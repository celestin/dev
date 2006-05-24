-- --------------------------------------------------------
-- West Coast Express
-- Copyright (c) 2006 Frontburner
-- Author Craig McKay <craig@frontburner.co.uk>
--
-- $Id$
-- --------------------------------------------------------
-- phpMyAdmin SQL Dump
-- version 2.6.1-pl3
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: May 24, 2006 at 01:08 PM
-- Server version: 4.0.18
-- PHP Version: 4.3.10
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
) TYPE=MyISAM COMMENT='User Information';

--
-- Dumping data for table member
--

INSERT INTO member VALUES ('CRAIG', 'Craig', 'McKay', 'craig@southesk.com', '1eebdddd1f688244a5861695cb7c3eba', 1, 'A', '0', 1, '1975-09-13', '0000-00-00 00:00:00', '2005-11-26 10:20:00');

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
) TYPE=MyISAM COMMENT='User Types';

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
  location varchar(255) NOT NULL default '',
  disporder int(11) NOT NULL default '0',
  PRIMARY KEY  (id)
) TYPE=MyISAM COMMENT='Photo Gallery' AUTO_INCREMENT=5 ;

--
-- Dumping data for table photos
--

INSERT INTO photos VALUES (1, 'boat1.jpg', 'Yacht', '', 1);
INSERT INTO photos VALUES (2, 'boat2.jpg', 'Yacht', '', 2);
INSERT INTO photos VALUES (3, 'boat3.jpg', 'Yacht', '', 3);
INSERT INTO photos VALUES (4, 'boat4.jpg', 'Yacht', '', 4);

-- --------------------------------------------------------

--
-- Table structure for table upload
--

CREATE TABLE upload (
  uplfile varchar(255) NOT NULL default '',
  docdate date NOT NULL default '0000-00-00',
  doctype char(1) NOT NULL default 'I',
  PRIMARY KEY  (uplfile)
) TYPE=MyISAM COMMENT='Uploaded Files';

--
-- Dumping data for table upload
--

