-- --------------------------------------------------------
-- Relaxatub
-- Copyright (c) 2006,2010 Frontburner
-- Author Craig McKay <craig@frontburner.co.uk>
--
-- $Id$
--
-- GRANT ALL PRIVILEGES ON *.* TO 'relaxatub'@'localhost' IDENTIFIED BY 'hazel44' WITH GRANT OPTION;
-- SET PASSWORD FOR 'relaxatub'@'localhost' = OLD_PASSWORD('hazel44');
-- --------------------------------------------------------
-- phpMyAdmin SQL Dump
-- version 2.9.2
-- http://www.phpmyadmin.net
-- 
-- Host: localhost
-- Generation Time: Mar 29, 2010 at 07:07 PM
-- Server version: 5.0.27
-- PHP Version: 4.4.5
-- 
-- Database: relaxatub_com_-_prod
-- 

-- --------------------------------------------------------

-- 
-- Table structure for table accessory
-- 

CREATE TABLE accessory (
  accid int(11) NOT NULL auto_increment,
  pid int(11) NOT NULL,
  photo varchar(60) character set latin1 NOT NULL,
  price double NOT NULL,
  PRIMARY KEY  (accid)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='Accessories (Products)' AUTO_INCREMENT=3010 ;

-- 
-- Dumping data for table accessory
-- 

INSERT INTO accessory VALUES (3001, 1011, 'na.png', 132);
INSERT INTO accessory VALUES (3002, 1012, 'na.png', 150);
INSERT INTO accessory VALUES (3003, 1013, 'na.png', 228);
INSERT INTO accessory VALUES (3004, 1014, 'na.png', 45);
INSERT INTO accessory VALUES (3005, 1015, 'na.png', 42);
INSERT INTO accessory VALUES (3006, 1016, 'na.png', 24);
INSERT INTO accessory VALUES (3007, 1017, 'na.png', 32);
INSERT INTO accessory VALUES (3008, 1018, 'af1.png', 85);
INSERT INTO accessory VALUES (3009, 1019, 'c4326.png', 25);

-- --------------------------------------------------------

-- 
-- Table structure for table faq
-- 

CREATE TABLE faq (
  faqno int(11) NOT NULL default '0',
  summary varchar(100) NOT NULL default '',
  question mediumtext NOT NULL,
  answer mediumtext NOT NULL,
  PRIMARY KEY  (faqno)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COMMENT='FAQ';

-- 
-- Dumping data for table faq
-- 

INSERT INTO faq VALUES (1, 'advanced design', 'What makes Beachcomber''s Protec Hot Tub so Different?', 'Beachcomber''s Protec Hot Tub is more comfortable, more energy efficient and safter.  These three advantages set Protec apart from all other Hot Tubs.  How do we do it?\n<ul>\n<li class="faqa">First, we move the motor and pump outside the tub cavity.  This creates even more room inside the Protec Hot Tub for you to get comfortable.</li>\n<li class="faqa">It also made it possible to take the second step - insulating all four sides of the Hot Tub (and every other model of portable Beachcomber Hot Tub) just like you would in the most energy efficient home today.  Every nook and cranny is filled with insulation to make Beachcomber''s Protec Hot Tub the most energy efficient Hot Tub available today.</li>\n<li class="faqa">Third, we designed a housing for the pump and motor to do double duty as a step that makes it easier for people to get in and out of the tub safely.  The special housing also makes it easier to access the pump and motor.  We also have an injection system that draws air from the pump and motor housing into mixing ducts, injecting warm air instead of could into the water.  Protec really is something different.</li>\n</ul>');
INSERT INTO faq VALUES (2, 'guarantee', 'What do you mean by your Guarantee versus the Hot Tub Industry''s Limited Warranty?', 'The industry''s standard Limited Warranty protects the manufacturer and not the customer.  Buying a Hot Tub is a major purchase, but few people understand what can go wrong, and are not as familiar with buying a Hot Tub as they are with other household appliciances.  Beachcomber''s guarantee protects <i>you</i>, the customer, and enables us to protect you after you purchase a Hot Tub.  It is still a young industry and we recommend that you get a guarantee like Beachcomber''s when you buy a Hot Tub, not the industry''s standard Limited Warranty.');
INSERT INTO faq VALUES (3, 'control & maintenance', 'Is it hard to keep a Hot Tub running properly?', 'It could be if it didn''t have Beachcomber''s Management Centre.  Every Beachcomber Hot Tub has a user-friendly control pad installed on the entrance lip to let you manage the heating and cleaning functions automatically so your Hot Tub is always ready for use when you are.  This computerised system lets you control the maintenance of your Beachcomber, and saves you money in energy costs on many models.  There is even a special mode for when you are away, or for your Hot Tub at the cottage or second home.  You control it with the touch of a finger: nothing could be simpler, or more energy efficient.');
INSERT INTO faq VALUES (4, 'service', 'What can a family business do for me that a big corporation can''t?', 'A family business like Beachcomber can give you the service with a personal touch that a big corporation simply cannot do.  The portable tub and spa industry concept is only about 25 years old.  We need pioneering entrepreneurs participating directly in their companies at this early stage.  Imagine if the founders of the automobile, pioneers like Benz of Mercedes and Henry Ford, sold to conglomerates early on in their business cycle.  It is too soon for Hot Tub makers to start servicing the shareholders for the best return on their investment.  Beachcomber wants to build a Hot Tub that gives the retail customer the best quality, price and service for their investment.  Keith Scott has done just this every day since he started 20 years ago.');
INSERT INTO faq VALUES (5, 'motors', 'Does having more than one Motor make a Hot Tub run better?  And what is the difference between a Motor and a Pump, anyway?', 'No. You don''t need more than one motor in a Hot Tub for the same reason you don''t have more than one motor in your car.  One motor provides all the power you need.  Over the past 20 years, Beachcomber has designed and refined a single motor that serves multiple functions and multiple speeds.  The single motor works best because it requires less service and maintenance.  To answer the second question, we simply tell people that the motor is what drives the pump, which pumps water through the massage jets to make you feel good all over.');
INSERT INTO faq VALUES (6, 'power', 'I''m confused.  What does Max Rating a Pump mean?', 'Max rating means rating a motor''s horsepower by its maximum output.  It may sound like you are getting a more powerful motor, but it is just not so.  We rate Beachcomber motors at normal operating conditions.  A rating of 2hp under normal conditions will provide more power than a pump max rated at 5hp.  What Beachcomber gives you is more therapeutic jet action with less horsepower: you use less electricity and save money.');
INSERT INTO faq VALUES (7, 'construction', 'Is installing permanent pillows or moulding them directly into the hot tub a good method of manufacturing?', 'Beachcomber''s past experience shows that permenant pillows absorb odour from the bathers as well as the Hot Tub water itself.  Over-exposure to Hot Tub water means that permanent pillows will become unsightly and tarnished very quickly.  Beachcomber have developed comfortable, contoured neck recesses without pillows that give exceptional comfort and the option of adding a portable pillow if required.');
INSERT INTO faq VALUES (8, 'water', 'What is recommended for treating and cleaning Hot Tub water?', 'Water quality and cleanliness are important aspects of caring for your Hot Tub and hence we are highly experienced when it comes to educating and advising on which products to enhance and make the Hot Tub experience enjoyable and safe.');
INSERT INTO faq VALUES (9, 'comfort', 'How important is the depth of the Hot Tub?', 'Extra depth gives more comfort, especially for the feet, knees and abdomen.  One of the only reasons for a low-profile tub would be for indoor use.');

-- --------------------------------------------------------

-- 
-- Table structure for table member
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
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='User Information';

-- 
-- Dumping data for table member
-- 

INSERT INTO member VALUES ('CRAIG', 'Craig', 'McKay', 'craig@southesk.com', '1eebdddd1f688244a5861695cb7c3eba', 1, 'A', '0', 1, '1975-09-13', '0000-00-00 00:00:00', '2010-03-08 10:07:51');

-- --------------------------------------------------------

-- 
-- Table structure for table member_type
-- 

CREATE TABLE member_type (
  member_type char(2) NOT NULL,
  type_name varchar(50) default NULL,
  comments varchar(255) default NULL,
  disp_order int(11) NOT NULL default '0',
  PRIMARY KEY  (member_type)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='User Types';

-- 
-- Dumping data for table member_type
-- 

INSERT INTO member_type VALUES ('U', 'User', 'Ability to View all details on the site', 1);
INSERT INTO member_type VALUES ('N', 'New User', 'No permissions yet - waiting verification', 3);
INSERT INTO member_type VALUES ('A', 'Administrator', 'Full Administrative capabilities', 2);

-- --------------------------------------------------------

-- 
-- Table structure for table photo
-- 

CREATE TABLE photo (
  photo varchar(100) NOT NULL default '',
  location varchar(100) default '',
  tub varchar(100) default '',
  PRIMARY KEY  (photo)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COMMENT='Photo Album';

-- 
-- Dumping data for table photo
-- 

INSERT INTO photo VALUES ('p001.jpg', 'Aberdeen', NULL);
INSERT INTO photo VALUES ('p002.jpg', 'Aberdeen', NULL);
INSERT INTO photo VALUES ('p003.jpg', 'Aberdeen', NULL);
INSERT INTO photo VALUES ('p004.jpg', 'Aberdeen', NULL);
INSERT INTO photo VALUES ('p005.jpg', 'Chester', NULL);
INSERT INTO photo VALUES ('p006.jpg', 'Kirkcaldy', NULL);
INSERT INTO photo VALUES ('p007.jpg', 'Angus', '');
INSERT INTO photo VALUES ('p008.jpg', 'Angus', '');
INSERT INTO photo VALUES ('p009.jpg', 'Aberdeen', '');
INSERT INTO photo VALUES ('p010.jpg', 'Glasgow', '');
INSERT INTO photo VALUES ('p011.jpg', 'Tarland', '');
INSERT INTO photo VALUES ('p012.jpg', 'Tarland', '');
INSERT INTO photo VALUES ('p013.jpg', 'Glasgow', '');
INSERT INTO photo VALUES ('p014.jpg', 'Drumock', '');
INSERT INTO photo VALUES ('p015.jpg', 'Westhill', '');
INSERT INTO photo VALUES ('p016.jpg', 'Bridge of Don', '');
INSERT INTO photo VALUES ('p017.jpg', 'Kingswells', '');
INSERT INTO photo VALUES ('p019.jpg', 'Aberdeen', '');
INSERT INTO photo VALUES ('p020.jpg', 'Bridge of Don', '');
INSERT INTO photo VALUES ('p021.jpg', 'Bridge of Don', '');
INSERT INTO photo VALUES ('p022.jpg', 'Newmacher', '');
INSERT INTO photo VALUES ('p024.jpg', 'Bridge of Don', '');
INSERT INTO photo VALUES ('p025.jpg', 'Stonehaven', NULL);
INSERT INTO photo VALUES ('p026.jpg', 'Bucksburn', NULL);
INSERT INTO photo VALUES ('p027.jpg', 'Bucksburn', NULL);
INSERT INTO photo VALUES ('p028.jpg', 'Bucksburn', NULL);

-- --------------------------------------------------------

-- 
-- Table structure for table product
-- 

CREATE TABLE product (
  pid int(11) NOT NULL auto_increment,
  pcode varchar(20) NOT NULL,
  pdescription varchar(100) default NULL,
  ptype char(1) NOT NULL COMMENT 'Product Type: A - Accessory, C - Aftercare, Q - Quickship Tub',
  paypal_button_id varchar(20) default NULL,
  PRIMARY KEY  (pid)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='Quickship (Products)' AUTO_INCREMENT=1020 ;

-- 
-- Dumping data for table product
-- 

INSERT INTO product VALUES (1001, '321-ISP', '321 (ISP) Portable', 'Q', 'WFAMAAEJHY6J4');
INSERT INTO product VALUES (1002, '340-ISP', '340 (ISP) Portable', 'Q', 'PHMQ5RXGXWWPJ');
INSERT INTO product VALUES (1003, '350QS-LEEP', '350 (LEEP) Portable', 'Q', 'VF47SDA8FY3TC');
INSERT INTO product VALUES (1004, '350QS-BHE', '350 (BHE) Hybrid', 'Q', '2C5GJY7YR3SZW');
INSERT INTO product VALUES (1005, '360QS-LEEP', '360 (LEEP) Portable', 'Q', 'BTNA3DCB6WR5U');
INSERT INTO product VALUES (1006, '360QS-BHE', '360 (BHE) Hybrid', 'Q', 'CBHW25HKHZ8VC');
INSERT INTO product VALUES (1007, '380QS-BHE', '380 (BHE) Hybrid', 'Q', 'ZCPJG2YTBM4UY');
INSERT INTO product VALUES (1008, '550QS-BHE', '550 (BHE) Hybrid', 'Q', '6FB7ZLDVLF422');
INSERT INTO product VALUES (1009, '725QS-BHE', '725 (BHE) Hybrid', 'Q', '6YSJU9WDB3DVW');
INSERT INTO product VALUES (1010, '750QS-BHE', '750 (BHE) Hybrid', 'Q', 'TW2QEB7NXKSRG');
INSERT INTO product VALUES (1011, 'GLS-851-0504', 'Covermate I', 'A', 'W6Z4UESXUQT22');
INSERT INTO product VALUES (1012, 'GLS-851-0505', 'Covermate II', 'A', 'G2QZM6589WWW2');
INSERT INTO product VALUES (1013, 'GLS-851-0507', 'Covermate III', 'A', 'F7ZT8P5KGJ8N2');
INSERT INTO product VALUES (1014, 'GLS-851-0511', 'Spa caddy', 'A', 'V9EBTTKQDLLCN');
INSERT INTO product VALUES (1015, 'PLS-40-8027', 'Spa wand (inc skimmer brush and wall mount)', 'A', 'HEMJJDWZ67CRU');
INSERT INTO product VALUES (1016, 'GLS-851-0508', 'Towel rail', 'A', '5JMCCVTSPM9RS');
INSERT INTO product VALUES (1017, 'GLS-851-0529', 'Solar-powered cabinet illumination', 'A', 'JLB6DYGVPGMBC');
INSERT INTO product VALUES (1018, 'A-AF1', 'Aquafinesse + free test strips', 'C', '42V7KWHBQ48ZY');
INSERT INTO product VALUES (1019, 'C-4326', 'Beachcomber C-4326 Filter 25sq.ft.', 'C', 'SCY6S5NWJTYQ4');

-- --------------------------------------------------------

-- 
-- Table structure for table quickship
-- 

CREATE TABLE quickship (
  qsid int(11) NOT NULL auto_increment,
  qscode varchar(20) character set latin1 NOT NULL,
  pid int(11) NOT NULL,
  acrylic_colour varchar(30) character set latin1 NOT NULL,
  cabinet_colour varchar(30) character set latin1 NOT NULL,
  heatshield_colour varchar(30) character set latin1 NOT NULL,
  seats varchar(12) character set latin1 NOT NULL,
  tub int(11) NOT NULL,
  tubtype varchar(20) character set latin1 NOT NULL,
  price_rrp double NOT NULL,
  deposit double NOT NULL,
  PRIMARY KEY  (qsid)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='Quickship (Products)' AUTO_INCREMENT=2011 ;

-- 
-- Dumping data for table quickship
-- 

INSERT INTO quickship VALUES (2001, '321', 1001, 'atlantis', 'bamboo', 'tan', '4 - 5', 321, 'ISP', 4495, 899);
INSERT INTO quickship VALUES (2002, '340', 1002, 'opal', 'ebony_enviro', 'steel', '5', 340, 'ISP', 4995, 999);
INSERT INTO quickship VALUES (2003, '350QS', 1003, 'alabaster', 'ebony_enviro', 'steel', '6', 350, 'LEEP', 5625, 1125);
INSERT INTO quickship VALUES (2004, '350QS', 1004, 'quartzite', 'walnut_enviro', 'tan', '6', 350, 'BHE', 6165, 1233);
INSERT INTO quickship VALUES (2005, '360QS', 1005, 'quartzite', 'walnut_enviro', 'tan', '6 + 1', 360, 'LEEP', 5625, 1125);
INSERT INTO quickship VALUES (2006, '360QS', 1006, 'alabaster', 'ebony_enviro', 'steel', '6 + 1', 360, 'BHE', 6165, 1233);
INSERT INTO quickship VALUES (2007, '380QS', 1007, 'quartzite', 'bamboo', 'tan', '7 + 1', 380, 'BHE', 6695, 1339);
INSERT INTO quickship VALUES (2008, '550QS', 1008, 'opal', 'ebony_enviro', 'steel', '6 + 2', 550, 'BHE', 7995, 1599);
INSERT INTO quickship VALUES (2009, '725QS', 1009, 'alabaster', 'walnut_enviro', 'tan', '6 + 1', 725, 'BHE', 8735, 1747);
INSERT INTO quickship VALUES (2010, '750QS', 1010, 'alabaster', 'walnut_enviro', 'tan', '8 + 1', 750, 'BHE', 11595, 2319);

-- --------------------------------------------------------

-- 
-- Table structure for table series
-- 

CREATE TABLE series (
  series int(11) NOT NULL default '0',
  seriesName varchar(50) NOT NULL default '',
  PRIMARY KEY  (series)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COMMENT='Series';

-- 
-- Dumping data for table series
-- 

INSERT INTO series VALUES (300, '300 Series');
INSERT INTO series VALUES (500, '500 Series');
INSERT INTO series VALUES (700, '700 Series');

-- --------------------------------------------------------

-- 
-- Table structure for table tub
-- 

CREATE TABLE tub (
  series int(11) default NULL,
  tub varchar(50) NOT NULL default '',
  disabled int(11) default '0',
  img_desc varchar(255) default NULL,
  colour varchar(30) NOT NULL default '',
  wood varchar(30) NOT NULL default '',
  tub_size varchar(50) default NULL,
  no_people varchar(10) default NULL,
  dimen varchar(80) default NULL,
  capacity varchar(80) default NULL,
  dry_weight varchar(80) default NULL,
  fill_weight varchar(80) default NULL,
  short_ports varchar(30) default NULL,
  short_custom varchar(30) default NULL,
  short_pumps varchar(30) default NULL,
  ports varchar(255) default NULL,
  custom varchar(255) default NULL,
  filter varchar(255) default NULL,
  auto varchar(255) default NULL,
  shield varchar(255) default NULL,
  pumps varchar(255) default NULL,
  safety varchar(255) default NULL,
  light varchar(255) default NULL,
  protect varchar(255) default NULL,
  quote1 mediumtext,
  cust1 varchar(50) default NULL,
  quote2 mediumtext,
  cust2 varchar(50) default NULL,
  PRIMARY KEY  (tub),
  KEY tub_series (series)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- 
-- Dumping data for table tub
-- 

INSERT INTO tub VALUES (300, '321', 0, 'Shown in Beachwood', 'beachwood', 'natural_enviro', 'Medium', '4-5', '198 x 86', '916', '193', '1109', '10', '10-46', '2.5', '5 locations selected to enable you to choose the type of therapy for your personalised body massage', 'Customise this 320m from a minimum of 5-35 different types of jetting combinations at no cost', 'High performing, efficient water cleaning system', 'Adjustable heating and cleaning cycles', 'Tight thermos bottle seal to save energy and money', 'Economical 1 hp pump with stainless steel heater', 'Built to the highest standards available', 'Mood setting and safety for entry and exit', 'A no-fine-print, straightforward customer guarantee', 'Over the past year, our Beachcomber Hot Tub has been in constant use... When I wake up stiff and sore, sitting in my hot tub eases all stiffness and I''m ready to go again.', 'Brenda & Brian Kalyn', 'Purchasing our Beachcomber Hot Tub was one of the best moves we''ve made!  We actually look forward to those cold, snowy nights when we submerge ourselves and enjoy therapeutic qualities of water in our Beachcomber Hot Tub.', 'Janic & Brad Chalmers');
INSERT INTO tub VALUES (300, '350', 0, 'Shown in Rainforest', 'midnight', 'natural_enviro', 'Large', '6', '203 x 224 x 97', '1419', '295', '1714', '23', '24-86', '3.5', '13 locations selected to enable you to choose the type of therapy for your personalised body massage', 'Customise this 350 from a minimum of 13-64 different types of jetting combinations at no cost', 'High performing, efficient water cleaning system', 'Easy programming for heating and filtering to save money', 'Tight thermos bottle seal to save energy and money', 'Powerful 2 hp pump with stainless steel heater', 'Built to the highest standards available', 'Mood setting and safety for entry and exit', 'A no-fine-print, straightforward customer guarantee', 'I cannot think of any better way of treating a physically and mentally stressed body except with heat, water and the massage action of my Beachcomber Hot Tub.', 'Bill Stephenson', 'We just purchased a Beachcomber - what a fantastic way to relax!  My wife and I work every day and look forward to an evening of total relaxation and a good night''s sleep.  We have a family night twice a week.  The kids love it, and so does my mother, dad, sister, brother, etc.  Keep up the good work.  I tell everyone I can.', 'Terry & Joan Belleau');
INSERT INTO tub VALUES (300, '310', 0, 'Shown in Sterling', 'quartzite', 'twilight_enviro', 'Small', '2+', '145 x 191 x 76', '662', '193', '855', '13', '14-48', '2.5', '14 locations selected to enable you to choose the type of therapy for your personalised body massage', 'Customise this 520 from a minimum of 18-42 different types of jetting combinations at no cost', 'High performing, efficient water cleaning system', 'Easy programming for heating and filtering to save money', 'Tight thermos bottle seal to save energy and money', 'Powerful 1.5 hp pump with stainless steel heater', 'Built to the highest standards available', 'Mood setting and safety for entry and exit', 'A no-fine-print, straightforward customer guarantee', NULL, NULL, NULL, NULL);
INSERT INTO tub VALUES (500, '540', 0, 'Shown in Tropical Mist', 'quartzite', 'walnut_enviro', 'Medium', '5-6', '178 x 218 x 97', '1139', '272', '1408', '25', '26-84', '3.5 plus blower', '15 locations selected to enable you to choose the type of therapy for your personalised body massage', 'Customise this 530 from a minimum of 15-70 different types of jetting combinations at no cost', 'High performing, efficient water cleaning system', 'Easy programming for heating and filtering to save money', 'Tight thermos bottle seal to save energy and money', 'Powerful 2.5 hp pump with stainless steel heater', 'Built to the highest standards available', 'Mood setting and safety for entry and exit', 'A no-fine-print, straightforward customer guarantee', NULL, NULL, NULL, NULL);
INSERT INTO tub VALUES (500, '550', 0, 'Shown in Azure', 'glacier', 'twilight_enviro', 'Large', '6-8', '203 x 224 x 97', '1438', '295', '1733', '27', '28-88', '3.5 plus blower', '20 locations selected to enable you to choose the type of therapy for your personalised body massage', 'Customise this 550x from a minimum of 24-90 different types of jetting combinations at no cost', 'High performing, efficient water cleaning system', 'Easy programming for heating and filtering to save money', 'Tight thermos bottle seal to save energy and money', 'Powerful 3.5 hp pump with stainless steel heater', 'Built to the highest standards available', 'Mood setting and safety for entry and exit', 'A no-fine-print, straightforward customer guarantee', NULL, NULL, NULL, NULL);
INSERT INTO tub VALUES (300, '380', 0, 'Shown in Garnet', 'carbon', 'ebony_enviro', 'Large', '7-8', '226 x 226 x 97', '1582', '329', '1911', '23', '24-84', '3.5', '25 locations selected to enable you to choose the type of therapy for your personalised body massage', 'Customise this 580 from a minimum of 29-100 different types of jetting combinations at no cost', 'High performing, efficient water cleaning system', 'Easy programming for heating and filtering to save money', 'Tight thermos bottle seal to save energy and money', 'Powerful 4.5 hp pump with stainless steel heater', 'Built to the highest standards available', 'Mood setting and safety for entry and exit', 'A no-fine-print, straightforward customer guarantee', NULL, NULL, NULL, NULL);
INSERT INTO tub VALUES (700, '720', 0, 'Shown in Azure', 'sandstone', 'walnut_enviro', 'Medium', '7-9', '203 x 224 x 97', '1370', '306', '1676', '32', '33-123', '2.5 + 3.5 plus blower', '19 locations selected to enable you to choose the type of therapy for your personalised body massage', 'Customise this 720 from a minimum of 21-98 different types of jetting combinations at no cost', 'High performing, efficient water cleaning system', 'Easy programming for heating and filtering to save money', 'Tight thermos bottle seal to save energy and money', 'Powerful twin 1.5 hp pumps with stainless steel heater', 'Built to the highest standards available', 'Mood setting and safety for entry and exit', 'A no-fine-print, straightforward customer guarantee', NULL, NULL, NULL, NULL);
INSERT INTO tub VALUES (700, '725', 0, 'Shown in Denim', 'beachwood', 'twilight_enviro', 'Medium', '6-7', '203 x 224 x 97', '1268', '306', '1574', '33', '34-126', '2.5 + 3.5 plus blower', '27 locations selected to enable you to choose the type of therapy for your personalised body massage', 'Customise this 720x from a minimum of 32-139 different types of jetting combinations at no cost', 'High performing, efficient water cleaning system', 'Easy programming for heating and filtering to save money', 'Tight thermos bottle seal to save energy and money', 'Powerful 1.5 and 3.5 hp pumps with stainless steel heater', 'Built to the highest standards available', 'Mood setting and safety for entry and exit', 'A no-fine-print, straightforward customer guarantee', NULL, NULL, NULL, NULL);
INSERT INTO tub VALUES (700, '740', 0, 'Shown in Tropical Mist', 'glacier', 'twilight_enviro', 'Large', '6-7', '226 x 226 x 97', '1525', '363', '1888', '45', '46-155', 'Twin 3.5 plus blower', '37 locations selected to enable you to choose the type of therapy for your personalised body massage', 'Customise this 740 from a minimum of 48-155 different types of jetting combinations at no cost', 'High performing, efficient water cleaning system', 'Easy programming for heating and filtering to save money', 'Tight thermos bottle seal to save energy and money', 'Powerful twin 3.5 hp pumps with stainless steel heater', 'Built to the highest standards available', 'Mood setting and safety for entry and exit', 'A no-fine-print, straightforward customer guarantee', NULL, NULL, NULL, NULL);
INSERT INTO tub VALUES (700, '750', 0, 'Shown in Seamist', 'oyster-pearl', 'ebony_enviro', 'Large', '8-9', '226 x 226 x 97', '1654', '363', '2017', '45', '47-168', 'Twin 3.5 plus blower', '38 locations selected to enable you to choose the type of therapy for your personalised body massage', 'Customise this 750 from a minimum of 41-147 different types of jetting combinations at no cost', 'High performing, efficient water cleaning system', 'Easy programming for heating and filtering to save money', 'Tight thermos bottle seal to save energy and money', 'Powerful 3.5 and 4.5 hp pumps with stainless steel heater', 'Built to the highest standards available', 'Mood setting and safety for entry and exit', 'A no-fine-print, straightforward customer guarantee', 'The whole family absolutely loves to spend time in our Beachcomber Hot Tub.  It is great to get in and relax.  It relieves tension, aches and pains.', 'The Deerie Family', 'One Saturday we decided to stop and visit some hot tub companies.  Beachcomber welcomed us and put us at ease.  Within an hour we decided on the hot tub, colour and size.  Thank you Beachcomber, for a suberb job in building a quality hot tub for us.', 'Doug Heath');
INSERT INTO tub VALUES (500, '578', 0, 'Many special features available including the unique Acqucoustic surround sound', 'cobalt', 'ebony_enviro', 'Medium', '7-8', '203 x 224 x 97', '1370', '295', '1665', '28', '30-94', '3.5 plus blower', '23 locations selected to enable you to choose the type of therapy for your personalised body massage', 'Customise this 578 from a minimum of 22-71 different types of jetting combinations at no cost', 'High performing, efficient water cleaning system', 'Easy programming for heating and filtering to save money', 'Tight thermos bottle seal to save energy and money', 'Powerful 2 hp pump with stainless steel heater', 'Built to the highest standards available', 'Mood setting and safety for entry and exit', 'A no-fine-print, straightforward customer guarantee', NULL, NULL, NULL, NULL);
INSERT INTO tub VALUES (300, '340', 0, NULL, 'opal', 'natural_enviro', 'Small', '5', '178 x 218 x 86', '1136', '290', '1426', '20', '21-81', '2.5', '13 locations selected to enable you to choose the type of therapy for your personalised body massage', 'Customise this 350 from a minimum of 13-25 different types of jetting combinations at no cost', 'High performing, efficient water cleaning system', 'Easy programming for heating and filtering to save money', 'Tight thermos bottle seal to save energy and money', 'Powerful 1.5 hp pump with stainless steel heater', 'Built to the highest standards available', 'Mood setting and safety for entry and exit', 'A no-fine-print, straightforward customer guarantee', NULL, NULL, NULL, NULL);
INSERT INTO tub VALUES (300, '360', 0, NULL, 'alabaster', 'ebony_enviro', NULL, '6-7', '203 x 224 x 97', '1306', '295', '1601', '23', '24-82', '3.5', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
