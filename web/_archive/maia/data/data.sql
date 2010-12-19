-- phpMyAdmin SQL Dump
-- version 2.7.0-pl2
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Feb 03, 2006 at 03:52 PM
-- Server version: 4.1.16
-- PHP Version: 4.4.1
--
-- Database: `maiasystems_com`
--
-- $Id$

-- --------------------------------------------------------

--
-- Table structure for table `member`
--

CREATE TABLE `member` (
  `memberid` varchar(20) NOT NULL default '',
  `first_name` varchar(25) NOT NULL default '',
  `last_name` varchar(25) NOT NULL default '',
  `email_address` varchar(255) default NULL,
  `password` varchar(50) NOT NULL default '',
  `admin` int(1) default '0',
  `member_type` char(2) NOT NULL default 'N',
  `verify_code` varchar(100) NOT NULL default '',
  `active` int(1) NOT NULL default '0',
  `dob` date NOT NULL default '0000-00-00',
  `signup_date` datetime NOT NULL default '0000-00-00 00:00:00',
  `last_login` datetime NOT NULL default '0000-00-00 00:00:00',
  PRIMARY KEY  (`memberid`),
  KEY `i_email_address` (`email_address`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COMMENT='User Information';

--
-- Dumping data for table `member`
--

INSERT INTO `member` VALUES ('CRAIG', 'Craig', 'McKay', 'craig@southesk.com', '1eebdddd1f688244a5861695cb7c3eba', 1, 'A', '0', 1, '1975-09-13', '0000-00-00 00:00:00', '2006-02-03 15:45:15');

-- --------------------------------------------------------

--
-- Table structure for table `member_type`
--

CREATE TABLE `member_type` (
  `member_type` char(2) NOT NULL default '',
  `type_name` varchar(50) default NULL,
  `comments` varchar(255) default NULL,
  `disp_order` int(11) NOT NULL default '0',
  PRIMARY KEY  (`member_type`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COMMENT='User Types';

--
-- Dumping data for table `member_type`
--

INSERT INTO `member_type` VALUES ('U', 'User', 'Ability to View all details on the site', 1);
INSERT INTO `member_type` VALUES ('N', 'New User', 'No permissions yet - waiting verification', 3);
INSERT INTO `member_type` VALUES ('A', 'Administrator', 'Full Administrative capabilities', 2);

-- --------------------------------------------------------

--
-- Table structure for table `section`
--

CREATE TABLE `section` (
  `section` int(11) NOT NULL auto_increment,
  `sec_parent` int(11) default NULL,
  `sec_name` varchar(100) NOT NULL default '',
  `source` varchar(100) default NULL,
  `text` longtext,
  `sort_order` int(11) NOT NULL default '0',
  PRIMARY KEY  (`section`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COMMENT='Section' AUTO_INCREMENT=26 ;

--
-- Dumping data for table `section`
--

INSERT INTO `section` VALUES (1, NULL, 'Home', NULL, '<p>Maia Systems Ltd is an independent company dedicated to offering high quality, cost effective machinery and structural asset optimisation products and services. We also provide specialist consultancy for machinery and structural analysis.</p>\r\n\r\n<p>Complete tailored solutions are provided embracing, where appropriate, process measurement, traditional condition indicators, such as vibration and lubricating oil analysis, and novel techniques such as acoustic emission monitoring.</p>\r\n\r\n<p>Data gathered is processed using a combination of classical methods and sophisticated techniques researched and proven over a ten year period in parallel with asset modelling.</p>\r\n\r\n<p>Effective integration with existing computerised maintenance management systems (CMMS) is provided to offer seamless communication with existing work processes and maintenance regimes. Alternatively, for clients who do not operate a CMMS, web based software can be provided to give visibility of specific metric modelling (eg safety, availability, etc) and view overall asset condition. This also provides access outwith the confines of the asset, around the globe.</p>\r\n\r\n<p>Our technical strength lies in our ability to identify and integrate the most appropriate measurement parameters partnered with our data processing and display hardware and software. Furthermore, we pride ourselves on the excellent working relationships we have built up with clients in satisfying their requirements. As a result of this, Maia Systems products and services have been used to design, implement and improve on plant performance and availability providing a measurable increase in our clients’ bottom line.</p>', 10);
INSERT INTO `section` VALUES (2, NULL, 'Application Papers', 'papers.php', NULL, 40);
INSERT INTO `section` VALUES (3, NULL, 'News', 'news.php', NULL, 20);
INSERT INTO `section` VALUES (4, NULL, 'Service Overview', NULL, '<h3>Machinery and Structural Asset Management</h3>\r\n\r\n<p>At Maia Systems we recognise the need to supply products and services that reflect the requirements of your business.</p>\r\n\r\n<p>Ultimately your business generates profit by providing a product to consumers. Effective performance of the tools used to generate this product, i.e. your structures and machines, is required to achieve this. Maia Systems can help by ensuring that you realise appropriate performance and availability of your assets in a cost effective manner. Maximum profit is not always achieved by maximising performance and availability as other factors must be taken into account e.g. the cost of achieving this increased performance and availability.</p>\r\n\r\n<p>To ensure you have a well run asset providing you with maximum profit, Maia Systems offers a number of products and services:</p>\r\n\r\n<ol>\r\n<li>Services to examine the state of current assets, from a specific machine or structure such as a pump or compressor to an entire plant. This will identify the main function of the asset and potential failures and consequences of failure.</li>\r\n\r\n<li>Provision of condition monitoring systems to gather and process data from the asset and provide information on current and future asset condition.</li>\r\n\r\n<li>Support to provide root cause analysis (RCA) in situations where issues with the asset have been identified.</li>\r\n</ol>', 30);
INSERT INTO `section` VALUES (5, NULL, 'Technology', NULL, NULL, 50);
INSERT INTO `section` VALUES (6, NULL, 'Certification', NULL, NULL, 60);
INSERT INTO `section` VALUES (7, NULL, 'Application Overview', NULL, NULL, 70);
INSERT INTO `section` VALUES (8, NULL, 'Contact', NULL, '<table border=0 cellpadding=4 align=center valign=center>\r\n  <tr>\r\n    <td colspan=2 align=center>\r\n      <p>Thank you for your interest in Maia Systems.</p>\r\n      <p>For further information about Maia Systems Ltd please contact us:</p>\r\n    </td>\r\n  </tr>\r\n  <tr><td class="fld">Email</td><td><a href="mailto:info@Maia-Systems.com">info@Maia-Systems.com</a></td></tr>\r\n  <tr><td class="fld">Phone/Fax</td><td>+44 (0) 1651 882315</td></tr>\r\n  <tr><td class="fld">Mobile</td><td>+44 (0) 7702 384 488</td></tr>\r\n</table>\r\n', 80);
INSERT INTO `section` VALUES (9, 4, 'Consultancy', NULL, NULL, 31);
INSERT INTO `section` VALUES (10, 4, 'Products', NULL, NULL, 32);
INSERT INTO `section` VALUES (11, 5, 'Vibration', NULL, '', 51);
INSERT INTO `section` VALUES (12, 5, 'Accoustic Emission', NULL, NULL, 52);
INSERT INTO `section` VALUES (13, 5, 'Lube Oil Analysis', NULL, NULL, 53);
INSERT INTO `section` VALUES (14, 5, 'Instantaneous Speed', NULL, NULL, 54);
INSERT INTO `section` VALUES (15, 5, 'Strain', NULL, NULL, 54);
INSERT INTO `section` VALUES (16, 5, 'Process', NULL, NULL, 55);
INSERT INTO `section` VALUES (17, 4, 'Software', NULL, NULL, 38);
INSERT INTO `section` VALUES (18, 6, 'BINDT', NULL, NULL, 61);
INSERT INTO `section` VALUES (19, 6, 'Working Group for EU standard', NULL, NULL, 62);
INSERT INTO `section` VALUES (20, 7, 'Rotating machinery', NULL, NULL, 71);
INSERT INTO `section` VALUES (21, 7, 'Reciprocating machinery', NULL, NULL, 72);
INSERT INTO `section` VALUES (22, 7, 'Structural investigations', NULL, NULL, 73);
INSERT INTO `section` VALUES (23, 7, 'Slow speed rotating equipment', NULL, NULL, 74);
INSERT INTO `section` VALUES (24, 10, 'Bespoke', NULL, '', 33);
INSERT INTO `section` VALUES (25, 10, 'Wireless', NULL, '', 34);

-- --------------------------------------------------------

--
-- Table structure for table `upload`
--

CREATE TABLE `upload` (
  `uplfile` varchar(255) NOT NULL default '',
  `docdate` date NOT NULL default '0000-00-00',
  `doctype` char(1) NOT NULL default 'I',
  PRIMARY KEY  (`uplfile`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COMMENT='Uploaded Files';

--
-- Dumping data for table `upload`
--

