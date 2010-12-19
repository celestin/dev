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
 * CAM  13-Jul-2010  10740 : File created.
 * CAM  22-Oct-2010  10791 : Added Google Analytics.
 * * * * * * * * * * * * * * * * * * * * * * * */

  require('includes/application_top.php');

  require(DIR_WS_LANGUAGES . $language . '/' . FILENAME_SECUREPAYMENT);

  $breadcrumb->add(NAVBAR_TITLE, tep_href_link(FILENAME_SECUREPAYMENT));
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
        <td><table border="0" width="100%" cellspacing="0" cellpadding="2">
          <tr>
            <td class="main">

              <div id="legal">

                <div id="worldpay">
                  <a href="http://www.rbsworldpay.com/shopper/index.php?c=UK"><?php echo tep_image(DIR_WS_IMAGES . DIR_PAYMENT_IMAGES . 'worldpay_large.png') ?></a>
                </div>

                <p>Our shopping cart is powered by <span id="rbs">RBS WorldPay&trade;</span> &mdash;
                a trusted, secure service, giving you <b>peace of mind</b> and enabling you to make your <b>payment quickly and easily</b>.</p>


                <p>We accept payment using the following cards:</p>

                <?php echo tep_image(DIR_WS_IMAGES . DIR_PAYMENT_IMAGES . 'cards.png') ?>

                <p>Want to read more about <span id="rbs">RBS WorldPay</span>? Their online <a href="http://www.rbsworldpay.com/shopper/index.php?c=UK">Shopper Help</a>
                is very useful if you want peace of mind about
                <a href="http://www.rbsworldpay.com/shopper/index.php?page=payment&c=UK">how payments are made</a>, and we highly recommend that you read their
                <a href="http://www.rbsworldpay.com/shopper/index.php?page=safety&c=UK">Internet Shopping Safety</a> tips.

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
