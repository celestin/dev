<?
/* * * * * * * * * * * * * * * * * * * * * * * *
 * Maia Systems Website
 * Copyright (c) 2006 Maia Systems
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * Logout of the system
 *
 * $Id$
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
