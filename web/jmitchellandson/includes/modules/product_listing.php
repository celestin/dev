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
 * CAM  29-May-2010  10647 : Changed from Product List to Grid
 * CAM  08-Jun-2010  10689 : Enabled Items/Page & Sort Order (using $no_drop = false;)
 * CAM  10-Jun-2010  10688 : Resized Grid to allow image and text to fit in properly.
 * CAM  23-Oct-2010  10784 : Added RRP to results grid.
 * CAM  23-Oct-2010  10784 : Added 'RRP' and 'Our price' to results grid.
 * * * * * * * * * * * * * * * * * * * * * * * */

$graphic_bord = 'no'; //  set to 'yes' if you have older 'graphic borders' and not 'easy graphic borders'.
$cat_path = false; // set to true to include category paths in urls
$no_drop = false; // set to true to remove resuls/page & sort order drop downs
$set_width = true; // set to false to allow columns to find their own widths in list mode
$sale = false; // set to true to show sale prices if you have SaleMaker installed.
$show_ratings = false; // set to true to show the products average review rating
$checkbox =  true; // set to true to show a checkbox field in place of other quantity boxes, will only show for multi add to cart.

$max_rows = intval($specials ? MAX_DISPLAY_SPECIAL_PRODUCTS : ($new_page ? MAX_DISPLAY_PRODUCTS_NEW : ($new_mode ? MAX_DISPLAY_NEW_PRODUCTS : MAX_DISPLAY_SEARCH_RESULTS)));
if (tep_not_null($HTTP_GET_VARS['sort'])) $_GET['sort'] = $HTTP_GET_VARS['sort'];
$max_results = (tep_not_null($_GET['max']) ? $_GET['max'] : $max_rows);
if (PRODUCTS_PER_ROW == 'PRODUCTS_PER_ROW' || PRODUCTS_PER_ROW == 0 || LISTING_SWITCH == 'LISTING_SWITCH') { $to = 'Setup Error!\nPlease ensure you have run the\nInstall SQL File.' ; print "<script>alert('$to');</script>"; }

// sort order array
if ($_GET['sort'] == '0d') $sort_array[] = array('id' => 0 . 'd', 'text' => DATE_ORDER);
for ($i=0, $n=sizeof($column_list); $i<$n; $i++) {
  switch ($column_list[$i]) {
    case 'PRODUCT_LIST_MODEL':
    $sort_array[] = array('id' => $i+1 . 'a', 'text' => TABLE_HEADING_MODEL . APHA_ORDER);
    $sort_array[] = array('id' => $i+1 . 'd', 'text' => TABLE_HEADING_MODEL . REVERSE_ALPHA_ORDER);
      break;
    case 'PRODUCT_LIST_NAME':
      $sort_array[] = array('id' => $i+1 . 'a', 'text' => TABLE_HEADING_PRODUCTS . APHA_ORDER);
      //$sort_array[] = array('id' => $i+1 . 'd', 'text' => TABLE_HEADING_PRODUCTS . REVERSE_ALPHA_ORDER);
      break;
    case 'PRODUCT_LIST_MANUFACTURER':
      $sort_array[] = array('id' => $i+1 . 'a', 'text' => TABLE_HEADING_MANUFACTURER . APHA_ORDER);
      $sort_array[] = array('id' => $i+1 . 'd', 'text' => TABLE_HEADING_MANUFACTURER . REVERSE_ALPHA_ORDER);
      break;
    case 'PRODUCT_LIST_QUANTITY':
      $sort_array[] = array('id' => $i+1 . 'a', 'text' => TABLE_HEADING_QUANTITY . NUM_ORDER);
      $sort_array[] = array('id' => $i+1 . 'd', 'text' => TABLE_HEADING_QUANTITY . REVERSE_NUM_ORDER);
      break;
    case 'PRODUCT_LIST_WEIGHT':
      $sort_array[] = array('id' => $i+1 . 'a', 'text' => TABLE_HEADING_WEIGHT . NUM_ORDER);
      $sort_array[] = array('id' => $i+1 . 'd', 'text' => TABLE_HEADING_WEIGHT . REVERSE_NUM_ORDER);
      break;
    case 'PRODUCT_LIST_PRICE':
      $sort_array[] = array('id' => $i+1 . 'a', 'text' => TABLE_HEADING_PRICE . NUM_ORDER);
      $sort_array[] = array('id' => $i+1 . 'd', 'text' => TABLE_HEADING_PRICE . REVERSE_NUM_ORDER);
      break;
  }
}

// Max Results Array
for ($i=1; $i<10; $i++) {
    $max_display[] = array('id' => $max_rows * $i, 'text' => $max_rows * $i);
    }
    $max_display[] = array('id' => 1000000, 'text' => 'Show All');
// store GET vars
$get_vars = '';
    reset($_GET);
    while (list($key, $value) = each($_GET)) {
      if ( ($key != 'sort') && ($key != 'max') && ($key != tep_session_name()) && ($key != 'x') && ($key != 'y') ) {
        $get_vars .= tep_draw_hidden_field($key, $value);
      }
    }
$top_nav = ((PREV_NEXT_BAR_LOCATION == '1') || (PREV_NEXT_BAR_LOCATION == '3'));
$base_nav = ((PREV_NEXT_BAR_LOCATION == '2') || (PREV_NEXT_BAR_LOCATION == '3'));
$listing_split = new splitPageResults($listing_sql, $max_results, 'p.products_id');
$data_ok = ($listing_split->number_of_rows > 0);
$list_mode = isset($_GET['list']) ? $_GET['list'] : PRODUCT_THUMBNAIL_VIEW;
$thumbnail_view = strstr($list_mode, 'thumbnails');
$global_add = PRODUCT_LIST_MULTI_BUY;
$multi_add = ($global_add != 'false' && !$new_mode);
if ($new_mode) $no_drop = true;

  if (LISTING_SWITCH != 'false' && $data_ok && !$new_mode) $switch = '<br /><span class="smallText"><a href="' . tep_href_link(basename($PHP_SELF), tep_get_all_get_params(array('list')). 'list='.($thumbnail_view ? 'manufacturer' : 'thumbnails')) . '">' . ($thumbnail_view ? LIST_VIEW : THUMB_VIEW).'</a></span><br />';
