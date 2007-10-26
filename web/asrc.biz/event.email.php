<?
/* * * * * * * * * * * * * * * * * * * * * * * *
 * ASRC.biz (Aberdeen Squash Racquets Club)
 * Copyright (c) 2006-2007 Frontburner
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  26-Oct-2007  10195 : File created.
 * * * * * * * * * * * * * * * * * * * * * * * */

$title = "Email Event";
include_once 'Main.php';

$event_id = NULL;         if (!empty($_GET['event_id'])) $event_id = $_GET['event_id'];
$areyousure = NULL;       if (!empty($_GET['areyousure'])) $areyousure = $_GET['areyousure'];
$rows = 0;

$ssql = "SELECT id event_id, event_title, email_count, DATE_FORMAT(event_date,'%d %b %Y') event_date_fmt ".
        "FROM event ".
        "WHERE id = '$event_id'";
$sql = mysql_query($ssql) or die (mysql_error());
if ($row = mysql_fetch_array($sql)) {
  foreach($row AS $key => $val) {
    $$key = stripslashes($val);
  }

  $eventdesc = "$event_title";

} else {
  redirect("events.php");
}

if(!empty($areyousure)){
  $ssql = "UPDATE event SET email_count = ($email_count+1) WHERE id='$event_id'";
  $sql = mysql_query($ssql);

  $ssql = "INSERT INTO queue (item_type, item_id, memberid) ".
          "SELECT 'EVENT', '$event_id', memberid ".
          "FROM member ".
          "WHERE email_address IS NOT NULL ".
          "AND length(email_address) > 0 ".
          "AND member_type <> 'A' ".
          "AND email_address <> 'info@asrc.co.uk' ";
  $sql = mysql_query($ssql);
  $rows = mysql_affected_rows();
}

include 'tpl/top.php';

if (!($loggedin && $member->isAdmin())) {
  redirect("login.php");
}

if(empty($areyousure)) {
  Msg::question("Are you sure you want to email <b>$eventdesc</b>");

  echo "<center><a href=event.email.php?event_id=$event_id&areyousure=yes>Yes</a> | <a href=events.php>No</a>";
} else {
  storeFlash("Event <b>$eventdesc</b> added to email queue for $rows members.");
  redirect("events.php");
}
include 'tpl/bot.php';
?>
