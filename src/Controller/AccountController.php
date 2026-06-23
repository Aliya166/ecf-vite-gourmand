<?php

namespace App\Controller;

use App\Entity\User;
use App\Entity\Commande;
use App\Form\ChangePasswordType;
use App\Form\ProfileType;
use App\Repository\CommandeRepository;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\Security\Http\Attribute\IsGranted;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\PasswordHasher\Hasher\UserPasswordHasherInterface;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Attribute\Route;

final class AccountController extends AbstractController

{
    #[IsGranted('ROLE_USER')]
    #[Route('/mon-compte', name: 'app_account')]
    public function index(CommandeRepository $commandeRepository): Response
    {
        /** @var User $user */
        $user = $this->getUser();

        $commandes = $commandeRepository->findBy(['user' => $user], ['dateCommande' => 'DESC']);

        return $this->render('account/index.html.twig', [
            'user' => $user,
            'commandes' => $commandes,
        ]);
    }

    #[IsGranted('ROLE_USER')]
    #[Route('/mon-compte/edit', name: 'app_account_edit')]
    public function edit(Request $request, EntityManagerInterface $entityManager): Response
    {
        /** @var User $user */
        $user = $this->getUser();

        $form = $this->createForm(ProfileType::class, $user);
        $entityManager->persist($user);
        $form->handleRequest($request);

        if ($form->isSubmitted() && $form->isValid()) {
            $entityManager->flush();

            $this->addFlash('success', 'Vos informations ont bien été mises à jour.');

            return $this->redirectToRoute('app_account');
        }

        return $this->render('account/edit.html.twig', [
            'profileForm' => $form->createView(),
        ]);
    }

    #[IsGranted('ROLE_USER')]
    #[Route('/mon-compte/password', name: 'app_account_password')]
    public function changePassword(
        Request $request,
        EntityManagerInterface $entityManager,
        UserPasswordHasherInterface $passwordHasher
    ): Response {
        /** @var User $user */
        $user = $this->getUser();

        $form = $this->createForm(ChangePasswordType::class);
        $form->handleRequest($request);

        if ($form->isSubmitted() && $form->isValid()) {
            $currentPassword = $form->get('currentPassword')->getData();
            $newPassword = $form->get('newPassword')->getData();

            if (!$passwordHasher->isPasswordValid($user, $currentPassword)) {
                $this->addFlash('danger', 'Le mot de passe actuel est incorrect.');

                return $this->redirectToRoute('app_account_password');
            }

            $user->setPassword(
                $passwordHasher->hashPassword($user, $newPassword)
            );

            $entityManager->flush();

            $this->addFlash('success', 'Votre mot de passe a bien été modifié.');

            return $this->redirectToRoute('app_account');
        }

        return $this->render('account/password.html.twig', [
            'passwordForm' => $form->createView(),
        ]);
    }

    #[IsGranted('ROLE_USER')]
    #[Route('/commande/{id}/annuler', name: 'app_order_cancel')]
    public function cancel(
        Commande $commande,
        EntityManagerInterface $entityManager
    ): Response {

        if ($commande->getUser() !== $this->getUser()) {
            throw $this->createAccessDeniedException();
        }

        if (!in_array($commande->getStatus(), ['en_attente', 'confirmee'])) {

            $this->addFlash(
                'error',
                'Cette commande ne peut plus être annulée.'
            );

            return $this->redirectToRoute('app_account');
        }

        $commande->setStatus('annulee');

        $entityManager->flush();

        $this->addFlash(
            'success',
            'Commande annulée avec succès.'
        );

        return $this->redirectToRoute('app_account');
    }
}
