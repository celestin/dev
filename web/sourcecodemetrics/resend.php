<?php
/* * * * * * * * * * * * * * * * * * * * * * * *
 * SourceCodeMetrics.com
 * Copyright (c) 2006 SourceCodeMetrics.com
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * Resend Email Verification
 *
 * $Id: top.php 298 2006-10-07 17:35:31Z craig $
 *
 * Who  When         Why
 * CAM  18-Nov-2006  File created.
 * * * * * * * * * * * * * * * * * * * * * * * */

$title = "Resend Email Verification";
include_once 'Main.php';
include 'tpl/top.php';

$username = NULL;         if (!empty($_POST['username'])) $username = strtoupper($_POST['username']);
$email_address = NULL;    if (!empty($_POST['first_name'])) $first_name = $_POST['first_name'];
$verify_code = NULL;      if (!empty($_POST['verify_code'])) $verify_code = $_POST['verify_code'];

/*
$ssql = "UPDATE member SET email_address='$email_address' ".
        "WHERE memberid='$username'";
$sql = mysql_query($ssql);
*/

Msg::statement("Thank you.  Please check your email to verify your email address.");

$e = new EmailMsg('V', $username);
$e->sendVerify($verify_code);

?>

