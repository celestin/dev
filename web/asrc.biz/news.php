<?
/* * * * * * * * * * * * * * * * * * * * * * * *
 * ASRC.biz (Aberdeen Squash Racquets Club)
 *
 * Copyright (c) 2006 Frontburner
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * News Items
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  06-Feb-2006  8: File created.
 * * * * * * * * * * * * * * * * * * * * * * * */

$title = "Aberdeen Squash Racquets Club - News";
include_once 'Main.php';
include 'tpl/top.php';

?>
<table border=0>
<?

$ssql = "SELECT post_title, post_text, ".
        "DATE_FORMAT(post_date,'%d %b %Y') post_date ".
        "FROM news ".
        "ORDER BY post_date DESC ";
$sql = mysql_query($ssql) or die (mysql_error());

while ($row = mysql_fetch_array($sql)) {
  foreach($row AS $key => $val) {
    $$key = stripslashes($val);
  }

?>
<tr><td width="100"><b><? echo $post_date; ?></b></td><td><b><? echo $post_title; ?></b></td></tr>
<tr><td colspan=2><? echo $post_text; ?></td></tr>
<?

}

?>
</table>
<?

include 'tpl/bot.php';
?>

