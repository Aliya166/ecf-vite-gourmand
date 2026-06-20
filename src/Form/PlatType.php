<?php

namespace App\Form;

use App\Entity\Plat;
use App\Entity\Menu;
use App\Entity\Allergene;
use Symfony\Bridge\Doctrine\Form\Type\EntityType;
use Symfony\Component\Form\AbstractType;
use Symfony\Component\Form\FormBuilderInterface;
use Symfony\Component\OptionsResolver\OptionsResolver;

class PlatType extends AbstractType
{
    public function buildForm(FormBuilderInterface $builder, array $options): void
    {
        $builder
            ->add('name')
            ->add('description')
            ->add('typePlat')
            ->add('price')
            ->add('isActive')
            ->add('createAt', null, [
                'widget' => 'single_text'
            ])
            ->add('menu', EntityType::class, [
                'class' => Menu::class,
                'choice_label' => 'title',
                'placeholder' => 'Choisir un menu',
                'required' => false,
            ])
            ->add('allergenes', EntityType::class, [
                'class' => Allergene::class,
                'choice_label' => 'libelle',
                'multiple' => true,
                'expanded' => true,
                'required' => false,
            ])
            ->add('photo')
        ;
    }

    public function configureOptions(OptionsResolver $resolver): void
    {
        $resolver->setDefaults([
            'data_class' => Plat::class,
            'csrf_protection' => false, // Désactiver la protection CSRF pour les tests
        ]);
    }
}
