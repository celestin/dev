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
 * CAM  29-May-2010  10670 : Call table_header.
 * * * * * * * * * * * * * * * * * * * * * * * */

  require(DIR_WS_INCLUDES . 'counter.php');
?>
<?php require(DIR_WS_INCLUDES . 'table_header_top.php'); ?>
  <tr class="footer">
    <td class="footer">&nbsp;&nbsp;<?php echo strftime(DATE_FORMAT_LONG); ?>&nbsp;&nbsp;</td>
    <td align="right" class="footer">&nbsp;&nbsp;<?php echo $counter_now . ' ' . FOOTER_TEXT_REQUESTS_SINCE . ' ' . $counter_startdate_formatted; ?>&nbsp;&nbsp;</td>
  </tr>
</table>
<br>
<?php require(DIR_WS_INCLUDES . 'table_header_top.php'); ?>
  <tr>
    <td align="center" class="smallText"><?php echo FOOTER_TEXT_BODY; ?></td>
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
