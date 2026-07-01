<?php

namespace App\Form;

use App\Entity\Commande;
use App\Entity\Menu;
use App\Entity\User;
use Symfony\Bridge\Doctrine\Form\Type\EntityType;
use Symfony\Component\Form\AbstractType;
use Symfony\Component\Form\Extension\Core\Type\ChoiceType;
use Symfony\Component\Form\Extension\Core\Type\DateTimeType;
use Symfony\Component\Form\Extension\Core\Type\IntegerType;
use Symfony\Component\Form\Extension\Core\Type\TextareaType;
use Symfony\Component\Form\FormBuilderInterface;
use Symfony\Component\OptionsResolver\OptionsResolver;
use Symfony\Component\Form\Extension\Core\Type\DateType;
use Symfony\Component\Form\Extension\Core\Type\NumberType;
use Symfony\Component\Form\Extension\Core\Type\TextType;
use Symfony\Component\Form\Extension\Core\Type\TimeType;

class CommandeType extends AbstractType
{
    public function buildForm(FormBuilderInterface $builder, array $options): void
    {
        $builder
            ->add('user', EntityType::class, [
                'class' => User::class,
                'choice_label' => 'email',
                'label' => 'Client',
            ])
            ->add('menu', EntityType::class, [
                'class' => Menu::class,
                'choice_label' => 'title',
                'label' => 'Menu',
            ])
            ->add('dateLivraison', DateType::class, [
                'label' => 'Date de livraison',
                'widget' => 'single_text',
            ])
            ->add('heureLivraison', TimeType::class, [
                'label' => 'Heure souhaitée',
                'widget' => 'single_text',
            ])
            ->add('adresseLivraison', TextType::class, [
                'label' => 'Adresse de livraison',
            ])
            ->add('villeLivraison', TextType::class, [
                'label' => 'Ville de livraison',
            ])
            ->add('distanceKm', NumberType::class, [
                'label' => 'Distance estimée (km)',
                'required' => false,
            ])
            ->add('prixLivraison', NumberType::class, [
                'label' => 'Prix livraison',
                'required' => false,
            ])
            ->add('reduction', NumberType::class, [
                'label' => 'Réduction',
                'required' => false,
            ])
            ->add('prixTotal', NumberType::class, [
                'label' => 'Prix total',
            ])
            ->add('nombrePersonnes', IntegerType::class, [
                'label' => 'Nombre de personnes',
            ])
            ->add('status', ChoiceType::class, [
                'label' => 'Statut',
                'choices' => [
                    'En attente' => 'en_attente',
                    'Confirmée' => 'confirmee',
                    'En préparation' => 'en_preparation',
                    'Prête' => 'prete',
                    'Livrée' => 'livree',
                    'Annulée' => 'annulee',
                ],
            ])
            ->add('commentaire', TextareaType::class, [
                'label' => 'Commentaire',
                'required' => false,
            ])
        ;
    }

    public function configureOptions(OptionsResolver $resolver): void
    {
        $resolver->setDefaults([
            'data_class' => Commande::class,
        ]);
    }
}
