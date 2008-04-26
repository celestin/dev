-- --------------------------------------------------------
-- Relaxatub
-- Copyright (c) 2006,2008 Frontburner
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
-- Generation Time: Apr 26, 2008 at 12:11 PM
-- Server version: 5.0.27
-- PHP Version: 4.4.5
-- 
-- Database: relaxatub_com_-_prod
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

INSERT INTO tub VALUES (300, '320x', 0, 'Shown in Beachwood', 'beachwood.jpg', 'natural_enviroskirt.jpg', 'Medium', '7-8', '198 x 76', '833', '193', '1026', '5', '5-35', '1', '5 locations selected to enable you to choose the type of therapy for your personalised body massage', 'Customise this 320m from a minimum of 5-35 different types of jetting combinations at no cost', 'High performing, efficient water cleaning system', 'Adjustable heating and cleaning cycles', 'Tight thermos bottle seal to save energy and money', 'Economical 1 hp pump with stainless steel heater', 'Built to the highest standards available', 'Mood setting and safety for entry and exit', 'A no-fine-print, straightforward customer guarantee', 'Over the past year, our Beachcomber Hot Tub has been in constant use... When I wake up stiff and sore, sitting in my hot tub eases all stiffness and I''m ready to go again.', 'Brenda & Brian Kalyn', 'Purchasing our Beachcomber Hot Tub was one of the best moves we''ve made!  We actually look forward to those cold, snowy nights when we submerge ourselves and enjoy therapeutic qualities of water in our Beachcomber Hot Tub.', 'Janic & Brad Chalmers');
INSERT INTO tub VALUES (300, '350H', 0, 'Shown in Rainforest', 'midnight.jpg', 'natural_enviroskirt.jpg', 'Large', '6', '203 x 224 x 91', '1363', '295', '1658', '13', '13-64', '2.5', '13 locations selected to enable you to choose the type of therapy for your personalised body massage', 'Customise this 350 from a minimum of 13-64 different types of jetting combinations at no cost', 'High performing, efficient water cleaning system', 'Easy programming for heating and filtering to save money', 'Tight thermos bottle seal to save energy and money', 'Powerful 2 hp pump with stainless steel heater', 'Built to the highest standards available', 'Mood setting and safety for entry and exit', 'A no-fine-print, straightforward customer guarantee', 'I cannot think of any better way of treating a physically and mentally stressed body except with heat, water and the massage action of my Beachcomber Hot Tub.', 'Bill Stephenson', 'We just purchased a Beachcomber - what a fantastic way to relax!  My wife and I work every day and look forward to an evening of total relaxation and a good night''s sleep.  We have a family night twice a week.  The kids love it, and so does my mother, dad, sister, brother, etc.  Keep up the good work.  I tell everyone I can.', 'Terry & Joan Belleau');
INSERT INTO tub VALUES (300, '310', 0, 'Shown in Sterling', 'quartzite.jpg', 'twilight_enviroskirt.jpg', 'Small', '2+', '145 x 190 x 76', '701', '193', '894', '14', '18-42', '2.5', '14 locations selected to enable you to choose the type of therapy for your personalised body massage', 'Customise this 520 from a minimum of 18-42 different types of jetting combinations at no cost', 'High performing, efficient water cleaning system', 'Easy programming for heating and filtering to save money', 'Tight thermos bottle seal to save energy and money', 'Powerful 1.5 hp pump with stainless steel heater', 'Built to the highest standards available', 'Mood setting and safety for entry and exit', 'A no-fine-print, straightforward customer guarantee', NULL, NULL, NULL, NULL);
INSERT INTO tub VALUES (500, '530', 0, 'Shown in Tropical Mist', 'quartzite.jpg', 'walnut_enviroskirt.jpg', 'Medium', '6-7', '179 x 218 x 91', '1000', '273', '1273', '15', '15-70', '2.5', '15 locations selected to enable you to choose the type of therapy for your personalised body massage', 'Customise this 530 from a minimum of 15-70 different types of jetting combinations at no cost', 'High performing, efficient water cleaning system', 'Easy programming for heating and filtering to save money', 'Tight thermos bottle seal to save energy and money', 'Powerful 2.5 hp pump with stainless steel heater', 'Built to the highest standards available', 'Mood setting and safety for entry and exit', 'A no-fine-print, straightforward customer guarantee', NULL, NULL, NULL, NULL);
INSERT INTO tub VALUES (500, '538', 0, 'Shown in Graphite', 'tungsten.jpg', 'walnut_enviroskirt.jpg', 'Large', '8-9', '203 x 224 x 91', '1363', '295', '1658', '15', '15-70', '2.5', '15 locations selected to enable you to choose the type of therapy for your personalised body massage', 'Customise this 550 from a minimum of 15-70 different types of jetting combinations at no cost', 'High performing, efficient water cleaning system', 'Easy programming for heating and filtering to save money', 'Tight thermos bottle seal to save energy and money', 'Powerful 2.5 hp pump with stainless steel heater', 'Built to the highest standards available', 'Mood setting and safety for entry and exit', 'A no-fine-print, straightforward customer guarantee', 'When we use our Beachcomber Hot Tub, it''s one of the few times we get to relax and talk together.  We look forward to a private time in the tub.  No distractions, just us and our dreams.', 'Lyndon & Heather Thorness', 'Thank you for the return call a while back.  I ordered your video, but it wasn''t the video that sold me.  It was your attitude towards your customers.  We took delivery of our new Beachcomber Hot Tub and took our first soak Christmas eve.  What an enjoyable experience!  As a matter of fact, we haven''t missed a night yet.  We expect to get years of enjoyment from our investment.', 'Don & Lou Fornsdahl');
INSERT INTO tub VALUES (500, '550x', 0, 'Shown in Azure', 'glacier.jpg', 'twilight_enviroskirt.jpg', 'Large', '8-9', '203 x 224 x 91', '1363', '295', '1658', '20', '24-90', '3.5', '20 locations selected to enable you to choose the type of therapy for your personalised body massage', 'Customise this 550x from a minimum of 24-90 different types of jetting combinations at no cost', 'High performing, efficient water cleaning system', 'Easy programming for heating and filtering to save money', 'Tight thermos bottle seal to save energy and money', 'Powerful 3.5 hp pump with stainless steel heater', 'Built to the highest standards available', 'Mood setting and safety for entry and exit', 'A no-fine-print, straightforward customer guarantee', NULL, NULL, NULL, NULL);
INSERT INTO tub VALUES (300, '378', 0, 'Shown in Garnet', 'carbon.jpg', 'ebony_enviroskirt.jpg', 'Large', '8-9', '226 x 226 x 97', '1515', '329', '1844', '22', '29-100', '3.5', '25 locations selected to enable you to choose the type of therapy for your personalised body massage', 'Customise this 580 from a minimum of 29-100 different types of jetting combinations at no cost', 'High performing, efficient water cleaning system', 'Easy programming for heating and filtering to save money', 'Tight thermos bottle seal to save energy and money', 'Powerful 4.5 hp pump with stainless steel heater', 'Built to the highest standards available', 'Mood setting and safety for entry and exit', 'A no-fine-print, straightforward customer guarantee', NULL, NULL, NULL, NULL);
INSERT INTO tub VALUES (700, '720', 0, 'Shown in Azure', 'sandstone.jpg', 'walnut_enviroskirt.jpg', 'Medium', '7-8', '203 x 224 x 91', '1325', '307', '1632', '19', '21-98', 'Twin 1.5', '19 locations selected to enable you to choose the type of therapy for your personalised body massage', 'Customise this 720 from a minimum of 21-98 different types of jetting combinations at no cost', 'High performing, efficient water cleaning system', 'Easy programming for heating and filtering to save money', 'Tight thermos bottle seal to save energy and money', 'Powerful twin 1.5 hp pumps with stainless steel heater', 'Built to the highest standards available', 'Mood setting and safety for entry and exit', 'A no-fine-print, straightforward customer guarantee', NULL, NULL, NULL, NULL);
INSERT INTO tub VALUES (700, '720x', 0, 'Shown in Denim', 'beachwood.jpg', 'twilight_enviroskirt.jpg', 'Medium', '7-8', '203 x 224 x 91', '1325', '307', '1632', '27', '32-139', '1.5 and 3.5', '27 locations selected to enable you to choose the type of therapy for your personalised body massage', 'Customise this 720x from a minimum of 32-139 different types of jetting combinations at no cost', 'High performing, efficient water cleaning system', 'Easy programming for heating and filtering to save money', 'Tight thermos bottle seal to save energy and money', 'Powerful 1.5 and 3.5 hp pumps with stainless steel heater', 'Built to the highest standards available', 'Mood setting and safety for entry and exit', 'A no-fine-print, straightforward customer guarantee', NULL, NULL, NULL, NULL);
INSERT INTO tub VALUES (700, '738', 0, 'Shown in Graphite', 'cobalt.jpg', 'sequoia_enviroskirt.jpg', 'Large', '8-9', '226 x 226 x 91', '1507', '341', '1848', '31', '41-152', '2.5 and 3.5', '31 locations selected to enable you to choose the type of therapy for your personalised body massage', 'Customise this 730 from a minimum of 41-152 different types of jetting combinations at no cost', 'High performing, efficient water cleaning system', 'Easy programming for heating and filtering to save money', 'Tight thermos bottle seal to save energy and money', 'Powerful 2.5 and 3.5 hp pumps with stainless steel heater', 'Built to the highest standards available', 'Mood setting and safety for entry and exit', 'A no-fine-print, straightforward customer guarantee', NULL, NULL, NULL, NULL);
INSERT INTO tub VALUES (700, '740', 0, 'Shown in Tropical Mist', 'glacier.jpg', 'twilight_enviroskirt.jpg', 'Large', '8-9', '226 x 226 x 91', '1807', '363', '1870', '37', '48-155', 'Twin 3.5', '37 locations selected to enable you to choose the type of therapy for your personalised body massage', 'Customise this 740 from a minimum of 48-155 different types of jetting combinations at no cost', 'High performing, efficient water cleaning system', 'Easy programming for heating and filtering to save money', 'Tight thermos bottle seal to save energy and money', 'Powerful twin 3.5 hp pumps with stainless steel heater', 'Built to the highest standards available', 'Mood setting and safety for entry and exit', 'A no-fine-print, straightforward customer guarantee', NULL, NULL, NULL, NULL);
INSERT INTO tub VALUES (700, '750', 0, 'Shown in Seamist', 'oyster-pearl.jpg', 'ebony_enviroskirt.jpg', 'Large', '8-10', '226 x 226 x 91', '1807', '363', '1870', '38', '41-147', '3.5 and 4.5', '38 locations selected to enable you to choose the type of therapy for your personalised body massage', 'Customise this 750 from a minimum of 41-147 different types of jetting combinations at no cost', 'High performing, efficient water cleaning system', 'Easy programming for heating and filtering to save money', 'Tight thermos bottle seal to save energy and money', 'Powerful 3.5 and 4.5 hp pumps with stainless steel heater', 'Built to the highest standards available', 'Mood setting and safety for entry and exit', 'A no-fine-print, straightforward customer guarantee', 'The whole family absolutely loves to spend time in our Beachcomber Hot Tub.  It is great to get in and relax.  It relieves tension, aches and pains.', 'The Deerie Family', 'One Saturday we decided to stop and visit some hot tub companies.  Beachcomber welcomed us and put us at ease.  Within an hour we decided on the hot tub, colour and size.  Thank you Beachcomber, for a suberb job in building a quality hot tub for us.', 'Doug Heath');
INSERT INTO tub VALUES (500, '578', 0, 'Many special features available including the unique Acqucoustic surround sound', 'cobalt.jpg', 'ebony_enviroskirt.jpg', 'Medium', '6-8', '203 x 224 x 97', '1363', '295', '1658', '23', '22-71', '2', '23 locations selected to enable you to choose the type of therapy for your personalised body massage', 'Customise this 578 from a minimum of 22-71 different types of jetting combinations at no cost', 'High performing, efficient water cleaning system', 'Easy programming for heating and filtering to save money', 'Tight thermos bottle seal to save energy and money', 'Powerful 2 hp pump with stainless steel heater', 'Built to the highest standards available', 'Mood setting and safety for entry and exit', 'A no-fine-print, straightforward customer guarantee', NULL, NULL, NULL, NULL);
INSERT INTO tub VALUES (300, '160L', 0, NULL, 'glacier.jpg', 'natural_enviroskirt.jpg', 'Small', '5-6', '203 x 224 x 97', '1363', '295', '1658', '13', '13-25', '1.5', '13 locations selected to enable you to choose the type of therapy for your personalised body massage', 'Customise this 350 from a minimum of 13-25 different types of jetting combinations at no cost', 'High performing, efficient water cleaning system', 'Easy programming for heating and filtering to save money', 'Tight thermos bottle seal to save energy and money', 'Powerful 1.5 hp pump with stainless steel heater', 'Built to the highest standards available', 'Mood setting and safety for entry and exit', 'A no-fine-print, straightforward customer guarantee', NULL, NULL, NULL, NULL);
INSERT INTO tub VALUES (300, '360', 0, NULL, 'alabaster.jpg', 'ebony_enviroskirt.jpg', NULL, '6-7', '203 x 224 x 97', '1364', '295', '1658', '23', '28-86', '3.5', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
