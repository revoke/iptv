<?php

namespace App;

use Nette,
    Nette\Application\Routers\RouteList,
    Nette\Application\Routers\Route;

class RouterFactory
{        
    /**
     * @return Nette\Application\Routers\RouteList
     */
    public static function createRouter() : Nette\Application\Routers\RouteList
    {
        $frontend   = new RouteList('Frontend');
        
        $frontend[] = new Route('<presenter=Homepage>[/<action=default>[/<id [\d]+>]]');
        
        $router   = new RouteList;
        $router[] = $frontend;
        
        return $router;
    }
    
}