if (LISTING_SWITCH != 'bottom') echo $switch;
$gbutton = ($data_ok ? tep_image_submit('button_multi_in_cart.gif', MULTI_ADD_ALT) : '') . '</div>';
$page_nav = '<table border="0" width="100%" cellspacing="0" cellpadding="2"><tr><td class="smallText">' .  $listing_split->display_count(TEXT_DISPLAY_NUMBER_OF_PRODUCTS) . '</td><td class="smallText" align="right">' . TEXT_RESULT_PAGE . ' ' . $listing_split->display_links(MAX_DISPLAY_PAGE_LINKS, tep_get_all_get_params(array('page', 'info', 'x', 'y'))) . '</td></tr></table>';
$drop = $no_drop ? '' : '<table border="0" width="100%" cellspacing="0" cellpadding="2" class="drop"><tr><td class="smallText">Results/Page: '. tep_draw_form('maxdisplay', tep_href_link(basename($PHP_SELF), '', $request_type, false), 'get') . $get_vars . (isset($_GET['sort']) ? tep_draw_hidden_field('sort', $_GET['sort']) : '') .  tep_draw_pull_down_menu('max', $max_display, $_GET['max'], 'onChange="this.form.submit();"') . tep_hide_session_id().'</form></td><td class="smallText" align="right">Sort Order: ' . tep_draw_form('sorting', tep_href_link(basename($PHP_SELF), '', $request_type, false), 'get') . $get_vars . (isset($_GET['max']) ? tep_draw_hidden_field('max', $_GET['max']) : '') . tep_draw_pull_down_menu('sort', $sort_array, $_GET['sort'], 'onChange="this.form.submit();"') . tep_hide_session_id().'</form></td></tr></table>';
 if ( ($listing_split->number_of_rows > (int)$max_results) && $top_nav ) echo $page_nav;
 if ($top_nav && $data_ok) echo '<div id="drop1">' . $drop . '</div>';
 if ($multi_add) { echo tep_draw_form('cart_quantity', tep_href_link(basename($PHP_SELF), tep_get_all_get_params(array('action','products_id')) . 'action=add_multi')); if ($global_add != 'bottom') echo '<div class="multi_buy_now" id="gbutton1">' . $gbutton; }
if (($show_ratings || PRODUCT_LIST_DESCRIPTION ) && $data_ok) {
    $listing_query = tep_db_query($listing_split->sql_query);
    while ($products = tep_db_fetch_array($listing_query)) $id_array[] = $products['products_id'];
    $pid_string = implode(',', array_unique($id_array));
    }
if (PRODUCT_LIST_DESCRIPTION && $data_ok) {
    $product_query = tep_db_query("select products_id, products_description from " . TABLE_PRODUCTS_DESCRIPTION . " where products_id in (" . $pid_string . ") and language_id = '" . (int)$languages_id . "'");
    while ($products = tep_db_fetch_array($product_query)) {
        $t_desc[$products['products_id']] = substr(strip_tags($products['products_description']), 0, PRODUCT_LIST_DESCRIPTION_MAX_LENGTH);
    }
}
if ($show_ratings && $data_ok) {
    $rating_query = tep_db_query("select count(*) as count, products_id, sum(reviews_rating) as total from " . TABLE_REVIEWS . " where products_id in (" . $pid_string . ") group by products_id");
    while ($rating = tep_db_fetch_array($rating_query)) {
        $review[$rating['products_id']] = ceil($rating['total'] / $rating['count']);
    }
}

function tep_get_category_name($category_id, $language_id) {
       $category_query = tep_db_query("select categories_name from " . TABLE_CATEGORIES_DESCRIPTION . " where categories_id = '" . (int)$category_id . "' and language_id = '" . (int)$language_id . "'");
     $category = tep_db_fetch_array($category_query);

      return $category['categories_name'];
     }
function tep_get_manufacturer_name($manufacturer_id) {
       $manufacturers_query = tep_db_query("select manufacturers_name from " . TABLE_MANUFACTURERS . " where manufacturers_id = '" . (int)$manufacturer_id . "'");
     $manufacturer = tep_db_fetch_array($manufacturers_query);

      return $manufacturer['manufacturers_name'];
     }

function extra_fields($products_id) {
    global $languages_id;
    $extra_fields_text = '';
    if (tep_not_null(TABLE_PRODUCTS_EXTRA_FIELDS) && LISTING_EXTRA_FIELDS == 'true') {
      $extra_fields_query = tep_db_query("SELECT pef.products_extra_fields_name as name, ptf.products_extra_fields_value as value FROM ". TABLE_PRODUCTS_EXTRA_FIELDS ." pef, ". TABLE_PRODUCTS_TO_PRODUCTS_EXTRA_FIELDS ." ptf WHERE ptf.products_extra_fields_id=pef.products_extra_fields_id and ptf.products_id=". (int) $products_id ." and (pef.languages_id = '0' or pef.languages_id = '".(int)$languages_id."') and ptf.products_extra_fields_value <> '' and pef.products_extra_fields_status ORDER BY pef.products_extra_fields_order");
      while ($extra_fields = tep_db_fetch_array($extra_fields_query)) {
      $extra_fields_text .= '<tr><td class="smallText"><span class="xtra-field-name">' . $extra_fields['name'] . ': </span><span class="xtra-field-value">' . $extra_fields['value'] . '</span></td></tr>';
      }
    }
    return $extra_fields_text;
  }

