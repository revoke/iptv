<?php

namespace App\FrontendModule\Repository;

class ChannelPackages extends \App\Repository
{
    
    public function getPackagesHiearchy() : array
    {
        $arr = [];
        foreach ($this->findAll() as $bundle)
        {
            $children = $this->database
                             ->query('SELECT id, name
                                        FROM (SELECT * FROM ChannelPackages ORDER BY parent, id) channelpackages,
                                             (SELECT @pv := ?) initialisation
                                       WHERE (FIND_IN_SET(parent, @pv) > 0 AND @pv := CONCAT(@pv, ",", id))
                                          OR id = @pv
                                    ', $bundle->id)
                             ->fetchPairs('id','name');
            
            $arr[$bundle->id] = $children;
        }
        
        return $arr;
    }
    
}
