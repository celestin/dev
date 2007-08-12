<?
/* * * * * * * * * * * * * * * * * * * * * * * *
 * ASRC.biz (Aberdeen Squash Racquets Club)
 *
 * Copyright (c) 2006-2007 Frontburner
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * Delete an existing user
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  29-Jul-2006  10021 : File added.
 * CAM  22-Jun-2007  10132 : Removed session_register.
 * CAM  12-Aug-2007  10157 : Use Flash/redirect.
 * * * * * * * * * * * * * * * * * * * * * * * */

$title = "Aberdeen Squash Racquets Club - Log out";
include_once 'Main.php';
include 'tpl/top.php';

if (!$member->isAdmin()) {
  Msg::error("Only Administrative users may access this option.");
  exit();
}

$member_id = NULL;  if (!empty($_GET['member_id'])) $member_id = strtoupper($_GET['member_id']);

if(!isset($_REQUEST['confirm'])){
  Msg::question("Are you sure you want to delete user $member_id");
  echo "<center><a href=deluser.php?member_id=$member_id&confirm>Yes</a> | <a href=users.php>No</a>";
} else {

  $ssql = "DELETE FROM member ".
          "WHERE memberid = '$member_id' ";
  $sql = mysql_query($ssql) or die(mysql_error());

  storeFlash("User $member_id deleted.");
  redirect("users.php");
}
include 'tpl/bot.php';
?>
