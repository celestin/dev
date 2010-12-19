<?
/* * * * * * * * * * * * * * * * * * * * * * * *
 * First Summerhouses
 * Copyright (c) 2006-2007 Frontburner
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * Testimonal Creation
 *
 * $Id: news.add.php 310 2006-10-10 21:31:17Z craig $
 *
 * Who  When         Why
 * CAM  01-Feb-2007  10081 : File created.
 * * * * * * * * * * * * * * * * * * * * * * * */

$title = "Add Testimonal";
include_once 'Main.php';
include 'tpl/top.php';

function retry_create($error="") {
  global $testimonal_id, $testimonal_date, $customer_name, $testimonal, $retry, $form_action, $form_button;
  if (!empty($error)) Msg::error($error);
  include 'frm/testimonal.edit.php';
  include 'tpl/bot.php';
  exit();
}

$testimonal_id = NULL;     if (!empty($_POST['testimonal_id'])) $testimonal_id = $_POST['testimonal_id'];
$testimonal_date = NULL;   if (!empty($_POST['testimonal_date'])) $testimonal_date = $_POST['testimonal_date'];
$customer_name = NULL;     if (!empty($_POST['customer_name'])) $customer_name = $_POST['customer_name'];
$testimonal = NULL;        if (!empty($_POST['testimonal'])) $testimonal = $_POST['testimonal'];
$retry = NULL;             if (!empty($_POST['retry'])) $retry = $_POST['retry'];

$form_action = "testimonals.add.php";
$form_button = "Add";

if (!$retry) {
  retry_create();
} else if (!$testimonal_date) {
  retry_create("You must specify a date for the Testimonal.");
} else if (!$customer_name) {
  retry_create("You must enter the Customers name.");
} else if (!$testimonal) {
  retry_create("You must enter the text of the Testimonal.");
} else {
  storeFlash("Testimonal <b>$testimonal_date - $customer_name</b> created.");

  $testimonal_date = Util::displayToSqlDate($testimonal_date);
  $customer_name = Util::textToSql($customer_name);
  $testimonal = Util::textToSql($testimonal);

  $ssql = "INSERT INTO testimonals (testimonal_date,customer_name,testimonal) VALUES ".
          "('$testimonal_date','$customer_name','$testimonal')";
  $sql = mysql_query($ssql);

  redirect("testimonals.php");
}

?>

