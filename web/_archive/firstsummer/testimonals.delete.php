<?
/* * * * * * * * * * * * * * * * * * * * * * * *
 * First Summerhouses
 * Copyright (c) 2006-2007 Frontburner
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * Delete a Testimonal.
 *
 * $Id: news.delete.php 310 2006-10-10 21:31:17Z craig $
 *
 * Who  When         Why
 * CAM  01-Feb-2007  10081 : File created.
 * * * * * * * * * * * * * * * * * * * * * * * */

$title = "Delete a Testimonal";
include_once 'Main.php';

$testimonal_id = NULL;       if (!empty($_GET['testimonal_id'])) $testimonal_id = $_GET['testimonal_id'];
$areyousure = NULL;          if (!empty($_GET['areyousure'])) $areyousure = $_GET['areyousure'];

$ssql = "SELECT id testimonal_id, customer_name, DATE_FORMAT(testimonal_date,'%d %b %Y') testimonal_date ".
        "FROM testimonals ".
        "WHERE id = '$testimonal_id'";
$sql = mysql_query($ssql) or die (mysql_error());
if ($row = mysql_fetch_array($sql)) {
  foreach($row AS $key => $val) {
    $$key = stripslashes($val);
  }

  $testimonaldesc = "$customer_name - $testimonal_date";

} else {
  redirect("testimonals.php");
}

if(!empty($areyousure)){
  $ssql = "DELETE FROM testimonals WHERE id='$testimonal_id'";
  $sql = mysql_query($ssql);
}

include 'tpl/top.php';

if(empty($areyousure)) {
  echo "<center>Are you sure you want to delete <b>$testimonaldesc</b>?</center><br />";
  echo "<center><a href=testimonals.delete.php?testimonal_id=$testimonal_id&areyousure=yes>Yes</a> | <a href=testimonals.php>No</a>";
} else {
  storeFlash("Testimonal from <b>$testimonaldesc</b> deleted.");
  redirect("testimonals.php");
}
include 'tpl/bot.php';
?>
