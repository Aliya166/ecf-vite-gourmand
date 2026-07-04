<?php

namespace App\Controller;

use App\Entity\Commande;
use App\Entity\CommandeStatusHistory;
use App\Repository\CommandeRepository;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Attribute\Route;
use Symfony\Component\Security\Http\Attribute\IsGranted;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Bridge\Twig\Mime\TemplatedEmail;
use Symfony\Component\Mailer\MailerInterface;
use Symfony\Component\Mime\Address;


final class EmployeeDashboardController extends AbstractController
{
    #[IsGranted('ROLE_EMPLOYE')]
    #[Route('/espace-employe', name: 'app_employee_dashboard', methods: ['GET'])]
    public function index(CommandeRepository $commandeRepository): Response
    {
        return $this->render('employee/dashboard.html.twig', [
            'commandes' => $commandeRepository->findBy([], ['dateCommande' => 'DESC']),
        ]);
    }

    #[IsGranted('ROLE_EMPLOYE')]
    #[Route('/espace-employe/commande/{id}/statut', name: 'app_employee_order_status', methods: ['GET', 'POST'])]
    public function editStatus(
        Commande $commande,
        Request $request,
        EntityManagerInterface $entityManager,
        MailerInterface $mailer
    ): Response {
        if ($request->isMethod('POST')) {
            $status = $request->request->get('status');

            if (in_array($status, ['en_attente', 'confirmee', 'en_preparation', 'prete', 'livree', 'terminee', 'annulee', 'en_attente_retour_materiel'], true)) {
                $commande->setStatus($status);

                $history = new CommandeStatusHistory();
                $history->setCommande($commande);
                $history->setStatus($status);
                $history->setCreatedAt(new \DateTimeImmutable());

                $entityManager->persist($history);
                $entityManager->flush();

                $this->addFlash('success', 'Le statut de la commande a bien été modifié.');

                if ($status === 'terminee') {
                    $email = (new TemplatedEmail())
                        ->from(new Address('noreply@vitegourmand.fr', 'Vite & Gourmand'))
                        ->to($commande->getUser()->getEmail())
                        ->subject('Votre commande a été livrée')
                        ->htmlTemplate('emails/order_completed.html.twig')
                        ->context([
                            'user' => $commande->getUser(),
                            'commande' => $commande,
                        ]);

                    $mailer->send($email);
                }

                if ($status === 'en_attente_retour_materiel') {
                    $email = (new TemplatedEmail())
                        ->from(new Address('noreply@vitegourmand.fr', 'Vite & Gourmand'))
                        ->to($commande->getUser()->getEmail())
                        ->subject('Retour du matériel de livraison')
                        ->htmlTemplate('emails/material_return.html.twig')
                        ->context([
                            'user' => $commande->getUser(),
                            'commande' => $commande,
                        ]);

                    $mailer->send($email);
                }
            }

            return $this->redirectToRoute('app_employee_dashboard');
        }

        return $this->render('employee/status.html.twig', [
            'commande' => $commande,
        ]);
    }
}
