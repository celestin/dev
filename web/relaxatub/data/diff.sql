-- --------------------------------------------------------
-- Relaxatub
-- Copyright (c) 2006,2010 Frontburner
-- Author Craig McKay <craig@frontburner.co.uk>
--
-- $Id$
--
-- --------------------------------------------------------
-- Database Diff
--
-- Who  When         Why
-- CAM  29-Mar-2010  10620 : Added accessory.
-- CAM  29-Mar-2010  10622 : Added Harrow's tub pictures.
-- CAM  30-Mar-2010  10620 : Added accessory images.
-- CAM  01-Apr-2010  10620 : Added spa caddy accessory image.
-- --------------------------------------------------------

DROP TABLE acc;

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
-- Dumping data
-- 

INSERT INTO product VALUES (1011, 'GLS-851-0504', 'Covermate I', 'A', 'W6Z4UESXUQT22');
INSERT INTO product VALUES (1012, 'GLS-851-0505', 'Covermate II', 'A', 'G2QZM6589WWW2');
INSERT INTO product VALUES (1013, 'GLS-851-0507', 'Covermate III', 'A', 'F7ZT8P5KGJ8N2');
INSERT INTO product VALUES (1014, 'GLS-851-0511', 'Spa caddy', 'A', 'V9EBTTKQDLLCN');
INSERT INTO product VALUES (1015, 'PLS-40-8027', 'Spa wand (inc skimmer brush and wall mount)', 'A', 'HEMJJDWZ67CRU');
INSERT INTO product VALUES (1016, 'GLS-851-0508', 'Towel rail', 'A', '5JMCCVTSPM9RS');
INSERT INTO product VALUES (1017, 'GLS-851-0529', 'Solar-powered cabinet illumination', 'A', 'JLB6DYGVPGMBC');
INSERT INTO product VALUES (1018, 'A-AF1', 'Aquafinesse + free test strips', 'C', '42V7KWHBQ48ZY');
INSERT INTO product VALUES (1019, 'C-4326', 'Beachcomber C-4326 Filter 25sq.ft.', 'C', 'SCY6S5NWJTYQ4');


INSERT INTO accessory VALUES (3001, 1011, 'na.png', 132);
INSERT INTO accessory VALUES (3002, 1012, 'na.png', 150);
INSERT INTO accessory VALUES (3003, 1013, 'na.png', 228);
INSERT INTO accessory VALUES (3004, 1014, 'na.png', 45);
INSERT INTO accessory VALUES (3005, 1015, 'na.png', 42);
INSERT INTO accessory VALUES (3006, 1016, 'na.png', 24);
INSERT INTO accessory VALUES (3007, 1017, 'na.png', 32);
INSERT INTO accessory VALUES (3008, 1018, 'af1.png', 85);
INSERT INTO accessory VALUES (3009, 1019, 'c4326.png', 25);

INSERT INTO photo (photo, location, tub)
VALUES (
'p029.jpg', 'Inverurie', ''
), (
'p030.jpg', 'Inverurie', ''
);

UPDATE accessory SET photo='1011.png' WHERE pid=1011;
UPDATE accessory SET photo='1012.png' WHERE pid=1012;
UPDATE accessory SET photo='1013.png' WHERE pid=1013;
UPDATE accessory SET photo='na.png' WHERE pid=1014;
UPDATE accessory SET photo='1015.png' WHERE pid=1015;
UPDATE accessory SET photo='1016.png' WHERE pid=1016;
UPDATE accessory SET photo='1017.png' WHERE pid=1017;
UPDATE accessory SET photo='af1.png' WHERE pid=1018;
UPDATE accessory SET photo='c4326.png' WHERE pid=1019;

UPDATE accessory SET photo='1014.png' WHERE pid=1014;

