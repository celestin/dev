<?
/* * * * * * * * * * * * * * * * * * * * * * * *
 * Relaxatub
 * Copyright (c) 2006,2010 Frontburner
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * Detailed Accessory page
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  18-Jul-2006  File added to source control.
 * CAM  29-Mar-2010  10620 : Changed to ensure error-free operation, needs more work.
 * CAM  30-Mar-2010  10620 : Tidied page and added Paypal button.
 * * * * * * * * * * * * * * * * * * * * * * * */

include_once 'main.php';

$ptypedescription = "Accessory";

$sql = "SELECT p.pid, p.pcode, p.ptype, p.pdescription, p.paypal_button_id, " .
         "acc.accid, acc.photo, ".
         "FORMAT(acc.price, 2) price ".
       "FROM product p, accessory acc ".
       "WHERE acc.pid=p.pid ".
       "AND acc.accid='". $_GET['accid'] . "'";

$res = mysql_query($sql) or die('<pre>Error in <b>'.$sql.'</b></pre>');

if ($row = mysql_fetch_array($res)) {
  foreach($row AS $key => $val) {
    $$key = stripslashes($val);
  }
  if ($ptype == "C") $ptypedescription = "Aftercare";
}

$pageTitle = "$ptypedescription - $pdescription";
$pageCss = "accessories";
include "tpl/top.php";
?>

<div id="accessory">
<h2><? echo $ptypedescription; ?></h2>
<h3><? echo $pdescription; ?></h3>
<table border=0 cellpadding=4 cellspacing=0>
  <tr><td colspan=2 align=center><img height=300 src="./img/ac/f/<? echo $photo ?>"></td></tr>
  <tr><td width="200" id="lbl">Code</td><td width="200" id="val"><? echo $pcode ?></td></tr>
  <tr><td id="lbl">Price</td><td id="val">&pound;<? echo $price; ?></td></tr>

  <tr><form action="https://www.paypal.com/cgi-bin/webscr" method="post">
    <td colspan=2 align=center><input type="hidden" name="cmd" value="_s-xclick"><input type="hidden" name="hosted_button_id"
      value="<? echo $paypal_button_id; ?>"><input id="paypalbutton" type="image" src="img/addbasketbutton.png"
      border="0" name="submit" alt="PayPal - The safer, easier way to pay online.">
    </td>
  </tr></form>

  <tr><td colspan=2 align=center><a href="accessories.php">Back to Accessories</a></td></tr>
</table>
</div>

<?
  include "tpl/bot.php";
?>