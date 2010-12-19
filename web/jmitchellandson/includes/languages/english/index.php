<?php
/* * * * * * * * * * * * * * * * * * * * * * * *
 * J.Mitchell & Son (jmitchellandson.co.uk)
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
 * CAM  29-May-2010  10647 : Changed from Product List to Grid
 * CAM  29-May-2010  10670 : Added TEXT_NO_PRODUCTS for nested categories.
 * * * * * * * * * * * * * * * * * * * * * * * */

define('TEXT_MAIN', '');
define('TABLE_HEADING_NEW_PRODUCTS', 'New Products For %s');
define('TABLE_HEADING_UPCOMING_PRODUCTS', 'Upcoming Products');
define('TABLE_HEADING_DATE_EXPECTED', 'Date Expected');

if ( ($category_depth == 'products') || (isset($HTTP_GET_VARS['manufacturers_id'])) ) {
  define('HEADING_TITLE', 'Products available');
  define('TABLE_HEADING_IMAGE', '');
  define('TABLE_HEADING_MODEL', 'Model');
  define('TABLE_HEADING_PRODUCTS', 'Product Name');
  define('TABLE_HEADING_MANUFACTURER', 'Manufacturer');
  define('TABLE_HEADING_QUANTITY', 'Quantity');
  define('TABLE_HEADING_PRICE', 'Price');
  define('TABLE_HEADING_WEIGHT', 'Weight');
  define('TABLE_HEADING_BUY_NOW', 'Buy Now');
  define('TEXT_NO_PRODUCTS', 'There are no products to list in this category.');
  define('TEXT_NO_PRODUCTS2', 'There is no product available from this manufacturer.');
  define('TEXT_NUMBER_OF_PRODUCTS', 'Number of Products: ');
  define('TEXT_SHOW', '<b>Show:</b>');
  define('TEXT_BUY', 'Buy 1 \'');
  define('TEXT_NOW', '\' now');
  define('TEXT_ALL_CATEGORIES', 'All Categories');
  define('TEXT_ALL_MANUFACTURERS', 'All Manufacturers');
} elseif ($category_depth == 'top') {
  define('HEADING_TITLE', 'What\'s New Here?');
} elseif ($category_depth == 'nested') {
  define('HEADING_TITLE', 'Categories');
  define('TEXT_NO_PRODUCTS', 'Click on a brand logo to view available products.');
}

define('TABLE_HEADING_DETAIL', 'Click For More');
define('TEXT_POA', '<span class="list_info">P.O.A<span>Price On Application</span></span>');
define('IMAGE_BUTTON_DETAILS', 'Product Details');
define('NUM_ORDER', ', Low to High');
define('APHA_ORDER', '');
define('REVERSE_ALPHA_ORDER', ', Reverse');
define('REVERSE_NUM_ORDER', ', High to Low');
define('DATE_ORDER', 'Date Added');
define('LIST_VIEW', 'List View');
define('THUMB_VIEW', 'Thumbnail View');
define('WEIGHT_ABRV', 'Kg');
define('MULTI_ADD_ALT','Add all quantities to the cart');
define('QUANTITY','Quantity:');
define('MORE','More');
define('LESS','Less');

?>
