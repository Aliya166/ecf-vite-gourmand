<?php

namespace App\Form;

use App\Entity\Commande;
use App\Entity\User;
use App\Entity\Menu;
use Symfony\Bridge\Doctrine\Form\Type\EntityType;
use Symfony\Component\Form\AbstractType;
use Symfony\Component\Form\FormBuilderInterface;
use Symfony\Component\OptionsResolver\OptionsResolver;

class CommandeType extends AbstractType
{
    public function buildForm(FormBuilderInterface $builder, array $options): void
    {
        $builder
            ->add('dateCommande', null, [
                'widget' => 'single_text'
            ])
            ->add('nombrePersonnes')
            ->add('status')
            ->add('commentaire')
            ->add('user', EntityType::class, [
                'class' => User::class,
                'choice_label' => 'email'
            ])
            ->add('menu', EntityType::class, [
                'class' => Menu::class,
                'choice_label' => 'title'
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
