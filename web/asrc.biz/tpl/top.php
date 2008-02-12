<?php
/* * * * * * * * * * * * * * * * * * * * * * * *
 * ASRC.biz (Aberdeen Squash Racquets Club)
 * Copyright (c) 2006-2008 Frontburner
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
 * * * * * * * * * * * * * * * * * * * * * * * */

include_once 'Main.php';
$member = NULL;  if (session_is_registered('member_person')) $member = $_SESSION['member_person'];
$loggedin = session_is_registered('memberid');

global $events_read;
if ($events_read) {
  $_SESSION['events_read'] = "true";
}

if (empty($title)) {
  $title = "ASRC Online Booking";
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

?>
<head>
  <title><?php print $title;?></title>
  <link href="asrc.css" rel=stylesheet type="text/css" />
  <script language="Javascript" src="dhtml.js"></script>
  <script language="Javascript" src="date.js"></script>
</head>

<body topmargin=2 leftmargin=0 onload="<? if (!session_is_registered('events_read')) echo "blink();"; ?>">

<table border=0 cellpadding=0 cellspacing=0>
<tr><td><table border=0 cellpadding=0 cellspacing=8>
<tr><td align=center valign=top><a target="_blank" href="http://www.twma.co.uk/"><img border=0 width=180 height=220 src="img/ad/twma.png"></a></td>
<td rowspan=2 valign=top>
<table border=0 cellpadding=0 cellspacing=10 width="600" height="450" class=outerBox>
  <tr>
  <td valign=top><table border=0 cellpadding=4 cellspacing=0 width="100%" height="100%" class="thinBox">
    <tr><td class="topnav"><b>Aberdeen Squash Racquets Club</b>&nbsp;-&nbsp;<? echo strftime("%a %d %b %H:%M"); ?></td>

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
            ToolbarOption("events.php", "events", false, "blink");
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

    <tr><td colspan=2 width="100%" height="100%" valign=top>
<?
  showFlash();
?>