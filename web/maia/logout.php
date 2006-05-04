<?
/* * * * * * * * * * * * * * * * * * * * * * * *
 * Logout of the system
 * Copyright (c) 2006 frontburner.co.uk
 *
 * $Log: /web/maia/logout.php $
 * 
 * 2     3/02/06 20:42 Craig
 *
 * 1     3/02/06 1:52 Craig
 * 1000
 *
 * Who  When         Why
 * CAM  02-Feb-2006  File created.
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
  if(!session_is_registered('memberid')){
    Msg::error("You are now logged out!");
  }
}
include 'tpl/bot.php';
?>
