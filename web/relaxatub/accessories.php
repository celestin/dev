<?
/* * * * * * * * * * * * * * * * * * * * * * * *
 * Relaxatub
 * Copyright (c) 2006,2008 Frontburner
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * Accessories page
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  18-Jul-2006  File added to source control.
 * CAM  14-Feb-2008  10243 : Highlight link associated with current page.
 * * * * * * * * * * * * * * * * * * * * * * * */

include_once 'main.php';

$pageId = "pageaccessories";
$pageTitle = "Accessories";
include "tpl/top.php";
?>

<table align=left border=0 cellpadding=4 cellspacing=0 width="100%" height="100%">
<tr><td align=left height="35"><img src="img/tt/accessories.gif" width="115" height="22" alt="Hot Tub Accessories"></td></tr>
<tr><td align=center valign=top><table border=1 cellpadding=4 cellspacing=0>

<?
  function accLink($acc, $html, $photo) {
    if (empty($photo)) {
      return $html;
    }

    return "<a href=\"accessory.php?acc=$acc\">$html</a>";
  }

  $sql = "SELECT acc,accName,photo FROM acc ORDER BY dispOrder";
  $res = mysql_query($sql) or die('<pre>Error in <b>'.$sql.'</b></pre>');

  while ($row = mysql_fetch_array($res)) {
    foreach($row AS $key => $val) {
      $$key = stripslashes($val);
    }

    echo "<tr>";

    if (!empty($photo)) {
      echo "<td align=center>" . accLink($acc, "<img border=0 src=\"./img/ac/t/$photo\">", $photo) . "</td>";
    } else {
      echo "<td>&nbsp;</td>";
    }

    echo "<td>" . accLink($acc, $acc, $photo) . "</td>";
    echo "<td>" . accLink($acc, $accName, $photo) . "</td>";
    echo "</tr>";
  }
?>

</table></td></tr></table>

<?
  include "tpl/bot.php";
?>