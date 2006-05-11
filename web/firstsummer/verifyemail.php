<?
/* * * * * * * * * * * * * * * * * * * * * * * *
 * First Summerhouses
 * Copyright (c) 2006 Frontburner
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * Verify Email Address
 *
 * $Id: forgot.php 71 2006-05-09 21:09:10Z craig $
 *
 * Who  When         Why
 * CAM  10-Feb-2006  File created.
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
