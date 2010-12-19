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

  require(DIR_WS_LANGUAGES . $language . '/' . FILENAME_BIRTHSTONES);

  $breadcrumb->add(NAVBAR_TITLE, tep_href_link(FILENAME_BIRTHSTONES));
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

              <div id="birthstones">

                <p>Traditionally a precious stone was associated with a sign of the zodiac, based on a colour system. In time birthstones became associated with calendar months rather than zodiac signs.</p>

                <p>Every month has its own birthstone which is said to be lucky or important for people born in that month.</p>

                <?php echo tep_image(DIR_WS_IMAGES . DIR_BIRTHSTONE_IMAGES . 'garnet.png') ?><h2>January &mdash; Garnet</h2>
                <p>Garnet has a dark red colour, but can be found in many colours except blue. Garnet is a very versatile stone and is available in many shapes and sizes.</p>

                <?php echo tep_image(DIR_WS_IMAGES . DIR_BIRTHSTONE_IMAGES . 'amethyst.png') ?><h2>February &mdash; Amethyst</h2>
                <p>Amethyst is an extremely beautiful gemstone with its remarkable purple colour. It is said to have healing properties and also give peace, protection and tranquillity.</p>

                <?php echo tep_image(DIR_WS_IMAGES . DIR_BIRTHSTONE_IMAGES . 'aquamarine.png') ?><h2>March &mdash; Aquamarine</h2>
                <p>Aquamarine has a pastel sea blue colour. The word aquamarine means sea water and some legends consider aquamarine to be the treasure of mermaids.</p>

                <?php echo tep_image(DIR_WS_IMAGES . DIR_BIRTHSTONE_IMAGES . 'diamond.png') ?><h2>April &mdash; Diamond</h2>
                <p>Diamond is the ultimate symbol of love, the traditional colour associated with diamond is white and is the hardest material known to man, it is most desirable. Diamonds were discovered in India around 500BC and said to be splinters from the stars.</p>

                <?php echo tep_image(DIR_WS_IMAGES . DIR_BIRTHSTONE_IMAGES . 'emerald.png') ?><h2>May &mdash; Emerald</h2>
                <p>Emerald comes in all shades of green, from the palest to a rich deep green. First mined in Egypt, emeralds have long been valued as a symbol of wealth and prosperity.</p>

                <?php echo tep_image(DIR_WS_IMAGES . DIR_BIRTHSTONE_IMAGES . 'pearl.png') ?><h2>June &mdash; Pearl</h2>
                <p>Pearls have a milky white colour but can come in other colours depending on location and fashions. Cultured pearls are made by molluscs but with human intervention (an irritant introduced into the shell causes the pearl to grow).</p>

                <?php echo tep_image(DIR_WS_IMAGES . DIR_BIRTHSTONE_IMAGES . 'ruby.png') ?><h2>July &mdash; Ruby</h2>
                <p>Ruby has a dark red to a light pink colour. Ruby is second only to diamond for hardness. The finest rubies come from Burma, also found in Thailand, Sri Lanka and Kenya.</p>

                <?php echo tep_image(DIR_WS_IMAGES . DIR_BIRTHSTONE_IMAGES . 'peridot.png') ?><h2>August &mdash; Peridot</h2>
                <p>Peridot has a lime green colour and is one of the very few gemstones which come in one colour only. They are found in Burma, Brazil and U.S.A.</p>

                <?php echo tep_image(DIR_WS_IMAGES . DIR_BIRTHSTONE_IMAGES . 'sapphire.png') ?><h2>September &mdash; Sapphire</h2>
                <p>Sapphire comes in all colours (except red), but is traditionally recognised as a rich deep blue colour. It has the same hardness as ruby and is found in Australia, Sri Lanka, Thailand, U.S.A. and Africa.</p>

                <?php echo tep_image(DIR_WS_IMAGES . DIR_BIRTHSTONE_IMAGES . 'opal.png') ?><h2>October &mdash; Opal</h2>
                <p>Opal has a white body colour with pastel glints. Nearly 95% of opals are mined in                                                                                                   Australia with the rest mined in Mexico and U.S.A.</p>

                <?php echo tep_image(DIR_WS_IMAGES . DIR_BIRTHSTONE_IMAGES . 'topaz.png') ?><h2>November &mdash; Topaz</h2>
                <p>Topaz comes in different colours yellow, yellow brown, brown, green, blue, light blue, red and pink. Topaz is believed to offer long life and fidelity to those born in November. It symbolises beauty, splendour and joy.</p>

                <?php echo tep_image(DIR_WS_IMAGES . DIR_BIRTHSTONE_IMAGES . 'turquoise.png') ?><h2>December &mdash;Turquoise</h2>
                <p>Turquoise has a distinct sky blue colour, it is named after the Turkish, who first introduced it to Europe from Persia. Turquoise is found in U.S.A. and Iran.</p>

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
