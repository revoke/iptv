# Testovací úkol

Instalace
---------
Spusťte `composer update` a v souborech v `app/config/config.neon` a `.env` nastavte připojení k databázi.

Projekt lze spustit buď jako kontejner v *Dockeru* (příkazem `docker-compose -p iptv -f docker-compose.yml up -d`), 
nebo standardním způsobem na localhostu.

Zkontrolujte existence složek *log* a *temp* a práva pro zápis.

Spuštění
--------
Document root je ve složce *www*, ale *.htaccess* je nastaven tak, že přesměruje požadavky i z rootu aplikace.

V případě použití nginx funguje jen request nad *www*. 

Adresa aplikace v případě použití *Dockeru*: http://localhost:8080

Přepoklady
----------
PHP 7.3, MariaDB 10, Apache 2.4 / Nginx

Komentář k řešení
-----------------
Nejdříve jsem SQL dotazy sestavoval na MySQL 5.5, tedy ve verzi, 
která nepodporuje efektivnější způsoby dotazování, např. rekurzi. 

Při dodatečném začlenění podmínky počítání jen unikátních dnů (u třetího úkolu) 
by řešení bez rekurze bylo tak složité, že jsem raději zvolil vyšší verzi MySQL, resp. MariaDB.
První dva úkoly jsem již zpětně neupravoval. 

U výpisu na homepage jsem více samostatných SQL dotazů použil záměrně, abych eliminoval možnost chyby.

U 2. úkolu jsem ignoroval možnost mít aktivní službu HBOGO.

~~U 3. úkolu jsem neuvažoval překrývání služeb v čase.~~ 3. úkol uvažuje překrývání 
služeb v čase - počítá tedy unikátní dny. Zvolené řešení předpokládá nastavení minimálního 
data sledovaného období, v našem případě 1.1.2015
