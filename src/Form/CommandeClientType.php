<?php

namespace App\Form;

use App\Entity\Commande;
use Symfony\Component\Form\AbstractType;
use Symfony\Component\Form\Extension\Core\Type\DateType;
use Symfony\Component\Form\Extension\Core\Type\IntegerType;
use Symfony\Component\Form\Extension\Core\Type\NumberType;
use Symfony\Component\Form\Extension\Core\Type\TextareaType;
use Symfony\Component\Form\Extension\Core\Type\TextType;
use Symfony\Component\Form\Extension\Core\Type\HiddenType;
use Symfony\Component\Form\Extension\Core\Type\TimeType;
use Symfony\Component\Form\FormBuilderInterface;
use Symfony\Component\OptionsResolver\OptionsResolver;

class CommandeClientType extends AbstractType
{
    public function buildForm(FormBuilderInterface $builder, array $options): void
    {
        $minPersonnes = $options['min_personnes'];

        $builder
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
            ->add('distanceKm', HiddenType::class, [
                'required' => false,
            ])
            ->add('nombrePersonnes', IntegerType::class, [
                'label' => 'Nombre de personnes',
                'attr' => [
                    'min' => $minPersonnes,
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
            'min_personnes' => 1,
        ]);
    }
}