-- --------------------------------------------------------
-- Airylea Motors Website
-- Copyright (c) 2008,2009 Frontburner
-- Author Craig McKay <craig@frontburner.co.uk>
--
-- $Id$
-- --------------------------------------------------------
-- phpMyAdmin SQL Dump
-- version 2.11.1.1
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Aug 28, 2008 at 10:10 PM
-- Server version: 4.1.22
-- PHP Version: 5.2.6

--
-- Database: airylea_com_-_site
--
-- --------------------------------------------------------

--
-- Table structure for table feedback
--

CREATE TABLE feedback (
  id int(11) NOT NULL auto_increment,
  feedback_date date NOT NULL default '0000-00-00',
  customer_name varchar(50) default NULL,
  feedback mediumtext,
  PRIMARY KEY  (id)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 COMMENT='Customer Feedback' AUTO_INCREMENT=7 ;

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

INSERT INTO member (memberid, first_name, last_name, email_address, password, admin, member_type, verify_code, active, dob, signup_date, last_login) VALUES
('CRAIG', 'Craig', 'McKay', 'craig@southesk.com', '0954bfb4e59e3d85ff989944a65f6955', 1, 'A', '0', 1, '1975-09-13', '0000-00-00 00:00:00', '2008-06-11 10:23:11');

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

INSERT INTO member_type (member_type, type_name, comments, disp_order) VALUES
('U', 'User', 'Ability to View all details on the site', 1),
('N', 'New User', 'No permissions yet - waiting verification', 3),
('A', 'Administrator', 'Full Administrative capabilities', 2);

-- --------------------------------------------------------

--
-- Table structure for table newsitems
--

CREATE TABLE newsitems (
  id int(11) NOT NULL auto_increment,
  newsitem varchar(50) default NULL,
  news_text mediumtext,
  news_date date default NULL,
  news_img varchar(50) default NULL,
  PRIMARY KEY  (id)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 COMMENT='News Items' AUTO_INCREMENT=10 ;

--
-- Dumping data for table newsitems
--


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
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 COMMENT='Photo Gallery' AUTO_INCREMENT=157 ;

