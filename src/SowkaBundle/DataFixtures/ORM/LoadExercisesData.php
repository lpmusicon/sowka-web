<?php

namespace SowkaBundle\DataFixtures\ORM;

use Doctrine\Common\DataFixtures\AbstractFixture;
use Doctrine\Common\DataFixtures\OrderedFixtureInterface;
use Symfony\Component\DependencyInjection\ContainerAwareInterface; 
use Symfony\Component\DependencyInjection\ContainerInterface;
use Doctrine\Common\Persistence\ObjectManager;
use SowkaBundle\Entity\Category;
use SowkaBundle\Entity\Exercise;

class LoadExercisesData extends AbstractFixture implements OrderedFixtureInterface, ContainerAwareInterface 
{
    private $container;

    public function getOrder()
    {
        return 4;
    }

    public function setContainer(ContainerInterface $container = null) 
    { 
        $this->container = $container; 
    }

    public function load(ObjectManager $manager)
    {
        $this->loadMowaBierna($manager);
        $this->loadGrafomotoryka($manager);
        $this->loadSekwencje($manager);
        $this->loadSzeregi($manager);

        $manager->flush();
    }

    private function loadMowaBierna(ObjectManager $manager)
    {
        $mowaBierna = $this->getReference('category-bierna');

        $vowels = new Exercise();
        $vowels
            ->setName("Samogłoski")
            ->setTraining("assets/exercises/vowel_exercise.pde")
            ->setCategory($mowaBierna);

        $toys = new Exercise();
        $toys
            ->setName("Zabawki")
            ->setTraining("assets/exercises/toys_exercise.pde")
            ->setCategory($mowaBierna);

        $cutlery = new Exercise();
        $cutlery
            ->setName("Sztućce")
            ->setTraining("assets/exercises/cutlery_exercise.pde")
            ->setCategory($mowaBierna);

        $animals = new Exercise();
        $animals
            ->setName("Zwierzęta")
            ->setTraining("assets/exercises/animals_exercise.pde")
            ->setCategory($mowaBierna);
        
        $furniture = new Exercise();
        $furniture
            ->setName("Meble")
            ->setTraining("assets/exercises/furniture_exercise.pde")
            ->setCategory($mowaBierna);

        $colors = new Exercise();
        $colors
            ->setName("Kolory")
            ->setTraining("assets/exercises/colors_exercise.pde")
            ->setCategory($mowaBierna);

        $clothes = new Exercise();
        $clothes
            ->setName("Ubrania")
            ->setTraining("assets/exercises/clothes_exercise.pde")
            ->setCategory($mowaBierna);

        $mowaBierna
            ->addExercise($vowels)
            ->addExercise($toys)
            ->addExercise($cutlery)
            ->addExercise($animals)
            ->addExercise($furniture)
            ->addExercise($colors)
            ->addExercise($clothes);

        $manager->persist($vowels);
        $manager->persist($toys);
        $manager->persist($cutlery);
        $manager->persist($animals);
        $manager->persist($furniture);
        $manager->persist($colors);
        $manager->persist($clothes);
        $manager->persist($mowaBierna);

        $manager->flush();
    }

