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
 * CAM  28-Apr-2010  10639 : Added Product Extra Fields (http://www.oscommerce.com/community/contributions,2202)
 * CAM  29-May-2010  10647 : Changed from Product List to Grid
 * * * * * * * * * * * * * * * * * * * * * * * */

?>
<!-- new_products //-->
<?php
$max_age = tep_not_null( MAX_DISPLAY_PRODUCTS_NEW_AGE ) ?  MAX_DISPLAY_PRODUCTS_NEW_AGE : 60; // set max age of displayed product
$date = strtotime("-" . $max_age . " days");
$date = strftime("%Y-%m-%d",$date);

$new_mode = sprintf(TABLE_HEADING_NEW_PRODUCTS, strftime('%B'));

    $define_list = array('PRODUCT_LIST_MODEL' => PRODUCT_LIST_MODEL,
                         'PRODUCT_LIST_NAME' => PRODUCT_LIST_NAME,
                         'PRODUCT_LIST_MANUFACTURER' => PRODUCT_LIST_MANUFACTURER,
                         'PRODUCT_LIST_PRICE' => PRODUCT_LIST_PRICE,
                         'PRODUCT_LIST_QUANTITY' => PRODUCT_LIST_QUANTITY,
                         'PRODUCT_LIST_WEIGHT' => PRODUCT_LIST_WEIGHT,
                         'PRODUCT_LIST_IMAGE' => PRODUCT_LIST_IMAGE,
                         'PRODUCT_LIST_BUY_NOW' => PRODUCT_LIST_BUY_NOW);

    asort($define_list);

    $column_list = array();
    reset($define_list);
    while (list($key, $value) = each($define_list)) {
      if ($value > 0) $column_list[] = $key;
    }

    $select_column_list = '';

  for ($i=0, $n=sizeof($column_list); $i<$n; $i++) {
      switch ($column_list[$i]) {
        case 'PRODUCT_LIST_MODEL':
          $select_column_list .= 'p.products_model, ';
          break;
        case 'PRODUCT_LIST_NAME':
          $select_column_list .= 'pd.products_name, ';
          break;
        case 'PRODUCT_LIST_MANUFACTURER':
          $select_column_list .= 'm.manufacturers_name, ';
          break;
        case 'PRODUCT_LIST_QUANTITY':
          $select_column_list .= 'p.products_quantity, ';
          break;
        case 'PRODUCT_LIST_WEIGHT':
          $select_column_list .= 'p.products_weight, ';
          break;
      }
    }
  $order = ' order by p.products_date_added desc';
  // $order = ' order by rand()'; // uncomment if you want products in a random order


  if ( (!isset($new_products_category_id)) || ($new_products_category_id == '0') ) {
    $new_products_query = "select " . $select_column_list . "p.products_id, p.products_image, p.products_tax_class_id, p.products_price, p.products_quantity from " . TABLE_PRODUCTS . " p left join " . TABLE_MANUFACTURERS . " m on (p.manufacturers_id = m.manufacturers_id), " . TABLE_PRODUCTS_DESCRIPTION . " pd where p.products_status = '1' and p.products_date_added > '".$date."' and p.products_id = pd.products_id and pd.language_id = '" . (int)$languages_id . "'" . $order;
  } else {
    $new_products_query = "select distinct " . $select_column_list . "p.products_id, p.products_image, p.products_tax_class_id, p.products_price, p.products_quantity from " . TABLE_PRODUCTS . " p  left join " . TABLE_MANUFACTURERS . " m on (p.manufacturers_id = m.manufacturers_id), " . TABLE_PRODUCTS_DESCRIPTION . " pd, " . TABLE_PRODUCTS_TO_CATEGORIES . " p2c, " . TABLE_CATEGORIES . " c where p.products_id = p2c.products_id and p2c.categories_id = c.categories_id and c.parent_id = '" . (int)$new_products_category_id . "' and p.products_status = '1' and p.products_date_added > '".$date."' and p.products_id = pd.products_id and pd.language_id = '" . (int)$languages_id . "'" . $order;
  }

  $listing_sql = $new_products_query;
  include(DIR_WS_MODULES . FILENAME_PRODUCT_LISTING);
?>
<!-- new_products_eof //-->
