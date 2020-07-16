SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;


CREATE TABLE `ChannelPackageChannels` (
  `package` int(11) NOT NULL,
  `channel` varchar(100) COLLATE utf8_czech_ci NOT NULL,
  `multiscreen` tinyint(4) NOT NULL DEFAULT 1,
  `ott` tinyint(4) NOT NULL DEFAULT 1,
  `timeshift` tinyint(4) NOT NULL DEFAULT 1,
  `timeshiftAvailable` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_czech_ci;

CREATE TABLE `ChannelPackages` (
  `id` int(11) NOT NULL,
  `active` tinyint(4) NOT NULL DEFAULT 1,
  `name` varchar(150) COLLATE utf8_czech_ci NOT NULL,
  `type` enum('package','bundle','extern','') COLLATE utf8_czech_ci NOT NULL DEFAULT 'package',
  `provider` int(11) NOT NULL,
  `shortname` varchar(25) COLLATE utf8_czech_ci DEFAULT NULL,
  `condition` mediumtext COLLATE utf8_czech_ci NOT NULL,
  `description` mediumtext COLLATE utf8_czech_ci NOT NULL,
  `parent` int(11) DEFAULT NULL,
  `public` tinyint(4) NOT NULL DEFAULT 0,
  `forUsers` tinyint(4) NOT NULL DEFAULT 0,
  `offering` tinyint(4) NOT NULL DEFAULT 0,
  `reporting` tinyint(4) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_czech_ci;

CREATE TABLE `Channels` (
  `id` varchar(100) COLLATE utf8_czech_ci NOT NULL,
  `active` tinyint(4) NOT NULL DEFAULT 1,
  `type` varchar(20) COLLATE utf8_czech_ci NOT NULL,
  `name` varchar(100) COLLATE utf8_czech_ci NOT NULL,
  `epgProvider` int(11) DEFAULT NULL,
  `epgProviderId` varchar(25) COLLATE utf8_czech_ci DEFAULT NULL COMMENT 'SID v multiplexu',
  `order` int(11) NOT NULL DEFAULT 1000,
  `testing` tinyint(4) NOT NULL DEFAULT 0,
  `public` tinyint(4) NOT NULL DEFAULT 1,
  `availability` varchar(15) COLLATE utf8_czech_ci NOT NULL DEFAULT 'cable',
  `parentLock` tinyint(4) NOT NULL DEFAULT 0,
  `malfunction` varchar(20) COLLATE utf8_czech_ci DEFAULT NULL,
  `timeshiftDuration` int(11) NOT NULL DEFAULT 0,
  `timeshiftAvailable` int(11) NOT NULL DEFAULT 0,
  `timeshiftBeforeEvent` int(11) NOT NULL DEFAULT 0,
  `timeshiftAfterEvent` int(11) NOT NULL DEFAULT 0,
  `drm` tinyint(4) NOT NULL DEFAULT 0,
  `audio` varchar(16) COLLATE utf8_czech_ci DEFAULT NULL,
  `message` varchar(255) COLLATE utf8_czech_ci DEFAULT NULL,
  `channelGroup` varchar(15) COLLATE utf8_czech_ci DEFAULT NULL,
  `description` varchar(500) COLLATE utf8_czech_ci NOT NULL DEFAULT '',
  `hd` tinyint(4) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_czech_ci;

CREATE TABLE `Services` (
  `id` int(11) NOT NULL,
  `active` tinyint(4) NOT NULL DEFAULT 1,
  `specification` int(11) DEFAULT NULL,
  `user` int(11) NOT NULL,
  `from` date DEFAULT NULL,
  `to` date DEFAULT NULL,
  `partner` int(11) DEFAULT NULL,
  `channelPackage` int(11) DEFAULT NULL,
  `level` int(11) DEFAULT NULL,
  `price` decimal(10,2) NOT NULL DEFAULT 0.00,
  `bundle` int(11) DEFAULT NULL,
  `flag` varchar(20) COLLATE utf8_czech_ci NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_czech_ci;

CREATE TABLE `Users` (
  `id` int(11) NOT NULL,
  `active` tinyint(4) NOT NULL DEFAULT 1,
  `login` varchar(150) COLLATE utf8_czech_ci DEFAULT NULL,
  `email` varchar(150) COLLATE utf8_czech_ci DEFAULT NULL,
  `password` varchar(64) COLLATE utf8_czech_ci NOT NULL COMMENT 'Password hash.',
  `salt` varchar(25) COLLATE utf8_czech_ci DEFAULT NULL,
  `registered` datetime NOT NULL,
  `partner` int(11) DEFAULT NULL,
  `partnerId` varchar(50) COLLATE utf8_czech_ci DEFAULT NULL,
  `admin` tinyint(4) NOT NULL DEFAULT 0,
  `partnerAdmin` tinyint(4) NOT NULL DEFAULT 0,
  `blocked` datetime DEFAULT NULL,
  `noNetworkRestriction` date DEFAULT NULL,
  `fullName` varchar(150) COLLATE utf8_czech_ci DEFAULT NULL,
  `address` varchar(255) COLLATE utf8_czech_ci DEFAULT NULL,
  `city` varchar(255) COLLATE utf8_czech_ci DEFAULT NULL,
  `postcode` varchar(8) COLLATE utf8_czech_ci DEFAULT NULL,
  `country` varchar(3) COLLATE utf8_czech_ci NOT NULL DEFAULT 'cz',
  `partnerData` varchar(50) COLLATE utf8_czech_ci DEFAULT NULL,
  `partnerField` varchar(64) COLLATE utf8_czech_ci DEFAULT NULL,
  `phone` varchar(30) COLLATE utf8_czech_ci DEFAULT NULL,
  `tvfee` tinyint(4) DEFAULT 0,
  `parallelStreams` int(11) NOT NULL DEFAULT 2,
  `computedParallelStreams` int(11) NOT NULL DEFAULT 1,
  `streamQuality` int(11) NOT NULL DEFAULT 20,
  `computedStreamQuality` int(11) NOT NULL DEFAULT 30,
  `vlcAllowed` tinyint(4) NOT NULL DEFAULT 1,
  `mobileAllowed` tinyint(4) NOT NULL DEFAULT 1,
  `locked` tinyint(4) NOT NULL DEFAULT 0,
  `lastSessionEnd` int(11) NOT NULL DEFAULT 0,
  `comment` mediumtext COLLATE utf8_czech_ci NOT NULL,
  `removed` timestamp NULL DEFAULT NULL,
  `oldLogin` varchar(150) COLLATE utf8_czech_ci DEFAULT NULL,
  `partnerActivation` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_czech_ci;


ALTER TABLE `ChannelPackageChannels`
  ADD PRIMARY KEY (`package`,`channel`),
  ADD KEY `I_channel` (`channel`);

ALTER TABLE `ChannelPackages`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `shortname` (`shortname`),
  ADD KEY `provider` (`provider`),
  ADD KEY `parent` (`parent`);

ALTER TABLE `Channels`
  ADD PRIMARY KEY (`id`),
  ADD KEY `I_type` (`type`),
  ADD KEY `epgProvider` (`epgProvider`),
  ADD KEY `channelGroup` (`channelGroup`);

ALTER TABLE `Services`
  ADD PRIMARY KEY (`id`),
  ADD KEY `I_user` (`user`),
  ADD KEY `I_partner` (`partner`),
  ADD KEY `I_channelPackage` (`channelPackage`),
  ADD KEY `bundle` (`bundle`),
  ADD KEY `specification` (`specification`),
  ADD KEY `l_channelpackage_from_to` (`channelPackage`,`from`,`to`);

ALTER TABLE `Users`
  ADD PRIMARY KEY (`id`),
  ADD KEY `country` (`country`),
  ADD KEY `I_partner` (`partner`,`partnerId`),
  ADD KEY `login` (`login`);


ALTER TABLE `ChannelPackages`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=92;
ALTER TABLE `Services`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=48;

ALTER TABLE `ChannelPackageChannels`
  ADD CONSTRAINT `ChannelPackageChannels_ibfk_1` FOREIGN KEY (`package`) REFERENCES `ChannelPackages` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `ChannelPackageChannels_ibfk_2` FOREIGN KEY (`channel`) REFERENCES `Channels` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `ChannelPackages`
  ADD CONSTRAINT `ChannelPackages_ibfk_1` FOREIGN KEY (`parent`) REFERENCES `ChannelPackages` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `Services`
  ADD CONSTRAINT `Services_ibfk_1` FOREIGN KEY (`user`) REFERENCES `Users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `Services_ibfk_2` FOREIGN KEY (`channelPackage`) REFERENCES `ChannelPackages` (`id`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
