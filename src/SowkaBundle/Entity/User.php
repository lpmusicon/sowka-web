<?php

namespace SowkaBundle\Entity;

use Doctrine\ORM\Mapping as ORM;
use Symfony\Component\Security\Core\User\UserInterface;
use SowkaBundle\Entity\Reward;
use Doctrine\Common\Collections\ArrayCollection;
use Symfony\Component\Validator\Constraints as Assert;
use Vich\UploaderBundle\Mapping\Annotation as Vich;
use Symfony\Bridge\Doctrine\Validator\Constraints\UniqueEntity;
use Symfony\Component\HttpFoundation\File\File;

/**
 * @ORM\Table(name="users")
 * @ORM\Entity()
 * @UniqueEntity(fields={"username"}, message="Taki użytkownik już istnieje", groups={"registration"})
 * @Vich\Uploadable
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
     * @ORM\Column(type="string", length=25, unique=true, nullable=false, name="username")
     * @Assert\NotBlank(groups={"registration"})
     * @Assert\Length(
     *    min = 3,
     *    minMessage = "Twój login musi mieć minimum trzy znaki",
     *    max = 25,
     *    maxMessage = "Twój login musi mieć maksymalnie 25 znaków",
     *    groups={"registration"}
     * )
     */
    private $username;

    /**
     * @ORM\Column(type="string", length=64)
     */
    private $password;

    /**
     * @Assert\NotBlank(groups={"registration"})
     * @Assert\Length(
     *    min = 3,
     *    minMessage = "Twoje hasło musi mieć minimum trzy znaki",
     *    max = 32,
     *    maxMessage = "Twoje hasło musi mieć maksymalnie 32 znaki",
     *    groups={"registration"}
     * )
     */
    private $plainPassword;

    /**
     * @ORM\Column(name="is_active", type="boolean")
     */
    private $isActive = true;

    /**
     * @ORM\Column(name="name", type="string", length=255)
     * @Assert\NotNull(groups={"setup"})
     * @Assert\NotBlank(groups={"setup"})
     * @Assert\Length(
     *    min = 3,
     *    minMessage = "Imię musi mieć minimum trzy znaki",
     *    max = 64,
     *    maxMessage = "Imię musi mieć maksymalnie 64 znaki",
     *    groups={"setup"}
     * )
     */
    private $name = '';

    /**
     * @ORM\Column(name="completed_setup", type="boolean")
     */
    private $completedSetup = false;
    
    /**
     * @ORM\Column(name="is_using_avatar", type="boolean", nullable=true)
     * @Assert\NotNull(groups={"image", "avatar"})
     */
    private $isUsingAvatar;
    
    /**
     * @ORM\Column(name="is_male_avatar", type="boolean", nullable=true)
     */
    private $isMaleAvatar;

    /**
     * @ORM\Column(name="image_path", type="string", length=255, nullable=true)
     */
    private $imagePath;

    /**
     * @Vich\UploadableField(mapping="child_image", fileNameProperty="imagePath")
     * @Assert\Image(groups={"image"})
     */
    private $imageFile;

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
        if($isUsingAvatar) {
            $this->imagePath = null;
        }

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

    /**
     * Set name
     *
     * @param string $name
     *
     * @return User
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

    public function setSingleReward(Reward $reward = null)
    {
        if(!$reward) {
            return;
        }
        $this->reward->clear();
        $this->reward->add($reward);
        return $this;
    }

    public function getSingleReward()
    {
        return $this->reward->first();
    }

    public function setImageFile(File $image = null)
    {
        $this->imageFile = $image;
        
        return $this;
    }

    /**
     * @return File|null
     */
    public function getImageFile()
    {
        return $this->imageFile;
    }

}
