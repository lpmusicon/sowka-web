<?php

namespace SowkaBundle\Entity;

use Doctrine\ORM\Mapping as ORM;
use Symfony\Component\Security\Core\User\UserInterface;
use SowkaBundle\Entity\Reward;
use Doctrine\Common\Collections\ArrayCollection;

/**
 * @ORM\Table(name="users")
 * @ORM\Entity()
 */
class User implements UserInterface, \Serializable
{
    /**
     * @ORM\Column(type="integer")
     * @ORM\Id
     * @ORM\GeneratedValue(strategy="AUTO")
     */
    private $id;

    /**
     * @ORM\Column(type="string", length=25, unique=true, nullable=false)
     */
    private $username;

    /**
     * @ORM\Column(type="string", length=64)
     */
    private $password;

    private $plainPassword;

    /**
     * @ORM\Column(name="is_active", type="boolean")
     */
    private $isActive;

    private $name;

    /**
     * @ORM\Column(name="completed_setup", type="boolean")
     */
    private $completedSetup = false;
    
    /**
     * @ORM\Column(name="is_using_avatar", type="boolean")
     */
    private $isUsingAvatar;
    
    /**
     * @ORM\Column(name="is_male_avatar", type="boolean")
     */
    private $isMaleAvatar;

    /**
     * @ORM\Column(name="image_path", type="string", length=255)
     */
    private $imagePath;

    /**
     * @ORM\ManyToMany(targetEntity="Reward")
     * @ORM\JoinTable(name="user_rewards",
     *      joinColumns={@ORM\JoinColumn(name="user_id", referencedColumnName="id")},
     *      inverseJoinColumns={@ORM\JoinColumn(name="reward_id", referencedColumnName="id")}
     *     )
     */
    private $reward;

    public function __construct()
    {
        $this->isActive = true;
        $this->reward = new \Doctrine\Common\Collections\ArrayCollection();
    }

    public function getUsername()
    {
        return $this->username;
    }

    public function getSalt()
    {
        return null;
    }

    public function getPassword()
    {
        return $this->password;
    }

    public function getRoles()
    {
        return array('ROLE_USER');
    }

    public function eraseCredentials()
    {
    }

    public function getPlainPassword()
    {
        return $this->plainPassword;
    }

    public function setPlainPassword($password)
    {
        $this->plainPassword = $password;
        return $this;
    }

    /** @see \Serializable::serialize() */
    public function serialize()
    {
        return serialize(array(
            $this->id,
            $this->username,
            $this->password,
            // see section on salt below
            // $this->salt,
        ));
    }

    /** @see \Serializable::unserialize() */
    public function unserialize($serialized)
    {
        list (
            $this->id,
            $this->username,
            $this->password,
            // see section on salt below
            // $this->salt
        ) = unserialize($serialized);
    }

    /**
     * Get id
     *
     * @return integer
     */
    public function getId()
    {
        return $this->id;
    }

    /**
     * Set username
     *
     * @param string $username
     *
     * @return User
     */
    public function setUsername($username)
    {
        $this->username = $username;

        return $this;
    }

    /**
     * Set password
     *
     * @param string $password
     *
     * @return User
     */
    public function setPassword($password)
    {
        $this->password = $password;

        return $this;
    }

    /**
     * Set isActive
     *
     * @param boolean $isActive
     *
     * @return User
     */
    public function setIsActive($isActive)
    {
        $this->isActive = $isActive;

        return $this;
    }

    /**
     * Get isActive
     *
     * @return boolean
     */
    public function getIsActive()
    {
        return $this->isActive;
    }

    /**
     * Set isUsingAvatar
     *
     * @param boolean $isUsingAvatar
     *
     * @return User
     */
    public function setIsUsingAvatar($isUsingAvatar)
    {
        $this->isUsingAvatar = $isUsingAvatar;

        return $this;
    }

    /**
     * Get isUsingAvatar
     *
     * @return boolean
     */
    public function getIsUsingAvatar()
    {
        return $this->isUsingAvatar;
    }

    /**
     * Set isMaleAvatar
     *
     * @param boolean $isMaleAvatar
     *
     * @return User
     */
    public function setIsMaleAvatar($isMaleAvatar)
    {
        $this->isMaleAvatar = $isMaleAvatar;

        return $this;
    }

    /**
     * Get isMaleAvatar
     *
     * @return boolean
     */
    public function getIsMaleAvatar()
    {
        return $this->isMaleAvatar;
    }

    /**
     * Set imagePath
     *
     * @param string $imagePath
     *
     * @return User
     */
    public function setImagePath($imagePath)
    {
        $this->imagePath = $imagePath;

        return $this;
    }

    /**
     * Get imagePath
     *
     * @return string
     */
    public function getImagePath()
    {
        return $this->imagePath;
    }

    /**
     * Add reward
     *
     * @param \SowkaBundle\Entity\Reward $reward
     *
     * @return User
     */
    public function addReward(\SowkaBundle\Entity\Reward $reward)
    {
        $this->reward[] = $reward;

        return $this;
    }

    /**
     * Remove reward
     *
     * @param \SowkaBundle\Entity\Reward $reward
     */
    public function removeReward(\SowkaBundle\Entity\Reward $reward)
    {
        $this->reward->removeElement($reward);
    }

    /**
     * Get reward
     *
     * @return \Doctrine\Common\Collections\Collection
     */
    public function getReward()
    {
        return $this->reward;
    }

    /**
     * Set completedSetup
     *
     * @param boolean $completedSetup
     *
     * @return User
     */
    public function setCompletedSetup($completedSetup)
    {
        $this->completedSetup = $completedSetup;

        return $this;
    }

    /**
     * Get completedSetup
     *
     * @return boolean
     */
    public function getCompletedSetup()
    {
        return $this->completedSetup;
    }
}
