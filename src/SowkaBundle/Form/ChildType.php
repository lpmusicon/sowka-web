<?php

namespace SowkaBundle\Form;

use SowkaBundle\Entity\User;
use Symfony\Component\Form\AbstractType;
use Symfony\Component\Form\FormBuilderInterface;
use Symfony\Component\Form\FormInterface;
use Symfony\Component\OptionsResolver\OptionsResolver;
use Symfony\Component\Form\Extension\Core\Type\TextType;
use Symfony\Component\Form\Extension\Core\Type\FileType;
use Symfony\Component\Form\Extension\Core\Type\CheckboxType;
use Symfony\Component\Form\Extension\Core\Type\NumberType;
use Symfony\Bridge\Doctrine\Form\Type\EntityType;
use SowkaBundle\Entity\Reward;

class ChildType extends AbstractType
{
    public function buildForm(FormBuilderInterface $builder, array $options)
    {
        $builder
            ->add('name', TextType::class)
            ->add('imageFile', FileType::class)
            ->add('isUsingAvatar', CheckboxType::class,
                [ 'required' => false ])
            ->add('isMaleAvatar', CheckboxType::class,
                [ 'required' => false])
            ->add('singleReward', EntityType::class, [
                'class' => 'SowkaBundle\Entity\Reward',
                'choice_label' => 'image',
                'multiple' => false,
                'expanded' => true
            ])
        ;
    }

    public function configureOptions(OptionsResolver $resolver)
    {
        $resolver->setDefaults(array(
            'data_class' => User::class,
            'validation_groups' => function (FormInterface $form) {
                $data = $form->getData();

                if(!$data->getIsUsingAvatar()) {
                    return ['setup', 'image'];
                }

                return ['setup', 'avatar'];
            },
        ));
    }
}