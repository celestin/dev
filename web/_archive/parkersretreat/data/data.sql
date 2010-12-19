-- phpMyAdmin SQL Dump
-- version 2.6.4-pl4
-- http://www.phpmyadmin.net
-- 
-- Host: localhost
-- Generation Time: Apr 23, 2006 at 09:01 PM
-- Server version: 4.1.16
-- PHP Version: 5.1.1
-- 
-- Database: parkersretreat_co_uk_-_site
-- 
-- $Id$

-- --------------------------------------------------------

-- 
-- Table structure for table member
-- 

CREATE TABLE member (
  memberid varchar(20) NOT NULL default '',
  first_name varchar(25) NOT NULL default '',
  last_name varchar(25) NOT NULL default '',
  email_address varchar(255) default NULL,
  password varchar(50) NOT NULL default '',
  admin int(1) default '0',
  member_type char(2) NOT NULL default 'N',
  verify_code varchar(100) NOT NULL default '',
  active int(1) NOT NULL default '0',
  dob date NOT NULL default '0000-00-00',
  signup_date datetime NOT NULL default '0000-00-00 00:00:00',
  last_login datetime NOT NULL default '0000-00-00 00:00:00',
  PRIMARY KEY  (memberid),
  KEY i_email_address (email_address)
) ENGINE=MyISAM  COMMENT='User Information';

-- 
-- Dumping data for table member
-- 

INSERT INTO member VALUES ('CRAIG', 'Craig', 'McKay', 'craig@southesk.com', '1eebdddd1f688244a5861695cb7c3eba', 1, 'A', '0', 1, '1975-09-13', '0000-00-00 00:00:00', '2006-04-11 19:44:03');

-- --------------------------------------------------------

-- 
-- Table structure for table member_type
-- 

CREATE TABLE member_type (
  member_type char(2) NOT NULL default '',
  type_name varchar(50) default NULL,
  comments varchar(255) default NULL,
  disp_order int(11) NOT NULL default '0',
  PRIMARY KEY  (member_type)
) ENGINE=MyISAM  COMMENT='User Types';

-- 
-- Dumping data for table member_type
-- 

INSERT INTO member_type VALUES ('U', 'User', 'Ability to View all details on the site', 1);
INSERT INTO member_type VALUES ('N', 'New User', 'No permissions yet - waiting verification', 3);
INSERT INTO member_type VALUES ('A', 'Administrator', 'Full Administrative capabilities', 2);

-- --------------------------------------------------------

-- 
-- Table structure for table photos
-- 

CREATE TABLE photos (
  id int(11) NOT NULL auto_increment,
  imgfile varchar(30) NOT NULL default '',
  room_id int(11) NOT NULL default '0',
  default_flag tinyint(4) NOT NULL default '0',
  disporder tinyint(4) default NULL,
  short_text varchar(255) default NULL,
  long_text mediumtext,
  created_by varchar(50) default NULL,
  created_on date default NULL,
  created_at time default NULL,
  updated_by varchar(50) default NULL,
  updated_on date default NULL,
  updated_at time default NULL,
  PRIMARY KEY  (id)
) ENGINE=MyISAM  COMMENT='Photos' AUTO_INCREMENT=22 ;

-- 
-- Dumping data for table photos
-- 

