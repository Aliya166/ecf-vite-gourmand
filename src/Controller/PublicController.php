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
use Symfony\Bridge\Twig\Mime\TemplatedEmail;
use Symfony\Component\Mailer\MailerInterface;
use Symfony\Component\Mime\Address;

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

        if ($request->isXmlHttpRequest()) {
            return $this->render('public/_menus_list.html.twig', [
                'menus' => $menus,
            ]);
        }

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

    #[Route('/informations', name: 'app_informations')]
    public function informations(): Response
    {
        return $this->render('public/informations.html.twig');
    }

    #[Route('/contact', name: 'app_contact', methods: ['GET', 'POST'])]
    public function contact(
        Request $request,
        HoraireRepository $horaireRepository,
        MailerInterface $mailer
    ): Response {
        if ($request->isMethod('POST')) {
            $name = $request->request->get('name');
            $email = $request->request->get('email');
            $phone = $request->request->get('phone');
            $subject = $request->request->get('subject');
            $message = $request->request->get('message');

            $contactEmail = (new TemplatedEmail())
                ->from(new Address('alisazamkovaya@gmail.com', 'Vite & Gourmand'))
                ->to('alisazamkovaya@gmail.com')
                ->replyTo($email)
                ->subject('Nouveau message de contact - Vite & Gourmand')
                ->htmlTemplate('emails/contact.html.twig')
                ->context([
                    'name' => $name,
                    'senderEmail' => $email,
                    'phone' => $phone,
                    'subject' => $subject,
                    'message' => $message,
                ]);

            $mailer->send($contactEmail);

            $this->addFlash('success', 'Votre message a bien été envoyé. Notre équipe vous répondra rapidement.');

            return $this->redirectToRoute('app_contact');
        }

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
