-- --------------------------------------------------------
-- West Coast Express
-- Copyright (c) 2006-2007 Frontburner
-- Author Craig McKay <craig@frontburner.co.uk>
--
-- $Id$
-- --------------------------------------------------------
-- phpMyAdmin SQL Dump
-- version 2.9.2
-- http://www.phpmyadmin.net
-- 
-- Host: localhost
-- Generation Time: Aug 11, 2007 at 11:36 AM
-- Server version: 5.0.27
-- PHP Version: 4.4.5
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
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COMMENT='User Information';

-- 
-- Dumping data for table member
-- 

INSERT INTO member VALUES ('CRAIG', 'Craig', 'McKay', 'craig@southesk.com', '0954bfb4e59e3d85ff989944a65f6955', 1, 'A', '0', 1, '1975-09-13', '0000-00-00 00:00:00', '2007-08-11 11:19:47');
INSERT INTO member VALUES ('BOB', 'Bob', 'Bain', '', 'b193cacd08f36cfa4f0c165a48255497', 1, 'A', '0', 1, '1950-01-01', '0000-00-00 00:00:00', '2007-02-03 08:06:43');

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
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 COMMENT='Photo Gallery' AUTO_INCREMENT=84 ;

-- 
-- Dumping data for table photos
-- 

INSERT INTO photos VALUES(1, 'boat1.jpg', 'Hunter Horizon 26 Yacht ''Hailey''', 'Loading at Norwich en-route to Durness Scotland. Used a Parrymore 3.5T gross trailer', 10);
INSERT INTO photos VALUES(88, 'P8290009-01.jpg', '28'' Mitchell 28', 'The ''Avalon 11'' safely loaded onto trailer at Ullapool Scotland heading for Portsmouth', 53);
INSERT INTO photos VALUES(3, 'boat3.jpg', '''Hailey''', 'A great place to take photos. Making a safe journey from Norwich to Durness', 12);
INSERT INTO photos VALUES(87, 'P8280003-01.jpg', '''Orion''  21'' Fishing Boat', 'The Orion being loaded onto trailer at St Andrews Fife en route to Macduff to start a new life', 52);
INSERT INTO photos VALUES(30, 'PA2700412.jpg', 'Small Cruiser', 'Launching at the Falkirk Wheel. Vessel taken out of the water at Loch Lomond using a Mersea trailer custom built to carry any model of vessel', 20);
INSERT INTO photos VALUES(31, 'DSC00384-01.jpg', 'RAF rescue launch', 'Lying at Buckie ready to go to Lancashire.\r\nSitting on a Parrymore trailer', 14);
INSERT INTO photos VALUES(32, 'DSC01064-01.jpg', 'Hardy', 'Loading straight onto the trailer from the water at Loch Tay ', 15);
INSERT INTO photos VALUES(33, 'DSC01073-01.jpg', 'Hardy', 'Safely loaded onto trailer ready for the trip to Dornoch', 16);
INSERT INTO photos VALUES(34, 'DSC01080-01.jpg', 'Hardy', 'Having a comfort break at Tyndrum', 17);
INSERT INTO photos VALUES(35, 'DSC01081-01.jpg', 'Hardy', 'Arrived safely at Dornoch', 18);
INSERT INTO photos VALUES(36, 'P9040037_1-01.jpg', 'Yacht', 'Boat and launching trailer being transported from Dunvegan Isle of Skye to Tighnabruaich using a tri-axle flat bed trailer', 19);
INSERT INTO photos VALUES(37, 'PB290062-01.jpg', 'Finn Keel Merlin Yacht (28ft)', 'Loading at Brightlingsea heading for Oban Scotland. Used a custom built trailer from Mersea', 21);
INSERT INTO photos VALUES(38, 'PB290065-01.jpg', 'Merlin Yacht', 'Strapped down and ready to leave', 22);
INSERT INTO photos VALUES(39, 'P2270195-01.jpg', 'Yacht', 'Collecting at Cairnryan going to Portsoy customers'' own trailer It was a cold February morning', 23);
INSERT INTO photos VALUES(40, 'P2270196-01.jpg', 'Fin Keeled Yacht', 'Strapped down and ready to leave 7 hr journey ahead', 24);
INSERT INTO photos VALUES(41, 'P3070197-01.jpg', 'Westerly Griffon 27ft', 'Loaded at Port Edgar Marina South Queensferry on a Mersea trailer, with extensions for the bilge keels, en-route to Southampton left 6.30 pm arrived Southampton safely at 8 am next morning. Boat sat very well on trailer easy drive', 26);
INSERT INTO photos VALUES(42, 'P3070198-01.jpg', 'Westerly Griffon 27ft', 'ready to be strapped down for the journey to Southampton, with jacks in place to give added stability for the journey', 26);
INSERT INTO photos VALUES(43, 'P3080199-01.jpg', 'Westerly Griffon 27ft', 'At Deacons Boatyard Southampton next morning ready for lifting off', 27);
INSERT INTO photos VALUES(44, 'P3080201-01.jpg', 'Westerly Griffon 27ft', 'Lifting off trailer at Southampton under the watchfull eye of the owner', 28);
INSERT INTO photos VALUES(53, 'P3210203-01.jpg', '28'' Yacht', 'Safely loaded and ready to leave', 30);
INSERT INTO photos VALUES(52, 'P3210202-01.jpg', '28'' Yacht', 'Loading at Arisaig near Mallaig this one is ''taking the high road''', 29);
INSERT INTO photos VALUES(103, '11665-01.jpg', 'Yawl', 'This boat was built by the present owner when he was sixteen. Thirty two years later he moved from Cruden Bay near Peterhead to the Orkney''s, this is us waiting at the ferry terminal in Scrabster.\r\nThe ferry from Aberdeen was cancelled due to bad weather so we made the long haul to Scrabster loaded with his creels, nets and ropes along with some household furniture.', 67);
INSERT INTO photos VALUES(55, 'P3220206-01.jpg', '28'' Yacht', 'Waiting for the crane at Clyde Marina Ardrossan. Yacht sat well on the Mersea trailer and never moved throughout the 6hr journey on bumpy Scottish roads', 32);
INSERT INTO photos VALUES(56, 'P4040197-01.jpg', 'The ''Rebound'' a Nimbus 28', 'Lifting out of the water at Dorset Shipyard Poole', 33);
INSERT INTO photos VALUES(57, 'P4040198-01.jpg', 'The ''Rebound''', 'Loaded onto a Mersea trailer and her bottom washed ready for the trip to Scotland. Client wants his boat to be looking good when arriving at new destination.', 34);
INSERT INTO photos VALUES(58, 'P4040199-01.jpg', 'The ''Rebound''', 'Stopped at services on M27 to check boat had not moved. Trailer and truck were pushed to the limit on this trip The boat sat well on the trailer, apart from the hills you would not have known she was there.', 35);
INSERT INTO photos VALUES(59, 'P4050200-01.jpg', 'The ''Rebound''', 'Arrived safely at Clyde Marina Ardrossan, it took us about 14hrs to do the trip, were in no hurry the boats safety is paramount.', 36);
INSERT INTO photos VALUES(141, 'P7070077-01.jpg', 'Bayliner Cierra 8m', 'Safely loaded on to our trailer at Largs Marina ready for the trip to Caley Marina Inverness', 104);
INSERT INTO photos VALUES(142, 'P7070079-01.jpg', 'Bayliner Cierra 8m', 'Safely arrived at Inverness and now slipping into the Caledonian Canal with the owner holding on tightly', 105);
INSERT INTO photos VALUES(61, 'P4130197-01.jpg', 'Sadler 26 Bilge Keel Yacht 26''', 'Collecting at Inverkip Marina en-route to Port Edgar South Qheensferry', 38);
INSERT INTO photos VALUES(62, 'P4130198-01.jpg', 'Sadler 26 Bilge Keel Yacht 26''', 'Strapped down and ready to leave lovely morning leaving Inverkip', 39);
INSERT INTO photos VALUES(63, 'P4140197-01.jpg', 'Yacht', 'April. Ready for going into water at Portsoy', 25);
INSERT INTO photos VALUES(65, 'P4130199-01.jpg', 'Sadler 26 Bilge Keel Yacht 26''', 'Arrived safely at Port Edgar cold and misty', 40);
INSERT INTO photos VALUES(66, 'P4200002-01.jpg', 'Small cruiser', 'Ready to unload at Wick.\r\nUsed the Range Rover to handle the steep hills en-route. Boat sitting on the Mersea trailer stripped to handle a cruiser.', 41);
INSERT INTO photos VALUES(67, 'P4260009-01.jpg', 'Twin Keel Leisure 23sl', 'Loaded and strapped down at farm in Essex ready for journey to Tayport Scotland. Mast was strapped to base of trailer.', 42);
INSERT INTO photos VALUES(68, 'P4270010-01.jpg', 'Leasure 23sl', 'Safely delivered to Tayport seen here with the proud new owner waiting for the crane to arrive to put the mast up and lift vessel into water. A very happy and satisfied customer', 43);
INSERT INTO photos VALUES(69, 'P6010001-01.jpg', 'Bayliner', 'Getting ready to leave Cameron House Marina Loch Lomond en-route to Port Edgar ', 44);
INSERT INTO photos VALUES(70, 'P6010002-01.jpg', 'Bayliner', 'In company with another era at Cameron House Hotel Loch Lomond', 45);
INSERT INTO photos VALUES(71, 'P6110005-01.jpg', 'Day Cruiser', 'At Kinlochmoidart. Customer going for a weeks fishing in the tranquility of a West Coast Loch. Delivered and collected at the customers'' request.', 9);
INSERT INTO photos VALUES(72, 'P6170020-01.jpg', 'Cruiser the ''Orcadia''', 'Waiting to board ferry at Plymouth en-route from Inverkip in Scotland to Aguadulce in southern Spain', 4);
INSERT INTO photos VALUES(73, 'P6190023-01.jpg', 'Cruiser ''Orcadia''', 'Safely arrived at destination waiting for marina to open to get unloaded. It is 6am and the temp. is rising fast', 5);
INSERT INTO photos VALUES(74, 'P6190026-01.jpg', 'Cruiser ''Orcadia''', 'Waiting our turn in the queue to get lifted off', 6);
INSERT INTO photos VALUES(75, 'P6190027-01.jpg', 'The ''Orcadia''', 'Being lifted onto cradles in the compound at the marina Aguadulce. Beautiful spot on the Med. ', 7);
INSERT INTO photos VALUES(76, 'P6250001-01.jpg', 'Single keeled Yacht', 'Lifting off at Lossiemouth in pouring rain real culture shock from Spain the week before. ', 8);
INSERT INTO photos VALUES(77, 'P7090008-01.jpg', 'MG Spring 25 Embark', 'Loaded and strapped down ready for the long haul from Banff on the Moray Firth, Scotland, to Dover', 2);
INSERT INTO photos VALUES(78, 'P7110010-01.jpg', 'Embark', 'Safely arrived at the marina Dover waiting to be lifted off', 2);
INSERT INTO photos VALUES(212, 'P5090303-01.jpg', 'Fast passenger fun boat', 'We picked this boat up at Ullapool in Scotland and delivered to Padstow in Cornwall', 1);
INSERT INTO photos VALUES(80, 'P7200001-01.jpg', 'Bayliner', 'Loading at Chichister Marina in torrential rain. There was so much flooding we could have sailed her up the motorway. Heading for Port Edgar Marina South Queensferry Scotland', 46);
INSERT INTO photos VALUES(81, 'P7210005-01.jpg', 'Bayliner', 'Safely arrived at Port Edgar with the two Forth Bridges in the background', 47);
INSERT INTO photos VALUES(82, 'P7210006-01.jpg', 'Bayliner', 'Waiting to be lifted off at the point of the quay at Port Edgar', 48);
INSERT INTO photos VALUES(83, 'P7210007-01.jpg', 'Bayliner', 'Lowering into the water with the proud new owner taking pics of his pride and joy. ', 49);
INSERT INTO photos VALUES(84, 'P8100011-01.jpg', '''Golden Sceptre'' Bucanneer 19', 'Safely arrived at Buckie on the Moray Coast taken from Maryport Cumbria', 50);
INSERT INTO photos VALUES(85, 'P8110018-01.jpg', '''Golden Sceptre'' Bucanneer 19', 'Lifting off, another job done to customers'' satisfaction', 51);
INSERT INTO photos VALUES(89, 'P8290011-01.jpg', '''Avalon 11''', 'Changing towing vehicle as the boat turned out to be far heavier than first notified', 54);
INSERT INTO photos VALUES(90, 'P8300013-01.jpg', '''Avalon 11''', 'Safely arrived at destination waiting to be lifted off. New owner busy scraping mussels from bottom of keel before going back into water', 55);
INSERT INTO photos VALUES(91, 'P8300016-01.jpg', '''Avalon 11''', 'About to be lowered into water at Portsmouth away to start a new life on the Isle of Wight', 56);
INSERT INTO photos VALUES(92, 'P9200010-01.jpg', 'Inshore Fishing Boat', 'Taking a breather in Harris on the Hebridean Islands, waiting for the new owner to appear to give instructions on where to unload his new boat. I was far too quick for them they were not expecting me to arrive the very next morning. This one was taken from Poolewe, all the steepest hills in the UK had to be overcome!!!!', 57);
INSERT INTO photos VALUES(93, 'P9250012-01.jpg', 'A Kingfisher 20 from Guernsey', 'Waiting at Poole Ferry terminal for the crane driver to arrive to load the boat on to our trailer', 58);
INSERT INTO photos VALUES(94, 'P9250014-01.jpg', 'The Kingfisher 20', 'Loaded on to trailer at Poole freight terminal and strapped down ready for the long haul to the Moray Firth in Scotland. She looks huge along side the Range Rover but it is only an optical illusion', 59);
INSERT INTO photos VALUES(95, 'P9260017-01.jpg', 'Kingfisher 20', 'Being craned off at Portsoy on the Moray Firth with the new owner conducting operations. What a contrast in weather the sea was beginning to break over the wall. ', 60);
INSERT INTO photos VALUES(96, 'P9270020-01.jpg', 'An ''Aphrodite 29''', 'Picked this beauty up in North Lincolnshire \r\nShe was sitting on her own trailer an old Swedish job which looked antiquated. We towed all the way to the Clyde Marina at Ardrossan with no problems. Another customer very satisfied with our service.', 61);
INSERT INTO photos VALUES(97, 'PA050003-01.jpg', 'Empty 30ft hull', 'This hull was picked up at a farm near Aberdeen and delivered to a ''boat sanctuary'' near Mallaig. The hull was in excellent condition mahogany on oak and was about to get the chain saw treatment.', 62);
INSERT INTO photos VALUES(98, 'PA310005-02.jpg', '''Lucky 11''', 'Loaded and strapped down at boat yard in Rothesay Isle of Bute ready for the long journey to the Medway Kent', 63);
INSERT INTO photos VALUES(99, 'PB010010-01.jpg', 'Westerly Griffon  ''Hermit''', 'Firmly secured ready for the long haul from Gosport to Tayport in Scotland', 64);
INSERT INTO photos VALUES(100, 'PB020015-01.jpg', 'Westerly Griffon  ''Hermit''', 'Safely arrived next morning at Tayport near Dundee Scotland with the proud new owner and her son. Balanced well on the trailer and towed easily. Another satisfied customer', 65);
INSERT INTO photos VALUES(102, 'PB160002-01.jpg', '''Moondancer''', 'Single keeled yacht lifted from the Crinan Canal at Cairnbahn and taken to Portishead Marina near Bristol. This was the boat being lifted off the trailer having arrived safely at our destination', 66);
INSERT INTO photos VALUES(104, '11663-01.jpg', 'Yawl', 'Everything covered to protect it on the journey. It meant so much to the owner I thought I was moving the QE2.', 68);
INSERT INTO photos VALUES(105, 'P2150010-01.jpg', 'Hunter Horizon 27 ''Impulse''', 'Proud new owner making sure everything is secure ready for the trip to Cramond Edinburgh', 69);
INSERT INTO photos VALUES(106, 'P2150012-01.jpg', '''Impulse''', 'Strapped down and ready to leave Grimsby for Cramond Edinburgh. Trailer with extensions for bilge keels and four sets of jacks supporting the boat forward and aft.', 70);
INSERT INTO photos VALUES(107, 'P2150014-01.jpg', '''Impulse''', 'Arrived safely at Cramond Edinburgh preparing to lift off.', 71);
INSERT INTO photos VALUES(108, 'P2200002-01.jpg', 'Dory Fishing Boat', 'Lying at Buckie Fish Market all strapped down ready for the trip to Methil Fife', 72);
INSERT INTO photos VALUES(110, 'P2220010-01.jpg', 'Fishing Boat, the ''Jenny May''', 'Picked this beauty up at the marina Dunstaffnage near Oban and dropped it off at Aberdeen enroute to the Shetlands', 75);
INSERT INTO photos VALUES(111, 'P2220011-01.jpg', 'The ''Jenny May''', 'Waiting at Northwards depot Aberdeen docks to be lifted off onto a container for the trip to the Shetlands', 74);
INSERT INTO photos VALUES(112, 'P3110005-01.jpg', 'Racing Yacht the ''Zufulo''', 'Collected this beauty at the Humber Yacht Association Grimsby.\r\nAll strapped down and ready to leave. We towed this boat through gale force winds it was white knuckle driving.', 76);
INSERT INTO photos VALUES(113, 'P3110007-01.jpg', 'The ''Zufulo''', 'Safely arrived at Fairlie Marina near largs.\r\nWhat would have been a five hour drive took us nearly eight with only a fuel stop in between. I was a relieved driver when I turned into the marina', 77);
INSERT INTO photos VALUES(114, 'P3150002-01.jpg', ' Sailer', 'Picked this one up at the picturesque village of Portknockie. The loading was the easiest part of this job', 78);
INSERT INTO photos VALUES(115, 'P3150003-01.jpg', 'Sailer', 'Safely unloading at its destination. It had to be lifted over phone wires that seem to be going in every direction. The wind had died down sufficient for us to lift it over everything and drop it into the clients garden without any of the neighbours noticing', 79);
INSERT INTO photos VALUES(116, 'P3170002-01.jpg', 'Fairline "Ocean Spray"', 'Loaded at Selby near York ready to leave for Inverkip on the Clyde', 80);
INSERT INTO photos VALUES(117, 'P3210008-01.jpg', 'Arvor 23', 'Had to carry this boat back to front because of the design of the keel', 81);
INSERT INTO photos VALUES(118, 'P3250001-01.jpg', 'Racing Yacht', 'Not the tidiest of jobs however we transported this yacht from Cardiff to Largs in Scotland on it own trailer which was too short for the job', 82);
INSERT INTO photos VALUES(119, 'P3270004-01.jpg', 'Cygnus Signet 23 The Oyster Catcher 11', 'Loaded at night in Bude Cornwall all strapped down and ready to leave. Heading for the Shetland Isles Scotland', 83);
INSERT INTO photos VALUES(123, 'P4040001-01.jpg', 'The ''Polarus''', 'Hitched on and strapped down leaving Fort William with the new yacht club house in the background, bound for Kenmore boating centre on Loch Tay', 87);
INSERT INTO photos VALUES(121, 'P3290008-01.jpg', 'The Oyster Catcher 11', 'Beautiful morning in Aberdeen waiting to transfer onto ferry transport', 85);
INSERT INTO photos VALUES(122, 'P3290010-01.jpg', 'The  Oyster Catcher 11', 'Safely transferred onto ferry transport for its final leg of the journey from Cornwall to the Shetland Isles', 86);
INSERT INTO photos VALUES(124, 'P4040003-01.jpg', '''Polarus''', 'Unhitching at Loch Tay in beautiful sunny weather', 88);
INSERT INTO photos VALUES(125, 'P4090001-01.jpg', 'Small Yacht', 'This Yacht was picked up at Holyhead Marina Dunoon and was transported with its own trailer to Essex. Here we are checking everything is still tight outside Dunoon at a very picturesque spot', 89);
INSERT INTO photos VALUES(126, 'P4110003-01.jpg', 'Trailers', 'Not only do we carry boats, we carry everything associated with the transportation of boats. This load was picked at Mersea Trailers in Colchester and delivered to Preston', 90);
INSERT INTO photos VALUES(129, 'P5130021-01.jpg', 'Sue.J. Hardy 24', 'Loading at Rhu Marina near Helensburgh.\r\nThis beauty we transported to Banff on the Moray coast. This beauty is everyones dream she had everything on her.', 92);
INSERT INTO photos VALUES(128, 'P5090056-01.jpg', 'RIB', 'Customer going for weekend with some added fun on the water. We collected his RIB and delivered to holiday address ', 91);
INSERT INTO photos VALUES(130, 'P5130022-01.jpg', 'Sue.J.', 'This is a boat to be proud to own.\r\nShe sat nicely on the trailer and towed easily.', 93);
INSERT INTO photos VALUES(131, 'P5130023-01.jpg', 'Sue.J.', 'This photo was taken at a rest stop The boat looked safe and comfortable on the trailer.', 94);
INSERT INTO photos VALUES(132, 'P5150002-01.jpg', '''Mandarin''  a Westerly Centaur', 'All loaded and strapped down ready for the long haul from Suffolk to the Moray coast, North of Scotland. ', 95);
INSERT INTO photos VALUES(133, 'P5160003-01.jpg', 'Mandarin', 'Safely arrived at Buckie on the Moray coast 1400 mile round trip', 96);
INSERT INTO photos VALUES(140, 'P7030074-01.jpg', 'Hardy 18', 'We collected this well looked after Hardy in Whitby and delivered Caley Marina Inverness', 103);
INSERT INTO photos VALUES(135, 'P6040062-01.jpg', 'The ''Satsuma''', 'Strapped down and ready to leave Port Edgar Marina South Queensferry for the long haul to Essex', 98);
INSERT INTO photos VALUES(136, 'P6040063-01.jpg', 'The ''Satsuma', 'Note the triple jacks on each side for greater safety. This ensures the boat is kept steady on all road conditions', 99);
INSERT INTO photos VALUES(137, 'P6050064-01.jpg', 'The ''Satsuma''', 'Safely arrived at destination in Essex. ', 100);
INSERT INTO photos VALUES(138, 'P6240068-01.jpg', 'Inland Cruiser', 'Collected from Gloucester and delivered to BoNess near the Forth and Clyde canal, Scotland. Here the customer stands proudly alongside his new boat parked in his drive.', 101);
INSERT INTO photos VALUES(139, 'P6250073-01.jpg', 'Beneteau Day Fisher', 'Collected this smart craft from Seaway Marine Gosport and delivered to the Outer Hebrides North West Scotland', 102);
INSERT INTO photos VALUES(143, 'P7170081-01.jpg', 'Sealine', 'We collected this well kept sealine at Dartmouth and delivered to Hopeman in the Moray Firth. I needed a shoe horn to get this one through the narrow streets of Devon', 106);
INSERT INTO photos VALUES(145, 'P7220084-01.jpg', 'Double Masted Yacht', 'This yacht was flying the skull and crossbones in Loch Tay Scotland when we arrived. It was soon demasted and trundled off to England by a Wild Rover to ply its trade in the English Channel', 108);
INSERT INTO photos VALUES(146, 'P7230086-01.jpg', 'The pirate ship', 'Being unloaded at a boatyard in Rye.\r\nCaptain Pugwash is now searching for a new crew. All you keen sailers get down to Rye and join this new venture', 109);
INSERT INTO photos VALUES(147, 'P7230087-01.jpg', 'Beneteau Antares 709', 'Loaded and strapped ready for the long journey from Brighton to Glenborrodale Scotland.\r\nFrom a very southerly point in England too the most westerly point on the Mainland Scotland', 110);
INSERT INTO photos VALUES(148, 'P7240089-01.jpg', 'Beneteau Antares 709', 'Waiting for the tide to put her in the water.\r\nThe scenery was magnificent it is a pity the roads are not as good ', 111);
INSERT INTO photos VALUES(149, 'P7280091-01.jpg', 'Inland Cruiser', 'Loaded at March in Cambridgeshire and secured ready for the long haul to Tipperary in Ireland', 113);
INSERT INTO photos VALUES(150, 'P7290096-01.jpg', 'Inland Cruiser', 'Arrived safely at Lough Derg on the Shannon, Ireland. Beautiful spot with easy slipping facilities', 113);
INSERT INTO photos VALUES(151, 'P7310099-01.jpg', 'Fishing Boat, Mr Todd', 'Loaded this one onto trailer at Strood on the Medway Kent and towed it all the way to Uig the northmost point on the Isle of Sky, Scotland', 114);
INSERT INTO photos VALUES(152, 'P8040103-01.jpg', 'Small Yacht', 'Loaded at Findhorn on the Moray Firth and delivered to Rhu Marina on the Clyde', 117);
INSERT INTO photos VALUES(153, 'P8070106-01.jpg', 'Small Fisher', 'We collected this fishing boat at Portknockie and delivered to Dunbar ', 115);
INSERT INTO photos VALUES(154, 'P8190111-01.jpg', 'Brand New Quicksilver Pilothouse', 'We collected this new boat complete with trailer at Newhaven and delivered to Rothesay on the island of Bute\r\n(See customers comments)', 116);
INSERT INTO photos VALUES(155, 'P8210112-01.jpg', 'Boriston Single Keeled yacht', 'We had the job of delivering this beauty which had been damaged to Barcaldine near Oban to await the insurance assessor.\r\nHere we are loaded and strapped down at Portree Isle of Sky', 118);
INSERT INTO photos VALUES(156, 'P8210113-01.jpg', 'Boriston 33', 'This must be the longest boat we have moved. It towered over the car and the lighting board extensions were at there maximum. We got there safely without causing any headaches for other road users', 119);
INSERT INTO photos VALUES(157, 'P8280117-01.jpg', 'Birchwood 27', 'Here we are loaded and fastened down at Burton Waters Marina Lincoln ready for the journey to Kilsyth to slip into the Clyde and Forth canal', 120);
INSERT INTO photos VALUES(158, 'P9020124-01.jpg', 'Fishing Boat', 'Loaded at Shoreham yacht club near Brighton. We are all set for the trip to Barrow-in-Furness', 121);
INSERT INTO photos VALUES(159, 'P9030125-01.jpg', 'Fishing Boat', 'Here we are in Barrow-in-Furness- getting ready to slip her into the water. There was a strong wind blowing up the inlet making it very difficult to hold her as she lifted off, we managed, and the last we saw of the customer was him taking off out to sea with his new toy', 122);
INSERT INTO photos VALUES(160, 'P9040126-01.jpg', '8 metre Cat Fishing Boat', 'Just lifted out of the water at Ramsgate and getting washed down before loading onto trailer. This is the first cat we have moved and it was an interesting experience.', 123);
INSERT INTO photos VALUES(161, 'P9050127-01.jpg', '8 metre Cat Fishing Boat', 'Loaded and strapped ready for the journey from Ramsgate to Aberdeen. ', 124);
INSERT INTO photos VALUES(162, 'P9050129-01.jpg', 'Cat Fishing Boat', 'Sat very well on trailer. delivered safely to Streamline who forwarded the boat onto the Orkney Islands', 125);
INSERT INTO photos VALUES(163, 'P9090130-01.jpg', 'Telstar Trimaran', 'They dont come more awkward than this one. We arrived at Benfleet marina Southend on Sea to be faced with a monstrosity that was neither a cruiser nor yacht. Fortunately we went prepared with every attachment for the trailer and with the help of some spare pieces of wood we got it secured to the trailer for the long haul to Kyle of Lochalsh', 126);
INSERT INTO photos VALUES(164, 'P9100134-01.jpg', 'Telstar Trimaran', 'Here we are safely at Kyle of Lochalsh waiting for the helpers to arrive so that we could get the boat lifted off', 127);
INSERT INTO photos VALUES(165, 'P9100137-01.jpg', 'Telstar Trimaran', 'Reassembled but somehow or other not looking right. I left them to work out the problem themselves I had done my duty and delivered the boat safely.', 128);
INSERT INTO photos VALUES(166, 'P9180139-01.jpg', 'Old clinker built fishing boat', 'Transported this old but in first class condition fishing boat from Wallsend to Fairlie on the Clyde. Here we are waiting to be lifted off under the watchful eye of our transport manager', 129);
INSERT INTO photos VALUES(167, 'P9190146-01.jpg', 'A Snapdragon 27', 'Collected this neat bilge keeled yacht from Fleetwood Marina and had the task of delivering to Tighnabruach. This yacht was built in 1973 and is in fairly good condition for its age.', 130);
INSERT INTO photos VALUES(168, 'P9300147-01.jpg', 'Small Fishing Boat.', 'We collected this well kept boat at Whitby and transported it to Balvicar near Oban.\r\nWe crossed the atlantic enroute', 131);
INSERT INTO photos VALUES(169, 'P9300148-01.jpg', 'Same Fishing Boat', 'Here we are with the new owner proudly posing with his new toy. This boat is to be used for fishing in very shallow water and tight coves', 132);
INSERT INTO photos VALUES(170, 'PA090149-01.jpg', 'Colvic Watson 24', 'This was a very awkward boat to move as it would neither fit in nor on the trailer.\r\nWe transported it from Plymouth to Peterhead', 133);
INSERT INTO photos VALUES(173, 'PA150151-01.jpg', 'The Bus', 'Not only do we carry boats we can carry anything. This is a 1923 Model T Ford bus originally from Lewis and was now returning to its original family. This vehicle was in immaculate condition and drew a lot of attention when we arrived in Stornoway. The following pics tell the story', 134);
INSERT INTO photos VALUES(174, 'PA150152-01.jpg', '', '', 135);
INSERT INTO photos VALUES(175, 'PA150153-01.jpg', '', '', 136);
INSERT INTO photos VALUES(176, 'PA150154-01.jpg', '', '', 137);
INSERT INTO photos VALUES(178, 'PA160155-01.jpg', '', '', 138);
INSERT INTO photos VALUES(179, 'PA160156-01.jpg', '', '', 139);
INSERT INTO photos VALUES(180, 'PA150154-01.jpg', '', '', 134);
INSERT INTO photos VALUES(181, 'PA160157-01.jpg', '', '', 140);
INSERT INTO photos VALUES(182, 'PA160158-01.jpg', '', '', 141);
INSERT INTO photos VALUES(183, 'PA160159-01.jpg', '', '', 142);
INSERT INTO photos VALUES(184, 'PA160160-01.jpg', '', '', 143);
INSERT INTO photos VALUES(185, 'PA160161-01.jpg', '', '', 144);
INSERT INTO photos VALUES(186, 'PA160162-01.jpg', '', '', 145);
INSERT INTO photos VALUES(187, 'PA280164-01.jpg', 'Lady Diana', 'Ready for loading at Can-Picafort on the island of Mallorca heading for Cork Ireland', 0);
INSERT INTO photos VALUES(188, 'PA280169-01.jpg', 'Lady Diana', 'Loaded and secured ready for the long trip to Cork in Ireland', 0);
INSERT INTO photos VALUES(189, 'PA290172-01.jpg', 'Lady Diana', 'On the first leg of the journey waiting for the ferry in Palma. ', 0);
INSERT INTO photos VALUES(190, 'PA300174-01.jpg', 'Lady Dina', 'About to start the second leg of the journey waiting to board ferry at Santander', 0);
INSERT INTO photos VALUES(191, 'PB010178-01.jpg', 'Lady Diana', 'Journeys end lifting off at Cork in Ireland after a long tiring journey. Customer delighted at the efficient way we handled the job.', 0);
INSERT INTO photos VALUES(192, 'PB110182-01.jpg', 'Fishing Boat', 'We had to take this boat out of the water without mechanical help. A nightmare.\r\nTold it was 2t it was more like 4t. The trailer got damaged in the process and the Range Rover struggled to pull it!!!', 0);
INSERT INTO photos VALUES(193, 'PB170187-01.jpg', 'Cruiser', 'Waiting at Prosser Marine in Glasgow to unload and reload with customers new boat', 0);
INSERT INTO photos VALUES(194, 'PB200193-01.jpg', 'Small fishing boat', 'We collected this immaculately kept boat at Lochinver and took it to the most southerly point in Harris', 0);
INSERT INTO photos VALUES(195, 'PB210198-01.jpg', 'Fishing Boat', 'We took back this one from Harris and it is here seen being unloaded at Fraserburgh with the proud new owner', 0);
INSERT INTO photos VALUES(196, 'PB260201-01.jpg', 'Fishing Boat', 'We collected this very tidy fishing boat in Harris and took it to the Shetlands', 0);
INSERT INTO photos VALUES(197, 'PB270209-01.jpg', '', 'Here we are unloading at Walsay on the shetlands. The equipment on a purser was used to lift off making it look like a small toy boat in the process', 0);
INSERT INTO photos VALUES(198, 'PC040211-01.jpg', 'Catamaran', 'This is the first half. We collected at Abergavenny in Wales in the middle of a field high up on the valleys and took it to Wellington in Somerset. We have to go back and collect the other half.', 0);
INSERT INTO photos VALUES(199, 'PC050213-01.jpg', 'Bilge Keeled Yacht', 'We collected this very tidy example at Maryport on the way back home and delivered to Fife in Scotland', 0);
INSERT INTO photos VALUES(200, 'PC170216-01.jpg', 'Shandon', 'We picked this beauty at Loch Awe near Oban and took it to Somerset, where the new owner is planning installing a steam engine bringing it back to how it was driven orriginally', 0);
INSERT INTO photos VALUES(201, 'P1080220-01.jpg', 'Micks Boat', 'Awaiting to be loaded at Southhampton ', 2);
INSERT INTO photos VALUES(202, 'P1080221-01.jpg', 'Micks Boat', 'Just arrived from America we transported boat and trailer on our trailer and delivered to Arbroath in Scotland', 0);
INSERT INTO photos VALUES(203, 'P1290226-01.jpg', 'Catamaran Cruiser', 'Loaded up and ready to go. Safely secured at the boatyard in Plymouth ready to leave for Greece', 0);
INSERT INTO photos VALUES(204, 'P2020229-01.jpg', 'Catamaran Cruiser', 'Waiting at the terminal Ancona to board the ferry for Greece. It was raining quite a change from the snow as we crossed the Alps ', 0);
INSERT INTO photos VALUES(205, 'P2030235-01.jpg', 'Catamaran Cruiser', 'Unloading at the marina Preveza Greece.\r\nThe temp was in the 20s. The customer was delighted to see his boat delivered safely and on time', 0);
INSERT INTO photos VALUES(206, 'P2030237-01.jpg', 'Smaller Cruiser', 'On our way back from Greece picked this boat up at Preveza and delivered to Fowey in Devon', 0);
INSERT INTO photos VALUES(207, 'P2070242-01.jpg', '26ft Yacht', 'Collected this yacht from the marina Whitby on way back from Greece and delivered to Port Edgar Marina Edinburgh.\r\nA tiring but fruitful trip ', 0);
INSERT INTO photos VALUES(208, 'P2180244-01.jpg', 'Buccaneer 26', 'This fishing boat is becoming quite popular on this site. The last time we moved it it was bright yellow and we were returning it to its original place The Isle of Man', 0);
INSERT INTO photos VALUES(209, 'P2200249-01.jpg', 'Yacht on Cradle', 'We transported this yacht on it own cradle \r\nWe bolted the cradle to our trailer and strapped the whole lot for the journey from Pwllheli in North Wales and delivered to Rosneath on the Clyde', 0);
INSERT INTO photos VALUES(210, 'P6010310-01.jpg', 'CACHALOT', 'In Penzance, loaded and strapped ready for the long haul to Lochmaddy in North Uist Scotland ', 1);
INSERT INTO photos VALUES(211, 'P6020315-01.jpg', 'CACHALOT', 'Arrived safely at Lochmaddy and now preparing to launch. Waiting for the champagne to arrive and send her on her way into the water', 1);

-- --------------------------------------------------------

