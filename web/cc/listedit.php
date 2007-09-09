<?php
/* * * * * * * * * * * * * * * * * * * * * * * *
 * List Edit
 * Copyright (c) 2006 frontburner.co.uk
 * Author Craig McKay <craig@southesk.com>
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  08-Apr-2006  File created.
 * * * * * * * * * * * * * * * * * * * * * * * */

$title = "Edit List";
include 'tpl/top.php';

$umtg_type = NULL;
$umtg_date = NULL;
$ulocality = NULL;

if (!empty($_GET['umtg_type'])) {
  if (!empty($_GET['umtg_type'])) $umtg_type = $_GET['umtg_type'];
  if (!empty($_GET['umtg_date'])) $umtg_date = $_GET['umtg_date'];
  if (!empty($_GET['ulocality'])) $ulocality = $_GET['ulocality'];
} else {
  if (!empty($_POST['umtg_type'])) $umtg_type = $_POST['umtg_type'];
  if (!empty($_POST['umtg_date'])) $umtg_date = $_POST['umtg_date'];
  if (!empty($_POST['ulocality'])) $ulocality = $_POST['ulocality'];
}
$uservant = NULL;        if (!empty($_POST['uservant'])) $uservant = $_POST['uservant'];
$retry = NULL;           if (!empty($_POST['retry'])) $retry = $_POST['retry'];

?>

<center>

<?

if ($member->isAdmin()) {
  if (empty($retry)) {
    include 'frm/list.edit.php';
  } else {
    $ssql = "UPDATE meeting_list ".
            "SET servant='$uservant' ".
            "WHERE mtg_type='$umtg_type' ".
            "AND mtg_date='".mdate($umtg_date). "' ".
            "AND locality='$ulocality' ";

    $sql = mysql_query($ssql) or die(mysql_error());
    if(mysql_affected_rows() == 1){
      Msg::statement("List entry has been updated.");

    } else {
      Msg::error("An error occurred updating the list entry - please try again.");
    }
  }
}

include 'tpl/bot.php';
?>