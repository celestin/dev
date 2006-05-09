<?
/* * * * * * * * * * * * * * * * * * * * * * * *
 * Login to the system (including first-time)
 * Copyright (c) 2006 frontburner.co.uk
 *
 * $Log: /web/parkersretreat/login.php $
 * 
 * 1     23/04/06 21:27 Craig
 *
 * Who  When         Why
 * CAM  11-Apr-2006  File created.
 * * * * * * * * * * * * * * * * * * * * * * * */

$title = "Login";
include_once 'Main.php';
include 'tpl/top.php';

function retry_login($error='') {
  global $memberid;
  if (!empty($error)) Msg::error($error);
  include 'frm/user.login.php';
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

    if($pwd == $password) {
      if($active != 1) {
        Msg::error("You must verify your account to continue.<br>");
        include 'frm/user.verify.php';
        exit();
      } else if ($member_type == "N") {
        Msg::error("Your details are being reviewed and you will be contacted shortly.<br>");
        exit();
      }

      include 'session_reg.php';
    } else {

      retry_login("Your password is incorrect.&nbsp;&nbsp;Please check and try again!");
    }
  }
} else {
  retry_login("The Username " . $memberid . " could not be found.&nbsp;&nbsp;Please check and try again!");
}

include 'tpl/bot.php';
?>