INSERT INTO photos VALUES (1, '01_0.jpg', 1, 1, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO photos VALUES (2, '10_1.jpg', 10, 0, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO photos VALUES (3, '10_2.jpg', 10, 1, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO photos VALUES (4, '11_0.jpg', 11, 1, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO photos VALUES (5, '12_0.jpg', 12, 1, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO photos VALUES (6, '14_0.jpg', 14, 1, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO photos VALUES (7, '15_0.jpg', 15, 1, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO photos VALUES (8, '16_0.jpg', 16, 1, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO photos VALUES (9, '02_0.jpg', 2, 1, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO photos VALUES (10, '03_0.jpg', 3, 1, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO photos VALUES (11, '04_0.jpg', 4, 1, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO photos VALUES (12, '05_1.jpg', 5, 0, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO photos VALUES (13, '05_2.jpg', 5, 1, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO photos VALUES (14, '05_3.jpg', 5, 0, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO photos VALUES (15, '05_4.jpg', 5, 0, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO photos VALUES (16, '05_5.jpg', 5, 0, 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO photos VALUES (17, '06_0.jpg', 6, 1, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO photos VALUES (18, '07_0.jpg', 7, 1, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO photos VALUES (19, '08_0.jpg', 8, 1, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO photos VALUES (20, '09_1.jpg', 9, 0, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO photos VALUES (21, '09_2.jpg', 9, 1, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

-- 
-- Table structure for table rooms
-- 

CREATE TABLE rooms (
  id int(11) NOT NULL auto_increment,
  room_name varchar(50) default NULL,
  tab int(11) default NULL,
  disporder tinyint(4) default NULL,
  short_text varchar(255) default NULL,
  long_text mediumtext,
  panorama varchar(50) default NULL,
  created_by varchar(50) default NULL,
  created_on date default NULL,
  created_at time default NULL,
  updated_by varchar(50) default NULL,
  updated_on date default NULL,
  updated_at time default NULL,
  PRIMARY KEY  (id)
) ENGINE=MyISAM  COMMENT='Rooms' AUTO_INCREMENT=19 ;

-- 
-- Dumping data for table rooms
-- 

INSERT INTO rooms VALUES (1, 'Foxgloves (Bedroom 1)', 2, NULL, 'Charming, pink bedroom with lovely brass bed.', 'This downstairs bedroom with its pink décor creates a warm and comforting feel with its large double brass bed, blanket box, chest of drawers, fitted double wardrobes and cot. North facing window looking out over countryside. Ensuite with bath and integrated bath shower mixer taps.', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO rooms VALUES (2, 'En Suite (to Foxgloves)', 2, NULL, 'Foxgloves Ensuite.', 'Ensuite with bath and integrated bath shower mixer taps.', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO rooms VALUES (3, 'Toilet', 2, NULL, 'Convenient downstairs washroom.', 'Convenient downstairs washroom contains basin and toilet.\r\nLocated in hall between kitchen and utility room.\r\n', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO rooms VALUES (4, 'Utility', 2, NULL, 'Well-appointed, sizable utility room.', 'Contains Belfast sink, freezer, microwave, oil central heating boiler,\r\nWashing machine, tumble dryer laundry facilities.\r\n', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO rooms VALUES (5, 'Kitchen', 2, NULL, 'Large, bright Farmhouse kitchen.', 'Floor to ceiling south facing windows beautifully illuminate this hearty kitchen and dinning area. The solid wood bespoke kitchen units have a central island, which cleverly conceals an integrated dishwasher and fridge and also doubles as a breakfast bar. The large range cooker with six gas burners and two ovens is a culinary wizard’s dream. Cooking gadgets and implements are contained in the deep cupboards that frame the cooker. A large oak dresser contains all crockery, glass and tableware. The enormous oak farmhouse dinning table easily sits ten Simply a gastronome’s dream, a fabulous room to impress family and friends with your food flair. Perfect for flexible entertaining.', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO rooms VALUES (6, 'Downstairs Lounge', 2, NULL, 'A warm comfortable room inviting you to relax', 'A-wash with sunlight during the day. In the evening a large wood burning stove and fabulous thick curtains, plump inviting sofas, T.V and video create the perfect sanctuary to sit and unwind. In the summer months simply open the French windows and walk down onto the garden.', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO rooms VALUES (7, 'Hall', 2, NULL, 'Large welcoming entranceway.', 'This large airy space features a magnificent traditionally built oak staircase. Within the hall a large chest holds your linen for the holiday. An antique dresser contains magazines, books and games for guest’s enjoyment.', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO rooms VALUES (8, 'Porch', 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO rooms VALUES (9, 'Stairs', 2, NULL, 'Magnificent traditionally-built oak staircase.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO rooms VALUES (10, 'Landing', 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO rooms VALUES (11, 'Bluebells (Bedroom 2)', 3, NULL, 'Beautiful blue bedroom with luxurious en suite.', 'Upstairs this charming room decorated in shades of blue provide both a bright and fresh feel, with views across open countryside from its North and West facing windows. A traditional antique Scottish double bed with matching bedside tables, chest of drawers and fitted wardrobe. From here step into the thickly carpeted shower room with large vanity basin, toilet, Matki shower enclosure and fabulous Perrin and Rowe shower. The perfect answer to wash away morning blues.', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO rooms VALUES (12, 'Toilet (ajoining Bluebells)', 3, NULL, 'Shower room and WC.', 'A shower room with large vanity basin, toilet, Matki shower enclosure and fabulous Perrin and Rowe shower.', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO rooms VALUES (14, 'Primroses (Bedroom 3)', 3, NULL, 'Substantial master bedroom.', 'With its East and South facing windows a truly sumptuous room. The largest bedroom, with a double brass bed, side tables, dressing table, fitted wardrobe and chest of drawers. Step into the thickly carpeted en suite with its amazing freestanding bath with shower mixer, large vanity basin and toilet. \r\nA truly elegant room difficult to leave; definitely for grown ups!\r\n', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO rooms VALUES (15, 'Ensuite (to Primroses)', 3, NULL, 'En suite with its lovely freestanding bath.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO rooms VALUES (16, 'Upstairs Lounge', 3, NULL, 'The classic lounge; luxurious and elegant', 'Once more a refreshing bright room; imaginative use of both contemporary furniture and colour scheme create an ambience for more mature relaxing. Its panoramic landscape views and air of tranquillity create a perfect space to sit and reflect.', NULL, NULL, NULL, NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

-- 
-- Table structure for table tabs
-- 

CREATE TABLE tabs (
  id int(11) NOT NULL auto_increment,
  page varchar(20) NOT NULL default '',
  tab varchar(50) default NULL,
  disporder tinyint(4) default NULL,
  created_by varchar(50) default NULL,
  created_on date default NULL,
  created_at time default NULL,
  updated_by varchar(50) default NULL,
  updated_on date default NULL,
  updated_at time default NULL,
  PRIMARY KEY  (id)
) ENGINE=MyISAM  COMMENT='Tabs' AUTO_INCREMENT=5 ;

-- 
-- Dumping data for table tabs
-- 

INSERT INTO tabs VALUES (1, 'index', 'Welcome!', 10, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tabs VALUES (2, 'index', 'Ground&nbsp;floor', 20, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tabs VALUES (3, 'index', 'First&nbsp;floor', 30, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tabs VALUES (4, 'index', 'Pricing&nbsp;&amp;&nbsp;Availability', 40, NULL, NULL, NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

-- 
-- Table structure for table upload
-- 

CREATE TABLE upload (
  uplfile varchar(255) NOT NULL default '',
  docdate date NOT NULL default '0000-00-00',
  doctype char(1) NOT NULL default 'I',
  PRIMARY KEY  (uplfile)
) ENGINE=MyISAM  COMMENT='Uploaded Files';

