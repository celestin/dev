-- --------------------------------------------------------
-- Airylea Motors Website
-- Copyright (c) 2008 Frontburner
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

--
-- Dumping data for table feedback
--

INSERT INTO feedback (id, feedback_date, customer_name, feedback) VALUES
(1, '2007-07-21', 'Douglas Benton', 'Thank you very much for delivering our boat safely in extreme weather conditions. I thought you would not make it for the arranged lift off. (it was a birthday present for the wife I am glad you made it on time)\r\nThanks again\r\n\r\nDougie'),
(2, '2007-08-11', 'Eddie Clark', 'I really appreciated the way you went about and overcame the obsticles that were put in front of me to hinder me getting the Golden Sceptre to Buckie. I don''t think anyone else would have done what you did.\r\nThanks\r\n\r\nEddie '),
(3, '2007-06-23', 'Jim Purss', 'You did a great job. No fuss, took everything in your stride, I can now look forward to cruising the MED.\r\nCheers\r\nJim\r\n\r\nps take your wife out to Spain for a holiday on the boat'),
(4, '2008-02-15', 'Ron McCreath', 'Thanks for doing a good job and being so obliging and helpful\r\n\r\nRon'),
(5, '2008-07-21', 'Val. North', 'Thank you both very much for all your help. Gary now catching up with sleep and I am at work. Will certainly recommend you amongst our friends and neighbours who may need transport in the future.'),
(6, '2008-08-21', 'Graeme Naylor', 'Hi Bob, \r\nMany thanks indeed for your care & patience in bringing my new baby the length of the country & the way you handled unforseen circumstances. You are a delight to deal with.\r\n \r\nYours most sincerely,\r\nGraeme Naylor.');

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

