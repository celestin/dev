<?
/* * * * * * * * * * * * * * * * * * * * * * * *
 * Parkers Retreat
 * Copyright (c) 2006 Frontburner
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * Logout of the system
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  11-Apr-2006  File created.
 * * * * * * * * * * * * * * * * * * * * * * * */

$title = "Log out";
include_once 'Main.php';

if(isset($_REQUEST['logmeout'])){
  session_destroy();
}

include 'tpl/top.php';

if(!isset($_REQUEST['logmeout'])){
  echo "<center>Are you sure you want to logout?</center><br />";
  echo "<center><a href=logout.php?logmeout>Yes</a> | <a href=page.php>No</a>";
} else {
  if(!session_is_registered('memberid')){
    Msg::error("You are now logged out!");
    include 'tpl/home.php';
  }
}
include 'tpl/bot.php';
?>
