<?php

namespace SowkaBundle\Controller;

use SowkaBundle\Entity\User;
use SowkaBundle\Form\UserType;
use SowkaBundle\Form\ChildType;
use SowkaBundle\Entity\Reward;
use Symfony\Bundle\FrameworkBundle\Controller\Controller;
use Symfony\Component\HttpFoundation\Request;
use Sensio\Bundle\FrameworkExtraBundle\Configuration\Route;
use Sensio\Bundle\FrameworkExtraBundle\Configuration\Security;
use Symfony\Component\Security\Core\User\UserInterface;

class PagesController extends Controller
{
    /**
     * @Route("/", name="index")
     */
    public function indexAction(Request $request)
    {
        $authenticationUtils = $this->get('security.authentication_utils');

        $error = $authenticationUtils->getLastAuthenticationError();

        $lastUsername = $authenticationUtils->getLastUsername();

        $form = $this->createForm(UserType::class, new User);

        return $this->render('SowkaBundle:Default:index.html.twig', [
            'last_username' => $lastUsername,
            'error'         => $error,
            'register' => $form->createView()
        ]);
    }


    /**
     * @Route("/register", name="register")
     */
    public function registerAction(Request $request) 
    {
        $user = new User();
        $form = $this->createForm(UserType::class, $user);

        $form->handleRequest($request);
        if ($form->isSubmitted() && $form->isValid()) {

            $password = $this->get('security.password_encoder')
                ->encodePassword($user, $user->getPlainPassword());
            $user->setPassword($password);

            $em = $this->getDoctrine()->getManager();
            $em->persist($user);
            $em->flush();

            return $this->redirectToRoute('index');
        }

        return $this->render(
            'SowkaBundle:Login:register.html.twig',
            array('form' => $form->createView())
        );
    }

    /**
     * @Route("/main", name="main")
     */
    public function mainAction(Request $request, UserInterface $user)
    {
        if(!$user->getCompletedSetup()) {
            return $this->redirectToRoute('setupChild');
        }
        //Nie ma informacji o dziecku
        //Dodaj informacje o dziecku
        //Przejdz dalej
    }

    /**
     * @Route("/setup", name="setupChild")
     */
    public function setupChildAction(Request $request, UserInterface $user)
    {
        $doctrine = $this->getDoctrine()->getManager();
        $rewardsRepository = $doctrine->getRepository('SowkaBundle:Reward');
        $rewards = $rewardsRepository->findAll();

        $form = $this->createForm(ChildType::class, $user);

        $form->handleRequest($request);
        if ($form->isSubmitted() && $form->isValid()) {

            $em = $this->getDoctrine()->getManager();
            $em->persist($user);
            $em->flush();

            return $this->redirectToRoute('index');
        }

        return $this->render('SowkaBundle:Main:setup.html.twig', [
            'form' => $form->createView(),
            'rewards' => $rewards
        ]);
    }
}
