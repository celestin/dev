-- --------------------------------------------------------
-- Good Teaching Search Engine
-- Copyright (c) 2007 Frontburner
-- Author Craig McKay <craig@frontburner.co.uk>
--
-- $Id$
--
-- Who  When         Why
-- CAM  28-Mar-2009  10407 : Added member and member_type.
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

INSERT INTO member VALUES ('CRAIG', 'Craig', 'McKay', 'craig@southesk.com', '0954bfb4e59e3d85ff989944a65f6955', 1, 'A', '0', 1, '1975-09-13', '0000-00-00 00:00:00', '2007-08-11 16:23:56');

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

