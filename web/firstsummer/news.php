<?php
/* * * * * * * * * * * * * * * * * * * * * * * *
 * First Summerhouses
 * Copyright (c) 2006 Frontburner
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * News Archive
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  06-Oct-2006  10040 : File created.
 * * * * * * * * * * * * * * * * * * * * * * * */

$title = "News Archive";
include 'tpl/top.php';

global $flash;

showFlash();

?><table border=0 cellpadding=0 cellspacing=0 width="100%">
<?

$ssql = "SELECT id newsitem_id, newsitem, news_text, ".
        "DATE_FORMAT(news_date,'%d %b %Y') news_date_fmt, news_img ".
        "FROM newsitems ".
        "ORDER BY news_date DESC ";
$sql = mysql_query($ssql) or die (mysql_error());
$counter=0;

while ($row = mysql_fetch_array($sql)) {
  foreach($row AS $key => $val) {
    $$key = stripslashes($val);
  }
  $style = "";
  if ($counter++ > 0) {
    $style = "style=\"padding-top:20px\"";
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
<td <? echo $style; ?>><table border=0 cellpadding=0 cellspacing=0>
  <tr>
    <td><b><? echo $news_date_fmt; ?></b>&nbsp;-&nbsp;<b><? echo $newsitem; ?></b>
<?
if ($loggedin && $member->isAdmin()) {
?>
    <td><a href="news.edit.php?newsitem_id=<? echo $newsitem_id; ?>"><img border=0 class="sep" src="img/edit/edit.png"></a></td>
    <td><a href="news.delete.php?newsitem_id=<? echo $newsitem_id; ?>"><img border=0 class="sep" src="img/edit/delete.png"></a></td>
<?
}
?>
  </tr>
</table></td></tr>
</td></tr>
<td><? echo $news_text; ?></td></tr>
<?
}
?>
</td></tr>
<?
if ($loggedin && $member->isAdmin()) {
?>
<tr><td <? echo $style; ?> align="center"><table border=0 cellpadding=0 cellspacing=0>
  <tr>
    <td><a href="news.add.php"><img border=0 class="sep" src="img/edit/add.png"></a></td>
    <td><a href="news.add.php">Add a News Item</a></td>
  </tr>
</table></td></tr>
<?
}
?>
</table>
<?
include 'tpl/bot.php';
?>