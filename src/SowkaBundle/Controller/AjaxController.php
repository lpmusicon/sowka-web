<?php

namespace SowkaBundle\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\Controller;
use Sensio\Bundle\FrameworkExtraBundle\Configuration\Route;

class AjaxController extends Controller
{
    /**
     * @Route("/ajax/")
     */
    public function indexAction()
    {
        return $this->render('SowkaBundle:Default:index.html.twig');
    }
}
