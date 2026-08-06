<?php

namespace App\Controller;

use App\Entity\Menu;
use App\Form\MenuType;
use App\Repository\MenuRepository;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\HttpFoundation\File\UploadedFile;
use Symfony\Component\String\Slugger\SluggerInterface;
use Symfony\Component\Routing\Attribute\Route;

#[Route('/menu')]
final class MenuController extends AbstractController
{
    #[Route(name: 'app_menu_index', methods: ['GET'])]
    public function index(MenuRepository $menuRepository): Response
    {
        return $this->render('menu/index.html.twig', [
            'menus' => $menuRepository->findAll(),
        ]);
    }

    #[Route('/new', name: 'app_menu_new', methods: ['GET', 'POST'])]
    public function new(Request $request, EntityManagerInterface $entityManager, SluggerInterface $slugger): Response
    {
        $menu = new Menu();
        $form = $this->createForm(MenuType::class, $menu);
        $form->handleRequest($request);

        if ($form->isSubmitted() && $form->isValid()) {
            $entityManager->persist($menu);
            $this->handleMenuImage($form, $menu, 'imageMainFile', 'setImageMain', $slugger);
            $this->handleMenuImage($form, $menu, 'imageSecondFile', 'setImageSecond', $slugger);
            $this->handleMenuImage($form, $menu, 'imageThirdFile', 'setImageThird', $slugger);
            $this->handleMenuImage($form, $menu, 'imageFourthFile', 'setImageFourth', $slugger);
            $entityManager->flush();

            return $this->redirectToRoute('app_menu_index', [], Response::HTTP_SEE_OTHER);
        }

        return $this->render('menu/new.html.twig', [
            'menu' => $menu,
            'form' => $form->createView(),
        ]);
    }

    #[Route('/{id}', name: 'app_menu_show', methods: ['GET'])]
    public function show(Menu $menu): Response
    {
        return $this->render('menu/show.html.twig', [
            'menu' => $menu,
        ]);
    }

    #[Route('/{id}/edit', name: 'app_menu_edit', methods: ['GET', 'POST'])]
    public function edit(Request $request, Menu $menu, EntityManagerInterface $entityManager, SluggerInterface $slugger): Response
    {
        $form = $this->createForm(MenuType::class, $menu);
        $form->handleRequest($request);

        if ($form->isSubmitted() && $form->isValid()) {
            $this->handleMenuImage($form, $menu, 'imageMainFile', 'setImageMain', $slugger);
            $this->handleMenuImage($form, $menu, 'imageSecondFile', 'setImageSecond', $slugger);
            $this->handleMenuImage($form, $menu, 'imageThirdFile', 'setImageThird', $slugger);
            $this->handleMenuImage($form, $menu, 'imageFourthFile', 'setImageFourth', $slugger);
            $entityManager->flush();

            return $this->redirectToRoute('app_menu_index', [], Response::HTTP_SEE_OTHER);
        }

        return $this->render('menu/edit.html.twig', [
            'menu' => $menu,
            'form' => $form->createView(),
        ]);
    }

    #[Route('/{id}', name: 'app_menu_delete', methods: ['POST'])]
    public function delete(Request $request, Menu $menu, EntityManagerInterface $entityManager): Response
    {
        $menu->setIsActive(false);

        $entityManager->flush();

        $this->addFlash('success', 'Le menu a bien été désactivé.');

        return $this->redirectToRoute('app_menu_index', [], Response::HTTP_SEE_OTHER);
    }

    private function handleMenuImage($form, Menu $menu, string $fieldName, string $setter, SluggerInterface $slugger): void
    {
        /** @var UploadedFile|null $imageFile */
        $imageFile = $form->get($fieldName)->getData();

        if (!$imageFile) {
            return;
        }

        $originalFilename = pathinfo($imageFile->getClientOriginalName(), PATHINFO_FILENAME);

        $safeFilename = $slugger->slug($originalFilename);

        $newFilename = $safeFilename . '-' . uniqid() . '.' . $imageFile->guessExtension();

        $imageFile->move(
            $this->getParameter('menus_images_directory'),
            $newFilename
        );

        $menu->$setter($newFilename);
    }
}
