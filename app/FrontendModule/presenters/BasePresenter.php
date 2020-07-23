<?php

namespace App\FrontendModule\Presenters;

use Nette;

abstract class BasePresenter extends Nette\Application\UI\Presenter
{
    /** @var \Nette\Database\Context @inject */
    public $database;

    public function startup()
    {
        parent::startup();

        if ($this->getName() !== 'Frontend:Migration') {
            try {
                if (!$this->database->fetchField('SELECT COUNT(id) FROM Users')) {
                    echo 'Databáze pravděpodobně neobsahuje <b>data</b>.<br>Kliknutím <a href="' . $this->link('Migration:data') . '">zde</a> je můžete naimportovat.';
                    $this->terminate();
                }
            } catch (Nette\Database\DriverException $exception) {
                echo 'Databáze pravděpodobně neobsahuje <b>tabulky</b>.<br>Kliknutím <a href="' . $this->link('Migration:schema') . '">zde</a> je můžete naimportovat.';
                $this->terminate();
            }
        }
    }
}

