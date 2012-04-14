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
 * CAM  30-Oct-2010  10800 : Changed to 'Product Code'.
 * CAM  30-Oct-2010  10805 : Added Google Analytics.
 * CAM  09-Dec-2010  10830 : Added Related Products.
 * CAM  10-Jan-2011  10930 : Ensured that Shades with no Patterns show no Patterns.
 * CAM  28-Jul-2011  11000 : Remove duplicate Leaflet/Shades by grouping.
 * CAM  28-Jul-2011  11006 : Produce=>Product.
 * CAM  14-Apr-2012  11106 : Added Facebook Like to Product page.
 * * * * * * * * * * * * * * * * * * * * * * * */

  require('includes/application_top.php');

  require(DIR_WS_LANGUAGES . $language . '/' . FILENAME_PRODUCT_INFO);

  function add_related_products($sql, $description) {

    $rel_prod_query = tep_db_query($sql);
    $rows = 0;

    if (tep_db_num_rows($rel_prod_query) > 0) {
?>
      <tr><td><div id="relatedProducts"><h3><? echo $description; ?></h3><ul>
<?
      while ($rel_prod = tep_db_fetch_array($rel_prod_query)) {
?>
        <li><a href="<? echo tep_href_link(FILENAME_PRODUCT_INFO, 'products_id=' . $rel_prod['products_id']); ?>"><? echo
          tep_image(DIR_WS_IMAGES . $rel_prod['products_image'], $rel_prod['products_name'], $width = '', $height = '130') ?></a></li>
<?
      }
?>
      </ul></div></td></tr>
<?
    }
  }

  $product_check_query = tep_db_query("select count(*) as total from " . TABLE_PRODUCTS . " p, " . TABLE_PRODUCTS_DESCRIPTION . " pd where p.products_status = '1' and p.products_id = '" . (int)$HTTP_GET_VARS['products_id'] . "' and pd.products_id = p.products_id and pd.language_id = '" . (int)$languages_id . "'");
  $product_check = tep_db_fetch_array($product_check_query);
?>
<!doctype html public "-//W3C//DTD HTML 4.01 Transitional//EN">
<html <?php echo HTML_PARAMS; ?>>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=<?php echo CHARSET; ?>">
<title><?php echo TITLE; ?></title>
<base href="<?php echo (($request_type == 'SSL') ? HTTPS_SERVER : HTTP_SERVER) . DIR_WS_CATALOG; ?>">
<link rel="stylesheet" type="text/css" href="<?php echo CONFIG_STYLESHEET; ?>">
<link rel="shortcut icon" href="<?php echo CONFIG_FAVICON; ?>" type="image/vnd.microsoft.icon" />
<link rel="icon" href="<?php echo CONFIG_FAVICON; ?>" type="image/vnd.microsoft.icon" />
<script language="javascript"><!--
function popupWindow(url) {
  window.open(url,'popupWindow','toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=no,resizable=yes,copyhistory=no,width=100,height=100,screenX=150,screenY=150,top=150,left=150')
}
//--></script>
<?php include(FILENAME_ANALYTICS); ?>
</head>
<body marginwidth="0" marginheight="0" topmargin="0" bottommargin="0" leftmargin="0" rightmargin="0">
<div id="productInfo">
<!-- header //-->
<?php require(DIR_WS_INCLUDES . 'header.php'); ?>
<!-- header_eof //-->

<!-- body //-->
<?php require(DIR_WS_INCLUDES . 'table_header.php'); ?>
  <tr>
    <td width="<?php echo BOX_WIDTH; ?>" valign="top"><table border="0" width="<?php echo BOX_WIDTH; ?>" cellspacing="0" cellpadding="2">
<!-- left_navigation //-->
<?php require(DIR_WS_INCLUDES . 'column_left.php'); ?>
<!-- left_navigation_eof //-->
    </table></td>
