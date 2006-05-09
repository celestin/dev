<?php
/* * * * * * * * * * * * * * * * * * * * * * * *
 * Parkers Retreat
 * Copyright (c) 2006 Frontburner
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * Home Page Context
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  11-Apr-2006  File created.
 * * * * * * * * * * * * * * * * * * * * * * * */

include_once 'Main.php';

$utab = NULL;          if (!empty($_GET['tab'])) $utab = $_GET['tab'];
$uroom = NULL;         if (!empty($_GET['room'])) $uroom = $_GET['room'];
if (empty($utab)) $utab = 1;
$title = "";

$sql2 = mysql_query("SELECT tab ".
                    "FROM tabs ".
                    "WHERE id='$utab'");
if ($row2 = mysql_fetch_array($sql2)) {
  foreach($row2 AS $key2 => $val) {
    $$key2 = stripslashes($val);
  }
  $title = $tab;
}
include 'tpl/top.php';

if ($utab == 1) {

  include 'tpl/home.php';

} else if ($utab == 5) {

  include 'tpl/local.php';

} else if ($utab == 6) {

  include 'tpl/parkers.php';

} else if ($utab == 4) {

  include 'tpl/pricing.php';

} else {

  $swf = "downstairs.swf";
  if ($utab == 3) $swf = "upstairs.swf";

  if (empty($uroom)) {
    $sql2 = mysql_query("SELECT MIN(id) uroom ".
                        "FROM rooms ".
                        "WHERE tab='$utab'");
    if ($row2 = mysql_fetch_array($sql2)) {
      foreach($row2 AS $key2 => $val) {
        $$key2 = stripslashes($val);
      }
    }
  }

  $sql2 = mysql_query("SELECT r.short_text, r.long_text, p.imgfile ".
                      "FROM rooms r, photos p ".
                      "WHERE p.room_id=r.id ".
                      "AND r.id='$uroom' ".
                      "AND p.default_flag=1");
  if ($row2 = mysql_fetch_array($sql2)) {
    foreach($row2 AS $key2 => $val) {
      $$key2 = stripslashes($val);
    }
  }

?>

<table border=0 cellspacing=0 cellpadding=2>
  <tr>
    <td align="center" height=20><a href="page.php?&tab=2">Ground floor</a>&nbsp;|&nbsp;<a href="page.php?&tab=3">First floor</a></td>
    <td rowspan=2 valign=top><p><? echo $short_text; ?></p><img width=375 height=200 src="img/room/<? echo $imgfile; ?>"><p><? echo $long_text; ?></p></td>
  </tr>
  <tr>
    <td valign=top><OBJECT classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000"  WIDTH=400 HEIGHT=335
                codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=5,0,0,0">
           <PARAM NAME=movie VALUE="<? echo $swf; ?>">
           <PARAM NAME=loop VALUE=false> <PARAM NAME=quality VALUE=high>
           <PARAM NAME=bgcolor VALUE=#FFFFFF>
           <EMBED src="<? echo $swf; ?>" loop=false quality=high bgcolor=#FFFFFF  WIDTH=400 HEIGHT=335 TYPE="application/x-shockwave-flash"
           PLUGINSPAGE="http://www.macromedia.com/shockwave/download/index.cgi?P1_Prod_Version=ShockwaveFlash"></EMBED>
        </OBJECT></td>
  </tr>
</table>

<?
}

include 'tpl/bot.php';
?>