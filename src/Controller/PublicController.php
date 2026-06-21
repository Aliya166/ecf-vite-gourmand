<?php

namespace App\Controller;

use App\Entity\Menu;
use App\Repository\HoraireRepository;
use App\Repository\MenuRepository;
use App\Repository\ThemeRepository;
use App\Repository\RegimeRepository;
use App\Repository\GalleryImageRepository;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\Routing\Attribute\Route;

final class PublicController extends AbstractController
{
    #[Route('/menus', name: 'app_public_menus')]
    public function index(
        Request $request,
        MenuRepository $menuRepository,
        ThemeRepository $themeRepository,
        RegimeRepository $regimeRepository,
        HoraireRepository $horaireRepository,
    ): Response {
        $themeId = $request->query->get('theme');
        $regimeId = $request->query->get('regime');

        $criteria = [
            'isActive' => true,
        ];

        if ($themeId) {
            $criteria['theme'] = $themeId;
        }

        if ($regimeId) {
            $criteria['regime'] = $regimeId;
        }

        $menus = $menuRepository->findBy($criteria);

        return $this->render('public/index.html.twig', [
            'menus' => $menus,
            'themes' => $themeRepository->findAll(),
            'regimes' => $regimeRepository->findAll(),
            'selectedTheme' => $themeId,
            'selectedRegime' => $regimeId,
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

    #[Route('/galerie', name: 'app_public_galerie')]
    public function galerie(
        GalleryImageRepository $galleryImageRepository,
        HoraireRepository $horaireRepository
    ): Response {
        $images = $galleryImageRepository->findBy([
            'isActive' => true,
        ]);

        return $this->render('public/galerie.html.twig', [
            'images' => $images,
            'horaires' => $horaireRepository->findAll(),
        ]);
    }
}
