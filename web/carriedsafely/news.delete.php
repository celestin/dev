<?
/* * * * * * * * * * * * * * * * * * * * * * * *
 * West Coast Express Website
 * Copyright (c) 2007 Frontburner
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * Delete a News Item.
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  11-Aug-2007  10153 : File created.
 * * * * * * * * * * * * * * * * * * * * * * * */

$title = "Delete a News Item";
include_once 'Main.php';

$newsitem_id = NULL;         if (!empty($_GET['newsitem_id'])) $newsitem_id = $_GET['newsitem_id'];
$areyousure = NULL;          if (!empty($_GET['areyousure'])) $areyousure = $_GET['areyousure'];

$ssql = "SELECT id newsitem_id, newsitem, DATE_FORMAT(news_date,'%d %b %Y') news_date_fmt ".
        "FROM newsitems ".
        "WHERE id = '$newsitem_id'";
$sql = mysql_query($ssql) or die (mysql_error());
if ($row = mysql_fetch_array($sql)) {
  foreach($row AS $key => $val) {
    $$key = stripslashes($val);
  }

  $newsdesc = "$news_date_fmt - $newsitem";

} else {
  redirect("index.php");
}

if(!empty($areyousure)){
  $ssql = "DELETE FROM newsitems WHERE id='$newsitem_id'";
  $sql = mysql_query($ssql);
}

include 'tpl/top.php';

if(empty($areyousure)) {
  echo "<center>Are you sure you want to delete <b>$newsdesc</b>?</center><br />";
  echo "<center><a href=news.delete.php?newsitem_id=$newsitem_id&areyousure=yes>Yes</a> | <a href=index.php>No</a>";
} else {
  storeFlash("News Item <b>$newsdesc</b> deleted.");
  redirect("index.php");
}
include 'tpl/bot.php';
?>
