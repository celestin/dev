-- --------------------------------------------------------
-- West Coast Express
-- Copyright (c) 2006-2007 Frontburner
-- Author Craig McKay <craig@frontburner.co.uk>
--
-- $Id$
-- --------------------------------------------------------
-- phpMyAdmin SQL Dump
-- version 2.9.2
-- http://www.phpmyadmin.net
-- 
-- Host: localhost
-- Generation Time: Aug 11, 2007 at 11:36 AM
-- Server version: 5.0.27
-- PHP Version: 4.4.5
-- 
-- Database: westcoastexpress_net_-_site
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
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COMMENT='User Information';

-- 
-- Dumping data for table member
-- 

INSERT INTO member VALUES ('CRAIG', 'Craig', 'McKay', 'craig@southesk.com', '0954bfb4e59e3d85ff989944a65f6955', 1, 'A', '0', 1, '1975-09-13', '0000-00-00 00:00:00', '2007-08-11 11:19:47');
INSERT INTO member VALUES ('BOB', 'Bob', 'Bain', '', 'b193cacd08f36cfa4f0c165a48255497', 1, 'A', '0', 1, '1950-01-01', '0000-00-00 00:00:00', '2007-02-03 08:06:43');

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
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COMMENT='User Types';

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
  photo varchar(100) NOT NULL default '',
  boat varchar(100) NOT NULL default '',
  location mediumtext NOT NULL,
  disporder int(11) NOT NULL default '0',
  PRIMARY KEY  (id)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 COMMENT='Photo Gallery' AUTO_INCREMENT=84 ;

-- 
-- Dumping data for table photos
-- 

