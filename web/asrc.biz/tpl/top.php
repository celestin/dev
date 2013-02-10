<?php
/* * * * * * * * * * * * * * * * * * * * * * * *
 * ASRC.biz (Aberdeen Squash Racquets Club)
 * Copyright (c) 2006,2010 Frontburner
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  19-Mar-2004  File created.
 * CAM  30-May-2004  4 : Added Fines menu.
 * CAM  25-Apr-2006  14 : Show Courts View to admin toolbar.
 * CAM  29-Jul-2006  10021 : Show flash messages if they exist.
 * CAM  25-Jun-2007  10134 : Add News to members toolbar.
 * CAM  12-Aug-2007  10157 : Add TBC to Admin toolbar.
 * CAM  22-Oct-2007  10182 : Split Admin toolbar onto second line.  Adding blinking Events.
 * CAM  12-Feb-2008  10230 : Added TWMA logo, shuffled others.
 * CAM  25-Nov-2008  10314 : New colours/layout in line with new asrc.co.uk.
 * CAM  25-Nov-2008  10314 : CSS file renamed to ensure proper reload.
 * CAM  27-Feb-2010  10577 : Added new sponsorship logos.
 * CAM  13-Oct-2012  11135 : Removed session_is_registered.
 * CAM  10-Feb-2013  11155 : Updated ASRC logo.
 * * * * * * * * * * * * * * * * * * * * * * * */

include_once 'Main.php';
$member = NULL;  if (isset($_SESSION['member_person'])) $member = $_SESSION['member_person'];
$loggedin = isset($_SESSION['memberid']);

global $events_read;
if ($events_read) {
  $_SESSION['events_read'] = "true";
}

if (empty($title)) {
  $title = "Online Booking";
}

if (empty($hide_toolbar)) {
  $hide_toolbar = false;
}

function ToolbarOption($action, $label, $last=false, $class="") {
  $sep = "";
  if (!$last) {
    $sep = "&nbsp;&nbsp;|&nbsp;&nbsp;";
  }
  if (!empty($class)) {
    $class="class=\"$class\"";
  }
  ?><td><a href="<? echo $action; ?>" <? echo $class; ?>><? echo $label; ?></a><? echo $sep; ?></td><?
}

?><head>
  <title><?=$cfg['Site']['Name'] . " - " . $title?></title>
  <link href="asrc3.css" rel=stylesheet type="text/css" />
	<script language="Javascript">
	  function getObjRef(p_ref) {
	    return document.all ? document.all[p_ref] : document.getElementById(p_ref);
	  }
	</script>
  <script language="Javascript" src="dhtml.js"></script>
  <script language="Javascript" src="date.js"></script>
</head>

<body topmargin=0 leftmargin=0>

<table border=0 cellpadding=0 cellspacing=0 width="100%">
<tr><td align="center"><table border=0 cellpadding=0 cellspacing=0>
<tr><td><table id="main" border=0 cellpadding=2 cellspacing=0 bgcolor="white">
<tr><td colspan=3><img src="img\logo\asrc_logo.jpg"></td>
</tr>

<tr>
<td valign=top><table border=0 cellpadding=0 cellspacing=0 width="800" height="480" class="outerBox">
  <tr>
  <td valign=top><table border=0 cellpadding=4 cellspacing=8 width="100%" height="100%" class="thinBox">
    <tr><td class="topnav"><b>Online Court Booking System</b>&nbsp;-&nbsp;<? echo strftime("%a %d %b %H:%M"); ?></td>

    <td class="topnav" align=right><?php
      if ($loggedin) {
        print $member->toHtmlString(true);
      } else {
        print "&nbsp;";
      }
    ?></td>

    </tr>
    <tr><td colspan=2 class="topnav"><table border=0 cellpadding=0 cellspacing=0>
      <tr>
        <?php
          if ($loggedin && !$hide_toolbar) {
            ToolbarOption("mybookings.php", $member->getBookingsDescription());
            ToolbarOption("newbooking.php", "make booking");
            ToolbarOption("events.php", "events");
            ToolbarOption("news.php", "news");
            ToolbarOption("changepass.php", "change password");
            ToolbarOption("logout.php", "logout");
          } else {
            ToolbarOption("login.php", "login");
          }
          ToolbarOption("help.php", "help", true);
        ?>
      </tr>
    </table></td></tr>
    <?
    if ($loggedin && !$hide_toolbar && $member->isAdmin()) {
    ?>
    <tr><td colspan=2 class="topnav" align=right><table border=0 cellpadding=0 cellspacing=0>
      <tr>
        <td class="topnav"><b><? echo $member->getFirstname(); ?>'s admin options</b>&nbsp;&gt;&gt;&nbsp;</td>
        <?php
          ToolbarOption("unconfirmed.php", "tbc");
          ToolbarOption("fines.php", "fines");
          ToolbarOption("users.php", "users");
          ToolbarOption("courtsview.php", "courts", true);
        ?>
      </tr>
    </table></td></tr>
    <?
    }
    ?>
    </table></td></tr>

    <tr><td colspan=2 width="100%" height="100%" valign=top class="detailBox">
<?
  showFlash();
?>