function product_description($product_id,$link,$thumb=false) {
    global $head_title, $t_desc, $review;

    return '';

    if ($review[$product_id]) $rating = '<span class="smallText"><br />' . sprintf(TEXT_AVERAGE_REVIEW, tep_image(DIR_WS_IMAGES . 'stars_' . $review[$product_id] . '.gif',sprintf(TEXT_AVERAGE_REVIEW,$review[$product_id]))) . '</span>';
    if (PRODUCT_LIST_DESCRIPTION) {
      return ($head_title || $thumb ? '' : '<br />') . '<span class="productListing-short">' . $t_desc[$product_id] . $link . '<b>...' . MORE . '</b></a></span>' . $rating;
    } else {
    return $rating;
    }
  }

function product_price($listing, $source,$last=false) {
    global $sale;
    $currencies = new currencies();
    $p_price = $listing['products_price'];
    $price = (function_exists(display_short_price)) ? $currencies->display_short_price($p_price, tep_get_tax_rate($listing['products_tax_class_id'])) : $currencies->display_price($p_price, tep_get_tax_rate($listing['products_tax_class_id']));
         if ($sale && $new_price = tep_get_products_special_price($listing['products_id'])) {
                    $price = '<s>' .  $price . '</s>' . ($last ? '<br />' : '&nbsp;&nbsp;') . '<span class="productSpecialPrice">' . $currencies->display_price($new_price, tep_get_tax_rate($listing['products_tax_class_id'])) . '</span>';
          } elseif (tep_not_null($listing['specials_new_products_price'])) {
              $price = '<s>' .  $price . '</s>' . ($last ? '<br />' : '&nbsp;&nbsp;') . '<span class="productSpecialPrice">' . $currencies->display_price($listing['specials_new_products_price'], tep_get_tax_rate($listing['products_tax_class_id'])) . '</span>';
          }
    $price = ($p_price > 0 ? '' . $price . '' : '' . TEXT_POA);
    if (function_exists(tep_get_att_price)) $price .= (tep_get_att_price($listing['products_id']) > 0 ? '+' : '');


    $rrp = "";
    $sql =
      "SELECT products_extra_fields_value ".
      "FROM products_to_products_extra_fields ".
      "WHERE products_id=". $listing['products_id'] . " ".
      "AND products_extra_fields_id=1 ";

    $product_rrp_query = tep_db_query($sql);
    if ($product_rrp = tep_db_fetch_array($product_rrp_query)) {
      if (!empty($product_rrp['products_extra_fields_value'])) {
        $rrp = 'RRP&nbsp;<span class="productListing-rrp">' . $currencies->display_price($product_rrp['products_extra_fields_value'], 0) . '</span><br />Our price&nbsp;';
      }
    }

    return $rrp . '<span class="productListing-list-price">' . $price . '</span>';
  }


function list_row ($listing, $column_list) {
      global $rows, $gborders, $list_box_contents, $cPath, $cat_path, $head_title, $man_id;
      $list_box_contents[][] = array('text' =>  '<br />');
      if (!$rows && $gborders) $list_box_contents = array();
      $rows++;
      $link = '<a href="' . tep_href_link(FILENAME_PRODUCT_INFO, 'products_id=' . $listing['products_id'] . ($man_id ? '&manufacturers_id='.$man_id : ($cPath && $cat_path ? '&cPath=' . $cPath : '')) ) . '"' . ($man_id || ($cat_path && $cat_path) ? ' rel="nofollow"' : '') . '>';
          if ($head_title) {
                if (in_array('PRODUCT_LIST_PRICE',$column_list)) $price = '<p style="float: right">' . product_price($listing, 1) . '</p>';
                $list_box_contents[][] = array('align' => 'left',
                                           'params' => 'colspan="'.sizeof($column_list).'" class="productListing-title"',
                                           'text' =>  '<div style="clear: both; width:100%;"><p style="float: left">' . $link . '<b>' . $listing['products_name'] . '</b></a></p>' . $price . '</div>');
          }
      $list_box_contents[] =  list_box_data($listing, $column_list, $link);
      $list_box_contents[][] = array('align' => 'center',
                                           'params' => 'class="separator" colspan="'.sizeof($column_list).'"',
                                           'text' =>  '<br />');
      return true;
      }
?>
<script type="text/javascript" language="javascript">
<!--
function changeValue(inObject,delta)
{  var myVal = parseInt(inObject.value);
    isNaN(myVal) ? myVal = delta : myVal = myVal + delta;
    inObject.value = Math.max(myVal,0);
    return; }

// -->
</script>
<?php
function quantity ($products_id,$p_price) {
  global $multi_add, $checkbox, $thumbnail_view, $bx;

      if (PRODUCT_LIST_QUANTITY_BOX != 'false' && strstr(LISTING_BUTTON, 'buy now')) {
          if (tep_has_product_attributes($products_id) && PRODUCT_LIST_OPTIONS != 'true' && $multi_add) return '<br />';
          $pstock = min(tep_get_products_stock($products_id),MAX_QTY_IN_CART); $qbox = ($pstock && $p_price != 0);
          if ($checkbox && $multi_add) {
                if ($qbox) { $bx++; return 'Select ' . tep_draw_checkbox_field('cart_quantity['.$bx.']',1) . tep_draw_hidden_field('products_id['.$bx.']', $products_id);
                } else { return '<br />'; }
          }
          if (PRODUCT_LIST_QUANTITY_BOX == 'true')
          return ($qbox ? '<table  cellspacing="0" cellpadding="2"><tr><td class="quantity" >' . QUANTITY . tep_draw_input_field('cart_quantity' . ($multi_add ? '[]' : '') , ($multi_add ? '0' : '1') , 'maxlength="5" size="2" id="qid'.$products_id.'"') . ($multi_add ? tep_draw_hidden_field('products_id[]', $products_id) : '') . '</td><td><a href="javascript:changeValue(document.getElementById(\'qid'.$products_id.'\'),1);">' . tep_image_button('btn_up.gif',MORE) . '</a><br><a href="javascript:changeValue(document.getElementById(\'qid'.$products_id.'\'),-1);">' . tep_image_button('btn_down.gif',LESS) . '</a></td></tr></table>' : '<br /><br />');
          else
        $qty_array = array();
        for ($i=0; $i<=$pstock; $i++) { $qty_array[]=array('id' => $i, 'text' => $i); }
        return ($qbox ? '<div class="quantity" align="' . ($thumbnail_view ? 'center' : 'right' ) .'">' . QUANTITY . tep_draw_pull_down_menu('cart_quantity'.($multi_add ? '[]' : ''),$qty_array,($multi_add ? 0 : 1)) . '<br />' . ($multi_add ? tep_draw_hidden_field('products_id[]', $products_id) : '') . '</div>' : '<br />');
          } else { return false; }
      }

