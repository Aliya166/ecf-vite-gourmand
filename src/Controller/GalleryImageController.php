<?php

namespace App\Controller;

use App\Entity\GalleryImage;
use App\Form\GalleryImageType;
use App\Repository\GalleryImageRepository;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Attribute\Route;

#[Route('/gallery/image')]
final class GalleryImageController extends AbstractController
{
    #[Route(name: 'app_gallery_image_index', methods: ['GET'])]
    public function index(GalleryImageRepository $galleryImageRepository): Response
    {
        return $this->render('gallery_image/index.html.twig', [
            'gallery_images' => $galleryImageRepository->findAll(),
        ]);
    }

    #[Route('/new', name: 'app_gallery_image_new', methods: ['GET', 'POST'])]
    public function new(Request $request, EntityManagerInterface $entityManager): Response
    {
        $galleryImage = new GalleryImage();
        $form = $this->createForm(GalleryImageType::class, $galleryImage);
        $form->handleRequest($request);

        if ($form->isSubmitted() && $form->isValid()) {
            $entityManager->persist($galleryImage);
            $entityManager->flush();

            return $this->redirectToRoute('app_gallery_image_index', [], Response::HTTP_SEE_OTHER);
        }

        return $this->render('gallery_image/new.html.twig', [
            'gallery_image' => $galleryImage,
            'form' => $form,
        ]);
    }

    #[Route('/{id}', name: 'app_gallery_image_show', methods: ['GET'])]
    public function show(GalleryImage $galleryImage): Response
    {
        return $this->render('gallery_image/show.html.twig', [
            'gallery_image' => $galleryImage,
        ]);
    }

    #[Route('/{id}/edit', name: 'app_gallery_image_edit', methods: ['GET', 'POST'])]
    public function edit(Request $request, GalleryImage $galleryImage, EntityManagerInterface $entityManager): Response
    {
        $form = $this->createForm(GalleryImageType::class, $galleryImage);
        $form->handleRequest($request);

        if ($form->isSubmitted() && $form->isValid()) {
            $entityManager->flush();

            return $this->redirectToRoute('app_gallery_image_index', [], Response::HTTP_SEE_OTHER);
        }

        return $this->render('gallery_image/edit.html.twig', [
            'gallery_image' => $galleryImage,
            'form' => $form,
        ]);
    }

    #[Route('/{id}', name: 'app_gallery_image_delete', methods: ['POST'])]
    public function delete(Request $request, GalleryImage $galleryImage, EntityManagerInterface $entityManager): Response
    {
        if ($this->isCsrfTokenValid('delete'.$galleryImage->getId(), $request->getPayload()->getString('_token'))) {
            $entityManager->remove($galleryImage);
            $entityManager->flush();
        }

        return $this->redirectToRoute('app_gallery_image_index', [], Response::HTTP_SEE_OTHER);
    }
}
