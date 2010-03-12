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
-- CAM  12-Mar-2010  10604 : Added product and quickship.
-- --------------------------------------------------------

CREATE TABLE product (
  pid int(11) NOT NULL auto_increment,
  pcode varchar(20) NOT NULL,
  pdescription varchar(100) default NULL,
  ptype char(1) NOT NULL COMMENT 'Product Type: A - Accessory, C - Aftercare, Q - Quickship Tub',
  paypal_button_id varchar(20) default NULL,
  PRIMARY KEY  (pid)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='Quickship (Products)' AUTO_INCREMENT=1011 ;

-- 
-- Dumping data for table product
-- 

INSERT INTO product VALUES (1001, '321-ISP', '321 (ISP) Portable', 'Q', 'WFAMAAEJHY6J4');
INSERT INTO product VALUES (1002, '340-ISP', '340 (ISP) Portable', 'Q', 'PHMQ5RXGXWWPJ');
INSERT INTO product VALUES (1003, '350QS-LEEP', '350 (LEEP) Portable', 'Q', 'VF47SDA8FY3TC');
INSERT INTO product VALUES (1004, '350QS-BHE', '350 (BHE) Hybrid', 'Q', '2C5GJY7YR3SZW');
INSERT INTO product VALUES (1005, '360QS-LEEP', '360 (LEEP) Portable', 'Q', 'BTNA3DCB6WR5U');
INSERT INTO product VALUES (1006, '360QS-BHE', '360 (BHE) Hybrid', 'Q', 'CBHW25HKHZ8VC');
INSERT INTO product VALUES (1007, '380QS-BHE', '380 (BHE) Hybrid', 'Q', 'ZCPJG2YTBM4UY');
INSERT INTO product VALUES (1008, '550QS-BHE', '550 (BHE) Hybrid', 'Q', '6FB7ZLDVLF422');
INSERT INTO product VALUES (1009, '725QS-BHE', '725 (BHE) Hybrid', 'Q', '6YSJU9WDB3DVW');
INSERT INTO product VALUES (1010, '750QS-BHE', '750 (BHE) Hybrid', 'Q', 'TW2QEB7NXKSRG');

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
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='Quickship (Products)' AUTO_INCREMENT=2011 ;

-- 
-- Dumping data for table quickship
-- 

INSERT INTO quickship VALUES (2001, '321', 1001, 'atlantis', 'bamboo', 'tan', '4 - 5', 321, 'ISP', 4495, 899);
INSERT INTO quickship VALUES (2002, '340', 1002, 'opal', 'ebony_enviro', 'steel', '5', 340, 'ISP', 4995, 999);
INSERT INTO quickship VALUES (2003, '350QS', 1003, 'alabaster', 'ebony_enviro', 'steel', '6', 350, 'LEEP', 5625, 1125);
INSERT INTO quickship VALUES (2004, '350QS', 1004, 'quartzite', 'walnut_enviro', 'tan', '6', 350, 'BHE', 6165, 1233);
INSERT INTO quickship VALUES (2005, '360QS', 1005, 'quartzite', 'walnut_enviro', 'tan', '6 + 1', 360, 'LEEP', 5625, 1125);
INSERT INTO quickship VALUES (2006, '360QS', 1006, 'alabaster', 'ebony_enviro', 'steel', '6 + 1', 360, 'BHE', 6165, 1233);
INSERT INTO quickship VALUES (2007, '380QS', 1007, 'quartzite', 'bamboo', 'tan', '7 + 1', 380, 'BHE', 6695, 1339);
INSERT INTO quickship VALUES (2008, '550QS', 1008, 'opal', 'ebony_enviro', 'steel', '6 + 2', 550, 'BHE', 7995, 1599);
INSERT INTO quickship VALUES (2009, '725QS', 1009, 'alabaster', 'walnut_enviro', 'tan', '6 + 1', 725, 'BHE', 8735, 1747);
INSERT INTO quickship VALUES (2010, '750QS', 1010, 'alabaster', 'walnut_enviro', 'tan', '8 + 1', 750, 'BHE', 11595, 2319);

