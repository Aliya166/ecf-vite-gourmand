<?php

namespace App\Controller;

use App\Entity\Commande;
use App\Entity\CommandeStatusHistory;
use App\Entity\Menu;
use App\Entity\User;
use App\Form\CommandeType;
use App\Service\OrderStatusMailer;
use App\Service\CommandeCalculator;
use App\Form\CommandeClientType;
use App\Repository\CommandeRepository;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Attribute\Route;
use Symfony\Component\Security\Http\Attribute\IsGranted;
use Symfony\Component\Security\Http\Attribute\CurrentUser;
use Symfony\Bridge\Twig\Mime\TemplatedEmail;
use Symfony\Component\Mailer\MailerInterface;
use Symfony\Component\Mime\Address;
use App\Repository\MenuRepository;

#[Route('/commande')]
final class CommandeController extends AbstractController
{

    #[IsGranted('ROLE_USER')]
    #[Route('/menu/{id}', name: 'app_order_create', methods: ['GET', 'POST'])]
    public function createFromMenu(
        Menu $menu,
        Request $request,
        EntityManagerInterface $entityManager,
        MailerInterface $mailer,
        CommandeCalculator $calculator,
        #[CurrentUser] User $user
    ): Response {
        $commande = new Commande();

        $commande->setMenu($menu);
        $commande->setUser($user);
        $commande->setDateCommande(new \DateTimeImmutable());
        $commande->setStatus('en_attente');
        $commande->setNombrePersonnes($menu->getNombrePersonneMinimum());

        $form = $this->createForm(CommandeClientType::class, $commande, [
            'min_personnes' => $menu->getNombrePersonneMinimum(),
        ]);

        $form->handleRequest($request);

        if ($form->isSubmitted() && $form->isValid()) {
            $nombrePersonnes = $commande->getNombrePersonnes();
            $prixMenu = (float) $menu->getPrice();

            $sousTotal = $prixMenu * $nombrePersonnes;

            $ville = $commande->getVilleLivraison() ?? '';
            $distanceKm = (float) ($commande->getDistanceKm() ?? 0);

            $reduction = $calculator->calculerReduction(
                $sousTotal,
                $nombrePersonnes,
                $menu->getNombrePersonneMinimum()
            );

            $prixLivraison = $calculator->calculerPrixLivraison(
                $ville,
                $distanceKm
            );

            $prixTotal = $sousTotal - $reduction + $prixLivraison;

            $commande->setPrixLivraison(number_format($prixLivraison, 2, '.', ''));
            $commande->setReduction(number_format($reduction, 2, '.', ''));
            $commande->setPrixTotal(number_format($prixTotal, 2, '.', ''));

            if (($menu->getStockDisponible() ?? 0) <= 0) {
                $this->addFlash('danger', 'Ce menu vient de devenir indisponible.');
                return $this->redirectToRoute('app_public_menu_show', [
                    'id' => $menu->getId(),
                ]);
            }

            $menu->setStockDisponible($menu->getStockDisponible() - 1);

            $entityManager->persist($commande);

            $history = new CommandeStatusHistory();
            $history->setCommande($commande);
            $history->setStatus('en_attente');
            $history->setCreatedAt(new \DateTimeImmutable());

            $entityManager->persist($history);
            $entityManager->flush();

            $email = (new TemplatedEmail())
                ->from(new Address('alisazamkovaya@gmail.com', 'Vite & Gourmand'))
                ->to($user->getEmail())
                ->subject('Confirmation de votre commande - Vite & Gourmand')
                ->htmlTemplate('emails/order_confirmation.html.twig')
                ->context([
                    'user' => $user,
                    'commande' => $commande,
                    'menu' => $menu,
                ]);

            $mailer->send($email);

            $this->addFlash('success', 'Votre commande a bien été enregistrée. Un email de confirmation vous a été envoyé.');

            # $adminEmail = (new TemplatedEmail())
            #->from(new Address('alisazamkovaya@gmail.com', 'Vite & Gourmand'))
            #->to('alisazamkovaya@gmail.com')
            #->subject('Nouvelle commande reçue - Vite & Gourmand')
            #->htmlTemplate('emails/admin_new_order.html.twig')
            #->context([
            #'user' => $user,
            #'commande' => $commande,
            #'menu' => $menu,
            #]);

            # $mailer->send($adminEmail);

            return $this->redirectToRoute('app_account');
        }

        return $this->render('commande/client_new.html.twig', [
            'form' => $form,
            'menu' => $menu,
            'commande' => $commande,
        ]);
    }


