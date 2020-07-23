<?php

require __DIR__ . '/../vendor/autoload.php';

define('APP_DIR', __DIR__);

$configurator = new Nette\Configurator;
$configurator->setDebugMode(true);
$configurator->enableDebugger(__DIR__ . '/../log');
$configurator->setTempDirectory(__DIR__ . '/../temp');                       
$configurator->createRobotLoader()
             ->addDirectory(__DIR__)
             ->register();
$configurator->addConfig(__DIR__ . '/config/config.neon');

return $configurator->createContainer(); 
