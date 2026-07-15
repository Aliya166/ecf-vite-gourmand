<?php

namespace App\Controller;

use App\Entity\Commande;
use App\Entity\Menu;
use App\Entity\User;
use App\Form\ClientOrderType;
use App\Service\CommandeCalculator;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\Routing\Attribute\Route;
use Symfony\Component\Security\Http\Attribute\IsGranted;

final class OrderController extends AbstractController
{
    #[IsGranted('ROLE_USER')]
    #[Route('/commande-client/{id}/modifier', name: 'app_order_edit')]
    public function edit(
        Commande $commande,
        Request $request,
        EntityManagerInterface $entityManager,
        CommandeCalculator $calculator
    ): Response {
        if ($commande->getUser() !== $this->getUser()) {
            throw $this->createAccessDeniedException();
        }

        if (!in_array($commande->getStatus(), ['en_attente', 'confirmee'])) {
            $this->addFlash('danger', 'Cette commande ne peut plus être modifiée.');

            return $this->redirectToRoute('app_account');
        }

        $originalMenu = $commande->getMenu();
        $form = $this->createForm(ClientOrderType::class, $commande);
        $form->handleRequest($request);

        if ($form->isSubmitted() && $form->isValid()) {
            $commande->setMenu($originalMenu);

            $nombrePersonnes = $commande->getNombrePersonnes();
            $prixMenu = (float) $originalMenu->getPrice();

            // Prix du menu selon le nombre de personnes
            $sousTotal = $prixMenu * $nombrePersonnes;

            $ville = $commande->getVilleLivraison() ?? '';
            $distanceKm = (float) ($commande->getDistanceKm() ?? 0);

            $reduction = $calculator->calculerReduction(
                $sousTotal,
                $nombrePersonnes,
                $originalMenu->getNombrePersonneMinimum()
            );

            $prixLivraison = $calculator->calculerPrixLivraison(
                $ville,
                $distanceKm
            );

            $prixTotal = $sousTotal - $reduction + $prixLivraison;

            $commande->setPrixLivraison(
                number_format($prixLivraison, 2, '.', '')
            );

            $commande->setReduction(
                number_format($reduction, 2, '.', '')
            );

            $commande->setPrixTotal(
                number_format($prixTotal, 2, '.', '')
            );

            $entityManager->flush();

            $this->addFlash(
                'success',
                'Votre commande a bien été modifiée.'
            );

            return $this->redirectToRoute('app_account');
        }

        return $this->render('order/edit.html.twig', [
            'orderForm' => $form->createView(),
            'commande' => $commande,
        ]);
    }
}
