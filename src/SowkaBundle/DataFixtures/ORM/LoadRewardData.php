<?php

namespace SowkaBundle\DataFixtures\ORM;

use Doctrine\Common\DataFixtures\FixtureInterface;
use Doctrine\Common\Persistence\ObjectManager;
use SowkaBundle\Entity\Reward;

class LoadRewardData implements FixtureInterface
{
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

        $manager->flush();
    }
}