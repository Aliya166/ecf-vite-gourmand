<?php

namespace App\Service;

use App\Entity\Commande;
use Symfony\Bridge\Twig\Mime\TemplatedEmail;
use Symfony\Component\Mailer\MailerInterface;
use Symfony\Component\Mime\Address;

final class OrderStatusMailer
{
    public function __construct(
        private readonly MailerInterface $mailer
    ) {
    }

    public function sendForStatus(Commande $commande, string $status): void
    {
        $user = $commande->getUser();

        if (!$user) {
            return;
        }

        $email = match ($status) {
            'terminee' => (new TemplatedEmail())
                ->from(new Address(
                    'alisazamkovaya@gmail.com',
                    'Vite & Gourmand'
                ))
                ->to($user->getEmail())
                ->subject(
                    'Votre commande est terminée - Donnez-nous votre avis'
                )
                ->htmlTemplate('emails/order_completed.html.twig')
                ->context([
                    'user' => $user,
                    'commande' => $commande,
                ]),

            'en_attente_retour_materiel' => (new TemplatedEmail())
                ->from(new Address(
                    'alisazamkovaya@gmail.com',
                    'Vite & Gourmand'
                ))
                ->to($user->getEmail())
                ->subject('Retour du matériel de livraison')
                ->htmlTemplate('emails/material_return.html.twig')
                ->context([
                    'user' => $user,
                    'commande' => $commande,
                ]),

            default => null,
        };

        if ($email !== null) {
            $this->mailer->send($email);
        }
    }
}