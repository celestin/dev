<?
/* * * * * * * * * * * * * * * * * * * * * * * *
 * ASRC.biz (Aberdeen Squash Racquets Club)
 *
 * Copyright (c) 2006-2007 Frontburner
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * Edit an existing User
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  29-Jul-2006  10021 : File added.
 * CAM  22-Jun-2007  10132 : Removed session_register.
 * CAM  12-Aug-2007  10157 : Use Flash/redirect.
 * * * * * * * * * * * * * * * * * * * * * * * */

$title = "Aberdeen Squash Racquets Club - Edit User";
include_once 'Main.php';
include 'tpl/top.php';

if (!$member->isAdmin()) {
  Msg::error("Only Administrative users may access this option.");
  exit();
}

function retry_create($error) {
  Msg::error($error);
  include 'frm/edituser_form.php';
  include 'tpl/bot.php';
  exit();
}

$member_id = NULL;        if (!empty($_POST['member_id'])) $member_id = strtoupper($_POST['member_id']);
$member_parent = NULL;    if (!empty($_POST['member_parent'])) $member_parent = strtoupper($_POST['member_parent']);
$first_name = NULL;       if (!empty($_POST['first_name'])) $first_name = $_POST['first_name'];
$last_name = NULL;        if (!empty($_POST['last_name'])) $last_name = $_POST['last_name'];
$email_address = NULL;    if (!empty($_POST['email_address'])) $email_address = $_POST['email_address'];
$member_type = NULL;      if (!empty($_POST['member_type'])) $member_type = $_POST['member_type'];
$block_booker = NULL;     if (!empty($_POST['block_booker'])) $block_booker = $_POST['block_booker'];
$dob = NULL;              if (!empty($_POST['dob'])) $dob = $_POST['dob'];
$retry = NULL;            if (!empty($_POST['retry'])) $retry = $_POST['retry'];

if (!$retry) {
  retry_create("Please make the required changes to the user's details.");
} else if (!$member_id) {
  retry_create("You must enter the new Member ID.");
} else if (!$first_name || !$last_name) {
  retry_create("You must enter first name and last name.");
} else if (!$dob) {
  retry_create("You must enter the correct Date of Birth.");
} else {
  $admin="0";
  if ($member_type == "A") $admin="1";
  $block_booker = ($block_booker == 1) ? "1": "0";
  $dob = Util::displayToSqlDate($dob);

  $ssql = "UPDATE member SET ".
          "parent = '$member_parent', ".
          "first_name = '$first_name', ".
          "last_name = '$last_name', ".
          "email_address = '$email_address', ".
          "member_type = '$member_type', ".
          "block_booker = '$block_booker', ".
          "dob = '$dob', ".
          "admin = '$admin' ".
          "WHERE memberid = '$member_id' ";
  $sql = mysql_query($ssql) or die(mysql_error());

  storeFlash("User $member_id updated.");
  redirect("users.php");
}

?>

