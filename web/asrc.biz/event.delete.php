<?
/* * * * * * * * * * * * * * * * * * * * * * * *
 * ASRC.biz (Aberdeen Squash Racquets Club)
 * Copyright (c) 2006-2007 Frontburner
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  23-Oct-2007  10182 : File created.
 * * * * * * * * * * * * * * * * * * * * * * * */

$title = "Delete a Event";
include_once 'Main.php';

$event_id = NULL;         if (!empty($_GET['event_id'])) $event_id = $_GET['event_id'];
$areyousure = NULL;          if (!empty($_GET['areyousure'])) $areyousure = $_GET['areyousure'];

$ssql = "SELECT id event_id, event_title, DATE_FORMAT(event_date,'%d %b %Y') event_date_fmt ".
        "FROM event ".
        "WHERE id = '$event_id'";
$sql = mysql_query($ssql) or die (mysql_error());
if ($row = mysql_fetch_array($sql)) {
  foreach($row AS $key => $val) {
    $$key = stripslashes($val);
  }

  $newsdesc = "$event_date_fmt - $event_title";

} else {
  redirect("events.php");
}

if(!empty($areyousure)){
  $ssql = "DELETE FROM event WHERE id='$event_id'";
  $sql = mysql_query($ssql);
}

include 'tpl/top.php';

if(empty($areyousure)) {
  Msg::question("Are you sure you want to delete <b>$newsdesc</b>");

  echo "<center><a href=event.delete.php?event_id=$event_id&areyousure=yes>Yes</a> | <a href=news.php>No</a>";
} else {
  storeFlash("Event <b>$newsdesc</b> deleted.");
  redirect("events.php");
}
include 'tpl/bot.php';
?>
