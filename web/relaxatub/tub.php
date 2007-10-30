<?
/* * * * * * * * * * * * * * * * * * * * * * * *
 * Relaxatub
 * Copyright (c) 2006 Frontburner
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * Tub Page
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  18-Jul-2006  File added to source control.
 * CAM  24-Sep-2006  10020 : Display colours and wood finishes of tubs.
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

  $pageTitle = $_seriesObj->getDesc();
  include "tpl/top.php";
?>

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
    <tr><td width=120>&nbsp;</td><td width=110>&nbsp;</td><td width=270 class="tubname"><? print $_t->id; ?></td></tr>
    <tr>
      <td class="fldlbl">Dimensions</td><td class="fldtxt"><? print $dimen ?></td>
      <td rowspan=8 align=right>
      <table border=0 width=270 cellspacing=0 cellpadding=0>
      <tr><td colspan=2 align=center><img height=200 src="<? print $_t->imgFile("fa"); ?>" alt="Isometric view of <? echo $_t->id; ?>"></td></tr>
      <tr>
        <td align=center><img src="img/col/<? print $_t->colour; ?>"></td>
        <td align=center><img src="img/col/<? print $_t->wood; ?>"></td>
      </tr>
      </table>
      </td>
    </tr>
    <tr><td class="fldlbl">Water Capacity</td><td class="fldtxt"><? print $_t->capacity ?></td></tr>
    <tr><td class="fldlbl">Dry Weight</td><td class="fldtxt"><? print $_t->dry_weight ?></td></tr>
    <tr><td class="fldlbl">Filled Weight</td><td class="fldtxt"><? print $_t->fill_weight ?></td></tr>
    <tr><td class="fldlbl">Massaging Pumps</td><td class="fldtxt"><? print $_t->pumps ?></td></tr>
    <tr><td class="fldlbl">Heatshield Cover</td><td class="fldtxt"><? print $_t->shield ?></td></tr>
    <tr><td class="fldlbl">Safety Approval</td><td class="fldtxt"><? print $_t->safety ?></td></tr>

    <tr><td class="fldlbl">Water Ports System</td><td class="fldtxt"><? print $_t->ports ?></td></tr>
    <tr><td class="fldlbl">Customised Jetting</td><td colspan=2 class="fldtxt"><? print $_t->custom ?></td></tr>
    <tr><td class="fldlbl">Microfilter Filtration</td><td colspan=2 class="fldtxt"><? print $_t->filter ?></td></tr>
    <tr><td class="fldlbl">Automatic Controls</td><td colspan=2 class="fldtxt"><? print $_t->auto ?></td></tr>
    <tr><td class="fldlbl">Underwater Lighting</td><td colspan=2 class="fldtxt"><? print $_t->light ?></td></tr>
    <tr><td class="fldlbl">Customer Protection</td><td colspan=2 class="fldtxt"><? print $_t->protect ?></td></tr>

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

<?
  include "tpl/bot.php";
?>