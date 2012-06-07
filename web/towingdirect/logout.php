<?
/* * * * * * * * * * * * * * * * * * * * * * * *
 * TowingDirect Website
 * Copyright (c) 2012 Front Burner
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * Logout of the system
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  13-Apr-2006  File created.
 * CAM  31-May-2006  Fill out the page.
 * CAM  11-Aug-2007  10153 : Use Flash to report logout.
 * CAM  07-Jun-2012  11126 : Remove errors with deprecated PHP session functions.
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
  if(!isset($_SESSION['memberid'])){
    session_start();
    storeFlash("You are now logged out!");
    redirect("index.php");
  }
}
include 'tpl/bot.php';
?>
