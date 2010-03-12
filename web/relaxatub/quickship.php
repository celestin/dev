<?
/* * * * * * * * * * * * * * * * * * * * * * * *
 * Relaxatub
 * Copyright (c) 2008,2010 Frontburner
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * Quick Ship
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  08-Nov-2008  10237 : File created.
 * CAM  11-Aug-2009  10471 : Updated Quick Ship for 2009.
 * CAM  08-Mar-2010  10587 : Updated Quick Ship for 2010.
 * CAM  12-Mar-2010  10605 : Moved colours to common folder.
 * CAM  12-Mar-2010  10604 : Build from database, include Pay Deposit Now.
 * * * * * * * * * * * * * * * * * * * * * * * */

$pageId = "pagequickship";
$pageTitle = "Quick Ship";
include "tpl/top.php";
?>
<div id="quickship">

<p>These products can all be shipped quickly - call us for more information 01224 870 959!</p>

<table border=0 cellpadding=0 cellspacing=0 align=center width="100%">

<tr>
  <th>Model</th>
  <th>Acrylic<br />Colour</th>
  <th>Cabinet<br />Colour</th>
  <th>Seats</th>
  <th>Details</th>
  <th>Price </th>
</tr>

<?
    $sql = "SELECT p.pid, p.pcode, p.pdescription, p.paypal_button_id, " .
             "qs.qsid, qs.qscode, qs.acrylic_colour, qs.cabinet_colour, qs.heatshield_colour, ".
             "qs.seats, qs.tub, qs.tubtype, ".
             "FORMAT(qs.price_rrp, 0) price_rrp, ".
             "FORMAT(qs.deposit, 0) deposit ".
           "FROM product p, quickship qs ".
           "WHERE qs.pid = p.pid ".
           "ORDER BY p.pcode";

    $res = mysql_query($sql) or die('<pre>Error in <b>'.$sql.'</b></pre>');

    while ($row = mysql_fetch_array($res)) {
      foreach($row AS $key => $val) {
        $$key = stripslashes($val);
      }

      $tidytype = "Portable";
      if ($tubtype == "BHE") $tidytype = "Hybrid";
?>
<tr>
  <td><? echo $qscode; ?><br /><span id="tubtype"><? echo $tidytype; ?></span></td>
  <td><img src="img/col/<? echo $acrylic_colour; ?>.png"></td>
  <td><img src="img/col/<? echo $cabinet_colour; ?>.png"></td>
  <td><span id="seats"><? echo $seats; ?></span></td>
  <td><a href="tub.php?tub=<? echo $tub; ?>"><img border=0 src="img/tub/fa/<? echo $tub; ?>.jpg" height="84"></a></td>
  <td>
    <ul id="prices">
      <li>Price&nbsp;<span id="price">&pound;<? echo $price_rrp; ?></span></li>
      <li>Deposit&nbsp;<span id="price">&pound;<? echo $deposit; ?></span></li>
    </ul>
    <form action="https://www.paypal.com/cgi-bin/webscr" method="post">
      <input type="hidden" name="cmd" value="_s-xclick">
      <input type="hidden" name="hosted_button_id" value="<? echo $paypal_button_id; ?>">
      <input id="paypalbutton" type="image" src="img/paydepositnowbutton.png" border="0" name="submit" alt="PayPal - The safer, easier way to pay online.">
    </form>
  </td>
</tr>
<?
    }
?>

</table>
</div>
<?
  include "tpl/bot.php";
?>