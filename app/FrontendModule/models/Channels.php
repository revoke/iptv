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
                                    ->query('SELECT GROUP_CONCAT(DISTINCT Channels.name ORDER BY Channels.name SEPARATOR ", ") AS channels
                                               FROM ChannelPackageChannels 
                                         INNER JOIN Channels ON Channels.id = ChannelPackageChannels.channel
                                              WHERE package IN (?)
                                             ', array_keys($packages))
                                    ->fetchField('channels');
        }
        return $arr;
    }
}
