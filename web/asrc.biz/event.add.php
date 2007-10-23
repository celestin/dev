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

$title = "Add Event";
include_once 'Main.php';
include 'tpl/top.php';

function retry_create($error="") {
  global $event_id, $event_date, $event_title, $event_text, $retry, $form_action, $form_button;
  if (!empty($error)) Msg::error($error);
  include 'frm/event.edit.php';
  include 'tpl/bot.php';
  exit();
}

$event_id = NULL;       if (!empty($_POST['event_id'])) $event_id = $_POST['event_id'];
$event_date = NULL;     if (!empty($_POST['event_date'])) $event_date = $_POST['event_date'];
$event_title = NULL;    if (!empty($_POST['event_title'])) $event_title = $_POST['event_title'];
$event_text = NULL;     if (!empty($_POST['event_text'])) $event_text = $_POST['event_text'];
$retry = NULL;          if (!empty($_POST['retry'])) $retry = $_POST['retry'];

$form_action = "event.add.php";
$form_button = "Add";

if (!$retry) {
  retry_create();
} else if (!$event_date) {
  retry_create("You must specify a date for the Event.");
} else if (!$event_title) {
  retry_create("You must enter a Title for the Event.");
} else if (!$event_text) {
  retry_create("You must enter the text of the Event.");
} else {
  storeFlash("Event <b>$event_date - $event_title</b> created.");

  $event_date = Util::displayToSqlDate($event_date);
  $event_title = Util::textToSql($event_title);
  $event_text = Util::textToSql($event_text);

  $ssql = "INSERT INTO event (event_date,event_title,event_text) VALUES ".
          "('$event_date','$event_title','$event_text')";
  $sql = mysql_query($ssql);

  redirect("events.php");
}

?>
