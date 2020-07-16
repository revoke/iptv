SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

INSERT INTO `Channels` (`id`, `active`, `type`, `name`, `epgProvider`, `epgProviderId`, `order`, `testing`, `public`, `availability`, `parentLock`, `malfunction`, `timeshiftDuration`, `timeshiftAvailable`, `timeshiftBeforeEvent`, `timeshiftAfterEvent`, `drm`, `audio`, `message`, `channelGroup`, `description`, `hd`) VALUES
('ct1', 1, 'tv', 'ČT1', 7, 'ct1', 100, 0, 1, 'cable', 0, NULL, 19200, 18000, 0, 15, 0, 'cze', NULL, 'general', 'Hlavní kanál české veřejnoprávní televize s nabídkou pořadů napříč žánry.', 1),
('ct2', 1, 'tv', 'ČT2', 7, 'ct2', 200, 0, 1, 'cable', 0, NULL, 1920, 1800, 0, 15, 0, 'cze', NULL, 'general', 'Druhý kanál České televize s nabídkou seriálů, dokumentů a klasických filmových děl.', 1),
('ct24', 1, 'tv', 'ČT24', 7, 'ct24', 600, 0, 1, 'cable', 0, NULL, 1920, 1800, 0, 15, 0, 'cze', NULL, 'news', 'Zpravodajství České televize, rozhovory, komentáře.', 0),
('ct4sport', 1, 'tv', 'ČT Sport', 7, 'ct4', 700, 0, 1, 'cable', 0, NULL, 1920, 1800, 0, 15, 0, 'cze', NULL, 'sport', 'Sportovní program České televize, 24 hodin denně.', 1),
('ctart', 1, 'tv', 'ČT art', 7, 'ct6', 460, 0, 1, 'vodafone', 0, NULL, 1920, 1800, 0, 15, 0, 'cze', NULL, 'general', 'Program České televize pro kulturní fanoušky vystřídá každý večer program ČT :D.', 0),
('eurosport', 1, 'tv', 'Eurosport', 7, 'eusport', 700, 0, 1, 'cable', 0, NULL, 1920, 1800, 0, 15, 0, 'cze', NULL, 'sport', 'Ikona mezi sportovními programy - atletika, cyklistika, tenis, motosport a další.', 1),
('HBO', 1, 'tv', 'HBO', 10, 'HBO', 1001, 0, 1, 'czsk', 0, NULL, 1920, 1800, 0, 15, 1, 'cze,eng', NULL, 'movie', 'Slavný filmový kanál. Filmové premiéry zcela bez reklam.', 1),
('HBO2', 1, 'tv', 'HBO2', 10, 'HBO2', 1101, 0, 1, 'czsk', 0, NULL, 1920, 1800, 0, 15, 1, 'cze,eng,hun', NULL, 'movie', 'Kasovní hity a seriály z vlastní produkce HBO.', 1),
('HBO3', 1, 'tv', 'HBO3', 10, 'HBOCOMEDY', 1102, 0, 1, 'czsk', 0, NULL, 1920, 1800, 0, 15, 1, 'cze,eng,hun', NULL, 'movie', 'Nejlepší komediální filmy, seriály a sitcomy.', 1);

INSERT INTO `ChannelPackages` (`id`, `active`, `name`, `type`, `provider`, `shortname`, `condition`, `description`, `parent`, `public`, `forUsers`, `offering`, `reporting`) VALUES
(3, 1, 'Premium', 'bundle', 1, 'premium', '', 'Prémiový balíček kanálů včetně HBO a HBO GO.', NULL, 1, 1, 0, 1),
(1, 1, 'Základ', 'package', 1, 'basic', '', 'Základní balíček programů.', 3, 1, 1, 1, 0),
(4, 1, 'Sport', 'package', 1, 'sport', '', 'Sportovní balíček programů.', 3, 1, 1, 1, 0),
(80, 1, 'Komplet HBO', 'bundle', 1, 'hbo_all', '', 'Kombinace HBO kanálů a externí služby HBO GO.', 3, 1, 1, 0, 1),
(81, 1, 'HBO', 'package', 1, 'hbo', '', 'Kanály HBO.', 80, 1, 1, 0, 1),
(82, 1, 'HBOGO', 'extern', 1, 'hbogo', '', 'Externí služba HBOGO.', 80, 1, 1, 0, 1);


INSERT INTO `ChannelPackageChannels` (`package`, `channel`, `multiscreen`, `ott`, `timeshift`, `timeshiftAvailable`) VALUES
(1, 'ct1', 1, 1, 1, NULL),
(1, 'ct2', 1, 1, 1, NULL),
(1, 'ct24', 1, 1, 1, NULL),
(1, 'ct4sport', 1, 1, 1, NULL),
(1, 'ctart', 1, 1, 1, NULL),
(4, 'ct4sport', 1, 1, 1, NULL),
(4, 'eurosport', 1, 1, 1, NULL),
(81, 'HBO', 1, 1, 1, NULL),
(81, 'HBO2', 1, 1, 1, NULL),
(81, 'HBO3', 1, 1, 1, NULL);



