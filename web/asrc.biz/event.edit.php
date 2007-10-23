<?
/* * * * * * * * * * * * * * * * * * * * * * * *
 * ASRC.biz (Aberdeen Squash Racquets Club)
 * Copyright (c) 2006-2007 Frontburner
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  06-Oct-2006  10040 : File created.
 * * * * * * * * * * * * * * * * * * * * * * * */

$title = "Edit Event";
include_once 'Main.php';
include 'tpl/top.php';

function retry_create($error="") {
  global $event_id, $event_date, $event_title, $event_text, $retry, $form_action, $form_button;
  if (!empty($error)) Msg::error($error);
  include 'frm/event.edit.php';
  include 'tpl/bot.php';
  exit();
}

$event_id = NULL;      if (!empty($_GET['event_id'])) $event_id = $_GET['event_id'];

$event_date = NULL;
$event_title = NULL;
$event_text = NULL;
$retry = NULL;

if (!empty($event_id)) {
  // Must be the initial Edit - retrieve details
  $ssql = "SELECT id event_id, event_title, DATE_FORMAT(event_date,'%d-%b-%Y') event_date, event_text ".
          "FROM event ".
          "WHERE id = '$event_id'";
  $sql = mysql_query($ssql) or die (mysql_error());
  if ($row = mysql_fetch_array($sql)) {
    foreach($row AS $key => $val) {
      $$key = stripslashes($val);
    }
  } else {
    redirect("news.php");
  }
} else {
  // Must be after an Edit - used edited details
  if (!empty($_POST['event_id'])) $event_id = $_POST['event_id'];
  if (!empty($_POST['event_date'])) $event_date = $_POST['event_date'];
  if (!empty($_POST['event_title'])) $event_title = $_POST['event_title'];
  if (!empty($_POST['event_text'])) $event_text = $_POST['event_text'];
  if (!empty($_POST['retry'])) $retry = $_POST['retry'];
}

$form_action = "event.edit.php";
$form_button = "Save";

if (!$retry) {
  retry_create();
} else if (!$event_date) {
  retry_create("You must specify a date for the Event.");
} else if (!$event_title) {
  retry_create("You must enter a Title for the Event.");
} else if (!$event_text) {
  retry_create("You must enter the text of the Event.");
} else {
echo "<h3>!!!!</h3>";
  storeFlash("Event <b>$event_date - $event_title</b> saved.");

  $event_date = Util::displayToSqlDate($event_date);
  $event_title = Util::textToSql($event_title);
  $event_text = Util::textToSql($event_text);

  $ssql = "UPDATE event SET ".
            "event_date = '$event_date',".
            "event_title = '$event_title',".
            "event_text = '$event_text' ".
          "WHERE id = '$event_id'";
  $sql = mysql_query($ssql);

  redirect("events.php");
}

?>
