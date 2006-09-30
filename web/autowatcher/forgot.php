<?
/* * * * * * * * * * * * * * * * * * * * * * * *
 * Forgotten Password Workflow
 * Copyright (c) 2006 frontburner.co.uk
 *
 * $Id: /web/autowatcherforgot.php $
 *
 * Who  When         Why
 * CAM  30-Sep-2006  File created.
 * * * * * * * * * * * * * * * * * * * * * * * */

include_once 'Main.php';
include 'tpl/top.php';

function retry_login($error='') {
  global $memberid;
  if (!empty($error)) Msg::error($error);
  include 'frm/user.login.php';
  include 'tpl/bot.php';
  exit();
}

$memberid = NULL;     if (!empty($_POST['memberid'])) $memberid = strtoupper($_POST['memberid']);
$pwd = NULL;          if (!empty($_POST['password'])) $pwd = $_POST['password'];
$retry = NULL;        if (!empty($_POST['retry'])) $retry = $_POST['retry'];

if(!$memberid){
  retry_login();

} else {

  // Retrieve the member details
  $sql = mysql_query("SELECT * FROM member WHERE memberid='$memberid'");
  $login_check = mysql_num_rows($sql);

  if ($login_check == 0) {
    retry_login("The Username " . $memberid . " could not be found.&nbsp;&nbsp;Please check and try again!");
  } else {

    if ($row = mysql_fetch_array($sql)) {
      foreach($row AS $key => $val) {
        $$key = stripslashes($val);
      }
    }

    if (!isset($_POST['confirm'])) {
      Msg::question("Would you like a new password emailed to $email_address");
    ?>
      <form name=frmConfirm action="forgot.php" method="post">
        <input type=hidden name="memberid" value="<? echo $memberid; ?>">
        <input type=hidden name="confirm" value="1">
    <?
        echo "<center><a href=\"javascript:frmConfirm.submit();\">Yes</a> | <a href=javascript:history.back()>No</a>";
    ?>
      </form>
    <?
    } else {
      // Convert password to md5 hash
      $new_pwd = strtolower(substr(md5(time()),0,8));
      $pwd = md5($new_pwd);

      $sql = mysql_query("UPDATE member SET password='$pwd' WHERE memberid='$memberid'");

      $em = new EmailMsg("F", $memberid);
      $em->sendForgot($new_pwd);

      Msg::statement("Your password has been sent.  Please check your email!");
    }
  }
}

include 'tpl/bot.php';
?>

