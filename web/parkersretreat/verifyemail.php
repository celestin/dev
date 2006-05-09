<?
/* * * * * * * * * * * * * * * * * * * * * * * *
 * Verify Email Address
 * Copyright (c) 2006 frontburner.co.uk
 *
 * $Log: /web/parkersretreat/verifyemail.php $
 * 
 * 1     23/04/06 21:27 Craig
 *
 * Who  When         Why
 * CAM  11-Apr-2006  File created.
 * * * * * * * * * * * * * * * * * * * * * * * */

$title = "Email Verification";
include_once 'Main.php';
include 'tpl/top.php';

$username = NULL;         if (!empty($_GET['username'])) $username = $_GET['username'];
$code = NULL;             if (!empty($_GET['code'])) $code = $_GET['code'];

$sql = "UPDATE member SET verify_code = NULL, active = 1 ".
       "WHERE memberid='$username' ".
       "AND verify_code='$code'";

mysql_query($sql);

if(mysql_affected_rows() == 1){
  Msg::statement("Your email address has been verified - thank you.");
} else {
  Msg::error("Your email address could not be verified - please try again.");
}

include 'tpl/bot.php';
?>
