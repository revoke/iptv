<?php

namespace App\FrontendModule\Presenters;

class TasksPresenter extends BasePresenter
{ 
    
    public function renderChannel($channel = 'ct4sport')
    {
        $sql = "
     SELECT users.login, GROUP_CONCAT(channelPackages.name SEPARATOR ', ') AS channelName
       FROM users
 INNER JOIN services ON services.user = users.id
 INNER JOIN channelpackages ON channelpackages.id IN (
                                  SELECT IF (d1.type = 'package', d1.id, IF (d2.type = 'package', d2.id, d3.id)) AS package_id
                                    FROM channelpackages d1
                               LEFT JOIN channelpackages d2 ON d1.id = d2.parent AND d2.type <> 'extern'
                               LEFT JOIN channelpackages d3 ON d2.id = d3.parent AND d3.type <> 'extern'
                                   WHERE d1.type <> 'extern'
                                     AND d1.id = services.channelPackage
                                    )
 INNER JOIN channelpackagechannels ON channelpackages.id = channelpackagechannels.package
 INNER JOIN channels ON channelpackagechannels.channel = channels.id AND channels.id = ?
      WHERE services.active = 1
        AND CURRENT_DATE() BETWEEN services.from AND IFNULL(services.to, CURRENT_DATE())
        AND channelpackages.active = 1
        AND channels.active = 1 
   GROUP BY users.id";
        
        $users = $this->database->query($sql, $channel);
                                
        $this->template->sql     = $sql;
        $this->template->users   = $users;
        $this->template->query   = $users->getQueryString();
        $this->template->channel = $channel;
    }
    
    
    
    public function renderNoChannel()
    {
        $sql = "
SELECT users.id, users.login
  FROM users
 WHERE NOT EXISTS (SELECT *
                     FROM services
                LEFT JOIN channelpackages
                       /* se sluzbou je spjat balicek, pricemz nas zajimaji jen balicky s kanaly (type=package) */ 
                       ON channelpackages.id IN (
                                                  SELECT IF (d1.type = 'package', d1.id, IF (d2.type = 'package', d2.id, d3.id)) AS package_id
                                                    FROM channelpackages d1
                                               LEFT JOIN channelpackages d2 ON d1.id = d2.parent AND d2.type <> 'extern'
                                               LEFT JOIN channelpackages d3 ON d2.id = d3.parent AND d3.type <> 'extern'
                                                   WHERE d1.type <> 'extern'
                                                     AND d1.id = services.channelPackage
                                                  )

                     /* u nalezenych balicku kanalu zkontroluji stav */
                     LEFT JOIN channelpackagechannels 
                       ON channelpackages.id = channelpackagechannels.package 
                      AND channelpackages.active = 1

                     /* i samotne kanaly musi byt aktivni */
                     LEFT JOIN channels 
                       ON channelpackagechannels.channel = channels.id 
                      AND channels.active = 1

                     WHERE services.active = 1
                       AND CURRENT_DATE() BETWEEN services.from AND IFNULL(services.to, CURRENT_DATE())
                       AND users.id = services.user
                 )";
        
        $users = $this->database->query($sql);
                            
        $this->template->users = $users;
        $this->template->sql   = $sql;    
        $this->template->query = $users->getQueryString();
    }
    
    
    public function renderHbogo($channel = 'hbogo')
    {
        $sql = "
     SELECT users.login,
            /* součet intervalů ze všech služeb, které měl uživatel kdy objednán a které zároveň jsou/obsahují sledovanou službu */  
            SUM(
                /* null hodnota _services.from znamená nenaleznou službu, tedy počet dnů = 0 */
                /* ignorujeme také služby, jejichž odběr ještě nebyl zahájen */
                IF(_services.from IS NULL OR _services.from > CURRENT_DATE(), 0, 
                      /* pokud je 'to' null, služba je odebírána = použijeme dnešní den */
                      /* pokud je 'to' nastaveno, zajímá nás buď datum ukončení v minulosti nebo použijeme dnešní den */
                      DATEDIFF(IF(_services.to IS NULL, CURRENT_DATE(), LEAST(_services.to, CURRENT_DATE())), _services.from) + 1
                  )
               ) AS diff,
            /* pro kontroluju vypisuji i seznam balíčků, které obsahují sledovanou službu */   
            GROUP_CONCAT(DISTINCT _services.name ORDER BY _services.name SEPARATOR ', ')  AS channelName

       FROM users 

  LEFT JOIN (SELECT services.user, services.from, services.to, channelPackages.name 
               FROM services
         INNER JOIN channelpackages 
                  /* zde potřebuji najít všechny balíčky, které obsahují sledovanou službu nebo je to služba samotná */
                 ON channelpackages.id IN (SELECT d1.id
                                             FROM channelpackages d1
                                        LEFT JOIN channelpackages d2 ON d1.id = d2.parent
                                        LEFT JOIN channelpackages d3 ON d2.id = d3.parent
                                            WHERE ? IN (d1.shortname, d2.shortname, d3.shortname)
                                              AND d1.id = services.channelPackage
                                          )
             ) _services
         ON _services.user = users.id 

   GROUP BY users.id";
        
        $users = $this->database->query($sql, $channel);
                                
        $this->template->users = $users;
        $this->template->sql   = $sql;
        $this->template->query = $users->getQueryString();
    }
}