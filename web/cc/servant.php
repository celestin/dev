<?php
/* * * * * * * * * * * * * * * * * * * * * * * *
 * Add a Servant
 * Copyright (c) 2006 frontburner.co.uk
 * Author Craig McKay <craig@southesk.com>
 *
 * $Id$
 *
 * 1     8/04/06 20:38 Craig
 *
 * Who  When         Why
 * CAM  08-Apr-2006  File created.
 * * * * * * * * * * * * * * * * * * * * * * * */

$title = "Add Servant";
include 'tpl/top.php';

$ulocality = NULL;        if (!empty($_POST['ulocality'])) $ulocality = $_POST['ulocality'];
$uservant = NULL;         if (!empty($_POST['uservant'])) $uservant = $_POST['uservant'];
$retry = NULL;            if (!empty($_POST['retry'])) $retry = $_POST['retry'];

if (!session_is_registered('memberid')) {
  Msg::error("You must be logged in to use this functionality.");
  include 'tpl/bot.php';
  exit();
}

?>
<center>
<?

if ($member->isAdmin()) {
  if (empty($retry)) {
    include 'frm/servant.add.php';
  } else if (empty($uservant)) {
    Msg::error("Please enter the Servant's full name.");
    include 'frm/servant.add.php';
  } else {
    $ssql = "REPLACE INTO meeting_servant (".
              "servant_name,locality".
            ") VALUES (".
              "'$uservant','$ulocality'".
            ")";

    $sql = mysql_query($ssql) or die(mysql_error());
    if(mysql_affected_rows() <= 2){
      // Replace does update two rows
      Msg::statement("Servant has been created.");

    } else {
      Msg::error("An error occurred creating the servant - please try again.");
    }
  }
}

include 'tpl/bot.php';
?>