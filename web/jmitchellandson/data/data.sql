-- --------------------------------------------------------
-- J.Mitchell & Son (jmitchellandson.co.uk)
-- Copyright (c) 2010 Front Burner
-- Author Craig McKay <craig@frontburner.co.uk>
--
-- $Id$
-- --------------------------------------------------------
--
-- phpMyAdmin SQL Dump
-- version 2.10.3
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Dec 27, 2010 at 04:36 PM
-- Server version: 5.0.51
-- PHP Version: 5.2.6

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";

--
-- Database: `jmitchellandson_site`
--

-- --------------------------------------------------------

--
-- Table structure for table `address_book`
--

CREATE TABLE `address_book` (
  `address_book_id` int(11) NOT NULL auto_increment,
  `customers_id` int(11) NOT NULL,
  `entry_gender` char(1) NOT NULL,
  `entry_company` varchar(32) default NULL,
  `entry_firstname` varchar(32) NOT NULL,
  `entry_lastname` varchar(32) NOT NULL,
  `entry_street_address` varchar(64) NOT NULL,
  `entry_suburb` varchar(32) default NULL,
  `entry_postcode` varchar(10) NOT NULL,
  `entry_city` varchar(32) NOT NULL,
  `entry_state` varchar(32) default NULL,
  `entry_country_id` int(11) NOT NULL default '0',
  `entry_zone_id` int(11) NOT NULL default '0',
  PRIMARY KEY  (`address_book_id`),
  KEY `idx_address_book_customers_id` (`customers_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=20 ;

--
-- Dumping data for table `address_book`
--

INSERT INTO `address_book` VALUES (2, 2, 'm', '', 'Craig', 'McKay', '7 Park Grove', '', 'DD9 7AJ', 'Brechin', '', 222, 266);
INSERT INTO `address_book` VALUES (3, 3, 'm', '', 'John', 'Laing', '5 nether caldhame', '', 'dd9 7hn', 'brechin', '', 222, 281);
INSERT INTO `address_book` VALUES (6, 6, 'm', '', 'neil', 'hutcheon', '28 city road', '', 'dd96dn', 'brechin', '', 222, 281);
INSERT INTO `address_book` VALUES (7, 7, 'f', '', 'Linda', 'Flanigan', '10 Barrett''s Close', 'Stonesfield', 'OX29 8PW', 'Stonesfield', '', 222, 399);
INSERT INTO `address_book` VALUES (8, 8, 'f', '', 'Susan', 'Hermiston', '132 Peacocktail Close', '', 'EH15 3QT', 'Edinburgh', '', 222, 381);
INSERT INTO `address_book` VALUES (11, 11, 'm', '', 'Craig', 'Singh', '1 Pakistan land', '', 'PAK1', 'Isalamabad', 'Isalamabadshire', 162, 0);
INSERT INTO `address_book` VALUES (12, 12, 'm', '', 'Simon', 'Henley-Castleden', '115 Poverest Road', '', 'BR5 2DZ', 'Orpington', '', 222, 372);
INSERT INTO `address_book` VALUES (13, 13, 'f', '', 'Shelagh', 'Borden', '11 lyndworth close', '', 'Ox39er', 'Oxford', '', 222, 399);
INSERT INTO `address_book` VALUES (14, 14, 'm', '', 'Anthony', 'Horan', '3 Redburn Court', 'Cumbernauld', 'G67 3NL', 'Glasgow', '', 222, 376);
INSERT INTO `address_book` VALUES (15, 15, 'm', '', 'Neil', 'Sutherland', '37 Moor Lane', 'Guiseley', 'LS20 9EA', 'Leeds', '', 222, 431);
INSERT INTO `address_book` VALUES (16, 16, 'f', '', 'Kay', 'Robertson', '26 North Latch Road', '', 'DD9 6LE', 'Brechin', '', 222, 281);
INSERT INTO `address_book` VALUES (19, 19, 'f', '', 'Sharon', 'Emery', '33 Westfield Ave', 'Audley', 'ST7 8EQ', 'Stoke on Trent', '', 222, 416);
INSERT INTO `address_book` VALUES (18, 18, 'm', '', 'david', 'law', '40 prince street', '', 'ol16 5ll', 'rochdale', '', 222, 377);

-- --------------------------------------------------------

--
-- Table structure for table `address_format`
--

CREATE TABLE `address_format` (
  `address_format_id` int(11) NOT NULL auto_increment,
  `address_format` varchar(128) NOT NULL,
  `address_summary` varchar(48) NOT NULL,
  PRIMARY KEY  (`address_format_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=6 ;

--
-- Dumping data for table `address_format`
--

INSERT INTO `address_format` VALUES (1, '$firstname $lastname$cr$streets$cr$city$cr$statecomma$postcode$cr$country', '$city / $country');
INSERT INTO `address_format` VALUES (2, '$firstname $lastname$cr$streets$cr$city, $state    $postcode$cr$country', '$city, $state / $country');
INSERT INTO `address_format` VALUES (3, '$firstname $lastname$cr$streets$cr$city$cr$postcode - $statecomma$country', '$state / $country');
INSERT INTO `address_format` VALUES (4, '$firstname $lastname$cr$streets$cr$city ($postcode)$cr$country', '$postcode / $country');
INSERT INTO `address_format` VALUES (5, '$firstname $lastname$cr$streets$cr$postcode $city$cr$country', '$city / $country');

-- --------------------------------------------------------

--
-- Table structure for table `administrators`
--

CREATE TABLE `administrators` (
  `id` int(11) NOT NULL auto_increment,
  `user_name` varchar(32) character set latin1 collate latin1_bin NOT NULL,
  `user_password` varchar(40) NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=10 ;

--
-- Dumping data for table `administrators`
--

INSERT INTO `administrators` VALUES (1, 0x6a6c61696e67, '3c4a123e0931facd42944d54043218ee:14');
INSERT INTO `administrators` VALUES (2, 0x636d636b6179, 'f59179ad6a3c50f95f213ba566953f72:4f');
INSERT INTO `administrators` VALUES (9, 0x61646d696e32343739, '2b7f95abc121652afad32233013c8474:09');
INSERT INTO `administrators` VALUES (8, 0x64646f6f676766, '55501ff0e838b408261dada20fc27cb3:f3');
INSERT INTO `administrators` VALUES (7, 0x4162636465666731, 'c307719a8cc50d21c16108f603e314dd:49');

-- --------------------------------------------------------

--
-- Table structure for table `banners`
--

CREATE TABLE `banners` (
  `banners_id` int(11) NOT NULL auto_increment,
  `banners_title` varchar(64) NOT NULL,
  `banners_url` varchar(255) NOT NULL,
  `banners_image` varchar(64) NOT NULL,
  `banners_group` varchar(10) NOT NULL,
  `banners_html_text` text,
  `expires_impressions` int(7) default '0',
  `expires_date` datetime default NULL,
  `date_scheduled` datetime default NULL,
  `date_added` datetime NOT NULL,
  `date_status_change` datetime default NULL,
  `status` int(1) NOT NULL default '1',
  PRIMARY KEY  (`banners_id`),
  KEY `idx_banners_group` (`banners_group`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=5 ;

--
-- Dumping data for table `banners`
--


-- --------------------------------------------------------

--
-- Table structure for table `banners_history`
--

CREATE TABLE `banners_history` (
  `banners_history_id` int(11) NOT NULL auto_increment,
  `banners_id` int(11) NOT NULL,
  `banners_shown` int(5) NOT NULL default '0',
  `banners_clicked` int(5) NOT NULL default '0',
  `banners_history_date` datetime NOT NULL,
  PRIMARY KEY  (`banners_history_id`),
  KEY `idx_banners_history_banners_id` (`banners_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=2 ;

--
-- Dumping data for table `banners_history`
--


-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE `categories` (
  `categories_id` int(11) NOT NULL auto_increment,
  `categories_image` varchar(64) default NULL,
  `parent_id` int(11) NOT NULL default '0',
  `sort_order` int(3) default NULL,
  `subcat_per_row` int(11) default NULL,
  `subcat_image_width` int(11) default NULL,
  `date_added` datetime default NULL,
  `last_modified` datetime default NULL,
  PRIMARY KEY  (`categories_id`),
  KEY `idx_categories_parent_id` (`parent_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=45 ;

--
-- Dumping data for table `categories`
--

INSERT INTO `categories` VALUES (1, NULL, 0, 10, NULL, NULL, '2010-04-26 09:49:59', NULL);
INSERT INTO `categories` VALUES (2, NULL, 0, 20, NULL, NULL, '2010-04-26 09:50:12', NULL);
INSERT INTO `categories` VALUES (3, 'category_watches_citizen_new.png', 1, 10, NULL, NULL, '2010-04-26 09:50:33', '2010-07-17 10:28:34');
INSERT INTO `categories` VALUES (4, 'category_watches_sekonda_new.png', 1, 20, NULL, NULL, '2010-04-26 09:51:00', '2010-07-17 10:29:07');
INSERT INTO `categories` VALUES (5, 'category_watches_accurist_new.png', 1, 15, NULL, NULL, '2010-04-26 09:51:24', '2010-07-17 10:28:49');
INSERT INTO `categories` VALUES (6, 'category_watches_seksy_new.png', 1, 18, NULL, NULL, '2010-04-26 09:51:35', '2010-07-17 10:28:58');
INSERT INTO `categories` VALUES (8, 'category_jewellery_dfordiamonds.png', 2, 60, NULL, NULL, '2010-04-26 10:50:45', '2010-10-22 21:59:01');
INSERT INTO `categories` VALUES (10, 'category_silver.png', 2, 70, 3, 240, '2010-04-26 10:51:07', '2010-10-30 21:58:31');
INSERT INTO `categories` VALUES (11, 'category_jewellery_fredbennett.png', 2, 90, 3, 240, '2010-04-26 10:51:18', '2010-10-22 21:59:22');
INSERT INTO `categories` VALUES (12, 'category_watches_citizen_gents.png', 3, 0, NULL, NULL, '2010-05-29 08:50:12', NULL);
INSERT INTO `categories` VALUES (13, 'category_watches_citizen_ladies.png', 3, 0, NULL, NULL, '2010-05-29 08:50:33', NULL);
INSERT INTO `categories` VALUES (14, 'category_watches_sekonda_gents.png', 4, 1, NULL, NULL, '2010-05-31 22:42:52', NULL);
INSERT INTO `categories` VALUES (15, 'category_watches_sekonda_ladies.png', 4, 2, NULL, NULL, '2010-05-31 22:43:06', NULL);
INSERT INTO `categories` VALUES (16, 'e3804copy4.jpg', 10, 0, NULL, NULL, '2010-06-12 14:48:47', '2010-10-30 20:52:42');
INSERT INTO `categories` VALUES (17, 'category_jewellery_elementssilver_bracelets.png', 10, 0, NULL, NULL, '2010-06-12 14:48:58', NULL);
INSERT INTO `categories` VALUES (18, 'category_jewellery_elementssilver_pendants.png', 10, 0, NULL, NULL, '2010-06-12 14:49:06', NULL);
INSERT INTO `categories` VALUES (20, 'category_jewellery_fredbennett_bracelet.png', 11, 0, NULL, NULL, '2010-06-19 21:48:26', '2010-06-19 21:52:46');
INSERT INTO `categories` VALUES (21, 'category_jewellery_fredbennett_neckchain.png', 11, 0, NULL, NULL, '2010-06-19 21:48:35', '2010-07-20 20:37:33');
INSERT INTO `categories` VALUES (23, 'category_jewellery_fredbennett_cufflinks.png', 11, 0, NULL, NULL, '2010-06-19 21:48:44', NULL);
INSERT INTO `categories` VALUES (24, 'category_watches_accurist_gents.png', 5, 10, NULL, NULL, '2010-06-22 21:28:34', '2010-10-22 07:31:11');
INSERT INTO `categories` VALUES (25, 'category_watches_accurist_ladies.png', 5, 20, NULL, NULL, '2010-06-22 21:28:42', '2010-06-22 21:49:24');
INSERT INTO `categories` VALUES (27, 'category_jewellery_fluid.png', 2, 80, 3, 240, '2010-06-30 21:45:59', '2010-10-22 21:59:16');
INSERT INTO `categories` VALUES (28, 'category_jewellery_fluid_earrings.png', 27, 0, NULL, NULL, '2010-06-30 21:53:54', '2010-06-30 22:08:38');
INSERT INTO `categories` VALUES (30, 'category_jewellery_fluid_pendants.png', 27, 0, NULL, NULL, '2010-06-30 21:54:42', '2010-06-30 22:08:52');
INSERT INTO `categories` VALUES (31, 'category_jewellery_fluid_bracelets.png', 27, 0, NULL, NULL, '2010-06-30 21:54:52', '2010-06-30 22:09:24');
INSERT INTO `categories` VALUES (32, NULL, 0, 30, NULL, NULL, '2010-08-13 19:48:53', '2010-08-13 19:52:39');
INSERT INTO `categories` VALUES (33, 'category_pewter_quaichco.png', 32, 10, NULL, NULL, '2010-08-13 19:49:13', '2010-08-13 19:49:30');
INSERT INTO `categories` VALUES (34, 'category_pewter_englishpewter.png', 32, 20, NULL, NULL, '2010-08-13 19:49:21', '2010-08-13 19:49:36');
INSERT INTO `categories` VALUES (35, 'category_goldear.png', 2, 20, NULL, NULL, '2010-10-15 12:10:37', '2010-11-12 11:02:03');
INSERT INTO `categories` VALUES (36, 'category_goldpend.png', 2, 30, NULL, NULL, '2010-10-16 09:10:05', '2010-11-12 11:10:33');
INSERT INTO `categories` VALUES (37, 'category_jewellery_glassbeads.png', 2, 10, NULL, NULL, '2010-10-16 14:59:27', '2010-10-22 21:58:51');
INSERT INTO `categories` VALUES (38, 'category_jewellery_silvercharms.png', 2, 15, NULL, NULL, '2010-10-16 18:23:07', '2010-10-22 22:00:03');
INSERT INTO `categories` VALUES (39, 'category_pewter_widdop.png', 32, 0, NULL, NULL, '2010-10-22 14:31:43', NULL);
INSERT INTO `categories` VALUES (40, '31083001.png', 35, 0, NULL, NULL, '2010-10-29 14:04:16', '2010-10-30 15:18:43');
INSERT INTO `categories` VALUES (41, '31759001.png', 35, 0, NULL, NULL, '2010-10-29 14:20:48', '2010-10-30 11:40:29');
INSERT INTO `categories` VALUES (43, 'category_goldweddingrings.png', 2, 0, NULL, NULL, '2010-11-10 16:12:31', '2010-11-12 09:55:40');

-- --------------------------------------------------------

--
-- Table structure for table `categories_description`
--

CREATE TABLE `categories_description` (
  `categories_id` int(11) NOT NULL default '0',
  `language_id` int(11) NOT NULL default '1',
  `categories_name` varchar(32) NOT NULL,
  PRIMARY KEY  (`categories_id`,`language_id`),
  KEY `idx_categories_name` (`categories_name`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `categories_description`
--

INSERT INTO `categories_description` VALUES (1, 1, 'Watches');
INSERT INTO `categories_description` VALUES (2, 1, 'Jewellery');
INSERT INTO `categories_description` VALUES (3, 1, 'Citizen');
INSERT INTO `categories_description` VALUES (4, 1, 'Sekonda');
INSERT INTO `categories_description` VALUES (5, 1, 'Accurist');
INSERT INTO `categories_description` VALUES (6, 1, 'Seksy');
INSERT INTO `categories_description` VALUES (8, 1, 'D for Diamond');
INSERT INTO `categories_description` VALUES (10, 1, 'Elements Silver');
INSERT INTO `categories_description` VALUES (11, 1, 'Fred Bennett');
INSERT INTO `categories_description` VALUES (12, 1, 'Gents');
INSERT INTO `categories_description` VALUES (13, 1, 'Ladies');
INSERT INTO `categories_description` VALUES (14, 1, 'Gents');
INSERT INTO `categories_description` VALUES (15, 1, 'Ladies');
INSERT INTO `categories_description` VALUES (16, 1, 'Earrings');
INSERT INTO `categories_description` VALUES (17, 1, 'Bracelets & Bangles');
INSERT INTO `categories_description` VALUES (18, 1, 'Pendants & Necklaces');
INSERT INTO `categories_description` VALUES (40, 1, '9ct Hoop Earrings');
INSERT INTO `categories_description` VALUES (20, 1, 'Bracelets & Bangles');
INSERT INTO `categories_description` VALUES (21, 1, 'Pendants & Necklaces');
INSERT INTO `categories_description` VALUES (23, 1, 'Cufflinks');
INSERT INTO `categories_description` VALUES (24, 1, 'Gents');
INSERT INTO `categories_description` VALUES (25, 1, 'Ladies');
INSERT INTO `categories_description` VALUES (27, 1, 'Fluid');
INSERT INTO `categories_description` VALUES (28, 1, 'Earrings');
INSERT INTO `categories_description` VALUES (30, 1, 'Pendants & Necklaces');
INSERT INTO `categories_description` VALUES (31, 1, 'Bracelets & Bangles');
INSERT INTO `categories_description` VALUES (32, 1, 'Pewter');
INSERT INTO `categories_description` VALUES (33, 1, 'Quaich Company');
INSERT INTO `categories_description` VALUES (34, 1, 'English Pewter');
INSERT INTO `categories_description` VALUES (35, 1, 'Gold Earrings');
INSERT INTO `categories_description` VALUES (36, 1, 'Gold Pendants');
INSERT INTO `categories_description` VALUES (37, 1, 'Glass Charm Beads');
INSERT INTO `categories_description` VALUES (38, 1, 'Silver Charm Beads');
INSERT INTO `categories_description` VALUES (39, 1, 'Widdop & Bingham');
INSERT INTO `categories_description` VALUES (41, 1, '9ct Stud Earrings');
INSERT INTO `categories_description` VALUES (43, 1, 'Wedding Rings');

-- --------------------------------------------------------

--
-- Table structure for table `configuration`
--

CREATE TABLE `configuration` (
  `configuration_id` int(11) NOT NULL auto_increment,
  `configuration_title` varchar(255) NOT NULL,
  `configuration_key` varchar(255) NOT NULL,
  `configuration_value` varchar(255) NOT NULL,
  `configuration_description` varchar(255) NOT NULL,
  `configuration_group_id` int(11) NOT NULL,
  `sort_order` int(5) default NULL,
  `last_modified` datetime default NULL,
  `date_added` datetime NOT NULL,
  `use_function` varchar(255) default NULL,
  `set_function` varchar(255) default NULL,
  PRIMARY KEY  (`configuration_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=189 ;

--
-- Dumping data for table `configuration`
--

INSERT INTO `configuration` VALUES (1, 'Store Name', 'STORE_NAME', 'J. Mitchell & Son Jewellers', 'The name of my store', 1, 1, NULL, '2010-04-26 09:31:37', NULL, NULL);
INSERT INTO `configuration` VALUES (2, 'Store Owner', 'STORE_OWNER', 'John Laing', 'The name of my store owner', 1, 2, NULL, '2010-04-26 09:31:37', NULL, NULL);
INSERT INTO `configuration` VALUES (3, 'E-Mail Address', 'STORE_OWNER_EMAIL_ADDRESS', 'sales@jmitchellandson.co.uk', 'The e-mail address of my store owner', 1, 3, NULL, '2010-04-26 09:31:37', NULL, NULL);
INSERT INTO `configuration` VALUES (4, 'E-Mail From', 'EMAIL_FROM', '"John Laing" <sales@jmitchellandson.co.uk>', 'The e-mail address used in (sent) e-mails', 1, 4, NULL, '2010-04-26 09:31:37', NULL, NULL);
INSERT INTO `configuration` VALUES (5, 'Country', 'STORE_COUNTRY', '222', 'The country my store is located in <br><br><b>Note: Please remember to update the store zone.</b>', 1, 6, NULL, '2010-04-26 09:31:37', 'tep_get_country_name', 'tep_cfg_pull_down_country_list(');
INSERT INTO `configuration` VALUES (6, 'Zone', 'STORE_ZONE', '266', 'The zone my store is located in', 1, 7, '2010-04-26 09:44:48', '2010-04-26 09:31:37', 'tep_cfg_get_zone_name', 'tep_cfg_pull_down_zone_list(');
INSERT INTO `configuration` VALUES (7, 'Expected Sort Order', 'EXPECTED_PRODUCTS_SORT', 'desc', 'This is the sort order used in the expected products box.', 1, 8, NULL, '2010-04-26 09:31:37', NULL, 'tep_cfg_select_option(array(''asc'', ''desc''), ');
INSERT INTO `configuration` VALUES (8, 'Expected Sort Field', 'EXPECTED_PRODUCTS_FIELD', 'date_expected', 'The column to sort by in the expected products box.', 1, 9, NULL, '2010-04-26 09:31:37', NULL, 'tep_cfg_select_option(array(''products_name'', ''date_expected''), ');
INSERT INTO `configuration` VALUES (9, 'Switch To Default Language Currency', 'USE_DEFAULT_LANGUAGE_CURRENCY', 'false', 'Automatically switch to the language''s currency when it is changed', 1, 10, NULL, '2010-04-26 09:31:37', NULL, 'tep_cfg_select_option(array(''true'', ''false''), ');
INSERT INTO `configuration` VALUES (10, 'Send Extra Order Emails To', 'SEND_EXTRA_ORDER_EMAILS_TO', '', 'Send extra order emails to the following email addresses, in this format: Name 1 &lt;email@address1&gt;, Name 2 &lt;email@address2&gt;', 1, 11, NULL, '2010-04-26 09:31:37', NULL, NULL);
INSERT INTO `configuration` VALUES (11, 'Use Search-Engine Safe URLs (still in development)', 'SEARCH_ENGINE_FRIENDLY_URLS', 'false', 'Use search-engine safe urls for all site links', 1, 12, NULL, '2010-04-26 09:31:37', NULL, 'tep_cfg_select_option(array(''true'', ''false''), ');
INSERT INTO `configuration` VALUES (12, 'Display Cart After Adding Product', 'DISPLAY_CART', 'true', 'Display the shopping cart after adding a product (or return back to their origin)', 1, 14, NULL, '2010-04-26 09:31:37', NULL, 'tep_cfg_select_option(array(''true'', ''false''), ');
INSERT INTO `configuration` VALUES (13, 'Allow Guest To Tell A Friend', 'ALLOW_GUEST_TO_TELL_A_FRIEND', 'false', 'Allow guests to tell a friend about a product', 1, 15, NULL, '2010-04-26 09:31:37', NULL, 'tep_cfg_select_option(array(''true'', ''false''), ');
INSERT INTO `configuration` VALUES (14, 'Default Search Operator', 'ADVANCED_SEARCH_DEFAULT_OPERATOR', 'and', 'Default search operators', 1, 17, NULL, '2010-04-26 09:31:37', NULL, 'tep_cfg_select_option(array(''and'', ''or''), ');
INSERT INTO `configuration` VALUES (15, 'Store Address and Phone', 'STORE_NAME_ADDRESS', 'J.Mitchell &amp; Son\n20 High Street\nBrechin\nAngus\nUnited Kingdom\nDD9 6ER\n01356 624015\nsales@jmitchellandson.co.uk', 'This is the Store Name, Address and Phone used on printable documents and displayed online', 1, 18, NULL, '2010-04-26 09:31:37', NULL, 'tep_cfg_textarea(');
INSERT INTO `configuration` VALUES (16, 'Show Category Counts', 'SHOW_COUNTS', 'true', 'Count recursively how many products are in each category', 1, 19, NULL, '2010-04-26 09:31:37', NULL, 'tep_cfg_select_option(array(''true'', ''false''), ');
INSERT INTO `configuration` VALUES (17, 'Tax Decimal Places', 'TAX_DECIMAL_PLACES', '0', 'Pad the tax value this amount of decimal places', 1, 20, NULL, '2010-04-26 09:31:37', NULL, NULL);
INSERT INTO `configuration` VALUES (18, 'Display Prices with Tax', 'DISPLAY_PRICE_WITH_TAX', 'true', 'Display prices with tax included (true) or add the tax at the end (false)', 1, 21, NULL, '2010-04-26 09:31:37', NULL, 'tep_cfg_select_option(array(''true'', ''false''), ');
INSERT INTO `configuration` VALUES (19, 'First Name', 'ENTRY_FIRST_NAME_MIN_LENGTH', '2', 'Minimum length of first name', 2, 1, NULL, '2010-04-26 09:31:37', NULL, NULL);
INSERT INTO `configuration` VALUES (20, 'Last Name', 'ENTRY_LAST_NAME_MIN_LENGTH', '2', 'Minimum length of last name', 2, 2, NULL, '2010-04-26 09:31:37', NULL, NULL);
INSERT INTO `configuration` VALUES (21, 'Date of Birth', 'ENTRY_DOB_MIN_LENGTH', '10', 'Minimum length of date of birth', 2, 3, NULL, '2010-04-26 09:31:37', NULL, NULL);
INSERT INTO `configuration` VALUES (22, 'E-Mail Address', 'ENTRY_EMAIL_ADDRESS_MIN_LENGTH', '6', 'Minimum length of e-mail address', 2, 4, NULL, '2010-04-26 09:31:37', NULL, NULL);
INSERT INTO `configuration` VALUES (23, 'Street Address', 'ENTRY_STREET_ADDRESS_MIN_LENGTH', '5', 'Minimum length of street address', 2, 5, NULL, '2010-04-26 09:31:37', NULL, NULL);
INSERT INTO `configuration` VALUES (24, 'Company', 'ENTRY_COMPANY_MIN_LENGTH', '2', 'Minimum length of company name', 2, 6, NULL, '2010-04-26 09:31:37', NULL, NULL);
INSERT INTO `configuration` VALUES (25, 'Post Code', 'ENTRY_POSTCODE_MIN_LENGTH', '4', 'Minimum length of post code', 2, 7, NULL, '2010-04-26 09:31:37', NULL, NULL);
INSERT INTO `configuration` VALUES (26, 'City', 'ENTRY_CITY_MIN_LENGTH', '3', 'Minimum length of city', 2, 8, NULL, '2010-04-26 09:31:37', NULL, NULL);
INSERT INTO `configuration` VALUES (27, 'State', 'ENTRY_STATE_MIN_LENGTH', '2', 'Minimum length of state', 2, 9, NULL, '2010-04-26 09:31:37', NULL, NULL);
INSERT INTO `configuration` VALUES (28, 'Telephone Number', 'ENTRY_TELEPHONE_MIN_LENGTH', '3', 'Minimum length of telephone number', 2, 10, NULL, '2010-04-26 09:31:37', NULL, NULL);
INSERT INTO `configuration` VALUES (29, 'Password', 'ENTRY_PASSWORD_MIN_LENGTH', '5', 'Minimum length of password', 2, 11, NULL, '2010-04-26 09:31:37', NULL, NULL);
INSERT INTO `configuration` VALUES (30, 'Credit Card Owner Name', 'CC_OWNER_MIN_LENGTH', '3', 'Minimum length of credit card owner name', 2, 12, NULL, '2010-04-26 09:31:37', NULL, NULL);
INSERT INTO `configuration` VALUES (31, 'Credit Card Number', 'CC_NUMBER_MIN_LENGTH', '10', 'Minimum length of credit card number', 2, 13, NULL, '2010-04-26 09:31:37', NULL, NULL);
INSERT INTO `configuration` VALUES (32, 'Review Text', 'REVIEW_TEXT_MIN_LENGTH', '50', 'Minimum length of review text', 2, 14, NULL, '2010-04-26 09:31:37', NULL, NULL);
INSERT INTO `configuration` VALUES (33, 'Best Sellers', 'MIN_DISPLAY_BESTSELLERS', '1', 'Minimum number of best sellers to display', 2, 15, NULL, '2010-04-26 09:31:37', NULL, NULL);
INSERT INTO `configuration` VALUES (34, 'Also Purchased', 'MIN_DISPLAY_ALSO_PURCHASED', '1', 'Minimum number of products to display in the ''This Customer Also Purchased'' box', 2, 16, NULL, '2010-04-26 09:31:37', NULL, NULL);
INSERT INTO `configuration` VALUES (35, 'Address Book Entries', 'MAX_ADDRESS_BOOK_ENTRIES', '5', 'Maximum address book entries a customer is allowed to have', 3, 1, NULL, '2010-04-26 09:31:37', NULL, NULL);
INSERT INTO `configuration` VALUES (36, 'Search Results', 'MAX_DISPLAY_SEARCH_RESULTS', '16', 'Amount of products to list', 3, 2, NULL, '2010-04-26 09:31:37', NULL, NULL);
INSERT INTO `configuration` VALUES (37, 'Page Links', 'MAX_DISPLAY_PAGE_LINKS', '5', 'Number of ''number'' links use for page-sets', 3, 3, NULL, '2010-04-26 09:31:37', NULL, NULL);
INSERT INTO `configuration` VALUES (38, 'Special Products', 'MAX_DISPLAY_SPECIAL_PRODUCTS', '16', 'Maximum number of products on special to display', 3, 4, NULL, '2010-04-26 09:31:37', NULL, NULL);
INSERT INTO `configuration` VALUES (39, 'New Products Module', 'MAX_DISPLAY_NEW_PRODUCTS', '16', 'Maximum number of new products to display in a category', 3, 5, NULL, '2010-04-26 09:31:37', NULL, NULL);
INSERT INTO `configuration` VALUES (40, 'Products Expected', 'MAX_DISPLAY_UPCOMING_PRODUCTS', '10', 'Maximum number of products expected to display', 3, 6, NULL, '2010-04-26 09:31:37', NULL, NULL);
INSERT INTO `configuration` VALUES (41, 'Manufacturers List', 'MAX_DISPLAY_MANUFACTURERS_IN_A_LIST', '0', 'Used in manufacturers box; when the number of manufacturers exceeds this number, a drop-down list will be displayed instead of the default list', 3, 7, NULL, '2010-04-26 09:31:37', NULL, NULL);
INSERT INTO `configuration` VALUES (42, 'Manufacturers Select Size', 'MAX_MANUFACTURERS_LIST', '1', 'Used in manufacturers box; when this value is ''1'' the classic drop-down list will be used for the manufacturers box. Otherwise, a list-box with the specified number of rows will be displayed.', 3, 7, NULL, '2010-04-26 09:31:37', NULL, NULL);
INSERT INTO `configuration` VALUES (43, 'Length of Manufacturers Name', 'MAX_DISPLAY_MANUFACTURER_NAME_LEN', '15', 'Used in manufacturers box; maximum length of manufacturers name to display', 3, 8, NULL, '2010-04-26 09:31:37', NULL, NULL);
INSERT INTO `configuration` VALUES (44, 'New Reviews', 'MAX_DISPLAY_NEW_REVIEWS', '6', 'Maximum number of new reviews to display', 3, 9, NULL, '2010-04-26 09:31:37', NULL, NULL);
INSERT INTO `configuration` VALUES (45, 'Selection of Random Reviews', 'MAX_RANDOM_SELECT_REVIEWS', '10', 'How many records to select from to choose one random product review', 3, 10, NULL, '2010-04-26 09:31:37', NULL, NULL);
INSERT INTO `configuration` VALUES (46, 'Selection of Random New Products', 'MAX_RANDOM_SELECT_NEW', '10', 'How many records to select from to choose one random new product to display', 3, 11, NULL, '2010-04-26 09:31:37', NULL, NULL);
INSERT INTO `configuration` VALUES (47, 'Selection of Products on Special', 'MAX_RANDOM_SELECT_SPECIALS', '10', 'How many records to select from to choose one random product special to display', 3, 12, NULL, '2010-04-26 09:31:37', NULL, NULL);
INSERT INTO `configuration` VALUES (48, 'Categories To List Per Row', 'MAX_DISPLAY_CATEGORIES_PER_ROW', '2', 'How many categories to list per row', 3, 13, NULL, '2010-04-26 09:31:37', NULL, NULL);
INSERT INTO `configuration` VALUES (49, 'New Products Listing', 'MAX_DISPLAY_PRODUCTS_NEW', '10', 'Maximum number of new products to display in new products page', 3, 14, NULL, '2010-04-26 09:31:37', NULL, NULL);
INSERT INTO `configuration` VALUES (50, 'Best Sellers', 'MAX_DISPLAY_BESTSELLERS', '10', 'Maximum number of best sellers to display', 3, 15, NULL, '2010-04-26 09:31:37', NULL, NULL);
INSERT INTO `configuration` VALUES (51, 'Also Purchased', 'MAX_DISPLAY_ALSO_PURCHASED', '6', 'Maximum number of products to display in the ''This Customer Also Purchased'' box', 3, 16, NULL, '2010-04-26 09:31:37', NULL, NULL);
INSERT INTO `configuration` VALUES (52, 'Customer Order History Box', 'MAX_DISPLAY_PRODUCTS_IN_ORDER_HISTORY_BOX', '6', 'Maximum number of products to display in the customer order history box', 3, 17, NULL, '2010-04-26 09:31:37', NULL, NULL);
INSERT INTO `configuration` VALUES (53, 'Order History', 'MAX_DISPLAY_ORDER_HISTORY', '10', 'Maximum number of orders to display in the order history page', 3, 18, NULL, '2010-04-26 09:31:37', NULL, NULL);
INSERT INTO `configuration` VALUES (54, 'Product Quantities In Shopping Cart', 'MAX_QTY_IN_CART', '99', 'Maximum number of product quantities that can be added to the shopping cart (0 for no limit)', 3, 19, NULL, '2010-04-26 09:31:37', NULL, NULL);
INSERT INTO `configuration` VALUES (55, 'Small Image Width', 'SMALL_IMAGE_WIDTH', '100', 'The pixel width of small images', 4, 1, NULL, '2010-04-26 09:31:37', NULL, NULL);
INSERT INTO `configuration` VALUES (56, 'Small Image Height', 'SMALL_IMAGE_HEIGHT', '140', 'The pixel height of small images', 4, 2, NULL, '2010-04-26 09:31:37', NULL, NULL);
INSERT INTO `configuration` VALUES (57, 'Heading Image Width', 'HEADING_IMAGE_WIDTH', '370', 'The pixel width of heading images', 4, 3, NULL, '2010-04-26 09:31:37', NULL, NULL);
INSERT INTO `configuration` VALUES (58, 'Heading Image Height', 'HEADING_IMAGE_HEIGHT', '40', 'The pixel height of heading images', 4, 4, NULL, '2010-04-26 09:31:37', NULL, NULL);
INSERT INTO `configuration` VALUES (59, 'Subcategory Image Width', 'SUBCATEGORY_IMAGE_WIDTH', '370', 'The pixel width of subcategory images', 4, 5, '2010-04-26 10:52:22', '2010-04-26 09:31:37', NULL, NULL);
INSERT INTO `configuration` VALUES (60, 'Subcategory Image Height', 'SUBCATEGORY_IMAGE_HEIGHT', '100', 'The pixel height of subcategory images', 4, 6, '2010-04-26 10:52:53', '2010-04-26 09:31:37', NULL, NULL);
INSERT INTO `configuration` VALUES (61, 'Calculate Image Size', 'CONFIG_CALCULATE_IMAGE_SIZE', 'true', 'Calculate the size of images?', 4, 7, NULL, '2010-04-26 09:31:37', NULL, 'tep_cfg_select_option(array(''true'', ''false''), ');
INSERT INTO `configuration` VALUES (62, 'Image Required', 'IMAGE_REQUIRED', 'true', 'Enable to display broken images. Good for development.', 4, 8, NULL, '2010-04-26 09:31:37', NULL, 'tep_cfg_select_option(array(''true'', ''false''), ');
INSERT INTO `configuration` VALUES (63, 'Gender', 'ACCOUNT_GENDER', 'true', 'Display gender in the customers account', 5, 1, NULL, '2010-04-26 09:31:37', NULL, 'tep_cfg_select_option(array(''true'', ''false''), ');
INSERT INTO `configuration` VALUES (64, 'Date of Birth', 'ACCOUNT_DOB', 'true', 'Display date of birth in the customers account', 5, 2, NULL, '2010-04-26 09:31:37', NULL, 'tep_cfg_select_option(array(''true'', ''false''), ');
INSERT INTO `configuration` VALUES (65, 'Company', 'ACCOUNT_COMPANY', 'true', 'Display company in the customers account', 5, 3, NULL, '2010-04-26 09:31:37', NULL, 'tep_cfg_select_option(array(''true'', ''false''), ');
INSERT INTO `configuration` VALUES (66, 'Suburb', 'ACCOUNT_SUBURB', 'true', 'Display suburb in the customers account', 5, 4, NULL, '2010-04-26 09:31:37', NULL, 'tep_cfg_select_option(array(''true'', ''false''), ');
INSERT INTO `configuration` VALUES (67, 'State', 'ACCOUNT_STATE', 'true', 'Display state in the customers account', 5, 5, NULL, '2010-04-26 09:31:37', NULL, 'tep_cfg_select_option(array(''true'', ''false''), ');
INSERT INTO `configuration` VALUES (68, 'Installed Modules', 'MODULE_PAYMENT_INSTALLED', 'worldpay_junior.php', 'List of payment module filenames separated by a semi-colon. This is automatically updated. No need to edit. (Example: cc.php;cod.php;paypal.php)', 6, 0, '2010-06-24 23:45:53', '2010-04-26 09:31:37', NULL, NULL);
INSERT INTO `configuration` VALUES (69, 'Installed Modules', 'MODULE_ORDER_TOTAL_INSTALLED', 'ot_subtotal.php;ot_shipping.php;ot_tax.php;ot_total.php', 'List of order_total module filenames separated by a semi-colon. This is automatically updated. No need to edit. (Example: ot_subtotal.php;ot_tax.php;ot_shipping.php;ot_total.php)', 6, 0, '2010-04-26 11:34:40', '2010-04-26 09:31:37', NULL, NULL);
INSERT INTO `configuration` VALUES (70, 'Installed Modules', 'MODULE_SHIPPING_INSTALLED', 'table.php', 'List of shipping module filenames separated by a semi-colon. This is automatically updated. No need to edit. (Example: ups.php;flat.php;item.php)', 6, 0, '2010-04-28 17:08:02', '2010-04-26 09:31:37', NULL, NULL);
INSERT INTO `configuration` VALUES (85, 'Default Currency', 'DEFAULT_CURRENCY', 'GBP', 'Default Currency', 6, 0, NULL, '2010-04-26 09:31:37', NULL, NULL);
INSERT INTO `configuration` VALUES (86, 'Default Language', 'DEFAULT_LANGUAGE', 'en', 'Default Language', 6, 0, NULL, '2010-04-26 09:31:37', NULL, NULL);
INSERT INTO `configuration` VALUES (87, 'Default Order Status For New Orders', 'DEFAULT_ORDERS_STATUS_ID', '1', 'When a new order is created, this order status will be assigned to it.', 6, 0, NULL, '2010-04-26 09:31:37', NULL, NULL);
INSERT INTO `configuration` VALUES (88, 'Display Shipping', 'MODULE_ORDER_TOTAL_SHIPPING_STATUS', 'true', 'Do you want to display the order shipping cost?', 6, 1, NULL, '2010-04-26 09:31:37', NULL, 'tep_cfg_select_option(array(''true'', ''false''), ');
INSERT INTO `configuration` VALUES (89, 'Sort Order', 'MODULE_ORDER_TOTAL_SHIPPING_SORT_ORDER', '2', 'Sort order of display.', 6, 2, NULL, '2010-04-26 09:31:37', NULL, NULL);
INSERT INTO `configuration` VALUES (90, 'Allow Free Shipping', 'MODULE_ORDER_TOTAL_SHIPPING_FREE_SHIPPING', 'false', 'Do you want to allow free shipping?', 6, 3, NULL, '2010-04-26 09:31:37', NULL, 'tep_cfg_select_option(array(''true'', ''false''), ');
INSERT INTO `configuration` VALUES (91, 'Free Shipping For Orders Over', 'MODULE_ORDER_TOTAL_SHIPPING_FREE_SHIPPING_OVER', '50', 'Provide free shipping for orders over the set amount.', 6, 4, NULL, '2010-04-26 09:31:37', 'currencies->format', NULL);
INSERT INTO `configuration` VALUES (92, 'Provide Free Shipping For Orders Made', 'MODULE_ORDER_TOTAL_SHIPPING_DESTINATION', 'national', 'Provide free shipping for orders sent to the set destination.', 6, 5, NULL, '2010-04-26 09:31:37', NULL, 'tep_cfg_select_option(array(''national'', ''international'', ''both''), ');
INSERT INTO `configuration` VALUES (93, 'Display Sub-Total', 'MODULE_ORDER_TOTAL_SUBTOTAL_STATUS', 'true', 'Do you want to display the order sub-total cost?', 6, 1, NULL, '2010-04-26 09:31:37', NULL, 'tep_cfg_select_option(array(''true'', ''false''), ');
INSERT INTO `configuration` VALUES (94, 'Sort Order', 'MODULE_ORDER_TOTAL_SUBTOTAL_SORT_ORDER', '1', 'Sort order of display.', 6, 2, NULL, '2010-04-26 09:31:37', NULL, NULL);
INSERT INTO `configuration` VALUES (95, 'Display Tax', 'MODULE_ORDER_TOTAL_TAX_STATUS', 'true', 'Do you want to display the order tax value?', 6, 1, NULL, '2010-04-26 09:31:37', NULL, 'tep_cfg_select_option(array(''true'', ''false''), ');
INSERT INTO `configuration` VALUES (96, 'Sort Order', 'MODULE_ORDER_TOTAL_TAX_SORT_ORDER', '3', 'Sort order of display.', 6, 2, NULL, '2010-04-26 09:31:37', NULL, NULL);
INSERT INTO `configuration` VALUES (97, 'Display Total', 'MODULE_ORDER_TOTAL_TOTAL_STATUS', 'true', 'Do you want to display the total order value?', 6, 1, NULL, '2010-04-26 09:31:37', NULL, 'tep_cfg_select_option(array(''true'', ''false''), ');
INSERT INTO `configuration` VALUES (98, 'Sort Order', 'MODULE_ORDER_TOTAL_TOTAL_SORT_ORDER', '4', 'Sort order of display.', 6, 2, NULL, '2010-04-26 09:31:37', NULL, NULL);
INSERT INTO `configuration` VALUES (99, 'Country of Origin', 'SHIPPING_ORIGIN_COUNTRY', '222', 'Select the country of origin to be used in shipping quotes.', 7, 1, '2010-04-28 17:05:37', '2010-04-26 09:31:37', 'tep_get_country_name', 'tep_cfg_pull_down_country_list(');
INSERT INTO `configuration` VALUES (100, 'Postal Code', 'SHIPPING_ORIGIN_ZIP', 'DD9', 'Enter the Postal Code (ZIP) of the Store to be used in shipping quotes.', 7, 2, '2010-04-28 17:05:50', '2010-04-26 09:31:37', NULL, NULL);
INSERT INTO `configuration` VALUES (101, 'Enter the Maximum Package Weight you will ship', 'SHIPPING_MAX_WEIGHT', '50', 'Carriers have a max weight limit for a single package. This is a common one for all.', 7, 3, NULL, '2010-04-26 09:31:37', NULL, NULL);
INSERT INTO `configuration` VALUES (102, 'Package Tare weight.', 'SHIPPING_BOX_WEIGHT', '3', 'What is the weight of typical packaging of small to medium packages?', 7, 4, NULL, '2010-04-26 09:31:37', NULL, NULL);
INSERT INTO `configuration` VALUES (103, 'Larger packages - percentage increase.', 'SHIPPING_BOX_PADDING', '10', 'For 10% enter 10', 7, 5, NULL, '2010-04-26 09:31:37', NULL, NULL);
INSERT INTO `configuration` VALUES (104, 'Display Product Image', 'PRODUCT_LIST_IMAGE', '1', 'Do you want to display the Product Image?', 8, 1, NULL, '2010-04-26 09:31:37', NULL, NULL);
INSERT INTO `configuration` VALUES (105, 'Display Product Manufaturer Name', 'PRODUCT_LIST_MANUFACTURER', '0', 'Do you want to display the Product Manufacturer Name?', 8, 2, NULL, '2010-04-26 09:31:37', NULL, NULL);
INSERT INTO `configuration` VALUES (106, 'Display Product Model', 'PRODUCT_LIST_MODEL', '0', 'Do you want to display the Product Model?', 8, 3, NULL, '2010-04-26 09:31:37', NULL, NULL);
INSERT INTO `configuration` VALUES (107, 'Display Product Name', 'PRODUCT_LIST_NAME', '2', 'Do you want to display the Product Name?', 8, 4, NULL, '2010-04-26 09:31:37', NULL, NULL);
INSERT INTO `configuration` VALUES (108, 'Display Product Price', 'PRODUCT_LIST_PRICE', '3', 'Do you want to display the Product Price', 8, 5, NULL, '2010-04-26 09:31:37', NULL, NULL);
INSERT INTO `configuration` VALUES (109, 'Display Product Quantity', 'PRODUCT_LIST_QUANTITY', '0', 'Do you want to display the Product Quantity?', 8, 6, NULL, '2010-04-26 09:31:37', NULL, NULL);
INSERT INTO `configuration` VALUES (110, 'Display Product Weight', 'PRODUCT_LIST_WEIGHT', '0', 'Do you want to display the Product Weight?', 8, 7, NULL, '2010-04-26 09:31:37', NULL, NULL);
INSERT INTO `configuration` VALUES (111, 'Display Buy Now column', 'PRODUCT_LIST_BUY_NOW', '4', 'Do you want to display the Buy Now column?', 8, 8, NULL, '2010-04-26 09:31:37', NULL, NULL);
INSERT INTO `configuration` VALUES (112, 'Display Category/Manufacturer Filter (0=disable; 1=enable)', 'PRODUCT_LIST_FILTER', '1', 'Do you want to display the Category/Manufacturer Filter?', 8, 9, NULL, '2010-04-26 09:31:37', NULL, NULL);
INSERT INTO `configuration` VALUES (113, 'Location of Prev/Next Navigation Bar (1-top, 2-bottom, 3-both)', 'PREV_NEXT_BAR_LOCATION', '2', 'Sets the location of the Prev/Next Navigation Bar (1-top, 2-bottom, 3-both)', 8, 10, NULL, '2010-04-26 09:31:37', NULL, NULL);
INSERT INTO `configuration` VALUES (114, 'Check stock level', 'STOCK_CHECK', 'true', 'Check to see if sufficent stock is available', 9, 1, NULL, '2010-04-26 09:31:37', NULL, 'tep_cfg_select_option(array(''true'', ''false''), ');
INSERT INTO `configuration` VALUES (115, 'Subtract stock', 'STOCK_LIMITED', 'true', 'Subtract product in stock by product orders', 9, 2, NULL, '2010-04-26 09:31:37', NULL, 'tep_cfg_select_option(array(''true'', ''false''), ');
INSERT INTO `configuration` VALUES (116, 'Allow Checkout', 'STOCK_ALLOW_CHECKOUT', 'true', 'Allow customer to checkout even if there is insufficient stock', 9, 3, NULL, '2010-04-26 09:31:37', NULL, 'tep_cfg_select_option(array(''true'', ''false''), ');
INSERT INTO `configuration` VALUES (117, 'Mark product out of stock', 'STOCK_MARK_PRODUCT_OUT_OF_STOCK', '***', 'Display something on screen so customer can see which product has insufficient stock', 9, 4, NULL, '2010-04-26 09:31:37', NULL, NULL);
INSERT INTO `configuration` VALUES (118, 'Stock Re-order level', 'STOCK_REORDER_LEVEL', '5', 'Define when stock needs to be re-ordered', 9, 5, NULL, '2010-04-26 09:31:37', NULL, NULL);
INSERT INTO `configuration` VALUES (119, 'Store Page Parse Time', 'STORE_PAGE_PARSE_TIME', 'false', 'Store the time it takes to parse a page', 10, 1, NULL, '2010-04-26 09:31:37', NULL, 'tep_cfg_select_option(array(''true'', ''false''), ');
INSERT INTO `configuration` VALUES (120, 'Log Destination', 'STORE_PAGE_PARSE_TIME_LOG', '/var/log/www/tep/page_parse_time.log', 'Directory and filename of the page parse time log', 10, 2, NULL, '2010-04-26 09:31:37', NULL, NULL);
INSERT INTO `configuration` VALUES (121, 'Log Date Format', 'STORE_PARSE_DATE_TIME_FORMAT', '%d/%m/%Y %H:%M:%S', 'The date format', 10, 3, NULL, '2010-04-26 09:31:37', NULL, NULL);
INSERT INTO `configuration` VALUES (122, 'Display The Page Parse Time', 'DISPLAY_PAGE_PARSE_TIME', 'true', 'Display the page parse time (store page parse time must be enabled)', 10, 4, NULL, '2010-04-26 09:31:37', NULL, 'tep_cfg_select_option(array(''true'', ''false''), ');
INSERT INTO `configuration` VALUES (123, 'Store Database Queries', 'STORE_DB_TRANSACTIONS', 'false', 'Store the database queries in the page parse time log (PHP4 only)', 10, 5, NULL, '2010-04-26 09:31:37', NULL, 'tep_cfg_select_option(array(''true'', ''false''), ');
INSERT INTO `configuration` VALUES (124, 'Use Cache', 'USE_CACHE', 'false', 'Use caching features', 11, 1, NULL, '2010-04-26 09:31:37', NULL, 'tep_cfg_select_option(array(''true'', ''false''), ');
INSERT INTO `configuration` VALUES (125, 'Cache Directory', 'DIR_FS_CACHE', '/tmp/', 'The directory where the cached files are saved', 11, 2, NULL, '2010-04-26 09:31:37', NULL, NULL);
INSERT INTO `configuration` VALUES (126, 'E-Mail Transport Method', 'EMAIL_TRANSPORT', 'sendmail', 'Defines if this server uses a local connection to sendmail or uses an SMTP connection via TCP/IP. Servers running on Windows and MacOS should change this setting to SMTP.', 12, 1, NULL, '2010-04-26 09:31:37', NULL, 'tep_cfg_select_option(array(''sendmail'', ''smtp''),');
INSERT INTO `configuration` VALUES (127, 'E-Mail Linefeeds', 'EMAIL_LINEFEED', 'LF', 'Defines the character sequence used to separate mail headers.', 12, 2, NULL, '2010-04-26 09:31:37', NULL, 'tep_cfg_select_option(array(''LF'', ''CRLF''),');
INSERT INTO `configuration` VALUES (128, 'Use MIME HTML When Sending Emails', 'EMAIL_USE_HTML', 'true', 'Send e-mails in HTML format', 12, 3, '2010-04-26 09:45:52', '2010-04-26 09:31:37', NULL, 'tep_cfg_select_option(array(''true'', ''false''),');
INSERT INTO `configuration` VALUES (129, 'Verify E-Mail Addresses Through DNS', 'ENTRY_EMAIL_ADDRESS_CHECK', 'false', 'Verify e-mail address through a DNS server', 12, 4, NULL, '2010-04-26 09:31:37', NULL, 'tep_cfg_select_option(array(''true'', ''false''), ');
INSERT INTO `configuration` VALUES (130, 'Send E-Mails', 'SEND_EMAILS', 'true', 'Send out e-mails', 12, 5, NULL, '2010-04-26 09:31:37', NULL, 'tep_cfg_select_option(array(''true'', ''false''), ');
INSERT INTO `configuration` VALUES (131, 'Enable download', 'DOWNLOAD_ENABLED', 'false', 'Enable the products download functions.', 13, 1, NULL, '2010-04-26 09:31:37', NULL, 'tep_cfg_select_option(array(''true'', ''false''), ');
INSERT INTO `configuration` VALUES (132, 'Download by redirect', 'DOWNLOAD_BY_REDIRECT', 'false', 'Use browser redirection for download. Disable on non-Unix systems.', 13, 2, NULL, '2010-04-26 09:31:37', NULL, 'tep_cfg_select_option(array(''true'', ''false''), ');
INSERT INTO `configuration` VALUES (133, 'Expiry delay (days)', 'DOWNLOAD_MAX_DAYS', '7', 'Set number of days before the download link expires. 0 means no limit.', 13, 3, NULL, '2010-04-26 09:31:37', NULL, '');
INSERT INTO `configuration` VALUES (134, 'Maximum number of downloads', 'DOWNLOAD_MAX_COUNT', '5', 'Set the maximum number of downloads. 0 means no download authorized.', 13, 4, NULL, '2010-04-26 09:31:37', NULL, '');
INSERT INTO `configuration` VALUES (135, 'Enable GZip Compression', 'GZIP_COMPRESSION', 'false', 'Enable HTTP GZip compression.', 14, 1, NULL, '2010-04-26 09:31:37', NULL, 'tep_cfg_select_option(array(''true'', ''false''), ');
INSERT INTO `configuration` VALUES (136, 'Compression Level', 'GZIP_LEVEL', '5', 'Use this compression level 0-9 (0 = minimum, 9 = maximum).', 14, 2, NULL, '2010-04-26 09:31:37', NULL, NULL);
INSERT INTO `configuration` VALUES (137, 'Session Directory', 'SESSION_WRITE_DIRECTORY', '/tmp', 'If sessions are file based, store them in this directory.', 15, 1, NULL, '2010-04-26 09:31:37', NULL, NULL);
INSERT INTO `configuration` VALUES (138, 'Force Cookie Use', 'SESSION_FORCE_COOKIE_USE', 'False', 'Force the use of sessions when cookies are only enabled.', 15, 2, NULL, '2010-04-26 09:31:37', NULL, 'tep_cfg_select_option(array(''True'', ''False''), ');
INSERT INTO `configuration` VALUES (139, 'Check SSL Session ID', 'SESSION_CHECK_SSL_SESSION_ID', 'False', 'Validate the SSL_SESSION_ID on every secure HTTPS page request.', 15, 3, NULL, '2010-04-26 09:31:37', NULL, 'tep_cfg_select_option(array(''True'', ''False''), ');
INSERT INTO `configuration` VALUES (140, 'Check User Agent', 'SESSION_CHECK_USER_AGENT', 'False', 'Validate the clients browser user agent on every page request.', 15, 4, NULL, '2010-04-26 09:31:37', NULL, 'tep_cfg_select_option(array(''True'', ''False''), ');
INSERT INTO `configuration` VALUES (141, 'Check IP Address', 'SESSION_CHECK_IP_ADDRESS', 'False', 'Validate the clients IP address on every page request.', 15, 5, NULL, '2010-04-26 09:31:37', NULL, 'tep_cfg_select_option(array(''True'', ''False''), ');
INSERT INTO `configuration` VALUES (142, 'Prevent Spider Sessions', 'SESSION_BLOCK_SPIDERS', 'True', 'Prevent known spiders from starting a session.', 15, 6, NULL, '2010-04-26 09:31:37', NULL, 'tep_cfg_select_option(array(''True'', ''False''), ');
INSERT INTO `configuration` VALUES (143, 'Recreate Session', 'SESSION_RECREATE', 'False', 'Recreate the session to generate a new session ID when the customer logs on or creates an account (PHP >=4.1 needed).', 15, 7, NULL, '2010-04-26 09:31:37', NULL, 'tep_cfg_select_option(array(''True'', ''False''), ');
INSERT INTO `configuration` VALUES (144, 'Enable WorldPay Select Junior', 'MODULE_PAYMENT_WORLDPAY_JUNIOR_STATUS', 'True', 'Do you want to accept WorldPay Select Junior payments?', 6, 0, NULL, '2010-04-26 09:43:50', NULL, 'tep_cfg_select_option(array(''True'', ''False''), ');
INSERT INTO `configuration` VALUES (145, 'Installation ID', 'MODULE_PAYMENT_WORLDPAY_JUNIOR_INSTALLATION_ID', '249711', 'Your WorldPay Installation ID', 6, 0, NULL, '2010-04-26 09:43:50', NULL, NULL);
INSERT INTO `configuration` VALUES (146, 'Callback Password', 'MODULE_PAYMENT_WORLDPAY_JUNIOR_CALLBACK_PASSWORD', 'john77', 'A password that is sent back in the callback response (specified in the WorldPay Customer Management System)', 6, 0, NULL, '2010-04-26 09:43:50', NULL, NULL);
INSERT INTO `configuration` VALUES (147, 'MD5 Password', 'MODULE_PAYMENT_WORLDPAY_JUNIOR_MD5_PASSWORD', '', 'The MD5 secret encryption password used to validate transaction responses with (specified in the WorldPay Customer Management System)', 6, 0, NULL, '2010-04-26 09:43:50', NULL, NULL);
INSERT INTO `configuration` VALUES (148, 'Transaction Method', 'MODULE_PAYMENT_WORLDPAY_JUNIOR_TRANSACTION_METHOD', 'Capture', 'The processing method to use for each transaction', 6, 0, NULL, '2010-04-26 09:43:50', NULL, 'tep_cfg_select_option(array(''Pre-Authorization'', ''Capture''), ');
INSERT INTO `configuration` VALUES (149, 'Test Mode', 'MODULE_PAYMENT_WORLDPAY_JUNIOR_TESTMODE', 'False', 'Process transactions in test mode?', 6, 0, NULL, '2010-04-26 09:43:50', NULL, 'tep_cfg_select_option(array(''True'', ''False''), ');
INSERT INTO `configuration` VALUES (150, 'Sort order of display.', 'MODULE_PAYMENT_WORLDPAY_JUNIOR_SORT_ORDER', '10', 'Sort order of display. Lowest is displayed first.', 6, 0, NULL, '2010-04-26 09:43:50', NULL, NULL);
INSERT INTO `configuration` VALUES (151, 'Payment Zone', 'MODULE_PAYMENT_WORLDPAY_JUNIOR_ZONE', '0', 'If a zone is selected, only enable this payment method for that zone.', 6, 2, NULL, '2010-04-26 09:43:50', 'tep_get_zone_class_title', 'tep_cfg_pull_down_zone_classes(');
INSERT INTO `configuration` VALUES (152, 'Set Preparing Order Status', 'MODULE_PAYMENT_WORLDPAY_JUNIOR_PREPARE_ORDER_STATUS_ID', '4', 'Set the status of prepared orders made with this payment module to this value', 6, 0, NULL, '2010-04-26 09:43:50', 'tep_get_order_status_name', 'tep_cfg_pull_down_order_statuses(');
INSERT INTO `configuration` VALUES (153, 'Set Order Status', 'MODULE_PAYMENT_WORLDPAY_JUNIOR_ORDER_STATUS_ID', '0', 'Set the status of orders made with this payment module to this value', 6, 0, NULL, '2010-04-26 09:43:50', 'tep_get_order_status_name', 'tep_cfg_pull_down_order_statuses(');
INSERT INTO `configuration` VALUES (154, 'Enable Table Method', 'MODULE_SHIPPING_TABLE_STATUS', 'True', 'Do you want to offer table rate shipping?', 6, 0, NULL, '2010-04-28 17:06:29', NULL, 'tep_cfg_select_option(array(''True'', ''False''), ');
INSERT INTO `configuration` VALUES (155, 'Shipping Table', 'MODULE_SHIPPING_TABLE_COST', '50:2.95,99.99:5.95,100:0.00', 'The shipping cost is based on the total cost or weight of items. Example: 25:8.50,50:5.50,etc.. Up to 25 charge 8.50, from there to 50 charge 5.50, etc', 6, 0, NULL, '2010-04-28 17:06:29', NULL, NULL);
INSERT INTO `configuration` VALUES (156, 'Table Method', 'MODULE_SHIPPING_TABLE_MODE', 'price', 'The shipping cost is based on the order total or the total weight of the items ordered.', 6, 0, NULL, '2010-04-28 17:06:29', NULL, 'tep_cfg_select_option(array(''weight'', ''price''), ');
INSERT INTO `configuration` VALUES (157, 'Handling Fee', 'MODULE_SHIPPING_TABLE_HANDLING', '0', 'Handling fee for this shipping method.', 6, 0, NULL, '2010-04-28 17:06:29', NULL, NULL);
INSERT INTO `configuration` VALUES (158, 'Tax Class', 'MODULE_SHIPPING_TABLE_TAX_CLASS', '0', 'Use the following tax class on the shipping fee.', 6, 0, NULL, '2010-04-28 17:06:29', 'tep_get_tax_class_title', 'tep_cfg_pull_down_tax_classes(');
INSERT INTO `configuration` VALUES (159, 'Shipping Zone', 'MODULE_SHIPPING_TABLE_ZONE', '0', 'If a zone is selected, only enable this shipping method for that zone.', 6, 0, NULL, '2010-04-28 17:06:29', 'tep_get_zone_class_title', 'tep_cfg_pull_down_zone_classes(');
INSERT INTO `configuration` VALUES (160, 'Sort Order', 'MODULE_SHIPPING_TABLE_SORT_ORDER', '0', 'Sort order of display.', 6, 0, NULL, '2010-04-28 17:06:29', NULL, NULL);
INSERT INTO `configuration` VALUES (161, 'Display Product Options', 'PRODUCT_LIST_OPTIONS', '0', 'Do you want to display product options within the product listing', 8, 0, NULL, '2010-05-25 21:25:36', '', '');
INSERT INTO `configuration` VALUES (162, 'Product Listing Style', 'PRODUCT_THUMBNAIL_VIEW', 'thumbnails', 'Product Listing As Thumbnails, Product List or Manufacturer List. Straight or block list.', 8, 15, NULL, '2010-05-25 21:25:36', NULL, 'tep_cfg_select_option(array(''list'', ''list in blocks'', ''thumbnails'', ''thumbnails in grid'', ''manufacturer'', ''manufacturer in blocks''),');
INSERT INTO `configuration` VALUES (163, 'Product Listing Short Description', 'PRODUCT_SHORT_DESC', 'false', 'Display Product Short Description In Listing', 8, 16, NULL, '2010-05-25 21:25:36', NULL, 'tep_cfg_select_option(array(''true'', ''false''),');
INSERT INTO `configuration` VALUES (164, 'Product Listing Buy Now / Details Button', 'LISTING_BUTTON', 'buy now', 'Display a &lsquo;Buy Now&rsquo;, &lsquo;Details&rsquo; Button or Both', 8, 22, NULL, '2010-05-25 21:25:36', NULL, 'tep_cfg_select_option(array(''none'', ''buy now'', ''small buy now'', ''details'', ''buy now & details''),');
INSERT INTO `configuration` VALUES (165, 'Product Listing Manufacturers Description', 'MANU_DESCRIPTION', 'false', 'Display Manufacturers Description In Listing', 8, 16, NULL, '2010-05-25 21:25:36', NULL, 'tep_cfg_select_option(array(''true'', ''false''),');
INSERT INTO `configuration` VALUES (166, 'Product Listing Headings', 'LISTING_HEADINGS', 'true', 'Show Listing Column Headings (false prevents user sorting listing).', 8, 23, NULL, '2010-05-25 21:25:36', NULL, 'tep_cfg_select_option(array(''true'', ''false''),');
INSERT INTO `configuration` VALUES (167, 'Display Product Options', 'PRODUCT_LIST_OPTIONS', 'false', 'Do you want to display product options within the product listing.\r\nDisplay will be adjacent to \r\nbuy now button.', 8, 9, NULL, '2010-05-25 21:25:36', NULL, 'tep_cfg_select_option(array(''true'', ''false''),');
INSERT INTO `configuration` VALUES (168, 'Product Listing Image Height.', 'PRODUCT_IMAGE_HEIGHT', '', 'It is recommended this is left empty so images aren''t distorted.', 8, 17, NULL, '2010-05-25 21:25:36', '', '');
INSERT INTO `configuration` VALUES (169, 'Product Listing Image Width', 'PRODUCT_IMAGE_WIDTH', '140', 'Product Listing Image Width.', 8, 17, NULL, '2010-05-25 21:25:36', '', '');
INSERT INTO `configuration` VALUES (170, 'Product Listing Box Width', 'PRODUCT_LIST_WIDTH', '150', 'Individual Product Listing Box Width.', 8, 18, NULL, '2010-05-25 21:25:36', '', '');
INSERT INTO `configuration` VALUES (171, 'Product Listing Box Height', 'PRODUCT_LIST_HEIGHT', '240', 'Individual Product Listing Box Height.', 8, 19, NULL, '2010-05-25 21:25:36', '', '');
INSERT INTO `configuration` VALUES (172, 'Product Listing Per Row', 'PRODUCTS_PER_ROW', '4', 'Number Of Products To List Per Row.', 8, 21, NULL, '2010-05-25 21:25:36', '', '');
INSERT INTO `configuration` VALUES (173, 'Product Listing Image Vertical Space', 'PRODUCT_IMAGE_VSPACE', '100', 'Image Vertical Space, set to height of largest image in thumbnail.', 8, 20, NULL, '2010-05-25 21:25:36', '', '');
INSERT INTO `configuration` VALUES (174, 'Product Listing Name Vertical Space', 'PRODUCT_NAME_VSPACE', '25', 'Name Vertical Space, sets vertical space for name + description in thumbnail.', 8, 20, NULL, '2010-05-25 21:25:36', '', '');
INSERT INTO `configuration` VALUES (175, 'Display Product Truncated Description', 'PRODUCT_LIST_DESCRIPTION', '1', 'Include truncated product description in the product listing. The product \r\ndescription will be included under the product name, so, that must be included in the product listing too.', 8, 5, NULL, '2010-05-25 21:25:36', '', '');
INSERT INTO `configuration` VALUES (176, 'Product Truncated Description Length', 'PRODUCT_LIST_DESCRIPTION_MAX_LENGTH', '120', 'Maximum number of characters for the product truncated description in \r\nthe product listing.', 8, 5, NULL, '2010-05-25 21:25:36', '', '');
INSERT INTO `configuration` VALUES (177, 'Display Product Name/Price above all other fields', 'PRODUCT_LIST_HEAD_TITLE', 'true', 'Display product name & price (if set) as a title on its own line above \r\nall other fields.', 8, 4, NULL, '2010-05-25 21:25:36', '', 'tep_cfg_select_option(array(''true'', ''false''),');
INSERT INTO `configuration` VALUES (178, 'Enable Multi Add to Cart', 'PRODUCT_LIST_MULTI_BUY', 'false', 'Enable adding mutiple items to the cart at once, and set position of Add to Cart Button on the \r\nlisting display. See docs for all requirements for proper operation.', 8, 8, NULL, '2010-05-25 21:25:36', '', 'tep_cfg_select_option(array(''top'', ''bottom'',''both'',''false''),');
INSERT INTO `configuration` VALUES (179, 'Display a Quantity Input Box / Drop Down', 'PRODUCT_LIST_QUANTITY_BOX', 'true', 'Display a quantity input box above the buy now button as a input box with \r\nincremental buttons or as a drop down.', 8, 9, NULL, '2010-05-25 21:25:36', '', 'tep_cfg_select_option(array(''false'', ''true'', ''drop down''),');
INSERT INTO `configuration` VALUES (180, 'Display Products Extra Fields', 'LISTING_EXTRA_FIELDS', 'false', 'Set to true if you have products extra fields installed & you want to display the fields in \r\nthe listing', 8, 9, NULL, '2010-05-25 21:25:36', '', 'tep_cfg_select_option(array(''true'', ''false''),');
INSERT INTO `configuration` VALUES (181, 'Product Listing Style Last Column Size', 'BLOCK_LAST_SIZE', '1', 'Set the size of the last column in block mode so the last x fields will appear there.', 8, 15, NULL, '2010-05-25 21:25:36', '', 'tep_cfg_select_option(array(''1'', ''2'', ''3'', ''4'', ''5'',''6''),');
INSERT INTO `configuration` VALUES (182, 'Product Listing Style Switch', 'LISTING_SWITCH', 'bottom', 'Provide the user the option to switch listing style.', 8, 24, NULL, '2010-05-25 21:25:36', '', 'tep_cfg_select_option(array(''top'', ''bottom'',''both'',''false''),');
INSERT INTO `configuration` VALUES (183, 'Product Listing Image zoom on hover', 'IMAGE_TTIP', 'false', 'Display tool tip image zoom on hover over product image', 8, 30, '2010-08-31 22:25:57', '2010-05-25 21:25:36', '', 'tep_cfg_select_option(array(''true'', ''false''),');
INSERT INTO `configuration` VALUES (184, 'Product Listing Image hover zoom width', 'IMAGE_TTIP_WIDTH', '200', 'Width of tooltip image on hover in pixels', 8, 31, NULL, '2010-05-25 21:25:36', '', '');
INSERT INTO `configuration` VALUES (185, 'Installed Modules', '', '', 'This is automatically updated. No need to edit.', 6, 0, NULL, '2010-06-24 23:45:34', NULL, NULL);
INSERT INTO `configuration` VALUES (186, 'Enable FWR Security Pro?', 'FWR_SECURITY_PRO_ON', 'true', 'Enable FWR Security Pro and beat the querystring hackers.', 16, 1, '2010-11-02 21:23:36', '2010-11-02 21:06:19', NULL, 'tep_cfg_select_option(array(''true'', ''false''), ');
INSERT INTO `configuration` VALUES (187, 'File Exclusion ON', 'FWR_SECURITY_PRO_FILE_EXCLUSIONS_ON', 'false', 'Files are only excluded from cleansing if this function is enabled.', 16, 2, '2010-11-02 21:06:19', '2010-11-02 21:06:19', NULL, 'tep_cfg_select_option(array(''true'', ''false''),');
INSERT INTO `configuration` VALUES (188, 'File Exclusions', 'FWR_SECURITY_PRO_FILE_EXCLUSIONS', '', 'List of safe files to exclude from cleansing. Seperated by , (comma)<br />e.g. protx_process.php,my_processor.php<br />', 16, 3, '2010-11-02 21:06:19', '2010-11-02 21:06:19', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `configuration_group`
--

CREATE TABLE `configuration_group` (
  `configuration_group_id` int(11) NOT NULL auto_increment,
  `configuration_group_title` varchar(64) NOT NULL,
  `configuration_group_description` varchar(255) NOT NULL,
  `sort_order` int(5) default NULL,
  `visible` int(1) default '1',
  PRIMARY KEY  (`configuration_group_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=17 ;

--
-- Dumping data for table `configuration_group`
--

INSERT INTO `configuration_group` VALUES (1, 'My Store', 'General information about my store', 1, 1);
INSERT INTO `configuration_group` VALUES (2, 'Minimum Values', 'The minimum values for functions / data', 2, 1);
INSERT INTO `configuration_group` VALUES (3, 'Maximum Values', 'The maximum values for functions / data', 3, 1);
INSERT INTO `configuration_group` VALUES (4, 'Images', 'Image parameters', 4, 1);
INSERT INTO `configuration_group` VALUES (5, 'Customer Details', 'Customer account configuration', 5, 1);
INSERT INTO `configuration_group` VALUES (6, 'Module Options', 'Hidden from configuration', 6, 0);
INSERT INTO `configuration_group` VALUES (7, 'Shipping/Packaging', 'Shipping options available at my store', 7, 1);
INSERT INTO `configuration_group` VALUES (8, 'Product Listing', 'Product Listing    configuration options', 8, 1);
INSERT INTO `configuration_group` VALUES (9, 'Stock', 'Stock configuration options', 9, 1);
INSERT INTO `configuration_group` VALUES (10, 'Logging', 'Logging configuration options', 10, 1);
INSERT INTO `configuration_group` VALUES (11, 'Cache', 'Caching configuration options', 11, 1);
INSERT INTO `configuration_group` VALUES (12, 'E-Mail Options', 'General setting for E-Mail transport and HTML E-Mails', 12, 1);
INSERT INTO `configuration_group` VALUES (13, 'Download', 'Downloadable products options', 13, 1);
INSERT INTO `configuration_group` VALUES (14, 'GZip Compression', 'GZip compression options', 14, 1);
INSERT INTO `configuration_group` VALUES (15, 'Sessions', 'Session options', 15, 1);
INSERT INTO `configuration_group` VALUES (16, 'FWR Security Pro', 'Ultimate Querystring security by FWR Media', 16, 1);

-- --------------------------------------------------------

--
-- Table structure for table `counter`
--

CREATE TABLE `counter` (
  `startdate` char(8) default NULL,
  `counter` int(12) default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `counter`
--

INSERT INTO `counter` VALUES ('20100426', 39151);

-- --------------------------------------------------------

--
-- Table structure for table `counter_history`
--

CREATE TABLE `counter_history` (
  `month` char(8) default NULL,
  `counter` int(12) default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `counter_history`
--


-- --------------------------------------------------------

--
-- Table structure for table `countries`
--

CREATE TABLE `countries` (
  `countries_id` int(11) NOT NULL auto_increment,
  `countries_name` varchar(64) NOT NULL,
  `countries_iso_code_2` char(2) NOT NULL,
  `countries_iso_code_3` char(3) NOT NULL,
  `address_format_id` int(11) NOT NULL,
  PRIMARY KEY  (`countries_id`),
  KEY `IDX_COUNTRIES_NAME` (`countries_name`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=240 ;

--
-- Dumping data for table `countries`
--

INSERT INTO `countries` VALUES (1, 'Afghanistan', 'AF', 'AFG', 1);
INSERT INTO `countries` VALUES (2, 'Albania', 'AL', 'ALB', 1);
INSERT INTO `countries` VALUES (3, 'Algeria', 'DZ', 'DZA', 1);
INSERT INTO `countries` VALUES (4, 'American Samoa', 'AS', 'ASM', 1);
INSERT INTO `countries` VALUES (5, 'Andorra', 'AD', 'AND', 1);
INSERT INTO `countries` VALUES (6, 'Angola', 'AO', 'AGO', 1);
INSERT INTO `countries` VALUES (7, 'Anguilla', 'AI', 'AIA', 1);
INSERT INTO `countries` VALUES (8, 'Antarctica', 'AQ', 'ATA', 1);
INSERT INTO `countries` VALUES (9, 'Antigua and Barbuda', 'AG', 'ATG', 1);
INSERT INTO `countries` VALUES (10, 'Argentina', 'AR', 'ARG', 1);
INSERT INTO `countries` VALUES (11, 'Armenia', 'AM', 'ARM', 1);
INSERT INTO `countries` VALUES (12, 'Aruba', 'AW', 'ABW', 1);
INSERT INTO `countries` VALUES (13, 'Australia', 'AU', 'AUS', 1);
INSERT INTO `countries` VALUES (14, 'Austria', 'AT', 'AUT', 5);
INSERT INTO `countries` VALUES (15, 'Azerbaijan', 'AZ', 'AZE', 1);
INSERT INTO `countries` VALUES (16, 'Bahamas', 'BS', 'BHS', 1);
INSERT INTO `countries` VALUES (17, 'Bahrain', 'BH', 'BHR', 1);
INSERT INTO `countries` VALUES (18, 'Bangladesh', 'BD', 'BGD', 1);
INSERT INTO `countries` VALUES (19, 'Barbados', 'BB', 'BRB', 1);
INSERT INTO `countries` VALUES (20, 'Belarus', 'BY', 'BLR', 1);
INSERT INTO `countries` VALUES (21, 'Belgium', 'BE', 'BEL', 1);
INSERT INTO `countries` VALUES (22, 'Belize', 'BZ', 'BLZ', 1);
INSERT INTO `countries` VALUES (23, 'Benin', 'BJ', 'BEN', 1);
INSERT INTO `countries` VALUES (24, 'Bermuda', 'BM', 'BMU', 1);
INSERT INTO `countries` VALUES (25, 'Bhutan', 'BT', 'BTN', 1);
INSERT INTO `countries` VALUES (26, 'Bolivia', 'BO', 'BOL', 1);
INSERT INTO `countries` VALUES (27, 'Bosnia and Herzegowina', 'BA', 'BIH', 1);
INSERT INTO `countries` VALUES (28, 'Botswana', 'BW', 'BWA', 1);
INSERT INTO `countries` VALUES (29, 'Bouvet Island', 'BV', 'BVT', 1);
INSERT INTO `countries` VALUES (30, 'Brazil', 'BR', 'BRA', 1);
INSERT INTO `countries` VALUES (31, 'British Indian Ocean Territory', 'IO', 'IOT', 1);
INSERT INTO `countries` VALUES (32, 'Brunei Darussalam', 'BN', 'BRN', 1);
INSERT INTO `countries` VALUES (33, 'Bulgaria', 'BG', 'BGR', 1);
INSERT INTO `countries` VALUES (34, 'Burkina Faso', 'BF', 'BFA', 1);
INSERT INTO `countries` VALUES (35, 'Burundi', 'BI', 'BDI', 1);
INSERT INTO `countries` VALUES (36, 'Cambodia', 'KH', 'KHM', 1);
INSERT INTO `countries` VALUES (37, 'Cameroon', 'CM', 'CMR', 1);
INSERT INTO `countries` VALUES (38, 'Canada', 'CA', 'CAN', 1);
INSERT INTO `countries` VALUES (39, 'Cape Verde', 'CV', 'CPV', 1);
INSERT INTO `countries` VALUES (40, 'Cayman Islands', 'KY', 'CYM', 1);
INSERT INTO `countries` VALUES (41, 'Central African Republic', 'CF', 'CAF', 1);
INSERT INTO `countries` VALUES (42, 'Chad', 'TD', 'TCD', 1);
INSERT INTO `countries` VALUES (43, 'Chile', 'CL', 'CHL', 1);
INSERT INTO `countries` VALUES (44, 'China', 'CN', 'CHN', 1);
INSERT INTO `countries` VALUES (45, 'Christmas Island', 'CX', 'CXR', 1);
INSERT INTO `countries` VALUES (46, 'Cocos (Keeling) Islands', 'CC', 'CCK', 1);
INSERT INTO `countries` VALUES (47, 'Colombia', 'CO', 'COL', 1);
INSERT INTO `countries` VALUES (48, 'Comoros', 'KM', 'COM', 1);
INSERT INTO `countries` VALUES (49, 'Congo', 'CG', 'COG', 1);
INSERT INTO `countries` VALUES (50, 'Cook Islands', 'CK', 'COK', 1);
INSERT INTO `countries` VALUES (51, 'Costa Rica', 'CR', 'CRI', 1);
INSERT INTO `countries` VALUES (52, 'Cote D''Ivoire', 'CI', 'CIV', 1);
INSERT INTO `countries` VALUES (53, 'Croatia', 'HR', 'HRV', 1);
INSERT INTO `countries` VALUES (54, 'Cuba', 'CU', 'CUB', 1);
INSERT INTO `countries` VALUES (55, 'Cyprus', 'CY', 'CYP', 1);
INSERT INTO `countries` VALUES (56, 'Czech Republic', 'CZ', 'CZE', 1);
INSERT INTO `countries` VALUES (57, 'Denmark', 'DK', 'DNK', 1);
INSERT INTO `countries` VALUES (58, 'Djibouti', 'DJ', 'DJI', 1);
INSERT INTO `countries` VALUES (59, 'Dominica', 'DM', 'DMA', 1);
INSERT INTO `countries` VALUES (60, 'Dominican Republic', 'DO', 'DOM', 1);
INSERT INTO `countries` VALUES (61, 'East Timor', 'TP', 'TMP', 1);
INSERT INTO `countries` VALUES (62, 'Ecuador', 'EC', 'ECU', 1);
INSERT INTO `countries` VALUES (63, 'Egypt', 'EG', 'EGY', 1);
INSERT INTO `countries` VALUES (64, 'El Salvador', 'SV', 'SLV', 1);
INSERT INTO `countries` VALUES (65, 'Equatorial Guinea', 'GQ', 'GNQ', 1);
INSERT INTO `countries` VALUES (66, 'Eritrea', 'ER', 'ERI', 1);
INSERT INTO `countries` VALUES (67, 'Estonia', 'EE', 'EST', 1);
INSERT INTO `countries` VALUES (68, 'Ethiopia', 'ET', 'ETH', 1);
INSERT INTO `countries` VALUES (69, 'Falkland Islands (Malvinas)', 'FK', 'FLK', 1);
INSERT INTO `countries` VALUES (70, 'Faroe Islands', 'FO', 'FRO', 1);
INSERT INTO `countries` VALUES (71, 'Fiji', 'FJ', 'FJI', 1);
INSERT INTO `countries` VALUES (72, 'Finland', 'FI', 'FIN', 1);
INSERT INTO `countries` VALUES (73, 'France', 'FR', 'FRA', 1);
INSERT INTO `countries` VALUES (74, 'France, Metropolitan', 'FX', 'FXX', 1);
INSERT INTO `countries` VALUES (75, 'French Guiana', 'GF', 'GUF', 1);
INSERT INTO `countries` VALUES (76, 'French Polynesia', 'PF', 'PYF', 1);
INSERT INTO `countries` VALUES (77, 'French Southern Territories', 'TF', 'ATF', 1);
INSERT INTO `countries` VALUES (78, 'Gabon', 'GA', 'GAB', 1);
INSERT INTO `countries` VALUES (79, 'Gambia', 'GM', 'GMB', 1);
INSERT INTO `countries` VALUES (80, 'Georgia', 'GE', 'GEO', 1);
INSERT INTO `countries` VALUES (81, 'Germany', 'DE', 'DEU', 5);
INSERT INTO `countries` VALUES (82, 'Ghana', 'GH', 'GHA', 1);
INSERT INTO `countries` VALUES (83, 'Gibraltar', 'GI', 'GIB', 1);
INSERT INTO `countries` VALUES (84, 'Greece', 'GR', 'GRC', 1);
INSERT INTO `countries` VALUES (85, 'Greenland', 'GL', 'GRL', 1);
INSERT INTO `countries` VALUES (86, 'Grenada', 'GD', 'GRD', 1);
INSERT INTO `countries` VALUES (87, 'Guadeloupe', 'GP', 'GLP', 1);
INSERT INTO `countries` VALUES (88, 'Guam', 'GU', 'GUM', 1);
INSERT INTO `countries` VALUES (89, 'Guatemala', 'GT', 'GTM', 1);
INSERT INTO `countries` VALUES (90, 'Guinea', 'GN', 'GIN', 1);
INSERT INTO `countries` VALUES (91, 'Guinea-bissau', 'GW', 'GNB', 1);
INSERT INTO `countries` VALUES (92, 'Guyana', 'GY', 'GUY', 1);
INSERT INTO `countries` VALUES (93, 'Haiti', 'HT', 'HTI', 1);
INSERT INTO `countries` VALUES (94, 'Heard and Mc Donald Islands', 'HM', 'HMD', 1);
INSERT INTO `countries` VALUES (95, 'Honduras', 'HN', 'HND', 1);
INSERT INTO `countries` VALUES (96, 'Hong Kong', 'HK', 'HKG', 1);
INSERT INTO `countries` VALUES (97, 'Hungary', 'HU', 'HUN', 1);
INSERT INTO `countries` VALUES (98, 'Iceland', 'IS', 'ISL', 1);
INSERT INTO `countries` VALUES (99, 'India', 'IN', 'IND', 1);
INSERT INTO `countries` VALUES (100, 'Indonesia', 'ID', 'IDN', 1);
INSERT INTO `countries` VALUES (101, 'Iran (Islamic Republic of)', 'IR', 'IRN', 1);
INSERT INTO `countries` VALUES (102, 'Iraq', 'IQ', 'IRQ', 1);
INSERT INTO `countries` VALUES (103, 'Ireland', 'IE', 'IRL', 1);
INSERT INTO `countries` VALUES (104, 'Israel', 'IL', 'ISR', 1);
INSERT INTO `countries` VALUES (105, 'Italy', 'IT', 'ITA', 1);
INSERT INTO `countries` VALUES (106, 'Jamaica', 'JM', 'JAM', 1);
INSERT INTO `countries` VALUES (107, 'Japan', 'JP', 'JPN', 1);
INSERT INTO `countries` VALUES (108, 'Jordan', 'JO', 'JOR', 1);
INSERT INTO `countries` VALUES (109, 'Kazakhstan', 'KZ', 'KAZ', 1);
INSERT INTO `countries` VALUES (110, 'Kenya', 'KE', 'KEN', 1);
INSERT INTO `countries` VALUES (111, 'Kiribati', 'KI', 'KIR', 1);
INSERT INTO `countries` VALUES (112, 'Korea, Democratic People''s Republic of', 'KP', 'PRK', 1);
INSERT INTO `countries` VALUES (113, 'Korea, Republic of', 'KR', 'KOR', 1);
INSERT INTO `countries` VALUES (114, 'Kuwait', 'KW', 'KWT', 1);
INSERT INTO `countries` VALUES (115, 'Kyrgyzstan', 'KG', 'KGZ', 1);
INSERT INTO `countries` VALUES (116, 'Lao People''s Democratic Republic', 'LA', 'LAO', 1);
INSERT INTO `countries` VALUES (117, 'Latvia', 'LV', 'LVA', 1);
INSERT INTO `countries` VALUES (118, 'Lebanon', 'LB', 'LBN', 1);
INSERT INTO `countries` VALUES (119, 'Lesotho', 'LS', 'LSO', 1);
INSERT INTO `countries` VALUES (120, 'Liberia', 'LR', 'LBR', 1);
INSERT INTO `countries` VALUES (121, 'Libyan Arab Jamahiriya', 'LY', 'LBY', 1);
INSERT INTO `countries` VALUES (122, 'Liechtenstein', 'LI', 'LIE', 1);
INSERT INTO `countries` VALUES (123, 'Lithuania', 'LT', 'LTU', 1);
INSERT INTO `countries` VALUES (124, 'Luxembourg', 'LU', 'LUX', 1);
INSERT INTO `countries` VALUES (125, 'Macau', 'MO', 'MAC', 1);
INSERT INTO `countries` VALUES (126, 'Macedonia, The Former Yugoslav Republic of', 'MK', 'MKD', 1);
INSERT INTO `countries` VALUES (127, 'Madagascar', 'MG', 'MDG', 1);
INSERT INTO `countries` VALUES (128, 'Malawi', 'MW', 'MWI', 1);
INSERT INTO `countries` VALUES (129, 'Malaysia', 'MY', 'MYS', 1);
INSERT INTO `countries` VALUES (130, 'Maldives', 'MV', 'MDV', 1);
INSERT INTO `countries` VALUES (131, 'Mali', 'ML', 'MLI', 1);
INSERT INTO `countries` VALUES (132, 'Malta', 'MT', 'MLT', 1);
INSERT INTO `countries` VALUES (133, 'Marshall Islands', 'MH', 'MHL', 1);
INSERT INTO `countries` VALUES (134, 'Martinique', 'MQ', 'MTQ', 1);
INSERT INTO `countries` VALUES (135, 'Mauritania', 'MR', 'MRT', 1);
INSERT INTO `countries` VALUES (136, 'Mauritius', 'MU', 'MUS', 1);
INSERT INTO `countries` VALUES (137, 'Mayotte', 'YT', 'MYT', 1);
INSERT INTO `countries` VALUES (138, 'Mexico', 'MX', 'MEX', 1);
INSERT INTO `countries` VALUES (139, 'Micronesia, Federated States of', 'FM', 'FSM', 1);
INSERT INTO `countries` VALUES (140, 'Moldova, Republic of', 'MD', 'MDA', 1);
INSERT INTO `countries` VALUES (141, 'Monaco', 'MC', 'MCO', 1);
INSERT INTO `countries` VALUES (142, 'Mongolia', 'MN', 'MNG', 1);
INSERT INTO `countries` VALUES (143, 'Montserrat', 'MS', 'MSR', 1);
INSERT INTO `countries` VALUES (144, 'Morocco', 'MA', 'MAR', 1);
INSERT INTO `countries` VALUES (145, 'Mozambique', 'MZ', 'MOZ', 1);
INSERT INTO `countries` VALUES (146, 'Myanmar', 'MM', 'MMR', 1);
INSERT INTO `countries` VALUES (147, 'Namibia', 'NA', 'NAM', 1);
INSERT INTO `countries` VALUES (148, 'Nauru', 'NR', 'NRU', 1);
INSERT INTO `countries` VALUES (149, 'Nepal', 'NP', 'NPL', 1);
INSERT INTO `countries` VALUES (150, 'Netherlands', 'NL', 'NLD', 1);
INSERT INTO `countries` VALUES (151, 'Netherlands Antilles', 'AN', 'ANT', 1);
INSERT INTO `countries` VALUES (152, 'New Caledonia', 'NC', 'NCL', 1);
INSERT INTO `countries` VALUES (153, 'New Zealand', 'NZ', 'NZL', 1);
INSERT INTO `countries` VALUES (154, 'Nicaragua', 'NI', 'NIC', 1);
INSERT INTO `countries` VALUES (155, 'Niger', 'NE', 'NER', 1);
INSERT INTO `countries` VALUES (156, 'Nigeria', 'NG', 'NGA', 1);
INSERT INTO `countries` VALUES (157, 'Niue', 'NU', 'NIU', 1);
INSERT INTO `countries` VALUES (158, 'Norfolk Island', 'NF', 'NFK', 1);
INSERT INTO `countries` VALUES (159, 'Northern Mariana Islands', 'MP', 'MNP', 1);
INSERT INTO `countries` VALUES (160, 'Norway', 'NO', 'NOR', 1);
INSERT INTO `countries` VALUES (161, 'Oman', 'OM', 'OMN', 1);
INSERT INTO `countries` VALUES (162, 'Pakistan', 'PK', 'PAK', 1);
INSERT INTO `countries` VALUES (163, 'Palau', 'PW', 'PLW', 1);
INSERT INTO `countries` VALUES (164, 'Panama', 'PA', 'PAN', 1);
INSERT INTO `countries` VALUES (165, 'Papua New Guinea', 'PG', 'PNG', 1);
INSERT INTO `countries` VALUES (166, 'Paraguay', 'PY', 'PRY', 1);
INSERT INTO `countries` VALUES (167, 'Peru', 'PE', 'PER', 1);
INSERT INTO `countries` VALUES (168, 'Philippines', 'PH', 'PHL', 1);
INSERT INTO `countries` VALUES (169, 'Pitcairn', 'PN', 'PCN', 1);
INSERT INTO `countries` VALUES (170, 'Poland', 'PL', 'POL', 1);
INSERT INTO `countries` VALUES (171, 'Portugal', 'PT', 'PRT', 1);
INSERT INTO `countries` VALUES (172, 'Puerto Rico', 'PR', 'PRI', 1);
INSERT INTO `countries` VALUES (173, 'Qatar', 'QA', 'QAT', 1);
INSERT INTO `countries` VALUES (174, 'Reunion', 'RE', 'REU', 1);
INSERT INTO `countries` VALUES (175, 'Romania', 'RO', 'ROM', 1);
INSERT INTO `countries` VALUES (176, 'Russian Federation', 'RU', 'RUS', 1);
INSERT INTO `countries` VALUES (177, 'Rwanda', 'RW', 'RWA', 1);
INSERT INTO `countries` VALUES (178, 'Saint Kitts and Nevis', 'KN', 'KNA', 1);
INSERT INTO `countries` VALUES (179, 'Saint Lucia', 'LC', 'LCA', 1);
INSERT INTO `countries` VALUES (180, 'Saint Vincent and the Grenadines', 'VC', 'VCT', 1);
INSERT INTO `countries` VALUES (181, 'Samoa', 'WS', 'WSM', 1);
INSERT INTO `countries` VALUES (182, 'San Marino', 'SM', 'SMR', 1);
INSERT INTO `countries` VALUES (183, 'Sao Tome and Principe', 'ST', 'STP', 1);
INSERT INTO `countries` VALUES (184, 'Saudi Arabia', 'SA', 'SAU', 1);
INSERT INTO `countries` VALUES (185, 'Senegal', 'SN', 'SEN', 1);
INSERT INTO `countries` VALUES (186, 'Seychelles', 'SC', 'SYC', 1);
INSERT INTO `countries` VALUES (187, 'Sierra Leone', 'SL', 'SLE', 1);
INSERT INTO `countries` VALUES (188, 'Singapore', 'SG', 'SGP', 4);
INSERT INTO `countries` VALUES (189, 'Slovakia (Slovak Republic)', 'SK', 'SVK', 1);
INSERT INTO `countries` VALUES (190, 'Slovenia', 'SI', 'SVN', 1);
INSERT INTO `countries` VALUES (191, 'Solomon Islands', 'SB', 'SLB', 1);
INSERT INTO `countries` VALUES (192, 'Somalia', 'SO', 'SOM', 1);
INSERT INTO `countries` VALUES (193, 'South Africa', 'ZA', 'ZAF', 1);
INSERT INTO `countries` VALUES (194, 'South Georgia and the South Sandwich Islands', 'GS', 'SGS', 1);
INSERT INTO `countries` VALUES (195, 'Spain', 'ES', 'ESP', 3);
INSERT INTO `countries` VALUES (196, 'Sri Lanka', 'LK', 'LKA', 1);
INSERT INTO `countries` VALUES (197, 'St. Helena', 'SH', 'SHN', 1);
INSERT INTO `countries` VALUES (198, 'St. Pierre and Miquelon', 'PM', 'SPM', 1);
INSERT INTO `countries` VALUES (199, 'Sudan', 'SD', 'SDN', 1);
INSERT INTO `countries` VALUES (200, 'Suriname', 'SR', 'SUR', 1);
INSERT INTO `countries` VALUES (201, 'Svalbard and Jan Mayen Islands', 'SJ', 'SJM', 1);
INSERT INTO `countries` VALUES (202, 'Swaziland', 'SZ', 'SWZ', 1);
INSERT INTO `countries` VALUES (203, 'Sweden', 'SE', 'SWE', 1);
INSERT INTO `countries` VALUES (204, 'Switzerland', 'CH', 'CHE', 1);
INSERT INTO `countries` VALUES (205, 'Syrian Arab Republic', 'SY', 'SYR', 1);
INSERT INTO `countries` VALUES (206, 'Taiwan', 'TW', 'TWN', 1);
INSERT INTO `countries` VALUES (207, 'Tajikistan', 'TJ', 'TJK', 1);
INSERT INTO `countries` VALUES (208, 'Tanzania, United Republic of', 'TZ', 'TZA', 1);
INSERT INTO `countries` VALUES (209, 'Thailand', 'TH', 'THA', 1);
INSERT INTO `countries` VALUES (210, 'Togo', 'TG', 'TGO', 1);
INSERT INTO `countries` VALUES (211, 'Tokelau', 'TK', 'TKL', 1);
INSERT INTO `countries` VALUES (212, 'Tonga', 'TO', 'TON', 1);
INSERT INTO `countries` VALUES (213, 'Trinidad and Tobago', 'TT', 'TTO', 1);
INSERT INTO `countries` VALUES (214, 'Tunisia', 'TN', 'TUN', 1);
INSERT INTO `countries` VALUES (215, 'Turkey', 'TR', 'TUR', 1);
INSERT INTO `countries` VALUES (216, 'Turkmenistan', 'TM', 'TKM', 1);
INSERT INTO `countries` VALUES (217, 'Turks and Caicos Islands', 'TC', 'TCA', 1);
INSERT INTO `countries` VALUES (218, 'Tuvalu', 'TV', 'TUV', 1);
INSERT INTO `countries` VALUES (219, 'Uganda', 'UG', 'UGA', 1);
INSERT INTO `countries` VALUES (220, 'Ukraine', 'UA', 'UKR', 1);
INSERT INTO `countries` VALUES (221, 'United Arab Emirates', 'AE', 'ARE', 1);
INSERT INTO `countries` VALUES (222, 'United Kingdom', 'GB', 'GBR', 1);
INSERT INTO `countries` VALUES (223, 'United States', 'US', 'USA', 2);
INSERT INTO `countries` VALUES (224, 'United States Minor Outlying Islands', 'UM', 'UMI', 1);
INSERT INTO `countries` VALUES (225, 'Uruguay', 'UY', 'URY', 1);
INSERT INTO `countries` VALUES (226, 'Uzbekistan', 'UZ', 'UZB', 1);
INSERT INTO `countries` VALUES (227, 'Vanuatu', 'VU', 'VUT', 1);
INSERT INTO `countries` VALUES (228, 'Vatican City State (Holy See)', 'VA', 'VAT', 1);
INSERT INTO `countries` VALUES (229, 'Venezuela', 'VE', 'VEN', 1);
INSERT INTO `countries` VALUES (230, 'Viet Nam', 'VN', 'VNM', 1);
INSERT INTO `countries` VALUES (231, 'Virgin Islands (British)', 'VG', 'VGB', 1);
INSERT INTO `countries` VALUES (232, 'Virgin Islands (U.S.)', 'VI', 'VIR', 1);
INSERT INTO `countries` VALUES (233, 'Wallis and Futuna Islands', 'WF', 'WLF', 1);
INSERT INTO `countries` VALUES (234, 'Western Sahara', 'EH', 'ESH', 1);
INSERT INTO `countries` VALUES (235, 'Yemen', 'YE', 'YEM', 1);
INSERT INTO `countries` VALUES (236, 'Yugoslavia', 'YU', 'YUG', 1);
INSERT INTO `countries` VALUES (237, 'Zaire', 'ZR', 'ZAR', 1);
INSERT INTO `countries` VALUES (238, 'Zambia', 'ZM', 'ZMB', 1);
INSERT INTO `countries` VALUES (239, 'Zimbabwe', 'ZW', 'ZWE', 1);

-- --------------------------------------------------------

--
-- Table structure for table `currencies`
--

CREATE TABLE `currencies` (
  `currencies_id` int(11) NOT NULL auto_increment,
  `title` varchar(32) NOT NULL,
  `code` char(3) NOT NULL,
  `symbol_left` varchar(12) default NULL,
  `symbol_right` varchar(12) default NULL,
  `decimal_point` char(1) default NULL,
  `thousands_point` char(1) default NULL,
  `decimal_places` char(1) default NULL,
  `value` float(13,8) default NULL,
  `last_updated` datetime default NULL,
  PRIMARY KEY  (`currencies_id`),
  KEY `idx_currencies_code` (`code`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=4 ;

--
-- Dumping data for table `currencies`
--

INSERT INTO `currencies` VALUES (3, 'UK Pounds Sterling', 'GBP', '&pound;', '', '.', ',', '2', 1.00000000, '2010-04-26 09:31:37');

-- --------------------------------------------------------

--
-- Table structure for table `customers`
--

CREATE TABLE `customers` (
  `customers_id` int(11) NOT NULL auto_increment,
  `customers_gender` char(1) NOT NULL,
  `customers_firstname` varchar(32) NOT NULL,
  `customers_lastname` varchar(32) NOT NULL,
  `customers_dob` datetime NOT NULL default '0000-00-00 00:00:00',
  `customers_email_address` varchar(96) NOT NULL,
  `customers_default_address_id` int(11) default NULL,
  `customers_telephone` varchar(32) NOT NULL,
  `customers_fax` varchar(32) default NULL,
  `customers_password` varchar(40) NOT NULL,
  `customers_newsletter` char(1) default NULL,
  PRIMARY KEY  (`customers_id`),
  KEY `idx_customers_email_address` (`customers_email_address`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=20 ;

--
-- Dumping data for table `customers`
--

INSERT INTO `customers` VALUES (2, 'm', 'Craig', 'McKay', '1975-09-13 00:00:00', 'craig@southesk.com', 2, '01356 629481', '', '9795534d72ea0df56061a9387649f677:fc', '');
INSERT INTO `customers` VALUES (3, 'm', 'John', 'Laing', '1962-09-05 00:00:00', 'birdie2@tiscali.co.uk', 3, '01356624063', '', 'a66d69bf448614a87b66de8de6c56383:2b', '0');
INSERT INTO `customers` VALUES (6, 'm', 'neil', 'hutcheon', '1975-03-12 00:00:00', 'neilhutcheon@hotmail.co.uk', 6, '626612', '', '7b05fbf6c63814f49742227066ae88e1:63', '');
INSERT INTO `customers` VALUES (7, 'f', 'Linda', 'Flanigan', '1958-03-05 00:00:00', 'linda@flanigan01.wanadoo.co.uk', 7, '01993891979', '', 'c677ba329f86dcbea75c14829a81a629:e6', '');
INSERT INTO `customers` VALUES (8, 'f', 'Susan', 'Hermiston', '1965-01-13 00:00:00', 'susanhermiston-bowie@blueyonder.co.uk', 8, '07803136154', '', '90ee7a47931da7ca99a3c73ceda343e8:08', '1');
INSERT INTO `customers` VALUES (11, 'm', 'Craig', 'Singh', '1975-09-13 00:00:00', 'cmckay@southesk.com', 11, '+44 1307 818 774', '', 'cf48ad5dc7be82028876ca3dcc4e4155:74', '');
INSERT INTO `customers` VALUES (12, 'm', 'Simon', 'Henley-Castleden', '1969-10-05 00:00:00', 'thehenleycastledens@o2.co.uk', 12, '07845250008', '', '04c5c7fd59a3299d73c8e38c7f7f3f88:9c', '');
INSERT INTO `customers` VALUES (13, 'f', 'Shelagh', 'Borden', '1939-10-28 00:00:00', 'shelaghborden@btinternet.com', 13, '01865766291', '', 'ed028516dde283844f8f7d9d40c3400a:f3', '1');
INSERT INTO `customers` VALUES (14, 'm', 'Anthony', 'Horan', '1979-01-18 00:00:00', 'anthony_horan@hotmail.co.uk', 14, '07738008938', '', '87570cedab0f851db2784dbdaa335fbe:97', '');
INSERT INTO `customers` VALUES (15, 'm', 'Neil', 'Sutherland', '1979-09-02 00:00:00', 'neil-sutherland@hotmail.co.uk', 15, '07734405730', '', 'e5d9f7d64c1de787bfa90468f1bcf7f9:7d', '');
INSERT INTO `customers` VALUES (16, 'f', 'Kay', 'Robertson', '1989-07-17 00:00:00', 'kayzwayz35@hotmail.com', 16, '01356624814', '', '01a9e04b23cdefaa4c9df43f59cc567c:af', '');
INSERT INTO `customers` VALUES (19, 'f', 'Sharon', 'Emery', '1970-02-20 00:00:00', 'shazemery@aol.com', 19, '01782723087', '', 'ffa7d67d7da6722f85235f4be3ff9f4d:2f', '1');
INSERT INTO `customers` VALUES (18, 'm', 'david', 'law', '1970-10-24 00:00:00', 'davidlaw187@gmail.com', 18, '01706 507782', '', '89b3c78de542d52f19a64d7fae1055a3:0d', '');

-- --------------------------------------------------------

--
-- Table structure for table `customers_basket`
--

CREATE TABLE `customers_basket` (
  `customers_basket_id` int(11) NOT NULL auto_increment,
  `customers_id` int(11) NOT NULL,
  `products_id` tinytext NOT NULL,
  `customers_basket_quantity` int(2) NOT NULL,
  `final_price` decimal(15,4) default NULL,
  `customers_basket_date_added` char(8) default NULL,
  PRIMARY KEY  (`customers_basket_id`),
  KEY `idx_customers_basket_customers_id` (`customers_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=69 ;

--
-- Dumping data for table `customers_basket`
--

INSERT INTO `customers_basket` VALUES (44, 2, '155', 1, NULL, '20100720');
INSERT INTO `customers_basket` VALUES (58, 11, '694', 1, NULL, '20101121');
INSERT INTO `customers_basket` VALUES (47, 2, '387', 1, NULL, '20100729');
INSERT INTO `customers_basket` VALUES (63, 16, '261', 1, NULL, '20101213');
INSERT INTO `customers_basket` VALUES (65, 18, '30', 1, NULL, '20101217');
INSERT INTO `customers_basket` VALUES (66, 18, '659', 1, NULL, '20101217');
INSERT INTO `customers_basket` VALUES (67, 18, '621', 1, NULL, '20101217');

-- --------------------------------------------------------

--
-- Table structure for table `customers_basket_attributes`
--

CREATE TABLE `customers_basket_attributes` (
  `customers_basket_attributes_id` int(11) NOT NULL auto_increment,
  `customers_id` int(11) NOT NULL,
  `products_id` tinytext NOT NULL,
  `products_options_id` int(11) NOT NULL,
  `products_options_value_id` int(11) NOT NULL,
  PRIMARY KEY  (`customers_basket_attributes_id`),
  KEY `idx_customers_basket_att_customers_id` (`customers_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=9 ;

--
-- Dumping data for table `customers_basket_attributes`
--


-- --------------------------------------------------------

--
-- Table structure for table `customers_info`
--

CREATE TABLE `customers_info` (
  `customers_info_id` int(11) NOT NULL,
  `customers_info_date_of_last_logon` datetime default NULL,
  `customers_info_number_of_logons` int(5) default NULL,
  `customers_info_date_account_created` datetime default NULL,
  `customers_info_date_account_last_modified` datetime default NULL,
  `global_product_notifications` int(1) default '0',
  PRIMARY KEY  (`customers_info_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `customers_info`
--

INSERT INTO `customers_info` VALUES (2, '2010-07-29 21:38:18', 13, '2010-04-28 17:04:14', '2010-04-28 17:11:24', 0);
INSERT INTO `customers_info` VALUES (3, '2010-10-13 13:23:18', 68, '2010-06-25 08:27:34', '2010-07-17 08:22:59', 0);
INSERT INTO `customers_info` VALUES (6, NULL, 0, '2010-09-04 12:59:46', NULL, 0);
INSERT INTO `customers_info` VALUES (7, NULL, 0, '2010-10-02 14:30:42', NULL, 0);
INSERT INTO `customers_info` VALUES (8, NULL, 0, '2010-10-13 12:30:02', NULL, 0);
INSERT INTO `customers_info` VALUES (11, NULL, 0, '2010-11-21 21:44:00', NULL, 0);
INSERT INTO `customers_info` VALUES (12, '2010-12-01 17:40:20', 1, '2010-11-28 17:52:18', NULL, 0);
INSERT INTO `customers_info` VALUES (13, '2010-11-30 12:10:53', 1, '2010-11-30 11:43:11', NULL, 0);
INSERT INTO `customers_info` VALUES (14, NULL, 0, '2010-12-01 23:24:17', NULL, 0);
INSERT INTO `customers_info` VALUES (15, NULL, 0, '2010-12-12 17:25:26', NULL, 0);
INSERT INTO `customers_info` VALUES (16, NULL, 0, '2010-12-13 18:34:10', NULL, 0);
INSERT INTO `customers_info` VALUES (19, NULL, 0, '2010-12-27 09:31:17', NULL, 0);
INSERT INTO `customers_info` VALUES (18, NULL, 0, '2010-12-17 14:43:37', NULL, 0);

-- --------------------------------------------------------

--
-- Table structure for table `geo_zones`
--

CREATE TABLE `geo_zones` (
  `geo_zone_id` int(11) NOT NULL auto_increment,
  `geo_zone_name` varchar(32) NOT NULL,
  `geo_zone_description` varchar(255) NOT NULL,
  `last_modified` datetime default NULL,
  `date_added` datetime NOT NULL,
  PRIMARY KEY  (`geo_zone_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=2 ;

--
-- Dumping data for table `geo_zones`
--

INSERT INTO `geo_zones` VALUES (1, 'European Countries', 'EU VAT zone', '2010-04-26 09:31:37', '2010-04-26 09:31:37');

-- --------------------------------------------------------

--
-- Table structure for table `languages`
--

CREATE TABLE `languages` (
  `languages_id` int(11) NOT NULL auto_increment,
  `name` varchar(32) NOT NULL,
  `code` char(2) NOT NULL,
  `image` varchar(64) default NULL,
  `directory` varchar(32) default NULL,
  `sort_order` int(3) default NULL,
  PRIMARY KEY  (`languages_id`),
  KEY `IDX_LANGUAGES_NAME` (`name`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=4 ;

--
-- Dumping data for table `languages`
--

INSERT INTO `languages` VALUES (1, 'English', 'en', 'icon.gif', 'english', 1);

-- --------------------------------------------------------

--
-- Table structure for table `manufacturers`
--

CREATE TABLE `manufacturers` (
  `manufacturers_id` int(11) NOT NULL auto_increment,
  `manufacturers_name` varchar(32) NOT NULL,
  `manufacturers_image` varchar(64) default NULL,
  `guarantee_years` int(11) NOT NULL COMMENT 'Number of years manufacturer guarantess products',
  `date_added` datetime default NULL,
  `last_modified` datetime default NULL,
  PRIMARY KEY  (`manufacturers_id`),
  KEY `IDX_MANUFACTURERS_NAME` (`manufacturers_name`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=29 ;

--
-- Dumping data for table `manufacturers`
--

INSERT INTO `manufacturers` VALUES (13, 'Accurist', 'category_watches_accurist.png', 3, '2010-04-26 12:39:53', NULL);
INSERT INTO `manufacturers` VALUES (12, 'Citizen', 'category_watches_citizen.png', 5, '2010-04-26 12:39:07', NULL);
INSERT INTO `manufacturers` VALUES (14, 'Sekonda', 'category_watches_sekonda.png', 2, '2010-04-26 12:40:20', NULL);
INSERT INTO `manufacturers` VALUES (16, 'Gecko', 'category_jewellery_gecko.png', 0, '2010-04-26 12:41:23', NULL);
INSERT INTO `manufacturers` VALUES (17, 'Fluid', 'category_jewellery_fluid.png', 0, '2010-06-30 21:46:48', NULL);
INSERT INTO `manufacturers` VALUES (18, 'Quaich Company', '', 0, '2010-08-13 19:41:24', NULL);
INSERT INTO `manufacturers` VALUES (19, 'English Pewter', '', 0, '2010-08-13 19:41:41', NULL);
INSERT INTO `manufacturers` VALUES (20, '', 'goog1e5789a816a4e45.php', 0, '2010-09-04 01:13:17', NULL);
INSERT INTO `manufacturers` VALUES (21, 'Widdop & Bingham', '', 0, '2010-09-05 01:23:13', '2010-12-06 16:38:45');
INSERT INTO `manufacturers` VALUES (22, '', 'goog1e50cb833295593.php', 0, '2010-09-07 19:03:16', NULL);
INSERT INTO `manufacturers` VALUES (23, '', 'goog1e825275141c2b75.php', 0, '2010-09-16 04:33:55', NULL);
INSERT INTO `manufacturers` VALUES (24, '', 'goog1e96b78031982239.php', 0, '2010-09-16 06:50:20', NULL);
INSERT INTO `manufacturers` VALUES (25, '', 'goog1e6074c911989b6.php', 0, '2010-09-26 16:46:52', NULL);
INSERT INTO `manufacturers` VALUES (26, 'Stubbs & Co', '', 0, '2010-09-27 11:02:29', '2010-10-26 20:15:39');
INSERT INTO `manufacturers` VALUES (27, 'Emarno', '', 0, '2010-10-09 23:14:13', '2010-10-15 13:35:49');
INSERT INTO `manufacturers` VALUES (28, 'Curteis', '', 0, '2010-10-17 00:46:57', '2010-10-19 11:29:27');

-- --------------------------------------------------------

--
-- Table structure for table `manufacturers_info`
--

CREATE TABLE `manufacturers_info` (
  `manufacturers_id` int(11) NOT NULL,
  `languages_id` int(11) NOT NULL,
  `manufacturers_url` varchar(255) NOT NULL,
  `url_clicked` int(5) NOT NULL default '0',
  `date_last_click` datetime default NULL,
  `manufacturers_description` varchar(64) default NULL,
  PRIMARY KEY  (`manufacturers_id`,`languages_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `manufacturers_info`
--

INSERT INTO `manufacturers_info` VALUES (12, 1, 'http://www.citizenwatch.com/', 16, '2010-12-16 18:46:59', NULL);
INSERT INTO `manufacturers_info` VALUES (13, 1, 'http://www.accurist.co.uk/', 3, '2010-10-24 16:28:32', NULL);
INSERT INTO `manufacturers_info` VALUES (14, 1, 'http://www.sekonda.co.uk/', 3, '2010-11-13 06:28:41', NULL);
INSERT INTO `manufacturers_info` VALUES (16, 1, 'http://www.geckojewellery.com/', 10, '2010-12-11 11:28:53', NULL);
INSERT INTO `manufacturers_info` VALUES (17, 1, 'http://www.fluidjewellery.co.uk/', 4, '2010-10-24 16:22:08', NULL);
INSERT INTO `manufacturers_info` VALUES (18, 1, '', 0, NULL, NULL);
INSERT INTO `manufacturers_info` VALUES (19, 1, '', 0, NULL, NULL);
INSERT INTO `manufacturers_info` VALUES (20, 1, '', 0, NULL, NULL);
INSERT INTO `manufacturers_info` VALUES (21, 1, '', 0, NULL, NULL);
INSERT INTO `manufacturers_info` VALUES (22, 1, '', 0, NULL, NULL);
INSERT INTO `manufacturers_info` VALUES (23, 1, '', 0, NULL, NULL);
INSERT INTO `manufacturers_info` VALUES (24, 1, '', 0, NULL, NULL);
INSERT INTO `manufacturers_info` VALUES (25, 1, '', 0, NULL, NULL);
INSERT INTO `manufacturers_info` VALUES (26, 1, '', 0, NULL, NULL);
INSERT INTO `manufacturers_info` VALUES (27, 1, '', 0, NULL, NULL);
INSERT INTO `manufacturers_info` VALUES (28, 1, '', 0, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `newsletters`
--

CREATE TABLE `newsletters` (
  `newsletters_id` int(11) NOT NULL auto_increment,
  `title` varchar(255) NOT NULL,
  `content` text NOT NULL,
  `module` varchar(255) NOT NULL,
  `date_added` datetime NOT NULL,
  `date_sent` datetime default NULL,
  `status` int(1) default NULL,
  `locked` int(1) default '0',
  PRIMARY KEY  (`newsletters_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `newsletters`
--


-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `orders_id` int(11) NOT NULL auto_increment,
  `customers_id` int(11) NOT NULL,
  `customers_name` varchar(64) NOT NULL,
  `customers_company` varchar(32) default NULL,
  `customers_street_address` varchar(64) NOT NULL,
  `customers_suburb` varchar(32) default NULL,
  `customers_city` varchar(32) NOT NULL,
  `customers_postcode` varchar(10) NOT NULL,
  `customers_state` varchar(32) default NULL,
  `customers_country` varchar(32) NOT NULL,
  `customers_telephone` varchar(32) NOT NULL,
  `customers_email_address` varchar(96) NOT NULL,
  `customers_address_format_id` int(5) NOT NULL,
  `delivery_name` varchar(64) NOT NULL,
  `delivery_company` varchar(32) default NULL,
  `delivery_street_address` varchar(64) NOT NULL,
  `delivery_suburb` varchar(32) default NULL,
  `delivery_city` varchar(32) NOT NULL,
  `delivery_postcode` varchar(10) NOT NULL,
  `delivery_state` varchar(32) default NULL,
  `delivery_country` varchar(32) NOT NULL,
  `delivery_address_format_id` int(5) NOT NULL,
  `billing_name` varchar(64) NOT NULL,
  `billing_company` varchar(32) default NULL,
  `billing_street_address` varchar(64) NOT NULL,
  `billing_suburb` varchar(32) default NULL,
  `billing_city` varchar(32) NOT NULL,
  `billing_postcode` varchar(10) NOT NULL,
  `billing_state` varchar(32) default NULL,
  `billing_country` varchar(32) NOT NULL,
  `billing_address_format_id` int(5) NOT NULL,
  `payment_method` varchar(255) NOT NULL,
  `cc_type` varchar(20) default NULL,
  `cc_owner` varchar(64) default NULL,
  `cc_number` varchar(32) default NULL,
  `cc_expires` varchar(4) default NULL,
  `last_modified` datetime default NULL,
  `date_purchased` datetime default NULL,
  `orders_status` int(5) NOT NULL,
  `orders_date_finished` datetime default NULL,
  `currency` char(3) default NULL,
  `currency_value` decimal(14,6) default NULL,
  PRIMARY KEY  (`orders_id`),
  KEY `idx_orders_customers_id` (`customers_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=68 ;

--
-- Dumping data for table `orders`
--

INSERT INTO `orders` VALUES (54, 8, 'Susan Hermiston', '', '132 Peacocktail Close', '', 'Edinburgh', 'EH15 3QT', 'Lothian, Scotland', 'United Kingdom', '07803136154', 'susanhermiston-bowie@blueyonder.co.uk', 1, 'Susan Hermiston', '', '132 Peacocktail Close', '', 'Edinburgh', 'EH15 3QT', 'Lothian, Scotland', 'United Kingdom', 1, 'Susan Hermiston', '', '132 Peacocktail Close', '', 'Edinburgh', 'EH15 3QT', 'Lothian, Scotland', 'United Kingdom', 1, 'Credit Card', '', '', '', '', '2010-10-22 07:26:59', '2010-10-13 12:30:44', 3, NULL, 'GBP', 1.000000);
INSERT INTO `orders` VALUES (18, 2, 'Craig McKay', '', '7 Park Grove', '', 'Brechin', 'DD9 7AJ', '', 'United Kingdom', '01356 629481', 'craig@southesk.com', 1, 'Craig McKay', '', '7 Park Grove', '', 'Brechin', 'DD9 7AJ', '', 'United Kingdom', 1, 'Craig McKay', '', '7 Park Grove', '', 'Brechin', 'DD9 7AJ', '', 'United Kingdom', 1, 'Credit Card', '', '', '', '', NULL, '2010-07-15 21:35:08', 4, NULL, 'GBP', 1.000000);
INSERT INTO `orders` VALUES (50, 6, 'neil hutcheon', '', '28 city road', '', 'brechin', 'dd96dn', 'Angus, Scotland', 'United Kingdom', '626612', 'neilhutcheon@hotmail.co.uk', 1, 'neil hutcheon', '', '28 city road', '', 'brechin', 'dd96dn', 'Angus, Scotland', 'United Kingdom', 1, 'neil hutcheon', '', '28 city road', '', 'brechin', 'dd96dn', 'Angus, Scotland', 'United Kingdom', 1, 'Credit Card', '', '', '', '', '2010-09-08 07:46:40', '2010-09-04 13:01:15', 3, NULL, 'GBP', 1.000000);
INSERT INTO `orders` VALUES (52, 7, 'Linda Flanigan', '', '10 Barrett''s Close', 'Stonesfield', 'Stonesfield', 'OX29 8PW', 'Oxfordshire, England', 'United Kingdom', '01993891979', 'linda@flanigan01.wanadoo.co.uk', 1, 'Linda Flanigan', '', '10 Barrett''s Close', 'Stonesfield', 'Stonesfield', 'OX29 8PW', 'Oxfordshire, England', 'United Kingdom', 1, 'Linda Flanigan', '', '10 Barrett''s Close', 'Stonesfield', 'Stonesfield', 'OX29 8PW', 'Oxfordshire, England', 'United Kingdom', 1, 'Credit Card', '', '', '', '', '2010-10-13 13:01:21', '2010-10-02 14:31:31', 3, NULL, 'GBP', 1.000000);
INSERT INTO `orders` VALUES (55, 3, 'John Laing', '', '5 nether caldhame', '', 'brechin', 'dd9 7hn', 'Angus, Scotland', 'United Kingdom', '01356624063', 'birdie2@tiscali.co.uk', 1, 'John Laing', '', '5 nether caldhame', '', 'brechin', 'dd9 7hn', 'Angus, Scotland', 'United Kingdom', 1, 'John Laing', '', '5 nether caldhame', '', 'brechin', 'dd9 7hn', 'Angus, Scotland', 'United Kingdom', 1, 'Credit Card', '', '', '', '', NULL, '2010-10-13 13:23:34', 4, NULL, 'GBP', 1.000000);
INSERT INTO `orders` VALUES (57, 10, 'asdas ddsa', '', 'dsadsda', '', 'dasd', '32432', 'dasdas', 'Pakistan', '23432423', 'dasda@yahoo.com', 1, 'asdas ddsa', '', 'dsadsda', '', 'dasd', '32432', 'dasdas', 'Pakistan', 1, 'asdas ddsa', '', 'dsadsda', '', 'dasd', '32432', 'dasdas', 'Pakistan', 1, 'Credit Card', '', '', '', '', '2010-11-19 10:19:59', '2010-11-19 06:49:50', 5, NULL, 'GBP', 1.000000);
INSERT INTO `orders` VALUES (58, 11, 'Craig Singh', '', '1 Pakistan land', '', 'Isalamabad', 'PAK1', 'Isalamabadshire', 'Pakistan', '+44 1307 818 774', 'cmckay@southesk.com', 1, 'Craig Singh', '', '1 Pakistan land', '', 'Isalamabad', 'PAK1', 'Isalamabadshire', 'Pakistan', 1, 'Craig Singh', '', '1 Pakistan land', '', 'Isalamabad', 'PAK1', 'Isalamabadshire', 'Pakistan', 1, 'Credit Card', '', '', '', '', NULL, '2010-11-21 21:44:32', 4, NULL, 'GBP', 1.000000);
INSERT INTO `orders` VALUES (59, 12, 'Simon Henley-Castleden', '', '115 Poverest Road', '', 'Orpington', 'BR5 2DZ', 'Kent, England', 'United Kingdom', '07845250008', 'thehenleycastledens@o2.co.uk', 1, 'Simon Henley-Castleden', '', '115 Poverest Road', '', 'Orpington', 'BR5 2DZ', 'Kent, England', 'United Kingdom', 1, 'Simon Henley-Castleden', '', '115 Poverest Road', '', 'Orpington', 'BR5 2DZ', 'Kent, England', 'United Kingdom', 1, 'Credit Card', '', '', '', '', '2010-12-04 16:22:28', '2010-11-28 17:52:57', 3, NULL, 'GBP', 1.000000);
INSERT INTO `orders` VALUES (65, 17, 'Victor Dharmawan', '', '2950 NE 32 Ave', 'A-1721', 'FT Lauderdale', '33308', 'Florida', 'United States', '9456329465', 'superman8877@myself.com', 2, 'Victor Dharmawan', '', '2950 NE 32 Ave', 'A-1721', 'FT Lauderdale', '33308', 'Florida', 'United States', 2, 'Victor Dharmawan', '', '2950 NE 32 Ave', 'A-1721', 'FT Lauderdale', '33308', 'Florida', 'United States', 2, 'Credit Card', '', '', '', '', '2010-12-15 11:37:43', '2010-12-14 22:40:59', 5, NULL, 'GBP', 1.000000);
INSERT INTO `orders` VALUES (61, 13, 'Shelagh Borden', '', '11 lyndworth close', '', 'Oxford', 'Ox39er', 'Oxfordshire, England', 'United Kingdom', '01865766291', 'shelaghborden@btinternet.com', 1, 'Shelagh Borden', '', '11 lyndworth close', '', 'Oxford', 'Ox39er', 'Oxfordshire, England', 'United Kingdom', 1, 'Shelagh Borden', '', '11 lyndworth close', '', 'Oxford', 'Ox39er', 'Oxfordshire, England', 'United Kingdom', 1, 'Credit Card', '', '', '', '', '2010-12-04 16:23:02', '2010-11-30 12:11:26', 3, NULL, 'GBP', 1.000000);
INSERT INTO `orders` VALUES (62, 14, 'Anthony Horan', '', '3 Redburn Court', 'Cumbernauld', 'Glasgow', 'G67 3NL', 'Lanarkshire, Scotland', 'United Kingdom', '07738008938', 'anthony_horan@hotmail.co.uk', 1, 'Anthony Horan', '', '3 Redburn Court', 'Cumbernauld', 'Glasgow', 'G67 3NL', 'Lanarkshire, Scotland', 'United Kingdom', 1, 'Anthony Horan', '', '3 Redburn Court', 'Cumbernauld', 'Glasgow', 'G67 3NL', 'Lanarkshire, Scotland', 'United Kingdom', 1, 'Credit Card', '', '', '', '', '2010-12-12 18:32:08', '2010-12-01 23:24:58', 3, NULL, 'GBP', 1.000000);
INSERT INTO `orders` VALUES (64, 15, 'Neil Sutherland', '', '37 Moor Lane', 'Guiseley', 'Leeds', 'LS20 9EA', 'West Yorkshire, England', 'United Kingdom', '07734405730', 'neil-sutherland@hotmail.co.uk', 1, 'Neil Sutherland', '', '37 Moor Lane', 'Guiseley', 'Leeds', 'LS20 9EA', 'West Yorkshire, England', 'United Kingdom', 1, 'Neil Sutherland', '', '37 Moor Lane', 'Guiseley', 'Leeds', 'LS20 9EA', 'West Yorkshire, England', 'United Kingdom', 1, 'Credit Card', '', '', '', '', '2010-12-13 13:50:10', '2010-12-12 17:27:37', 2, NULL, 'GBP', 1.000000);
INSERT INTO `orders` VALUES (67, 19, 'Sharon Emery', '', '33 Westfield Ave', 'Audley', 'Stoke on Trent', 'ST7 8EQ', 'Staffordshire, England', 'United Kingdom', '01782723087', 'shazemery@aol.com', 1, 'Sharon Emery', '', '33 Westfield Ave', 'Audley', 'Stoke on Trent', 'ST7 8EQ', 'Staffordshire, England', 'United Kingdom', 1, 'Sharon Emery', '', '33 Westfield Ave', 'Audley', 'Stoke on Trent', 'ST7 8EQ', 'Staffordshire, England', 'United Kingdom', 1, 'Credit Card', '', '', '', '', '2010-12-27 09:55:10', '2010-12-27 09:32:17', 1, NULL, 'GBP', 1.000000);

-- --------------------------------------------------------

--
-- Table structure for table `orders_products`
--

CREATE TABLE `orders_products` (
  `orders_products_id` int(11) NOT NULL auto_increment,
  `orders_id` int(11) NOT NULL,
  `products_id` int(11) NOT NULL,
  `products_model` varchar(12) default NULL,
  `products_name` varchar(64) NOT NULL,
  `products_price` decimal(15,4) NOT NULL,
  `final_price` decimal(15,4) NOT NULL,
  `products_tax` decimal(7,4) NOT NULL,
  `products_quantity` int(2) NOT NULL,
  PRIMARY KEY  (`orders_products_id`),
  KEY `idx_orders_products_orders_id` (`orders_id`),
  KEY `idx_orders_products_products_id` (`products_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=101 ;

--
-- Dumping data for table `orders_products`
--

INSERT INTO `orders_products` VALUES (81, 52, 402, '43STC', 'Standard Celtic Band Quaich', 24.6809, 24.6809, 17.5000, 1);
INSERT INTO `orders_products` VALUES (85, 54, 174, 'P620', 'Girls D for Diamond Sterling Silver Heart Pendant', 16.1702, 16.1702, 17.5000, 1);
INSERT INTO `orders_products` VALUES (40, 18, 381, '4317', 'Ladies Sekonda Summer Time Riviera Blue Watch', 22.9702, 22.9702, 17.5000, 1);
INSERT INTO `orders_products` VALUES (78, 50, 251, 'E3665C', 'Sterling Silver Cubic Zirconia Drop Earring', 12.7660, 12.7660, 17.5000, 1);
INSERT INTO `orders_products` VALUES (84, 54, 287, 'P2599', 'Elements Sterling Silver Figure of 8 Pendant', 10.2128, 17.0213, 17.5000, 1);
INSERT INTO `orders_products` VALUES (88, 57, 694, '62543b01', '9ct White Gold 6mm Flat Court Bevelled edge wedding Ring Size R', 276.5957, 276.5957, 0.0000, 1);
INSERT INTO `orders_products` VALUES (86, 55, 287, 'P2599', 'Elements Sterling Silver Figure of 8 Pendant', 10.2128, 17.0213, 17.5000, 1);
INSERT INTO `orders_products` VALUES (89, 58, 694, '62543b01', '9ct White Gold 6mm Flat Court Bevelled edge wedding Ring Size R', 276.5957, 276.5957, 0.0000, 1);
INSERT INTO `orders_products` VALUES (90, 59, 201, 'LB1198', 'Ladies Accurist Stainless Steel Quartz Watch', 54.4681, 54.4681, 17.5000, 1);
INSERT INTO `orders_products` VALUES (96, 65, 44, 'BY0000-56E', 'Gents Citizen Stainless Steel Radio Controlled Watch', 322.5532, 322.5532, 0.0000, 2);
INSERT INTO `orders_products` VALUES (92, 61, 38, 'BM8242-16A', 'Gents Citizen Leather Strap Watch', 72.3404, 72.3404, 17.5000, 1);
INSERT INTO `orders_products` VALUES (93, 62, 267, 'E3525', 'Sterling Silver Butterfly Drop Earrings', 15.3191, 15.3191, 17.5000, 1);
INSERT INTO `orders_products` VALUES (95, 64, 374, '3212606', 'Fluid Sterling Silver Oasis Collection Pippin Pendant', 24.6809, 24.6809, 17.5000, 1);
INSERT INTO `orders_products` VALUES (100, 67, 477, 'LB1404', 'Ladies Silver Plated Charmed by Accurist (Starlight) Watch', 70.2128, 70.2128, 17.5000, 1);

-- --------------------------------------------------------

--
-- Table structure for table `orders_products_attributes`
--

CREATE TABLE `orders_products_attributes` (
  `orders_products_attributes_id` int(11) NOT NULL auto_increment,
  `orders_id` int(11) NOT NULL,
  `orders_products_id` int(11) NOT NULL,
  `products_options` varchar(32) NOT NULL,
  `products_options_values` varchar(32) NOT NULL,
  `options_values_price` decimal(15,4) NOT NULL,
  `price_prefix` char(1) NOT NULL,
  PRIMARY KEY  (`orders_products_attributes_id`),
  KEY `idx_orders_products_att_orders_id` (`orders_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=12 ;

--
-- Dumping data for table `orders_products_attributes`
--

INSERT INTO `orders_products_attributes` VALUES (10, 54, 84, 'Elements Silver Chain', '16" Med D/C Curb', 6.8085, '+');
INSERT INTO `orders_products_attributes` VALUES (11, 55, 86, 'Elements Silver Chain', '16" Med D/C Curb', 6.8085, '+');

-- --------------------------------------------------------

--
-- Table structure for table `orders_products_download`
--

CREATE TABLE `orders_products_download` (
  `orders_products_download_id` int(11) NOT NULL auto_increment,
  `orders_id` int(11) NOT NULL default '0',
  `orders_products_id` int(11) NOT NULL default '0',
  `orders_products_filename` varchar(255) NOT NULL default '',
  `download_maxdays` int(2) NOT NULL default '0',
  `download_count` int(2) NOT NULL default '0',
  PRIMARY KEY  (`orders_products_download_id`),
  KEY `idx_orders_products_download_orders_id` (`orders_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `orders_products_download`
--


-- --------------------------------------------------------

--
-- Table structure for table `orders_status`
--

CREATE TABLE `orders_status` (
  `orders_status_id` int(11) NOT NULL default '0',
  `language_id` int(11) NOT NULL default '1',
  `orders_status_name` varchar(32) NOT NULL,
  `public_flag` int(11) default '1',
  `downloads_flag` int(11) default '0',
  PRIMARY KEY  (`orders_status_id`,`language_id`),
  KEY `idx_orders_status_name` (`orders_status_name`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `orders_status`
--

INSERT INTO `orders_status` VALUES (1, 1, 'Pending', 1, 0);
INSERT INTO `orders_status` VALUES (2, 1, 'Despatched', 1, 1);
INSERT INTO `orders_status` VALUES (3, 1, 'Delivered', 1, 1);
INSERT INTO `orders_status` VALUES (4, 1, 'Preparing [RBS WorldPay]', 0, 0);
INSERT INTO `orders_status` VALUES (5, 1, 'Payment Refused', 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `orders_status_history`
--

CREATE TABLE `orders_status_history` (
  `orders_status_history_id` int(11) NOT NULL auto_increment,
  `orders_id` int(11) NOT NULL,
  `orders_status_id` int(5) NOT NULL,
  `date_added` datetime NOT NULL,
  `customer_notified` int(1) default '0',
  `comments` text,
  PRIMARY KEY  (`orders_status_history_id`),
  KEY `idx_orders_status_history_orders_id` (`orders_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=105 ;

--
-- Dumping data for table `orders_status_history`
--

INSERT INTO `orders_status_history` VALUES (75, 52, 3, '2010-10-13 13:01:21', 0, '');
INSERT INTO `orders_status_history` VALUES (74, 54, 1, '2010-10-13 12:31:35', 1, '');
INSERT INTO `orders_status_history` VALUES (73, 54, 1, '2010-10-13 12:31:34', 0, 'WorldPay: Transaction Verified');
INSERT INTO `orders_status_history` VALUES (77, 54, 3, '2010-10-22 07:26:59', 0, 'Your item with reference DL067681645GB was delivered from our PORTOBELLO Delivery Office on 20/10/10 .\r\n\r\nThank you for using this service.\r\n\r\nThe electronic Proof of Delivery for this item is now displayed below.');
INSERT INTO `orders_status_history` VALUES (71, 52, 1, '2010-10-02 14:38:59', 1, '');
INSERT INTO `orders_status_history` VALUES (70, 52, 1, '2010-10-02 14:38:58', 0, 'WorldPay: Transaction Verified');
INSERT INTO `orders_status_history` VALUES (65, 50, 1, '2010-09-04 13:05:06', 0, 'WorldPay: Transaction Verified');
INSERT INTO `orders_status_history` VALUES (66, 50, 1, '2010-09-04 13:05:08', 1, '');
INSERT INTO `orders_status_history` VALUES (67, 50, 2, '2010-09-06 10:54:28', 1, 'Your earrings have now been despatched by Recorded Delivery nunber - DL 0676 8193 2GB');
INSERT INTO `orders_status_history` VALUES (68, 50, 3, '2010-09-08 07:46:40', 0, '');
INSERT INTO `orders_status_history` VALUES (72, 52, 2, '2010-10-04 11:35:11', 1, 'Thank you very much for your order, it has now been despatched and can be tracked by using Royal Mail track and trace.\r\nThe tracking number is DL 0676 8191 5GB\r\n\r\nAs of tommorrow we will be closed for one week.\r\n\r\nregards\r\nJohn Laing');
INSERT INTO `orders_status_history` VALUES (81, 59, 1, '2010-11-28 17:55:26', 0, 'WorldPay: Transaction Verified');
INSERT INTO `orders_status_history` VALUES (82, 59, 1, '2010-11-28 17:55:26', 1, '');
INSERT INTO `orders_status_history` VALUES (83, 59, 2, '2010-11-29 10:19:27', 1, 'Your watch has now been despatched and will be delivered by Royal Mail, using there special delivery service.\r\nYou can use the Royal Mail track and trace service to track your parcel, the reference number is - ZI 1631 1255 9GB.\r\nThank you very much for you order\r\nJ.Mitchell & Son');
INSERT INTO `orders_status_history` VALUES (80, 57, 5, '2010-11-19 10:19:59', 0, 'Address outside U.K.');
INSERT INTO `orders_status_history` VALUES (76, 54, 2, '2010-10-14 17:29:13', 1, 'Your order has now been despatched and you can track at Royal Mail track and trace.\r\nTracking number - DL067681645GB\r\n\r\nRegards\r\nJohn Laing');
INSERT INTO `orders_status_history` VALUES (84, 61, 1, '2010-11-30 12:13:26', 0, 'WorldPay: Transaction Verified');
INSERT INTO `orders_status_history` VALUES (85, 61, 1, '2010-11-30 12:13:30', 1, '');
INSERT INTO `orders_status_history` VALUES (86, 61, 2, '2010-11-30 14:02:45', 1, 'Thank you very much for your order.\r\nThis has now been despatched and can be tracked through the Royal Mail track and trace facility.\r\nYor tracking number is SC 5207 2371 8GB.\r\n\r\nRegards\r\nJ.Mitchell & Son');
INSERT INTO `orders_status_history` VALUES (87, 62, 1, '2010-12-01 23:26:45', 0, 'WorldPay: Transaction Verified');
INSERT INTO `orders_status_history` VALUES (88, 62, 1, '2010-12-01 23:26:46', 1, '');
INSERT INTO `orders_status_history` VALUES (89, 62, 2, '2010-12-02 13:06:06', 1, 'Thank you very much for your order.\r\nThis has now been despatched and can be tracked on the Royal Mail website using their track and trace facility.\r\nThe tracking number is - AH 3050 9311 8GB\r\n\r\nRegards\r\nJ.Mitchell & Son');
INSERT INTO `orders_status_history` VALUES (90, 59, 0, '2010-12-02 18:25:49', 0, '');
INSERT INTO `orders_status_history` VALUES (91, 59, 1, '2010-12-02 18:35:22', 1, 'The parcel was sent on Monday at approx 10am, I checked the track and trace facility at 10.15am and it was showing that it had been received at Clerk Street Post Office. I have just checked and it says no data for this parcel.\r\nI tried to phone Royal Mail but after 6pm no one available. I then phoned my brother who is a postie and he is going to check with Royal Mail when he goes to work in the morning.\r\n\r\nThe weather has seen little or no improvement since Sunday in this part of the country.\r\n\r\nI will give you a further update in the morning, when I have more information.\r\n\r\nRegards\r\nJohn Laing');
INSERT INTO `orders_status_history` VALUES (92, 59, 1, '2010-12-03 09:41:28', 1, 'Hi\r\n\r\nFurther update regarding your parcel.\r\n\r\nThis morning I have spoken to the Brechin Postmaster and he has given me all the details.\r\nMonday 29th 9.58am received at Brechin post office.\r\nTuesday 30th despatched to Edinburgh sorting office and then despatched to Croydon which has taken 2 days.\r\nThursday 2nd arrives at Croydon.\r\nFriday 3rd arrives at Orpington at 5.05am and is scanned at 8.05am by the delivering postie, should arrive by 1pm today 3/12/10.\r\n\r\nI am very sorry for this delay, the weather has played a large part, this service from Royal Mail is generally very reliable and I always use it. This is the first time I can remember having any problem in the 28 years I have used it.\r\nAgain I can only apologise and hope this parcel is with you by 1pm.\r\n\r\nregards\r\nJohn Laing');
INSERT INTO `orders_status_history` VALUES (93, 61, 2, '2010-12-03 12:37:36', 1, 'Hi Shelagh\r\n\r\nThank you very for your phone call. \r\nYou can track your parcel through the Royal Mail track and trace service, the reference number is SC 5207 2371 8GB.\r\n\r\nI have checked this and you should receive your parcel today.\r\n\r\nI am a bit concerned you cannot access my website when you try to log in, I will get my IT consultant to look at this.\r\n\r\nIf you have another query please do not hesitate to contact me.\r\n\r\nRegards\r\nJohn Laing');
INSERT INTO `orders_status_history` VALUES (94, 59, 3, '2010-12-04 16:22:28', 0, '');
INSERT INTO `orders_status_history` VALUES (95, 61, 3, '2010-12-04 16:23:02', 0, '');
INSERT INTO `orders_status_history` VALUES (96, 64, 1, '2010-12-12 17:29:49', 0, 'WorldPay: Transaction Verified');
INSERT INTO `orders_status_history` VALUES (97, 64, 1, '2010-12-12 17:29:54', 1, 'Required for Christmas.\r\nPlease include gift reciept as a present.');
INSERT INTO `orders_status_history` VALUES (98, 62, 3, '2010-12-12 18:32:08', 0, '');
INSERT INTO `orders_status_history` VALUES (99, 64, 1, '2010-12-13 10:31:28', 1, 'Thank you very much for your order.\r\n\r\nYour order has now been despatched by Royal Mail recorded delivery, which can be tracked on the Royal Mail website (Track and Trace). The reference number is AH 3050 9312 1GB.\r\n\r\n All orders placed on or after 1st December 2010 will have an extended returns policy to 7th January 2011.\r\n\r\nRegards\r\nJ.Mitchell & Son');
INSERT INTO `orders_status_history` VALUES (100, 64, 2, '2010-12-13 13:50:10', 0, '');
INSERT INTO `orders_status_history` VALUES (101, 65, 5, '2010-12-15 11:37:44', 1, 'Hi Victor\r\n\r\nUnfortunately we only deliver to addresses in the United Kingdom where the credit card statements are received, so we cannot complete this order.\r\nPlease accept our apologies.\r\n\r\nRegards\r\nJ.Mitchell & Son');
INSERT INTO `orders_status_history` VALUES (102, 67, 1, '2010-12-27 09:34:29', 0, 'WorldPay: Transaction Verified');
INSERT INTO `orders_status_history` VALUES (103, 67, 1, '2010-12-27 09:34:37', 1, '');
INSERT INTO `orders_status_history` VALUES (104, 67, 1, '2010-12-27 09:55:10', 1, 'Thank you very much for your order.\r\n\r\nYour watch will be despatched on Wednesday 29th December, this is when the Post Office re-opens. \r\n\r\nI will send you an update and a Royal Mail tracking number on Wednesday when I despatch your order.\r\n\r\nBest regards\r\nJ.Mitchell & Son');

-- --------------------------------------------------------

--
-- Table structure for table `orders_total`
--

CREATE TABLE `orders_total` (
  `orders_total_id` int(10) unsigned NOT NULL auto_increment,
  `orders_id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `text` varchar(255) NOT NULL,
  `value` decimal(15,4) NOT NULL,
  `class` varchar(32) NOT NULL,
  `sort_order` int(11) NOT NULL,
  PRIMARY KEY  (`orders_total_id`),
  KEY `idx_orders_total_orders_id` (`orders_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=245 ;

--
-- Dumping data for table `orders_total`
--

INSERT INTO `orders_total` VALUES (192, 54, 'Sub-Total:', '&pound;39.00', 39.0000, 'ot_subtotal', 1);
INSERT INTO `orders_total` VALUES (193, 54, 'P&amp;P (Royal Mail):', '&pound;2.95', 2.9500, 'ot_shipping', 2);
INSERT INTO `orders_total` VALUES (194, 54, 'VAT (17.5%):', '&pound;5.81', 5.8085, 'ot_tax', 3);
INSERT INTO `orders_total` VALUES (195, 54, 'Total:', '<b>&pound;41.95</b>', 41.9500, 'ot_total', 4);
INSERT INTO `orders_total` VALUES (187, 52, 'Total:', '<b>&pound;31.95</b>', 31.9500, 'ot_total', 4);
INSERT INTO `orders_total` VALUES (186, 52, 'VAT (17.5%):', '&pound;4.32', 4.3191, 'ot_tax', 3);
INSERT INTO `orders_total` VALUES (185, 52, 'P&amp;P (Royal Mail):', '&pound;2.95', 2.9500, 'ot_shipping', 2);
INSERT INTO `orders_total` VALUES (184, 52, 'Sub-Total:', '&pound;29.00', 29.0000, 'ot_subtotal', 1);
INSERT INTO `orders_total` VALUES (179, 50, 'Total:', '<b>&pound;17.95</b>', 17.9500, 'ot_total', 4);
INSERT INTO `orders_total` VALUES (176, 50, 'Sub-Total:', '&pound;15.00', 15.0000, 'ot_subtotal', 1);
INSERT INTO `orders_total` VALUES (177, 50, 'P&amp;P (Royal Mail):', '&pound;2.95', 2.9500, 'ot_shipping', 2);
INSERT INTO `orders_total` VALUES (178, 50, 'VAT (17.5%):', '&pound;2.23', 2.2340, 'ot_tax', 3);
INSERT INTO `orders_total` VALUES (199, 55, 'Total:', '<b>&pound;22.95</b>', 22.9500, 'ot_total', 4);
INSERT INTO `orders_total` VALUES (206, 57, 'Total:', '<b>&pound;276.60</b>', 276.6000, 'ot_total', 4);
INSERT INTO `orders_total` VALUES (205, 57, 'P&amp;P (Royal Mail):', '&pound;0.00', 0.0000, 'ot_shipping', 2);
INSERT INTO `orders_total` VALUES (204, 57, 'Sub-Total:', '&pound;276.60', 276.6000, 'ot_subtotal', 1);
INSERT INTO `orders_total` VALUES (198, 55, 'VAT (17.5%):', '&pound;2.98', 2.9787, 'ot_tax', 3);
INSERT INTO `orders_total` VALUES (197, 55, 'P&amp;P (Royal Mail):', '&pound;2.95', 2.9500, 'ot_shipping', 2);
INSERT INTO `orders_total` VALUES (196, 55, 'Sub-Total:', '&pound;20.00', 20.0000, 'ot_subtotal', 1);
INSERT INTO `orders_total` VALUES (207, 58, 'Sub-Total:', '&pound;276.60', 276.6000, 'ot_subtotal', 1);
INSERT INTO `orders_total` VALUES (208, 58, 'P&amp;P (Royal Mail):', '&pound;0.00', 0.0000, 'ot_shipping', 2);
INSERT INTO `orders_total` VALUES (209, 58, 'Total:', '<b>&pound;276.60</b>', 276.6000, 'ot_total', 4);
INSERT INTO `orders_total` VALUES (210, 59, 'Sub-Total:', '&pound;64.00', 64.0000, 'ot_subtotal', 1);
INSERT INTO `orders_total` VALUES (211, 59, 'P&amp;P (Royal Mail):', '&pound;5.95', 5.9500, 'ot_shipping', 2);
INSERT INTO `orders_total` VALUES (212, 59, 'VAT (17.5%):', '&pound;9.53', 9.5319, 'ot_tax', 3);
INSERT INTO `orders_total` VALUES (213, 59, 'Total:', '<b>&pound;69.95</b>', 69.9500, 'ot_total', 4);
INSERT INTO `orders_total` VALUES (236, 65, 'Total:', '<b>&pound;645.10</b>', 645.1000, 'ot_total', 4);
INSERT INTO `orders_total` VALUES (235, 65, 'P&amp;P (Royal Mail):', '&pound;0.00', 0.0000, 'ot_shipping', 2);
INSERT INTO `orders_total` VALUES (234, 65, 'Sub-Total:', '&pound;645.10', 645.1000, 'ot_subtotal', 1);
INSERT INTO `orders_total` VALUES (218, 61, 'Sub-Total:', '&pound;85.00', 85.0000, 'ot_subtotal', 1);
INSERT INTO `orders_total` VALUES (219, 61, 'P&amp;P (Royal Mail):', '&pound;5.95', 5.9500, 'ot_shipping', 2);
INSERT INTO `orders_total` VALUES (220, 61, 'VAT (17.5%):', '&pound;12.66', 12.6596, 'ot_tax', 3);
INSERT INTO `orders_total` VALUES (221, 61, 'Total:', '<b>&pound;90.95</b>', 90.9500, 'ot_total', 4);
INSERT INTO `orders_total` VALUES (222, 62, 'Sub-Total:', '&pound;18.00', 18.0000, 'ot_subtotal', 1);
INSERT INTO `orders_total` VALUES (223, 62, 'P&amp;P (Royal Mail):', '&pound;2.95', 2.9500, 'ot_shipping', 2);
INSERT INTO `orders_total` VALUES (224, 62, 'VAT (17.5%):', '&pound;2.68', 2.6809, 'ot_tax', 3);
INSERT INTO `orders_total` VALUES (225, 62, 'Total:', '<b>&pound;20.95</b>', 20.9500, 'ot_total', 4);
INSERT INTO `orders_total` VALUES (232, 64, 'VAT (17.5%):', '&pound;4.32', 4.3191, 'ot_tax', 3);
INSERT INTO `orders_total` VALUES (231, 64, 'P&amp;P (Royal Mail):', '&pound;2.95', 2.9500, 'ot_shipping', 2);
INSERT INTO `orders_total` VALUES (230, 64, 'Sub-Total:', '&pound;29.00', 29.0000, 'ot_subtotal', 1);
INSERT INTO `orders_total` VALUES (233, 64, 'Total:', '<b>&pound;31.95</b>', 31.9500, 'ot_total', 4);
INSERT INTO `orders_total` VALUES (243, 67, 'VAT (17.5%):', '&pound;12.29', 12.2872, 'ot_tax', 3);
INSERT INTO `orders_total` VALUES (242, 67, 'P&amp;P (Royal Mail):', '&pound;5.95', 5.9500, 'ot_shipping', 2);
INSERT INTO `orders_total` VALUES (241, 67, 'Sub-Total:', '&pound;82.50', 82.5000, 'ot_subtotal', 1);
INSERT INTO `orders_total` VALUES (244, 67, 'Total:', '<b>&pound;88.45</b>', 88.4500, 'ot_total', 4);

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `products_id` int(11) NOT NULL auto_increment,
  `groupid` int(11) NOT NULL,
  `products_quantity` int(4) NOT NULL,
  `products_model` varchar(12) default NULL,
  `products_image` varchar(64) default NULL,
  `products_price` decimal(15,4) NOT NULL,
  `products_date_added` datetime NOT NULL,
  `products_last_modified` datetime default NULL,
  `products_date_available` datetime default NULL,
  `products_weight` decimal(5,2) NOT NULL,
  `products_status` tinyint(1) NOT NULL,
  `products_tax_class_id` int(11) NOT NULL,
  `manufacturers_id` int(11) default NULL,
  `products_ordered` int(11) NOT NULL default '0',
  `dataload_gender` varchar(30) default NULL,
  `dataload_price_rrp` double default NULL,
  PRIMARY KEY  (`products_id`),
  KEY `idx_products_model` (`products_model`),
  KEY `idx_products_date_added` (`products_date_added`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=779 ;

--
-- Dumping data for table `products`
--

INSERT INTO `products` VALUES (81, 0, 1, '3012', 'wsek_3012.jpg', 22.9702, '0000-00-00 00:00:00', '2010-06-08 12:44:57', NULL, 0.00, 1, 1, 14, 0, NULL, NULL);
INSERT INTO `products` VALUES (80, 0, 1, '3011', 'wsek_3011.jpg', 19.1404, '0000-00-00 00:00:00', '2010-06-08 12:44:34', NULL, 1.00, 1, 1, 14, 0, NULL, NULL);
INSERT INTO `products` VALUES (5, 0, 1, 'AR0014-52A', 'wcit_ar0014-52a.jpg', 182.9787, '2010-05-25 21:00:00', '2010-12-27 16:04:40', NULL, 1.00, 1, 1, 12, 0, NULL, NULL);
INSERT INTO `products` VALUES (6, 0, 1, 'AR1002-05A', 'wcit_ar1002-05a.jpg', 144.6809, '2010-05-25 21:00:00', '2010-12-27 16:03:17', NULL, 1.00, 1, 1, 12, 0, NULL, NULL);
INSERT INTO `products` VALUES (7, 0, 1, 'AR1002-56B', 'wcit_ar1002-56b.jpg', 205.9574, '2010-05-25 21:00:00', '2010-12-27 16:02:50', NULL, 1.00, 1, 1, 12, 0, NULL, NULL);
INSERT INTO `products` VALUES (8, 0, 1, 'AR1004-51E', 'wcit_ar1004-51e.jpg', 205.9574, '2010-05-25 21:00:00', '2010-12-27 16:05:13', NULL, 0.00, 1, 1, 12, 0, NULL, NULL);
INSERT INTO `products` VALUES (9, 0, 1, 'AR1062-03P', 'wcit_ar1062-03p.jpg', 144.6809, '2010-05-25 21:00:00', '2010-12-27 16:03:39', NULL, 0.00, 1, 1, 12, 0, NULL, NULL);
INSERT INTO `products` VALUES (10, 0, 1, 'AR3004-50A', 'wcit_ar3004-50a.jpg', 205.9574, '2010-05-25 21:00:00', '2010-12-27 16:05:35', NULL, 0.00, 1, 1, 12, 0, NULL, NULL);
INSERT INTO `products` VALUES (11, 0, 1, 'AR3010-57E', 'wcit_ar3010-57e.jpg', 213.6170, '2010-05-25 21:00:00', '2010-12-27 16:04:03', NULL, 1.00, 1, 1, 12, 0, NULL, NULL);
INSERT INTO `products` VALUES (12, 0, 1, 'AT0810-55X', 'wcit_at0810-55x.jpg', 143.8298, '2010-05-25 21:00:00', '2010-09-07 16:54:32', NULL, 0.00, 1, 1, 12, 0, NULL, NULL);
INSERT INTO `products` VALUES (13, 0, 0, 'AT0884-59E', 'wcit_at0884-59e.jpg', 158.2979, '2010-05-25 21:00:00', '2010-06-04 15:02:22', NULL, 0.00, 1, 1, 12, 1, NULL, NULL);
INSERT INTO `products` VALUES (14, 0, 1, 'AT0910-51E', 'wcit_at0910-51e.jpg', 190.6383, '2010-05-25 21:00:00', '2010-12-27 15:58:33', NULL, 1.00, 1, 1, 12, 0, NULL, NULL);
INSERT INTO `products` VALUES (15, 0, 1, 'AU1012-54A', 'wcit_au1012-54a.jpg', 108.0851, '2010-05-25 21:00:00', '2010-06-03 19:47:39', NULL, 1.00, 1, 1, 12, 0, NULL, NULL);
INSERT INTO `products` VALUES (16, 0, 1, 'AU1022-51A', 'wcit_au1022-51a.jpg', 108.0851, '2010-05-25 21:00:00', '2010-06-03 19:49:39', NULL, 1.00, 1, 1, 12, 0, NULL, NULL);
INSERT INTO `products` VALUES (17, 0, 1, 'AU1024-55A', 'wcit_au1024-55a.jpg', 108.0851, '2010-05-25 21:00:00', '2010-06-04 15:15:53', NULL, 0.00, 1, 1, 12, 0, NULL, NULL);
INSERT INTO `products` VALUES (18, 0, 1, 'BL5250-02L', 'wcit_bl5250-02l.jpg', 211.9149, '2010-05-25 21:00:00', '2010-12-27 11:35:02', NULL, 0.00, 0, 1, 12, 0, NULL, NULL);
INSERT INTO `products` VALUES (19, 0, 1, 'BL5376-55A', 'wcit_bl5376-55a.jpg', 228.9362, '2010-05-25 21:00:00', '2010-12-27 16:06:42', NULL, 0.00, 1, 1, 12, 0, NULL, NULL);
INSERT INTO `products` VALUES (20, 0, 1, 'BL5380-58E', 'wcit_bl5380-58e.jpg', 194.8936, '2010-05-25 21:00:00', '2010-06-03 20:12:58', NULL, 1.00, 1, 1, 12, 0, NULL, NULL);
INSERT INTO `products` VALUES (21, 0, 1, '', 'wcit_bl6005-01e.jpg', 75.7447, '2010-05-25 21:00:00', '2010-12-27 15:56:50', NULL, 0.00, 1, 1, 12, 1, NULL, NULL);
INSERT INTO `products` VALUES (22, 0, 1, 'BL8000-54L', 'wcit_bl8000-54l.jpg', 221.2766, '2010-05-25 21:00:00', '2010-12-27 15:59:28', NULL, 1.00, 1, 1, 12, 0, NULL, NULL);
INSERT INTO `products` VALUES (23, 0, 1, 'BM0900-51L', 'wcit_bm0900-51l.jpg', 129.3617, '2010-05-25 21:00:00', '2010-06-03 20:32:06', NULL, 0.00, 1, 1, 12, 0, NULL, NULL);
INSERT INTO `products` VALUES (24, 0, 1, 'BM5000-54A', 'wcit_bm5000-54a.jpg', 129.3617, '2010-05-25 21:00:00', '2010-06-04 15:24:11', NULL, 0.00, 1, 1, 12, 0, NULL, NULL);
INSERT INTO `products` VALUES (459, 0, 2, 'MB864', 'MB864_opt-1.jpg', 34.0426, '2010-10-01 09:05:22', '2010-10-13 16:39:04', NULL, 0.00, 1, 1, 13, 0, NULL, NULL);
INSERT INTO `products` VALUES (26, 0, 1, 'BM6010-55A', 'wcit_bm6010-55a.jpg', 80.8511, '2010-05-25 21:00:00', '2010-09-16 14:41:17', NULL, 0.00, 1, 1, 12, 0, NULL, NULL);
INSERT INTO `products` VALUES (27, 0, 1, 'BM6010-55E', 'wcit_bm6010-55e.jpg', 80.8511, '2010-05-25 21:00:00', '2010-06-03 20:46:58', NULL, 1.00, 1, 1, 12, 0, NULL, NULL);
INSERT INTO `products` VALUES (28, 0, 1, 'BM6014-54A', 'wcit_bm6014-54a.jpg', 93.6170, '2010-05-25 21:00:00', '2010-12-14 13:15:38', NULL, 1.00, 0, 1, 12, 0, NULL, NULL);
INSERT INTO `products` VALUES (29, 0, 1, 'BM6550-58E', 'wcit_bm6550-58e.jpg', 101.2766, '2010-05-25 21:00:00', '2010-06-03 20:56:42', NULL, 1.00, 1, 1, 12, 0, NULL, NULL);
INSERT INTO `products` VALUES (30, 0, 1, 'BM6552-52E', 'wcit_bm6552-52e.jpg', 108.0851, '2010-05-25 21:00:00', '2010-08-19 17:02:51', NULL, 1.00, 1, 1, 12, 0, NULL, NULL);
INSERT INTO `products` VALUES (31, 0, 1, 'BM6560-54H', 'wcit_bm6560-54h.jpg', 129.3617, '2010-05-25 21:00:00', '2010-12-18 15:31:11', NULL, 0.00, 0, 1, 12, 0, NULL, NULL);
INSERT INTO `products` VALUES (32, 0, 1, 'BM6575-06E', 'wcit_bm6575-06e.jpg', 89.3617, '2010-05-25 21:00:00', '2010-12-26 09:57:01', NULL, 1.00, 1, 1, 12, 0, NULL, NULL);
INSERT INTO `products` VALUES (33, 0, 1, 'BM8220-51L', 'wcit_bm8220-51l.jpg', 72.3404, '2010-05-25 21:00:00', '2010-07-23 09:26:18', NULL, 1.00, 1, 1, 12, 0, NULL, NULL);
INSERT INTO `products` VALUES (34, 0, 1, 'BM8224-51E', 'wcit_bm8224-51e.jpg', 80.0000, '2010-05-25 21:00:00', '2010-09-16 14:45:08', NULL, 1.00, 0, 1, 12, 0, NULL, NULL);
INSERT INTO `products` VALUES (35, 0, 1, 'BM8240-11A', 'wcit_bm8240-11a.jpg', 65.5319, '2010-05-25 21:00:00', '2010-10-29 15:36:15', NULL, 1.00, 0, 1, 12, 1, NULL, NULL);
INSERT INTO `products` VALUES (36, 0, 1, 'BM8242-08A', 'wcit_bm8242-08a.jpg', 72.3404, '2010-05-25 21:00:00', '2010-06-07 23:03:43', NULL, 1.00, 1, 1, 12, 0, NULL, NULL);
INSERT INTO `products` VALUES (37, 0, 1, 'BM8242-08P', 'wcit_bm8242-08p.jpg', 72.3404, '2010-05-25 21:00:00', '2010-06-07 23:56:06', NULL, 1.00, 1, 1, 12, 0, NULL, NULL);
INSERT INTO `products` VALUES (38, 0, -1, 'BM8242-16A', 'wcit_bm8242-16a.jpg', 72.3404, '2010-05-25 21:00:00', '2010-11-30 12:36:57', NULL, 1.00, 0, 1, 12, 1, NULL, NULL);
INSERT INTO `products` VALUES (39, 0, 1, 'BM8450-94B', 'wcit_bm8450-94b.jpg', 65.5319, '2010-05-25 21:00:00', '2010-06-04 15:17:17', NULL, 1.00, 1, 1, 12, 0, NULL, NULL);
INSERT INTO `products` VALUES (40, 0, 1, 'BM8452-99A', 'wcit_bm8452-99a.jpg', 72.3404, '2010-05-25 21:00:00', '2010-09-10 14:11:51', NULL, 1.00, 1, 1, 12, 0, NULL, NULL);
INSERT INTO `products` VALUES (41, 0, 1, 'BM8454-93A', 'wcit_bm8454-93a.jpg', 72.3404, '2010-05-25 21:00:00', '2010-09-14 10:42:54', NULL, 1.00, 1, 1, 12, 0, NULL, NULL);
INSERT INTO `products` VALUES (42, 0, 1, 'BV1030-08A', 'wcit_bv1030-08a.jpg', 108.0851, '2010-05-25 21:00:00', '2010-06-07 23:03:50', NULL, 0.00, 1, 1, 12, 0, NULL, NULL);
INSERT INTO `products` VALUES (43, 0, 1, 'BW0172-02P', 'wcit_bw0172-02p.jpg', 72.3404, '2010-05-25 21:00:00', '2010-06-07 23:04:20', NULL, 1.00, 1, 1, 12, 0, NULL, NULL);
INSERT INTO `products` VALUES (44, 0, 1, 'BY0000-56E', 'wcit_by0000-56e.jpg', 343.8298, '2010-05-25 21:00:00', '2010-12-27 16:00:25', NULL, 0.00, 1, 1, 12, 1, NULL, NULL);
INSERT INTO `products` VALUES (45, 0, 1, 'EG2152-51D', 'wcit_eg2152-51d.jpg', 137.0213, '2010-05-25 21:00:00', '2010-12-27 16:09:37', NULL, 1.00, 1, 1, 12, 0, NULL, NULL);
INSERT INTO `products` VALUES (46, 0, 1, 'EG2664-50D', 'wcit_eg2664-50d.jpg', 123.4043, '2010-05-25 21:00:00', '2010-09-04 09:22:30', NULL, 1.00, 1, 1, 12, 0, NULL, NULL);
INSERT INTO `products` VALUES (47, 0, -1, 'EG2680-53D', 'wcit_eg2680-53d.jpg', 251.9149, '2010-05-25 21:00:00', '2010-12-27 16:07:41', NULL, 1.00, 1, 1, 12, 2, NULL, NULL);
INSERT INTO `products` VALUES (48, 0, 1, 'EG2682-58D', 'wcit_eg2682-58d.jpg', 267.2340, '2010-05-25 21:00:00', '2010-12-27 16:07:18', NULL, 1.00, 1, 1, 12, 1, NULL, NULL);
INSERT INTO `products` VALUES (49, 0, 1, 'EG2690-50E', 'wcit_eg2690-50e.jpg', 122.5532, '2010-05-25 21:00:00', '2010-09-04 09:16:56', NULL, 1.00, 1, 1, 12, 0, NULL, NULL);
INSERT INTO `products` VALUES (50, 0, 1, 'EG2692-54D', 'wcit_eg2692-54d.jpg', 136.1702, '2010-05-25 21:00:00', '2010-09-04 09:11:18', NULL, 1.00, 1, 1, 12, 0, NULL, NULL);
INSERT INTO `products` VALUES (51, 0, 1, 'EG2694-59D', 'wcit_eg2694-59d.jpg', 136.1702, '2010-05-25 21:00:00', '2010-12-23 16:46:22', NULL, 1.00, 0, 1, 12, 0, NULL, NULL);
INSERT INTO `products` VALUES (52, 0, 1, 'EG2704-57E', 'wcit_eg2704-57e.jpg', 114.8936, '2010-05-25 21:00:00', '2010-06-04 12:41:35', NULL, 1.00, 1, 1, 12, 0, NULL, NULL);
INSERT INTO `products` VALUES (53, 0, 1, 'EG3022-51D', 'wcit_eg3022-51d.jpg', 305.5319, '2010-05-25 21:00:00', '2010-12-27 16:10:14', NULL, 1.00, 1, 1, 12, 0, NULL, NULL);
INSERT INTO `products` VALUES (54, 0, 1, 'EG3042-54A', 'wcit_eg3042-54a.jpg', 172.7660, '2010-05-25 21:00:00', '2010-06-04 12:49:35', NULL, 1.00, 1, 1, 12, 0, NULL, NULL);
INSERT INTO `products` VALUES (55, 0, 1, 'EG3060-52D', 'wcit_eg3060-52d.jpg', 331.0638, '2010-05-25 21:00:00', '2010-12-27 10:56:22', NULL, 1.00, 1, 1, 12, 0, NULL, NULL);
INSERT INTO `products` VALUES (56, 0, 1, 'EW0894-57D', 'wcit_ew0894-57d.jpg', 178.7234, '2010-05-25 21:00:00', '2010-06-04 12:57:04', NULL, 1.00, 1, 1, 12, 0, NULL, NULL);
INSERT INTO `products` VALUES (57, 0, 1, 'EW1254-53A', 'wcit_ew1254-53a.jpg', 93.6170, '2010-05-25 21:00:00', '2010-06-04 12:59:50', NULL, 1.00, 1, 1, 12, 0, NULL, NULL);
INSERT INTO `products` VALUES (58, 0, 1, 'EW1264-50A', 'wcit_ew1264-50a.jpg', 101.2766, '2010-05-25 21:00:00', '2010-06-04 13:01:28', NULL, 1.00, 1, 1, 12, 0, NULL, NULL);
INSERT INTO `products` VALUES (59, 0, 1, 'EW1270-06A', 'wcit_ew1270-06a.jpg', 65.5319, '2010-05-25 21:00:00', '2010-08-10 10:44:08', NULL, 1.00, 1, 1, 12, 0, NULL, NULL);
INSERT INTO `products` VALUES (60, 0, 1, 'EW1272-01B', 'wcit_ew1272-01b.jpg', 72.3404, '2010-05-25 21:00:00', '2010-06-07 23:09:57', NULL, 1.00, 1, 1, 12, 0, NULL, NULL);
INSERT INTO `products` VALUES (61, 0, 1, 'EW1400-53H', 'wcit_ew1400-53h.jpg', 129.3617, '2010-05-25 21:00:00', '2010-06-04 13:08:57', NULL, 0.00, 1, 1, 12, 0, NULL, NULL);
INSERT INTO `products` VALUES (62, 0, 1, 'EW1520-51E', 'wcit_ew1520-51e.jpg', 108.0851, '2010-05-25 21:00:00', '2010-06-04 13:12:00', NULL, 1.00, 1, 1, 12, 0, NULL, NULL);
INSERT INTO `products` VALUES (63, 0, 1, 'EW3034-59A', 'wcit_ew3034-59a.jpg', 108.0851, '2010-05-25 21:00:00', '2010-06-04 13:14:17', NULL, 1.00, 1, 1, 12, 0, NULL, NULL);
INSERT INTO `products` VALUES (64, 0, 1, 'EW3152-95A', 'wcit_ew3152-95a.jpg', 72.3404, '2010-05-25 21:00:00', '2010-06-04 13:19:00', NULL, 1.00, 1, 1, 12, 0, NULL, NULL);
INSERT INTO `products` VALUES (65, 0, 1, 'EW8692-58A', 'wcit_ew8692-58a.jpg', 84.2553, '2010-05-25 21:00:00', '2010-12-02 15:38:12', NULL, 1.00, 1, 1, 12, 0, NULL, NULL);
INSERT INTO `products` VALUES (66, 0, 1, 'EW8694-52D', 'wcit_ew8694-52d.jpg', 93.6170, '2010-05-25 21:00:00', '2010-09-04 09:20:05', NULL, 1.00, 1, 1, 12, 0, NULL, NULL);
INSERT INTO `products` VALUES (67, 0, 1, 'EW9330-53A', 'wcit_ew9330-53a.jpg', 93.6170, '2010-05-25 21:00:00', '2010-09-04 09:17:38', NULL, 1.00, 1, 1, 12, 0, NULL, NULL);
INSERT INTO `products` VALUES (68, 0, 1, 'EW9682-56D', 'wcit_ew9682-56d.jpg', 108.0851, '2010-05-25 21:00:00', '2010-09-04 09:13:45', NULL, 1.00, 1, 1, 12, 0, NULL, NULL);
INSERT INTO `products` VALUES (69, 0, 1, 'EW9690-58E', 'wcit_ew9690-58e.jpg', 93.6170, '2010-05-25 21:00:00', '2010-09-04 09:15:12', NULL, 1.00, 1, 1, 12, 0, NULL, NULL);
INSERT INTO `products` VALUES (70, 0, 1, 'EW9700-56E', 'wcit_ew9700-56e.jpg', 101.2766, '2010-05-25 21:00:00', '2010-09-04 09:18:09', NULL, 1.00, 1, 1, 12, 0, NULL, NULL);
INSERT INTO `products` VALUES (71, 0, 1, 'EW9720-59E', 'wcit_ew9720-59e.jpg', 251.9149, '2010-05-25 21:00:00', '2010-12-27 16:08:20', NULL, 1.00, 1, 1, 12, 0, NULL, NULL);
INSERT INTO `products` VALUES (72, 0, 1, 'EW9734-54A', 'wcit_ew9734-54a.jpg', 267.2340, '2010-05-25 21:00:00', '2010-12-27 16:08:00', NULL, 1.00, 1, 1, 12, 0, NULL, NULL);
INSERT INTO `products` VALUES (73, 0, 1, 'EW9780-57E', 'wcit_ew9780-57e.jpg', 136.1702, '2010-05-25 21:00:00', '2010-10-14 16:51:50', NULL, 1.00, 1, 1, 12, 0, NULL, NULL);
INSERT INTO `products` VALUES (74, 0, 1, 'EW9810-58D', 'wcit_ew9810-58d.jpg', 114.8936, '2010-05-25 21:00:00', '2010-09-04 09:16:20', NULL, 1.00, 1, 1, 12, 0, NULL, NULL);
INSERT INTO `products` VALUES (75, 0, 1, 'EW9834-50A', 'wcit_ew9834-50a.jpg', 108.0851, '2010-05-25 21:00:00', '2010-09-04 09:20:54', NULL, 1.00, 1, 1, 12, 0, NULL, NULL);
INSERT INTO `products` VALUES (76, 0, 1, 'FB1020-52D', 'wcit_fb1020-52d.jpg', 208.5106, '2010-05-25 21:00:00', '2010-06-03 22:29:28', NULL, 0.00, 1, 1, 12, 0, NULL, NULL);
INSERT INTO `products` VALUES (77, 0, 1, 'GA1024-51A', 'wcit_ga1024-51a.jpg', 108.0851, '2010-05-25 21:00:00', '2010-06-03 22:20:54', NULL, 1.00, 1, 1, 12, 0, NULL, NULL);
INSERT INTO `products` VALUES (78, 0, 1, 'JY0000-53E', 'wcit_jy0000-53e.jpg', 288.5106, '2010-05-25 21:00:00', '2010-06-03 22:25:55', NULL, 0.00, 1, 1, 12, 0, NULL, NULL);
INSERT INTO `products` VALUES (79, 0, 1, 'JY0005-50E', 'wcit_jy0005-50e.jpg', 288.5106, '2010-05-25 21:00:00', '2010-07-26 16:35:12', NULL, 0.00, 0, 1, 12, 0, NULL, NULL);
INSERT INTO `products` VALUES (82, 0, 1, '3020', 'wsek_3020.jpg', 30.6298, '0000-00-00 00:00:00', '2010-06-08 12:39:22', NULL, 1.00, 1, 1, 14, 0, NULL, NULL);
INSERT INTO `products` VALUES (83, 0, 1, '3032', 'wsek_3032.jpg', 32.3319, '0000-00-00 00:00:00', '2010-06-08 12:38:57', NULL, 1.00, 1, 1, 14, 0, NULL, NULL);
INSERT INTO `products` VALUES (84, 0, 1, '3035', 'wsek_3035.jpg', 30.6298, '0000-00-00 00:00:00', '2010-06-08 12:39:49', NULL, 1.00, 1, 1, 14, 0, NULL, NULL);
INSERT INTO `products` VALUES (85, 0, 1, '3037', 'wsek_3037.jpg', 34.0340, '0000-00-00 00:00:00', '2010-06-08 12:38:15', NULL, 1.00, 1, 1, 14, 0, NULL, NULL);
INSERT INTO `products` VALUES (86, 0, 1, '3074', 'wsek_3074.jpg', 51.0553, '0000-00-00 00:00:00', '2010-06-08 12:57:49', NULL, 1.00, 1, 1, 14, 0, NULL, NULL);
INSERT INTO `products` VALUES (87, 0, 1, '3076', 'wsek_3076.jpg', 59.5660, '0000-00-00 00:00:00', '2010-06-08 13:02:05', NULL, 1.00, 1, 1, 14, 0, NULL, NULL);
INSERT INTO `products` VALUES (88, 0, 1, '3081', 'wsek_3081.jpg', 27.2255, '0000-00-00 00:00:00', '2010-10-29 16:13:27', NULL, 1.00, 0, 1, 14, 0, NULL, NULL);
INSERT INTO `products` VALUES (89, 0, 1, '3086', 'wsek_3086.jpg', 28.0766, '0000-00-00 00:00:00', '2010-12-20 16:02:02', NULL, 1.00, 0, 1, 14, 0, NULL, NULL);
INSERT INTO `products` VALUES (90, 0, 1, '3101', 'wsek_3101.jpg', 51.0553, '0000-00-00 00:00:00', '2010-06-08 13:12:20', NULL, 1.00, 1, 1, 14, 0, NULL, NULL);
INSERT INTO `products` VALUES (91, 0, 1, '3102', 'wsek_3102.jpg', 27.2255, '0000-00-00 00:00:00', '2010-06-08 13:16:24', NULL, 1.00, 1, 1, 14, 0, NULL, NULL);
INSERT INTO `products` VALUES (92, 0, 1, '3104', 'wsek_3104.jpg', 38.2894, '0000-00-00 00:00:00', '2010-06-08 14:27:58', NULL, 1.00, 1, 1, 14, 0, NULL, NULL);
INSERT INTO `products` VALUES (93, 0, 1, '3115', 'wsek_3115.jpg', 51.0553, '0000-00-00 00:00:00', '2010-06-08 13:26:48', NULL, 1.00, 1, 1, 14, 0, NULL, NULL);
INSERT INTO `products` VALUES (94, 0, 1, '3117', 'wsek_3117.jpg', 21.2681, '0000-00-00 00:00:00', '2010-06-08 14:02:57', NULL, 1.00, 1, 1, 14, 0, NULL, NULL);
INSERT INTO `products` VALUES (95, 0, 1, '3122', 'wsek_3122.jpg', 38.2894, '0000-00-00 00:00:00', '2010-06-08 14:10:58', NULL, 1.00, 1, 1, 14, 0, NULL, NULL);
INSERT INTO `products` VALUES (96, 0, 1, '3123', 'wsek_3123.jpg', 37.4383, '0000-00-00 00:00:00', '2010-12-06 14:14:26', NULL, 1.00, 0, 1, 14, 0, NULL, NULL);
INSERT INTO `products` VALUES (97, 0, 1, '3179', 'wsek_3179.jpg', 30.6298, '0000-00-00 00:00:00', '2010-06-08 14:27:16', NULL, 1.00, 1, 1, 14, 0, NULL, NULL);
INSERT INTO `products` VALUES (98, 0, 1, '3468', 'wsek_3468.jpg', 30.6298, '0000-00-00 00:00:00', '2010-06-08 14:26:54', NULL, 1.00, 1, 1, 14, 0, NULL, NULL);
INSERT INTO `products` VALUES (738, 0, 1, '3470', 'wsek_3470.jpg', 39.9915, '2010-12-01 14:59:41', '2010-12-01 15:00:07', NULL, 0.00, 1, 1, 14, 0, NULL, NULL);
INSERT INTO `products` VALUES (100, 0, 1, '3619', 'wsek_3619.jpg', 29.7787, '0000-00-00 00:00:00', '2010-06-08 14:26:35', NULL, 1.00, 1, 1, 14, 0, NULL, NULL);
INSERT INTO `products` VALUES (101, 0, 1, '3621', 'wsek_3621.jpg', 15.3106, '0000-00-00 00:00:00', '2010-12-01 09:11:41', NULL, 1.00, 1, 1, 14, 0, NULL, NULL);
INSERT INTO `products` VALUES (102, 0, 1, '3641', 'wsek_3641.jpg', 15.3106, '0000-00-00 00:00:00', '2010-06-08 14:57:38', NULL, 1.00, 1, 1, 14, 0, NULL, NULL);
INSERT INTO `products` VALUES (103, 0, 1, '3683', 'wsek_3683.jpg', 29.7787, '0000-00-00 00:00:00', '2010-06-08 14:36:48', NULL, 1.00, 1, 1, 14, 0, NULL, NULL);
INSERT INTO `products` VALUES (104, 0, 1, '3696', 'wsek_3696.jpg', 22.9702, '0000-00-00 00:00:00', '2010-06-08 14:39:44', NULL, 1.00, 1, 1, 14, 0, NULL, NULL);
INSERT INTO `products` VALUES (105, 0, 1, '3697', 'wsek_3697.jpg', 21.2681, '0000-00-00 00:00:00', '2010-06-08 14:42:41', NULL, 1.00, 1, 1, 14, 0, NULL, NULL);
INSERT INTO `products` VALUES (106, 0, 1, '3752', 'wsek_3752.jpg', 21.2681, '0000-00-00 00:00:00', '2010-07-21 11:16:16', NULL, 1.00, 1, 1, 14, 0, NULL, NULL);
INSERT INTO `products` VALUES (107, 0, 1, '3777', 'wsek_3777.jpg', 15.3106, '0000-00-00 00:00:00', '2010-08-03 16:17:28', NULL, 1.00, 1, 1, 14, 0, NULL, NULL);
INSERT INTO `products` VALUES (108, 0, 1, '3847', 'wsek_3847.jpg', 42.5447, '0000-00-00 00:00:00', '2010-12-07 16:59:58', NULL, 1.00, 0, 1, 14, 0, NULL, NULL);
INSERT INTO `products` VALUES (109, 0, 1, '3876', 'wsek_3876.jpg', 34.0340, '0000-00-00 00:00:00', '2010-06-08 14:53:13', NULL, 1.00, 1, 1, 14, 0, NULL, NULL);
INSERT INTO `products` VALUES (110, 0, 1, '3878', 'wsek_3878.jpg', 51.0553, '0000-00-00 00:00:00', '2010-07-24 12:43:41', NULL, 1.00, 0, 1, 14, 0, NULL, NULL);
INSERT INTO `products` VALUES (111, 0, 1, '3922', 'wsek_3922.jpg', 51.0553, '0000-00-00 00:00:00', '2010-08-03 16:15:24', NULL, 1.00, 1, 1, 14, 0, NULL, NULL);
INSERT INTO `products` VALUES (112, 0, 1, '3951', 'wsek_3951.jpg', 27.2255, '0000-00-00 00:00:00', '2010-06-08 15:00:30', NULL, 1.00, 1, 1, 14, 0, NULL, NULL);
INSERT INTO `products` VALUES (113, 0, 1, '3952', 'wsek_3952.jpg', 22.9702, '0000-00-00 00:00:00', '2010-08-26 16:59:15', NULL, 1.00, 1, 1, 14, 0, NULL, NULL);
INSERT INTO `products` VALUES (114, 0, 1, '3956', 'wsek_3956.jpg', 17.0128, '0000-00-00 00:00:00', '2010-06-08 15:04:19', NULL, 1.00, 1, 1, 14, 0, NULL, NULL);
INSERT INTO `products` VALUES (115, 0, 1, '4020', 'wsek_4020.jpg', 26.8085, '0000-00-00 00:00:00', '2010-08-26 17:00:59', NULL, 1.00, 1, 1, 14, 0, NULL, NULL);
INSERT INTO `products` VALUES (116, 0, 1, '4054', 'wsek_4054.jpg', 22.9787, '0000-00-00 00:00:00', '2010-06-04 16:12:13', NULL, 0.00, 1, 1, 14, 0, NULL, NULL);
INSERT INTO `products` VALUES (117, 0, 1, '4058', 'wsek_4058.jpg', 29.7787, '0000-00-00 00:00:00', '2010-06-08 15:26:52', NULL, 1.00, 1, 1, 14, 0, NULL, NULL);
INSERT INTO `products` VALUES (118, 0, 1, '4063', 'wsek_4063.jpg', 39.1404, '0000-00-00 00:00:00', '2010-12-01 10:18:52', NULL, 1.00, 1, 1, 14, 0, NULL, NULL);
INSERT INTO `products` VALUES (119, 0, 1, '4073', 'wsek_4073.jpg', 15.3106, '0000-00-00 00:00:00', '2010-12-01 09:17:10', NULL, 1.00, 1, 1, 14, 0, NULL, NULL);
INSERT INTO `products` VALUES (120, 0, 1, '4103', 'wsek_4103.jpg', 22.9702, '0000-00-00 00:00:00', '2010-06-08 15:41:24', NULL, 1.00, 1, 1, 14, 0, NULL, NULL);
INSERT INTO `products` VALUES (122, 0, 1, '4113', 'wsek_4113.jpg', 34.0340, '0000-00-00 00:00:00', '2010-06-08 15:47:43', NULL, 1.00, 1, 1, 14, 0, NULL, NULL);
INSERT INTO `products` VALUES (123, 0, 1, '4119', 'wsek_4119.jpg', 31.4809, '0000-00-00 00:00:00', '2010-12-11 10:32:00', NULL, 1.00, 1, 1, 14, 0, NULL, NULL);
INSERT INTO `products` VALUES (124, 0, 1, '4174', 'wsek_4174.jpg', 36.5872, '0000-00-00 00:00:00', '2010-06-08 15:53:57', NULL, 1.00, 1, 1, 14, 0, NULL, NULL);
INSERT INTO `products` VALUES (125, 0, 1, '4191', 'wsek_4191.jpg', 31.4809, '0000-00-00 00:00:00', '2010-12-01 09:28:08', NULL, 1.00, 1, 1, 14, 0, NULL, NULL);
INSERT INTO `products` VALUES (126, 0, 1, '4218', 'wsek_4218.jpg', 21.2681, '0000-00-00 00:00:00', '2010-06-08 16:55:10', NULL, 1.00, 1, 1, 14, 0, NULL, NULL);
INSERT INTO `products` VALUES (127, 0, 1, '4230', 'wsek_4230.jpg', 30.6298, '0000-00-00 00:00:00', '2010-06-08 16:27:25', NULL, 1.00, 1, 1, 14, 0, NULL, NULL);
INSERT INTO `products` VALUES (128, 0, 1, '4245', 'wsek_4245.jpg', 38.2894, '0000-00-00 00:00:00', '2010-06-08 16:30:07', NULL, 1.00, 1, 1, 14, 0, NULL, NULL);
INSERT INTO `products` VALUES (129, 0, 1, '4246', 'wsek_4246.jpg', 23.8213, '0000-00-00 00:00:00', '2010-12-22 13:35:15', NULL, 1.00, 0, 1, 14, 0, NULL, NULL);
INSERT INTO `products` VALUES (130, 0, 1, '4258', 'wsek_4258.jpg', 29.7787, '0000-00-00 00:00:00', '2010-06-08 16:40:26', NULL, 1.00, 1, 1, 14, 0, NULL, NULL);
INSERT INTO `products` VALUES (131, 0, 1, '4260', 'wsek_4260.jpg', 31.4809, '0000-00-00 00:00:00', '2010-12-01 09:21:39', NULL, 1.00, 1, 1, 14, 0, NULL, NULL);
INSERT INTO `products` VALUES (132, 0, 1, '4261', 'wsek_4261.jpg', 34.0340, '0000-00-00 00:00:00', '2010-12-01 09:14:37', NULL, 1.00, 1, 1, 14, 0, NULL, NULL);
INSERT INTO `products` VALUES (133, 0, 1, '4263', 'wsek_4263.jpg', 34.0340, '0000-00-00 00:00:00', '2010-06-08 16:45:47', NULL, 1.00, 1, 1, 14, 0, NULL, NULL);
INSERT INTO `products` VALUES (134, 0, 1, '4267', 'wsek_4267.jpg', 34.0340, '0000-00-00 00:00:00', '2010-06-08 16:47:59', NULL, 1.00, 1, 1, 14, 0, NULL, NULL);
INSERT INTO `products` VALUES (135, 0, 1, '4491', 'wsek_4491.jpg', 15.3106, '0000-00-00 00:00:00', '2010-12-01 09:20:36', NULL, 1.00, 1, 1, 14, 0, NULL, NULL);
INSERT INTO `products` VALUES (136, 0, 2, '4492', 'wsek_4492.jpg', 22.1191, '0000-00-00 00:00:00', '2010-12-01 09:56:30', NULL, 1.00, 1, 1, 14, 0, NULL, NULL);
INSERT INTO `products` VALUES (137, 0, 1, '4562', 'wsek_4562.jpg', 22.9702, '0000-00-00 00:00:00', '2010-09-26 11:18:17', NULL, 1.00, 1, 1, 14, 0, NULL, NULL);
INSERT INTO `products` VALUES (138, 0, 1, '4587', 'wsek_4587.jpg', 19.5660, '0000-00-00 00:00:00', '2010-12-01 09:30:23', NULL, 1.00, 1, 1, 14, 0, NULL, NULL);
INSERT INTO `products` VALUES (139, 0, 2, '4601', 'wsek_4601.jpg', 17.8638, '0000-00-00 00:00:00', '2010-12-01 09:26:20', NULL, 1.00, 1, 1, 14, 0, NULL, NULL);
INSERT INTO `products` VALUES (140, 0, 2, '4602', 'wsek_4602.jpg', 22.1191, '0000-00-00 00:00:00', '2010-12-01 09:32:33', NULL, 1.00, 1, 1, 14, 0, NULL, NULL);
INSERT INTO `products` VALUES (141, 0, 1, '4677', 'wsek_4677.jpg', 22.1191, '0000-00-00 00:00:00', '2010-12-13 13:49:48', NULL, 1.00, 1, 1, 14, 0, NULL, NULL);
INSERT INTO `products` VALUES (142, 0, 1, '4683', 'wsek_4683.jpg', 29.7787, '0000-00-00 00:00:00', '2010-06-08 18:33:22', NULL, 1.00, 1, 1, 14, 0, NULL, NULL);
INSERT INTO `products` VALUES (143, 0, 1, '4787', 'wsek_4787.jpg', 25.5234, '0000-00-00 00:00:00', '2010-06-08 18:36:38', NULL, 0.00, 1, 1, 14, 0, NULL, NULL);
INSERT INTO `products` VALUES (144, 0, 1, '4844', 'wsek_4844.jpg', 29.7787, '0000-00-00 00:00:00', '2010-06-08 18:40:07', NULL, 1.00, 1, 1, 14, 0, NULL, NULL);
INSERT INTO `products` VALUES (145, 0, 1, '4849', 'wsek_4849.jpg', 28.9277, '0000-00-00 00:00:00', '2010-06-08 18:42:03', NULL, 1.00, 1, 1, 14, 0, NULL, NULL);
INSERT INTO `products` VALUES (146, 0, 1, '4874', 'wsek_4874.jpg', 22.1191, '0000-00-00 00:00:00', '2010-06-08 18:45:41', NULL, 1.00, 1, 1, 14, 0, NULL, NULL);
INSERT INTO `products` VALUES (147, 0, 1, '4918', 'wsek_4918.jpg', 30.6298, '0000-00-00 00:00:00', '2010-06-08 18:47:43', NULL, 1.00, 1, 1, 14, 0, NULL, NULL);
INSERT INTO `products` VALUES (148, 0, 1, '4934', 'wsek_4934.jpg', 23.8213, '0000-00-00 00:00:00', '2010-12-01 09:53:49', NULL, 0.00, 1, 1, 14, 0, NULL, NULL);
INSERT INTO `products` VALUES (727, 0, 2, 'XGBB4', 'gecu_xgbb4 copy.jpg', 16.1702, '2010-11-19 11:02:25', '2010-11-19 11:35:04', NULL, 0.00, 1, 1, 28, 0, NULL, NULL);
INSERT INTO `products` VALUES (150, 0, 1, '4942', 'wsek_4942.jpg', 23.8213, '0000-00-00 00:00:00', '2010-12-20 14:03:47', NULL, 1.00, 0, 1, 14, 0, NULL, NULL);
INSERT INTO `products` VALUES (151, 0, 1, '4971', 'wsek_4971.jpg', 19.5660, '0000-00-00 00:00:00', '2010-08-26 17:00:38', NULL, 1.00, 1, 1, 14, 0, NULL, NULL);
INSERT INTO `products` VALUES (153, 0, 1, '4074B', 'wsek_4074b.jpg', 18.7149, '0000-00-00 00:00:00', '2010-06-11 17:05:28', NULL, 1.00, 1, 1, 14, 0, NULL, NULL);
INSERT INTO `products` VALUES (154, 0, 1, '4159', 'wsey_4159.jpg', 53.6085, '0000-00-00 00:00:00', '2010-06-09 10:18:03', NULL, 1.00, 1, 1, 14, 0, NULL, NULL);
INSERT INTO `products` VALUES (155, 0, 1, '4199', 'wsey_4199.jpg', 53.6085, '0000-00-00 00:00:00', '2010-12-24 17:13:32', NULL, 1.00, 0, 1, 14, -1, NULL, NULL);
INSERT INTO `products` VALUES (156, 0, 1, '4272', 'wsey_4272.jpg', 53.6085, '0000-00-00 00:00:00', '2010-12-11 10:44:40', NULL, 1.00, 0, 1, 14, 1, NULL, NULL);
INSERT INTO `products` VALUES (157, 0, 1, '4275', 'wsey_4275.jpg', 53.6085, '0000-00-00 00:00:00', '2010-06-09 11:02:23', NULL, 1.00, 1, 1, 14, 0, NULL, NULL);
INSERT INTO `products` VALUES (158, 0, 1, '4276', 'wsey_4276.jpg', 53.6085, '0000-00-00 00:00:00', '2010-08-26 15:36:21', NULL, 1.00, 0, 1, 14, 0, NULL, NULL);
INSERT INTO `products` VALUES (159, 0, 1, '4281', 'wsey_4281.jpg', 53.6085, '0000-00-00 00:00:00', '2010-12-22 14:54:29', NULL, 1.00, 0, 1, 14, 0, NULL, NULL);
INSERT INTO `products` VALUES (160, 0, 1, '4287', 'wsey_4287.jpg', 53.6085, '0000-00-00 00:00:00', '2010-06-09 11:33:22', NULL, 1.00, 1, 1, 14, 0, NULL, NULL);
INSERT INTO `products` VALUES (161, 0, 1, '4773', 'wsey_4773.jpg', 38.2894, '0000-00-00 00:00:00', '2010-12-21 09:01:37', NULL, 1.00, 0, 1, 14, 0, NULL, NULL);
INSERT INTO `products` VALUES (162, 0, 1, 'B2842', 'jgdd_b2842.jpg', 23.8298, '2010-06-08 23:00:00', '2010-10-17 19:33:26', NULL, 0.00, 1, 1, 16, 0, NULL, NULL);
INSERT INTO `products` VALUES (163, 0, 1, '', 'jgdd_b307.jpg', 34.0000, '2010-06-08 23:00:00', '2010-10-17 19:32:25', NULL, 1.00, 1, 1, 16, 0, NULL, NULL);
INSERT INTO `products` VALUES (164, 0, 1, 'B3095', 'jgdd_b3095.jpg', 23.8298, '2010-06-08 23:00:00', '2010-10-17 19:33:13', NULL, 0.00, 1, 1, 16, 0, NULL, NULL);
INSERT INTO `products` VALUES (165, 0, 1, 'B3561', 'jgdd_b3561.jpg', 30.6383, '2010-06-08 23:00:00', '2010-10-17 19:33:59', NULL, 0.00, 1, 1, 16, 0, NULL, NULL);
INSERT INTO `products` VALUES (166, 0, 1, 'B772', 'jgdd_b772.jpg', 34.0000, '2010-06-08 23:00:00', '2010-10-17 19:32:49', NULL, 0.00, 1, 1, 16, 0, NULL, NULL);
INSERT INTO `products` VALUES (167, 0, 0, 'B773', 'jgdd_b773.jpg', 34.0000, '2010-06-08 23:00:00', '2010-10-17 19:32:36', NULL, 1.00, 1, 1, 16, 1, NULL, NULL);
INSERT INTO `products` VALUES (168, 0, 1, 'P2157', 'jgdd_p2157.jpg', 25.5319, '2010-06-08 23:00:00', '2010-12-15 13:14:09', NULL, 0.00, 1, 1, 16, 0, NULL, NULL);
INSERT INTO `products` VALUES (169, 0, 3, 'P2486', 'jgdd_p2486.jpg', 17.0213, '2010-06-08 23:00:00', '2010-12-15 13:17:42', NULL, 0.00, 1, 1, 16, 0, NULL, NULL);
INSERT INTO `products` VALUES (170, 0, 1, 'P2548', 'jgdd_p2548.jpg', 28.0426, '2010-06-08 23:00:00', '2010-12-15 13:03:51', NULL, 0.00, 1, 1, 16, 0, NULL, NULL);
INSERT INTO `products` VALUES (171, 0, 1, 'P2549', 'jgdd_p2549.jpg', 21.2340, '2010-06-08 23:00:00', '2010-12-15 13:01:46', NULL, 0.00, 1, 1, 16, 0, NULL, NULL);
INSERT INTO `products` VALUES (172, 0, 1, 'P2966', 'jgdd_p2966.jpg', 23.8298, '2010-06-08 23:00:00', '2010-12-15 13:16:01', NULL, 0.00, 1, 1, 16, 0, NULL, NULL);
INSERT INTO `products` VALUES (173, 547, 3, 'P616', 'jgdd_p616.jpg', 16.1702, '2010-06-08 23:00:00', '2010-12-15 13:31:47', NULL, 0.00, 1, 1, 16, 0, NULL, NULL);
INSERT INTO `products` VALUES (174, 546, 2, 'P620', 'jgdd_p620.jpg', 16.1702, '2010-06-08 23:00:00', '2010-12-15 13:33:55', NULL, 0.00, 1, 1, 16, 1, NULL, NULL);
INSERT INTO `products` VALUES (175, 0, 1, 'P800', 'jgdd_p800.jpg', 18.7234, '2010-06-08 23:00:00', '2010-12-15 13:36:24', NULL, 0.00, 1, 1, 16, 0, NULL, NULL);
INSERT INTO `products` VALUES (176, 0, 1, 'MB323S', 'wacc_mb323s.jpg', 79.1489, '2010-06-10 20:00:00', '2010-06-11 13:51:33', NULL, 0.00, 1, 1, 13, 0, 'Gents', 110);
INSERT INTO `products` VALUES (177, 0, 1, 'MB754B', 'wacc_mb754b.jpg', 93.6170, '2010-06-10 20:00:00', '2010-06-11 14:27:07', NULL, 0.00, 1, 1, 13, 0, 'Gents', 125);
INSERT INTO `products` VALUES (178, 0, 1, 'MB754N', 'wacc_mb754n.jpg', 93.6170, '2010-06-10 20:00:00', '2010-06-11 14:26:36', NULL, 0.00, 1, 1, 13, 0, 'Gents', 125);
INSERT INTO `products` VALUES (179, 0, 1, 'MB761N', 'wacc_mb761n.jpg', 59.5745, '2010-06-10 20:00:00', '2010-06-11 14:26:04', NULL, 0.00, 1, 1, 13, 0, 'Gents', 125);
INSERT INTO `products` VALUES (180, 0, 1, 'MB778N', 'wacc_mb778n.jpg', 44.2553, '2010-06-10 20:00:00', '2010-07-21 10:52:28', NULL, 0.00, 1, 1, 13, 0, 'Gents', 60);
INSERT INTO `products` VALUES (181, 0, 1, 'MB794B', 'wacc_mb794b.jpg', 36.5957, '2010-06-10 20:00:00', '2010-07-02 09:24:01', NULL, 0.00, 1, 1, 13, 1, 'Gents', 50);
INSERT INTO `products` VALUES (182, 0, 1, 'MB794S', 'wacc_mb794s.jpg', 36.5957, '2010-06-10 20:00:00', '2010-06-11 15:05:33', NULL, 0.00, 1, 1, 13, 0, 'Gents', 50);
INSERT INTO `products` VALUES (183, 0, 1, 'MB798GR', 'wacc_mb798gr.jpg', 36.5957, '2010-06-10 20:00:00', '2010-06-11 15:23:59', NULL, 0.00, 1, 1, 13, 0, 'Gents', 50);
INSERT INTO `products` VALUES (184, 0, 1, 'MB819B', 'wacc_mb819b.jpg', 108.0851, '2010-06-10 20:00:00', '2010-06-11 15:28:32', NULL, 0.00, 1, 1, 13, 0, 'Gents', 150);
INSERT INTO `products` VALUES (185, 0, 2, 'MB825BN', 'wacc_mb825bn.jpg', 83.4043, '2010-06-10 20:00:00', '2010-08-19 12:14:00', NULL, 0.00, 1, 1, 13, 0, 'Gents', 100);
INSERT INTO `products` VALUES (186, 0, 1, 'MB851B', 'wacc_mb851b.jpg', 59.5745, '2010-06-10 20:00:00', '2010-10-30 15:33:26', NULL, 0.00, 0, 1, 13, 0, 'Gents', 125);
INSERT INTO `products` VALUES (187, 0, 1, '', 'wacc_mb851n.jpg', 59.5745, '2010-06-10 20:00:00', '2010-07-02 09:26:28', NULL, 0.00, 1, 1, 13, 0, 'Gents', 125);
INSERT INTO `products` VALUES (188, 0, 1, 'MB860N', 'wacc_mb860n.jpg', 37.4468, '2010-06-10 20:00:00', '2010-10-01 16:35:04', NULL, 0.00, 0, 1, 13, 0, 'Gents', 50);
INSERT INTO `products` VALUES (189, 0, 2, 'MB860S', 'wacc_mb860s-copy.jpg', 37.4468, '2010-06-10 20:00:00', '2010-08-19 12:09:50', NULL, 0.00, 1, 1, 13, 0, 'Gents', 50);
INSERT INTO `products` VALUES (190, 0, 1, 'MB888S', 'wacc_mb888s-copy.jpg', 44.2553, '2010-06-10 20:00:00', '2010-06-11 17:00:49', NULL, 0.00, 1, 1, 13, 0, 'Gents', 60);
INSERT INTO `products` VALUES (191, 0, 1, 'MB889S', 'wacc_mb889s.jpg', 38.2979, '2010-06-10 20:00:00', '2010-10-14 16:48:08', NULL, 0.00, 1, 1, 13, 0, 'Gents', 50);
INSERT INTO `products` VALUES (192, 0, 1, 'MS547S', 'wacc_ms547s.jpg', 30.6383, '2010-06-10 20:00:00', '2010-09-23 15:43:08', NULL, 0.00, 1, 1, 13, 0, 'Gents', 40);
INSERT INTO `products` VALUES (193, 0, 1, 'MS595B', 'wacc_ms595b.jpg', 30.6383, '2010-06-10 20:00:00', '2010-06-12 15:54:17', NULL, 0.00, 1, 1, 13, 0, 'Gents', 40);
INSERT INTO `products` VALUES (194, 0, 1, 'MS595S', 'wacc_ms595s.jpg', 30.6383, '2010-06-10 20:00:00', '2010-06-12 15:54:10', NULL, 0.00, 1, 1, 13, 0, 'Gents', 40);
INSERT INTO `products` VALUES (195, 0, 1, 'MS606WA', 'wacc_ms606wa.jpg', 25.5319, '2010-06-10 20:00:00', '2010-06-12 15:53:33', NULL, 0.00, 1, 1, 13, 0, 'Gents', 35);
INSERT INTO `products` VALUES (196, 0, 1, 'MS730S', 'wacc_ms730s.jpg', 33.1915, '2010-06-10 20:00:00', '2010-09-23 12:16:36', NULL, 0.00, 1, 1, 13, 0, 'Gents', 45);
INSERT INTO `products` VALUES (197, 0, 1, 'LB1004W', 'wacc_lb1004w-copy.jpg', 33.1915, '2010-06-10 20:00:00', '2010-06-11 09:18:43', NULL, 0.00, 1, 1, 13, 0, 'Ladies', 45);
INSERT INTO `products` VALUES (198, 0, 1, 'LB1124DIA', 'wacc_lb1124dia.jpg', 44.2553, '2010-06-10 20:00:00', '2010-06-15 15:17:10', NULL, 0.00, 1, 1, 13, 0, 'Ladies', 50);
INSERT INTO `products` VALUES (199, 0, 1, 'LB1127G', 'wacc_lb1127g.jpg', 30.6383, '2010-06-10 20:00:00', '2010-06-11 09:55:23', NULL, 0.00, 0, 1, 13, 0, 'Ladies', 40);
INSERT INTO `products` VALUES (200, 0, 1, 'LB1129W', 'wacc_lb1129w.jpg', 29.7872, '2010-06-10 20:00:00', '2010-06-11 09:59:46', NULL, 0.00, 0, 1, 13, 0, 'Ladies', 40);
INSERT INTO `products` VALUES (201, 0, 0, 'LB1198', 'wacc_lb1198-copy.jpg', 54.4681, '2010-06-10 20:00:00', '2010-11-28 18:20:48', NULL, 1.00, 0, 1, 13, 1, 'Ladies', 75);
INSERT INTO `products` VALUES (202, 0, 1, 'LB1280', 'wacc_lb1280.jpg', 47.6596, '2010-06-10 20:00:00', '2010-06-11 10:17:37', NULL, 0.00, 1, 1, 13, 0, 'Ladies', 65);
INSERT INTO `products` VALUES (203, 0, 1, 'LB1282', 'wacc_lb1282.jpg', 47.6596, '2010-06-10 20:00:00', '2010-06-11 10:23:24', NULL, 1.00, 1, 1, 13, 0, 'Ladies', 65);
INSERT INTO `products` VALUES (204, 0, 1, 'LB1284S', 'wacc_lb1284s.jpg', 44.2553, '2010-06-10 20:00:00', '2010-06-11 10:30:14', NULL, 1.00, 1, 1, 13, 0, 'Ladies', 60);
INSERT INTO `products` VALUES (205, 0, 1, 'LB1285S', 'wacc_lb1285s.jpg', 36.5957, '2010-06-10 20:00:00', '2010-06-11 10:34:26', NULL, 1.00, 1, 1, 13, 0, 'Ladies', 50);
INSERT INTO `products` VALUES (206, 0, 1, 'LB1286P', 'wacc_lb1286p.jpg', 44.2553, '2010-06-10 20:00:00', '2010-06-11 10:47:03', NULL, 1.00, 1, 1, 13, 0, 'Ladies', 60);
INSERT INTO `products` VALUES (207, 0, 1, '', 'wacc_lb1292.jpg', 45.1064, '2010-06-10 20:00:00', '2010-07-02 09:27:41', NULL, 0.00, 1, 1, 13, 0, 'Ladies', 60);
INSERT INTO `products` VALUES (208, 0, 1, 'LB1294W', 'wacc_lb1294w.jpg', 40.8511, '2010-06-10 20:00:00', '2010-06-15 15:22:23', NULL, 1.00, 1, 1, 13, 0, 'Ladies', 60);
INSERT INTO `products` VALUES (209, 0, 1, 'LB1297B', 'wacc_lb1297b.jpg', 55.3191, '2010-06-10 20:00:00', '2010-11-06 11:11:23', NULL, 1.00, 0, 1, 13, 0, 'Ladies', 75);
INSERT INTO `products` VALUES (210, 0, 1, 'LB1303BR', 'wacc_lb1303br.jpg', 44.2553, '2010-06-10 20:00:00', '2010-06-11 11:46:41', NULL, 1.00, 1, 1, 13, 0, 'Ladies', 60);
INSERT INTO `products` VALUES (211, 0, 1, 'LB1303S', 'wacc_lb1303s.jpg', 44.2553, '2010-06-10 20:00:00', '2010-06-11 11:50:21', NULL, 1.00, 1, 1, 13, 0, 'Ladies', 60);
INSERT INTO `products` VALUES (212, 0, 1, 'LB1317', 'wacc_lb1317.jpg', 67.2340, '2010-06-10 20:00:00', '2010-06-11 11:55:42', NULL, 1.00, 1, 1, 13, 0, 'Ladies', 90);
INSERT INTO `products` VALUES (213, 0, 1, 'LB1325I', 'wacc_lb1325i.jpg', 44.2553, '2010-06-10 20:00:00', '2010-06-11 12:14:44', NULL, 0.00, 1, 1, 13, 0, 'Ladies', 60);
INSERT INTO `products` VALUES (214, 0, 1, 'LB1327B', 'wacc_lb1327b-copy.jpg', 44.2553, '2010-06-10 20:00:00', '2010-06-11 12:21:29', NULL, 0.00, 1, 1, 13, 0, 'Ladies', 60);
INSERT INTO `products` VALUES (215, 0, 1, 'LB1738P', 'wacc_lb1738p.jpg', 42.5532, '2010-06-10 20:00:00', '2010-06-11 12:28:30', NULL, 0.00, 1, 1, 13, 0, 'Ladies', 75);
INSERT INTO `products` VALUES (216, 0, 1, 'LB1739P', 'wacc_lb1739p.jpg', 42.5532, '2010-06-10 20:00:00', '2010-06-11 12:37:13', NULL, 0.00, 1, 1, 13, 0, 'Ladies', 75);
INSERT INTO `products` VALUES (217, 0, 0, 'LS164W', 'wacc_ls164w.jpg', 55.3191, '2010-06-10 20:00:00', '2010-06-12 15:57:09', NULL, 0.00, 1, 1, 13, 1, 'Ladies', 75);
INSERT INTO `products` VALUES (218, 0, 1, 'LS583WA', 'wacc_ls583wa.jpg', 25.5319, '2010-06-10 20:00:00', '2010-06-11 12:58:01', NULL, 0.00, 1, 1, 13, 0, 'Ladies', 35);
INSERT INTO `products` VALUES (219, 0, -1, 'LS632', 'wacc_ls632.jpg', 22.9787, '2010-06-10 20:00:00', '2010-06-12 15:54:43', NULL, 0.00, 1, 1, 13, 2, 'Ladies', 30);
INSERT INTO `products` VALUES (220, 499, 3, 'E3064B', 'jges_e3064b.jpg', 8.5106, '2010-06-12 15:00:00', '2010-10-20 19:30:13', NULL, 0.00, 1, 1, 16, 0, 'Earrings', NULL);
INSERT INTO `products` VALUES (221, 500, 3, 'E3662H', 'jges_e3662h.jpg', 8.5106, '2010-06-12 15:00:00', '2010-10-20 19:30:49', NULL, 0.00, 1, 1, 16, 0, 'Earrings', NULL);
INSERT INTO `products` VALUES (222, 500, 1, 'P3082H', 'jges_p3082h.jpg', 13.6170, '2010-06-12 15:00:00', '2010-10-17 18:29:03', NULL, 0.00, 1, 1, 16, 0, 'Pendant', NULL);
INSERT INTO `products` VALUES (223, 501, 3, 'B2947W', 'jges_b2947w.jpg', 10.2128, '2010-06-12 15:00:00', '2010-10-20 12:39:18', NULL, 0.00, 1, 1, 16, 0, 'Bracelet', NULL);
INSERT INTO `products` VALUES (224, 501, 2, 'E3065W', 'jges_e3065w.jpg', 8.5106, '2010-06-12 15:00:00', '2010-10-20 19:30:30', NULL, 0.00, 1, 1, 16, 0, 'Earrings', NULL);
INSERT INTO `products` VALUES (225, 501, 1, 'N2507W', 'jges_n2507w.jpg', 15.3191, '2010-06-12 15:00:00', '2010-06-21 11:30:15', NULL, 0.00, 1, 1, 16, 0, 'Necklace', NULL);
INSERT INTO `products` VALUES (226, 502, 2, 'E3511C', 'jges_e3511c.jpg', 13.6170, '2010-06-12 15:00:00', '2010-12-20 09:30:07', NULL, 0.00, 1, 1, 16, 0, 'Earrings', NULL);
INSERT INTO `products` VALUES (227, 502, 1, 'P2975C', 'jges_p2975c.jpg', 15.3191, '2010-06-12 15:00:00', '2010-12-20 09:37:21', NULL, 0.00, 0, 1, 16, 0, 'Pendant', NULL);
INSERT INTO `products` VALUES (228, 503, 2, 'E3321C', 'jges_e3321c.jpg', 13.6170, '2010-06-12 15:00:00', '2010-11-02 15:31:56', NULL, 0.00, 1, 1, 16, 0, 'Earrings', NULL);
INSERT INTO `products` VALUES (229, 503, 2, 'P2794C', 'jges_p2794c.jpg', 11.9149, '2010-06-12 15:00:00', '2010-10-26 19:20:44', NULL, 0.00, 1, 1, 16, 0, 'Pendant', NULL);
INSERT INTO `products` VALUES (230, 504, 1, 'E3646C', 'jges_e3646c.jpg', 24.6809, '2010-06-12 15:00:00', '2010-10-20 19:34:33', NULL, 0.00, 1, 1, 16, 0, 'Earrings', NULL);
INSERT INTO `products` VALUES (231, 504, 1, 'P3067C', 'jges_p3067c.jpg', 23.8298, '2010-06-12 15:00:00', '2010-12-21 11:44:21', NULL, 0.00, 0, 1, 16, 0, 'Pendant', NULL);
INSERT INTO `products` VALUES (232, 505, 1, 'B3171C', 'jges_b3171c.jpg', 58.7234, '2010-06-12 15:00:00', '2010-12-22 14:03:16', NULL, 0.00, 0, 1, 16, 0, 'Bracelet', NULL);
INSERT INTO `products` VALUES (233, 505, 1, 'E3342C', 'jges_e3342c.jpg', 14.4681, '2010-06-12 15:00:00', '2010-10-20 18:39:50', NULL, 0.00, 1, 1, 16, 0, 'Earrings', NULL);
INSERT INTO `products` VALUES (234, 505, 1, 'P2810C', 'jges_p2810c.jpg', 15.3191, '2010-06-12 15:00:00', '2010-10-17 18:28:46', NULL, 0.00, 1, 1, 16, 0, 'Pendant', NULL);
INSERT INTO `products` VALUES (235, 506, 1, 'E3320C', 'jges_e3320c.jpg', 22.1277, '2010-06-12 15:00:00', '2010-11-02 15:25:59', NULL, 0.00, 1, 1, 16, 0, 'Earrings', NULL);
INSERT INTO `products` VALUES (728, 0, 2, 'XGBB5', 'gecu_xgbb5 copy.jpg', 18.7234, '2010-11-19 11:58:59', '2010-11-19 12:00:12', NULL, 0.00, 1, 1, 28, 0, NULL, NULL);
INSERT INTO `products` VALUES (237, 507, 1, 'B3454C', 'jges_b3454c.jpg', 36.5957, '2010-06-12 15:00:00', '2010-10-20 12:39:46', NULL, 0.00, 1, 1, 16, 1, 'Bracelet', NULL);
INSERT INTO `products` VALUES (238, 507, 1, 'E3614C', 'jges_e3614c.jpg', 23.8298, '2010-06-12 15:00:00', '2010-12-18 09:39:22', NULL, 0.00, 0, 1, 16, 0, 'Earrings', NULL);
INSERT INTO `products` VALUES (239, 507, 2, 'P3029C', 'jges_p3029c.jpg', 18.7234, '2010-06-12 15:00:00', '2010-10-17 18:31:31', NULL, 0.00, 1, 1, 16, 0, 'Pendant', NULL);
INSERT INTO `products` VALUES (240, 508, 1, 'B3456C', 'jges_b3456c.jpg', 58.7234, '2010-06-12 15:00:00', '2010-10-20 12:24:00', NULL, 0.00, 1, 1, 16, 0, 'Bracelet', NULL);
INSERT INTO `products` VALUES (241, 508, 1, 'E3615C', 'jges_e3615c.jpg', 17.0213, '2010-06-12 15:00:00', '2010-10-20 18:38:29', NULL, 0.00, 1, 1, 16, 0, 'Earrings', NULL);
INSERT INTO `products` VALUES (242, 508, 2, 'P3031C', 'jges_p3031c.jpg', 11.9149, '2010-06-12 15:00:00', '2010-12-20 10:03:09', NULL, 0.00, 1, 1, 16, 0, 'Pendant', NULL);
INSERT INTO `products` VALUES (243, 509, 1, 'B2954C', 'jges_b2954c.jpg', 0.0000, '2010-06-12 15:00:00', '2010-06-15 09:50:19', NULL, 0.00, 0, 1, 16, 0, 'Bracelet', NULL);
INSERT INTO `products` VALUES (244, 509, 1, 'E3057C', 'jges_e3057c.jpg', 10.2128, '2010-06-12 15:00:00', '2010-10-20 19:25:50', NULL, 0.00, 0, 1, 16, 0, 'Earrings', NULL);
INSERT INTO `products` VALUES (245, 509, 3, 'P2621C', 'jges_p2621c.jpg', 8.5106, '2010-06-12 15:00:00', '2010-10-17 18:27:14', NULL, 0.00, 1, 1, 16, 0, 'Pendant', NULL);
INSERT INTO `products` VALUES (246, 510, 3, 'E2321C', 'jges_e2321c.jpg', 17.0213, '2010-06-12 15:00:00', '2010-10-26 18:46:53', NULL, 0.00, 1, 1, 16, 0, 'Earrings', NULL);
INSERT INTO `products` VALUES (247, 510, 3, 'P2211C', 'jges_p2211c.jpg', 10.2128, '2010-06-12 15:00:00', '2010-10-17 18:25:25', NULL, 0.00, 1, 1, 16, 0, 'Pendant', NULL);
INSERT INTO `products` VALUES (248, 511, 1, 'E3033C', 'jges_e3033c.jpg', 17.0213, '2010-06-12 15:00:00', '2010-12-24 15:32:29', NULL, 0.00, 1, 1, 16, 0, 'Earrings', NULL);
INSERT INTO `products` VALUES (249, 511, 1, 'P2600C', 'jges_p2600c.jpg', 23.8298, '2010-06-12 15:00:00', '2010-11-25 10:34:24', NULL, 0.00, 1, 1, 16, 0, 'Pendant', NULL);
INSERT INTO `products` VALUES (250, 512, 1, 'B3093C', 'jges_b3093c.jpg', 39.1489, '2010-06-12 15:00:00', '2010-10-20 12:24:13', NULL, 0.00, 1, 1, 16, 0, 'Bracelet', NULL);
INSERT INTO `products` VALUES (251, 512, 2, 'E3665C', 'jges_e3665c.jpg', 14.4681, '2010-06-12 15:00:00', '2010-12-20 11:16:03', NULL, 0.00, 1, 1, 16, 1, 'Earrings', NULL);
INSERT INTO `products` VALUES (252, 512, 1, 'P3084C', 'jges_p3084c.jpg', 28.9362, '2010-06-12 15:00:00', '2010-10-17 18:32:26', NULL, 0.00, 1, 1, 16, 0, 'Pendant', NULL);
INSERT INTO `products` VALUES (253, 513, 2, 'E2295C', 'jges_e2295c.jpg', 11.0638, '2010-06-12 15:00:00', '2010-12-20 11:02:21', NULL, 0.00, 1, 1, 16, 0, 'Earrings', NULL);
INSERT INTO `products` VALUES (254, 513, 3, 'P2199C', 'jges_p2199c.jpg', 10.2128, '2010-06-12 15:00:00', '2010-12-20 10:08:59', NULL, 0.00, 1, 1, 16, 0, 'Pendant', NULL);
INSERT INTO `products` VALUES (255, 514, 1, 'E2165B', 'jges_e2165b.jpg', 8.5106, '2010-06-12 15:00:00', '2010-10-20 18:37:03', NULL, 0.00, 1, 1, 16, 0, 'Earrings', NULL);
INSERT INTO `products` VALUES (256, 515, 4, 'B3469T', 'jges_b3469t.jpg', 29.7872, '2010-06-12 15:00:00', '2010-10-19 09:42:48', NULL, 0.00, 1, 1, 16, 0, 'Bracelet', NULL);
INSERT INTO `products` VALUES (257, 515, 1, 'P3069T', 'jges_p3069t.jpg', 11.0638, '2010-06-12 15:00:00', '2010-11-30 11:36:19', NULL, 0.00, 1, 1, 16, 0, 'Pendant', NULL);
INSERT INTO `products` VALUES (258, 516, 0, '', 'jges_b3199l.jpg', 42.5532, '2010-06-12 15:00:00', '2010-06-15 11:30:14', NULL, 0.00, 0, 1, 16, 0, 'Bracelet', NULL);
INSERT INTO `products` VALUES (259, 516, 1, 'E3382L', 'jges_e3382l.jpg', 14.4681, '2010-06-12 15:00:00', '2010-10-20 18:37:19', NULL, 0.00, 1, 1, 16, 0, 'Earrings', NULL);
INSERT INTO `products` VALUES (261, 517, 1, 'E3057T', 'jges_e3057t.jpg', 14.4681, '2010-06-12 15:00:00', '2010-12-20 11:21:06', NULL, 0.00, 1, 1, 16, 0, 'Earrings', NULL);
INSERT INTO `products` VALUES (262, 517, 3, 'P2621T', 'jges_p2621t.jpg', 8.5106, '2010-06-12 15:00:00', '2010-10-17 18:23:55', NULL, 0.00, 1, 1, 16, 0, 'Pendant', NULL);
INSERT INTO `products` VALUES (263, 518, 3, 'E3643T', 'jges_e3643t.jpg', 17.0213, '2010-06-12 15:00:00', '2010-10-20 18:37:33', NULL, 0.00, 1, 1, 16, 0, 'Earrings', NULL);
INSERT INTO `products` VALUES (264, 518, 1, 'P3063T', 'jges_p3063t.jpg', 14.4681, '2010-06-12 15:00:00', '2010-10-17 18:25:06', NULL, 0.00, 1, 1, 16, 0, 'Pendant', NULL);
INSERT INTO `products` VALUES (265, 519, 1, 'E3608', 'jges_e3608.jpg', 21.2766, '2010-06-12 15:00:00', '2010-10-20 19:29:34', NULL, 0.00, 1, 1, 16, 0, 'Earrings', NULL);
INSERT INTO `products` VALUES (266, 519, 1, 'N2918', 'jges_n2918.jpg', 29.7872, '2010-06-12 15:00:00', '2010-10-20 12:20:04', NULL, 0.00, 1, 1, 16, 0, 'Necklace', NULL);
INSERT INTO `products` VALUES (267, 520, 0, 'E3525', 'jges_e3525.jpg', 15.3191, '2010-06-12 15:00:00', '2010-12-02 09:39:58', NULL, 0.00, 0, 1, 16, 1, 'Earrings', NULL);
INSERT INTO `products` VALUES (268, 520, 1, 'N2818', 'jges_n2818.jpg', 55.3191, '2010-06-12 15:00:00', '2010-10-20 12:20:51', NULL, 0.00, 1, 1, 16, 1, 'Necklace', NULL);
INSERT INTO `products` VALUES (269, 521, 1, 'B3466', 'jges_b3466.jpg', 27.2340, '2010-06-12 15:00:00', '2010-12-23 10:11:17', NULL, 0.00, 1, 1, 16, 0, 'Bracelet', NULL);
INSERT INTO `products` VALUES (270, 521, 2, 'E3635', 'jges_e3635.jpg', 12.7660, '2010-06-12 15:00:00', '2010-12-14 16:09:19', NULL, 0.00, 1, 1, 16, 0, 'Earrings', NULL);
INSERT INTO `products` VALUES (271, 521, 1, 'N2931', 'jges_n2931.jpg', 24.6809, '2010-06-12 15:00:00', '2010-12-18 12:47:09', NULL, 0.00, 1, 1, 16, 0, 'Necklace', NULL);
INSERT INTO `products` VALUES (272, 522, 1, 'E3627', 'jges_e3627.jpg', 28.0851, '2010-06-12 15:00:00', '2010-12-23 12:48:55', NULL, 0.00, 0, 1, 16, 0, 'Earrings', NULL);
INSERT INTO `products` VALUES (273, 522, 1, 'P3045', 'jges_p3045.jpg', 24.6809, '2010-06-12 15:00:00', '2010-10-17 18:27:36', NULL, 0.00, 1, 1, 16, 0, 'Pendant', NULL);
INSERT INTO `products` VALUES (274, 523, 1, 'E3531', 'jges_e3531.jpg', 18.7234, '2010-06-12 15:00:00', '2010-11-02 14:57:39', NULL, 0.00, 1, 1, 16, 0, 'Earrings', NULL);
INSERT INTO `products` VALUES (275, 523, 1, 'N2822', 'jges_n2822.jpg', 33.1915, '2010-06-12 15:00:00', '2010-06-21 11:25:49', NULL, 0.00, 0, 1, 16, 0, 'Necklace', NULL);
INSERT INTO `products` VALUES (276, 524, 1, 'E3613', 'jges_e3613.jpg', 18.7234, '2010-06-12 15:00:00', '2010-10-20 19:29:10', NULL, 0.00, 1, 1, 16, 0, 'Earrings', NULL);
INSERT INTO `products` VALUES (277, 524, 1, 'N2923', 'jges_n2923.jpg', 34.0426, '2010-06-12 15:00:00', '2010-10-20 12:22:56', NULL, 0.00, 1, 1, 16, 0, 'Necklace', NULL);
INSERT INTO `products` VALUES (278, 525, 1, 'E3624', 'jges_e3624.jpg', 29.7872, '2010-06-12 15:00:00', '2010-10-20 19:29:54', NULL, 0.00, 1, 1, 16, 0, 'Earrings', NULL);
INSERT INTO `products` VALUES (279, 525, 1, 'P3047', 'jges_p3047.jpg', 25.5319, '2010-06-12 15:00:00', '2010-12-11 14:50:22', NULL, 0.00, 0, 1, 16, 0, 'Pendant', NULL);
INSERT INTO `products` VALUES (280, 526, 4, 'E3337', 'jges_e3337.jpg', 18.7234, '2010-06-12 15:00:00', '2010-10-20 19:31:32', NULL, 0.00, 1, 1, 16, 0, 'Earrings', NULL);
INSERT INTO `products` VALUES (281, 526, 1, 'P2730', 'jges_p2730.jpg', 13.6170, '2010-06-12 15:00:00', '2010-10-17 18:33:27', NULL, 0.00, 1, 1, 16, 0, 'Pendant', NULL);
INSERT INTO `products` VALUES (282, 527, 3, 'B3086', 'jges_b3086.jpg', 35.7447, '2010-06-12 15:00:00', '2010-10-20 12:39:59', NULL, 0.00, 1, 1, 16, 0, 'Bracelet', NULL);
INSERT INTO `products` VALUES (283, 527, 1, 'E3263', 'jges_e3263.jpg', 17.0213, '2010-06-12 15:00:00', '2010-12-20 09:33:21', NULL, 0.00, 0, 1, 16, 0, 'Earrings', NULL);
INSERT INTO `products` VALUES (284, 527, 1, 'P2735', 'jges_p2735.jpg', 11.9149, '2010-06-12 15:00:00', '2010-12-20 09:32:06', NULL, 0.00, 0, 1, 16, 0, 'Pendant', NULL);
INSERT INTO `products` VALUES (285, 528, 1, 'B2943', 'jges_b2943.jpg', 46.8085, '2010-06-12 15:00:00', '2010-10-20 12:24:44', NULL, 0.00, 1, 1, 16, 0, 'Bracelet', NULL);
INSERT INTO `products` VALUES (286, 528, 2, 'E3032', 'jges_e3032.jpg', 12.7660, '2010-06-12 15:00:00', '2010-12-11 14:36:45', NULL, 0.00, 0, 1, 16, 0, 'Earrings', NULL);
INSERT INTO `products` VALUES (287, 528, 7, 'P2599', 'jges_p2599.jpg', 15.3191, '2010-06-12 15:00:00', '2010-12-11 14:37:19', NULL, 0.00, 0, 1, 16, 1, 'Pendant', NULL);
INSERT INTO `products` VALUES (288, 529, 3, 'E3639', 'jges_e3639.jpg', 12.7660, '2010-06-12 15:00:00', '2010-12-21 11:19:06', NULL, 0.00, 0, 1, 16, 0, 'Earrings', NULL);
INSERT INTO `products` VALUES (289, 529, 1, 'P3058', 'jges_p3058.jpg', 17.0213, '2010-06-12 15:00:00', '2010-12-21 11:46:21', NULL, 0.00, 0, 1, 16, 0, 'Pendant', NULL);
INSERT INTO `products` VALUES (290, 530, 1, '', 'jges_e3261.jpg', 11.9149, '2010-06-12 15:00:00', '2010-10-20 19:35:36', NULL, 0.00, 1, 1, 16, 0, 'Earrings', NULL);
INSERT INTO `products` VALUES (291, 530, 1, 'P2738', 'jges_p2738.jpg', 17.0213, '2010-06-12 15:00:00', '2010-10-17 18:34:19', NULL, 25.00, 1, 1, 16, 0, 'Pendant', NULL);
INSERT INTO `products` VALUES (292, 531, 2, 'E3535', 'jges_e3535.jpg', 22.1277, '2010-06-12 15:00:00', '2010-10-20 19:28:18', NULL, 0.00, 1, 1, 16, 0, 'Earrings', NULL);
INSERT INTO `products` VALUES (293, 531, 1, 'P2992', 'jges_p2992.jpg', 13.6170, '2010-06-12 15:00:00', '2010-10-17 18:30:33', NULL, 0.00, 1, 1, 16, 0, 'Pendant', NULL);
INSERT INTO `products` VALUES (294, 532, 4, 'E3279', 'jges_e3279.jpg', 20.4255, '2010-06-12 15:00:00', '2010-11-13 15:20:52', NULL, 0.00, 1, 1, 16, 0, 'Earrings', NULL);
INSERT INTO `products` VALUES (295, 532, 3, 'P2747', 'jges_p2747.jpg', 22.1277, '2010-06-12 15:00:00', '2010-11-19 13:16:05', NULL, 0.00, 1, 1, 16, 0, 'Pendant', NULL);
INSERT INTO `products` VALUES (296, 533, 2, 'E3345', 'jges_e3345.jpg', 12.7660, '2010-06-12 15:00:00', '2010-12-03 16:01:05', NULL, 0.00, 1, 1, 16, 2, 'Earrings', NULL);
INSERT INTO `products` VALUES (297, 533, 4, 'N2707', 'jges_n2707.jpg', 27.2340, '2010-06-12 15:00:00', '2010-11-18 13:43:52', NULL, 0.00, 1, 1, 16, 1, 'Necklace', NULL);
INSERT INTO `products` VALUES (298, 534, 1, 'E3333', 'jges_e3333.jpg', 19.5745, '2010-06-12 15:00:00', '2010-11-02 15:11:23', NULL, 0.00, 1, 1, 16, 0, 'Earrings', NULL);
INSERT INTO `products` VALUES (299, 534, 1, 'P2806', 'jges_p2806.jpg', 17.0213, '2010-06-12 15:00:00', '2010-12-24 15:28:18', NULL, 0.00, 1, 1, 16, 0, 'Pendant', NULL);
INSERT INTO `products` VALUES (300, 535, 3, 'E777', 'jges_e777.jpg', 11.9149, '2010-06-12 15:00:00', '2010-11-25 12:19:26', NULL, 0.00, 1, 1, 16, 0, 'Earrings', NULL);
INSERT INTO `products` VALUES (301, 535, 1, 'P701', 'jges_p701.jpg', 8.5106, '2010-06-12 15:00:00', '2010-10-17 18:27:48', NULL, 0.00, 1, 1, 16, 0, 'Pendant', NULL);
INSERT INTO `products` VALUES (302, 536, 1, 'B3167', 'jges_b3167.jpg', 47.6596, '2010-06-12 15:00:00', '2010-10-17 19:14:50', NULL, 0.00, 0, 1, 16, 0, 'Bracelet', NULL);
INSERT INTO `products` VALUES (303, 536, 3, 'E3334', 'jges_e3334.jpg', 15.3191, '2010-06-12 15:00:00', '2010-11-02 15:37:07', NULL, 0.00, 1, 1, 16, 0, 'Earrings', NULL);
INSERT INTO `products` VALUES (304, 536, 1, 'P2807', 'jges_p2807.jpg', 15.3191, '2010-06-12 15:00:00', '2010-10-17 18:31:46', NULL, 0.00, 1, 1, 16, 0, 'Pendant', NULL);
INSERT INTO `products` VALUES (305, 537, 6, 'E2928C', 'jges_e2928c.jpg', 8.5106, '2010-06-12 15:00:00', '2010-10-20 19:26:05', NULL, 0.00, 1, 1, 16, 0, 'Earrings', NULL);
INSERT INTO `products` VALUES (306, 537, 5, 'P2533C', 'jges_p2533c.jpg', 6.8085, '2010-06-12 15:00:00', '2010-10-17 18:32:42', NULL, 0.00, 1, 1, 16, 0, 'Pendant', NULL);
INSERT INTO `products` VALUES (730, 0, 1, 'P3224C', 'jges_p3224c.jpg', 24.6809, '2010-11-19 15:59:14', '2010-12-24 15:29:53', NULL, 0.00, 0, 1, 16, 0, NULL, NULL);
INSERT INTO `products` VALUES (308, 538, 1, 'B3168C', 'jges_b3168c.jpg', 0.0000, '2010-06-12 15:00:00', '2010-06-15 12:51:11', NULL, 0.00, 0, 1, 16, 0, 'Bracelet', NULL);
INSERT INTO `products` VALUES (310, 539, 3, 'B2958C', 'jges_b2958c.jpg', 45.1064, '2010-06-12 15:00:00', '2010-10-26 14:20:16', NULL, 0.00, 1, 1, 16, 0, 'Bracelet', NULL);
INSERT INTO `products` VALUES (311, 540, 1, 'B3453', 'jges_b3453.jpg', 38.2979, '2010-06-12 15:00:00', '2010-10-28 12:25:18', NULL, 0.00, 1, 1, 16, 0, 'Bracelet', NULL);
INSERT INTO `products` VALUES (312, 540, 1, 'N2924', 'jges_n2924.jpg', 41.7021, '2010-06-12 15:00:00', '2010-10-20 12:18:58', NULL, 0.00, 1, 1, 16, 0, 'Necklace', NULL);
INSERT INTO `products` VALUES (313, 541, 1, 'B3170', 'jges_b3170.jpg', 36.5957, '2010-06-12 15:00:00', '2010-10-20 12:23:38', NULL, 0.00, 1, 1, 16, 0, 'Bracelet', NULL);
INSERT INTO `products` VALUES (314, 542, 1, 'B731C', 'jges_b731c.jpg', 36.5957, '2010-06-12 15:00:00', '2010-10-20 12:40:48', NULL, 0.00, 1, 1, 16, 0, 'Bracelet', NULL);
INSERT INTO `products` VALUES (315, 543, 14, 'E188C', 'jges_e188c.jpg', 11.0638, '2010-06-12 15:00:00', '2010-12-17 14:53:46', NULL, 0.00, 1, 1, 16, 0, 'Earrings', NULL);
INSERT INTO `products` VALUES (316, 543, 3, 'P590C', 'jges_p590c.jpg', 6.8085, '2010-06-12 15:00:00', '2010-10-26 19:32:13', NULL, 0.00, 1, 1, 16, 0, 'Pendant', NULL);
INSERT INTO `products` VALUES (317, 544, 8, 'E544C', 'jges_e544c.jpg', 11.0638, '2010-06-12 15:00:00', '2010-12-10 11:18:11', NULL, 0.00, 1, 1, 16, 0, 'Earrings', NULL);
INSERT INTO `products` VALUES (318, 544, 12, 'P298C', 'jges_p298c.jpg', 6.8085, '2010-06-12 15:00:00', '2010-10-17 18:26:40', NULL, 0.00, 1, 1, 16, 1, 'Pendant', NULL);
INSERT INTO `products` VALUES (319, 545, 6, 'E792C', 'jges_e792c.jpg', 10.2128, '2010-06-12 15:00:00', '2010-10-26 18:36:09', NULL, 0.00, 1, 1, 16, 0, 'Earrings', NULL);
INSERT INTO `products` VALUES (320, 0, 1, 'B2903', 'jgfb_b2903.jpg', 25.4894, '2010-06-19 22:00:00', '2010-12-22 10:52:54', NULL, 0.00, 0, 1, 16, 0, 'Bangle', NULL);
INSERT INTO `products` VALUES (321, 0, 3, 'B2906', 'jgfb_b2906.jpg', 25.4894, '2010-06-19 22:00:00', '2010-10-17 20:06:35', NULL, 0.00, 1, 1, 16, 0, 'Bangle', NULL);
INSERT INTO `products` VALUES (322, 0, 1, 'B3130', 'jgfb_b3130.jpg', 0.0000, '2010-06-19 22:00:00', '2010-10-17 20:01:30', NULL, 0.00, 0, 1, 16, 0, 'Bangle', NULL);
INSERT INTO `products` VALUES (323, 0, 1, 'B3394', 'jgfb_b3394.jpg', 21.2340, '2010-06-19 22:00:00', '2010-10-17 20:05:17', NULL, 0.00, 1, 1, 16, 0, 'Bangle', NULL);
INSERT INTO `products` VALUES (324, 0, 1, 'B3398', 'jgfb_b3398.jpg', 25.4894, '2010-06-19 22:00:00', '2010-10-17 20:06:51', NULL, 0.00, 1, 1, 16, 0, 'Bangle', NULL);
INSERT INTO `products` VALUES (325, 0, 4, 'B3400', 'jgfb_b3400.jpg', 21.2340, '2010-06-19 22:00:00', '2010-10-28 15:13:11', NULL, 0.00, 1, 1, 16, 0, 'Bangle', NULL);
INSERT INTO `products` VALUES (326, 0, 1, 'B750', 'jgfb_b750.jpg', 63.8298, '2010-06-19 22:00:00', '2010-10-17 20:07:29', NULL, 0.00, 1, 1, 16, 0, 'Bangle', NULL);
INSERT INTO `products` VALUES (327, 0, 1, 'N2686', 'jgfb_n2686.jpg', 22.0851, '2010-06-19 22:00:00', '2010-10-17 20:13:35', NULL, 0.00, 1, 1, 16, 0, 'Necklace', NULL);
INSERT INTO `products` VALUES (328, 0, 1, 'N2875', 'jgfb_n2875.jpg', 19.5319, '2010-06-19 22:00:00', '2010-12-24 08:47:04', NULL, 0.00, 0, 1, 16, 0, 'Necklace', NULL);
INSERT INTO `products` VALUES (329, 0, 1, 'P1212', 'jgfb_p1212.jpg', 37.4043, '2010-06-19 22:00:00', '2010-10-17 20:14:33', NULL, 0.00, 1, 1, 16, 0, 'Pendant', NULL);
INSERT INTO `products` VALUES (330, 0, 1, 'P2542', 'jgfb_p2542.jpg', 18.6809, '2010-06-19 22:00:00', '2010-10-17 20:11:32', NULL, 0.00, 1, 1, 16, 1, 'Pendant', NULL);
INSERT INTO `products` VALUES (331, 0, 1, 'P2776', 'jgfb_p2776.jpg', 40.8085, '2010-06-19 22:00:00', '2010-10-17 20:11:06', NULL, 0.00, 1, 1, 16, 0, 'Pendant', NULL);
INSERT INTO `products` VALUES (332, 0, 1, 'P2777', 'jgfb_p2777.jpg', 59.5319, '2010-06-19 22:00:00', '2010-10-17 20:14:13', NULL, 0.00, 1, 1, 16, 0, 'Pendant', NULL);
INSERT INTO `products` VALUES (333, 0, 2, 'P3003', 'jgfb_p3003.jpg', 21.2340, '2010-06-19 22:00:00', '2010-10-17 20:11:53', NULL, 0.00, 1, 1, 16, 0, 'Pendant', NULL);
INSERT INTO `products` VALUES (334, 0, 1, 'P3004', 'jgfb_p3004.jpg', 30.5957, '2010-06-19 22:00:00', '2010-10-17 20:12:10', NULL, 0.00, 1, 1, 16, 0, 'Pendant', NULL);
INSERT INTO `products` VALUES (335, 0, 1, '', 'jgfb_v188.jpg', 36.5532, '2010-06-19 22:00:00', '2010-10-17 20:09:54', NULL, 0.00, 1, 1, 16, 0, 'Cufflinks', NULL);
INSERT INTO `products` VALUES (336, 0, 1, 'V282', 'jgfb_v282.jpg', 28.0426, '2010-06-19 22:00:00', '2010-10-17 20:08:02', NULL, 0.00, 1, 1, 16, 0, 'Cufflinks', NULL);
INSERT INTO `products` VALUES (337, 0, 12, 'V319', 'jgfb_v319.jpg', 14.4255, '2010-06-19 22:00:00', '2010-10-17 20:08:30', NULL, 0.00, 1, 1, 16, 1, 'Cufflinks', NULL);
INSERT INTO `products` VALUES (338, 0, 1, 'V374', 'jgfb_v374.jpg', 40.8085, '2010-06-19 22:00:00', '2010-10-17 20:10:20', NULL, 0.00, 1, 1, 16, 1, 'Cufflinks', NULL);
INSERT INTO `products` VALUES (339, 0, 1, 'V377', 'jgfb_v377.jpg', 21.2340, '2010-06-19 22:00:00', '2010-10-17 20:09:06', NULL, 0.00, 1, 1, 16, 1, 'Cufflinks', NULL);
INSERT INTO `products` VALUES (340, 0, 1, 'V380', 'jgfb_v380.jpg', 18.6809, '2010-06-19 22:00:00', '2010-10-17 20:08:51', NULL, 0.00, 1, 1, 16, 0, 'Cufflinks', NULL);
INSERT INTO `products` VALUES (341, 0, 1, 'V383', 'jgfb_v383.jpg', 40.8085, '2010-06-19 22:00:00', '2010-10-17 20:09:26', NULL, 0.00, 1, 1, 16, 0, 'Cufflinks', NULL);
INSERT INTO `products` VALUES (342, 0, 1, 'V390', 'jgfb_v390.jpg', 42.5106, '2010-06-19 22:00:00', '2010-10-17 20:10:40', NULL, 0.00, 1, 1, 16, 0, 'Cufflinks', NULL);
INSERT INTO `products` VALUES (343, 0, 1, 'B3134', 'jgfb_b3134.jpg', 97.8723, '2010-06-19 22:00:00', '2010-10-20 19:37:27', NULL, 0.00, 1, 1, 16, 0, 'Bangle', NULL);
INSERT INTO `products` VALUES (344, 0, 1, 'B3393', 'jgfb_b3393.jpg', 28.0426, '2010-06-19 22:00:00', '2010-11-06 09:40:31', NULL, 0.00, 1, 1, 16, 0, 'Bangle', NULL);
INSERT INTO `products` VALUES (345, 0, 1, 'P2778', 'jgfb_p2778.jpg', 37.4043, '2010-06-19 22:00:00', '2010-10-17 20:14:54', NULL, 0.00, 1, 1, 16, 0, 'Pendant', NULL);
INSERT INTO `products` VALUES (346, 0, 1, 'P2858', 'jgfb_p2858.jpg', 28.8936, '2010-06-19 22:00:00', '2010-10-17 20:12:31', NULL, 0.00, 1, 1, 16, 0, 'Pendant', NULL);
INSERT INTO `products` VALUES (347, 0, 1, 'P3005', 'jgfb_p3005.jpg', 28.8936, '2010-06-19 22:00:00', '2010-10-17 20:13:18', NULL, 0.00, 1, 1, 16, 0, 'Pendant', NULL);
INSERT INTO `products` VALUES (348, 0, 1, 'P3008', 'jgfb_p3008.jpg', 54.4255, '2010-06-19 22:00:00', '2010-10-17 20:13:52', NULL, 0.00, 1, 1, 16, 0, 'Pendant', NULL);
INSERT INTO `products` VALUES (349, 0, 0, 'LB1526P', 'wacc_lb1526p.jpg', 0.0000, '2010-06-22 21:37:07', '2010-06-24 16:13:43', NULL, 0.00, 0, 1, 13, 0, NULL, NULL);
INSERT INTO `products` VALUES (350, 0, 1, 'LB1071', 'wacc_lb1071.jpg', 36.5957, '2010-06-22 21:40:12', '2010-11-12 10:57:36', NULL, 0.00, 0, 1, 13, 1, NULL, NULL);
INSERT INTO `products` VALUES (351, 0, 2, 'LB1196S', 'wacc_lb1196s.jpg', 51.0638, '2010-06-22 21:41:59', '2010-11-09 10:44:28', NULL, 0.00, 1, 1, 13, 1, NULL, NULL);
INSERT INTO `products` VALUES (352, 546, 3, 'E572', 'jgdd_e572.jpg', 17.8723, '2010-06-22 21:59:21', '2010-10-17 19:38:17', NULL, 0.00, 1, 1, 16, 1, NULL, NULL);
INSERT INTO `products` VALUES (353, 547, 1, 'E573', 'jgdd_e573.jpg', 17.8723, '2010-06-22 21:59:52', '2010-12-14 16:18:18', NULL, 0.00, 0, 1, 16, 0, NULL, NULL);
INSERT INTO `products` VALUES (354, 548, 1, '3211123', 'jfld_3211123.jpg', 22.1277, '2010-06-30 22:00:00', '2010-10-19 12:02:58', NULL, 0.00, 0, 1, 17, 1, 'Pendant', NULL);
INSERT INTO `products` VALUES (355, 548, 3, '3211263', 'jfld_3211263.jpg', 18.7234, '2010-06-30 22:00:00', '2010-10-17 19:50:02', NULL, 0.00, 1, 1, 17, 1, 'Earrings', NULL);
INSERT INTO `products` VALUES (356, 548, 1, '3212593', 'jfld_3212593.jpg', 28.0851, '2010-06-30 22:00:00', '2010-10-17 19:44:00', NULL, 0.00, 1, 1, 17, 0, 'Bracelet', NULL);
INSERT INTO `products` VALUES (357, 549, 1, '3211264', 'jfld_3211264.jpg', 18.7234, '2010-06-30 22:00:00', '2010-10-17 19:49:06', NULL, 0.00, 1, 1, 17, 0, 'Earrings', NULL);
INSERT INTO `products` VALUES (358, 549, 1, '3211270', 'jfld_3211270.jpg', 29.7872, '2010-06-30 22:00:00', '2010-10-17 19:54:18', NULL, 0.00, 1, 1, 17, 0, 'Pendant', NULL);
INSERT INTO `products` VALUES (359, 550, 2, '3211496', 'jfld_3211496.jpg', 18.7234, '2010-06-30 22:00:00', '2010-10-17 19:46:17', NULL, 0.00, 1, 1, 17, 0, 'Earrings', NULL);
INSERT INTO `products` VALUES (360, 550, 1, '3211895', 'jfld_3211895.jpg', 20.4255, '2010-06-30 22:00:00', '2010-10-17 19:43:13', NULL, 0.00, 1, 1, 17, 1, 'Bracelet', NULL);
INSERT INTO `products` VALUES (361, 550, 2, '3212592', 'jfld_3212592.jpg', 24.6809, '2010-06-30 22:00:00', '2010-10-17 19:53:21', NULL, 0.00, 1, 1, 17, 0, 'Pendant', NULL);
INSERT INTO `products` VALUES (362, 551, 1, '3211497', 'jfld_3211497.jpg', 14.4681, '2010-06-30 22:00:00', '2010-10-17 19:49:34', NULL, 0.00, 1, 1, 17, 0, 'Earrings', NULL);
INSERT INTO `products` VALUES (363, 551, 1, '3212590', 'jfld_3212590.jpg', 24.6809, '2010-06-30 22:00:00', '2010-10-17 19:54:44', NULL, 0.00, 1, 1, 17, 0, 'Pendant', NULL);
INSERT INTO `products` VALUES (364, 552, 2, '3211897', 'jfld_3211897.jpg', 22.1277, '2010-06-30 22:00:00', '2010-10-17 19:46:30', NULL, 0.00, 1, 1, 17, 0, 'Earrings', NULL);
INSERT INTO `products` VALUES (365, 552, 1, '3211910', 'jfld_3211910.jpg', 29.7872, '2010-06-30 22:00:00', '2010-10-17 19:52:13', NULL, 0.00, 0, 1, 17, 1, 'Pendant', NULL);
INSERT INTO `products` VALUES (366, 553, 2, '3211898', 'jfld_3211898.jpg', 20.4255, '2010-06-30 22:00:00', '2010-10-17 19:46:52', NULL, 0.00, 1, 1, 17, 0, 'Earrings', NULL);
INSERT INTO `products` VALUES (367, 553, 1, '3211900', 'jfld_3211900.jpg', 38.2979, '2010-06-30 22:00:00', '2010-10-17 19:51:19', NULL, 0.00, 1, 1, 17, 0, 'Necklace', NULL);
INSERT INTO `products` VALUES (368, 553, 1, '3211903', 'jfld_3211903.jpg', 35.7447, '2010-06-30 22:00:00', '2010-10-17 19:42:19', NULL, 0.00, 1, 1, 17, 0, 'Bracelet', NULL);
INSERT INTO `products` VALUES (369, 553, 1, '3211909', 'jfld_3211909.jpg', 24.6809, '2010-06-30 22:00:00', '2010-10-17 19:52:54', NULL, 0.00, 1, 1, 17, 0, 'Pendant', NULL);
INSERT INTO `products` VALUES (370, 554, 1, '3211899', 'jfld_3211899.jpg', 29.7872, '2010-06-30 22:00:00', '2010-10-17 19:50:35', NULL, 0.00, 1, 1, 17, 0, 'Earrings', NULL);
INSERT INTO `products` VALUES (371, 554, 1, '3211904', 'jfld_3211904.jpg', 75.7447, '2010-06-30 22:00:00', '2010-10-17 19:44:23', NULL, 0.00, 1, 1, 17, 0, 'Bangle', NULL);
INSERT INTO `products` VALUES (372, 554, 1, '3211931', 'jfld_3211931.jpg', 35.7447, '2010-06-30 22:00:00', '2010-10-17 19:51:43', NULL, 0.00, 1, 1, 17, 0, 'Necklace', NULL);
INSERT INTO `products` VALUES (373, 555, 1, '3212605', 'jfld_3212605.jpg', 25.5319, '2010-06-30 22:00:00', '2010-10-17 19:47:23', NULL, 0.00, 1, 1, 17, 1, 'Earrings', NULL);
INSERT INTO `products` VALUES (374, 555, 1, '3212606', 'jfld_3212606.jpg', 24.6809, '2010-06-30 22:00:00', '2010-12-13 08:56:45', NULL, 0.00, 1, 1, 17, 2, 'Pendant', NULL);
INSERT INTO `products` VALUES (375, 555, 0, '3212608', 'jfld_3212608.jpg', 38.2979, '2010-06-30 22:00:00', '2010-10-17 19:43:36', NULL, 0.00, 0, 1, 17, 0, 'Bracelet', NULL);
INSERT INTO `products` VALUES (376, 0, 3, '4304', 'wsek_4304.jpg', 22.9702, '2010-07-13 23:00:00', '2010-08-31 10:30:15', NULL, 0.00, 1, 1, 14, 1, 'Ladies', NULL);
INSERT INTO `products` VALUES (377, 0, 3, '4305', 'wsek_4305.jpg', 22.9702, '2010-07-13 23:00:00', '2010-08-31 10:30:33', NULL, 0.00, 1, 1, 14, 0, 'Ladies', NULL);
INSERT INTO `products` VALUES (378, 0, 1, '4307', 'wsek_4307.jpg', 22.9702, '2010-07-13 23:00:00', '2010-08-31 10:29:58', NULL, 0.00, 1, 1, 14, 0, 'Ladies', NULL);
INSERT INTO `products` VALUES (379, 0, 1, '4314', 'wsek_4314.jpg', 22.9702, '2010-07-13 23:00:00', '2010-08-31 10:29:37', NULL, 0.00, 1, 1, 14, 1, 'Ladies', NULL);
INSERT INTO `products` VALUES (380, 0, 1, '4315', 'wsek_4315.jpg', 22.9702, '2010-07-13 23:00:00', '2010-08-31 10:31:09', NULL, 0.00, 1, 1, 14, 0, 'Ladies', NULL);
INSERT INTO `products` VALUES (381, 0, 1, '4317', 'wsek_4317.jpg', 22.9702, '2010-07-13 23:00:00', '2010-08-31 10:31:42', NULL, 0.00, 1, 1, 14, 1, 'Ladies', NULL);
INSERT INTO `products` VALUES (382, 0, 2, '4448', 'wsek_4448.jpg', 22.9702, '2010-07-13 23:00:00', '2010-09-01 08:51:39', NULL, 0.00, 1, 1, 14, 0, 'Ladies', NULL);
INSERT INTO `products` VALUES (383, 0, 2, '4449', 'wsek_4449.jpg', 22.9702, '2010-07-13 23:00:00', '2010-09-01 08:52:00', NULL, 0.00, 1, 1, 14, 0, 'Ladies', NULL);
INSERT INTO `products` VALUES (384, 0, 2, '4450', 'wsek_4450.jpg', 22.9702, '2010-07-13 23:00:00', '2010-09-01 08:52:20', NULL, 0.00, 1, 1, 14, 0, 'Ladies', NULL);
INSERT INTO `products` VALUES (461, 0, 2, 'MS670W', 'MS670W_opt.jpg', 21.2766, '2010-10-01 09:34:10', '2010-10-16 12:27:17', NULL, 0.00, 1, 1, 0, 0, NULL, NULL);
INSERT INTO `products` VALUES (388, 0, 3, '43L', 'pqc_43l.jpg', 30.6383, '2010-06-30 22:00:00', '2010-11-08 19:37:33', NULL, 0.00, 1, 1, 18, 0, 'Quaich', NULL);
INSERT INTO `products` VALUES (385, 0, 1, 'BM6544-51A', 'wcit_bm6544-51a.jpg', 121.7021, '2010-07-29 20:32:25', '2010-07-30 12:48:56', NULL, 0.00, 1, 1, 12, 0, NULL, NULL);
INSERT INTO `products` VALUES (494, 0, 1, 'R34358', 'R34358copy.jpg', 84.2553, '2010-10-15 15:33:40', '2010-10-18 15:01:07', NULL, 0.00, 1, 1, 27, 0, NULL, NULL);
INSERT INTO `products` VALUES (460, 0, 2, 'MB866S', 'MB866S_opt.jpg', 25.5319, '2010-10-01 09:30:09', '2010-10-14 16:47:40', NULL, 0.00, 1, 1, 13, 0, NULL, NULL);
INSERT INTO `products` VALUES (591, 0, 2, 'B3336', 'B3336_B3337_B3338copy.jpg', 29.7872, '2010-10-21 16:30:52', '2010-10-28 14:30:13', NULL, 0.00, 1, 1, 16, 0, NULL, NULL);
INSERT INTO `products` VALUES (673, 0, 1, '4424', 'wsey_4424.jpg', 53.6085, '2010-10-28 16:07:54', '2010-10-28 16:26:25', NULL, 0.00, 1, 1, 14, 0, NULL, NULL);
INSERT INTO `products` VALUES (386, 0, 7, 'LB1401', 'wacc_lb1401.jpg', 63.8298, '2010-07-29 20:44:05', '2010-12-26 09:37:56', NULL, 0.00, 1, 1, 13, 0, NULL, NULL);
INSERT INTO `products` VALUES (387, 0, 4, 'LB1402', 'wacc_lb1402.jpg', 76.5957, '2010-07-29 20:45:50', '2010-12-26 09:39:54', NULL, 0.00, 1, 1, 13, 0, NULL, NULL);
INSERT INTO `products` VALUES (647, 0, 1, 'P3075C', 'jges_p3075C_n2573.jpg', 31.4894, '2010-10-27 12:01:23', '2010-12-21 11:43:52', NULL, 0.00, 0, 1, 16, 0, NULL, NULL);
INSERT INTO `products` VALUES (389, 0, 2, '43LB', 'pqc_43lb.jpg', 34.0426, '2010-06-30 22:00:00', '2010-11-19 16:54:16', NULL, 0.00, 1, 1, 18, 0, 'Quaich', NULL);
INSERT INTO `products` VALUES (390, 0, 1, '43LC', 'pqc_43lc.jpg', 33.1915, '2010-06-30 22:00:00', '2010-11-08 19:35:37', NULL, 0.00, 1, 1, 18, 0, 'Quaich', NULL);
INSERT INTO `products` VALUES (391, 0, 2, '43LGHDL', 'pqc_43l-gemhdl.jpg', 33.1915, '2010-06-30 22:00:00', '2010-11-08 19:36:55', NULL, 0.00, 1, 1, 18, 0, 'Quaich', NULL);
INSERT INTO `products` VALUES (392, 0, 4, '43M', 'pqc_43m.jpg', 28.0851, '2010-06-30 22:00:00', '2010-11-08 19:40:29', NULL, 0.00, 1, 1, 18, 0, 'Quaich', NULL);
INSERT INTO `products` VALUES (393, 0, 3, '43MB', 'pqc_43mb.jpg', 32.3404, '2010-06-30 22:00:00', '2010-11-08 19:38:32', NULL, 0.00, 1, 1, 18, 0, 'Quaich', NULL);
INSERT INTO `products` VALUES (394, 0, 7, '43MC', 'pqc_43mc.jpg', 29.7872, '2010-06-30 22:00:00', '2010-11-19 16:18:55', NULL, 0.00, 1, 1, 18, 0, 'Quaich', NULL);
INSERT INTO `products` VALUES (395, 0, 2, '43MGHDL', 'pqc_43mghdl.jpg', 30.6383, '2010-06-30 22:00:00', '2010-11-08 19:39:23', NULL, 0.00, 1, 1, 18, 0, 'Quaich', NULL);
INSERT INTO `products` VALUES (396, 0, 5, '43S', 'pqc_43s.jpg', 19.5745, '2010-06-30 22:00:00', '2010-11-08 19:42:57', NULL, 0.00, 1, 1, 18, 0, 'Quaich', NULL);
INSERT INTO `products` VALUES (397, 0, 2, '43SB', 'pqc_43sb.jpg', 26.3830, '2010-06-30 22:00:00', '2010-11-08 19:41:07', NULL, 0.00, 1, 1, 18, 0, 'Quaich', NULL);
INSERT INTO `products` VALUES (398, 0, 4, '43SC', 'pqc_43sc.jpg', 22.1277, '2010-06-30 22:00:00', '2010-11-08 19:42:25', NULL, 0.00, 1, 1, 18, 0, 'Quaich', NULL);
INSERT INTO `products` VALUES (399, 0, 3, '43SGHDL', 'pqc_43s-gemhdl.jpg', 22.1277, '2010-06-30 22:00:00', '2010-11-08 19:41:45', NULL, 0.00, 1, 1, 18, 0, 'Quaich', NULL);
INSERT INTO `products` VALUES (400, 0, 2, '43ST', 'pqc_43st.jpg', 26.3830, '2010-06-30 22:00:00', '2010-11-08 19:46:25', NULL, 0.00, 1, 1, 18, 0, 'Quaich', NULL);
INSERT INTO `products` VALUES (401, 0, 3, '43STB', 'pqc_43stb.jpg', 27.2340, '2010-06-30 22:00:00', '2010-11-08 19:43:38', NULL, 0.00, 1, 1, 18, 0, 'Quaich', NULL);
INSERT INTO `products` VALUES (402, 0, 1, '43STC', 'pqc_43stc.jpg', 28.0851, '2010-06-30 22:00:00', '2010-11-08 19:44:19', NULL, 0.00, 1, 1, 18, 1, 'Quaich', NULL);
INSERT INTO `products` VALUES (403, 0, 1, '43STGHDL', 'pqc_43stghdl.jpg', 28.0851, '2010-06-30 22:00:00', '2010-11-08 19:45:47', NULL, 0.00, 1, 1, 18, 0, 'Quaich', NULL);
INSERT INTO `products` VALUES (404, 0, 1, '4756/8CG', 'pqc_47568cg.jpg', 26.3830, '2010-06-30 22:00:00', '2010-08-16 17:18:46', NULL, 0.00, 1, 1, 18, 0, 'Hip Flask', NULL);
INSERT INTO `products` VALUES (405, 0, 2, '4756/8-LIONS', 'pqc_4756-8-lionsc.jpg', 28.0851, '2010-06-30 22:00:00', '2010-11-08 19:48:59', NULL, 0.00, 1, 1, 18, 0, 'Hip Flask', NULL);
INSERT INTO `products` VALUES (406, 0, 2, '4756/8TH', 'pqc_47568th.jpg', 28.0851, '2010-06-30 22:00:00', '2010-11-08 19:49:35', NULL, 0.00, 1, 1, 18, 0, 'Hip Flask', NULL);
INSERT INTO `products` VALUES (407, 0, 2, '4763GEM', 'pqc_4763gem.jpg', 33.1915, '2010-06-30 22:00:00', '2010-11-08 19:50:23', NULL, 0.00, 1, 1, 18, 0, 'Hip Flask', NULL);
INSERT INTO `products` VALUES (408, 0, 2, '4764-LIONSC', 'pqc_4764-lionsc.jpg', 27.2340, '2010-06-30 22:00:00', '2010-08-16 17:19:19', NULL, 0.00, 1, 1, 18, 0, 'Hip Flask', NULL);
INSERT INTO `products` VALUES (409, 0, 2, 'WD136', 'pep_wd136.jpg', 13.6170, '2010-08-13 20:00:00', '2010-08-17 16:15:34', NULL, 0.00, 1, 1, 19, 0, 'Cake Knife', NULL);
INSERT INTO `products` VALUES (410, 0, 2, '', 'pep_wd403.jpg', 12.7660, '2010-08-13 20:00:00', '2010-08-17 16:13:22', NULL, 0.00, 1, 1, 19, 0, 'Cake Knife', NULL);
INSERT INTO `products` VALUES (411, 0, 2, 'WD406', 'pep_wd406.jpg', 13.6170, '2010-08-13 20:00:00', '2010-08-17 16:05:23', NULL, 0.00, 1, 1, 19, 0, 'Cake Knife', NULL);
INSERT INTO `products` VALUES (412, 0, 1, 'WD400', 'pep_wd400.jpg', 0.0000, '2010-08-13 20:00:00', '2010-08-14 13:01:20', NULL, 0.00, 0, 0, 19, 0, 'Cake Knife and Slice Set', NULL);
INSERT INTO `products` VALUES (413, 0, 2, 'WD401', 'pep_wd401.jpg', 19.5745, '2010-08-13 20:00:00', '2010-08-17 16:25:04', NULL, 0.00, 1, 1, 19, 0, 'Cake Knife and Slice Set', NULL);
INSERT INTO `products` VALUES (414, 0, 2, 'CEL920', 'pep_cel920.jpg', 13.6170, '2010-08-13 20:00:00', '2010-08-17 15:34:15', NULL, 0.00, 1, 1, 19, 0, 'Letter Opener', NULL);
INSERT INTO `products` VALUES (415, 0, 2, 'CEL940', 'pep_cel940.jpg', 13.6170, '2010-08-13 20:00:00', '2010-08-17 15:36:59', NULL, 0.00, 1, 1, 19, 0, 'Letter Opener', NULL);
INSERT INTO `products` VALUES (416, 0, 2, 'CEL941', 'pep_cel941.jpg', 13.6170, '2010-08-13 20:00:00', '2010-08-17 15:38:31', NULL, 0.00, 1, 1, 19, 0, 'Letter Opener', NULL);
INSERT INTO `products` VALUES (417, 0, 2, 'CEL943', 'pep_cel943.jpg', 13.6170, '2010-08-13 20:00:00', '2010-08-17 15:40:09', NULL, 0.00, 1, 1, 19, 0, 'Letter Opener', NULL);
INSERT INTO `products` VALUES (418, 0, 2, 'CEL946', 'pep_cel946.jpg', 13.6170, '2010-08-13 20:00:00', '2010-08-17 15:42:40', NULL, 0.00, 1, 1, 19, 0, 'Letter Opener', NULL);
INSERT INTO `products` VALUES (419, 0, 1, 'CEL947', 'pep_cel947.jpg', 13.6170, '2010-08-13 20:00:00', '2010-12-16 10:59:20', NULL, 0.00, 1, 1, 19, 0, 'Letter Opener', NULL);
INSERT INTO `products` VALUES (420, 0, 2, 'CEL530', 'pep_cel530.jpg', 15.0000, '2010-08-13 20:00:00', '2010-08-17 13:58:50', NULL, 0.00, 1, 0, 19, 0, 'Compact Mirror', NULL);
INSERT INTO `products` VALUES (421, 0, 2, 'CEL531', 'pep_cel531.jpg', 15.0000, '2010-08-13 20:00:00', '2010-08-17 14:03:51', NULL, 0.00, 1, 0, 19, 0, 'Compact Mirror', NULL);
INSERT INTO `products` VALUES (422, 0, 2, 'CEL532', 'pep_cel532.jpg', 15.0000, '2010-08-13 20:00:00', '2010-08-17 14:06:28', NULL, 0.00, 1, 0, 19, 0, 'Compact Mirror', NULL);
INSERT INTO `products` VALUES (423, 0, 2, 'CEL533', 'pep_cel533.jpg', 15.0000, '2010-08-13 20:00:00', '2010-08-21 11:53:21', NULL, 0.00, 1, 0, 19, 0, 'Compact Mirror', NULL);
INSERT INTO `products` VALUES (424, 0, 2, 'CEL535', 'pep_cel535.jpg', 15.0000, '2010-08-13 20:00:00', '2010-08-17 14:11:10', NULL, 0.00, 1, 0, 19, 0, 'Compact Mirror', NULL);
INSERT INTO `products` VALUES (425, 0, 2, 'PQ501', 'pep_pq501.jpg', 16.1702, '2010-08-13 20:00:00', '2010-08-17 13:05:11', NULL, 0.00, 1, 1, 19, 0, '2.5" Quaich', NULL);
INSERT INTO `products` VALUES (426, 0, 1, 'PQ502', 'pep_pq502.jpg', 22.0000, '2010-08-13 20:00:00', '2010-08-17 13:39:43', NULL, 0.00, 1, 0, 19, 0, '3.5" Quaich', NULL);
INSERT INTO `products` VALUES (427, 0, 2, 'PQ515', 'pep_pq515.jpg', 21.2766, '2010-08-13 20:00:00', '2010-08-17 13:44:26', NULL, 0.00, 1, 1, 19, 0, '4" Quaich', NULL);
INSERT INTO `products` VALUES (428, 0, 2, 'PQ503', 'pep_pq503.jpg', 23.8298, '2010-08-13 20:00:00', '2010-08-17 13:48:36', NULL, 0.00, 1, 1, 19, 0, '4.5" Quaich', NULL);
INSERT INTO `products` VALUES (429, 0, 3, 'SQ900', 'pep_sq900.jpg', 16.1702, '2010-08-13 20:00:00', '2010-08-17 12:34:49', NULL, 0.00, 1, 1, 19, 0, '2.5" Quaich   ', NULL);
INSERT INTO `products` VALUES (430, 0, 2, '', 'pep_sq901.jpg', 18.7234, '2010-08-13 20:00:00', '2010-08-17 12:35:33', NULL, 0.00, 1, 1, 0, 0, '3" Quaich', NULL);
INSERT INTO `products` VALUES (431, 0, 2, 'SQ902', 'pep_sq902.jpg', 21.2766, '2010-08-13 20:00:00', '2010-08-17 12:36:02', NULL, 0.00, 1, 1, 19, 0, '3.5" Quaich', NULL);
INSERT INTO `products` VALUES (432, 0, 2, 'SQ903', 'pep_sq902.jpg', 23.8298, '2010-08-13 20:00:00', '2010-08-17 12:36:31', NULL, 0.00, 1, 1, 19, 0, '4" Quaich', NULL);
INSERT INTO `products` VALUES (433, 0, 1, 'PQ301', 'pep_pq301.jpg', 23.0000, '2010-08-13 20:00:00', '2010-08-16 11:26:15', NULL, 0.00, 0, 0, 19, 0, '2.5"  Quaich', NULL);
INSERT INTO `products` VALUES (434, 0, 1, 'PQ302', 'pep_pq302.jpg', 25.0000, '2010-08-13 20:00:00', '2010-08-13 22:20:31', NULL, 0.00, 0, 0, 19, 0, '3.5"  Quaich', NULL);
INSERT INTO `products` VALUES (435, 0, 1, 'PQ303', 'pep_pq303.jpg', 29.0000, '2010-08-13 20:00:00', '2010-08-13 22:21:16', NULL, 0.00, 0, 0, 19, 0, '4.5"  Quaich', NULL);
INSERT INTO `products` VALUES (436, 0, 2, 'TSF602', 'pep_tsf602.jpg', 24.6809, '2010-08-13 20:00:00', '2010-08-17 14:51:41', NULL, 0.00, 1, 1, 19, 0, 'Hip Flask', NULL);
INSERT INTO `products` VALUES (437, 0, 2, 'TSF603', 'pep_tsf603.jpg', 24.6809, '2010-08-13 20:00:00', '2010-08-17 15:01:09', NULL, 0.00, 1, 1, 19, 0, 'Hip Flask', NULL);
INSERT INTO `products` VALUES (438, 0, 2, 'TSF604', 'pep_tsf604.jpg', 24.6809, '2010-08-13 20:00:00', '2010-08-17 15:04:20', NULL, 0.00, 1, 1, 19, 0, 'Hip Flask', NULL);
INSERT INTO `products` VALUES (439, 0, 2, 'TSF605', 'pep_tsf605.jpg', 24.6809, '2010-08-13 20:00:00', '2010-08-17 15:08:23', NULL, 0.00, 1, 1, 19, 0, 'Hip Flask', NULL);
INSERT INTO `products` VALUES (440, 0, 1, 'TSF606', 'pep_tsf606.jpg', 24.6809, '2010-08-13 20:00:00', '2010-08-17 15:11:37', NULL, 0.00, 1, 1, 19, 0, 'Hip Flask', NULL);
INSERT INTO `products` VALUES (441, 0, 2, 'TSF639', 'pep_tsf639.jpg', 24.6809, '2010-08-13 20:00:00', '2010-08-17 15:17:44', NULL, 0.00, 1, 1, 19, 0, 'Hip Flask', NULL);
INSERT INTO `products` VALUES (442, 0, 2, 'SF204', 'pep_sf204.jpg', 21.2766, '2010-08-13 20:00:00', '2010-08-17 14:21:42', NULL, 0.00, 1, 1, 19, 0, 'Hip Flask', NULL);
INSERT INTO `products` VALUES (443, 0, 2, 'SF214', 'pep_sf214.jpg', 21.2766, '2010-08-13 20:00:00', '2010-08-17 14:29:05', NULL, 0.00, 1, 1, 19, 0, 'Hip Flask', NULL);
INSERT INTO `products` VALUES (444, 0, 2, 'SF297', 'pep_sf297.jpg', 21.2766, '2010-08-13 20:00:00', '2010-08-17 14:45:24', NULL, 0.00, 1, 1, 19, 0, 'Hip Flask', NULL);
INSERT INTO `products` VALUES (445, 0, 1, 'CEL487', 'pep_cel487.jpg', 29.0000, '2010-08-13 20:00:00', '2010-08-13 22:21:33', NULL, 0.00, 0, 0, 19, 0, 'Hip Flask', NULL);
INSERT INTO `products` VALUES (446, 0, 1, 'CEL488', 'pep_cel488.jpg', 31.0000, '2010-08-13 20:00:00', '2010-08-13 22:21:51', NULL, 0.00, 0, 0, 19, 0, 'Hip Flask', NULL);
INSERT INTO `products` VALUES (447, 0, 1, 'CEL489', 'pep_cel489.jpg', 33.0000, '2010-08-13 20:00:00', '2010-08-13 22:22:33', NULL, 0.00, 0, 0, 19, 0, 'Hip Flask', NULL);
INSERT INTO `products` VALUES (462, 0, 1, 'MS670G', 'MS670G_opt.jpg', 21.2766, '2010-10-01 09:43:52', '2010-12-15 11:39:05', NULL, 0.00, 0, 1, 13, 0, NULL, NULL);
INSERT INTO `products` VALUES (463, 0, 2, 'LB1864', 'LB1864_opt.jpg', 24.6809, '2010-10-01 09:54:25', '2010-10-13 15:42:31', NULL, 0.00, 1, 1, 0, 0, NULL, NULL);
INSERT INTO `products` VALUES (464, 0, 2, 'LB1866', 'LB1866_opt.jpg', 22.1277, '2010-10-01 10:14:50', '2010-12-07 13:32:27', NULL, 0.00, 1, 1, 13, 0, NULL, NULL);
INSERT INTO `products` VALUES (465, 0, 2, 'LS670W', 'LS670W_opt-5.jpg', 21.2766, '2010-10-01 10:33:19', '2010-10-14 14:47:11', NULL, 0.00, 1, 1, 13, 0, NULL, NULL);
INSERT INTO `products` VALUES (466, 0, 2, 'LS670G', 'LS670G_opt.jpg', 21.2766, '2010-10-01 10:58:10', '2010-10-13 15:46:54', NULL, 0.00, 1, 1, 13, 0, NULL, NULL);
INSERT INTO `products` VALUES (467, 0, 1, 'LB1036P', '779274022_lb1036p_opt.jpg', 38.2979, '2010-10-01 13:04:30', '2010-11-09 10:42:10', NULL, 0.00, 1, 1, 0, 0, NULL, NULL);
INSERT INTO `products` VALUES (468, 0, 1, 'LB1038P', '779274027_lb1038p copy_opt-1.jpg', 38.2979, '2010-10-01 13:21:55', '2010-12-07 13:30:36', NULL, 0.00, 1, 1, 13, 0, NULL, NULL);
INSERT INTO `products` VALUES (469, 0, 1, 'LB1038B', '902199793_lb1038b_opt.jpg', 36.5957, '2010-10-01 13:43:19', '2010-12-13 10:44:29', NULL, 0.00, 0, 1, 13, 0, NULL, NULL);
INSERT INTO `products` VALUES (470, 0, 1, 'LB1380', '939772448_lb1380_opt-1.jpg', 46.8085, '2010-10-01 13:47:20', '2010-10-13 15:39:26', NULL, 0.00, 1, 1, 13, 0, NULL, NULL);
INSERT INTO `products` VALUES (471, 0, 1, 'LB1382', '1017955365_lb1382_opt-1.jpg', 44.2553, '2010-10-01 14:16:55', '2010-10-23 16:33:35', NULL, 0.00, 0, 1, 13, 0, NULL, NULL);
INSERT INTO `products` VALUES (472, 0, 0, 'LB706W', '605036970_lb706w_opt-2.jpg', 29.7872, '2010-10-01 14:23:59', '2010-10-13 16:01:07', NULL, 0.00, 1, 1, 13, 0, NULL, NULL);
INSERT INTO `products` VALUES (473, 0, 1, 'LB708W', '605036992_lb708w_opt-1.jpg', 29.7872, '2010-10-01 14:37:23', '2010-10-13 16:02:29', NULL, 0.00, 1, 1, 13, 0, NULL, NULL);
INSERT INTO `products` VALUES (474, 0, 1, 'LB1741', '664936213_lb1741_opt-1.jpg', 0.0000, '2010-10-01 14:43:40', '2010-10-01 17:31:25', NULL, 0.00, 0, 1, 13, 0, NULL, NULL);
INSERT INTO `products` VALUES (475, 0, 1, 'LB1388P', '779273999_lb1388p_opt.jpg', 44.2553, '2010-10-01 14:51:01', '2010-10-13 15:52:34', NULL, 0.00, 1, 1, 13, 0, NULL, NULL);
INSERT INTO `products` VALUES (476, 0, 1, 'LB1390P', '779274007_lb1390p_opt.jpg', 44.2553, '2010-10-01 14:55:05', '2010-10-13 15:59:40', NULL, 0.00, 1, 1, 13, 0, NULL, NULL);
INSERT INTO `products` VALUES (477, 0, 1, 'LB1404', 'wacc_lb1404.jpg', 93.6170, '2010-10-01 15:00:29', '2010-12-26 09:41:04', NULL, 0.00, 1, 1, 13, 1, NULL, NULL);
INSERT INTO `products` VALUES (478, 0, 1, 'MB832S', '779273089copy_mb832s-1.jpg', 76.5957, '2010-10-01 15:24:29', '2010-10-18 17:20:13', NULL, 0.00, 1, 1, 13, 0, NULL, NULL);
INSERT INTO `products` VALUES (479, 0, 1, 'MS832Y', '819126962_ms832y_opt-1.jpg', 74.0426, '2010-10-01 15:37:26', '2010-12-07 14:29:54', NULL, 0.00, 1, 1, 13, 0, NULL, NULL);
INSERT INTO `products` VALUES (480, 0, 1, 'MB837B', '773922756_mb837b_opt.jpg', 66.3830, '2010-10-01 15:46:17', '2010-10-13 16:23:04', NULL, 0.00, 1, 1, 13, 0, NULL, NULL);
INSERT INTO `products` VALUES (490, 0, 3, 'N2922', 'N2922.jpg', 31.4894, '2010-10-14 12:24:58', '2010-12-24 15:29:01', NULL, 0.00, 0, 1, 16, 0, NULL, NULL);
INSERT INTO `products` VALUES (482, 0, 1, 'MB890dia', '773923054_mb890dia_opt.jpg', 57.0213, '2010-10-01 16:14:45', '2010-10-13 16:46:08', NULL, 0.00, 1, 1, 13, 0, NULL, NULL);
INSERT INTO `products` VALUES (492, 0, 1, 'R35603', 'R35603copy.jpg', 48.5106, '2010-10-15 12:29:07', '2010-10-22 12:30:06', NULL, 0.00, 1, 1, 27, 0, NULL, NULL);
INSERT INTO `products` VALUES (484, 0, 1, 'MB840N', '773922787_mb840n_opt.jpg', 36.5957, '2010-10-01 16:23:10', '2010-10-13 16:44:16', NULL, 0.00, 1, 1, 13, 0, NULL, NULL);
INSERT INTO `products` VALUES (493, 0, 1, 'R35597', 'geem_r35597.jpg', 41.7021, '2010-10-15 12:57:45', '2010-11-17 18:09:26', NULL, 0.00, 1, 1, 27, 0, NULL, NULL);
INSERT INTO `products` VALUES (485, 0, 1, 'MB850B', '572664061_mb850b_opt.jpg', 58.7234, '2010-10-01 16:37:04', '2010-10-13 16:48:49', NULL, 0.00, 1, 1, 13, 0, NULL, NULL);
INSERT INTO `products` VALUES (486, 0, 1, 'MS728B', '773922618_ms728b_opt.jpg', 33.1915, '2010-10-01 16:41:39', '2010-10-13 16:28:05', NULL, 0.00, 1, 1, 13, 0, NULL, NULL);
INSERT INTO `products` VALUES (487, 0, 1, 'LB1398P', 'LB1398P (2)_opt.jpg', 34.0426, '2010-10-01 16:46:56', '2010-12-07 13:27:01', NULL, 0.00, 1, 1, 13, 0, NULL, NULL);
INSERT INTO `products` VALUES (488, 0, 2, 'LB1399P', 'LB1399P_opt.jpg', 34.0426, '2010-10-01 17:08:32', '2010-12-07 13:34:55', NULL, 0.00, 1, 1, 13, 0, NULL, NULL);
INSERT INTO `products` VALUES (495, 0, 1, 'R35665', NULL, 44.2553, '2010-10-15 15:37:23', '2010-10-18 14:59:29', NULL, 0.00, 0, 1, 27, 0, NULL, NULL);
INSERT INTO `products` VALUES (496, 0, 1, 'R34931', 'R34931copy.jpg', 50.2128, '2010-10-15 15:46:20', '2010-10-22 12:47:50', NULL, 0.00, 1, 1, 27, 0, NULL, NULL);
INSERT INTO `products` VALUES (497, 0, 1, 'R35503', 'R35503copy.jpg', 58.7234, '2010-10-15 15:56:46', '2010-10-19 16:21:21', NULL, 0.00, 1, 1, 27, 0, NULL, NULL);
INSERT INTO `products` VALUES (498, 0, 1, 'R35615', 'geem_r35615.jpg', 93.6170, '2010-10-15 16:33:32', '2010-12-10 13:38:11', NULL, 0.00, 0, 1, 27, 0, NULL, NULL);
INSERT INTO `products` VALUES (499, 0, 1, 'R35151', 'R35151copy.jpg', 42.5532, '2010-10-15 16:49:00', '2010-11-15 17:21:16', NULL, 0.00, 1, 1, 27, 0, NULL, NULL);
INSERT INTO `products` VALUES (500, 0, 1, 'R35024', 'geem_r35024.jpg', 40.8511, '2010-10-15 16:55:03', '2010-11-17 18:27:02', NULL, 0.00, 1, 1, 27, 0, NULL, NULL);
INSERT INTO `products` VALUES (501, 0, 1, 'R35621', 'geem_r35621.jpg', 46.8085, '2010-10-15 17:06:13', '2010-11-17 18:13:05', NULL, 0.00, 1, 1, 27, 0, NULL, NULL);
INSERT INTO `products` VALUES (502, 0, 1, 'R35596', 'R35596copy.jpg', 36.5957, '2010-10-15 17:16:37', '2010-12-10 12:58:42', NULL, 0.00, 1, 1, 27, 0, NULL, NULL);
INSERT INTO `products` VALUES (503, 0, 1, 'R45312', 'R45312copy.jpg', 84.2553, '2010-10-16 09:19:38', '2010-10-18 13:20:12', NULL, 0.00, 1, 1, 27, 0, NULL, NULL);
INSERT INTO `products` VALUES (504, 0, 1, 'R45428', 'R45428copy.JPG', 118.2979, '2010-10-16 10:42:07', '2010-10-18 13:08:49', NULL, 0.00, 1, 1, 27, 0, NULL, NULL);
INSERT INTO `products` VALUES (505, 0, 1, 'R45377', 'R45377copy.JPG', 217.0213, '2010-10-16 11:07:22', '2010-10-18 13:17:23', NULL, 0.00, 1, 1, 27, 0, NULL, NULL);
INSERT INTO `products` VALUES (506, 0, 1, 'R45384', 'R45384copy.JPG', 97.8723, '2010-10-16 11:31:04', '2010-10-18 13:15:35', NULL, 0.00, 1, 1, 27, 0, NULL, NULL);
INSERT INTO `products` VALUES (507, 0, 1, 'R45335', 'R45335copy.jpg', 74.0426, '2010-10-16 11:46:50', '2010-10-22 13:42:08', NULL, 0.00, 1, 1, 27, 0, NULL, NULL);
INSERT INTO `products` VALUES (508, 0, 1, 'R45427', 'R45427copy.JPG', 182.9787, '2010-10-16 12:20:19', '2010-10-18 13:12:10', NULL, 0.00, 1, 1, 27, 0, NULL, NULL);
INSERT INTO `products` VALUES (509, 0, 1, 'R45339', 'R45339copy.jpg', 93.6170, '2010-10-16 12:34:46', '2010-10-22 13:38:00', NULL, 0.00, 1, 1, 27, 0, NULL, NULL);
INSERT INTO `products` VALUES (510, 0, 2, 'R44810', 'R44810copy.jpg', 75.7447, '2010-10-16 12:42:40', '2010-12-20 15:54:29', NULL, 0.00, 1, 1, 27, 0, NULL, NULL);
INSERT INTO `products` VALUES (511, 0, 1, 'R45336', 'R45336copy.jpg', 93.6170, '2010-10-16 12:52:39', '2010-10-22 13:40:05', NULL, 0.00, 1, 1, 27, 0, NULL, NULL);
INSERT INTO `products` VALUES (512, 0, 1, 'R43338', 'R43338copy.jpg', 58.7234, '2010-10-16 12:54:53', '2010-10-18 13:24:31', NULL, 0.00, 1, 1, 27, 0, NULL, NULL);
INSERT INTO `products` VALUES (513, 0, 1, 'R45316', 'R45316copy.jpg', 89.3617, '2010-10-16 13:55:18', '2010-12-23 13:01:42', NULL, 0.00, 0, 1, 27, 0, NULL, NULL);
INSERT INTO `products` VALUES (514, 0, 1, 'R44927', 'R44927copy.jpg', 63.8298, '2010-10-16 14:05:55', '2010-10-22 13:48:48', NULL, 0.00, 1, 1, 27, 0, NULL, NULL);
INSERT INTO `products` VALUES (515, 0, 1, 'R43560', 'R43560copy.jpg', 63.8298, '2010-10-16 14:15:09', '2010-12-04 12:03:06', NULL, 0.00, 0, 1, 27, 0, NULL, NULL);
INSERT INTO `products` VALUES (516, 0, 1, 'R44985', 'R44985copy.jpg', 93.6170, '2010-10-16 14:22:48', '2010-10-22 13:56:14', NULL, 0.00, 1, 1, 27, 0, NULL, NULL);
INSERT INTO `products` VALUES (517, 0, 1, 'R44466', 'R44466copy.jpg', 182.9787, '2010-10-16 14:39:22', '2010-10-22 13:44:48', NULL, 0.00, 1, 1, 27, 0, NULL, NULL);
INSERT INTO `products` VALUES (518, 0, 5, 'Y2289', 'Y2289copy.jpg', 6.8085, '2010-10-16 15:00:24', '2010-10-19 14:48:03', NULL, 0.00, 1, 1, 16, 0, NULL, NULL);
INSERT INTO `products` VALUES (519, 0, 5, 'Y2386', 'Y2386copy.jpg', 6.8085, '2010-10-16 15:57:39', '2010-10-19 14:41:52', NULL, 0.00, 1, 1, 16, 0, NULL, NULL);
INSERT INTO `products` VALUES (520, 0, 1, 'Y2199', 'Y2199copy.jpg', 10.2128, '2010-10-16 17:55:30', '2010-10-16 21:51:11', NULL, 0.00, 1, 1, 16, 0, NULL, NULL);
INSERT INTO `products` VALUES (521, 0, 2, 'Y2209', 'Y2209copy.jpg', 10.2128, '2010-10-16 20:34:52', '2010-10-19 16:50:51', NULL, 0.00, 1, 1, 16, 0, NULL, NULL);
INSERT INTO `products` VALUES (522, 0, 2, 'Y2141', 'Y2141copy.jpg', 10.2128, '2010-10-16 20:52:57', '2010-10-16 21:48:40', NULL, 0.00, 1, 1, 16, 0, NULL, NULL);
INSERT INTO `products` VALUES (523, 0, 5, 'Y2173', 'Y2173copy.jpg', 10.2128, '2010-10-16 21:02:39', '2010-10-19 15:37:42', NULL, 0.00, 1, 1, 16, 0, NULL, NULL);
INSERT INTO `products` VALUES (524, 0, 10, 'Y2187', 'y2187copy1.jpg', 12.7660, '2010-10-16 21:13:27', '2010-10-26 15:13:59', NULL, 0.00, 1, 1, 16, 0, NULL, NULL);
INSERT INTO `products` VALUES (525, 0, 5, 'Y2232', 'Y2232_opt.jpg', 10.2128, '2010-10-16 21:24:09', '2010-10-19 15:54:08', NULL, 0.00, 1, 1, 16, 0, NULL, NULL);
INSERT INTO `products` VALUES (526, 0, 5, 'Y2266', 'Y2266copy.jpg', 6.8085, '2010-10-16 22:23:05', '2010-10-19 14:24:03', NULL, 0.00, 1, 1, 16, 0, NULL, NULL);
INSERT INTO `products` VALUES (527, 0, 5, 'Y2290', 'Y2290copy.jpg', 6.8085, '2010-10-16 22:34:08', '2010-10-19 14:47:36', NULL, 0.00, 1, 1, 16, 0, NULL, NULL);
INSERT INTO `products` VALUES (528, 0, 5, 'Y2264', 'Y2264copy.jpg', 6.8085, '2010-10-16 22:45:25', '2010-10-19 14:15:30', NULL, 0.00, 1, 1, 16, 0, NULL, NULL);
INSERT INTO `products` VALUES (529, 0, 5, 'Y2379', 'Y2379copy.jpg', 6.8085, '2010-10-16 23:05:18', '2010-10-19 14:32:01', NULL, 0.00, 1, 1, 16, 0, NULL, NULL);
INSERT INTO `products` VALUES (530, 0, 5, 'Y2378', 'Y2378copy.jpg', 6.8085, '2010-10-16 23:22:11', '2010-10-19 14:45:15', NULL, 0.00, 1, 1, 16, 0, NULL, NULL);
INSERT INTO `products` VALUES (531, 0, 0, '', 'B3467copy.jpg', 0.0000, '2010-10-17 15:43:50', '2010-10-17 16:44:23', NULL, 0.00, 0, 1, 16, 0, NULL, NULL);
INSERT INTO `products` VALUES (532, 0, 3, 'B254', 'B254_opt.jpg', 25.5319, '2010-10-17 16:59:01', '2010-10-19 09:54:31', NULL, 0.00, 1, 1, 16, 0, NULL, NULL);
INSERT INTO `products` VALUES (533, 0, 1, 'B2942', 'B2942_opt.jpg', 27.2340, '2010-10-17 17:04:22', '2010-12-20 11:59:29', NULL, 0.00, 1, 1, 16, 0, NULL, NULL);
INSERT INTO `products` VALUES (534, 0, 3, 'N2932', 'N2932copy_E3637.jpg', 28.9362, '2010-10-17 17:32:02', '2010-10-17 17:54:52', NULL, 0.00, 1, 1, 16, 0, NULL, NULL);
INSERT INTO `products` VALUES (535, 0, 2, 'Y2374', 'Y2374copy.jpg', 12.7660, '2010-10-18 09:07:09', '2010-10-18 09:12:50', NULL, 0.00, 1, 1, 16, 0, NULL, NULL);
INSERT INTO `products` VALUES (536, 0, 2, 'Y2191', 'Y2191copy.jpg', 10.2128, '2010-10-18 09:17:43', '2010-10-18 09:22:59', NULL, 0.00, 1, 1, 16, 0, NULL, NULL);
INSERT INTO `products` VALUES (537, 0, 5, 'Y2194', 'Y2194copy.jpg', 10.2128, '2010-10-18 09:38:18', '2010-10-19 15:34:48', NULL, 0.00, 1, 1, 16, 0, NULL, NULL);
INSERT INTO `products` VALUES (538, 0, 4, 'Y2348', 'Y2348copy.jpg', 10.2128, '2010-10-18 10:55:14', '2010-10-18 11:27:03', NULL, 0.00, 1, 1, 16, 0, NULL, NULL);
INSERT INTO `products` VALUES (539, 0, 5, 'y2360', 'Y2360copy.jpg', 10.2128, '2010-10-18 11:28:49', '2010-10-18 11:35:47', NULL, 0.00, 1, 1, 16, 0, NULL, NULL);
INSERT INTO `products` VALUES (540, 0, 5, 'Y2367', 'Y2367copy.jpg', 10.2128, '2010-10-18 11:38:19', '2010-11-08 11:28:43', NULL, 0.00, 1, 1, 16, 0, NULL, NULL);
INSERT INTO `products` VALUES (541, 0, 8, 'Y2368', 'Y2368copy.jpg', 10.2128, '2010-10-18 11:44:11', '2010-11-11 16:29:45', NULL, 0.00, 1, 1, 16, 0, NULL, NULL);
INSERT INTO `products` VALUES (542, 0, 3, 'Y2484', 'jgsb_y2484.jpg', 10.2128, '2010-10-18 11:58:50', '2010-10-30 15:47:52', NULL, 0.00, 1, 1, 16, 0, NULL, NULL);
INSERT INTO `products` VALUES (543, 0, 3, 'Y2487', 'jgsb_2487.jpg', 11.0638, '2010-10-18 12:01:52', '2010-10-30 15:43:46', NULL, 0.00, 1, 1, 16, 0, NULL, NULL);
INSERT INTO `products` VALUES (544, 0, 3, 'Y2488', 'jgsc_y2488.jpg', 11.0638, '2010-10-18 12:05:05', '2010-10-30 15:40:15', NULL, 0.00, 1, 1, 16, 0, NULL, NULL);
INSERT INTO `products` VALUES (545, 0, 3, 'Y2507', 'jgsb_y2507.jpg', 10.2128, '2010-10-18 12:09:43', '2010-10-30 15:54:52', NULL, 0.00, 1, 1, 16, 0, NULL, NULL);
INSERT INTO `products` VALUES (546, 0, 3, 'Y2508', 'jgsb_y2508.jpg', 10.2128, '2010-10-18 12:12:30', '2010-11-30 09:36:27', NULL, 0.00, 1, 1, 16, 0, NULL, NULL);
INSERT INTO `products` VALUES (547, 0, 3, 'Y2510', 'jgsb_y2510.jpg', 12.7660, '2010-10-18 12:15:24', '2010-10-30 15:52:53', NULL, 0.00, 1, 1, 16, 0, NULL, NULL);
INSERT INTO `products` VALUES (548, 0, 3, 'Y2511', 'jgsb_y2511.jpg', 12.7660, '2010-10-18 12:17:55', '2010-10-30 15:46:08', NULL, 0.00, 1, 1, 16, 0, NULL, NULL);
INSERT INTO `products` VALUES (549, 0, 1, 'R45315', 'R45315copy.jpg', 80.8511, '2010-10-18 14:04:41', '2010-10-18 15:03:22', NULL, 0.00, 1, 1, 16, 0, NULL, NULL);
INSERT INTO `products` VALUES (550, 0, 1, 'R35574', 'R35574copy.jpg', 61.2766, '2010-10-18 14:51:07', '2010-10-19 16:27:41', NULL, 0.00, 1, 1, 0, 0, NULL, NULL);
INSERT INTO `products` VALUES (551, 0, 3, 'Y2542', 'jggby2542.jpg', 6.8085, '2010-10-18 15:34:07', '2010-10-26 18:12:54', NULL, 0.00, 1, 1, 16, 0, NULL, NULL);
INSERT INTO `products` VALUES (552, 0, 6, 'Y2544', 'jggby2544.jpg', 6.8085, '2010-10-18 15:37:56', '2010-10-26 18:22:23', NULL, 0.00, 1, 1, 16, 0, NULL, NULL);
INSERT INTO `products` VALUES (553, 0, 3, 'y2582', 'jggby2582.jpg', 10.2128, '2010-10-18 15:55:50', '2010-10-26 18:14:41', NULL, 0.00, 1, 1, 16, 0, NULL, NULL);
INSERT INTO `products` VALUES (554, 0, 3, 'Y2528', 'jggby2528.jpg', 6.8085, '2010-10-18 16:03:44', '2010-10-26 15:47:53', NULL, 0.00, 1, 1, 16, 0, NULL, NULL);
INSERT INTO `products` VALUES (555, 0, 3, 'Y2527', 'jggby2527.jpg', 6.8085, '2010-10-18 16:06:28', '2010-10-26 18:05:07', NULL, 0.00, 1, 1, 16, 0, NULL, NULL);
INSERT INTO `products` VALUES (556, 0, 3, 'Y2552', 'jggby2552.jpg', 6.8085, '2010-10-18 16:08:58', '2010-10-26 17:51:27', NULL, 0.00, 1, 1, 16, 0, NULL, NULL);
INSERT INTO `products` VALUES (557, 0, 3, 'Y2562', 'jggby2562.jpg', 6.8085, '2010-10-18 16:12:42', '2010-10-26 18:24:11', NULL, 0.00, 1, 1, 16, 0, NULL, NULL);
INSERT INTO `products` VALUES (558, 0, 3, 'Y2555', 'jggby2555.jpg', 6.8085, '2010-10-18 16:17:58', '2010-10-26 18:29:46', NULL, 12.00, 1, 1, 16, 0, NULL, NULL);
INSERT INTO `products` VALUES (559, 0, 3, 'Y2556', 'jggby2556.jpg', 6.8085, '2010-10-18 16:20:09', '2010-10-26 18:20:23', NULL, 0.00, 1, 1, 16, 0, NULL, NULL);
INSERT INTO `products` VALUES (560, 0, 3, 'Y2523', 'jggby2523.jpg', 6.8085, '2010-10-18 16:22:44', '2010-10-26 18:10:47', NULL, 0.00, 1, 1, 16, 0, NULL, NULL);
INSERT INTO `products` VALUES (561, 0, 3, 'Y2533', 'jggby2533.jpg', 6.8085, '2010-10-18 16:25:01', '2010-10-26 17:55:44', NULL, 0.00, 1, 1, 16, 0, NULL, NULL);
INSERT INTO `products` VALUES (562, 0, 3, 'Y2521', 'jggby2521.jpg', 6.8085, '2010-10-18 16:27:36', '2010-10-26 18:00:39', NULL, 0.00, 1, 1, 16, 0, NULL, NULL);
INSERT INTO `products` VALUES (563, 0, 3, 'Y2520', 'jggby2520.jpg', 6.8085, '2010-10-18 16:29:55', '2010-10-26 18:09:02', NULL, 0.00, 1, 1, 16, 0, NULL, NULL);
INSERT INTO `products` VALUES (564, 0, 3, 'Y2519', 'jggby2519.jpg', 6.8085, '2010-10-18 16:32:07', '2010-10-26 18:06:55', NULL, 0.00, 1, 1, 16, 0, NULL, NULL);
INSERT INTO `products` VALUES (565, 0, 10, 'Y2518', 'jggby2518.jpg', 6.8085, '2010-10-18 16:34:28', '2010-11-11 16:28:25', NULL, 0.00, 1, 1, 16, 0, NULL, NULL);
INSERT INTO `products` VALUES (566, 0, 1, 'Y2516', 'jggby2516.jpg', 6.8085, '2010-10-18 16:36:41', '2010-11-25 13:38:18', NULL, 0.00, 1, 1, 16, 0, NULL, NULL);
INSERT INTO `products` VALUES (567, 0, 3, 'Y2517', 'jggby2517.jpg', 6.8085, '2010-10-18 16:41:13', '2010-10-26 18:02:39', NULL, 0.00, 1, 1, 16, 0, NULL, NULL);
INSERT INTO `products` VALUES (568, 0, 3, 'Y2515', 'jggby2515.jpg', 6.8085, '2010-10-18 16:43:33', '2010-10-26 17:58:16', NULL, 0.00, 1, 1, 16, 0, NULL, NULL);
INSERT INTO `products` VALUES (569, 0, 3, 'Y2563', 'jggby2563.jpg', 6.8085, '2010-10-18 16:45:52', '2010-10-26 18:26:04', NULL, 0.00, 1, 1, 16, 0, NULL, NULL);
INSERT INTO `products` VALUES (570, 0, 3, 'Y2580', 'jggby2580.jpg', 10.2128, '2010-10-18 16:48:32', '2010-10-26 18:17:34', NULL, 0.00, 1, 1, 16, 0, NULL, NULL);
INSERT INTO `products` VALUES (571, 0, 3, 'Y2583', 'jggb2583copy.jpg', 10.2128, '2010-10-18 16:52:47', '2010-10-26 15:44:18', NULL, 0.00, 1, 1, 16, 0, NULL, NULL);
INSERT INTO `products` VALUES (572, 0, 5, 'E198C', 'E198Ccopy.jpg', 7.6596, '2010-10-19 09:22:15', '2010-10-19 09:27:10', NULL, 0.00, 1, 1, 16, 0, NULL, NULL);
INSERT INTO `products` VALUES (573, 0, 3, 'GHE062', 'GHE062copy.jpg', 28.9362, '2010-10-19 11:02:09', '2010-10-19 11:09:01', NULL, 0.00, 1, 1, 0, 0, NULL, NULL);
INSERT INTO `products` VALUES (574, 0, 2, 'GHE089', 'GHE089copy.jpg', 34.0426, '2010-10-19 11:19:17', '2010-11-18 16:31:07', NULL, 0.00, 1, 1, 0, 0, NULL, NULL);
INSERT INTO `products` VALUES (575, 0, 3, '', 'GHE082copy.jpg', 31.4894, '2010-10-19 11:29:07', '2010-10-27 20:02:10', NULL, 0.00, 1, 1, 28, 0, NULL, NULL);
INSERT INTO `products` VALUES (576, 0, 2, 'GHE059', 'GHE059copy.jpg', 41.7021, '2010-10-19 12:26:46', '2010-10-19 12:29:30', NULL, 0.00, 1, 1, 28, 0, NULL, NULL);
INSERT INTO `products` VALUES (577, 0, 2, 'GHE053', 'GHE053copy.jpg', 41.7021, '2010-10-19 12:32:56', '2010-10-27 20:05:43', NULL, 0.00, 1, 1, 28, 0, NULL, NULL);
INSERT INTO `products` VALUES (578, 0, 2, 'GHE042', 'GHE042copy.jpg', 25.5319, '2010-10-19 12:39:23', '2010-11-19 10:22:24', NULL, 0.00, 1, 1, 28, 0, NULL, NULL);
INSERT INTO `products` VALUES (579, 0, 1, 'B3041', 'B3041copy.jpg', 35.7447, '2010-10-19 13:28:01', '2010-10-19 13:48:29', NULL, 0.00, 1, 1, 16, 0, NULL, NULL);
INSERT INTO `products` VALUES (580, 0, 3, 'B598', 'B598copy.jpg', 17.0213, '2010-10-19 13:36:41', '2010-10-19 13:45:42', NULL, 0.00, 1, 1, 16, 0, NULL, NULL);
INSERT INTO `products` VALUES (581, 0, 3, 'Y2277', 'Y2277copy.jpg', 6.8085, '2010-10-19 14:20:22', '2010-10-19 14:22:28', NULL, 0.00, 1, 1, 16, 0, NULL, NULL);
INSERT INTO `products` VALUES (582, 0, 3, 'Y2144', 'Y2144copy.jpg', 10.2128, '2010-10-19 14:57:14', '2010-10-19 14:58:54', NULL, 0.00, 1, 1, 16, 0, NULL, NULL);
INSERT INTO `products` VALUES (583, 0, 3, 'Y2158', 'Y2158copy.jpg', 10.2128, '2010-10-19 15:01:26', '2010-11-08 11:25:34', NULL, 0.00, 1, 1, 16, 0, NULL, NULL);
INSERT INTO `products` VALUES (584, 0, 3, 'Y2175', 'Y2175copy.jpg', 10.2128, '2010-10-19 15:27:58', '2010-11-08 11:29:14', NULL, 0.00, 1, 1, 16, 0, NULL, NULL);
INSERT INTO `products` VALUES (585, 0, 3, 'Y2184', 'Y2184copy.jpg', 10.2128, '2010-10-19 15:33:29', '2010-11-30 09:36:03', NULL, 0.00, 1, 1, 16, 0, NULL, NULL);
INSERT INTO `products` VALUES (586, 0, 6, 'Y2200', 'Y2200copy.jpg', 10.2128, '2010-10-19 15:44:28', '2010-11-11 16:31:58', NULL, 0.00, 1, 1, 16, 0, NULL, NULL);
INSERT INTO `products` VALUES (587, 0, 3, 'Y2201', 'Y2201copy.jpg', 10.2128, '2010-10-19 15:48:14', '2010-11-08 11:28:19', NULL, 0.00, 1, 1, 16, 0, NULL, NULL);
INSERT INTO `products` VALUES (588, 0, 3, 'Y2207', 'Y2207copy.jpg', 10.2128, '2010-10-19 15:53:31', '2010-11-08 11:26:42', NULL, 0.00, 1, 1, 16, 0, NULL, NULL);
INSERT INTO `products` VALUES (589, 0, 3, 'Y2342', 'Y2342copy.jpg', 10.2128, '2010-10-19 15:59:54', '2010-10-19 16:00:02', NULL, 0.00, 1, 1, 16, 0, NULL, NULL);
INSERT INTO `products` VALUES (590, 0, 8, 'Y2251', 'Y2251copy.jpg', 10.2128, '2010-10-19 16:02:21', '2010-11-11 16:31:35', NULL, 0.00, 1, 1, 16, 0, NULL, NULL);
INSERT INTO `products` VALUES (592, 0, 1, 'B3339', 'B3339_B3340_B3341copy.jpg', 29.7872, '2010-10-21 16:43:31', '2010-10-28 12:59:29', NULL, 0.00, 1, 1, 16, 0, NULL, NULL);
INSERT INTO `products` VALUES (593, 0, 4, 'B3340', 'B3339_B3340_B3341copy.jpg', 33.1915, '2010-10-21 16:50:15', '2010-10-28 13:01:54', NULL, 0.00, 1, 1, 16, 0, NULL, NULL);
INSERT INTO `products` VALUES (594, 0, 2, '9931', '9931copy.jpg', 11.9149, '2010-10-22 14:17:46', '2010-12-08 13:40:36', NULL, 0.00, 1, 1, 21, 0, NULL, NULL);
INSERT INTO `products` VALUES (595, 0, 1, '9930', '9930copy.jpg', 11.9149, '2010-10-22 15:09:29', '2010-12-08 13:40:08', NULL, 0.00, 1, 1, 21, 0, NULL, NULL);
INSERT INTO `products` VALUES (596, 0, 2, '9945', '9945copy.jpg', 14.4681, '2010-10-22 15:49:58', '2010-12-20 14:54:24', NULL, 0.00, 0, 1, 21, 0, NULL, NULL);
INSERT INTO `products` VALUES (597, 0, 2, 'HM140', 'HM140copy.jpg', 28.0851, '2010-10-22 16:04:40', '2010-10-22 16:08:00', NULL, 0.00, 1, 1, 21, 0, NULL, NULL);
INSERT INTO `products` VALUES (598, 0, 2, '9859BKGF', '9859BKGFcopy.jpg', 18.7234, '2010-10-22 16:13:08', '2010-10-22 16:16:00', NULL, 0.00, 1, 1, 21, 0, NULL, NULL);
INSERT INTO `products` VALUES (599, 0, 2, '9935/3GF', '9935~3GFcopy.jpg', 21.2766, '2010-10-22 16:20:16', '2010-10-22 16:30:15', NULL, 0.00, 1, 1, 21, 0, NULL, NULL);
INSERT INTO `products` VALUES (600, 0, 1, 'GN144', 'GN144copy.jpg', 106.3830, '2010-10-23 16:13:01', '2010-10-23 16:31:59', NULL, 0.00, 1, 1, 16, 0, NULL, NULL);
INSERT INTO `products` VALUES (601, 0, 1, 'GP620R', 'GP620Rcopy.jpg', 182.9787, '2010-10-23 16:41:01', '2010-10-23 17:56:50', NULL, 0.00, 1, 1, 16, 0, NULL, NULL);
INSERT INTO `products` VALUES (602, 0, 1, 'GP639', 'GP639copy.jpg', 102.1277, '2010-10-23 18:03:40', '2010-10-23 18:26:19', NULL, 0.00, 1, 1, 16, 0, NULL, NULL);
INSERT INTO `products` VALUES (603, 0, 1, 'GP522T', 'GP522Tcopy.jpg', 131.9149, '2010-10-23 18:10:57', '2010-12-20 15:54:55', NULL, 0.00, 0, 1, 16, 0, NULL, NULL);
INSERT INTO `products` VALUES (604, 0, 1, 'GP541', 'gp541copy1.jpg', 143.8298, '2010-10-23 18:19:36', '2010-10-23 18:25:22', NULL, 0.00, 1, 1, 16, 0, NULL, NULL);
INSERT INTO `products` VALUES (605, 0, 1, 'GP559G', 'gp559Gcopy1.jpg', 140.4255, '2010-10-23 18:27:46', '2010-10-23 18:33:30', NULL, 0.00, 1, 1, 16, 0, NULL, NULL);
INSERT INTO `products` VALUES (606, 0, 1, 'GE541', 'ge541copy1.jpg', 71.4894, '2010-10-23 18:49:53', '2010-10-23 18:55:19', NULL, 0.00, 1, 1, 16, 0, NULL, NULL);
INSERT INTO `products` VALUES (607, 0, 1, 'GE653', 'GE653copy.jpg', 102.1277, '2010-10-23 18:57:20', '2010-10-23 19:00:05', NULL, 0.00, 1, 1, 16, 0, NULL, NULL);
INSERT INTO `products` VALUES (608, 0, 1, 'GE548T', 'ge548Tcopy1.jpg', 109.7872, '2010-10-23 19:02:10', '2010-12-20 15:55:36', NULL, 0.00, 0, 1, 16, 0, NULL, NULL);
INSERT INTO `products` VALUES (609, 0, 1, 'GE565W', 'GE565Wcopy.jpg', 123.4043, '2010-10-23 19:10:51', '2010-10-23 19:20:49', NULL, 0.00, 1, 1, 16, 0, NULL, NULL);
INSERT INTO `products` VALUES (610, 0, 1, 'GE599', 'GE599copy.jpg', 178.7234, '2010-10-23 19:23:11', '2010-12-23 14:53:58', NULL, 0.00, 0, 1, 16, 0, NULL, NULL);
INSERT INTO `products` VALUES (611, 0, 1, 'GE631W', 'ge631Wcopy1.jpg', 75.7447, '2010-10-23 19:32:47', '2010-10-23 19:44:37', NULL, 0.00, 1, 1, 16, 0, NULL, NULL);
INSERT INTO `products` VALUES (612, 0, 1, 'GE658T', 'GE658Tcopy.jpg', 157.4468, '2010-10-23 19:49:16', '2010-10-23 19:56:49', NULL, 0.00, 1, 1, 16, 0, NULL, NULL);
INSERT INTO `products` VALUES (613, 0, 1, 'GP542W', 'gp542Wcopy1.jpg', 118.2979, '2010-10-23 20:00:08', '2010-10-23 20:17:23', NULL, 0.00, 1, 1, 16, 0, NULL, NULL);
INSERT INTO `products` VALUES (614, 0, 1, 'GP571', 'GP571copy.jpg', 212.7660, '2010-10-23 20:19:36', '2010-10-23 20:27:36', NULL, 0.00, 1, 1, 16, 0, NULL, NULL);
INSERT INTO `products` VALUES (615, 0, 1, 'GP602', 'gp602copy1.jpg', 127.6596, '2010-10-23 20:32:20', '2010-10-23 20:35:22', NULL, 0.00, 0, 1, 16, 0, NULL, NULL);
INSERT INTO `products` VALUES (616, 0, 1, 'GP627L', 'GP627Lcopy.jpg', 161.7021, '2010-10-23 20:38:43', '2010-10-23 20:44:43', NULL, 0.00, 1, 1, 16, 0, NULL, NULL);
INSERT INTO `products` VALUES (617, 0, 2, 'B3179C', 'jgesb3179C.jpg', 44.2553, '2010-10-26 16:06:04', '2010-12-22 09:07:28', NULL, 0.00, 1, 1, 16, 0, NULL, NULL);
INSERT INTO `products` VALUES (618, 0, 3, 'B3467', 'jgesb3467.jpg', 28.0851, '2010-10-26 16:19:58', '2010-12-20 16:46:28', NULL, 0.00, 0, 1, 16, 0, NULL, NULL);
INSERT INTO `products` VALUES (619, 0, 3, 'B3715T', 'jgesb3715T.jpg', 33.1915, '2010-10-26 16:40:37', '2010-10-26 16:46:16', NULL, 0.00, 1, 1, 16, 0, NULL, NULL);
INSERT INTO `products` VALUES (620, 0, 3, 'B3463C', 'jgesb3463c.jpg', 32.3404, '2010-10-26 16:53:07', '2010-10-26 16:57:41', NULL, 0.00, 1, 1, 16, 0, NULL, NULL);
INSERT INTO `products` VALUES (621, 0, 1, 'B3448', 'jgesb3448.jpg', 72.3404, '2010-10-26 17:02:47', '2010-10-26 17:07:23', NULL, 0.00, 1, 1, 16, 0, NULL, NULL);
INSERT INTO `products` VALUES (622, 0, 3, 'E3855T', 'jgese3855T.jpg', 13.6170, '2010-10-26 18:54:45', '2010-10-26 18:55:42', NULL, 0.00, 1, 1, 16, 0, NULL, NULL);
INSERT INTO `products` VALUES (623, 0, 1, 'E3804', 'jgese3804.jpg', 17.0213, '2010-10-26 19:01:15', '2010-12-11 14:51:16', NULL, 0.00, 1, 1, 16, 0, NULL, NULL);
INSERT INTO `products` VALUES (624, 0, 1, 'E3851C', 'jges_e3851C.jpg', 17.0213, '2010-10-26 19:06:49', '2010-10-26 19:07:36', NULL, 0.00, 1, 1, 16, 0, NULL, NULL);
INSERT INTO `products` VALUES (625, 0, 1, 'E3852', 'jges_e3852.jpg', 27.2340, '2010-10-26 19:11:32', '2010-10-28 12:07:19', NULL, 0.00, 1, 1, 16, 0, NULL, NULL);
INSERT INTO `products` VALUES (626, 0, 1, 'E3831C', 'jges_e3831C.jpg', 20.4255, '2010-10-26 19:14:07', '2010-10-28 12:04:12', NULL, 0.00, 1, 1, 16, 0, NULL, NULL);
INSERT INTO `products` VALUES (627, 0, 1, 'P3199', 'jges_p3199_N723.jpg', 28.0851, '2010-10-26 19:28:39', '2010-12-11 14:50:53', NULL, 0.00, 1, 1, 16, 0, NULL, NULL);
INSERT INTO `products` VALUES (628, 0, 1, 'N3071', 'jges_n3071.jpg', 50.2128, '2010-10-26 19:42:20', '2010-10-26 19:43:15', NULL, 0.00, 1, 1, 16, 0, NULL, NULL);
INSERT INTO `products` VALUES (629, 0, 1, '31065001', 'gest_31065001.jpg', 40.8511, '2010-10-26 20:47:43', '2010-10-26 20:51:56', NULL, 0.00, 1, 1, 26, 0, NULL, NULL);
INSERT INTO `products` VALUES (630, 0, 1, '31064001', 'gest_31064001.jpg', 58.7234, '2010-10-26 20:56:50', '2010-10-26 21:04:05', NULL, 0.00, 1, 1, 26, 0, NULL, NULL);
INSERT INTO `products` VALUES (631, 0, 1, '31058001', 'gpst_31058001.jpg', 46.8085, '2010-10-26 21:11:49', '2010-10-26 21:16:48', NULL, 0.00, 1, 1, 26, 0, NULL, NULL);
INSERT INTO `products` VALUES (632, 0, 1, '31001001', 'gest_31001001.jpg', 22.1277, '2010-10-26 21:21:20', '2010-10-26 21:24:31', NULL, 0.00, 1, 1, 26, 0, NULL, NULL);
INSERT INTO `products` VALUES (633, 0, 1, '31019001', 'gest_31019001.jpg', 30.6383, '2010-10-26 21:30:28', '2010-10-26 21:33:45', NULL, 0.00, 1, 1, 26, 0, NULL, NULL);
INSERT INTO `products` VALUES (634, 0, 1, '31083001', 'gest_31083001.jpg', 84.2553, '2010-10-26 21:46:53', '2010-10-26 21:51:39', NULL, 0.00, 1, 1, 26, 0, NULL, NULL);
INSERT INTO `products` VALUES (635, 0, 1, '31396001', 'gest_31396001.jpg', 39.1489, '2010-10-26 22:13:27', '2010-10-26 22:16:55', NULL, 0.00, 1, 1, 26, 0, NULL, NULL);
INSERT INTO `products` VALUES (636, 0, 1, '31604001', 'gest_31604001.jpg', 75.7447, '2010-10-26 22:23:03', '2010-10-26 22:26:04', NULL, 0.00, 1, 1, 26, 0, NULL, NULL);
INSERT INTO `products` VALUES (637, 0, 1, '31632001', 'gest_31632001.jpg', 45.1064, '2010-10-26 22:32:00', '2010-12-23 14:27:15', NULL, 0.00, 1, 1, 26, 0, NULL, NULL);
INSERT INTO `products` VALUES (638, 0, 1, '31771001', 'gest_31771001.jpg', 38.2979, '2010-10-26 22:39:51', '2010-10-26 22:44:14', NULL, 0.00, 1, 1, 26, 0, NULL, NULL);
INSERT INTO `products` VALUES (639, 0, 1, '31522001', 'gest_31522001.jpg', 38.2979, '2010-10-26 22:52:17', '2010-10-26 22:55:23', NULL, 0.00, 1, 1, 26, 0, NULL, NULL);
INSERT INTO `products` VALUES (640, 0, 1, '31391001', 'gest_31391001.jpg', 34.0426, '2010-10-26 23:00:23', '2010-10-26 23:06:16', NULL, 0.00, 1, 1, 26, 0, NULL, NULL);
INSERT INTO `products` VALUES (641, 0, 1, '31602001', 'gest_31602001.jpg', 107.2340, '2010-10-26 23:12:12', '2010-10-26 23:15:15', NULL, 0.00, 1, 1, 26, 0, NULL, NULL);
INSERT INTO `products` VALUES (642, 0, 2, '31383001', 'gest_31383001.jpg', 28.9362, '2010-10-26 23:22:12', '2010-10-26 23:25:17', NULL, 0.00, 1, 1, 26, 0, NULL, NULL);
INSERT INTO `products` VALUES (643, 0, 1, '31679001', 'gest_31679001.jpg', 63.8298, '2010-10-26 23:29:54', '2010-10-26 23:33:22', NULL, 0.00, 1, 1, 26, 0, NULL, NULL);
INSERT INTO `products` VALUES (644, 0, 1, '31523001', 'gest_31523001.jpg', 41.7021, '2010-10-27 07:50:47', '2010-10-27 07:54:32', NULL, 0.00, 1, 1, 26, 0, NULL, NULL);
INSERT INTO `products` VALUES (645, 0, 1, '31525001', 'gest_31525001.jpg', 58.7234, '2010-10-27 07:59:33', '2010-10-27 08:02:37', NULL, 0.00, 1, 1, 26, 0, NULL, NULL);
INSERT INTO `products` VALUES (646, 0, 1, '31552001', 'gest_31552001.jpg', 58.7234, '2010-10-27 08:06:10', '2010-10-27 08:10:07', NULL, 0.00, 1, 1, 26, 0, NULL, NULL);
INSERT INTO `products` VALUES (648, 0, 1, '31633001', 'gest_31633001.jpg', 41.7021, '2010-10-27 16:25:57', '2010-10-27 16:33:52', NULL, 0.00, 1, 1, 26, 0, NULL, NULL);
INSERT INTO `products` VALUES (649, 0, 1, '31677001', 'gest_31677001.jpg', 64.6809, '2010-10-27 17:07:49', '2010-10-27 17:09:07', NULL, 0.00, 1, 1, 26, 0, NULL, NULL);
INSERT INTO `products` VALUES (650, 0, 1, '31759001', 'gest_31759001.jpg', 35.7447, '2010-10-27 17:16:31', '2010-10-27 17:17:17', NULL, 0.00, 1, 1, 26, 0, NULL, NULL);
INSERT INTO `products` VALUES (651, 0, 1, '31760001', 'gest_31760001.jpg', 58.7234, '2010-10-27 17:24:08', '2010-10-27 17:24:47', NULL, 0.00, 1, 1, 26, 0, NULL, NULL);
INSERT INTO `products` VALUES (652, 0, 1, '31906001', 'gest_31906001.jpg', 50.2128, '2010-10-27 17:32:33', '2010-10-27 17:33:25', NULL, 0.00, 1, 1, 26, 0, NULL, NULL);
INSERT INTO `products` VALUES (653, 0, 1, '31833001', 'gest_31833001.jpg', 40.8511, '2010-10-27 17:37:56', '2010-10-27 17:40:37', NULL, 0.00, 1, 1, 26, 0, NULL, NULL);
INSERT INTO `products` VALUES (654, 0, 1, '31867001', 'gest_31867001.jpg', 52.7660, '2010-10-27 17:45:06', '2010-10-27 17:47:31', NULL, 0.00, 1, 1, 26, 0, NULL, NULL);
INSERT INTO `products` VALUES (655, 0, 1, '31890001', 'gest_31890001.jpg', 63.8298, '2010-10-27 17:59:23', '2010-10-27 18:00:15', NULL, 0.00, 1, 1, 26, 0, NULL, NULL);
INSERT INTO `products` VALUES (656, 0, 1, '35578001', 'gest_35578001.jpg', 41.7021, '2010-10-27 18:10:37', '2010-10-27 18:12:06', NULL, 0.00, 1, 1, 26, 0, NULL, NULL);
INSERT INTO `products` VALUES (657, 0, 1, '35362001', 'gest_35362001.jpg', 55.3191, '2010-10-27 18:19:39', '2010-10-27 18:22:22', NULL, 0.00, 1, 1, 26, 0, NULL, NULL);
INSERT INTO `products` VALUES (658, 0, 1, '35018001', 'gest_35018001.jpg', 67.2340, '2010-10-27 18:34:33', '2010-10-27 18:35:05', NULL, 0.00, 1, 1, 26, 0, NULL, NULL);
INSERT INTO `products` VALUES (659, 0, 1, '35436001', 'gest_35436001.jpg', 84.2553, '2010-10-27 18:40:59', '2010-10-27 18:41:52', NULL, 0.00, 1, 1, 26, 0, NULL, NULL);
INSERT INTO `products` VALUES (660, 0, 1, '35454001', 'gest_35454001.jpg', 37.4468, '2010-10-27 18:48:10', '2010-10-27 18:48:52', NULL, 0.00, 1, 1, 26, 0, NULL, NULL);
INSERT INTO `products` VALUES (661, 0, 1, '36105001', 'gest_36105001.jpg', 22.1277, '2010-10-27 18:57:35', '2010-11-17 18:32:34', NULL, 0.00, 1, 1, 26, 0, NULL, NULL);
INSERT INTO `products` VALUES (662, 0, 1, '36208001', 'gest_36208001.jpg', 20.4255, '2010-10-27 19:08:05', '2010-12-20 14:57:15', NULL, 0.00, 0, 1, 26, 0, NULL, NULL);
INSERT INTO `products` VALUES (663, 0, 1, '36915001', 'gest_36915001.jpg', 29.7872, '2010-10-27 19:15:20', '2010-12-23 14:24:03', NULL, 0.00, 1, 1, 26, 0, NULL, NULL);
INSERT INTO `products` VALUES (664, 0, 1, '36207001', 'gest_36207001.jpg', 16.1702, '2010-10-27 19:21:02', '2010-10-27 19:21:36', NULL, 0.00, 1, 1, 26, 0, NULL, NULL);
INSERT INTO `products` VALUES (665, 0, 1, '36104001', 'gest_36104001.jpg', 20.4255, '2010-10-27 19:28:38', '2010-10-27 19:29:09', NULL, 0.00, 1, 1, 26, 0, NULL, NULL);
INSERT INTO `products` VALUES (666, 0, 1, '36916001', 'gest_36916001.jpg', 27.2340, '2010-10-27 19:36:32', '2010-10-27 19:37:06', NULL, 0.00, 1, 1, 26, 0, NULL, NULL);
INSERT INTO `products` VALUES (667, 0, 1, '36006001', 'gest_36006001.jpg', 29.7872, '2010-10-27 19:44:28', '2010-10-27 19:46:13', NULL, 0.00, 1, 1, 26, 0, NULL, NULL);
INSERT INTO `products` VALUES (668, 0, 2, '36068001', 'gest_36068001.jpg', 10.2128, '2010-10-27 19:52:22', '2010-10-27 19:52:57', NULL, 0.00, 1, 1, 26, 0, NULL, NULL);
INSERT INTO `products` VALUES (669, 0, 3, 'B3333', 'jges_b3333.jpg', 28.0851, '2010-10-28 12:44:11', '2010-10-28 14:29:36', NULL, 0.00, 1, 1, 16, 0, NULL, NULL);
INSERT INTO `products` VALUES (670, 0, 5, 'B3334', 'jges_b3334.jpg', 30.6383, '2010-10-28 13:09:52', '2010-11-19 14:38:07', NULL, 0.00, 1, 1, 16, 0, NULL, NULL);
INSERT INTO `products` VALUES (671, 0, 1, 'E3637', 'jges_e3637.jpg', 21.2766, '2010-10-28 14:01:22', '2010-10-28 14:10:48', NULL, 0.00, 1, 1, 16, 0, NULL, NULL);
INSERT INTO `products` VALUES (672, 0, 5, 'B3335', 'jges_b3335.jpg', 32.3404, '2010-10-28 14:27:57', '2010-11-19 14:38:20', NULL, 0.00, 1, 1, 16, 0, NULL, NULL);
INSERT INTO `products` VALUES (674, 0, 1, '4425', 'wsey_4425.jpg', 53.6085, '2010-10-28 16:21:33', '2010-10-28 16:25:25', NULL, 0.00, 1, 1, 14, 0, NULL, NULL);
INSERT INTO `products` VALUES (675, 0, 1, '4421', 'wsey_4421.jpg', 38.2894, '2010-10-28 16:40:45', '2010-10-28 16:49:56', NULL, 0.00, 1, 1, 14, 0, NULL, NULL);
INSERT INTO `products` VALUES (676, 0, 1, '4429', 'wsey_4429.jpg', 53.6085, '2010-10-28 16:54:45', '2010-12-24 17:12:57', NULL, 0.00, 0, 1, 14, 0, NULL, NULL);
INSERT INTO `products` VALUES (677, 0, 1, '31056001', 'gest_31056001.jpg', 35.7447, '2010-10-28 17:57:57', '2010-10-29 09:00:22', NULL, 0.00, 1, 1, 26, 0, NULL, NULL);
INSERT INTO `products` VALUES (678, 0, 3, 'Y2489', 'jgsb_y2489.jpg', 11.0638, '2010-10-30 16:01:28', '2010-10-30 16:02:02', NULL, 0.00, 1, 1, 16, 0, NULL, NULL);
INSERT INTO `products` VALUES (679, 0, 1, 'SL1405', 'wacc_sl1405(2).jpg', 225.0000, '2010-11-03 17:00:48', '2010-12-26 09:41:47', NULL, 0.00, 1, 0, 13, 0, NULL, NULL);
INSERT INTO `products` VALUES (680, 0, 3, 'Y2458', 'jgsb_y2458.jpg', 6.8085, '2010-11-06 09:35:26', '2010-11-06 09:37:00', NULL, 0.00, 1, 1, 16, 0, NULL, NULL);
INSERT INTO `products` VALUES (681, 0, 3, 'N2712C', 'jges_n2712c.jpg', 24.6809, '2010-11-06 09:50:19', '2010-11-06 09:51:24', NULL, 0.00, 1, 1, 16, 0, NULL, NULL);
INSERT INTO `products` VALUES (682, 0, 1, 'LB1196P', 'wacc_lb1196 copy.jpg', 55.3191, '2010-11-09 14:31:46', '2010-11-09 14:37:28', NULL, 0.00, 1, 1, 13, 0, NULL, NULL);
INSERT INTO `products` VALUES (683, 0, 1, '62526001', 'grst_62526001.jpg', 72.3404, '2010-11-10 16:29:21', '2010-11-10 18:08:31', NULL, 0.00, 1, 1, 26, 0, NULL, NULL);
INSERT INTO `products` VALUES (684, 0, 1, '62527001', 'grst_62527001.jpg', 106.3830, '2010-11-10 18:06:20', '2010-11-10 18:07:18', NULL, 0.00, 1, 1, 26, 0, NULL, NULL);
INSERT INTO `products` VALUES (685, 0, 1, '62528001', 'grst_62528001.jpg', 165.9574, '2010-11-10 18:18:27', '2010-11-10 18:25:01', NULL, 0.00, 1, 1, 26, 0, NULL, NULL);
INSERT INTO `products` VALUES (686, 0, 1, '62529001', 'grst_62529001.jpg', 212.7660, '2010-11-10 18:24:19', '2010-11-10 18:29:44', NULL, 0.00, 1, 1, 26, 0, NULL, NULL);
INSERT INTO `products` VALUES (687, 0, 1, '62526a01', 'grst_62526a01.jpg', 102.1277, '2010-11-10 18:40:39', '2010-11-10 18:43:47', NULL, 0.00, 1, 1, 26, 0, NULL, NULL);
INSERT INTO `products` VALUES (688, 0, 1, '52527a01', 'grst_62527a01.jpg', 131.9149, '2010-11-10 19:04:57', '2010-11-10 19:05:31', NULL, 0.00, 1, 1, 26, 0, NULL, NULL);
INSERT INTO `products` VALUES (689, 0, 1, '62528a01', 'grst_62528a01.jpg', 182.9787, '2010-11-10 19:11:56', '2010-11-10 19:12:32', NULL, 0.00, 1, 1, 26, 0, NULL, NULL);
INSERT INTO `products` VALUES (690, 0, 1, '62529a01', 'grst_62529a01.jpg', 212.7660, '2010-11-10 19:22:21', '2010-11-10 19:22:57', NULL, 0.00, 1, 1, 26, 0, NULL, NULL);
INSERT INTO `products` VALUES (691, 0, 1, '62540b01', 'grst_62540B01.jpg', 123.4043, '2010-11-10 19:30:49', '2010-11-10 19:31:28', NULL, 0.00, 1, 1, 26, 0, NULL, NULL);
INSERT INTO `products` VALUES (692, 0, 1, '62541b01', 'grst_62541B01.jpg', 157.4468, '2010-11-10 19:39:11', '2010-11-10 19:40:04', NULL, 0.00, 1, 1, 26, 0, NULL, NULL);
INSERT INTO `products` VALUES (693, 0, 1, '62542b01', 'grst_62542B01.jpg', 212.7660, '2010-11-11 09:10:13', '2010-11-11 09:10:48', NULL, 0.00, 1, 1, 26, 0, NULL, NULL);
INSERT INTO `products` VALUES (694, 0, 1, '62543b01', 'grst_62543B01.jpg', 276.5957, '2010-11-11 09:19:15', '2010-11-11 09:19:51', NULL, 0.00, 1, 1, 26, 0, NULL, NULL);
INSERT INTO `products` VALUES (695, 0, 1, '62440b01', '62440B01.jpg', 106.3830, '2010-11-11 09:25:35', '2010-11-11 09:26:15', NULL, 0.00, 1, 1, 0, 0, NULL, NULL);
INSERT INTO `products` VALUES (696, 0, 1, '62441b01', 'grst_62441b01.jpg', 157.4468, '2010-11-11 09:33:41', '2010-11-11 13:35:11', NULL, 0.00, 1, 1, 26, 0, NULL, NULL);
INSERT INTO `products` VALUES (697, 0, 1, '62442b01', 'grst_62442b01.jpg', 191.4894, '2010-11-11 09:39:36', '2010-11-11 13:35:55', NULL, 0.00, 1, 1, 26, 0, NULL, NULL);
INSERT INTO `products` VALUES (698, 0, 1, '62443b01', 'grst_62443b01.jpg', 251.0638, '2010-11-11 09:47:07', '2010-11-11 13:37:07', NULL, 0.00, 1, 1, 26, 0, NULL, NULL);
INSERT INTO `products` VALUES (699, 0, 1, '62430a01', 'grst_62430001.jpg', 93.6170, '2010-11-11 10:03:45', '2010-11-11 10:04:18', NULL, 0.00, 1, 1, 26, 0, NULL, NULL);
INSERT INTO `products` VALUES (700, 0, 1, '62431001', 'grst_62431001.jpg', 102.1277, '2010-11-11 10:12:02', '2010-11-11 10:12:33', NULL, 0.00, 1, 1, 26, 0, NULL, NULL);
INSERT INTO `products` VALUES (701, 0, 1, '62432001', 'grst_62432001.jpg', 131.9149, '2010-11-11 10:18:06', '2010-11-11 10:18:38', NULL, 0.00, 1, 1, 26, 0, NULL, NULL);
INSERT INTO `products` VALUES (702, 0, 1, '62433001', 'grst_62433001.jpg', 191.4894, '2010-11-11 10:23:46', '2010-11-11 10:24:12', NULL, 0.00, 1, 1, 26, 0, NULL, NULL);
INSERT INTO `products` VALUES (703, 0, 1, '62426001', 'grst_62426001.jpg', 63.8298, '2010-11-11 10:52:37', '2010-11-11 11:03:06', NULL, 0.00, 1, 1, 26, 0, NULL, NULL);
INSERT INTO `products` VALUES (704, 0, 1, '62427001', 'grst_62427001.jpg', 93.6170, '2010-11-11 11:10:42', '2010-11-11 11:11:12', NULL, 0.00, 1, 1, 26, 0, NULL, NULL);
INSERT INTO `products` VALUES (705, 0, 1, '62428001', 'grst_62428001.jpg', 144.6809, '2010-11-11 11:15:54', '2010-11-11 11:17:02', NULL, 0.00, 1, 1, 26, 0, NULL, NULL);
INSERT INTO `products` VALUES (706, 0, 1, '62429001', 'grst_62429001.jpg', 195.7447, '2010-11-11 11:31:54', '2010-11-11 11:32:21', NULL, 0.00, 1, 1, 26, 0, NULL, NULL);
INSERT INTO `products` VALUES (707, 0, 1, '', 'grst_62426A01.jpg', 80.8511, '2010-11-11 11:56:42', '2010-11-11 12:15:20', NULL, 0.00, 1, 1, 26, 0, NULL, NULL);
INSERT INTO `products` VALUES (708, 0, 1, '62427a01', 'grst_62427A01.jpg', 119.1489, '2010-11-11 12:34:13', '2010-11-11 13:34:03', NULL, 0.00, 1, 1, 26, 0, NULL, NULL);
INSERT INTO `products` VALUES (709, 0, 1, '62428a01', 'grst_62428A01.jpg', 161.7021, '2010-11-11 12:41:42', '2010-11-11 13:36:25', NULL, 0.00, 1, 1, 26, 0, NULL, NULL);
INSERT INTO `products` VALUES (710, 0, 1, '62441g01', 'grst_62441g01.jpg', 148.9362, '2010-11-11 13:48:05', '2010-11-24 17:35:15', NULL, 0.00, 1, 1, 26, 0, NULL, NULL);
INSERT INTO `products` VALUES (711, 0, 1, '62443G01', 'grst_62443g01.jpg', 251.0638, '2010-11-11 13:53:12', '2010-11-24 17:40:12', NULL, 0.00, 1, 1, 26, 0, NULL, NULL);
INSERT INTO `products` VALUES (712, 0, 1, '62442j21', 'grst_62442j21.jpg', 251.0638, '2010-11-11 14:01:33', '2010-11-24 17:38:33', NULL, 0.00, 1, 1, 26, 0, NULL, NULL);
INSERT INTO `products` VALUES (713, 0, 1, '62441j21', 'grst_62441j21.jpg', 191.4894, '2010-11-11 14:09:00', '2010-11-24 17:37:26', NULL, 0.00, 1, 1, 26, 0, NULL, NULL);
INSERT INTO `products` VALUES (714, 0, 1, '62541j21', 'grst_62541j21.jpg', 200.0000, '2010-11-11 14:19:05', '2010-11-24 17:32:13', NULL, 0.00, 1, 1, 26, 0, NULL, NULL);
INSERT INTO `products` VALUES (715, 0, 1, '62542j21', 'grst_62542j21.jpg', 251.0638, '2010-11-11 14:30:49', '2010-11-24 17:33:13', NULL, 0.00, 1, 1, 26, 0, NULL, NULL);
INSERT INTO `products` VALUES (716, 0, 1, '4277', 'wsey_4277.jpg', 53.6085, '2010-11-11 16:41:08', '2010-12-04 09:41:09', NULL, 0.00, 1, 1, 14, 0, NULL, NULL);
INSERT INTO `products` VALUES (717, 0, 1, 'R35633', 'geem_r35633.jpg', 84.2553, '2010-11-17 16:52:00', '2010-11-17 16:57:07', NULL, 0.00, 1, 1, 27, 0, NULL, NULL);
INSERT INTO `products` VALUES (718, 0, 1, 'R35252', 'geem_r35252.jpg', 84.2553, '2010-11-17 17:25:56', '2010-12-02 15:45:00', NULL, 0.00, 1, 1, 27, 0, NULL, NULL);
INSERT INTO `products` VALUES (719, 0, 1, 'R35493', 'geem_r35493.JPG', 63.8298, '2010-11-17 17:31:18', '2010-11-17 17:32:16', NULL, 0.00, 1, 1, 27, 0, NULL, NULL);
INSERT INTO `products` VALUES (720, 0, 1, 'R35531', 'geem_r35531.jpg', 42.5532, '2010-11-17 17:36:36', '2010-11-17 17:37:26', NULL, 0.00, 1, 1, 27, 0, NULL, NULL);
INSERT INTO `products` VALUES (721, 0, 1, 'R35495', 'geem_r35495.jpg', 84.2553, '2010-11-17 17:40:44', '2010-12-10 12:54:27', NULL, 0.00, 0, 1, 27, 0, NULL, NULL);
INSERT INTO `products` VALUES (722, 0, 1, 'R35607', 'geem_r35607.jpg', 55.3191, '2010-11-17 17:50:57', '2010-11-17 17:53:28', NULL, 0.00, 1, 1, 27, 0, NULL, NULL);
INSERT INTO `products` VALUES (723, 0, 1, 'R35637', 'geem_r35637.JPG', 72.3404, '2010-11-17 17:56:38', '2010-11-17 17:57:46', NULL, 0.00, 1, 1, 27, 0, NULL, NULL);
INSERT INTO `products` VALUES (724, 0, 1, 'R35280', 'geem_r35280.jpg', 97.8723, '2010-11-17 18:02:33', '2010-11-17 18:04:06', NULL, 0.00, 1, 1, 27, 0, NULL, NULL);
INSERT INTO `products` VALUES (725, 0, 2, 'R35610', 'geem_r35610.jpg', 46.8085, '2010-11-18 09:12:35', '2010-11-18 09:14:56', NULL, 0.00, 1, 1, 27, 0, NULL, NULL);
INSERT INTO `products` VALUES (726, 0, 1, 'R30226', 'geem_r30226copy.jpg', 27.2340, '2010-11-18 09:20:21', '2010-11-18 09:25:29', NULL, 0.00, 1, 1, 27, 0, NULL, NULL);
INSERT INTO `products` VALUES (729, 0, 3, 'N3082T', 'jges_n3082t.jpg', 30.6383, '2010-11-19 15:07:47', '2010-11-19 15:08:23', NULL, 0.00, 1, 1, 16, 0, NULL, NULL);
INSERT INTO `products` VALUES (731, 0, 1, '3560501', 'gest_35605001.jpg', 28.9362, '2010-11-24 18:05:41', '2010-11-24 18:06:08', NULL, 0.00, 0, 1, 26, 0, NULL, NULL);
INSERT INTO `products` VALUES (732, 0, 1, '3561501', 'gest_35615001.jpg', 31.4894, '2010-11-24 18:07:30', '2010-12-17 14:24:11', NULL, 0.00, 1, 1, 26, 0, NULL, NULL);
INSERT INTO `products` VALUES (733, 0, 1, '35639001', 'gest_35639001.jpg', 37.4468, '2010-11-24 18:10:28', '2010-12-08 15:43:51', NULL, 0.00, 1, 1, 0, 0, NULL, NULL);
INSERT INTO `products` VALUES (734, 0, 1, '3564301', 'gest_35643001.jpg', 37.4468, '2010-11-24 18:13:01', '2010-12-08 15:40:35', NULL, 0.00, 1, 1, 26, 0, NULL, NULL);
INSERT INTO `products` VALUES (735, 0, 1, '3017', 'wsek_3017.jpg', 23.8213, '2010-12-01 14:17:38', '2010-12-01 14:18:39', NULL, 0.00, 1, 1, 14, 0, NULL, NULL);
INSERT INTO `products` VALUES (736, 0, 1, '3243', 'wsek_3243.jpg', 19.5660, '2010-12-01 14:31:24', '2010-12-01 14:44:16', NULL, 0.00, 1, 1, 14, 0, NULL, NULL);
INSERT INTO `products` VALUES (737, 0, 1, '3469', 'wsek_3469.jpg', 31.4809, '2010-12-01 14:47:04', '2010-12-01 14:54:01', NULL, 0.00, 1, 1, 14, 0, NULL, NULL);
INSERT INTO `products` VALUES (739, 0, 1, '3623', 'wsek_3623.jpg', 15.3106, '2010-12-01 15:01:54', '2010-12-01 15:03:31', NULL, 0.00, 1, 1, 14, 0, NULL, NULL);
INSERT INTO `products` VALUES (740, 0, 1, '3747', 'wsek_3747.jpg', 23.8213, '2010-12-01 15:06:38', '2010-12-01 15:07:38', NULL, 0.00, 1, 1, 14, 0, NULL, NULL);
INSERT INTO `products` VALUES (741, 0, 2, '3751', 'wsek_3751.jpg', 17.8638, '2010-12-01 15:11:00', '2010-12-01 15:11:40', NULL, 0.00, 1, 1, 14, 0, NULL, NULL);
INSERT INTO `products` VALUES (742, 0, 1, '3779', 'wsek_3779.jpg', 23.8213, '2010-12-01 15:13:28', '2010-12-01 15:17:35', NULL, 0.00, 1, 1, 14, 0, NULL, NULL);
INSERT INTO `products` VALUES (743, 0, 1, '4352', 'wsek_4352.jpg', 27.2255, '2010-12-04 13:26:29', '2010-12-04 13:27:00', NULL, 0.00, 1, 1, 14, 0, NULL, NULL);
INSERT INTO `products` VALUES (744, 0, 1, '4355', 'wsek_4355.jpg', 31.4809, '2010-12-04 13:28:45', '2010-12-04 13:31:06', NULL, 0.00, 1, 1, 14, 0, NULL, NULL);
INSERT INTO `products` VALUES (745, 0, 1, '4385', 'wsek_4385.jpg', 39.1404, '2010-12-04 13:32:52', '2010-12-04 13:34:45', NULL, 0.00, 1, 1, 14, 0, NULL, NULL);
INSERT INTO `products` VALUES (746, 0, 1, '4391', 'wsek_4391.jpg', 39.1404, '2010-12-04 13:36:12', '2010-12-04 13:38:26', NULL, 0.00, 1, 1, 14, 0, NULL, NULL);
INSERT INTO `products` VALUES (747, 0, 1, '4392', 'wsek_4392.jpg', 39.1404, '2010-12-04 13:39:50', '2010-12-22 14:33:46', NULL, 0.00, 0, 1, 14, 0, NULL, NULL);
INSERT INTO `products` VALUES (748, 0, 1, '4415', 'wsek_4415.jpg', 35.7362, '2010-12-04 13:41:24', '2010-12-04 13:45:12', NULL, 0.00, 1, 1, 14, 0, NULL, NULL);
INSERT INTO `products` VALUES (749, 0, 1, '4416', 'wsek_4416.jpg', 19.5660, '2010-12-04 13:46:52', '2010-12-04 13:48:08', NULL, 0.00, 1, 1, 14, 0, NULL, NULL);
INSERT INTO `products` VALUES (750, 0, 1, '4441', 'wsek_4441.jpg', 27.2255, '2010-12-04 13:49:32', '2010-12-04 13:49:58', NULL, 0.00, 1, 1, 14, 0, NULL, NULL);
INSERT INTO `products` VALUES (751, 0, 1, '4442', 'wsek_4442.jpg', 27.2255, '2010-12-04 13:51:14', '2010-12-04 13:51:46', NULL, 0.00, 1, 1, 14, 0, NULL, NULL);
INSERT INTO `products` VALUES (752, 0, 3, '4453', 'wsek_4453.jpg', 31.4809, '2010-12-04 14:05:09', '2010-12-07 14:20:07', NULL, 0.00, 1, 1, 14, 0, NULL, NULL);
INSERT INTO `products` VALUES (753, 0, 1, '3281', 'wsek_3281.jpg', 22.1191, '2010-12-04 14:15:17', '2010-12-04 14:21:40', NULL, 0.00, 1, 1, 14, 0, NULL, NULL);
INSERT INTO `products` VALUES (754, 0, 1, '3329', 'wsek_3329.jpg', 31.4809, '2010-12-04 14:23:00', '2010-12-22 15:26:28', NULL, 0.00, 0, 1, 14, 0, NULL, NULL);
INSERT INTO `products` VALUES (755, 0, 1, '3330', 'wsek_3330.jpg', 36.9900, '2010-12-04 14:25:46', '2010-12-04 15:54:15', NULL, 0.00, 1, 0, 14, 0, NULL, NULL);
INSERT INTO `products` VALUES (756, 0, 1, '3335', 'wsek_3335.jpg', 35.7362, '2010-12-04 15:20:02', '2010-12-04 15:20:54', NULL, 0.00, 1, 1, 14, 0, NULL, NULL);
INSERT INTO `products` VALUES (757, 0, 1, '3341', 'wsek_3341.jpg', 25.5234, '2010-12-04 15:25:04', '2010-12-04 15:27:16', NULL, 0.00, 1, 1, 14, 0, NULL, NULL);
INSERT INTO `products` VALUES (758, 0, 1, '3342', 'wsek_3342.jpg', 31.4809, '2010-12-04 15:51:07', '2010-12-13 16:23:35', NULL, 0.00, 0, 1, 14, 0, NULL, NULL);
INSERT INTO `products` VALUES (759, 0, 2, 'LB1403P', 'wacc_lb1403round.jpg', 93.6170, '2010-12-07 13:44:23', '2010-12-26 09:40:23', NULL, 0.00, 1, 1, 13, 0, NULL, NULL);
INSERT INTO `products` VALUES (760, 0, 3, '9924', 'pwb_9924.jpg', 11.9149, '2010-12-08 13:21:37', '2010-12-08 13:41:06', NULL, 0.00, 1, 1, 21, 0, NULL, NULL);
INSERT INTO `products` VALUES (761, 0, 2, '9949', 'pwb_9949~6gf.jpg', 19.5745, '2010-12-08 13:31:56', '2010-12-08 13:38:51', NULL, 0.00, 1, 1, 21, 0, NULL, NULL);
INSERT INTO `products` VALUES (762, 0, 2, '9925', 'pwb_9925~4gf.jpg', 17.0213, '2010-12-08 13:42:55', '2010-12-08 13:48:43', NULL, 0.00, 1, 1, 21, 0, NULL, NULL);
INSERT INTO `products` VALUES (775, 0, 1, '62323001', 'grst_62323001.jpg', 306.3830, '2010-12-21 17:07:55', '2010-12-21 17:08:30', NULL, 0.00, 1, 1, 26, 0, NULL, NULL);
INSERT INTO `products` VALUES (773, 0, 1, 'P2952', 'jgdd_p2952.jpg', 31.4894, '2010-12-15 13:54:34', '2010-12-15 14:22:20', NULL, 0.00, 1, 1, 16, 0, NULL, NULL);
INSERT INTO `products` VALUES (772, 0, 4, 'lb1702b', 'wacc_lb1702b.jpg', 97.8723, '2010-12-13 12:12:00', '2010-12-26 09:40:44', NULL, 0.00, 1, 1, 13, 0, NULL, NULL);
INSERT INTO `products` VALUES (771, 0, 2, '4048', 'wsey_4048.jpg', 38.2894, '2010-12-11 10:26:49', '2010-12-11 10:27:15', NULL, 0.00, 1, 1, 14, 0, NULL, NULL);
INSERT INTO `products` VALUES (774, 0, 1, '62322001', 'grst_62322001.jpg', 306.3830, '2010-12-21 16:57:48', '2010-12-21 17:08:52', NULL, 0.00, 1, 1, 26, 0, NULL, NULL);
INSERT INTO `products` VALUES (770, 0, 2, '4418', 'wsey_4418.jpg', 53.6085, '2010-12-11 09:36:16', '2010-12-11 09:41:48', NULL, 0.00, 1, 1, 14, 0, NULL, NULL);
INSERT INTO `products` VALUES (776, 0, 1, '62324001', 'grst_62324001.jpg', 404.2553, '2010-12-21 17:13:35', '2010-12-21 17:14:10', NULL, 0.00, 1, 1, 26, 0, NULL, NULL);
INSERT INTO `products` VALUES (777, 0, 1, '62325001', 'grst_62325001.jpg', 404.2553, '2010-12-21 17:18:13', '2010-12-21 17:19:55', NULL, 0.00, 1, 1, 26, 0, NULL, NULL);
INSERT INTO `products` VALUES (778, 0, 2, 'Y2202', 'jgsc_y2202.jpg', 10.2128, '2010-12-22 09:13:11', '2010-12-22 09:17:59', NULL, 0.00, 1, 1, 16, 0, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `products_attributes`
--

CREATE TABLE `products_attributes` (
  `products_attributes_id` int(11) NOT NULL auto_increment,
  `products_id` int(11) NOT NULL,
  `options_id` int(11) NOT NULL,
  `options_values_id` int(11) NOT NULL,
  `options_values_price` decimal(15,4) NOT NULL,
  `price_prefix` char(1) NOT NULL,
  PRIMARY KEY  (`products_attributes_id`),
  KEY `idx_products_attributes_products_id` (`products_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=4480 ;

--
-- Dumping data for table `products_attributes`
--

INSERT INTO `products_attributes` VALUES (29, 1, 1, 2, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (28, 1, 2, 4, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (31, 1, 3, 5, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (32, 1, 4, 7, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (33, 1, 5, 12, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (34, 1, 6, 9, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (35, 3, 4, 7, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (36, 3, 1, 1, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (37, 3, 3, 5, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (38, 3, 5, 13, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (39, 3, 6, 9, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (40, 5, 1, 1, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (41, 6, 1, 1, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (42, 7, 1, 1, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (43, 8, 1, 1, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (44, 9, 1, 1, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (45, 10, 1, 1, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (46, 11, 1, 1, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (47, 12, 1, 1, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (48, 13, 1, 1, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (49, 14, 1, 1, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (50, 15, 1, 1, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (51, 16, 1, 1, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (52, 17, 1, 1, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (53, 18, 1, 1, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (54, 19, 1, 1, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (55, 20, 1, 1, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (56, 21, 1, 1, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (57, 22, 1, 1, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (58, 23, 1, 1, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (59, 24, 1, 1, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (2266, 460, 4, 7, 0.0000, '');
INSERT INTO `products_attributes` VALUES (61, 26, 1, 1, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (62, 27, 1, 1, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (63, 28, 1, 1, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (64, 29, 1, 1, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (65, 30, 1, 1, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (66, 31, 1, 1, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (67, 32, 1, 1, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (68, 33, 1, 1, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (69, 34, 1, 1, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (70, 35, 1, 1, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (71, 36, 1, 1, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (72, 37, 1, 1, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (73, 38, 1, 1, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (74, 39, 1, 1, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (75, 40, 1, 1, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (76, 41, 1, 1, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (77, 42, 1, 1, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (78, 43, 1, 1, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (79, 44, 1, 1, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (80, 45, 1, 2, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (81, 46, 1, 2, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (82, 47, 1, 2, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (83, 48, 1, 2, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (84, 49, 1, 2, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (85, 50, 1, 2, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (86, 51, 1, 2, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (87, 52, 1, 2, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (88, 53, 1, 2, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (89, 54, 1, 2, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (90, 55, 1, 2, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (91, 56, 1, 2, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (92, 57, 1, 2, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (93, 58, 1, 2, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (94, 59, 1, 2, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (95, 60, 1, 2, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (96, 61, 1, 2, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (97, 62, 1, 2, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (98, 63, 1, 2, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (99, 64, 1, 2, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (100, 65, 1, 2, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (101, 66, 1, 2, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (102, 67, 1, 2, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (103, 68, 1, 2, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (104, 69, 1, 2, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (105, 70, 1, 2, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (106, 71, 1, 2, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (107, 72, 1, 2, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (108, 73, 1, 2, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (109, 74, 1, 2, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (110, 75, 1, 2, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (111, 76, 1, 2, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (112, 77, 1, 2, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (113, 78, 1, 1, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (114, 79, 1, 1, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (115, 5, 2, 4, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (116, 6, 2, 4, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (117, 7, 2, 4, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (118, 8, 2, 3, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (119, 9, 2, 14, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (120, 10, 2, 4, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (121, 11, 2, 3, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (122, 12, 2, 15, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (123, 13, 2, 3, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (124, 14, 2, 3, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (125, 15, 2, 4, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (126, 16, 2, 4, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (127, 17, 2, 4, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (128, 18, 2, 4, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (129, 19, 2, 4, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (130, 20, 2, 3, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (131, 21, 2, 3, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (132, 22, 2, 16, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (133, 23, 2, 16, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (134, 24, 2, 4, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (2265, 459, 6, 9, 0.0000, '');
INSERT INTO `products_attributes` VALUES (136, 26, 2, 4, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (137, 27, 2, 3, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (138, 28, 2, 4, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (139, 29, 2, 3, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (140, 30, 2, 3, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (141, 31, 2, 3, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (142, 32, 2, 3, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (143, 33, 2, 16, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (144, 34, 2, 3, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (145, 35, 2, 4, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (146, 36, 2, 4, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (147, 37, 2, 14, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (148, 38, 2, 4, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (149, 39, 2, 4, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (150, 40, 2, 4, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (151, 41, 2, 4, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (152, 42, 2, 4, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (153, 43, 2, 14, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (154, 44, 2, 3, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (155, 45, 2, 21, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (156, 46, 2, 21, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (157, 47, 2, 21, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (158, 48, 2, 21, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (159, 49, 2, 3, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (160, 50, 2, 21, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (161, 51, 2, 21, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (162, 52, 2, 3, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (163, 53, 2, 21, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (164, 54, 2, 4, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (165, 55, 2, 21, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (166, 56, 2, 21, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (167, 57, 2, 4, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (168, 58, 2, 4, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (169, 59, 2, 4, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (170, 60, 2, 4, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (171, 61, 2, 3, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (172, 62, 2, 3, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (173, 63, 2, 4, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (174, 64, 2, 4, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (175, 65, 2, 4, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (176, 66, 2, 4, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (177, 67, 2, 4, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (178, 68, 2, 21, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (179, 69, 2, 3, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (180, 70, 2, 3, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (181, 71, 2, 3, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (182, 72, 2, 4, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (183, 73, 2, 3, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (184, 74, 2, 21, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (185, 75, 2, 4, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (186, 76, 2, 4, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (187, 77, 2, 4, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (188, 78, 2, 3, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (189, 79, 2, 3, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (190, 5, 3, 6, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (191, 6, 3, 5, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (192, 7, 3, 6, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (193, 8, 3, 6, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (194, 9, 3, 5, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (195, 10, 3, 6, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (196, 11, 3, 6, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (197, 12, 3, 6, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (198, 13, 3, 6, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (199, 14, 3, 6, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (200, 15, 3, 6, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (201, 16, 3, 6, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (202, 17, 3, 6, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (203, 18, 3, 5, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (204, 19, 3, 6, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (205, 20, 3, 6, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (206, 21, 3, 5, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (207, 22, 3, 6, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (208, 23, 3, 6, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (209, 24, 3, 6, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (2264, 459, 3, 6, 0.0000, '');
INSERT INTO `products_attributes` VALUES (211, 26, 3, 6, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (212, 27, 3, 6, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (213, 28, 3, 6, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (214, 29, 3, 6, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (215, 30, 3, 6, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (216, 31, 3, 6, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (218, 33, 3, 6, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (219, 34, 3, 6, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (220, 35, 3, 5, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (221, 36, 3, 5, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (952, 37, 3, 5, 0.0000, '');
INSERT INTO `products_attributes` VALUES (223, 38, 3, 5, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (224, 39, 3, 6, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (225, 40, 3, 6, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (226, 41, 3, 6, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (227, 42, 3, 5, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (229, 44, 3, 6, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (230, 45, 3, 6, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (231, 46, 3, 6, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (232, 47, 3, 6, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (233, 48, 3, 6, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (234, 49, 3, 6, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (235, 50, 3, 6, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (236, 51, 3, 6, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (237, 52, 3, 6, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (238, 53, 3, 6, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (239, 54, 3, 6, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (240, 55, 3, 6, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (241, 56, 3, 6, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (242, 57, 3, 6, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (243, 58, 3, 6, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (246, 61, 3, 6, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (247, 62, 3, 6, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (248, 63, 3, 6, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (249, 64, 3, 6, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (250, 65, 3, 6, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (251, 66, 3, 6, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (252, 67, 3, 6, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (253, 68, 3, 5, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (254, 69, 3, 6, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (255, 70, 3, 6, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (256, 71, 3, 6, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (257, 72, 3, 6, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (258, 73, 3, 6, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (259, 74, 3, 6, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (260, 75, 3, 6, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (261, 76, 3, 6, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (262, 77, 3, 6, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (263, 78, 3, 6, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (264, 79, 3, 6, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (265, 5, 4, 7, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (266, 6, 4, 8, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (267, 7, 4, 8, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (268, 8, 4, 8, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (269, 9, 4, 7, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (270, 10, 4, 8, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (271, 11, 4, 7, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (272, 12, 4, 7, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (273, 13, 4, 7, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (274, 14, 4, 8, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (275, 15, 4, 8, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (276, 16, 4, 7, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (277, 17, 4, 7, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (278, 18, 4, 7, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (279, 19, 4, 7, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (280, 20, 4, 7, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (281, 21, 4, 8, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (282, 22, 4, 7, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (283, 23, 4, 7, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (284, 24, 4, 7, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (2263, 459, 5, 27, 0.0000, '');
INSERT INTO `products_attributes` VALUES (286, 26, 4, 7, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (287, 27, 4, 7, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (288, 28, 4, 7, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (289, 29, 4, 8, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (290, 30, 4, 8, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (291, 31, 4, 7, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (292, 32, 4, 8, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (293, 33, 4, 7, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (294, 34, 4, 7, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (295, 35, 4, 7, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (296, 36, 4, 7, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (297, 37, 4, 7, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (298, 38, 4, 7, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (299, 39, 4, 7, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (300, 40, 4, 7, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (301, 41, 4, 7, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (302, 42, 4, 8, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (303, 43, 4, 8, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (304, 44, 4, 7, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (305, 45, 4, 8, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (306, 46, 4, 8, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (307, 47, 4, 8, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (308, 48, 4, 8, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (309, 49, 4, 8, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (310, 50, 4, 8, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (311, 51, 4, 8, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (312, 52, 4, 8, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (313, 53, 4, 8, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (314, 54, 4, 7, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (315, 55, 4, 64, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (316, 56, 4, 7, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (317, 57, 4, 7, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (318, 58, 4, 7, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (319, 59, 4, 7, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (320, 60, 4, 7, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (321, 61, 4, 7, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (322, 62, 4, 7, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (323, 63, 4, 7, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (324, 64, 4, 7, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (325, 65, 4, 7, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (326, 66, 4, 7, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (327, 67, 4, 7, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (328, 68, 4, 7, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (329, 69, 4, 7, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (330, 70, 4, 8, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (331, 71, 4, 7, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (332, 72, 4, 64, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (333, 73, 4, 64, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (334, 74, 4, 8, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (335, 75, 4, 7, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (336, 76, 4, 7, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (337, 77, 4, 7, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (338, 78, 4, 7, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (339, 79, 4, 7, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (340, 5, 5, 13, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (341, 6, 5, 13, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (342, 7, 5, 13, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (343, 8, 5, 19, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (344, 9, 5, 13, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (345, 10, 5, 19, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (346, 11, 5, 12, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (347, 12, 5, 12, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (348, 13, 5, 19, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (349, 14, 5, 12, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (350, 15, 5, 13, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (351, 16, 5, 13, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (352, 17, 5, 19, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (353, 18, 5, 12, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (354, 19, 5, 12, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (355, 20, 5, 12, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (934, 21, 7, 20, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (357, 22, 5, 12, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (358, 23, 5, 12, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (359, 24, 5, 12, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (2262, 459, 1, 1, 0.0000, '');
INSERT INTO `products_attributes` VALUES (361, 26, 5, 12, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (362, 27, 5, 12, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (363, 28, 5, 19, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (364, 29, 5, 12, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (365, 30, 5, 13, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (366, 31, 5, 12, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (367, 32, 5, 12, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (368, 33, 5, 12, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (369, 34, 5, 19, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (370, 35, 5, 12, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (371, 36, 5, 13, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (372, 37, 5, 13, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (373, 38, 5, 13, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (374, 39, 5, 12, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (375, 40, 5, 13, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (376, 41, 5, 19, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (377, 42, 5, 12, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (378, 43, 5, 13, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (379, 44, 5, 12, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (380, 45, 5, 13, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (381, 46, 5, 19, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (382, 47, 5, 12, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (383, 48, 5, 13, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (384, 49, 5, 12, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (385, 50, 5, 13, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (386, 51, 5, 19, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (387, 52, 5, 19, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (388, 53, 5, 13, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (389, 54, 5, 13, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (390, 55, 5, 12, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (391, 56, 5, 19, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (392, 57, 5, 19, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (393, 58, 5, 19, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (394, 59, 5, 12, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (395, 60, 5, 13, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (396, 61, 5, 12, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (397, 62, 5, 12, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (398, 63, 5, 19, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (399, 64, 5, 13, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (400, 65, 5, 13, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (401, 66, 5, 19, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (402, 67, 5, 12, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (403, 68, 5, 13, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (404, 69, 5, 12, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (405, 70, 5, 12, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (406, 71, 5, 12, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (407, 72, 5, 12, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (408, 73, 5, 12, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (409, 74, 5, 12, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (410, 75, 5, 19, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (411, 76, 5, 12, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (412, 77, 5, 19, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (413, 78, 5, 12, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (414, 79, 5, 12, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (415, 5, 6, 9, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (416, 6, 6, 9, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (417, 7, 6, 9, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (418, 8, 6, 9, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (419, 9, 6, 9, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (420, 10, 6, 9, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (421, 11, 6, 9, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (422, 12, 6, 11, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (423, 13, 6, 11, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (424, 14, 6, 9, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (425, 15, 6, 9, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (426, 16, 6, 9, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (427, 17, 6, 9, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (428, 18, 6, 9, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (429, 19, 6, 9, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (430, 20, 6, 11, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (431, 21, 6, 9, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (432, 22, 6, 11, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (433, 23, 6, 11, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (434, 24, 6, 11, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (2261, 459, 4, 7, 0.0000, '');
INSERT INTO `products_attributes` VALUES (436, 26, 6, 9, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (437, 27, 6, 9, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (438, 28, 6, 9, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (439, 29, 6, 9, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (440, 30, 6, 9, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (441, 31, 6, 9, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (442, 32, 6, 9, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (443, 33, 6, 9, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (444, 34, 6, 9, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (445, 35, 6, 9, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (446, 36, 6, 9, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (447, 37, 6, 9, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (448, 38, 6, 9, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (449, 39, 6, 9, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (450, 40, 6, 9, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (451, 41, 6, 9, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (452, 42, 6, 9, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (453, 43, 6, 9, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (454, 44, 6, 9, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (455, 45, 6, 9, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (456, 46, 6, 9, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (457, 47, 6, 9, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (458, 48, 6, 9, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (459, 49, 6, 9, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (460, 50, 6, 9, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (461, 51, 6, 9, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (462, 52, 6, 9, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (463, 53, 6, 9, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (464, 54, 6, 9, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (465, 55, 6, 9, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (466, 56, 6, 9, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (467, 57, 6, 9, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (468, 58, 6, 9, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (469, 59, 6, 9, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (470, 60, 6, 9, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (471, 61, 6, 9, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (472, 62, 6, 11, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (473, 63, 6, 11, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (474, 64, 6, 9, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (475, 65, 6, 9, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (476, 66, 6, 9, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (477, 67, 6, 9, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (478, 68, 6, 9, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (479, 69, 6, 9, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (480, 70, 6, 9, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (481, 71, 6, 9, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (482, 72, 6, 9, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (483, 73, 6, 9, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (484, 74, 6, 9, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (485, 75, 6, 9, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (486, 76, 6, 11, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (487, 77, 6, 9, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (488, 78, 6, 9, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (489, 79, 6, 9, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (490, 80, 1, 1, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (491, 81, 1, 1, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (492, 82, 1, 1, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (493, 83, 1, 1, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (494, 84, 1, 1, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (495, 85, 1, 1, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (496, 86, 1, 1, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (497, 87, 1, 1, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (498, 88, 1, 1, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (499, 89, 1, 1, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (500, 90, 1, 1, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (501, 91, 1, 1, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (502, 92, 1, 1, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (503, 93, 1, 1, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (504, 94, 1, 1, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (505, 95, 1, 1, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (506, 96, 1, 1, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (507, 97, 1, 1, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (508, 98, 1, 1, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (4246, 739, 4, 7, 0.0000, '');
INSERT INTO `products_attributes` VALUES (510, 100, 1, 1, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (511, 101, 1, 1, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (512, 102, 1, 1, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (513, 103, 1, 1, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (514, 104, 1, 1, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (515, 105, 1, 1, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (516, 106, 1, 1, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (517, 107, 1, 1, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (518, 108, 1, 1, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (519, 109, 1, 1, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (520, 110, 1, 1, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (521, 111, 1, 1, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (522, 112, 1, 1, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (523, 113, 1, 1, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (524, 114, 1, 1, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (525, 115, 1, 2, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (526, 116, 1, 2, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (527, 117, 1, 2, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (528, 118, 1, 2, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (529, 119, 1, 2, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (530, 120, 1, 2, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (2188, 385, 6, 11, 0.0000, '');
INSERT INTO `products_attributes` VALUES (532, 122, 1, 2, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (533, 123, 1, 2, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (534, 124, 1, 2, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (535, 125, 1, 2, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (536, 126, 1, 2, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (537, 127, 1, 2, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (538, 128, 1, 2, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (539, 129, 1, 2, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (540, 130, 1, 2, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (541, 131, 1, 2, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (542, 132, 1, 2, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (543, 133, 1, 2, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (544, 134, 1, 2, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (545, 135, 1, 2, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (546, 136, 1, 2, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (547, 137, 1, 2, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (548, 138, 1, 2, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (549, 139, 1, 2, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (550, 140, 1, 2, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (551, 141, 1, 2, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (552, 142, 1, 2, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (553, 143, 1, 2, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (554, 144, 1, 2, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (555, 145, 1, 2, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (556, 146, 1, 2, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (557, 147, 1, 2, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (558, 148, 1, 2, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (4176, 728, 32, 116, 0.0000, '');
INSERT INTO `products_attributes` VALUES (560, 150, 1, 2, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (561, 151, 1, 2, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (2272, 461, 2, 4, 0.0000, '');
INSERT INTO `products_attributes` VALUES (563, 153, 1, 2, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (564, 80, 2, 3, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (565, 81, 2, 16, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (566, 82, 2, 14, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (567, 83, 2, 3, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (568, 84, 2, 3, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (569, 85, 2, 32, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (570, 86, 2, 16, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (571, 87, 2, 3, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (572, 88, 2, 3, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (574, 90, 2, 3, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (575, 91, 2, 32, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (576, 92, 2, 3, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (577, 93, 2, 16, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (578, 94, 2, 4, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (579, 95, 2, 3, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (580, 96, 2, 21, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (581, 97, 2, 4, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (582, 98, 2, 4, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (4245, 738, 6, 9, 0.0000, '');
INSERT INTO `products_attributes` VALUES (584, 100, 2, 4, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (585, 101, 2, 4, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (586, 102, 2, 4, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (587, 103, 2, 4, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (588, 104, 2, 16, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (589, 105, 2, 14, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (590, 106, 2, 4, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (591, 107, 2, 3, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (592, 108, 2, 4, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (593, 109, 2, 3, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (594, 110, 2, 4, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (595, 111, 2, 3, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (596, 112, 2, 4, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (597, 113, 2, 4, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (598, 114, 2, 4, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (599, 115, 2, 4, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (600, 116, 2, 3, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (601, 117, 2, 4, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (602, 118, 2, 4, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (603, 119, 2, 4, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (604, 120, 2, 32, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (2187, 385, 3, 6, 0.0000, '');
INSERT INTO `products_attributes` VALUES (606, 122, 2, 21, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (607, 123, 2, 3, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (608, 124, 2, 21, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (609, 125, 2, 4, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (610, 126, 2, 32, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (611, 127, 2, 4, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (612, 128, 2, 32, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (613, 129, 2, 4, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (614, 130, 2, 4, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (615, 131, 2, 3, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (616, 132, 2, 3, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (617, 133, 2, 21, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (618, 134, 2, 21, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (619, 135, 2, 4, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (620, 136, 2, 4, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (621, 137, 2, 3, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (622, 138, 2, 4, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (623, 139, 2, 4, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (624, 140, 2, 4, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (625, 141, 2, 21, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (626, 142, 2, 4, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (627, 143, 2, 14, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (628, 144, 2, 4, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (629, 145, 2, 4, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (630, 146, 2, 4, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (631, 147, 2, 4, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (632, 148, 2, 4, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (4175, 728, 31, 110, 0.0000, '');
INSERT INTO `products_attributes` VALUES (634, 150, 2, 14, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (635, 151, 2, 4, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (2271, 461, 4, 7, 0.0000, '');
INSERT INTO `products_attributes` VALUES (637, 153, 2, 4, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (639, 81, 3, 6, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (640, 82, 3, 6, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (641, 83, 3, 6, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (642, 84, 3, 6, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (643, 85, 3, 6, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (644, 86, 3, 5, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (645, 87, 3, 6, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (646, 88, 3, 6, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (647, 89, 3, 6, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (649, 91, 3, 6, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (650, 92, 3, 6, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (651, 93, 3, 5, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (653, 95, 3, 6, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (654, 96, 3, 6, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (655, 97, 3, 6, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (957, 108, 7, 18, 0.0000, '');
INSERT INTO `products_attributes` VALUES (954, 102, 7, 20, 0.0000, '');
INSERT INTO `products_attributes` VALUES (658, 100, 3, 6, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (659, 101, 3, 5, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (660, 102, 3, 5, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (661, 103, 3, 6, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (662, 104, 3, 6, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (663, 105, 3, 5, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (664, 106, 3, 6, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (665, 107, 3, 5, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (666, 108, 3, 5, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (667, 109, 3, 6, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (668, 110, 3, 6, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (669, 111, 3, 6, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (670, 112, 3, 6, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (671, 113, 3, 6, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (672, 114, 3, 5, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (673, 115, 3, 6, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (674, 116, 3, 3, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (675, 117, 3, 6, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (676, 118, 3, 6, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (677, 119, 3, 5, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (2186, 385, 5, 19, 0.0000, '');
INSERT INTO `products_attributes` VALUES (680, 122, 3, 6, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (681, 123, 3, 6, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (682, 124, 3, 6, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (683, 125, 3, 6, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (960, 129, 7, 20, 0.0000, '');
INSERT INTO `products_attributes` VALUES (685, 127, 3, 5, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (686, 128, 3, 6, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (961, 135, 7, 20, 0.0000, '');
INSERT INTO `products_attributes` VALUES (688, 130, 3, 6, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (689, 131, 3, 6, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (690, 132, 3, 6, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (691, 133, 3, 6, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (692, 134, 3, 6, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (695, 137, 3, 6, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (4174, 727, 9, 35, 0.0000, '');
INSERT INTO `products_attributes` VALUES (697, 139, 3, 6, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (698, 140, 3, 6, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (699, 141, 3, 6, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (700, 142, 3, 6, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (701, 143, 3, 6, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (702, 144, 3, 6, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (703, 145, 3, 6, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (704, 146, 3, 6, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (705, 147, 3, 6, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (2190, 386, 2, 21, 0.0000, '');
INSERT INTO `products_attributes` VALUES (963, 151, 7, 20, 0.0000, '');
INSERT INTO `products_attributes` VALUES (964, 150, 7, 20, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2270, 460, 6, 9, 0.0000, '');
INSERT INTO `products_attributes` VALUES (711, 153, 3, 6, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (712, 80, 4, 7, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (713, 81, 4, 7, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (714, 82, 4, 8, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (715, 83, 4, 8, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (716, 84, 4, 8, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (717, 85, 4, 7, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (718, 86, 4, 7, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (719, 87, 4, 7, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (720, 88, 4, 7, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (721, 89, 4, 7, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (722, 90, 4, 7, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (723, 91, 4, 8, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (724, 92, 4, 7, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (725, 93, 4, 7, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (726, 94, 4, 7, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (727, 95, 4, 8, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (728, 96, 4, 8, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (729, 97, 4, 7, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (730, 98, 4, 7, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (4244, 738, 5, 27, 0.0000, '');
INSERT INTO `products_attributes` VALUES (732, 100, 4, 8, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (733, 101, 4, 7, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (734, 102, 4, 22, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (735, 103, 4, 7, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (736, 104, 4, 7, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (737, 105, 4, 7, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (738, 106, 4, 7, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (739, 107, 4, 7, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (740, 108, 4, 7, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (741, 109, 4, 7, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (742, 110, 4, 7, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (743, 111, 4, 7, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (744, 112, 4, 7, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (745, 113, 4, 7, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (746, 114, 4, 7, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (747, 115, 4, 7, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (748, 116, 4, 8, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (749, 117, 4, 22, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (750, 118, 4, 76, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (751, 119, 4, 7, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (752, 120, 4, 7, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (2185, 385, 1, 1, 0.0000, '');
INSERT INTO `products_attributes` VALUES (754, 122, 4, 7, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (755, 123, 4, 8, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (756, 124, 4, 7, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (757, 125, 4, 8, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (758, 126, 4, 7, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (759, 127, 4, 7, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (760, 128, 4, 23, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (761, 129, 4, 64, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (762, 130, 4, 22, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (763, 131, 4, 22, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (764, 132, 4, 22, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (765, 133, 4, 22, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (766, 134, 4, 8, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (767, 135, 4, 23, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (768, 136, 4, 7, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (769, 137, 4, 22, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (770, 138, 4, 7, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (771, 139, 4, 76, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (772, 140, 4, 7, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (773, 141, 4, 7, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (774, 142, 4, 7, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (775, 143, 4, 7, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (776, 144, 4, 22, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (777, 145, 4, 7, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (778, 146, 4, 8, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (779, 147, 4, 22, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (780, 148, 4, 7, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (4173, 727, 29, 130, 0.0000, '');
INSERT INTO `products_attributes` VALUES (782, 150, 4, 8, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (783, 151, 4, 7, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (2269, 460, 3, 6, 0.0000, '');
INSERT INTO `products_attributes` VALUES (785, 153, 4, 7, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (786, 80, 5, 12, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (787, 81, 5, 12, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (788, 82, 5, 27, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (789, 83, 5, 26, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (790, 84, 5, 27, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (791, 85, 5, 27, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (792, 86, 5, 12, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (793, 87, 5, 12, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (794, 88, 5, 12, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (795, 89, 5, 12, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (796, 90, 5, 27, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (797, 91, 5, 12, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (798, 92, 5, 12, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (799, 93, 5, 12, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (800, 94, 5, 12, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (801, 95, 5, 26, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (802, 96, 5, 27, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (803, 97, 5, 27, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (804, 98, 5, 26, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (4243, 738, 1, 1, 0.0000, '');
INSERT INTO `products_attributes` VALUES (806, 100, 5, 27, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (807, 101, 5, 12, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (808, 102, 5, 27, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (809, 103, 5, 27, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (810, 104, 5, 12, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (811, 105, 5, 27, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (812, 106, 5, 27, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (813, 107, 5, 27, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (814, 108, 5, 27, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (815, 109, 5, 24, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (816, 110, 5, 19, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (817, 111, 5, 12, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (818, 112, 5, 12, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (819, 113, 5, 12, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (820, 114, 5, 27, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (821, 115, 5, 12, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (822, 116, 5, 12, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (823, 117, 5, 26, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (824, 118, 5, 27, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (825, 119, 5, 27, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (826, 120, 5, 27, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (2184, 385, 2, 4, 0.0000, '');
INSERT INTO `products_attributes` VALUES (828, 122, 5, 27, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (829, 123, 5, 26, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (830, 124, 5, 19, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (831, 125, 5, 26, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (832, 126, 5, 12, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (833, 127, 5, 12, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (834, 128, 5, 26, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (835, 129, 5, 27, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (836, 130, 5, 26, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (837, 131, 5, 26, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (838, 132, 5, 27, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (839, 133, 5, 27, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (840, 134, 5, 26, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (841, 135, 5, 12, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (842, 136, 5, 27, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (843, 137, 5, 19, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (844, 138, 5, 12, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (845, 139, 5, 12, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (846, 140, 5, 27, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (847, 141, 5, 27, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (848, 142, 5, 27, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (849, 143, 5, 27, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (850, 144, 5, 26, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (851, 145, 5, 27, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (852, 146, 5, 26, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (853, 147, 5, 27, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (854, 148, 5, 12, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (4172, 727, 8, 128, 0.0000, '');
INSERT INTO `products_attributes` VALUES (856, 150, 5, 27, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (857, 151, 5, 27, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (2268, 460, 5, 12, 0.0000, '');
INSERT INTO `products_attributes` VALUES (859, 153, 5, 27, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (860, 80, 6, 10, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (861, 81, 6, 10, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (864, 84, 6, 9, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (866, 86, 6, 9, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (867, 87, 6, 11, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (868, 88, 6, 11, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (869, 89, 6, 11, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (870, 90, 6, 11, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (872, 92, 6, 11, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (873, 93, 6, 11, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (959, 120, 7, 20, 0.0000, '');
INSERT INTO `products_attributes` VALUES (875, 95, 6, 29, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (876, 96, 6, 29, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (877, 97, 6, 29, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (956, 107, 7, 20, 0.0000, '');
INSERT INTO `products_attributes` VALUES (953, 101, 7, 20, 0.0000, '');
INSERT INTO `products_attributes` VALUES (880, 100, 6, 9, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (881, 101, 6, 29, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (882, 102, 6, 9, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (955, 105, 7, 20, 0.0000, '');
INSERT INTO `products_attributes` VALUES (884, 104, 6, 10, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (885, 105, 6, 9, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (886, 106, 6, 9, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (887, 107, 6, 9, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (888, 108, 6, 10, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (889, 109, 6, 10, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (890, 110, 6, 10, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (891, 111, 6, 11, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (892, 112, 6, 11, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (893, 113, 6, 11, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (894, 114, 6, 9, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (895, 115, 6, 10, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (896, 116, 6, 9, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (897, 117, 6, 9, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (958, 119, 7, 20, 0.0000, '');
INSERT INTO `products_attributes` VALUES (899, 119, 6, 9, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (900, 120, 6, 9, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (2183, 385, 4, 7, 0.0000, '');
INSERT INTO `products_attributes` VALUES (904, 124, 6, 10, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (905, 125, 6, 9, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (906, 126, 6, 9, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (907, 127, 6, 9, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (908, 128, 6, 9, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (909, 129, 6, 9, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (910, 130, 6, 9, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (911, 131, 6, 9, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (912, 132, 6, 9, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (913, 133, 6, 9, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (914, 134, 6, 9, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (915, 135, 6, 9, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (916, 136, 6, 9, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (917, 137, 6, 9, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (918, 138, 6, 9, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (919, 139, 6, 9, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (920, 140, 6, 9, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (921, 141, 6, 9, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (922, 142, 6, 9, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (923, 143, 6, 9, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (924, 144, 6, 9, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (925, 145, 6, 9, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (926, 146, 6, 9, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (927, 147, 6, 9, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (928, 148, 6, 9, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (4171, 727, 32, 116, 0.0000, '');
INSERT INTO `products_attributes` VALUES (930, 150, 6, 9, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (931, 151, 6, 9, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (2267, 460, 1, 1, 0.0000, '');
INSERT INTO `products_attributes` VALUES (933, 153, 6, 9, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (935, 32, 7, 20, 0.0000, '');
INSERT INTO `products_attributes` VALUES (936, 32, 3, 5, 0.0000, '');
INSERT INTO `products_attributes` VALUES (937, 36, 7, 18, 0.0000, '');
INSERT INTO `products_attributes` VALUES (938, 42, 7, 20, 0.0000, '');
INSERT INTO `products_attributes` VALUES (939, 35, 7, 20, 0.0000, '');
INSERT INTO `products_attributes` VALUES (940, 38, 7, 20, 0.0000, '');
INSERT INTO `products_attributes` VALUES (941, 43, 7, 20, 0.0000, '');
INSERT INTO `products_attributes` VALUES (942, 43, 3, 5, 0.0000, '');
INSERT INTO `products_attributes` VALUES (951, 37, 7, 18, 0.0000, '');
INSERT INTO `products_attributes` VALUES (944, 21, 5, 12, 0.0000, '');
INSERT INTO `products_attributes` VALUES (945, 9, 7, 18, 0.0000, '');
INSERT INTO `products_attributes` VALUES (946, 6, 7, 20, 0.0000, '');
INSERT INTO `products_attributes` VALUES (947, 59, 7, 20, 0.0000, '');
INSERT INTO `products_attributes` VALUES (948, 59, 3, 5, 0.0000, '');
INSERT INTO `products_attributes` VALUES (949, 60, 7, 18, 0.0000, '');
INSERT INTO `products_attributes` VALUES (950, 60, 3, 5, 0.0000, '');
INSERT INTO `products_attributes` VALUES (965, 154, 1, 2, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (966, 155, 1, 2, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (967, 156, 1, 2, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (968, 157, 1, 2, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (969, 158, 1, 2, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (970, 159, 1, 2, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (971, 160, 1, 2, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (972, 161, 1, 2, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (973, 89, 2, 4, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (974, 154, 2, 3, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (975, 155, 2, 21, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (976, 156, 2, 3, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (977, 157, 2, 4, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (978, 158, 2, 3, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (979, 159, 2, 21, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (980, 160, 2, 4, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (981, 161, 2, 21, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (982, 80, 3, 5, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (983, 90, 3, 5, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (984, 94, 3, 5, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (985, 98, 3, 5, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (4242, 738, 2, 4, 0.0000, '');
INSERT INTO `products_attributes` VALUES (987, 120, 3, 5, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (988, 126, 3, 5, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (989, 129, 3, 5, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (990, 135, 3, 5, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (2189, 386, 4, 7, 0.0000, '');
INSERT INTO `products_attributes` VALUES (992, 138, 3, 5, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (4170, 727, 31, 110, 0.0000, '');
INSERT INTO `products_attributes` VALUES (994, 150, 3, 5, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (995, 151, 3, 5, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (996, 154, 3, 6, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (997, 155, 3, 6, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (998, 156, 3, 6, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (999, 157, 3, 6, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1000, 158, 3, 6, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1001, 159, 3, 6, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1002, 160, 3, 6, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1003, 161, 3, 6, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1044, 167, 8, 33, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1005, 155, 4, 7, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1043, 166, 8, 33, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1042, 165, 8, 33, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1041, 164, 8, 33, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1039, 162, 8, 33, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1011, 161, 4, 7, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1012, 154, 5, 12, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1013, 155, 5, 12, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1014, 156, 5, 12, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1015, 157, 5, 12, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1016, 158, 5, 12, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1017, 159, 5, 12, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1018, 160, 5, 12, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1019, 161, 5, 12, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1020, 82, 6, 9, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1021, 83, 6, 9, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1022, 85, 6, 9, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1023, 91, 6, 9, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1024, 94, 6, 9, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1025, 98, 6, 9, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (4241, 738, 4, 7, 0.0000, '');
INSERT INTO `products_attributes` VALUES (1027, 103, 6, 9, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1028, 118, 6, 9, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1029, 122, 6, 9, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1030, 123, 6, 9, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1031, 154, 6, 29, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1032, 155, 6, 9, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1033, 156, 6, 9, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1034, 157, 6, 9, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1035, 158, 6, 9, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1036, 159, 6, 9, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1037, 160, 6, 9, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1038, 161, 6, 9, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1045, 168, 8, 33, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1046, 169, 8, 33, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1047, 170, 8, 33, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1048, 171, 8, 33, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1049, 172, 8, 33, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1050, 173, 8, 33, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1051, 174, 8, 33, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1052, 175, 8, 33, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1053, 159, 4, 22, 0.0000, '');
INSERT INTO `products_attributes` VALUES (1054, 176, 1, 1, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1055, 177, 1, 1, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1056, 178, 1, 1, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1057, 179, 1, 1, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1058, 180, 1, 1, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1059, 181, 1, 1, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1060, 182, 1, 1, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1061, 183, 1, 1, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1062, 184, 1, 1, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1063, 185, 1, 1, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1064, 186, 1, 1, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1065, 187, 1, 1, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1066, 188, 1, 1, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1067, 189, 1, 1, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1068, 190, 1, 1, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1069, 191, 1, 1, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1070, 192, 1, 1, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1071, 193, 1, 1, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1072, 194, 1, 1, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1073, 195, 1, 1, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1074, 196, 1, 1, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1075, 197, 1, 2, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1076, 198, 1, 2, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1077, 199, 1, 2, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1078, 200, 1, 2, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1079, 201, 1, 2, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1080, 202, 1, 2, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1081, 203, 1, 2, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1082, 204, 1, 2, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1083, 205, 1, 2, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1084, 206, 1, 2, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1085, 207, 1, 2, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1086, 208, 1, 2, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1087, 209, 1, 2, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1088, 210, 1, 2, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1089, 211, 1, 2, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1090, 212, 1, 2, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1091, 213, 1, 2, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1092, 214, 1, 2, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1093, 215, 1, 2, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1094, 216, 1, 2, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1095, 217, 1, 2, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1096, 218, 1, 2, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1097, 219, 1, 2, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1331, 175, 9, 36, 0.0000, '');
INSERT INTO `products_attributes` VALUES (1099, 177, 2, 3, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1100, 178, 2, 16, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1101, 179, 2, 16, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1102, 180, 2, 15, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1103, 181, 2, 3, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1330, 166, 9, 37, 0.0000, '');
INSERT INTO `products_attributes` VALUES (1105, 183, 2, 3, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1106, 184, 2, 3, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1107, 185, 2, 3, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1108, 186, 2, 3, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1109, 187, 2, 16, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1110, 188, 2, 16, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1329, 167, 9, 37, 0.0000, '');
INSERT INTO `products_attributes` VALUES (1328, 163, 9, 37, 0.0000, '');
INSERT INTO `products_attributes` VALUES (1327, 169, 9, 36, 0.0000, '');
INSERT INTO `products_attributes` VALUES (1319, 192, 7, 20, 0.0000, '');
INSERT INTO `products_attributes` VALUES (1115, 193, 2, 3, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1321, 194, 7, 20, 0.0000, '');
INSERT INTO `products_attributes` VALUES (1117, 195, 2, 4, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1323, 196, 7, 20, 0.0000, '');
INSERT INTO `products_attributes` VALUES (1119, 197, 2, 4, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1120, 198, 2, 14, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1121, 199, 2, 4, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1122, 200, 2, 4, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1124, 202, 2, 21, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1130, 208, 2, 4, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1131, 209, 2, 3, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1132, 210, 2, 15, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1334, 174, 9, 36, 0.0000, '');
INSERT INTO `products_attributes` VALUES (1134, 212, 2, 21, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1135, 213, 2, 21, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1136, 214, 2, 3, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1137, 215, 2, 21, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1138, 216, 2, 21, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1139, 217, 2, 21, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1140, 218, 2, 4, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1141, 219, 2, 4, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1142, 176, 3, 6, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1143, 177, 3, 6, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1144, 178, 3, 6, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1145, 179, 3, 6, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1146, 180, 3, 6, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1147, 181, 3, 6, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1148, 182, 3, 6, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1149, 183, 3, 6, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1150, 184, 3, 6, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1151, 185, 3, 6, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1152, 186, 3, 6, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1153, 187, 3, 6, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1154, 188, 3, 6, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1155, 189, 3, 6, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1156, 190, 3, 6, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1157, 191, 3, 6, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1320, 193, 7, 20, 0.0000, '');
INSERT INTO `products_attributes` VALUES (1326, 165, 9, 34, 0.0000, '');
INSERT INTO `products_attributes` VALUES (1322, 195, 7, 20, 0.0000, '');
INSERT INTO `products_attributes` VALUES (1325, 162, 9, 34, 0.0000, '');
INSERT INTO `products_attributes` VALUES (1324, 164, 9, 34, 0.0000, '');
INSERT INTO `products_attributes` VALUES (1163, 197, 3, 6, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1164, 198, 3, 6, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1165, 199, 3, 6, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1166, 200, 3, 6, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1167, 201, 3, 6, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1168, 202, 3, 6, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1169, 203, 3, 6, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1170, 204, 3, 6, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1171, 205, 3, 6, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1172, 206, 3, 6, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1173, 207, 3, 6, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1174, 208, 3, 6, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1175, 209, 3, 6, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1176, 210, 3, 6, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1177, 211, 3, 6, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1178, 212, 3, 6, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1179, 213, 3, 6, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1180, 214, 3, 6, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1181, 215, 3, 6, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1182, 216, 3, 6, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1183, 217, 3, 5, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1318, 219, 7, 20, 0.0000, '');
INSERT INTO `products_attributes` VALUES (1332, 172, 9, 36, 0.0000, '');
INSERT INTO `products_attributes` VALUES (1186, 176, 4, 7, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1187, 177, 4, 7, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1188, 178, 4, 7, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1189, 179, 4, 7, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1190, 180, 4, 7, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1191, 181, 4, 7, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1192, 182, 4, 7, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1193, 183, 4, 7, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1194, 184, 4, 7, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1195, 185, 4, 7, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1196, 186, 4, 7, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1197, 187, 4, 7, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1198, 188, 4, 7, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1199, 189, 4, 7, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1200, 190, 4, 8, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1201, 191, 4, 8, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1202, 192, 4, 8, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1203, 193, 4, 7, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1204, 194, 4, 7, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1205, 195, 4, 7, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1206, 196, 4, 8, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1207, 197, 4, 7, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1208, 198, 4, 22, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1209, 199, 4, 8, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1210, 200, 4, 7, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1338, 168, 9, 39, 0.0000, '');
INSERT INTO `products_attributes` VALUES (1337, 170, 9, 39, 0.0000, '');
INSERT INTO `products_attributes` VALUES (1336, 171, 9, 39, 0.0000, '');
INSERT INTO `products_attributes` VALUES (1335, 173, 9, 36, 0.0000, '');
INSERT INTO `products_attributes` VALUES (1222, 212, 4, 8, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1223, 213, 4, 22, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1224, 214, 4, 22, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1225, 215, 4, 7, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1226, 216, 4, 7, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1227, 217, 4, 7, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1228, 218, 4, 7, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1229, 219, 4, 7, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1230, 176, 5, 12, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1231, 177, 5, 12, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1232, 178, 5, 12, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1233, 179, 5, 12, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1234, 180, 5, 12, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1235, 181, 5, 27, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1236, 182, 5, 12, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1237, 183, 5, 19, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1238, 184, 5, 12, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1239, 185, 5, 12, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1240, 186, 5, 12, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1241, 187, 5, 12, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1242, 188, 5, 12, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1243, 189, 5, 12, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1244, 190, 5, 27, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1245, 191, 5, 12, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1246, 192, 5, 27, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1247, 193, 5, 12, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1248, 194, 5, 12, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1249, 195, 5, 27, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1250, 196, 5, 12, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1251, 197, 5, 27, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1252, 198, 5, 27, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1253, 199, 5, 12, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1254, 200, 5, 12, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1255, 201, 5, 12, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1256, 202, 5, 27, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1257, 203, 5, 12, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1258, 204, 5, 27, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1259, 205, 5, 19, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1260, 206, 5, 12, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1261, 207, 5, 12, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1262, 208, 5, 12, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1263, 209, 5, 12, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1264, 210, 5, 27, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1265, 211, 5, 27, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1266, 212, 5, 12, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1267, 213, 5, 27, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1268, 214, 5, 12, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1269, 215, 5, 19, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1270, 216, 5, 12, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1271, 217, 5, 12, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1272, 218, 5, 12, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1273, 219, 5, 12, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1274, 176, 6, 9, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1275, 177, 6, 10, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1276, 178, 6, 10, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1277, 179, 6, 11, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1278, 180, 6, 9, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1279, 181, 6, 10, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1280, 182, 6, 10, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1281, 183, 6, 10, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1282, 184, 6, 11, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1283, 185, 6, 11, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1284, 186, 6, 11, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1285, 187, 6, 11, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1286, 188, 6, 11, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1287, 189, 6, 11, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1288, 190, 6, 29, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1289, 191, 6, 29, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1290, 192, 6, 9, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1291, 193, 6, 9, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1292, 194, 6, 9, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1293, 195, 6, 9, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1294, 196, 6, 9, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1295, 197, 6, 9, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1296, 198, 6, 9, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1297, 199, 6, 9, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1298, 200, 6, 9, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1299, 201, 6, 9, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1300, 202, 6, 9, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1301, 203, 6, 9, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1302, 204, 6, 9, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1303, 205, 6, 9, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1304, 206, 6, 9, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1305, 207, 6, 9, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1306, 208, 6, 9, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1307, 209, 6, 9, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1308, 210, 6, 9, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1309, 211, 6, 9, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1310, 212, 6, 9, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1311, 213, 6, 9, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1312, 214, 6, 9, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1313, 215, 6, 9, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1314, 216, 6, 9, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1315, 217, 6, 9, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1316, 218, 6, 9, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1317, 219, 6, 9, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1339, 223, 9, 34, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1340, 232, 9, 34, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1341, 237, 9, 34, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1342, 240, 9, 34, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1343, 243, 9, 34, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1344, 250, 9, 34, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1345, 256, 9, 34, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1346, 258, 9, 34, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1347, 269, 9, 34, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1348, 282, 9, 34, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1349, 285, 9, 34, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1350, 302, 9, 34, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1351, 308, 9, 34, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1352, 310, 9, 34, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1353, 311, 9, 34, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1354, 313, 9, 34, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1355, 314, 9, 34, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1356, 220, 9, 35, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1357, 221, 9, 35, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1358, 224, 9, 35, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1359, 226, 9, 35, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1360, 228, 9, 35, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1361, 230, 9, 35, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1362, 233, 9, 35, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1363, 235, 9, 35, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1364, 238, 9, 35, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1365, 241, 9, 35, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1366, 244, 9, 35, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1367, 246, 9, 35, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1368, 248, 9, 35, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1369, 251, 9, 35, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1370, 252, 9, 36, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1371, 253, 9, 35, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1372, 255, 9, 35, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1373, 259, 9, 35, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1374, 261, 9, 35, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1375, 263, 9, 35, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1376, 265, 9, 35, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1377, 267, 9, 35, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1378, 270, 9, 35, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1379, 272, 9, 35, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1380, 274, 9, 35, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1381, 276, 9, 35, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1382, 278, 9, 35, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1383, 280, 9, 35, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1384, 283, 9, 35, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1385, 286, 9, 35, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1386, 288, 9, 35, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1387, 290, 9, 35, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1388, 292, 9, 35, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1389, 294, 9, 35, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1390, 296, 9, 35, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1391, 298, 9, 35, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1392, 300, 9, 35, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1393, 303, 9, 35, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1394, 305, 9, 35, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1395, 315, 9, 35, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1396, 317, 9, 35, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1397, 319, 9, 35, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1398, 222, 9, 36, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1399, 227, 9, 36, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1400, 229, 9, 36, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1401, 231, 9, 36, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1402, 234, 9, 36, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (4203, 711, 9, 162, 0.0000, '');
INSERT INTO `products_attributes` VALUES (1404, 239, 9, 36, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1405, 242, 9, 36, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1406, 245, 9, 36, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1407, 247, 9, 36, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1408, 249, 9, 36, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1409, 254, 9, 36, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1410, 257, 9, 36, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1411, 262, 9, 36, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1412, 264, 9, 36, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1413, 273, 9, 36, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1414, 279, 9, 36, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1415, 281, 9, 36, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1416, 284, 9, 36, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1417, 287, 9, 36, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1418, 289, 9, 36, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1419, 291, 9, 36, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1420, 293, 9, 36, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1421, 295, 9, 36, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1422, 299, 9, 36, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1423, 301, 9, 36, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1424, 304, 9, 36, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1425, 306, 9, 36, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (4198, 710, 42, 159, 0.0000, '');
INSERT INTO `products_attributes` VALUES (1427, 316, 9, 36, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1428, 318, 9, 36, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1429, 225, 9, 38, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (4199, 711, 32, 163, 0.0000, '');
INSERT INTO `products_attributes` VALUES (1431, 266, 9, 38, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1432, 268, 9, 38, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1433, 271, 9, 38, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1434, 275, 9, 38, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1435, 277, 9, 38, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1436, 297, 9, 38, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (4200, 711, 8, 128, 0.0000, '');
INSERT INTO `products_attributes` VALUES (1438, 312, 9, 38, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1439, 192, 3, 5, 0.0000, '');
INSERT INTO `products_attributes` VALUES (1440, 195, 3, 5, 0.0000, '');
INSERT INTO `products_attributes` VALUES (1441, 194, 3, 5, 0.0000, '');
INSERT INTO `products_attributes` VALUES (1442, 193, 3, 5, 0.0000, '');
INSERT INTO `products_attributes` VALUES (1443, 196, 3, 5, 0.0000, '');
INSERT INTO `products_attributes` VALUES (1444, 219, 3, 5, 0.0000, '');
INSERT INTO `products_attributes` VALUES (1445, 217, 7, 40, 0.0000, '');
INSERT INTO `products_attributes` VALUES (1446, 320, 9, 34, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1447, 321, 9, 34, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1448, 322, 9, 37, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1449, 323, 9, 37, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1450, 324, 9, 34, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1451, 325, 9, 34, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1452, 326, 9, 34, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1453, 343, 9, 34, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1454, 344, 9, 34, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1455, 327, 9, 38, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1456, 328, 9, 38, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1457, 329, 9, 38, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1458, 330, 9, 38, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1459, 331, 9, 38, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1460, 332, 9, 38, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1461, 333, 9, 38, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1462, 334, 9, 38, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1463, 345, 9, 38, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1464, 346, 9, 38, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1465, 347, 9, 38, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1466, 348, 9, 38, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1467, 335, 9, 41, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1468, 336, 9, 41, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1469, 337, 9, 41, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1470, 338, 9, 41, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1471, 339, 9, 41, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1472, 340, 9, 41, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1473, 341, 9, 41, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1474, 342, 9, 41, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (2182, 318, 10, 51, 9.3617, '+');
INSERT INTO `products_attributes` VALUES (2181, 318, 10, 50, 8.5106, '+');
INSERT INTO `products_attributes` VALUES (2180, 318, 10, 49, 12.7660, '+');
INSERT INTO `products_attributes` VALUES (2179, 318, 10, 48, 11.0638, '+');
INSERT INTO `products_attributes` VALUES (2178, 318, 10, 47, 10.2128, '+');
INSERT INTO `products_attributes` VALUES (2177, 318, 10, 46, 8.5106, '+');
INSERT INTO `products_attributes` VALUES (2176, 318, 10, 45, 7.6596, '+');
INSERT INTO `products_attributes` VALUES (2175, 318, 10, 44, 6.8085, '+');
INSERT INTO `products_attributes` VALUES (2174, 318, 10, 43, 5.5319, '+');
INSERT INTO `products_attributes` VALUES (2173, 318, 10, 42, 5.1064, '+');
INSERT INTO `products_attributes` VALUES (2172, 316, 10, 51, 9.3617, '+');
INSERT INTO `products_attributes` VALUES (2171, 316, 10, 50, 8.5106, '+');
INSERT INTO `products_attributes` VALUES (2170, 316, 10, 49, 12.7660, '+');
INSERT INTO `products_attributes` VALUES (2169, 316, 10, 48, 11.0638, '+');
INSERT INTO `products_attributes` VALUES (2168, 316, 10, 47, 10.2128, '+');
INSERT INTO `products_attributes` VALUES (2167, 316, 10, 46, 8.5106, '+');
INSERT INTO `products_attributes` VALUES (2166, 316, 10, 45, 7.6596, '+');
INSERT INTO `products_attributes` VALUES (2165, 316, 10, 44, 6.8085, '+');
INSERT INTO `products_attributes` VALUES (2164, 316, 10, 43, 5.5319, '+');
INSERT INTO `products_attributes` VALUES (2163, 316, 10, 42, 5.1064, '+');
INSERT INTO `products_attributes` VALUES (4197, 710, 9, 162, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4196, 710, 41, 154, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4195, 710, 29, 130, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4194, 710, 8, 128, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4193, 710, 32, 116, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4192, 730, 9, 36, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4191, 730, 30, 106, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4190, 730, 29, 105, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4189, 730, 8, 33, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4188, 730, 32, 116, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2152, 306, 10, 51, 9.3617, '+');
INSERT INTO `products_attributes` VALUES (2151, 306, 10, 50, 8.5106, '+');
INSERT INTO `products_attributes` VALUES (2150, 306, 10, 49, 12.7660, '+');
INSERT INTO `products_attributes` VALUES (2149, 306, 10, 48, 11.0638, '+');
INSERT INTO `products_attributes` VALUES (2148, 306, 10, 47, 10.2128, '+');
INSERT INTO `products_attributes` VALUES (2147, 306, 10, 46, 8.5106, '+');
INSERT INTO `products_attributes` VALUES (2146, 306, 10, 45, 7.6596, '+');
INSERT INTO `products_attributes` VALUES (2145, 306, 10, 44, 6.8085, '+');
INSERT INTO `products_attributes` VALUES (2144, 306, 10, 43, 5.5319, '+');
INSERT INTO `products_attributes` VALUES (2143, 306, 10, 42, 5.1064, '+');
INSERT INTO `products_attributes` VALUES (2142, 304, 10, 51, 9.3617, '+');
INSERT INTO `products_attributes` VALUES (2141, 304, 10, 50, 8.5106, '+');
INSERT INTO `products_attributes` VALUES (2140, 304, 10, 49, 12.7660, '+');
INSERT INTO `products_attributes` VALUES (2139, 304, 10, 48, 11.0638, '+');
INSERT INTO `products_attributes` VALUES (2138, 304, 10, 47, 10.2128, '+');
INSERT INTO `products_attributes` VALUES (2137, 304, 10, 46, 8.5106, '+');
INSERT INTO `products_attributes` VALUES (2136, 304, 10, 45, 7.6596, '+');
INSERT INTO `products_attributes` VALUES (2135, 304, 10, 44, 6.8085, '+');
INSERT INTO `products_attributes` VALUES (2134, 304, 10, 43, 5.5319, '+');
INSERT INTO `products_attributes` VALUES (2133, 304, 10, 42, 5.1064, '+');
INSERT INTO `products_attributes` VALUES (2132, 301, 10, 51, 9.3617, '+');
INSERT INTO `products_attributes` VALUES (2131, 301, 10, 50, 8.5106, '+');
INSERT INTO `products_attributes` VALUES (2130, 301, 10, 49, 12.7660, '+');
INSERT INTO `products_attributes` VALUES (2129, 301, 10, 48, 11.0638, '+');
INSERT INTO `products_attributes` VALUES (2128, 301, 10, 47, 10.2128, '+');
INSERT INTO `products_attributes` VALUES (2127, 301, 10, 46, 8.5106, '+');
INSERT INTO `products_attributes` VALUES (2126, 301, 10, 45, 7.6596, '+');
INSERT INTO `products_attributes` VALUES (2125, 301, 10, 44, 6.8085, '+');
INSERT INTO `products_attributes` VALUES (2124, 301, 10, 43, 5.5319, '+');
INSERT INTO `products_attributes` VALUES (2123, 301, 10, 42, 5.1064, '+');
INSERT INTO `products_attributes` VALUES (2122, 299, 10, 51, 9.3617, '+');
INSERT INTO `products_attributes` VALUES (2121, 299, 10, 50, 8.5106, '+');
INSERT INTO `products_attributes` VALUES (2120, 299, 10, 49, 12.7660, '+');
INSERT INTO `products_attributes` VALUES (2119, 299, 10, 48, 11.0638, '+');
INSERT INTO `products_attributes` VALUES (2118, 299, 10, 47, 10.2128, '+');
INSERT INTO `products_attributes` VALUES (2117, 299, 10, 46, 8.5106, '+');
INSERT INTO `products_attributes` VALUES (2116, 299, 10, 45, 7.6596, '+');
INSERT INTO `products_attributes` VALUES (2115, 299, 10, 44, 6.8085, '+');
INSERT INTO `products_attributes` VALUES (2114, 299, 10, 43, 5.5319, '+');
INSERT INTO `products_attributes` VALUES (2113, 299, 10, 42, 5.1064, '+');
INSERT INTO `products_attributes` VALUES (2112, 295, 10, 51, 9.3617, '+');
INSERT INTO `products_attributes` VALUES (2111, 295, 10, 50, 8.5106, '+');
INSERT INTO `products_attributes` VALUES (2110, 295, 10, 49, 12.7660, '+');
INSERT INTO `products_attributes` VALUES (2109, 295, 10, 48, 11.0638, '+');
INSERT INTO `products_attributes` VALUES (2108, 295, 10, 47, 10.2128, '+');
INSERT INTO `products_attributes` VALUES (2107, 295, 10, 46, 8.5106, '+');
INSERT INTO `products_attributes` VALUES (2106, 295, 10, 45, 7.6596, '+');
INSERT INTO `products_attributes` VALUES (2105, 295, 10, 44, 6.8085, '+');
INSERT INTO `products_attributes` VALUES (2104, 295, 10, 43, 5.5319, '+');
INSERT INTO `products_attributes` VALUES (2103, 295, 10, 42, 5.1064, '+');
INSERT INTO `products_attributes` VALUES (2102, 293, 10, 51, 9.3617, '+');
INSERT INTO `products_attributes` VALUES (2101, 293, 10, 50, 8.5106, '+');
INSERT INTO `products_attributes` VALUES (2100, 293, 10, 49, 12.7660, '+');
INSERT INTO `products_attributes` VALUES (2099, 293, 10, 48, 11.0638, '+');
INSERT INTO `products_attributes` VALUES (2098, 293, 10, 47, 10.2128, '+');
INSERT INTO `products_attributes` VALUES (2097, 293, 10, 46, 8.5106, '+');
INSERT INTO `products_attributes` VALUES (2096, 293, 10, 45, 7.6596, '+');
INSERT INTO `products_attributes` VALUES (2095, 293, 10, 44, 6.8085, '+');
INSERT INTO `products_attributes` VALUES (2094, 293, 10, 43, 5.5319, '+');
INSERT INTO `products_attributes` VALUES (2093, 293, 10, 42, 5.1064, '+');
INSERT INTO `products_attributes` VALUES (2092, 291, 10, 51, 9.3617, '+');
INSERT INTO `products_attributes` VALUES (2091, 291, 10, 50, 8.5106, '+');
INSERT INTO `products_attributes` VALUES (2090, 291, 10, 49, 12.7660, '+');
INSERT INTO `products_attributes` VALUES (2089, 291, 10, 48, 11.0638, '+');
INSERT INTO `products_attributes` VALUES (2088, 291, 10, 47, 10.2128, '+');
INSERT INTO `products_attributes` VALUES (2087, 291, 10, 46, 8.5106, '+');
INSERT INTO `products_attributes` VALUES (2086, 291, 10, 45, 7.6596, '+');
INSERT INTO `products_attributes` VALUES (2085, 291, 10, 44, 6.8085, '+');
INSERT INTO `products_attributes` VALUES (2084, 291, 10, 43, 5.5319, '+');
INSERT INTO `products_attributes` VALUES (2083, 291, 10, 42, 5.1064, '+');
INSERT INTO `products_attributes` VALUES (2082, 289, 10, 51, 9.3617, '+');
INSERT INTO `products_attributes` VALUES (2081, 289, 10, 50, 8.5106, '+');
INSERT INTO `products_attributes` VALUES (2080, 289, 10, 49, 12.7660, '+');
INSERT INTO `products_attributes` VALUES (2079, 289, 10, 48, 11.0638, '+');
INSERT INTO `products_attributes` VALUES (2078, 289, 10, 47, 10.2128, '+');
INSERT INTO `products_attributes` VALUES (2077, 289, 10, 46, 8.5106, '+');
INSERT INTO `products_attributes` VALUES (2076, 289, 10, 45, 7.6596, '+');
INSERT INTO `products_attributes` VALUES (2075, 289, 10, 44, 6.8085, '+');
INSERT INTO `products_attributes` VALUES (2074, 289, 10, 43, 5.5319, '+');
INSERT INTO `products_attributes` VALUES (2073, 289, 10, 42, 5.1064, '+');
INSERT INTO `products_attributes` VALUES (2072, 287, 10, 51, 9.3617, '+');
INSERT INTO `products_attributes` VALUES (2071, 287, 10, 50, 8.5106, '+');
INSERT INTO `products_attributes` VALUES (2070, 287, 10, 49, 12.7660, '+');
INSERT INTO `products_attributes` VALUES (2069, 287, 10, 48, 11.0638, '+');
INSERT INTO `products_attributes` VALUES (2068, 287, 10, 47, 10.2128, '+');
INSERT INTO `products_attributes` VALUES (2067, 287, 10, 46, 8.5106, '+');
INSERT INTO `products_attributes` VALUES (2066, 287, 10, 45, 7.6596, '+');
INSERT INTO `products_attributes` VALUES (2065, 287, 10, 44, 6.8085, '+');
INSERT INTO `products_attributes` VALUES (2064, 287, 10, 43, 5.5319, '+');
INSERT INTO `products_attributes` VALUES (2063, 287, 10, 42, 5.1064, '+');
INSERT INTO `products_attributes` VALUES (2062, 284, 10, 51, 9.3617, '+');
INSERT INTO `products_attributes` VALUES (2061, 284, 10, 50, 8.5106, '+');
INSERT INTO `products_attributes` VALUES (2060, 284, 10, 49, 12.7660, '+');
INSERT INTO `products_attributes` VALUES (2059, 284, 10, 48, 11.0638, '+');
INSERT INTO `products_attributes` VALUES (2058, 284, 10, 47, 10.2128, '+');
INSERT INTO `products_attributes` VALUES (2057, 284, 10, 46, 8.5106, '+');
INSERT INTO `products_attributes` VALUES (2056, 284, 10, 45, 7.6596, '+');
INSERT INTO `products_attributes` VALUES (2055, 284, 10, 44, 6.8085, '+');
INSERT INTO `products_attributes` VALUES (2054, 284, 10, 43, 5.5319, '+');
INSERT INTO `products_attributes` VALUES (2053, 284, 10, 42, 5.1064, '+');
INSERT INTO `products_attributes` VALUES (2052, 281, 10, 51, 9.3617, '+');
INSERT INTO `products_attributes` VALUES (2051, 281, 10, 50, 8.5106, '+');
INSERT INTO `products_attributes` VALUES (2050, 281, 10, 49, 12.7660, '+');
INSERT INTO `products_attributes` VALUES (2049, 281, 10, 48, 11.0638, '+');
INSERT INTO `products_attributes` VALUES (2048, 281, 10, 47, 10.2128, '+');
INSERT INTO `products_attributes` VALUES (2047, 281, 10, 46, 8.5106, '+');
INSERT INTO `products_attributes` VALUES (2046, 281, 10, 45, 7.6596, '+');
INSERT INTO `products_attributes` VALUES (2045, 281, 10, 44, 6.8085, '+');
INSERT INTO `products_attributes` VALUES (2044, 281, 10, 43, 5.5319, '+');
INSERT INTO `products_attributes` VALUES (2043, 281, 10, 42, 5.1064, '+');
INSERT INTO `products_attributes` VALUES (2042, 279, 10, 51, 9.3617, '+');
INSERT INTO `products_attributes` VALUES (2041, 279, 10, 50, 8.5106, '+');
INSERT INTO `products_attributes` VALUES (2040, 279, 10, 49, 12.7660, '+');
INSERT INTO `products_attributes` VALUES (2039, 279, 10, 48, 11.0638, '+');
INSERT INTO `products_attributes` VALUES (2038, 279, 10, 47, 10.2128, '+');
INSERT INTO `products_attributes` VALUES (2037, 279, 10, 46, 8.5106, '+');
INSERT INTO `products_attributes` VALUES (2036, 279, 10, 45, 7.6596, '+');
INSERT INTO `products_attributes` VALUES (2035, 279, 10, 44, 6.8085, '+');
INSERT INTO `products_attributes` VALUES (2034, 279, 10, 43, 5.5319, '+');
INSERT INTO `products_attributes` VALUES (2033, 279, 10, 42, 5.1064, '+');
INSERT INTO `products_attributes` VALUES (2032, 273, 10, 51, 9.3617, '+');
INSERT INTO `products_attributes` VALUES (2031, 273, 10, 50, 8.5106, '+');
INSERT INTO `products_attributes` VALUES (2030, 273, 10, 49, 12.7660, '+');
INSERT INTO `products_attributes` VALUES (2029, 273, 10, 48, 11.0638, '+');
INSERT INTO `products_attributes` VALUES (2028, 273, 10, 47, 10.2128, '+');
INSERT INTO `products_attributes` VALUES (2027, 273, 10, 46, 8.5106, '+');
INSERT INTO `products_attributes` VALUES (2026, 273, 10, 45, 7.6596, '+');
INSERT INTO `products_attributes` VALUES (2025, 273, 10, 44, 6.8085, '+');
INSERT INTO `products_attributes` VALUES (2024, 273, 10, 43, 5.5319, '+');
INSERT INTO `products_attributes` VALUES (2023, 273, 10, 42, 5.1064, '+');
INSERT INTO `products_attributes` VALUES (2022, 264, 10, 51, 9.3617, '+');
INSERT INTO `products_attributes` VALUES (2021, 264, 10, 50, 8.5106, '+');
INSERT INTO `products_attributes` VALUES (2020, 264, 10, 49, 12.7660, '+');
INSERT INTO `products_attributes` VALUES (2019, 264, 10, 48, 11.0638, '+');
INSERT INTO `products_attributes` VALUES (2018, 264, 10, 47, 10.2128, '+');
INSERT INTO `products_attributes` VALUES (2017, 264, 10, 46, 8.5106, '+');
INSERT INTO `products_attributes` VALUES (2016, 264, 10, 45, 7.6596, '+');
INSERT INTO `products_attributes` VALUES (2015, 264, 10, 44, 6.8085, '+');
INSERT INTO `products_attributes` VALUES (2014, 264, 10, 43, 5.5319, '+');
INSERT INTO `products_attributes` VALUES (2013, 264, 10, 42, 5.1064, '+');
INSERT INTO `products_attributes` VALUES (2012, 262, 10, 51, 9.3617, '+');
INSERT INTO `products_attributes` VALUES (2011, 262, 10, 50, 8.5106, '+');
INSERT INTO `products_attributes` VALUES (2010, 262, 10, 49, 12.7660, '+');
INSERT INTO `products_attributes` VALUES (2009, 262, 10, 48, 11.0638, '+');
INSERT INTO `products_attributes` VALUES (2008, 262, 10, 47, 10.2128, '+');
INSERT INTO `products_attributes` VALUES (2007, 262, 10, 46, 8.5106, '+');
INSERT INTO `products_attributes` VALUES (2006, 262, 10, 45, 7.6596, '+');
INSERT INTO `products_attributes` VALUES (2005, 262, 10, 44, 6.8085, '+');
INSERT INTO `products_attributes` VALUES (2004, 262, 10, 43, 5.5319, '+');
INSERT INTO `products_attributes` VALUES (2003, 262, 10, 42, 5.1064, '+');
INSERT INTO `products_attributes` VALUES (2002, 257, 10, 51, 9.3617, '+');
INSERT INTO `products_attributes` VALUES (2001, 257, 10, 50, 8.5106, '+');
INSERT INTO `products_attributes` VALUES (2000, 257, 10, 49, 12.7660, '+');
INSERT INTO `products_attributes` VALUES (1999, 257, 10, 48, 11.0638, '+');
INSERT INTO `products_attributes` VALUES (1998, 257, 10, 47, 10.2128, '+');
INSERT INTO `products_attributes` VALUES (1997, 257, 10, 46, 8.5106, '+');
INSERT INTO `products_attributes` VALUES (1996, 257, 10, 45, 7.6596, '+');
INSERT INTO `products_attributes` VALUES (1995, 257, 10, 44, 6.8085, '+');
INSERT INTO `products_attributes` VALUES (1994, 257, 10, 43, 5.5319, '+');
INSERT INTO `products_attributes` VALUES (1993, 257, 10, 42, 5.1064, '+');
INSERT INTO `products_attributes` VALUES (1992, 254, 10, 51, 9.3617, '+');
INSERT INTO `products_attributes` VALUES (1991, 254, 10, 50, 8.5106, '+');
INSERT INTO `products_attributes` VALUES (1990, 254, 10, 49, 12.7660, '+');
INSERT INTO `products_attributes` VALUES (1989, 254, 10, 48, 11.0638, '+');
INSERT INTO `products_attributes` VALUES (1988, 254, 10, 47, 10.2128, '+');
INSERT INTO `products_attributes` VALUES (1987, 254, 10, 46, 8.5106, '+');
INSERT INTO `products_attributes` VALUES (1986, 254, 10, 45, 7.6596, '+');
INSERT INTO `products_attributes` VALUES (1985, 254, 10, 44, 6.8085, '+');
INSERT INTO `products_attributes` VALUES (1984, 254, 10, 43, 5.5319, '+');
INSERT INTO `products_attributes` VALUES (1983, 254, 10, 42, 5.1064, '+');
INSERT INTO `products_attributes` VALUES (1982, 252, 10, 51, 9.3617, '+');
INSERT INTO `products_attributes` VALUES (1981, 252, 10, 50, 8.5106, '+');
INSERT INTO `products_attributes` VALUES (1980, 252, 10, 49, 12.7660, '+');
INSERT INTO `products_attributes` VALUES (1979, 252, 10, 48, 11.0638, '+');
INSERT INTO `products_attributes` VALUES (1978, 252, 10, 47, 10.2128, '+');
INSERT INTO `products_attributes` VALUES (1977, 252, 10, 46, 8.5106, '+');
INSERT INTO `products_attributes` VALUES (1976, 252, 10, 45, 7.6596, '+');
INSERT INTO `products_attributes` VALUES (1975, 252, 10, 44, 6.8085, '+');
INSERT INTO `products_attributes` VALUES (1974, 252, 10, 43, 5.5319, '+');
INSERT INTO `products_attributes` VALUES (1973, 252, 10, 42, 5.1064, '+');
INSERT INTO `products_attributes` VALUES (1972, 249, 10, 51, 9.3617, '+');
INSERT INTO `products_attributes` VALUES (1971, 249, 10, 50, 8.5106, '+');
INSERT INTO `products_attributes` VALUES (1970, 249, 10, 49, 12.7660, '+');
INSERT INTO `products_attributes` VALUES (1969, 249, 10, 48, 11.0638, '+');
INSERT INTO `products_attributes` VALUES (1968, 249, 10, 47, 10.2128, '+');
INSERT INTO `products_attributes` VALUES (1967, 249, 10, 46, 8.5106, '+');
INSERT INTO `products_attributes` VALUES (1966, 249, 10, 45, 7.6596, '+');
INSERT INTO `products_attributes` VALUES (1965, 249, 10, 44, 6.8085, '+');
INSERT INTO `products_attributes` VALUES (1964, 249, 10, 43, 5.5319, '+');
INSERT INTO `products_attributes` VALUES (1963, 249, 10, 42, 5.1064, '+');
INSERT INTO `products_attributes` VALUES (1962, 247, 10, 51, 9.3617, '+');
INSERT INTO `products_attributes` VALUES (1961, 247, 10, 50, 8.5106, '+');
INSERT INTO `products_attributes` VALUES (1960, 247, 10, 49, 12.7660, '+');
INSERT INTO `products_attributes` VALUES (1959, 247, 10, 48, 11.0638, '+');
INSERT INTO `products_attributes` VALUES (1958, 247, 10, 47, 10.2128, '+');
INSERT INTO `products_attributes` VALUES (1957, 247, 10, 46, 8.5106, '+');
INSERT INTO `products_attributes` VALUES (1956, 247, 10, 45, 7.6596, '+');
INSERT INTO `products_attributes` VALUES (1955, 247, 10, 44, 6.8085, '+');
INSERT INTO `products_attributes` VALUES (1954, 247, 10, 43, 5.5319, '+');
INSERT INTO `products_attributes` VALUES (1953, 247, 10, 42, 5.1064, '+');
INSERT INTO `products_attributes` VALUES (1952, 245, 10, 51, 9.3617, '+');
INSERT INTO `products_attributes` VALUES (1951, 245, 10, 50, 8.5106, '+');
INSERT INTO `products_attributes` VALUES (1950, 245, 10, 49, 12.7660, '+');
INSERT INTO `products_attributes` VALUES (1949, 245, 10, 48, 11.0638, '+');
INSERT INTO `products_attributes` VALUES (1948, 245, 10, 47, 10.2128, '+');
INSERT INTO `products_attributes` VALUES (1947, 245, 10, 46, 8.5106, '+');
INSERT INTO `products_attributes` VALUES (1946, 245, 10, 45, 7.6596, '+');
INSERT INTO `products_attributes` VALUES (1945, 245, 10, 44, 6.8085, '+');
INSERT INTO `products_attributes` VALUES (1944, 245, 10, 43, 5.5319, '+');
INSERT INTO `products_attributes` VALUES (1943, 245, 10, 42, 5.1064, '+');
INSERT INTO `products_attributes` VALUES (1942, 242, 10, 51, 9.3617, '+');
INSERT INTO `products_attributes` VALUES (1941, 242, 10, 50, 8.5106, '+');
INSERT INTO `products_attributes` VALUES (1940, 242, 10, 49, 12.7660, '+');
INSERT INTO `products_attributes` VALUES (1939, 242, 10, 48, 11.0638, '+');
INSERT INTO `products_attributes` VALUES (1938, 242, 10, 47, 10.2128, '+');
INSERT INTO `products_attributes` VALUES (1937, 242, 10, 46, 8.5106, '+');
INSERT INTO `products_attributes` VALUES (1936, 242, 10, 45, 7.6596, '+');
INSERT INTO `products_attributes` VALUES (1935, 242, 10, 44, 6.8085, '+');
INSERT INTO `products_attributes` VALUES (1934, 242, 10, 43, 5.5319, '+');
INSERT INTO `products_attributes` VALUES (1933, 242, 10, 42, 5.1064, '+');
INSERT INTO `products_attributes` VALUES (1932, 239, 10, 51, 9.3617, '+');
INSERT INTO `products_attributes` VALUES (1931, 239, 10, 50, 8.5106, '+');
INSERT INTO `products_attributes` VALUES (1930, 239, 10, 49, 12.7660, '+');
INSERT INTO `products_attributes` VALUES (1929, 239, 10, 48, 11.0638, '+');
INSERT INTO `products_attributes` VALUES (1928, 239, 10, 47, 10.2128, '+');
INSERT INTO `products_attributes` VALUES (1927, 239, 10, 46, 8.5106, '+');
INSERT INTO `products_attributes` VALUES (1926, 239, 10, 45, 7.6596, '+');
INSERT INTO `products_attributes` VALUES (1925, 239, 10, 44, 6.8085, '+');
INSERT INTO `products_attributes` VALUES (1924, 239, 10, 43, 5.5319, '+');
INSERT INTO `products_attributes` VALUES (1923, 239, 10, 42, 5.1064, '+');
INSERT INTO `products_attributes` VALUES (4202, 711, 41, 154, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4201, 711, 29, 130, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4187, 729, 9, 38, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4186, 729, 30, 148, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4185, 729, 29, 105, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4184, 729, 8, 33, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4183, 729, 32, 116, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4182, 271, 29, 105, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4181, 271, 8, 33, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4180, 271, 32, 116, 0.0000, '');
INSERT INTO `products_attributes` VALUES (1912, 234, 10, 51, 9.3617, '+');
INSERT INTO `products_attributes` VALUES (1911, 234, 10, 50, 8.5106, '+');
INSERT INTO `products_attributes` VALUES (1910, 234, 10, 49, 12.7660, '+');
INSERT INTO `products_attributes` VALUES (1909, 234, 10, 48, 11.0638, '+');
INSERT INTO `products_attributes` VALUES (1908, 234, 10, 47, 10.2128, '+');
INSERT INTO `products_attributes` VALUES (1907, 234, 10, 46, 8.5106, '+');
INSERT INTO `products_attributes` VALUES (1906, 234, 10, 45, 7.6596, '+');
INSERT INTO `products_attributes` VALUES (1905, 234, 10, 44, 6.8085, '+');
INSERT INTO `products_attributes` VALUES (1904, 234, 10, 43, 5.5319, '+');
INSERT INTO `products_attributes` VALUES (1903, 234, 10, 42, 5.1064, '+');
INSERT INTO `products_attributes` VALUES (1902, 231, 10, 51, 9.3617, '+');
INSERT INTO `products_attributes` VALUES (1901, 231, 10, 50, 8.5106, '+');
INSERT INTO `products_attributes` VALUES (1900, 231, 10, 49, 12.7660, '+');
INSERT INTO `products_attributes` VALUES (1899, 231, 10, 48, 11.0638, '+');
INSERT INTO `products_attributes` VALUES (1898, 231, 10, 47, 10.2128, '+');
INSERT INTO `products_attributes` VALUES (1897, 231, 10, 46, 8.5106, '+');
INSERT INTO `products_attributes` VALUES (1896, 231, 10, 45, 7.6596, '+');
INSERT INTO `products_attributes` VALUES (1895, 231, 10, 44, 6.8085, '+');
INSERT INTO `products_attributes` VALUES (1894, 231, 10, 43, 5.5319, '+');
INSERT INTO `products_attributes` VALUES (1893, 231, 10, 42, 5.1064, '+');
INSERT INTO `products_attributes` VALUES (1892, 229, 10, 51, 9.3617, '+');
INSERT INTO `products_attributes` VALUES (1891, 229, 10, 50, 8.5106, '+');
INSERT INTO `products_attributes` VALUES (1890, 229, 10, 49, 12.7660, '+');
INSERT INTO `products_attributes` VALUES (1889, 229, 10, 48, 11.0638, '+');
INSERT INTO `products_attributes` VALUES (1888, 229, 10, 47, 10.2128, '+');
INSERT INTO `products_attributes` VALUES (1887, 229, 10, 46, 8.5106, '+');
INSERT INTO `products_attributes` VALUES (1886, 229, 10, 45, 7.6596, '+');
INSERT INTO `products_attributes` VALUES (1885, 229, 10, 44, 6.8085, '+');
INSERT INTO `products_attributes` VALUES (1884, 229, 10, 43, 5.5319, '+');
INSERT INTO `products_attributes` VALUES (1883, 229, 10, 42, 5.1064, '+');
INSERT INTO `products_attributes` VALUES (1882, 227, 10, 51, 9.3617, '+');
INSERT INTO `products_attributes` VALUES (1881, 227, 10, 50, 8.5106, '+');
INSERT INTO `products_attributes` VALUES (1880, 227, 10, 49, 12.7660, '+');
INSERT INTO `products_attributes` VALUES (1879, 227, 10, 48, 11.0638, '+');
INSERT INTO `products_attributes` VALUES (1878, 227, 10, 47, 10.2128, '+');
INSERT INTO `products_attributes` VALUES (1877, 227, 10, 46, 8.5106, '+');
INSERT INTO `products_attributes` VALUES (1876, 227, 10, 45, 7.6596, '+');
INSERT INTO `products_attributes` VALUES (1875, 227, 10, 44, 6.8085, '+');
INSERT INTO `products_attributes` VALUES (1874, 227, 10, 43, 5.5319, '+');
INSERT INTO `products_attributes` VALUES (1873, 227, 10, 42, 5.1064, '+');
INSERT INTO `products_attributes` VALUES (1872, 222, 10, 51, 9.3617, '+');
INSERT INTO `products_attributes` VALUES (1871, 222, 10, 50, 8.5106, '+');
INSERT INTO `products_attributes` VALUES (1870, 222, 10, 49, 12.7660, '+');
INSERT INTO `products_attributes` VALUES (1869, 222, 10, 48, 11.0638, '+');
INSERT INTO `products_attributes` VALUES (1868, 222, 10, 47, 10.2128, '+');
INSERT INTO `products_attributes` VALUES (1867, 222, 10, 46, 8.5106, '+');
INSERT INTO `products_attributes` VALUES (1866, 222, 10, 45, 7.6596, '+');
INSERT INTO `products_attributes` VALUES (1865, 222, 10, 44, 6.8085, '+');
INSERT INTO `products_attributes` VALUES (1864, 222, 10, 43, 5.5319, '+');
INSERT INTO `products_attributes` VALUES (1863, 222, 10, 42, 5.1064, '+');
INSERT INTO `products_attributes` VALUES (1795, 349, 4, 7, 0.0000, '');
INSERT INTO `products_attributes` VALUES (1796, 349, 2, 21, 0.0000, '');
INSERT INTO `products_attributes` VALUES (1797, 349, 1, 2, 0.0000, '');
INSERT INTO `products_attributes` VALUES (1798, 349, 5, 12, 0.0000, '');
INSERT INTO `products_attributes` VALUES (1799, 349, 3, 6, 0.0000, '');
INSERT INTO `products_attributes` VALUES (1800, 349, 6, 9, 0.0000, '');
INSERT INTO `products_attributes` VALUES (1801, 350, 4, 22, 0.0000, '');
INSERT INTO `products_attributes` VALUES (1802, 350, 2, 31, 0.0000, '');
INSERT INTO `products_attributes` VALUES (1803, 350, 1, 2, 0.0000, '');
INSERT INTO `products_attributes` VALUES (1804, 350, 5, 12, 0.0000, '');
INSERT INTO `products_attributes` VALUES (1805, 350, 3, 6, 0.0000, '');
INSERT INTO `products_attributes` VALUES (1806, 350, 6, 9, 0.0000, '');
INSERT INTO `products_attributes` VALUES (1809, 351, 5, 27, 0.0000, '');
INSERT INTO `products_attributes` VALUES (1810, 351, 3, 6, 0.0000, '');
INSERT INTO `products_attributes` VALUES (1811, 351, 6, 9, 0.0000, '');
INSERT INTO `products_attributes` VALUES (1812, 352, 9, 35, 0.0000, '');
INSERT INTO `products_attributes` VALUES (1813, 353, 9, 35, 0.0000, '');
INSERT INTO `products_attributes` VALUES (1814, 356, 9, 34, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1815, 360, 9, 34, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1816, 368, 9, 34, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1817, 375, 9, 34, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1818, 371, 9, 37, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1819, 354, 9, 36, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1820, 358, 9, 36, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1821, 361, 9, 36, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1822, 363, 9, 36, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1823, 365, 9, 36, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1824, 369, 9, 36, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1825, 374, 9, 36, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1826, 367, 9, 38, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1827, 372, 9, 38, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1828, 355, 9, 35, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1829, 357, 9, 35, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1830, 359, 9, 35, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1831, 362, 9, 35, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1832, 364, 9, 35, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1833, 366, 9, 35, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1834, 370, 9, 35, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1835, 373, 9, 35, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (1836, 376, 4, 7, 0.0000, '');
INSERT INTO `products_attributes` VALUES (1837, 376, 2, 4, 0.0000, '');
INSERT INTO `products_attributes` VALUES (1838, 376, 1, 2, 0.0000, '');
INSERT INTO `products_attributes` VALUES (1839, 377, 4, 7, 0.0000, '');
INSERT INTO `products_attributes` VALUES (1840, 377, 2, 3, 0.0000, '');
INSERT INTO `products_attributes` VALUES (1841, 377, 1, 2, 0.0000, '');
INSERT INTO `products_attributes` VALUES (1842, 378, 4, 7, 0.0000, '');
INSERT INTO `products_attributes` VALUES (1843, 378, 2, 31, 0.0000, '');
INSERT INTO `products_attributes` VALUES (1844, 378, 1, 2, 0.0000, '');
INSERT INTO `products_attributes` VALUES (1845, 379, 4, 7, 0.0000, '');
INSERT INTO `products_attributes` VALUES (1846, 379, 1, 2, 0.0000, '');
INSERT INTO `products_attributes` VALUES (1847, 380, 4, 7, 0.0000, '');
INSERT INTO `products_attributes` VALUES (1848, 380, 1, 2, 0.0000, '');
INSERT INTO `products_attributes` VALUES (1849, 381, 4, 7, 0.0000, '');
INSERT INTO `products_attributes` VALUES (1850, 381, 2, 16, 0.0000, '');
INSERT INTO `products_attributes` VALUES (1851, 381, 1, 2, 0.0000, '');
INSERT INTO `products_attributes` VALUES (1852, 382, 4, 7, 0.0000, '');
INSERT INTO `products_attributes` VALUES (1853, 382, 1, 2, 0.0000, '');
INSERT INTO `products_attributes` VALUES (1854, 383, 4, 7, 0.0000, '');
INSERT INTO `products_attributes` VALUES (1855, 383, 1, 2, 0.0000, '');
INSERT INTO `products_attributes` VALUES (1856, 384, 4, 7, 0.0000, '');
INSERT INTO `products_attributes` VALUES (1857, 384, 1, 2, 0.0000, '');
INSERT INTO `products_attributes` VALUES (1858, 379, 2, 52, 0.0000, '');
INSERT INTO `products_attributes` VALUES (1859, 380, 2, 53, 0.0000, '');
INSERT INTO `products_attributes` VALUES (1860, 382, 2, 54, 0.0000, '');
INSERT INTO `products_attributes` VALUES (1861, 383, 2, 55, 0.0000, '');
INSERT INTO `products_attributes` VALUES (1862, 384, 2, 56, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2191, 386, 1, 2, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2201, 388, 11, 57, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (2193, 386, 3, 6, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2194, 386, 6, 9, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2195, 387, 4, 7, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2196, 387, 2, 21, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2197, 387, 1, 2, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2202, 389, 11, 57, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (2199, 387, 3, 6, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2200, 387, 6, 9, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2203, 390, 11, 57, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (2204, 391, 11, 57, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (2274, 461, 5, 27, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2206, 393, 11, 57, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (2207, 394, 11, 57, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (2208, 395, 11, 57, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (2209, 396, 11, 57, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (2210, 397, 11, 57, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (2211, 398, 11, 57, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (2212, 399, 11, 57, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (2273, 461, 1, 1, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2214, 401, 11, 57, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (2215, 402, 11, 57, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (2216, 403, 11, 57, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (2217, 404, 11, 58, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (2275, 461, 3, 5, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2219, 406, 11, 58, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (2220, 407, 11, 58, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (2221, 408, 11, 58, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (2222, 436, 11, 58, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (2223, 437, 11, 58, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (2224, 438, 11, 58, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (2225, 439, 11, 57, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (2226, 440, 11, 58, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (2227, 441, 11, 58, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (2228, 442, 11, 58, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (2229, 443, 11, 58, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (2230, 444, 11, 58, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (2231, 445, 11, 58, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (2232, 446, 11, 58, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (2233, 447, 11, 58, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (2234, 425, 11, 57, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (2235, 426, 11, 57, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (2236, 427, 11, 57, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (2237, 428, 11, 57, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (2238, 429, 11, 57, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (2239, 430, 11, 57, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (2240, 431, 11, 57, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (2241, 432, 11, 57, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (2242, 433, 11, 57, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (2243, 434, 11, 57, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (2244, 435, 11, 57, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (2245, 412, 11, 60, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (2246, 413, 11, 60, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (2247, 409, 11, 59, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (2248, 410, 11, 59, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (2249, 411, 11, 59, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (2250, 420, 11, 62, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (2251, 421, 11, 62, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (2252, 422, 11, 62, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (2253, 423, 11, 62, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (2254, 424, 11, 62, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (2255, 414, 11, 61, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (2256, 415, 11, 61, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (2257, 416, 11, 61, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (2258, 417, 11, 61, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (2259, 418, 11, 61, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (2260, 419, 11, 61, 0.0000, '+');
INSERT INTO `products_attributes` VALUES (2276, 461, 6, 9, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2277, 462, 4, 7, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2278, 462, 1, 1, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2279, 462, 5, 27, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2280, 462, 7, 18, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2281, 462, 6, 9, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2282, 463, 4, 7, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2283, 463, 1, 2, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2284, 463, 5, 27, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2285, 463, 3, 6, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2286, 463, 6, 9, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2287, 464, 4, 7, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2288, 464, 1, 2, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2289, 464, 5, 12, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2290, 464, 3, 6, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2291, 464, 6, 9, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2292, 465, 4, 7, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2293, 465, 2, 4, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2294, 465, 1, 2, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2295, 465, 5, 27, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2296, 465, 7, 20, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2297, 465, 6, 9, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2298, 466, 4, 7, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2299, 466, 1, 2, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2300, 466, 5, 27, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2301, 466, 7, 18, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2302, 466, 6, 9, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2303, 467, 4, 8, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2304, 467, 2, 21, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2305, 467, 1, 2, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2306, 467, 5, 27, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2307, 467, 3, 6, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2308, 467, 6, 9, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2309, 468, 4, 8, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2310, 468, 2, 21, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2311, 468, 1, 2, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2312, 468, 5, 12, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2313, 468, 3, 6, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2314, 468, 6, 9, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2315, 469, 4, 22, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2316, 469, 2, 3, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2317, 469, 1, 2, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2318, 469, 5, 12, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2319, 469, 3, 6, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2320, 469, 6, 9, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2321, 471, 4, 8, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2322, 471, 2, 21, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2323, 471, 1, 2, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2324, 471, 5, 12, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2325, 471, 3, 6, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2326, 471, 6, 9, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2327, 472, 4, 7, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2328, 472, 2, 4, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2329, 472, 1, 2, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2330, 472, 5, 27, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2331, 472, 3, 6, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2332, 472, 6, 9, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2333, 473, 4, 7, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2334, 473, 2, 4, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2335, 473, 1, 2, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2336, 473, 5, 12, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2337, 473, 3, 6, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2338, 473, 6, 9, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2339, 474, 4, 7, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2340, 474, 2, 4, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2341, 474, 1, 2, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2342, 474, 5, 19, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2343, 474, 3, 6, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2344, 474, 6, 9, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2345, 475, 4, 8, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2346, 475, 2, 21, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2347, 475, 1, 2, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2348, 475, 5, 27, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2349, 475, 3, 6, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2350, 475, 6, 9, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2351, 476, 4, 8, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2352, 476, 2, 21, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2353, 476, 1, 2, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2354, 476, 5, 12, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2355, 476, 3, 6, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2356, 476, 6, 9, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2357, 477, 4, 7, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4111, 477, 2, 164, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2359, 477, 1, 1, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2360, 477, 5, 26, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2361, 477, 3, 6, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2362, 477, 6, 9, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2363, 478, 4, 7, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2364, 478, 1, 1, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2365, 478, 5, 12, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2366, 478, 3, 6, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2367, 478, 6, 11, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2368, 479, 4, 7, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2369, 479, 2, 56, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2370, 479, 1, 1, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2371, 479, 5, 12, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2372, 479, 7, 20, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2373, 479, 6, 11, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2374, 480, 4, 7, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2375, 480, 2, 3, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2376, 480, 1, 1, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2377, 480, 5, 12, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2378, 480, 3, 6, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2379, 480, 6, 11, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2441, 492, 15, 70, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2440, 492, 12, 73, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2439, 492, 14, 69, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2438, 492, 13, 72, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2437, 191, 2, 63, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2436, 460, 2, 63, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2386, 482, 4, 8, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2387, 482, 2, 3, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2388, 482, 1, 1, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2389, 482, 5, 12, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2390, 482, 3, 6, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2391, 482, 6, 9, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2447, 496, 12, 73, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2446, 496, 14, 69, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2445, 496, 13, 72, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2444, 493, 12, 73, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2443, 493, 14, 69, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2442, 493, 13, 72, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2398, 484, 4, 7, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2399, 484, 2, 3, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2400, 484, 1, 1, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2401, 484, 5, 12, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2402, 484, 3, 6, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2403, 484, 6, 10, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2404, 485, 4, 7, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2405, 485, 2, 3, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2406, 485, 1, 1, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2407, 485, 5, 12, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2408, 485, 3, 6, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2409, 485, 6, 10, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2410, 486, 4, 8, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2411, 486, 2, 3, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2412, 486, 1, 1, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2413, 486, 5, 27, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2414, 486, 7, 20, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2415, 486, 6, 9, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2416, 487, 4, 7, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2417, 487, 2, 21, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2418, 487, 1, 2, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2419, 487, 5, 27, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2420, 487, 3, 6, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2421, 487, 6, 9, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2422, 488, 4, 7, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2423, 488, 2, 21, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2424, 488, 1, 2, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2425, 488, 5, 12, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2426, 488, 3, 6, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2427, 488, 6, 9, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2428, 470, 4, 8, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2429, 470, 2, 21, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2430, 470, 1, 2, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2431, 470, 5, 27, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2432, 470, 3, 6, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2433, 470, 6, 9, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2434, 466, 2, 14, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2435, 462, 2, 14, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2448, 494, 13, 72, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2449, 494, 14, 67, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2450, 494, 12, 73, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2451, 494, 15, 77, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2452, 495, 13, 72, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2453, 495, 14, 69, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2454, 495, 12, 73, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2455, 495, 15, 70, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2456, 492, 16, 78, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2457, 495, 16, 78, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2458, 497, 16, 78, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2459, 497, 13, 72, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2460, 497, 14, 69, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2461, 497, 12, 73, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2462, 497, 15, 71, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2463, 493, 16, 78, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2464, 496, 16, 78, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2465, 494, 16, 78, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2466, 498, 16, 78, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2467, 498, 13, 72, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2468, 498, 14, 69, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2469, 498, 12, 73, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2470, 499, 16, 78, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2471, 499, 13, 72, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2472, 499, 14, 67, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2473, 499, 12, 73, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2474, 500, 16, 78, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2475, 500, 13, 72, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2476, 500, 14, 69, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2477, 500, 12, 73, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2478, 501, 16, 78, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2479, 501, 13, 72, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2480, 501, 14, 69, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2481, 501, 12, 73, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2482, 502, 16, 78, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2483, 502, 13, 72, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2484, 502, 14, 69, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2485, 502, 12, 73, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2486, 503, 21, 80, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2487, 503, 17, 87, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2488, 503, 18, 89, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2489, 503, 20, 91, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2490, 503, 19, 92, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2491, 504, 21, 80, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2492, 504, 17, 87, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2493, 504, 18, 89, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2494, 504, 20, 91, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2495, 504, 19, 94, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2496, 503, 22, 95, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2497, 504, 22, 95, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2498, 505, 21, 80, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2499, 505, 17, 87, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2500, 505, 18, 89, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2501, 505, 22, 95, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2502, 505, 20, 91, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2503, 505, 19, 96, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2504, 506, 21, 80, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2505, 506, 17, 87, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2506, 506, 18, 89, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2507, 506, 22, 95, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2508, 506, 20, 91, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2509, 506, 19, 92, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2510, 507, 21, 80, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2511, 507, 17, 87, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2512, 507, 18, 89, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2513, 507, 22, 95, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2514, 507, 20, 91, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2515, 507, 19, 92, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2516, 508, 21, 80, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2517, 508, 17, 87, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2518, 508, 18, 89, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2519, 508, 22, 95, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2520, 508, 20, 91, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2521, 508, 19, 94, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2522, 509, 21, 80, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2523, 509, 17, 87, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2524, 509, 18, 89, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2525, 509, 22, 95, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2526, 509, 20, 91, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2527, 509, 19, 92, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2528, 510, 21, 80, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2529, 510, 17, 87, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2530, 510, 18, 89, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2531, 510, 22, 95, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2532, 510, 20, 91, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2533, 510, 19, 92, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2534, 511, 21, 80, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2535, 511, 17, 87, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2536, 511, 18, 89, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2537, 511, 22, 95, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2538, 511, 20, 91, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2539, 511, 19, 92, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2540, 512, 21, 80, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2541, 512, 17, 87, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2542, 512, 18, 88, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2543, 512, 22, 95, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2544, 512, 20, 91, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2545, 512, 19, 92, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2546, 513, 21, 80, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2547, 513, 17, 87, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2548, 513, 18, 88, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2549, 513, 22, 95, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2550, 513, 20, 91, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2551, 513, 19, 92, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2552, 514, 21, 80, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2553, 514, 17, 87, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2554, 514, 18, 88, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2555, 514, 22, 95, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2556, 514, 20, 91, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2557, 514, 19, 92, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2558, 515, 21, 80, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2559, 515, 17, 87, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2560, 515, 18, 88, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2561, 515, 22, 95, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2562, 515, 20, 91, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2563, 515, 19, 97, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2575, 517, 19, 94, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2574, 517, 20, 91, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2573, 517, 22, 95, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2572, 517, 18, 89, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2571, 517, 17, 87, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2570, 517, 21, 80, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2576, 519, 23, 98, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2577, 519, 25, 100, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2578, 519, 24, 99, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2579, 520, 28, 103, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2580, 520, 26, 102, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2581, 520, 27, 104, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2582, 521, 28, 103, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2583, 521, 26, 102, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2584, 521, 27, 104, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2585, 522, 28, 103, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2586, 522, 26, 102, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2587, 522, 27, 104, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2588, 523, 28, 103, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2589, 523, 26, 102, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2590, 523, 27, 104, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2591, 524, 28, 103, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2592, 524, 26, 102, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2593, 524, 27, 104, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2594, 525, 28, 103, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2595, 525, 26, 102, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2596, 525, 27, 104, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2597, 518, 25, 100, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2598, 518, 23, 98, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2599, 518, 24, 99, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2600, 526, 25, 100, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2601, 526, 23, 98, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2602, 526, 24, 99, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2603, 528, 25, 100, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2604, 528, 23, 98, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2605, 528, 24, 99, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2606, 527, 25, 100, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2607, 527, 23, 98, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2608, 527, 24, 99, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2609, 529, 25, 100, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2610, 529, 23, 98, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2611, 529, 24, 99, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2612, 530, 25, 100, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2613, 530, 23, 98, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2614, 530, 24, 99, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2615, 531, 8, 33, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2616, 531, 29, 105, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2617, 531, 9, 34, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2618, 532, 8, 33, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2619, 532, 29, 105, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2620, 532, 9, 37, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2621, 533, 8, 33, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2622, 533, 29, 105, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2623, 533, 9, 37, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2624, 534, 8, 33, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2625, 534, 29, 105, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2626, 534, 9, 38, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2627, 268, 8, 33, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2628, 268, 29, 105, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2629, 277, 8, 33, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2630, 277, 29, 105, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2631, 262, 8, 33, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2632, 262, 29, 105, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2633, 262, 30, 108, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2634, 257, 8, 33, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2635, 257, 29, 105, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2636, 257, 30, 107, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2637, 264, 8, 33, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2638, 264, 29, 105, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2639, 264, 30, 108, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2640, 247, 8, 33, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2641, 247, 29, 105, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2642, 247, 30, 106, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2643, 316, 8, 33, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2644, 316, 29, 105, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2645, 316, 30, 106, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2646, 318, 8, 33, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2647, 318, 29, 105, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2648, 318, 30, 106, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4179, 728, 9, 35, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4178, 728, 29, 130, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4177, 728, 8, 128, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2652, 245, 8, 33, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2653, 245, 29, 105, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2654, 245, 30, 106, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2655, 273, 8, 33, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2656, 273, 29, 105, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2657, 301, 8, 33, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2658, 301, 29, 105, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2659, 299, 8, 33, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2660, 299, 29, 105, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2661, 287, 8, 33, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2662, 287, 29, 105, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2663, 234, 8, 33, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2664, 234, 29, 105, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2665, 234, 30, 106, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2666, 222, 8, 33, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2667, 222, 29, 105, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2668, 222, 30, 109, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2669, 227, 8, 33, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2670, 227, 29, 105, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2671, 227, 30, 106, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2672, 231, 8, 33, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2673, 231, 29, 105, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2674, 231, 30, 106, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2675, 229, 8, 33, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2676, 229, 29, 105, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2677, 229, 30, 106, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2678, 295, 8, 33, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2679, 295, 29, 105, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2680, 293, 8, 33, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2681, 293, 29, 105, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2682, 284, 8, 33, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2683, 284, 29, 105, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2684, 239, 8, 33, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2685, 239, 29, 105, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2686, 239, 30, 106, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2687, 304, 8, 33, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2688, 304, 29, 105, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2689, 289, 8, 33, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2690, 289, 29, 105, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2691, 252, 8, 33, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2692, 252, 29, 105, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2693, 252, 30, 106, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2694, 306, 8, 33, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2695, 306, 29, 105, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2696, 306, 30, 106, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2697, 279, 8, 33, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2698, 279, 29, 105, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2699, 254, 8, 33, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2700, 254, 29, 105, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2701, 254, 30, 106, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2702, 281, 8, 33, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2703, 281, 29, 105, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2704, 242, 8, 33, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2705, 242, 29, 105, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2706, 242, 30, 106, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2707, 249, 8, 33, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2708, 249, 29, 105, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2709, 249, 30, 106, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2710, 291, 8, 33, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2711, 291, 29, 105, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2712, 255, 31, 110, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2713, 255, 8, 33, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2714, 255, 29, 105, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2715, 255, 30, 112, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2716, 259, 31, 110, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2717, 259, 8, 33, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2718, 259, 29, 105, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2719, 259, 30, 107, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2720, 263, 31, 110, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2721, 263, 8, 33, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2722, 263, 29, 105, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2723, 263, 30, 108, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2724, 261, 31, 110, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2725, 261, 8, 33, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2726, 261, 29, 105, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2727, 261, 30, 108, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2728, 267, 31, 111, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2729, 267, 8, 33, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2730, 267, 29, 105, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2731, 241, 31, 111, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2732, 241, 8, 33, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2733, 241, 29, 105, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2734, 241, 30, 106, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2735, 248, 31, 111, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2736, 248, 8, 33, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2737, 248, 29, 105, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2738, 248, 30, 106, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2739, 246, 31, 110, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2740, 246, 8, 33, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2741, 246, 29, 105, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2742, 246, 30, 106, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2743, 228, 31, 111, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2744, 228, 8, 33, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2745, 228, 29, 105, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2746, 228, 30, 106, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2747, 251, 31, 110, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2748, 251, 8, 33, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2749, 251, 29, 105, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2750, 251, 30, 106, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2751, 315, 31, 110, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2752, 315, 8, 33, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2753, 315, 29, 105, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2754, 315, 30, 106, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2755, 233, 31, 110, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2756, 233, 8, 33, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2757, 233, 29, 105, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2758, 233, 30, 106, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2759, 226, 31, 110, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2760, 226, 8, 33, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2761, 226, 29, 105, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2762, 226, 30, 106, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2763, 317, 31, 110, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2764, 317, 8, 33, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2765, 317, 29, 105, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2766, 317, 30, 106, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2767, 253, 31, 110, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2768, 253, 8, 33, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2769, 253, 29, 105, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2770, 253, 30, 106, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2771, 244, 31, 110, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2772, 244, 8, 33, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2773, 244, 29, 105, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2774, 244, 30, 106, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2775, 305, 31, 110, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2776, 305, 8, 33, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2777, 305, 29, 105, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2778, 305, 30, 106, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2779, 319, 31, 110, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2780, 319, 8, 33, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2781, 319, 29, 105, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2782, 319, 30, 106, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2783, 283, 31, 111, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2784, 283, 8, 33, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2785, 283, 29, 105, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2786, 238, 31, 111, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2787, 238, 8, 33, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2788, 238, 29, 105, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2789, 238, 30, 106, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2790, 274, 31, 111, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2791, 274, 8, 33, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2792, 274, 29, 105, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2793, 294, 31, 110, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2794, 294, 8, 33, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2795, 294, 29, 105, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2796, 272, 31, 111, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2797, 272, 8, 33, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2798, 272, 29, 105, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2799, 292, 31, 110, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2800, 292, 8, 33, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2801, 292, 29, 105, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2802, 298, 31, 110, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2803, 298, 8, 33, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2804, 298, 29, 105, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2805, 286, 31, 110, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2806, 286, 8, 33, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2807, 286, 29, 105, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2808, 276, 31, 111, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2809, 276, 8, 33, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2810, 276, 29, 105, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2811, 265, 31, 111, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2812, 265, 8, 33, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2813, 265, 29, 105, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2814, 278, 31, 113, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2815, 278, 8, 33, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2816, 278, 29, 105, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2817, 220, 31, 110, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2818, 220, 8, 33, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2819, 220, 29, 105, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2820, 220, 30, 109, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2821, 224, 31, 110, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2822, 224, 8, 33, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2823, 224, 29, 105, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2824, 224, 30, 109, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2825, 221, 31, 110, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2826, 221, 8, 33, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2827, 221, 29, 105, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2828, 221, 30, 109, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2829, 300, 31, 110, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2830, 300, 8, 33, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2831, 300, 29, 105, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2832, 280, 31, 110, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2833, 280, 8, 33, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2834, 280, 29, 105, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2835, 303, 31, 111, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2836, 303, 8, 33, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2837, 303, 29, 105, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2838, 230, 31, 110, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2839, 230, 8, 33, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2840, 230, 29, 105, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2841, 230, 30, 106, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2842, 296, 31, 110, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2843, 296, 8, 33, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2844, 296, 29, 105, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2845, 270, 31, 111, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2846, 270, 8, 33, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2847, 270, 29, 105, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2848, 290, 31, 111, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2849, 290, 8, 33, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2850, 290, 29, 105, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2851, 288, 31, 110, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2852, 288, 8, 33, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2853, 288, 29, 105, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2854, 235, 31, 111, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2855, 235, 8, 33, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2856, 235, 29, 105, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2857, 235, 30, 106, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2858, 256, 8, 33, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2859, 256, 29, 105, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2860, 256, 30, 108, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2861, 313, 8, 33, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2862, 313, 29, 105, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2863, 240, 8, 33, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2864, 240, 29, 105, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2865, 240, 30, 106, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2866, 250, 8, 33, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2867, 250, 29, 105, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2868, 250, 30, 106, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2869, 310, 8, 33, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2870, 310, 29, 105, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2871, 310, 30, 106, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2872, 285, 8, 33, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2873, 285, 29, 105, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2874, 232, 8, 33, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2875, 232, 29, 105, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2876, 232, 30, 106, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2877, 223, 8, 33, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2878, 223, 29, 105, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2879, 223, 30, 109, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2880, 302, 8, 33, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2881, 302, 29, 105, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2882, 269, 8, 33, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2883, 269, 29, 105, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2884, 237, 8, 33, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2885, 237, 29, 105, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2886, 237, 30, 106, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2887, 282, 8, 33, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2888, 282, 29, 105, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2889, 311, 8, 33, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2890, 311, 29, 105, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2891, 314, 8, 33, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2892, 314, 29, 105, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2893, 163, 8, 33, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2894, 163, 29, 114, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2895, 167, 29, 114, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2896, 163, 32, 115, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2897, 167, 32, 115, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2898, 166, 32, 115, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2899, 166, 29, 114, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2900, 164, 32, 115, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2901, 164, 29, 114, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2902, 162, 32, 115, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2903, 162, 29, 114, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2904, 165, 32, 115, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2905, 165, 29, 114, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2906, 163, 30, 118, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2907, 167, 30, 118, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2908, 166, 30, 118, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2909, 164, 30, 118, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2910, 162, 30, 118, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2911, 165, 30, 118, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2912, 169, 32, 115, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2913, 169, 29, 114, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2914, 169, 30, 118, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2915, 172, 32, 115, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2916, 172, 29, 114, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2917, 172, 30, 118, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2918, 171, 32, 115, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2919, 171, 29, 114, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2920, 171, 30, 118, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2921, 170, 32, 115, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2922, 170, 29, 114, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2923, 170, 30, 118, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2924, 168, 32, 115, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2925, 168, 29, 114, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2926, 168, 30, 118, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2927, 173, 32, 115, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2928, 173, 29, 114, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2929, 173, 30, 118, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2930, 175, 32, 115, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2931, 175, 29, 114, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2932, 175, 30, 118, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2933, 352, 32, 115, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2934, 352, 8, 33, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2935, 352, 29, 114, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2936, 352, 30, 118, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2937, 174, 32, 115, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2938, 174, 29, 114, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2939, 174, 30, 118, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2940, 353, 32, 115, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2941, 353, 8, 33, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2942, 353, 29, 114, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2943, 353, 30, 118, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2944, 368, 32, 116, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2945, 368, 8, 33, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2946, 368, 29, 119, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2947, 360, 32, 116, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2948, 360, 8, 33, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2949, 360, 29, 119, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2950, 375, 32, 116, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2951, 375, 8, 33, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2952, 375, 29, 119, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2953, 356, 32, 116, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2954, 356, 8, 33, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2955, 356, 29, 119, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2956, 371, 32, 116, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2957, 371, 8, 33, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2958, 371, 29, 119, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2959, 364, 32, 116, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2960, 364, 8, 33, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2961, 364, 29, 119, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2962, 366, 32, 116, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2963, 366, 8, 33, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2964, 366, 29, 119, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2965, 359, 31, 110, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2966, 359, 32, 116, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2967, 359, 8, 33, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2968, 359, 29, 119, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2969, 364, 31, 110, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2970, 366, 31, 110, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2971, 373, 31, 111, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2972, 373, 32, 116, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2973, 373, 8, 33, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2974, 373, 29, 119, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2975, 357, 31, 110, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2976, 357, 32, 116, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2977, 357, 8, 33, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2978, 357, 29, 119, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2979, 362, 31, 110, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2980, 362, 32, 116, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2981, 362, 8, 33, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2982, 362, 29, 119, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2983, 355, 31, 110, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2984, 355, 32, 116, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2985, 355, 8, 33, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2986, 355, 29, 119, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2987, 370, 31, 110, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2988, 370, 32, 116, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2989, 370, 8, 33, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2990, 370, 29, 119, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2991, 367, 32, 116, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2992, 367, 8, 33, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2993, 367, 29, 119, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2994, 372, 32, 116, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2995, 372, 8, 33, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2996, 372, 29, 119, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2997, 365, 32, 116, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2998, 365, 8, 33, 0.0000, '');
INSERT INTO `products_attributes` VALUES (2999, 365, 29, 119, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3000, 369, 32, 116, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3001, 369, 8, 33, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3002, 369, 29, 119, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3003, 361, 32, 116, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3004, 361, 8, 33, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3005, 361, 29, 119, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3006, 374, 32, 116, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3007, 374, 8, 33, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3008, 374, 29, 119, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3009, 358, 32, 116, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3010, 358, 8, 33, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3011, 358, 29, 119, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3012, 363, 32, 116, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3013, 363, 8, 33, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3014, 363, 29, 119, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3015, 354, 32, 116, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3016, 354, 8, 33, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3017, 354, 29, 119, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3018, 322, 32, 117, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3019, 322, 8, 122, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3020, 322, 29, 121, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3021, 323, 32, 117, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3022, 323, 8, 122, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3023, 323, 29, 121, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3024, 344, 32, 117, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3025, 344, 8, 122, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3026, 344, 29, 121, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3027, 320, 32, 117, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3028, 320, 8, 122, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3029, 320, 29, 121, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3030, 321, 32, 117, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3031, 321, 8, 122, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3032, 321, 29, 121, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3033, 324, 32, 117, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3034, 324, 8, 122, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3035, 324, 29, 121, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3036, 325, 32, 117, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3037, 325, 8, 122, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3038, 325, 29, 121, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3039, 326, 32, 117, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3040, 326, 8, 33, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3041, 326, 29, 121, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3042, 336, 32, 117, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3043, 336, 8, 122, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3044, 336, 29, 121, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3045, 337, 32, 117, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3046, 337, 8, 122, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3047, 337, 29, 121, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3048, 340, 32, 117, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3049, 340, 8, 122, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3050, 340, 29, 121, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3051, 339, 32, 117, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3052, 339, 8, 122, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3053, 339, 29, 121, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3054, 341, 32, 117, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3055, 341, 8, 33, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3056, 341, 29, 121, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3057, 335, 32, 117, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3058, 335, 8, 33, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3059, 335, 29, 121, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3060, 338, 32, 117, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3061, 338, 8, 33, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3062, 338, 29, 121, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3063, 342, 32, 117, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3064, 342, 8, 33, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3065, 342, 29, 121, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3066, 331, 32, 117, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3067, 331, 8, 33, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3068, 331, 29, 121, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3069, 330, 32, 117, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3070, 330, 8, 122, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3071, 330, 29, 121, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3072, 333, 32, 117, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3073, 333, 8, 122, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3074, 333, 29, 121, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3075, 334, 32, 117, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3076, 334, 8, 122, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3077, 334, 29, 121, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3078, 346, 32, 117, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3079, 346, 8, 122, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3080, 346, 29, 121, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3081, 328, 32, 117, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3082, 328, 8, 122, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3083, 328, 29, 121, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3084, 347, 32, 117, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3085, 347, 8, 122, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3086, 347, 29, 121, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3087, 347, 30, 106, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3088, 327, 32, 117, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3089, 327, 8, 122, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3090, 327, 29, 121, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3091, 348, 32, 117, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3092, 348, 8, 33, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3093, 348, 29, 121, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3094, 332, 32, 117, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3095, 332, 8, 33, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3096, 332, 29, 121, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3097, 329, 32, 117, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3098, 329, 8, 33, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3099, 329, 29, 121, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3100, 345, 32, 117, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3101, 345, 8, 33, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3102, 345, 29, 121, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3103, 535, 28, 103, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3104, 535, 26, 102, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3105, 535, 27, 104, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3106, 536, 28, 103, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3107, 536, 26, 102, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3108, 536, 27, 104, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3109, 537, 28, 103, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3110, 537, 26, 102, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3111, 537, 27, 104, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3112, 538, 28, 103, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3113, 538, 26, 102, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3114, 538, 27, 104, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3115, 539, 28, 103, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3116, 539, 26, 102, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3117, 539, 27, 104, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3118, 540, 28, 103, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3119, 540, 26, 102, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3120, 540, 27, 104, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3121, 541, 28, 103, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3122, 541, 26, 102, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3123, 541, 27, 104, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3124, 542, 28, 103, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3125, 542, 26, 102, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3126, 542, 27, 104, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3127, 543, 28, 103, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3128, 543, 26, 102, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3129, 543, 27, 104, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3130, 544, 28, 103, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3131, 544, 26, 102, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3132, 544, 27, 104, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3133, 545, 28, 103, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3134, 545, 26, 102, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3135, 545, 27, 104, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3136, 546, 28, 103, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3137, 546, 26, 102, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3138, 546, 27, 104, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3139, 547, 28, 103, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3140, 547, 26, 102, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3141, 547, 27, 104, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3142, 548, 28, 103, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3143, 548, 26, 102, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3144, 548, 27, 104, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3145, 549, 21, 80, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3146, 549, 17, 87, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3147, 549, 18, 88, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3148, 549, 22, 95, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3149, 549, 20, 91, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3150, 549, 19, 123, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3151, 550, 16, 78, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3152, 550, 13, 72, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3153, 550, 14, 68, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3154, 550, 12, 73, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3155, 550, 15, 124, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3156, 499, 33, 125, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3157, 492, 33, 125, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3158, 495, 33, 125, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3159, 497, 33, 125, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3160, 501, 33, 125, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3161, 493, 33, 125, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3162, 496, 33, 125, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3163, 500, 33, 125, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3164, 502, 33, 125, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3165, 498, 33, 125, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3166, 550, 33, 125, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3167, 494, 33, 125, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3168, 529, 34, 126, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3169, 528, 34, 126, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3170, 527, 34, 126, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3171, 518, 34, 126, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3172, 526, 34, 126, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3173, 519, 34, 126, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3174, 530, 34, 126, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3175, 551, 25, 100, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3176, 551, 23, 98, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3177, 551, 34, 126, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3178, 551, 24, 99, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3179, 552, 25, 100, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3180, 552, 23, 98, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3181, 552, 34, 126, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3182, 552, 24, 99, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3183, 553, 25, 100, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3184, 553, 23, 98, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3185, 553, 34, 126, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3186, 553, 24, 99, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3187, 554, 25, 100, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3188, 554, 23, 98, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3189, 554, 34, 126, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3190, 554, 24, 99, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3191, 555, 25, 100, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3192, 555, 23, 98, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3193, 555, 34, 126, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3194, 555, 24, 99, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3195, 556, 25, 100, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3196, 556, 23, 98, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3197, 556, 34, 126, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3198, 556, 24, 99, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3199, 557, 25, 100, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3200, 557, 23, 98, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3201, 557, 34, 126, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3202, 557, 24, 99, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3203, 558, 25, 100, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3204, 558, 23, 98, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3205, 558, 34, 126, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3206, 558, 24, 99, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3207, 559, 25, 100, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3208, 559, 23, 98, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3209, 559, 34, 126, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3210, 559, 24, 99, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3211, 560, 25, 100, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3212, 560, 23, 98, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3213, 560, 34, 126, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3214, 560, 24, 99, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3215, 561, 25, 100, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3216, 561, 23, 98, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3217, 561, 34, 126, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3218, 561, 24, 99, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3219, 562, 25, 100, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3220, 562, 23, 98, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3221, 562, 34, 126, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3222, 562, 24, 99, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3223, 563, 25, 100, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3224, 563, 23, 98, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3225, 563, 34, 126, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3226, 563, 24, 99, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3227, 564, 25, 100, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3228, 564, 23, 98, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3229, 564, 34, 126, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3230, 564, 24, 99, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3231, 565, 25, 100, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3232, 565, 23, 98, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3233, 565, 34, 126, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3234, 565, 24, 99, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3235, 566, 25, 100, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3236, 566, 23, 98, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3237, 566, 34, 126, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3238, 566, 24, 99, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3239, 567, 25, 100, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3240, 567, 23, 98, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3241, 567, 34, 126, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3242, 567, 24, 99, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3243, 568, 25, 100, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3244, 568, 23, 98, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3245, 568, 34, 126, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3246, 568, 24, 99, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3247, 569, 25, 100, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3248, 569, 23, 98, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3249, 569, 34, 126, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3250, 569, 24, 99, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3251, 570, 25, 100, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3252, 570, 23, 98, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3253, 570, 34, 126, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3254, 570, 24, 99, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3255, 571, 25, 100, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3256, 571, 23, 98, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3257, 571, 34, 126, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3258, 571, 24, 99, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3259, 572, 31, 110, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3260, 572, 32, 116, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3261, 572, 8, 33, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3262, 572, 29, 105, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3263, 572, 30, 106, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3264, 572, 9, 35, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3265, 256, 32, 116, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3266, 532, 32, 116, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3267, 573, 16, 78, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3268, 573, 13, 72, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3269, 573, 14, 67, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3270, 573, 33, 125, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3271, 573, 12, 73, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3272, 574, 16, 78, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3273, 574, 13, 72, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3274, 574, 14, 67, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3275, 574, 33, 125, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3276, 574, 12, 73, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3277, 575, 16, 78, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3278, 575, 13, 72, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3279, 575, 14, 67, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3280, 575, 33, 125, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3281, 575, 12, 73, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3282, 270, 32, 116, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3283, 576, 16, 78, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3284, 576, 13, 72, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3285, 576, 14, 67, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3286, 576, 33, 125, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3287, 576, 12, 73, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3288, 577, 16, 78, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3289, 577, 13, 72, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3290, 577, 14, 67, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3291, 577, 33, 125, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3292, 577, 12, 73, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3293, 578, 16, 78, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3294, 578, 13, 72, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3295, 578, 14, 67, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3296, 578, 33, 125, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3297, 578, 12, 73, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3298, 579, 32, 116, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3299, 579, 8, 33, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3300, 579, 29, 105, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3301, 579, 9, 34, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3302, 580, 32, 116, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3303, 580, 8, 33, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3304, 580, 29, 114, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3305, 580, 30, 112, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3306, 581, 25, 100, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3307, 581, 23, 98, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3308, 581, 34, 126, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3309, 581, 24, 99, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3310, 582, 28, 103, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3311, 582, 26, 102, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3312, 582, 27, 104, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3313, 583, 28, 103, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3314, 583, 26, 102, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3315, 583, 27, 104, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3316, 584, 28, 103, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3317, 584, 26, 102, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3318, 584, 27, 104, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3319, 585, 28, 103, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3320, 585, 26, 102, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3321, 585, 27, 104, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3322, 586, 28, 103, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3323, 586, 26, 102, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3324, 586, 27, 104, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3325, 587, 28, 103, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3326, 587, 26, 102, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3327, 587, 27, 104, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3328, 588, 28, 103, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3329, 588, 26, 102, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3330, 588, 27, 104, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3331, 589, 28, 103, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3332, 589, 26, 102, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3333, 589, 27, 104, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3334, 590, 28, 103, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3335, 590, 26, 102, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3336, 590, 27, 104, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3337, 312, 32, 116, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3338, 312, 8, 33, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3339, 312, 29, 105, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3340, 266, 32, 116, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3341, 266, 8, 33, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3342, 266, 29, 105, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3343, 268, 32, 116, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3344, 297, 32, 116, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3345, 297, 8, 33, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3346, 297, 29, 105, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3347, 277, 32, 116, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3348, 313, 32, 116, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3349, 240, 32, 116, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3350, 250, 32, 116, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3351, 310, 32, 116, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3352, 285, 32, 116, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3353, 223, 32, 116, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3354, 269, 32, 116, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3355, 237, 32, 116, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3356, 282, 32, 116, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3357, 533, 32, 116, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3358, 311, 32, 116, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3359, 314, 32, 116, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3360, 255, 32, 116, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3361, 259, 32, 116, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3362, 263, 32, 116, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3363, 261, 32, 116, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3364, 267, 32, 116, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3365, 241, 32, 116, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3366, 248, 32, 116, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3367, 246, 32, 116, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3368, 228, 32, 116, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3369, 251, 32, 116, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3370, 315, 32, 116, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3371, 233, 32, 116, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3372, 226, 32, 116, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3373, 317, 32, 116, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3374, 253, 32, 116, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3375, 244, 32, 116, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3376, 305, 32, 116, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3377, 319, 32, 116, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3378, 283, 32, 115, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3379, 238, 32, 116, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3380, 274, 32, 116, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3381, 294, 32, 116, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3382, 272, 32, 116, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3383, 292, 32, 116, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3384, 298, 32, 116, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3385, 286, 32, 116, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3386, 276, 32, 116, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3387, 265, 32, 116, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3388, 278, 32, 116, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3389, 220, 32, 116, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3390, 224, 32, 116, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3391, 221, 32, 116, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3392, 300, 32, 116, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3393, 280, 32, 116, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3394, 303, 32, 116, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3395, 230, 32, 116, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3396, 296, 32, 116, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3397, 290, 32, 116, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3398, 288, 32, 116, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3399, 235, 32, 116, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3400, 343, 32, 117, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3401, 343, 8, 33, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3402, 343, 29, 121, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3403, 591, 28, 103, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3404, 591, 26, 102, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3410, 592, 8, 33, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3409, 592, 32, 116, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3407, 591, 29, 105, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3408, 591, 9, 34, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3411, 592, 29, 105, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3412, 592, 9, 34, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3413, 593, 32, 116, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3414, 593, 8, 33, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3415, 593, 29, 105, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3416, 593, 9, 34, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3417, 490, 32, 116, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3418, 490, 8, 33, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3419, 490, 29, 105, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3420, 490, 9, 36, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3430, 516, 9, 36, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3429, 516, 30, 106, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3428, 516, 29, 130, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3427, 516, 8, 128, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3426, 516, 32, 116, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3431, 516, 35, 131, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3432, 594, 11, 58, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3433, 594, 37, 133, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3434, 594, 39, 137, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3435, 594, 38, 139, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3436, 594, 36, 132, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3437, 595, 37, 133, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3438, 595, 39, 137, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3439, 595, 38, 139, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3440, 595, 36, 132, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3441, 595, 11, 58, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3442, 596, 37, 133, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3443, 596, 39, 137, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3444, 596, 38, 139, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3445, 596, 36, 132, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3446, 596, 11, 58, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3447, 597, 37, 134, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3448, 597, 39, 136, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3449, 597, 38, 139, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3450, 597, 36, 132, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3451, 597, 11, 58, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3452, 598, 37, 135, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3453, 598, 39, 138, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3454, 598, 38, 139, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3455, 598, 36, 132, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3456, 598, 11, 58, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3457, 599, 37, 133, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3458, 599, 39, 138, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3459, 599, 38, 139, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3460, 599, 36, 132, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3461, 599, 11, 58, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3462, 600, 35, 131, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3463, 600, 32, 116, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3464, 600, 8, 128, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3465, 600, 29, 105, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3466, 600, 30, 118, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3467, 600, 9, 36, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3468, 601, 35, 142, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3469, 601, 32, 116, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3470, 601, 8, 127, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3471, 601, 29, 105, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3472, 601, 9, 36, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3473, 601, 30, 143, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3474, 602, 35, 142, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3475, 602, 32, 116, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3476, 602, 8, 128, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3477, 602, 29, 105, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3478, 602, 30, 118, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3479, 602, 9, 36, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3480, 603, 35, 142, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3481, 603, 32, 116, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3482, 603, 8, 127, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3483, 603, 29, 105, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3484, 603, 30, 108, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3485, 603, 9, 36, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3486, 604, 35, 142, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3487, 604, 32, 116, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3488, 604, 8, 127, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3489, 604, 29, 105, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3490, 604, 30, 118, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3491, 604, 9, 36, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3492, 605, 35, 142, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3493, 605, 32, 116, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3494, 605, 8, 128, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3495, 605, 29, 105, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3496, 605, 9, 36, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3497, 605, 30, 144, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3498, 606, 31, 111, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3499, 606, 32, 116, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3500, 606, 8, 128, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3501, 606, 29, 105, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3502, 606, 30, 118, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3503, 606, 9, 35, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3504, 607, 31, 110, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3505, 607, 32, 116, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3506, 607, 8, 128, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3507, 607, 29, 105, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3508, 607, 30, 118, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3509, 607, 9, 35, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3510, 608, 31, 110, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3511, 608, 32, 116, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3512, 608, 8, 127, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3513, 608, 29, 105, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3514, 608, 30, 108, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3515, 608, 9, 35, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3516, 609, 31, 110, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3517, 609, 32, 116, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3518, 609, 8, 128, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3519, 609, 29, 105, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3520, 609, 9, 35, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3521, 609, 30, 145, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3522, 610, 31, 110, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3523, 610, 32, 116, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3524, 610, 8, 128, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3525, 610, 29, 105, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3526, 610, 30, 118, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3527, 610, 9, 35, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3528, 611, 31, 110, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3529, 611, 32, 116, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3530, 611, 8, 128, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3531, 611, 29, 105, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3532, 611, 30, 145, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3533, 611, 9, 35, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3534, 612, 31, 110, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3535, 612, 32, 116, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3536, 612, 8, 127, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3537, 612, 29, 105, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3538, 612, 9, 35, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3539, 612, 30, 146, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3540, 613, 35, 142, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3541, 613, 32, 116, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3542, 613, 8, 128, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3543, 613, 29, 105, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3544, 613, 30, 145, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3545, 613, 9, 36, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3546, 614, 35, 142, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3547, 614, 32, 116, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3548, 614, 8, 128, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3549, 614, 29, 105, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3550, 614, 30, 118, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3551, 614, 9, 36, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3552, 615, 32, 116, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3553, 615, 8, 128, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3554, 615, 29, 105, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3555, 615, 9, 36, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3556, 616, 35, 142, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3557, 616, 32, 116, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3558, 616, 8, 127, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3559, 616, 29, 105, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3560, 616, 9, 36, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3561, 616, 30, 147, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3562, 571, 32, 116, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3563, 571, 8, 33, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3564, 571, 29, 130, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3565, 554, 32, 116, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3566, 554, 8, 33, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3567, 554, 29, 130, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3568, 617, 32, 116, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3569, 617, 8, 33, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3570, 617, 29, 105, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3571, 617, 30, 106, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3572, 617, 9, 34, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3573, 618, 32, 116, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3574, 618, 8, 33, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3575, 618, 29, 105, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3576, 618, 9, 34, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3577, 619, 32, 116, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3578, 619, 8, 33, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3579, 619, 29, 105, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3580, 619, 30, 148, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3581, 619, 9, 34, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3582, 620, 32, 116, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3583, 620, 8, 33, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3584, 620, 29, 105, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3585, 620, 30, 106, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3586, 620, 9, 34, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3587, 621, 32, 116, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3588, 621, 8, 33, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3589, 621, 29, 105, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3590, 621, 9, 34, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3596, 622, 8, 33, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3595, 622, 32, 116, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3594, 622, 31, 111, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3597, 622, 29, 105, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3598, 622, 30, 148, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3599, 622, 9, 35, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3600, 623, 31, 111, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3601, 623, 32, 116, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3602, 623, 8, 33, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3603, 623, 29, 105, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3604, 623, 9, 35, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3605, 624, 31, 111, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3606, 624, 32, 116, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3607, 624, 8, 33, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3608, 624, 29, 105, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3609, 624, 30, 106, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3610, 624, 9, 35, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3611, 625, 31, 111, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3612, 625, 32, 116, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3613, 625, 8, 33, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3614, 625, 29, 105, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3615, 625, 9, 35, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3616, 626, 31, 110, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3617, 626, 32, 116, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3618, 626, 8, 33, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3619, 626, 29, 105, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3620, 626, 30, 106, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3621, 626, 9, 35, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3622, 627, 32, 116, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3623, 627, 8, 33, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3624, 627, 29, 105, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3625, 627, 9, 36, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3626, 316, 32, 116, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3627, 628, 32, 116, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3628, 628, 8, 33, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3629, 628, 29, 105, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3630, 628, 9, 38, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3631, 629, 31, 110, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3632, 629, 32, 116, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3633, 629, 8, 128, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3634, 629, 29, 130, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3635, 629, 9, 35, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3636, 630, 31, 110, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3637, 630, 32, 116, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3638, 630, 8, 128, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3639, 630, 29, 130, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3640, 630, 9, 35, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3641, 631, 31, 113, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3642, 631, 32, 116, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3643, 631, 8, 128, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3644, 631, 29, 130, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3645, 631, 9, 35, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3646, 632, 31, 113, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3647, 632, 32, 116, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3648, 632, 8, 128, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3649, 632, 29, 130, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3650, 632, 9, 35, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3651, 633, 31, 113, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3652, 633, 32, 116, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3653, 633, 8, 128, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3654, 633, 29, 130, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3655, 633, 9, 35, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3656, 634, 31, 113, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3657, 634, 32, 116, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3658, 634, 8, 128, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3659, 634, 29, 130, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3660, 634, 9, 35, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3661, 635, 31, 113, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3662, 635, 32, 116, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3663, 635, 8, 127, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3664, 635, 29, 130, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3665, 635, 9, 35, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3666, 636, 31, 113, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3667, 636, 32, 116, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3668, 636, 8, 127, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3669, 636, 29, 130, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3670, 636, 9, 35, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3671, 637, 31, 113, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3672, 637, 32, 116, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3673, 637, 8, 127, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3674, 637, 29, 130, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3675, 637, 9, 35, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3676, 638, 31, 110, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3677, 638, 32, 116, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3678, 638, 8, 128, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3679, 638, 29, 130, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3680, 638, 9, 35, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3681, 639, 31, 113, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3682, 639, 32, 116, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3683, 639, 8, 128, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3684, 639, 29, 130, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3685, 639, 9, 35, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3686, 640, 31, 113, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3687, 640, 32, 116, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3688, 640, 8, 127, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3689, 640, 29, 130, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3690, 640, 9, 35, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3691, 641, 31, 113, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3692, 641, 32, 116, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3693, 641, 8, 129, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3694, 641, 29, 130, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3695, 641, 9, 35, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3696, 642, 31, 113, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3697, 642, 32, 116, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3698, 642, 8, 127, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3699, 642, 29, 130, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3700, 642, 9, 35, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3701, 643, 31, 113, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3702, 643, 32, 116, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3703, 643, 8, 127, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3704, 643, 29, 130, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3705, 643, 9, 35, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3706, 644, 31, 113, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3707, 644, 32, 116, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3708, 644, 8, 128, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3709, 644, 29, 130, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3710, 644, 9, 35, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3711, 645, 31, 113, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3712, 645, 32, 116, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3713, 645, 8, 128, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3714, 645, 29, 130, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3715, 645, 9, 35, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3716, 646, 31, 113, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3717, 646, 32, 116, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3718, 646, 8, 128, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3719, 646, 29, 130, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3720, 646, 9, 35, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3721, 647, 32, 116, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3722, 647, 8, 33, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3723, 647, 29, 105, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3724, 647, 9, 36, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3725, 648, 31, 113, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3726, 648, 32, 116, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3727, 648, 8, 127, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3728, 648, 29, 130, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3729, 648, 9, 35, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3730, 649, 31, 113, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3731, 649, 32, 116, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3732, 649, 8, 127, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3733, 649, 29, 130, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3734, 649, 9, 35, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3735, 650, 31, 110, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3736, 650, 32, 116, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3737, 650, 8, 128, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3738, 650, 29, 130, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3739, 650, 9, 35, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3740, 651, 31, 110, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3741, 651, 32, 116, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3742, 651, 8, 128, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3743, 651, 29, 130, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3744, 651, 9, 35, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3745, 652, 31, 113, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3746, 652, 32, 116, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3747, 652, 8, 127, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3748, 652, 29, 130, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3749, 652, 9, 35, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3750, 653, 31, 110, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3751, 653, 32, 116, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3752, 653, 8, 128, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3753, 653, 29, 130, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3754, 653, 9, 35, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3755, 654, 31, 110, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3756, 654, 32, 116, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3757, 654, 8, 127, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3758, 654, 29, 130, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3759, 654, 9, 35, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3760, 655, 31, 113, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3761, 655, 32, 116, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3762, 655, 8, 127, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3763, 655, 29, 130, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3764, 655, 9, 35, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3765, 656, 31, 110, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3766, 656, 32, 116, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3767, 656, 8, 128, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3768, 656, 29, 130, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3769, 656, 9, 35, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3770, 657, 31, 113, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3771, 657, 32, 116, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3772, 657, 8, 127, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3773, 657, 29, 130, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3774, 657, 9, 35, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3775, 658, 31, 113, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3776, 658, 32, 116, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3777, 658, 8, 127, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3778, 658, 29, 130, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3779, 658, 9, 35, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3780, 659, 31, 113, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3781, 659, 32, 116, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3782, 659, 8, 128, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3783, 659, 29, 130, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3784, 659, 9, 35, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3785, 660, 31, 110, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3786, 660, 32, 116, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3787, 660, 8, 127, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3788, 660, 29, 130, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3789, 660, 9, 35, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3790, 661, 31, 110, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3791, 661, 32, 116, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3792, 661, 8, 127, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3793, 661, 29, 130, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3794, 661, 9, 35, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3795, 662, 31, 110, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3796, 662, 32, 116, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3797, 662, 8, 128, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3798, 662, 29, 130, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3799, 662, 9, 35, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3800, 663, 31, 110, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3801, 663, 32, 116, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3802, 663, 8, 127, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3803, 663, 29, 130, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3804, 663, 30, 106, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3805, 663, 9, 35, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3806, 664, 31, 110, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3807, 664, 32, 116, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3808, 664, 8, 128, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3809, 664, 29, 130, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3810, 664, 9, 35, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3811, 665, 31, 110, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3812, 665, 32, 116, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3813, 665, 8, 127, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3814, 665, 29, 130, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3815, 665, 9, 35, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3816, 666, 31, 110, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3817, 666, 32, 116, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3818, 666, 8, 127, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3819, 666, 29, 130, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3820, 666, 9, 35, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3821, 667, 31, 110, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3822, 667, 32, 116, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3823, 667, 8, 128, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3824, 667, 29, 130, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3825, 667, 9, 35, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3826, 667, 30, 149, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3827, 668, 31, 110, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3828, 668, 32, 116, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3829, 668, 8, 128, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3830, 668, 29, 130, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3831, 668, 9, 35, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3832, 669, 32, 116, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3833, 669, 8, 33, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3834, 669, 29, 105, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3835, 669, 9, 34, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3836, 669, 40, 150, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3837, 592, 40, 150, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3838, 593, 40, 151, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3839, 670, 40, 151, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3840, 670, 32, 116, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3841, 670, 8, 33, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3842, 670, 29, 105, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3843, 670, 9, 34, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3844, 671, 31, 111, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3845, 671, 32, 116, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3846, 671, 8, 33, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3847, 671, 29, 105, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3848, 671, 9, 35, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3849, 672, 40, 152, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3850, 672, 32, 116, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3851, 672, 8, 33, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3852, 672, 29, 105, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3853, 672, 9, 35, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3854, 673, 4, 7, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3855, 673, 2, 3, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3856, 673, 1, 2, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3857, 673, 5, 12, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3858, 673, 3, 6, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3859, 673, 6, 9, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3860, 674, 4, 7, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3861, 674, 2, 31, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3862, 674, 1, 2, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3863, 674, 5, 12, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3864, 674, 3, 6, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3865, 674, 6, 9, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3866, 675, 4, 76, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3867, 675, 2, 55, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3868, 675, 1, 2, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3869, 675, 5, 12, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3870, 675, 3, 6, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3871, 675, 6, 9, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3872, 676, 4, 7, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3873, 676, 2, 21, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3874, 676, 1, 2, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3875, 676, 5, 12, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3876, 676, 3, 6, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3877, 676, 6, 9, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3878, 677, 31, 113, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3879, 677, 32, 116, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3880, 677, 8, 128, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3881, 677, 29, 130, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3882, 677, 9, 35, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3887, 548, 29, 130, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3886, 543, 29, 130, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3885, 544, 29, 130, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3888, 542, 29, 130, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3889, 546, 29, 130, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3890, 547, 29, 130, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3891, 545, 29, 130, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3892, 678, 32, 116, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3893, 678, 8, 33, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3894, 678, 29, 130, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3895, 679, 4, 7, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3896, 679, 2, 21, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3897, 679, 1, 2, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3898, 679, 5, 25, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3899, 679, 3, 6, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3900, 679, 6, 9, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3910, 681, 8, 33, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3909, 681, 32, 116, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3908, 680, 29, 130, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3907, 680, 8, 33, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3906, 680, 32, 116, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3911, 681, 29, 105, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3912, 681, 30, 106, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3913, 681, 9, 38, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3914, 682, 4, 64, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3915, 682, 2, 21, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3916, 682, 1, 2, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3917, 682, 5, 27, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3918, 682, 3, 6, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3919, 682, 6, 9, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3920, 683, 32, 116, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3921, 683, 8, 127, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3922, 683, 29, 130, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3923, 683, 41, 153, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3924, 683, 9, 162, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3925, 683, 42, 158, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3926, 684, 32, 163, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3927, 684, 8, 127, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3928, 684, 29, 130, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3929, 684, 41, 153, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3930, 684, 9, 162, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3931, 684, 42, 159, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3932, 685, 32, 163, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3933, 685, 8, 127, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3934, 685, 29, 130, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3935, 685, 41, 153, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3936, 685, 9, 162, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3937, 685, 42, 160, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3938, 686, 32, 163, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3939, 686, 8, 127, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3940, 686, 29, 130, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3941, 686, 41, 153, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3942, 686, 9, 162, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3943, 686, 42, 161, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3944, 687, 32, 116, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3945, 687, 8, 127, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3946, 687, 29, 130, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3947, 687, 41, 153, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3948, 687, 9, 162, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3949, 687, 42, 158, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3950, 688, 32, 163, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3951, 688, 8, 127, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3952, 688, 29, 130, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3953, 688, 41, 157, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3954, 688, 9, 162, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3955, 688, 42, 159, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3956, 689, 32, 163, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3957, 689, 8, 127, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3958, 689, 29, 130, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3959, 689, 41, 157, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3960, 689, 9, 162, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3961, 689, 42, 160, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3962, 690, 32, 163, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3963, 690, 8, 127, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3964, 690, 29, 130, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3965, 690, 41, 157, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3966, 690, 9, 162, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3967, 690, 42, 161, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3968, 691, 32, 116, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3969, 691, 8, 127, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3970, 691, 29, 130, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3971, 691, 41, 156, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3972, 691, 9, 162, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3973, 691, 42, 158, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3974, 692, 32, 163, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3975, 692, 8, 127, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3976, 692, 29, 130, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3977, 692, 41, 156, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3978, 692, 9, 162, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3979, 692, 42, 159, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3980, 693, 32, 163, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3981, 693, 8, 127, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3982, 693, 29, 130, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3983, 693, 41, 156, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3984, 693, 9, 162, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3985, 693, 42, 160, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3986, 694, 32, 163, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3987, 694, 8, 127, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3988, 694, 29, 130, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3989, 694, 41, 156, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3990, 694, 9, 162, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3991, 694, 42, 161, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3992, 695, 32, 116, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3993, 695, 8, 128, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3994, 695, 29, 130, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3995, 695, 41, 156, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3996, 695, 9, 162, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3997, 695, 42, 158, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3998, 696, 32, 163, 0.0000, '');
INSERT INTO `products_attributes` VALUES (3999, 696, 8, 128, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4000, 696, 29, 130, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4001, 696, 41, 156, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4002, 696, 9, 162, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4003, 696, 42, 159, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4004, 697, 32, 163, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4005, 697, 8, 128, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4006, 697, 29, 130, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4007, 697, 41, 156, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4008, 697, 9, 162, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4009, 697, 42, 160, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4010, 698, 32, 163, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4011, 698, 8, 128, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4012, 698, 29, 130, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4013, 698, 41, 156, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4014, 698, 9, 162, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4015, 698, 42, 161, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4016, 699, 32, 163, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4017, 699, 8, 128, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4018, 699, 29, 130, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4019, 699, 41, 154, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4020, 699, 9, 162, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4021, 699, 42, 158, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4022, 700, 32, 163, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4023, 700, 8, 128, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4024, 700, 29, 130, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4025, 700, 41, 154, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4026, 700, 9, 162, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4027, 700, 42, 159, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4028, 701, 32, 163, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4029, 701, 8, 128, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4030, 701, 29, 130, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4031, 701, 41, 154, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4032, 701, 9, 162, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4033, 701, 42, 160, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4034, 702, 32, 163, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4035, 702, 8, 128, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4036, 702, 29, 130, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4037, 702, 41, 154, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4038, 702, 9, 162, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4039, 702, 42, 161, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4040, 703, 32, 163, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4041, 703, 8, 128, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4042, 703, 29, 130, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4043, 703, 41, 153, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4044, 703, 9, 162, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4045, 703, 42, 158, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4046, 704, 32, 163, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4047, 704, 8, 128, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4048, 704, 29, 130, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4049, 704, 41, 153, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4050, 704, 9, 162, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4051, 704, 42, 159, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4052, 705, 32, 163, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4053, 705, 8, 128, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4054, 705, 29, 130, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4055, 705, 41, 153, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4056, 705, 9, 162, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4057, 705, 42, 160, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4058, 706, 32, 163, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4059, 706, 8, 128, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4060, 706, 29, 130, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4061, 706, 41, 153, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4062, 706, 9, 162, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4063, 706, 42, 161, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4064, 707, 32, 116, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4065, 707, 8, 128, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4066, 707, 29, 130, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4067, 707, 41, 157, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4068, 707, 9, 162, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4069, 707, 42, 158, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4070, 708, 32, 163, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4071, 708, 8, 128, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4072, 708, 29, 130, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4073, 708, 41, 157, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4074, 708, 9, 162, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4075, 708, 42, 159, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4076, 709, 32, 163, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4077, 709, 8, 128, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4078, 709, 29, 130, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4079, 709, 41, 157, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4080, 709, 9, 162, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4081, 709, 42, 160, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4082, 713, 32, 163, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4083, 713, 8, 128, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4084, 713, 29, 130, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4085, 713, 41, 155, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4086, 713, 9, 162, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4087, 713, 42, 159, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4088, 712, 32, 163, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4089, 712, 8, 128, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4090, 712, 29, 130, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4091, 712, 41, 155, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4092, 712, 9, 162, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4093, 712, 42, 160, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4094, 714, 32, 163, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4095, 714, 8, 127, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4096, 714, 29, 130, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4097, 714, 41, 155, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4098, 714, 9, 162, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4099, 714, 42, 159, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4100, 715, 32, 163, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4101, 715, 8, 127, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4102, 715, 29, 130, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4103, 715, 41, 155, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4104, 715, 9, 162, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4105, 715, 42, 160, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4106, 716, 2, 63, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4107, 716, 1, 2, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4108, 716, 5, 12, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4109, 716, 3, 6, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4110, 716, 6, 9, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4112, 717, 31, 110, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4113, 717, 32, 116, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4114, 717, 8, 128, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4115, 717, 29, 130, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4116, 717, 9, 35, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4117, 717, 30, 165, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4118, 718, 31, 110, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4119, 718, 32, 116, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4120, 718, 8, 129, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4121, 718, 29, 130, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4122, 718, 30, 106, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4123, 718, 9, 35, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4124, 719, 31, 110, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4125, 719, 32, 116, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4126, 719, 8, 129, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4127, 719, 29, 130, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4128, 719, 30, 106, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4129, 719, 9, 35, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4130, 720, 31, 110, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4131, 720, 32, 116, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4132, 720, 8, 129, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4133, 720, 29, 130, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4134, 720, 9, 35, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4135, 721, 31, 110, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4136, 721, 32, 116, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4137, 721, 8, 129, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4138, 721, 29, 130, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4139, 721, 30, 118, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4140, 721, 9, 35, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4141, 722, 31, 110, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4142, 722, 32, 116, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4143, 722, 8, 128, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4144, 722, 29, 130, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4145, 722, 9, 35, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4146, 722, 30, 166, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4147, 723, 31, 110, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4148, 723, 32, 116, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4149, 723, 8, 128, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4150, 723, 29, 130, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4151, 723, 30, 106, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4152, 723, 9, 35, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4153, 724, 31, 110, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4154, 724, 32, 116, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4155, 724, 8, 128, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4156, 724, 29, 130, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4157, 724, 30, 118, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4158, 724, 9, 35, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4159, 725, 31, 110, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4160, 725, 32, 116, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4161, 725, 8, 128, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4162, 725, 29, 130, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4163, 725, 9, 35, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4164, 726, 31, 110, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4165, 726, 32, 116, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4166, 726, 8, 128, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4167, 726, 29, 130, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4168, 726, 30, 106, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4169, 726, 9, 35, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4204, 711, 42, 161, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4205, 731, 32, 116, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4206, 731, 8, 128, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4207, 731, 29, 130, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4208, 731, 9, 35, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4209, 732, 31, 113, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4210, 732, 32, 116, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4211, 732, 8, 128, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4212, 732, 29, 130, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4213, 732, 9, 35, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4214, 733, 31, 113, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4215, 733, 32, 116, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4216, 733, 8, 128, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4217, 733, 29, 130, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4218, 733, 9, 35, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4219, 734, 31, 113, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4220, 734, 32, 116, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4221, 734, 8, 128, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4222, 734, 29, 130, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4223, 734, 9, 35, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4224, 735, 4, 7, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4225, 735, 2, 32, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4226, 735, 1, 1, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4227, 735, 5, 26, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4228, 735, 7, 20, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4229, 735, 6, 9, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4230, 736, 4, 7, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4231, 736, 2, 167, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4232, 736, 1, 1, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4233, 736, 5, 27, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4234, 736, 7, 20, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4235, 736, 6, 9, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4236, 737, 4, 7, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4237, 737, 2, 14, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4238, 737, 1, 1, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4239, 737, 5, 27, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4240, 737, 6, 9, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4247, 739, 2, 4, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4248, 739, 1, 1, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4249, 739, 5, 27, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4250, 739, 7, 20, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4251, 739, 6, 9, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4252, 740, 4, 8, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4253, 740, 2, 32, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4254, 740, 1, 1, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4255, 740, 5, 12, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4256, 740, 7, 18, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4257, 740, 6, 9, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4258, 741, 4, 7, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4259, 741, 2, 4, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4260, 741, 1, 1, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4261, 741, 5, 12, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4262, 741, 3, 6, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4263, 741, 6, 9, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4264, 742, 4, 7, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4265, 742, 2, 14, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4266, 742, 1, 1, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4267, 742, 5, 27, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4268, 742, 7, 18, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4269, 742, 6, 10, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4270, 743, 4, 22, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4271, 743, 2, 3, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4272, 743, 1, 2, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4273, 743, 5, 26, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4274, 743, 3, 6, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4275, 743, 6, 9, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4276, 744, 4, 64, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4277, 744, 2, 3, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4278, 744, 1, 2, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4279, 744, 5, 26, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4280, 744, 3, 6, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4281, 744, 6, 9, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4282, 745, 2, 21, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4283, 745, 1, 2, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4284, 745, 5, 27, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4285, 745, 3, 6, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4286, 745, 6, 9, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4287, 746, 4, 23, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4288, 746, 2, 4, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4289, 746, 1, 2, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4290, 746, 5, 26, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4291, 746, 3, 6, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4292, 746, 6, 9, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4293, 747, 4, 23, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4294, 747, 2, 4, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4295, 747, 1, 2, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4296, 747, 5, 27, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4297, 747, 3, 6, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4298, 747, 6, 9, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4299, 748, 4, 7, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4300, 748, 2, 4, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4301, 748, 1, 2, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4302, 748, 5, 19, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4303, 748, 3, 6, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4304, 748, 6, 10, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4305, 749, 2, 4, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4306, 749, 1, 2, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4307, 749, 5, 27, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4308, 749, 7, 20, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4309, 749, 6, 9, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4310, 750, 4, 22, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4311, 750, 2, 4, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4312, 750, 1, 2, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4313, 750, 5, 27, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4314, 750, 3, 6, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4315, 750, 6, 9, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4316, 751, 4, 7, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4317, 751, 2, 4, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4318, 751, 1, 2, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4319, 751, 5, 26, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4320, 751, 3, 6, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4321, 751, 6, 9, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4322, 752, 4, 22, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4323, 752, 2, 21, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4324, 752, 1, 2, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4325, 752, 5, 26, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4326, 752, 3, 6, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4327, 752, 6, 9, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4328, 753, 4, 7, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4329, 753, 2, 32, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4330, 753, 1, 1, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4331, 753, 5, 26, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4332, 753, 3, 6, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4333, 753, 6, 9, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4334, 754, 4, 7, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4335, 754, 2, 3, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4336, 754, 1, 1, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4337, 754, 5, 12, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4338, 754, 3, 6, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4339, 754, 6, 10, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4340, 756, 4, 7, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4341, 756, 2, 4, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4342, 756, 1, 1, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4343, 756, 5, 19, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4344, 756, 3, 6, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4345, 756, 6, 10, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4346, 757, 4, 7, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4347, 757, 2, 32, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4348, 757, 1, 1, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4349, 757, 5, 12, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4350, 757, 6, 10, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4351, 757, 7, 168, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4352, 758, 4, 7, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4353, 758, 2, 16, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4354, 758, 1, 1, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4355, 758, 5, 12, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4356, 758, 3, 6, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4357, 758, 6, 10, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4358, 755, 4, 7, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4359, 755, 1, 1, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4360, 755, 5, 27, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4361, 755, 3, 6, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4362, 755, 6, 10, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4363, 755, 2, 169, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4364, 759, 4, 7, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4365, 759, 2, 21, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4366, 759, 1, 2, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4367, 759, 3, 6, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4368, 759, 6, 9, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4369, 760, 37, 133, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4370, 760, 39, 137, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4371, 760, 38, 139, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4372, 760, 36, 132, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4373, 760, 11, 58, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4374, 761, 37, 135, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4375, 761, 39, 138, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4376, 761, 38, 139, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4377, 761, 36, 132, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4378, 761, 11, 58, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4379, 762, 37, 134, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4380, 762, 39, 138, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4381, 762, 38, 139, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4382, 762, 36, 132, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4383, 762, 11, 58, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4467, 776, 29, 130, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4466, 776, 8, 128, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4465, 776, 32, 116, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4464, 775, 9, 172, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4463, 775, 30, 118, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4462, 775, 41, 154, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4461, 775, 29, 130, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4460, 775, 8, 127, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4459, 775, 32, 116, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4458, 774, 9, 172, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4457, 774, 30, 118, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4456, 774, 41, 154, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4455, 774, 29, 130, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4454, 774, 8, 128, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4453, 774, 32, 116, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4452, 773, 30, 146, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4451, 773, 9, 36, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4446, 772, 6, 9, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4445, 772, 3, 6, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4450, 773, 29, 114, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4449, 773, 8, 33, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4444, 772, 1, 2, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4443, 772, 2, 3, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4448, 773, 32, 115, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4447, 772, 5, 171, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4442, 772, 4, 7, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4441, 771, 6, 9, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4440, 771, 3, 6, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4439, 771, 5, 26, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4438, 771, 1, 2, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4437, 771, 2, 21, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4436, 771, 4, 7, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4435, 770, 6, 9, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4434, 770, 3, 6, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4433, 770, 5, 27, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4432, 770, 1, 2, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4431, 770, 2, 21, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4430, 770, 4, 7, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4468, 776, 41, 154, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4469, 776, 30, 118, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4470, 776, 9, 172, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4471, 777, 32, 116, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4472, 777, 8, 127, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4473, 777, 29, 130, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4474, 777, 41, 154, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4475, 777, 30, 118, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4476, 777, 9, 172, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4477, 778, 32, 116, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4478, 778, 8, 33, 0.0000, '');
INSERT INTO `products_attributes` VALUES (4479, 778, 9, 173, 0.0000, '');

-- --------------------------------------------------------

--
-- Table structure for table `products_attributes_download`
--

CREATE TABLE `products_attributes_download` (
  `products_attributes_id` int(11) NOT NULL,
  `products_attributes_filename` varchar(255) NOT NULL default '',
  `products_attributes_maxdays` int(2) default '0',
  `products_attributes_maxcount` int(2) default '0',
  PRIMARY KEY  (`products_attributes_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `products_attributes_download`
--


-- --------------------------------------------------------

--
-- Table structure for table `products_attributes_group`
--

CREATE TABLE `products_attributes_group` (
  `options_id` int(11) NOT NULL,
  `options_values_id` int(11) NOT NULL,
  `options_values_price` decimal(15,4) NOT NULL,
  `price_prefix` char(1) NOT NULL,
  PRIMARY KEY  (`options_id`,`options_values_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Product Attributes Group';

--
-- Dumping data for table `products_attributes_group`
--

INSERT INTO `products_attributes_group` VALUES (10, 42, 5.1064, '+');
INSERT INTO `products_attributes_group` VALUES (10, 43, 5.5319, '+');
INSERT INTO `products_attributes_group` VALUES (10, 44, 6.8085, '+');
INSERT INTO `products_attributes_group` VALUES (10, 45, 7.6596, '+');
INSERT INTO `products_attributes_group` VALUES (10, 46, 8.5106, '+');
INSERT INTO `products_attributes_group` VALUES (10, 47, 10.2128, '+');
INSERT INTO `products_attributes_group` VALUES (10, 48, 11.0638, '+');
INSERT INTO `products_attributes_group` VALUES (10, 49, 12.7660, '+');
INSERT INTO `products_attributes_group` VALUES (10, 50, 8.5106, '+');
INSERT INTO `products_attributes_group` VALUES (10, 51, 9.3617, '+');

-- --------------------------------------------------------

--
-- Table structure for table `products_description`
--

CREATE TABLE `products_description` (
  `products_id` int(11) NOT NULL auto_increment,
  `language_id` int(11) NOT NULL default '1',
  `products_name` varchar(64) NOT NULL default '',
  `products_description` text,
  `products_url` varchar(255) default NULL,
  `products_viewed` int(5) default '0',
  PRIMARY KEY  (`products_id`,`language_id`),
  KEY `products_name` (`products_name`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=779 ;

--
-- Dumping data for table `products_description`
--

INSERT INTO `products_description` VALUES (1, 1, 'BM8240-11A', '', '', 144);
INSERT INTO `products_description` VALUES (3, 1, 'BM8242-08P', '', 'www.citizenwatch.com/CUK/English/detail.asp?Country=CUK&Language=English&ModelNumber=BM8242-08P', 37);
INSERT INTO `products_description` VALUES (5, 1, 'Gents Citizen Stiletto Two Tone bracelet watch', '', 'www.citizenwatch.com/CUK/English/detail.asp?Country=CUK&Language=English&ModelNumber=AR0014-52A', 63);
INSERT INTO `products_description` VALUES (6, 1, 'Gents Citizen Stiletto Gold Tone Leather Strap Watch', '', 'www.citizenwatch.com/CUK/English/detail.asp?Country=CUK&Language=English&ModelNumber=AR1002-05A', 14);
INSERT INTO `products_description` VALUES (7, 1, 'Gents Citizen Stiletto Gold Tone Bracelet Watch', '', 'www.citizenwatch.com/CUK/English/detail.asp?Country=CUK&Language=English&ModelNumber=AR1002-56B', 12);
INSERT INTO `products_description` VALUES (8, 1, 'Gents Citizen Stiletto Two Tone Bracelet Watch', '', 'www.citizenwatch.com/CUK/English/detail.asp?Country=CUK&Language=English&ModelNumber=AR1004-51E', 16);
INSERT INTO `products_description` VALUES (9, 1, 'Gents Citizen Stiletto Gold Tone Leather Strap Watch', '', 'www.citizenwatch.com/CUK/English/detail.asp?Country=CUK&Language=English&ModelNumber=AR1062-03P', 17);
INSERT INTO `products_description` VALUES (10, 1, 'Gents Citizen Stiletto Two Tone Bracelet Watch', '', 'www.citizenwatch.com/CUK/English/detail.asp?Country=CUK&Language=English&ModelNumber=AR3004-50A', 25);
INSERT INTO `products_description` VALUES (11, 1, 'Gents Citizen Stiletto Stainless Steel Bracelet Watch', '', 'www.citizenwatch.com/CUK/English/detail.asp?Country=CUK&Language=English&ModelNumber=AR3010-57E', 16);
INSERT INTO `products_description` VALUES (12, 1, 'Gents Citizen Stainless Steel Chronograph Watch', '', 'www.citizenwatch.com/CUK/English/detail.asp?Country=CUK&Language=English&ModelNumber=AT0810-55X', 29);
INSERT INTO `products_description` VALUES (13, 1, 'Gents Citizen Two Tone Chronograph Watch', '', 'www.citizenwatch.com/CUK/English/detail.asp?Country=CUK&Language=English&ModelNumber=AT0884-59E', 43);
INSERT INTO `products_description` VALUES (14, 1, 'Gents Citizen Largo Stainless Steel Bracelet Watch', '', 'www.citizenwatch.com/CUK/English/detail.asp?Country=CUK&Language=English&ModelNumber=AT0910-51E', 18);
INSERT INTO `products_description` VALUES (15, 1, 'Gents Citizen Gold Tone Bracelet Watch', '', 'www.citizenwatch.com/CUK/English/detail.asp?Country=CUK&Language=English&ModelNumber=AU1012-54A', 17);
INSERT INTO `products_description` VALUES (16, 1, 'Gents Citizen Gold Tone Bracelet Watch', '', 'www.citizenwatch.com/CUK/English/detail.asp?Country=CUK&Language=English&ModelNumber=AU1022-51A', 13);
INSERT INTO `products_description` VALUES (17, 1, 'Gents Citizen Two Tone Bracelet Watch', '', 'www.citizenwatch.com/CUK/English/detail.asp?Country=CUK&Language=English&ModelNumber=AU1024-55A', 9);
INSERT INTO `products_description` VALUES (18, 1, 'Gents Citizen Titanium Chronograph Watch', '', 'www.citizenwatch.com/CUK/English/detail.asp?Country=CUK&Language=English&ModelNumber=BL5250-02L', 50);
INSERT INTO `products_description` VALUES (19, 1, 'Gents Citizen Two Tone Chronograph Watch', '', 'www.citizenwatch.com/CUK/English/detail.asp?Country=CUK&Language=English&ModelNumber=BL5376-55A', 21);
INSERT INTO `products_description` VALUES (20, 1, 'Gents Citizen Stainless Steel Chronograph Watch', '', 'www.citizenwatch.com/CUK/English/detail.asp?Country=CUK&Language=English&ModelNumber=BL5380-58E', 29);
INSERT INTO `products_description` VALUES (21, 1, 'Gents Citizen Black Leather Strap Watch', '', '', 33);
INSERT INTO `products_description` VALUES (22, 1, 'Gents Citizen Stainless Steel Perpetual Calendar', '', 'www.citizenwatch.com/CUK/English/detail.asp?Country=CUK&Language=English&ModelNumber=BL8000-54L', 24);
INSERT INTO `products_description` VALUES (23, 1, 'Gents Citizen Titanium Watch', '', 'www.citizenwatch.com/CUK/English/detail.asp?Country=CUK&Language=English&ModelNumber=BM0900-51L', 16);
INSERT INTO `products_description` VALUES (24, 1, 'Gents Citizen Stainless Steel Bracelet Watch', '', 'www.citizenwatch.com/CUK/English/detail.asp?Country=CUK&Language=English&ModelNumber=BM5000-54A', 19);
INSERT INTO `products_description` VALUES (459, 1, 'Gents Accurist Gold Plated Quartz Watch', '', '', 12);
INSERT INTO `products_description` VALUES (460, 1, 'Gents Accurist Stainless Steel Quartz Watch', '', '', 8);
INSERT INTO `products_description` VALUES (26, 1, 'Gents Citizen Stainless Steel Watch', '', 'www.citizenwatch.com/CUK/English/detail.asp?Country=CUK&Language=English&ModelNumber=BM6010-55A', 11);
INSERT INTO `products_description` VALUES (27, 1, 'Gents Citizen Stainless Steel Watch', '', 'www.citizenwatch.com/CUK/English/detail.asp?Country=CUK&Language=English&ModelNumber=BM6010-55E', 21);
INSERT INTO `products_description` VALUES (28, 1, 'Gents Citizen Two Tone Bracelet Watch', '', 'www.citizenwatch.com/CUK/English/detail.asp?Country=CUK&Language=English&ModelNumber=BM6014-54A', 15);
INSERT INTO `products_description` VALUES (29, 1, 'Gents Citizen Stainless Steel Watch', '', 'www.citizenwatch.com/CUK/English/detail.asp?Country=CUK&Language=English&ModelNumber=BM6550-58E', 17);
INSERT INTO `products_description` VALUES (30, 1, 'Gents Citizen Gold Tone Bracelet Watch', '', 'www.citizenwatch.com/CUK/English/detail.asp?Country=CUK&Language=English&ModelNumber=BM6552-52E', 49);
INSERT INTO `products_description` VALUES (31, 1, 'Gents Citizen Titanium Watch', '', '', 21);
INSERT INTO `products_description` VALUES (32, 1, 'Gents Citizen Black Leather Strap Watch', '', 'www.citizenwatch.com/CUK/English/detail.asp?Country=CUK&Language=English&ModelNumber=BM6575-06E', 20);
INSERT INTO `products_description` VALUES (33, 1, 'Gents Citizen Stainless Steel Watch', '', 'www.citizenwatch.com/CUK/English/detail.asp?Country=CUK&Language=English&ModelNumber=BM8220-51L', 10);
INSERT INTO `products_description` VALUES (34, 1, 'Gents Citizen Two Tone Bracelet Watch', '', 'www.citizenwatch.com/CUK/English/detail.asp?Country=CUK&Language=English&ModelNumber=BM8224-51E', 4);
INSERT INTO `products_description` VALUES (35, 1, 'Gents Citizen Leather Strap Watch', '', 'www.citizenwatch.com/CUK/English/detail.asp?Country=CUK&Language=English&ModelNumber=BM8240-11A', 22);
INSERT INTO `products_description` VALUES (36, 1, 'Gents Citizen Leather Strap Watch', '', 'www.citizenwatch.com/CUK/English/detail.asp?Country=CUK&Language=English&ModelNumber=BM8242-08A', 28);
INSERT INTO `products_description` VALUES (37, 1, 'Gents Citizen Leather Strap Watch', '', 'www.citizenwatch.com/CUK/English/detail.asp?Country=CUK&Language=English&ModelNumber=BM8242-08P', 39);
INSERT INTO `products_description` VALUES (38, 1, 'Gents Citizen Leather Strap Watch', '', 'www.citizenwatch.com/CUK/English/detail.asp?Country=CUK&Language=English&ModelNumber=BM8242-16A', 20);
INSERT INTO `products_description` VALUES (39, 1, 'Gents Citizen Expanding Bracelet Watch', '', 'www.citizenwatch.com/CUK/English/detail.asp?Country=CUK&Language=English&ModelNumber=BM8450-94B', 18);
INSERT INTO `products_description` VALUES (40, 1, 'Gents Citizen Gold Tone Expanding Bracelet Watch', '', 'www.citizenwatch.com/CUK/English/detail.asp?Country=CUK&Language=English&ModelNumber=BM8452-99A', 12);
INSERT INTO `products_description` VALUES (41, 1, 'Gents Citizen Two Tone Expanding Bracelet Watch', '', 'www.citizenwatch.com/CUK/English/detail.asp?Country=CUK&Language=English&ModelNumber=BM8454-93A', 13);
INSERT INTO `products_description` VALUES (42, 1, 'Gents Citizen Leather Strap Watch', '', 'www.citizenwatch.com/CUK/English/detail.asp?Country=CUK&Language=English&ModelNumber=BV1030-08A', 13);
INSERT INTO `products_description` VALUES (43, 1, 'Gents Citizen Leather Strap Watch', '', 'www.citizenwatch.com/CUK/English/detail.asp?Country=CUK&Language=English&ModelNumber=BW0172-02P', 14);
INSERT INTO `products_description` VALUES (44, 1, 'Gents Citizen Stainless Steel Radio Controlled Watch', '', 'www.citizenwatch.com/CUK/English/detail.asp?Country=CUK&Language=English&ModelNumber=BY0000-56E', 58);
INSERT INTO `products_description` VALUES (45, 1, 'Ladies Citizen Silhouette Gold Tone Watch', '', 'www.citizenwatch.com/CUK/English/detail.asp?Country=CUK&Language=English&ModelNumber=EG2152-51D', 22);
INSERT INTO `products_description` VALUES (46, 1, 'Ladies Citizen Silhouette Two Tone Bracelet Watch', '', 'www.citizenwatch.com/CUK/English/detail.asp?Country=CUK&Language=English&ModelNumber=EG2664-50D', 21);
INSERT INTO `products_description` VALUES (47, 1, 'Ladies Citizen Silhouette 34 Diamond Watch', '', 'www.citizenwatch.com/CUK/English/detail.asp?Country=CUK&Language=English&ModelNumber=EG2680-53D', 77);
INSERT INTO `products_description` VALUES (48, 1, 'Ladies Citizen Silhouette 34 Diamond Watch', '', 'www.citizenwatch.com/CUK/English/detail.asp?Country=CUK&Language=English&ModelNumber=EG2682-58D', 26);
INSERT INTO `products_description` VALUES (49, 1, 'Ladies Citizen Silhouette Stainless Steel Bracelet Watch', '', 'www.citizenwatch.com/CUK/English/detail.asp?Country=CUK&Language=English&ModelNumber=EG2690-50E', 13);
INSERT INTO `products_description` VALUES (50, 1, 'Ladies Citizen Silhouette Gold Tone Bracelet Watch', '', 'www.citizenwatch.com/CUK/English/detail.asp?Country=CUK&Language=English&ModelNumber=EG2692-54D', 9);
INSERT INTO `products_description` VALUES (51, 1, 'Ladies Citizen Silhouette Two Tone Bracelet Watch', '', 'www.citizenwatch.com/CUK/English/detail.asp?Country=CUK&Language=English&ModelNumber=EG2694-59D', 10);
INSERT INTO `products_description` VALUES (52, 1, 'Ladies Citizen Two Tone Bracelet Watch', '', 'www.citizenwatch.com/CUK/English/detail.asp?Country=CUK&Language=English&ModelNumber=EG2704-57E', 14);
INSERT INTO `products_description` VALUES (53, 1, 'Ladies Citizen Stiletto 36 Diamond Watch', '', 'www.citizenwatch.com/CUK/English/detail.asp?Country=CUK&Language=English&ModelNumber=EG3022-51D', 11);
INSERT INTO `products_description` VALUES (54, 1, 'Ladies Citizen Stiletto Gold Tone Bracelet Watch', '', 'www.citizenwatch.com/CUK/English/detail.asp?Country=CUK&Language=English&ModelNumber=EG3042-54A', 16);
INSERT INTO `products_description` VALUES (55, 1, 'Ladies Citizen Stiletto Stainless Steel 42 Diamond Watch', '', 'www.citizenwatch.com/CUK/English/detail.asp?Country=CUK&Language=English&ModelNumber=EG3060-52D', 17);
INSERT INTO `products_description` VALUES (56, 1, 'Ladies Citizen Riva 24 Diamond Bracelet Watch', '', 'www.citizenwatch.com/CUK/English/detail.asp?Country=CUK&Language=English&ModelNumber=EW0894-57D', 17);
INSERT INTO `products_description` VALUES (57, 1, 'Ladies Citizen Two Tone Bracelet Watch', '', 'www.citizenwatch.com/CUK/English/detail.asp?Country=CUK&Language=English&ModelNumber=EW1254-53A', 10);
INSERT INTO `products_description` VALUES (58, 1, 'Ladies Citizen Two Tone Bracelet Watch', '', 'www.citizenwatch.com/CUK/English/detail.asp?Country=CUK&Language=English&ModelNumber=EW1264-50A', 15);
INSERT INTO `products_description` VALUES (59, 1, 'Ladies Citizen Leather Strap Watch', '', 'www.citizenwatch.com/CUK/English/detail.asp?Country=CUK&Language=English&ModelNumber=EW1270-06A', 16);
INSERT INTO `products_description` VALUES (60, 1, 'Ladies Citizen Leather Strap Watch', '', 'www.citizenwatch.com/CUK/English/detail.asp?Country=CUK&Language=English&ModelNumber=EW1272-01B', 19);
INSERT INTO `products_description` VALUES (61, 1, 'Ladies Citizen Titanium Bracelet Watch', '', 'www.citizenwatch.com/CUK/English/detail.asp?Country=CUK&Language=English&ModelNumber=EW1400-53H', 10);
INSERT INTO `products_description` VALUES (62, 1, 'Ladies Citizen Stainless Steel Bracelet Watch', '', 'www.citizenwatch.com/CUK/English/detail.asp?Country=CUK&Language=English&ModelNumber=EW1520-51E', 12);
INSERT INTO `products_description` VALUES (63, 1, 'Ladies Citizen 100m Two Tone Bracelet Watch', '', 'www.citizenwatch.com/CUK/English/detail.asp?Country=CUK&Language=English&ModelNumber=EW3034-59A', 26);
INSERT INTO `products_description` VALUES (64, 1, 'Ladies Citizen Gold Tone Expanding Bracelet Watch', '', 'www.citizenwatch.com/CUK/English/detail.asp?Country=CUK&Language=English&ModelNumber=EW3152-95A', 11);
INSERT INTO `products_description` VALUES (65, 1, 'Ladies Citizen Silhouette Gold Tone Bracelet Watch', '', 'www.citizenwatch.com/CUK/English/detail.asp?Country=CUK&Language=English&ModelNumber=EW8692-58A', 11);
INSERT INTO `products_description` VALUES (66, 1, 'Ladies Citizen Silhouette Two Tone Bracelet Watch', '', 'www.citizenwatch.com/CUK/English/detail.asp?Country=CUK&Language=English&ModelNumber=EW8694-52D', 9);
INSERT INTO `products_description` VALUES (67, 1, 'Ladies Citizen Silhouette Stainless Steel Bracelet Watch', '', 'www.citizenwatch.com/CUK/English/detail.asp?Country=CUK&Language=English&ModelNumber=EW9330-53A', 11);
INSERT INTO `products_description` VALUES (68, 1, 'Ladies Citizen Silhouette Gold Tone Bracelet Watch', '', 'www.citizenwatch.com/CUK/English/detail.asp?Country=CUK&Language=English&ModelNumber=EW9682-56D', 11);
INSERT INTO `products_description` VALUES (69, 1, 'Ladies Citizen Silhouette Stainless Steel Bracelet Watch', '', 'www.citizenwatch.com/CUK/English/detail.asp?Country=CUK&Language=English&ModelNumber=EW9690-58E', 12);
INSERT INTO `products_description` VALUES (70, 1, 'Ladies Citizen Silhouette Stainless Steel Bracelet Watch', '', 'www.citizenwatch.com/CUK/English/detail.asp?Country=CUK&Language=English&ModelNumber=EW9700-56E', 17);
INSERT INTO `products_description` VALUES (71, 1, 'Ladies Citizen Silhouette 40 Diamond Watch', '', 'www.citizenwatch.com/CUK/English/detail.asp?Country=CUK&Language=English&ModelNumber=EW9720-59E', 28);
INSERT INTO `products_description` VALUES (72, 1, 'Ladies Citizen Silhouette 40 Diamond Watch', '', 'www.citizenwatch.com/CUK/English/detail.asp?Country=CUK&Language=English&ModelNumber=EW9734-54A', 24);
INSERT INTO `products_description` VALUES (73, 1, 'Ladies Citizen Normandie Stainless Steel and Black Bracelet Watc', '', 'www.citizenwatch.com/CUK/English/detail.asp?Country=CUK&Language=English&ModelNumber=EW9780-57E', 22);
INSERT INTO `products_description` VALUES (74, 1, 'Ladies Citizen Silhouette Stainless Steel Bracelet Watch', '', 'www.citizenwatch.com/CUK/English/detail.asp?Country=CUK&Language=English&ModelNumber=EW9810-58D', 20);
INSERT INTO `products_description` VALUES (75, 1, 'Ladies Citizen Silhouette Two Tone Bracelet Watch', '', 'www.citizenwatch.com/CUK/English/detail.asp?Country=CUK&Language=English&ModelNumber=EW9834-50A', 15);
INSERT INTO `products_description` VALUES (76, 1, 'Ladies Citizen Stainless Steel Riva Chronograph Bracelet Watch', '', 'www.citizenwatch.com/CUK/English/detail.asp?Country=CUK&Language=English&ModelNumber=FB1020-52D', 21);
INSERT INTO `products_description` VALUES (77, 1, 'Ladies Citizen Two Tone bracelet Watch', '', 'www.citizenwatch.com/CUK/English/detail.asp?Country=CUK&Language=English&ModelNumber=GA1024-51A', 24);
INSERT INTO `products_description` VALUES (78, 1, 'Gents Citizen Stainless Steel SkyHawk Watch', '', 'www.citizenwatch.com/CUK/English/detail.asp?Country=CUK&Language=English&ModelNumber=JY0000-53E', 32);
INSERT INTO `products_description` VALUES (79, 1, 'Gents Citizen Stainless Steel SkyHawk Watch', '', 'www.citizenwatch.com/CUK/English/detail.asp?Country=CUK&Language=English&ModelNumber=JY0005-50E', 14);
INSERT INTO `products_description` VALUES (81, 1, 'Youths Sekonda Stainless Steel Quartz Sports Watch', '', '', 8);
INSERT INTO `products_description` VALUES (80, 1, 'Youths Sekonda Black Strap Quartz Sport Watch', '', '', 5);
INSERT INTO `products_description` VALUES (82, 1, 'Gents Sekonda Gold Plated Quartz Watch', '', '', 7);
INSERT INTO `products_description` VALUES (83, 1, 'Gents Sekonda Chrome Plated Bracelet Quartz Watch', '', '', 5);
INSERT INTO `products_description` VALUES (84, 1, 'Gents Sekonda Gold Plated Quartz Watch', '', '', 5);
INSERT INTO `products_description` VALUES (85, 1, 'Gents Sekonda Gold Plated Quartz Watch', '', '', 7);
INSERT INTO `products_description` VALUES (86, 1, 'Gents Sekonda Stainless Steel Quartz Chronograph Watch', '', '', 3);
INSERT INTO `products_description` VALUES (87, 1, 'Gents Sekonda Stainless Steel Quartz Chronograph Watch', '', '', 2);
INSERT INTO `products_description` VALUES (88, 1, 'Gents Sekonda Stainless Steel Quartz Watch', '', '', 5);
INSERT INTO `products_description` VALUES (89, 1, 'Gents Sekonda Stainless Steel Quartz Watch', '', '', 1);
INSERT INTO `products_description` VALUES (90, 1, 'Gents Sekonda Resin Strap Quartz Chronograph Watch', '', '', 2);
INSERT INTO `products_description` VALUES (91, 1, 'Gents Sekonda Stainless Steel Quartz Watch', '', '', 1);
INSERT INTO `products_description` VALUES (92, 1, 'Gents Sekonda Stainless Steel Quartz Watch', '', '', 1);
INSERT INTO `products_description` VALUES (93, 1, 'Gents Sekonda Blue Leather Strap Chronograph Quartz Watch', '', '', 5);
INSERT INTO `products_description` VALUES (94, 1, 'Gents Sekonda Stainless Steel Quartz Pocket Watch', '', '', 3);
INSERT INTO `products_description` VALUES (95, 1, 'Gents Sekonda Quartz Bracelet Watch', '', '', 3);
INSERT INTO `products_description` VALUES (96, 1, 'Gents Sekonda Gold Plated Stone Set Quartz Watch', '', '', 4);
INSERT INTO `products_description` VALUES (97, 1, 'Gents Sekonda Gold Plated Quartz Watch', '', '', 5);
INSERT INTO `products_description` VALUES (98, 1, 'Gents Sekonda Chrome Coloured Quartz Pocket Watch', '', '', 6);
INSERT INTO `products_description` VALUES (738, 1, 'Gents Sekonda Gold Plated Quartz Pocket Watch', '', '', 5);
INSERT INTO `products_description` VALUES (100, 1, 'Gents Sekonda Gold Plated Quartz Watch', '', '', 8);
INSERT INTO `products_description` VALUES (101, 1, 'Gents Sekonda Leather Strap Quartz Watch', '', '', 8);
INSERT INTO `products_description` VALUES (102, 1, 'Gents Sekonda Gold Plated Leather Strap Watch', '', '', 10);
INSERT INTO `products_description` VALUES (103, 1, 'Gents Sekonda Gold Plated Quartz Bracelet Watch', '', '', 13);
INSERT INTO `products_description` VALUES (104, 1, 'Gents Sekonda Stainless Steel Bracelet Watch', '', '', 1);
INSERT INTO `products_description` VALUES (105, 1, 'Gents Sekonda Leather Strap Quartz Watch', '', '', 10);
INSERT INTO `products_description` VALUES (106, 1, 'Gents Sekonda Quartz Expanding Bracelet Watch', '', '', 5);
INSERT INTO `products_description` VALUES (107, 1, 'Gents Sekonda Leather Strap Quartz Watch', '', '', 7);
INSERT INTO `products_description` VALUES (108, 1, 'Gents Sekonda Leather Strap Chronograph Quartz Watch', '', '', 15);
INSERT INTO `products_description` VALUES (109, 1, 'Gents Sekonda Titanium Quartz Watch', '', '', 1);
INSERT INTO `products_description` VALUES (110, 1, 'Gents Sekonda Two Tone Bracelet Quartz Watch', '', '', 1);
INSERT INTO `products_description` VALUES (111, 1, 'Gents Sekonda Stainless Steel Quartz Chronograph Watch', '', '', 4);
INSERT INTO `products_description` VALUES (112, 1, 'Gents Sekonda Stainless Steel Bracelet Watch', '', '', 2);
INSERT INTO `products_description` VALUES (113, 1, 'Gents Sekonda Stainless Steel Bracelet Quartz Watch', '', '', 2);
INSERT INTO `products_description` VALUES (114, 1, 'Gents Sekonda Leather Strap Quartz Watch', '', '', 9);
INSERT INTO `products_description` VALUES (115, 1, 'Ladies Sekonda Stainless Steel Bracelet Watch', '', '', 7);
INSERT INTO `products_description` VALUES (116, 1, 'Ladies Sekonda Fashion Watch', '', '', 13);
INSERT INTO `products_description` VALUES (117, 1, 'Ladies Sekonda Quartz Bracelet Watch', '', '', 13);
INSERT INTO `products_description` VALUES (118, 1, 'Ladies Sekonda Gold Plated Quartz Bracelet Watch', '', '', 5);
INSERT INTO `products_description` VALUES (119, 1, 'Ladies Sekonda Leather Strap Quartz Watch', '', '', 6);
INSERT INTO `products_description` VALUES (120, 1, 'Ladies Sekonda Leather Strap Quartz Watch', '', '', 9);
INSERT INTO `products_description` VALUES (122, 1, 'Ladies Sekonda Gold Plated Quartz Watch', '', '', 6);
INSERT INTO `products_description` VALUES (123, 1, 'Ladies Sekonda Quartz bracelet Watch', '', '', 9);
INSERT INTO `products_description` VALUES (124, 1, 'Ladies Sekonda Two Tone Bracelet Quartz Watch', '', '', 4);
INSERT INTO `products_description` VALUES (125, 1, 'Ladies Sekonda Stone Set Quartz Watch', '', '', 4);
INSERT INTO `products_description` VALUES (126, 1, 'Ladies Sekonda Quartz Stainless Steel Fob Watch', '', '', 3);
INSERT INTO `products_description` VALUES (127, 1, 'Ladies Sekonda Quartz Two Tone Bracelet Watch', '', '', 1);
INSERT INTO `products_description` VALUES (128, 1, 'Ladies Sekonda Quartz Bracelet Watch', '', '', 2);
INSERT INTO `products_description` VALUES (129, 1, 'Ladies Sekonda Leather Strap Quartz Watch', '', '', 5);
INSERT INTO `products_description` VALUES (130, 1, 'Ladies Sekonda Quartz Bracelet Watch', '', '', 3);
INSERT INTO `products_description` VALUES (131, 1, 'Ladies Sekonda Quartz Bracelet Watch', '', '', 4);
INSERT INTO `products_description` VALUES (132, 1, 'Ladies Sekonda Gold Plated Bracelet Quartz Watch', '', '', 5);
INSERT INTO `products_description` VALUES (133, 1, 'Ladies Sekonda Gold Plated Bracelet Quartz Watch', '', '', 10);
INSERT INTO `products_description` VALUES (134, 1, 'Ladies Sekonda Quartz Bracelet Watch', '', '', 3);
INSERT INTO `products_description` VALUES (135, 1, 'Ladies Sekonda Leather Strap Quartz Watch', '', '', 5);
INSERT INTO `products_description` VALUES (136, 1, 'Ladies Sekonda Quartz Gold Plated Nurses Fob Watch', '', '', 8);
INSERT INTO `products_description` VALUES (137, 1, 'Ladies Sekonda Two Tone Quartz Bracelet Watch', '', '', 3);
INSERT INTO `products_description` VALUES (138, 1, 'Ladies Sekonda Quartz Stainless Steel fob Watch', '', '', 2);
INSERT INTO `products_description` VALUES (139, 1, 'Ladies Sekonda Quartz Stainless Steel Expanding Bracelet Watch', '', '', 1);
INSERT INTO `products_description` VALUES (140, 1, 'Ladies Sekonda Quartz Gold Plated Expanding Bracelet Watch', '', '', 4);
INSERT INTO `products_description` VALUES (141, 1, 'Ladies Sekonda Quartz Gold Plated Expanding Bracelet Watch', '', '', 2);
INSERT INTO `products_description` VALUES (142, 1, 'Ladies Sekonda Quartz Gold Plated Bracelet Watch', '', '', 1);
INSERT INTO `products_description` VALUES (143, 1, 'Ladies Sekonda Quartz Gold Plated Watch', '', '', 3);
INSERT INTO `products_description` VALUES (144, 1, 'Ladies Sekonda Quartz Stone Set Bracelet Watch', '', '', 3);
INSERT INTO `products_description` VALUES (145, 1, 'Ladies Sekonda Quartz Gold Plated Watch', '', '', 2);
INSERT INTO `products_description` VALUES (146, 1, 'Ladies Sekonda Quartz Bracelet Watch', '', '', 2);
INSERT INTO `products_description` VALUES (147, 1, 'Ladies Sekonda Quartz Gold Plated Bracelet Watch', '', '', 1);
INSERT INTO `products_description` VALUES (148, 1, 'Ladies Sekonda Quartz Nurses Fob Watch', '', '', 7);
INSERT INTO `products_description` VALUES (727, 1, '9ct Yellow Gold Bouton Ball 4mm Stud Earrings', 'Easy to wear for all occasions, discreet yet elegant, these yellow gold stud earrings are a must.  Weight 0.3 grams', '', 13);
INSERT INTO `products_description` VALUES (150, 1, 'Ladies Sekonda Quartz Leather Strap Watch', '', '', 2);
INSERT INTO `products_description` VALUES (151, 1, 'Ladies Sekonda Quartz Leather Strap Watch', '', '', 3);
INSERT INTO `products_description` VALUES (153, 1, 'Ladies Gold Plated Expanding Bracelet Quartz Watch', 'This Ladies Sekonda watch has a gold plated case and expanding bracelet, round white dial with numbers, quartz analogue movement, water resistant and comes with a 2 year sekonda guarantee and presentation box.', '', 9);
INSERT INTO `products_description` VALUES (154, 1, 'Ladies Seksy Hidden Hearts Quartz Watch', '', '', 17);
INSERT INTO `products_description` VALUES (155, 1, 'Ladies Seksy Stainless Steel Swarovski Crystal Quartz Watch', 'This Seksy watch has a fully adjustable bracelet made with Swarovski Crystals,Quartz analogue movement, white mother of pearl dial and comes with a 2 year guarantee and is supplied in a presentation box.', '', 31);
INSERT INTO `products_description` VALUES (156, 1, 'Ladies Seksy Wave Stainless Steel Quartz Watch', 'This Ladies Seksy fashion watch has a fully adjustable bracelet, chrome coloured case with Swarovski Crystals, black dial with sparkle effect, Quartz analogue movement and comes with a 2 year guarantee and presentation box.', '', 18);
INSERT INTO `products_description` VALUES (157, 1, 'Ladies Seksy Stainless Steel Swarovski Crystal Quartz Watch', 'This Ladies Seksy fashion watch has a chrome coloured case made with Swarovski Crystals, a fully adjustable bracelet, silver-white dial with sparkle effect, Quartz analogue movement and comes with a 2 year guarantee and presentation box', '', 29);
INSERT INTO `products_description` VALUES (158, 1, 'Ladies Seksy Stainless Steel Swarovski Crystal Quartz Watch', 'This Ladies Seksy fashion watch has a chrome coloured case made with Swarovski Crystals, a fully adjustable bracelet, black dial with sparkle effect, Quartz analogue movement and comes with a 2 year guarantee and presentation box.', '', 9);
INSERT INTO `products_description` VALUES (159, 1, 'Ladies Seksy Stainless Steel Swarovski Crystal Quartz Watch', 'This Ladies Seksy fashion watch has an oval chrome coloured case with Swarovski Crystals, pink mother of pearl dial, fully adjustable bracelet, Quartz analogue movement and comes with a 2 year guarantee and presentation box.', '', 13);
INSERT INTO `products_description` VALUES (160, 1, 'Ladies Seksy Wave Stainless Steel Quartz Watch', 'This Ladie Seksy fashion watch has a chrome coloured case with Swarovski Crystals, silver-white dial with sparkle effect, Quartz analogue movement and comes with a 2 year guarantee and presentation box.', '', 18);
INSERT INTO `products_description` VALUES (161, 1, 'Ladies Seksy Stainless Steel Swarovski Crystal Quartz Watch', 'This Ladies Seksy fashion watch has a chrome coloured case with Swarovski Crystals, fully adjustable bracelet, pink mother of pearl dial with stone set at 12, Quartz analogue movement and comes with a 2 year guarantee and presentation box.', '', 17);
INSERT INTO `products_description` VALUES (162, 1, 'Girls Bracelet with Heart & T-bar', 'Girls D for Diamond sterling silver wth diamond set plain heart and t bar feature. Length 14cm/5.5".', '', 18);
INSERT INTO `products_description` VALUES (163, 1, 'Childs D for Diamond Angel Expanding Bangle', 'Silver D for Diamond childs silver expanding bangle. This bangle has Angel engraved on the top with a small diamond, approx dimensions width - 4.5mm diameter - 45mm extending to 50mm, weight 4.7g', '', 31);
INSERT INTO `products_description` VALUES (164, 1, 'Girls Bracelet with 4 Charms', 'Girls D for Diamond sterling silver bracelet with 4 charms, adjustable length 14-16cm/5.5-6.25".', '', 20);
INSERT INTO `products_description` VALUES (165, 1, 'Girls Bracelet with Heart Charm', '', '', 19);
INSERT INTO `products_description` VALUES (535, 1, 'Sterling Silver Happy Birthday Charm Bead', 'This silver happy birthday harm is suitable for use with all major charm bracelets including Pandora, Chamilia and Trollbeads.', '', 12);
INSERT INTO `products_description` VALUES (166, 1, 'Childs D for Diamond Star expanding Bangle', 'Sterling Silver D for Diamond Star expanding bangle. This bangle has a star on the top and a small diamond in the middle, approx dimensions width - 4.5mm diameter - 45mm extending to 50mm, weight approx 4.7g.', '', 15);
INSERT INTO `products_description` VALUES (167, 1, 'Childs D for Diamond Heart expanding Bangle', 'Sterling Silver D for Diamond heart expanding bangle. This bangle has a heart with a small diamond on the top. Approx dimensions width - 4.5mm, diameter - 45mm extending to 50mm, weight approx 4.7g.', '', 79);
INSERT INTO `products_description` VALUES (168, 1, 'Girls D for Diamond Heart Locket (Pink)', 'Childrens D for Diamond sterling silver heart locket with small diamond and pink inlay, this locket measures  length 16.1mm including bale, width 11mm and sits on a 35cm/14" silver box chain.', '', 19);
INSERT INTO `products_description` VALUES (169, 1, 'Girls D for Diamond Butterfly Pendant', 'Girls D for Diamond sterling silver butterfly pendant with small diamond, it sits on a sterling silver 35cm/14" box chain.', '', 19);
INSERT INTO `products_description` VALUES (170, 1, 'Girls D for Diamond Heart Locket', 'Girls D for Diamond heart locket has a small diamond, this locket measures length 22.3mm including bale, width 16.7mm and sits on a sterling silver 35cm/14" box chain.', '', 19);
INSERT INTO `products_description` VALUES (171, 1, 'Girls D for Diamond Heart Locket', 'Childrens D for Diamond sterling silver heart locket with small diamond, this locket measures length 15.4mm including bale, width 10.9mm and sits on a sterling silver 35cm/14" box chain.', '', 17);
INSERT INTO `products_description` VALUES (172, 1, 'Girls D for Diamond Fairy Pendant', 'Girls D for Diamond sterling silver fairy pendant with diamond and sits on a sterling silver 35cm/14" box chain.', '', 25);
INSERT INTO `products_description` VALUES (173, 1, 'Girls D for Diamond Star Pendant', 'Girls D for Diamond star pendant with small diamond and sits on a 35cm/14" box chain. Dimensions length including bale 11.6mm, width 6.6mm. Shown with matching earings E573.', '', 23);
INSERT INTO `products_description` VALUES (174, 1, 'Girls D for Diamond Sterling Silver Heart Pendant', 'Girls D for Diamond sterling silver heart pendant with small diamond and sits on a 35cm/14" silver box chain. Dimensions length including bale 12.5mm, width 5.7mm. Shown with matching earrings E572.', '', 30);
INSERT INTO `products_description` VALUES (175, 1, 'Girls D for Diamond Sterling Silver Cross Pendant', 'D for Diamond sterling silver cross pendant has a diamond in the middle of the cross and is supplied with a 35cm/14" chain. Approx dimensions of cross - lenghth 10.8mm width 7mm depth 1.1mm. Total weight 2.2g.', '', 23);
INSERT INTO `products_description` VALUES (176, 1, 'Gents Accurist Stainless Steel Quartz Watch', 'This Gents Accurist watch has a stainless steel case and bracelet which is fully adjustable, round silver dial, quartz analogue movement, water resistant and comes with a 3 year manufacturers guarantee and presentation box.', '', 14);
INSERT INTO `products_description` VALUES (177, 1, 'Gents Accurist Stainless Steel Skymaster Chronograph Watch', 'This Gents Accurist watch has a stainless steel case and bracelet, which is adjustable, chronograph feature, quartz analogue movement, water resistant to 50m. Case diameter 47mm including crown, case depth 12mm. It comes with a 3 year manufacturers guarantee, instructions and a presentation box.', '', 17);
INSERT INTO `products_description` VALUES (178, 1, 'Gents Accurist Stainless Steel Skymaster Chronograph Watch', 'This Gents Accurist watcg has a stainless steel case and bracelet, which is adjustable, chronograph feature, quartz analogue movement, water resistant to 50m. Case diameter 47mm including crown, case depth 12mm. It comes with a 3 year manufacturers guarantee, instructions and a presentation box.', '', 19);
INSERT INTO `products_description` VALUES (179, 1, 'Gents Accurist Stainless Steel Chronograph Watch', 'This Gents Accurist watch has a stainless steel case and bracelet, which is adjustable, chronograph feature, quartz analogue movement, water resistant to 100m. It comes with a 3 year manufacturers guarantee, instructions and a presentation box.', '', 21);
INSERT INTO `products_description` VALUES (180, 1, 'Gents Accurist Stainless Steel Quartz Watch', 'This Gents Accurist watch has a stainless steel case and bracelet, which is adjustable, quartz analogue movement, water resistant and comes with a 3 year manufacturers guarantee and presentation box.', '', 12);
INSERT INTO `products_description` VALUES (181, 1, 'Gents Accurist Gold Plated Quartz Watch', 'This Gents Accurist watch has a gold plated case and bracelet, which is adjustable, it has a black dial with a day and date display, quartz analogue movement, water resistant to 50m and comes with a 3 year manufacturers guarantee and presentation box.', '', 24);
INSERT INTO `products_description` VALUES (182, 1, 'Gents Accurist Gold Plated Quartz Watch', 'This Gents Accurist watch has a gold plated case and bracelet, which is adjustable, it has a silver dial with a day and date display, quartz analogue movement, water resistant to 50m and comes with a 3 year manufacturers guarantee and presentation box.', '', 12);
INSERT INTO `products_description` VALUES (183, 1, 'Gents Accurist Two Tone Quartz Watch', 'This Gents Accurist watch has a two tone case and bracelet, which can be adjusted, round black dial with day and date display, quartz analogue movement, water resistant to 50m and comes with a 3 year manufacturers guarantee and a presentation box.', '', 52);
INSERT INTO `products_description` VALUES (184, 1, 'Gents Accurist Stainless Steel Chronograph Watch', 'This Gents Accurist watch has a stainless steel case and bracelet, which is adjustable, chronograph feature, quartz analogue movement, water resistant to 100m and comes with a 3 year manufacturers guarantee, instructions and presentation box.', '', 19);
INSERT INTO `products_description` VALUES (185, 1, 'Gents Accurist Stainless Steel Chronograph Watch', 'This Gents Accurist watch has a stainless steel case and bracelet, which is adjustable, chronograph feature, quartz analogue movement, water resistant to 100m and comes with a 3 year manufacturers guarantee, instructions and presentation box.', '', 14);
INSERT INTO `products_description` VALUES (186, 1, 'Gents Accurist Stainless Steel Chronograph Watch', 'This Gents Accurist watch has a stainless steel case and bracelet, which can be adjusted, chronograph feature, quartz analogue movement, water resistant to 100m and comes with a 3 year guarantee, instructions and a presentation box.', '', 9);
INSERT INTO `products_description` VALUES (187, 1, 'Gents Accurist Stainless Steel Chronograph Watch', 'This Gents Accurist watch has a stainless steel case and bracelet, which can be adjusted, chronograph feature, quartz analogue movement, water resistant to 100m and comes with a 3 year guarantee, instructions and a presentation box.', '', 11);
INSERT INTO `products_description` VALUES (188, 1, 'Gents Accurist Stainless Steel Quartz Watch', 'This Gents Accurist watch has a stainless steel case and bracelet, which can be adjusted, blue dial with date display, quartz analogue movement, water resistant to 100m and comes with a 3 year manufacturing guarantee and presentation box.', '', 6);
INSERT INTO `products_description` VALUES (189, 1, 'Gents Accurist Stainless Steel Quartz Watch', 'This Gents Accurist watch has a stainless steel case and bracelet, which can be adjusted, round silver dial with date display, quartz analogue movement, water resistant to 100m and comes with a 3 year manufacturers guarantee and presentation box.', '', 11);
INSERT INTO `products_description` VALUES (190, 1, 'Gents Accurist Gold Plated Quartz Watch', 'This Gents Accurist watch has a gold plated case and bracelet, which is adjustable, rectangular silver dial with date display, quartz analogue movement, water resistant to 30m and comes with a 3 year manufacturers guarantee and presentation box.', '', 13);
INSERT INTO `products_description` VALUES (191, 1, 'Gents Accurist Stainless Steel Quartz Watch', 'This Gents Accurist watch has a Stainless Steel case and bracelet, which is adjustable, rectangular silver dial with date display, quartz analogue movement, water resistant to 30m and comes with a 3 year manufacturers guarantee and a presentation box.', '', 9);
INSERT INTO `products_description` VALUES (192, 1, 'Gents Accurist Gold Plated Leather Strap Quartz Watch', 'This Gents Accurist watch has a gold plated case and leather strap, rectangular silver dial with date display, quartz analogue movement, water resistant and comes with a 3 year manufacturers guarantee and a presentation box.', '', 14);
INSERT INTO `products_description` VALUES (193, 1, 'Gents Accurist Stainless Steel Leather Strap Quartz Watch', 'This Gents Accurist watch has a stainless steel case and leather strap, round black dial with date display, quartz analogue movement, water resistant and comes with a 3 year manufacturers guarantee and presentation box.', '', 9);
INSERT INTO `products_description` VALUES (194, 1, 'Gents Accurist Stainless Steel Leather Strap Quartz Watch', 'This Gents Accurist watch has a stainless steel case with a leather strap, round silver dial with a date display, quartz analogue movement, water resistant and comes with a 3 year guarantee and a presentation box.', '', 11);
INSERT INTO `products_description` VALUES (195, 1, 'Gents Accurist Gold Plated Leather Strap Quartz Watch', 'This Gents Accurist watch has a gold plated case with a leather strap, round white dial and date display, quartz analogue movement, water resistant and comes with a 3 year manufacturers guarantee and presentation box.', '', 12);
INSERT INTO `products_description` VALUES (196, 1, 'Gents Accurist Stainless Steel Leather Strap Quartz Watch', 'This Gents Accurist watch has a stainless steel case with leather strap, rectangular silver dial with a date display, quartz analogue movement, water resistant and comes with a 3 year manufacturers guarantee and presentation box.', '', 25);
INSERT INTO `products_description` VALUES (197, 1, 'Ladies Accurist Gold Plated Quartz Watch', 'This Ladies Accurist watch has a gold tone stainless steel case and fully adjustable bracelet, white round stone set dial, quartz analogue movement, water resistant and comes with a 3 year manufacturers guarantee and presentation box.', '', 18);
INSERT INTO `products_description` VALUES (198, 1, 'Ladies Accurist Gold Plated Quartz Watch', 'This Ladies Accurist watch has a gold plated case and bracelet which is fully adjustable, oval champagne dial with diamond at 12, quartz analogue movement, water resistant and comes with a 3 year manufacturers guarantee and presentation box.', '', 19);
INSERT INTO `products_description` VALUES (199, 1, 'LB1127G', '', '', 1);
INSERT INTO `products_description` VALUES (200, 1, 'LB1129W', '', '', 1);
INSERT INTO `products_description` VALUES (201, 1, 'Ladies Accurist Stainless Steel Quartz Watch', 'This Ladies Accurist watch has a stainless steel case and adjustable bracelet, silver tonneau shaped dial, quartz analogue movement, water resistant and comes with a manufacturers 3 year warranty and presentation box.', '', 9);
INSERT INTO `products_description` VALUES (202, 1, 'Ladies Accurist Gold Plated Quartz Watch', 'This Ladies Accurist watch has a gold plated case and fully adjustable bracelet, tonneau shaped mother of pearl dial, quartz analogue movement, water resistant and comes with a manufacturers 3 year guarantee and presentation box.', '', 12);
INSERT INTO `products_description` VALUES (203, 1, 'Ladies Accurist Stainless Steel Quartz Watch', 'This Ladies Accurist watch has a stainless steel case and fully adjustable bracelet, tonneau shaped silver dial, quartz analogue movement, water resistant and comes with a 3 year manufacturers guarantee and presentation box.', '', 16);
INSERT INTO `products_description` VALUES (204, 1, 'Ladies Accurist Gold Plated Quartz Watch', 'This Ladies Accurist watch has a gold plated case and fully adjustable bracelet, tonneau shaped silver dial, quartz analogue movement, water resistant and comes with a 3 year manufacturers guarantee and presentation box.', '', 10);
INSERT INTO `products_description` VALUES (205, 1, 'Ladies Accurist Two Tone Quartz Watch', 'This Ladies Accurist ladies watch has a two tone case and fully adjustable bracelet, tonneau shaped silver dial, water resistant and comes with a 3 year guarantee and presentation box.', '', 12);
INSERT INTO `products_description` VALUES (206, 1, 'Ladies Accurist Stainless Steel Watch', 'This Ladies Accurist watch has a stainless steel case and bracelet which is adjustable, tonneau shaped pink dial, quartz analogue movement, water resistant and comes with a 3 year manufacturers guarantee and presentation box.', '', 13);
INSERT INTO `products_description` VALUES (207, 1, 'Ladies Accurist Gold Plated Quartz Watch', 'This Ladies Accurist watch has a gold plated case and crystal set bracelet which is fully adjustable, tonneau shaped white dial with crystals at 12 and 6, quartz analogue movement, water resistant and comes with a 3 year manufacturers guarantee and presentation box.', '', 8);
INSERT INTO `products_description` VALUES (208, 1, 'Ladies Accurist Stainless Steel Quartz Watch', 'This Ladies Accurist watch has a stainless steel case and crystal set bracelet which is fully adjustable, tonneau shaped white dial with crystals set at 12 and 6, quartz analogue movement, water resistant and comes with a 3 year manufacturers guarantee and presentation box.', '', 13);
INSERT INTO `products_description` VALUES (209, 1, 'Ladies Accurist Stainless Steel Quartz Watch', 'This Ladies Accurist watch has a stainless steel case and bracelet which is fully adjustable, tonneau shaped black dial, quartz analogue movement, water resistant and comes with a 3 year manufacturers guarantee and presentation box.', '', 10);
INSERT INTO `products_description` VALUES (210, 1, 'Ladies Accurist Gold Plated Quartz Watch', 'This Ladies Accurist watch has a gold plated case and bracelet which is fully adjustable, tonneau shaped brown dial, quartz analogue movement, water resistant and comes with a 3 year manufacturers guarantee and presentation box.', '', 11);
INSERT INTO `products_description` VALUES (211, 1, 'Ladies Accurist Gold Plated Quartz Watch', 'This Ladies Accurist watch has a gold plated case and bracelet which is fully adjustable, tonneau shaped silver dial, quartz analogue movement, water resistant and comes with a 3 year guarantee and a presentation box.', '', 10);
INSERT INTO `products_description` VALUES (212, 1, 'Ladies Accurist Stainless Steel Quartz Watch', 'This Ladies Accurist watch has a crystal set stainless steel case and bracelet which is fully adjustable, rectangular shaped mother of pearl dial, quartz analogue movement, water resistant and comes with a 3 year manufacturers guarantee and presentation box.', '', 11);
INSERT INTO `products_description` VALUES (213, 1, 'Ladies Accurist Gold Plated Quartz Watch', 'This Ladies Accurist watch has a gold plated case and bracelet which is fully adjustable, oval mother of pearl dial, quartz analogue movement, water resistant and comes with a 3 year manufacturers guarantee and presentation box.', '', 9);
INSERT INTO `products_description` VALUES (214, 1, 'Ladies Accurist Stainless Steel Quartz Watch', 'This Ladies Accurist watch has a stainless steel case and bracelet which is fully adjustable, oval black dial, quartz analogue movement, water resistant and comes with a 3 year manufacturers guarantee and presentation box.', '', 14);
INSERT INTO `products_description` VALUES (215, 1, 'Ladies Accurist Two Tone Quartz Watch', 'This Ladies Accurist watch has a two tone crystal set case and bracelet which is fully adjustable, round mother of pear dial, quartz analogue movement, water resistant and comes with a 3 year manufacturers guarantee and presentation box.l', '', 15);
INSERT INTO `products_description` VALUES (216, 1, 'Ladies Accurist Stainless Steel Quartz Watch', 'This Ladies Accurist watch has a stainless steel stone set case and fully adjustable bracelet, round mother of pearl dial, quartz analogue movement, water resistant and comes with a 3 year manufacturers guarantee and presentation box.', '', 16);
INSERT INTO `products_description` VALUES (217, 1, 'Ladies Stainless Steel Leather Strap Quartz Watch', 'This Ladies Accurist watch has a stainless steel crystal set case with white leather strap, round mother of pearl dial, quartz analogue movement, water resistant and comes with a 3 year guarantee and presentation box.', '', 13);
INSERT INTO `products_description` VALUES (218, 1, 'Ladies Accurist Quartz Leather Strap Watch', 'This Ladies Accurist watch has a gold plated case, brown leather strap, round white dial, quartz analogue movement, water resistant and comes with a 3 year manufacturers guarantee and a presentation box.', '', 13);
INSERT INTO `products_description` VALUES (219, 1, 'Ladies Accurist Stainless Steel Leather Strap Quartz Watch', 'This Ladies Accurist watch has a round stainless steel case, black leather strap, quartz analogue movement, water resistant and comes with a 3 year guarantee and presentation box.', '', 76);
INSERT INTO `products_description` VALUES (220, 1, 'Sterling Silver Freshwater Pearl Stud Earring', 'This sterling silver 8mm black freshwater pearl stud earring has a post and butterfly fitting and is for pierced ears.', '', 16);
INSERT INTO `products_description` VALUES (221, 1, 'Sterling Silver Grey Freshwater Pearl Stud Earring', 'This Elements sterling silver 8mm grey freshwater pearl stud earring has a post and butterfly fitting and is for pierced ears.', '', 12);
INSERT INTO `products_description` VALUES (222, 1, 'Elements Sterling Silver Grey Freshwater Pearl Pendant', 'Pendant measures, length including bale 19.1mm, width 11mm and weighs 2.3 grams. This pendant does not come with a chain, please select your chain from the drop down box. Elements presentation box included.', '', 12);
INSERT INTO `products_description` VALUES (223, 1, 'Sterling Silver Freshwater Pearl Bracelet', 'Elements freshwater pearl bracelet with sterling silver fittings, length 19-22cm/7.5-8.75".', '', 13);
INSERT INTO `products_description` VALUES (224, 1, 'Sterling Silver Freshwater Pearl Stud Earring', 'This Elements sterling silver 6mm freshwater pearl stud earring has a post and butterfly fitting and is for pierced ears. It comes with an elements presentation box.', '', 9);
INSERT INTO `products_description` VALUES (225, 1, 'Freshwater Pearl Necklet', 'Elements white freshwater pearl necklet with sterling silver lobster claw and adjustable chain. The length of this pearl necklet is 41-46cm/16-18", pearls are approx 7mm wide and comes in an elements presentation box.', '', 14);
INSERT INTO `products_description` VALUES (226, 1, 'Sterling Silver Cubic Zirconia Stud Earrings', 'This sterling silver heart shaped cubic zirconia stud earring has a post and butterfly fitting for pierced ears. Dimensions - length 11.1mm, width 12.7mm and weighs a total of 2 grams.', '', 10);
INSERT INTO `products_description` VALUES (536, 1, 'Sterling Silver Dangling Cut Out Star Bead', 'This silver dangling cut out star bead is suitable for use with all major charm bracelets including Pandora, Chamilia and Trollbeads.', '', 11);
INSERT INTO `products_description` VALUES (227, 1, 'Elements Sterling Silver Heart shape Pendant With Cubic Zirconia', 'Pendant measures, length including bale 24.4mm, width 19.9mm and weighs 2.8 grams. This pendant does not come with a chain, please select your chain from the drop down box. Elements presentation box included.', '', 18);
INSERT INTO `products_description` VALUES (228, 1, 'Sterling Silver Cubic Zirconia Drop Earring', 'This sterling silver heart shaped cubic zirconia drop earring has hook fittings and is for pierced ears. Dimensions - length including hook 28mm, width 14.3mm, total weight 2.6 grams.', '', 17);
INSERT INTO `products_description` VALUES (229, 1, 'Elements Sterling Silver Heart Shaped Pendant With CubicZirconia', 'Pendant measures, length including bale 26.8mm, width 20.1mm and weighs 2.4 grams. This pendant does not come with a chain, please select your chain from the drop down box. Elements presentation box included.', '', 11);
INSERT INTO `products_description` VALUES (230, 1, 'Sterling Silver Heart Shaped Cubic Zirconia Earrings', 'This sterling silver heart shape cubic zirconia stud earring has a post and butterfly fitting and is for pierced ears. Dimensions - length 14.2mm, width 15.6mm and weighs a total of 3 grams.', '', 8);
INSERT INTO `products_description` VALUES (231, 1, 'Elements Sterling Silver Heart Shaped Pendant With CubicZirconia', 'Pendant measures, length 23.7mm, width 27.8mm and weighs 3.7 grams. This pendant does not come with a chain, please select your chain from the drop down box. Elements presentation box included.', '', 8);
INSERT INTO `products_description` VALUES (232, 1, 'Sterling Silver Figure of 8 Cubic Zirconia Bracelet', 'Elements sterling silver figure of 8 bracelet with cubic zirconia encrusted on one side. Dimensions - length 19-22cm/7.5-8.75".', '', 17);
INSERT INTO `products_description` VALUES (233, 1, 'Sterling Silver Cubic Zirconia Figure of 8 Stud Earrings', 'this Elements sterling silver pave set cubic zirconia stud earring has a post and butterfly (the post is at the top of the earring) fitting and is for pierced ears. Dimensions - length 24.4mm, width 8.3mm and weighs at total of 2.8 grams.', '', 17);
INSERT INTO `products_description` VALUES (234, 1, 'Elements Sterling Silver Figure of 8 Pendant With Cubic Zirconia', 'Pendant measures, length 28.5mm, width 11.1mm and weighs 2.8 grams. This pendant does not come with a chain, please select your chain from the drop down box. Elements presentation box included.', '', 13);
INSERT INTO `products_description` VALUES (235, 1, 'Sterling Silver Spiral Cubic Zirconia Drop Earring', 'This sterling silver spiral pave set cubic zirconia drop earring has a hook fitting and is for pierced ears. Dimensions - length including hook 31.6mm, width 14.6mm and weighs a total of 4.6 grams.', '', 13);
INSERT INTO `products_description` VALUES (728, 1, '9ct Yellow Gold Bouton Ball 5mm Stud Earrings', 'Easy to wear for all occasions, discreet yet elegant, these yellow gold earrings are a must. Weight 0.32 grams', '', 13);
INSERT INTO `products_description` VALUES (237, 1, 'Sterling Silver Marquise Shaped Cubic Zirconia Bracelet', 'Elements sterling silver marquise shaped open link with cubic zirconia detail. Dimensions - length 18-21cm/7-8.25", width 6.6mm at widest, weight 5.1 grams.', '', 17);
INSERT INTO `products_description` VALUES (238, 1, 'Sterling Silver Drop Earrings', 'This sterling silver pave set cubic zirconia drop earring has a hook fitting and is for pierced ears. Dimensions - length including hook 39.5mm, width 11.5mm and weighs a total of 3.2 grams.', '', 9);
INSERT INTO `products_description` VALUES (239, 1, 'Elements Sterling Silver Pave Set Cubic Zirconia Pendant', 'Pendant measures, length including bale 36.5mm, width 16.6mm and weighs 2.8 grams. This pendant does not come with a chain, please select your chain from the drop down box. Elements presentation box included.', '', 10);
INSERT INTO `products_description` VALUES (240, 1, 'Sterling Silver Cubic Zirconia Bracelet', 'Elements sterling silver open teardrop links with 5 cubic zirconia stones. Dimensions - length 18-21cm/7-8.25", width 9.8mm at widest, weight 11.6 grams.', '', 12);
INSERT INTO `products_description` VALUES (241, 1, 'Sterling Silver Cubic Zirconia Drop Earring', 'This sterling silver cubic zirconia teardrop earring has a hook fitting and is for pierced ears.\r\nDimensions - length including hook 31.3mm, width 10.2mm and weighs a total of 2.8 grams.', '', 16);
INSERT INTO `products_description` VALUES (242, 1, 'Elements Sterling Silver Teardrop Pendant With Cubic Zirconia', 'Pendant measures, length 25.8mm, width 12.8mm and weighs 2.1 grams. This pendant does not come with a chain, please select your chain from the drop down box. Elements presentation box included.', '', 8);
INSERT INTO `products_description` VALUES (243, 1, 'B2954C', '', '', 1);
INSERT INTO `products_description` VALUES (244, 1, 'Sterling Silver Cubic Zirconia Stud Earrings', 'This Sterling Silver cubic zirconia stud earring has a post and butterfly fitting and is for pierced ears.', '', 3);
INSERT INTO `products_description` VALUES (245, 1, 'Elements Sterling Silver Cubic Zirconia Teardrop Pendant', 'Pendant measures, length 15.3mm, width 8.1mm and weighs 1.6 grams. This pendant does not come with a chain, please select your chain from the drop down box. Elements presentation box included.', '', 20);
INSERT INTO `products_description` VALUES (246, 1, 'Sterling Silver Cubic Zirconia Drop Earring', 'This Elements sterling silver cubic zirconia drop earrings has a post and butterfly fitting, is for pierced ears and has a top round 6mm cz with a pear shape 10.3mm x 6.9mm cz and a total drop of 21mm, total weight of 4 grams.', '', 16);
INSERT INTO `products_description` VALUES (247, 1, 'Elements Sterling Silver Cubic Zirconia Pendant', 'Elements sterling silver cubic zirconia pendant has a top round cubic zirconia stone measuring 6mm and below a 10.3mm x 7mm teardrop with a total length of 26mm, weight 2.1 grams. This pendant does not come with a chain please select your chain from the drop down box. Elements presentation box included.', '', 19);
INSERT INTO `products_description` VALUES (248, 1, 'Sterling Silver Cubic Zirconia Drop Earring', 'This Elements sterling silver cubic zirconia drop earrings has a hook fitting for pierced ears and measures, length including hook 40.1mm, width of largest cz 9.1mm and smallest cz 5.3mm, total weight 5.8 grams.', '', 12);
INSERT INTO `products_description` VALUES (249, 1, 'Elements Sterling Silver Three Cubic Zirconia Drop Pendant', 'Stones measure, top 8mm, middle 10mm, bottom 15mm with a total length including bale 47.1mm, weight 10.3 grams. This pendant does not come with a chain, please select chain from the drop down box. Elements presentation box included.', '', 13);
INSERT INTO `products_description` VALUES (250, 1, 'Sterling Silver Cubic Zirconia Bracelet', 'Elements sterling silver round and marquise cubic zirconia bracelet. Length 18-20cm/7-8" and weighs 11.2 grams.', '', 21);
INSERT INTO `products_description` VALUES (251, 1, 'Sterling Silver Cubic Zirconia Drop Earring', 'This sterling silver cubic zirconia drop earring has a post and butterfly fitting and is for pierced ears. Dimensions - length 17.2mm, width 5.7mm and weighs a total of 2.2 grams.', '', 23);
INSERT INTO `products_description` VALUES (252, 1, 'Elements Sterling Silver Round Cubic Zirconia Pendant', 'Pendant measures, length including bale 40.5mm, width 33.3mm and weighs 6.8 grams. This pendant does not come with a chain, please select your chain from the drop down box. Elements presentation box included.', '', 37);
INSERT INTO `products_description` VALUES (253, 1, 'Sterling Silver Cubic Zirconia Stud Earrings', 'This Sterling Silver cubic zirconia stud earring has a post and butterfly fitting and is for pierced ears. Dimensions - length 6.3mm, width 6.3mm, total weight 2.2 grams.', '', 13);
INSERT INTO `products_description` VALUES (254, 1, 'Elements Sterling Silver Square Cubic Zirconia Pendant', 'Pendant measures, length including loop 15.2mm, width 10.2mm and weighs 3.5 grams. This pendant does not come with a chain please select your chain from the drop down box. Elements presentation box included.', '', 29);
INSERT INTO `products_description` VALUES (255, 1, 'Sterling Silver Black Cubic Zirconia Stud Earrings', 'This sterling silver black cubic zirconia stud earring has a post and butterfly fitting and is for pierced ears. Dimensions - length 7.6mm, width 5.7mm, total weight 2.2grams.', '', 20);
INSERT INTO `products_description` VALUES (256, 1, 'Sterling Silver Blue Cubic Zirconia Bracelet', 'Elements sterling silver marquise shape blue crystal bracelet. Dimensions - length 18-21cm/7-8.25", width 5.6mm, weight 6.1 grams.', '', 19);
INSERT INTO `products_description` VALUES (257, 1, 'Elements Sterling Silver Blue Cubic Zirconia Pendant', 'Pendant measures, length including bale 50mm, width5.6mm and weighs 2 grams. This pendant does not come with a chain, please select your chain from the drop down box. Elements presentation box included.', '', 16);
INSERT INTO `products_description` VALUES (258, 1, 'Sterling Silver Blue Crystal Bracelet', 'Elements sterling silver three shades of blue crystal bracelet. Dimensions - length 18-21cmm/7-8.25", width 7.2mm at widest, weight 12.2 grams and comes in an elements presentation box.', '', 2);
INSERT INTO `products_description` VALUES (259, 1, 'Sterling Silver Blue Crystal Drop Earrings', 'This sterling silver dark blue crystal drop earring has a post and butterfly fitting for pierced ears. Dimensions - length 22.6mm, width 7.2mm and weighs a total of 3.6 grams.', '', 19);
INSERT INTO `products_description` VALUES (261, 1, 'Sterling Silver Blue Crystal Stud Earring', 'This Sterling Silver blue topaz stud earring has a post and butterfly fitting and is for pierced ears. Dimensions - length 12.1mm, width 7mm, total weight 2.4 grams.', '', 14);
INSERT INTO `products_description` VALUES (262, 1, 'Elements Blue Topaz Teardrop Pendant', 'Pendant measures - length 15.3mm, width 8.1mm and weighs 1.6 grams. This pendant does not come with a chain, please select your chain from the drop down box. Elements presentation box included.', '', 31);
INSERT INTO `products_description` VALUES (263, 1, 'Sterling Silver Blue Topaz Stud Earring', 'This sterling silver 5mm blue topaz stud earring has a post and butterfly fitting and is for pierced ears.', '', 16);
INSERT INTO `products_description` VALUES (264, 1, 'Elements Sterling Silver Blue Topaz Pendant', 'Pendant measures, length including bale 12.8mm, width 7mm and weighs 1.7 grams. This pendant does not come with a chain, please select your chain from the drop down box. Elements presentation box included.', '', 20);
INSERT INTO `products_description` VALUES (265, 1, 'Sterling Silver Filigree Drop Earrings', 'This sterling silver round filigree drop earring has hook fittings and is for pierced ears. Dimensions - length including hook 30mm, width 17.1mm and weighs a total of 5.4 grams.', '', 9);
INSERT INTO `products_description` VALUES (266, 1, 'Sterling Silver Round Filigree Necklet', 'Elements sterling silver round filigree necklet which has an adjustable chain 45-50cm/17.75-19.5". Pendant length including bale 34.3mm, width 24.8mm and weighs 6.5 grams including chain. It comes in an elements presentation box.', '', 21);
INSERT INTO `products_description` VALUES (267, 1, 'Sterling Silver Butterfly Drop Earrings', 'This sterling silver open butterfly drop earring has a hook fitting and is for pierced ears.\r\nDimensions - length 49.8mm including hook, width 13.4mm and total weight is 3.6 grams.', '', 11);
INSERT INTO `products_description` VALUES (268, 1, 'Sterling Silver Butterfly Necklet', 'Elements sterling silver open linked butterfly necklet with lobster claw catch and adjustable chain to increase length from 41cm/16" to 46cm/18".', '', 41);
INSERT INTO `products_description` VALUES (269, 1, 'Sterling Silver Leaf Shaped Bracelet', 'Elements sterling silver 6 leave bracelet. Dimensions - length 18-21cm/7-8.25", weight 5.1 grams.', '', 26);
INSERT INTO `products_description` VALUES (270, 1, 'Sterling Silver Leaf Drop Earrings', 'This sterling silver open leaf drop earring has a hook fitting and is for pierced ears.', '', 20);
INSERT INTO `products_description` VALUES (271, 1, 'Sterling Silver Double Leaf Necklet', 'Elements sterling silver double leaf necklet has an adjustable chain 41-46cm/16-18" it comes in an elements presentation box.', '', 21);
INSERT INTO `products_description` VALUES (272, 1, 'Sterling Silver Drop Earrings', 'This sterling silver cut out drop earring has a hook fitting and is for pierced ears. Dimensions - length including hook 39.4mm, width 21.8mm and weighs a total of 6 grams.', '', 13);
INSERT INTO `products_description` VALUES (273, 1, 'Elements Sterling Silver Cut Out Pendant', 'Pendant measures, length including bale 42.4mm, width 27.7mm and weighs 5.5 grams. This pendant does not come with a chain, please select your chain from the drop down box. Elements presentation box included.', '', 10);
INSERT INTO `products_description` VALUES (274, 1, 'Sterling Silver Drop Earrings', 'This sterling silver drop earring has a hook fitting and is for pierced ears. Dimensions - length including hook 31mm, width 20.7mm and weighs a total of 3.6 grams.', '', 10);
INSERT INTO `products_description` VALUES (275, 1, 'Sterling Silver Open Work Necklet', 'Elements sterling silver open work necklet, it measures 41cm/16" and extends to 46cm/18" and comes with an elements presentation box.', '', 2);
INSERT INTO `products_description` VALUES (276, 1, 'Sterling Silver Filigree Drop Earrings', 'This Elements sterling silver oval filigree drop earring has a hook fitting and is for pierced ears. Dimensions - length including hook 31.5mm, width 20.5mm and weighs a total of 4.4 grams.', '', 8);
INSERT INTO `products_description` VALUES (277, 1, 'Sterling Silver Filigree Necklet', 'Elements sterling silver oval swirl necklet, this necklet has an adjustable chain 45-50cm/17.75-19.5", length of pendant 31mm width 30.2mm and weighs 7.9 grams. It omes in an elements presentation box.', '', 14);
INSERT INTO `products_description` VALUES (278, 1, 'Sterling Silver Filigree Hoop Earring', 'This sterling silver open filigree hoop earring has a creole fitting and is for pierced ears. Dimensions - length 30.6mm, width 29.9mm and weighs a total of 6.8 grams.', '', 29);
INSERT INTO `products_description` VALUES (279, 1, 'Elements Sterling Silver Round Filigree Pendant', 'Pendant measures, length including bale 42mm, width 37mm and weighs 7.1 grams. This pendant does not come with a chain, please select your chain from the drop down box. Elements presentation box included.', '', 11);
INSERT INTO `products_description` VALUES (280, 1, 'Sterling Silver Half Hoop Earring', 'This sterling silver ridged effect half hoop earring has a post and butterfly fitting and is for pierced ears. Dimensions - length 21.7mm width 7.8mm and weighs a total of 5.6 grams.', '', 12);
INSERT INTO `products_description` VALUES (281, 1, 'Elements Sterling Silver Teardrop Pendant', 'Pendant measures, length 34.4mm, width 17.5mm and weighs 5.5 grams. This pendant does not come with a chain, please select your chain from the drop down box. Elements presentation box included.', '', 14);
INSERT INTO `products_description` VALUES (282, 1, 'Sterling Silver Open Link Bracelet', 'Elements sterling silver bracelet. Dimensions - length 19-20.5cm/7.25-8", width 15.1mm at widest, weight 14.5 grams.', '', 10);
INSERT INTO `products_description` VALUES (283, 1, 'Sterling Silver Drop Earring', 'This Sterling Silver drop earring has a hook fitting for pierced ears. Dimensions - length including hook 45mm, width 15.3mm and total weight 5.8 grams.', '', 9);
INSERT INTO `products_description` VALUES (284, 1, 'Elements Sterling Silver Oval Pendant', 'pendant measures, length 36.5mm, width 18.3mm and weighs 3.9 grams. This pendant does not come with a chain, please select your chain from the drop down box. Elements presentation box included.', '', 23);
INSERT INTO `products_description` VALUES (285, 1, 'Sterling Silver Figure of 8 Bracelet', 'Elements sterling silver figure of 8 bracelet. Dimensions length 7.25 to 8 inches (19-20.5cm), width 9.8mm, weight 18.5 grams.', '', 27);
INSERT INTO `products_description` VALUES (286, 1, 'Sterling Silver Figure of 8 Stud Earring', 'This Sterling Silver figure of eight stud earring has a post and butterfly fitting for pierced ears. dimensions length 24.5mm, width 8.2mm and total weight of 4.4 grams.', '', 9);
INSERT INTO `products_description` VALUES (287, 1, 'Elements Sterling Silver Figure of 8 Pendant', 'Pendant measures, length 29.4mm, width 11.6mm and weighs 3 grams. This pendant does not come with a chain, please select a chain from the drop down box. Elements presentation box included.', '', 49);
INSERT INTO `products_description` VALUES (288, 1, 'Sterling Silver Ridged Stud Earring', 'This sterling silver ridged stud earring has a post and butterfly fitting and suitable for pierced ears. Dimensions - length 13.5mm, width 9.5mm and weighs a total of 3 grams.', '', 15);
INSERT INTO `products_description` VALUES (289, 1, 'Elements Sterling Silver Ridged Pendant', 'Pendant measures, length 22mm, width 11.3mm and weighs 3.6 grams. this pendant does not come with a chain, please select your chain from the drop down box. Elements presentation box included.', '', 8);
INSERT INTO `products_description` VALUES (290, 1, 'Sterling Silver Leaf Drop Earrings', 'This Elements sterling silver leaf drop earrings has a hook fitting and is for pierced ears. Dimensions - length including hook 39.8mm, width 8mm and weighs a total of 2.6 grams.', '', 9);
INSERT INTO `products_description` VALUES (291, 1, 'Elements Sterling Silver Twist Leaf Pendant', 'Pendant measures, length 46.9mm, width 11.2mm and weighs 4.2 grams. This pendant does not come with a chain, please select your chain from the drop down box. Elements presentation box inluded.', '', 11);
INSERT INTO `products_description` VALUES (292, 1, 'Sterling Silver Drop Earrings', 'This sterling silver oval and teardrop earring has a post and butterfly fitting and is for pierced ears. Dimensions - length 45.6mm, width 19.8mm and weighs a total of 8.8 grams.', '', 12);
INSERT INTO `products_description` VALUES (293, 1, 'Elements Sterling Silver Oval and Tear Drop Pendant', 'Pendant measures, length 42.3mm, width 19.5mm and weighs 4.4 grams. This pendant does not come with a chain, please select your chain from the drop down box. Elements presentation box included.', '', 9);
INSERT INTO `products_description` VALUES (294, 1, 'Sterling Silver Open Squared Drop Earrings', 'This Sterling Silver drop earring has a post and butterfly fitting and is for pierced ears. Dimensions - length 33.5mm, width 15mm and total weight of 6 grams.', '', 24);
INSERT INTO `products_description` VALUES (295, 1, 'Elements Sterling Silver Open Squared Pendant', 'Pendant measures, length 46mm, width 20mm and weighs 6.1 grams. This pendant does not come with a chain, please select your chain from the drop down box. Elements presentation box included', '', 22);
INSERT INTO `products_description` VALUES (296, 1, 'Sterling Silver Kiss Stud Earring', 'This sterling silver kiss stud earring has a post and butterfly fitting and is for pierced ears. Dimensions - length 14.3mm, width 9mm and total weight 2 grams.', '', 71);
INSERT INTO `products_description` VALUES (297, 1, 'Sterling Silver Kiss Pendant', 'Elements sterling silver kiss pendant with 46cm/18" box chain. Dimensions of pendant length 17.2 mm, width 13mm at widest and comes in an elements presentation box.', '', 22);
INSERT INTO `products_description` VALUES (298, 1, 'Sterling Silver Drop Earrings', 'This sterling silver diamond cut and polished finish drop earring has a post and butterfly fitting and is for pierced ears.  Dimensions - length 36.8mm, width 11.3mm and weighs a total of 4.4 grams.', '', 10);
INSERT INTO `products_description` VALUES (299, 1, 'Elements Sterling Silver Diamond Cut and Polished Finish Pendant', 'pendant measures, length including bale 47.1mm, width 14.6mm and weighs 4 grams. This pendant does not come with a chain, please select your chain from the drop down box. Elements presentation box included.', '', 11);
INSERT INTO `products_description` VALUES (300, 1, 'Sterling Silver Half Hoop Crossover Earring', 'This sterling silver diamond cut and polished finished crossover half hoop earring has a post and butterfly fitting and is for pierced ears. Dimensions - length 11.5mm, width 6.2mm and weighs a total of 2 grams.', '', 11);
INSERT INTO `products_description` VALUES (301, 1, 'Elements Sterling Silver Diamond Cut and Polished Finish Pendant', 'Pendant measures, length 15.5mm, width 8.2mm and weighs 1.3 grams. This pendant does not come with a chain, please select your chain from the drop down box. Elements presentation box included.', '', 11);
INSERT INTO `products_description` VALUES (302, 1, 'Sterling Silver Heart Bracelet', 'Elements sterling silver polished hearts bracelet. Dimensions - length 18-21cm/7-8.25".', '', 2);
INSERT INTO `products_description` VALUES (303, 1, 'Sterling Silver Heart Drop Earrings', 'This Elements sterling silver plain heart drop earring has a hook fitting for pierced ears. Dimensions - length including hook 25.2mm, width 9.7mm and weighs a total of 1.8 grams.', '', 9);
INSERT INTO `products_description` VALUES (304, 1, 'Elements Sterling Silver Polished Heart Pendant', 'Pendant measures, length including bale 32.9mm, width 21mm and weighs 3.2 grams. This pendant does not come with a chain, please select your chain from the drop down box. Elements presentation box included.', '', 7);
INSERT INTO `products_description` VALUES (305, 1, 'Sterling Silver Cubic Zirconia Stud Earrings', 'This Sterling Silver round cubic zirconia stud earring has a post and butterfly fitting and is for pierced ears. Dimensions - diameter 7.4mm and weighs a total of 3 grams.', '', 26);
INSERT INTO `products_description` VALUES (306, 1, 'Elements Sterling Silver Round Cubic Zirconia Pendant', 'Pendant measures, length 17.4mm including bale, width 8.6mm and weighs 1.5 grams. This pendant does not come with a chain, please select your chain from the drop down box. Elements presentation box included.', '', 15);
INSERT INTO `products_description` VALUES (730, 1, 'Sterling Silver Cubic Zirconia Cherry Blossom Pendant', 'This beautiful pendant has a cubic zirconia in the centre which is held in by 4 claws.\r\n26mm x 23mm. It sits on an 18"/45cm diamond cut curb chain.', '', 25);
INSERT INTO `products_description` VALUES (308, 1, 'B3168C', '', '', 3);
INSERT INTO `products_description` VALUES (310, 1, 'Sterling Silver Cubic Zirconia Tennis Bracelet', 'Elements sterling silver cubic zirconia tennis bracelet. Dimensions - length 19cm/7.25 inches, width 5.1mm, weight 15 grams.', '', 23);
INSERT INTO `products_description` VALUES (311, 1, 'Sterling Silver Oval Link Bracelet', 'Elements sterling silver oval open link bracelet. Dimensions - length 18-21cm/7-8.25", width 9.8mm at widest, weight 9.2 grams.', '', 20);
INSERT INTO `products_description` VALUES (312, 1, 'Sterling Silver Oval Open Link Necklet', 'Elements sterling silver oval open link 45cm/17.75" necklet with lobster claw catch, weight 11.6 grams and it comes with an elements presentation box.', '', 19);
INSERT INTO `products_description` VALUES (313, 1, 'Sterling Silver Charm Bracelet With 8 Heart Charms', 'Elements sterling silver charm bracelet with 8 heart charms, length 19cm/7.5", weight 10.5 grams.', '', 25);
INSERT INTO `products_description` VALUES (314, 1, 'Sterling Silver T.Bar Bracelet', 'Elements sterling silver t bar bracelet with crystal heart charm. Dimensions - length 19cm7.5",weight 19 grams.', '', 8);
INSERT INTO `products_description` VALUES (315, 1, 'Sterling Silver Cubic Zirconia Earrings', 'This sterling silver hoop style earrings with 6 cubic zirconia stones has a post and butterfly fitting and is for pierced ears. Dimensions are, length 12mm, width at widest 5mm and a total weight of 2 grams.', '', 15);
INSERT INTO `products_description` VALUES (316, 1, 'Elements Sterling Silver Cubic Zirconia Pendant', 'Pendant measures, length 20.3mm, width 4.4mm and weighs 1.6 grams. This pendant does not come with a chain, please select your chain from the drop down box.', '', 14);
INSERT INTO `products_description` VALUES (317, 1, 'Sterling Silver Cubic Zirconia Stud Earrings', 'This sterling silver cubic zirconia stud earring has a post and butterfly fitting and is for pierced ears. Dimensions - length 8mm, width 4.5mm and weighs a total of 0.8 grams.', '', 18);
INSERT INTO `products_description` VALUES (318, 1, 'Elements Sterling Silver Cubic Zirconia Pendant', 'Pendant measures, length 11.6mm, width 5.4mm and weighs 0.7 grams. This pendant does not come with a chain, please select your chain from the drop down box. Elements presentation box included.', '', 77);
INSERT INTO `products_description` VALUES (319, 1, 'Sterling Silver Cubic Zirconia Stud Earrings', 'This sterling silver channel set cubic zirconia stud earring has a post and butterfly fitting and is for pierced ears. Dimensions - length 6.7mm, width 4.3mm and weighs a total of 1.4 grams.', '', 11);
INSERT INTO `products_description` VALUES (320, 1, 'Fred Bennett Stainless Steel Bracelet', 'Bracelet measures, length 23cm/9", width 15.4mm at the middle plate and weighs 62.4 grams. All Fred Bennett products come in a Fred Bennett gift box.', '', 9);
INSERT INTO `products_description` VALUES (321, 1, 'Fred Bennett Stainless Steel Bracelet', 'Bracelet measures, length 23cm/9", width 8.4mm and weighs 34.8 grams. All Fred Bennett products come in a Fred Bennett gift box.', '', 13);
INSERT INTO `products_description` VALUES (322, 1, 'B3130', '', '', 1);
INSERT INTO `products_description` VALUES (323, 1, 'Fred Bennett Stainless Steel Bangle', 'Bangle measures, length 74.8mm, width 10.1mm and weighs 32.7 grams. All Fred Bennett products come in a Fred Bennett gift box.', '', 13);
INSERT INTO `products_description` VALUES (324, 1, 'Fred Bennett Stainless Steel Bracelet', 'Bracelet measures, length 23cm/9", width 6.5mm and weighs 20.9 grams. All Fred Bennett products come in a Fred Bennett gift box.', '', 2);
INSERT INTO `products_description` VALUES (325, 1, 'Fred Bennett Stainless Steel Curb Identity Bracelet', 'Bracelet measures, length 23.5cm/9", width 9.2mm, engraving plate 49mm x 10.1mm and weighs 29.4 grams. All Fred Bennett products come in a Fred Bennett gift box.', '', 14);
INSERT INTO `products_description` VALUES (326, 1, 'Fred Bennett Sterling Silver Scratched Finish Bangle', 'Bracelet measures, length 69.6mm, width 9.7mm and weighs 30.4 grams. All Fred Bennett products come with a Fred Bennett gift box.', '', 14);
INSERT INTO `products_description` VALUES (327, 1, 'Fred Bennett Stainless Steel Oval Dogtags Necklace', 'Dog tags measure, length 37.5mm, width 18.8mm each and sits on a 56cm/22" ball chain. Total weight 24.1 grams. All Fred Bennett products come in a Fred Bennett gift box.', '', 9);
INSERT INTO `products_description` VALUES (328, 1, 'Fred Bennett Stainless Steel Dogtag Necklace', 'Dogtags measure, length 40mm, width 17mm each and sit on a56cm/22" ball chain. Total weight 16.7 grams. All Fred Bennett products come in a Fred Bennett gift box.', '', 15);
INSERT INTO `products_description` VALUES (329, 1, 'Fred Bennett Sterling Silver Plain Cross Pendant', 'Cross measures, length 35.8mm, width 20mm and sits on a silver 51cm/20" ball chain. Total weight 15 grams. All Fred Bennett produts come in a Fred Bennett gift box.', '', 22);
INSERT INTO `products_description` VALUES (330, 1, 'Fred Bennett Stainless Steel Brushed and Polished Cross Pendant', 'Cross measures, length 29.9mm, width 20.1mm and sits on a 51cm/20" curb chain. Total weight 13.3 grams. All Fred Bennett products come in a Fred Bennett gift box.', '', 31);
INSERT INTO `products_description` VALUES (331, 1, 'Fred Bennet Sterling Silver Cross Pendant', 'Cross Measures, length 34.6mm, width 21.6mm and sits on a 51cm/20" silver box chain. Total weight 17.4 grams. All Fred Bennett products come in a Fred Bennett gift box.', '', 21);
INSERT INTO `products_description` VALUES (332, 1, 'Fred Bennett Sterling Silver Dogtag with Black Resin Stripe Pend', 'Dogtag measures, length including bale 43.5mm, width 21.7mm and sits on a 51cm/20" silver box chain. Total weight 27.1 grams. All fred Bennett products come in a Fred Bennett gift box.', '', 12);
INSERT INTO `products_description` VALUES (333, 1, 'Fred Bennett Stainless Steel Brushed and Polished Dogtag Pendant', 'Dogtag measures, length including bale 35mm, width 14.8mm and sits on a 51cm/20" ball chain. Total weight 11.5 grams. All Fred Bennett products come in a Fred Bennett gift box.', '', 12);
INSERT INTO `products_description` VALUES (334, 1, 'Fred Bennett Stainless Steel Cross Pendant', 'Cross measures, length including bale 43.4mm, width 25.5mm and sits on a 51cm/20" curb chain. Total weight 17 grams. All Fred Bennett products come in a Fred Bennett gift box.', '', 13);
INSERT INTO `products_description` VALUES (335, 1, 'Fred Bennett Sterling Silver Scratch Finish Cufflinks', 'Gents sterling silver scratched finished Fred Bennett cufflinks. Dimensions - 13.2mm x 13.2mm and weights 6.3 grams each. All Fred Bennett products are sold in Fred Bennett gift boxes.', '', 8);
INSERT INTO `products_description` VALUES (336, 1, 'Fred Bennett Stainless Steel Carbon Fibre Cufflinks', 'Gents round 15mm stainless steel carbon fibre Fred Bennett cufflinks,  weight 5.5 grams each. All Fred Bennett products are sold in Fred Bennett gift boxes.', '', 14);
INSERT INTO `products_description` VALUES (337, 1, 'Fred Bennett Stainless Steel Cufflinks', 'Gents Fred Bennett stainless steel brushed and polished square cufflinks, these cufflinks measures 12.9mm x 12.9mm and weighs 4 grams each. All Fred Bennett products are sold in Fred Bennett gift boxes.', '', 14);
INSERT INTO `products_description` VALUES (338, 1, 'Fred Bennett Sterling Silver Scratched and Polished Cufflinks', 'Gents sterling silver Fred Bennett scratched and polished cufflinks, these cufflinks measure 17.5mm x 10.2mm and weighs 4.6 grams each. All Fred Bennett products are sold in a Fred Bennett gift boxes.', '', 16);
INSERT INTO `products_description` VALUES (339, 1, 'Fred Bennett Stainless Steel Cufflinks', 'Gents stainless steel Fred Bennett polished cufflinks, measure 13.6mm x 13.6mm and weighs 6.3 grams each. All Fred Bennett products are sold in a Fred Bennett gift box.', '', 11);
INSERT INTO `products_description` VALUES (340, 1, 'Fred Bennett Stainless Steel Cufflinks', 'Gents stainless steel Fred Bennett ribbed design cufflinks, measures 17.8mm x 12.3mm and weighs 5 grams each. All Fred Bennett products are sold in a Fred Bennett gift box.', '', 12);
INSERT INTO `products_description` VALUES (341, 1, 'Fred Bennett Sterling Silver Scooped Edged Cufflinks', 'Gents sterling silver scooped edge Fred Bennett cfflinks, measure 13.7mm x 13.7mm and weighs 5.7 grams each. All Fred Bennett are sold in a Fred Bennett gift box.', '', 11);
INSERT INTO `products_description` VALUES (342, 1, 'Fred Bennett Sterling Silver Scratched and Polished Cufflinks', 'Gents sterling silver Fred Bennett scratched and polished cufflinks, these cufflinks measure 23mm x 7mm and weigh 5.9 grams each. All Fred Bennett products are sold in a Fred Bennett gift box.', '', 14);
INSERT INTO `products_description` VALUES (343, 1, 'Fred Bennet Sterling Silver Scratched and Polished Bangle', 'Bangle measures, length 72.2mm, width 12mm and weighs 47.4 grams. All Fred Bennett products come in a Fred Bennett gift box.', '', 8);
INSERT INTO `products_description` VALUES (344, 1, 'Fred Bennett Stainless Steel Bangle With Black PVD Strip', 'Bangle measures, length 73mm, width 10.2mm and weighs 30.4 grams. All fred Bennett products come in a Fred Bennett gift box.', '', 14);
INSERT INTO `products_description` VALUES (345, 1, 'Fred Bennett Sterling Silver Scratched and PolishedCross Pendant', 'Cross measures, length 30.1mm, width 18.2mm and sits on a 51cm/20" silver box chain. Total weight 13.9 grams. All Fred Bennett products come in a Fred Bennett gift box.', '', 10);
INSERT INTO `products_description` VALUES (346, 1, 'Fred Bennett Stainless Steel Dogtag Necklace', 'Dogtag measures, length 39mm, width 18mm and sits on a 51cm/20" curb chain. Total weight 21.8 grams. All Fred Bennett products come in a Fred Bennett gift box.', '', 20);
INSERT INTO `products_description` VALUES (347, 1, 'Fred Bennett Stainless Steel Dogtag Necklace with Cubic Zirconia', 'Dogtag measures, length including bale 33.7mm, width 12.2mm and sits on a 51cm/20" curb chain. Total weight 10.8 grams. All Fred Bennett products come in a Fred Bennett gift box.', '', 14);
INSERT INTO `products_description` VALUES (348, 1, 'Fred Bennett Sterling Silver Dogtag Pendant with Scooped Edge', 'Dogtag measures, length including bale 41.7mm, width 17.1 - 19.7mm and sits on a silver 51cm/20" box chain. Total Weight 17.8 grams. All Fred Bennett products come in a Fred Bennett gift box.', '', 15);
INSERT INTO `products_description` VALUES (349, 1, 'LB1526P', '', '', 4);
INSERT INTO `products_description` VALUES (350, 1, 'Ladies Accurist Stainless Steel Quartz Watch', 'This Ladies Accurist has a stainless steel case and bracelet which is fully adjustable, quartz analogue movement and comes with a 3 year manufacturers guarantee and presentation box.', '', 30);
INSERT INTO `products_description` VALUES (351, 1, 'Ladies Accurist Gold Plated Quartz Watch', 'This ladies Accurist watch has a gold plated case and fully adjustable bracelet, tonneau shaped silver coloured dial, quartz analogue movement, water resistant and comes with a 3 year manufacturers guarantee and presentation box.', '', 26);
INSERT INTO `products_description` VALUES (352, 1, 'Girls D for Diamond Sterling Silver Heart Earrings', 'Heart earrings with diamond measures 5.5mm x 5.5mm and has a post and butterfly fitting for pierced ears.', '', 16);
INSERT INTO `products_description` VALUES (353, 1, 'Girls D for Diamond Sterling Silver Star Earrings', 'Star earrings with diamond measures 5.5mm x 5.5mm and has a post and butterfly fitting for pierced ears.', '', 17);
INSERT INTO `products_description` VALUES (354, 1, 'Fluid Sterling Silver Ripple collection Open Heart Pendant', 'Pendant measures 17mm x 11.7mm and is attached to a 43cm chain, total weight 4.1 grams.', '', 25);
INSERT INTO `products_description` VALUES (355, 1, 'Fluid Sterling Silver Ripple Collection Drop Earrings', 'Earrings measure, length 23mm, width 8.6mm and each earring weighs 1.1 grams. This earring has a post and butterfly fitting and is for pierced ears.', '', 76);
INSERT INTO `products_description` VALUES (356, 1, 'Fluid Sterling Silver Ripple Collection Open Heart T.Bar Bracele', 'Bracelet measures 19cm in length and has 4 open hearts, one of which houses the T.Bar fitting. The weight of the bracelet is 4 grams.', '', 18);
INSERT INTO `products_description` VALUES (357, 1, 'Fluid Sterling Silver Puddle Collection Drop Earrings', 'Earrings measure, length 23mm, width 7.6mm and each earring weighs 0.8 grams. This earring has a post and butterfly fitting and is for pierced ears.', '', 9);
INSERT INTO `products_description` VALUES (358, 1, 'Fluid Sterling Silver Puddle Collection 3 Link Pendant', 'Pendant measures 42mm x 10mm and sits on a 43cm chain, Total weight 6.3 grams.', '', 13);
INSERT INTO `products_description` VALUES (359, 1, 'Fluid Sterling Silver Lagoon Collection Drop Earrings', 'Earrings measure, length 20mm, width 6.3mm and each earring weighs 1.3 grams. This earring has a post and butterfly fitting and is for pierced ears.', '', 13);
INSERT INTO `products_description` VALUES (360, 1, 'Fluid Sterling Silver Lagoon Collection Bracelet with Figure of', 'Bracelet measures 19cm in length and is joined in the middle with a figure of 8 charm which is 19mm long and 6.5mm wide. The weight of the bracelet is 3.1 grams.', '', 86);
INSERT INTO `products_description` VALUES (361, 1, 'Fluid Sterling Silver Lagoon Collection Figure of 8 Pendant', 'Pendant measures including loop 27.7mm x 8.6mm and sits on a 43cm chain. Total weight 4.2 grams.', '', 21);
INSERT INTO `products_description` VALUES (362, 1, 'Fluid Sterling Silver Raindrop Collection Stud Earrings', 'Earring measures, length 12.2mm, width 6.6mm and each earring weighs 1.3 grams. This earring has a post and butterfly fitting and is for pierced ears.', '', 20);
INSERT INTO `products_description` VALUES (363, 1, 'Fluid Sterling Silver Raindrop Collection Tear Drop Pendant', 'Pendant measures 16.8mm x 9.6mm and sits on a 43cm chain. Total weight 6.3 grams.', '', 21);
INSERT INTO `products_description` VALUES (364, 1, 'Fluid Sterling Silver Bubble Collection Drop Earrings', 'Earring measures, length 22mm, width 14mm and each earring weighs 2.2 grams. This earring has a post and butterfly fitting and is for pierced ears.', '', 20);
INSERT INTO `products_description` VALUES (365, 1, 'Fluid Sterling Silver Bubble Collection Heart Pendant', 'Pendant measures, 19mm x 18mm and is attached to a 43cm chain, total weight 8.5 grams.', '', 31);
INSERT INTO `products_description` VALUES (366, 1, 'Fluid Sterling Silver Droplet Collection Earrings', 'Earrings measure, length 24mm, width 6.4mm and each earring weighs 1.3 grams. This earring has a post and butterfly fitting and is for pierced ears.', '', 15);
INSERT INTO `products_description` VALUES (367, 1, 'Fluid Sterling Silver Droplet Collection Tear Drop Necklace', 'Necklace measures 43cm in length, the cluster drop measures 67mm and weighs a total of 5.5 grams.', '', 17);
INSERT INTO `products_description` VALUES (368, 1, 'Fluid Sterling Silver Droplet Collection T.Bar Bracelet', 'Bracelet measures 19cm and comes with a T.Bar fitting with a tear drop charm on the end ring. The weight of this bracelet is 9.9 grams.', '', 15);
INSERT INTO `products_description` VALUES (369, 1, 'Fluid Sterling Silver Droplet Collection Tear Drop Pendant', 'Pendant measures 17.4mm x 9.2mm and sits on a 43cn chain. Total weight 4.4 grams.', '', 15);
INSERT INTO `products_description` VALUES (370, 1, 'Fluid Sterling Silver Tide Collection Drop Earrings', 'Earring measures, length 37mm, width 6.7mm and each earring weighs 1.8 grams. This earring has a post and butterfly fitting and is for pierced ears.', '', 19);
INSERT INTO `products_description` VALUES (371, 1, 'Fluid Sterling Silver Tide Collection Twist Torque Bangle', 'Bangle measures 65mm X 10mm at the widest and weighs 21.9 grams.', '', 19);
INSERT INTO `products_description` VALUES (372, 1, 'Fluid Sterling Silver Tide Collection Twist Necklace', 'Necklace measures including loop, 50mm x 9mm and sits on a 43cm chain. Total weight 7.3 grams.', '', 29);
INSERT INTO `products_description` VALUES (373, 1, 'Fluid Sterling Silver Oasis Collection Drop Earrings', 'Earring measures, length including hook 31mm, width 7.1mm and each earring weighs 2.1 grams. This earring has a hook fitting for pierced ears.', '', 67);
INSERT INTO `products_description` VALUES (374, 1, 'Fluid Sterling Silver Oasis Collection Pippin Pendant', 'Pendant measures including loop, 28mm x 8.5mm and is attached to a 43cm chain, total weight 4.9 grams.', '', 81);
INSERT INTO `products_description` VALUES (375, 1, 'Fluid Sterling Silver Oasis Collection 3 Charm Bracelet', 'Bracelet measures 19cm in length and has three charms with a total weight of 8.2 grams.', '', 10);
INSERT INTO `products_description` VALUES (376, 1, 'Ladies Sekonda Party Time Cloud White Watch', 'This Sekonda fashion watch has a round chrome stone set case, white dial, white silicone strap, quartz analogue movement and comes with a 2 year manufacturers guarantee and presentation box.', '', 23);
INSERT INTO `products_description` VALUES (377, 1, 'Ladies Sekonda Party Time Moonlight Black Watch', 'This Sekonda fashion watch has a round chrome colour stone set case, black dial, black silicone strap, quartz analogue movement and comes with a 2 year manufacturers guarantee and presentation box.', '', 22);
INSERT INTO `products_description` VALUES (378, 1, 'Ladies Sekonda Party Time Blossom Watch', 'This Sekonda fashion watch has a round chrome colour stone set case, fuschia coloured dial, fuschia silicone strap, quartz analogue movement and comes with a 2 year manufacturers guarantee and presentation box.', '', 14);
INSERT INTO `products_description` VALUES (379, 1, 'Ladies Sekonda Party Time Aqua Watch', 'This Sekonda fashion watch has a round chrome colour stone set case, light blue dial, light blue silicone strap, quartz analogue movement and comes with a 2 year manufacturers guarantee and presentation box.', '', 26);
INSERT INTO `products_description` VALUES (380, 1, 'Ladies Sekonda Party Time Palm Green Watch', 'This Sekonda fashion watch has a round chrome colour stone set case, green dial, green silicone strap, quartz analogue movement and comes with a 2 year manufacturers guarantee and presentation box.', '', 21);
INSERT INTO `products_description` VALUES (381, 1, 'Ladies Sekonda Party Time Riviera Blue Watch', 'This Sekonda fashion watch has a round chrome colour stone set case, blue dial, blue silicone strap, quartz analogue movement and comes with a 2 year manufacturers guarantee and presentation box.', '', 24);
INSERT INTO `products_description` VALUES (382, 1, 'Ladies Sekonda Party Time Orange Watch', 'This Sekonda fashion watch has a chrome colour stone set case, orange dial, orange silicone strap, quartz analogue movement and comes with a 2 year manufacturers guarantee and presentation box.', '', 15);
INSERT INTO `products_description` VALUES (383, 1, 'Ladies Sekonda Party Time Purple Watch', 'This Sekonda fashion watch has a round chrome colour stone set case, purple dial, purple silicone strap, quartz analogue movement and comes with a 2 year manufacturers guarantee and presentation box.', '', 13);
INSERT INTO `products_description` VALUES (384, 1, 'Ladies Sekonda Party Time Yellow Watch', 'This Sekonda fashion watch has a round chrome colour stone set case, yellow dial, yellow silicone strap, quartz analogue movement and comes with a 2 year manufacturers guarantee and presentation box.', '', 23);
INSERT INTO `products_description` VALUES (388, 1, 'Large Pewter Quaich  (43L)', '<ul>\r\n  <li>Bright polished finish</li>\r\n  <li>Celtic detail on handles</li>\r\n  <li>Supplied in lid and case box</li>\r\n  <li>&quot;The quaich&quot; story card included</li>\r\n  <li>Bowl diameter - 115mm/4.25&quot;</li>\r\n  <li>Height - 55mm/2&quot;</li>\r\n  <li>Handle to handle - 190mm/7.25&quot;</li>\r\n  <li>Suitable for engraving</li>\r\n</ul>', '', 13);
INSERT INTO `products_description` VALUES (389, 1, 'Large Brass Rim Pewter Quaich', '<ul>\r\n<li> Bright Polished finish</li>\r\n<li> Celtic detail on handles</li>\r\n<li> supplied in lid and base box</li>\r\n<li> "The quaich" story card included</li>\r\n<li> Bowl diameter - 115mm/4.25"</li>\r\n<li> Height - 55mm/2"</li>\r\n<li> Handle to handle - 190mm/7.25"</li>\r\n<li> Suitable for engraving</li>\r\n</ul>', '', 35);
INSERT INTO `products_description` VALUES (390, 1, 'Large Celtic Band Pewter Quaich', '<ul>\r\n  <li>Bright polished finish</li>\r\n  <li>Celtic band detail on outside of bowl</li>\r\n  <li>Celtic detail on handles</li>\r\n  <li>Supplied in lid and base box</li>\r\n  <li>&quot;The quaich&quot; story card included</li>\r\n  <li>Bowl diameter - 115mm/4.25&quot;</li>\r\n  <li>Height - 55mm/2&quot;</li>\r\n  <li>Handle to handle - 190mm/7.25&quot;</li>\r\n  <li>Suitable for engraving</li>\r\n</ul>', '', 24);
INSERT INTO `products_description` VALUES (391, 1, 'Large Pewter Gem Handle Quaich', '<ul>\r\n  <li>Bright polished finish</li>\r\n  <li>Handles set with blue agate semi-precious cabachons</li>\r\n  <li>Supplied in lid and base box</li>\r\n  <li>&quot;The quaich&quot; story card included</li>\r\n  <li>Bowl diameter - 115mm/4.25&quot;</li>\r\n  <li>Height - 55mm/2&quot;</li>\r\n  <li>Handle to handle - 190mm/7.25&quot;</li>\r\n  <li>Suitable for engraving</li>\r\n</ul>', '', 20);
INSERT INTO `products_description` VALUES (392, 1, 'Medium Pewter Quaich (43M)', '<ul>\r\n  <li>Bright polished finish</li>\r\n  <li>Celtic detail on handles</li>\r\n  <li>Supplied in lid and base box</li>\r\n  <li>&quot;The quaich&quot; story card included</li>\r\n  <li>Bowl diameter - 100mm/4&quot;</li>\r\n  <li>Height - 50mm/1.5&quot;</li>\r\n  <li>Handle to handle - 160mm/6&quot;</li>\r\n  <li>Suitable for engraving</li>\r\n</ul>', '', 17);
INSERT INTO `products_description` VALUES (393, 1, 'Medium Brass Rim Pewter Quaich (43MB)', '<ul>\r\n  <li>Bright polished finish</li>\r\n  <li>Celtic detail on handles</li>\r\n  <li>Supplied in lid and base box</li>\r\n  <li>&quot;The quaich&quot; story card included</li>\r\n  <li>Bowl diameter - 100mm/4&quot;</li>\r\n  <li>Height - 50mm/1.5&quot;</li>\r\n  <li>Handle to handle - 160mm/6&quot;</li>\r\n  <li>Suitable for engraving</li>\r\n</ul>', '', 17);
INSERT INTO `products_description` VALUES (394, 1, 'Medium Celtic Band Pewter Quaich (43MC)', '<ul>\r\n  <li>Bright polished finish</li>\r\n  <li>Celtic band detail on outside of bowl</li>\r\n  <li>Celtic detail on handles</li>\r\n  <li>Supplid in lid and base box</li>\r\n  <li>&quot;The quaich&quot; story card included</li>\r\n  <li>Bowl diameter - 100mm/4&quot;</li>\r\n  <li>Height - 50mm/1.5&quot;</li>\r\n  <li>Handle to handle - 160mm/6&quot;</li>\r\n  <li>Suitable for engraving</li>\r\n</ul>', '', 16);
INSERT INTO `products_description` VALUES (395, 1, 'Medium Pewter Gem Handle Quaich (43MGHDL)', '<ul>\r\n  <li>Bright polished finish</li>\r\n  <li>Handles set with blue agate semi-precious cabachons</li>\r\n  <li>Supplied in lid and base box</li>\r\n  <li>&quot;The quaich&quot; story card included</li>\r\n  <li>Bowl diameter - 100mm/4&quot;</li>\r\n  <li>Height - 50mm/1.5&quot;</li>\r\n  <li>Handle to handle - 160mm/6&quot;</li>\r\n  <li>Suitable for engraving</li>\r\n</ul>', '', 10);
INSERT INTO `products_description` VALUES (396, 1, 'Small Pewter Quaich (43S)', '<ul>\r\n  <li>Bright polished finish</li>\r\n  <li>Celtic detail on handles</li>\r\n  <li>Supplied in lid and base box</li>\r\n  <li>&quot;The quaich&quot; story card included</li>\r\n  <li>Bowl diameter - 70mm/2.75&quot;</li>\r\n  <li>Height - 40mm/1.25&quot;</li>\r\n  <li>Handle to handle - 125mm/4.5&quot;</li>\r\n  <li>Suitable for engraving</li>\r\n</ul>', '', 12);
INSERT INTO `products_description` VALUES (397, 1, 'Small Brass Rim Pewter Quaich', '<ul>\r\n  <li>Bright polished finish</li>\r\n  <li>Celtic detail on handles</li>\r\n  <li>Supplied on lid and base box</li>\r\n  <li>&quot;The quaich &quot; story card included</li>\r\n  <li>Bowl diameter - 70mm/2.75&quot;</li>\r\n  <li>Height - 40mm/1.25&quot;</li>\r\n  <li>Handle to handle - 125mm/4.5&quot;</li>\r\n  <li>Suitable for engraving</li>\r\n</ul>', '', 12);
INSERT INTO `products_description` VALUES (398, 1, 'Small Pewter Celtic Band Quaich (43SC)', '<ul>\r\n  <li>Bright polished finish</li>\r\n  <li>Celtic band detail on outside of bowl</li>\r\n  <li>Celtic detail on handles</li>\r\n  <li>Supplied in lid and base box</li>\r\n  <li>&quot;The quaich&quot; story card included</li>\r\n  <li>Bowl diameter - 70mm/2.75&quot;</li>\r\n  <li>Height - 40mm/1.25&quot;</li>\r\n  <li>Handle to handle - 125mm/4.5&quot;</li>\r\n  <li>Suitable for engraving</li>\r\n</ul>', '', 18);
INSERT INTO `products_description` VALUES (399, 1, 'Small Gem Handle Pewter Quaich', '<ul>\r\n  <li>Bright polished finish</li>\r\n  <li>Handles set with blue agate semi-precious cabachons</li>\r\n  <li>Supplied in lid and base box</li>\r\n  <li>&quot;The quaich&quot; story card included</li>\r\n  <li>Bowl diameter - 70mm/2.75&quot;</li>\r\n  <li>Height - 40mm/1.25&quot;</li>\r\n  <li>Handle to handle - 125mm/4.5&quot;</li>\r\n  <li>Suitable for engraving</li>\r\n</ul>', '', 13);
INSERT INTO `products_description` VALUES (400, 1, 'Standard Pewter Quaich', '<ul>\r\n  <li>Bright polished finish</li>\r\n  <li>Celtic detail on handles</li>\r\n  <li>Supplied in lid and base box</li>\r\n  <li>&quot;The quaich&quot; story card included</li>\r\n  <li>Bowl diameter - 90mm/3.5&quot;</li>\r\n  <li>Height - 45mm/1.5mm&quot;</li>\r\n  <li>Handle to handle - 150mm/5.5&quot;</li>\r\n  <li>Suitable for engraving</li>\r\n</ul>', '', 10);
INSERT INTO `products_description` VALUES (401, 1, 'Standard Brass Rim Pewter Quaich (43STB)', '<ul>\r\n  <li>Bright polished finish</li>\r\n  <li>Celtic detail on handles</li>\r\n  <li>Supplied in lid and base box</li>\r\n  <li>&quot;The quaich&quot; story card included</li>\r\n  <li>Bowl diameter - 90mm/3.5&quot;</li>\r\n  <li>Height - 45mm/1.5&quot;</li>\r\n  <li>Handle to handle - 150mm/5.5&quot;</li>\r\n  <li>Suitable for engraving</li>\r\n</ul>', '', 14);
INSERT INTO `products_description` VALUES (402, 1, 'Standard Celtic Band Quaich', '<ul>\r\n  <li>Bright Polished finish</li>\r\n  <li>Celtic band detail on outside of bowl</li>\r\n  <li>Celtic detail on handles</li>\r\n  <li>Supplied in lid and base box</li>\r\n  <li>&quot;The quaich&quot; story card included</li>\r\n  <li>Bowl diameter - 90mm/3.5&quot;</li>\r\n  <li>Height - 45mm/1.5&quot;</li>\r\n  <li>Handle to handle - 150mm/5.5&quot;</li>\r\n  <li>Suitable for engraving</li>\r\n</ul>', '', 17);
INSERT INTO `products_description` VALUES (403, 1, 'Standard Gem Handle Pewter Quaich', '<ul>\r\n  <li>Bright polished finish</li>\r\n  <li>Handles set with blue agate semi-precious cabachons</li>\r\n  <li>Supplied in lid and base box</li>\r\n  <li>&quot;the quaich&quot; story card included</li>\r\n  <li>Bowl diameter - 90mm/3.5&quot;</li>\r\n  <li>Height - 45mm/1.5&quot;</li>\r\n  <li>Handle to handle - 150mm/5.5&quot;</li>\r\n  <li>Suitable for engraving</li>\r\n</ul>', '', 11);
INSERT INTO `products_description` VALUES (404, 1, 'Pewter Hip Flask 6oz', '<ul>\r\n  <li>6oz capacity</li>\r\n  <li>Pewter flask with brass badge</li>\r\n  <li>Kidney shaped</li>\r\n  <li>Bright polished finish</li>\r\n  <li>Embossed celtic gold badge on front</li>\r\n  <li>Screw top</li>\r\n  <li>Supplied in lid and base presentation box</li>\r\n  <li>Height:100mm</li>\r\n  <li>Width:100mm</li>\r\n  <li>Depth:25mm</li>\r\n  <li>Plain back, suitable for engraving</li>\r\n</ul>', '', 16);
INSERT INTO `products_description` VALUES (405, 1, 'Pewter Scotland Hip Flask 6oz', '<ul>\r\n  <li>6oz capacity</li>\r\n  <li>Kidney shaped</li>\r\n  <li>Bright polished finish</li>\r\n  <li>Lion of Scotland design embossed on front</li>\r\n  <li>Screw top</li>\r\n  <li>Supplied in lid and base box</li>\r\n  <li>Height:100mm</li>\r\n  <li>Width:100mm</li>\r\n  <li>Depth:25mm</li>\r\n  <li>Plain back, suitable for engraving</li>\r\n</ul>', '', 20);
INSERT INTO `products_description` VALUES (406, 1, 'Pewter Thistle Hip Flask 6oz', '<ul>\r\n  <li>6oz capacity</li>\r\n  <li>Kidney shaped</li>\r\n  <li>Bright polished finish</li>\r\n  <li>Thistle design embossed on front</li>\r\n  <li>Screw top</li>\r\n  <li>Supplied in lid and base box</li>\r\n  <li>Height:100mm</li>\r\n  <li>Width:100mm</li>\r\n  <li>Depth:25mm</li>\r\n  <li>Suitable to engrave on back</li>\r\n</ul>', '', 18);
INSERT INTO `products_description` VALUES (407, 1, 'Round Pewter Gemset Flask 4oz', '<ul>\r\n  <li>4oz capacity</li>\r\n  <li>Bright polished finish</li>\r\n  <li>Cast celtic cross with semi-precious stones set into front</li>\r\n  <li>Screw top</li>\r\n  <li>Supplied in lid and base box</li>\r\n  <li>Height:95mm</li>\r\n  <li>Width:80mm</li>\r\n  <li>Depth:20mm</li>\r\n  <li>plain back, suitable for engraving</li>\r\n</ul>', '', 20);
INSERT INTO `products_description` VALUES (408, 1, 'Pewter Scotland Hip Flask 4oz', '<ul>\r\n  <li>4oz capacity</li>\r\n  <li>Bright polished finish</li>\r\n  <li>Embossed with Lion of Scotland design on front</li>\r\n  <li>Screw top</li>\r\n  <li>Supplied in lid and base box</li>\r\n  <li>Height:95mm</li>\r\n  <li>Width:80mm</li>\r\n  <li>Depth:20mm</li>\r\n  <li>Plain back, suitable for engraving</li>\r\n</ul>', '', 11);
INSERT INTO `products_description` VALUES (409, 1, 'Cake Knife', '<ul>\r\n  <li>Silver Plated</li>\r\n  <li>Supplied in presentation box</li>\r\n  <li>Length - 320mm/12.5&quot;</li>\r\n  <li>Width - 20mm/0.75&quot;</li>\r\n</ul>', '', 28);
INSERT INTO `products_description` VALUES (410, 1, 'Silver Plated Cake Knife', '<ul>\r\n  <li>Silver Plated</li>\r\n  <li>Supplied in presentation box</li>\r\n  <li>Length - 340mm/13.5&quot;</li>\r\n  <li>Width - 25mm/1&quot;</li>\r\n</ul>', '', 21);
INSERT INTO `products_description` VALUES (411, 1, 'Silver Plated Cake Knife', '<ul>\r\n  <li>Silver plated</li>\r\n  <li>Supplied in presentation box</li>\r\n  <li>Length - 320mm/13&quot;</li>\r\n  <li>Width - 21mm/0.75&quot;</li>\r\n</ul>', '', 14);
INSERT INTO `products_description` VALUES (412, 1, 'Cake Knife and Slice Set (WD400)', '', '', 2);
INSERT INTO `products_description` VALUES (413, 1, 'Silver Plated Cake Knife and Slice Set', '<ul>\r\n  <li>Silver plated</li>\r\n  <li>Supplied in presentation box</li>\r\n  <li>Length - knife 340mm/13.5&quot;  slice 260mm/10.25&quot;</li>\r\n  <li>Width - knife 25mm/1&quot; slice 60mm/2.5&quot;</li>\r\n</ul>', '', 39);
INSERT INTO `products_description` VALUES (414, 1, 'Celtic Pewter Letter Opener', '<ul>\r\n  <li>Handle features cast celtic design</li>\r\n  <li>Supplied in presentation box</li>\r\n  <li>Length - 220mm/8.75&quot;</li>\r\n  <li>Suitable for engraving</li>\r\n</ul>', '', 19);
INSERT INTO `products_description` VALUES (415, 1, 'Celtic Pewter Letter Opener', '<ul>\r\n  <li>Handle features cast celtic design</li>\r\n  <li>Supplied in presentation box</li>\r\n  <li>Length - 220mm/8.75&quot;</li>\r\n  <li>Suitable for engraving</li>\r\n</ul>', '', 34);
INSERT INTO `products_description` VALUES (416, 1, 'Celtic Pewter Letter Opener', '<ul>\r\n  <li>Handle features cast celtic design</li>\r\n  <li>Supplied in presentation box</li>\r\n  <li>Length - 220mm/8.75&quot;</li>\r\n  <li>Suitable for engraving</li>\r\n</ul>', '', 35);
INSERT INTO `products_description` VALUES (417, 1, 'Celtic Pewter Letter Opener', '<ul>\r\n  <li>Handle features cast celtic design</li>\r\n  <li>Supplied in presentation box</li>\r\n  <li>Length - 220mm/8.75&quot;</li>\r\n  <li>Suitable for engraving</li>\r\n</ul>', '', 10);
INSERT INTO `products_description` VALUES (418, 1, 'Celtic Pewter Letter Opener', '<ul>\r\n  <li>Handle features cast celtic design</li>\r\n  <li>Supplied in presentation box</li>\r\n  <li>Length - 220mm/8.75&quot;</li>\r\n  <li>Suitable for engraving</li>\r\n</ul>', '', 27);
INSERT INTO `products_description` VALUES (419, 1, 'Celtic Pewter Letter Opener', '<ul>\r\n  <li>Handle features cast celtic design</li>\r\n  <li>Supplied in presentation box</li>\r\n  <li>Length - 220mm/8.75&quot;</li>\r\n  <li>Suitable for engraving</li>\r\n</ul>', '', 19);
INSERT INTO `products_description` VALUES (420, 1, 'Compact Mirror with Pewter Disc (CEL530)', '<ul>\r\n  <li>Chrome plated</li>\r\n  <li>Celtic pewter disc on front</li>\r\n  <li>Plain back, suitable for engraving</li>\r\n  <li>Supplied in satin lined presentation box</li>\r\n  <li>Diameter - 60mm/2.25&quot;</li>\r\n  <li>Height - 14mm/0.5&quot;</li>\r\n</ul>', '', 17);
INSERT INTO `products_description` VALUES (421, 1, 'Compact Mirror with Pewter Disc (CEL531)', '<ul>\r\n  <li>Chrome plated</li>\r\n  <li>Celtic pewter disc on front</li>\r\n  <li>Plain back, suitable for engraving</li>\r\n  <li>Supplied in satin lined presentation box</li>\r\n  <li>Diameter - 60mm/2.25&quot;</li>\r\n  <li>Height - 14mm/0.5&quot;</li>\r\n</ul>', '', 36);
INSERT INTO `products_description` VALUES (422, 1, 'Compact Mirror with Pewter Disc (CEL532)', '<ul>\r\n  <li>Chrome plated</li>\r\n  <li>Celtic pewter disc on front</li>\r\n  <li>Plain back, suitable for engraving</li>\r\n  <li>Supplied in satin lined presentation box</li>\r\n  <li>Diameter - 60mm/2.25&quot;</li>\r\n  <li>Height - 14mm/0.5&quot;</li>\r\n</ul>', '', 17);
INSERT INTO `products_description` VALUES (423, 1, 'Compact Mirror with Pewter Disc (CEL533)', '<ul>\r\n  <li>Chrome plated</li>\r\n  <li>Celtic pewter disc on front</li>\r\n  <li>Plain back, suitable for engraving</li>\r\n  <li>Supplied in satin lined presentation box</li>\r\n  <li>Diameter - 60mm/2.25&quot;</li>\r\n  <li>Height 14mm/0.5&quot;</li>\r\n</ul>', '', 30);
INSERT INTO `products_description` VALUES (424, 1, 'Compact Mirror with Pewter Disc (CEL535)', '<ul>\r\n  <li>Chrome plated</li>\r\n  <li>Celtic pewter disc on front</li>\r\n  <li>Plain back, suitable for engraving</li>\r\n  <li>Supplied in satin lined presentation box</li>\r\n  <li>Diameter - 60mm/2.25&quot;</li>\r\n  <li>Height - 14mm/0.5&quot;</li>\r\n</ul>', '', 29);
INSERT INTO `products_description` VALUES (425, 1, '2.5" Pewter Quaich with Celtic Handle', '<ul>\r\n  <li>Bright polished finish</li>\r\n  <li>Celtic handles</li>\r\n  <li>Celtic band on outside of bowl</li>\r\n  <li>Quaich story information</li>\r\n  <li>Bowl diameter - 63mm/2.5&quot;</li>\r\n  <li>Height - 38mm/1.5&quot;</li>\r\n  <li>Handle to handle - 120mm/4.5&quot;</li>\r\n  <li>Supplied in presentation box</li>\r\n  <li>Suitable for engraving</li>\r\n</ul>', '', 14);
INSERT INTO `products_description` VALUES (426, 1, '3.5" Pewter Quaich with Celtic Handles', '<ul>\r\n  <li>Bright polished finish</li>\r\n  <li>Celtic handles</li>\r\n  <li>Celtic band on outside of bowl</li>\r\n  <li>Quaich story information</li>\r\n  <li>Bowl diameter - 90mm/3.5&quot;</li>\r\n  <li>Height - 50mm/2&quot;</li>\r\n  <li>Handle to handle - 140mm/5.5&quot;</li>\r\n  <li>Supplied in presentation box</li>\r\n  <li>Suitable for engraving</li>\r\n</ul>', '', 28);
INSERT INTO `products_description` VALUES (427, 1, '4" Pewter Quaich with Celtic Handles', '<ul>\r\n  <li>Bright polished finish</li>\r\n  <li>Celtic handles</li>\r\n  <li>Celtic band on outside of bowl</li>\r\n  <li>Quaich story information</li>\r\n  <li>Bowl diameter - 100mm/4&quot;</li>\r\n  <li>Height - 45mm/1.75&quot;</li>\r\n  <li>Handle to handle - 175mm/7&quot;</li>\r\n  <li>Supplied in presentation box</li>\r\n  <li>Suitable for engraving</li>\r\n</ul>', '', 19);
INSERT INTO `products_description` VALUES (428, 1, '4.5" Pewter Quaich with Celtic Handles', '<ul>\r\n  <li>Bright polished finish</li>\r\n  <li>Celtic handles</li>\r\n  <li>Celtic band on outside of bowl</li>\r\n  <li>Quaich story information</li>\r\n  <li>Bowl diameter - 115mm/4.5&quot;</li>\r\n  <li>Height - 50mm/2&quot;</li>\r\n  <li>Handle to handle - 190mm/7.5&quot;</li>\r\n  <li>Supplied in presentation box</li>\r\n  <li>Suitable for engraving</li>\r\n</ul>', '', 11);
INSERT INTO `products_description` VALUES (429, 1, '2.5" Pewter Quaich with Thistle Handles', '<ul>\r\n  <li>Bright Polished finish</li>\r\n  <li>Thistle handles</li>\r\n  <li>Celtic band on outside of bowl</li>\r\n  <li>Quaich story information</li>\r\n  <li>Bowl diameter - 63mm/2.5&quot;</li>\r\n  <li>Height - 38mm/1.5&quot;</li>\r\n  <li>Handle to handle - 125mm/4.75&quot;</li>\r\n  <li>Supplied in presentation box</li>\r\n  <li>Suitable for engraving</li>\r\n</ul>', '', 56);
INSERT INTO `products_description` VALUES (430, 1, '3" Pewter Quaich with Thistle Handles', '<ul>\r\n  <li>Bright polished finish</li>\r\n  <li>Thistle handles</li>\r\n  <li>Celtic band on outside of bowl</li>\r\n  <li>Quaich story information</li>\r\n  <li>Bowl diameter - 75mm/3&quot;</li>\r\n  <li>Height - 40mm/1.5&quot;</li>\r\n  <li>Handle to handle - 140mm/5.5&quot;</li>\r\n  <li>Supplied in presentation box</li>\r\n  <li>Suitable for engraving</li>\r\n</ul>', '', 18);
INSERT INTO `products_description` VALUES (431, 1, '3.5" Pewter Quaich with Thistle Handles', '<ul>\r\n  <li>Bright polished finish</li>\r\n  <li>Thistle handles</li>\r\n  <li>Celtic band on outside of bowl</li>\r\n  <li>Quaich story information</li>\r\n  <li>Bowl diameter - 88mm/3.5&quot;</li>\r\n  <li>Height - 45mm/1.75&quot;</li>\r\n  <li>Handle to handle - 150mm/6&quot;</li>\r\n  <li>Supplied in presentation box</li>\r\n  <li>Suitable for engraving</li>\r\n</ul>', '', 33);
INSERT INTO `products_description` VALUES (432, 1, '4" Pewter Quaich with Thistle Handles', '<ul>\r\n  <li>Bright polished finish</li>\r\n  <li>Thistle handles</li>\r\n  <li>Celtic band on outside of bowl</li>\r\n  <li>Quaich story information</li>\r\n  <li>Bowl diameter - 100mm/4&quot;</li>\r\n  <li>Height - 45mm/1.75&quot;</li>\r\n  <li>Handle to handle - 180mm/7&quot;</li>\r\n  <li>Supplied in presentation box</li>\r\n  <li>Suitable for engraving</li>\r\n</ul>', '', 43);
INSERT INTO `products_description` VALUES (433, 1, '2.5" Quaich', '', '', 3);
INSERT INTO `products_description` VALUES (434, 1, '3.5"  Quaich (PQ302)', '', '', 1);
INSERT INTO `products_description` VALUES (435, 1, '4.5"  Quaich (PQ303)', '', '', 1);
INSERT INTO `products_description` VALUES (436, 1, 'Pewter Golf Hip Flask 6oz (TSF602)', '<ul>\r\n  <li>6oz capacity</li>\r\n  <li>Bright polished finish</li>\r\n  <li>Golfing design on front</li>\r\n  <li>Plain back, suitable for engraving</li>\r\n  <li>Screw top</li>\r\n  <li>Supplied in presentation box</li>\r\n  <li>Height - 110mm/4.25&quot;</li>\r\n  <li>Width - 90mm/3.5&quot;</li>\r\n  <li>Depth - 20mm/0.75&quot;</li>\r\n</ul>', '', 21);
INSERT INTO `products_description` VALUES (437, 1, 'Pewter Thistle Hip Flask 6oz (TSF603)', '<ul>\r\n  <li>6oz capacity</li>\r\n  <li>Bright polished finish</li>\r\n  <li>Thistle design on front</li>\r\n  <li>Plain back, suitable for engraving</li>\r\n  <li>Screw top</li>\r\n  <li>Supplied in presentation box</li>\r\n  <li>Height - 110mm/4.25&quot;</li>\r\n  <li>Width - 90mm/3.5&quot;</li>\r\n  <li>Depth - 20mm/0.75&quot;</li>\r\n</ul>', '', 33);
INSERT INTO `products_description` VALUES (438, 1, 'Pewter Scottish Piper Hip Flask 6oz (TSF604)', '<ul>\r\n  <li>6oz capacity</li>\r\n  <li>Bright polished finish</li>\r\n  <li>Scottish piper design on front</li>\r\n  <li>Plain back, suitable for engraving</li>\r\n  <li>Screw top</li>\r\n  <li>Supplied in presentation box</li>\r\n  <li>Height - 110mm/4.25&quot;</li>\r\n  <li>Width - 90mm/3.5&quot;</li>\r\n  <li>Depth - 20mm/0.75&quot;</li>\r\n</ul>', '', 34);
INSERT INTO `products_description` VALUES (439, 1, 'Pewter shooting Hip Flask 6oz', '<ul>\r\n  <li>6oz capacity</li>\r\n  <li>Bright polished finish</li>\r\n  <li>Shooting scene design on front</li>\r\n  <li>Plain back, suitable for engraving</li>\r\n  <li>Screw top</li>\r\n  <li>Supplied in presentation box</li>\r\n  <li>Height - 110mm/4.25&quot;</li>\r\n  <li>Width - 90mm/3.5&quot;</li>\r\n  <li>Depth - 20mm/0.75&quot;</li>\r\n</ul>', '', 18);
INSERT INTO `products_description` VALUES (440, 1, 'Pewter fishing Hip Flask 6oz', '<ul>\r\n  <li>6oz capacity</li>\r\n  <li>Bright polished finish</li>\r\n  <li>Fishing scene on front</li>\r\n  <li>Plain back, suitable for engraving</li>\r\n  <li>Screw top</li>\r\n  <li>Supplied in presentation box</li>\r\n  <li>Height - 110mm/4.25&quot;</li>\r\n  <li>Width - 90mm/3.5&quot;</li>\r\n  <li>Depth - 20mm/0.75&quot;</li>\r\n</ul>', '', 44);
INSERT INTO `products_description` VALUES (441, 1, 'Pewter Scotland Hip Flask 6oz', '<ul>\r\n  <li>6oz capacity</li>\r\n  <li>Bright polished finish</li>\r\n  <li>Scottish lion and text</li>\r\n  <li>Plain back, suitable for engraving</li>\r\n  <li>Screw top</li>\r\n  <li>Supplied in presentation box</li>\r\n  <li>Height - 110mm/4.25&quot;</li>\r\n  <li>Width - 90mm/3.5&quot;</li>\r\n  <li>Depth - 20mm/0.75&quot;</li>\r\n</ul>', '', 32);
INSERT INTO `products_description` VALUES (442, 1, 'Pewter fishing Hip Flask 6oz', '<ul>\r\n  <li>6oz capacity</li>\r\n  <li>Kidney shaped</li>\r\n  <li>bright polished finish</li>\r\n  <li>Fishing design on front</li>\r\n  <li>Plain back, suitable for engraving</li>\r\n  <li>Screw top</li>\r\n  <li>Supplied in presentation box</li>\r\n  <li>Height - 100mm/4&quot;</li>\r\n  <li>Width - 80mm/3.25&quot;</li>\r\n  <li>Depth - 25mm/1&quot;</li>\r\n</ul>', '', 32);
INSERT INTO `products_description` VALUES (443, 1, 'Pewter Rugby Hip Flask 6oz', '<ul>\r\n  <li>6oz capacity</li>\r\n  <li>Kidney shaped</li>\r\n  <li>Bright Polished finish</li>\r\n  <li>Rugby design on front</li>\r\n  <li>Plain back, suitable for engraving</li>\r\n  <li>Screw top</li>\r\n  <li>Supplied in presentation box</li>\r\n  <li>Height - 100mm/4&quot;</li>\r\n  <li>Width - 80mm/3.25&quot;</li>\r\n  <li>Depth - 25mm/1&quot;</li>\r\n</ul>', '', 50);
INSERT INTO `products_description` VALUES (444, 1, 'Pewter Football Hip Flask 6oz', '<ul>\r\n  <li>6oz capacity</li>\r\n  <li>Kidney shaped</li>\r\n  <li>Bright Polished finish</li>\r\n  <li>Football design on front</li>\r\n  <li>Plain back, suitable for engraving</li>\r\n  <li>Screw top</li>\r\n  <li>Supplied in presentation box</li>\r\n  <li>Height - 100mm/4&quot;</li>\r\n  <li>Width - 80mm/3.25&quot;</li>\r\n  <li>Depth - 25mm/1&quot;</li>\r\n</ul>', '', 18);
INSERT INTO `products_description` VALUES (445, 1, 'Hip Flask (CEL487)', '', '', 1);
INSERT INTO `products_description` VALUES (446, 1, 'Hip Flask (CEL488)', '', '', 1);
INSERT INTO `products_description` VALUES (447, 1, 'Hip Flask (CEL489)', '', '', 1);
INSERT INTO `products_description` VALUES (386, 1, 'Ladies Silver Plated Charmed by Accurist watch - Daisy', 'Ladies silver plated charmed watch with elegant mother of pearl dial and decorative stoppers, with bezel featuring simple petal motif.  Add beads or charms from any of the leading brands and create your own unique timepiece. Four stopper beads included.', '', 32);
INSERT INTO `products_description` VALUES (387, 1, 'Ladies Silver Plated Charmed by Accurist Watch (Crystal Row)', 'Ladies silver plated charmed watch with elegant mother of pearl dial and decorative Swarovski crystal set bezel and stoppers.\r\nAdd beads or charms from any of the leading brands and create your own timepiece. Four stopper beads included.', '', 50);
INSERT INTO `products_description` VALUES (461, 1, 'Gents Accurist Gold Plated Leather Strap Quartz Watch', '', '', 8);
INSERT INTO `products_description` VALUES (462, 1, 'Gents Accurist Gold Plated Leather Strap Quartz Watch', '', '', 13);
INSERT INTO `products_description` VALUES (463, 1, 'Ladies Accurist Gold Plated Quartz Watch', '', '', 17);
INSERT INTO `products_description` VALUES (464, 1, 'Ladies Accurist Stainless Steel Quartz Watch', '', '', 8);
INSERT INTO `products_description` VALUES (465, 1, 'Ladies Accurist Gold Plated Quartz Leather Strap Watch', '', '', 19);
INSERT INTO `products_description` VALUES (466, 1, 'Ladies Accurist Gold Plated Quartz Leather Strap Watch', '', '', 10);
INSERT INTO `products_description` VALUES (467, 1, 'Ladies Accurist Gold Plated Quartz Watch', '', '', 7);
INSERT INTO `products_description` VALUES (468, 1, 'Ladies Accurist Stainless Steel Quartz Watch', '', '', 7);
INSERT INTO `products_description` VALUES (469, 1, 'Ladies Accurist Stainless Steel Quartz Watch', '', '', 13);
INSERT INTO `products_description` VALUES (470, 1, 'Ladies Accurist Gold Plated Quartz Watch', '', '', 16);
INSERT INTO `products_description` VALUES (471, 1, 'Ladies Accurist Stainless Steel Quartz Watch', '', '', 9);
INSERT INTO `products_description` VALUES (472, 1, 'Ladies Accurist Gold Plated Expanding Bracelet Quartz  Watch', '', '', 20);
INSERT INTO `products_description` VALUES (473, 1, 'Ladies Accurist Stainless Steel Expanding Bracelet Quartz  Watch', '', '', 18);
INSERT INTO `products_description` VALUES (474, 1, 'Ladies Accurist Two Tone Quartz Watch', '', '', 3);
INSERT INTO `products_description` VALUES (475, 1, 'Ladies Accurist Gold Plated Quartz Watch', '', '', 14);
INSERT INTO `products_description` VALUES (476, 1, 'Ladies Accurist Stainless Steel Quartz Watch', '', '', 17);
INSERT INTO `products_description` VALUES (477, 1, 'Ladies Silver Plated Charmed by Accurist (Starlight) Watch', 'Ladies silver plated charmed watch with ''Pave'' dial set with Swarovski elements.  \r\nCreate your unique timepiece  by adding charms or beads from any of the leading brands. Four stopper beads included.', '', 35);
INSERT INTO `products_description` VALUES (478, 1, 'Gents Accurist Stainless Steel Chronograph Watch', '', '', 31);
INSERT INTO `products_description` VALUES (479, 1, 'Gents Accurist Stainless Steel Chronograph Watch', '', '', 7);
INSERT INTO `products_description` VALUES (480, 1, 'Gents Accurist Black Stainless Steel Chronograph Watch', '', '', 20);
INSERT INTO `products_description` VALUES (492, 1, '9ct White and Yellow Gold Fancy Cubic Zirconia Earring', 'These cubic zirconia set stud earrings are for pierced ears with a post and butterfly fitting. There are 4 round cubic zirconia stones in each earring which is set in white and yellow gold.\r\nLength - 12.6mm\r\nWidth - 5.6mm', '', 11);
INSERT INTO `products_description` VALUES (490, 1, 'Sterling Silver Abstract Double Heart Pendant', 'This heart pendant a small polished heart and a brushed effect larger heart and sits on a 45cm/18" chain with a 5cm extender', '', 16);
INSERT INTO `products_description` VALUES (482, 1, 'Gents Accurist Stainless Steel Diamond Quartz Watch', '', '', 16);
INSERT INTO `products_description` VALUES (484, 1, 'Gents Accurist Stainless Steel Quartz Watch', '', '', 26);
INSERT INTO `products_description` VALUES (485, 1, 'Gents Accurist Stainless Steel Quartz Watch', '', '', 22);
INSERT INTO `products_description` VALUES (486, 1, 'Gents Accurist Gold Plated Leather Strap Quartz Watch', '', '', 14);
INSERT INTO `products_description` VALUES (487, 1, 'Ladies Accurist Gold Plated Quartz Watch', '', '', 7);
INSERT INTO `products_description` VALUES (488, 1, 'Ladies Accurist Stainless Steel Quartz Watch', '', '', 6);
INSERT INTO `products_description` VALUES (493, 1, '9ct White and Yellow Gold Fancy Stud Earring', 'This round open design white and yellow gold stud earring are for pierced ears with a post and butterfly fitting. \r\nDiameter - 7.8mm', '', 7);
INSERT INTO `products_description` VALUES (494, 1, '9ct Yellow Gold Opal Stud Earring', 'This beautiful marquise cut opal stud earring has a post and butterfly fitting which is for pierced ears.\r\nLength - 12.85mm\r\nWidth - 6.3mm', '', 8);
INSERT INTO `products_description` VALUES (495, 1, '9ct White and Yellow Gold Fancy Cubic Zirconia Earring', 'This 9ct white and yellow gold flower design stud earring has two small round cubic zirconia stones and comes with a post and butterfly fitting.\r\nLength - 10.45mm\r\nWidth - 10.23mm', '', 0);
INSERT INTO `products_description` VALUES (496, 1, '9ct White and Yellow Gold Fancy Stud Earring', 'This two colour round stud earring has a post and butterfly fitting suitable for pierced ears.\r\nDiameter - 9.5mm', '', 3);
INSERT INTO `products_description` VALUES (497, 1, '9ct White and Yellow Gold Fancy Diamond Stud Earring', 'This 9ct gold diamond stud earring has one diamond in each earring which is set in white gold and is suitable for pierced ears.\r\nLength - 11mm\r\nWidth - 5.9mm', '', 20);
INSERT INTO `products_description` VALUES (498, 1, '9ct White and Yellow Gold Oval Stud Earring', 'A stylish and elegant stud earring set with open oval two colour gold design, suitable for pierced ears.\r\nLength - 11.3mm\r\nWidth - 8.8mm', '', 4);
INSERT INTO `products_description` VALUES (499, 1, '9ct Gold Fancy Stud Earring', 'This oval open design stud earring is suitable for pierced ears.\r\nLength - 11.2mm\r\nWidth - 10mm', '', 7);
INSERT INTO `products_description` VALUES (500, 1, '9ct White and Yellow Gold Knot Stud Earring', 'A beautiful knot style two colour earring which is suitable for pierced ears.\r\nDiameter - 8.25mm', '', 23);
INSERT INTO `products_description` VALUES (501, 1, '9ct White and Yellow Gold Fancy Stud Earring', 'A classy oval two colour stud earring suitable for pierced ears.\r\nLength - 8mm\r\nwidth - 5.7mm', '', 3);
INSERT INTO `products_description` VALUES (502, 1, '9ct White and Yellow Gold Knot Stud Earring', 'An elagant two colour knot design stud earring, suitable for pierced ears.\r\nDiameter - 6.1mm', '', 8);
INSERT INTO `products_description` VALUES (503, 1, '9ct White Gold Cubic Zirconia Pendant', 'A beautiful 9ct white gold swirl design pendant with one cubic zirconia set at the bottom of the pendant.\r\nPendant Length - 16mm \r\nWidth - 8mm', '', 1);
INSERT INTO `products_description` VALUES (504, 1, '9ct White Gold Round Pendant with Diamonds', 'This beautiful round swirl design pendant has 10 small diamonds in a pave style setting. Diameter of pendant - 12.2mm', '', 6);
INSERT INTO `products_description` VALUES (505, 1, '9ct White Gold Sapphire and Diamond Heart Pendant', 'This beautiful heart pendant has 3 round sapphires surrounded by 26 round diamonds. \r\n Pendant measures 8.9mm long (excluding loop) 9.8mm wide.', '', 8);
INSERT INTO `products_description` VALUES (506, 1, '9ct White Gold Cubic Zirconia Figure of Eight Pendant', 'This classy white gold pendant has 29 cubic zirconia stones and measures, length - 26.8mm and 9mm wide.', '', 8);
INSERT INTO `products_description` VALUES (507, 1, '9ct White Gold Cubic Zirconia Pendant', 'This stunning white gold pendant has 11 cubic zirconia stones and measures 22.8mm long including the loop and 6.7mm wide.', '', 3);
INSERT INTO `products_description` VALUES (508, 1, '9ct White Gold Diamond Tear Drop Pendant', 'A small but beautiful white gold tear drop pendant with 9 round diamonds in a pave setting. Pendant measures 13mm including loop and 5.5mm wide.', '', 6);
INSERT INTO `products_description` VALUES (509, 1, '9ct White Gold Cubic Zirconia Pendant', 'A stunning twisted white gold pendant with 17 cubic zirconia stones. The pendant measures 20mm long and 6.2mm wide.', '', 4);
INSERT INTO `products_description` VALUES (510, 1, '9ct White Gold Heart Shaped Pendant', 'This fashionable offset white gold heart shaped pendant has 16 cubic zirconia stones cleverly set on one side. Pendant measures 19.5mm including loop and 13.5mm wide', '', 3);
INSERT INTO `products_description` VALUES (511, 1, '9ct White Gold Cubic Zirconia Pendant', 'A beautifully designed white gold pendant which has cubic zirconia stones in a pave setting at the bottom of an open pendant. Pendant measures 25.8mm including loop and 9.5mm wide.', '', 3);
INSERT INTO `products_description` VALUES (512, 1, '9ct Yellow Gold 4 Cubic Zirconia Pendant', 'A classic 4 cubic zirconia stone pendant with the stones gradually increasing in size. Pendant measures 26mm including loop and 6.2mm wide.', '', 4);
INSERT INTO `products_description` VALUES (513, 1, '9ct Yellow Gold Cubic Zirconia Pendant', 'An elegant yellow gold pendant with 6 cubic zirconia stones. Pendant measures 27mm including loop and 7.9mm wide.', '', 1);
INSERT INTO `products_description` VALUES (514, 1, '9ct Yellow Gold Cubic Zirconia Pendant', 'This diamond shape yellow gold pendant has 9 cubic zirconia stones i a claw setting.  Pendant measures 15.7mm including loop and 7.1mm wide.', '', 4);
INSERT INTO `products_description` VALUES (515, 1, '9ct Yellow Gold Opal Pendant', 'Beautiful designed yellow gold pendant with a 9mm x 4mm marquise opal. Pendant measures 18.2mm long and 6.1mm wide.', '', 6);
INSERT INTO `products_description` VALUES (516, 1, '9ct Yellow Gold Pave set Cubic Zirconia Pendant', 'This enticing oval swirl pendant has 15 cubic zirconia stones in a pave setting and is 14.4mm in length and 10.4mm wide.', '', 6);
INSERT INTO `products_description` VALUES (517, 1, '9ct White Gold Diamond Heart Shaped Pendant', 'This modern offset heart shaped white gold pendant has 5 diamonds in a pave setting. Pendant measures 24.7mm long and 13.2mm wide.', '', 1);
INSERT INTO `products_description` VALUES (518, 1, 'Lime Green Foil Glass Bead', 'Compatible with Pandora, Chamilia and trollbeads. Lime green glass bead with solid sterling silver core.', '', 15);
INSERT INTO `products_description` VALUES (519, 1, 'Tortoise Shell Glass Bead', 'Compatible with all major charm bracelets including Pandora, Chamilia and Trollbeads. Tortoise glass bead with sterling silver core.', '', 16);
INSERT INTO `products_description` VALUES (520, 1, 'Sterling Silver Friends Charm Bead', 'This silver Friend charm is suitable for use with all the major charm bracelets including Pandora, Chamilia and trollbeads.', '', 16);
INSERT INTO `products_description` VALUES (521, 1, 'Sterling Silver I Love To Shop Charm Bead', 'This silver I love To Shop charm is suitable for use with all the major charm bracelets including Pandora, Chamilia and Trollbeads', '', 20);
INSERT INTO `products_description` VALUES (522, 1, 'Sterling Silver Cocktail Glass Charm Bead', 'This silver cocktail glass charm is suitable for use with all the major charm bracelets including Pandora, Chamilia and Trollbeads.', '', 22);
INSERT INTO `products_description` VALUES (523, 1, 'Sterling Silver Handbag Charm Bead', 'This silver handbag charm is suitable for use with all the major charm bracelets including Pandora Chamilia and Trollbeads.', '', 13);
INSERT INTO `products_description` VALUES (524, 1, 'Sterling Silver Clear Stones Charm Bead', 'This silver clear stone charm is suitable for use with all major charm bracelets including Pandora, Chamilia and Trollbeads.', '', 19);
INSERT INTO `products_description` VALUES (525, 1, 'Sterling Silver Dice Charm Bead', 'This silver dice charm is suitable for use with all major charm bracelets including Pandora, Chamilia and Trollbeads.', '', 12);
INSERT INTO `products_description` VALUES (526, 1, 'Coral Striped Glass Bead', 'Compatible with all major charm bracelets including Pandora, Chamilia and Trollbeads. Red glass bead with solid sterling silver core.', '', 20);
INSERT INTO `products_description` VALUES (527, 1, 'Lilac and White Glass Bead', 'Compatible with all major charm bracelets inluding Pandora, Chamilia and Trollbeads. Sterling silver core.', '', 7);
INSERT INTO `products_description` VALUES (528, 1, 'Light Blue and White Glass Bead', 'Compatible with all major charm bracelets including Pandora, Chamilia and Trollbeads. Sterling silver core.', '', 14);
INSERT INTO `products_description` VALUES (529, 1, 'Multi coloured Foil Glass Bead', 'Compatible with all the major charm bracelets including Pandora, Chamilia and Trollbeads.  A mixture of colours run through this glass bead, there is a sterling silver core that runs through the centre.', '', 21);
INSERT INTO `products_description` VALUES (530, 1, 'White and Pink Flower Glass Bead', 'Compatible with all major charm bracelets including Pandora, Chamilia and Trollbeads.White and pink flower glass beadwith solid sterling silver core.', '', 19);
INSERT INTO `products_description` VALUES (531, 1, '', '', '', 4);
INSERT INTO `products_description` VALUES (532, 1, 'Sterling Silver CRM Bangle', 'This silver ladies Charles Rennie Mackintosh bangle is 67.5mm wide and 6.2mm in depth, it weighs 12.6 grams', '', 8);
INSERT INTO `products_description` VALUES (533, 1, 'Sterling Silver Open Link Heart Charm Bracelet', 'This open link silver bracelet measures 17.5cm long and has a 2.5cm extender. Total Weight 7.2 grams.', '', 8);
INSERT INTO `products_description` VALUES (534, 1, 'Sterling Silver Open Disc Cluster Necklet', 'This silver necklet measures 41cm with a 5cm extender and weighs 5.7 grams.', '', 19);
INSERT INTO `products_description` VALUES (537, 1, 'Sterling Silver Cross Over Heart Drop Charm Bead', 'This silver cross over heart drop bead is suitable for use with all the major charm bracelets including Pandora, Chamilia and Trollbeads.', '', 9);
INSERT INTO `products_description` VALUES (538, 1, 'Sterling Silver Heart & Swirl Rubber Stopper Charm Bead', 'This silver stopper has an internal rubber ring that grips the bracelet to position the beads, not suitable for bracelets with bar sections.', '', 16);
INSERT INTO `products_description` VALUES (539, 1, 'Sterling Silver Silicone Stopper', 'This plain silver silicone stopper has an internal silicone ring that grips the bracelet to position the beads, not suitable for bracelets with bar sections.', '', 8);
INSERT INTO `products_description` VALUES (540, 1, 'Sterling Silver Rubber Stopper With Ridges', 'This silver stopper has an internal rubber ring that grips the bracelet to position the beads, not suitable for bracelets with bar sections.', '', 16);
INSERT INTO `products_description` VALUES (541, 1, 'Sterling Silver Raised Pattern Rubber Stopper Charm', 'This silver stopper has an internal rubber ring that grips the bracelet to position the beads, not suitable for bracelets with bar sections.', '', 8);
INSERT INTO `products_description` VALUES (542, 1, 'Sterling Silver Gingerbread Man Charm Bead', 'This silver gingerbread man charm is suitable for use with all the major charm bracelets including Pandora, Chamilia and Trollbeads.', '', 5);
INSERT INTO `products_description` VALUES (543, 1, 'Sterling Silver 21st Birthday Charm Bead', 'This 21st birthday charm is suitable for all the major charm bracelets including Pandora, Chamilia and Trollbeads.', '', 10);
INSERT INTO `products_description` VALUES (544, 1, 'Sterling Silver 16th Birthday Charm Bead', 'This silver 16th birthday charm is suitable for all the major charm bracelets including Pandora, Chamilia and Trollbeads.', '', 8);
INSERT INTO `products_description` VALUES (545, 1, 'Sterling Silver Rocking Horse Charm Bead', 'This silver rocking horse charm is suitable for all the major charm bracelets including Pandora, Chamilia and Trollbeads.', '', 4);
INSERT INTO `products_description` VALUES (546, 1, 'Sterling Silver Oxidised Star Pattern Charm Bead', 'This oxidised star patterened charm is suitable for all the major charm bracelets including Pandora, Chamilia and Trollbeads.', '', 4);
INSERT INTO `products_description` VALUES (547, 1, 'Sterling Silver Oxidised Swirl Charm Bead', 'This silver oxidised swirl charm is suitable for all the major charm bracelets including Pandora, Chamilia and Trollbeads.', '', 4);
INSERT INTO `products_description` VALUES (548, 1, 'Sterling Silver Ethnic Style Charm Bead', 'This silver ethnic style charm is suitable for all major charm bracelets including Pandora, Chamilia and Trollbeads.', '', 6);
INSERT INTO `products_description` VALUES (549, 1, '9ct Yellow Gold Pearl and Cubic Zirconia Pendant', 'A yellow gold pearl pendant with a modern design, the pearl measures 7mm and the pendant measures 17.5mm long and 7mm wide.', '', 6);
INSERT INTO `products_description` VALUES (550, 1, '9ct White Gold Pearl and Cubic Zirconia Stud Earring', 'A beautiful white gold stud earring, frehwater pearl measures 6.6mm and the earring measures 9.1mm.', '', 22);
INSERT INTO `products_description` VALUES (551, 1, 'Mint Green Foil Glass Bead', 'Compatible with all major charm bracelets including Pandora, Chamilia and Trollbeads. Sterling silver core runs through the centre.', '', 5);
INSERT INTO `products_description` VALUES (552, 1, 'Pink Flower Glass Charm Bead', 'Compatible with all major charm bracelets including Pandora, Chamilia and Trollbeads. Sterling silver core runs through the centre.', '', 4);
INSERT INTO `products_description` VALUES (553, 1, 'Montana Crystal Bead', 'Compatible with all major charm bracelets including Pandora, Chamilia and Trollbeads. There is a sterling silver core which runs through the centre.', '', 5);
INSERT INTO `products_description` VALUES (554, 1, 'Aqua Striped Glass Bead', 'Compatible with all major charm bracelets including Pandora, Chamilia and Trollbeads. Ther is a sterling silver core which runs throgh the middle.', '', 3);
INSERT INTO `products_description` VALUES (555, 1, 'Hot Pink Striped Glass Bead', 'Compatible with all major charm bracelets including Pandora, Chamilia and Trollbeads. There is a sterling silver core which runs though the middle.', '', 4);
INSERT INTO `products_description` VALUES (556, 1, 'Black and White Swirl Glass Bead', 'Compatible with all major charm bracelets including Pandora, Chamilia and Trollbeads. Ther is a sterling silver core which runs through the middle.', '', 6);
INSERT INTO `products_description` VALUES (557, 1, 'Pink Rose Glass Bead', 'Compatible with all major charm bracelets including Pandora, Chamilia and Trollbeads. There is a sterling silver core which runs through the middle.', '', 4);
INSERT INTO `products_description` VALUES (558, 1, 'White and Pink Polka Dot Bead', 'Compatible with all major charm bracelets including Pandora, Chamilia and Trollbeads. There is a sterling silver core which runs through the middle.', '', 4);
INSERT INTO `products_description` VALUES (559, 1, 'Pink Floral Glass Bead', 'Compatible with all major charm bracelets including Pandora, Chamilia and Trollbeads. There is a sterling silver core which runs through the middle.', '', 4);
INSERT INTO `products_description` VALUES (560, 1, 'Metalic Crystal Faceted Bead', 'Compatible with all major charm bracelets including Pandora, Chamilia and Trollbeads. There is a sterling silver core which runs through the middle.', '', 4);
INSERT INTO `products_description` VALUES (561, 1, 'Blue with White Spots Glass Bead', 'Compatible with all major charm bracelets including Pandora, Chamilia and Trollbeads. There is a sterling silver core which runs through the middle.', '', 5);
INSERT INTO `products_description` VALUES (562, 1, 'Dusty Pink Faceted Bead', 'Compatible with all major charm bracelets including Pandora, Chamilia and Trollbeads. There is a sterling silver core which runs through the middle.', '', 4);
INSERT INTO `products_description` VALUES (563, 1, 'Light Pink Crystal Faceted Bead', 'Compatible with all major charm bracelets including Pandora, Chamilia and Trollbeads. There is a sterling silver core which runs through the middle.', '', 3);
INSERT INTO `products_description` VALUES (564, 1, 'Lavender Crystal Faceted Bead', 'Compatible with all major charm bracelets including Pandora, Chamilia and Trollbeads. Ther is a sterling silver core which runs through the middle.', '', 4);
INSERT INTO `products_description` VALUES (565, 1, 'Red/Silver Foil Glass Bead', 'Compatible with all major charm bracelets including Pandora, Chamilia and Trollbeads. There is a sterling silver core which runs through the middle.', '', 5);
INSERT INTO `products_description` VALUES (566, 1, 'Black/Silver Foil Glass Bead', 'Compatible with all major charm bracelets including Pandora, Chamilia and Trollbeads. There is a sterling silver core which runs through the middle.', '', 6);
INSERT INTO `products_description` VALUES (567, 1, 'Green/Silver Foil Glass Bead', 'Compatible with all major charm bracelets including Pandora, Chamilia and trollbeads. There is a sterling silver core which runs through the middle.', '', 6);
INSERT INTO `products_description` VALUES (568, 1, 'Blue/Silver Foil Glass Bead', 'Compatible with all major charm bracelets including Pandora, Chamilia and Trollbeads. There is a sterling silver Core which runs through the middle.', '', 7);
INSERT INTO `products_description` VALUES (569, 1, 'Red and Pink Rose Glass Bead', 'Compatible with all major charm bracelets including Pandora, Chamilia and Trollbeads. There is a sterling silver core which runs through the middle.', '', 3);
INSERT INTO `products_description` VALUES (570, 1, 'Pink Crystal Charm Bead', 'Compatible with all major charm bracelets including Pandora, Chamilia and Trollbeads. There is a sterling silver core which runs through the middle.', '', 5);
INSERT INTO `products_description` VALUES (571, 1, 'Aqua Crystal Charm Bead', 'Compatible with all major charm bracelets including Pandora, Chamilia and Trollbeads. There is a sterling silver core which runs through the middle.', '', 14);
INSERT INTO `products_description` VALUES (572, 1, 'Sterling Silver Cubic Zirconia Stud Earrings', 'This silver cubic zirconia is for pierced ears and measures 5.2mm in diameter. Total weight 0.8 grams.', '', 2);
INSERT INTO `products_description` VALUES (573, 1, '9ct Yellow Gold Flat knot Style Stud Earring', 'This traditional gold earring has a flat wool mark appearance and measures 7.7mm.', '', 18);
INSERT INTO `products_description` VALUES (574, 1, '9ct Yellow Gold Plain Stud Earring', 'This plain gold stud earring has a curved profile and measures 7.9mm long and 5.1mm wide. Weight 0.62 grams', '', 6);
INSERT INTO `products_description` VALUES (575, 1, '9ct Yellow Gold Star Stud Earrings', 'This gold polished star earring measures 8.6mm and a total weight of 0.49 grams.', '', 24);
INSERT INTO `products_description` VALUES (576, 1, '9ct Yellow Gold Open Ridge Stud Earring', 'A stylish 9ct gold open ridged polished stud earring. Dimensions - Length 13mm, Width 5.5mm and weighs a total of 0.77 grams', '', 11);
INSERT INTO `products_description` VALUES (577, 1, '9ct Yellow Gold Polished and Satin Stud Earring', 'This elegant 9ct gold polished and satin stud earring measures 8.5mm long and 4.2mm wide. Total weight 0.71 grams', '', 11);
INSERT INTO `products_description` VALUES (578, 1, '9ct Yellow Gold Stud Earring', 'This 9ct gold 4 point diamond cut star earring measures 6.8mm and has a total weight of 0.38 grams', '', 10);
INSERT INTO `products_description` VALUES (579, 1, 'Sterling Silver Organic Curved Link Bracelet', 'This polished silver curved link bracelet measures 18.5cm long, 5.8mm wide and weighs 10 grams.', '', 19);
INSERT INTO `products_description` VALUES (580, 1, 'Sterling Silver CRM Bracelet', 'A stylish silver Charles Rennie Mackintosh style bracelet which measures 18cm long and 5.3mm wide. total weight 5.7 grams.', '', 16);
INSERT INTO `products_description` VALUES (581, 1, 'Emerald Green Foil Glass Bead', 'Compatible with all major charm bead bracelets including Pandora, Chamilia and Trollbeads. There is a sterling silver core which runs through the middle.', '', 19);
INSERT INTO `products_description` VALUES (582, 1, 'Sterling Silver Elephant Charm Bead', 'This sterling silver elephant charm is suitable for all major charm bracelets including Pandora, Chamilia and Trollbeads.', '', 10);
INSERT INTO `products_description` VALUES (583, 1, 'Sterling Silver Cubic Zirconia Design Charm Bead', 'This silve cubic zirconia charm is suitable for all major charm bracelets including Pandora, Chamilia and Trollbeads.', '', 9);
INSERT INTO `products_description` VALUES (584, 1, 'sterling Silver Plain Heart Charm Bead', 'This silver plain heart charm is suitable for all major charm bracelets including Pandora, Chamilia and Trollbeads.', '', 18);
INSERT INTO `products_description` VALUES (585, 1, 'Sterling Silver Multi Flower Pattern Charm Bead', 'Compatible with all major charm bracelets including Pandora, Chamilia and Trollbeads.', '', 9);
INSERT INTO `products_description` VALUES (586, 1, 'Sterling Silver Daughter Charm Bead', 'Compatible with all major charm bracelets including Pandora, Chamilia and trollbeads.', '', 21);
INSERT INTO `products_description` VALUES (587, 1, 'Sterling Silver Sister Charm Bead', 'Compatible with all major charm bracelets including Pandora, Chamilia and Trollbeads.', '', 12);
INSERT INTO `products_description` VALUES (588, 1, 'Sterling Silver I love You Charm Bead', 'Compatible with all major charm bracelets including Pandora, Chamilia and Trollbeads.', '', 9);
INSERT INTO `products_description` VALUES (589, 1, 'sterling Silver Horse Head Charm Bead', 'Compatible with all major charm bracelets including Pandora, Chamilia and Trollbeads.', '', 11);
INSERT INTO `products_description` VALUES (590, 1, 'Sterling Silver Stiletto Charm Bead', 'Compatible with all major charm bracelets including Pandora, Chamilia and Trollbeads.', '', 8);
INSERT INTO `products_description` VALUES (591, 1, 'Sterling Silver 19cm Charm Bead Bracelet', 'This silver pandora style bracelet measures 19cm/7.5" it can carry any of the glass and silver charm beads on this website but is not compatible with rubber stoppers.', '', 27);
INSERT INTO `products_description` VALUES (592, 1, 'Sterling Silver 19cm Magnetic Charm Bead Bracelet', 'This Pandora style charm bracelet can carry any glass and silver charm bead from all the major charm companies including Pandora, chamilia and Trollbeads.', '', 12);
INSERT INTO `products_description` VALUES (593, 1, 'Sterling Silver 21cm Magnetic Catch Charm Bead Bracelet', 'This Pandora style charm bracelet can carry silver and glass charm beads from all the major charms sellers including Pandora, Chamilia and Trollbeads.', '', 12);
INSERT INTO `products_description` VALUES (594, 1, 'Stainless Steel 3oz Hip Flask with Diamonte Dragonfly', 'This beautiful pink ladies hip flask is perfect for a night out or special event. Not suitable to be engraved.', '', 27);
INSERT INTO `products_description` VALUES (595, 1, 'Stainless Steel 3oz Hip Flask with Diamonte Butterfly', 'This beautiful pink ladies hip flask is ideal for nights out or special occasions, it has a captive top. Not suitable to be engraved on flask.', '', 26);
INSERT INTO `products_description` VALUES (596, 1, 'Stainless Steel 3oz Hip Flask with Top and Bottom Diamonte Band', '', '', 8);
INSERT INTO `products_description` VALUES (597, 1, 'Stainless Steel Round Hip Flask with Cups and Funnel', 'This stainless steel plain hip flask is on the plain back and front, so is suitable for engraving. It comes with 2 cups and a handy funnel which will prevent spills.', '', 16);
INSERT INTO `products_description` VALUES (598, 1, 'Stainless Steel 6oz Hip Flask with Black Leather Finish', 'This 6oz hip flask has a black leather finish with an engraving plate on the front, it has a captive top and a handy funnel.', '', 16);
INSERT INTO `products_description` VALUES (599, 1, 'Stainless Steel 3oz Hip Flask and Business Card Holder in Black', 'This hip flask has a captive top and is also black on the back, the card holder has a plain back.', '', 7);
INSERT INTO `products_description` VALUES (600, 1, '9ct Yellow Gold Triple Tear Drop Pendant', 'This pendant has 3 diamonds which totals 0.03ct and measures 32.6mm long, 8mm wide and weighs a total of 2.7 grams including the 9ct gold trace chain.', '', 10);
INSERT INTO `products_description` VALUES (601, 1, '9ct White Gold Ruby and Diamond Pendant', 'This beautiful white gold pendant has a 5mm x 4mm ruby and 6 diamonds in a claw setting. The pendant measures 17mm long and 7mm wide, it sits on a white gold curb chain.', '', 19);
INSERT INTO `products_description` VALUES (602, 1, '9ct Yellow Gold Open Tear Drop Diamond Pendant', 'The pendant measures 21mm long, 8mm wide and total weight including yellow gold trace chain (different chain from image) is 2 grams. Diamonds 0.06ct', '', 15);
INSERT INTO `products_description` VALUES (603, 1, '9ct White Gold Blue Topaz Pendant', 'This beautiful pendant has a 10mm x 8mm blue topaz set in a 4 claw setting. The pendant measures 23mm long, 11.2mm wide and sits on a white gold mini belcher chain.', '', 16);
INSERT INTO `products_description` VALUES (604, 1, '9ct White Gold Oval pendant with Diamonds', 'A stylish white gold oval pendant which has pave set diamonds and total 0.10ct. The pendant measures 22.4mm long and 16mm wide. It sits on a white gold mini belcher chain (different chain from image).', '', 14);
INSERT INTO `products_description` VALUES (605, 1, '9ct Yellow Gold Peridot Pendant', 'This elegant 3 peridot pendant measures 27mm long including loop and 7.3mm wide. It sits on a yellow gold trace chain ( different chain from image).', '', 11);
INSERT INTO `products_description` VALUES (606, 1, '9ct Yellow Gold Triple Tear Drop Earring', 'This lovely yellow gold earring has a 0.02ct diamond on the bottom of the tear drop which measures 27.3mm, 8mm wide and weghs a total of 1.6 grams.', '', 16);
INSERT INTO `products_description` VALUES (607, 1, '9ct Yellow Gold Open Tear Drop Loop Design Earring', 'This earring measures 18.6mm long, 7.5mm wide and weighs a total of 1.8 grams. Diamond content 0.11ct', '', 16);
INSERT INTO `products_description` VALUES (608, 1, '9ct White Gold Blue Topaz Earring', 'This stunning white gold earring has a 8mm x 6mm blue topaz set in a 4 claw setting. The earring measures 26mm long and 8mm wide.', '', 19);
INSERT INTO `products_description` VALUES (609, 1, '9ct Yellow Gold Pearl and Diamond Earring', 'This modern pearl and diamond earring measures 12.5mm long 9mm wide. Diamond weight 0.07ct.', '', 17);
INSERT INTO `products_description` VALUES (610, 1, '9ct Yellow Gold Diamond Drop Earring', 'This elegant drop earring has 7 diamonds on each earring and totals 0.154ct.', '', 13);
INSERT INTO `products_description` VALUES (611, 1, '9ct Yellow Gold Pearl and Diamond Drop Earring', '', '', 16);
INSERT INTO `products_description` VALUES (612, 1, '9ct White Gold Aquamarine and Diamond Earring', 'A stunningly beautiful white gold stud earring which measures 11.5mm and 8.7mm wide', '', 15);
INSERT INTO `products_description` VALUES (613, 1, '9ct Yellow Gold Pearl and Diamond Pendant', 'This modern pearl and diamond pendant has a beautiful freshwater pearl and 10 diamonds which total 0.06ct. It sits on a yellow gold curb chain.', '', 18);
INSERT INTO `products_description` VALUES (614, 1, '9ct Yellow Gold Diamond Pendant', 'This stylish tear drop style pendant has 7 graduated diamonds down one side with a total of 0.255ct and sits on a yellow gold curb chain (different chain from image).', '', 14);
INSERT INTO `products_description` VALUES (615, 1, '9ct Yellow Gold Open Tear Drop Loop Design Pendant', '', '', 3);
INSERT INTO `products_description` VALUES (616, 1, '9ct White Gold Sapphire and Diamond Open Heart Pendant', 'A modern heart shaped sapphire and diamond pendant with curb chain (different chain from image)', '', 11);
INSERT INTO `products_description` VALUES (617, 1, 'Sterling Silver Cubic Zirconia Open Circles Bracelets', 'This beautiful bracelet measures 19cm/7.25" long, 9.5mm at widest and weighs 12.3 grams.', '', 8);
INSERT INTO `products_description` VALUES (618, 1, 'Sterling Silver Open Disc Cluster Bracelet', 'Dimensions - 18cm/7" long with 3cm extender and weighs 6.7 grams.', '', 6);
INSERT INTO `products_description` VALUES (619, 1, 'Sterling Silver Blue Crystal Bracelet', 'This stylish bracelet measures 18cm/7" long with a 3cm extender and weighs 8.1 grams.', '', 8);
INSERT INTO `products_description` VALUES (620, 1, 'Sterling Silver Cubic Zirconia Bracelet', 'this bracelet measures 18cm/7" long, 3.5mm wide and weighs 6.2 grams.', '', 4);
INSERT INTO `products_description` VALUES (621, 1, 'Sterling Silver Snake Bracelet with Rings', 'This bracelet measures 19cm/7.5" long and weighs 20.2 grams', '', 20);
INSERT INTO `products_description` VALUES (622, 1, 'Sterling Silver Blue Crystal Drop Earring', '', '', 11);
INSERT INTO `products_description` VALUES (623, 1, 'Sterling Silver Open Lantern Drop Earring', 'These modern earrings measure 33mm long, 13.6mm wide and weigh a total of 3 grams.', '', 11);
INSERT INTO `products_description` VALUES (624, 1, 'Sterling Silver Cubic Zirconia Cherry Blossom Earring', '', '', 8);
INSERT INTO `products_description` VALUES (625, 1, 'Sterling Silver Triple Layer Drop Earring', 'This stunning drop earring measures 55mm long, 11mm wide and weighs a total of 6.2 grams.', '', 10);
INSERT INTO `products_description` VALUES (626, 1, 'Sterling Silver Cubic Zirconia Open Tear Drop Earring', 'This elegant drop earring measures 19.5mm long, 8mm wide and weighs a total of 2.2 grams.', '', 7);
INSERT INTO `products_description` VALUES (627, 1, 'Sterling Silver Open Lantern Pendant', 'This beautiful pendant measures 29mm long, 22.3mm wide and weighs 3.8 grams. It sits on an 18"/45cm diamond cut curb chain.', '', 9);
INSERT INTO `products_description` VALUES (628, 1, 'Sterling Silver 5 Twist Drop Necklace', '', '', 12);
INSERT INTO `products_description` VALUES (629, 1, '9ct Yellow Gold Inter-woven Stud Earrings', 'Theses studs are designed with inter-woven textured tubings, a discreet touch of femininity which will blend in with all styles. Approximately 10x10mm and weighs 1.0 grams.', '', 7);
INSERT INTO `products_description` VALUES (630, 1, '9ct Yellow Gold Rose-Shaped Stud Earrings', 'These studs are liked freshly blossomed roses, a discreet touch of femininity which will blend with all styles. Approximately 10x10mm and weighs 1.6 grams.', '', 4);
INSERT INTO `products_description` VALUES (631, 1, '9ct Yellow Gold Bamboo Creole Earrings', 'Inspired from bamboo shoots, these creoles achive a striking balance between the classic and the exotic. Fitted with a  hinged bar closure. Approximately 18x19mm and weighs 1.4 grams. Made in Italy.', '', 10);
INSERT INTO `products_description` VALUES (632, 1, '9ct yellow GoldFaceted Creole Earrings', 'These hoops catch the light with their multi-faceted surfaces, creating a dazzling effect. Fitted with hinged bar closure.. Approximately 13x15mm and weighs 0.6 grams.', '', 8);
INSERT INTO `products_description` VALUES (633, 1, '9ct Yellow Gold Creole Earrings', 'These classic creoles feature a triangular tubing and attractive designs on the sides. Fitted with a hinged bar closure. Approximately 15x16mm and weighs 0.8 grams.', '', 6);
INSERT INTO `products_description` VALUES (634, 1, '9ct White, Yellow and Rose Gold Hoop Earring', 'These modern three coloured hoops are made of white, rose and yellow gold tubings integrated together to form a very simple but stylish piece. Fitted with hinged bar closure. Approximately 20x22mm and weighs 2.6 grams.', '', 12);
INSERT INTO `products_description` VALUES (635, 1, '9ct White Gold Twisted Hoop Earrings', 'Precise twisting with sharper angles reflect the light and create a fancy effect to this stricking white gold hoops. Approximately 25x26mm and weighs 1.1 grams.', '', 10);
INSERT INTO `products_description` VALUES (636, 1, '9ct White Gold Twisted Double Hoop Earrings', 'The main theme of these stylish twisted white gold is the double hoop. Fitted with a hinged bar closure. Approximately 21x24mm and weighs 2.1 grams.', '', 9);
INSERT INTO `products_description` VALUES (637, 1, '9ct White Gold Engraved Square Hoop Earrings', 'These attractive square hoop earrings feature a square tubing. They are enhanced by an engraved design on the sides. Fitted by a hinged bar closure. Approximately 23x25mm and weighs 1.3 grams.', '', 4);
INSERT INTO `products_description` VALUES (638, 1, '9ct Yellow Gold Flat Knot Earrings', 'Stylish knot earrings formed of four highly polished tubes. approximately 10x10mm and weighs 1.0 grams', '', 12);
INSERT INTO `products_description` VALUES (639, 1, '9ct Yellow Gold Engraved Square hoop Earrings', 'These square hoop earrings feature a square tubing, enhanced by a design on the sides. Fitted with a hinged bar closure. Approximately 20x23x2mm and weighs 1.4 grams.', '', 7);
INSERT INTO `products_description` VALUES (640, 1, '9ct White Gold Twisted Hoop Earrings', 'Precise twisting with sharp angles reflect the light and give a striking look to these hoop earrings. Fitted with a hinged bar closure. Approximately 20x21mm and weighs 1.1 grams.', '', 11);
INSERT INTO `products_description` VALUES (641, 1, '9ct White and Yellow Gold Hoop Earring', 'Angular shapes and clear lines are combined with alternating white and yellow gold, and highlighted by white gold accents. Approximately 20x21mm and weighs 3.4 grams.', '', 14);
INSERT INTO `products_description` VALUES (642, 1, '9ct White Gold Twisted Hoop Earrings', 'Precise twisting with sharp angles reflect the light and give a striking look to these white god earrings, Approximately 15x16nn and weighs 0.8 grams.', '', 10);
INSERT INTO `products_description` VALUES (643, 1, '9ct White Gold Square Tube Hoop Earrings', 'These minimalist white gold hoops have been fashioned from narrow square tubing. Their discreet and understated elagance will compliment all styles. Approximately 22x23x2mm and weighs 1.8 grams.', '', 10);
INSERT INTO `products_description` VALUES (644, 1, '9ct Yellow Gold Engraved Oval Hoop Earrings', 'These oval hoop earrings feature a square tubing, enhanced by a design on the sides. Fitted with a hinged bar closure. Approximately 28x25x2mm and weighs1.3 grams.', '', 9);
INSERT INTO `products_description` VALUES (645, 1, '9ct Yellow Gold Classic Twisted Earrings.', 'These classic hoop earrings are made from round tubing twisted into a neat spiral for a dazzling effect. Fitted with a hinged bar closure. Approximately 22x23mm and weighs 1.7 grams.', '', 9);
INSERT INTO `products_description` VALUES (646, 1, '9ct Yellow Gold Classic Hoop Earrings', 'These classic hoops are made of polished round tubing and brace the minimalist trend. Ideal for formal and informal occasions. Fitted with a hinged bar closure. Approximately 23x25x2mm and weighs 1.7 grams.', '', 7);
INSERT INTO `products_description` VALUES (647, 1, 'Sterling Silver Cubic Zirconia Pave Disc & Heart Pendant', 'This pendant measures 30mm and sits on a 18"/45cm diamond cut curb chain', '', 8);
INSERT INTO `products_description` VALUES (648, 1, '9ct White Gold Engraved Hoop Earrings', 'These lightweight round hoop earrings feature a square tubing. They are enhanced by an engraved design on the sides. Fitted by a hinged bar closure. Approximately 19x19mm and weighs 1.2 grams.', '', 10);
INSERT INTO `products_description` VALUES (649, 1, '9ct White Gold Square Tube Round Hoops', 'These minamilist white gold hoops have been fashioned from narrow square tubing. Their discreet and understated elagance will complement all styles. Fitted with a hinged bar closure. Approximately 20x20x2mm and weighs 1.8 grams.', '', 6);
INSERT INTO `products_description` VALUES (650, 1, '9ct Yellow Gold Earrings', 'These stylish knots are formed of fancy tubing comprising of four highly polished and four mesh textured tubes.  Approximately 11x11mm and weighs 1.0 grams.', '', 9);
INSERT INTO `products_description` VALUES (651, 1, '9ct Yellow Gold Knot Earrings', 'Thesestylish knots are formed of fancy tubing comprising of four highly polished and four mesh textured tubes. Approximately 12x12mm and weighs 1.9 grams.', '', 6);
INSERT INTO `products_description` VALUES (652, 1, '9ct White Gold Classic Hoop Earrings', 'These classic polished white gold hoop earrings provide a discreet touch of femininity and modernity and are ideal for formal and informal occasions. Fitted with a hinged bar closure. Approximately 24x26x3mm and weighs 1.5 grams.', '', 9);
INSERT INTO `products_description` VALUES (653, 1, '9ct Yellow Gold Knot Earring', 'These stylish discreet knot earrings are made with contrasting polished and textured tubings. Approximately 9x9mm and weighs 1.1 grams.', '', 14);
INSERT INTO `products_description` VALUES (654, 1, '9ct White Gold Knot Earrings', 'These stylish white gold knot earrings are formed with polished rectangular tubing. Approximately 9x9mm and weighs 1.4 grams.', '', 15);
INSERT INTO `products_description` VALUES (655, 1, '9ct White Gold Twisted Hoop Earrings', 'These white gold twist hoops are made from twisted round tubing. Approximately 22x26mm and weighs 2.0 grams.', '', 9);
INSERT INTO `products_description` VALUES (656, 1, '9ct Yellow Gold Knot Earrings', 'These unusual knot earrings feature double elements. Weighs 0.9 grams.', '', 12);
INSERT INTO `products_description` VALUES (657, 1, '9ct White Gold Oval Hoop Earrings', 'Subtle diamond cut edging is the engaging theme of these simple yet stylish white gold oval hoop earrings. Fitted with a hinged bar closure. Approximately 26x44mm and weighs 1.8 grams.', '', 9);
INSERT INTO `products_description` VALUES (658, 1, '9ct White Gold Oval Wave Hoop Earring', 'With their fluid wave styling, these oval earrings create a stunning visual effect both from the front and from the side. Fitted with a hinged bar closure. Approximately 18x27mm and weighs 2.2 grams', '', 12);
INSERT INTO `products_description` VALUES (659, 1, '9ct Yellow Gold Ribbed Hoop Earrings', 'Cylindrical in shape, ribbed in design and versitile to wear. Fitted with a hinged bar closure. Approximately 21x20mm and weighs 2.9 grams.', '', 9);
INSERT INTO `products_description` VALUES (660, 1, '9ct White Gold Stud Earrings', 'Subtle movement is created by these simple curved white gold earrings. Approximately 3x12mm and weigh 1.2 grams.', '', 10);
INSERT INTO `products_description` VALUES (661, 1, '9ct White Gold 5mm Ball Stud Earring', 'Easy to wear for all occasions, discreet yet elegant, these white gold studs are a must. Polished and spherical, they will just blend in with any style.', '', 14);
INSERT INTO `products_description` VALUES (662, 1, '9ct Yellow Gold 6mm Frosted Ball Stud Earrings', 'Easy to wear for all occasions, discreet yet elegant, these studs are a must. With their stardust finish and round shape, they will just blend in with any style.', '', 9);
INSERT INTO `products_description` VALUES (663, 1, '9ct White Gold Cubic Zirconia Stud Earrings', 'White gold and cubic zirconia stud earrings. Approximately 5x7mm.', '', 15);
INSERT INTO `products_description` VALUES (664, 1, '9ct Yellow Gold 5mm Frosted Ball Stud Earring', '9ct gold frosted ball stud earrings', '', 17);
INSERT INTO `products_description` VALUES (665, 1, '9ct White Gold 4mm Ball Stud Earring', 'Easy to wear for all occasions, discreet yet elegant, these white gold studs are a must. Polished and spherical, they will just blend in with any style.', '', 10);
INSERT INTO `products_description` VALUES (666, 1, '9ct White Gold Cubic Zirconia Stud Earring', 'White gold and cubic zirconia ellipse studs. Approximately 4x9mm.', '', 15);
INSERT INTO `products_description` VALUES (667, 1, '9ct Yellow Gold Simulated Pearl Stud Earrings', 'A classic pair of simulated pearl stud earrings, diamond-cut on the edges for increased brilliance. Approximately 8x8mm.', '', 18);
INSERT INTO `products_description` VALUES (668, 1, '9ct Yellow Gold 3mm Ball Stud Earrings', 'Easy to wear for all occasions, discreet yet elegant, these are a must, Polished and spherical, they will just blend in with any style.', '', 15);
INSERT INTO `products_description` VALUES (669, 1, 'Sterling Silver 19cm Pandora Style Charm Bracelet', 'This Pandora style charm bracelet can carry any glass and silver charm beads from all the major charm companies including Pandora. Chamilia and Trollbeads.', '', 19);
INSERT INTO `products_description` VALUES (670, 1, 'Sterling Silver 21cm Pandora Style Charm Bracelet', 'This Pandora style charm bracelet can carry any glass and silver charm bead from all the major charm companies including Pandora, Chamilia and Trollbeads.', '', 15);
INSERT INTO `products_description` VALUES (671, 1, 'Sterling Silver Open Multi Disc Drop Earring', 'This elegant drop earring is 45mm long, 11mm wide and weighs a total of 3.4 grams.', '', 16);
INSERT INTO `products_description` VALUES (672, 1, 'Sterling Silver 23cm Pandora Style Charm Bracelet', 'This Pandora style charm bracelet can carry any glass and silver charm bead from all the major charm companies including Pandora, Chamilia and Trollbeads.', '', 33);
INSERT INTO `products_description` VALUES (673, 1, 'Ladies Seksy Black Stone Set Half Moon Watch', 'This ladies Seksy watch features a crystal set case and shoulders, it has a black mother of pearl dial. It has a three catch bracelet for adjustment.', '', 31);
INSERT INTO `products_description` VALUES (674, 1, 'Ladies Seksy Pink Stone Set Half Moon Watch', 'This ladies seksy watch features a crystal set case and shoulders, it has a pink mother of pearl dial and has a three catch bracelet for adjustment.', '', 26);
INSERT INTO `products_description` VALUES (675, 1, 'Ladies Seksy Purple Dial Watch', 'Ladies purple mother of pearl dial tear drop shaped dial which has a four catch bracelet to allow you to shorten.', '', 23);
INSERT INTO `products_description` VALUES (676, 1, 'Ladies Seksy Mother of Pearl Dial Watch', 'Ladies mother of pearl triangular shaped dial which features a crystal set case and shoulders and has a three catch bracelet to allow you to shorten.', '', 22);
INSERT INTO `products_description` VALUES (677, 1, '9ct Yellow Gold Bamboo Creole Earrings', 'Inspired from bamboo shoots, these creoles achive a striking balance between the classic and the exotic. Fitted with a hinged bar closure. Approximately 15x16mm and weighs 1.0 grams', '', 17);
INSERT INTO `products_description` VALUES (678, 1, 'Sterling Silver 18th Birthday Charm Bead', 'This silver 18th birthday charm is suitable for all the major charm bracelets including Pandora, Chamilia and Trollbeads.', '', 16);
INSERT INTO `products_description` VALUES (679, 1, 'Ladies Sterling Silver Charmed Watch (Precious)', 'Ladies sterling silver charmed by Accurist watch with sterling silver stoppers and heart shaped mother of pearl charms.\r\nCreate your own unique timepiece by adding charms from any of the leading charms, four stopper beads included.', '', 30);
INSERT INTO `products_description` VALUES (680, 1, 'Blue and White Swirl Charm Bead', 'Compatible with all major charm bracelets including Pandora, Chamilia and Trollbeads. There is a sterling silver core which runs through the middle.', '', 10);
INSERT INTO `products_description` VALUES (681, 1, 'Sterling Silver Cubic Zirconia and Open Circle Necklet', 'This open circle cubic zirconia necklet measures 28mm fom top of the open circle to the bottom of the cubic zirconia and sits on a 16"/40cm silver trace chain which has a 2"/5cm extender. Total weight of pendant is 6.3 grams.', '', 13);
INSERT INTO `products_description` VALUES (682, 1, 'Ladies Accurist Gold Plated Quartz Watch', 'This beautiful ladies Accurist watch has a gold plated case and bracelet which is adjustable, quartz analogue movement and comes in an Accurist presentation box.', '', 9);
INSERT INTO `products_description` VALUES (683, 1, '9ct White Gold 3mm D Shaped Wedding Ring Size M', 'With it''s tapered edges, the D  shape profile of this white gold ring is the most classical and timeless. Weight 2.2 grams <br/>Made in England.<br/>Also available in sizes J-Q, Delivery 3 to 5 days', '', 13);
INSERT INTO `products_description` VALUES (684, 1, '9ct white Gold 4mm D Shape Wedding Ring Size P', 'With it''s tapered edges, the D saped profile ot this white gold ring is the most classical nand timeless. Weight 3.4 grams.<br/>Made in England.<br/>Also available in sizes J-U, Delivery 3 to 5 days', '', 13);
INSERT INTO `products_description` VALUES (685, 1, '9ct White Gold 5mm D Shape Wedding Ring Size R', 'With it''s tapered edges, the D shape profile of this white gold ring is the most classical and timeless. weight 5.0 grams<br/>Made in England<br/>Also available in sizes K-Z, Delivery 3 to 5 days.', '', 8);
INSERT INTO `products_description` VALUES (686, 1, '9ct White Gold 6mm D Shape Wedding Ring Size V', 'With it''s tapered edges, the D shape profile of this white gold ring is the most classical and timeless. Weight 7.1 grams. Made in England.<br/>Also available in sizes K-Z, Delivery 3 to 5 days', '', 7);
INSERT INTO `products_description` VALUES (687, 1, '9ct White Gold 3mm D Shaped Mill Grain Edge Wedding Ring Size M', 'With it''s tapered edges, the D shaped profile of this white gold ring is the most classical and timeless. Mill grain edge band. Made in England.<br/>Also available in sizes J-Q, Delivery 3 to 5 days.', '', 6);
INSERT INTO `products_description` VALUES (688, 1, '9ct White Gold 4mm D Shaped Mill Grain Edge Wedding Ring Size O', 'With it''s tapered edges, this white gold ring is the most classical and timeless. mill grain edge band. Made in England.<br/>Also available in sizes J-U, Delivery 3 to 5 days.', '', 4);
INSERT INTO `products_description` VALUES (689, 1, '9ct White Gold 5mm D Shaped Mill Grain Edge Wedding Ring Size P', 'With its tapered edges, the D shaped profile of this white gold ring is the most classical and timeless. Mill grain edge band. Made in England.<br/>Also available in sizes K-Z, Delivery 3 to 5 Days.', '', 7);
INSERT INTO `products_description` VALUES (690, 1, '9ct White Gold 6mm D Shaped Mill Grain Edge Wedding Ring Size S', 'With it''s tapered edges, the D shaped profile of this white gold ring is the most classical and timeless. Mill grain edge band. Made in England.<br/>Also available in sizes K-Z, Delivery 3 to 5 days.', '', 3);
INSERT INTO `products_description` VALUES (691, 1, '9ct White Gold 3mm Flat Court Bevelled Edge Wedding Ring Size M', 'With it''s clean lines, tradition is reworked for a more contempory look while the internal barrelling of the interior of this white gold ring assures a comfortable fit. Made in England.<br/>Also available in sizes J-Q, Delivery 3 to 5 days.', '', 4);
INSERT INTO `products_description` VALUES (692, 1, '9ct White Gold 4mm Flat Court Bevelled edge wedding Ring Size O', 'With it''s clean lines, tradition is reworked for a more contempory look while the internal barrelling of the interior of this white gold ring assures a comfortable fit. Made in England.<br/>Also available in sizes J-U, Delivery 3 to 5 days.', '', 6);
INSERT INTO `products_description` VALUES (693, 1, '9ct White Gold 5mm Flat Court Bevelled edge wedding Ring Size S', 'With it''s clean lines, tradition is reworked for a more contemporary look while the internal barrelling of the interior of this white gold ring assures a comfortable fit. Made in England.<br/>Also available in sizes K-Z, Delivery 3 to 5 days.', '', 3);
INSERT INTO `products_description` VALUES (694, 1, '9ct White Gold 6mm Flat Court Bevelled edge wedding Ring Size R', 'With it''s clean lines,tradition is reworked for a more contemporary look while the internal barrelling of the interior of this white gold ring assures a comfortable fit. Made in England.<br/>Also available in sizes K-Z, Delivery 3 to 5 days.', '', 10);
INSERT INTO `products_description` VALUES (695, 1, '9ct Yellow Gold 3mm Flat court Bevelled Edge Wedding Ring Size L', 'With it''s clean lines, tradition is reworked for a more contemporary look while the internal barrelling of the interior of this ring assures a comfortable fit. Made in England.<br/>Also available in sizes J-Q, Delivery 3 to 5 days.', '', 8);
INSERT INTO `products_description` VALUES (696, 1, '9ct Y Gold 4mm Flat Court Bevelled Edge Wedding Ring Size N', 'With it''s clean lines, tradition is reworked for a far more contemporary look while the internal barrelling of the interior assures a comfortable fit. Made in England.<br/>Also available in sizes J-U, Delivery 3 to 5 days.', '', 9);
INSERT INTO `products_description` VALUES (710, 1, '9ct Y Gold 4mm Flat Court Ribbed Wedding Band Size N', 'With it''s clean lines, tradition is reworked for a more contemporary look while the internal barrelling of the interior of this ring assures a comfortable fit.Made in England.<br/>Also available in sizes J-U, Delivery 3 to 5 days.', '', 11);
INSERT INTO `products_description` VALUES (697, 1, '9ct Y Gold 5mm Flat Court Bevelled Edge Wedding Ring Size S', 'With it''s clean lines, tradition is reworked for a more contemporary look while the internal barrelling of the interior of this ring assures a comfortable fit. Made in England.<br/>Also available in sizes K-Z, Delivery 3 to 5 days.', '', 13);
INSERT INTO `products_description` VALUES (698, 1, '9ct Y Gold 6mm Flat Court Bevelled Edge Wedding Ring Size T', 'With it''s clean lines, tradition is reworked for a more contemporary look while the internal barrelling of the interior of this ring assures a comfortable fit. Made in England.<br/>Also available in sizes P-Z, Delivery 3 to 5 days.', '', 14);
INSERT INTO `products_description` VALUES (699, 1, '9ct Yellow Gold 3mm Court Shaped Wedding Ring Size M', 'The court shaped profile is also known as the comfort-fit. The internal barrelling of this ring ensures outstanding wearability. Weight 3.1 grams. Made in England.<br/>Also available in sizes J-U, Delivery 3 to 5 days.', '', 11);
INSERT INTO `products_description` VALUES (700, 1, '9ct Yellow Gold 4mm Court Shaped Wedding Ring Size P', 'The court shaped profile is also known as the comfort-fit. The internal barrelling of this ring ensures outstanding wearability. Weight 3.5 grams. Made in England.<br/>Also available in sizes J-U, Delivery 3 to 5 days.', '', 14);
INSERT INTO `products_description` VALUES (701, 1, '9ct Yellow Gold 5mm Court Shaped Wedding Ring Size T', 'The court shaped profile is also known as the comfort-fit. The internal barrelling of this ring ensures outstanding wearability. Weight 4.6 grams. Made in England.<br/>Also available in sizes K-Z, Delivery 3 to 5 days.', '', 14);
INSERT INTO `products_description` VALUES (702, 1, '9ct Yellow Gold 6mm Court Shaped Wedding Ring Size W', 'The court shaped profile is also known as the comfort-fit. The internal barrelling of this ring ensures outstanding wearability. Weight 6.9 grams. Made in England.<br/>Also available in sizes K-Z, Delivery 3 to 5 days.', '', 11);
INSERT INTO `products_description` VALUES (703, 1, '9ct Yellow Gold 3mm D Shaped wedding Ring Size L', 'With it''s tapered edges, the D shaped profile of this ring is the most classical and timeless. Weight 2.0 grams. Made in England.<br/>Also available in sizes J-U. Delivery 3 to 5 days.', '', 14);
INSERT INTO `products_description` VALUES (704, 1, '9ct Yellow Gold 4mm D Shaped wedding ring Size N', 'With it''s tapered edges, the D shaped profile of this ring is the most classical and timeless. Weight 2.9 grams. Made in England.<br/>Also available in sizes J-U, Delivery 3 to 5 days.', '', 12);
INSERT INTO `products_description` VALUES (705, 1, '9ct Yellow Gold 5mm D Shaped Wedding Ring Size S', 'With it''s tapered edges, the D shaped profile of this ring is the most classical and timeless. Weight 4.7 grams. Made in England.<br/>Also available in sizes K-Z, Delivery 3 to 5 days.', '', 14);
INSERT INTO `products_description` VALUES (706, 1, '9ct Yellow Gold 6mm D Shaped Wedding Ring Size V', 'With it''s tapered edges, the D shaped profile of this ring is the most classical and timeless. Weight 6.5 grams. Made in England.<br/>Also available in sizes K-Z, Delivery 3 to 5 days.', '', 16);
INSERT INTO `products_description` VALUES (707, 1, '9ct Yellow Gold 3mm D Shape mill Grain Edge Wedding Ring size L', 'With it''s tapered edges, the D shaped profile of this ring is the most classical and timeless. Mill grain edge. Made in England.<br/>Also available in sizes J-U, Delivery 3 to 5 days.', '', 15);
INSERT INTO `products_description` VALUES (708, 1, '9ct Y Gold 4mm D Shaped Mill Grain Edge Wedding Ring size O', 'With it''s tapered edges, the D shaped profile of this ring is the most classical and timeless. Mill grain edge. Made in England.<br/>Also available in sizes J-U, Delivery 3 to 5 days.', '', 16);
INSERT INTO `products_description` VALUES (709, 1, '9ct Y Gold 5mm D Shaped Mill Grain Edge Wedding Ring Size Q', 'With it''s tapered edges, the D shaped profile of this ring is the most classical and timeless. Mill grain edge. Made in England.<br/>Also available in sizes K-Z, Delivery 3 to 5 days.', '', 14);
INSERT INTO `products_description` VALUES (711, 1, '9ct Y Gold 6mm Flat Court Ribbed Wedding Ring Size U', 'With it''s clean lines, tradition is reworked for a more contemporary look while the internal barrelling of the interior of this ring assures a comfortable fit. Made in England.<br/>Also available in sizes P-Z, Delivery 3 to 5 days.', '', 8);
INSERT INTO `products_description` VALUES (712, 1, '9ct Y Gold 5mm Flat Court Striped Wedding Ring Size T', 'With it''s clean lines, tradition is reworked for a more contemporary look while the internal barrelling of the interior of the ring assures a comfortable fit. Striped with polished centre with satin edges. Made in England.<br/>Also available in sizes K-Z, Delivery 3 to 5 days.', '', 7);
INSERT INTO `products_description` VALUES (713, 1, '9ct Y Gold 4mm Flat Court Striped Wedding Ring Size N', 'With it''s clean lines, tradition is reworked for a more contemporary look while the internal barrelling of the interior of this ring assures a comfortable fit. Striped with polished centre and satin edges. Made in England.<br/>Also available in sizes J-U, Delivery 3 to 5 days.', '', 10);
INSERT INTO `products_description` VALUES (714, 1, '9ct W Gold 4mm Flat Court Striped Wedding Ring Size M', 'With it''s clean lines, tradition is reworked for a more contemporary look while the internal barrelling of the interior of this white gold ring assures a comfortable fit. Striped with polished centre and satin edges. Made in England.<br/>Also available in sizes J-U, Delivery 3 to 5 days.', '', 10);
INSERT INTO `products_description` VALUES (715, 1, '9ct W Gold 5mm Flat Court Striped Wedding Ring Size R', 'With it''s clean lines, tradition is reworked for a more contemporary look while the internal barrelling of the interior of this ring assures a comfortable fit. Striped with polished centre and satin edges. Made in England.<br/>Also available in sizes K-Z, Delivery 3 bto 5 days.', '', 9);
INSERT INTO `products_description` VALUES (716, 1, 'Ladies Seksy Stainless Steel Swarovski Crystal Quartz Watch', 'This beautiful Seksy watch has an adjustable bracelet with Swarovski crystals, a silver dial with sparkle effect and comes in a presentation box.', '', 24);
INSERT INTO `products_description` VALUES (717, 1, '9ct Yellow Gold Emerald and Cubic Zirconia Stud Earring', 'These beautiful earrings have 4 marquise cut emeralds and 5 round cubic zirconia stones. 9.7mm x 9.2mm. Total weight 1.8 grams', '', 11);
INSERT INTO `products_description` VALUES (718, 1, '9ct White and Yellow Gold Cubic Zirconia Drop Earring', 'This stylish drop earring has 3 round cubic zirconia stones in a channel setting between white and yellow gold. It measures 33.9mm long and 5mm at it''s widest. Total weight 1.5 grams.', '', 8);
INSERT INTO `products_description` VALUES (719, 1, '9ct White and Yellow Gold Cubic Zirconia Stud Earring', 'A beautiful blend of intertwining white and yellow gold with a small cubic zirconia set in the yellow gold. 8.2mm x 8.5mm. Total weight 1.2 grams.', '', 15);
INSERT INTO `products_description` VALUES (720, 1, '9ct White and Yellow Gold Stud Earring', 'A classy intertwining white and yellow gold earring. 7.5mm x 7.6mm. Total weight 1.0 grams', '', 12);
INSERT INTO `products_description` VALUES (721, 1, '9ct White and Yellow Gold Diamond Stud Earring', 'A classic white and yellow gold knot earring with one small diamond on each earring. 9.4mm x 9.2mm. Total weight 1.6 grams.', '', 14);
INSERT INTO `products_description` VALUES (722, 1, '9ct Yellow Gold Pearl and Cubic Zirconia Stud Earring', 'This round swirl style earring has a small cubic zirconia and pearl in the middle and measures 7.8mm, it weighs a total of 0.8 grams.', '', 16);
INSERT INTO `products_description` VALUES (723, 1, '9ct Yellow Gold Cubic Zirconia Stud Earring', 'Elagant open leaf style gold earring with 3 round cubic zirconia stones. 14.6mm x 7.8mm. Total weight 1.4 grams', '', 12);
INSERT INTO `products_description` VALUES (724, 1, '9ct Yellow Gold Round Diamond Set Stud Earring', 'This round gold earring has a heart set in the inside with 3 small diamonds on each earring. 10.2mm x 10.3mm. Total weight 1.6 grams.', '', 14);
INSERT INTO `products_description` VALUES (725, 1, '9ct Yellow Gold Tear Drop Stud Earring', 'This classic open tear drop earring meassures 9.4mm x 5.8mm and weighs a total of 0.6 grams', '', 22);
INSERT INTO `products_description` VALUES (726, 1, '9ct Yellow Gold 5mm Cubic Zirconia Stud Earring', 'This gold stud earring has a 5mm cubic zirconia stone which is set in a four claw setting. Total weight 1.0 gram', '', 18);
INSERT INTO `products_description` VALUES (729, 1, 'Sterling Silver Blue Crystal Necklace', 'This stunning pendant has a marquise shaped blue crystal which sits in the middle of the three part pendant. Measures 40mm long and 12.7mm at it''s widest. It sits on a 40cm/16" silver box chain and has a 5cm extender. Total weight including chain 6.1 grams.', '', 15);
INSERT INTO `products_description` VALUES (731, 1, '9ct Yellow Gold Hoop Earring', '', '', 0);
INSERT INTO `products_description` VALUES (732, 1, '9ct Yellow Gold Twisted Hoop Earring', 'This beautiful creole style earring has a hinge and bar closure and measures 22mm x 19mm and weighs 0.8 grams', '', 4);
INSERT INTO `products_description` VALUES (733, 1, '9ct Yellow Gold Hoop Earring', 'This beautiful hoop earring is fitted with a hinged bar closure. Measures 26mm x 24mm and weighs 1.0 gram.', '', 5);
INSERT INTO `products_description` VALUES (734, 1, '9ct Yellow Gold Hoop Earring', 'A stylish hoop earring which has a hinge and bar closure and measures 23mm x 20mm and weighs 1.0 gram.', '', 4);
INSERT INTO `products_description` VALUES (735, 1, 'Gents Sekonda Leather Strap Quartz Watch', '', '', 6);
INSERT INTO `products_description` VALUES (736, 1, 'Gents Sekonda Gold Plated Leather Strap Watch', '', '', 6);
INSERT INTO `products_description` VALUES (737, 1, 'Gents Sekonda Gold Plated Quartz Pocket Watch', '', '', 5);
INSERT INTO `products_description` VALUES (739, 1, 'Gents Sekonda Gold Plated Leather Strap Quartz Watch', '', '', 5);
INSERT INTO `products_description` VALUES (740, 1, 'Gents Sekonda Leather Strap Quartz Watch', '', '', 5);
INSERT INTO `products_description` VALUES (741, 1, 'Gents Sekonda Steel Expanding Bracelet Watch', '', '', 4);
INSERT INTO `products_description` VALUES (742, 1, 'Gents Sekonda Gold Plated Leather Strap Quartz Watch', '', '', 7);
INSERT INTO `products_description` VALUES (743, 1, 'Ladies Sekonda Quartz Bracelet Watch', '', '', 4);
INSERT INTO `products_description` VALUES (744, 1, 'Ladies Sekonda Quartz Bracelet Watch', '', '', 4);
INSERT INTO `products_description` VALUES (745, 1, 'Ladies Sekonda Gold Plated Bracelet Quartz Watch', '', '', 4);
INSERT INTO `products_description` VALUES (746, 1, 'Ladies Sekonda Quartz Bracelet Watch', '', '', 4);
INSERT INTO `products_description` VALUES (747, 1, 'Ladies Sekonda Gold Plated Bracelet Quartz Watch', '', '', 4);
INSERT INTO `products_description` VALUES (748, 1, 'Ladies Sekonda Two Tone Bracelet Quartz Watch', '', '', 3);
INSERT INTO `products_description` VALUES (749, 1, 'Ladies Sekonda Quartz Leather Strap Watch', '', '', 7);
INSERT INTO `products_description` VALUES (750, 1, 'Ladies Sekonda Gold Plated Bracelet Quartz Watch', '', '', 11);
INSERT INTO `products_description` VALUES (751, 1, 'Ladies Sekonda Quartz Bracelet Watch', '', '', 10);
INSERT INTO `products_description` VALUES (752, 1, 'Ladies Sekonda "Just Bead It" Bracelet Watch', 'This is a beautiful watch by Sekonda which has a mother of pearl dial and is suitable to add beads or charms from any of the leading brands including Pandora, Chamilia and Trollbeads.', '', 25);
INSERT INTO `products_description` VALUES (753, 1, 'Gents Sekonda Steel Expanding Bracelet Watch', '', '', 11);
INSERT INTO `products_description` VALUES (754, 1, 'Gents Sekonda Stainless Steel Quartz Watch', '', '', 13);
INSERT INTO `products_description` VALUES (755, 1, 'Gents Sekonda Gold Plated Quartz Bracelet Watch', '', '', 14);
INSERT INTO `products_description` VALUES (756, 1, 'Gents Sekonda Two Tone Bracelet Quartz Watch', '', '', 11);
INSERT INTO `products_description` VALUES (757, 1, 'Gents Sekonda Green Fabric Strap Watch', '', '', 16);
INSERT INTO `products_description` VALUES (758, 1, 'Gents Sekonda Stainless Steel Bracelet Watch', '', '', 5);
INSERT INTO `products_description` VALUES (759, 1, 'Ladies Silver and Gold Plated Charmed Watch (Sunflower)', 'Ladies two tone silver and gold plated charmed watch with elegant mother of pearl dial. Create your own unique timepiece by adding beads or charms from any of the leading brands. Four stopper beads included.', '', 28);
INSERT INTO `products_description` VALUES (760, 1, 'Stainless Steel 3oz Hip Flask with Diamonte Heart', 'This pink hip flask is ideal for nights out or special occasions, it has a captive top. Not suitable to engrave on flask.', '', 13);
INSERT INTO `products_description` VALUES (761, 1, 'Stainless Steel 6oz Hip Flask with Golfer', 'Ideal gift for the golfer in your life. It has a captive top and can be engraved on the front or back.', '', 12);
INSERT INTO `products_description` VALUES (762, 1, 'Stainless Steel 4oz Hip Flask with Thistle', 'This 6oz flask has a lazer engraved Scottish thistle on the front and a plain back which is suitable to be engraved.', '', 15);
INSERT INTO `products_description` VALUES (774, 1, '9ct Yellow Gold Diamond Eternity Ring Size L', 'This beautifully finished half eternity band features stunning channel-set round brilliant cut diamonds, 0.14ct. Also available to order in sizes I to R.', '', 7);
INSERT INTO `products_description` VALUES (773, 1, 'Girls D for Diamond Sterling Silver Double Heart Pendant', 'This D for Diamond pendant has a double heart drop, the top heart has a diamond and the larger bottom heart has an aquamarine stone. The pendant sits on a 14" silver box chain and measures 19mm long including bale and 8.5mm at it''s widest.', '', 12);
INSERT INTO `products_description` VALUES (772, 1, 'Ladies Silver Plated Charmed by Accurist (Midnight) Watch', 'Ladies silver plated Charmed watch with elegant black mother of pearl dial and decorative Swarovski crystal set bezel. This watch includes all beads and stoppers as shown.', '', 19);
INSERT INTO `products_description` VALUES (771, 1, 'Ladies Seksy Stainless Steel Swarovski Crystal Quartz Watch', 'This ladies Seksy fashion watch has a chrome coloured case with Swarovski crystals, fully adjustable bracelet, black mother of pearl dial and a quartz analogue movement.', '', 15);
INSERT INTO `products_description` VALUES (770, 1, 'Ladies Seksy Gold Plated Fashion Watch', 'This watch has a beautiful mother of pearl dial and is compilmented with a gold plated bracelet and case.', '', 19);
INSERT INTO `products_description` VALUES (775, 1, '9ct white Gold Diamond Eternity Ring Size M', 'This beautifully finished half eternity white gold band features stunning channel-set round brilliant cut diamonds, 0.14ct. Also available to order in sizes I to R', '', 5);
INSERT INTO `products_description` VALUES (776, 1, '9ct Yellow Gold Eternity Ring Size N', 'This beautifully finished half eternity band features stunning channel-set round brilliant cut diamonds, 0.22ct. Also available to order in sizes I to T.', '', 3);
INSERT INTO `products_description` VALUES (777, 1, '9ct White Gold Eternity Ring Size O', 'This beautifully finishe white gold band features stunning channel-set round brilliant cut diamonds, 0.22ct. Also available to order in sizes I to T.', '', 5);
INSERT INTO `products_description` VALUES (778, 1, 'Sterling Silver Mother Charm Bead', 'Compatible with all the major charm bracelets including Pandora, Chamilia and Trollbeads.', '', 4);

-- --------------------------------------------------------

--
-- Table structure for table `products_extra_fields`
--

CREATE TABLE `products_extra_fields` (
  `products_extra_fields_id` int(11) NOT NULL auto_increment,
  `products_extra_fields_name` varchar(64) collate latin1_general_ci NOT NULL default '',
  `products_extra_fields_order` int(3) NOT NULL default '0',
  `products_extra_fields_status` tinyint(1) NOT NULL default '1',
  `languages_id` int(11) NOT NULL default '0',
  `category_id` text collate latin1_general_ci NOT NULL,
  `google_only` char(1) collate latin1_general_ci NOT NULL default '0',
  `currencies_id` int(11) NOT NULL,
  PRIMARY KEY  (`products_extra_fields_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci AUTO_INCREMENT=3 ;

--
-- Dumping data for table `products_extra_fields`
--

INSERT INTO `products_extra_fields` VALUES (1, 'RRP', 0, 1, 0, '4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 33, 34, 35, 36, 37, 38, 39, 40, 41, 43, 44,', '0', 3);

-- --------------------------------------------------------

--
-- Table structure for table `products_notifications`
--

CREATE TABLE `products_notifications` (
  `products_id` int(11) NOT NULL,
  `customers_id` int(11) NOT NULL,
  `date_added` datetime NOT NULL,
  PRIMARY KEY  (`products_id`,`customers_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `products_notifications`
--


-- --------------------------------------------------------

--
-- Table structure for table `products_options`
--

CREATE TABLE `products_options` (
  `products_options_id` int(11) NOT NULL default '0',
  `language_id` int(11) NOT NULL default '1',
  `categories_id` int(11) default NULL,
  `products_options_name` varchar(32) NOT NULL default '',
  `products_options_is_static` tinyint(1) default '0',
  `products_options_is_visible` tinyint(1) default '0',
  PRIMARY KEY  (`products_options_id`,`language_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `products_options`
--

INSERT INTO `products_options` VALUES (1, 1, 1, 'Gender', 1, 1);
INSERT INTO `products_options` VALUES (2, 1, 1, 'Dial Colour', 1, 1);
INSERT INTO `products_options` VALUES (3, 1, 1, 'Strap/Bracelet', 1, 1);
INSERT INTO `products_options` VALUES (4, 1, 1, 'Case Shape', 1, 1);
INSERT INTO `products_options` VALUES (5, 1, 1, 'Metal', 1, 1);
INSERT INTO `products_options` VALUES (6, 1, 1, 'Water Resistance', 1, 1);
INSERT INTO `products_options` VALUES (7, 1, 1, 'Strap Colour', 1, 1);
INSERT INTO `products_options` VALUES (8, 1, 2, 'Metal', 1, 1);
INSERT INTO `products_options` VALUES (9, 1, 2, 'Type', 1, 1);
INSERT INTO `products_options` VALUES (10, 1, 2, 'Elements Silver Chain', 0, 1);
INSERT INTO `products_options` VALUES (11, 1, 32, 'Product type', 1, 1);
INSERT INTO `products_options` VALUES (12, 1, 35, 'Product Type', 1, 1);
INSERT INTO `products_options` VALUES (13, 1, 35, 'Gender', 1, 1);
INSERT INTO `products_options` VALUES (14, 1, 35, 'Metal', 1, 1);
INSERT INTO `products_options` VALUES (15, 1, 35, 'Stones', 1, 1);
INSERT INTO `products_options` VALUES (16, 1, 35, 'Fitting', 1, 1);
INSERT INTO `products_options` VALUES (17, 1, 36, 'Gender', 1, 1);
INSERT INTO `products_options` VALUES (18, 1, 36, 'Metal', 1, 1);
INSERT INTO `products_options` VALUES (19, 1, 36, 'Stones', 1, 1);
INSERT INTO `products_options` VALUES (20, 1, 36, 'Product Type', 1, 1);
INSERT INTO `products_options` VALUES (21, 1, 36, 'Chain Length', 1, 1);
INSERT INTO `products_options` VALUES (22, 1, 36, 'Presentation Box', 1, 1);
INSERT INTO `products_options` VALUES (23, 1, 37, 'Metal', 1, 1);
INSERT INTO `products_options` VALUES (24, 1, 37, 'Product Type', 1, 1);
INSERT INTO `products_options` VALUES (25, 1, 37, 'Gender', 1, 1);
INSERT INTO `products_options` VALUES (26, 1, 38, 'Metal', 1, 1);
INSERT INTO `products_options` VALUES (27, 1, 38, 'Product Type', 1, 1);
INSERT INTO `products_options` VALUES (28, 1, 38, 'Gender', 1, 1);
INSERT INTO `products_options` VALUES (29, 1, 2, 'Presentation Box', 1, 1);
INSERT INTO `products_options` VALUES (30, 1, 2, 'Stone', 1, 1);
INSERT INTO `products_options` VALUES (31, 1, 2, 'Fitting', 1, 1);
INSERT INTO `products_options` VALUES (32, 1, 2, 'Gender', 1, 1);
INSERT INTO `products_options` VALUES (33, 1, 35, 'Presentation Box', 1, 1);
INSERT INTO `products_options` VALUES (34, 1, 37, 'Presentation Box', 1, 1);
INSERT INTO `products_options` VALUES (35, 1, 2, 'Chain Length', 1, 1);
INSERT INTO `products_options` VALUES (36, 1, 32, 'Presentation Box', 1, 1);
INSERT INTO `products_options` VALUES (37, 1, 32, 'Capacity', 1, 1);
INSERT INTO `products_options` VALUES (38, 1, 32, 'Metal', 1, 1);
INSERT INTO `products_options` VALUES (39, 1, 32, 'Gender', 1, 1);
INSERT INTO `products_options` VALUES (40, 1, 2, 'Bracelet Length', 1, 1);
INSERT INTO `products_options` VALUES (41, 1, 2, 'Profile', 1, 1);
INSERT INTO `products_options` VALUES (42, 1, 2, 'Width', 1, 1);

-- --------------------------------------------------------

--
-- Table structure for table `products_options_values`
--

CREATE TABLE `products_options_values` (
  `products_options_values_id` int(11) NOT NULL default '0',
  `language_id` int(11) NOT NULL default '1',
  `products_options_values_name` varchar(64) NOT NULL default '',
  PRIMARY KEY  (`products_options_values_id`,`language_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `products_options_values`
--

INSERT INTO `products_options_values` VALUES (1, 1, 'Gents');
INSERT INTO `products_options_values` VALUES (2, 1, 'Ladies');
INSERT INTO `products_options_values` VALUES (3, 1, 'Black');
INSERT INTO `products_options_values` VALUES (4, 1, 'White');
INSERT INTO `products_options_values` VALUES (5, 1, 'Leather');
INSERT INTO `products_options_values` VALUES (6, 1, 'Bracelet');
INSERT INTO `products_options_values` VALUES (7, 1, 'Round');
INSERT INTO `products_options_values` VALUES (8, 1, 'Rectangular');
INSERT INTO `products_options_values` VALUES (9, 1, 'Water Resistant');
INSERT INTO `products_options_values` VALUES (10, 1, '50m');
INSERT INTO `products_options_values` VALUES (11, 1, '100m');
INSERT INTO `products_options_values` VALUES (12, 1, 'Stainless Steel');
INSERT INTO `products_options_values` VALUES (13, 1, 'All Stainless Steel Gold Tone');
INSERT INTO `products_options_values` VALUES (14, 1, 'Champagne');
INSERT INTO `products_options_values` VALUES (15, 1, 'Brown');
INSERT INTO `products_options_values` VALUES (16, 1, 'Blue');
INSERT INTO `products_options_values` VALUES (20, 1, 'Leather, Black');
INSERT INTO `products_options_values` VALUES (18, 1, 'Leather, Brown');
INSERT INTO `products_options_values` VALUES (19, 1, 'Stainless Steel Two Tone');
INSERT INTO `products_options_values` VALUES (21, 1, 'Mother Of Pearl');
INSERT INTO `products_options_values` VALUES (22, 1, 'Oval');
INSERT INTO `products_options_values` VALUES (23, 1, 'Square');
INSERT INTO `products_options_values` VALUES (24, 1, 'Titanium');
INSERT INTO `products_options_values` VALUES (25, 1, 'Silver');
INSERT INTO `products_options_values` VALUES (26, 1, 'Chrome coloured');
INSERT INTO `products_options_values` VALUES (27, 1, 'Gold plated');
INSERT INTO `products_options_values` VALUES (28, 1, 'Two Tone');
INSERT INTO `products_options_values` VALUES (29, 1, '30m');
INSERT INTO `products_options_values` VALUES (30, 1, '200m');
INSERT INTO `products_options_values` VALUES (31, 1, 'Pink');
INSERT INTO `products_options_values` VALUES (32, 1, 'Cream');
INSERT INTO `products_options_values` VALUES (33, 1, 'Sterling Silver');
INSERT INTO `products_options_values` VALUES (34, 1, 'Bracelet');
INSERT INTO `products_options_values` VALUES (35, 1, 'Earrings');
INSERT INTO `products_options_values` VALUES (36, 1, 'Pendant');
INSERT INTO `products_options_values` VALUES (37, 1, 'Bangle');
INSERT INTO `products_options_values` VALUES (38, 1, 'Necklace');
INSERT INTO `products_options_values` VALUES (39, 1, 'Locket');
INSERT INTO `products_options_values` VALUES (40, 1, 'Leather, White');
INSERT INTO `products_options_values` VALUES (41, 1, 'Cufflinks');
INSERT INTO `products_options_values` VALUES (42, 1, '16" Small D/C Curb');
INSERT INTO `products_options_values` VALUES (43, 1, '18" Small D/C Curb');
INSERT INTO `products_options_values` VALUES (44, 1, '16" Med D/C Curb');
INSERT INTO `products_options_values` VALUES (45, 1, '18" Med D/C Curb');
INSERT INTO `products_options_values` VALUES (46, 1, '20" Med D/C Curb');
INSERT INTO `products_options_values` VALUES (47, 1, '18" Plain Curb');
INSERT INTO `products_options_values` VALUES (48, 1, '20" Plain Curb');
INSERT INTO `products_options_values` VALUES (49, 1, '24" Plain Curb');
INSERT INTO `products_options_values` VALUES (50, 1, '16" Snake');
INSERT INTO `products_options_values` VALUES (51, 1, '18" Snake');
INSERT INTO `products_options_values` VALUES (52, 1, 'Aqua');
INSERT INTO `products_options_values` VALUES (53, 1, 'Green');
INSERT INTO `products_options_values` VALUES (54, 1, 'Orange');
INSERT INTO `products_options_values` VALUES (55, 1, 'Purple');
INSERT INTO `products_options_values` VALUES (56, 1, 'Yellow');
INSERT INTO `products_options_values` VALUES (57, 1, 'Quaich');
INSERT INTO `products_options_values` VALUES (58, 1, 'Hip Flask');
INSERT INTO `products_options_values` VALUES (59, 1, 'Cake Knife');
INSERT INTO `products_options_values` VALUES (60, 1, 'Cake Knife and Slice Set');
INSERT INTO `products_options_values` VALUES (61, 1, 'Letter Opener');
INSERT INTO `products_options_values` VALUES (62, 1, 'Compact Mirror');
INSERT INTO `products_options_values` VALUES (63, 1, 'Silver');
INSERT INTO `products_options_values` VALUES (64, 1, 'Tonneau');
INSERT INTO `products_options_values` VALUES (65, 1, 'Earrings');
INSERT INTO `products_options_values` VALUES (92, 1, 'Cubic Zirconia');
INSERT INTO `products_options_values` VALUES (67, 1, '9ct Gold');
INSERT INTO `products_options_values` VALUES (68, 1, '9ct White Gold');
INSERT INTO `products_options_values` VALUES (69, 1, '9ct White and Yellow Gold');
INSERT INTO `products_options_values` VALUES (70, 1, 'Cubic Zirconia');
INSERT INTO `products_options_values` VALUES (71, 1, 'Diamonds');
INSERT INTO `products_options_values` VALUES (72, 1, 'Ladies');
INSERT INTO `products_options_values` VALUES (73, 1, 'Stud Earrings');
INSERT INTO `products_options_values` VALUES (74, 1, 'Creole Earrings');
INSERT INTO `products_options_values` VALUES (75, 1, 'Hoop Earrings');
INSERT INTO `products_options_values` VALUES (76, 1, 'Tear Drop');
INSERT INTO `products_options_values` VALUES (77, 1, 'Opal');
INSERT INTO `products_options_values` VALUES (78, 1, 'Post and Butterfly');
INSERT INTO `products_options_values` VALUES (79, 1, 'Creole');
INSERT INTO `products_options_values` VALUES (80, 1, '18"/45cm');
INSERT INTO `products_options_values` VALUES (89, 1, '9ct White Gold');
INSERT INTO `products_options_values` VALUES (84, 1, 'Diamond');
INSERT INTO `products_options_values` VALUES (87, 1, 'Ladies');
INSERT INTO `products_options_values` VALUES (88, 1, '9ct Gold');
INSERT INTO `products_options_values` VALUES (90, 1, '9ct White and Yellow Gold');
INSERT INTO `products_options_values` VALUES (91, 1, 'Pendant');
INSERT INTO `products_options_values` VALUES (93, 1, 'Diamond');
INSERT INTO `products_options_values` VALUES (94, 1, 'Diamonds');
INSERT INTO `products_options_values` VALUES (95, 1, 'Yes');
INSERT INTO `products_options_values` VALUES (96, 1, 'Sapphire and Diamond');
INSERT INTO `products_options_values` VALUES (97, 1, 'Opal');
INSERT INTO `products_options_values` VALUES (98, 1, 'Sterling Silver');
INSERT INTO `products_options_values` VALUES (99, 1, 'Glass Beads');
INSERT INTO `products_options_values` VALUES (100, 1, 'Ladies');
INSERT INTO `products_options_values` VALUES (101, 1, 'Ladies');
INSERT INTO `products_options_values` VALUES (102, 1, 'Sterling Silver');
INSERT INTO `products_options_values` VALUES (103, 1, 'Ladies');
INSERT INTO `products_options_values` VALUES (104, 1, 'Silver Charm Beads');
INSERT INTO `products_options_values` VALUES (105, 1, 'Elements Presentation Box');
INSERT INTO `products_options_values` VALUES (106, 1, 'Cubic Zirconia');
INSERT INTO `products_options_values` VALUES (107, 1, 'Blue Cubic Zirconia');
INSERT INTO `products_options_values` VALUES (108, 1, 'Blue Topaz');
INSERT INTO `products_options_values` VALUES (109, 1, 'Pearl');
INSERT INTO `products_options_values` VALUES (110, 1, 'Post and Butterfly');
INSERT INTO `products_options_values` VALUES (111, 1, 'Hook');
INSERT INTO `products_options_values` VALUES (112, 1, 'Black Cubic Zirconia');
INSERT INTO `products_options_values` VALUES (113, 1, 'Creole');
INSERT INTO `products_options_values` VALUES (114, 1, 'D for Diamond Presentation Box');
INSERT INTO `products_options_values` VALUES (115, 1, 'Childrens');
INSERT INTO `products_options_values` VALUES (116, 1, 'Ladies');
INSERT INTO `products_options_values` VALUES (117, 1, 'Gents');
INSERT INTO `products_options_values` VALUES (118, 1, 'Diamond');
INSERT INTO `products_options_values` VALUES (119, 1, 'Fluid Presentation Box');
INSERT INTO `products_options_values` VALUES (122, 1, 'Stainless Steel');
INSERT INTO `products_options_values` VALUES (121, 1, 'Fred Bennett Presentation Box');
INSERT INTO `products_options_values` VALUES (123, 1, 'Pearl and Cubic Zirconia');
INSERT INTO `products_options_values` VALUES (124, 1, 'Pearl and Cubic Zirconia');
INSERT INTO `products_options_values` VALUES (125, 1, 'J.Mitchell & Son Box');
INSERT INTO `products_options_values` VALUES (126, 1, 'J.Mitchell & Son Box');
INSERT INTO `products_options_values` VALUES (127, 1, '9ct White Gold');
INSERT INTO `products_options_values` VALUES (128, 1, '9ct Gold');
INSERT INTO `products_options_values` VALUES (129, 1, '9ct White and Yellow Gold');
INSERT INTO `products_options_values` VALUES (130, 1, 'J.Mitchell & Son Box');
INSERT INTO `products_options_values` VALUES (131, 1, '18"/45cm');
INSERT INTO `products_options_values` VALUES (132, 1, 'Lid and Base Box');
INSERT INTO `products_options_values` VALUES (133, 1, '3oz');
INSERT INTO `products_options_values` VALUES (134, 1, '4oz');
INSERT INTO `products_options_values` VALUES (135, 1, '6oz');
INSERT INTO `products_options_values` VALUES (136, 1, 'Ladies and Gents');
INSERT INTO `products_options_values` VALUES (137, 1, 'Ladies');
INSERT INTO `products_options_values` VALUES (138, 1, 'Gents');
INSERT INTO `products_options_values` VALUES (139, 1, 'Stainless Steel');
INSERT INTO `products_options_values` VALUES (140, 1, 'Pewter');
INSERT INTO `products_options_values` VALUES (141, 1, 'Silver Plated');
INSERT INTO `products_options_values` VALUES (142, 1, '16"/40cm');
INSERT INTO `products_options_values` VALUES (143, 1, 'Ruby and Diamond');
INSERT INTO `products_options_values` VALUES (144, 1, 'Peridot');
INSERT INTO `products_options_values` VALUES (145, 1, 'Pearl and Diamond');
INSERT INTO `products_options_values` VALUES (146, 1, 'Aquamarine and Diamond');
INSERT INTO `products_options_values` VALUES (147, 1, 'Sapphire and Diamond');
INSERT INTO `products_options_values` VALUES (148, 1, 'Blue Crystal');
INSERT INTO `products_options_values` VALUES (149, 1, 'Simulated Pearl');
INSERT INTO `products_options_values` VALUES (150, 1, '19cm/7.5"');
INSERT INTO `products_options_values` VALUES (151, 1, '21cm/8.25"');
INSERT INTO `products_options_values` VALUES (152, 1, '23cm/9"');
INSERT INTO `products_options_values` VALUES (153, 1, 'D Shape');
INSERT INTO `products_options_values` VALUES (154, 1, 'Court Shape');
INSERT INTO `products_options_values` VALUES (155, 1, 'Flat Court');
INSERT INTO `products_options_values` VALUES (156, 1, 'Flat Court Bevelled Edge');
INSERT INTO `products_options_values` VALUES (157, 1, 'D Shape Mill Grain Edge');
INSERT INTO `products_options_values` VALUES (158, 1, '3mm');
INSERT INTO `products_options_values` VALUES (159, 1, '4mm');
INSERT INTO `products_options_values` VALUES (160, 1, '5mm');
INSERT INTO `products_options_values` VALUES (161, 1, '6mm');
INSERT INTO `products_options_values` VALUES (162, 1, 'Wedding Ring');
INSERT INTO `products_options_values` VALUES (163, 1, 'Ladies or Gents');
INSERT INTO `products_options_values` VALUES (164, 1, 'Stone Encrusted');
INSERT INTO `products_options_values` VALUES (165, 1, 'Emerald and Cubic Zirconia');
INSERT INTO `products_options_values` VALUES (166, 1, 'Pearl and Cubic Zirconia');
INSERT INTO `products_options_values` VALUES (167, 1, 'Luminous');
INSERT INTO `products_options_values` VALUES (168, 1, 'Green');
INSERT INTO `products_options_values` VALUES (169, 1, 'Tiger Eye');
INSERT INTO `products_options_values` VALUES (170, 1, '18ct Gold');
INSERT INTO `products_options_values` VALUES (171, 1, 'Silver Plated');
INSERT INTO `products_options_values` VALUES (172, 1, 'Eternity Ring');
INSERT INTO `products_options_values` VALUES (173, 1, 'Silver Charm Beads');

-- --------------------------------------------------------

--
-- Table structure for table `products_options_values_to_products_options`
--

CREATE TABLE `products_options_values_to_products_options` (
  `products_options_values_to_products_options_id` int(11) NOT NULL auto_increment,
  `products_options_id` int(11) NOT NULL,
  `products_options_values_id` int(11) NOT NULL,
  PRIMARY KEY  (`products_options_values_to_products_options_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=236 ;

--
-- Dumping data for table `products_options_values_to_products_options`
--

INSERT INTO `products_options_values_to_products_options` VALUES (17, 2, 4);
INSERT INTO `products_options_values_to_products_options` VALUES (16, 2, 3);
INSERT INTO `products_options_values_to_products_options` VALUES (15, 1, 2);
INSERT INTO `products_options_values_to_products_options` VALUES (14, 1, 1);
INSERT INTO `products_options_values_to_products_options` VALUES (18, 3, 5);
INSERT INTO `products_options_values_to_products_options` VALUES (20, 3, 6);
INSERT INTO `products_options_values_to_products_options` VALUES (21, 4, 7);
INSERT INTO `products_options_values_to_products_options` VALUES (22, 4, 8);
INSERT INTO `products_options_values_to_products_options` VALUES (23, 6, 9);
INSERT INTO `products_options_values_to_products_options` VALUES (24, 6, 10);
INSERT INTO `products_options_values_to_products_options` VALUES (25, 6, 11);
INSERT INTO `products_options_values_to_products_options` VALUES (26, 5, 12);
INSERT INTO `products_options_values_to_products_options` VALUES (27, 5, 13);
INSERT INTO `products_options_values_to_products_options` VALUES (28, 2, 14);
INSERT INTO `products_options_values_to_products_options` VALUES (29, 2, 15);
INSERT INTO `products_options_values_to_products_options` VALUES (30, 2, 16);
INSERT INTO `products_options_values_to_products_options` VALUES (34, 7, 20);
INSERT INTO `products_options_values_to_products_options` VALUES (32, 7, 18);
INSERT INTO `products_options_values_to_products_options` VALUES (33, 5, 19);
INSERT INTO `products_options_values_to_products_options` VALUES (35, 2, 21);
INSERT INTO `products_options_values_to_products_options` VALUES (36, 4, 22);
INSERT INTO `products_options_values_to_products_options` VALUES (37, 4, 23);
INSERT INTO `products_options_values_to_products_options` VALUES (38, 5, 24);
INSERT INTO `products_options_values_to_products_options` VALUES (39, 5, 25);
INSERT INTO `products_options_values_to_products_options` VALUES (40, 5, 26);
INSERT INTO `products_options_values_to_products_options` VALUES (41, 5, 27);
INSERT INTO `products_options_values_to_products_options` VALUES (42, 5, 28);
INSERT INTO `products_options_values_to_products_options` VALUES (43, 6, 29);
INSERT INTO `products_options_values_to_products_options` VALUES (44, 6, 30);
INSERT INTO `products_options_values_to_products_options` VALUES (45, 2, 31);
INSERT INTO `products_options_values_to_products_options` VALUES (46, 2, 32);
INSERT INTO `products_options_values_to_products_options` VALUES (47, 8, 33);
INSERT INTO `products_options_values_to_products_options` VALUES (48, 9, 34);
INSERT INTO `products_options_values_to_products_options` VALUES (49, 9, 35);
INSERT INTO `products_options_values_to_products_options` VALUES (50, 9, 36);
INSERT INTO `products_options_values_to_products_options` VALUES (51, 9, 37);
INSERT INTO `products_options_values_to_products_options` VALUES (52, 9, 38);
INSERT INTO `products_options_values_to_products_options` VALUES (53, 9, 39);
INSERT INTO `products_options_values_to_products_options` VALUES (54, 7, 40);
INSERT INTO `products_options_values_to_products_options` VALUES (55, 9, 41);
INSERT INTO `products_options_values_to_products_options` VALUES (56, 10, 42);
INSERT INTO `products_options_values_to_products_options` VALUES (57, 10, 43);
INSERT INTO `products_options_values_to_products_options` VALUES (58, 10, 44);
INSERT INTO `products_options_values_to_products_options` VALUES (59, 10, 45);
INSERT INTO `products_options_values_to_products_options` VALUES (60, 10, 46);
INSERT INTO `products_options_values_to_products_options` VALUES (61, 10, 47);
INSERT INTO `products_options_values_to_products_options` VALUES (62, 10, 48);
INSERT INTO `products_options_values_to_products_options` VALUES (63, 10, 49);
INSERT INTO `products_options_values_to_products_options` VALUES (64, 10, 50);
INSERT INTO `products_options_values_to_products_options` VALUES (65, 10, 51);
INSERT INTO `products_options_values_to_products_options` VALUES (66, 2, 52);
INSERT INTO `products_options_values_to_products_options` VALUES (67, 2, 53);
INSERT INTO `products_options_values_to_products_options` VALUES (68, 2, 54);
INSERT INTO `products_options_values_to_products_options` VALUES (69, 2, 55);
INSERT INTO `products_options_values_to_products_options` VALUES (70, 2, 56);
INSERT INTO `products_options_values_to_products_options` VALUES (71, 11, 57);
INSERT INTO `products_options_values_to_products_options` VALUES (72, 11, 58);
INSERT INTO `products_options_values_to_products_options` VALUES (73, 11, 59);
INSERT INTO `products_options_values_to_products_options` VALUES (74, 11, 60);
INSERT INTO `products_options_values_to_products_options` VALUES (75, 11, 61);
INSERT INTO `products_options_values_to_products_options` VALUES (76, 11, 62);
INSERT INTO `products_options_values_to_products_options` VALUES (77, 2, 63);
INSERT INTO `products_options_values_to_products_options` VALUES (78, 4, 64);
INSERT INTO `products_options_values_to_products_options` VALUES (79, 12, 65);
INSERT INTO `products_options_values_to_products_options` VALUES (111, 19, 92);
INSERT INTO `products_options_values_to_products_options` VALUES (81, 14, 67);
INSERT INTO `products_options_values_to_products_options` VALUES (82, 14, 68);
INSERT INTO `products_options_values_to_products_options` VALUES (83, 14, 69);
INSERT INTO `products_options_values_to_products_options` VALUES (84, 15, 70);
INSERT INTO `products_options_values_to_products_options` VALUES (85, 15, 71);
INSERT INTO `products_options_values_to_products_options` VALUES (86, 13, 72);
INSERT INTO `products_options_values_to_products_options` VALUES (87, 12, 73);
INSERT INTO `products_options_values_to_products_options` VALUES (88, 12, 74);
INSERT INTO `products_options_values_to_products_options` VALUES (89, 12, 75);
INSERT INTO `products_options_values_to_products_options` VALUES (90, 4, 76);
INSERT INTO `products_options_values_to_products_options` VALUES (91, 15, 77);
INSERT INTO `products_options_values_to_products_options` VALUES (92, 16, 78);
INSERT INTO `products_options_values_to_products_options` VALUES (93, 16, 79);
INSERT INTO `products_options_values_to_products_options` VALUES (94, 21, 80);
INSERT INTO `products_options_values_to_products_options` VALUES (103, 17, 87);
INSERT INTO `products_options_values_to_products_options` VALUES (106, 18, 88);
INSERT INTO `products_options_values_to_products_options` VALUES (108, 18, 89);
INSERT INTO `products_options_values_to_products_options` VALUES (98, 15, 84);
INSERT INTO `products_options_values_to_products_options` VALUES (109, 18, 90);
INSERT INTO `products_options_values_to_products_options` VALUES (110, 20, 91);
INSERT INTO `products_options_values_to_products_options` VALUES (114, 19, 93);
INSERT INTO `products_options_values_to_products_options` VALUES (115, 19, 94);
INSERT INTO `products_options_values_to_products_options` VALUES (116, 22, 95);
INSERT INTO `products_options_values_to_products_options` VALUES (117, 19, 96);
INSERT INTO `products_options_values_to_products_options` VALUES (118, 19, 97);
INSERT INTO `products_options_values_to_products_options` VALUES (124, 23, 98);
INSERT INTO `products_options_values_to_products_options` VALUES (126, 24, 99);
INSERT INTO `products_options_values_to_products_options` VALUES (127, 25, 100);
INSERT INTO `products_options_values_to_products_options` VALUES (129, 13, 101);
INSERT INTO `products_options_values_to_products_options` VALUES (130, 26, 102);
INSERT INTO `products_options_values_to_products_options` VALUES (136, 28, 103);
INSERT INTO `products_options_values_to_products_options` VALUES (138, 27, 104);
INSERT INTO `products_options_values_to_products_options` VALUES (139, 29, 105);
INSERT INTO `products_options_values_to_products_options` VALUES (140, 30, 106);
INSERT INTO `products_options_values_to_products_options` VALUES (141, 30, 107);
INSERT INTO `products_options_values_to_products_options` VALUES (142, 30, 108);
INSERT INTO `products_options_values_to_products_options` VALUES (143, 30, 109);
INSERT INTO `products_options_values_to_products_options` VALUES (144, 31, 110);
INSERT INTO `products_options_values_to_products_options` VALUES (145, 31, 111);
INSERT INTO `products_options_values_to_products_options` VALUES (146, 30, 112);
INSERT INTO `products_options_values_to_products_options` VALUES (147, 31, 113);
INSERT INTO `products_options_values_to_products_options` VALUES (148, 29, 114);
INSERT INTO `products_options_values_to_products_options` VALUES (155, 32, 115);
INSERT INTO `products_options_values_to_products_options` VALUES (156, 32, 116);
INSERT INTO `products_options_values_to_products_options` VALUES (157, 32, 117);
INSERT INTO `products_options_values_to_products_options` VALUES (158, 30, 118);
INSERT INTO `products_options_values_to_products_options` VALUES (159, 29, 119);
INSERT INTO `products_options_values_to_products_options` VALUES (163, 8, 122);
INSERT INTO `products_options_values_to_products_options` VALUES (161, 29, 121);
INSERT INTO `products_options_values_to_products_options` VALUES (164, 19, 123);
INSERT INTO `products_options_values_to_products_options` VALUES (165, 15, 124);
INSERT INTO `products_options_values_to_products_options` VALUES (166, 33, 125);
INSERT INTO `products_options_values_to_products_options` VALUES (168, 34, 126);
INSERT INTO `products_options_values_to_products_options` VALUES (172, 8, 127);
INSERT INTO `products_options_values_to_products_options` VALUES (173, 8, 128);
INSERT INTO `products_options_values_to_products_options` VALUES (174, 8, 129);
INSERT INTO `products_options_values_to_products_options` VALUES (175, 29, 130);
INSERT INTO `products_options_values_to_products_options` VALUES (176, 35, 131);
INSERT INTO `products_options_values_to_products_options` VALUES (178, 36, 132);
INSERT INTO `products_options_values_to_products_options` VALUES (179, 37, 133);
INSERT INTO `products_options_values_to_products_options` VALUES (180, 37, 134);
INSERT INTO `products_options_values_to_products_options` VALUES (181, 37, 135);
INSERT INTO `products_options_values_to_products_options` VALUES (183, 39, 136);
INSERT INTO `products_options_values_to_products_options` VALUES (184, 39, 137);
INSERT INTO `products_options_values_to_products_options` VALUES (185, 39, 138);
INSERT INTO `products_options_values_to_products_options` VALUES (190, 38, 139);
INSERT INTO `products_options_values_to_products_options` VALUES (191, 38, 140);
INSERT INTO `products_options_values_to_products_options` VALUES (192, 38, 141);
INSERT INTO `products_options_values_to_products_options` VALUES (193, 35, 142);
INSERT INTO `products_options_values_to_products_options` VALUES (194, 30, 143);
INSERT INTO `products_options_values_to_products_options` VALUES (195, 30, 144);
INSERT INTO `products_options_values_to_products_options` VALUES (196, 30, 145);
INSERT INTO `products_options_values_to_products_options` VALUES (197, 30, 146);
INSERT INTO `products_options_values_to_products_options` VALUES (198, 30, 147);
INSERT INTO `products_options_values_to_products_options` VALUES (199, 30, 148);
INSERT INTO `products_options_values_to_products_options` VALUES (200, 30, 149);
INSERT INTO `products_options_values_to_products_options` VALUES (201, 40, 150);
INSERT INTO `products_options_values_to_products_options` VALUES (202, 40, 151);
INSERT INTO `products_options_values_to_products_options` VALUES (203, 40, 152);
INSERT INTO `products_options_values_to_products_options` VALUES (204, 41, 153);
INSERT INTO `products_options_values_to_products_options` VALUES (205, 41, 154);
INSERT INTO `products_options_values_to_products_options` VALUES (206, 41, 155);
INSERT INTO `products_options_values_to_products_options` VALUES (207, 41, 156);
INSERT INTO `products_options_values_to_products_options` VALUES (208, 41, 157);
INSERT INTO `products_options_values_to_products_options` VALUES (209, 42, 158);
INSERT INTO `products_options_values_to_products_options` VALUES (210, 42, 159);
INSERT INTO `products_options_values_to_products_options` VALUES (211, 42, 160);
INSERT INTO `products_options_values_to_products_options` VALUES (212, 42, 161);
INSERT INTO `products_options_values_to_products_options` VALUES (213, 9, 162);
INSERT INTO `products_options_values_to_products_options` VALUES (221, 32, 163);
INSERT INTO `products_options_values_to_products_options` VALUES (222, 2, 164);
INSERT INTO `products_options_values_to_products_options` VALUES (223, 30, 165);
INSERT INTO `products_options_values_to_products_options` VALUES (224, 30, 166);
INSERT INTO `products_options_values_to_products_options` VALUES (225, 2, 167);
INSERT INTO `products_options_values_to_products_options` VALUES (226, 7, 168);
INSERT INTO `products_options_values_to_products_options` VALUES (227, 2, 169);
INSERT INTO `products_options_values_to_products_options` VALUES (230, 8, 170);
INSERT INTO `products_options_values_to_products_options` VALUES (233, 5, 171);
INSERT INTO `products_options_values_to_products_options` VALUES (234, 9, 172);
INSERT INTO `products_options_values_to_products_options` VALUES (235, 9, 173);

-- --------------------------------------------------------

--
-- Table structure for table `products_to_attributes_group`
--

CREATE TABLE `products_to_attributes_group` (
  `products_id` int(11) NOT NULL,
  `options_id` int(11) NOT NULL,
  PRIMARY KEY  (`products_id`,`options_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Dumping data for table `products_to_attributes_group`
--

INSERT INTO `products_to_attributes_group` VALUES (222, 10);
INSERT INTO `products_to_attributes_group` VALUES (227, 10);
INSERT INTO `products_to_attributes_group` VALUES (229, 10);
INSERT INTO `products_to_attributes_group` VALUES (231, 10);
INSERT INTO `products_to_attributes_group` VALUES (234, 10);
INSERT INTO `products_to_attributes_group` VALUES (236, 10);
INSERT INTO `products_to_attributes_group` VALUES (239, 10);
INSERT INTO `products_to_attributes_group` VALUES (242, 10);
INSERT INTO `products_to_attributes_group` VALUES (245, 10);
INSERT INTO `products_to_attributes_group` VALUES (247, 10);
INSERT INTO `products_to_attributes_group` VALUES (249, 10);
INSERT INTO `products_to_attributes_group` VALUES (252, 10);
INSERT INTO `products_to_attributes_group` VALUES (254, 10);
INSERT INTO `products_to_attributes_group` VALUES (257, 10);
INSERT INTO `products_to_attributes_group` VALUES (262, 10);
INSERT INTO `products_to_attributes_group` VALUES (264, 10);
INSERT INTO `products_to_attributes_group` VALUES (273, 10);
INSERT INTO `products_to_attributes_group` VALUES (279, 10);
INSERT INTO `products_to_attributes_group` VALUES (281, 10);
INSERT INTO `products_to_attributes_group` VALUES (284, 10);
INSERT INTO `products_to_attributes_group` VALUES (287, 10);
INSERT INTO `products_to_attributes_group` VALUES (289, 10);
INSERT INTO `products_to_attributes_group` VALUES (291, 10);
INSERT INTO `products_to_attributes_group` VALUES (293, 10);
INSERT INTO `products_to_attributes_group` VALUES (295, 10);
INSERT INTO `products_to_attributes_group` VALUES (299, 10);
INSERT INTO `products_to_attributes_group` VALUES (301, 10);
INSERT INTO `products_to_attributes_group` VALUES (304, 10);
INSERT INTO `products_to_attributes_group` VALUES (306, 10);
INSERT INTO `products_to_attributes_group` VALUES (307, 10);
INSERT INTO `products_to_attributes_group` VALUES (316, 10);
INSERT INTO `products_to_attributes_group` VALUES (318, 10);

-- --------------------------------------------------------

--
-- Table structure for table `products_to_categories`
--

CREATE TABLE `products_to_categories` (
  `products_id` int(11) NOT NULL,
  `categories_id` int(11) NOT NULL,
  PRIMARY KEY  (`products_id`,`categories_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `products_to_categories`
--

INSERT INTO `products_to_categories` VALUES (1, 12);
INSERT INTO `products_to_categories` VALUES (3, 12);
INSERT INTO `products_to_categories` VALUES (5, 12);
INSERT INTO `products_to_categories` VALUES (6, 12);
INSERT INTO `products_to_categories` VALUES (7, 12);
INSERT INTO `products_to_categories` VALUES (8, 12);
INSERT INTO `products_to_categories` VALUES (9, 12);
INSERT INTO `products_to_categories` VALUES (10, 12);
INSERT INTO `products_to_categories` VALUES (11, 12);
INSERT INTO `products_to_categories` VALUES (12, 12);
INSERT INTO `products_to_categories` VALUES (13, 12);
INSERT INTO `products_to_categories` VALUES (14, 12);
INSERT INTO `products_to_categories` VALUES (15, 12);
INSERT INTO `products_to_categories` VALUES (16, 12);
INSERT INTO `products_to_categories` VALUES (17, 12);
INSERT INTO `products_to_categories` VALUES (18, 12);
INSERT INTO `products_to_categories` VALUES (19, 12);
INSERT INTO `products_to_categories` VALUES (20, 12);
INSERT INTO `products_to_categories` VALUES (21, 12);
INSERT INTO `products_to_categories` VALUES (22, 12);
INSERT INTO `products_to_categories` VALUES (23, 12);
INSERT INTO `products_to_categories` VALUES (24, 12);
INSERT INTO `products_to_categories` VALUES (26, 12);
INSERT INTO `products_to_categories` VALUES (27, 12);
INSERT INTO `products_to_categories` VALUES (28, 12);
INSERT INTO `products_to_categories` VALUES (29, 12);
INSERT INTO `products_to_categories` VALUES (30, 12);
INSERT INTO `products_to_categories` VALUES (31, 12);
INSERT INTO `products_to_categories` VALUES (32, 12);
INSERT INTO `products_to_categories` VALUES (33, 12);
INSERT INTO `products_to_categories` VALUES (34, 12);
INSERT INTO `products_to_categories` VALUES (35, 12);
INSERT INTO `products_to_categories` VALUES (36, 12);
INSERT INTO `products_to_categories` VALUES (37, 12);
INSERT INTO `products_to_categories` VALUES (38, 12);
INSERT INTO `products_to_categories` VALUES (39, 12);
INSERT INTO `products_to_categories` VALUES (40, 12);
INSERT INTO `products_to_categories` VALUES (41, 12);
INSERT INTO `products_to_categories` VALUES (42, 12);
INSERT INTO `products_to_categories` VALUES (43, 12);
INSERT INTO `products_to_categories` VALUES (44, 12);
INSERT INTO `products_to_categories` VALUES (45, 13);
INSERT INTO `products_to_categories` VALUES (46, 13);
INSERT INTO `products_to_categories` VALUES (47, 13);
INSERT INTO `products_to_categories` VALUES (48, 13);
INSERT INTO `products_to_categories` VALUES (49, 13);
INSERT INTO `products_to_categories` VALUES (50, 13);
INSERT INTO `products_to_categories` VALUES (51, 13);
INSERT INTO `products_to_categories` VALUES (52, 13);
INSERT INTO `products_to_categories` VALUES (53, 13);
INSERT INTO `products_to_categories` VALUES (54, 13);
INSERT INTO `products_to_categories` VALUES (55, 13);
INSERT INTO `products_to_categories` VALUES (56, 13);
INSERT INTO `products_to_categories` VALUES (57, 13);
INSERT INTO `products_to_categories` VALUES (58, 13);
INSERT INTO `products_to_categories` VALUES (59, 13);
INSERT INTO `products_to_categories` VALUES (60, 13);
INSERT INTO `products_to_categories` VALUES (61, 13);
INSERT INTO `products_to_categories` VALUES (62, 13);
INSERT INTO `products_to_categories` VALUES (63, 13);
INSERT INTO `products_to_categories` VALUES (64, 13);
INSERT INTO `products_to_categories` VALUES (65, 13);
INSERT INTO `products_to_categories` VALUES (66, 13);
INSERT INTO `products_to_categories` VALUES (67, 13);
INSERT INTO `products_to_categories` VALUES (68, 13);
INSERT INTO `products_to_categories` VALUES (69, 13);
INSERT INTO `products_to_categories` VALUES (70, 13);
INSERT INTO `products_to_categories` VALUES (71, 13);
INSERT INTO `products_to_categories` VALUES (72, 13);
INSERT INTO `products_to_categories` VALUES (73, 13);
INSERT INTO `products_to_categories` VALUES (74, 13);
INSERT INTO `products_to_categories` VALUES (75, 13);
INSERT INTO `products_to_categories` VALUES (76, 13);
INSERT INTO `products_to_categories` VALUES (77, 13);
INSERT INTO `products_to_categories` VALUES (78, 12);
INSERT INTO `products_to_categories` VALUES (79, 12);
INSERT INTO `products_to_categories` VALUES (80, 14);
INSERT INTO `products_to_categories` VALUES (81, 14);
INSERT INTO `products_to_categories` VALUES (82, 14);
INSERT INTO `products_to_categories` VALUES (83, 14);
INSERT INTO `products_to_categories` VALUES (84, 14);
INSERT INTO `products_to_categories` VALUES (85, 14);
INSERT INTO `products_to_categories` VALUES (86, 14);
INSERT INTO `products_to_categories` VALUES (87, 14);
INSERT INTO `products_to_categories` VALUES (88, 14);
INSERT INTO `products_to_categories` VALUES (89, 14);
INSERT INTO `products_to_categories` VALUES (90, 14);
INSERT INTO `products_to_categories` VALUES (91, 14);
INSERT INTO `products_to_categories` VALUES (92, 14);
INSERT INTO `products_to_categories` VALUES (93, 14);
INSERT INTO `products_to_categories` VALUES (94, 14);
INSERT INTO `products_to_categories` VALUES (95, 14);
INSERT INTO `products_to_categories` VALUES (96, 14);
INSERT INTO `products_to_categories` VALUES (97, 14);
INSERT INTO `products_to_categories` VALUES (98, 14);
INSERT INTO `products_to_categories` VALUES (100, 14);
INSERT INTO `products_to_categories` VALUES (101, 14);
INSERT INTO `products_to_categories` VALUES (102, 14);
INSERT INTO `products_to_categories` VALUES (103, 14);
INSERT INTO `products_to_categories` VALUES (104, 14);
INSERT INTO `products_to_categories` VALUES (105, 14);
INSERT INTO `products_to_categories` VALUES (106, 14);
INSERT INTO `products_to_categories` VALUES (107, 14);
INSERT INTO `products_to_categories` VALUES (108, 14);
INSERT INTO `products_to_categories` VALUES (109, 14);
INSERT INTO `products_to_categories` VALUES (110, 14);
INSERT INTO `products_to_categories` VALUES (111, 14);
INSERT INTO `products_to_categories` VALUES (112, 14);
INSERT INTO `products_to_categories` VALUES (113, 14);
INSERT INTO `products_to_categories` VALUES (114, 14);
INSERT INTO `products_to_categories` VALUES (115, 15);
INSERT INTO `products_to_categories` VALUES (116, 15);
INSERT INTO `products_to_categories` VALUES (117, 15);
INSERT INTO `products_to_categories` VALUES (118, 15);
INSERT INTO `products_to_categories` VALUES (119, 15);
INSERT INTO `products_to_categories` VALUES (120, 15);
INSERT INTO `products_to_categories` VALUES (122, 15);
INSERT INTO `products_to_categories` VALUES (123, 15);
INSERT INTO `products_to_categories` VALUES (124, 15);
INSERT INTO `products_to_categories` VALUES (125, 15);
INSERT INTO `products_to_categories` VALUES (126, 15);
INSERT INTO `products_to_categories` VALUES (127, 15);
INSERT INTO `products_to_categories` VALUES (128, 15);
INSERT INTO `products_to_categories` VALUES (129, 15);
INSERT INTO `products_to_categories` VALUES (130, 15);
INSERT INTO `products_to_categories` VALUES (131, 15);
INSERT INTO `products_to_categories` VALUES (132, 15);
INSERT INTO `products_to_categories` VALUES (133, 15);
INSERT INTO `products_to_categories` VALUES (134, 15);
INSERT INTO `products_to_categories` VALUES (135, 15);
INSERT INTO `products_to_categories` VALUES (136, 15);
INSERT INTO `products_to_categories` VALUES (137, 15);
INSERT INTO `products_to_categories` VALUES (138, 15);
INSERT INTO `products_to_categories` VALUES (139, 15);
INSERT INTO `products_to_categories` VALUES (140, 15);
INSERT INTO `products_to_categories` VALUES (141, 15);
INSERT INTO `products_to_categories` VALUES (142, 15);
INSERT INTO `products_to_categories` VALUES (143, 15);
INSERT INTO `products_to_categories` VALUES (144, 15);
INSERT INTO `products_to_categories` VALUES (145, 15);
INSERT INTO `products_to_categories` VALUES (146, 15);
INSERT INTO `products_to_categories` VALUES (147, 15);
INSERT INTO `products_to_categories` VALUES (148, 15);
INSERT INTO `products_to_categories` VALUES (150, 15);
INSERT INTO `products_to_categories` VALUES (151, 15);
INSERT INTO `products_to_categories` VALUES (153, 15);
INSERT INTO `products_to_categories` VALUES (154, 6);
INSERT INTO `products_to_categories` VALUES (155, 6);
INSERT INTO `products_to_categories` VALUES (156, 6);
INSERT INTO `products_to_categories` VALUES (157, 6);
INSERT INTO `products_to_categories` VALUES (158, 6);
INSERT INTO `products_to_categories` VALUES (159, 6);
INSERT INTO `products_to_categories` VALUES (160, 6);
INSERT INTO `products_to_categories` VALUES (161, 6);
INSERT INTO `products_to_categories` VALUES (162, 8);
INSERT INTO `products_to_categories` VALUES (163, 8);
INSERT INTO `products_to_categories` VALUES (164, 8);
INSERT INTO `products_to_categories` VALUES (165, 8);
INSERT INTO `products_to_categories` VALUES (166, 8);
INSERT INTO `products_to_categories` VALUES (167, 8);
INSERT INTO `products_to_categories` VALUES (168, 8);
INSERT INTO `products_to_categories` VALUES (169, 8);
INSERT INTO `products_to_categories` VALUES (170, 8);
INSERT INTO `products_to_categories` VALUES (171, 8);
INSERT INTO `products_to_categories` VALUES (172, 8);
INSERT INTO `products_to_categories` VALUES (173, 8);
INSERT INTO `products_to_categories` VALUES (174, 8);
INSERT INTO `products_to_categories` VALUES (175, 8);
INSERT INTO `products_to_categories` VALUES (176, 24);
INSERT INTO `products_to_categories` VALUES (177, 24);
INSERT INTO `products_to_categories` VALUES (178, 24);
INSERT INTO `products_to_categories` VALUES (179, 24);
INSERT INTO `products_to_categories` VALUES (180, 24);
INSERT INTO `products_to_categories` VALUES (181, 24);
INSERT INTO `products_to_categories` VALUES (182, 24);
INSERT INTO `products_to_categories` VALUES (183, 24);
INSERT INTO `products_to_categories` VALUES (184, 24);
INSERT INTO `products_to_categories` VALUES (185, 24);
INSERT INTO `products_to_categories` VALUES (186, 24);
INSERT INTO `products_to_categories` VALUES (187, 24);
INSERT INTO `products_to_categories` VALUES (188, 24);
INSERT INTO `products_to_categories` VALUES (189, 24);
INSERT INTO `products_to_categories` VALUES (190, 24);
INSERT INTO `products_to_categories` VALUES (191, 24);
INSERT INTO `products_to_categories` VALUES (192, 24);
INSERT INTO `products_to_categories` VALUES (193, 24);
INSERT INTO `products_to_categories` VALUES (194, 24);
INSERT INTO `products_to_categories` VALUES (195, 24);
INSERT INTO `products_to_categories` VALUES (196, 24);
INSERT INTO `products_to_categories` VALUES (197, 25);
INSERT INTO `products_to_categories` VALUES (198, 25);
INSERT INTO `products_to_categories` VALUES (199, 25);
INSERT INTO `products_to_categories` VALUES (200, 25);
INSERT INTO `products_to_categories` VALUES (201, 25);
INSERT INTO `products_to_categories` VALUES (202, 25);
INSERT INTO `products_to_categories` VALUES (203, 25);
INSERT INTO `products_to_categories` VALUES (204, 25);
INSERT INTO `products_to_categories` VALUES (205, 25);
INSERT INTO `products_to_categories` VALUES (206, 25);
INSERT INTO `products_to_categories` VALUES (207, 25);
INSERT INTO `products_to_categories` VALUES (208, 25);
INSERT INTO `products_to_categories` VALUES (209, 25);
INSERT INTO `products_to_categories` VALUES (210, 25);
INSERT INTO `products_to_categories` VALUES (211, 25);
INSERT INTO `products_to_categories` VALUES (212, 25);
INSERT INTO `products_to_categories` VALUES (213, 25);
INSERT INTO `products_to_categories` VALUES (214, 25);
INSERT INTO `products_to_categories` VALUES (215, 25);
INSERT INTO `products_to_categories` VALUES (216, 25);
INSERT INTO `products_to_categories` VALUES (217, 25);
INSERT INTO `products_to_categories` VALUES (218, 25);
INSERT INTO `products_to_categories` VALUES (219, 25);
INSERT INTO `products_to_categories` VALUES (220, 16);
INSERT INTO `products_to_categories` VALUES (221, 16);
INSERT INTO `products_to_categories` VALUES (222, 18);
INSERT INTO `products_to_categories` VALUES (223, 17);
INSERT INTO `products_to_categories` VALUES (224, 16);
INSERT INTO `products_to_categories` VALUES (225, 18);
INSERT INTO `products_to_categories` VALUES (226, 16);
INSERT INTO `products_to_categories` VALUES (227, 18);
INSERT INTO `products_to_categories` VALUES (228, 16);
INSERT INTO `products_to_categories` VALUES (229, 18);
INSERT INTO `products_to_categories` VALUES (230, 16);
INSERT INTO `products_to_categories` VALUES (231, 18);
INSERT INTO `products_to_categories` VALUES (232, 17);
INSERT INTO `products_to_categories` VALUES (233, 16);
INSERT INTO `products_to_categories` VALUES (234, 18);
INSERT INTO `products_to_categories` VALUES (235, 16);
INSERT INTO `products_to_categories` VALUES (237, 17);
INSERT INTO `products_to_categories` VALUES (238, 16);
INSERT INTO `products_to_categories` VALUES (239, 18);
INSERT INTO `products_to_categories` VALUES (240, 17);
INSERT INTO `products_to_categories` VALUES (241, 16);
INSERT INTO `products_to_categories` VALUES (242, 18);
INSERT INTO `products_to_categories` VALUES (243, 17);
INSERT INTO `products_to_categories` VALUES (244, 16);
INSERT INTO `products_to_categories` VALUES (245, 18);
INSERT INTO `products_to_categories` VALUES (246, 16);
INSERT INTO `products_to_categories` VALUES (247, 18);
INSERT INTO `products_to_categories` VALUES (248, 16);
INSERT INTO `products_to_categories` VALUES (249, 18);
INSERT INTO `products_to_categories` VALUES (250, 17);
INSERT INTO `products_to_categories` VALUES (251, 16);
INSERT INTO `products_to_categories` VALUES (252, 18);
INSERT INTO `products_to_categories` VALUES (253, 16);
INSERT INTO `products_to_categories` VALUES (254, 18);
INSERT INTO `products_to_categories` VALUES (255, 16);
INSERT INTO `products_to_categories` VALUES (256, 17);
INSERT INTO `products_to_categories` VALUES (257, 18);
INSERT INTO `products_to_categories` VALUES (258, 17);
INSERT INTO `products_to_categories` VALUES (259, 16);
INSERT INTO `products_to_categories` VALUES (261, 16);
INSERT INTO `products_to_categories` VALUES (262, 18);
INSERT INTO `products_to_categories` VALUES (263, 16);
INSERT INTO `products_to_categories` VALUES (264, 18);
INSERT INTO `products_to_categories` VALUES (265, 16);
INSERT INTO `products_to_categories` VALUES (266, 18);
INSERT INTO `products_to_categories` VALUES (267, 16);
INSERT INTO `products_to_categories` VALUES (268, 18);
INSERT INTO `products_to_categories` VALUES (269, 17);
INSERT INTO `products_to_categories` VALUES (270, 16);
INSERT INTO `products_to_categories` VALUES (271, 18);
INSERT INTO `products_to_categories` VALUES (272, 16);
INSERT INTO `products_to_categories` VALUES (273, 18);
INSERT INTO `products_to_categories` VALUES (274, 16);
INSERT INTO `products_to_categories` VALUES (275, 18);
INSERT INTO `products_to_categories` VALUES (276, 16);
INSERT INTO `products_to_categories` VALUES (277, 18);
INSERT INTO `products_to_categories` VALUES (278, 16);
INSERT INTO `products_to_categories` VALUES (279, 18);
INSERT INTO `products_to_categories` VALUES (280, 16);
INSERT INTO `products_to_categories` VALUES (281, 18);
INSERT INTO `products_to_categories` VALUES (282, 17);
INSERT INTO `products_to_categories` VALUES (283, 16);
INSERT INTO `products_to_categories` VALUES (284, 18);
INSERT INTO `products_to_categories` VALUES (285, 17);
INSERT INTO `products_to_categories` VALUES (286, 16);
INSERT INTO `products_to_categories` VALUES (287, 18);
INSERT INTO `products_to_categories` VALUES (288, 16);
INSERT INTO `products_to_categories` VALUES (289, 18);
INSERT INTO `products_to_categories` VALUES (290, 16);
INSERT INTO `products_to_categories` VALUES (291, 18);
INSERT INTO `products_to_categories` VALUES (292, 16);
INSERT INTO `products_to_categories` VALUES (293, 18);
INSERT INTO `products_to_categories` VALUES (294, 16);
INSERT INTO `products_to_categories` VALUES (295, 18);
INSERT INTO `products_to_categories` VALUES (296, 16);
INSERT INTO `products_to_categories` VALUES (297, 18);
INSERT INTO `products_to_categories` VALUES (298, 16);
INSERT INTO `products_to_categories` VALUES (299, 18);
INSERT INTO `products_to_categories` VALUES (300, 16);
INSERT INTO `products_to_categories` VALUES (301, 18);
INSERT INTO `products_to_categories` VALUES (302, 17);
INSERT INTO `products_to_categories` VALUES (303, 16);
INSERT INTO `products_to_categories` VALUES (304, 18);
INSERT INTO `products_to_categories` VALUES (305, 16);
INSERT INTO `products_to_categories` VALUES (306, 18);
INSERT INTO `products_to_categories` VALUES (308, 17);
INSERT INTO `products_to_categories` VALUES (310, 17);
INSERT INTO `products_to_categories` VALUES (311, 17);
INSERT INTO `products_to_categories` VALUES (312, 18);
INSERT INTO `products_to_categories` VALUES (313, 17);
INSERT INTO `products_to_categories` VALUES (314, 17);
INSERT INTO `products_to_categories` VALUES (315, 16);
INSERT INTO `products_to_categories` VALUES (316, 18);
INSERT INTO `products_to_categories` VALUES (317, 16);
INSERT INTO `products_to_categories` VALUES (318, 18);
INSERT INTO `products_to_categories` VALUES (319, 16);
INSERT INTO `products_to_categories` VALUES (320, 20);
INSERT INTO `products_to_categories` VALUES (321, 20);
INSERT INTO `products_to_categories` VALUES (322, 20);
INSERT INTO `products_to_categories` VALUES (323, 20);
INSERT INTO `products_to_categories` VALUES (324, 20);
INSERT INTO `products_to_categories` VALUES (325, 20);
INSERT INTO `products_to_categories` VALUES (326, 20);
INSERT INTO `products_to_categories` VALUES (327, 21);
INSERT INTO `products_to_categories` VALUES (328, 21);
INSERT INTO `products_to_categories` VALUES (329, 21);
INSERT INTO `products_to_categories` VALUES (330, 21);
INSERT INTO `products_to_categories` VALUES (331, 21);
INSERT INTO `products_to_categories` VALUES (332, 21);
INSERT INTO `products_to_categories` VALUES (333, 21);
INSERT INTO `products_to_categories` VALUES (334, 21);
INSERT INTO `products_to_categories` VALUES (335, 23);
INSERT INTO `products_to_categories` VALUES (336, 23);
INSERT INTO `products_to_categories` VALUES (337, 23);
INSERT INTO `products_to_categories` VALUES (338, 23);
INSERT INTO `products_to_categories` VALUES (339, 23);
INSERT INTO `products_to_categories` VALUES (340, 23);
INSERT INTO `products_to_categories` VALUES (341, 23);
INSERT INTO `products_to_categories` VALUES (342, 23);
INSERT INTO `products_to_categories` VALUES (343, 20);
INSERT INTO `products_to_categories` VALUES (344, 20);
INSERT INTO `products_to_categories` VALUES (345, 21);
INSERT INTO `products_to_categories` VALUES (346, 21);
INSERT INTO `products_to_categories` VALUES (347, 21);
INSERT INTO `products_to_categories` VALUES (348, 21);
INSERT INTO `products_to_categories` VALUES (349, 25);
INSERT INTO `products_to_categories` VALUES (350, 25);
INSERT INTO `products_to_categories` VALUES (351, 25);
INSERT INTO `products_to_categories` VALUES (352, 8);
INSERT INTO `products_to_categories` VALUES (353, 8);
INSERT INTO `products_to_categories` VALUES (354, 30);
INSERT INTO `products_to_categories` VALUES (355, 28);
INSERT INTO `products_to_categories` VALUES (356, 31);
INSERT INTO `products_to_categories` VALUES (357, 28);
INSERT INTO `products_to_categories` VALUES (358, 30);
INSERT INTO `products_to_categories` VALUES (359, 28);
INSERT INTO `products_to_categories` VALUES (360, 31);
INSERT INTO `products_to_categories` VALUES (361, 30);
INSERT INTO `products_to_categories` VALUES (362, 28);
INSERT INTO `products_to_categories` VALUES (363, 30);
INSERT INTO `products_to_categories` VALUES (364, 28);
INSERT INTO `products_to_categories` VALUES (365, 30);
INSERT INTO `products_to_categories` VALUES (366, 28);
INSERT INTO `products_to_categories` VALUES (367, 30);
INSERT INTO `products_to_categories` VALUES (368, 31);
INSERT INTO `products_to_categories` VALUES (369, 30);
INSERT INTO `products_to_categories` VALUES (370, 28);
INSERT INTO `products_to_categories` VALUES (371, 31);
INSERT INTO `products_to_categories` VALUES (372, 30);
INSERT INTO `products_to_categories` VALUES (373, 28);
INSERT INTO `products_to_categories` VALUES (374, 30);
INSERT INTO `products_to_categories` VALUES (375, 31);
INSERT INTO `products_to_categories` VALUES (376, 15);
INSERT INTO `products_to_categories` VALUES (377, 15);
INSERT INTO `products_to_categories` VALUES (378, 15);
INSERT INTO `products_to_categories` VALUES (379, 15);
INSERT INTO `products_to_categories` VALUES (380, 15);
INSERT INTO `products_to_categories` VALUES (381, 15);
INSERT INTO `products_to_categories` VALUES (382, 15);
INSERT INTO `products_to_categories` VALUES (383, 15);
INSERT INTO `products_to_categories` VALUES (384, 15);
INSERT INTO `products_to_categories` VALUES (385, 12);
INSERT INTO `products_to_categories` VALUES (386, 25);
INSERT INTO `products_to_categories` VALUES (387, 25);
INSERT INTO `products_to_categories` VALUES (388, 33);
INSERT INTO `products_to_categories` VALUES (389, 33);
INSERT INTO `products_to_categories` VALUES (390, 33);
INSERT INTO `products_to_categories` VALUES (391, 33);
INSERT INTO `products_to_categories` VALUES (392, 33);
INSERT INTO `products_to_categories` VALUES (393, 33);
INSERT INTO `products_to_categories` VALUES (394, 33);
INSERT INTO `products_to_categories` VALUES (395, 33);
INSERT INTO `products_to_categories` VALUES (396, 33);
INSERT INTO `products_to_categories` VALUES (397, 33);
INSERT INTO `products_to_categories` VALUES (398, 33);
INSERT INTO `products_to_categories` VALUES (399, 33);
INSERT INTO `products_to_categories` VALUES (400, 33);
INSERT INTO `products_to_categories` VALUES (401, 33);
INSERT INTO `products_to_categories` VALUES (402, 33);
INSERT INTO `products_to_categories` VALUES (403, 33);
INSERT INTO `products_to_categories` VALUES (404, 33);
INSERT INTO `products_to_categories` VALUES (405, 33);
INSERT INTO `products_to_categories` VALUES (406, 33);
INSERT INTO `products_to_categories` VALUES (407, 33);
INSERT INTO `products_to_categories` VALUES (408, 33);
INSERT INTO `products_to_categories` VALUES (409, 34);
INSERT INTO `products_to_categories` VALUES (410, 34);
INSERT INTO `products_to_categories` VALUES (411, 34);
INSERT INTO `products_to_categories` VALUES (412, 34);
INSERT INTO `products_to_categories` VALUES (413, 34);
INSERT INTO `products_to_categories` VALUES (414, 34);
INSERT INTO `products_to_categories` VALUES (415, 34);
INSERT INTO `products_to_categories` VALUES (416, 34);
INSERT INTO `products_to_categories` VALUES (417, 34);
INSERT INTO `products_to_categories` VALUES (418, 34);
INSERT INTO `products_to_categories` VALUES (419, 34);
INSERT INTO `products_to_categories` VALUES (420, 34);
INSERT INTO `products_to_categories` VALUES (421, 34);
INSERT INTO `products_to_categories` VALUES (422, 34);
INSERT INTO `products_to_categories` VALUES (423, 34);
INSERT INTO `products_to_categories` VALUES (424, 34);
INSERT INTO `products_to_categories` VALUES (425, 34);
INSERT INTO `products_to_categories` VALUES (426, 34);
INSERT INTO `products_to_categories` VALUES (427, 34);
INSERT INTO `products_to_categories` VALUES (428, 34);
INSERT INTO `products_to_categories` VALUES (429, 34);
INSERT INTO `products_to_categories` VALUES (430, 34);
INSERT INTO `products_to_categories` VALUES (431, 34);
INSERT INTO `products_to_categories` VALUES (432, 34);
INSERT INTO `products_to_categories` VALUES (433, 34);
INSERT INTO `products_to_categories` VALUES (434, 34);
INSERT INTO `products_to_categories` VALUES (435, 34);
INSERT INTO `products_to_categories` VALUES (436, 34);
INSERT INTO `products_to_categories` VALUES (437, 34);
INSERT INTO `products_to_categories` VALUES (438, 34);
INSERT INTO `products_to_categories` VALUES (439, 34);
INSERT INTO `products_to_categories` VALUES (440, 34);
INSERT INTO `products_to_categories` VALUES (441, 34);
INSERT INTO `products_to_categories` VALUES (442, 34);
INSERT INTO `products_to_categories` VALUES (443, 34);
INSERT INTO `products_to_categories` VALUES (444, 34);
INSERT INTO `products_to_categories` VALUES (445, 34);
INSERT INTO `products_to_categories` VALUES (446, 34);
INSERT INTO `products_to_categories` VALUES (447, 34);
INSERT INTO `products_to_categories` VALUES (459, 24);
INSERT INTO `products_to_categories` VALUES (460, 24);
INSERT INTO `products_to_categories` VALUES (461, 24);
INSERT INTO `products_to_categories` VALUES (462, 24);
INSERT INTO `products_to_categories` VALUES (463, 25);
INSERT INTO `products_to_categories` VALUES (464, 25);
INSERT INTO `products_to_categories` VALUES (465, 25);
INSERT INTO `products_to_categories` VALUES (466, 25);
INSERT INTO `products_to_categories` VALUES (467, 25);
INSERT INTO `products_to_categories` VALUES (468, 25);
INSERT INTO `products_to_categories` VALUES (469, 25);
INSERT INTO `products_to_categories` VALUES (470, 25);
INSERT INTO `products_to_categories` VALUES (471, 25);
INSERT INTO `products_to_categories` VALUES (472, 25);
INSERT INTO `products_to_categories` VALUES (473, 25);
INSERT INTO `products_to_categories` VALUES (474, 25);
INSERT INTO `products_to_categories` VALUES (475, 25);
INSERT INTO `products_to_categories` VALUES (476, 25);
INSERT INTO `products_to_categories` VALUES (477, 25);
INSERT INTO `products_to_categories` VALUES (478, 24);
INSERT INTO `products_to_categories` VALUES (479, 24);
INSERT INTO `products_to_categories` VALUES (480, 24);
INSERT INTO `products_to_categories` VALUES (482, 24);
INSERT INTO `products_to_categories` VALUES (484, 24);
INSERT INTO `products_to_categories` VALUES (485, 24);
INSERT INTO `products_to_categories` VALUES (486, 24);
INSERT INTO `products_to_categories` VALUES (487, 25);
INSERT INTO `products_to_categories` VALUES (488, 25);
INSERT INTO `products_to_categories` VALUES (490, 18);
INSERT INTO `products_to_categories` VALUES (492, 41);
INSERT INTO `products_to_categories` VALUES (493, 41);
INSERT INTO `products_to_categories` VALUES (494, 41);
INSERT INTO `products_to_categories` VALUES (495, 41);
INSERT INTO `products_to_categories` VALUES (496, 41);
INSERT INTO `products_to_categories` VALUES (497, 41);
INSERT INTO `products_to_categories` VALUES (498, 41);
INSERT INTO `products_to_categories` VALUES (499, 41);
INSERT INTO `products_to_categories` VALUES (500, 41);
INSERT INTO `products_to_categories` VALUES (501, 41);
INSERT INTO `products_to_categories` VALUES (502, 41);
INSERT INTO `products_to_categories` VALUES (503, 36);
INSERT INTO `products_to_categories` VALUES (504, 36);
INSERT INTO `products_to_categories` VALUES (505, 36);
INSERT INTO `products_to_categories` VALUES (506, 36);
INSERT INTO `products_to_categories` VALUES (507, 36);
INSERT INTO `products_to_categories` VALUES (508, 36);
INSERT INTO `products_to_categories` VALUES (509, 36);
INSERT INTO `products_to_categories` VALUES (510, 36);
INSERT INTO `products_to_categories` VALUES (511, 36);
INSERT INTO `products_to_categories` VALUES (512, 36);
INSERT INTO `products_to_categories` VALUES (513, 36);
INSERT INTO `products_to_categories` VALUES (514, 36);
INSERT INTO `products_to_categories` VALUES (515, 36);
INSERT INTO `products_to_categories` VALUES (516, 36);
INSERT INTO `products_to_categories` VALUES (517, 36);
INSERT INTO `products_to_categories` VALUES (518, 37);
INSERT INTO `products_to_categories` VALUES (519, 37);
INSERT INTO `products_to_categories` VALUES (520, 38);
INSERT INTO `products_to_categories` VALUES (521, 38);
INSERT INTO `products_to_categories` VALUES (522, 38);
INSERT INTO `products_to_categories` VALUES (523, 38);
INSERT INTO `products_to_categories` VALUES (524, 38);
INSERT INTO `products_to_categories` VALUES (525, 38);
INSERT INTO `products_to_categories` VALUES (526, 37);
INSERT INTO `products_to_categories` VALUES (527, 37);
INSERT INTO `products_to_categories` VALUES (528, 37);
INSERT INTO `products_to_categories` VALUES (529, 37);
INSERT INTO `products_to_categories` VALUES (530, 37);
INSERT INTO `products_to_categories` VALUES (531, 17);
INSERT INTO `products_to_categories` VALUES (532, 17);
INSERT INTO `products_to_categories` VALUES (533, 17);
INSERT INTO `products_to_categories` VALUES (534, 18);
INSERT INTO `products_to_categories` VALUES (535, 38);
INSERT INTO `products_to_categories` VALUES (536, 38);
INSERT INTO `products_to_categories` VALUES (537, 38);
INSERT INTO `products_to_categories` VALUES (538, 38);
INSERT INTO `products_to_categories` VALUES (539, 38);
INSERT INTO `products_to_categories` VALUES (540, 38);
INSERT INTO `products_to_categories` VALUES (541, 38);
INSERT INTO `products_to_categories` VALUES (542, 38);
INSERT INTO `products_to_categories` VALUES (543, 38);
INSERT INTO `products_to_categories` VALUES (544, 38);
INSERT INTO `products_to_categories` VALUES (545, 38);
INSERT INTO `products_to_categories` VALUES (546, 38);
INSERT INTO `products_to_categories` VALUES (547, 38);
INSERT INTO `products_to_categories` VALUES (548, 38);
INSERT INTO `products_to_categories` VALUES (549, 36);
INSERT INTO `products_to_categories` VALUES (550, 41);
INSERT INTO `products_to_categories` VALUES (551, 37);
INSERT INTO `products_to_categories` VALUES (552, 37);
INSERT INTO `products_to_categories` VALUES (553, 37);
INSERT INTO `products_to_categories` VALUES (554, 37);
INSERT INTO `products_to_categories` VALUES (555, 37);
INSERT INTO `products_to_categories` VALUES (556, 37);
INSERT INTO `products_to_categories` VALUES (557, 37);
INSERT INTO `products_to_categories` VALUES (558, 37);
INSERT INTO `products_to_categories` VALUES (559, 37);
INSERT INTO `products_to_categories` VALUES (560, 37);
INSERT INTO `products_to_categories` VALUES (561, 37);
INSERT INTO `products_to_categories` VALUES (562, 37);
INSERT INTO `products_to_categories` VALUES (563, 37);
INSERT INTO `products_to_categories` VALUES (564, 37);
INSERT INTO `products_to_categories` VALUES (565, 37);
INSERT INTO `products_to_categories` VALUES (566, 37);
INSERT INTO `products_to_categories` VALUES (567, 37);
INSERT INTO `products_to_categories` VALUES (568, 37);
INSERT INTO `products_to_categories` VALUES (569, 37);
INSERT INTO `products_to_categories` VALUES (570, 37);
INSERT INTO `products_to_categories` VALUES (571, 37);
INSERT INTO `products_to_categories` VALUES (572, 16);
INSERT INTO `products_to_categories` VALUES (573, 41);
INSERT INTO `products_to_categories` VALUES (574, 41);
INSERT INTO `products_to_categories` VALUES (575, 41);
INSERT INTO `products_to_categories` VALUES (576, 41);
INSERT INTO `products_to_categories` VALUES (577, 41);
INSERT INTO `products_to_categories` VALUES (578, 41);
INSERT INTO `products_to_categories` VALUES (579, 17);
INSERT INTO `products_to_categories` VALUES (580, 17);
INSERT INTO `products_to_categories` VALUES (581, 37);
INSERT INTO `products_to_categories` VALUES (582, 38);
INSERT INTO `products_to_categories` VALUES (583, 38);
INSERT INTO `products_to_categories` VALUES (584, 38);
INSERT INTO `products_to_categories` VALUES (585, 38);
INSERT INTO `products_to_categories` VALUES (586, 38);
INSERT INTO `products_to_categories` VALUES (587, 38);
INSERT INTO `products_to_categories` VALUES (588, 38);
INSERT INTO `products_to_categories` VALUES (589, 38);
INSERT INTO `products_to_categories` VALUES (590, 38);
INSERT INTO `products_to_categories` VALUES (591, 17);
INSERT INTO `products_to_categories` VALUES (591, 37);
INSERT INTO `products_to_categories` VALUES (591, 38);
INSERT INTO `products_to_categories` VALUES (592, 17);
INSERT INTO `products_to_categories` VALUES (592, 37);
INSERT INTO `products_to_categories` VALUES (592, 38);
INSERT INTO `products_to_categories` VALUES (593, 17);
INSERT INTO `products_to_categories` VALUES (593, 37);
INSERT INTO `products_to_categories` VALUES (593, 38);
INSERT INTO `products_to_categories` VALUES (594, 39);
INSERT INTO `products_to_categories` VALUES (595, 39);
INSERT INTO `products_to_categories` VALUES (596, 39);
INSERT INTO `products_to_categories` VALUES (597, 39);
INSERT INTO `products_to_categories` VALUES (598, 39);
INSERT INTO `products_to_categories` VALUES (599, 39);
INSERT INTO `products_to_categories` VALUES (600, 36);
INSERT INTO `products_to_categories` VALUES (601, 36);
INSERT INTO `products_to_categories` VALUES (602, 36);
INSERT INTO `products_to_categories` VALUES (603, 36);
INSERT INTO `products_to_categories` VALUES (604, 36);
INSERT INTO `products_to_categories` VALUES (605, 36);
INSERT INTO `products_to_categories` VALUES (606, 41);
INSERT INTO `products_to_categories` VALUES (607, 41);
INSERT INTO `products_to_categories` VALUES (608, 41);
INSERT INTO `products_to_categories` VALUES (609, 41);
INSERT INTO `products_to_categories` VALUES (610, 41);
INSERT INTO `products_to_categories` VALUES (611, 41);
INSERT INTO `products_to_categories` VALUES (612, 41);
INSERT INTO `products_to_categories` VALUES (613, 36);
INSERT INTO `products_to_categories` VALUES (614, 36);
INSERT INTO `products_to_categories` VALUES (615, 36);
INSERT INTO `products_to_categories` VALUES (616, 36);
INSERT INTO `products_to_categories` VALUES (617, 17);
INSERT INTO `products_to_categories` VALUES (618, 17);
INSERT INTO `products_to_categories` VALUES (619, 17);
INSERT INTO `products_to_categories` VALUES (620, 17);
INSERT INTO `products_to_categories` VALUES (621, 17);
INSERT INTO `products_to_categories` VALUES (622, 16);
INSERT INTO `products_to_categories` VALUES (623, 16);
INSERT INTO `products_to_categories` VALUES (624, 16);
INSERT INTO `products_to_categories` VALUES (625, 16);
INSERT INTO `products_to_categories` VALUES (626, 16);
INSERT INTO `products_to_categories` VALUES (627, 18);
INSERT INTO `products_to_categories` VALUES (628, 18);
INSERT INTO `products_to_categories` VALUES (629, 41);
INSERT INTO `products_to_categories` VALUES (630, 41);
INSERT INTO `products_to_categories` VALUES (631, 40);
INSERT INTO `products_to_categories` VALUES (632, 40);
INSERT INTO `products_to_categories` VALUES (633, 40);
INSERT INTO `products_to_categories` VALUES (634, 40);
INSERT INTO `products_to_categories` VALUES (635, 40);
INSERT INTO `products_to_categories` VALUES (636, 40);
INSERT INTO `products_to_categories` VALUES (637, 40);
INSERT INTO `products_to_categories` VALUES (638, 41);
INSERT INTO `products_to_categories` VALUES (639, 40);
INSERT INTO `products_to_categories` VALUES (640, 40);
INSERT INTO `products_to_categories` VALUES (641, 40);
INSERT INTO `products_to_categories` VALUES (642, 40);
INSERT INTO `products_to_categories` VALUES (643, 40);
INSERT INTO `products_to_categories` VALUES (644, 40);
INSERT INTO `products_to_categories` VALUES (645, 40);
INSERT INTO `products_to_categories` VALUES (646, 40);
INSERT INTO `products_to_categories` VALUES (647, 18);
INSERT INTO `products_to_categories` VALUES (648, 40);
INSERT INTO `products_to_categories` VALUES (649, 40);
INSERT INTO `products_to_categories` VALUES (650, 41);
INSERT INTO `products_to_categories` VALUES (651, 41);
INSERT INTO `products_to_categories` VALUES (652, 40);
INSERT INTO `products_to_categories` VALUES (653, 41);
INSERT INTO `products_to_categories` VALUES (654, 41);
INSERT INTO `products_to_categories` VALUES (655, 40);
INSERT INTO `products_to_categories` VALUES (656, 41);
INSERT INTO `products_to_categories` VALUES (657, 40);
INSERT INTO `products_to_categories` VALUES (658, 40);
INSERT INTO `products_to_categories` VALUES (659, 40);
INSERT INTO `products_to_categories` VALUES (660, 41);
INSERT INTO `products_to_categories` VALUES (661, 41);
INSERT INTO `products_to_categories` VALUES (662, 41);
INSERT INTO `products_to_categories` VALUES (663, 41);
INSERT INTO `products_to_categories` VALUES (664, 41);
INSERT INTO `products_to_categories` VALUES (665, 41);
INSERT INTO `products_to_categories` VALUES (666, 41);
INSERT INTO `products_to_categories` VALUES (667, 41);
INSERT INTO `products_to_categories` VALUES (668, 41);
INSERT INTO `products_to_categories` VALUES (669, 17);
INSERT INTO `products_to_categories` VALUES (669, 37);
INSERT INTO `products_to_categories` VALUES (669, 38);
INSERT INTO `products_to_categories` VALUES (670, 17);
INSERT INTO `products_to_categories` VALUES (670, 37);
INSERT INTO `products_to_categories` VALUES (670, 38);
INSERT INTO `products_to_categories` VALUES (671, 16);
INSERT INTO `products_to_categories` VALUES (672, 17);
INSERT INTO `products_to_categories` VALUES (672, 37);
INSERT INTO `products_to_categories` VALUES (672, 38);
INSERT INTO `products_to_categories` VALUES (673, 6);
INSERT INTO `products_to_categories` VALUES (674, 6);
INSERT INTO `products_to_categories` VALUES (675, 6);
INSERT INTO `products_to_categories` VALUES (676, 6);
INSERT INTO `products_to_categories` VALUES (677, 40);
INSERT INTO `products_to_categories` VALUES (678, 38);
INSERT INTO `products_to_categories` VALUES (679, 25);
INSERT INTO `products_to_categories` VALUES (680, 37);
INSERT INTO `products_to_categories` VALUES (681, 18);
INSERT INTO `products_to_categories` VALUES (682, 25);
INSERT INTO `products_to_categories` VALUES (683, 43);
INSERT INTO `products_to_categories` VALUES (684, 43);
INSERT INTO `products_to_categories` VALUES (685, 43);
INSERT INTO `products_to_categories` VALUES (686, 43);
INSERT INTO `products_to_categories` VALUES (687, 43);
INSERT INTO `products_to_categories` VALUES (688, 43);
INSERT INTO `products_to_categories` VALUES (689, 43);
INSERT INTO `products_to_categories` VALUES (690, 43);
INSERT INTO `products_to_categories` VALUES (691, 43);
INSERT INTO `products_to_categories` VALUES (692, 43);
INSERT INTO `products_to_categories` VALUES (693, 43);
INSERT INTO `products_to_categories` VALUES (694, 43);
INSERT INTO `products_to_categories` VALUES (695, 43);
INSERT INTO `products_to_categories` VALUES (696, 43);
INSERT INTO `products_to_categories` VALUES (697, 43);
INSERT INTO `products_to_categories` VALUES (698, 43);
INSERT INTO `products_to_categories` VALUES (699, 43);
INSERT INTO `products_to_categories` VALUES (700, 43);
INSERT INTO `products_to_categories` VALUES (701, 43);
INSERT INTO `products_to_categories` VALUES (702, 43);
INSERT INTO `products_to_categories` VALUES (703, 43);
INSERT INTO `products_to_categories` VALUES (704, 43);
INSERT INTO `products_to_categories` VALUES (705, 43);
INSERT INTO `products_to_categories` VALUES (706, 43);
INSERT INTO `products_to_categories` VALUES (707, 43);
INSERT INTO `products_to_categories` VALUES (708, 43);
INSERT INTO `products_to_categories` VALUES (709, 43);
INSERT INTO `products_to_categories` VALUES (710, 43);
INSERT INTO `products_to_categories` VALUES (711, 43);
INSERT INTO `products_to_categories` VALUES (712, 43);
INSERT INTO `products_to_categories` VALUES (713, 43);
INSERT INTO `products_to_categories` VALUES (714, 43);
INSERT INTO `products_to_categories` VALUES (715, 43);
INSERT INTO `products_to_categories` VALUES (716, 6);
INSERT INTO `products_to_categories` VALUES (717, 41);
INSERT INTO `products_to_categories` VALUES (718, 41);
INSERT INTO `products_to_categories` VALUES (719, 41);
INSERT INTO `products_to_categories` VALUES (720, 41);
INSERT INTO `products_to_categories` VALUES (721, 41);
INSERT INTO `products_to_categories` VALUES (722, 41);
INSERT INTO `products_to_categories` VALUES (723, 41);
INSERT INTO `products_to_categories` VALUES (724, 41);
INSERT INTO `products_to_categories` VALUES (725, 41);
INSERT INTO `products_to_categories` VALUES (726, 41);
INSERT INTO `products_to_categories` VALUES (727, 41);
INSERT INTO `products_to_categories` VALUES (728, 41);
INSERT INTO `products_to_categories` VALUES (729, 18);
INSERT INTO `products_to_categories` VALUES (730, 18);
INSERT INTO `products_to_categories` VALUES (731, 40);
INSERT INTO `products_to_categories` VALUES (732, 40);
INSERT INTO `products_to_categories` VALUES (733, 40);
INSERT INTO `products_to_categories` VALUES (734, 40);
INSERT INTO `products_to_categories` VALUES (735, 14);
INSERT INTO `products_to_categories` VALUES (736, 14);
INSERT INTO `products_to_categories` VALUES (737, 14);
INSERT INTO `products_to_categories` VALUES (738, 14);
INSERT INTO `products_to_categories` VALUES (739, 14);
INSERT INTO `products_to_categories` VALUES (740, 14);
INSERT INTO `products_to_categories` VALUES (741, 14);
INSERT INTO `products_to_categories` VALUES (742, 14);
INSERT INTO `products_to_categories` VALUES (743, 15);
INSERT INTO `products_to_categories` VALUES (744, 15);
INSERT INTO `products_to_categories` VALUES (745, 15);
INSERT INTO `products_to_categories` VALUES (746, 15);
INSERT INTO `products_to_categories` VALUES (747, 15);
INSERT INTO `products_to_categories` VALUES (748, 15);
INSERT INTO `products_to_categories` VALUES (749, 15);
INSERT INTO `products_to_categories` VALUES (750, 15);
INSERT INTO `products_to_categories` VALUES (751, 15);
INSERT INTO `products_to_categories` VALUES (752, 15);
INSERT INTO `products_to_categories` VALUES (753, 14);
INSERT INTO `products_to_categories` VALUES (754, 14);
INSERT INTO `products_to_categories` VALUES (755, 14);
INSERT INTO `products_to_categories` VALUES (756, 14);
INSERT INTO `products_to_categories` VALUES (757, 14);
INSERT INTO `products_to_categories` VALUES (758, 14);
INSERT INTO `products_to_categories` VALUES (759, 25);
INSERT INTO `products_to_categories` VALUES (760, 39);
INSERT INTO `products_to_categories` VALUES (761, 39);
INSERT INTO `products_to_categories` VALUES (762, 39);
INSERT INTO `products_to_categories` VALUES (770, 6);
INSERT INTO `products_to_categories` VALUES (771, 6);
INSERT INTO `products_to_categories` VALUES (772, 25);
INSERT INTO `products_to_categories` VALUES (773, 8);
INSERT INTO `products_to_categories` VALUES (774, 43);
INSERT INTO `products_to_categories` VALUES (775, 43);
INSERT INTO `products_to_categories` VALUES (776, 43);
INSERT INTO `products_to_categories` VALUES (777, 43);
INSERT INTO `products_to_categories` VALUES (778, 38);

-- --------------------------------------------------------

--
-- Table structure for table `products_to_products_extra_fields`
--

CREATE TABLE `products_to_products_extra_fields` (
  `products_id` int(11) NOT NULL default '0',
  `products_extra_fields_id` int(11) NOT NULL default '0',
  `products_extra_fields_value` text,
  PRIMARY KEY  (`products_id`,`products_extra_fields_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Dumping data for table `products_to_products_extra_fields`
--

INSERT INTO `products_to_products_extra_fields` VALUES (5, 1, '239.00');
INSERT INTO `products_to_products_extra_fields` VALUES (6, 1, '189.00');
INSERT INTO `products_to_products_extra_fields` VALUES (7, 1, '269.00');
INSERT INTO `products_to_products_extra_fields` VALUES (8, 1, '269.00');
INSERT INTO `products_to_products_extra_fields` VALUES (9, 1, '189.00');
INSERT INTO `products_to_products_extra_fields` VALUES (10, 1, '269.00');
INSERT INTO `products_to_products_extra_fields` VALUES (11, 1, '279.00');
INSERT INTO `products_to_products_extra_fields` VALUES (12, 1, '199');
INSERT INTO `products_to_products_extra_fields` VALUES (13, 1, '219.00');
INSERT INTO `products_to_products_extra_fields` VALUES (14, 1, '249.00');
INSERT INTO `products_to_products_extra_fields` VALUES (15, 1, '149.00');
INSERT INTO `products_to_products_extra_fields` VALUES (16, 1, '149.00');
INSERT INTO `products_to_products_extra_fields` VALUES (17, 1, '149.00');
INSERT INTO `products_to_products_extra_fields` VALUES (18, 1, '249.00');
INSERT INTO `products_to_products_extra_fields` VALUES (19, 1, '299.00');
INSERT INTO `products_to_products_extra_fields` VALUES (20, 1, '269.00');
INSERT INTO `products_to_products_extra_fields` VALUES (21, 1, '99.95');
INSERT INTO `products_to_products_extra_fields` VALUES (22, 1, '289.00');
INSERT INTO `products_to_products_extra_fields` VALUES (23, 1, '179.00');
INSERT INTO `products_to_products_extra_fields` VALUES (24, 1, '179.00');
INSERT INTO `products_to_products_extra_fields` VALUES (461, 1, '50');
INSERT INTO `products_to_products_extra_fields` VALUES (26, 1, '110.00');
INSERT INTO `products_to_products_extra_fields` VALUES (27, 1, '110.00');
INSERT INTO `products_to_products_extra_fields` VALUES (28, 1, '129.00');
INSERT INTO `products_to_products_extra_fields` VALUES (29, 1, '139.00');
INSERT INTO `products_to_products_extra_fields` VALUES (30, 1, '149.00');
INSERT INTO `products_to_products_extra_fields` VALUES (31, 1, '179.00');
INSERT INTO `products_to_products_extra_fields` VALUES (32, 1, '110.00');
INSERT INTO `products_to_products_extra_fields` VALUES (33, 1, '99.95');
INSERT INTO `products_to_products_extra_fields` VALUES (34, 1, '110.00');
INSERT INTO `products_to_products_extra_fields` VALUES (35, 1, '89.95');
INSERT INTO `products_to_products_extra_fields` VALUES (36, 1, '99.95');
INSERT INTO `products_to_products_extra_fields` VALUES (37, 1, '99.95');
INSERT INTO `products_to_products_extra_fields` VALUES (38, 1, '99.95');
INSERT INTO `products_to_products_extra_fields` VALUES (39, 1, '89.95');
INSERT INTO `products_to_products_extra_fields` VALUES (40, 1, '99.95');
INSERT INTO `products_to_products_extra_fields` VALUES (41, 1, '99.95');
INSERT INTO `products_to_products_extra_fields` VALUES (42, 1, '149.00');
INSERT INTO `products_to_products_extra_fields` VALUES (43, 1, '99.95');
INSERT INTO `products_to_products_extra_fields` VALUES (44, 1, '449.00');
INSERT INTO `products_to_products_extra_fields` VALUES (45, 1, '179.00');
INSERT INTO `products_to_products_extra_fields` VALUES (46, 1, '169.00');
INSERT INTO `products_to_products_extra_fields` VALUES (47, 1, '329.00');
INSERT INTO `products_to_products_extra_fields` VALUES (48, 1, '349.00');
INSERT INTO `products_to_products_extra_fields` VALUES (49, 1, '169.00');
INSERT INTO `products_to_products_extra_fields` VALUES (50, 1, '189.00');
INSERT INTO `products_to_products_extra_fields` VALUES (51, 1, '189.00');
INSERT INTO `products_to_products_extra_fields` VALUES (52, 1, '159.00');
INSERT INTO `products_to_products_extra_fields` VALUES (53, 1, '399.00');
INSERT INTO `products_to_products_extra_fields` VALUES (54, 1, '239.00');
INSERT INTO `products_to_products_extra_fields` VALUES (55, 1, '389.00');
INSERT INTO `products_to_products_extra_fields` VALUES (56, 1, '249.00');
INSERT INTO `products_to_products_extra_fields` VALUES (57, 1, '129.00');
INSERT INTO `products_to_products_extra_fields` VALUES (58, 1, '139.00');
INSERT INTO `products_to_products_extra_fields` VALUES (59, 1, '89.95');
INSERT INTO `products_to_products_extra_fields` VALUES (60, 1, '99.95');
INSERT INTO `products_to_products_extra_fields` VALUES (61, 1, '179.00');
INSERT INTO `products_to_products_extra_fields` VALUES (62, 1, '149.00');
INSERT INTO `products_to_products_extra_fields` VALUES (63, 1, '149.00');
INSERT INTO `products_to_products_extra_fields` VALUES (64, 1, '99.95');
INSERT INTO `products_to_products_extra_fields` VALUES (65, 1, '119.00');
INSERT INTO `products_to_products_extra_fields` VALUES (66, 1, '129.00');
INSERT INTO `products_to_products_extra_fields` VALUES (67, 1, '129.00');
INSERT INTO `products_to_products_extra_fields` VALUES (68, 1, '149.00');
INSERT INTO `products_to_products_extra_fields` VALUES (69, 1, '129.00');
INSERT INTO `products_to_products_extra_fields` VALUES (70, 1, '139.00');
INSERT INTO `products_to_products_extra_fields` VALUES (71, 1, '329.00');
INSERT INTO `products_to_products_extra_fields` VALUES (72, 1, '349.00');
INSERT INTO `products_to_products_extra_fields` VALUES (73, 1, '189.00');
INSERT INTO `products_to_products_extra_fields` VALUES (74, 1, '159.00');
INSERT INTO `products_to_products_extra_fields` VALUES (75, 1, '149.00');
INSERT INTO `products_to_products_extra_fields` VALUES (76, 1, '289.00');
INSERT INTO `products_to_products_extra_fields` VALUES (77, 1, '149.00');
INSERT INTO `products_to_products_extra_fields` VALUES (78, 1, '399.00');
INSERT INTO `products_to_products_extra_fields` VALUES (79, 1, '399.00');
INSERT INTO `products_to_products_extra_fields` VALUES (81, 1, '29.9900');
INSERT INTO `products_to_products_extra_fields` VALUES (80, 1, '24.9900');
INSERT INTO `products_to_products_extra_fields` VALUES (82, 1, '39.9900');
INSERT INTO `products_to_products_extra_fields` VALUES (83, 1, '44.9900');
INSERT INTO `products_to_products_extra_fields` VALUES (84, 1, '39.9900');
INSERT INTO `products_to_products_extra_fields` VALUES (85, 1, '44.9900');
INSERT INTO `products_to_products_extra_fields` VALUES (86, 1, '69.9900');
INSERT INTO `products_to_products_extra_fields` VALUES (87, 1, '79.9900');
INSERT INTO `products_to_products_extra_fields` VALUES (88, 1, '34.9900');
INSERT INTO `products_to_products_extra_fields` VALUES (89, 1, '34.9900');
INSERT INTO `products_to_products_extra_fields` VALUES (90, 1, '69.9900');
INSERT INTO `products_to_products_extra_fields` VALUES (91, 1, '34.9900');
INSERT INTO `products_to_products_extra_fields` VALUES (92, 1, '49.9900');
INSERT INTO `products_to_products_extra_fields` VALUES (93, 1, '69.9900');
INSERT INTO `products_to_products_extra_fields` VALUES (94, 1, '27.9900');
INSERT INTO `products_to_products_extra_fields` VALUES (95, 1, '49.9900');
INSERT INTO `products_to_products_extra_fields` VALUES (96, 1, '49.9900');
INSERT INTO `products_to_products_extra_fields` VALUES (97, 1, '39.9900');
INSERT INTO `products_to_products_extra_fields` VALUES (98, 1, '39.9900');
INSERT INTO `products_to_products_extra_fields` VALUES (738, 1, '49.99');
INSERT INTO `products_to_products_extra_fields` VALUES (100, 1, '39.9900');
INSERT INTO `products_to_products_extra_fields` VALUES (101, 1, '19.9900');
INSERT INTO `products_to_products_extra_fields` VALUES (102, 1, '19.9900');
INSERT INTO `products_to_products_extra_fields` VALUES (103, 1, '39.9900');
INSERT INTO `products_to_products_extra_fields` VALUES (104, 1, '29.9900');
INSERT INTO `products_to_products_extra_fields` VALUES (105, 1, '27.9900');
INSERT INTO `products_to_products_extra_fields` VALUES (106, 1, '27.9900');
INSERT INTO `products_to_products_extra_fields` VALUES (107, 1, '19.9900');
INSERT INTO `products_to_products_extra_fields` VALUES (108, 1, '59.9900');
INSERT INTO `products_to_products_extra_fields` VALUES (109, 1, '44.9900');
INSERT INTO `products_to_products_extra_fields` VALUES (110, 1, '69.9900');
INSERT INTO `products_to_products_extra_fields` VALUES (111, 1, '69.9900');
INSERT INTO `products_to_products_extra_fields` VALUES (112, 1, '34.9900');
INSERT INTO `products_to_products_extra_fields` VALUES (113, 1, '29.9900');
INSERT INTO `products_to_products_extra_fields` VALUES (114, 1, '19.9900');
INSERT INTO `products_to_products_extra_fields` VALUES (115, 1, '34.9900');
INSERT INTO `products_to_products_extra_fields` VALUES (116, 1, '29.9900');
INSERT INTO `products_to_products_extra_fields` VALUES (117, 1, '37.9900');
INSERT INTO `products_to_products_extra_fields` VALUES (118, 1, '49.99');
INSERT INTO `products_to_products_extra_fields` VALUES (119, 1, '19.9900');
INSERT INTO `products_to_products_extra_fields` VALUES (120, 1, '29.9900');
INSERT INTO `products_to_products_extra_fields` VALUES (385, 1, '169');
INSERT INTO `products_to_products_extra_fields` VALUES (122, 1, '44.9900');
INSERT INTO `products_to_products_extra_fields` VALUES (123, 1, '39.99');
INSERT INTO `products_to_products_extra_fields` VALUES (124, 1, '49.9900');
INSERT INTO `products_to_products_extra_fields` VALUES (125, 1, '39.9900');
INSERT INTO `products_to_products_extra_fields` VALUES (126, 1, '27.9900');
INSERT INTO `products_to_products_extra_fields` VALUES (127, 1, '39.9900');
INSERT INTO `products_to_products_extra_fields` VALUES (128, 1, '49.9900');
INSERT INTO `products_to_products_extra_fields` VALUES (129, 1, '29.9900');
INSERT INTO `products_to_products_extra_fields` VALUES (130, 1, '39.9900');
INSERT INTO `products_to_products_extra_fields` VALUES (131, 1, '39.9900');
INSERT INTO `products_to_products_extra_fields` VALUES (132, 1, '44.9900');
INSERT INTO `products_to_products_extra_fields` VALUES (133, 1, '0.0000');
INSERT INTO `products_to_products_extra_fields` VALUES (134, 1, '44.9900');
INSERT INTO `products_to_products_extra_fields` VALUES (135, 1, '19.9900');
INSERT INTO `products_to_products_extra_fields` VALUES (136, 1, '27.9900');
INSERT INTO `products_to_products_extra_fields` VALUES (137, 1, '29.9900');
INSERT INTO `products_to_products_extra_fields` VALUES (138, 1, '24.9900');
INSERT INTO `products_to_products_extra_fields` VALUES (139, 1, '22.9900');
INSERT INTO `products_to_products_extra_fields` VALUES (140, 1, '27.9900');
INSERT INTO `products_to_products_extra_fields` VALUES (141, 1, '27.9900');
INSERT INTO `products_to_products_extra_fields` VALUES (142, 1, '39.9900');
INSERT INTO `products_to_products_extra_fields` VALUES (143, 1, '29.9900');
INSERT INTO `products_to_products_extra_fields` VALUES (144, 1, '39.9900');
INSERT INTO `products_to_products_extra_fields` VALUES (145, 1, '37.9900');
INSERT INTO `products_to_products_extra_fields` VALUES (146, 1, '29.9900');
INSERT INTO `products_to_products_extra_fields` VALUES (147, 1, '39.9900');
INSERT INTO `products_to_products_extra_fields` VALUES (148, 1, '29.99');
INSERT INTO `products_to_products_extra_fields` VALUES (727, 1, '21');
INSERT INTO `products_to_products_extra_fields` VALUES (150, 1, '29.9900');
INSERT INTO `products_to_products_extra_fields` VALUES (151, 1, '24.9900');
INSERT INTO `products_to_products_extra_fields` VALUES (462, 1, '50');
INSERT INTO `products_to_products_extra_fields` VALUES (153, 1, '24.9900');
INSERT INTO `products_to_products_extra_fields` VALUES (154, 1, '69.9900');
INSERT INTO `products_to_products_extra_fields` VALUES (155, 1, '69.9900');
INSERT INTO `products_to_products_extra_fields` VALUES (156, 1, '69.9900');
INSERT INTO `products_to_products_extra_fields` VALUES (157, 1, '69.9900');
INSERT INTO `products_to_products_extra_fields` VALUES (158, 1, '69.9900');
INSERT INTO `products_to_products_extra_fields` VALUES (159, 1, '69.9900');
INSERT INTO `products_to_products_extra_fields` VALUES (160, 1, '69.9900');
INSERT INTO `products_to_products_extra_fields` VALUES (161, 1, '49.9900');
INSERT INTO `products_to_products_extra_fields` VALUES (162, 1, '34.95');
INSERT INTO `products_to_products_extra_fields` VALUES (163, 1, '49.95');
INSERT INTO `products_to_products_extra_fields` VALUES (164, 1, '34.95');
INSERT INTO `products_to_products_extra_fields` VALUES (165, 1, '44.95');
INSERT INTO `products_to_products_extra_fields` VALUES (166, 1, '49.95');
INSERT INTO `products_to_products_extra_fields` VALUES (167, 1, '49.95');
INSERT INTO `products_to_products_extra_fields` VALUES (168, 1, '34.95');
INSERT INTO `products_to_products_extra_fields` VALUES (169, 1, '24.95');
INSERT INTO `products_to_products_extra_fields` VALUES (170, 1, '39.95');
INSERT INTO `products_to_products_extra_fields` VALUES (171, 1, '29.95');
INSERT INTO `products_to_products_extra_fields` VALUES (172, 1, '34.95');
INSERT INTO `products_to_products_extra_fields` VALUES (173, 1, '22.95');
INSERT INTO `products_to_products_extra_fields` VALUES (174, 1, '22.95');
INSERT INTO `products_to_products_extra_fields` VALUES (175, 1, '24.95');
INSERT INTO `products_to_products_extra_fields` VALUES (176, 1, '110');
INSERT INTO `products_to_products_extra_fields` VALUES (177, 1, '125');
INSERT INTO `products_to_products_extra_fields` VALUES (178, 1, '125');
INSERT INTO `products_to_products_extra_fields` VALUES (179, 1, '125');
INSERT INTO `products_to_products_extra_fields` VALUES (180, 1, '60');
INSERT INTO `products_to_products_extra_fields` VALUES (181, 1, '50');
INSERT INTO `products_to_products_extra_fields` VALUES (182, 1, '50');
INSERT INTO `products_to_products_extra_fields` VALUES (183, 1, '50');
INSERT INTO `products_to_products_extra_fields` VALUES (184, 1, '150');
INSERT INTO `products_to_products_extra_fields` VALUES (185, 1, '110');
INSERT INTO `products_to_products_extra_fields` VALUES (186, 1, '125');
INSERT INTO `products_to_products_extra_fields` VALUES (187, 1, '125');
INSERT INTO `products_to_products_extra_fields` VALUES (188, 1, '50');
INSERT INTO `products_to_products_extra_fields` VALUES (189, 1, '50');
INSERT INTO `products_to_products_extra_fields` VALUES (190, 1, '60');
INSERT INTO `products_to_products_extra_fields` VALUES (191, 1, '50');
INSERT INTO `products_to_products_extra_fields` VALUES (192, 1, '40');
INSERT INTO `products_to_products_extra_fields` VALUES (193, 1, '40');
INSERT INTO `products_to_products_extra_fields` VALUES (194, 1, '40');
INSERT INTO `products_to_products_extra_fields` VALUES (195, 1, '35');
INSERT INTO `products_to_products_extra_fields` VALUES (196, 1, '45');
INSERT INTO `products_to_products_extra_fields` VALUES (197, 1, '45');
INSERT INTO `products_to_products_extra_fields` VALUES (198, 1, '60');
INSERT INTO `products_to_products_extra_fields` VALUES (199, 1, '40');
INSERT INTO `products_to_products_extra_fields` VALUES (200, 1, '40');
INSERT INTO `products_to_products_extra_fields` VALUES (201, 1, '75');
INSERT INTO `products_to_products_extra_fields` VALUES (202, 1, '65');
INSERT INTO `products_to_products_extra_fields` VALUES (203, 1, '65');
INSERT INTO `products_to_products_extra_fields` VALUES (204, 1, '60');
INSERT INTO `products_to_products_extra_fields` VALUES (205, 1, '50');
INSERT INTO `products_to_products_extra_fields` VALUES (206, 1, '60');
INSERT INTO `products_to_products_extra_fields` VALUES (207, 1, '60');
INSERT INTO `products_to_products_extra_fields` VALUES (208, 1, '55');
INSERT INTO `products_to_products_extra_fields` VALUES (209, 1, '75');
INSERT INTO `products_to_products_extra_fields` VALUES (210, 1, '60');
INSERT INTO `products_to_products_extra_fields` VALUES (211, 1, '60');
INSERT INTO `products_to_products_extra_fields` VALUES (212, 1, '90');
INSERT INTO `products_to_products_extra_fields` VALUES (213, 1, '60');
INSERT INTO `products_to_products_extra_fields` VALUES (214, 1, '60');
INSERT INTO `products_to_products_extra_fields` VALUES (215, 1, '75');
INSERT INTO `products_to_products_extra_fields` VALUES (216, 1, '75');
INSERT INTO `products_to_products_extra_fields` VALUES (217, 1, '75');
INSERT INTO `products_to_products_extra_fields` VALUES (218, 1, '35');
INSERT INTO `products_to_products_extra_fields` VALUES (219, 1, '30');
INSERT INTO `products_to_products_extra_fields` VALUES (220, 1, '10');
INSERT INTO `products_to_products_extra_fields` VALUES (221, 1, '10');
INSERT INTO `products_to_products_extra_fields` VALUES (222, 1, '18');
INSERT INTO `products_to_products_extra_fields` VALUES (223, 1, '13');
INSERT INTO `products_to_products_extra_fields` VALUES (224, 1, '10');
INSERT INTO `products_to_products_extra_fields` VALUES (225, 1, '20');
INSERT INTO `products_to_products_extra_fields` VALUES (226, 1, '17');
INSERT INTO `products_to_products_extra_fields` VALUES (227, 1, '21');
INSERT INTO `products_to_products_extra_fields` VALUES (228, 1, '18');
INSERT INTO `products_to_products_extra_fields` VALUES (229, 1, '17');
INSERT INTO `products_to_products_extra_fields` VALUES (230, 1, '34');
INSERT INTO `products_to_products_extra_fields` VALUES (231, 1, '33');
INSERT INTO `products_to_products_extra_fields` VALUES (232, 1, '90');
INSERT INTO `products_to_products_extra_fields` VALUES (233, 1, '25');
INSERT INTO `products_to_products_extra_fields` VALUES (234, 1, '23');
INSERT INTO `products_to_products_extra_fields` VALUES (235, 1, '30');
INSERT INTO `products_to_products_extra_fields` VALUES (728, 1, '24');
INSERT INTO `products_to_products_extra_fields` VALUES (237, 1, '50');
INSERT INTO `products_to_products_extra_fields` VALUES (238, 1, '34');
INSERT INTO `products_to_products_extra_fields` VALUES (239, 1, '27');
INSERT INTO `products_to_products_extra_fields` VALUES (240, 1, '80');
INSERT INTO `products_to_products_extra_fields` VALUES (241, 1, '23');
INSERT INTO `products_to_products_extra_fields` VALUES (242, 1, '15');
INSERT INTO `products_to_products_extra_fields` VALUES (243, 1, '0');
INSERT INTO `products_to_products_extra_fields` VALUES (244, 1, '15');
INSERT INTO `products_to_products_extra_fields` VALUES (245, 1, '12');
INSERT INTO `products_to_products_extra_fields` VALUES (246, 1, '23');
INSERT INTO `products_to_products_extra_fields` VALUES (247, 1, '15.00');
INSERT INTO `products_to_products_extra_fields` VALUES (248, 1, '23');
INSERT INTO `products_to_products_extra_fields` VALUES (249, 1, '35');
INSERT INTO `products_to_products_extra_fields` VALUES (250, 1, '65');
INSERT INTO `products_to_products_extra_fields` VALUES (251, 1, '19');
INSERT INTO `products_to_products_extra_fields` VALUES (252, 1, '40');
INSERT INTO `products_to_products_extra_fields` VALUES (253, 1, '14');
INSERT INTO `products_to_products_extra_fields` VALUES (254, 1, '14');
INSERT INTO `products_to_products_extra_fields` VALUES (255, 1, '12');
INSERT INTO `products_to_products_extra_fields` VALUES (256, 1, '40');
INSERT INTO `products_to_products_extra_fields` VALUES (257, 1, '15.00');
INSERT INTO `products_to_products_extra_fields` VALUES (258, 1, '70');
INSERT INTO `products_to_products_extra_fields` VALUES (259, 1, '25');
INSERT INTO `products_to_products_extra_fields` VALUES (731, 1, '45');
INSERT INTO `products_to_products_extra_fields` VALUES (261, 1, '19');
INSERT INTO `products_to_products_extra_fields` VALUES (262, 1, '12');
INSERT INTO `products_to_products_extra_fields` VALUES (263, 1, '23');
INSERT INTO `products_to_products_extra_fields` VALUES (264, 1, '20');
INSERT INTO `products_to_products_extra_fields` VALUES (265, 1, '30');
INSERT INTO `products_to_products_extra_fields` VALUES (266, 1, '40');
INSERT INTO `products_to_products_extra_fields` VALUES (267, 1, '25');
INSERT INTO `products_to_products_extra_fields` VALUES (268, 1, '90');
INSERT INTO `products_to_products_extra_fields` VALUES (269, 1, '35');
INSERT INTO `products_to_products_extra_fields` VALUES (270, 1, '17');
INSERT INTO `products_to_products_extra_fields` VALUES (271, 1, '33');
INSERT INTO `products_to_products_extra_fields` VALUES (272, 1, '37');
INSERT INTO `products_to_products_extra_fields` VALUES (273, 1, '35');
INSERT INTO `products_to_products_extra_fields` VALUES (274, 1, '25');
INSERT INTO `products_to_products_extra_fields` VALUES (275, 1, '50.00');
INSERT INTO `products_to_products_extra_fields` VALUES (276, 1, '25');
INSERT INTO `products_to_products_extra_fields` VALUES (277, 1, '45');
INSERT INTO `products_to_products_extra_fields` VALUES (278, 1, '40');
INSERT INTO `products_to_products_extra_fields` VALUES (279, 1, '40');
INSERT INTO `products_to_products_extra_fields` VALUES (280, 1, '28');
INSERT INTO `products_to_products_extra_fields` VALUES (281, 1, '20');
INSERT INTO `products_to_products_extra_fields` VALUES (282, 1, '60');
INSERT INTO `products_to_products_extra_fields` VALUES (283, 1, '23');
INSERT INTO `products_to_products_extra_fields` VALUES (284, 1, '18.00');
INSERT INTO `products_to_products_extra_fields` VALUES (285, 1, '65');
INSERT INTO `products_to_products_extra_fields` VALUES (286, 1, '19');
INSERT INTO `products_to_products_extra_fields` VALUES (287, 1, '20.00');
INSERT INTO `products_to_products_extra_fields` VALUES (288, 1, '17');
INSERT INTO `products_to_products_extra_fields` VALUES (289, 1, '23');
INSERT INTO `products_to_products_extra_fields` VALUES (290, 1, '19');
INSERT INTO `products_to_products_extra_fields` VALUES (292, 1, '35');
INSERT INTO `products_to_products_extra_fields` VALUES (293, 1, '21');
INSERT INTO `products_to_products_extra_fields` VALUES (294, 1, '28');
INSERT INTO `products_to_products_extra_fields` VALUES (295, 1, '29.00');
INSERT INTO `products_to_products_extra_fields` VALUES (296, 1, '18');
INSERT INTO `products_to_products_extra_fields` VALUES (297, 1, '36');
INSERT INTO `products_to_products_extra_fields` VALUES (298, 1, '27');
INSERT INTO `products_to_products_extra_fields` VALUES (299, 1, '23');
INSERT INTO `products_to_products_extra_fields` VALUES (300, 1, '16');
INSERT INTO `products_to_products_extra_fields` VALUES (301, 1, '11');
INSERT INTO `products_to_products_extra_fields` VALUES (302, 1, '80');
INSERT INTO `products_to_products_extra_fields` VALUES (303, 1, '20');
INSERT INTO `products_to_products_extra_fields` VALUES (304, 1, '23');
INSERT INTO `products_to_products_extra_fields` VALUES (305, 1, '12');
INSERT INTO `products_to_products_extra_fields` VALUES (306, 1, '9.00');
INSERT INTO `products_to_products_extra_fields` VALUES (730, 1, '35');
INSERT INTO `products_to_products_extra_fields` VALUES (308, 1, '0');
INSERT INTO `products_to_products_extra_fields` VALUES (732, 1, '50');
INSERT INTO `products_to_products_extra_fields` VALUES (310, 1, '65');
INSERT INTO `products_to_products_extra_fields` VALUES (311, 1, '50');
INSERT INTO `products_to_products_extra_fields` VALUES (312, 1, '60');
INSERT INTO `products_to_products_extra_fields` VALUES (313, 1, '60');
INSERT INTO `products_to_products_extra_fields` VALUES (314, 1, '60');
INSERT INTO `products_to_products_extra_fields` VALUES (315, 1, '14');
INSERT INTO `products_to_products_extra_fields` VALUES (316, 1, '10');
INSERT INTO `products_to_products_extra_fields` VALUES (317, 1, '15');
INSERT INTO `products_to_products_extra_fields` VALUES (318, 1, '10');
INSERT INTO `products_to_products_extra_fields` VALUES (319, 1, '14');
INSERT INTO `products_to_products_extra_fields` VALUES (320, 1, '34.95');
INSERT INTO `products_to_products_extra_fields` VALUES (321, 1, '34.95');
INSERT INTO `products_to_products_extra_fields` VALUES (322, 1, '0');
INSERT INTO `products_to_products_extra_fields` VALUES (323, 1, '29.95');
INSERT INTO `products_to_products_extra_fields` VALUES (324, 1, '34.95');
INSERT INTO `products_to_products_extra_fields` VALUES (325, 1, '29.95');
INSERT INTO `products_to_products_extra_fields` VALUES (326, 1, '99.95');
INSERT INTO `products_to_products_extra_fields` VALUES (327, 1, '29.95');
INSERT INTO `products_to_products_extra_fields` VALUES (328, 1, '24.95');
INSERT INTO `products_to_products_extra_fields` VALUES (329, 1, '49.95');
INSERT INTO `products_to_products_extra_fields` VALUES (330, 1, '24.95');
INSERT INTO `products_to_products_extra_fields` VALUES (331, 1, '59.95');
INSERT INTO `products_to_products_extra_fields` VALUES (332, 1, '89.95');
INSERT INTO `products_to_products_extra_fields` VALUES (333, 1, '29.95');
INSERT INTO `products_to_products_extra_fields` VALUES (334, 1, '39.95');
INSERT INTO `products_to_products_extra_fields` VALUES (335, 1, '49.95');
INSERT INTO `products_to_products_extra_fields` VALUES (336, 1, '39.95');
INSERT INTO `products_to_products_extra_fields` VALUES (337, 1, '19.95');
INSERT INTO `products_to_products_extra_fields` VALUES (338, 1, '59.95');
INSERT INTO `products_to_products_extra_fields` VALUES (339, 1, '29.95');
INSERT INTO `products_to_products_extra_fields` VALUES (340, 1, '24.95');
INSERT INTO `products_to_products_extra_fields` VALUES (341, 1, '59.95');
INSERT INTO `products_to_products_extra_fields` VALUES (342, 1, '64.95');
INSERT INTO `products_to_products_extra_fields` VALUES (343, 1, '149.95');
INSERT INTO `products_to_products_extra_fields` VALUES (344, 1, '39.95');
INSERT INTO `products_to_products_extra_fields` VALUES (345, 1, '49.95');
INSERT INTO `products_to_products_extra_fields` VALUES (346, 1, '39.95');
INSERT INTO `products_to_products_extra_fields` VALUES (347, 1, '39.95');
INSERT INTO `products_to_products_extra_fields` VALUES (348, 1, '79.95');
INSERT INTO `products_to_products_extra_fields` VALUES (349, 1, '0');
INSERT INTO `products_to_products_extra_fields` VALUES (350, 1, '50');
INSERT INTO `products_to_products_extra_fields` VALUES (351, 1, '75.00');
INSERT INTO `products_to_products_extra_fields` VALUES (352, 1, '27.95');
INSERT INTO `products_to_products_extra_fields` VALUES (353, 1, '27.95');
INSERT INTO `products_to_products_extra_fields` VALUES (291, 1, '0');
INSERT INTO `products_to_products_extra_fields` VALUES (354, 1, '39.00');
INSERT INTO `products_to_products_extra_fields` VALUES (355, 1, '29.00');
INSERT INTO `products_to_products_extra_fields` VALUES (356, 1, '49.00');
INSERT INTO `products_to_products_extra_fields` VALUES (357, 1, '25.00');
INSERT INTO `products_to_products_extra_fields` VALUES (358, 1, '49.00');
INSERT INTO `products_to_products_extra_fields` VALUES (359, 1, '29.00');
INSERT INTO `products_to_products_extra_fields` VALUES (360, 1, '39.00');
INSERT INTO `products_to_products_extra_fields` VALUES (361, 1, '45.00');
INSERT INTO `products_to_products_extra_fields` VALUES (362, 1, '25.00');
INSERT INTO `products_to_products_extra_fields` VALUES (363, 1, '49.00');
INSERT INTO `products_to_products_extra_fields` VALUES (364, 1, '39.00');
INSERT INTO `products_to_products_extra_fields` VALUES (365, 1, '55.00');
INSERT INTO `products_to_products_extra_fields` VALUES (366, 1, '29.00');
INSERT INTO `products_to_products_extra_fields` VALUES (367, 1, '59.00');
INSERT INTO `products_to_products_extra_fields` VALUES (368, 1, '59.00');
INSERT INTO `products_to_products_extra_fields` VALUES (369, 1, '45.00');
INSERT INTO `products_to_products_extra_fields` VALUES (370, 1, '45.00');
INSERT INTO `products_to_products_extra_fields` VALUES (371, 1, '119.00');
INSERT INTO `products_to_products_extra_fields` VALUES (372, 1, '55.00');
INSERT INTO `products_to_products_extra_fields` VALUES (373, 1, '39.00');
INSERT INTO `products_to_products_extra_fields` VALUES (374, 1, '49.00');
INSERT INTO `products_to_products_extra_fields` VALUES (375, 1, '69.00');
INSERT INTO `products_to_products_extra_fields` VALUES (376, 1, '29.99');
INSERT INTO `products_to_products_extra_fields` VALUES (377, 1, '29.99');
INSERT INTO `products_to_products_extra_fields` VALUES (378, 1, '29.99');
INSERT INTO `products_to_products_extra_fields` VALUES (379, 1, '29.99');
INSERT INTO `products_to_products_extra_fields` VALUES (380, 1, '29.99');
INSERT INTO `products_to_products_extra_fields` VALUES (381, 1, '29.99');
INSERT INTO `products_to_products_extra_fields` VALUES (382, 1, '29.99');
INSERT INTO `products_to_products_extra_fields` VALUES (383, 1, '29.99');
INSERT INTO `products_to_products_extra_fields` VALUES (384, 1, '29.99');
INSERT INTO `products_to_products_extra_fields` VALUES (386, 1, '75');
INSERT INTO `products_to_products_extra_fields` VALUES (387, 1, '90.00');
INSERT INTO `products_to_products_extra_fields` VALUES (535, 1, '18');
INSERT INTO `products_to_products_extra_fields` VALUES (534, 1, '40');
INSERT INTO `products_to_products_extra_fields` VALUES (533, 1, '36');
INSERT INTO `products_to_products_extra_fields` VALUES (530, 1, '12');
INSERT INTO `products_to_products_extra_fields` VALUES (529, 1, '12');
INSERT INTO `products_to_products_extra_fields` VALUES (528, 1, '12');
INSERT INTO `products_to_products_extra_fields` VALUES (527, 1, '12');
INSERT INTO `products_to_products_extra_fields` VALUES (526, 1, '12');
INSERT INTO `products_to_products_extra_fields` VALUES (525, 1, '16');
INSERT INTO `products_to_products_extra_fields` VALUES (524, 1, '19');
INSERT INTO `products_to_products_extra_fields` VALUES (523, 1, '16');
INSERT INTO `products_to_products_extra_fields` VALUES (522, 1, '16');
INSERT INTO `products_to_products_extra_fields` VALUES (521, 1, '16');
INSERT INTO `products_to_products_extra_fields` VALUES (520, 1, '16');
INSERT INTO `products_to_products_extra_fields` VALUES (518, 1, '12');
INSERT INTO `products_to_products_extra_fields` VALUES (519, 1, '12');
INSERT INTO `products_to_products_extra_fields` VALUES (517, 1, '250');
INSERT INTO `products_to_products_extra_fields` VALUES (516, 1, '125');
INSERT INTO `products_to_products_extra_fields` VALUES (515, 1, '85');
INSERT INTO `products_to_products_extra_fields` VALUES (514, 1, '84');
INSERT INTO `products_to_products_extra_fields` VALUES (513, 1, '115');
INSERT INTO `products_to_products_extra_fields` VALUES (512, 1, '79');
INSERT INTO `products_to_products_extra_fields` VALUES (511, 1, '120');
INSERT INTO `products_to_products_extra_fields` VALUES (510, 1, '99');
INSERT INTO `products_to_products_extra_fields` VALUES (509, 1, '120');
INSERT INTO `products_to_products_extra_fields` VALUES (508, 1, '240');
INSERT INTO `products_to_products_extra_fields` VALUES (507, 1, '95');
INSERT INTO `products_to_products_extra_fields` VALUES (506, 1, '129');
INSERT INTO `products_to_products_extra_fields` VALUES (505, 1, '295');
INSERT INTO `products_to_products_extra_fields` VALUES (504, 1, '155');
INSERT INTO `products_to_products_extra_fields` VALUES (503, 1, '115');
INSERT INTO `products_to_products_extra_fields` VALUES (494, 1, '110');
INSERT INTO `products_to_products_extra_fields` VALUES (498, 1, '120');
INSERT INTO `products_to_products_extra_fields` VALUES (502, 1, '48');
INSERT INTO `products_to_products_extra_fields` VALUES (500, 1, '54');
INSERT INTO `products_to_products_extra_fields` VALUES (496, 1, '69');
INSERT INTO `products_to_products_extra_fields` VALUES (493, 1, '57');
INSERT INTO `products_to_products_extra_fields` VALUES (501, 1, '63');
INSERT INTO `products_to_products_extra_fields` VALUES (497, 1, '77');
INSERT INTO `products_to_products_extra_fields` VALUES (495, 1, '58');
INSERT INTO `products_to_products_extra_fields` VALUES (492, 1, '65');
INSERT INTO `products_to_products_extra_fields` VALUES (499, 1, '59');
INSERT INTO `products_to_products_extra_fields` VALUES (460, 1, '60');
INSERT INTO `products_to_products_extra_fields` VALUES (485, 1, '80');
INSERT INTO `products_to_products_extra_fields` VALUES (482, 1, '75');
INSERT INTO `products_to_products_extra_fields` VALUES (484, 1, '50');
INSERT INTO `products_to_products_extra_fields` VALUES (478, 1, '180');
INSERT INTO `products_to_products_extra_fields` VALUES (459, 1, '80');
INSERT INTO `products_to_products_extra_fields` VALUES (486, 1, '45');
INSERT INTO `products_to_products_extra_fields` VALUES (480, 1, '90');
INSERT INTO `products_to_products_extra_fields` VALUES (473, 1, '40');
INSERT INTO `products_to_products_extra_fields` VALUES (472, 1, '40');
INSERT INTO `products_to_products_extra_fields` VALUES (476, 1, '60');
INSERT INTO `products_to_products_extra_fields` VALUES (471, 1, '60');
INSERT INTO `products_to_products_extra_fields` VALUES (475, 1, '60');
INSERT INTO `products_to_products_extra_fields` VALUES (465, 1, '50');
INSERT INTO `products_to_products_extra_fields` VALUES (466, 1, '50');
INSERT INTO `products_to_products_extra_fields` VALUES (463, 1, '60');
INSERT INTO `products_to_products_extra_fields` VALUES (470, 1, '65');
INSERT INTO `products_to_products_extra_fields` VALUES (469, 1, '50');
INSERT INTO `products_to_products_extra_fields` VALUES (536, 1, '15');
INSERT INTO `products_to_products_extra_fields` VALUES (537, 1, '15');
INSERT INTO `products_to_products_extra_fields` VALUES (538, 1, '15');
INSERT INTO `products_to_products_extra_fields` VALUES (539, 1, '15');
INSERT INTO `products_to_products_extra_fields` VALUES (540, 1, '14');
INSERT INTO `products_to_products_extra_fields` VALUES (541, 1, '14');
INSERT INTO `products_to_products_extra_fields` VALUES (542, 1, '15');
INSERT INTO `products_to_products_extra_fields` VALUES (543, 1, '15');
INSERT INTO `products_to_products_extra_fields` VALUES (544, 1, '15');
INSERT INTO `products_to_products_extra_fields` VALUES (545, 1, '15');
INSERT INTO `products_to_products_extra_fields` VALUES (546, 1, '13');
INSERT INTO `products_to_products_extra_fields` VALUES (547, 1, '18');
INSERT INTO `products_to_products_extra_fields` VALUES (548, 1, '18');
INSERT INTO `products_to_products_extra_fields` VALUES (549, 1, '110');
INSERT INTO `products_to_products_extra_fields` VALUES (550, 1, '80');
INSERT INTO `products_to_products_extra_fields` VALUES (551, 1, '12');
INSERT INTO `products_to_products_extra_fields` VALUES (552, 1, '12');
INSERT INTO `products_to_products_extra_fields` VALUES (553, 1, '15');
INSERT INTO `products_to_products_extra_fields` VALUES (554, 1, '12');
INSERT INTO `products_to_products_extra_fields` VALUES (555, 1, '12');
INSERT INTO `products_to_products_extra_fields` VALUES (556, 1, '12');
INSERT INTO `products_to_products_extra_fields` VALUES (557, 1, '12');
INSERT INTO `products_to_products_extra_fields` VALUES (559, 1, '12');
INSERT INTO `products_to_products_extra_fields` VALUES (560, 1, '12');
INSERT INTO `products_to_products_extra_fields` VALUES (561, 1, '12');
INSERT INTO `products_to_products_extra_fields` VALUES (562, 1, '12');
INSERT INTO `products_to_products_extra_fields` VALUES (563, 1, '12');
INSERT INTO `products_to_products_extra_fields` VALUES (564, 1, '12');
INSERT INTO `products_to_products_extra_fields` VALUES (565, 1, '12');
INSERT INTO `products_to_products_extra_fields` VALUES (566, 1, '12');
INSERT INTO `products_to_products_extra_fields` VALUES (567, 1, '12');
INSERT INTO `products_to_products_extra_fields` VALUES (568, 1, '12');
INSERT INTO `products_to_products_extra_fields` VALUES (569, 1, '12');
INSERT INTO `products_to_products_extra_fields` VALUES (570, 1, '15');
INSERT INTO `products_to_products_extra_fields` VALUES (571, 1, '15');
INSERT INTO `products_to_products_extra_fields` VALUES (572, 1, '10');
INSERT INTO `products_to_products_extra_fields` VALUES (532, 1, '36');
INSERT INTO `products_to_products_extra_fields` VALUES (573, 1, '42');
INSERT INTO `products_to_products_extra_fields` VALUES (574, 1, '48');
INSERT INTO `products_to_products_extra_fields` VALUES (575, 1, '40');
INSERT INTO `products_to_products_extra_fields` VALUES (576, 1, '65');
INSERT INTO `products_to_products_extra_fields` VALUES (577, 1, '59');
INSERT INTO `products_to_products_extra_fields` VALUES (578, 1, '39');
INSERT INTO `products_to_products_extra_fields` VALUES (579, 1, '57');
INSERT INTO `products_to_products_extra_fields` VALUES (580, 1, '28');
INSERT INTO `products_to_products_extra_fields` VALUES (581, 1, '12');
INSERT INTO `products_to_products_extra_fields` VALUES (582, 1, '15');
INSERT INTO `products_to_products_extra_fields` VALUES (583, 1, '14');
INSERT INTO `products_to_products_extra_fields` VALUES (584, 1, '14');
INSERT INTO `products_to_products_extra_fields` VALUES (585, 1, '13');
INSERT INTO `products_to_products_extra_fields` VALUES (586, 1, '14');
INSERT INTO `products_to_products_extra_fields` VALUES (587, 1, '14');
INSERT INTO `products_to_products_extra_fields` VALUES (588, 1, '13');
INSERT INTO `products_to_products_extra_fields` VALUES (589, 1, '15');
INSERT INTO `products_to_products_extra_fields` VALUES (590, 1, '14');
INSERT INTO `products_to_products_extra_fields` VALUES (591, 1, '40');
INSERT INTO `products_to_products_extra_fields` VALUES (592, 1, '40');
INSERT INTO `products_to_products_extra_fields` VALUES (593, 1, '44');
INSERT INTO `products_to_products_extra_fields` VALUES (490, 1, '45');
INSERT INTO `products_to_products_extra_fields` VALUES (594, 1, '18');
INSERT INTO `products_to_products_extra_fields` VALUES (595, 1, '18');
INSERT INTO `products_to_products_extra_fields` VALUES (596, 1, '21');
INSERT INTO `products_to_products_extra_fields` VALUES (597, 1, '36');
INSERT INTO `products_to_products_extra_fields` VALUES (598, 1, '25');
INSERT INTO `products_to_products_extra_fields` VALUES (599, 1, '30');
INSERT INTO `products_to_products_extra_fields` VALUES (600, 1, '165');
INSERT INTO `products_to_products_extra_fields` VALUES (601, 1, '240');
INSERT INTO `products_to_products_extra_fields` VALUES (602, 1, '145');
INSERT INTO `products_to_products_extra_fields` VALUES (603, 1, '185');
INSERT INTO `products_to_products_extra_fields` VALUES (604, 1, '195');
INSERT INTO `products_to_products_extra_fields` VALUES (605, 1, '195');
INSERT INTO `products_to_products_extra_fields` VALUES (606, 1, '99');
INSERT INTO `products_to_products_extra_fields` VALUES (607, 1, '140');
INSERT INTO `products_to_products_extra_fields` VALUES (608, 1, '150');
INSERT INTO `products_to_products_extra_fields` VALUES (609, 1, '175');
INSERT INTO `products_to_products_extra_fields` VALUES (610, 1, '250');
INSERT INTO `products_to_products_extra_fields` VALUES (611, 1, '99');
INSERT INTO `products_to_products_extra_fields` VALUES (612, 1, '230');
INSERT INTO `products_to_products_extra_fields` VALUES (613, 1, '165');
INSERT INTO `products_to_products_extra_fields` VALUES (614, 1, '295');
INSERT INTO `products_to_products_extra_fields` VALUES (615, 1, '180');
INSERT INTO `products_to_products_extra_fields` VALUES (616, 1, '220');
INSERT INTO `products_to_products_extra_fields` VALUES (617, 1, '65');
INSERT INTO `products_to_products_extra_fields` VALUES (618, 1, '40');
INSERT INTO `products_to_products_extra_fields` VALUES (619, 1, '48');
INSERT INTO `products_to_products_extra_fields` VALUES (620, 1, '48');
INSERT INTO `products_to_products_extra_fields` VALUES (621, 1, '99');
INSERT INTO `products_to_products_extra_fields` VALUES (622, 1, '20');
INSERT INTO `products_to_products_extra_fields` VALUES (623, 1, '24');
INSERT INTO `products_to_products_extra_fields` VALUES (624, 1, '25');
INSERT INTO `products_to_products_extra_fields` VALUES (625, 1, '40');
INSERT INTO `products_to_products_extra_fields` VALUES (626, 1, '29');
INSERT INTO `products_to_products_extra_fields` VALUES (627, 1, '39');
INSERT INTO `products_to_products_extra_fields` VALUES (628, 1, '69');
INSERT INTO `products_to_products_extra_fields` VALUES (629, 1, '55');
INSERT INTO `products_to_products_extra_fields` VALUES (630, 1, '80');
INSERT INTO `products_to_products_extra_fields` VALUES (631, 1, '75');
INSERT INTO `products_to_products_extra_fields` VALUES (632, 1, '30');
INSERT INTO `products_to_products_extra_fields` VALUES (633, 1, '45');
INSERT INTO `products_to_products_extra_fields` VALUES (634, 1, '140');
INSERT INTO `products_to_products_extra_fields` VALUES (635, 1, '55');
INSERT INTO `products_to_products_extra_fields` VALUES (636, 1, '110');
INSERT INTO `products_to_products_extra_fields` VALUES (637, 1, '70');
INSERT INTO `products_to_products_extra_fields` VALUES (638, 1, '55');
INSERT INTO `products_to_products_extra_fields` VALUES (639, 1, '70');
INSERT INTO `products_to_products_extra_fields` VALUES (640, 1, '60');
INSERT INTO `products_to_products_extra_fields` VALUES (641, 1, '180');
INSERT INTO `products_to_products_extra_fields` VALUES (642, 1, '45');
INSERT INTO `products_to_products_extra_fields` VALUES (643, 1, '99');
INSERT INTO `products_to_products_extra_fields` VALUES (644, 1, '65');
INSERT INTO `products_to_products_extra_fields` VALUES (645, 1, '85');
INSERT INTO `products_to_products_extra_fields` VALUES (646, 1, '85');
INSERT INTO `products_to_products_extra_fields` VALUES (647, 1, '43');
INSERT INTO `products_to_products_extra_fields` VALUES (648, 1, '65');
INSERT INTO `products_to_products_extra_fields` VALUES (649, 1, '99');
INSERT INTO `products_to_products_extra_fields` VALUES (650, 1, '55');
INSERT INTO `products_to_products_extra_fields` VALUES (651, 1, '99');
INSERT INTO `products_to_products_extra_fields` VALUES (652, 1, '75');
INSERT INTO `products_to_products_extra_fields` VALUES (653, 1, '65');
INSERT INTO `products_to_products_extra_fields` VALUES (654, 1, '80');
INSERT INTO `products_to_products_extra_fields` VALUES (655, 1, '105');
INSERT INTO `products_to_products_extra_fields` VALUES (656, 1, '65');
INSERT INTO `products_to_products_extra_fields` VALUES (657, 1, '95');
INSERT INTO `products_to_products_extra_fields` VALUES (658, 1, '115');
INSERT INTO `products_to_products_extra_fields` VALUES (659, 1, '145');
INSERT INTO `products_to_products_extra_fields` VALUES (660, 1, '70');
INSERT INTO `products_to_products_extra_fields` VALUES (661, 1, '35');
INSERT INTO `products_to_products_extra_fields` VALUES (662, 1, '30');
INSERT INTO `products_to_products_extra_fields` VALUES (663, 1, '45');
INSERT INTO `products_to_products_extra_fields` VALUES (664, 1, '25');
INSERT INTO `products_to_products_extra_fields` VALUES (665, 1, '35');
INSERT INTO `products_to_products_extra_fields` VALUES (666, 1, '45');
INSERT INTO `products_to_products_extra_fields` VALUES (667, 1, '45');
INSERT INTO `products_to_products_extra_fields` VALUES (668, 1, '15');
INSERT INTO `products_to_products_extra_fields` VALUES (669, 1, '40');
INSERT INTO `products_to_products_extra_fields` VALUES (670, 1, '42');
INSERT INTO `products_to_products_extra_fields` VALUES (671, 1, '30');
INSERT INTO `products_to_products_extra_fields` VALUES (672, 1, '44');
INSERT INTO `products_to_products_extra_fields` VALUES (673, 1, '69.99');
INSERT INTO `products_to_products_extra_fields` VALUES (674, 1, '69.99');
INSERT INTO `products_to_products_extra_fields` VALUES (675, 1, '49.99');
INSERT INTO `products_to_products_extra_fields` VALUES (676, 1, '69.99');
INSERT INTO `products_to_products_extra_fields` VALUES (677, 1, '55');
INSERT INTO `products_to_products_extra_fields` VALUES (678, 1, '15');
INSERT INTO `products_to_products_extra_fields` VALUES (679, 1, '225');
INSERT INTO `products_to_products_extra_fields` VALUES (680, 1, '12');
INSERT INTO `products_to_products_extra_fields` VALUES (681, 1, '36');
INSERT INTO `products_to_products_extra_fields` VALUES (477, 1, '110');
INSERT INTO `products_to_products_extra_fields` VALUES (467, 1, '50');
INSERT INTO `products_to_products_extra_fields` VALUES (682, 1, '75');
INSERT INTO `products_to_products_extra_fields` VALUES (683, 1, '115');
INSERT INTO `products_to_products_extra_fields` VALUES (684, 1, '180');
INSERT INTO `products_to_products_extra_fields` VALUES (685, 1, '265');
INSERT INTO `products_to_products_extra_fields` VALUES (686, 1, '310');
INSERT INTO `products_to_products_extra_fields` VALUES (687, 1, '150');
INSERT INTO `products_to_products_extra_fields` VALUES (688, 1, '195');
INSERT INTO `products_to_products_extra_fields` VALUES (689, 1, '270');
INSERT INTO `products_to_products_extra_fields` VALUES (690, 1, '340');
INSERT INTO `products_to_products_extra_fields` VALUES (691, 1, '195');
INSERT INTO `products_to_products_extra_fields` VALUES (692, 1, '260');
INSERT INTO `products_to_products_extra_fields` VALUES (693, 1, '310');
INSERT INTO `products_to_products_extra_fields` VALUES (694, 1, '415');
INSERT INTO `products_to_products_extra_fields` VALUES (695, 1, '150');
INSERT INTO `products_to_products_extra_fields` VALUES (696, 1, '225');
INSERT INTO `products_to_products_extra_fields` VALUES (697, 1, '285');
INSERT INTO `products_to_products_extra_fields` VALUES (698, 1, '375');
INSERT INTO `products_to_products_extra_fields` VALUES (699, 1, '135');
INSERT INTO `products_to_products_extra_fields` VALUES (700, 1, '145');
INSERT INTO `products_to_products_extra_fields` VALUES (701, 1, '195');
INSERT INTO `products_to_products_extra_fields` VALUES (702, 1, '275');
INSERT INTO `products_to_products_extra_fields` VALUES (703, 1, '95');
INSERT INTO `products_to_products_extra_fields` VALUES (704, 1, '145');
INSERT INTO `products_to_products_extra_fields` VALUES (705, 1, '205');
INSERT INTO `products_to_products_extra_fields` VALUES (706, 1, '275');
INSERT INTO `products_to_products_extra_fields` VALUES (707, 1, '125');
INSERT INTO `products_to_products_extra_fields` VALUES (708, 1, '175');
INSERT INTO `products_to_products_extra_fields` VALUES (709, 1, '245');
INSERT INTO `products_to_products_extra_fields` VALUES (710, 1, '235');
INSERT INTO `products_to_products_extra_fields` VALUES (711, 1, '375');
INSERT INTO `products_to_products_extra_fields` VALUES (712, 1, '365');
INSERT INTO `products_to_products_extra_fields` VALUES (713, 1, '265');
INSERT INTO `products_to_products_extra_fields` VALUES (714, 1, '295');
INSERT INTO `products_to_products_extra_fields` VALUES (715, 1, '365');
INSERT INTO `products_to_products_extra_fields` VALUES (716, 1, '69.99');
INSERT INTO `products_to_products_extra_fields` VALUES (717, 1, '110');
INSERT INTO `products_to_products_extra_fields` VALUES (718, 1, '115');
INSERT INTO `products_to_products_extra_fields` VALUES (719, 1, '85');
INSERT INTO `products_to_products_extra_fields` VALUES (720, 1, '59');
INSERT INTO `products_to_products_extra_fields` VALUES (721, 1, '110');
INSERT INTO `products_to_products_extra_fields` VALUES (722, 1, '74');
INSERT INTO `products_to_products_extra_fields` VALUES (723, 1, '98');
INSERT INTO `products_to_products_extra_fields` VALUES (724, 1, '130');
INSERT INTO `products_to_products_extra_fields` VALUES (725, 1, '65');
INSERT INTO `products_to_products_extra_fields` VALUES (726, 1, '36');
INSERT INTO `products_to_products_extra_fields` VALUES (729, 1, '45');
INSERT INTO `products_to_products_extra_fields` VALUES (733, 1, '60');
INSERT INTO `products_to_products_extra_fields` VALUES (734, 1, '60');
INSERT INTO `products_to_products_extra_fields` VALUES (735, 1, '29.99');
INSERT INTO `products_to_products_extra_fields` VALUES (736, 1, '24.99');
INSERT INTO `products_to_products_extra_fields` VALUES (737, 1, '39.99');
INSERT INTO `products_to_products_extra_fields` VALUES (739, 1, '19.99');
INSERT INTO `products_to_products_extra_fields` VALUES (740, 1, '29.99');
INSERT INTO `products_to_products_extra_fields` VALUES (741, 1, '22.99');
INSERT INTO `products_to_products_extra_fields` VALUES (742, 1, '29.99');
INSERT INTO `products_to_products_extra_fields` VALUES (743, 1, '34.99');
INSERT INTO `products_to_products_extra_fields` VALUES (744, 1, '39.99');
INSERT INTO `products_to_products_extra_fields` VALUES (745, 1, '49.99');
INSERT INTO `products_to_products_extra_fields` VALUES (746, 1, '49.99');
INSERT INTO `products_to_products_extra_fields` VALUES (747, 1, '49.99');
INSERT INTO `products_to_products_extra_fields` VALUES (748, 1, '44.99');
INSERT INTO `products_to_products_extra_fields` VALUES (749, 1, '24.99');
INSERT INTO `products_to_products_extra_fields` VALUES (750, 1, '34.99');
INSERT INTO `products_to_products_extra_fields` VALUES (751, 1, '34.99');
INSERT INTO `products_to_products_extra_fields` VALUES (752, 1, '39.99');
INSERT INTO `products_to_products_extra_fields` VALUES (753, 1, '27.99');
INSERT INTO `products_to_products_extra_fields` VALUES (754, 1, '39.99');
INSERT INTO `products_to_products_extra_fields` VALUES (755, 1, '39.99');
INSERT INTO `products_to_products_extra_fields` VALUES (756, 1, '44.99');
INSERT INTO `products_to_products_extra_fields` VALUES (757, 1, '34.99');
INSERT INTO `products_to_products_extra_fields` VALUES (758, 1, '39.99');
INSERT INTO `products_to_products_extra_fields` VALUES (487, 1, '80');
INSERT INTO `products_to_products_extra_fields` VALUES (468, 1, '50');
INSERT INTO `products_to_products_extra_fields` VALUES (464, 1, '50');
INSERT INTO `products_to_products_extra_fields` VALUES (488, 1, '80');
INSERT INTO `products_to_products_extra_fields` VALUES (759, 1, '110');
INSERT INTO `products_to_products_extra_fields` VALUES (479, 1, '175');
INSERT INTO `products_to_products_extra_fields` VALUES (760, 1, '18');
INSERT INTO `products_to_products_extra_fields` VALUES (761, 1, '26');
INSERT INTO `products_to_products_extra_fields` VALUES (762, 1, '23');
INSERT INTO `products_to_products_extra_fields` VALUES (776, 1, '595');
INSERT INTO `products_to_products_extra_fields` VALUES (775, 1, '460');
INSERT INTO `products_to_products_extra_fields` VALUES (774, 1, '460');
INSERT INTO `products_to_products_extra_fields` VALUES (773, 1, '42.95');
INSERT INTO `products_to_products_extra_fields` VALUES (772, 1, '115');
INSERT INTO `products_to_products_extra_fields` VALUES (771, 1, '49.99');
INSERT INTO `products_to_products_extra_fields` VALUES (770, 1, '69.99');
INSERT INTO `products_to_products_extra_fields` VALUES (777, 1, '595');
INSERT INTO `products_to_products_extra_fields` VALUES (778, 1, '14');

-- --------------------------------------------------------

--
-- Table structure for table `reviews`
--

CREATE TABLE `reviews` (
  `reviews_id` int(11) NOT NULL auto_increment,
  `products_id` int(11) NOT NULL,
  `customers_id` int(11) default NULL,
  `customers_name` varchar(64) NOT NULL,
  `reviews_rating` int(1) default NULL,
  `date_added` datetime default NULL,
  `last_modified` datetime default NULL,
  `reviews_read` int(5) NOT NULL default '0',
  PRIMARY KEY  (`reviews_id`),
  KEY `idx_reviews_products_id` (`products_id`),
  KEY `idx_reviews_customers_id` (`customers_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `reviews`
--


-- --------------------------------------------------------

--
-- Table structure for table `reviews_description`
--

CREATE TABLE `reviews_description` (
  `reviews_id` int(11) NOT NULL,
  `languages_id` int(11) NOT NULL,
  `reviews_text` text NOT NULL,
  PRIMARY KEY  (`reviews_id`,`languages_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `reviews_description`
--


-- --------------------------------------------------------

--
-- Table structure for table `sessions`
--

CREATE TABLE `sessions` (
  `sesskey` varchar(32) NOT NULL,
  `expiry` int(11) unsigned NOT NULL,
  `value` text NOT NULL,
  PRIMARY KEY  (`sesskey`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `sessions`
--

INSERT INTO `sessions` VALUES ('qpqe8p4a0alcmup1vrcahn1b02', 1293467806, 'cart|O:12:"shoppingCart":5:{s:8:"contents";a:0:{}s:5:"total";i:0;s:6:"weight";i:0;s:6:"cartID";N;s:12:"content_type";b:0;}language|s:7:"english";languages_id|s:1:"1";currency|s:3:"GBP";navigation|O:17:"navigationHistory":2:{s:4:"path";a:2:{i:0;a:4:{s:4:"page";s:9:"index.php";s:4:"mode";s:6:"NONSSL";s:3:"get";a:0:{}s:4:"post";a:0:{}}i:1;a:4:{s:4:"page";s:12:"specials.php";s:4:"mode";s:6:"NONSSL";s:3:"get";a:2:{s:4:"sort";s:2:"0d";s:4:"page";s:1:"2";}s:4:"post";a:0:{}}}s:8:"snapshot";a:0:{}}');
INSERT INTO `sessions` VALUES ('nm7p1u2pnfvr89o44ns596ujp0', 1293467826, 'language|s:7:"english";languages_id|s:1:"1";redirect_origin|a:2:{s:4:"page";s:9:"index.php";s:3:"get";a:0:{}}selected_box|s:13:"configuration";');
INSERT INTO `sessions` VALUES ('e6j044sk6bllh5qhqahufps1n3', 1293468379, 'cart|O:12:"shoppingCart":5:{s:8:"contents";a:0:{}s:5:"total";i:0;s:6:"weight";i:0;s:6:"cartID";N;s:12:"content_type";b:0;}language|s:7:"english";languages_id|s:1:"1";currency|s:3:"GBP";navigation|O:17:"navigationHistory":2:{s:4:"path";a:2:{i:0;a:4:{s:4:"page";s:9:"index.php";s:4:"mode";s:6:"NONSSL";s:3:"get";a:1:{s:4:"page";s:2:"35";}s:4:"post";a:0:{}}i:1;a:4:{s:4:"page";s:9:"index.php";s:4:"mode";s:6:"NONSSL";s:3:"get";a:1:{s:5:"cPath";s:2:"10";}s:4:"post";a:0:{}}}s:8:"snapshot";a:0:{}}');
INSERT INTO `sessions` VALUES ('4h5u03a0d0ps29p2llk2nqua02', 1293465041, 'language|s:7:"english";languages_id|s:1:"1";selected_box|s:7:"catalog";admin|a:2:{s:2:"id";s:1:"2";s:8:"username";s:6:"cmckay";}');
INSERT INTO `sessions` VALUES ('cc6p7p9kq8958uvtel9vccsjb1', 1293452490, 'cart|O:12:"shoppingCart":4:{s:8:"contents";a:0:{}s:5:"total";i:0;s:6:"weight";i:0;s:12:"content_type";b:0;}language|s:7:"english";languages_id|s:1:"1";currency|s:3:"GBP";navigation|O:17:"navigationHistory":2:{s:4:"path";a:1:{i:0;a:4:{s:4:"page";s:9:"index.php";s:4:"mode";s:6:"NONSSL";s:3:"get";a:0:{}s:4:"post";a:0:{}}}s:8:"snapshot";a:0:{}}');
INSERT INTO `sessions` VALUES ('dig3ov2qnu9qu2dspnobs79aa5', 1293453680, 'cart|O:12:"shoppingCart":4:{s:8:"contents";a:0:{}s:5:"total";i:0;s:6:"weight";i:0;s:12:"content_type";b:0;}language|s:7:"english";languages_id|s:1:"1";currency|s:3:"GBP";navigation|O:17:"navigationHistory":2:{s:4:"path";a:1:{i:0;a:4:{s:4:"page";s:9:"index.php";s:4:"mode";s:6:"NONSSL";s:3:"get";a:1:{s:5:"cPath";s:3:"1_5";}s:4:"post";a:0:{}}}s:8:"snapshot";a:0:{}}');
INSERT INTO `sessions` VALUES ('t9nvukm52va8nk7v4gb3rgomj1', 1293453681, 'cart|O:12:"shoppingCart":4:{s:8:"contents";a:0:{}s:5:"total";i:0;s:6:"weight";i:0;s:12:"content_type";b:0;}language|s:7:"english";languages_id|s:1:"1";currency|s:3:"GBP";navigation|O:17:"navigationHistory":2:{s:4:"path";a:1:{i:0;a:4:{s:4:"page";s:9:"index.php";s:4:"mode";s:6:"NONSSL";s:3:"get";a:1:{s:5:"cPath";s:3:"1_5";}s:4:"post";a:0:{}}}s:8:"snapshot";a:0:{}}');
INSERT INTO `sessions` VALUES ('o0tbgen2kaqlhld3ifir5fvqs3', 1293453888, 'cart|O:12:"shoppingCart":4:{s:8:"contents";a:0:{}s:5:"total";i:0;s:6:"weight";i:0;s:12:"content_type";b:0;}language|s:7:"english";languages_id|s:1:"1";currency|s:3:"GBP";navigation|O:17:"navigationHistory":2:{s:4:"path";a:1:{i:0;a:4:{s:4:"page";s:9:"index.php";s:4:"mode";s:6:"NONSSL";s:3:"get";a:0:{}s:4:"post";a:0:{}}}s:8:"snapshot";a:0:{}}');
INSERT INTO `sessions` VALUES ('n5ogdagtt2jssoslmp3k3noal4', 1293456002, 'cart|O:12:"shoppingCart":4:{s:8:"contents";a:0:{}s:5:"total";i:0;s:6:"weight";i:0;s:12:"content_type";b:0;}language|s:7:"english";languages_id|s:1:"1";currency|s:3:"GBP";navigation|O:17:"navigationHistory":2:{s:4:"path";a:1:{i:0;a:4:{s:4:"page";s:9:"index.php";s:4:"mode";s:6:"NONSSL";s:3:"get";a:1:{s:5:"cPath";s:3:"1_3";}s:4:"post";a:0:{}}}s:8:"snapshot";a:0:{}}');
INSERT INTO `sessions` VALUES ('g0qs4teidub8798c6i0p24k5o2', 1293456332, 'cart|O:12:"shoppingCart":5:{s:8:"contents";a:0:{}s:5:"total";i:0;s:6:"weight";i:0;s:6:"cartID";N;s:12:"content_type";b:0;}language|s:7:"english";languages_id|s:1:"1";currency|s:3:"GBP";navigation|O:17:"navigationHistory":2:{s:4:"path";a:3:{i:0;a:4:{s:4:"page";s:9:"index.php";s:4:"mode";s:6:"NONSSL";s:3:"get";a:1:{s:5:"cPath";s:3:"1_5";}s:4:"post";a:0:{}}i:1;a:4:{s:4:"page";s:9:"index.php";s:4:"mode";s:6:"NONSSL";s:3:"get";a:1:{s:5:"cPath";s:6:"1_5_24";}s:4:"post";a:0:{}}i:2;a:4:{s:4:"page";s:16:"product_info.php";s:4:"mode";s:6:"NONSSL";s:3:"get";a:1:{s:11:"products_id";s:3:"187";}s:4:"post";a:0:{}}}s:8:"snapshot";a:0:{}}');
INSERT INTO `sessions` VALUES ('7a5t553q56jflmk867f7q8vri1', 1293465412, 'cart|O:12:"shoppingCart":5:{s:8:"contents";a:1:{i:772;a:1:{s:3:"qty";i:1;}}s:5:"total";d:86.25;s:6:"weight";d:0;s:6:"cartID";s:5:"93507";s:12:"content_type";b:0;}language|s:7:"english";languages_id|s:1:"1";currency|s:3:"GBP";navigation|O:17:"navigationHistory":2:{s:4:"path";a:2:{i:0;a:4:{s:4:"page";s:9:"index.php";s:4:"mode";s:6:"NONSSL";s:3:"get";a:0:{}s:4:"post";a:0:{}}i:1;a:4:{s:4:"page";s:16:"product_info.php";s:4:"mode";s:6:"NONSSL";s:3:"get";a:1:{s:11:"products_id";s:2:"53";}s:4:"post";a:0:{}}}s:8:"snapshot";a:0:{}}');
INSERT INTO `sessions` VALUES ('3snu3kambnu8ds03hcsdounbb4', 1293456956, 'cart|O:12:"shoppingCart":5:{s:8:"contents";a:0:{}s:5:"total";i:0;s:6:"weight";i:0;s:6:"cartID";N;s:12:"content_type";b:0;}language|s:7:"english";languages_id|s:1:"1";currency|s:3:"GBP";navigation|O:17:"navigationHistory":2:{s:4:"path";a:4:{i:0;a:4:{s:4:"page";s:9:"index.php";s:4:"mode";s:6:"NONSSL";s:3:"get";a:1:{s:5:"cPath";s:3:"1_3";}s:4:"post";a:0:{}}i:1;a:4:{s:4:"page";s:9:"index.php";s:4:"mode";s:6:"NONSSL";s:3:"get";a:2:{s:5:"cPath";s:6:"1_3_13";s:6:"osCsid";s:26:"3snu3kambnu8ds03hcsdounbb4";}s:4:"post";a:0:{}}i:2;a:4:{s:4:"page";s:16:"product_info.php";s:4:"mode";s:6:"NONSSL";s:3:"get";a:1:{s:11:"products_id";s:2:"73";}s:4:"post";a:0:{}}i:3;a:4:{s:4:"page";s:12:"shipping.php";s:4:"mode";s:6:"NONSSL";s:3:"get";a:0:{}s:4:"post";a:0:{}}}s:8:"snapshot";a:0:{}}');
INSERT INTO `sessions` VALUES ('f9jvjch3lpq3chtoktgagnnrq7', 1293457369, 'cart|O:12:"shoppingCart":4:{s:8:"contents";a:0:{}s:5:"total";i:0;s:6:"weight";i:0;s:12:"content_type";b:0;}language|s:7:"english";languages_id|s:1:"1";currency|s:3:"GBP";navigation|O:17:"navigationHistory":2:{s:4:"path";a:1:{i:0;a:4:{s:4:"page";s:9:"index.php";s:4:"mode";s:6:"NONSSL";s:3:"get";a:1:{s:5:"cPath";s:3:"1_3";}s:4:"post";a:0:{}}}s:8:"snapshot";a:0:{}}');
INSERT INTO `sessions` VALUES ('cclcn09p7lhrl2smf8hjr9qsf6', 1293457803, 'cart|O:12:"shoppingCart":5:{s:8:"contents";a:0:{}s:5:"total";i:0;s:6:"weight";i:0;s:6:"cartID";N;s:12:"content_type";b:0;}language|s:7:"english";languages_id|s:1:"1";currency|s:3:"GBP";navigation|O:17:"navigationHistory":2:{s:4:"path";a:1:{i:0;a:4:{s:4:"page";s:9:"index.php";s:4:"mode";s:6:"NONSSL";s:3:"get";a:0:{}s:4:"post";a:0:{}}}s:8:"snapshot";a:0:{}}');
INSERT INTO `sessions` VALUES ('mdo79ks3cprncnh8re7t1eo576', 1293458617, 'cart|N;language|s:7:"english";languages_id|s:1:"1";currency|s:3:"GBP";navigation|N;');
INSERT INTO `sessions` VALUES ('e2jpnt3qtki8sqacj39dljj9s0', 1293458710, 'cart|O:12:"shoppingCart":5:{s:8:"contents";a:0:{}s:5:"total";i:0;s:6:"weight";i:0;s:6:"cartID";N;s:12:"content_type";b:0;}language|s:7:"english";languages_id|s:1:"1";currency|s:3:"GBP";navigation|O:17:"navigationHistory":2:{s:4:"path";a:3:{i:0;a:4:{s:4:"page";s:9:"index.php";s:4:"mode";s:6:"NONSSL";s:3:"get";a:1:{s:5:"cPath";s:3:"1_3";}s:4:"post";a:0:{}}i:1;a:4:{s:4:"page";s:9:"index.php";s:4:"mode";s:6:"NONSSL";s:3:"get";a:2:{s:5:"cPath";s:6:"1_3_12";s:6:"osCsid";s:26:"e2jpnt3qtki8sqacj39dljj9s0";}s:4:"post";a:0:{}}i:2;a:4:{s:4:"page";s:16:"product_info.php";s:4:"mode";s:6:"NONSSL";s:3:"get";a:1:{s:11:"products_id";s:2:"20";}s:4:"post";a:0:{}}}s:8:"snapshot";a:0:{}}');
INSERT INTO `sessions` VALUES ('fltntcq05g4a07brde69oqmht3', 1293459151, 'cart|O:12:"shoppingCart":5:{s:8:"contents";a:0:{}s:5:"total";i:0;s:6:"weight";i:0;s:6:"cartID";N;s:12:"content_type";b:0;}language|s:7:"english";languages_id|s:1:"1";currency|s:3:"GBP";navigation|O:17:"navigationHistory":2:{s:4:"path";a:1:{i:0;a:4:{s:4:"page";s:9:"index.php";s:4:"mode";s:6:"NONSSL";s:3:"get";a:0:{}s:4:"post";a:0:{}}}s:8:"snapshot";a:0:{}}');
INSERT INTO `sessions` VALUES ('e93j3kut7r9m1bm56vjboa76a4', 1293459639, 'cart|O:12:"shoppingCart":4:{s:8:"contents";a:0:{}s:5:"total";i:0;s:6:"weight";i:0;s:12:"content_type";b:0;}language|s:7:"english";languages_id|s:1:"1";currency|s:3:"GBP";navigation|O:17:"navigationHistory":2:{s:4:"path";a:1:{i:0;a:4:{s:4:"page";s:9:"index.php";s:4:"mode";s:6:"NONSSL";s:3:"get";a:0:{}s:4:"post";a:0:{}}}s:8:"snapshot";a:0:{}}');
INSERT INTO `sessions` VALUES ('54ruas821oe8drl1m92uj0olr0', 1293459971, 'cart|O:12:"shoppingCart":5:{s:8:"contents";a:0:{}s:5:"total";i:0;s:6:"weight";i:0;s:6:"cartID";N;s:12:"content_type";b:0;}language|s:7:"english";languages_id|s:1:"1";currency|s:3:"GBP";navigation|O:17:"navigationHistory":2:{s:4:"path";a:2:{i:0;a:4:{s:4:"page";s:9:"index.php";s:4:"mode";s:6:"NONSSL";s:3:"get";a:1:{s:5:"cPath";s:3:"1_3";}s:4:"post";a:0:{}}i:1;a:4:{s:4:"page";s:9:"index.php";s:4:"mode";s:6:"NONSSL";s:3:"get";a:1:{s:5:"cPath";s:6:"1_3_12";}s:4:"post";a:0:{}}}s:8:"snapshot";a:0:{}}');
INSERT INTO `sessions` VALUES ('jpnt0f9kfp0evnjisct9j6kh96', 1293459927, 'cart|O:12:"shoppingCart":5:{s:8:"contents";a:0:{}s:5:"total";i:0;s:6:"weight";i:0;s:6:"cartID";N;s:12:"content_type";b:0;}language|s:7:"english";languages_id|s:1:"1";currency|s:3:"GBP";navigation|O:17:"navigationHistory":2:{s:4:"path";a:2:{i:0;a:4:{s:4:"page";s:9:"index.php";s:4:"mode";s:6:"NONSSL";s:3:"get";a:1:{s:5:"cPath";s:3:"1_3";}s:4:"post";a:0:{}}i:1;a:4:{s:4:"page";s:9:"index.php";s:4:"mode";s:6:"NONSSL";s:3:"get";a:2:{s:5:"cPath";s:6:"1_3_12";s:6:"osCsid";s:26:"jpnt0f9kfp0evnjisct9j6kh96";}s:4:"post";a:0:{}}}s:8:"snapshot";a:0:{}}');
INSERT INTO `sessions` VALUES ('3rcl6eu463ma4kf3ndoijie8t7', 1293461493, 'cart|O:12:"shoppingCart":4:{s:8:"contents";a:0:{}s:5:"total";i:0;s:6:"weight";i:0;s:12:"content_type";b:0;}language|s:7:"english";languages_id|s:1:"1";currency|s:3:"GBP";navigation|O:17:"navigationHistory":2:{s:4:"path";a:1:{i:0;a:4:{s:4:"page";s:16:"product_info.php";s:4:"mode";s:6:"NONSSL";s:3:"get";a:1:{s:11:"products_id";s:3:"673";}s:4:"post";a:0:{}}}s:8:"snapshot";a:0:{}}');
INSERT INTO `sessions` VALUES ('47uhut0d8bmppnsm503fphqtr5', 1293462549, 'cart|O:12:"shoppingCart":4:{s:8:"contents";a:0:{}s:5:"total";i:0;s:6:"weight";i:0;s:12:"content_type";b:0;}language|s:7:"english";languages_id|s:1:"1";currency|s:3:"GBP";navigation|O:17:"navigationHistory":2:{s:4:"path";a:1:{i:0;a:4:{s:4:"page";s:9:"index.php";s:4:"mode";s:6:"NONSSL";s:3:"get";a:1:{s:5:"cPath";s:3:"1_5";}s:4:"post";a:0:{}}}s:8:"snapshot";a:0:{}}');
INSERT INTO `sessions` VALUES ('iptthuktujb9ai7hqca0mae5c1', 1293462835, 'cart|O:12:"shoppingCart":5:{s:8:"contents";a:0:{}s:5:"total";i:0;s:6:"weight";i:0;s:6:"cartID";N;s:12:"content_type";b:0;}language|s:7:"english";languages_id|s:1:"1";currency|s:3:"GBP";navigation|O:17:"navigationHistory":2:{s:4:"path";a:1:{i:0;a:4:{s:4:"page";s:9:"index.php";s:4:"mode";s:6:"NONSSL";s:3:"get";a:1:{s:5:"cPath";s:3:"1_5";}s:4:"post";a:0:{}}}s:8:"snapshot";a:0:{}}');
INSERT INTO `sessions` VALUES ('et7ipe07bug43kr9tm7ek1qkc6', 1293468162, 'cart|O:12:"shoppingCart":5:{s:8:"contents";a:0:{}s:5:"total";i:0;s:6:"weight";i:0;s:6:"cartID";N;s:12:"content_type";b:0;}language|s:7:"english";languages_id|s:1:"1";currency|s:3:"GBP";navigation|O:17:"navigationHistory":2:{s:4:"path";a:1:{i:0;a:4:{s:4:"page";s:9:"index.php";s:4:"mode";s:6:"NONSSL";s:3:"get";a:1:{s:5:"cPath";s:3:"1_5";}s:4:"post";a:0:{}}}s:8:"snapshot";a:0:{}}');

-- --------------------------------------------------------

--
-- Table structure for table `specials`
--

CREATE TABLE `specials` (
  `specials_id` int(11) NOT NULL auto_increment,
  `products_id` int(11) NOT NULL,
  `specials_new_products_price` decimal(15,4) NOT NULL,
  `specials_date_added` datetime default NULL,
  `specials_last_modified` datetime default NULL,
  `expires_date` datetime default NULL,
  `date_status_change` datetime default NULL,
  `status` int(1) NOT NULL default '1',
  PRIMARY KEY  (`specials_id`),
  KEY `idx_specials_products_id` (`products_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=36 ;

--
-- Dumping data for table `specials`
--

INSERT INTO `specials` VALUES (11, 386, 51.0638, '2010-12-26 09:36:32', '2010-12-26 13:36:50', '2011-01-31 00:00:00', NULL, 1);
INSERT INTO `specials` VALUES (12, 759, 70.2128, '2010-12-26 09:42:37', NULL, '0000-00-00 00:00:00', NULL, 1);
INSERT INTO `specials` VALUES (13, 477, 70.2128, '2010-12-26 09:43:09', NULL, '0000-00-00 00:00:00', NULL, 1);
INSERT INTO `specials` VALUES (14, 772, 73.4042, '2010-12-26 09:43:42', '2010-12-26 09:44:35', '0000-00-00 00:00:00', NULL, 1);
INSERT INTO `specials` VALUES (15, 387, 57.4468, '2010-12-26 09:44:14', NULL, '0000-00-00 00:00:00', NULL, 1);
INSERT INTO `specials` VALUES (16, 679, 180.0000, '2010-12-26 09:45:06', NULL, '0000-00-00 00:00:00', NULL, 1);
INSERT INTO `specials` VALUES (17, 21, 64.6809, '2010-12-26 09:57:37', '2010-12-26 10:01:11', '2011-02-28 00:00:00', NULL, 1);
INSERT INTO `specials` VALUES (18, 44, 305.7022, '2010-12-27 10:14:47', '2010-12-27 16:01:28', '2011-01-31 00:00:00', NULL, 1);
INSERT INTO `specials` VALUES (19, 19, 203.5745, '2010-12-27 10:15:21', NULL, '2011-01-31 00:00:00', NULL, 1);
INSERT INTO `specials` VALUES (20, 22, 196.7659, '2010-12-27 10:17:36', NULL, '2011-01-31 00:00:00', NULL, 1);
INSERT INTO `specials` VALUES (21, 14, 169.5319, '2010-12-27 10:30:50', NULL, '2011-01-31 00:00:00', NULL, 1);
INSERT INTO `specials` VALUES (22, 7, 183.1490, '2010-12-27 10:43:36', NULL, '2011-01-31 00:00:00', NULL, 1);
INSERT INTO `specials` VALUES (23, 6, 128.6809, '2010-12-27 10:44:16', NULL, '2011-01-31 00:00:00', NULL, 1);
INSERT INTO `specials` VALUES (24, 9, 128.6809, '2010-12-27 10:44:40', NULL, '2011-01-31 00:00:00', NULL, 1);
INSERT INTO `specials` VALUES (25, 11, 189.9574, '2010-12-27 10:45:10', NULL, '2011-01-31 00:00:00', NULL, 1);
INSERT INTO `specials` VALUES (26, 10, 183.1490, '2010-12-27 10:45:35', NULL, '2011-01-31 00:00:00', NULL, 1);
INSERT INTO `specials` VALUES (27, 8, 183.1490, '2010-12-27 10:45:58', NULL, '2011-01-31 00:00:00', NULL, 1);
INSERT INTO `specials` VALUES (28, 5, 162.7234, '2010-12-27 10:46:26', NULL, '2011-01-31 00:00:00', NULL, 1);
INSERT INTO `specials` VALUES (29, 48, 237.6170, '2010-12-27 10:52:01', NULL, '2011-01-31 00:00:00', NULL, 1);
INSERT INTO `specials` VALUES (30, 47, 224.0000, '2010-12-27 10:52:31', NULL, '2011-01-31 00:00:00', NULL, 1);
INSERT INTO `specials` VALUES (31, 71, 224.0000, '2010-12-27 10:52:57', NULL, '2011-01-31 00:00:00', NULL, 1);
INSERT INTO `specials` VALUES (32, 72, 237.6170, '2010-12-27 10:53:25', NULL, '2011-01-31 00:00:00', NULL, 1);
INSERT INTO `specials` VALUES (33, 53, 274.9787, '2010-12-27 10:55:10', '2010-12-27 16:12:21', '2011-01-31 00:00:00', NULL, 1);
INSERT INTO `specials` VALUES (34, 55, 264.8510, '2010-12-27 10:56:58', NULL, '2011-01-31 00:00:00', NULL, 1);
INSERT INTO `specials` VALUES (35, 45, 121.8723, '2010-12-27 10:59:29', NULL, '2011-01-31 00:00:00', NULL, 1);

-- --------------------------------------------------------

--
-- Table structure for table `tax_class`
--

CREATE TABLE `tax_class` (
  `tax_class_id` int(11) NOT NULL auto_increment,
  `tax_class_title` varchar(32) NOT NULL,
  `tax_class_description` varchar(255) NOT NULL,
  `last_modified` datetime default NULL,
  `date_added` datetime NOT NULL,
  PRIMARY KEY  (`tax_class_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=2 ;

--
-- Dumping data for table `tax_class`
--

INSERT INTO `tax_class` VALUES (1, 'VAT Taxable Goods', 'The following types of products are included non-food, services, etc', '2010-04-26 09:31:37', '2010-04-26 09:31:37');

-- --------------------------------------------------------

--
-- Table structure for table `tax_rates`
--

CREATE TABLE `tax_rates` (
  `tax_rates_id` int(11) NOT NULL auto_increment,
  `tax_zone_id` int(11) NOT NULL,
  `tax_class_id` int(11) NOT NULL,
  `tax_priority` int(5) default '1',
  `tax_rate` decimal(7,4) NOT NULL,
  `tax_description` varchar(255) NOT NULL,
  `last_modified` datetime default NULL,
  `date_added` datetime NOT NULL,
  PRIMARY KEY  (`tax_rates_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=2 ;

--
-- Dumping data for table `tax_rates`
--

INSERT INTO `tax_rates` VALUES (1, 1, 1, 0, 17.5000, 'VAT (17.5%)', '2010-04-26 09:31:37', '2010-04-26 09:31:37');

-- --------------------------------------------------------

--
-- Table structure for table `whos_online`
--

CREATE TABLE `whos_online` (
  `customer_id` int(11) default NULL,
  `full_name` varchar(64) NOT NULL,
  `session_id` varchar(128) NOT NULL,
  `ip_address` varchar(15) NOT NULL,
  `time_entry` varchar(14) NOT NULL,
  `time_last_click` varchar(14) NOT NULL,
  `last_page_url` text NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `whos_online`
--

INSERT INTO `whos_online` VALUES (0, 'Guest', 'e6j044sk6bllh5qhqahufps1n3', '86.156.46.93', '1293466053', '1293466938', '/index.php?cPath=10&page=4');
INSERT INTO `whos_online` VALUES (0, 'Guest', 'et7ipe07bug43kr9tm7ek1qkc6', '86.139.182.207', '1293466699', '1293466722', '/index.php?cPath=1_5');
INSERT INTO `whos_online` VALUES (0, 'Guest', 'qpqe8p4a0alcmup1vrcahn1b02', '85.211.133.242', '1293465286', '1293466366', '/specials.php?sort=0d&page=2');

-- --------------------------------------------------------

--
-- Table structure for table `zones`
--

CREATE TABLE `zones` (
  `zone_id` int(11) NOT NULL auto_increment,
  `zone_country_id` int(11) NOT NULL,
  `zone_code` varchar(32) NOT NULL,
  `zone_name` varchar(32) NOT NULL,
  PRIMARY KEY  (`zone_id`),
  KEY `idx_zones_country_id` (`zone_country_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=438 ;

--
-- Dumping data for table `zones`
--

INSERT INTO `zones` VALUES (1, 223, 'AL', 'Alabama');
INSERT INTO `zones` VALUES (2, 223, 'AK', 'Alaska');
INSERT INTO `zones` VALUES (3, 223, 'AS', 'American Samoa');
INSERT INTO `zones` VALUES (4, 223, 'AZ', 'Arizona');
INSERT INTO `zones` VALUES (5, 223, 'AR', 'Arkansas');
INSERT INTO `zones` VALUES (6, 223, 'AF', 'Armed Forces Africa');
INSERT INTO `zones` VALUES (7, 223, 'AA', 'Armed Forces Americas');
INSERT INTO `zones` VALUES (8, 223, 'AC', 'Armed Forces Canada');
INSERT INTO `zones` VALUES (9, 223, 'AE', 'Armed Forces Europe');
INSERT INTO `zones` VALUES (10, 223, 'AM', 'Armed Forces Middle East');
INSERT INTO `zones` VALUES (11, 223, 'AP', 'Armed Forces Pacific');
INSERT INTO `zones` VALUES (12, 223, 'CA', 'California');
INSERT INTO `zones` VALUES (13, 223, 'CO', 'Colorado');
INSERT INTO `zones` VALUES (14, 223, 'CT', 'Connecticut');
INSERT INTO `zones` VALUES (15, 223, 'DE', 'Delaware');
INSERT INTO `zones` VALUES (16, 223, 'DC', 'District of Columbia');
INSERT INTO `zones` VALUES (17, 223, 'FM', 'Federated States Of Micronesia');
INSERT INTO `zones` VALUES (18, 223, 'FL', 'Florida');
INSERT INTO `zones` VALUES (19, 223, 'GA', 'Georgia');
INSERT INTO `zones` VALUES (20, 223, 'GU', 'Guam');
INSERT INTO `zones` VALUES (21, 223, 'HI', 'Hawaii');
INSERT INTO `zones` VALUES (22, 223, 'ID', 'Idaho');
INSERT INTO `zones` VALUES (23, 223, 'IL', 'Illinois');
INSERT INTO `zones` VALUES (24, 223, 'IN', 'Indiana');
INSERT INTO `zones` VALUES (25, 223, 'IA', 'Iowa');
INSERT INTO `zones` VALUES (26, 223, 'KS', 'Kansas');
INSERT INTO `zones` VALUES (27, 223, 'KY', 'Kentucky');
INSERT INTO `zones` VALUES (28, 223, 'LA', 'Louisiana');
INSERT INTO `zones` VALUES (29, 223, 'ME', 'Maine');
INSERT INTO `zones` VALUES (30, 223, 'MH', 'Marshall Islands');
INSERT INTO `zones` VALUES (31, 223, 'MD', 'Maryland');
INSERT INTO `zones` VALUES (32, 223, 'MA', 'Massachusetts');
INSERT INTO `zones` VALUES (33, 223, 'MI', 'Michigan');
INSERT INTO `zones` VALUES (34, 223, 'MN', 'Minnesota');
INSERT INTO `zones` VALUES (35, 223, 'MS', 'Mississippi');
INSERT INTO `zones` VALUES (36, 223, 'MO', 'Missouri');
INSERT INTO `zones` VALUES (37, 223, 'MT', 'Montana');
INSERT INTO `zones` VALUES (38, 223, 'NE', 'Nebraska');
INSERT INTO `zones` VALUES (39, 223, 'NV', 'Nevada');
INSERT INTO `zones` VALUES (40, 223, 'NH', 'New Hampshire');
INSERT INTO `zones` VALUES (41, 223, 'NJ', 'New Jersey');
INSERT INTO `zones` VALUES (42, 223, 'NM', 'New Mexico');
INSERT INTO `zones` VALUES (43, 223, 'NY', 'New York');
INSERT INTO `zones` VALUES (44, 223, 'NC', 'North Carolina');
INSERT INTO `zones` VALUES (45, 223, 'ND', 'North Dakota');
INSERT INTO `zones` VALUES (46, 223, 'MP', 'Northern Mariana Islands');
INSERT INTO `zones` VALUES (47, 223, 'OH', 'Ohio');
INSERT INTO `zones` VALUES (48, 223, 'OK', 'Oklahoma');
INSERT INTO `zones` VALUES (49, 223, 'OR', 'Oregon');
INSERT INTO `zones` VALUES (50, 223, 'PW', 'Palau');
INSERT INTO `zones` VALUES (51, 223, 'PA', 'Pennsylvania');
INSERT INTO `zones` VALUES (52, 223, 'PR', 'Puerto Rico');
INSERT INTO `zones` VALUES (53, 223, 'RI', 'Rhode Island');
INSERT INTO `zones` VALUES (54, 223, 'SC', 'South Carolina');
INSERT INTO `zones` VALUES (55, 223, 'SD', 'South Dakota');
INSERT INTO `zones` VALUES (56, 223, 'TN', 'Tennessee');
INSERT INTO `zones` VALUES (57, 223, 'TX', 'Texas');
INSERT INTO `zones` VALUES (58, 223, 'UT', 'Utah');
INSERT INTO `zones` VALUES (59, 223, 'VT', 'Vermont');
INSERT INTO `zones` VALUES (60, 223, 'VI', 'Virgin Islands');
INSERT INTO `zones` VALUES (61, 223, 'VA', 'Virginia');
INSERT INTO `zones` VALUES (62, 223, 'WA', 'Washington');
INSERT INTO `zones` VALUES (63, 223, 'WV', 'West Virginia');
INSERT INTO `zones` VALUES (64, 223, 'WI', 'Wisconsin');
INSERT INTO `zones` VALUES (65, 223, 'WY', 'Wyoming');
INSERT INTO `zones` VALUES (66, 38, 'AB', 'Alberta');
INSERT INTO `zones` VALUES (67, 38, 'BC', 'British Columbia');
INSERT INTO `zones` VALUES (68, 38, 'MB', 'Manitoba');
INSERT INTO `zones` VALUES (69, 38, 'NF', 'Newfoundland');
INSERT INTO `zones` VALUES (70, 38, 'NB', 'New Brunswick');
INSERT INTO `zones` VALUES (71, 38, 'NS', 'Nova Scotia');
INSERT INTO `zones` VALUES (72, 38, 'NT', 'Northwest Territories');
INSERT INTO `zones` VALUES (73, 38, 'NU', 'Nunavut');
INSERT INTO `zones` VALUES (74, 38, 'ON', 'Ontario');
INSERT INTO `zones` VALUES (75, 38, 'PE', 'Prince Edward Island');
INSERT INTO `zones` VALUES (76, 38, 'QC', 'Quebec');
INSERT INTO `zones` VALUES (77, 38, 'SK', 'Saskatchewan');
INSERT INTO `zones` VALUES (78, 38, 'YT', 'Yukon Territory');
INSERT INTO `zones` VALUES (79, 81, 'NDS', 'Niedersachsen');
INSERT INTO `zones` VALUES (80, 81, 'BAW', 'Baden-W?rttemberg');
INSERT INTO `zones` VALUES (81, 81, 'BAY', 'Bayern');
INSERT INTO `zones` VALUES (82, 81, 'BER', 'Berlin');
INSERT INTO `zones` VALUES (83, 81, 'BRG', 'Brandenburg');
INSERT INTO `zones` VALUES (84, 81, 'BRE', 'Bremen');
INSERT INTO `zones` VALUES (85, 81, 'HAM', 'Hamburg');
INSERT INTO `zones` VALUES (86, 81, 'HES', 'Hessen');
INSERT INTO `zones` VALUES (87, 81, 'MEC', 'Mecklenburg-Vorpommern');
INSERT INTO `zones` VALUES (88, 81, 'NRW', 'Nordrhein-Westfalen');
INSERT INTO `zones` VALUES (89, 81, 'RHE', 'Rheinland-Pfalz');
INSERT INTO `zones` VALUES (90, 81, 'SAR', 'Saarland');
INSERT INTO `zones` VALUES (91, 81, 'SAS', 'Sachsen');
INSERT INTO `zones` VALUES (92, 81, 'SAC', 'Sachsen-Anhalt');
INSERT INTO `zones` VALUES (93, 81, 'SCN', 'Schleswig-Holstein');
INSERT INTO `zones` VALUES (94, 81, 'THE', 'Th?ringen');
INSERT INTO `zones` VALUES (95, 14, 'WI', 'Wien');
INSERT INTO `zones` VALUES (96, 14, 'NO', 'Nieder?sterreich');
INSERT INTO `zones` VALUES (97, 14, 'OO', 'Ober?sterreich');
INSERT INTO `zones` VALUES (98, 14, 'SB', 'Salzburg');
INSERT INTO `zones` VALUES (99, 14, 'KN', 'K?rnten');
INSERT INTO `zones` VALUES (100, 14, 'ST', 'Steiermark');
INSERT INTO `zones` VALUES (101, 14, 'TI', 'Tirol');
INSERT INTO `zones` VALUES (102, 14, 'BL', 'Burgenland');
INSERT INTO `zones` VALUES (103, 14, 'VB', 'Voralberg');
INSERT INTO `zones` VALUES (104, 204, 'AG', 'Aargau');
INSERT INTO `zones` VALUES (105, 204, 'AI', 'Appenzell Innerrhoden');
INSERT INTO `zones` VALUES (106, 204, 'AR', 'Appenzell Ausserrhoden');
INSERT INTO `zones` VALUES (107, 204, 'BE', 'Bern');
INSERT INTO `zones` VALUES (108, 204, 'BL', 'Basel-Landschaft');
INSERT INTO `zones` VALUES (109, 204, 'BS', 'Basel-Stadt');
INSERT INTO `zones` VALUES (110, 204, 'FR', 'Freiburg');
INSERT INTO `zones` VALUES (111, 204, 'GE', 'Genf');
INSERT INTO `zones` VALUES (112, 204, 'GL', 'Glarus');
INSERT INTO `zones` VALUES (113, 204, 'JU', 'Graub?nden');
INSERT INTO `zones` VALUES (114, 204, 'JU', 'Jura');
INSERT INTO `zones` VALUES (115, 204, 'LU', 'Luzern');
INSERT INTO `zones` VALUES (116, 204, 'NE', 'Neuenburg');
INSERT INTO `zones` VALUES (117, 204, 'NW', 'Nidwalden');
INSERT INTO `zones` VALUES (118, 204, 'OW', 'Obwalden');
INSERT INTO `zones` VALUES (119, 204, 'SG', 'St. Gallen');
INSERT INTO `zones` VALUES (120, 204, 'SH', 'Schaffhausen');
INSERT INTO `zones` VALUES (121, 204, 'SO', 'Solothurn');
INSERT INTO `zones` VALUES (122, 204, 'SZ', 'Schwyz');
INSERT INTO `zones` VALUES (123, 204, 'TG', 'Thurgau');
INSERT INTO `zones` VALUES (124, 204, 'TI', 'Tessin');
INSERT INTO `zones` VALUES (125, 204, 'UR', 'Uri');
INSERT INTO `zones` VALUES (126, 204, 'VD', 'Waadt');
INSERT INTO `zones` VALUES (127, 204, 'VS', 'Wallis');
INSERT INTO `zones` VALUES (128, 204, 'ZG', 'Zug');
INSERT INTO `zones` VALUES (129, 204, 'ZH', 'Z?rich');
INSERT INTO `zones` VALUES (130, 195, 'A Coru?a', 'A Coru?a');
INSERT INTO `zones` VALUES (131, 195, 'Alava', 'Alava');
INSERT INTO `zones` VALUES (132, 195, 'Albacete', 'Albacete');
INSERT INTO `zones` VALUES (133, 195, 'Alicante', 'Alicante');
INSERT INTO `zones` VALUES (134, 195, 'Almeria', 'Almeria');
INSERT INTO `zones` VALUES (135, 195, 'Asturias', 'Asturias');
INSERT INTO `zones` VALUES (136, 195, 'Avila', 'Avila');
INSERT INTO `zones` VALUES (137, 195, 'Badajoz', 'Badajoz');
INSERT INTO `zones` VALUES (138, 195, 'Baleares', 'Baleares');
INSERT INTO `zones` VALUES (139, 195, 'Barcelona', 'Barcelona');
INSERT INTO `zones` VALUES (140, 195, 'Burgos', 'Burgos');
INSERT INTO `zones` VALUES (141, 195, 'Caceres', 'Caceres');
INSERT INTO `zones` VALUES (142, 195, 'Cadiz', 'Cadiz');
INSERT INTO `zones` VALUES (143, 195, 'Cantabria', 'Cantabria');
INSERT INTO `zones` VALUES (144, 195, 'Castellon', 'Castellon');
INSERT INTO `zones` VALUES (145, 195, 'Ceuta', 'Ceuta');
INSERT INTO `zones` VALUES (146, 195, 'Ciudad Real', 'Ciudad Real');
INSERT INTO `zones` VALUES (147, 195, 'Cordoba', 'Cordoba');
INSERT INTO `zones` VALUES (148, 195, 'Cuenca', 'Cuenca');
INSERT INTO `zones` VALUES (149, 195, 'Girona', 'Girona');
INSERT INTO `zones` VALUES (150, 195, 'Granada', 'Granada');
INSERT INTO `zones` VALUES (151, 195, 'Guadalajara', 'Guadalajara');
INSERT INTO `zones` VALUES (152, 195, 'Guipuzcoa', 'Guipuzcoa');
INSERT INTO `zones` VALUES (153, 195, 'Huelva', 'Huelva');
INSERT INTO `zones` VALUES (154, 195, 'Huesca', 'Huesca');
INSERT INTO `zones` VALUES (155, 195, 'Jaen', 'Jaen');
INSERT INTO `zones` VALUES (156, 195, 'La Rioja', 'La Rioja');
INSERT INTO `zones` VALUES (157, 195, 'Las Palmas', 'Las Palmas');
INSERT INTO `zones` VALUES (158, 195, 'Leon', 'Leon');
INSERT INTO `zones` VALUES (159, 195, 'Lleida', 'Lleida');
INSERT INTO `zones` VALUES (160, 195, 'Lugo', 'Lugo');
INSERT INTO `zones` VALUES (161, 195, 'Madrid', 'Madrid');
INSERT INTO `zones` VALUES (162, 195, 'Malaga', 'Malaga');
INSERT INTO `zones` VALUES (163, 195, 'Melilla', 'Melilla');
INSERT INTO `zones` VALUES (164, 195, 'Murcia', 'Murcia');
INSERT INTO `zones` VALUES (165, 195, 'Navarra', 'Navarra');
INSERT INTO `zones` VALUES (166, 195, 'Ourense', 'Ourense');
INSERT INTO `zones` VALUES (167, 195, 'Palencia', 'Palencia');
INSERT INTO `zones` VALUES (168, 195, 'Pontevedra', 'Pontevedra');
INSERT INTO `zones` VALUES (169, 195, 'Salamanca', 'Salamanca');
INSERT INTO `zones` VALUES (170, 195, 'Santa Cruz de Tenerife', 'Santa Cruz de Tenerife');
INSERT INTO `zones` VALUES (171, 195, 'Segovia', 'Segovia');
INSERT INTO `zones` VALUES (172, 195, 'Sevilla', 'Sevilla');
INSERT INTO `zones` VALUES (173, 195, 'Soria', 'Soria');
INSERT INTO `zones` VALUES (174, 195, 'Tarragona', 'Tarragona');
INSERT INTO `zones` VALUES (175, 195, 'Teruel', 'Teruel');
INSERT INTO `zones` VALUES (176, 195, 'Toledo', 'Toledo');
INSERT INTO `zones` VALUES (177, 195, 'Valencia', 'Valencia');
INSERT INTO `zones` VALUES (178, 195, 'Valladolid', 'Valladolid');
INSERT INTO `zones` VALUES (179, 195, 'Vizcaya', 'Vizcaya');
INSERT INTO `zones` VALUES (180, 195, 'Zamora', 'Zamora');
INSERT INTO `zones` VALUES (181, 195, 'Zaragoza', 'Zaragoza');
INSERT INTO `zones` VALUES (327, 222, 'MOG', 'Co. Monaghan, Ireland');
INSERT INTO `zones` VALUES (326, 222, 'MEA', 'Co. Meath, Ireland');
INSERT INTO `zones` VALUES (325, 222, 'MAY', 'Co. Mayo, Ireland');
INSERT INTO `zones` VALUES (324, 222, 'LOU', 'Co. Louth, Ireland');
INSERT INTO `zones` VALUES (323, 222, 'LOG', 'Co. Longford, Ireland');
INSERT INTO `zones` VALUES (322, 222, 'LDY', 'Co. Londonderry, Northern Irelan');
INSERT INTO `zones` VALUES (321, 222, 'LIM', 'Co. Limerick, Ireland');
INSERT INTO `zones` VALUES (320, 222, 'LET', 'Co. Leitrim, Ireland');
INSERT INTO `zones` VALUES (319, 222, 'LEX', 'Co. Laois, Ireland');
INSERT INTO `zones` VALUES (318, 222, 'KIK', 'Co. Kilkenny, Ireland');
INSERT INTO `zones` VALUES (317, 222, 'KID', 'Co. Kildare, Ireland');
INSERT INTO `zones` VALUES (316, 222, 'KER', 'Co. Kerry, Ireland');
INSERT INTO `zones` VALUES (315, 222, 'GAL', 'Co. Galway, Ireland');
INSERT INTO `zones` VALUES (314, 222, 'FER', 'Co. Fermanagh, Northern Ireland');
INSERT INTO `zones` VALUES (313, 222, 'DUR', 'Co. Durham, England');
INSERT INTO `zones` VALUES (312, 222, 'DUB', 'Co. Dublin, Ireland');
INSERT INTO `zones` VALUES (311, 222, 'DOW', 'Co. Down, Northern Ireland');
INSERT INTO `zones` VALUES (310, 222, 'DON', 'Co. Donegal, Ireland');
INSERT INTO `zones` VALUES (309, 222, 'COR', 'Co. Cork, Ireland');
INSERT INTO `zones` VALUES (308, 222, 'CLA', 'Co. Clare, Ireland');
INSERT INTO `zones` VALUES (307, 222, 'CAV', 'Co. Cavan, Ireland');
INSERT INTO `zones` VALUES (306, 222, 'CAR', 'Co. Carlow, Ireland');
INSERT INTO `zones` VALUES (305, 222, 'ARM', 'Co. Armagh, Northern Ireland');
INSERT INTO `zones` VALUES (304, 222, 'ANT', 'Co. Antrim, Northern Ireland');
INSERT INTO `zones` VALUES (303, 222, 'CWD', 'Clwyd, Wales');
INSERT INTO `zones` VALUES (302, 222, 'CLV', 'Cleveland, England');
INSERT INTO `zones` VALUES (301, 222, 'CLK', 'Clackmannanshire, Scotland');
INSERT INTO `zones` VALUES (300, 222, 'CHS', 'Cheshire, England');
INSERT INTO `zones` VALUES (299, 222, 'CHI', 'Channel Islands');
INSERT INTO `zones` VALUES (298, 222, 'CEN', 'Central, Scotland');
INSERT INTO `zones` VALUES (297, 222, 'CMN', 'Carmarthenshire, Wales');
INSERT INTO `zones` VALUES (296, 222, 'CGN', 'Cardiganshire, Wales');
INSERT INTO `zones` VALUES (295, 222, 'CAM', 'Cambridgeshire, England');
INSERT INTO `zones` VALUES (294, 222, 'CAI', 'Caithness, Scotland');
INSERT INTO `zones` VALUES (293, 222, 'CAE', 'Caernarvonshire, Wales');
INSERT INTO `zones` VALUES (292, 222, 'BUT', 'Bute, Scotland');
INSERT INTO `zones` VALUES (291, 222, 'BKM', 'Buckinghamshire, England');
INSERT INTO `zones` VALUES (290, 222, 'BRE', 'Breconshire, Wales');
INSERT INTO `zones` VALUES (289, 222, 'BOR', 'Borders, Scotland');
INSERT INTO `zones` VALUES (288, 222, 'BEW', 'Berwickshire, Scotland');
INSERT INTO `zones` VALUES (287, 222, 'BRK', 'Berkshire, England');
INSERT INTO `zones` VALUES (286, 222, 'BDF', 'Bedfordshire, England');
INSERT INTO `zones` VALUES (285, 222, 'BAN', 'Banffshire, Scotland');
INSERT INTO `zones` VALUES (284, 222, 'AYR', 'Ayrshire, Scotland');
INSERT INTO `zones` VALUES (283, 222, 'AVN', 'Avon, England');
INSERT INTO `zones` VALUES (282, 222, 'ARL', 'Argyllshire, Scotland');
INSERT INTO `zones` VALUES (281, 222, 'ANS', 'Angus, Scotland');
INSERT INTO `zones` VALUES (280, 222, 'AGY', 'Anglesey, Wales');
INSERT INTO `zones` VALUES (279, 222, 'ALD', 'Alderney, Channel Islands');
INSERT INTO `zones` VALUES (278, 222, 'ABD', 'Aberdeenshire, Scotland');
INSERT INTO `zones` VALUES (328, 222, 'OFF', 'Co. Offaly, Ireland');
INSERT INTO `zones` VALUES (329, 222, 'ROS', 'Co. Roscommon, Ireland');
INSERT INTO `zones` VALUES (330, 222, 'SLI', 'Co. Sligo, Ireland');
INSERT INTO `zones` VALUES (331, 222, 'TIP', 'Co. Tipperary, Ireland');
INSERT INTO `zones` VALUES (332, 222, 'TYR', 'Co. Tyrone, Northern Ireland');
INSERT INTO `zones` VALUES (333, 222, 'WAT', 'Co. Waterford, Ireland');
INSERT INTO `zones` VALUES (334, 222, 'WEM', 'Co. Westmeath, Ireland');
INSERT INTO `zones` VALUES (335, 222, 'WEX', 'Co. Wexford, Ireland');
INSERT INTO `zones` VALUES (336, 222, 'WIC', 'Co. Wicklow, Ireland');
INSERT INTO `zones` VALUES (337, 222, 'CON', 'Cornwall, England');
INSERT INTO `zones` VALUES (338, 222, 'CUL', 'Cumberland, England');
INSERT INTO `zones` VALUES (339, 222, 'CMA', 'Cumbria, England');
INSERT INTO `zones` VALUES (340, 222, 'DEN', 'Denbighshire, Wales');
INSERT INTO `zones` VALUES (341, 222, 'DBY', 'Derbyshire, England');
INSERT INTO `zones` VALUES (342, 222, 'DEV', 'Devon, England');
INSERT INTO `zones` VALUES (343, 222, 'DOR', 'Dorset, England');
INSERT INTO `zones` VALUES (344, 222, 'DGY', 'Dumfries and Galloway, Scotland');
INSERT INTO `zones` VALUES (345, 222, 'DFS', 'Dumfries-shire, Scotland');
INSERT INTO `zones` VALUES (346, 222, 'DNB', 'Dunbartonshire, Scotland');
INSERT INTO `zones` VALUES (347, 222, 'DFD', 'Dyfed, Wales');
INSERT INTO `zones` VALUES (348, 222, 'ELN', 'East Lothian, Scotland');
INSERT INTO `zones` VALUES (349, 222, 'ERY', 'East Riding of Yorkshire, Englan');
INSERT INTO `zones` VALUES (350, 222, 'SXE', 'East Sussex, England');
INSERT INTO `zones` VALUES (351, 222, 'ESS', 'Essex, England');
INSERT INTO `zones` VALUES (352, 222, 'FIF', 'Fife, Scotland');
INSERT INTO `zones` VALUES (353, 222, 'FLN', 'Flintshire, Wales');
INSERT INTO `zones` VALUES (354, 222, 'GLA', 'Glamorgan, Wales');
INSERT INTO `zones` VALUES (355, 222, 'GLS', 'Gloucestershire, England');
INSERT INTO `zones` VALUES (356, 222, 'GMP', 'Grampian, Scotland');
INSERT INTO `zones` VALUES (357, 222, 'GTM', 'Greater Manchester, England');
INSERT INTO `zones` VALUES (358, 222, 'GSY', 'Guernsey, Channel Islands');
INSERT INTO `zones` VALUES (359, 222, 'GNT', 'Gwent, Wales');
INSERT INTO `zones` VALUES (360, 222, 'GWN', 'Gwynedd, Wales');
INSERT INTO `zones` VALUES (361, 222, 'HAM', 'Hampshire, England');
INSERT INTO `zones` VALUES (362, 222, 'HWR', 'Hereford and Worcester, England');
INSERT INTO `zones` VALUES (363, 222, 'HEF', 'Herefordshire, England');
INSERT INTO `zones` VALUES (364, 222, 'HRT', 'Hertfordshire, England');
INSERT INTO `zones` VALUES (365, 222, 'HLD', 'Highland, Scotland');
INSERT INTO `zones` VALUES (366, 222, 'HUM', 'Humberside, England');
INSERT INTO `zones` VALUES (367, 222, 'HUN', 'Huntingdonshire, England');
INSERT INTO `zones` VALUES (368, 222, 'INV', 'Inverness-shire, Scotland');
INSERT INTO `zones` VALUES (369, 222, 'IOM', 'Isle of Man');
INSERT INTO `zones` VALUES (370, 222, 'IOW', 'Isle of Wight, England');
INSERT INTO `zones` VALUES (371, 222, 'JSY', 'Jersey, Channel Islands');
INSERT INTO `zones` VALUES (372, 222, 'KEN', 'Kent, England');
INSERT INTO `zones` VALUES (373, 222, 'KCD', 'Kincardineshire, Scotland');
INSERT INTO `zones` VALUES (374, 222, 'KRS', 'Kinross-shire, Scotland');
INSERT INTO `zones` VALUES (375, 222, 'KKD', 'Kirkcudbrightshire, Scotland');
INSERT INTO `zones` VALUES (376, 222, 'LKS', 'Lanarkshire, Scotland');
INSERT INTO `zones` VALUES (377, 222, 'LAN', 'Lancashire, England');
INSERT INTO `zones` VALUES (378, 222, 'LEI', 'Leicestershire, England');
INSERT INTO `zones` VALUES (379, 222, 'LIN', 'Lincolnshire, England');
INSERT INTO `zones` VALUES (380, 222, 'LND', 'London, England');
INSERT INTO `zones` VALUES (381, 222, 'LTN', 'Lothian, Scotland');
INSERT INTO `zones` VALUES (382, 222, 'MER', 'Merionethshire, Wales');
INSERT INTO `zones` VALUES (383, 222, 'MSY', 'Merseyside, England');
INSERT INTO `zones` VALUES (384, 222, 'MGM', 'Mid Glamorgan, Wales');
INSERT INTO `zones` VALUES (385, 222, 'MDX', 'Middlesex, England');
INSERT INTO `zones` VALUES (386, 222, 'MLN', 'Midlothian, Scotland');
INSERT INTO `zones` VALUES (387, 222, 'MON', 'Monmouthshire, Wales');
INSERT INTO `zones` VALUES (388, 222, 'MGY', 'Montgomeryshire, Wales');
INSERT INTO `zones` VALUES (389, 222, 'MOR', 'Morayshire, Scotland');
INSERT INTO `zones` VALUES (390, 222, 'NAI', 'Nairn, Scotland');
INSERT INTO `zones` VALUES (391, 222, 'NFK', 'Norfolk, England');
INSERT INTO `zones` VALUES (392, 222, 'NRY', 'North Riding of Yorkshire, Engla');
INSERT INTO `zones` VALUES (393, 222, 'NYK', 'North Yorkshire, England');
INSERT INTO `zones` VALUES (394, 222, 'NTH', 'Northamptonshire, England');
INSERT INTO `zones` VALUES (395, 222, 'NIR', 'Northern Ireland');
INSERT INTO `zones` VALUES (396, 222, 'NBL', 'Northumberland, England');
INSERT INTO `zones` VALUES (397, 222, 'NTT', 'Nottinghamshire, England');
INSERT INTO `zones` VALUES (398, 222, 'OKI', 'Orkney, Scotland');
INSERT INTO `zones` VALUES (399, 222, 'OXF', 'Oxfordshire, England');
INSERT INTO `zones` VALUES (400, 222, 'PEE', 'Peebles-shire, Scotland');
INSERT INTO `zones` VALUES (401, 222, 'PEM', 'Pembrokeshire, Wales');
INSERT INTO `zones` VALUES (402, 222, 'PER', 'Perth, Scotland');
INSERT INTO `zones` VALUES (403, 222, 'POW', 'Powys, Wales');
INSERT INTO `zones` VALUES (404, 222, 'RAD', 'Radnorshire, Wales');
INSERT INTO `zones` VALUES (405, 222, 'RFW', 'Renfrewshire, Scotland');
INSERT INTO `zones` VALUES (406, 222, 'ROC', 'Ross and Cromarty, Scotland');
INSERT INTO `zones` VALUES (407, 222, 'ROX', 'Roxburghshire, Scotland');
INSERT INTO `zones` VALUES (408, 222, 'RUT', 'Rutland, England');
INSERT INTO `zones` VALUES (409, 222, 'SRK', 'Sark, Channel Islands');
INSERT INTO `zones` VALUES (410, 222, 'SEL', 'Selkirkshire, Scotland');
INSERT INTO `zones` VALUES (411, 222, 'SHI', 'Shetland, Scotland');
INSERT INTO `zones` VALUES (412, 222, 'SAL', 'Shropshire, England');
INSERT INTO `zones` VALUES (413, 222, 'SOM', 'Somerset, England');
INSERT INTO `zones` VALUES (414, 222, 'SGM', 'South Glamorgan, Wales');
INSERT INTO `zones` VALUES (415, 222, 'SYK', 'South Yorkshire, England');
INSERT INTO `zones` VALUES (416, 222, 'STS', 'Staffordshire, England');
INSERT INTO `zones` VALUES (417, 222, 'STI', 'Stirlingshire, Scotland');
INSERT INTO `zones` VALUES (418, 222, 'STD', 'Strathclyde, Scotland');
INSERT INTO `zones` VALUES (419, 222, 'SFK', 'Suffolk, England');
INSERT INTO `zones` VALUES (420, 222, 'SRY', 'Surrey, England');
INSERT INTO `zones` VALUES (421, 222, 'SSX', 'Sussex, England');
INSERT INTO `zones` VALUES (422, 222, 'SUT', 'Sutherland, Scotland');
INSERT INTO `zones` VALUES (423, 222, 'TAY', 'Tayside, Scotland');
INSERT INTO `zones` VALUES (424, 222, 'TWR', 'Tyne and Wear, England');
INSERT INTO `zones` VALUES (425, 222, 'WAR', 'Warwickshire, England');
INSERT INTO `zones` VALUES (426, 222, 'WGM', 'West Glamorgan, Wales');
INSERT INTO `zones` VALUES (427, 222, 'WLN', 'West Lothian, Scotland');
INSERT INTO `zones` VALUES (428, 222, 'WMD', 'West Midlands, England');
INSERT INTO `zones` VALUES (429, 222, 'WRY', 'West Riding of Yorkshire, Englan');
INSERT INTO `zones` VALUES (430, 222, 'SXW', 'West Sussex, England');
INSERT INTO `zones` VALUES (431, 222, 'WYK', 'West Yorkshire, England');
INSERT INTO `zones` VALUES (432, 222, 'WIS', 'Western Isles, Scotland');
INSERT INTO `zones` VALUES (433, 222, 'WES', 'Westmorland, England');
INSERT INTO `zones` VALUES (434, 222, 'WIG', 'Wigtownshire, Scotland');
INSERT INTO `zones` VALUES (435, 222, 'WIL', 'Wiltshire, England');
INSERT INTO `zones` VALUES (436, 222, 'WOR', 'Worcestershire, England');
INSERT INTO `zones` VALUES (437, 222, 'YKS', 'Yorkshire, England');

-- --------------------------------------------------------

--
-- Table structure for table `zones_to_geo_zones`
--

CREATE TABLE `zones_to_geo_zones` (
  `association_id` int(11) NOT NULL auto_increment,
  `zone_country_id` int(11) NOT NULL,
  `zone_id` int(11) default NULL,
  `geo_zone_id` int(11) default NULL,
  `last_modified` datetime default NULL,
  `date_added` datetime NOT NULL,
  PRIMARY KEY  (`association_id`),
  KEY `idx_zones_to_geo_zones_country_id` (`zone_country_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=53 ;

--
-- Dumping data for table `zones_to_geo_zones`
--

INSERT INTO `zones_to_geo_zones` VALUES (32, 117, 0, 1, NULL, '2010-04-26 09:31:37');
INSERT INTO `zones_to_geo_zones` VALUES (31, 105, 0, 1, NULL, '2010-04-26 09:31:37');
INSERT INTO `zones_to_geo_zones` VALUES (30, 103, 0, 1, NULL, '2010-04-26 09:31:37');
INSERT INTO `zones_to_geo_zones` VALUES (29, 98, 0, 1, NULL, '2010-04-26 09:31:37');
INSERT INTO `zones_to_geo_zones` VALUES (28, 97, 0, 1, NULL, '2010-04-26 09:31:37');
INSERT INTO `zones_to_geo_zones` VALUES (27, 84, 0, 1, NULL, '2010-04-26 09:31:37');
INSERT INTO `zones_to_geo_zones` VALUES (25, 81, 0, 1, NULL, '2010-04-26 09:31:37');
INSERT INTO `zones_to_geo_zones` VALUES (24, 73, 0, 1, NULL, '2010-04-26 09:31:37');
INSERT INTO `zones_to_geo_zones` VALUES (23, 72, 0, 1, NULL, '2010-04-26 09:31:37');
INSERT INTO `zones_to_geo_zones` VALUES (22, 67, 0, 1, NULL, '2010-04-26 09:31:37');
INSERT INTO `zones_to_geo_zones` VALUES (21, 57, 0, 1, NULL, '2010-04-26 09:31:37');
INSERT INTO `zones_to_geo_zones` VALUES (20, 56, 0, 1, NULL, '2010-04-26 09:31:37');
INSERT INTO `zones_to_geo_zones` VALUES (19, 55, 0, 1, NULL, '2010-04-26 09:31:37');
INSERT INTO `zones_to_geo_zones` VALUES (18, 21, 0, 1, NULL, '2010-04-26 09:31:37');
INSERT INTO `zones_to_geo_zones` VALUES (17, 14, 0, 1, NULL, '2010-04-26 09:31:37');
INSERT INTO `zones_to_geo_zones` VALUES (33, 123, 0, 1, NULL, '2010-04-26 09:31:37');
INSERT INTO `zones_to_geo_zones` VALUES (34, 124, 0, 1, NULL, '2010-04-26 09:31:37');
INSERT INTO `zones_to_geo_zones` VALUES (35, 132, 0, 1, NULL, '2010-04-26 09:31:37');
INSERT INTO `zones_to_geo_zones` VALUES (36, 150, 0, 1, NULL, '2010-04-26 09:31:37');
INSERT INTO `zones_to_geo_zones` VALUES (37, 160, 0, 1, NULL, '2010-04-26 09:31:37');
INSERT INTO `zones_to_geo_zones` VALUES (38, 170, 0, 1, NULL, '2010-04-26 09:31:37');
INSERT INTO `zones_to_geo_zones` VALUES (46, 171, 0, 1, NULL, '2010-04-26 09:31:37');
INSERT INTO `zones_to_geo_zones` VALUES (47, 189, 0, 1, NULL, '2010-04-26 09:31:37');
INSERT INTO `zones_to_geo_zones` VALUES (48, 190, 0, 1, NULL, '2010-04-26 09:31:37');
INSERT INTO `zones_to_geo_zones` VALUES (49, 195, 0, 1, NULL, '2010-04-26 09:31:37');
INSERT INTO `zones_to_geo_zones` VALUES (50, 203, 0, 1, NULL, '2010-04-26 09:31:37');
INSERT INTO `zones_to_geo_zones` VALUES (51, 204, 0, 1, NULL, '2010-04-26 09:31:37');
INSERT INTO `zones_to_geo_zones` VALUES (52, 222, 0, 1, NULL, '2010-04-26 09:31:37');
