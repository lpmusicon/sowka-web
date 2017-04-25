<?php

namespace SowkaBundle\Entity;

use Doctrine\Common\DataFixtures\AbstractFixture;
use Doctrine\Common\DataFixtures\OrderedFixtureInterface;
use Symfony\Component\DependencyInjection\ContainerAwareInterface; 
use Symfony\Component\DependencyInjection\ContainerInterface;
use Doctrine\Common\Persistence\ObjectManager;
use SowkaBundle\Entity\User;
use SowkaBundle\Entity\Reward;

class LoadUserData extends AbstractFixture implements OrderedFixtureInterface, ContainerAwareInterface
{
    private $container;

    public function getOrder()
    {
        return 2;
    }

    public function setContainer(ContainerInterface $container = null) 
    { 
        $this->container = $container; 
    }

    public function load(ObjectManager $manager)
    {
        $passwd = $this->container->get('security.password_encoder');

        $plane = $this->getReference('reward-plane');

        $user = new User();
        $user
            ->setUsername("test")
            ->setPassword($passwd->encodePassword($user, 'test'))
            ->setCompletedSetup(true)
            ->setIsUsingAvatar(true)
            ->setIsMaleAvatar(true)
            ->setSingleReward($plane)
            ->setName("Tomek");

        $manager->persist($user);

        $manager->flush();
    }
}