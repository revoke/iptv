# Testovací úkol

Instalace
=========
Stačí spustit `composer update` a nastavit připojení k DB. Připojení k MySQL databázi nakonfigurujete v `app/config/config.neon`.
Zkontrolujte existence složek log a temp a práva pro zápis.

Spuštění
========
Document root je ve složce www, ale .htaccess je nastaven tak, že přesměruje požadavky i z rootu aplikace.

Přepoklady
==========
Vyvinuto na PHP 7.3, Mysql 5.5, Apache 2.4

Komentář k řešení
=================
SQL dotazy by šly řešit efektivněji při použití vyšší verze MySQL. Mnou použitá verze 5.5 zejména nepodporuje rekurzivní dotazy, musel jsem tedy použít alternativní SQL konstrukci.
U výpisu na homepage jsem více samostatných SQL dotazů použil záměrně, abych eliminoval možnost chyby.
U 2. úkolu jsem ignoroval možnost mít aktivní službu HBOGO.
U 3. úkolu jsem neuvažoval překrývání služeb v čase.