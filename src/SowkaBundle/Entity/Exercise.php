<?php

namespace SowkaBundle\Entity;

use Doctrine\ORM\Mapping as ORM;
use SowkaBundle\Entity\Category;

/**
 * Exercise
 *
 * @ORM\Table(name="exercise")
 * @ORM\Entity(repositoryClass="SowkaBundle\Repository\ExerciseRepository")
 */
class Exercise
{
    /**
     * @var int
     *
     * @ORM\Column(name="id", type="integer")
     * @ORM\Id
     * @ORM\GeneratedValue(strategy="AUTO")
     */
    private $id;

    /**
     * @var string
     *
     * @ORM\Column(name="name", type="string", length=255)
     */
    private $name;

    /**
     * @var string
     *
     * @ORM\Column(name="training", type="string", length=255)
     */
    private $training;

    /**
     * @ORM\ManyToOne(targetEntity="Category", inversedBy="exercises")
     */
    private $category;


    /**
     * Get id
     *
     * @return int
     */
    public function getId()
    {
        return $this->id;
    }

    /**
     * Set name
     *
     * @param string $name
     *
     * @return Exercise
     */
    public function setName($name)
    {
        $this->name = $name;

        return $this;
    }

    /**
     * Get name
     *
     * @return string
     */
    public function getName()
    {
        return $this->name;
    }

    /**
     * Set training
     *
     * @param string $training
     *
     * @return Exercise
     */
    public function setTraining($training)
    {
        $this->training = $training;

        return $this;
    }

    /**
     * Get training
     *
     * @return string
     */
    public function getTraining()
    {
        return $this->training;
    }

    /**
     * Set category
     *
     * @param \SowkaBundle\Entity\Category $category
     *
     * @return Exercise
     */
    public function setCategory(\SowkaBundle\Entity\Category $category = null)
    {
        $this->category = $category;

        return $this;
    }

    /**
     * Get category
     *
     * @return \SowkaBundle\Entity\Category
     */
    public function getCategory()
    {
        return $this->category;
    }
}
