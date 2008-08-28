<?
/* * * * * * * * * * * * * * * * * * * * * * * *
 * Airylea Motors Website
 * Copyright (c) 2007 Frontburner
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * Feedback Creation
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  28-Aug-2008  10280 : File created.
 * * * * * * * * * * * * * * * * * * * * * * * */

$title = "Add Feedback";
include_once 'Main.php';
include 'tpl/top.php';

function retry_create($error="") {
  global $feedback_id, $feedback_date, $customer_name, $feedback, $retry, $form_action, $form_button;
  if (!empty($error)) Msg::error($error);
  include 'frm/feedback.edit.php';
  include 'tpl/bot.php';
  exit();
}

$feedback_id = NULL;      if (!empty($_POST['feedback_id'])) $feedback_id = $_POST['feedback_id'];
$feedback_date = NULL;    if (!empty($_POST['feedback_date'])) $feedback_date = $_POST['feedback_date'];
$customer_name = NULL;    if (!empty($_POST['customer_name'])) $customer_name = $_POST['customer_name'];
$feedback = NULL;         if (!empty($_POST['feedback'])) $feedback = $_POST['feedback'];
$retry = NULL;            if (!empty($_POST['retry'])) $retry = $_POST['retry'];

$form_action = "feedback.add.php";
$form_button = "Add";

if (!$retry) {
  retry_create();
} else if (!$feedback_date) {
  retry_create("You must specify a date for the Feedback.");
} else if (!$customer_name) {
  retry_create("You must enter the Customers name.");
} else if (!$feedback) {
  retry_create("You must enter the text of the Feedback.");
} else {
  storeFlash("Feedback <b>$feedback_date - $customer_name</b> created.");

  $feedback_date = Util::displayToSqlDate($feedback_date);
  $customer_name = Util::textToSql($customer_name);
  $feedback = Util::textToSql($feedback);

  $ssql = "INSERT INTO feedback (feedback_date,customer_name,feedback) VALUES ".
          "('$feedback_date','$customer_name','$feedback')";
  $sql = mysql_query($ssql);

  redirect("feedback.php");
}

?>

