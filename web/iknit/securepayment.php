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
 * CAM  13-Jul-2010  10740 : File created.
 * CAM  30-Oct-2010  10805 : Added Google Analytics.
 * CAM  12-Dec-2010  10833 : Changed RBS WorldPay text to Google Checkout.
 * CAM  16-Aug-2011  11011 : Added Google Logo.
 * CAM  12-Nov-2011  11053 : Changed Google Checkout text to WorldNet text.
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

								<p style="text-align: justify;"><img style="float: right; margin-left: 15px;"
									src="https://www.worldnettps.com/sites/default/files/wnmark-14.jpg" alt="" width="200" height="60" />Security is
									the Number One issue of concern for online shoppers &mdash; which is why
									providing the highest levels of online security is the Number One priority for WorldNet.</p>

								<p>We aim to give your customers the level of confidence that can only come from knowing their payment information is fully secure.</p>

								<p><img style="float: left; margin-right: 15px;" src="https://www.worldnettps.com/sites/default/files/vlogo.gif" alt=""
									width="115" height="47" />We take a multi-layered approach to security.  We partner with Verisign, the global
									leaders in secure encryption, to provide full 256 bit encryption to all of our transactions.</p>

								<p><img style="float: right; margin-left: 5px;" src="https://www.worldnettps.com/sites/default/files/PCIDSS.jpg" alt=""
									width="185" height="108" />We are certified with Visa &amp; Mastercard to the highest level of the Payment Card Industry
									Data Security Standard (PCI DSS). We work with Sysnet, an independent Qualified Security Assessor (QSA), who regularly
									monitor our systems to ensure they are immune to the latest vulnerabilities on the web.</p>

								<p>This multi-layered approach allows us to provide your customers with the highest level of online security, ensuring
									their payment details are always fully secured, and allowing them to shop online with confidence.</p></div>
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
