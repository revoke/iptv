<?php

namespace App\FrontendModule\Presenters;

class TasksPresenter extends BasePresenter
{ 
    
    public function renderChannel($channel = 'ct4sport')
    {
        $sql = "
     SELECT Users.login, GROUP_CONCAT(ChannelPackages.name SEPARATOR ', ') AS channelName
       FROM Users
 INNER JOIN Services ON Services.user = Users.id
 INNER JOIN ChannelPackages ON ChannelPackages.id IN (
                                  SELECT IF (d1.type = 'package', d1.id, IF (d2.type = 'package', d2.id, d3.id)) AS package_id
                                    FROM ChannelPackages d1
                               LEFT JOIN ChannelPackages d2 ON d1.id = d2.parent AND d2.type <> 'extern'
                               LEFT JOIN ChannelPackages d3 ON d2.id = d3.parent AND d3.type <> 'extern'
                                   WHERE d1.type <> 'extern'
                                     AND d1.id = Services.channelPackage
                                    )
 INNER JOIN ChannelPackageChannels ON ChannelPackages.id = ChannelPackageChannels.package
 INNER JOIN Channels ON ChannelPackageChannels.channel = Channels.id AND Channels.id = ?
      WHERE Services.active = 1
        AND CURRENT_DATE() BETWEEN Services.from AND IFNULL(Services.to, CURRENT_DATE())
        AND ChannelPackages.active = 1
        AND Channels.active = 1 
   GROUP BY Users.id";
        
        $users = $this->database->query($sql, $channel);
                                
        $this->template->sql     = $sql;
        $this->template->users   = $users;
        $this->template->query   = $users->getQueryString();
        $this->template->channel = $channel;
    }
    
    
    
    public function renderNoChannel()
    {
        $sql = "
SELECT Users.id, Users.login
  FROM Users
 WHERE NOT EXISTS (SELECT *
                     FROM Services
                LEFT JOIN ChannelPackages
                       /* se sluzbou je spjat balicek, pricemz nas zajimaji jen balicky s kanaly (type=package) */ 
                       ON ChannelPackages.id IN (
                                                  SELECT IF (d1.type = 'package', d1.id, IF (d2.type = 'package', d2.id, d3.id)) AS package_id
                                                    FROM ChannelPackages d1
                                               LEFT JOIN ChannelPackages d2 ON d1.id = d2.parent AND d2.type <> 'extern'
                                               LEFT JOIN ChannelPackages d3 ON d2.id = d3.parent AND d3.type <> 'extern'
                                                   WHERE d1.type <> 'extern'
                                                     AND d1.id = Services.channelPackage
                                                  )

                     /* u nalezenych balicku kanalu zkontroluji stav */
                     LEFT JOIN ChannelPackageChannels 
                       ON ChannelPackages.id = ChannelPackageChannels.package 
                      AND ChannelPackages.active = 1

                     /* i samotne kanaly musi byt aktivni */
                     LEFT JOIN Channels 
                       ON ChannelPackageChannels.channel = Channels.id 
                      AND Channels.active = 1

                     WHERE Services.active = 1
                       AND CURRENT_DATE() BETWEEN Services.from AND IFNULL(Services.to, CURRENT_DATE())
                       AND Users.id = Services.user
                 )";
        
        $users = $this->database->query($sql);
                            
        $this->template->users = $users;
        $this->template->sql   = $sql;    
        $this->template->query = $users->getQueryString();
    }
    
    
    public function renderHbogo($channel = 'hbogo')
    {
        $sql = "
    SELECT Users.login, COUNT(DISTINCT calendar.date) AS diff,
           GROUP_CONCAT(DISTINCT _services.name ORDER BY _services.name SEPARATOR ', ')  AS channelName
    
      FROM Users

 LEFT JOIN ( SELECT Services.user, Services.from, Services.to, ChannelPackages.name 
               FROM Services
         INNER JOIN ChannelPackages 
                  /* zde potřebuji najít všechny balíčky, které obsahují sledovanou službu nebo je to služba samotná */
                 ON ChannelPackages.id IN (SELECT d1.id
                                             FROM ChannelPackages d1
                                        LEFT JOIN ChannelPackages d2 ON d1.id = d2.parent
                                        LEFT JOIN ChannelPackages d3 ON d2.id = d3.parent
                                            WHERE ? IN (d1.shortname, d2.shortname, d3.shortname)
                                              AND d1.id = Services.channelPackage
                                          )
             ) _services
         ON _services.user = Users.id

LEFT JOIN ( WITH RECURSIVE Services AS (
                 SELECT '2015-01-01' AS date
                 UNION
                 SELECT DATE_ADD(date, INTERVAL 1 DAY)
                 FROM Services
                 WHERE DATE_ADD(date, INTERVAL 1 DAY) <= CURRENT_DATE
            )
            select * FROM Services
        ) calendar
        ON calendar.date BETWEEN _services.from AND IFNULL(_services.to, CURRENT_DATE())
    
GROUP BY Users.id";
        
        $users = $this->database->query($sql, $channel);
                                
        $this->template->users = $users;
        $this->template->sql   = $sql;
        $this->template->query = $users->getQueryString();
    }
}