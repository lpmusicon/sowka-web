<?php

namespace SowkaBundle\DataFixtures\ORM;

use Doctrine\Common\DataFixtures\AbstractFixture;
use Doctrine\Common\DataFixtures\OrderedFixtureInterface;
use Symfony\Component\DependencyInjection\ContainerAwareInterface; 
use Symfony\Component\DependencyInjection\ContainerInterface;
use Doctrine\Common\Persistence\ObjectManager;
use SowkaBundle\Entity\Reward;

class LoadRewardData extends AbstractFixture implements OrderedFixtureInterface, ContainerAwareInterface 
{
    private $container; 

    public function getOrder()
    {
        return 1;
    }

    public function setContainer(ContainerInterface $container = null) 
    { 
        $this->container = $container; 
    }

    public function load(ObjectManager $manager)
    {
        $plane = new Reward();
        $plane->setImage("assets/img/plane.png");
        
        $ship = new Reward();
        $ship->setImage("assets/img/ship.png");

        $train = new Reward();
        $train->setImage("assets/img/train.png");

        $manager->persist($plane);
        $manager->persist($ship);
        $manager->persist($train);
        
        $this->addReference('reward-plane', $plane);

        $manager->flush();
    }
}