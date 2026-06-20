<?php

namespace App\Controller;

use App\Repository\AvisRepository;
use App\Repository\HoraireRepository;
use App\Repository\MenuRepository;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Attribute\Route;

final class HomeController extends AbstractController
{
    #[Route('/', name: 'app_home')]
    public function index(
        MenuRepository $menuRepository,
        AvisRepository $avisRepository,
        HoraireRepository $horaireRepository
    ): Response {
        return $this->render('home/index.html.twig', [
            'menus' => $menuRepository->findBy(['isActive' => true], null, 4),
            'avis' => $avisRepository->findAll(),
            'horaires' => $horaireRepository->findAll(),
        ]);
    }
}