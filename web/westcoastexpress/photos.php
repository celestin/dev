<?php
/* * * * * * * * * * * * * * * * * * * * * * * *
 * West Coast Express Website
 * Copyright (c) 2006-2007 Frontburner
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * Photo Gallery Page Context
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  13-Apr-2006  File created.
 * CAM  21-Dec-2006  10069 : Allow editing of photo details.
 * CAM  15-Feb-2007  10102 : Ensure the default Photo the page opens with can be edited.
 * * * * * * * * * * * * * * * * * * * * * * * */

$title = "Photo Gallery";
include 'tpl/top.php';

$uphoto = NULL;

if (!empty($_POST['photo'])) {

  $uphoto     = $_POST['photo'];
  $uboat      = $_POST['boat'];
  $ulocation  = $_POST['location'];
  $udisporder = $_POST['disporder'];

  $ssql = "UPDATE photos ".
          "SET boat='$uboat', ".
              "location='$ulocation', ".
              "disporder='$udisporder' ".
          "WHERE id='$uphoto'";
  $sql = mysql_query($ssql) or die (mysql_error());
}

if (!empty($_GET['photo'])) $uphoto = $_GET['photo'];

?>

<h3>Photo Gallery</h3>

      <table border=0 cellpadding=0 cellspacing=0 width=780>
<?
      $sql2 = mysql_query("SELECT id,photo,boat,location,disporder ".
                          "FROM photos ".
                          "ORDER BY disporder");
      $phcount=0;
      $phtcount=0;
      $phmax=4;
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
          $uboat = $boat;
          $ulocation = $location;
          $udisporder = $disporder;
          $uphoto = $id;
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
      <tr><td align=top><img width=361 class="bluebox" src="img/ph/f/<? echo $main_pic; ?>"></td><td rowspan=2 align=left valign=top><table border=0 cellpadding=0 cellspacing=0><tr>
<?
      echo $html;
      if ($loggedin && $member->isAdmin()) {
?>
      </tr><tr><td colspan=<? echo $phmax; ?>><center><a href="fileupload.php">Upload a New Photo</a></center></td></tr>
<?
      }
?>
      </table></td></tr>

      <tr><td>
<?
      if ($loggedin && $member->isAdmin()) {
        include 'frm/photo.update.php';
      } else {
        echo "<div style=\"width:360\"><p><b>$uboat</b></p><p>$ulocation</p></div>";
      }
?>

      </td></tr>

      </table>

<?
include 'tpl/bot.php';
?>