<?php

namespace SowkaBundle\Controller;

use SowkaBundle\Entity\Reward;
use SowkaBundle\Entity\User;
use SowkaBundle\Entity\Category;
use SowkaBundle\Entity\Exercise;
use SowkaBundle\Form\ChildType;
use SowkaBundle\Form\UserType;
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

        return $this->render('SowkaBundle:Main:index.html.twig', [
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
    public function mainAction(Request $request, UserInterface $user = null)
    {
        if($user === null) {
            return $this->redirectToRoute('logout');
        }

        if(!$user->getCompletedSetup()) {
            return $this->redirectToRoute('setupChild');
        }

        $doctrine = $this->getDoctrine()->getManager();
        $categoriesRepo = $doctrine->getRepository("SowkaBundle:Category");
        
        return $this->render(
            'SowkaBundle:Main:main.html.twig', [
                'categories' => $categoriesRepo->findAll()
            ]
        );
    }

    /**
     * @Route("/setup", name="setupChild")
     */
    public function setupChildAction(Request $request, UserInterface $user = null)
    {
        if($user === null) {
            return $this->redirectToRoute('logout');
        }

        $doctrine = $this->getDoctrine()->getManager();
        $rewardsRepository = $doctrine->getRepository('SowkaBundle:Reward');
        $rewards = $rewardsRepository->findAll();

        $form = $this->createForm(ChildType::class, $user);

        $form->handleRequest($request);
        if ($form->isSubmitted() && $form->isValid()) {
            $user->setCompletedSetup(true);
            $doctrine->persist($user);
            $doctrine->flush();

            return $this->redirectToRoute('main');
        }

        return $this->render('SowkaBundle:Main:setup.html.twig', [
            'form' => $form->createView(),
            'rewards' => $rewards
        ]);
    }

    /**
     * @Route("/options", name="options")
     */
    public function optionsAction(UserInterface $user = null, Request $request)
    {
        $doctrine = $this->getDoctrine()->getManager();
        $rewardsRepository = $doctrine->getRepository('SowkaBundle:Reward');
        $rewards = $rewardsRepository->findAll();

        $form = $this->createForm(ChildType::class, $user);
        $form->handleRequest($request);
        if ($form->isSubmitted() && $form->isValid()) {
            $doctrine->persist($user);
            $doctrine->flush();

            return $this->redirectToRoute('main');
        }

        return $this->render('SowkaBundle:Main:options.html.twig', [
            'form' => $form->createView(),
            'rewards' => $rewards
        ]);
    }

    /**
     * @Route("/main/category/{category}", name="category", requirements={"category" = "\d+"})
     */
    public function categoryAction(Category $category = null)
    {
        if($category === null) {
            return $this->redirectToRoute('main');
        }

        $exercises = $this->getDoctrine()->getManager()->getRepository("SowkaBundle:Exercise")->findAllInCategory($category);

        return $this->render('SowkaBundle:Main:category.html.twig', [
            'exercises' => $exercises
        ]);
    }

    /**
     * @Route("/main/exercise/{exercise}", name="exercise", requirements={"exercise" = "\d+"})
     */
    public function exerciseAction(Exercise $exercise = null, UserInterface $user = null)
    {
        if($user === null) {
            return $this->redirectToRoute('logout');
        }

        if($exercise === null) {
            return $this->redirectToRoute('main');
        }

        return $this->render('SowkaBundle:Main:exercise.html.twig', [
            'exercise' => $exercise
        ]);
    }
}
