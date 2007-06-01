-- --------------------------------------------------------
-- DS Glasscraft
-- Copyright (c) 2007 Front Burner
-- Author Craig McKay <craig@frontburner.co.uk>
--
-- $Id: data.sql 387 2007-02-13 23:42:52Z craig $
--
-- SET PASSWORD FOR 'dsglasscraft'@'localhost' = OLD_PASSWORD('dunc');
-- --------------------------------------------------------
-- phpMyAdmin SQL Dump
-- version 2.9.0.2
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Apr 03, 2007 at 04:45 PM
-- Server version: 4.1.22
-- PHP Version: 5.1.6
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
INSERT INTO category VALUES ('OWL', 'owls', 2);
INSERT INTO category VALUES ('BFLY', 'butterflies', 2);
INSERT INTO category VALUES ('CAT', 'cats', 2);
INSERT INTO category VALUES ('PRIMATE', 'primates', 2);

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
-- Table structure for table help_text
--

CREATE TABLE help_text (
  help_id varchar(20) NOT NULL default '',
  help_text longtext NOT NULL,
  PRIMARY KEY  (help_id)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COMMENT='Help Text';

--
-- Dumping data for table help_text
--

INSERT INTO help_text VALUES ('ocarddate', 'The date with which the card corresponds.  For instance, if it''s a birthday, enter the date the birthday occurs this year.  For Wedding cards, enter the Wedding day.  A leaving card might have the date someone leaves the company.  If there is no meaningful date, such as a ''Get Well Soon'', just enter the date you need the card by.');
INSERT INTO help_text VALUES ('oreqdate', 'The date by which you must have the card in your hands!');
INSERT INTO help_text VALUES ('oyears', 'For a Birthday, Anniversary, etc., use this field to specify how many years the card represents.');
INSERT INTO help_text VALUES ('otitle', 'Use this to specify a title on the card, e.g. ''So long Amy and fair well''');

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
-- Table structure for table neworder
--

CREATE TABLE neworder (
  orderid int(11) NOT NULL auto_increment,
  name varchar(40) NOT NULL default '',
  email varchar(40) NOT NULL default '',
  tel varchar(40) NOT NULL default '',
  rcpt varchar(40) NOT NULL default '',
  carddate date NOT NULL default '0000-00-00',
  reqdate date NOT NULL default '0000-00-00',
  cat varchar(5) NOT NULL default 'BIR',
  years int(11) default NULL,
  title varchar(255) NOT NULL default '',
  description longtext NOT NULL,
  orderdate date NOT NULL default '0000-00-00',
  PRIMARY KEY  (orderid)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 COMMENT='Order' AUTO_INCREMENT=21 ;

--
-- Dumping data for table neworder
--

INSERT INTO neworder VALUES (7, 'Tracy Ingram', 'Tracy.Ingram@shell.com', '0779 686 5925', 'Stephen Birse', '0000-00-00', '0000-00-00', 'BIR', 30, '"To my soul mate - Happy 30th Birthday!"', 'Stephen is a very keen golfer, just recently won his first golf open medal on a 3 day competition.  He also loves football. He''s away to start a gardening business, he loves designer clothes and accessories especially "Lacoste".', '2004-08-20');
INSERT INTO neworder VALUES (8, 'Tracy Ingram', 'Tracy.Ingram@shell.com', '0779 686 5925', 'Gerry Ingram', '0000-00-00', '0000-00-00', 'BIR', 0, '"Happy Birthday to My Best Big Bro"', 'Gerry''s passions are sports cars and Football.  He has a yellow Lotus Elise and his other favourite car is a Mark I Golf GTi. He is an avid "Dons" Supporter (Aberdeen) and has been since he can remember.  His other passions are his children - Anna and Jamie and of course wife Kerri.  He is also into designer named clothes in a big way - loves Burberry and Fred Perry.  (He''s 36 on his b''day although this doesn''t need to go on the card).', '2004-08-20');
INSERT INTO neworder VALUES (19, '', '', '', '', '2004-09-03', '2004-09-03', '', 0, '', '', '2004-09-03');
INSERT INTO neworder VALUES (20, '', '', '', '', '2004-09-03', '2004-09-03', '', 0, '', '', '2004-09-03');

-- --------------------------------------------------------

--
-- Table structure for table piece
--

CREATE TABLE piece (
  piece varchar(15) NOT NULL default '',
  cat varchar(100) NOT NULL default '',
  name varchar(255) default '',
  comments varchar(100) default '',
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
INSERT INTO piece VALUES ('eagle1', 'BIRD', 'Eagle', NULL);
INSERT INTO piece VALUES ('eagle_fish1', 'BIRD', 'Eagle with Fish', NULL);
INSERT INTO piece VALUES ('frog1', 'WATER', 'Frog', NULL);
INSERT INTO piece VALUES ('kingfisher1', 'KFISH', 'Kingfisher', NULL);
INSERT INTO piece VALUES ('koala1', 'BEAR', 'Koala', NULL);
INSERT INTO piece VALUES ('kookaburra1', 'BIRD', 'Kookaburra', NULL);
INSERT INTO piece VALUES ('penguin1', 'WATER', 'Penguins', NULL);
INSERT INTO piece VALUES ('polar_bear1', 'BEAR', 'Polar Bear Family', NULL);
INSERT INTO piece VALUES ('thrush1', 'BIRD', 'Thrush', NULL);
INSERT INTO piece VALUES ('toucan1', 'BIRD', 'Toucan', NULL);
INSERT INTO piece VALUES ('golden_eagle1', 'BIRD', 'Golden Eagle', NULL);
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
INSERT INTO piece VALUES ('eagle_fish2', 'BIRD', 'Eagle with Fish', '');
INSERT INTO piece VALUES ('otter1', 'WATER', 'Otter', NULL);
INSERT INTO piece VALUES ('owl1', 'OWL', 'Owl', NULL);
INSERT INTO piece VALUES ('owl2', 'OWL', 'Owl', NULL);
INSERT INTO piece VALUES ('owl3', 'OWL', 'Owl', NULL);
INSERT INTO piece VALUES ('owl4', 'OWL', 'Owl', NULL);
INSERT INTO piece VALUES ('owl5', 'OWL', 'Owl', NULL);
INSERT INTO piece VALUES ('owl6', 'OWL', 'Owl', NULL);
INSERT INTO piece VALUES ('panda1', 'BEAR', 'Panda', NULL);
INSERT INTO piece VALUES ('panda2', 'BEAR', 'Panda', NULL);
INSERT INTO piece VALUES ('panda3', 'BEAR', 'Panda', NULL);
INSERT INTO piece VALUES ('pelican1', 'BIRD', 'Pelican', NULL);
INSERT INTO piece VALUES ('polar_bear2', 'BEAR', 'Polar Bear', NULL);
INSERT INTO piece VALUES ('red_cardinal', 'BIRD', 'Red Cardinal', NULL);
INSERT INTO piece VALUES ('sailfish1', 'FISH', 'Sailfish', NULL);
INSERT INTO piece VALUES ('salmon1', 'FISH', 'Salmon', NULL);
INSERT INTO piece VALUES ('salmon_fly1', 'FISH', 'Salmon Fly', NULL);
INSERT INTO piece VALUES ('salmon_fly2', 'FISH', 'Salmon Fly', NULL);
INSERT INTO piece VALUES ('salmon_fly3', 'FISH', 'Salmon Fly', NULL);
INSERT INTO piece VALUES ('stellar1', 'BIRD', 'Stellar', NULL);
INSERT INTO piece VALUES ('swallow2', 'BIRD', 'Swallow', NULL);
INSERT INTO piece VALUES ('troucan2', 'BIRD', 'Toucan', NULL);
INSERT INTO piece VALUES ('troucan3', 'BIRD', 'Toucan', NULL);
INSERT INTO piece VALUES ('trout1', 'FISH', 'Trout', NULL);
INSERT INTO piece VALUES ('trout2', 'FISH', 'Trout', NULL);
INSERT INTO piece VALUES ('trout3', 'FISH', 'Trout', NULL);
INSERT INTO piece VALUES ('trout4', 'FISH', 'Trout', NULL);
INSERT INTO piece VALUES ('trout5', 'FISH', 'Trout', NULL);
INSERT INTO piece VALUES ('trout6', 'FISH', 'Trout', NULL);
INSERT INTO piece VALUES ('trout7', 'FISH', 'Trout', NULL);
INSERT INTO piece VALUES ('trout8', 'FISH', 'Trout', NULL);
INSERT INTO piece VALUES ('wren1', 'BIRD', 'Wren', NULL);
INSERT INTO piece VALUES ('frog4', 'WATER', 'Frogs', '');
INSERT INTO piece VALUES ('frog5', 'WATER', 'Frogs', '');
INSERT INTO piece VALUES ('penguin2', 'WATER', 'Playful Puffins', '');
INSERT INTO piece VALUES ('ylw_blckbird1', 'BIRD', 'Yellow-headed Blackbird', '');
INSERT INTO piece VALUES ('bluetits_house1', 'BIRD', 'Blue Tits with Heather on Sign with House Name', '');
INSERT INTO piece VALUES ('bee_eaters1', 'BIRD', 'Bee Eaters', '');
INSERT INTO piece VALUES ('buzzard1', 'BIRD', 'Buzzard', '');
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
INSERT INTO piece VALUES ('seaeagle1', 'BIRD', 'White Tailed Sea Eagle', '');

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