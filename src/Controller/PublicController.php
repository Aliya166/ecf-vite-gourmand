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

        $maxPriceValue = $request->query->get('maxPrice');
        $personnesValue = $request->query->get('personnes');

        $maxPrice = $maxPriceValue !== null && $maxPriceValue !== '' ? (float) $maxPriceValue : null;
        $personnes = $personnesValue !== null && $personnesValue !== '' ? (int) $personnesValue : null;

        $page = max(1, $request->query->getInt('page', 1));
        $limit = 6;

        $result = $menuRepository->findFilteredMenusPaginated(
            $themeId ? (int) $themeId : null,
            $regimeId ? (int) $regimeId : null,
            $maxPrice,
            $personnes,
            $page,
            $limit
        );

        $menus = $result['menus'];
        $totalMenus = $result['total'];
        $totalPages = (int) ceil($totalMenus / $limit);

        return $this->render('public/index.html.twig', [
            'menus' => $menus,
            'themes' => $themeRepository->findAll(),
            'regimes' => $regimeRepository->findAll(),
            'selectedTheme' => $themeId,
            'selectedRegime' => $regimeId,
            'selectedMaxPrice' => $maxPrice,
            'selectedPersonnes' => $personnes,
            'horaires' => $horaireRepository->findAll(),
            'currentPage' => $page,
            'totalPages' => $totalPages,
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

    #[Route('/a-propos', name: 'app_about')]
    public function about(HoraireRepository $horaireRepository): Response
    {
        return $this->render('public/about.html.twig', [
            'horaires' => $horaireRepository->findAll(),
        ]);
    }

    #[Route('/livraison', name: 'app_livraison')]
    public function livraison(HoraireRepository $horaireRepository): Response
    {
        return $this->render('public/livraison.html.twig', [
            'horaires' => $horaireRepository->findAll(),
        ]);
    }

    #[Route('/contact', name: 'app_contact')]
    public function contact(HoraireRepository $horaireRepository): Response
    {
        return $this->render('public/contact.html.twig', [
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
