<?
/* * * * * * * * * * * * * * * * * * * * * * * *
 * First Summerhouses
 * Copyright (c) 2006 Frontburner
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * Contact Me
 *
 * $Id: changepass.php 84 2006-05-11 18:55:49Z craig $
 *
 * Who  When         Why
 * CAM  25-Nov-2006  10012 : File added.
 * * * * * * * * * * * * * * * * * * * * * * * */

$title = "Contact Me";
include_once 'Main.php';
include 'tpl/top.php';

$contactProd = NULL;      if (!empty($_POST['contactProd'])) $contactProd = $_POST['contactProd'];
$contactName = NULL;      if (!empty($_POST['contactName'])) $contactName = $_POST['contactName'];
$contactTxt1 = NULL;      if (!empty($_POST['contactTxt1'])) $contactTxt1 = $_POST['contactTxt1'];
$contactComments = NULL;  if (!empty($_POST['contactComments'])) $contactComments = $_POST['contactComments'];
$contactType = NULL;      if (!empty($_POST['contactType'])) $contactType = $_POST['contactType'];

$em = new EmailMsg();

if ($contactType == "EMAIL") {
  $em->sendRequestEmail($contactProd, $contactName, $contactTxt1, $contactComments);
} else {
  $em->sendRequestCall($contactProd, $contactName, $contactTxt1, $contactComments);
}

Msg::statement("Thank you for your request - we will contact you as soon as we can.");

include 'tpl/bot.php';
?>