INSERT INTO photos VALUES (1, 'boat1.jpg', 'Hunter Horizon 26 Yacht', 'Loading at Norwich en-route to Durness Scotland. Used a Parrymore 3.5T gross trailer', 10);
INSERT INTO photos VALUES (2, 'boat2.jpg', 'Yacht', 'Stopped for a break at Lairg Scotland', 11);
INSERT INTO photos VALUES (3, 'boat3.jpg', 'Yacht', 'A great place to take photos. Making a safe journey from Norwich to Durness', 12);
INSERT INTO photos VALUES (4, 'boat4.jpg', 'Yacht', 'Scottish scenery where a yacht is at home almost at destination Durness', 13);
INSERT INTO photos VALUES (30, 'PA2700412.jpg', 'Small Cruiser', 'Launching at the Falkirk Wheel. Vessel taken out of the water at Loch Lomond using a Mersea trailer custom built to carry any model of vessel', 20);
INSERT INTO photos VALUES (31, 'DSC00384-01.jpg', 'RAF rescue launch', 'Lying at Buckie ready to go to Lancashire.\r\nSitting on a Parrymore trailer', 14);
INSERT INTO photos VALUES (32, 'DSC01064-01.jpg', 'Hardy', 'Loading straight onto the trailer from the water at Loch Tay ', 15);
INSERT INTO photos VALUES (33, 'DSC01073-01.jpg', 'Hardy', 'Safely loaded onto trailer ready for the trip to Dornoch', 16);
INSERT INTO photos VALUES (34, 'DSC01080-01.jpg', 'Hardy', 'Having a comfort break at Tyndrum', 17);
INSERT INTO photos VALUES (35, 'DSC01081-01.jpg', 'Hardy', 'Arrived safely at Dornoch', 18);
INSERT INTO photos VALUES (36, 'P9040037_1-01.jpg', 'Yacht', 'Boat and launching trailer being transported from Dunvegan Isle of Skye to Tighnabruaich using a tri-axle flat bed trailer', 19);
INSERT INTO photos VALUES (37, 'PB290062-01.jpg', 'Finn Keel Merlin Yacht (Twenty eight ft)', 'Loading at Brightlingsea heading for Oban Scotland Used a custom built trailer from Mersea', 21);
INSERT INTO photos VALUES (38, 'PB290065-01.jpg', 'Merlin Yacht', 'Strapped down and ready to leave', 22);
INSERT INTO photos VALUES (39, 'P2270195-01.jpg', 'Yacht', 'Collecting Cairnryan going to Portsoy customers own trailer', 23);
INSERT INTO photos VALUES (40, 'P2270196-01.jpg', 'Fin Keeled Yacht', 'Strapped down and ready to leave 7 hr journey ahead', 24);
INSERT INTO photos VALUES (41, 'P3070197-01.jpg', 'Westerly Griffon 27ft', 'Loaded at Port Edgar Marina South Queensferry on a Mersea trailer, with extensions for the bilge keels, en-route to Southampton left 6.30 pm arrived Southampton safely at 8 am next morning. Boat sat very well on trailer easy drive', 26);
INSERT INTO photos VALUES (42, 'P3070198-01.jpg', 'Westerly Griffon 27ft', 'ready to be strapped down for the journey to Southampton', 26);
INSERT INTO photos VALUES (43, 'P3080199-01.jpg', 'Westerly Griffon 27ft', 'At Deacons Boatyard Southampton next morning ready for lifting off', 27);
INSERT INTO photos VALUES (44, 'P3080201-01.jpg', 'Westerly Griffon 27ft', 'Lifting off trailer at Southampton under the watchfull eye of the owner', 28);
INSERT INTO photos VALUES (53, 'P3210203-01.jpg', '28'' Yacht', 'Safely loaded and ready to leave', 30);
INSERT INTO photos VALUES (52, 'P3210202-01.jpg', '28'' Yacht', 'Loading at Arisaig near Mallaig this one is ''taking the high road''', 29);
INSERT INTO photos VALUES (54, 'P3220205-01.jpg', '28'' Yacht', 'Arrived safely at Clyde Marina Ardrossan waiting to be lifted off', 31);
INSERT INTO photos VALUES (55, 'P3220206-01.jpg', '28'' Yacht', 'Yacht sat well on the Mersea trailer and never moved throughout the 6hr journey on bumpy Scottish roads', 32);
INSERT INTO photos VALUES (56, 'P4040197-01.jpg', 'The ''Rebound'' a Nimbus 28', 'Lifting out of the water at Dorset Shipyard Poole', 33);
INSERT INTO photos VALUES (57, 'P4040198-01.jpg', 'The ''Rebound''', 'Loaded onto a Mersea trailer and her bottom washed ready for a trip to Scotland. Client wants his boat to be looking good when arriving at new destination.', 34);
INSERT INTO photos VALUES (58, 'P4040199-01.jpg', 'The ''Rebound''', 'Stopped at services on M27 to check boat had not moved. Trailer and truck were pushed to the limit on this trip The boat sat well on the trailer, apart from the hills you would not have known she was there.', 35);
INSERT INTO photos VALUES (59, 'P4050200-01.jpg', 'The ''Rebound''', 'Arrived safely at Clyde Marina Ardrossan, it took us about 14hrs to do the trip, were in no hurry the boats safety is paramount.', 36);
INSERT INTO photos VALUES (60, 'P4050201-01.jpg', 'The ''Rebound''', 'Waiting in the queue to be lifted off', 37);
INSERT INTO photos VALUES (61, 'P4130197-01.jpg', 'Sadler 26 Bilge Keel Yacht 26''', 'Collecting at Inverkip Marina en-route to Port Edgar South Qheensferry', 38);
INSERT INTO photos VALUES (62, 'P4130198-01.jpg', 'Sadler 26 Bilge Keel Yacht 26''', 'Strapped down and ready to leave lovely morning leaving Inverkip', 39);
INSERT INTO photos VALUES (63, 'P4140197-01.jpg', 'Yacht', 'April. Ready for going into water at Portsoy', 25);
INSERT INTO photos VALUES (64, 'P4140199-01.jpg', '', 'Champagne bottle at the ready ', 25);
INSERT INTO photos VALUES (65, 'P4130199-01.jpg', 'Sadler 26 Bilge Keel Yacht 26''', 'Arrived safely at Port Edgar cold and misty', 40);
INSERT INTO photos VALUES (66, 'P4200002-01.jpg', 'Small cruiser', 'Ready to unload at Wick.\r\nUsed the Range Rover to handle the steep hills en-route. Boat sitting on the Mersea trailer stripped to handle a cruiser.', 41);
INSERT INTO photos VALUES (67, 'P4260009-01.jpg', 'Twin Keel Leisure 23sl', 'Loaded and strapped down at farm in Essex ready for journey to Tayport Scotland', 42);
INSERT INTO photos VALUES (68, 'P4270010-01.jpg', 'Leasure 23sl', 'Safely delivered to Tayport seen here with the proud new owner waiting for the crane to arrive to put mast up and lift vessel into water', 43);
INSERT INTO photos VALUES (69, 'P6010001-01.jpg', 'Bayliner', 'Getting ready to leave Cameron House Marina Loch Lomond en-route to Port Edgar ', 44);
INSERT INTO photos VALUES (70, 'P6010002-01.jpg', 'Bayliner', 'In company with another era at Cameron House Hotel Loch Lomond', 45);
INSERT INTO photos VALUES (71, 'P6110005-01.jpg', 'Day Cruiser', 'At Kinlochmoidart. Customer going for a weeks fishing in the tranquility of a West Coast Loch. Delivered and collected at the customers'' request.', 9);
INSERT INTO photos VALUES (72, 'P6170020-01.jpg', 'Cruiser the ''Orcadia''', 'Waiting to board ferry at Plymouth en-route from Inverkip in Scotland to Aguadulce in southern Spain', 4);
INSERT INTO photos VALUES (73, 'P6190023-01.jpg', 'Cruiser', 'Safely arrived at destination awaiting for marina to open to get unloaded. It is 6am and the temp. is riseing fast', 5);
INSERT INTO photos VALUES (74, 'P6190026-01.jpg', 'Cruiser', 'Waiting our turn in the queue to get lifted off', 6);
INSERT INTO photos VALUES (75, 'P6190027-01.jpg', 'The ''Orcadia''', 'Being lifted onto cradles in the compound at the marina Aguadulce. Beautiful spot on the Med. ', 7);
INSERT INTO photos VALUES (76, 'P6250001-01.jpg', 'Single keeled Yacht', 'Lifting off at Lossiemouth in pouring rain real culture shock from Spain the week before. ', 8);
INSERT INTO photos VALUES (77, 'P7090008-01.jpg', 'MG Spring 25 ''Embark''', 'Loaded and strapped down ready for the long haul from Banff on the Moray Firth Scotland to Dover', 1);
INSERT INTO photos VALUES (78, 'P7110010-01.jpg', 'Embark', 'Safely arrived at Dover waiting to be lifted off', 2);
INSERT INTO photos VALUES (79, 'P7110011-01.jpg', 'Embark', 'On the crane with the new owners proudly taking pics of their new boat', 3);
INSERT INTO photos VALUES (80, 'P7200001-01.jpg', 'Bayliner', 'Loading at Chichister Marine in torrential rain. There was so much flooding we could have sailed her up the motorway. Heading for Port Edgar Marina South Queensferry Scotland', 46);
INSERT INTO photos VALUES (81, 'P7210005-01.jpg', 'Bayliner', 'Safely arrived at Port Edgar with the two Forth Bridges in the background', 47);
INSERT INTO photos VALUES (82, 'P7210006-01.jpg', 'Bayliner', 'Waiting to be lifted off at the point of the quay at Port Edgar', 48);
INSERT INTO photos VALUES (83, 'P7210007-01.jpg', 'Bayliner', 'Lowering into the water with the proud new owner taking pics of his pride and joy', 49);

-- --------------------------------------------------------

