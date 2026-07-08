<?php

namespace App\Controller;

use App\Service\OrderStatisticsService;
use App\Service\MongoStatisticsService;
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

        if ($request->query->get('refresh') === '1') {
            $statisticsService->generate();

            $allStats = $statisticsService->read();
            $menuOptions = $allStats['menus'] ?? [];

            $stats = $statisticsService->read($dateStart, $dateEnd, $selectedMenu);
            $menusStats = $stats['menus'] ?? [];

            $mongoStatisticsService->clearStatistics();

            foreach ($menusStats as $menuStat) {
                $mongoStatisticsService->saveMenuStatistic(
                    $menuStat['menuTitle'] ?? 'Menu inconnu',
                    (int) ($menuStat['ordersCount'] ?? 0),
                    (float) ($menuStat['revenue'] ?? 0)
                );
            }

            $mongoStatisticsService->flush();

            $this->addFlash('success', 'Les statistiques NoSQL ont été mises à jour dans MongoDB.');
        }

        $stats = $statisticsService->read($dateStart, $dateEnd, $selectedMenu);
        $allStats = $statisticsService->read();
        $menuOptions = $allStats['menus'] ?? [];

        $allStats = $statisticsService->read();
        $menuOptions = $allStats['menus'] ?? [];

        $stats = $statisticsService->read($dateStart, $dateEnd, $selectedMenu);
        $menusStats = $stats['menus'] ?? [];

        return $this->render('admin_statistics/index.html.twig', [
            'stats' => $stats,
            'menusStats' => $menusStats,
            'menuOptions' => $menuOptions,
            'selectedMenu' => $selectedMenu,
            'dateStart' => $dateStart,
            'dateEnd' => $dateEnd,
        ]);
    }
}
