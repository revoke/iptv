<?php

namespace App\FrontendModule\Presenters;

class HomepagePresenter extends BasePresenter
{ 
    /** @var \App\FrontendModule\Repository\Users @inject */
    public $usersModel;
    
    /** @var \App\FrontendModule\Repository\Services @inject */
    public $servicesModel;
    
    /** @var \App\FrontendModule\Repository\Channelpackages @inject */
    public $channelpackagesModel;
    
    /** @var \App\FrontendModule\Repository\Channels @inject */
    public $channelsModel;
    
    public function actionDefault()
    {
        $this->template->users = $this->usersModel->findAll();
        $this->template->services = $this->servicesModel->getAllServices();
        $this->template->packages = $this->channelpackagesModel->findAll()->fetchPairs('id','name');
        
        $bundles = $this->channelpackagesModel->getPackagesHiearchy();
        $this->template->bundles  = $bundles;
        $this->template->channels = $this->channelsModel->getChannelsByPackage($bundles);
    }
    
}