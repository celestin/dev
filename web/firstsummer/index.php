<?php
/* * * * * * * * * * * * * * * * * * * * * * * *
 * First Summerhouses
 * Copyright (c) 2006 Frontburner
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * Home Page Context
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  10-Feb-2006  File created.
 * CAM  08-Apr-2006  Added newsitems.
 * * * * * * * * * * * * * * * * * * * * * * * */

$title = "Home";
include 'tpl/top.php';
?>
<table border=0 cellpadding=5 cellspacing=0>
<?

$ssql = "SELECT newsitem, news_text, ".
        "DATE_FORMAT(news_date,'%d %b %Y') news_date_fmt, news_img ".
        "FROM newsitems ".
        "ORDER BY news_date DESC ";
$sql = mysql_query($ssql) or die (mysql_error());
$counter=0;

while ($row = mysql_fetch_array($sql)) {
  foreach($row AS $key => $val) {
    $$key = stripslashes($val);
  }
  if ($counter++ > 0) {
?>
<tr><td colspan=3>&nbsp;</td></tr>
<?
  }
?>
<tr>
<?
  if (empty($news_img)) {
    $sql2 = mysql_query("SELECT id,imgfile FROM photos ORDER BY rand() LIMIT 1");
    if ($row2 = mysql_fetch_array($sql2)) {
      foreach($row2 AS $key2 => $val) {
        $$key2 = stripslashes($val);
      }
      $news_img = "g/t/$imgfile";
    }
  }
?>
<td rowspan=2><img align=right src="img/<? echo $news_img; ?>"></td>
<td width="100"><b><? echo $news_date_fmt; ?></b></td><td><b><? echo $newsitem; ?></b></td></tr>
<tr><td colspan=2><? echo $news_text; ?></td></tr>
<?
}
?>
<tr height="280" valign=bottom><td colspan=3 align=center>
<?
include 'tpl/cards.php';
?>
</td></tr>
</table>
<?
include 'tpl/bot.php';
?>