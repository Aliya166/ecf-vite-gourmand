<?php

namespace App\Controller;

use App\Service\MongoStatisticsService;
use App\Service\OrderStatisticsService;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Attribute\Route;
use Symfony\Component\Security\Http\Attribute\IsGranted;

#[IsGranted('ROLE_ADMIN')]
final class AdminStatisticsController extends AbstractController
{
    #[Route('/admin/statistiques', name: 'app_admin_statistics', methods: ['GET'])]
    public function index(
        Request $request,
        OrderStatisticsService $statisticsService,
        MongoStatisticsService $mongoStatisticsService
    ): Response {
        $dateStart = $request->query->get('dateStart');
        $dateEnd = $request->query->get('dateEnd');
        $selectedMenu = $request->query->get('menu');

        /*
         * La commande refresh=1 :
         * 1. recalcule les statistiques depuis MySQL ;
         * 2. les enregistre dans MongoDB.
         */
        if ($request->query->get('refresh') === '1') {
            $statisticsService->generate();

            $filteredStats = $statisticsService->read(
                $dateStart,
                $dateEnd,
                $selectedMenu
            );

            $filteredMenusStats = $filteredStats['menus'] ?? [];

            $mongoStatisticsService->clearStatistics();

            foreach ($filteredMenusStats as $menuStat) {
                $mongoStatisticsService->saveMenuStatistic(
                    $menuStat['menuTitle'] ?? 'Menu inconnu',
                    (int) ($menuStat['ordersCount'] ?? 0),
                    (float) ($menuStat['revenue'] ?? 0)
                );
            }

            $mongoStatisticsService->flush();

            $this->addFlash(
                'success',
                'Les statistiques NoSQL ont été mises à jour dans MongoDB.'
            );

            return $this->redirectToRoute('app_admin_statistics', [
                'dateStart' => $dateStart,
                'dateEnd' => $dateEnd,
                'menu' => $selectedMenu,
            ]);
        }

        /*
         * Données SQL/JSON conservées pour :
         * - les filtres ;
         * - le tableau détaillé ;
         * - la liste des menus.
         */
        $allStats = $statisticsService->read();
        $menuOptions = $allStats['menus'] ?? [];

        $filteredStats = $statisticsService->read(
            $dateStart,
            $dateEnd,
            $selectedMenu
        );

        $menusStats = $filteredStats['menus'] ?? [];

        /*
         * Lecture directe des statistiques depuis MongoDB.
         */
        $mongoStats = [];

        try {
            $mongoStats = $mongoStatisticsService->readStatistics();
        } catch (\Throwable $exception) {
            $this->addFlash(
                'danger',
                'Impossible de lire les statistiques MongoDB pour le moment.'
            );
        }

        return $this->render('admin_statistics/index.html.twig', [
            'stats' => $filteredStats,
            'menusStats' => $menusStats,
            'menuOptions' => $menuOptions,
            'mongoStats' => $mongoStats,
            'selectedMenu' => $selectedMenu,
            'dateStart' => $dateStart,
            'dateEnd' => $dateEnd,
        ]);
    }
}