    private function loadGrafomotoryka(ObjectManager $manager)
    {
        $grafomotoryka = $this->getReference('category-grafomotoryka');

        $levelOne = new Exercise();
        $levelOne
            ->setName("Zaparkuj samochodzik (Poziom Bardzo Łatwy)")
            ->setTraining("assets/exercises/car_lv1.pde")
            ->setCategory($grafomotoryka);

        $levelTwo = new Exercise();
        $levelTwo
            ->setName("Zaparkuj samochodzik (Poziom Łatwy)")
            ->setTraining("assets/exercises/car_lv2.pde")
            ->setCategory($grafomotoryka);

        $levelThree = new Exercise();
        $levelThree
            ->setName("Zaparkuj samochodzik (Poziom Średni)")
            ->setTraining("assets/exercises/car_lv3.pde")
            ->setCategory($grafomotoryka);

        $levelFour = new Exercise();
        $levelFour
            ->setName("Zaparkuj samochodzik (Poziom Trudny)")
            ->setTraining("assets/exercises/car_lv4.pde")
            ->setCategory($grafomotoryka);
        
        $levelFive = new Exercise();
        $levelFive
            ->setName("Zaparkuj samochodzik (Poziom Bardzo Trudny)")
            ->setTraining("assets/exercises/car_lv5.pde")
            ->setCategory($grafomotoryka);
       

        $grafomotoryka
            ->addExercise($levelOne)
            ->addExercise($levelTwo)
            ->addExercise($levelThree)
            ->addExercise($levelFour)
            ->addExercise($levelFive);

        $manager->persist($levelOne);
        $manager->persist($levelTwo);
        $manager->persist($levelThree);
        $manager->persist($levelFour);
        $manager->persist($levelFive);

        $manager->flush();
    }

    private function loadSekwencje(ObjectManager $manager)
    {
        $sekwencje = $this->getReference('category-sekwencje');

        $levelOne = new Exercise();
        $levelOne
            ->setName("Układanie pojazdów (Poziom Łatwy)")
            ->setTraining("assets/exercises/sequence_vehicle_lv1.pde")
            ->setCategory($sekwencje);

        $levelTwo = new Exercise();
        $levelTwo
            ->setName("Układanie pogody (Poziom Łatwy)")
            ->setTraining("assets/exercises/sequence_weather_lv1.pde")
            ->setCategory($sekwencje);

        $levelThree = new Exercise();
        $levelThree
            ->setName("Układanie pojazdów (Poziom Trudny)")
            ->setTraining("assets/exercises/sequence_vehicle_lv2.pde")
            ->setCategory($sekwencje);

        $levelFour = new Exercise();
        $levelFour
            ->setName("Układanie pogody (Poziom Trudny)")
            ->setTraining("assets/exercises/sequence_weather_lv2.pde")
            ->setCategory($sekwencje);
       

        $sekwencje
            ->addExercise($levelOne)
            ->addExercise($levelTwo)
            ->addExercise($levelThree)
            ->addExercise($levelFour);

        $manager->persist($levelOne);
        $manager->persist($levelTwo);
        $manager->persist($levelThree);
        $manager->persist($levelFour);

        $manager->flush();
    }

    private function loadSzeregi(ObjectManager $manager)
    {
        $sekwencje = $this->getReference('category-szeregi');

        $levelOne = new Exercise();
        $levelOne
            ->setName("Sortowanie samochodów (Poziom Łatwy)")
            ->setTraining("assets/exercises/sort_lv1_car.pde")
            ->setCategory($sekwencje);

        $levelTwo = new Exercise();
        $levelTwo
            ->setName("Sortowanie samolotów (Poziom Łatwy)")
            ->setTraining("assets/exercises/sort_lv1_plane.pde")
            ->setCategory($sekwencje);

        $levelThree = new Exercise();
        $levelThree
            ->setName("Sortowanie statków (Poziom Łatwy)")
            ->setTraining("assets/exercises/sort_lv1_ship.pde")
            ->setCategory($sekwencje);

        $levelFour = new Exercise();
        $levelFour
            ->setName("Sortowanie kotków (Poziom Łatwy)")
            ->setTraining("assets/exercises/sort_lv1_cat.pde")
            ->setCategory($sekwencje);

        $levelFive = new Exercise();
        $levelFive
            ->setName("Sortowanie krówek (Poziom Łatwy)")
            ->setTraining("assets/exercises/sort_lv1_cow.pde")
            ->setCategory($sekwencje);
       

        $sekwencje
            ->addExercise($levelOne)
            ->addExercise($levelTwo)
            ->addExercise($levelThree)
            ->addExercise($levelFour)
            ->addExercise($levelFive);

        $manager->persist($levelOne);
        $manager->persist($levelTwo);
        $manager->persist($levelThree);
        $manager->persist($levelFour);
        $manager->persist($levelFive);

        $manager->flush();
    }
}