INSERT INTO `Users` (`id`, `active`, `login`, `email`, `password`, `salt`, `registered`, `partner`, `partnerId`, `admin`, `partnerAdmin`, `blocked`, `noNetworkRestriction`, `fullName`, `address`, `city`, `postcode`, `country`, `partnerData`, `partnerField`, `phone`, `tvfee`, `parallelStreams`, `computedParallelStreams`, `streamQuality`, `computedStreamQuality`, `vlcAllowed`, `mobileAllowed`, `locked`, `lastSessionEnd`, `comment`, `removed`, `oldLogin`, `partnerActivation`) VALUES
(1, 1, 'petr@example.com', NULL, '', NULL, '0000-00-00 00:00:00', NULL, NULL, 0, 0, NULL, NULL, 'Petr', NULL, NULL, NULL, 'cz', NULL, NULL, NULL, 0, 2, 1, 20, 30, 1, 1, 0, 0, '', NULL, NULL, NULL),
(2, 1, 'tomas@example.com', NULL, '', NULL, '0000-00-00 00:00:00', NULL, NULL, 0, 0, NULL, NULL, 'Tomas', NULL, NULL, NULL, 'cz', NULL, NULL, NULL, 0, 2, 1, 20, 30, 1, 1, 0, 0, '', NULL, NULL, NULL),
(3, 1, 'radek@example.com', NULL, '', NULL, '0000-00-00 00:00:00', NULL, NULL, 0, 0, NULL, NULL, 'Radek', NULL, NULL, NULL, 'cz', NULL, NULL, NULL, 0, 2, 1, 20, 30, 1, 1, 0, 0, '', NULL, NULL, NULL),
(4, 1, 'josef@example.com', NULL, '', NULL, '0000-00-00 00:00:00', NULL, NULL, 0, 0, NULL, NULL, 'Josef', NULL, NULL, NULL, 'cz', NULL, NULL, NULL, 0, 2, 1, 20, 30, 1, 1, 0, 0, '', NULL, NULL, NULL),
(5, 1, 'michal@example.com', NULL, '', NULL, '0000-00-00 00:00:00', NULL, NULL, 0, 0, NULL, NULL, 'Michal', NULL, NULL, NULL, 'cz', NULL, NULL, NULL, 0, 2, 1, 20, 30, 1, 1, 0, 0, '', NULL, NULL, NULL),
(6, 1, 'martin@example.com', NULL, '', NULL, '0000-00-00 00:00:00', NULL, NULL, 0, 0, NULL, NULL, 'Martin', NULL, NULL, NULL, 'cz', NULL, NULL, NULL, 0, 2, 1, 20, 30, 1, 1, 0, 0, '', NULL, NULL, NULL),
(7, 1, 'tonik.ponik@example.com', NULL, '', NULL, '0000-00-00 00:00:00', NULL, NULL, 0, 0, NULL, NULL, 'Tonda', NULL, NULL, NULL, 'cz', NULL, NULL, NULL, 0, 2, 1, 20, 30, 1, 1, 0, 0, '', NULL, NULL, NULL),
(8, 1, 'david@example.com', NULL, '', NULL, '0000-00-00 00:00:00', NULL, NULL, 0, 0, NULL, NULL, 'David', NULL, NULL, NULL, 'cz', NULL, NULL, NULL, 0, 2, 1, 20, 30, 1, 1, 0, 0, '', NULL, NULL, NULL);


INSERT INTO `Services` (`id`, `active`, `specification`, `user`, `from`, `to`, `partner`, `channelPackage`, `level`, `price`, `bundle`, `flag`) VALUES
(31, 1, NULL, 1, '2019-06-18', '2019-12-19', NULL, 1, NULL, '0.00', NULL, ''),
(32, 1, NULL, 1, '2019-08-12', '2019-11-28', NULL, 82, NULL, '0.00', NULL, ''),
(35, 1, NULL, 2, '2019-04-02', '2019-06-01', NULL, 81, NULL, '0.00', NULL, ''),
(36, 1, NULL, 2, '2019-06-02', '2019-06-30', NULL, 80, NULL, '0.00', NULL, ''),
(37, 1, NULL, 2, '2019-07-01', '2019-11-01', NULL, 3, NULL, '0.00', NULL, ''),
(38, 1, NULL, 2, '2019-12-10', '2020-01-10', NULL, 4, NULL, '0.00', NULL, ''),
(41, 1, NULL, 4, '2018-02-28', '2018-03-01', NULL, 82, NULL, '0.00', NULL, ''),
(42, 1, NULL, 4, '2018-12-20', NULL, NULL, 3, NULL, '0.00', NULL, ''),
(43, 1, NULL, 5, '2019-09-26', NULL, NULL, 82, NULL, '0.00', NULL, ''),
(44, 1, NULL, 6, '2019-11-27', '2020-01-27', NULL, 82, NULL, '0.00', NULL, ''),
(45, 1, NULL, 6, '2019-11-20', NULL, NULL, 81, NULL, '0.00', NULL, ''),
(46, 1, NULL, 7, '2017-04-08', NULL, NULL, 4, NULL, '0.00', NULL, ''),
(47, 1, NULL, 8, '2019-07-31', '2019-08-31', NULL, 1, NULL, '0.00', NULL, '');



/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
