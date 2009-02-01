<?php
/* * * * * * * * * * * * * * * * * * * * * * * *
 * Airylea Motors Website
 * Copyright (c) 2008 Frontburner
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * Home Page Context
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  28-Aug-2008  10280 : File created.
 * * * * * * * * * * * * * * * * * * * * * * * */

$title = "Welcome";
include 'tpl/top.php';

global $flash;

showFlash();

?><table border=0 cellpadding=0 cellspacing=0 width="100%">
<tr>
  <td colspan=2 width=700>
    <h1>Welcome to Airylea Motors</h1>
    <p><span class=am>Airylea Motors</span> are specialists in all types of diesel
    fuel injection systems.</p>

    <p>With over 35 years in the business we have the experience to service and repair
    all your diesel fuel systems quickly and efficiently. We deal with both marine and
    commercial vehicle fuel injection systems as well as most other types of industrial
    diesel applications.</p>

    <p>Although we are based in Aberdeen, UK, we do business all over Scotland.</p>

    <p>We stock and can order spare parts for
      <a href="lorange.php">L'Orange</a>,
      <a href="delphi.php">Delphi</a>,
      <a href="bosch.php">Bosch</a>,
      <a href="stanadyne.php">Stanadyne</a> and
      <a href="woodward.php">Woodward</a>.
    </p>

    <p><span class=am>Airylea Motors</span> are the number one choice for all your diesel
    fuel injection supply, service, repair and maintenance needs.</p>
  </td>
</tr>
<tr><td valign=top width=350><table border=0 cellpadding=0 cellspacing=0>
<h2>News</h2>
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

</tr></table>

<?
include 'tpl/bot.php';
?>
