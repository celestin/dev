<?php
/* * * * * * * * * * * * * * * * * * * * * * * *
 * Lovie's Yarns (loviesyarn.com)
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
 * CAM  12-May-2012  11119 : Changed the footer text.
 * * * * * * * * * * * * * * * * * * * * * * * */

  require(DIR_WS_INCLUDES . 'counter.php');
?>
<?php require(DIR_WS_INCLUDES . 'table_header_top.php'); ?>
  <tr class="footer">
    <td class="footer"><?=FOOTER_TEXT_CPY?></td>
    <td align="right" class="footer"><?=FOOTER_TEXT_BODY?></td>
  </tr>
</table>
<?php
  if ($banner = tep_banner_exists('dynamic', '468x50')) {
?>
<br>
<?php require(DIR_WS_INCLUDES . 'table_header_top.php'); ?>
  <tr>
    <td align="center"><?php echo tep_display_banner('static', $banner); ?></td>
  </tr>
</table>
<?php
  }
?>
