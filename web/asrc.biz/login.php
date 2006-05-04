<?
/* * * * * * * * * * * * * * * * * * * * * * * *
 * ASRC.biz (Aberdeen Squash Racquets Club)
 *
 * Copyright (c) 2006 Frontburner
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * Login to the system (including first-time)
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  19-Mar-2004  File created.
 * * * * * * * * * * * * * * * * * * * * * * * */

$title = "Aberdeen Squash Racquets Club - Login";
include_once 'Main.php';
include 'tpl/top.php';

function retry_login($error='') {
  if (!empty($error)) Msg::error($error);
  include 'frm/login_form.php';
  include 'tpl/bot.php';
  exit();
}

$memberid = NULL;     if (!empty($_POST['memberid'])) $memberid = $_POST['memberid'];
$pwd = NULL;          if (!empty($_POST['password'])) $pwd = $_POST['password'];

if(!$memberid){
  retry_login();
}

// Convert password to md5 hash
$pwd = md5($pwd);

// Retrieve the member details
$sql = mysql_query("SELECT * FROM member WHERE memberid='$memberid'");
$login_check = mysql_num_rows($sql);

if ($login_check > 0) {
  if ($row = mysql_fetch_array($sql)) {
    foreach($row AS $key => $val) {
      $$key = stripslashes($val);
    }

    if($active != 1) {
      Msg::error("You must activate your account to continue.<br>");
      include 'frm/activate_form.php';
    } else if($pwd == $password) {
      include 'session_reg.php';
    } else {
      retry_login("Your password is incorrect.&nbsp;&nbsp;Please check and try again!");
    }
  }
} else {
  retry_login("The Member ID " . $memberid . " could not be found.&nbsp;&nbsp;Please check and try again!");
}

include 'tpl/bot.php';
?>

