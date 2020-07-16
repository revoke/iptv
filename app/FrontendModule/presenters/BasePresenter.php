<?php

namespace App\FrontendModule\Presenters;

use Nette;

abstract class BasePresenter extends Nette\Application\UI\Presenter
{
    /** @var \Nette\Database\Context @inject */
    public $database;
}

