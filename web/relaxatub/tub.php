<?
/* * * * * * * * * * * * * * * * * * * * * * * *
 * Relaxatub
 * Copyright (c) 2006,2010 Frontburner
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * Tub Page
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  18-Jul-2006  File added to source control.
 * CAM  24-Sep-2006  10020 : Display colours and wood finishes of tubs.
 * CAM  14-Feb-2008  10243 : Highlight link associated with current page.
 * CAM  22-Mar-2008  10258 : Added no_people and corrected dimen.
 * CAM  12-Apr-2008  10241 : Changed to short, bold details.
 * CAM  12-Mar-2010  10605 : Reference use Tub accessors for Colour/Wood.
 * CAM  29-Mar-2010  10621 : Added Quickships (if available).
 * * * * * * * * * * * * * * * * * * * * * * * */

  include_once 'main.php';

  $_series = '';
  $_tub = '';

  $param = 'series';
  if (!empty($HTTP_POST_VARS[$param]) || !empty($HTTP_GET_VARS[$param])) {
    $_series = (!empty($HTTP_POST_VARS[$param])) ? $HTTP_POST_VARS[$param] : $HTTP_GET_VARS[$param];
  }

  $param = 'tub';
  if (!empty($HTTP_POST_VARS[$param]) || !empty($HTTP_GET_VARS[$param])) {
    $_tub = (!empty($HTTP_POST_VARS[$param])) ? $HTTP_POST_VARS[$param] : $HTTP_GET_VARS[$param];
  }

  $_tub = getTub($_tub, $_series);
  $_t = new Tub($_tub);
  $_seriesObj = getSeries($_tub);

  $pageId = "pagetub" . $_seriesObj->getID();
  $pageTitle = $_seriesObj->getDesc();
  include "tpl/top.php";
?>

<div id="tub">
<table align=left valign=top border=0 cellpadding=0 cellspacing=0><tr>

  <td width="150" valign=top class="tubnav"><table border=0 cellpadding=4 cellspacing=0>
    <tr><td colspan=2 align=center class="series"><? print $_seriesObj->getDesc(); ?></td></tr>
<?
    $sql = "SELECT * FROM tub WHERE series = " .$_seriesObj->getID() . " AND disabled=0 ORDER BY tub";
    $res = mysql_query($sql) or die('<pre>Error in <b>'.$sql.'</b></pre>');

    while ($row = mysql_fetch_array($res)) {
      foreach($row AS $key => $val) {
        $$key = stripslashes($val);
      }

      $currTub = new Tub($tub, $series);
      $href = "<a href=\"tub.php?tub=" . $tub . "\">";

      if ($tub == $_tub) {
        $td = "<td class=\"tubsel\">";
      } else {
        $td = "<td>";
      }

      print "<tr>$td$href". $currTub->id ."</a></td>";
      print "$td$href<img height=60 border=0 src=\"" . $currTub->imgFile("t") . "\" alt=\"Beachcomber " . $currTub->id . "\"></a></td></tr>\n";
    }
?>
  </table></td>

  <td align=center width="100%"><table border=0 cellpadding=3 cellspacing=0>
    <tr>
      <td colspan="2" class="tubvalue" align=center><? print $_t->dimen ?><span class="tubunits">cm</span></td>
      <td colspan="2" class="tubvalue" align=right>
        <table border="0" cellpadding="0" cellspacing="0">
          <tr>
            <td class="tubname"><? print $_t->id; ?></td>
            <td align=center valign=center><a name="fb_share" type="button_count" href="http://www.facebook.com/sharer.php">Share</a><script src="http://static.ak.fbcdn.net/connect.php/js/FB.Share" type="text/javascript"></script></td>
          </tr>
        </table>
      </td>
    </tr>
    <tr>
      <td class="fldlbl" width="120">No. of People</td><td class="tubvalue" width="110"><? print $_t->no_people ?></td>
      <td rowspan=7 align=right><table
        border=0 width=270 cellspacing=0 cellpadding=0>
        <tr><td colspan=2 align=center><img height=200 src="<? print $_t->imgFile("fa"); ?>" alt="Isometric view of <? echo $_t->id; ?>"></td></tr>
        <tr>
          <td align=center><img src="img/col/<? print $_t->getColourFile(); ?>"></td>
          <td align=center><img src="img/col/<? print $_t->getWoodFile(); ?>"></td>
        </tr>
        </table>
      </td>
    </tr>

    <tr><td class="fldlbl">Water Capacity</td><td class="tubvalue"><? print $_t->capacity ?><span class="tubunits">L</span></td></tr>
    <tr><td class="fldlbl">Dry Weight</td><td class="tubvalue"><? print $_t->dry_weight ?><span class="tubunits">kg</span></td></tr>
    <tr><td class="fldlbl">Filled Weight</td><td class="tubvalue"><? print $_t->fill_weight ?><span class="tubunits">kg</span></td></tr>
    <tr><td class="fldlbl">Massaging Pumps</td><td class="tubvalue"><? print $_t->pumps ?><span class="tubunits">hp</span></td></tr>
    <tr><td class="fldlbl">Water Ports System</td><td class="tubvalue"><? print $_t->ports ?></td></tr>
    <tr><td class="fldlbl">Customised Jetting</td><td colspan=2 class="tubvalue"><? print $_t->custom ?></td></tr>

