<?
/* * * * * * * * * * * * * * * * * * * * * * * *
 * WEBSITE_NAME
 * Copyright (c) 2007 frontburner.co.uk
 *
 * Logout of the system
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  27-Dec-2005  File created.
 * CAM  08-Mar-2010  10602 : Test for correct session variable.
 * * * * * * * * * * * * * * * * * * * * * * * */

$title = "Log out";
include_once 'Main.php';

if(isset($_REQUEST['logmeout'])){
  session_destroy();
}

include 'tpl/top.php';

if(!isset($_REQUEST['logmeout'])){
  echo "<center>Are you sure you want to logout?</center><br />";
  echo "<center><a href=logout.php?logmeout>Yes</a> | <a href=index.php>No</a>";
} else {
  if(!session_is_registered('member_person')){
    Msg::error("You are now logged out!");
    include 'tpl/home.php';
  }
}
include 'tpl/bot.php';
?>
