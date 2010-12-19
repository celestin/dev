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
 * CAM  02-Jun-2010  10729 : File created.
 * CAM  22-Oct-2010  10791 : Added Google Analytics.
 * * * * * * * * * * * * * * * * * * * * * * * */

  require('includes/application_top.php');

  require(DIR_WS_LANGUAGES . $language . '/' . FILENAME_JEWELLERY_CARE);

  $breadcrumb->add(NAVBAR_TITLE, tep_href_link(FILENAME_JEWELLERY_CARE));
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

                <p>Jewellery should be carefully stored in a clean dry place, do not store together as this may result in the items getting scratched or damaged by other pieces.</p>

                <h2>Gold & Silver Jewellery</h2>

                <p>Light tarnishing can be removed by using a mild detergent diluted in warm water and a small soft brush (toothbrush is ideal). Rinse and dry thoroughly. For more stubborn tarnishing you will have to use a jewellery cleaning solution, purchased from a jeweller.</p>

                <p>White gold jewellery should not be cleaned in cleaning solutions as this will take off the rhodium plating, only clean in warm water. If your white gold items do go dull it will require rhodium plating.</p>

                <p>Be careful when cleaning jewellery with gemstones, as some stones require special cleaning procedures, also cleaning jewellery with gemstones which are set in by claws, requires more care not to break the claws. If in doubt ask your jeweller to clean them professionally.</p>

                <p>Avoid wearing your jewellery in swimming pools and Jacuzzis as chlorine can permanently damage or discolour your jewellery.</p>

                <h2>Diamonds</h2>

                <p>You should get your jeweller to check the settings of your diamonds on an annual basis to make sure there is no wear and tear which could lose the stone.</p>

                <p>Your diamonds will become dull during exposure to perspiration, dirt and cosmetics, to restore the sparkle in your diamonds regular cleaning should take place with a mild detergent and warm water with a soft brush and rinse and dry thoroughly.</p>

                <p>You should store your diamonds separately so they do not scratch other jewellery.</p>

                <h2>Gemstones</h2>

                <p>Opals, Pearls, Coral, Amber and Turquoise are porous stones and should be kept away from dirty water and oils to avoid damage and discolouration. They should be removed when washing dishes, applying sunscreens, lotions or creams and hairsprays and perfumes. They are sensitive to heat and sudden temperature changes, it is not advisable to leave near radiators or exposed to hot sunshine.</p>

                <p>Harder non porous gemstones, you can clean in a weak solution of mild detergent and warm water, rinse and dry thoroughly.</p>

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