function list_box_head($column_list) {
  global $set_width, $head_title;
  for ($col=0, $n=sizeof($column_list); $col<$n; $col++) {
  if ($head_title && $column_list[$col] == 'PRODUCT_LIST_PRICE') continue;
    switch ($column_list[$col]) {
      case 'PRODUCT_LIST_MODEL':
        $lc_text = TABLE_HEADING_MODEL;
        $lc_align = 'center';
        break;
      case 'PRODUCT_LIST_NAME':
        $lc_text = TABLE_HEADING_PRODUCTS;
        $lc_align = '';
        break;
      case 'PRODUCT_LIST_MANUFACTURER':
        $lc_text = TABLE_HEADING_MANUFACTURER;
        $lc_align = 'center';
        break;
      case 'PRODUCT_LIST_PRICE':
        $lc_text = TABLE_HEADING_PRICE;
        $lc_align = 'right';
        break;
      case 'PRODUCT_LIST_QUANTITY':
        $lc_text = TABLE_HEADING_QUANTITY;
        $lc_align = 'right';
        break;
      case 'PRODUCT_LIST_WEIGHT':
        $lc_text = TABLE_HEADING_WEIGHT;
        $lc_align = 'right';
        break;
      case 'PRODUCT_LIST_IMAGE':
        $lc_text = TABLE_HEADING_IMAGE;
        $lc_align = 'center';
        break;
      case 'PRODUCT_LIST_BUY_NOW':
        $lc_text = (PRODUCT_LIST_OPTIONS == 'true'  ? 'Product Options</td><td align="center" class="productListing-heading">' : '') . (strstr(LISTING_BUTTON, 'buy now')? TABLE_HEADING_BUY_NOW : TABLE_HEADING_DETAIL);
        $lc_align = 'center';
        break;
    }
    if ( ($column_list[$col] != 'PRODUCT_LIST_BUY_NOW') && ($column_list[$col] != 'PRODUCT_LIST_IMAGE') ) {
      $lc_text = tep_create_sort_heading($_GET['sort'], $col+1, $lc_text);
    }
   $list_box_contents[] = array('align' => $lc_align,'params' => 'class="productListing-heading" ' . ($set_width ? 'width="'.(int)(100/sizeof($column_list)) . '%"' : ''),'text' => '&nbsp;' . $lc_text . '&nbsp;');
  }
  return ($list_box_contents);
}
// function list_head end

