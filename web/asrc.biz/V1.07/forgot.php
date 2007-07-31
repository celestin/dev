<?
/* * * * * * * * * * * * * * * * * * * * * * * *
 * ASRC.biz (Aberdeen Squash Racquets Club)
 *
 * Copyright (c) 2006 Frontburner
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * Forgotten Password Workflow
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  31-Aug-2004  File created.
 * CAM  27-Sep-2006  10034 : Fixed bug.
 * CAM  08-Feb-2007  10097 : Ensure the correct URL is used when sending emails.
 * * * * * * * * * * * * * * * * * * * * * * * */

include_once 'Main.php';
include 'tpl/top.php';

function retry_login($error='') {
  if (!empty($error)) Msg::error($error);
  include 'frm/login_form.php';
  include 'tpl/bot.php';
  exit();
}

$memberid = strtoupper($_POST['memberid']);
//$pwd = $_POST['password'];

if(!$memberid){
  retry_login();

} else {

  // Retrieve the member details
  $sql = mysql_query("SELECT * FROM member WHERE memberid='$memberid'");
  $login_check = mysql_num_rows($sql);

  if ($login_check == 0) {
    retry_login("The Member ID " . $memberid . " could not be found.&nbsp;&nbsp;Please check and try again!");
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
      $cr = "\r\n";

      $sql = mysql_query("UPDATE member SET password='$pwd' WHERE memberid='$memberid'");

      $subject = "Your ASRC Online Booking password for $memberid" ;
      $message = "Hi $first_name,$cr$cr".
                 "We have reset your password to: $new_pwd$cr$cr".
                 "Click on " . $cfg['Site']['URL'] . "/login.php to login$cr$cr".
                 "Thanks!$cr".
                 "Aberdeen Squash Racquets Club$cr".
                 "(This is an automated response, please do not reply)$cr";

      mail($email_address, $subject, $message, "From: ASRC <craig@southesk.com>\nX-Mailer: PHP/" . phpversion());
      Msg::statement("Your password has been sent.  Please check your email!");
    }
  }
}

include 'tpl/bot.php';
?>

