-- --------------------------------------------------------
-- West Coast Express
-- Copyright (c) 2006 Frontburner
-- Author Craig McKay <craig@frontburner.co.uk>
--
-- $Id$
-- --------------------------------------------------------
-- phpMyAdmin SQL Dump
-- version 2.8.2
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Feb 03, 2007 at 08:10 AM
-- Server version: 4.1.20
-- PHP Version: 4.4.2
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

INSERT INTO member (memberid, first_name, last_name, email_address, password, admin, member_type, verify_code, active, dob, signup_date, last_login) VALUES ('CRAIG', 'Craig', 'McKay', 'craig@southesk.com', 'b193cacd08f36cfa4f0c165a48255497', 1, 'A', '0', 1, '1975-09-13', '0000-00-00 00:00:00', '2007-02-03 08:02:37'),
('BOB', 'Bob', 'Bain', '', 'b193cacd08f36cfa4f0c165a48255497', 1, 'A', '0', 1, '1950-01-01', '0000-00-00 00:00:00', '2007-02-03 08:06:43');

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

INSERT INTO member_type (member_type, type_name, comments, disp_order) VALUES ('U', 'User', 'Ability to View all details on the site', 1),
('N', 'New User', 'No permissions yet - waiting verification', 3),
('A', 'Administrator', 'Full Administrative capabilities', 2);

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
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COMMENT='Photo Gallery' AUTO_INCREMENT=31 ;

--
-- Dumping data for table photos
--

INSERT INTO photos (id, photo, boat, location, disporder) VALUES (1, 'boat1.jpg', 'Yacht', '', 60),
(2, 'boat2.jpg', 'Yacht', '', 20),
(3, 'boat3.jpg', 'Yacht', '', 30),
(4, 'boat4.jpg', 'Yacht', '', 40),
(30, 'PA2700412.jpg', '', 'Falkirk Wheel', 10);

-- --------------------------------------------------------

--
-- Table structure for table upload
--

CREATE TABLE upload (
  uplfile varchar(255) NOT NULL default '',
  docdate date NOT NULL default '0000-00-00',
  doctype char(1) NOT NULL default 'I',
  PRIMARY KEY  (uplfile)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COMMENT='Uploaded Files';

--
-- Dumping data for table upload
--

