<?php

namespace App\Controller;

use App\Entity\Commande;
use App\Repository\CommandeRepository;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Attribute\Route;
use Symfony\Component\Security\Http\Attribute\IsGranted;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Component\HttpFoundation\Request;


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
        EntityManagerInterface $entityManager
    ): Response {
        if ($request->isMethod('POST')) {
            $status = $request->request->get('status');

            if (in_array($status, ['en_attente', 'confirmee', 'en_preparation', 'prete', 'livree', 'terminee', 'annulee'], true)) {
                $commande->setStatus($status);
                $entityManager->flush();

                $this->addFlash('success', 'Le statut de la commande a bien été modifié.');
            }

            return $this->redirectToRoute('app_employee_dashboard');
        }

        return $this->render('employee/status.html.twig', [
            'commande' => $commande,
        ]);
    }
}
