-- --------------------------------------------------------
-- West Coast Express
-- Copyright (c) 2007 Frontburner
-- Author Craig McKay <craig@frontburner.co.uk>
--
-- $Id $
-- --------------------------------------------------------
-- Database Diff
--
-- Who  When         Why
-- CAM  11-Aug-2007  10149 : File created.
-- CAM  11-Aug-2007  10154 : Added feedback table.
-- --------------------------------------------------------

DROP TABLE upload;

CREATE TABLE feedback (
  id int(11) NOT NULL auto_increment,
  feedback_date date NOT NULL default '0000-00-00',
  customer_name varchar(50) default NULL,
  feedback mediumtext,
  PRIMARY KEY  (id)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COMMENT='Customer Feedback';
