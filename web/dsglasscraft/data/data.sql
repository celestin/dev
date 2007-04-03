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
-- version 2.8.2
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Apr 03, 2007 at 03:29 PM
-- Server version: 4.1.20
-- PHP Version: 4.4.2
--
-- Database: dsglasscraft_com_-_glass
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

INSERT INTO category (cat, catName, section) VALUES ('BIRD', 'birds', 2),
('BEAR', 'bears', 2),
('WATER', 'water', 2),
('FISH', 'fishing', 2),
('KFISH', 'kingfishers', 2),
('OWL', 'owls', 2),
('BFLY', 'butterflies', 2);

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

INSERT INTO context (section, source) VALUES (1, 'home.php'),
(2, ''),
(3, 'history.php'),
(4, 'links.php');

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

INSERT INTO help_text (help_id, help_text) VALUES ('ocarddate', 'The date with which the card corresponds.  For instance, if it''s a birthday, enter the date the birthday occurs this year.  For Wedding cards, enter the Wedding day.  A leaving card might have the date someone leaves the company.  If there is no meaningful date, such as a ''Get Well Soon'', just enter the date you need the card by.'),
('oreqdate', 'The date by which you must have the card in your hands!'),
('oyears', 'For a Birthday, Anniversary, etc., use this field to specify how many years the card represents.'),
('otitle', 'Use this to specify a title on the card, e.g. ''So long Amy and fair well''');

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
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COMMENT='Links' AUTO_INCREMENT=7 ;

--
-- Dumping data for table link
--

INSERT INTO link (linkid, url, title, linkdesc) VALUES (1, 'http://www.glassfairs.co.uk/', 'The National Glass Collectors Fair (UK)', 'Britain''s leading antique and collectable glass fair - With a wide choice of\r\nglassware, from 18th Century drinking glasses through to modern Studio Glass.'),
(2, 'http://www.glassassociation.org.uk/', 'The Glass Association (UK)', 'The Glass Association was founded to promote the understanding and appreciation of glass and glass-making methods; and to increase public interest in the subject of glass.'),
(3, 'http://www.3d2d.co.uk/', '3D/2D Craft & Design Fairs', 'Top organisers for quality fairs in Scotland.\r\n'),
(4, 'http://www.craftscotland.org/', 'Craft Scotland', 'Directory of makers, retailers and galleries, promoting the best of Scottish craft locally, nationally and internationally.\r\n'),
(5, 'http://www.eclectic-collectables.co.uk/', 'Eclectic Collectables', 'Jim Paterson’s site is a must for collectors of all sorts of Scottish and British collectable items.'),
(6, 'http://www.paperweightsplus.com/', 'Paperweights Plus', 'Large selection of paperweights, including some of Dunc’s collaborative weights with John \r\nDeacons.\r\n');

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
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COMMENT='Order' AUTO_INCREMENT=21 ;

--
-- Dumping data for table neworder
--

INSERT INTO neworder (orderid, name, email, tel, rcpt, carddate, reqdate, cat, years, title, description, orderdate) VALUES (7, 'Tracy Ingram', 'Tracy.Ingram@shell.com', '0779 686 5925', 'Stephen Birse', '0000-00-00', '0000-00-00', 'BIR', 30, '"To my soul mate - Happy 30th Birthday!"', 'Stephen is a very keen golfer, just recently won his first golf open medal on a 3 day competition.  He also loves football. He''s away to start a gardening business, he loves designer clothes and accessories especially "Lacoste".', '2004-08-20'),
(8, 'Tracy Ingram', 'Tracy.Ingram@shell.com', '0779 686 5925', 'Gerry Ingram', '0000-00-00', '0000-00-00', 'BIR', 0, '"Happy Birthday to My Best Big Bro"', 'Gerry''s passions are sports cars and Football.  He has a yellow Lotus Elise and his other favourite car is a Mark I Golf GTi. He is an avid "Dons" Supporter (Aberdeen) and has been since he can remember.  His other passions are his children - Anna and Jamie and of course wife Kerri.  He is also into designer named clothes in a big way - loves Burberry and Fred Perry.  (He''s 36 on his b''day although this doesn''t need to go on the card).', '2004-08-20'),
(19, '', '', '', '', '2004-09-03', '2004-09-03', '', 0, '', '', '2004-09-03'),
(20, '', '', '', '', '2004-09-03', '2004-09-03', '', 0, '', '', '2004-09-03');

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