function list_box_data($listing, $column_list, $link) {
        global $PHP_SELF, $ttip, $head_title, $rows, $set_width, $multi_add;
        $alt_text = $listing['products_name'];
        $image = (file_exists(DIR_WS_IMAGES . $listing['products_image']) ? $listing['products_image'] : 'no-image.jpg');
        $image = '<span class="ttip">' . $link . tep_image(DIR_WS_IMAGES . $image, $alt_text, PRODUCT_IMAGE_WIDTH, PRODUCT_IMAGE_HEIGHT) . ($ttip ? tep_image(DIR_WS_IMAGES . $image, $alt_text, IMAGE_TTIP_WIDTH, '', 'class="large"') : '' ) . '</a></span>';
        $name = (!$head_title ? $link . '<span class="productListing-name">' . $listing['products_name'] . '</span></a>' : '');
        if (LISTING_BUTTON != 'none' && PRODUCT_LIST_BUY_NOW) {
        $buypic = (LISTING_BUTTON == 'buy now' ? 'button_in_cart.gif' : 'button_buy_now.gif');
        $p_price = $listing['products_price'];
        $quantity_box = quantity ($listing['products_id'], $p_price);
        $form = ($multi_add ? '' : tep_draw_form('cart_quantity_' . $rows, tep_href_link(basename($PHP_SELF), tep_get_all_get_params(array('action','products_id')) . 'action=add_product')));
        $buytable = '<table class="buytable" border="0" width="100%" cellspacing="0" cellpadding="2"><tr><td valign="bottom" class="productListing-data">';
        $buytableend = '</td></tr></table>'. ($multi_add ? '' : '</form>');
        $detail = $link . tep_image_button((strstr(LISTING_BUTTON, '&') || (strstr(LISTING_BUTTON, 'small')) ? 'button_details_small.gif' : 'button_details.gif'), IMAGE_BUTTON_DETAILS, 'class="thm_buy_now"') . '</a>&nbsp;';
        $add_cart = ($multi_add ? ($quantity_box ? '' : $detail) : tep_draw_hidden_field('products_id', $listing['products_id']) . tep_image_submit($buypic, IMAGE_BUTTON_BUY_NOW, 'class="thm_buy_now"'));
        $button = (LISTING_BUTTON == 'buy now & details' ? ($add_cart == $detail ? $add_cart : $add_cart . '&nbsp;<span class="buy_now">|</span>&nbsp;' . $detail ) : (strstr(LISTING_BUTTON, 'buy now') ? $add_cart : $detail ));
        if ($p_price == 0 || (isset($listing['products_quantity']) && !$listing['products_quantity'])) { $button = $detail; $quantity_box = '';}//'<span class="buy_now">&nbsp;</span>'.
        }
        $list_box_temp =  array('params' => 'class="list-block"');
        if (!strstr(PRODUCT_THUMBNAIL_VIEW, 'block')) {
        for ($col=0, $n=sizeof($column_list); $col<$n; $col++) {
        if ($head_title && $column_list[$col] == 'PRODUCT_LIST_PRICE') continue;
        $lc_align = '';
        $params = 'class="productListing-data" ' . ($set_width ? 'width="'.(int)(100/sizeof($column_list)) . '%"' : '') . ' valign="top" ';
        switch ($column_list[$col]) {
          case 'PRODUCT_LIST_MODEL':
            $lc_align = 'center';
            $lc_text = '&nbsp;' . $listing['products_model'] . '&nbsp;';
            break;
          case 'PRODUCT_LIST_NAME':
            $lc_align = '';
            $lc_text = $name . ($listing['short_desc'] && (PRODUCT_SHORT_DESC == 'true') ? '<br /><span class="short">' . $listing['short_desc'] . '</span>' : '') . product_description($listing['products_id'],$link);
            $extra_fields_text = extra_fields($listing['products_id']);
            if ($extra_fields_text) $lc_text .= '<br /><table>' . $extra_fields_text . '</table>';
           break;
          case 'PRODUCT_LIST_MANUFACTURER':
            $lc_align = 'center';
            $lc_text = '&nbsp;<a href="' . tep_href_link(FILENAME_DEFAULT, 'manufacturers_id=' . $listing['manufacturers_id']) . '">' . $listing['manufacturers_name'] . '</a>&nbsp;';
            break;
          case 'PRODUCT_LIST_PRICE':
            if(!$head_title) {
              $lc_align = 'right';
              $lc_text = product_price($listing, 2);
            }
            break;
          case 'PRODUCT_LIST_QUANTITY':
            $lc_align = 'right';
            $lc_text = '&nbsp;' . $listing['products_quantity'] . '&nbsp;';
            break;
          case 'PRODUCT_LIST_WEIGHT':
            $lc_align = 'right';
            $lc_text = '&nbsp;' . $listing['products_weight'] . '&nbsp;';
            break;
          case 'PRODUCT_LIST_IMAGE':
            $lc_align = 'center';
            $lc_text = $image;
            break;
          case 'PRODUCT_LIST_BUY_NOW':
            if (PRODUCT_LIST_OPTIONS == 'true' ) $params = 'class="productListing-data" width="'.(int)((100/sizeof($column_list))*2).'%" colspan="2"';
            $lc_align = 'center';
            $button = $quantity_box . $button;
            $lc_text = $form . $buytable . (PRODUCT_LIST_OPTIONS == 'true'  ? attribute_drop($listing['products_id'],$listing['products_tax_class_id']) . '</td><td align="center" class="productListing-data">' . $button : $button) . $buytableend;
           break;
        }
        $list_box_temp[] = array('align' => $lc_align,
                                 'params' => $params,
                                 'text'  => $lc_text);
      }
    } else {
    if (PRODUCT_LIST_IMAGE) { $list_box_temp[] = array('align' => 'center',
                                              'params' => 'class="productListing-data" ',
                                              'text'  => $image);   }
         $display ='';$text = '';
    for ($col=0, $n=sizeof($column_list); $col<$n; $col++) {
    if ($head_title && $column_list[$col] == 'PRODUCT_LIST_PRICE') continue;
        $last = (($col + BLOCK_LAST_SIZE + 1) > $n);
        $text .= ($text ? '<br />' : '');
        switch ($column_list[$col]) {
          case 'PRODUCT_LIST_MODEL':
            $text .= $listing['products_model'];
            if (!$last) {$display .= $text . '<br />'; $text = '';}
            break;
          case 'PRODUCT_LIST_NAME':
            $text .= $name . ($listing['short_desc'] && (PRODUCT_SHORT_DESC == 'true') ? '<br /><span class="short">' . $listing['short_desc'] . '</span>' : '') . product_description($listing['products_id'],$link);
            $extra_fields_text = extra_fields($listing['products_id']);
            if ($extra_fields_text) $text .= '<br /><table>' . $extra_fields_text . '</table>';
            if (!$last) {$display .= $text . '<br />'; $text = '';}
           break;
          case 'PRODUCT_LIST_MANUFACTURER':
            $text .= '<a href="' . tep_href_link(FILENAME_DEFAULT, 'manufacturers_id=' . $listing['manufacturers_id']) . '">' . $listing['manufacturers_name'] . '</a>';
            if (!$last) {$display .= $text . '<br />'; $text = '';}
            break;
          case 'PRODUCT_LIST_PRICE':
            $text .= ($last ? '' : '<br />Price: ') . product_price($listing, 3, $last) . ($last ? '' : '<br />');
            if (!$last) {$display .= $text . '<br />'; $text = '';}
            break;
          case 'PRODUCT_LIST_QUANTITY':
            $text .= ($listing['products_quantity'] ? 'Stock = ' . $listing['products_quantity'] : 'Out of Stock');
            if (!$last) {$display .= $text . '<br />'; $text = '';}
            break;
          case 'PRODUCT_LIST_WEIGHT':
            $text .= 'Weight = ' . $listing['products_weight'].WEIGHT_ABRV . ($last ? '' : '<br />');
            if (!$last) {$display .= $text . '<br />'; $text = '';}
            break;
          case 'PRODUCT_LIST_BUY_NOW':
            $button = '<div align="right" width="100%">' . $quantity_box . '</div>' . ($last ? '' : '&nbsp;&nbsp;') . $button;
            $text .= $form . $buytable . (PRODUCT_LIST_OPTIONS == 'true' ? '<div ' . ($last ? 'align="right"' : 'align="left"' ) . ' width="100%">' . attribute_drop($listing['products_id'],$listing['products_tax_class_id']) . '</div>' . $button : $button) . $buytableend; //'<br />' .

            if (!$last) {$display .= $text . '<br />'; $text = '';}
            break;
        }
      }
        $display .= '';

  $list_box_temp[] = array('align' => 'left',
                             'params' => 'class="main" valign="top" ',
                             'text'  => $display);
  $list_box_temp[] = array('align' => 'right',
                             'params' => 'class="productListing-data" valign="top" ',
                             'text'  => $text);
    }
    return  ($list_box_temp);
    }
// function list_box_data end

