<?php
/* * * * * * * * * * * * * * * * * * * * * * * *
 * TowingDirect Website
 * Copyright (c) 2012 Front Burner
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * Home Page Context
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  17-Jan-2012  11077 : Changed Car logo.
 * CAM  01-Feb-2012  11083 : Text added.
 * * * * * * * * * * * * * * * * * * * * * * * */

$title = "Car Transport";
include 'tpl/top.php';

global $flash;

showFlash();

?><table border=0 cellpadding=0 cellspacing=0 width="100%">
<tr>
  <td colspan=2 width=700>
    <h3>Car Transport in Scotland and the UK</h3>

    <p>We know how much your Classic Car means to you therefore we will give you peace of mind that your pride and joy is in 'safe hands'.</p>
		<p>We will ensure your Vehicle Collection, Transportation and Delivery will be handled personally by an experienced driver.</p>
		<p>It will be loaded and transported in one operation, no change of vehicle or driver.</p>
		<p>The journey is exclusive to you, so we can be flexible on times etc (we do not operate back load deals).</p>
		<p>All our prices are complete.</p>
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
  <tr><td><img src="img/cartrans1.png"></td></tr>
  <tr><td><img src="img/boatsafe3.png"></td></tr>
</table></td></tr></table>

<?
include 'tpl/bot.php';
?>
