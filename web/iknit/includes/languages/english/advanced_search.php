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
 * CAM  29-May-2010  10647 : Changed from Product List to Grid
 * * * * * * * * * * * * * * * * * * * * * * * */

define('NAVBAR_TITLE_1', 'Advanced Search');
define('NAVBAR_TITLE_2', 'Search Results');

define('HEADING_TITLE', 'Advanced Search');
define('HEADING_TITLE_1', 'Advanced Search');
define('HEADING_TITLE_2', 'Products meeting the search criteria');

define('HEADING_SEARCH_CRITERIA', 'Search Criteria');

define('TEXT_SEARCH_IN_DESCRIPTION', 'Search In Product Descriptions');
define('ENTRY_CATEGORIES', 'Categories:');
define('ENTRY_INCLUDE_SUBCATEGORIES', 'Include Subcategories');
define('ENTRY_MANUFACTURERS', 'Manufacturers:');
define('ENTRY_PRICE_FROM', 'Price From:');
define('ENTRY_PRICE_TO', 'Price To:');
define('ENTRY_DATE_FROM', 'Date From:');
define('ENTRY_DATE_TO', 'Date To:');

define('TEXT_SEARCH_HELP_LINK', '<u>Search Help</u> [?]');

define('TEXT_ALL_CATEGORIES', 'All Categories');
define('TEXT_ALL_MANUFACTURERS', 'All Manufacturers');

define('HEADING_SEARCH_HELP', 'Search Help');
define('TEXT_SEARCH_HELP', 'Keywords may be separated by AND and/or OR statements for greater control of the search results.<br><br>For example, <u>Microsoft AND mouse</u> would generate a result set that contain both words. However, for <u>mouse OR keyboard</u>, the result set returned would contain both or either words.<br><br>Exact matches can be searched for by enclosing keywords in double-quotes.<br><br>For example, <u>"notebook computer"</u> would generate a result set which match the exact string.<br><br>Brackets can be used for further control on the result set.<br><br>For example, <u>Microsoft and (keyboard or mouse or "visual basic")</u>.');
define('TEXT_CLOSE_WINDOW', '<u>Close Window</u> [x]');

define('TABLE_HEADING_IMAGE', '');
define('TABLE_HEADING_MODEL', 'Model');
define('TABLE_HEADING_PRODUCTS', 'Product Name');
define('TABLE_HEADING_MANUFACTURER', 'Manufacturer');
define('TABLE_HEADING_QUANTITY', 'Quantity');
define('TABLE_HEADING_PRICE', 'Price');
define('TABLE_HEADING_WEIGHT', 'Weight');
define('TABLE_HEADING_BUY_NOW', 'Buy Now');

define('TEXT_NO_PRODUCTS', 'There is no product that matches the search criteria.');

define('ERROR_AT_LEAST_ONE_INPUT', 'At least one of the fields in the search form must be entered.');
define('ERROR_INVALID_FROM_DATE', 'Invalid From Date.');
define('ERROR_INVALID_TO_DATE', 'Invalid To Date.');
define('ERROR_TO_DATE_LESS_THAN_FROM_DATE', 'To Date must be greater than or equal to From Date.');
define('ERROR_PRICE_FROM_MUST_BE_NUM', 'Price From must be a number.');
define('ERROR_PRICE_TO_MUST_BE_NUM', 'Price To must be a number.');
define('ERROR_PRICE_TO_LESS_THAN_PRICE_FROM', 'Price To must be greater than or equal to Price From.');
define('ERROR_INVALID_KEYWORDS', 'Invalid keywords.');

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
