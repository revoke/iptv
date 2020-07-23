<?php

namespace App\FrontendModule\Presenters;

class MigrationPresenter extends BasePresenter
{
    public function actionData()
    {
        $this->database->query(file_get_contents(APP_DIR . '/../data/database_data.sql'));

        $this->redirect('Homepage:');
    }

    public function actionSchema()
    {
        $this->database->query(file_get_contents(APP_DIR . '/../data/database_schema.sql'));

        $this->redirect('Homepage:');
    }
}