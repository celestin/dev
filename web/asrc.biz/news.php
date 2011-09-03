<?
/* * * * * * * * * * * * * * * * * * * * * * * *
 * ASRC.biz (Aberdeen Squash Racquets Club)
 * Copyright (c) 2006-2007 Frontburner
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  06-Feb-2006  8: File created.
 * CAM  25-Jun-2007  10134 : Order by Date correctly.
 * CAM  22-Oct-2007  10182 : Use new item classes.
 * * * * * * * * * * * * * * * * * * * * * * * */

$title = "News";
include_once 'Main.php';
include 'tpl/top.php';

$spacer = "<br><br>";

?>
<table border=0>
<?

$ssql = "SELECT post_title, post_text, ".
        "DATE_FORMAT(post_date,'%d %b %Y') post_date_fmt ".
        "FROM news ".
        "ORDER BY post_date DESC ";
$sql = mysql_query($ssql) or die (mysql_error());

while ($row = mysql_fetch_array($sql)) {
  foreach($row AS $key => $val) {
    $$key = stripslashes($val);
  }

?>
<tr><td class="item_date" width="100"><? echo $post_date_fmt; ?></td><td class="item_title"><? echo $post_title; ?></td></tr>
<tr><td class="item_text" colspan=2><? echo $post_text . $spacer;  $spacer=""; ?></td></tr>
<?

}

?>
</table>
<?

include 'tpl/bot.php';
?>

