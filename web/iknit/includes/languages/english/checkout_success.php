<?php
/* * * * * * * * * * * * * * * * * * * * * * * *
 * iKnit (iknit.biz)
 *
 * osCommerce, Open Source E-Commerce Solutions
 * http://www.oscommerce.com
 * Copyright (c) 2007 osCommerce
 * Released under the GNU General Public License
 *
 * Customised by Front Burner
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  29-May-2010  10670 : Call table_header.
 * CAM  01-Jun-2010  10727 : Changed delivery timescales and reference to 'notify me'.
 * * * * * * * * * * * * * * * * * * * * * * * */

define('NAVBAR_TITLE_1', 'Checkout');
define('NAVBAR_TITLE_2', 'Success');

define('HEADING_TITLE', 'Your Order Has Been Processed!');

define('TEXT_SUCCESS', 'Your order has been successfully processed! Your products will arrive within 3-4 working days.');
define('TEXT_NOTIFY_PRODUCTS', 'You have ordered the following items:');
define('TEXT_SEE_ORDERS', 'You can view your order history by going to the <a href="' . tep_href_link(FILENAME_ACCOUNT, '', 'SSL') . '">\'My Account\'</a> page and by clicking on <a href="' . tep_href_link(FILENAME_ACCOUNT_HISTORY, '', 'SSL') . '">\'History\'</a>.');
define('TEXT_CONTACT_STORE_OWNER', 'Please direct any questions you have to the <a href="' . tep_href_link(FILENAME_CONTACT_US) . '">store owner</a>.');
define('TEXT_THANKS_FOR_SHOPPING', 'Thanks for shopping with us online!');

define('TABLE_HEADING_COMMENTS', 'Enter a comment for the order processed');

define('TABLE_HEADING_DOWNLOAD_DATE', 'Expiry date: ');
define('TABLE_HEADING_DOWNLOAD_COUNT', ' downloads remaining');
define('HEADING_DOWNLOAD', 'Download your products here:');
define('FOOTER_DOWNLOAD', 'You can also download your products at a later time at \'%s\'');
?>