<!-- body_text //-->
    <td width="100%" valign="top"><?php echo tep_draw_form('cart_quantity', tep_href_link(FILENAME_PRODUCT_INFO, tep_get_all_get_params(array('action')) . 'action=add_product')); ?><table border="0" width="100%" cellspacing="0" cellpadding="0">
<?php
  if ($product_check['total'] < 1) {
?>
      <tr>
        <td><?php new infoBox(array(array('text' => TEXT_PRODUCT_NOT_FOUND))); ?></td>
      </tr>
      <tr>
        <td><?php echo tep_draw_separator('pixel_trans.gif', '100%', '10'); ?></td>
      </tr>
      <tr>
        <td><table border="0" width="100%" cellspacing="1" cellpadding="2" class="infoBox">
          <tr class="infoBoxContents">
            <td><table border="0" width="100%" cellspacing="0" cellpadding="2">
              <tr>
                <td width="10"><?php echo tep_draw_separator('pixel_trans.gif', '10', '1'); ?></td>
                <td align="right"><?php echo '<a href="' . tep_href_link(FILENAME_DEFAULT) . '">' . tep_image_button('button_continue.gif', IMAGE_BUTTON_CONTINUE) . '</a>'; ?></td>
                <td width="10"><?php echo tep_draw_separator('pixel_trans.gif', '10', '1'); ?></td>
              </tr>
            </table></td>
          </tr>
        </table></td>
      </tr>
<?php
  } else {
    $sql =
      "SELECT p.products_id, p.groupid, pd.products_name, pd.products_description, p.products_model, ".
      "p.products_quantity, p.products_image, pd.products_url, p.products_price, p.products_tax_class_id, ".
      "p.products_date_added, p.products_date_available, p.manufacturers_id, ".
      "m.manufacturers_name, m.guarantee_years ".
      "FROM " . TABLE_PRODUCTS . " p " .
      "INNER JOIN " . TABLE_PRODUCTS_DESCRIPTION . " pd " .
      "ON pd.products_id = p.products_id ".
      "LEFT JOIN ". TABLE_MANUFACTURERS . " m ".
      "ON m.manufacturers_id = p.manufacturers_id ".
      "WHERE p.products_status = '1' ".
      "AND p.products_id = '" . (int)$HTTP_GET_VARS['products_id'] . "' ".
      "AND pd.language_id = '" . (int)$languages_id . "'";

    $product_info_query = tep_db_query($sql);
    $product_info = tep_db_fetch_array($product_info_query);
    $modelNo = $product_info['products_id'];

    tep_db_query("update " . TABLE_PRODUCTS_DESCRIPTION . " set products_viewed = products_viewed+1 where products_id = '" . (int)$HTTP_GET_VARS['products_id'] . "' and language_id = '" . (int)$languages_id . "'");

    if ($new_price = tep_get_products_special_price($product_info['products_id'])) {
      $products_price = '<s>' . $currencies->display_price($product_info['products_price'], tep_get_tax_rate($product_info['products_tax_class_id'])) . '</s> <span class="productSpecialPrice">' . $currencies->display_price($new_price, tep_get_tax_rate($product_info['products_tax_class_id'])) . '</span>';
    } else {
      $products_price = $currencies->display_price($product_info['products_price'], tep_get_tax_rate($product_info['products_tax_class_id']));
    }

    $products_name = $product_info['products_name'];
?>
      <tr>
        <td><table border="0" width="100%" cellspacing="0" cellpadding="0">
          <tr>
            <td id="productName" valign="top"><?php echo $products_name; ?></td>
            <td id="productPrice" align="right" valign="top"><?php echo $products_price; ?></td>
          </tr>
        </table></td>
      </tr>
      <tr>
        <td><?php echo tep_draw_separator('pixel_trans.gif', '100%', '10'); ?></td>
      </tr>
      <tr>
        <td>
<?php
    if (tep_not_null($product_info['products_image'])) {
?>
<div id="productImage">
  <table border=0 cellpadding="0" cellspacing="0">
    <tr>
      <td>
<?
      echo tep_image(DIR_WS_IMAGES . $product_info['products_image'], $product_info['products_name'], $width = '', $height = '') ;
?>
      </td>
    </tr>
<?
    if ($product_info['groupid'] > 0) {

      $sql =
        "SELECT p.products_id,pd.products_name,p.products_model,p.products_image,p.dataload_gender ".
        "FROM products p, products_description pd ".
        "WHERE pd.products_id = p.products_id ".
        "AND pd.language_id = '" . (int)$languages_id . "' ".
        "AND p.groupid='".$product_info['groupid']."' ".
        "AND p.groupid IS NOT NULL  ".
        "AND p.products_id <> '".$product_info['products_id']."' ".
        "ORDER BY p.products_model ";

      $groupproducts_query = tep_db_query($sql);
      $number_of_groupproducts = tep_db_num_rows($groupproducts_query);

      if ($number_of_groupproducts > 0) {
?>
    <tr>
      <td align=right><table border="0" cellpadding="0" cellspacing="0">
        <tr><td align="center" colspan="<? echo $number_of_groupproducts; ?>"><h1><? echo TEXT_ASSOCIATED_PRODUCTS; ?></h1></td></tr>
        <tr>
<?
      }

      while ($groupproducts = tep_db_fetch_array($groupproducts_query)) {
?>
          <td valign="top" align="center"><h2><? echo $groupproducts['dataload_gender'] . " " . $groupproducts['products_model']; ?></h2><a
            href="<? echo tep_href_link(FILENAME_PRODUCT_INFO, 'products_id=' . $groupproducts['products_id']); ?>"><?
            echo tep_image(DIR_WS_IMAGES . $groupproducts["products_image"], $groupproducts['products_name'], $width = '', $height = '80') ;?></a></td>
<?
      }

      if ($number_of_groupproducts > 0) {
?>
        </tr>
      </table></td>
    </tr>
<?
      }
    }
?>
  </table>
</div>
<?
    }
?>
       <div id="productDesc"><p><?php echo stripslashes($product_info['products_description']); ?></p></div>

       <table border="0" cellspacing="2" cellpadding="2">
<?php
    if (tep_not_null($product_info['products_model'])) {
      $modelNo = $product_info['products_model'];
?>
          <tr>
            <td class="productOptionLabel">Product Code</td>
            <td class="productOptionValue"><?php echo $product_info['products_model']; ?></td>
          </tr>
<?php
    }

    $products_attributes_query = tep_db_query("select count(*) as total from " . TABLE_PRODUCTS_OPTIONS . " popt, " . TABLE_PRODUCTS_ATTRIBUTES . " patrib where patrib.products_id='" . (int)$HTTP_GET_VARS['products_id'] . "' and patrib.options_id = popt.products_options_id and popt.language_id = '" . (int)$languages_id . "'");
    $products_attributes = tep_db_fetch_array($products_attributes_query);
    if ($products_attributes['total'] >= 0) {

      $once = true;
      $products_options_name_query = tep_db_query("select distinct popt.products_options_is_static, popt.products_options_is_visible,popt.products_options_id, popt.products_options_name from " . TABLE_PRODUCTS_OPTIONS . " popt, " . TABLE_PRODUCTS_ATTRIBUTES . " patrib where patrib.products_id='" . (int)$HTTP_GET_VARS['products_id'] . "' and patrib.options_id = popt.products_options_id and popt.language_id = '" . (int)$languages_id . "' order by popt.products_options_name");
      while ($products_options_name = tep_db_fetch_array($products_options_name_query)) {

        $products_options_array = array();
        $products_options_query = tep_db_query("select pov.products_options_values_id, pov.products_options_values_name, pa.options_values_price, pa.price_prefix from " . TABLE_PRODUCTS_ATTRIBUTES . " pa, " . TABLE_PRODUCTS_OPTIONS_VALUES . " pov where pa.products_id = '" . (int)$HTTP_GET_VARS['products_id'] . "' and pa.options_id = '" . (int)$products_options_name['products_options_id'] . "' and pa.options_values_id = pov.products_options_values_id and pov.language_id = '" . (int)$languages_id . "'");
        while ($products_options = tep_db_fetch_array($products_options_query)) {
          $static_attribute = false;

          if($products_options_name['products_options_is_static'] == '0'){
            $products_options_array[] = array('id' => $products_options['products_options_values_id'], 'text' => $products_options['products_options_values_name']);
            if ($products_options['options_values_price'] != '0') {
              $products_options_array[sizeof($products_options_array)-1]['text'] .= ' (' . $products_options['price_prefix'] . $currencies->display_price($products_options['options_values_price'], tep_get_tax_rate($product_info['products_tax_class_id'])) .') ';
            }
          }
          else{
            $static_attribute = true;
            if($products_options_name['products_options_is_visible'] == '1')
              // Save up all of our static attributes to print after the non-static options
              $static_attribute_strings[] = $products_options_name['products_options_name'];
              $static_attribute_strings[] = $products_options['products_options_values_name'];
          }
        }

        if (isset($cart->contents[$HTTP_GET_VARS['products_id']]['attributes'][$products_options_name['products_options_id']])) {
          $selected_attribute = $cart->contents[$HTTP_GET_VARS['products_id']]['attributes'][$products_options_name['products_options_id']];
        } else {
          $selected_attribute = false;
        }
?>
<?php if(!$static_attribute){
?>
          <tr>
            <td class="productOptionLabel"><?php echo $products_options_name['products_options_name']; ?></td>
            <td class="productOptionValue"><?php echo tep_draw_pull_down_menu('id[' . $products_options_name['products_options_id'] . ']', $products_options_array, $selected_attribute); ?></td>
          </tr>
<?php
       }
     }

     // Done with the non-static options.  Print out our static options
     for ($i = 0; $i < count($static_attribute_strings); $i+=2){
?>
          <tr>
            <td class="productOptionLabel"><?php echo $static_attribute_strings[$i]; ?></td>
            <td class="productOptionValue"><?php echo $static_attribute_strings[$i+1]; ?></td>
          </tr>
<?php }

      if ($product_info['guarantee_years'] > 0) {
?>
          <tr>
            <td class="productOptionLabel"><?php echo $product_info['manufacturers_name']; ?><br />Guarantee</td>
            <td class="productOptionValue"><?php echo $product_info['guarantee_years']; ?> years</td>
          </tr>
<?php
      }

      // BOF Product Extra Fields [#10639]

      $extra_fields_query = tep_db_query(
        "SELECT pef.products_extra_fields_order, pef.products_extra_fields_status as status, pef.products_extra_fields_name as name, ".
        "pef.currencies_id pef_currencies_id, ptf.products_extra_fields_value as value ".
        "FROM ". TABLE_PRODUCTS_EXTRA_FIELDS ." pef ".
        "LEFT JOIN ". TABLE_PRODUCTS_TO_PRODUCTS_EXTRA_FIELDS ." ptf ".
        "ON ptf.products_extra_fields_id=pef.products_extra_fields_id ".
        "WHERE ptf.products_id=". (int)$HTTP_GET_VARS['products_id'] . " ".
        "AND ptf.products_extra_fields_value<>'' AND (pef.languages_id='0' or pef.languages_id='".(int)$languages_id."') ".
        "ORDER BY pef.products_extra_fields_order");

      while ($extra_fields = tep_db_fetch_array($extra_fields_query)) {
         if (! $extra_fields['status'])  // show only enabled extra field
          continue;
         echo'<tr><td class="productOptionLabel">'.$extra_fields['name'].'</td>';

         if ($extra_fields['name'] == "RRP") {
          echo '<td class="productOptionValueRRP">';
         } else {
          echo '<td class="productOptionValue">';
         }

         if (!empty($extra_fields['pef_currencies_id'])) {
           echo $currencies->display_price((float)$extra_fields['value'], 0);
         } else {
           echo stripslashes($extra_fields['value']);
         }

         echo '</td></tr>';
      }
      // EOF Product Extra Fields [#10639]

      // Our price
?>
          <tr>
            <td class="productOptionLabel">Our Price</td>
            <td class="productOptionValueOurPrice"><?php echo $products_price; ?></td>
          </tr>

          </table>
<?php
    }
?>
        </td>
      </tr>

<?php

  $sql =
    "SELECT pl.products_id, MIN(pdl.products_name) products_name, MIN(pl.products_image) products_image " .
    "FROM sirdar_yarn_leaflet_shade sls, products ps, products_description pds, products pl, products_description pdl " .
    "WHERE ps.products_model = sls.shade_code " .
    "AND pl.products_model = sls.leaflet_code " .
    "AND pds.products_id = ps.products_id " .
    "AND pdl.products_id = pl.products_id " .
    "AND LENGTH(ps.products_model)>0 " .
    "AND ps.products_id=". (int)$HTTP_GET_VARS['products_id'] . " " .
    "GROUP BY pl.products_id";
  add_related_products($sql, "Leaflets where this Shade is explicitly mentioned");


  $sql =
    "SELECT pl.products_id, MIN(pdl.products_name) products_name, MIN(pl.products_image) products_image " .
    "FROM products pl, products_description pdl " .
    "WHERE pdl.products_id = pl.products_id " .
    "AND NOT EXISTS (SELECT 1 FROM sirdar_yarn_leaflet_shade sls, products ps " .
                    "WHERE ps.products_model = sls.shade_code " .
                    "AND pl.products_model = sls.leaflet_code " .
                    "AND ps.products_id=". (int)$HTTP_GET_VARS['products_id']. ") " .
    "AND EXISTS (SELECT 1  " .
                "FROM sirdar_yarn_leaflet_shade sls, products ps, sirdar_yarn_shade ss1, sirdar_yarn sy, sirdar_yarn_shade ss2 " .
                "WHERE ss1.yarn_code = sy.yarn_code " .
                "AND ss2.shade_code = sls.shade_code " .
                "AND ss2.yarn_code = sy.yarn_code " .
                "AND ps.products_model = ss1.shade_code " .
                "AND pl.products_model = sls.leaflet_code " .
                "AND ps.products_id=". (int)$HTTP_GET_VARS['products_id']. ") " .
    "GROUP BY pl.products_id";
  add_related_products($sql, "Leaflets for the all the Shades of this Yarn");


  $sql =
    "SELECT ps.products_id, MIN(pds.products_name) products_name, MIN(ps.products_image) products_image " .
    "FROM products ps, products_description pds " .
    "WHERE pds.products_id = ps.products_id " .
    "AND EXISTS (SELECT 1 FROM sirdar_yarn_leaflet_shade sls, products pl, sirdar_yarn_shade ss1, sirdar_yarn_shade ss2 " .
        "WHERE pl.products_model = sls.leaflet_code " .
        "AND ss1.shade_code = sls.shade_code " .
        "AND ss2.yarn_code = ss1.yarn_code " .
        "AND ps.products_model = ss2.shade_code " .
        "AND pl.products_id=". (int)$HTTP_GET_VARS['products_id']. ") " .
    "GROUP BY ps.products_id " .
    "ORDER BY 2";
  add_related_products($sql, "Shades that may suit this Leaflet");

?>

      <tr>
        <td><?php echo tep_draw_separator('pixel_trans.gif', '100%', '10'); ?></td>
      </tr>
<?php
    $reviews_query = tep_db_query("select count(*) as count from " . TABLE_REVIEWS . " where products_id = '" . (int)$HTTP_GET_VARS['products_id'] . "'");
    $reviews = tep_db_fetch_array($reviews_query);
    if ($reviews['count'] > 0) {
?>
      <tr>
        <td class="main"><?php echo TEXT_CURRENT_REVIEWS . ' ' . $reviews['count']; ?></td>
      </tr>
      <tr>
        <td><?php echo tep_draw_separator('pixel_trans.gif', '100%', '10'); ?></td>
      </tr>
<?php
    }

    if (tep_not_null($product_info['products_url'])) {
?>
      <tr>
        <td class="main"><?php echo sprintf(TEXT_MORE_INFORMATION, tep_href_link(FILENAME_REDIRECT, 'action=url&goto=' . urlencode($product_info['products_url']), 'NONSSL', true, false)); ?></td>
      </tr>
      <tr>
        <td><?php echo tep_draw_separator('pixel_trans.gif', '100%', '10'); ?></td>
      </tr>
<?php
    }

    if ($product_info['products_date_available'] > date('Y-m-d H:i:s')) {
?>
      <tr>
        <td align="center" class="smallText"><?php echo sprintf(TEXT_DATE_AVAILABLE, tep_date_long($product_info['products_date_available'])); ?></td>
      </tr>
<?php
    } else {
?>
<!--
      <tr>
        <td align="center" class="smallText"><?php echo sprintf(TEXT_DATE_ADDED, tep_date_long($product_info['products_date_added'])); ?></td>
      </tr>
-->
<?php
    }
?>
      <tr>
        <td><?php echo tep_draw_separator('pixel_trans.gif', '100%', '10'); ?></td>
      </tr>
      <tr>
        <td><table border="0" width="100%" cellspacing="1" cellpadding="2" class="infoBox">
          <tr class="infoBoxContents">
            <td><table border="1" width="100%" cellspacing="0" cellpadding="2">
              <tr>

                <td>
                  <div id="sociallinks">
                    <table border="0" cellspacing="0" cellpadding="0">
                      <tr>
                        <td>
						  <div class="fb-like" data-href="<?=tep_href_link(FILENAME_PRODUCT_INFO, 'products_id=' . $HTTP_GET_VARS['products_id'], 'NONSSL', false)?>" data-send="true" data-width="460" data-show-faces="false"></div>
                        </td>
                      </tr>
                    </table>
                  </div>
                </td>

                <!--<td class="main"><?php echo '<a href="' . tep_href_link(FILENAME_PRODUCT_REVIEWS, tep_get_all_get_params()) . '">' . tep_image_button('button_reviews.gif', IMAGE_BUTTON_REVIEWS) . '</a>'; ?></td>-->
                <td width="50%" class="main" align="right"><?php echo tep_draw_hidden_field('products_id', $product_info['products_id']) . tep_image_submit('button_in_cart.gif', IMAGE_BUTTON_IN_CART); ?></td>
              </tr>
            </table></td>
          </tr>
        </table></td>
      </tr>
      <tr>
        <td><?php echo tep_draw_separator('pixel_trans.gif', '100%', '10'); ?></td>
      </tr>
      <tr>
        <td>
<?php
    if ((USE_CACHE == 'true') && empty($SID)) {
      echo tep_cache_also_purchased(3600);
    } else {
      include(DIR_WS_MODULES . FILENAME_ALSO_PURCHASED_PRODUCTS);
    }
  }
?>
        </td>
      </tr>
    </table></form></td>
<!-- body_text_eof //-->
    <td width="<?php echo BOX_WIDTH; ?>" valign="top"><table border="0" width="<?php echo BOX_WIDTH; ?>" cellspacing="0" cellpadding="2">
<!-- right_navigation //-->
<?php require(DIR_WS_INCLUDES . 'column_right.php'); ?>
<!-- right_navigation_eof //-->
    </table></td>
  </tr>
</table>
<!-- body_eof //-->

<!-- footer //-->
<?php require(DIR_WS_INCLUDES . 'footer.php'); ?>
<!-- footer_eof //-->
<br>
</div>
</body>
</html>
<?php require(DIR_WS_INCLUDES . 'application_bottom.php'); ?>
