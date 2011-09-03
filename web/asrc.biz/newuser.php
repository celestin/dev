<?
/* * * * * * * * * * * * * * * * * * * * * * * *
 * ASRC.biz (Aberdeen Squash Racquets Club)
 *
 * Copyright (c) 2006 Frontburner
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * New User Creation
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  19-Mar-2004  File created.
 * * * * * * * * * * * * * * * * * * * * * * * */

$title = "New User";
include_once 'Main.php';
include 'tpl/top.php';

function retry_create($error) {
  Msg::error($error);
  include 'frm/newuser_form.php';
  include 'tpl/bot.php';
  exit();
}

$member_new = NULL;       if (!empty($_POST['member_new'])) $member_new = strtoupper($_POST['member_new']);
$member_parent = NULL;    if (!empty($_POST['member_parent'])) $member_parent = strtoupper($_POST['member_parent']);
$first_name = NULL;       if (!empty($_POST['first_name'])) $first_name = $_POST['first_name'];
$last_name = NULL;        if (!empty($_POST['last_name'])) $last_name = $_POST['last_name'];
$email_address = NULL;    if (!empty($_POST['email_address'])) $email_address = $_POST['email_address'];
$member_type = NULL;      if (!empty($_POST['member_type'])) $member_type = $_POST['member_type'];
$dob = NULL;              if (!empty($_POST['dob'])) $dob = $_POST['dob'];
$retry = NULL;            if (!empty($_POST['retry'])) $retry = $_POST['retry'];

if (!$retry) {
  retry_create("Please enter new user details.");
} else if (!$member_new) {
  retry_create("You must enter the new Member ID.");
} else if (!$first_name || !$last_name) {
  retry_create("You must enter first name and last name.");
} else if (!$dob) {
  retry_create("You must enter the correct Date of Birth.");
} else {
  $admin="0";
  if ($member_type == "A") $admin="1";
  $dob = Util::displayToSqlDate($dob);

  $ssql = "INSERT INTO member (".
      "memberid,parent,first_name,last_name,".
      "email_address,admin,member_type,dob".
    ") VALUES (".
      "'$member_new','$member_parent','$first_name','$last_name',".
      "'$email_address','$admin','$member_type','$dob'".
    ")";

  $sql = mysql_query($ssql) or die(mysql_error());
}

?>

