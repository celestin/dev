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
 * CAM  02-Jun-2010  10729 : Added About Us, Jewellery Care and Birthstones.
 * CAM  13-Jul-2010  10740 : Added Secure Payment.
 * * * * * * * * * * * * * * * * * * * * * * * */
?>
<!-- information //-->
          <tr>
            <td>
<?php
  $info_box_contents = array();
  $info_box_contents[] = array('text' => BOX_HEADING_INFORMATION);

  new infoBoxHeading($info_box_contents, false, false);

  $info_box_contents = array();
  $info_box_contents[] = array('text' =>
    '<a href="' . tep_href_link(FILENAME_ABOUTUS) . '">' . BOX_INFORMATION_ABOUTUS . '</a><br>' .
    '<a href="' . tep_href_link(FILENAME_JEWELLERY_CARE) . '">' . BOX_INFORMATION_JEWELLERY_CARE . '</a><br>' .
    '<a href="' . tep_href_link(FILENAME_BIRTHSTONES) . '">' . BOX_INFORMATION_BIRTHSTONES . '</a><br>' .
    '<a href="' . tep_href_link(FILENAME_CONDITIONS) . '">' . BOX_INFORMATION_CONDITIONS . '</a><br>' .
    '<a href="' . tep_href_link(FILENAME_PRIVACY) . '">' . BOX_INFORMATION_PRIVACY . '</a><br>' .
    '<a href="' . tep_href_link(FILENAME_SECUREPAYMENT) . '">' . BOX_INFORMATION_SECUREPAYMENT . '</a><br>' .
    '<a href="' . tep_href_link(FILENAME_SHIPPING) . '">' . BOX_INFORMATION_SHIPPING . '</a><br>' .
    '<b><a href="' . tep_href_link(FILENAME_CONTACT_US) . '">' . BOX_INFORMATION_CONTACT . '</a></b>');

  new infoBox($info_box_contents);
?>
            </td>
          </tr>
<!-- information_eof //-->
