
----------------------------------------------------------
--
-- User Information
--

CREATE TABLE member (
  memberid varchar(20) NOT NULL,
  first_name varchar(25) NOT NULL,
  last_name varchar(25) NOT NULL,
  email_address varchar(255) default NULL,
  password varchar(50) NOT NULL,
  admin int(1) default '0',
  member_type char(2) NOT NULL default 'N',
  verify_code varchar(100) NOT NULL,
  active int(1) NOT NULL default '0',
  dob date NOT NULL default '0000-00-00',
  signup_date datetime NOT NULL default '0000-00-00 00:00:00',
  last_login datetime NOT NULL default '0000-00-00 00:00:00',
  PRIMARY KEY  (memberid),
  KEY i_email_address (email_address)
) COMMENT='User Information';

--
-- Data for table member
--

INSERT INTO member VALUES ('CRAIG', '', '', '', 'Craig', 'McKay', 'craig@southesk.com', '1eebdddd1f688244a5861695cb7c3eba', 1, 'A', '0', 1, '1975-09-13', '0000-00-00 00:00:00', '2005-11-26 10:20:00');

----------------------------------------------------------
--
-- User Types
--

CREATE TABLE member_type (
  member_type char(2) NOT NULL,
  type_name varchar(50) default NULL,
  comments varchar(255) default NULL,
  disp_order int(11) NOT NULL default '0',
  PRIMARY KEY  (member_type)
) COMMENT='User Types';

-- Data for table member_type

INSERT INTO member_type VALUES ('U', 'User', 'Ability to View all details on the site', 1);
INSERT INTO member_type VALUES ('N', 'New User', 'No permissions yet - waiting verification', 3);
INSERT INTO member_type VALUES ('A', 'Administrator', 'Full Administrative capabilities', 2);

----------------------------------------------------------
--
-- Uploaded Files
--

CREATE TABLE upload (
  uplfile varchar(255) NOT NULL,
  docdate date NOT NULL default '0000-00-00',
  doctype char(1) NOT NULL default 'I',
  PRIMARY KEY  (uplfile)
) COMMENT='Uploaded Files';
