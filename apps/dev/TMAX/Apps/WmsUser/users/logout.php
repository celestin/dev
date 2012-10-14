<?
/* * * * * * * * * * * * * * * * * * * * * * * *
 * Talisman WMS Users
 * Copyright (c) 2012 Front Burner
 *
 * Logout of the system
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  27-Dec-2005  File created.
 * CAM  08-Mar-2010  10602 : Test for correct session variable.
 * CAM  14-Oct-2012  11136 : Replaced deprecated session_is_registered call.
 * * * * * * * * * * * * * * * * * * * * * * * */

$title = "Log out";
include_once 'Main.php';

if(isset($_REQUEST['logmeout'])){
  session_destroy();
  redirect($cfg['Site']['URL']);
}

include 'tpl/top.php';

if(!isset($_REQUEST['logmeout'])){
  echo "<center>Are you sure you want to logout?</center><br />";
  echo "<center><a href=logout.php?logmeout>Yes</a> | <a href=index.php>No</a>";
} else {
  if (!isset($_SESSION['member_person'])) {
    Msg::error("You are now logged out!");
  }
}
include 'tpl/bot.php';
?>
