<?php

namespace App\Form;

use App\Entity\Menu;
use App\Entity\Plat;
use App\Entity\Regime;
use App\Entity\Theme;
use Symfony\Bridge\Doctrine\Form\Type\EntityType;
use Symfony\Component\Form\AbstractType;
use Symfony\Component\Form\FormBuilderInterface;
use Symfony\Component\OptionsResolver\OptionsResolver;

class MenuType extends AbstractType
{
    public function buildForm(FormBuilderInterface $builder, array $options): void
    {
        $builder
            ->add('title')
            ->add('nombrePersonneMinimum')
            ->add('description')
            ->add('price')
            ->add('isActive')
            ->add('createAt', null, [
                'widget' => 'single_text'
            ])
            ->add('plats', EntityType::class, [
                'class' => Plat::class,
                'choice_label' => 'name',
                'multiple' => true,
                'expanded' => true,
            ])
            ->add('regime', EntityType::class, [
                'class' => Regime::class,
                'choice_label' => 'libelle',
                'placeholder' => 'Choisir un régime',
                'required' => false,
            ])
            ->add('theme', EntityType::class, [
                'class' => Theme::class,
                'choice_label' => 'libelle',
                'placeholder' => 'Choisir un thème',
                'required' => false,
            ])
        ;
    }

    public function configureOptions(OptionsResolver $resolver): void
    {
        $resolver->setDefaults([
            'data_class' => Menu::class,
            'csrf_protection' => false, // Désactiver la protection CSRF pour les tests
        ]);
    }
}
