-- --------------------------------------------------------
-- First Summerhouses
-- Copyright (c) 2006 Frontburner
-- Author Craig McKay <craig@frontburner.co.uk>
-- 
-- $Id$
-- --------------------------------------------------------
-- phpMyAdmin SQL Dump
-- version 2.6.4-pl4
-- http://www.phpmyadmin.net
-- 
-- Host: localhost
-- Generation Time: May 11, 2006 at 07:59 PM
-- Server version: 4.1.16
-- PHP Version: 5.1.1
-- 
-- Database: 1stsummerhouses_com_-_site
-- --------------------------------------------------------

-- 
-- Table structure for table categories
-- 

CREATE TABLE categories (
  id int(11) NOT NULL auto_increment,
  category varchar(50) default NULL,
  disporder tinyint(4) default NULL,
  short_text varchar(255) default NULL,
  long_text mediumtext,
  created_by varchar(50) default NULL,
  created_on date default NULL,
  created_at time default NULL,
  updated_by varchar(50) default NULL,
  updated_on date default NULL,
  updated_at time default NULL,
  PRIMARY KEY  (id)
) ENGINE=MyISAM COMMENT='Product Categories' AUTO_INCREMENT=4 ;

-- 
-- Dumping data for table categories
-- 

INSERT INTO categories VALUES (1, 'BBQ Huts', 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO categories VALUES (2, 'Log Cabins', 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

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
) ENGINE=MyISAM COMMENT='User Information';

-- 
-- Dumping data for table member
-- 

INSERT INTO member VALUES ('CRAIG', 'Craig', 'McKay', 'craig@southesk.com', '1eebdddd1f688244a5861695cb7c3eba', 1, 'A', '0', 1, '1975-09-13', '0000-00-00 00:00:00', '2005-11-26 10:20:00');

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
) ENGINE=MyISAM COMMENT='User Types';

-- 
-- Dumping data for table member_type
-- 

INSERT INTO member_type VALUES ('U', 'User', 'Ability to View all details on the site', 1);
INSERT INTO member_type VALUES ('N', 'New User', 'No permissions yet - waiting verification', 3);
INSERT INTO member_type VALUES ('A', 'Administrator', 'Full Administrative capabilities', 2);

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
  created_by varchar(50) default NULL,
  created_on date default NULL,
  created_at time default NULL,
  updated_by varchar(50) default NULL,
  updated_on date default NULL,
  updated_at time default NULL,
  PRIMARY KEY  (id)
) ENGINE=MyISAM COMMENT='News Items' AUTO_INCREMENT=3 ;

-- 
-- Dumping data for table newsitems
-- 

