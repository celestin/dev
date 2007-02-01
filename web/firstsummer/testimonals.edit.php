<?
/* * * * * * * * * * * * * * * * * * * * * * * *
 * First Summerhouses
 * Copyright (c) 2006-2007 Frontburner
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * Testimonal Creation
 *
 * $Id: news.edit.php 310 2006-10-10 21:31:17Z craig $
 *
 * Who  When         Why
 * CAM  01-Feb-2007  10081 : File created.
 * * * * * * * * * * * * * * * * * * * * * * * */

$title = "Edit Testimonal";
include_once 'Main.php';
include 'tpl/top.php';

function retry_create($error="") {
  global $testimonal_id, $testimonal_date, $customer_name, $testimonal, $retry, $form_action, $form_button;
  if (!empty($error)) Msg::error($error);
  include 'frm/testimonal.edit.php';
  include 'tpl/bot.php';
  exit();
}

$testimonal_id = NULL;      if (!empty($_GET['testimonal_id'])) $testimonal_id = $_GET['testimonal_id'];

$testimonal_date = NULL;
$customer_name = NULL;
$testimonal = NULL;
$retry = NULL;

if (!empty($testimonal_id)) {
  // Must be the initial Edit - retrieve details
  $ssql = "SELECT id testimonal_id, customer_name, DATE_FORMAT(testimonal_date,'%d-%b-%Y') testimonal_date, testimonal ".
          "FROM testimonals ".
          "WHERE id = '$testimonal_id'";
  $sql = mysql_query($ssql) or die (mysql_error());
  if ($row = mysql_fetch_array($sql)) {
    foreach($row AS $key => $val) {
      $$key = stripslashes($val);
    }
  } else {
    redirect("testimonals.php");
  }
} else {
  // Must be after an Edit - used edited details
  if (!empty($_POST['testimonal_id'])) $testimonal_id = $_POST['testimonal_id'];
  if (!empty($_POST['testimonal_date'])) $testimonal_date = $_POST['testimonal_date'];
  if (!empty($_POST['customer_name'])) $customer_name = $_POST['customer_name'];
  if (!empty($_POST['testimonal'])) $testimonal = $_POST['testimonal'];
  if (!empty($_POST['retry'])) $retry = $_POST['retry'];
}

$form_action = "testimonals.edit.php";
$form_button = "Edit";

if (!$retry) {
  retry_create();
} else if (!$testimonal_date) {
  retry_create("You must specify a date for the Testimonal.");
} else if (!$customer_name) {
  retry_create("You must enter the Customer&#039;s name.");
} else if (!$testimonal) {
  retry_create("You must enter the text of the Testimonal.");
} else {
echo "<h3>!!!!</h3>";
  storeFlash("News Item <b>$testimonal_date - $customer_name</b> edited.");

  $testimonal_date = Util::displayToSqlDate($testimonal_date);
  $customer_name = Util::textToSql($customer_name);
  $testimonal = Util::textToSql($testimonal);

  $ssql = "UPDATE testimonals SET ".
            "testimonal_date = '$testimonal_date',".
            "customer_name = '$customer_name',".
            "testimonal = '$testimonal' ".
          "WHERE id = '$testimonal_id'";
  $sql = mysql_query($ssql);

  redirect("testimonals.php");
}

?>

