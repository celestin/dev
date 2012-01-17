<?
/* * * * * * * * * * * * * * * * * * * * * * * *
 * TowingDirect Website
 * Copyright (c) 2012 Front Burner
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * Account activation script
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  13-Apr-2006  File created.
 * * * * * * * * * * * * * * * * * * * * * * * */

include_once 'Main.php';
include 'tpl/top.php';

function retry_activate($error, $confirm_set) {
  Msg::error($error);
  $locked_id = true;
  include 'frm/activate_form.php';
  include 'tpl/bot.php';
  exit();
}

$memberid = NULL;     if (!empty($_POST['memberid'])) $memberid = strtoupper($_POST['memberid']);
$password1 = NULL;    if (!empty($_POST['password1'])) $password1 = $_POST['password1'];
$password2 = NULL;    if (!empty($_POST['password2'])) $password2 = $_POST['password2'];
$email = NULL;        if (!empty($_POST['email'])) $email = $_POST['email'];
$confirm = NULL;      if (!empty($_POST['confirm'])) $confirm = $_POST['confirm'];

if ($password1 != $password2) {
  retry_activate("Your passwords do not match.  Please confirm them both again.", "N");
} else if (!$password1 || !$email) {
  retry_activate("You must enter and confirm your password and email address to access this site.", "N");
} else if (!$confirm) {
  retry_activate("Please confirm your email address is correct...", "Y");
} else {
  $password1 = md5($password1);
  $sql = mysql_query("UPDATE member SET active='1', password='$password1', email_address='$email' WHERE memberid='$memberid'");
  include 'session_reg.php';
  include 'tpl/bot.php';
}

?>