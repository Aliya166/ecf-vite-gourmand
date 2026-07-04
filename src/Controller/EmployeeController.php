<?php

namespace App\Controller;

use App\Entity\User;
use App\Form\EmployeeType;
use App\Repository\UserRepository;
use App\Repository\CommandeRepository;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Bridge\Twig\Mime\TemplatedEmail;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Mailer\MailerInterface;
use Symfony\Component\Mime\Address;
use Symfony\Component\PasswordHasher\Hasher\UserPasswordHasherInterface;
use Symfony\Component\Routing\Attribute\Route;
use Symfony\Component\Security\Http\Attribute\IsGranted;

#[IsGranted('ROLE_ADMIN')]
#[Route('/admin/employees')]
final class EmployeeController extends AbstractController
{
    #[Route('', name: 'app_employee_index', methods: ['GET'])]
    public function index(UserRepository $userRepository): Response
    {
        return $this->render('employee/index.html.twig', [
            'employees' => $userRepository->findByRole('ROLE_EMPLOYE'),
        ]);
    }

    #[Route('/new', name: 'app_employee_new', methods: ['GET', 'POST'])]
    public function new(
        Request $request,
        EntityManagerInterface $entityManager,
        UserPasswordHasherInterface $passwordHasher,
        MailerInterface $mailer
    ): Response {
        $employee = new User();

        $form = $this->createForm(EmployeeType::class, $employee);
        $form->handleRequest($request);

        if ($form->isSubmitted() && $form->isValid()) {
            $temporaryPassword = bin2hex(random_bytes(4));

            $employee->setRoles(['ROLE_EMPLOYE']);
            $employee->setCreatedAt(new \DateTimeImmutable());
            $employee->setPassword(
                $passwordHasher->hashPassword($employee, $temporaryPassword)
            );

            $entityManager->persist($employee);
            $entityManager->flush();

            $email = (new TemplatedEmail())
                ->from(new Address('noreply@vitegourmand.fr', 'Vite & Gourmand'))
                ->to($employee->getEmail())
                ->subject('Votre compte employé a été créé')
                ->htmlTemplate('emails/employee_created.html.twig')
                ->context([
                    'employee' => $employee,
                ]);

            $mailer->send($email);

            $this->addFlash('success', 'Le compte employé a bien été créé. Un email lui a été envoyé.');

            return $this->redirectToRoute('app_employee_index');
        }

        return $this->render('employee/new.html.twig', [
            'form' => $form,
        ]);
    }

    #[Route('/{id}/delete', name: 'app_employee_delete', methods: ['POST'])]
    public function delete(
        User $employee,
        Request $request,
        EntityManagerInterface $entityManager
    ): Response {
        if (!$this->isCsrfTokenValid('delete_employee' . $employee->getId(), $request->request->get('_token'))) {
            throw $this->createAccessDeniedException();
        }

        if (!in_array('ROLE_EMPLOYE', $employee->getRoles(), true)) {
            $this->addFlash('danger', 'Cet utilisateur n’est pas un employé.');

            return $this->redirectToRoute('app_employee_index');
        }

        $entityManager->remove($employee);
        $entityManager->flush();

        $this->addFlash('success', 'Le compte employé a bien été supprimé.');

        return $this->redirectToRoute('app_employee_index');
    }
}
