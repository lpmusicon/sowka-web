<?php

namespace SowkaBundle\DataFixtures\ORM;

use Doctrine\Common\DataFixtures\AbstractFixture;
use Doctrine\Common\DataFixtures\OrderedFixtureInterface;
use Symfony\Component\DependencyInjection\ContainerAwareInterface; 
use Symfony\Component\DependencyInjection\ContainerInterface;
use Doctrine\Common\Persistence\ObjectManager;
use SowkaBundle\Entity\Category;

class LoadCategoryData extends AbstractFixture implements OrderedFixtureInterface, ContainerAwareInterface 
{
    private $container;

    public function getOrder()
    {
        return 3;
    }

    public function setContainer(ContainerInterface $container = null) 
    { 
        $this->container = $container; 
    }

    public function load(ObjectManager $manager)
    {
        $mowaBierna = new Category();
        $mowaBierna
            ->setName("Mowa bierna")
            ->setImage("assets/img/sheep.png")
            ->setColor("#5b9314");

        $grafomotoryka = new Category();
        $grafomotoryka
            ->setName("Grafomotoryka")
            ->setImage("assets/img/car.png")
            ->setColor("#243470");

        $sekwencje = new Category();
        $sekwencje
            ->setName("Układanie sekwencji")
            ->setImage("assets/img/ship.png")
            ->setColor("#ad3f75");

        $szeregi = new Category();
        $szeregi
            ->setName("Układanie szeregów")
            ->setImage("assets/img/airplane.png")
            ->setColor("#db9704");

        $manager->persist($mowaBierna);
        $manager->persist($grafomotoryka);
        $manager->persist($sekwencje);
        $manager->persist($szeregi);

        $this->addReference('category-bierna', $mowaBierna);
        $this->addReference('category-grafomotoryka', $grafomotoryka);
        $this->addReference('category-sekwencje', $sekwencje);
        $this->addReference('category-szeregi', $szeregi);

        $manager->flush();
    }
}