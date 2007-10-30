<?
/* * * * * * * * * * * * * * * * * * * * * * * *
 * Relaxatub
 * Copyright (c) 2006 Frontburner
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * Detailed Accessory page
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  18-Jul-2006  File added to source control.
 * * * * * * * * * * * * * * * * * * * * * * * */

  include_once 'main.php';

  $sql = "SELECT acc,accName,photo FROM acc WHERE acc=" . $_GET['acc'] . " ORDER BY dispOrder";
  $res = mysql_query($sql) or die('<pre>Error in <b>'.$sql.'</b></pre>');

  if ($row = mysql_fetch_array($res)) {
    foreach($row AS $key => $val) {
      $$key = stripslashes($val);
    }
  }

  $pageTitle = "Accessory - $accName";
  include "tpl/top.php";
?>

<table align=left border=0 cellpadding=4 cellspacing=0 width="100%" height="100%">
<tr><td align=left height="35"><img src="img/tt/accessories.gif" width="115" height="22" alt="Hot Tub Accessory - <? echo $accName ?>"></td></tr>
<tr><td align=center valign=top><table border=0 cellpadding=4 cellspacing=0>
  <tr><td align=center><img width=500 src="./img/ac/f/<? echo $photo ?>"></td></tr>
  <tr><td class="tubname"><? echo $accName ?></td></tr>
  <tr><td align=center>Accessory <b><? echo $acc ?></b></td></tr>

  <tr><td align=center><a href="accessories.php">Back to Accessories</a></td></tr>
</table></td></tr></table>

<?
  include "tpl/bot.php";
?>