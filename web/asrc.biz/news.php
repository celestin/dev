<?
/* * * * * * * * * * * * * * * * * * * * * * * *
 * News Items
 * Copyright (c) 2004-2006 frontburner.co.uk
 *
 * $Log: /web/asrc.biz/news.php $
 * 
 * 1     6/02/06 23:20 Craig
 * 8
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

