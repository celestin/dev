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
 * CAM  28-Apr-2010  10639 : Added Product Extra Fields (http://www.oscommerce.com/community/contributions,2202)
 * CAM  29-May-2010  10669 : Removed Reviews
 * CAM  29-May-2010  10670 : Call table_header.
 * CAM  10-Jun-2010  10706 : Moved Model No down to attributes.
 * CAM  12-Jun-2010  10709 : Added Associated Products.
 * CAM  17-Jun-2010  10747 : Added Manufacturer's Guarantee.
 * CAM  29-Jul-2010  10763 : Show "Our Price" below RRP.
 * CAM  29-Jul-2010  10763 : Moved Guarantee up so RRP and Our Price are together.
 * CAM  07-Aug-2010  10767 : Added social networking links and left join to manufacturer.
 * CAM  22-Oct-2010  10791 : Added Google Analytics.
 * CAM  27-Dec-2010  10906 : Display Our Price (and Special Price) correctly when there is a Special Price.
 * CAM  10-Mar-2011  10945 : Added MagicMagnifyZoom.
 * * * * * * * * * * * * * * * * * * * * * * * */

  require('includes/application_top.php');

  require(DIR_WS_LANGUAGES . $language . '/' . FILENAME_PRODUCT_INFO);

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

<link type="text/css" rel="stylesheet" href="includes/magicmagnifyplus/magicmagnifyplus.css"/>
<script type="text/javascript" src="includes/magicmagnifyplus/magicmagnifyplus.js"></script>

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
      "m.manufacturers_name, m.guarantee_years, (SELECT MAX(c.box_image) FROM categories c, products_to_categories pc ".
                                                "WHERE pc.categories_id = c.categories_id ".
                                                "AND pc.products_id = p.products_id) box_image ".
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
      $products_price = $currencies->display_price($new_price, tep_get_tax_rate($product_info['products_tax_class_id']));
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
  <table border="0" cellpadding="0" cellspacing="0">
    <tr>
      <td>
<?
    $largeFile = DIR_WS_IMAGES . "large/" . $product_info['products_image'];
    if (file_exists($largeFile)) {
      echo "<a href=\"" . $largeFile . "\" class=\"MagicMagnifyPlus\">";
    }

    echo tep_image(DIR_WS_IMAGES . $product_info['products_image'], $product_info['products_name'], $width = '', $height = '') ;

    if (file_exists($largeFile)) {
      echo "</a>";
    }
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

       <div id="productOptions">
<? if (!empty($product_info['box_image'])) { ?>
       <img style="float:right;" src="<?=DIR_WS_IMAGES . "box/" . $product_info['box_image']?>" alt="boxes">
<? } ?>
       <table border="0" cellspacing="2" cellpadding="2">
<?php
    if (tep_not_null($product_info['products_model'])) {
      $modelNo = $product_info['products_model'];
?>
          <tr>
            <td class="productOptionLabel">Model No</td>
            <td class="productOptionValue"><?php echo $product_info['products_model']; ?></td>
          </tr>
<?php
    }

    $products_attributes_query = tep_db_query("select count(*) as total from " . TABLE_PRODUCTS_OPTIONS . " popt, " . TABLE_PRODUCTS_ATTRIBUTES . " patrib where patrib.products_id='" . (int)$HTTP_GET_VARS['products_id'] . "' and patrib.options_id = popt.products_options_id and popt.language_id = '" . (int)$languages_id . "'");
    $products_attributes = tep_db_fetch_array($products_attributes_query);
    if ($products_attributes['total'] > 0) {

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
            <td class="productOptionLabel"><?php echo $product_info['manufacturers_name']; ?>&nbsp;Guarantee</td>
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

      // Our Price & Special Price
?>
          <tr>
            <td class="productOptionLabel">Our Price</td>
<?php
      if ($new_price == 0) {
?>
            <td class="productOptionValueOurPrice"><?php echo $products_price; ?></td>
          </tr>
<?php
      } else {
?>
            <td class="productOptionValueRRP"><?php echo $currencies->display_price($product_info['products_price'], tep_get_tax_rate($product_info['products_tax_class_id'])); ?></td>
          <tr>
            <td class="productOptionLabel">Special Price</td>
            <td class="productOptionValueOurPrice"><?php echo $currencies->display_price($new_price, tep_get_tax_rate($product_info['products_tax_class_id'])); ?></td>
          </tr>
<?php
      }
?>
          </table>
<?php
    }
?>
          <p><?php include(DIR_WS_LANGUAGES . $language . '/' . 'why_buy_from_us.php'); ?></p>
        </td>
      </tr>
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

    if ($new_price != 0) {
?>
      <tr>
        <td>This product is available at a special price &mdash; why not check out all our <a href="/specials.php">special offers</a>?</td>
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
            <td><table border="0" width="100%" cellspacing="0" cellpadding="2">
              <tr>

                <td>
                  <div id="sociallinks">
                    <table border="0" cellspacing="0" cellpadding="0">
                      <tr>
                        <td>
                          <a href="http://delicious.com/save" onclick="window.open('http://delicious.com/save?v=5&noui&jump=close&url='+encodeURIComponent(location.href)+'&title='+encodeURIComponent(document.title), 'delicious','toolbar=no,width=550,height=550'); return false;"><img
                            border="0" src="http://static.delicious.com/img/delicious.small.gif" height="12" width="12" alt="Delicious" /></a>
                          <a href="http://delicious.com/save" onclick="window.open('http://delicious.com/save?v=5&noui&jump=close&url='+encodeURIComponent(location.href)+'&title='+encodeURIComponent(document.title), 'delicious','toolbar=no,width=550,height=550'); return false;">Bookmark <?php echo $modelNo; ?></a>
                        </td>

                        <td>
                          <a name="fb_share" type="button_count" href="http://www.facebook.com/sharer.php">Share</a><script src="http://static.ak.fbcdn.net/connect.php/js/FB.Share" type="text/javascript"></script>
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