    #[IsGranted('ROLE_ADMIN')]
    #[Route(name: 'app_commande_index', methods: ['GET'])]
    public function index(
        Request $request,
        CommandeRepository $commandeRepository,
        MenuRepository $menuRepository
    ): Response {
        $status = $request->query->get('status');
        $client = $request->query->get('client');
        $dateStart = $request->query->get('dateStart');
        $dateEnd = $request->query->get('dateEnd');
        $menu = $request->query->get('menu');

        $commandes = $commandeRepository->findForEmployeeFilters($status, $client, $dateStart, $dateEnd, $menu);

        return $this->render('commande/index.html.twig', [
            'commandes' => $commandes,
            'menus' => $menuRepository->findAll(),
            'selectedStatus' => $status,
            'clientSearch' => $client,
            'dateStart' => $dateStart,
            'dateEnd' => $dateEnd,
            'selectedMenu' => $menu,
        ]);
    }

    #[IsGranted('ROLE_ADMIN')]
    #[Route('/new', name: 'app_commande_new', methods: ['GET', 'POST'])]
    public function new(Request $request, EntityManagerInterface $entityManager): Response
    {
        $commande = new Commande();
        $form = $this->createForm(CommandeType::class, $commande);
        $form->handleRequest($request);

        if ($form->isSubmitted() && $form->isValid()) {
            $entityManager->persist($commande);
            $entityManager->flush();

            return $this->redirectToRoute('app_commande_index', [], Response::HTTP_SEE_OTHER);
        }

        return $this->render('commande/new.html.twig', [
            'commande' => $commande,
            'form' => $form,
        ]);
    }

    #[IsGranted('ROLE_ADMIN')]
    #[Route('/{id}', name: 'app_commande_show', methods: ['GET'])]
    public function show(Commande $commande): Response
    {
        return $this->render('commande/show.html.twig', [
            'commande' => $commande,
        ]);
    }

    #[IsGranted('ROLE_ADMIN')]
    #[Route('/{id}/edit', name: 'app_commande_edit', methods: ['GET', 'POST'])]
    public function edit(Request $request, Commande $commande, EntityManagerInterface $entityManager, OrderStatusMailer $orderStatusMailer): Response
    {
        $originalStatus = $commande->getStatus();
        $form = $this->createForm(CommandeType::class, $commande);
        $form->handleRequest($request);

        if ($form->isSubmitted() && $form->isValid()) {
            $newStatus = $commande->getStatus();

            if (
                $newStatus === 'annulee'
                && (!$commande->getModeContactClient() || !$commande->getMotifAnnulation())
            ) {
                $this->addFlash(
                    'danger',
                    'Pour annuler une commande, vous devez indiquer le mode de contact client et le motif d’annulation.'
                );

                return $this->redirectToRoute('app_commande_edit', [
                    'id' => $commande->getId(),
                ]);
            }

            if ($newStatus !== $originalStatus) {
                $history = new CommandeStatusHistory();
                $history->setCommande($commande);
                $history->setStatus($newStatus);
                $history->setCreatedAt(new \DateTimeImmutable());

                $entityManager->persist($history);
            }

            $entityManager->flush();

            if ($newStatus !== $originalStatus) {
                $orderStatusMailer->sendForStatus($commande, $newStatus);
            }

            $this->addFlash('success', 'La commande a bien été modifiée.');

            return $this->redirectToRoute(
                'app_commande_index',
                [],
                Response::HTTP_SEE_OTHER
            );
        }

        return $this->render('commande/edit.html.twig', [
            'commande' => $commande,
            'form' => $form,
        ]);
    }

    #[Route('/{id}', name: 'app_commande_delete', methods: ['POST'])]
    public function delete(Commande $commande, EntityManagerInterface $entityManager): Response
    {
        $entityManager->remove($commande);
        $entityManager->flush();

        $this->addFlash('success', 'La commande a bien été supprimée.');

        return $this->redirectToRoute('app_commande_index', [], Response::HTTP_SEE_OTHER);
    }
}
