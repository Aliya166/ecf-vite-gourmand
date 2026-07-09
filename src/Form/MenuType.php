<?php

namespace App\Form;

use App\Entity\Menu;
use App\Entity\Regime;
use App\Entity\Theme;
use App\Entity\Plat;
use Symfony\Bridge\Doctrine\Form\Type\EntityType;
use Symfony\Component\Form\AbstractType;
use Symfony\Component\Form\FormBuilderInterface;
use Symfony\Component\Form\Extension\Core\Type\FileType;
use Symfony\Component\Validator\Constraints\File;
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
            ->add('stockDisponible')
            ->add('isActive')
            ->add('createAt', null, [
                'widget' => 'single_text'
            ])
            ->add('platsMany', EntityType::class, [
                'class' => Plat::class,
                'choice_label' => 'name',
                'multiple' => true,
                'expanded' => true,
                'required' => false,
                'label' => 'Plats du menu',
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
            ->add('imageMainFile', FileType::class, [
                'label' => 'Photo principale',
                'mapped' => false,
                'required' => false,
                'constraints' => [
                    new File([
                        'maxSize' => '10M',
                        'mimeTypes' => ['image/jpeg', 'image/png', 'image/webp'],
                        'mimeTypesMessage' => 'Veuillez ajouter une image valide.',
                    ])
                ],
            ])
            ->add('imageSecondFile', FileType::class, [
                'label' => 'Photo 2',
                'mapped' => false,
                'required' => false,
                'constraints' => [
                    new File([
                        'maxSize' => '10M',
                        'mimeTypes' => ['image/jpeg', 'image/png', 'image/webp'],
                        'mimeTypesMessage' => 'Veuillez ajouter une image valide.',
                    ])
                ],
            ])
            ->add('imageThirdFile', FileType::class, [
                'label' => 'Photo 3',
                'mapped' => false,
                'required' => false,
                'constraints' => [
                    new File([
                        'maxSize' => '10M',
                        'mimeTypes' => ['image/jpeg', 'image/png', 'image/webp'],
                        'mimeTypesMessage' => 'Veuillez ajouter une image valide.',
                    ])
                ],
            ])
            ->add('imageFourthFile', FileType::class, [
                'label' => 'Photo 4',
                'mapped' => false,
                'required' => false,
                'constraints' => [
                    new File([
                        'maxSize' => '10M',
                        'mimeTypes' => ['image/jpeg', 'image/png', 'image/webp'],
                        'mimeTypesMessage' => 'Veuillez ajouter une image valide.',
                    ])
                ],
            ])
        ;
    }

    public function configureOptions(OptionsResolver $resolver): void
    {
        $resolver->setDefaults([
            'data_class' => Menu::class,
        ]);
    }
}
