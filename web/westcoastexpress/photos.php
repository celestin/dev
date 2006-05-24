<?php
/* * * * * * * * * * * * * * * * * * * * * * * *
 * West Coast Express Website
 * Copyright (c) 2006 Frontburner
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * Photo Gallery Page Context
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  13-Apr-2006  File created.
 * * * * * * * * * * * * * * * * * * * * * * * */

$title = "Photo Gallery";
include 'tpl/top.php';

$uphoto = NULL;        if (!empty($_GET['photo'])) $uphoto = $_GET['photo'];
?>

<h3>Photo Gallery</h3>

      <table border=0 cellpadding=4 cellspacing=0>
<?
      $sql2 = mysql_query("SELECT id,photo ".
                          "FROM photos ".
                          "ORDER BY disporder");
      $phcount=0;
      $phtcount=0;
      $phmax=5;
      $html = "";
      $main_pic = "_blank.jpg";
      while ($row2 = mysql_fetch_array($sql2)) {
        foreach($row2 AS $key2 => $val) {
          $$key2 = stripslashes($val);
        }

        $cls = "";
        if (($uphoto == $id) || ((empty($uphoto) && $phcount == 0))) {
          $main_pic = "$photo";
          $cls = "sel";
        }

        $phcount++;
        $phtcount++;
        if ($phcount > $phmax) {
          $html .= "</tr><tr>";
          $phcount = 1;
        }
        $html .= "<td class=\"ti\"><a class=\"itemnav$cls\" href=\"photos.php?photo=$id\"><img width=80 height=80 src=\"img/ph/t/$photo\"></a></td>\n";
      }

      if ($phcount < $phmax) {
        $html .= "<td colspan=" . ($phmax - $phcount) . ">&nbsp;</td>";
      }

      if ($phtcount < 2) {
        $html = "<td class=\"ti\">&nbsp;</td>";
      }
?>
      <tr><td align=top><img width=361 height=250 src="img/ph/f/<? echo $main_pic; ?>"></td><td align=left valign=top><table border=0 cellpadding=4 cellspacing=0><tr>
<?
      echo $html;
?>
      </tr></table></td></tr></table>



<?
include 'tpl/bot.php';
?>