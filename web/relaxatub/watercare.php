<?
/* * * * * * * * * * * * * * * * * * * * * * * *
 * Relaxatub
 * Copyright (c) 2008,2010 Frontburner
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * Water Care Page
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  20-Aug-2008  10113 : File created.
 * CAM  01-Apr-2010  10628 : Added 'Add to basket' button for Aqua Finesse.
 * * * * * * * * * * * * * * * * * * * * * * * */

$pageId = "watercare";
$pageTitle = "Water Care";
include "tpl/top.php";
?>

<table align=center border=0 cellpadding=4 cellspacing=0 width="95%" height="100%">
<tr><td align=center valign=top><table border=0 cellpadding=4 cellspacing=0>
<tr>
  <td>
    <img class="centerheader" src="img/af/logolarge.png" alt="Aqua Finesse"/>

    <h3>AquaFinesse&reg; is a revolutionary patented hottub watercare formula.
    It is easy to use, chlorine-free, and will keep your hottub water pure and clean.</h3>

    <p class="desc">AquaFinesse&reg; is a patented water care solution
    that allows users to enjoy their hot tubs without the harsh effects of chemicals. Everything you need
    to experience clean, soft, crystal clear water is in one convenient
    carrying case.  We take the guesswork out of hot tub water care in one easy step per week!
    You and your family will soak in the most luxurious water without the time and hassle
    of measuring multiple chemicals.</p>

  <p class="desc"><img src="img/af/large.png" alt="Elmswood Timber Decking - Aberdeen"
    style="float:left;padding:0px 5px 0px 0px; margin: 0px;"/>Simply add the solution once a week as directed and that's it!
  No more balancing pH levels, adjusting alkalinity, slimy surfaces, water lines or foaming problems.
  AquaFinesse&reg; saves you time AND money by eliminating the need for additional water care products.
  We mean it when we say that AquaFinesse&reg; is the TRUE One-Step Solution to Hot Tub Water Care. &nbsp;</p>

  <table border=0 cellpadding=0 cellspacing=0>
  <tr>

    <td>
      <p class="desc">Not only do we make hot tub water care easy, we also make it enjoyable.
        You will immediately notice the softness and light lavender scent that AquaFinesse&reg; adds to the water.
        Unlike conventional spa cleaners, AquaFinesse&reg; doesn't irritate your skin and eyes or damage your hair and swimwear.
        With AquaFinesse&reg;, you can truly sit back, relax and enjoy soft odor-free water like nature intended.</p>
    </td>
<?
  $sql = "SELECT p.pid, p.pcode, p.ptype, p.pdescription, p.paypal_button_id, " .
           "acc.accid, acc.photo, ".
           "FORMAT(acc.price, 2) price ".
         "FROM product p, accessory acc ".
         "WHERE acc.pid=p.pid ".
         "AND acc.pid='1018'";

  $res = mysql_query($sql) or die('<pre>Error in <b>'.$sql.'</b></pre>');

  if ($row = mysql_fetch_array($res)) {
    foreach($row AS $key => $val) {
      $$key = stripslashes($val);
    }
    if ($ptype == "C") $ptypedescription = "Aftercare";
  }
  ?>
    <td>
      <table border=0 cellpadding=4 cellspacing=0>
        <tr><td width="200" id="lbl">Code</td><td width="200" id="val"><? echo $pcode ?></td></tr>
        <tr><td id="lbl">Price</td><td id="val">&pound;<? echo $price; ?></td></tr>

        <tr><form action="https://www.paypal.com/cgi-bin/webscr" method="post">
          <td colspan=2 align=center><input type="hidden" name="cmd" value="_s-xclick"><input type="hidden" name="hosted_button_id"
            value="<? echo $paypal_button_id; ?>"><input id="paypalbutton" type="image" src="img/addbasketbutton.png"
            border="0" name="submit" alt="PayPal - The safer, easier way to pay online.">
          </td>
        </tr></form>
      </table>
    </td>
  </tr>
  </table>
  </td>
</tr>
</table></td></tr></table>

<?
  include "tpl/bot.php";
?>