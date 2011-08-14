<?
/* * * * * * * * * * * * * * * * * * * * * * * *
 * Carried Safely Website
 * Copyright (c) 2007 Frontburner
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * Editing of Customer Feedback
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  11-Aug-2007  10154 : File created.
 * * * * * * * * * * * * * * * * * * * * * * * */

$title = "Edit Feedback";
include_once 'Main.php';
include 'tpl/top.php';

function retry_create($error="") {
  global $feedback_id, $feedback_date, $customer_name, $feedback, $retry, $form_action, $form_button;
  if (!empty($error)) Msg::error($error);
  include 'frm/feedback.edit.php';
  include 'tpl/bot.php';
  exit();
}

$feedback_id = NULL;      if (!empty($_GET['feedback_id'])) $feedback_id = $_GET['feedback_id'];

$feedback_date = NULL;
$customer_name = NULL;
$feedback = NULL;
$retry = NULL;

if (!empty($feedback_id)) {
  // Must be the initial Edit - retrieve details
  $ssql = "SELECT id feedback_id, customer_name, DATE_FORMAT(feedback_date,'%d-%b-%Y') feedback_date, feedback ".
          "FROM feedback ".
          "WHERE id = '$feedback_id'";
  $sql = mysql_query($ssql) or die (mysql_error());
  if ($row = mysql_fetch_array($sql)) {
    foreach($row AS $key => $val) {
      $$key = stripslashes($val);
    }
  } else {
    redirect("feedback.php");
  }
} else {
  // Must be after an Edit - used edited details
  if (!empty($_POST['feedback_id'])) $feedback_id = $_POST['feedback_id'];
  if (!empty($_POST['feedback_date'])) $feedback_date = $_POST['feedback_date'];
  if (!empty($_POST['customer_name'])) $customer_name = $_POST['customer_name'];
  if (!empty($_POST['feedback'])) $feedback = $_POST['feedback'];
  if (!empty($_POST['retry'])) $retry = $_POST['retry'];
}

$form_action = "feedback.edit.php";
$form_button = "Edit";

if (!$retry) {
  retry_create();
} else if (!$feedback_date) {
  retry_create("You must specify a date for the Feedback.");
} else if (!$customer_name) {
  retry_create("You must enter the Customer&#039;s name.");
} else if (!$feedback) {
  retry_create("You must enter the text of the Feedback.");
} else {
  storeFlash("Feedback <b>$feedback_date - $customer_name</b> edited.");

  $feedback_date = Util::displayToSqlDate($feedback_date);
  $customer_name = Util::textToSql($customer_name);
  $feedback = Util::textToSql($feedback);

  $ssql = "UPDATE feedback SET ".
            "feedback_date = '$feedback_date',".
            "customer_name = '$customer_name',".
            "feedback = '$feedback' ".
          "WHERE id = '$feedback_id'";
  $sql = mysql_query($ssql);

  redirect("feedback.php");
}

?>

