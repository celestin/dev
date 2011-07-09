-- --------------------------------------------------------
-- Relaxatub
-- Copyright (c) 2006,2010 Frontburner
-- Author Craig McKay <craig@frontburner.co.uk>
--
-- $Id$
--
-- --------------------------------------------------------
-- Database Diff
--
-- Who  When         Why
-- CAM  08-Jul-2011  10984 : Added Quickship for 2011.
-- --------------------------------------------------------

INSERT INTO `product` VALUES (1020, '578-BHE', '578 (BHE) Hybrid', 'Q', NULL);

DROP TABLE IF EXISTS quickship;
CREATE TABLE quickship (
  qsid int(11) NOT NULL auto_increment,
  qscode varchar(20) character set latin1 NOT NULL,
  pid int(11) NOT NULL,
  acrylic_colour varchar(30) character set latin1 NOT NULL,
  cabinet_colour varchar(30) character set latin1 NOT NULL,
  heatshield_colour varchar(30) character set latin1 NOT NULL,
  seats varchar(12) character set latin1 NOT NULL,
  tub int(11) NOT NULL,
  tubtype varchar(20) character set latin1 NOT NULL,
  price_rrp double NOT NULL,
  deposit double NOT NULL,
  PRIMARY KEY  (qsid)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='Quickship (Products)' AUTO_INCREMENT=2012;

--
-- Dumping data for table quickship
--

INSERT INTO quickship VALUES (2001, '321', 1001, 'opal', 'bamboo', 'tan', '4 - 5', 321, 'LEEP', 4495, 899);
INSERT INTO quickship VALUES (2002, '340', 1002, 'opal', 'ebony_enviro', 'steel', '5', 340, 'LEEP', 4995, 999);
INSERT INTO quickship VALUES (2003, '350QS', 1003, 'alabaster', 'ebony_enviro', 'steel', '6', 350, 'LEEP', 5625, 1125);
INSERT INTO quickship VALUES (2004, '350QS', 1004, 'quartzite', 'walnut_enviro', 'tan', '6', 350, 'BHE', 6165, 1233);
INSERT INTO quickship VALUES (2005, '360QS', 1005, 'alabaster', 'walnut_enviro', 'tan', '6 + 1', 360, 'LEEP', 5625, 1125);
INSERT INTO quickship VALUES (2006, '360QS', 1006, 'palladium', 'ebony_enviro', 'steel', '6 + 1', 360, 'BHE', 6165, 1233);
INSERT INTO quickship VALUES (2007, '380QS', 1007, 'opal', 'walnut_enviro', 'tan', '7 + 1', 380, 'BHE', 6695, 1339);
INSERT INTO quickship VALUES (2008, '550QS', 1008, 'quartzite', 'walnut_enviro', 'tan', '6 + 2', 550, 'BHE', 7995, 1599);
INSERT INTO quickship VALUES (2009, '725QS', 1009, 'alabaster', 'ebony_enviro', 'steel', '6 + 1', 725, 'BHE', 8735, 1747);
INSERT INTO quickship VALUES (2010, '750QS', 1010, 'palladium', 'ebony_enviro', 'steel', '8 + 1', 750, 'BHE', 11595, 2319);
INSERT INTO quickship VALUES (2011, '578', 1020, 'palladium', 'ebony_enviro', 'steel', '', 578, 'BHE', 0, 0);

