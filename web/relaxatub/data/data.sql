-- --------------------------------------------------------
-- Relaxatub
-- Copyright (c) 2006 Frontburner
-- Author Craig McKay <craig@frontburner.co.uk>
--
-- $Id$
--
-- GRANT ALL PRIVILEGES ON *.* TO 'relaxatub'@'localhost' IDENTIFIED BY 'hazel44' WITH GRANT OPTION;
-- SET PASSWORD FOR 'relaxatub'@'localhost' = OLD_PASSWORD('hazel44');
-- --------------------------------------------------------
-- phpMyAdmin SQL Dump
-- version 2.9.0.2
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Mar 29, 2007 at 10:58 PM
-- Server version: 4.1.22
-- PHP Version: 5.1.6
--
-- Database: relaxatub_com_-_prod
-- --------------------------------------------------------

--
-- Table structure for table acc
--

CREATE TABLE acc (
  acc int(11) NOT NULL default '0',
  accName varchar(100) NOT NULL default '',
  dispOrder int(11) NOT NULL default '0',
  photo varchar(100) default '0',
  PRIMARY KEY  (acc)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COMMENT='Accessories';

--
-- Dumping data for table acc
--

INSERT INTO acc VALUES (94889, 'Lift''n''Store', 100, '94889.jpg');
INSERT INTO acc VALUES (95086, 'Slide''n''Store', 110, '95086.jpg');
INSERT INTO acc VALUES (94888, 'Swingbrella', 120, 'swing1.jpg');
INSERT INTO acc VALUES (94891, 'Drinks Bar complete with 2 Stools', 130, NULL);
INSERT INTO acc VALUES (94899, 'Spa Chemical Starter Pack', 140, NULL);
INSERT INTO acc VALUES (94887, 'Mini Step', 150, NULL);
INSERT INTO acc VALUES (95091, 'Portable Step', 160, 'portablestep1.jpg');
INSERT INTO acc VALUES (95046, 'Circular Spa Portable Step', 170, NULL);
INSERT INTO acc VALUES (94902, '25 sq.ft Filter Element', 180, NULL);
INSERT INTO acc VALUES (94904, '50 sq.ft Filter Element', 190, NULL);
INSERT INTO acc VALUES (94952, 'Holiday Tender', 200, NULL);
INSERT INTO acc VALUES (95070, 'Nu Wood', 210, NULL);
INSERT INTO acc VALUES (95048, 'Filter Cleaning Cannister', 220, NULL);
INSERT INTO acc VALUES (94700, 'Spa Wand', 230, NULL);

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

INSERT INTO tub VALUES (300, '320x', 0, 'Shown in Beachwood', 'beachwood.jpg', 'natural_enviroskirt.jpg', 'Medium', '7-8', '198 x 76 cm', '833 Litres', '193 kg', '1026 kg', '5 locations selected to enable you to choose the type of therapy for your personalised body massage', 'Customise this 320m from a minimum of 5-35 different types of jetting combinations at no cost', 'High performing, efficient water cleaning system', 'Adjustable heating and cleaning cycles', 'Tight thermos bottle seal to save energy and money', 'Economical 1 hp pump with stainless steel heater', 'Built to the highest standards available', 'Mood setting and safety for entry and exit', 'A no-fine-print, straightforward customer guarantee', 'Over the past year, our Beachcomber Hot Tub has been in constant use... When I wake up stiff and sore, sitting in my hot tub eases all stiffness and I''m ready to go again.', 'Brenda & Brian Kalyn', 'Purchasing our Beachcomber Hot Tub was one of the best moves we''ve made!  We actually look forward to those cold, snowy nights when we submerge ourselves and enjoy therapeutic qualities of water in our Beachcomber Hot Tub.', 'Janic & Brad Chalmers');
INSERT INTO tub VALUES (300, '350', 0, 'Shown in Rainforest', 'midnight.jpg', 'natural_enviroskirt.jpg', 'Large', '8-9', '203 x 224 x 91 cm', '1363 Litres', '295 kg', '1658 kg', '13 locations selected to enable you to choose the type of therapy for your personalised body massage', 'Customise this 350 from a minimum of 13-64 different types of jetting combinations at no cost', 'High performing, efficient water cleaning system', 'Easy programming for heating and filtering to save money', 'Tight thermos bottle seal to save energy and money', 'Powerful 2 hp pump with stainless steel heater', 'Built to the highest standards available', 'Mood setting and safety for entry and exit', 'A no-fine-print, straightforward customer guarantee', 'I cannot think of any better way of treating a physically and mentally stressed body except with heat, water and the massage action of my Beachcomber Hot Tub.', 'Bill Stephenson', 'We just purchased a Beachcomber - what a fantastic way to relax!  My wife and I work every day and look forward to an evening of total relaxation and a good night''s sleep.  We have a family night twice a week.  The kids love it, and so does my mother, dad, sister, brother, etc.  Keep up the good work.  I tell everyone I can.', 'Terry & Joan Belleau');
INSERT INTO tub VALUES (500, '520', 0, 'Shown in Sterling', 'quartzite.jpg', 'twilight_enviroskirt.jpg', 'Small', '2+', '145 x 190 x 76 cm', '701 Litres', '193 kg', '894 kg', '14 locations selected to enable you to choose the type of therapy for your personalised body massage', 'Customise this 520 from a minimum of 18-42 different types of jetting combinations at no cost', 'High performing, efficient water cleaning system', 'Easy programming for heating and filtering to save money', 'Tight thermos bottle seal to save energy and money', 'Powerful 1.5 hp pump with stainless steel heater', 'Built to the highest standards available', 'Mood setting and safety for entry and exit', 'A no-fine-print, straightforward customer guarantee', NULL, NULL, NULL, NULL);
INSERT INTO tub VALUES (500, '530', 0, 'Shown in Tropical Mist', 'quartzite.jpg', 'walnut_enviroskirt.jpg', 'Medium', '6-7', '179 x 218 x 91 cm', '1000 Litres', '273 kg', '1273 kg', '15 locations selected to enable you to choose the type of therapy for your personalised body massage', 'Customise this 530 from a minimum of 15-70 different types of jetting combinations at no cost', 'High performing, efficient water cleaning system', 'Easy programming for heating and filtering to save money', 'Tight thermos bottle seal to save energy and money', 'Powerful 2.5 hp pump with stainless steel heater', 'Built to the highest standards available', 'Mood setting and safety for entry and exit', 'A no-fine-print, straightforward customer guarantee', NULL, NULL, NULL, NULL);
INSERT INTO tub VALUES (500, '538', 0, 'Shown in Graphite', 'tungsten.jpg', 'walnut_enviroskirt.jpg', 'Large', '8-9', '203 x 224 x 91 cm', '1363 Litres', '295 kg', '1658 kg', '15 locations selected to enable you to choose the type of therapy for your personalised body massage', 'Customise this 550 from a minimum of 15-70 different types of jetting combinations at no cost', 'High performing, efficient water cleaning system', 'Easy programming for heating and filtering to save money', 'Tight thermos bottle seal to save energy and money', 'Powerful 2.5 hp pump with stainless steel heater', 'Built to the highest standards available', 'Mood setting and safety for entry and exit', 'A no-fine-print, straightforward customer guarantee', 'When we use our Beachcomber Hot Tub, it''s one of the few times we get to relax and talk together.  We look forward to a private time in the tub.  No distractions, just us and our dreams.', 'Lyndon & Heather Thorness', 'Thank you for the return call a while back.  I ordered your video, but it wasn''t the video that sold me.  It was your attitude towards your customers.  We took delivery of our new Beachcomber Hot Tub and took our first soak Christmas eve.  What an enjoyable experience!  As a matter of fact, we haven''t missed a night yet.  We expect to get years of enjoyment from our investment.', 'Don & Lou Fornsdahl');
INSERT INTO tub VALUES (500, '550x', 0, 'Shown in Azure', 'glacier.jpg', 'twilight_enviroskirt.jpg', 'Large', '8-9', '203 x 224 x 91 cm', '1363 Litres', '295 kg', '1658 kg', '20 locations selected to enable you to choose the type of therapy for your personalised body massage', 'Customise this 550x from a minimum of 24-90 different types of jetting combinations at no cost', 'High performing, efficient water cleaning system', 'Easy programming for heating and filtering to save money', 'Tight thermos bottle seal to save energy and money', 'Powerful 3.5 hp pump with stainless steel heater', 'Built to the highest standards available', 'Mood setting and safety for entry and exit', 'A no-fine-print, straightforward customer guarantee', NULL, NULL, NULL, NULL);
INSERT INTO tub VALUES (500, '580', 0, 'Shown in Garnet', 'carbon.jpg', 'ebony_enviroskirt.jpg', 'Large', '8-10', '226 x 226 x 91 cm', '1515 Litres', '329 kg', '1844 kg', '25 locations selected to enable you to choose the type of therapy for your personalised body massage', 'Customise this 580 from a minimum of 29-100 different types of jetting combinations at no cost', 'High performing, efficient water cleaning system', 'Easy programming for heating and filtering to save money', 'Tight thermos bottle seal to save energy and money', 'Powerful 4.5 hp pump with stainless steel heater', 'Built to the highest standards available', 'Mood setting and safety for entry and exit', 'A no-fine-print, straightforward customer guarantee', NULL, NULL, NULL, NULL);
INSERT INTO tub VALUES (700, '720', 0, 'Shown in Azure', 'sandstone.jpg', 'walnut_enviroskirt.jpg', 'Medium', '7-8', '203 x 224 x 91 cm', '1325 Litres', '307 kg', '1632 kg', '19 locations selected to enable you to choose the type of therapy for your personalised body massage', 'Customise this 720 from a minimum of 21-98 different types of jetting combinations at no cost', 'High performing, efficient water cleaning system', 'Easy programming for heating and filtering to save money', 'Tight thermos bottle seal to save energy and money', 'Powerful twin 1.5 hp pumps with stainless steel heater', 'Built to the highest standards available', 'Mood setting and safety for entry and exit', 'A no-fine-print, straightforward customer guarantee', NULL, NULL, NULL, NULL);
INSERT INTO tub VALUES (700, '720x', 0, 'Shown in Denim', 'beachwood.jpg', 'twilight_enviroskirt.jpg', 'Medium', '7-8', '203 x 224 x 91 cm', '1325 Litres', '307 kg', '1632 kg', '27 locations selected to enable you to choose the type of therapy for your personalised body massage', 'Customise this 720x from a minimum of 32-139 different types of jetting combinations at no cost', 'High performing, efficient water cleaning system', 'Easy programming for heating and filtering to save money', 'Tight thermos bottle seal to save energy and money', 'Powerful 1.5 and 3.5 hp pumps with stainless steel heater', 'Built to the highest standards available', 'Mood setting and safety for entry and exit', 'A no-fine-print, straightforward customer guarantee', NULL, NULL, NULL, NULL);
INSERT INTO tub VALUES (700, '738', 0, 'Shown in Graphite', 'cobalt.jpg', 'sequoia_enviroskirt.jpg', 'Large', '8-9', '226 x 226 x 91 cm', '1507 Litres', '341 kg', '1848 kg', '31 locations selected to enable you to choose the type of therapy for your personalised body massage', 'Customise this 730 from a minimum of 41-152 different types of jetting combinations at no cost', 'High performing, efficient water cleaning system', 'Easy programming for heating and filtering to save money', 'Tight thermos bottle seal to save energy and money', 'Powerful 2.5 and 3.5 hp pumps with stainless steel heater', 'Built to the highest standards available', 'Mood setting and safety for entry and exit', 'A no-fine-print, straightforward customer guarantee', NULL, NULL, NULL, NULL);
INSERT INTO tub VALUES (700, '740', 0, 'Shown in Tropical Mist', 'glacier.jpg', 'twilight_enviroskirt.jpg', 'Large', '8-9', '226 x 226 x 91 cm', '1807 Litres', '363 kg', '1870 kg', '37 locations selected to enable you to choose the type of therapy for your personalised body massage', 'Customise this 740 from a minimum of 48-155 different types of jetting combinations at no cost', 'High performing, efficient water cleaning system', 'Easy programming for heating and filtering to save money', 'Tight thermos bottle seal to save energy and money', 'Powerful twin 3.5 hp pumps with stainless steel heater', 'Built to the highest standards available', 'Mood setting and safety for entry and exit', 'A no-fine-print, straightforward customer guarantee', NULL, NULL, NULL, NULL);
INSERT INTO tub VALUES (700, '750', 0, 'Shown in Seamist', 'oyster-pearl.jpg', 'ebony_enviroskirt.jpg', 'Large', '8-10', '226 x 226 x 91 cm', '1807 Litres', '363 kg', '1870 kg', '38 locations selected to enable you to choose the type of therapy for your personalised body massage', 'Customise this 750 from a minimum of 41-147 different types of jetting combinations at no cost', 'High performing, efficient water cleaning system', 'Easy programming for heating and filtering to save money', 'Tight thermos bottle seal to save energy and money', 'Powerful 3.5 and 4.5 hp pumps with stainless steel heater', 'Built to the highest standards available', 'Mood setting and safety for entry and exit', 'A no-fine-print, straightforward customer guarantee', 'The whole family absolutely loves to spend time in our Beachcomber Hot Tub.  It is great to get in and relax.  It relieves tension, aches and pains.', 'The Deerie Family', 'One Saturday we decided to stop and visit some hot tub companies.  Beachcomber welcomed us and put us at ease.  Within an hour we decided on the hot tub, colour and size.  Thank you Beachcomber, for a suberb job in building a quality hot tub for us.', 'Doug Heath');
INSERT INTO tub VALUES (500, '578', 0, 'Many special features available including the unique Acqucoustic surround sound', 'cobalt.jpg', 'ebony_enviroskirt.jpg', 'Medium', '6-8', '203 x 224 x 97 cm', '1363 litres', '295kg', '1658kg', '23 locations selected to enable you to choose the type of therapy for your personalised body massage', 'Customise this 578 from a minimum of 22-71 different types of jetting combinations at no cost', 'High performing, efficient water cleaning system', 'Easy programming for heating and filtering to save money', 'Tight thermos bottle seal to save energy and money', 'Powerful 2 hp pump with stainless steel heater', 'Built to the highest standards available', 'Mood setting and safety for entry and exit', 'A no-fine-print, straightforward customer guarantee', NULL, NULL, NULL, NULL);
INSERT INTO tub VALUES (300, '160L', 0, NULL, 'glacier.jpg', 'natural_enviroskirt.jpg', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
