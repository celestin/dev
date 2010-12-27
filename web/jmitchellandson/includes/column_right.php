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
 * CAM  29-May-2010  10669 : Removed Reviews
 * CAM  27-Dec-2010  10906 : Moved Specials box to prominant left column, and WhatsNew to right.
 * * * * * * * * * * * * * * * * * * * * * * * */

  require(DIR_WS_BOXES . 'search.php');

  require(DIR_WS_BOXES . 'shopping_cart.php');

  if (isset($HTTP_GET_VARS['products_id'])) include(DIR_WS_BOXES . 'manufacturer_info.php');

  if (tep_session_is_registered('customer_id')) include(DIR_WS_BOXES . 'order_history.php');

  if (isset($HTTP_GET_VARS['products_id'])) {
    if (tep_session_is_registered('customer_id')) {
      $check_query = tep_db_query("select count(*) as count from " . TABLE_CUSTOMERS_INFO . " where customers_info_id = '" . (int)$customer_id . "' and global_product_notifications = '1'");
      $check = tep_db_fetch_array($check_query);
      if ($check['count'] > 0) {
        include(DIR_WS_BOXES . 'best_sellers.php');
      } else {
        include(DIR_WS_BOXES . 'product_notifications.php');
      }
    } else {
      //include(DIR_WS_BOXES . 'product_notifications.php');
    }
  } else {
    require(DIR_WS_BOXES . 'whats_new.php');
    include(DIR_WS_BOXES . 'best_sellers.php');
  }

  if (isset($HTTP_GET_VARS['products_id'])) {
    if (basename($PHP_SELF) != FILENAME_TELL_A_FRIEND) include(DIR_WS_BOXES . 'tell_a_friend.php');
  }

  //require(DIR_WS_BOXES . 'reviews.php');

  //if (substr(basename($PHP_SELF), 0, 8) != 'checkout') {
  //  include(DIR_WS_BOXES . 'languages.php');
  //  include(DIR_WS_BOXES . 'currencies.php');
  //}

?>
