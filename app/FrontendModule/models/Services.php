<?php

namespace App\FrontendModule\Repository;

class Services extends \App\Repository
{
    
    public function getAllServices() : array
    {
        return $this->findAll()->fetchAssoc('user|id');
    }
}