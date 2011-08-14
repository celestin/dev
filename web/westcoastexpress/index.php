<?php
/* * * * * * * * * * * * * * * * * * * * * * * *
 * WestCoastExpress Website
 * Copyright (c) 2006 Frontburner
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * Home Page Context
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  13-Apr-2006  File created.
 * CAM  11-Aug-2007  10153 : Added News Items.
 * * * * * * * * * * * * * * * * * * * * * * * */

$title = "Boat Transport";
include 'tpl/top.php';

global $flash;

showFlash();

?><table border=0 cellpadding=0 cellspacing=0 width="100%">
<tr>
  <td colspan=2 width=700>
    <h3>No. 1 for Boat Transport in Scotland</h3>

    <p>We pride ourselves in taking personal care of all
    boats we transport whether it is a small dingy or a
    luxury cabin cruiser. Routes from pick up to
    destination are carefully chosen to minimise any risk
    or damage. We can launch or retrieve where possible
    without any fuss, we get on with it and get the job done
    to all our customers satisfaction.</p>
  </td>
</tr>
<tr><td valign=top width=350><table border=0 cellpadding=0 cellspacing=8>
<?

$ssql = "SELECT id newsitem_id, newsitem, news_text, ".
        "DATE_FORMAT(news_date,'%d %b %Y') news_date_fmt ".
        "FROM newsitems ".
        "ORDER BY news_date DESC ";
$sql = mysql_query($ssql) or die (mysql_error());
$counter=0;
$style = "";

while ($row = mysql_fetch_array($sql)) {
  foreach($row AS $key => $val) {
    $$key = stripslashes($val);
  }
  $style = "";
  if ($counter++ > 0) {
    $style = "style=\"padding-top:20px\"";
  } else {
?>
  <tr><td align=left><img src="img/title/news.png"></td></tr>
<?
  }
?>
<tr>
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
</table></td>

<td valign="top"><table border=0 cellpadding=5 align=center>
  <tr><td><img src="img/boat2.png"></td></tr>
  <tr><td><img src="img/boatsafe3.png"></td></tr>
</table></td></tr></table>

<?
include 'tpl/bot.php';
?>
