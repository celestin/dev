<?
/* * * * * * * * * * * * * * * * * * * * * * * *
 * WestCoastExpress Website
 * Copyright (c) 2007 Frontburner
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * Delete Customer Feedback.
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  11-Aug-2007  10154 : File created.
 * * * * * * * * * * * * * * * * * * * * * * * */

$title = "Delete a Feedback";
include_once 'Main.php';

$feedback_id = NULL;       if (!empty($_GET['feedback_id'])) $feedback_id = $_GET['feedback_id'];
$areyousure = NULL;        if (!empty($_GET['areyousure'])) $areyousure = $_GET['areyousure'];

$ssql = "SELECT id feedback_id, customer_name, DATE_FORMAT(feedback_date,'%d %b %Y') feedback_date ".
        "FROM feedback ".
        "WHERE id = '$feedback_id'";
$sql = mysql_query($ssql) or die (mysql_error());
if ($row = mysql_fetch_array($sql)) {
  foreach($row AS $key => $val) {
    $$key = stripslashes($val);
  }

  $feedbackdesc = "$customer_name - $feedback_date";

} else {
  redirect("feedback.php");
}

if(!empty($areyousure)){
  $ssql = "DELETE FROM feedback WHERE id='$feedback_id'";
  $sql = mysql_query($ssql);
}

include 'tpl/top.php';

if(empty($areyousure)) {
  echo "<center>Are you sure you want to delete <b>$feedbackdesc</b>?</center><br />";
  echo "<center><a href=feedback.delete.php?feedback_id=$feedback_id&areyousure=yes>Yes</a> | <a href=feedback.php>No</a>";
} else {
  storeFlash("Feedback from <b>$feedbackdesc</b> deleted.");
  redirect("feedback.php");
}
include 'tpl/bot.php';
?>
