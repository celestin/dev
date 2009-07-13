<?php
/* * * * * * * * * * * * * * * * * * * * * * * *
 * Dunc Smith Glasscraft
 * Copyright (c) 2009 Dunc Smith
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  13-Jul-2009  10459 : Added new images and file headers.
 * * * * * * * * * * * * * * * * * * * * * * * */
?>

<table border=0>

<?

  $ssql = "SELECT url, title, linkdesc ".
          "FROM link ".
          "ORDER BY title";
  $sql = mysql_query($ssql) or die (mysql_error() . " " . $ssql);
  $i=0;

  while ($row = mysql_fetch_array($sql)) {
    foreach($row AS $key => $val) {
      $$key = stripslashes($val);
    }
?>
  <tr><td><a href="<? echo $url; ?>"><? echo $title; ?></a></td></tr>
  <tr><td><? echo $linkdesc; ?></td></tr>
<?
  }
?>
</table>