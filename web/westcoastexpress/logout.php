<?
/* * * * * * * * * * * * * * * * * * * * * * * *
 * West Coast Express Website
 * Copyright (c) 2006 Frontburner
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * Logout of the system
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  13-Apr-2006  File created.
 * CAM  31-May-2006  Fill out the page.
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
?><br><br><br><br><br><br><br><br><br><br><br><br><?

include 'tpl/bot.php';
?>