INSERT INTO newsitems VALUES (1, 'IDEAL HOME AND GARDEN SHOW', 'From the 5th - 9th April we will be at the <a target="_blank" href="http://www.secc.co.uk/whatson/index.cfm?inc_dsp=view&eventRef=E67C67E6-508B-E9FB-9810CA3259FDBB77">SECC</a> in Glasgow for the <a target="_blank" href="http://www.idealhomeandgardenshow.co.uk/">Ideal Home and Garden Show</a> - come and see us there!', '2006-04-02', 'secc.gif', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO newsitems VALUES (2, 'NEW SITE LAUNCHED', 'Our new-look website has been launched, corresponding with the fantastic new ranges of log cabins and BBQ huts we have added to our portfolio.  <a href="mailto:firstsummerhouses@msn.com?Subject=New%20Website">Let us know</a> what you think!', '2004-03-31', NULL, NULL, NULL, NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

-- 
-- Table structure for table photos
-- 

CREATE TABLE photos (
  id int(11) NOT NULL auto_increment,
  product_id int(11) default NULL,
  imgfile varchar(40) NOT NULL default '',
  disporder smallint(6) default NULL,
  title varchar(50) default NULL,
  default_flag tinyint(4) NOT NULL default '0',
  comments varchar(100) default NULL,
  created_by varchar(50) default NULL,
  created_on date default NULL,
  created_at time default NULL,
  updated_by varchar(50) default NULL,
  updated_on date default NULL,
  updated_at time default NULL,
  PRIMARY KEY  (id)
) ENGINE=MyISAM COMMENT='Photos' AUTO_INCREMENT=181 ;

-- 
-- Dumping data for table photos
-- 

INSERT INTO photos VALUES (1, 16, 'kota_k172_00020.jpg', 20, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO photos VALUES (2, 16, 'kota_k172_00040.jpg', 40, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO photos VALUES (3, 16, 'kota_k172_00060.jpg', 60, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO photos VALUES (5, 16, 'kota_k172_00100.jpg', 100, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO photos VALUES (6, 16, 'kota_k172_00120.jpg', 120, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO photos VALUES (93, 5, 'nida_na_03380.jpg', 3380, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO photos VALUES (94, 5, 'nida_na_03360.jpg', 3360, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO photos VALUES (10, 16, 'kota_k172_00200.jpg', 200, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO photos VALUES (11, 16, 'kota_k172_00220.jpg', 220, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO photos VALUES (92, 5, 'nida_na_03340.jpg', 3340, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO photos VALUES (90, 5, 'nida_na_03300.jpg', 3300, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO photos VALUES (16, 16, 'kota_k172_00320.jpg', 320, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO photos VALUES (89, 5, 'nida_na_03280.jpg', 3280, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO photos VALUES (19, 16, 'kota_k172_00380.jpg', 380, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO photos VALUES (87, 5, 'nida_na_03240.jpg', 3240, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO photos VALUES (88, 5, 'nida_na_03260.jpg', 3260, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO photos VALUES (22, 17, 'kota_k288_00440.jpg', 440, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO photos VALUES (24, 17, 'kota_k288_00480.jpg', 480, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO photos VALUES (25, 17, 'kota_k288_00500.jpg', 500, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO photos VALUES (26, 17, 'kota_k288_00520.jpg', 520, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO photos VALUES (27, 17, 'kota_k288_00540.jpg', 540, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO photos VALUES (28, 17, 'kota_k288_00560.jpg', 560, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO photos VALUES (29, 17, 'kota_k288_00580.jpg', 580, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO photos VALUES (85, 5, 'nida_na_03200.jpg', 3200, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO photos VALUES (86, 5, 'nida_na_03220.jpg', 3220, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO photos VALUES (32, 14, 'kota_k069_00640.jpg', 640, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO photos VALUES (33, 14, 'kota_k069_00660.jpg', 660, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO photos VALUES (34, 14, 'kota_k069_00680.jpg', 680, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO photos VALUES (35, 14, 'kota_k069_00700.jpg', 700, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO photos VALUES (36, 14, 'kota_k069_00720.jpg', 720, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO photos VALUES (37, 14, 'kota_k069_00740.jpg', 740, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO photos VALUES (165, 37, 'tyla_op_04380.jpg', 4380, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO photos VALUES (108, 7, 'nida_nt_03660.jpg', 3660, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO photos VALUES (40, 14, 'kota_k069_00800.jpg', 800, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO photos VALUES (107, 6, 'nida_ns_03640.jpg', 3640, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO photos VALUES (42, 15, 'kota_k099_00840.jpg', 840, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO photos VALUES (43, 15, 'kota_k099_00860.jpg', 860, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO photos VALUES (106, 6, 'nida_ns_03600.jpg', 3600, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO photos VALUES (45, 15, 'kota_k099_00900.jpg', 900, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO photos VALUES (46, 15, 'kota_k099_00920.jpg', 920, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO photos VALUES (47, 15, 'kota_k099_00940.jpg', 940, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO photos VALUES (105, 6, 'nida_ns_03620.jpg', 3620, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO photos VALUES (104, 6, 'nida_ns_03580.jpg', 3580, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO photos VALUES (50, 15, 'kota_k099_01000.jpg', 1000, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO photos VALUES (51, 15, 'kota_k099_01020.jpg', 1020, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO photos VALUES (52, 15, 'kota_k099_01040.jpg', 1040, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO photos VALUES (53, 15, 'kota_k099_01060.jpg', 1060, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO photos VALUES (54, 15, 'kota_k099_01080.jpg', 1080, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO photos VALUES (103, 42, 'nida_na_03560.jpg', 3560, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO photos VALUES (56, 15, 'kota_k099_01120.jpg', 1120, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO photos VALUES (57, 15, 'kota_k099_01140.jpg', 1140, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO photos VALUES (58, 15, 'kota_k099_01160.jpg', 1160, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO photos VALUES (59, 15, 'kota_k099_01180.jpg', 1180, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO photos VALUES (61, 15, 'kota_k099_01220.jpg', 1220, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO photos VALUES (62, 15, 'kota_k099_01240.jpg', 1240, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO photos VALUES (101, 5, 'nida_na_03520.jpg', 3520, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO photos VALUES (102, 5, 'nida_na_03540.jpg', 3540, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO photos VALUES (65, 15, 'kota_k099_01300.jpg', 1300, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO photos VALUES (66, 15, 'kota_k099_01320.jpg', 1320, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO photos VALUES (67, 15, 'kota_k099_01340.jpg', 1340, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO photos VALUES (68, 15, 'kota_k099_01360.jpg', 1360, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO photos VALUES (69, 15, 'kota_k099_01380.jpg', 1380, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO photos VALUES (70, 15, 'kota_k099_01400.jpg', 1400, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO photos VALUES (71, 15, 'kota_k099_01420.jpg', 1420, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO photos VALUES (72, 15, 'kota_k099_01440.jpg', 1440, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO photos VALUES (74, 15, 'kota_k099_01480.jpg', 1480, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO photos VALUES (75, 15, 'kota_k099_01500.jpg', 1500, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO photos VALUES (76, 15, 'kota_k099_01520.jpg', 1520, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO photos VALUES (77, 15, 'kota_k099_01540.jpg', 1540, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO photos VALUES (78, 15, 'kota_k099_01560.jpg', 1560, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO photos VALUES (79, 15, 'kota_k099_01580.jpg', 1580, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO photos VALUES (98, 5, 'nida_na_03460.jpg', 3460, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO photos VALUES (97, 5, 'nida_na_03440.jpg', 3440, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO photos VALUES (110, 10, 'nida_ntas_03700.jpg', 3700, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO photos VALUES (111, 10, 'nida_ntas_03720.jpg', 3720, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO photos VALUES (161, 33, 'tyla_ct_04340.jpg', 4340, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO photos VALUES (160, 32, 'tyla_cg_04320.jpg', 4320, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO photos VALUES (159, 21, 'tbuild_tg_04620.jpg', 4620, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO photos VALUES (115, 10, 'nida_ntas_03800.jpg', 3800, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO photos VALUES (116, 9, 'nida_nv_03820.jpg', 3820, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO photos VALUES (117, 9, 'nida_nv_03840.jpg', 3840, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO photos VALUES (118, 9, 'nida_nv_03860.jpg', 3860, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO photos VALUES (119, 4, 'nida_nida_02840.jpg', 2840, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO photos VALUES (120, 4, 'nida_nida_02860.jpg', 2860, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO photos VALUES (121, 4, 'nida_nida_02880.jpg', 2880, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO photos VALUES (122, 4, 'nida_nida_02900.jpg', 2900, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO photos VALUES (123, 4, 'nida_nida_02940.jpg', 2940, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO photos VALUES (124, 4, 'nida_nida_02960.jpg', 2960, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO photos VALUES (125, 4, 'nida_nida_02980.jpg', 2980, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO photos VALUES (126, 4, 'nida_nida_03000.jpg', 3000, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO photos VALUES (127, 4, 'nida_nida_03020.jpg', 3020, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO photos VALUES (128, 4, 'nida_nida_03040.jpg', 3040, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO photos VALUES (129, 4, 'nida_nida_03060.jpg', 3060, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO photos VALUES (130, 4, 'nida_nida_03080.jpg', 3080, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO photos VALUES (131, 4, 'nida_nida_03100.jpg', 3100, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO photos VALUES (132, 4, 'nida_nida_02920.jpg', 2920, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO photos VALUES (133, 4, 'nida_nida_03120.jpg', 3120, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO photos VALUES (134, 4, 'nida_nida_03140.jpg', 3140, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO photos VALUES (135, 4, 'nida_nida_03160.jpg', 3160, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO photos VALUES (136, 4, 'nida_nida_03180.jpg', 3180, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO photos VALUES (137, 24, 'tbuild_t12_03880.jpg', 3880, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO photos VALUES (138, 27, 'tbuild_t17t_03900.jpg', 3900, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO photos VALUES (139, 41, 'tbuild_t22_03920.jpg', 3920, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO photos VALUES (140, 41, 'tbuild_t22_03940.jpg', 3940, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO photos VALUES (141, 34, 'tyla_kf_03960.jpg', 3960, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO photos VALUES (142, 34, 'tyla_kf_03980.jpg', 3980, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO photos VALUES (143, 34, 'tyla_kf_04000.jpg', 4000, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO photos VALUES (144, 34, 'tyla_kf_04020.jpg', 4020, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO photos VALUES (145, 35, 'tyla_la_04040.jpg', 4040, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO photos VALUES (146, 35, 'tyla_la_04060.jpg', 4060, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO photos VALUES (147, 35, 'tyla_la_04080.jpg', 4080, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO photos VALUES (148, 35, 'tyla_la_04100.jpg', 4100, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO photos VALUES (149, 35, 'tyla_la_04120.jpg', 4120, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO photos VALUES (150, 35, 'tyla_la_04140.jpg', 4140, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO photos VALUES (151, 35, 'tyla_la_04160.jpg', 4160, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO photos VALUES (152, 35, 'tyla_la_04180.jpg', 4180, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO photos VALUES (153, 35, 'tyla_la_04200.jpg', 4200, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO photos VALUES (154, 35, 'tyla_la_04220.jpg', 4220, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO photos VALUES (155, 35, 'tyla_la_04240.jpg', 4240, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO photos VALUES (156, 40, 'tyla_uf_04260.jpg', 4260, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO photos VALUES (157, 40, 'tyla_uf_04280.jpg', 4280, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO photos VALUES (158, 40, 'tyla_uf_04300.jpg', 4300, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO photos VALUES (164, 36, 'tyla_oc_04360.jpg', 4360, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO photos VALUES (166, 43, 'tyla_op_04400.jpg', 4400, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO photos VALUES (167, 44, 'tyla_op_04420.jpg', 4420, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO photos VALUES (168, 38, 'tyla_pc_04440.jpg', 4440, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO photos VALUES (169, 39, 'tyla_sw_04460.jpg', 4460, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO photos VALUES (170, 18, 'tbuild_t10_04480.jpg', 4480, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO photos VALUES (171, 26, 'tbuild_t15_04540.jpg', 4540, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO photos VALUES (172, 28, 'tbuild_t17_04720.jpg', 4720, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO photos VALUES (173, 29, 'tbuild_t20_04560.jpg', 4560, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO photos VALUES (174, 30, 'tbuild_t21_04580.jpg', 4580, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO photos VALUES (175, 31, 'tbuild_t23_04600.jpg', 4600, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO photos VALUES (176, 19, 'tbuild_t24_04620.jpg', 4620, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO photos VALUES (177, 20, 'tbuild_pv_04640.jpg', 4640, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO photos VALUES (178, 22, 'tbuild_ts_04680.jpg', 4680, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO photos VALUES (179, 23, 'tbuild_tt_04700.jpg', 4700, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO photos VALUES (180, 25, 'tbuild_t14_04520.jpg', 4520, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

-- 
-- Table structure for table prodprices
-- 

CREATE TABLE prodprices (
  id int(11) NOT NULL auto_increment,
  product_id int(11) NOT NULL default '0',
  prodvariation_id int(11) default NULL,
  rangeoption_id int(11) default NULL,
  pivot smallint(6) default NULL,
  price smallint(6) default NULL,
  created_by varchar(50) default NULL,
  created_on date default NULL,
  created_at time default NULL,
  updated_by varchar(50) default NULL,
  updated_on date default NULL,
  updated_at time default NULL,
  PRIMARY KEY  (id)
) ENGINE=MyISAM COMMENT='Product Prices' AUTO_INCREMENT=652 ;

-- 
-- Dumping data for table prodprices
-- 

INSERT INTO prodprices VALUES (651, 7, 28, 2, NULL, 295, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO prodprices VALUES (650, 7, 27, 2, NULL, 270, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO prodprices VALUES (649, 7, 26, 2, NULL, 270, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO prodprices VALUES (648, 7, 25, 2, NULL, 238, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO prodprices VALUES (647, 7, 24, 2, NULL, 194, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO prodprices VALUES (646, 7, 23, 2, NULL, 194, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO prodprices VALUES (645, 7, 22, 2, NULL, 145, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO prodprices VALUES (644, 6, 21, 2, NULL, 275, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO prodprices VALUES (643, 6, 20, 2, NULL, 243, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO prodprices VALUES (642, 6, 19, 2, NULL, 243, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO prodprices VALUES (641, 6, 18, 2, NULL, 170, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO prodprices VALUES (640, 6, 17, 2, NULL, 170, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO prodprices VALUES (639, 6, 16, 2, NULL, 170, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO prodprices VALUES (638, 6, 15, 2, NULL, 146, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO prodprices VALUES (637, 5, 7, 2, NULL, 275, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO prodprices VALUES (636, 5, 6, 2, NULL, 243, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO prodprices VALUES (635, 5, 5, 2, NULL, 243, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO prodprices VALUES (634, 5, 4, 2, NULL, 170, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO prodprices VALUES (633, 5, 3, 2, NULL, 170, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO prodprices VALUES (632, 5, 2, 2, NULL, 170, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO prodprices VALUES (631, 5, 1, 2, NULL, 146, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO prodprices VALUES (630, 4, 9, 2, NULL, 145, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO prodprices VALUES (629, 4, 8, 2, NULL, 121, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO prodprices VALUES (628, 4, 14, 2, NULL, 250, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO prodprices VALUES (627, 4, 13, 2, NULL, 218, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO prodprices VALUES (626, 4, 12, 2, NULL, 218, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO prodprices VALUES (625, 4, 11, 2, NULL, 145, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO prodprices VALUES (624, 4, 10, 2, NULL, 145, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO prodprices VALUES (623, 7, 28, 1, 60, 225, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO prodprices VALUES (622, 7, 27, 1, 60, 200, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO prodprices VALUES (621, 7, 26, 1, 60, 194, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO prodprices VALUES (620, 7, 25, 1, 60, 172, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO prodprices VALUES (619, 6, 21, 1, 60, 173, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO prodprices VALUES (618, 6, 20, 1, 60, 154, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO prodprices VALUES (617, 6, 19, 1, 60, 149, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO prodprices VALUES (616, 6, 18, 1, 60, 132, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO prodprices VALUES (615, 5, 7, 1, 60, 232, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO prodprices VALUES (614, 5, 6, 1, 60, 206, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO prodprices VALUES (613, 5, 5, 1, 60, 200, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO prodprices VALUES (612, 5, 4, 1, 60, 177, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO prodprices VALUES (611, 4, 14, 1, 60, 173, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO prodprices VALUES (610, 4, 13, 1, 60, 154, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO prodprices VALUES (609, 4, 12, 1, 60, 149, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO prodprices VALUES (608, 4, 11, 1, 60, 132, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO prodprices VALUES (607, 7, 28, 1, 45, 224, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO prodprices VALUES (606, 7, 27, 1, 45, 198, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO prodprices VALUES (605, 7, 26, 1, 45, 191, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO prodprices VALUES (604, 7, 25, 1, 45, 169, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO prodprices VALUES (603, 7, 24, 1, 45, 140, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO prodprices VALUES (602, 7, 23, 1, 45, 140, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO prodprices VALUES (601, 7, 22, 1, 45, 117, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO prodprices VALUES (600, 6, 21, 1, 45, 172, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO prodprices VALUES (599, 6, 20, 1, 45, 152, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO prodprices VALUES (598, 6, 19, 1, 45, 147, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO prodprices VALUES (597, 6, 18, 1, 45, 130, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO prodprices VALUES (596, 6, 17, 1, 45, 108, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO prodprices VALUES (595, 6, 16, 1, 45, 108, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO prodprices VALUES (594, 6, 15, 1, 45, 90, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO prodprices VALUES (593, 5, 7, 1, 45, 230, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO prodprices VALUES (592, 5, 6, 1, 45, 204, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO prodprices VALUES (591, 5, 5, 1, 45, 197, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO prodprices VALUES (590, 5, 4, 1, 45, 174, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO prodprices VALUES (589, 5, 3, 1, 45, 145, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO prodprices VALUES (588, 5, 2, 1, 45, 145, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO prodprices VALUES (587, 5, 1, 1, 45, 121, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO prodprices VALUES (586, 4, 9, 1, 45, 108, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO prodprices VALUES (585, 4, 8, 1, 45, 90, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO prodprices VALUES (584, 4, 14, 1, 45, 172, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO prodprices VALUES (583, 4, 13, 1, 45, 152, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO prodprices VALUES (582, 4, 12, 1, 45, 147, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO prodprices VALUES (581, 4, 11, 1, 45, 130, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO prodprices VALUES (580, 4, 10, 1, 45, 108, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO prodprices VALUES (579, 7, 28, NULL, 60, 4447, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO prodprices VALUES (578, 7, 27, NULL, 60, 3680, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO prodprices VALUES (577, 7, 26, NULL, 60, 3897, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO prodprices VALUES (576, 7, 25, NULL, 60, 3538, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO prodprices VALUES (575, 6, 21, NULL, 60, 3981, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO prodprices VALUES (574, 6, 20, NULL, 60, 3206, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO prodprices VALUES (573, 6, 19, NULL, 60, 3495, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO prodprices VALUES (572, 6, 18, NULL, 60, 3150, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO prodprices VALUES (571, 5, 7, NULL, 60, 4725, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO prodprices VALUES (570, 5, 6, NULL, 60, 3936, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO prodprices VALUES (569, 5, 5, NULL, 60, 4239, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO prodprices VALUES (568, 5, 4, NULL, 60, 3880, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO prodprices VALUES (567, 4, 14, NULL, 60, 3760, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO prodprices VALUES (566, 4, 13, NULL, 60, 2998, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO prodprices VALUES (565, 4, 12, NULL, 60, 3274, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO prodprices VALUES (564, 4, 11, NULL, 60, 2942, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO prodprices VALUES (563, 7, 28, NULL, 45, 3552, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO prodprices VALUES (562, 7, 27, NULL, 45, 3258, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO prodprices VALUES (561, 7, 26, NULL, 45, 3159, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO prodprices VALUES (560, 7, 25, NULL, 45, 2873, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO prodprices VALUES (559, 7, 24, NULL, 45, 2495, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO prodprices VALUES (558, 7, 23, NULL, 45, 2341, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO prodprices VALUES (557, 7, 22, NULL, 45, 2055, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO prodprices VALUES (556, 6, 21, NULL, 45, 3141, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO prodprices VALUES (555, 6, 20, NULL, 45, 2838, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO prodprices VALUES (554, 6, 19, NULL, 45, 2811, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO prodprices VALUES (553, 6, 18, NULL, 45, 2534, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO prodprices VALUES (552, 6, 17, NULL, 45, 2162, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO prodprices VALUES (551, 6, 16, NULL, 45, 2192, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO prodprices VALUES (550, 6, 15, NULL, 45, 1838, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO prodprices VALUES (549, 5, 7, NULL, 45, 3708, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO prodprices VALUES (548, 5, 6, NULL, 45, 3391, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO prodprices VALUES (547, 5, 5, NULL, 45, 3378, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO prodprices VALUES (546, 5, 4, NULL, 45, 3087, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO prodprices VALUES (545, 5, 3, NULL, 45, 2636, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO prodprices VALUES (544, 5, 2, NULL, 45, 2745, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO prodprices VALUES (543, 5, 1, NULL, 45, 2312, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO prodprices VALUES (542, 4, 9, NULL, 45, 1984, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO prodprices VALUES (541, 4, 8, NULL, 45, 1660, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO prodprices VALUES (540, 4, 14, NULL, 45, 2920, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO prodprices VALUES (539, 4, 13, NULL, 45, 2630, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO prodprices VALUES (538, 4, 12, NULL, 45, 2590, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO prodprices VALUES (537, 4, 11, NULL, 45, 2326, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO prodprices VALUES (536, 4, 10, NULL, 45, 1984, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO prodprices VALUES (535, 4, NULL, 6, NULL, 267, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO prodprices VALUES (534, 4, NULL, 5, NULL, 159, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO prodprices VALUES (533, 4, NULL, 4, NULL, 124, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO prodprices VALUES (532, 4, NULL, 3, NULL, 83, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO prodprices VALUES (531, 7, NULL, 6, NULL, 267, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO prodprices VALUES (530, 7, NULL, 5, NULL, 159, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO prodprices VALUES (529, 7, NULL, 4, NULL, 124, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO prodprices VALUES (528, 7, NULL, 3, NULL, 83, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO prodprices VALUES (527, 6, NULL, 6, NULL, 267, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO prodprices VALUES (526, 6, NULL, 5, NULL, 159, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO prodprices VALUES (525, 6, NULL, 4, NULL, 124, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO prodprices VALUES (524, 6, NULL, 3, NULL, 83, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO prodprices VALUES (523, 5, NULL, 6, NULL, 267, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO prodprices VALUES (522, 5, NULL, 5, NULL, 159, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO prodprices VALUES (521, 5, NULL, 4, NULL, 124, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO prodprices VALUES (520, 5, NULL, 3, NULL, 83, NULL, NULL, NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

-- 
-- Table structure for table prodranges
-- 

CREATE TABLE prodranges (
  id int(11) NOT NULL auto_increment,
  range varchar(50) default NULL,
  category_id int(11) NOT NULL default '0',
  disporder tinyint(4) default NULL,
  short_text varchar(255) default NULL,
  long_text mediumtext,
  created_by varchar(50) default NULL,
  created_on date default NULL,
  created_at time default NULL,
  updated_by varchar(50) default NULL,
  updated_on date default NULL,
  updated_at time default NULL,
  PRIMARY KEY  (id)
) ENGINE=MyISAM COMMENT='Product Ranges' AUTO_INCREMENT=12 ;

-- 
-- Dumping data for table prodranges
-- 

INSERT INTO prodranges VALUES (4, 'T-Buildings', 2, 40, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO prodranges VALUES (5, 'Nida', 2, 30, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO prodranges VALUES (6, 'Holiday Houses', 2, 20, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO prodranges VALUES (7, 'Kota', 1, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO prodranges VALUES (8, 'Summerhouses', 3, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO prodranges VALUES (9, 'Garages', 2, 60, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO prodranges VALUES (10, 'Garden Cabins', 2, 10, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO prodranges VALUES (11, 'Pavilions', 2, 50, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

-- 
-- Table structure for table products
-- 

CREATE TABLE products (
  id int(11) NOT NULL auto_increment,
  product varchar(50) default NULL,
  prodrange_id int(11) NOT NULL default '0',
  brochure varchar(50) default NULL,
  disporder smallint(6) default NULL,
  short_text varchar(255) default NULL,
  long_text mediumtext,
  created_by varchar(50) default NULL,
  created_on date default NULL,
  created_at time default NULL,
  updated_by varchar(50) default NULL,
  updated_on date default NULL,
  updated_at time default NULL,
  PRIMARY KEY  (id)
) ENGINE=MyISAM COMMENT='Products' AUTO_INCREMENT=45 ;

-- 
-- Dumping data for table products
-- 

INSERT INTO products VALUES (4, 'Nida', 5, 'nida_nida.pdf', 10, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO products VALUES (5, 'Nida A', 5, 'nida_na.pdf', 20, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO products VALUES (6, 'Nida S', 5, 'nida_ns.pdf', 40, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO products VALUES (7, 'Nida T', 5, 'nida_nt.pdf', 50, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO products VALUES (9, 'Nida V', 5, NULL, 70, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO products VALUES (10, 'Nida TAS', 5, NULL, 80, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO products VALUES (33, 'Cottage with Terrace', 6, 'tyla_ct.pdf', 20, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO products VALUES (32, 'Cottage', 6, 'tyla_cg.pdf', 10, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO products VALUES (14, '6.9m2', 7, 'kota_k069.pdf', 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO products VALUES (15, '9.9m2', 7, 'kota_k099.pdf', 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO products VALUES (16, '17.2m2', 7, 'kota_k172.pdf', 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO products VALUES (17, '27m2', 7, 'kota_k288.pdf', 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO products VALUES (18, 'T10', 4, 'tbuild_t10.pdf', 10, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO products VALUES (19, 'Chalet T24', 4, 'tbuild_t24.pdf', 100, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO products VALUES (20, 'Pavillion', 11, 'tbuild_pv.pdf', 40, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO products VALUES (21, 'T Garage', 9, 'tbuild_tg.pdf', 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO products VALUES (22, 'T Shelter', 4, 'tbuild_ts.pdf', 120, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO products VALUES (23, 'T Terrace', 4, 'tbuild_tt.pdf', 130, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO products VALUES (24, 'T12', 4, 'tbuild_t12.pdf', 20, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO products VALUES (25, 'T14', 4, 'tbuild_t14.pdf', 25, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO products VALUES (26, 'T15', 4, 'tbuild_t15.pdf', 40, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO products VALUES (27, 'T17+Terrace', 4, 'tbuild_t17t.pdf', 60, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO products VALUES (28, 'T17', 4, 'tbuild_t17.pdf', 50, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO products VALUES (29, 'T20', 4, 'tbuild_t20.pdf', 70, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO products VALUES (30, 'T21', 4, 'tbuild_t21.pdf', 80, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO products VALUES (31, 'T23', 4, 'tbuild_t23.pdf', 90, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO products VALUES (34, 'Kaiserforst', 6, 'tyla_kf.pdf', 30, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO products VALUES (35, 'Laura', 6, 'tyla_la.pdf', 40, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO products VALUES (36, 'Sida', 11, 'tyla_oc.pdf', 50, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO products VALUES (37, 'Kaunas Pavilion', 11, 'tyla_op.pdf', 10, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO products VALUES (38, 'Borkum', 10, 'tyla_pc.pdf', 70, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO products VALUES (39, 'Superior Wallace', 10, 'tyla_sw.pdf', 80, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO products VALUES (40, 'Ulmenfield', 6, 'tyla_uf.pdf', 90, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO products VALUES (43, 'Vilnius Pavilion', 11, NULL, 30, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO products VALUES (42, 'Nida D', 5, 'nida_na.pdf', 30, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO products VALUES (44, 'Riga Pavilion', 11, NULL, 20, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

-- 
-- Table structure for table prodvariations
-- 

CREATE TABLE prodvariations (
  id int(11) NOT NULL auto_increment,
  variation varchar(50) default NULL,
  product_id int(11) NOT NULL default '0',
  vlength float default NULL,
  vbreadth float default NULL,
  created_by varchar(50) default NULL,
  created_on date default NULL,
  created_at time default NULL,
  updated_by varchar(50) default NULL,
  updated_on date default NULL,
  updated_at time default NULL,
  PRIMARY KEY  (id)
) ENGINE=MyISAM COMMENT='Product Variations' AUTO_INCREMENT=29 ;

-- 
-- Dumping data for table prodvariations
-- 

INSERT INTO prodvariations VALUES (9, NULL, 4, 4, 3, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO prodvariations VALUES (8, NULL, 4, 3, 3, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO prodvariations VALUES (7, NULL, 5, 5, 5, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO prodvariations VALUES (6, NULL, 5, 4, 5, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO prodvariations VALUES (5, NULL, 5, 5, 4, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO prodvariations VALUES (4, NULL, 5, 4, 4, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO prodvariations VALUES (3, NULL, 5, 3, 4, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO prodvariations VALUES (28, NULL, 7, 5, 5, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO prodvariations VALUES (27, NULL, 7, 4, 5, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO prodvariations VALUES (26, NULL, 7, 5, 4, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO prodvariations VALUES (25, NULL, 7, 4, 4, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO prodvariations VALUES (24, NULL, 7, 3, 4, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO prodvariations VALUES (23, NULL, 7, 4, 3, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO prodvariations VALUES (22, NULL, 7, 3, 3, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO prodvariations VALUES (21, NULL, 6, 5, 5, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO prodvariations VALUES (20, NULL, 6, 4, 5, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO prodvariations VALUES (2, NULL, 5, 4, 3, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO prodvariations VALUES (19, NULL, 6, 5, 4, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO prodvariations VALUES (18, NULL, 6, 4, 4, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO prodvariations VALUES (17, NULL, 6, 3, 4, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO prodvariations VALUES (16, NULL, 6, 4, 3, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO prodvariations VALUES (15, NULL, 6, 3, 3, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO prodvariations VALUES (14, NULL, 4, 5, 5, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO prodvariations VALUES (13, NULL, 4, 4, 5, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO prodvariations VALUES (12, NULL, 4, 5, 4, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO prodvariations VALUES (11, NULL, 4, 4, 4, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO prodvariations VALUES (10, NULL, 4, 3, 4, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO prodvariations VALUES (1, NULL, 5, 3, 3, NULL, NULL, NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

-- 
-- Table structure for table rangeoptions
-- 

CREATE TABLE rangeoptions (
  id int(11) NOT NULL auto_increment,
  rangeoption varchar(50) default NULL,
  prodrange_id int(11) NOT NULL default '0',
  disporder tinyint(4) default NULL,
  short_text varchar(255) default NULL,
  created_by varchar(50) default NULL,
  created_on date default NULL,
  created_at time default NULL,
  updated_by varchar(50) default NULL,
  updated_on date default NULL,
  updated_at time default NULL,
  PRIMARY KEY  (id)
) ENGINE=MyISAM COMMENT='Range Options' AUTO_INCREMENT=7 ;

-- 
-- Dumping data for table rangeoptions
-- 

INSERT INTO rangeoptions VALUES (1, 'Roof Insulation', 5, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO rangeoptions VALUES (2, 'Shingles', 5, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO rangeoptions VALUES (3, 'Single Window', 5, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO rangeoptions VALUES (4, 'Double Window', 5, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO rangeoptions VALUES (5, 'Single Door', 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO rangeoptions VALUES (6, 'Double Door', 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

-- 
-- Table structure for table tabs
-- 

CREATE TABLE tabs (
  id int(11) NOT NULL auto_increment,
  page varchar(20) NOT NULL default '',
  tab varchar(50) default NULL,
  disporder tinyint(4) default NULL,
  created_by varchar(50) default NULL,
  created_on date default NULL,
  created_at time default NULL,
  updated_by varchar(50) default NULL,
  updated_on date default NULL,
  updated_at time default NULL,
  PRIMARY KEY  (id)
) ENGINE=MyISAM COMMENT='Tabs' AUTO_INCREMENT=5 ;

-- 
-- Dumping data for table tabs
-- 

INSERT INTO tabs VALUES (1, 'product', 'Product', 10, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tabs VALUES (2, 'product', 'Gallery', 20, NULL, NULL, NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

-- 
-- Table structure for table upload
-- 

CREATE TABLE upload (
  uplfile varchar(255) NOT NULL default '',
  docdate date NOT NULL default '0000-00-00',
  doctype char(1) NOT NULL default 'I',
  PRIMARY KEY  (uplfile)
) ENGINE=MyISAM COMMENT='Uploaded Files';

-- 
-- Dumping data for table upload
-- 

