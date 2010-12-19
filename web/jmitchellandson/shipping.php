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
 * CAM  29-May-2010  10670 : Call table_header.
 * CAM  01-Jul-2010  10726 : Added custom text.
 * CAM  22-Oct-2010  10791 : Added Google Analytics.
 * * * * * * * * * * * * * * * * * * * * * * * */

  require('includes/application_top.php');

  require(DIR_WS_LANGUAGES . $language . '/' . FILENAME_SHIPPING);

  $breadcrumb->add(NAVBAR_TITLE, tep_href_link(FILENAME_SHIPPING));
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
<?php include(FILENAME_ANALYTICS); ?>
</head>

<body marginwidth="0" marginheight="0" topmargin="0" bottommargin="0" leftmargin="0" rightmargin="0">
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
    <td width="100%" valign="top"><table border="0" width="100%" cellspacing="0" cellpadding="0">
      <tr>
        <td class="pageHeading"><?php echo HEADING_TITLE; ?></td>
      </tr>
      <tr>
        <td><?php echo tep_draw_separator('pixel_trans.gif', '100%', '10'); ?></td>
      </tr>
      <tr>
        <td><table border="0" width="100%" cellspacing="0" cellpadding="2">
          <tr>
            <td class="main">

          <div id="legal">

<h2>Delivery Information</h2>

<p>We only deliver to addresses in the United Kingdom. Goods can only be delivered to the home address where your credit card statements are received.</p>
<p>Orders are usually despatched same day or day after your order has been received (in stock items only), so please allow 3 to 4 working days, depending on the speed of Royal Mail.</p>
<p>All orders under £50 will be sent by <a href="http://www.royalmail.com/portal/rm/jump2?catId=400028&mediaId=500201">Royal Mail Recorded Delivery</a>,
  and all orders over £50 will be sent <a href="http://www.royalmail.com/portal/rm/jump2?catId=400028&mediaId=400026">Royal Mail Special Delivery</a>,
  a signature will be required for both delivery methods.</p>
<p>Royal Mail Special Delivery has a <a href="http://www.royalmail.com/portal/rm/personal?pageId=tab_track_rm&catId=500185&mediaId=83900761">Track and Trace system</a>,
  we will email this tracking number on despatch of your goods.</p>

<h2>Delivery Costs</h2>
<ul>
<li>Royal Mail Recorded Delivery up to £50 &mdash; Cost <b>&pound;2.95</b></li>
<li>Royal Mail Special Delivery under £100 &mdash; Cost <b>&pound;5.95</b></li>
<li>Royal Mail Special Delivery over £100 &mdash; <b>Free Delivery</b></li>
</ul>

<h2>Return Policy</h2>

<p>If for any reason you are unhappy with your purchase or you have a change of mind, we offer a 7 day money back guarantee. The cooling off period begins the day you receive the goods.</p>
<p>Goods must be returned in their original condition along with all the packaging and paperwork.</p>
<p>A full refund will be given including any postal charges included in the original price, and returned to the same form of payment.</p>
<p>For hygiene reasons we cannot accept the return of earrings and other pierced jewellery.</p>
<p>Unfortunately we cannot exchange or refund goods which have been personalised, made to order or altered to fit.</p>

           </div>




            </td>
          </tr>
        </table></td>
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
    </table></td>
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
</body>
</html>
<?php require(DIR_WS_INCLUDES . 'application_bottom.php'); ?>
