<?
/* * * * * * * * * * * * * * * * * * * * * * * *
 * Opponent Search Logic
 * Copyright (c) 2004-2005 Southesk.com
 *
 * Who  When         Why
 * CAM  24-Aug-2004  File created.
 * * * * * * * * * * * * * * * * * * * * * * * */

$title = "Aberdeen Squash Racquets Club - Member Search";
include_once 'Main.php';
$member = $_SESSION['member_person'];
include 'tpl/top.php';

$member_id = NULL;    if (!empty($_POST['member_id'])) $member_id = $_POST['member_id'];
$member_name = NULL;  if (!empty($_POST['member_name'])) $member_name = $_POST['member_name'];
$retry = NULL;        if (!empty($_POST['retry'])) $retry = $_POST['retry'];

if (empty($member_id) && empty($member_name)) {
  if (!empty($retry)) Msg::error("Enter either the Member No. or Name!");

  include 'frm/orig_form.php';
} else {
  $ssql = "SELECT memberid,last_name,first_name,active " .
          "FROM member " .
          "WHERE ";

  if (!empty($member_name)) {
    $ssql .= "(CONCAT(first_name, ' ', last_name) LIKE '%$member_name%')";
  } else {
    $ssql .= "memberid='$member_id' OR parent='$member_id'";
  }

  $ssql .= "ORDER BY 2,3";

  $sql = mysql_query($ssql) or die (mysql_error());

  print "<table border=0 cellspacing=10 cellpadding=0>";

  while ($row = mysql_fetch_array($sql)) {
    foreach($row AS $key => $val) {
      $$key = stripslashes($val);
    }

    print "<tr><td><a href=\"newbooking.php?member_orig=$memberid\">$first_name $last_name ($memberid)</a></td></tr>";
  }

  print "<tr><td><a href=\"orig.php\">Search again...</a></td></tr>";

  print "</table>";
}

include 'tpl/bot.php';
?>