function attribute_drop($products_id,$tax_class_id) {
  global $languages_id, $multi_add;
  $currencies = new currencies();
$atrib_drop = '';
    $products_attributes_query = tep_db_query("select count(*) as total from " . TABLE_PRODUCTS_ATTRIBUTES . " where products_id='" . (int)$products_id . "'");
    $products_attributes = tep_db_fetch_array($products_attributes_query);
    if ($products_attributes['total'] > 0) {

    $atrib_drop = '<table border="0" cellspacing="0" cellpadding="2" class="attributes">';

    $products_options_name_query = tep_db_query("select distinct popt.products_options_id, popt.products_options_name from " . TABLE_PRODUCTS_OPTIONS . " popt, " . TABLE_PRODUCTS_ATTRIBUTES . " patrib where patrib.products_id='" . (int)$products_id . "' and patrib.options_id = popt.products_options_id and popt.language_id = '" . (int)$languages_id . "' order by popt.products_options_name");
      while ($products_options_name = tep_db_fetch_array($products_options_name_query)) {
        $products_options_array = array();
        $products_options_query = tep_db_query("select pov.products_options_values_id, pov.products_options_values_name, pa.options_values_price, pa.price_prefix from " . TABLE_PRODUCTS_ATTRIBUTES . " pa, " . TABLE_PRODUCTS_OPTIONS_VALUES . " pov where pa.products_id = '" . (int)$products_id . "' and pa.options_id = '" . (int)$products_options_name['products_options_id'] . "' and pa.options_values_id = pov.products_options_values_id and pov.language_id = '" . (int)$languages_id . "'");
        while ($products_options = tep_db_fetch_array($products_options_query)) {
          $products_options_array[] = array('id' => $products_options['products_options_values_id'], 'text' => $products_options['products_options_values_name']);
          if ($products_options['options_values_price'] != '0') {
            $products_options_array[sizeof($products_options_array)-1]['text'] .= ' (' . $products_options['price_prefix'] . $currencies->display_price($products_options['options_values_price'], tep_get_tax_rate($tax_class_id)) .') ';
          }
        }
$atrib_drop .= '<tr><td class="attributes" >' . $products_options_name['products_options_name'] . ':' . '</td><td align="left">' . tep_draw_pull_down_menu('id' . ($multi_add ? '['. $products_id .']' : '') . '[' . $products_options_name['products_options_id'] . ']', $products_options_array) . '</td></tr>';

      }
            $atrib_drop .= '</table>';
    }
    return $atrib_drop;
  }
  // function attribute_drop end

// set initial values

$empty_list=false;//$man_id = (tep_not_null($_GET['manufacturers_id']) ? $_GET['manufacturers_id'] : '');
if ($man_id = (tep_not_null($_GET['manufacturers_id']) ? $_GET['manufacturers_id'] : '')) {
$title_name = tep_get_manufacturer_name($_GET['manufacturers_id']);
} else {
$title_name =  ($specials ? $specials : ($new_page ? '' : ($new_mode ? $new_mode : (!$category['categories_name'] && tep_not_null($_GET['cPath']) ? tep_get_category_name(substr($_GET['cPath'], strpos($_GET['cPath'],'_')+1),$languages_id) : ''))));
}
$grid = strstr(PRODUCT_THUMBNAIL_VIEW, 'grid');
$gborders = function_exists(mws_boxHeader);//$gborders = false;
$Tborder = (!$gborders ? '<div class="infoBoxList" style="width:100%;">' : mws_boxHeader('<big>'.$title_name.'</big>'));
$Tborderend = (!$gborders ? '</div>' : mws_boxFooter ());
$border2 = (!$gborders ? '<div class="infoBoxList" style="width:100%;">' : ($graphic_bord == 'yes' ? mws_boxHeader('<big>'.$title_name.'</big>') : ''));
$border2end = (!$gborders ? '</div>' : ($graphic_bord == 'yes' ? mws_boxFooter() : ''));
$list_box_empty[] = array(array('params' => 'class="productListing-data"','text' => TEXT_NO_PRODUCTS));
$ttip = (IMAGE_TTIP == 'true');
$head_title = (PRODUCT_LIST_HEAD_TITLE == 'true');
$man_desc = (MANU_DESCRIPTION == 'true');

if (tep_not_null($_GET['categories_id']) && $current_category_id == 0) $current_category_id = $_GET['categories_id'];

