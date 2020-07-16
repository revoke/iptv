<?php

namespace App\FrontendModule\Repository;

class Channels extends \App\Repository
{
    public function getChannelsByPackage($bundles) : array
    {
        $arr = [];
        foreach ($bundles as $bundle_id => $packages)
        {
            $arr[$bundle_id] = $this->database
                                    ->query('SELECT GROUP_CONCAT(DISTINCT channels.name ORDER BY channels.name SEPARATOR ", ") AS channels
                                               FROM channelpackagechannels
                                         INNER JOIN channels ON channels.id = channelpackagechannels.channel
                                              WHERE package IN (?)
                                             ', array_keys($packages))
                                    ->fetchField('channels');
        }
        return $arr;
    }
}