<?
  $idRow = "";
  $priceRrpRow = "";
  $depositRow = "";
  $coloursRow = "";
  $buttonRow = "";
  $found = false;

  $sql = "SELECT p.pid, p.pcode, p.pdescription, p.paypal_button_id, " .
           "qs.qsid, qs.qscode, qs.acrylic_colour, qs.cabinet_colour, qs.heatshield_colour, ".
           "qs.seats, qs.tub, qs.tubtype, ".
           "FORMAT(qs.price_rrp, 0) price_rrp, ".
           "FORMAT(qs.deposit, 0) deposit ".
         "FROM product p, quickship qs ".
         "WHERE qs.pid = p.pid ".
         "AND qs.tub= '" . $_t->id . "' ".
         "ORDER BY p.pcode";

  $res = mysql_query($sql) or die('<pre>Error in <b>'.$sql.'</b></pre>');

  while ($row = mysql_fetch_array($res)) {
    foreach($row AS $key => $val) {
      $$key = stripslashes($val);
    }

    $tidytype = "Portable";
    if ($tubtype == "BHE") $tidytype = "Hybrid";

    if (!empty($idRow)) {
      $idRow .= "<td rowspan=5><img src=\"img/f.gif\" width=20></td>";
    }

    $idRow .= "<td id=\"id\" colspan=2>$qscode $tidytype</td>";
    $priceRrpRow .= "<td>Price</td><td id=\"price\">&pound;" . $price_rrp . "</td>";
    $depositRow .= "<td>Deposit</td><td id=\"price\">&pound;" . $deposit . "</td>";
    $coloursRow .= "<td><img width=\"60\" src=\"img/col/" . $acrylic_colour . ".png\"></td>".
                   "<td><img width=\"60\" src=\"img/col/" . $cabinet_colour . ".png\"></td>";
    $buttonRow .= "<form action=\"https://www.paypal.com/cgi-bin/webscr\" method=\"post\">".
      "<td colspan=2><input type=\"hidden\" name=\"cmd\" value=\"_s-xclick\"><input type=\"hidden\" name=\"hosted_button_id\" ".
      "value=\"" . $paypal_button_id . "\"><input id=\"paypalbutton\" type=\"image\" src=\"img/paydepositnowbutton.png\" ".
      "border=\"0\" name=\"submit\" alt=\"PayPal - The safer, easier way to pay online.\"></td></form>";
  }


  if (!empty($idRow)) {
?>
    <tr><td colspan=3 align=center>
      <div id="prices">
        <h2>available to quickship</h2>
        <table cellpadding=0 cellspacing=4 border=0>
          <tr><? echo $idRow; ?></tr>
          <tr><? echo $priceRrpRow; ?></tr>
          <tr><? echo $depositRow; ?></tr>
          <tr><? echo $coloursRow; ?></tr>
          <tr><? echo $buttonRow; ?></tr>
        </table>
      </div>
    </td></tr>
<?
  }
?>
    <tr><td colspan="3" align=center valign=top><img width="500" src="<? print $_t->imgFile("fb"); ?>" alt="Plan view of <? echo $_t->id; ?>"></td></tr>
<?
  if ($_t->hasQuote1()) {
    print "<tr><td colspan=\"3\">" . $_t->getQuote1() . "</td></tr>";
  }
  if ($_t->hasQuote2()) {
    print "<tr><td colspan=\"3\">" . $_t->getQuote2() . "</td></tr>";
  }
?>
  </table></td>

</tr></table>
</div>
<?
  include "tpl/bot.php";
?>