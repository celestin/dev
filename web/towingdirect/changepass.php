<?
/* * * * * * * * * * * * * * * * * * * * * * * *
 * TowingDirect Website
 * Copyright (c) 2012 Front Burner
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * Change Password
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  13-Apr-2006  File created.
 * * * * * * * * * * * * * * * * * * * * * * * */

$title = "Change Password";
include_once 'Main.php';
include 'tpl/top.php';

function retry_chgpass($msg) {
  if (!empty($_POST['retry'])) {
    Msg::error("Enter your old password, and the new one twice.");
  } else {
    Msg::error($msg);
  }

  include 'frm/user.chgpass.php';
  include 'tpl/bot.php';
  exit();
}

$memberid = $member->getID();

$old_pwd = NULL;     if (!empty($_POST['old_password'])) $old_pwd = $_POST['old_password'];
$new_pwd1 = NULL;    if (!empty($_POST['new_password1'])) $new_pwd1 = $_POST['new_password1'];
$new_pwd2 = NULL;    if (!empty($_POST['new_password2'])) $new_pwd2 = $_POST['new_password2'];

if(!$old_pwd || !$new_pwd1 || !$new_pwd2){
  retry_chgpass("Enter your old password, and the new one twice.");
} else if ($new_pwd1 != $new_pwd2) {
  retry_chgpass("The new passwords do not match.");
} else {

  $old_pwd = md5($old_pwd);
  $new_pwd1 = md5($new_pwd1);

  // Retrieve the member details
  $sql = mysql_query("SELECT * FROM member WHERE memberid='$memberid' AND password='$old_pwd'");
  $login_check = mysql_num_rows($sql);

  if ($login_check > 0) {
    mysql_query("UPDATE member SET password='$new_pwd1' WHERE memberid='$memberid'");
    Msg::error("Password changed.");
  } else {
    retry_chgpass("Your old password is incorrect.&nbsp;&nbsp;Please check and try again!");
  }
}

include 'tpl/bot.php';
?>