// output selected display
 if ($thumbnail_view) {  //thumbnail
  $row = 0;
  $col = 0;
  $border = (!$grid ? '<div class="infoBoxProducts" style="width:'.PRODUCT_LIST_WIDTH.'px; height:'.PRODUCT_LIST_HEIGHT.'px;" >' : '<br />');
  $borderend = (!$grid ? '</div>' : '');
  $style = (!$grid ? 'class="smallText"' : 'class="infoBoxGrid"');

  $info_box_contents = array();
  if ($data_ok) {   $listing_query = tep_db_query($listing_split->sql_query);} else {
        $listing_query = tep_db_query($listing_sql); }
  if (tep_db_num_rows($listing_query)) {
  while ($products = tep_db_fetch_array($listing_query)) {
    if ($row == 0) {
        if (!$gborders && !$grid)
              $info_box_contents[$row][$col] = array('align' => 'center',
                                           'params' => 'class="smallText" width="'.(PRODUCTS_PER_ROW ? (int)(100/PRODUCTS_PER_ROW) : '').'%" valign="top"',
                                           'text' =>  '&nbsp;');
        echo $Tborder;$row ++;
        if (!$gborders && $grid && $title_name) {
            $info_box_heading[0] = array('text' => '<big>'.$title_name.'</big>');
            new infoBoxHeading($info_box_heading, false, false);
        }
     }

      // build thumb
    $link = '<a href="' . tep_href_link(FILENAME_PRODUCT_INFO, 'products_id=' . $products['products_id'] . ($man_id ? '&manufacturers_id='.$man_id : ($cPath && $cat_path ? '&cPath=' . $cPath : ''))) . '"' . ($man_id  || ($cat_path && $cat_path) ? ' rel="nofollow"' : '') . '>';
    $p_price = $products['products_price'];
    $quantity_box = quantity ($products['products_id'],$p_price);
    $image = (file_exists(DIR_WS_IMAGES . $products['products_image']) ? $products['products_image'] : 'no-image.jpg');
    $addimages = (file_exists(DIR_WS_CLASSES . 'displayimages.php')); // Additional Images Present
    if ($addimages) {
    $image_query = tep_db_query( "SELECT ai.medium_images, ai.images_description, ai.popup_images, p.products_image_med, p.products_image_description  FROM " .  TABLE_ADDITIONAL_IMAGES . " ai, " . TABLE_PRODUCTS . " p WHERE ai.products_id=p.products_id and ai.products_id = '".(int)$products['products_id']."'");
    $selected_image = tep_db_fetch_array($image_query);
    $image = ($selected_image['medium_images'] ? $selected_image['medium_images'] : ($selected_image['products_image_med'] ? $selected_image['products_image_med'] : ($selected_image['popup_images'] ? $selected_image['popup_images'] : $products['products_image'])));
                    }
    $alt_text = ($addimages ? (tep_not_null($selected_image['images_description']) ? $selected_image['images_description'] : (tep_not_null($selected_image['products_image_description']) ? $selected_image['products_image_description'] : $products['products_name'])) : $products['products_name']);
    $image = ' <span class="ttip">' . $link . tep_image(DIR_WS_IMAGES . $image, $alt_text, 0, SMALL_IMAGE_HEIGHT, ' class="productListing-grid-image" ')  . ($ttip ? tep_image(DIR_WS_IMAGES . $image, $alt_text, IMAGE_TTIP_WIDTH, '', ' class="large"') : '' ) . '</a></span>' . '<br />';
    if (LISTING_BUTTON != 'none' && PRODUCT_LIST_BUY_NOW) {
    $buypic = (LISTING_BUTTON == 'buy now' ? 'button_in_cart.gif' : 'button_buy_now.gif');
    $detail = $link . tep_image_button((strstr(LISTING_BUTTON, '&') || (strstr(LISTING_BUTTON, 'small')) ? 'button_details_small.gif' : 'button_details.gif'), IMAGE_BUTTON_DETAILS, 'class="thm_buy_now"') . '</a>';
    $add_cart = ($multi_add ? ($quantity_box ? '' : $detail) : tep_draw_hidden_field('products_id', $products['products_id']) . tep_image_submit($buypic, IMAGE_BUTTON_BUY_NOW, 'class="thm_buy_now"'));
    $button = (LISTING_BUTTON == 'buy now & details' ? '<br />' . $quantity_box . ($add_cart == $detail ? $add_cart : $add_cart . '&nbsp;<span class="buy_now">|</span>&nbsp;' . $detail . '<br /><br />') : (strstr(LISTING_BUTTON, 'buy now') ? '<br />' . $quantity_box . $add_cart . '<br /><br />' : '<br />'. $detail . '<br /><br />' ));
    if ($p_price == 0  || (isset($products['products_quantity']) && !$products['products_quantity'])) { $button = $quantity_box . '<br /><span class="buy_now">&nbsp;</span>'. $detail . '<br />';$quantity_box = ''; }
    }
    $name = '<div class="productListing-name">' . $link . $products['products_name'] . '</a></div>'. ($products['short_desc'] && (PRODUCT_SHORT_DESC == 'true') ? '' . $products['short_desc'] . '<br />' : '') . product_description($products['products_id'],$link, true);
    $show_price = /*'<br />' .*/ product_price($products, 4) /*. '<br />'*/;
    $quantity = ($products['products_quantity'] ? 'Stock = '.$products['products_quantity'] : 'Out of Stock').'<br />';
    $weight = 'Weight = '.$products['products_weight'].WEIGHT_ABRV.'<br />';
    $model = $products['products_model'] . '<br />';
    $manfact = '<a href="' . tep_href_link(FILENAME_DEFAULT, 'manufacturers_id=' . $products['manufacturers_id']) . '">' . $products['manufacturers_name'] . '</a><br />';
    $display = $border;
    for ($disp=0, $n=sizeof($column_list); $disp<$n; $disp++) {
        switch ($column_list[$disp]) {
          case 'PRODUCT_LIST_IMAGE':
            $display .= '<table summary="" width="100%" cellpadding=0 cellspacing=0><tr><td style="text-align:center;" valign="top">'.$image.'</td></tr></table>';
            break;
          case 'PRODUCT_LIST_NAME':
            $display .= '<table summary="" width="100%" ><tr><td class="thumbcontent" height="'.PRODUCT_NAME_VSPACE.'" >'.$name.'</td></tr>' . extra_fields($products['products_id']) . '</table>';
            break;
          case 'PRODUCT_LIST_MODEL':
            $display .= $model;
            break;
          case 'PRODUCT_LIST_MANUFACTURER':
            $display .= $manfact;
            break;
          case 'PRODUCT_LIST_PRICE':
            $display .= $show_price;
            break;
          case 'PRODUCT_LIST_QUANTITY':
            $display .= $quantity;
            break;
          case 'PRODUCT_LIST_WEIGHT':
            $display .= $weight;
            break;
          }
    }
    $form = ($multi_add ? '' : tep_draw_form('cart_quantity_' . $col . $row, tep_href_link(basename($PHP_SELF), tep_get_all_get_params(array('action','products_id')) . 'action=add_product')));
    $display .= $borderend . $form . '' . (PRODUCT_LIST_OPTIONS == 'true' ? attribute_drop($products['products_id'],$products['products_tax_class_id']) : '') . /*$button .*/ ($multi_add ? '' : '</form>');
        // thumb built


     $info_box_contents[$row][$col] = array('align' => 'center',
                                           'params' => $style . ' width="'.(PRODUCTS_PER_ROW ? (int)(100/PRODUCTS_PER_ROW) : '').'%" valign="top"',
                                           'text' => $display );
    $col ++;
    if ($col > PRODUCTS_PER_ROW-1) {
      $col = 0;
      $row ++;
    }
}  // prod loop
} else {$empty_list=true; }// no products!!
 // got display
if ($row) {
$i = 0 ; $nbx = class_exists(noborderBox);
    if ($col > 0 && $row > 1 && $nbx && !$grid) {
        for ($i=0, $n=$col; $i < $n; $i++) { $last_row[0][$i] =  $info_box_contents[$row][$i]; unset($info_box_contents[$row][$i]);
        }
    }
if (!$i) {$col = 0;$row ++;$info_box_contents[$row][$col] = array('align' => 'center',
                                           'params' => 'class="smallText" width="'.(PRODUCTS_PER_ROW ? (int)(100/PRODUCTS_PER_ROW) : '').'%" ',
                                           'text' =>  '&nbsp;'); }
 if ($nbx) new noborderBox($info_box_contents); else new contentBox($info_box_contents);
 if($i) new noborderBox($last_row);
 echo ($gborders ? '' : '') . $Tborderend;
                  } else {$empty_list=true; }
} elseif (strstr($list_mode, 'manufacturer') && !$new_mode) {  //manufacturer

$row = 0;$col = 0;

if ($man_id) {
$filterlist_sql= tep_db_query("select distinct m.manufacturers_id, m.manufacturers_name" . ($man_desc ? ", mi.manufacturers_description" : "") . " from " . TABLE_MANUFACTURERS . " m left join " . TABLE_MANUFACTURERS_INFO . " mi on m.manufacturers_id = mi.manufacturers_id where m.manufacturers_id = '" . (int)$man_id . "' and mi.languages_id = '" . (int)$languages_id . "'");
  }else{
$filterlist_sql= tep_db_query("select distinct m.manufacturers_id, m.manufacturers_name" . ($man_desc ? ", mi.manufacturers_description" : "") . " from " . TABLE_PRODUCTS . " p, " . TABLE_PRODUCTS_TO_CATEGORIES . " p2c, " . TABLE_MANUFACTURERS . " m left join " . TABLE_MANUFACTURERS_INFO . " mi on m.manufacturers_id = mi.manufacturers_id where p.products_status = '1' and p.manufacturers_id = m.manufacturers_id and p.products_id = p2c.products_id and p2c.categories_id = '" . (int)$current_category_id . "' and mi.languages_id = '" . (int)$languages_id . "' order by m.manufacturers_name");
}
if (tep_db_num_rows($filterlist_sql)) { $rows = 0;
  while ($manufacturer = tep_db_fetch_array($filterlist_sql)) {
    $info_box_heading = array(); if ($rows) echo tep_draw_separator('pixel_trans.gif', '100%', '4');
    echo $border2;
    $info_box_heading[0] = array('text' => '<big>'.$manufacturer['manufacturers_name'].'</big><br />'.($man_desc ? $manufacturer['manufacturers_description'].'<br />' : ''));
    new infoBoxHeading($info_box_heading, false, false);
    $list_box_contents = array();
    $list_box_contents[0] = (LISTING_HEADINGS == 'true' && !strstr(PRODUCT_THUMBNAIL_VIEW, 'block') ? list_box_head($column_list) : '');
    if ($data_ok) { $rows = 0;  $listing_query = tep_db_query($listing_split->sql_query);} else {
      $rows = 0;  $listing_query = tep_db_query($listing_sql); }
    while ($listing = tep_db_fetch_array($listing_query)) {
    if ($listing['manufacturers_id'] != $manufacturer['manufacturers_id']) continue;
    list_row ($listing, $column_list);
    }
    $list_box_contents[sizeof($list_box_contents)-1] = array(array('text' =>  '<br />'));
   if (!$rows && $man_id) {
     $rows++;  $list_box_contents = $list_box_empty; $empty_list=true;}
    if ($rows) new productListingBox($list_box_contents);
    echo $border2end;
    //echo '<div class="multi_buy_now" id="gbutton2">' . $gbutton;
}   // man loop;
} else {$empty_list=true; }  // no manufacturers!!
 }
 if ((!$thumbnail_view && !strstr($list_mode, 'manufacturer')) || $empty_list  || ($new_mode && !$thumbnail_view)) {   //default listing

  if ($man_desc && $man_id) {
  $manufacturer_query = tep_db_query("select manufacturers_description from " . TABLE_MANUFACTURERS_INFO . " where manufacturers_id = '" . (int)($man_id) . "' and languages_id = '" . (int)$languages_id . "'");
    $manufacturer = tep_db_fetch_array($manufacturer_query); }

   $info_box_heading[0] = array('text' => '<big>'.$title_name.'</big>'.($manufacturer['manufacturers_description'] ? '<br />' . $manufacturer['manufacturers_description'] : ''));
   $list_box_contents = array();
   $list_box_contents[0] = (LISTING_HEADINGS == 'true' && !strstr(PRODUCT_THUMBNAIL_VIEW, 'block') ? list_box_head($column_list) : '');
   if ($listing_split->number_of_rows > 0) {  $rows = 0; $listing_query = tep_db_query($listing_split->sql_query);

    while ($listing = tep_db_fetch_array($listing_query)) {
    list_row ($listing, $column_list);
    }
    $list_box_contents[sizeof($list_box_contents)-1] = array(array('text' =>  '<br />'));
    $empty_list = false;
    echo $border2;
    if ($title_name) new infoBoxHeading($info_box_heading, false, false);
    new productListingBox($list_box_contents);
    echo $border2end;
  } else {
    new productListingBox($list_box_empty); $empty_list=true;
  }

  }
  if ($multi_add) { if ($global_add != 'top') echo '<div class="multi_buy_now" id="gbutton2">' . $gbutton;  echo '</form>'; }
  if ($base_nav && !$empty_list) echo $drop;
  if (($listing_split->number_of_rows > (int)$max_results) && $base_nav) echo $page_nav;
  if (LISTING_SWITCH != 'top') echo $switch . '<br />';
   //echo '<hr>' . $listing_sql . '<hr>' . $listing_split->number_of_rows . ' records.';

?>
