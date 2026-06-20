<?php

namespace App\Controller;

use App\Entity\Menu;
use App\Repository\HoraireRepository;
use App\Repository\MenuRepository;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Attribute\Route;

final class PublicController extends AbstractController
{
    #[Route('/menus', name: 'app_public_menus')]
    public function index(MenuRepository $menuRepository, HoraireRepository $horaireRepository): Response
    {
        $menus = $menuRepository->findBy(
            ['isActive' => true]
        );

        return $this->render('public/index.html.twig', [
            'menus' => $menus,
            'horaires' => $horaireRepository->findAll(),
        ]);
    }

    #[Route('/menus/{id}', name: 'app_public_menu_show')]
    public function show(Menu $menu, HoraireRepository $horaireRepository): Response
    {
        return $this->render('public/show.html.twig', [
            'menu' => $menu,
            'horaires' => $horaireRepository->findAll(),
        ]);
    }
}
