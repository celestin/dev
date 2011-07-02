-- --------------------------------------------------------
-- DS Glasscraft
-- Copyright (c) 2007 Front Burner
-- Author Craig McKay <craig@frontburner.co.uk>
--
-- $Id$
--
-- SET PASSWORD FOR 'dsglasscraft'@'localhost' = OLD_PASSWORD('dunc');
-- --------------------------------------------------------
-- phpMyAdmin SQL Dump
-- version 2.10.3
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Jul 02, 2011 at 11:18 AM
-- Server version: 5.0.51
-- PHP Version: 5.2.6

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";

--
-- Database: dsglasscraft_com_-_glass
--

-- --------------------------------------------------------

--
-- Table structure for table category
--

CREATE TABLE category (
  cat varchar(20) NOT NULL default '',
  catName varchar(50) default NULL,
  section int(11) default NULL,
  PRIMARY KEY  (cat),
  KEY CAT_SECTION (section)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COMMENT='Category';

--
-- Dumping data for table category
--

INSERT INTO category VALUES ('BIRD', 'birds', 2);
INSERT INTO category VALUES ('BEAR', 'bears', 2);
INSERT INTO category VALUES ('WATER', 'water', 2);
INSERT INTO category VALUES ('FISH', 'fishing', 2);
INSERT INTO category VALUES ('KFISH', 'kingfishers', 2);
INSERT INTO category VALUES ('BFLY', 'butterflies', 2);
INSERT INTO category VALUES ('CAT', 'cats', 2);
INSERT INTO category VALUES ('PRIMATE', 'primates', 2);
INSERT INTO category VALUES ('WOODLAND', 'woodland', 2);
INSERT INTO category VALUES ('REPTILE', 'reptiles', 2);
INSERT INTO category VALUES ('SAFARI', 'safari', 2);
INSERT INTO category VALUES ('RAPTOR', 'raptors', 2);

-- --------------------------------------------------------

--
-- Table structure for table context
--

CREATE TABLE context (
  section int(11) NOT NULL default '0',
  source varchar(100) NOT NULL default '',
  PRIMARY KEY  (section)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COMMENT='Context';

--
-- Dumping data for table context
--

INSERT INTO context VALUES (1, 'home.php');
INSERT INTO context VALUES (2, '');
INSERT INTO context VALUES (3, 'history.php');
INSERT INTO context VALUES (4, 'links.php');

-- --------------------------------------------------------

--
-- Table structure for table link
--

CREATE TABLE link (
  linkid int(11) NOT NULL auto_increment,
  url varchar(255) NOT NULL default '',
  title varchar(50) NOT NULL default '',
  linkdesc longtext NOT NULL,
  PRIMARY KEY  (linkid)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 COMMENT='Links' AUTO_INCREMENT=10 ;

--
-- Dumping data for table link
--

INSERT INTO link VALUES (1, 'http://www.glassfairs.co.uk/', 'The National Glass Collectors Fair (UK)', 'Britain''s leading antique and collectable glass fair - With a wide choice of\r\nglassware, from 18th Century drinking glasses through to modern Studio Glass.');
INSERT INTO link VALUES (2, 'http://www.glassassociation.org.uk/', 'The Glass Association (UK)', 'The Glass Association was founded to promote the understanding and appreciation of glass and glass-making methods; and to increase public interest in the subject of glass.');
INSERT INTO link VALUES (3, 'http://www.3d2d.co.uk/', '3D/2D Craft & Design Fairs', 'Top organisers for quality fairs in Scotland.\r\n');
INSERT INTO link VALUES (4, 'http://www.craftscotland.org/', 'Craft Scotland', 'Directory of makers, retailers and galleries, promoting the best of Scottish craft locally, nationally and internationally.\r\n');
INSERT INTO link VALUES (5, 'http://www.eclectic-collectables.co.uk/', 'Eclectic Collectables', 'Jim Paterson''s site is a must for collectors of all sorts of Scottish and British collectable items.');
INSERT INTO link VALUES (6, 'http://www.paperweightsplus.com/', 'Paperweights Plus', 'Large selection of paperweights, including some of Dunc''s collaborative weights with John Deacons.\r\n');
INSERT INTO link VALUES (7, 'http://www.wildaboutbritain.co.uk/', 'Wild About Britain', 'Great site for all things in British Wildlife.');
INSERT INTO link VALUES (8, 'http://blairgowriecraftworkers.org.uk/', 'Association of Blairgowrie Craftworkers', 'Members of the Association of Blairgowrie Craftworkers are dedicated to developing creative crafts that truly promote and reflect the traditions and qualities of the Scottish Crafts industry.');
INSERT INTO link VALUES (9, 'http://www.gallowglassbeads.co.uk/', 'Gallow Glass Beads', 'Beautiful handmade glass beads and other information about the fantastic work of Roy and Pat Ayre.');

-- --------------------------------------------------------

--
-- Table structure for table piece
--

CREATE TABLE piece (
  piece varchar(45) NOT NULL,
  cat varchar(100) NOT NULL default '',
  name varchar(255) default '',
  comments varchar(100) default '',
  PRIMARY KEY  (piece),
  KEY PIECE_CAT (cat)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COMMENT='Card';

--
-- Dumping data for table piece
--

INSERT INTO piece VALUES ('bananaquit1', 'BIRD', 'Bananaquit', NULL);
INSERT INTO piece VALUES ('butterfly1', 'BFLY', 'Butterfly', NULL);
INSERT INTO piece VALUES ('butterfly2', 'BFLY', 'Dichroic Butterfly', NULL);
INSERT INTO piece VALUES ('bluejay1', 'BIRD', 'Blue Jay', NULL);
INSERT INTO piece VALUES ('blue_macaw1', 'BIRD', 'Blue Macaw', NULL);
INSERT INTO piece VALUES ('dolphin1', 'WATER', 'Leaping Dolphin', NULL);
INSERT INTO piece VALUES ('eagle1', 'RAPTOR', 'Eagle', NULL);
INSERT INTO piece VALUES ('eagle_fish1', 'RAPTOR', 'Eagle with Fish', NULL);
INSERT INTO piece VALUES ('frog1', 'WATER', 'Frog', NULL);
INSERT INTO piece VALUES ('kingfisher1', 'KFISH', 'Kingfisher', NULL);
INSERT INTO piece VALUES ('koala1', 'BEAR', 'Koala', NULL);
INSERT INTO piece VALUES ('kookaburra1', 'BIRD', 'Kookaburra', NULL);
INSERT INTO piece VALUES ('penguin1', 'WATER', 'Penguins', NULL);
INSERT INTO piece VALUES ('polar_bear1', 'BEAR', 'Polar Bear Family', NULL);
INSERT INTO piece VALUES ('thrush1', 'BIRD', 'Thrush', NULL);
INSERT INTO piece VALUES ('toucan1', 'BIRD', 'Toucan', NULL);
INSERT INTO piece VALUES ('golden_eagle1', 'RAPTOR', 'Golden Eagle', NULL);
INSERT INTO piece VALUES ('dolphin2', 'WATER', 'Dolphin', NULL);
INSERT INTO piece VALUES ('frog2', 'WATER', 'Frog', NULL);
INSERT INTO piece VALUES ('frog3', 'WATER', 'Frog', NULL);
INSERT INTO piece VALUES ('greeb1', 'BIRD', 'Greebs', NULL);
INSERT INTO piece VALUES ('honey_badger1', 'BEAR', 'Honey Badger', NULL);
INSERT INTO piece VALUES ('humbird2', 'BIRD', 'Hummingbird', NULL);
INSERT INTO piece VALUES ('humbird3', 'BIRD', 'Hummingbird', NULL);
INSERT INTO piece VALUES ('humbird_blue1', 'BIRD', 'Blue Hummingbird', NULL);
INSERT INTO piece VALUES ('kingfisher2', 'KFISH', 'Kingfisher', NULL);
INSERT INTO piece VALUES ('kingfisher3', 'KFISH', 'Kingfisher', NULL);
INSERT INTO piece VALUES ('kingfisher4', 'KFISH', 'Kingfisher', NULL);
INSERT INTO piece VALUES ('kingfisher5', 'KFISH', 'Kingfisher', NULL);
INSERT INTO piece VALUES ('kingfisher6', 'KFISH', 'Kingfisher', NULL);
INSERT INTO piece VALUES ('kingfisher7', 'KFISH', 'Kingfisher', NULL);
INSERT INTO piece VALUES ('eagle_fish2', 'RAPTOR', 'Eagle with Fish', '');
INSERT INTO piece VALUES ('otter1', 'WATER', 'Otter', NULL);
INSERT INTO piece VALUES ('owl1', 'RAPTOR', 'Owl', NULL);
INSERT INTO piece VALUES ('owl2', 'RAPTOR', 'Owl', NULL);
INSERT INTO piece VALUES ('owl3', 'RAPTOR', 'Owl', NULL);
INSERT INTO piece VALUES ('owl4', 'RAPTOR', 'Owl', NULL);
INSERT INTO piece VALUES ('owl5', 'RAPTOR', 'Owl', NULL);
INSERT INTO piece VALUES ('owl6', 'RAPTOR', 'Owl', NULL);
INSERT INTO piece VALUES ('panda1', 'BEAR', 'Panda', NULL);
INSERT INTO piece VALUES ('panda2', 'BEAR', 'Panda', NULL);
INSERT INTO piece VALUES ('panda3', 'BEAR', 'Panda', NULL);
INSERT INTO piece VALUES ('pelican1', 'BIRD', 'Pelican', NULL);
INSERT INTO piece VALUES ('polar_bear2', 'BEAR', 'Polar Bear', NULL);
INSERT INTO piece VALUES ('red_cardinal', 'BIRD', 'Red Cardinal', NULL);
INSERT INTO piece VALUES ('sailfish1', 'FISHING', 'Sailfish', NULL);
INSERT INTO piece VALUES ('salmon1', 'FISHING', 'Salmon', NULL);
INSERT INTO piece VALUES ('salmon_fly1', 'FISHING', 'Salmon Fly', NULL);
INSERT INTO piece VALUES ('salmon_fly2', 'FISHING', 'Salmon Fly', NULL);
INSERT INTO piece VALUES ('salmon_fly3', 'FISHING', 'Salmon Fly', NULL);
INSERT INTO piece VALUES ('stellar1', 'RAPTOR', 'Stellar', NULL);
INSERT INTO piece VALUES ('swallow2', 'BIRD', 'Swallow', NULL);
INSERT INTO piece VALUES ('troucan2', 'BIRD', 'Toucan', NULL);
INSERT INTO piece VALUES ('troucan3', 'BIRD', 'Toucan', NULL);
INSERT INTO piece VALUES ('trout1', 'FISHING', 'Trout', NULL);
INSERT INTO piece VALUES ('trout2', 'FISHING', 'Trout', NULL);
INSERT INTO piece VALUES ('trout3', 'FISHING', 'Trout', NULL);
INSERT INTO piece VALUES ('trout4', 'FISHING', 'Trout', NULL);
INSERT INTO piece VALUES ('trout5', 'FISHING', 'Trout', NULL);
INSERT INTO piece VALUES ('trout6', 'FISHING', 'Trout', NULL);
INSERT INTO piece VALUES ('trout7', 'FISHING', 'Trout', NULL);
INSERT INTO piece VALUES ('trout8', 'FISHING', 'Trout', NULL);
INSERT INTO piece VALUES ('wren1', 'BIRD', 'Wren', NULL);
INSERT INTO piece VALUES ('frog4', 'WATER', 'Frogs', '');
INSERT INTO piece VALUES ('frog5', 'WATER', 'Frogs', '');
INSERT INTO piece VALUES ('penguin2', 'WATER', 'Playful Puffins', '');
INSERT INTO piece VALUES ('ylw_blckbird1', 'BIRD', 'Yellow-headed Blackbird', '');
INSERT INTO piece VALUES ('bluetits_house1', 'BIRD', 'Blue Tits with Heather on Sign with House Name', '');
INSERT INTO piece VALUES ('bee_eaters1', 'BIRD', 'Bee Eaters', '');
INSERT INTO piece VALUES ('buzzard1', 'RAPTOR', 'Buzzard', '');
INSERT INTO piece VALUES ('cheetah1', 'CAT', 'Cheetah and Cub', '');
INSERT INTO piece VALUES ('cheetah2', 'CAT', 'Cheetah chasing Gazelle', '');
INSERT INTO piece VALUES ('dippers1', 'BIRD', 'Dippers', '');
INSERT INTO piece VALUES ('dragonfly1', 'BFLY', 'Dragonfly', '');
INSERT INTO piece VALUES ('heron1', 'BIRD', 'Heron - No Fishing!', '');
INSERT INTO piece VALUES ('kingfisher8', 'KFISH', 'Kingfisher (2006)', '');
INSERT INTO piece VALUES ('lemurs1', 'PRIMATE', 'Lemurs', '');
INSERT INTO piece VALUES ('leopard1', 'CAT', 'Leopard', '');
INSERT INTO piece VALUES ('redadmiral1', 'BFLY', 'Red Admiral Butterfly', '');
INSERT INTO piece VALUES ('robin1', 'BIRD', 'Robin on Silver Birch', '');
INSERT INTO piece VALUES ('cockatoo1', 'BIRD', 'Umbrella Cockatoo', '');
INSERT INTO piece VALUES ('heron2', 'BIRD', 'Whinny Loch Commission, Heron with Name Sign', '');
INSERT INTO piece VALUES ('seaeagle1', 'RAPTOR', 'White Tailed Sea Eagle', '');
INSERT INTO piece VALUES ('badger', 'WOODLAND', 'Badger', '');
INSERT INTO piece VALUES ('cheetah_chasing_gazelle', 'CAT', 'Cheetah chasing Gazelle', '');
INSERT INTO piece VALUES ('emperorpenguin_chick2', 'BIRD', 'Emperor Penguin with Chick', '');
INSERT INTO piece VALUES ('emperorpenguin_chick1', 'BIRD', 'Emperor Penguin with Chick', '');
INSERT INTO piece VALUES ('emperorpenguins_chick3', 'BIRD', 'Emperor Penguins with Chick', '');
INSERT INTO piece VALUES ('fighting_ringtailedlemurs', 'PRIMATE', 'Fighting Ring-Tailed Lemurs', '');
INSERT INTO piece VALUES ('gannets', 'BIRD', 'Gannets', '');
INSERT INTO piece VALUES ('golden_eagle3', 'RAPTOR', 'Golden Eagle 2', '');
INSERT INTO piece VALUES ('golden_eagle2', 'RAPTOR', 'Golden Eagle 1', '');
INSERT INTO piece VALUES ('goldfish', 'FISH', 'Goldfish', '');
INSERT INTO piece VALUES ('hummingbird_blue', 'BIRD', 'Blue Humming Bird', '');
INSERT INTO piece VALUES ('kingfisher_frog', 'KFISH', 'Kingfisher with Frog', '');
INSERT INTO piece VALUES ('leopardgecko', 'REPTILE', 'Leopard Gecko', '');
INSERT INTO piece VALUES ('otters', 'WATER', 'Otters', '');
INSERT INTO piece VALUES ('puffins_clifftop2', 'BIRD', 'Puffins on Clifftop 2', '');
INSERT INTO piece VALUES ('puffins_clifftop1', 'BIRD', 'Puffins on Clifftop 1', '');
INSERT INTO piece VALUES ('redcardinal_holly', 'BIRD', 'Red Cardinal with Holly', '');
INSERT INTO piece VALUES ('scarlet_macaws', 'BIRD', 'Scarlet Macaws', '');
INSERT INTO piece VALUES ('seaeagle_catching_fish', 'RAPTOR', 'Sea Eagle catching fish', '');
INSERT INTO piece VALUES ('snowyowl', 'RAPTOR', 'Snowy Owl', '');
INSERT INTO piece VALUES ('tiger', 'CAT', 'Tiger', '');
INSERT INTO piece VALUES ('andean_bear', 'BEAR', 'Andean or Spectacled Bear', '');
INSERT INTO piece VALUES ('blue_butterfly', 'BFLY', 'Blue Butterfly', '');
INSERT INTO piece VALUES ('yellow_black_butterfly', 'BFLY', 'Yellow & Black Butterfly', '');
INSERT INTO piece VALUES ('capercaillie', 'BIRD', 'Capercaillie', '');
INSERT INTO piece VALUES ('cheetah_running', 'CAT', 'Running Cheetah', '');
INSERT INTO piece VALUES ('cheetah_walking', 'CAT', 'Walking Cheetah', '');
INSERT INTO piece VALUES ('clown_fish_anemone', 'FISH', 'Clown Fish & Anemone', '');
INSERT INTO piece VALUES ('clown_fish_pair', 'FISH', 'Pair of Clown Fish', '');
INSERT INTO piece VALUES ('fishing_fly', 'FISHING', 'Fishing Fly', '');
INSERT INTO piece VALUES ('frogs_waterfall', 'WATER', 'Frogs & Waterfall', '');
INSERT INTO piece VALUES ('golden_damselfish_blue_tang', 'FISH', 'Golden Damselfish & Blue Tang', '');
INSERT INTO piece VALUES ('golden_damselfish_pair', 'FISH', 'Pair of Golden Damselfish', '');
INSERT INTO piece VALUES ('golden_damselfish1', 'FISH', 'Golden Damselfish 1', '');
INSERT INTO piece VALUES ('golden_damselfish2', 'FISH', 'Golden Damselfish 2', '');
INSERT INTO piece VALUES ('orangutan', 'PRIMATE', 'Orang-utan', '');
INSERT INTO piece VALUES ('reef_fish', 'FISH', 'Reef Fish', '');
INSERT INTO piece VALUES ('sea_trout', 'FISHING', 'Sea Trout', '');
INSERT INTO piece VALUES ('seahorse_amber', 'FISH', 'Amber Seahorse', '');
INSERT INTO piece VALUES ('seahorse_green', 'FISH', 'Green Seahorse', '');
INSERT INTO piece VALUES ('seahorse_ruby', 'FISH', 'Ruby Seahorse', '');
INSERT INTO piece VALUES ('avocet2', 'BIRD', 'Avocet', '');
INSERT INTO piece VALUES ('avocet3', 'BIRD', 'Avocet', '');
INSERT INTO piece VALUES ('avocets1', 'BIRD', 'Avocets', '');
INSERT INTO piece VALUES ('goldfinch1', 'BIRD', 'Goldfinch on Broom', '');
INSERT INTO piece VALUES ('osprey1', 'RAPTOR', 'Osprey', '');
INSERT INTO piece VALUES ('pheasant1', 'BIRD', 'Pheasant', '');
INSERT INTO piece VALUES ('scarlet_macaw2', 'BIRD', 'Scarlet Macaw', '');
INSERT INTO piece VALUES ('belted_kingfishers1', 'KFISH', 'Belted Kingfishers', '');
INSERT INTO piece VALUES ('lemurs2', 'PRIMATE', 'Ring-tailed Lemur Family', '');
INSERT INTO piece VALUES ('bearded_dragon1', 'REPTILE', 'Bearded Dragon', '');
INSERT INTO piece VALUES ('zebras1', 'SAFARI', 'Zebras', '');
INSERT INTO piece VALUES ('frog7', 'WATER', 'Frog', '');
INSERT INTO piece VALUES ('frog8', 'WATER', 'Frog', '');
INSERT INTO piece VALUES ('hare1', 'WOODLAND', 'Hare', '');
INSERT INTO piece VALUES ('hare2', 'WOODLAND', 'Hare', '');

-- --------------------------------------------------------

--
-- Table structure for table section
--

CREATE TABLE section (
  section int(11) NOT NULL default '0',
  secName varchar(100) NOT NULL default '',
  sortOrder int(11) NOT NULL default '0',
  menu varchar(100) default '',
  PRIMARY KEY  (section)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COMMENT='Section';

--
-- Dumping data for table section
--

INSERT INTO section VALUES (1, 'home', 10, NULL);
INSERT INTO section VALUES (2, 'collectable pieces', 20, 'P');
INSERT INTO section VALUES (4, 'links', 30, NULL);
