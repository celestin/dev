<?
/* * * * * * * * * * * * * * * * * * * * * * * *
 * Relaxatub
 * Copyright (c) 2006,2010 Frontburner
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * Accessories page
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  18-Jul-2006  File added to source control.
 * CAM  14-Feb-2008  10243 : Highlight link associated with current page.
 * CAM  29-Mar-2010  10620 : Reworked to use new database tables and Paypal.
 * * * * * * * * * * * * * * * * * * * * * * * */

include_once 'main.php';

$pageId = "pageaccessories";
$pageTitle = "Accessories";
$pageCss = "accessories";

include "tpl/top.php";

function accLink($accid, $html)
{
  return "<a href=\"accessory.php?accid=$accid\">$html</a>";
}

function accessoryCategory($ptype)
{

$ptypedescription = "Accessories";
if ($ptype == "C") $ptypedescription = "Aftercare";

?>
<tr><td align=left colspan=2><h2><? echo $ptypedescription; ?></h2></td></tr>
<?

  $sql = "SELECT p.pid, p.pcode, p.pdescription, p.paypal_button_id, " .
           "acc.accid, acc.photo, ".
           "FORMAT(acc.price, 2) price ".
         "FROM product p, accessory acc ".
         "WHERE acc.pid=p.pid ".
         "AND p.ptype='$ptype' ".
         "ORDER BY p.pcode";
  $res = mysql_query($sql) or die('<pre>Error in <b>'.$sql.'</b></pre>');

  while ($row = mysql_fetch_array($res)) {
    foreach($row AS $key => $val) {
      $$key = stripslashes($val);
    }
?>
    <tr><form action="https://www.paypal.com/cgi-bin/webscr" method="post">
      <td align=center width=60><? echo accLink($accid, "<img border=0 src=\"./img/ac/t/$photo\">"); ?></td>
      <td width=400>
        <p><? echo accLink($accid, $pdescription); ?><br />
        <? echo $pcode; ?></p>
      </td>
      <td id="price">&pound;<? echo $price; ?></td>
      <td><input type="hidden" name="cmd" value="_s-xclick"><input type="hidden" name="hosted_button_id"
      value="<? echo $paypal_button_id; ?>"><input id="paypalbutton" type="image" src="img/addbasketbutton.png"
      border="0" name="submit" alt="PayPal - The safer, easier way to pay online."></td>
    </tr></form>
<?
  }
}
?>
<div id="accessories">
<table align=left border=0 cellpadding=4 cellspacing=0>
<?
  accessoryCategory("A");
  accessoryCategory("C");
?>
</table>
</div>
<?
  include "tpl/bot.php";
?>