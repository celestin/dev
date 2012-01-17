<?php
/* * * * * * * * * * * * * * * * * * * * * * * *
 * WestCoastExpress Website
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
 * CAM  11-Aug-2007  10149 : Added Pagination and Delete option.
 * * * * * * * * * * * * * * * * * * * * * * * */

$title = "Photo Gallery";
include 'tpl/top.php';

showFlash();

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
if (!empty($_GET['page']))  $upage = $_GET['page'];

if (empty($upage)) $upage = 0;

      $phcount=0;
      $phtcount=0;
      $phmax=4;
      $pgmax=$phmax*4;
      $phtotal=0;
      $paged = false;
      $html = "";
      $pageurl = "";
      $main_pic = "_blank.jpg";

      $sql2 = mysql_query("SELECT COUNT(*) photo_count ".
                          "FROM photos ");
      while ($row2 = mysql_fetch_array($sql2)) {
        $phtotal = $row2[0];
      }

      if ($phtotal>$pgmax) {
        $pagestart = 0;
        $thispage = 0;
        $paged = true;

        echo "<table border=0 cellspacing=2 cellpadding=1><tr><td>Page</td>";

        while ($pagestart < $phtotal) {

          if ($thispage==$upage) {
            ?><td class="pageboxsel"><? echo ++$thispage; ?></td><?
          } else {
            ?><td class="pagebox"
                  onclick="top.location.href='photos.php?page=<? echo $thispage++ ?>';"
                  onmouseover="this.className='pageboxhover';"
                  onmouseout="this.className='pagebox';"><? echo $thispage; ?></a></td><?
          }

          $pagestart += $pgmax;
        }
        echo "</tr></table><br>";
      } else {
      }

?>

      <table border=0 cellpadding=0 cellspacing=0 width=780>
<?

      $phsql = "SELECT id,photo,boat,location,disporder ".
               "FROM photos ".
               "ORDER BY disporder ";

      if ($paged) {
        $phsql .= "LIMIT " . ($upage*$pgmax) . "," . $pgmax;
        $pageurl = "&page=$upage";
      }

      $sql2 = mysql_query($phsql);
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
        $html .= "<td class=\"ti\"><a class=\"imgnav$cls\" href=\"photos.php?photo=$id$pageurl\"><img width=80 height=80 src=\"img/ph/t/$photo\"></a></td>\n";
      }

      if ($phcount < $phmax) {
        $html .= "<td colspan=" . ($phmax - $phcount) . ">&nbsp;</td>";
      }

      if ($phtcount < 1) {
        $html = "<td class=\"ti\">&nbsp;</td>";
      }
?>
      <tr>
        <td width=365 valign=top><table border=0 cellpadding=0 cellspacing=0>
          <tr><img width=361 height=271 class="bluebox" src="img/ph/f/<? echo $main_pic; ?>"></td></tr>
          <tr><td>
<?
      if ($loggedin && $member->isAdmin()) {
        include 'frm/photo.update.php';
      } else {
        echo "<div style=\"width:360\"><p><b>$uboat</b></p><p>$ulocation</p></div>";
      }
?>
          </td></tr>

<?
      if ($loggedin && $member->isAdmin()) {
?>
          <tr><td><center>
            <a href="photo.delete.php?photo_id=<? echo $uphoto; ?>">Delete this Photo</a>&nbsp;|&nbsp;
            <a href="photo.upload.php">Upload a New Photo</a></center></td></tr>
<?
      }
?>

        </table></td>
        <td align=left valign=top><table border=0 cellpadding=0 cellspacing=0><tr>
<?
      echo $html;
      if ($loggedin && $member->isAdmin()) {
?>
<?
      }
?>
      </table></td></tr>

      <tr><td>

      </td></tr>

      </table>

<?
include 'tpl/bot.php';
?>