INSERT INTO piece (piece, cat, name, comments) VALUES ('bananaquit1', 'BIRD', 'Bananaquit', NULL),
('butterfly1', 'BFLY', 'Butterfly', NULL),
('butterfly2', 'BFLY', 'Dichroic Butterfly', NULL),
('bluejay1', 'BIRD', 'Blue Jay', NULL),
('blue_macaw1', 'BIRD', 'Blue Macaw', NULL),
('dolphin1', 'WATER', 'Leaping Dolphin', NULL),
('eagle1', 'BIRD', 'Eagle', NULL),
('eagle_fish1', 'BIRD', 'Eagle with Fish', NULL),
('frog1', 'WATER', 'Frog', NULL),
('kingfisher1', 'KFISH', 'Kingfisher', NULL),
('koala1', 'BEAR', 'Koala', NULL),
('kookaburra1', 'BIRD', 'Kookaburra', NULL),
('penguin1', 'WATER', 'Penguins', NULL),
('polar_bear1', 'BEAR', 'Polar Bear Family', NULL),
('thrush1', 'BIRD', 'Thrush', NULL),
('toucan1', 'BIRD', 'Toucan', NULL),
('golden_eagle1', 'BIRD', 'Golden Eagle', NULL),
('dolphin2', 'WATER', 'Dolphin', NULL),
('frog2', 'WATER', 'Frog', NULL),
('frog3', 'WATER', 'Frog', NULL),
('greeb1', 'BIRD', 'Greebs', NULL),
('honey_badger1', 'BEAR', 'Honey Badger', NULL),
('humbird2', 'BIRD', 'Hummingbird', NULL),
('humbird3', 'BIRD', 'Hummingbird', NULL),
('humbird_blue1', 'BIRD', 'Blue Hummingbird', NULL),
('kingfisher2', 'KFISH', 'Kingfisher', NULL),
('kingfisher3', 'KFISH', 'Kingfisher', NULL),
('kingfisher4', 'KFISH', 'Kingfisher', NULL),
('kingfisher5', 'KFISH', 'Kingfisher', NULL),
('kingfisher6', 'KFISH', 'Kingfisher', NULL),
('kingfisher7', 'KFISH', 'Kingfisher', NULL),
('eagle_fish2', 'BIRD', 'Eagle with Fish', ''),
('otter1', 'WATER', 'Otter', NULL),
('owl1', 'OWL', 'Owl', NULL),
('owl2', 'OWL', 'Owl', NULL),
('owl3', 'OWL', 'Owl', NULL),
('owl4', 'OWL', 'Owl', NULL),
('owl5', 'OWL', 'Owl', NULL),
('owl6', 'OWL', 'Owl', NULL),
('panda1', 'BEAR', 'Panda', NULL),
('panda2', 'BEAR', 'Panda', NULL),
('panda3', 'BEAR', 'Panda', NULL),
('pelican1', 'BIRD', 'Pelican', NULL),
('polar_bear2', 'BEAR', 'Polar Bear', NULL),
('red_cardinal', 'BIRD', 'Red Cardinal', NULL),
('sailfish1', 'FISH', 'Sailfish', NULL),
('salmon1', 'FISH', 'Salmon', NULL),
('salmon_fly1', 'FISH', 'Salmon Fly', NULL),
('salmon_fly2', 'FISH', 'Salmon Fly', NULL),
('salmon_fly3', 'FISH', 'Salmon Fly', NULL),
('stellar1', 'BIRD', 'Stellar', NULL),
('swallow2', 'BIRD', 'Swallow', NULL),
('troucan2', 'BIRD', 'Toucan', NULL),
('troucan3', 'BIRD', 'Toucan', NULL),
('trout1', 'FISH', 'Trout', NULL),
('trout2', 'FISH', 'Trout', NULL),
('trout3', 'FISH', 'Trout', NULL),
('trout4', 'FISH', 'Trout', NULL),
('trout5', 'FISH', 'Trout', NULL),
('trout6', 'FISH', 'Trout', NULL),
('trout7', 'FISH', 'Trout', NULL),
('trout8', 'FISH', 'Trout', NULL),
('wren1', 'BIRD', 'Wren', NULL),
('frog4', 'WATER', 'Frogs', ''),
('frog5', 'WATER', 'Frogs', ''),
('penguin2', 'WATER', 'Playful Penguins', ''),
('ylw_blckbird1', 'BIRD', 'Yellow-headed Blackbird', '');

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

INSERT INTO section (section, secName, sortOrder, menu) VALUES (1, 'home', 10, NULL),
(2, 'collectable pieces', 20, 'P'),
(4, 'links', 30, NULL);
