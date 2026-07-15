<?php

namespace App\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Attribute\Route;

final class DashboardRedirectController extends AbstractController
{
    #[Route('/dashboard', name: 'app_dashboard_redirect', methods: ['GET'])]
    public function redirectDashboard(): Response
    {
        if ($this->isGranted('ROLE_ADMIN')) {
            return $this->redirectToRoute('app_admin');
        }

        if ($this->isGranted('ROLE_EMPLOYE')) {
            return $this->redirectToRoute('app_employee_home');
        }

        if ($this->isGranted('ROLE_USER')) {
            return $this->redirectToRoute('app_account');
        }

        return $this->redirectToRoute('app_login');
    }
}
