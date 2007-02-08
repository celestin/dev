<?php
/* * * * * * * * * * * * * * * * * * * * * * * *
 * ASRC.biz (Aberdeen Squash Racquets Club)
 * Copyright (c) 2006-2007 Frontburner
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * Top of the page
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  19-Mar-2004  File created.
 * CAM  30-May-2004  4 : Added Fines menu.
 * CAM  25-Apr-2006  14 : Show Courts View to admin toolbar.
 * CAM  29-Jul-2006  10021 : Show flash messages if they exist.
 * * * * * * * * * * * * * * * * * * * * * * * */

include_once 'Main.php';
$member = NULL;  if (session_is_registered('member_person')) $member = $_SESSION['member_person'];
$loggedin = session_is_registered('memberid');

if (empty($title)) {
  $title = "ASRC Online Booking";
}

if (empty($hide_toolbar)) {
  $hide_toolbar = false;
}


?>
<head>
  <title><?php print $title;?></title>
  <link href="asrc.css" rel=stylesheet type="text/css" />
  <script language="Javascript" src="date.js"></script>
</head>

<body topmargin=2 leftmargin=0>

<table border=0 cellpadding=0 cellspacing=0>
<tr><td><table border=0 cellpadding=0 cellspacing=8>
<tr><td align=center valign=top><a target="_blank" href="http://www.aberdeen-drilling.com/"><img border=0 width=180 height=220 src="img/ad/ads1.gif"></a></td>
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
    <tr><td colspan=2 class="topnav" height=30><table border=0 cellpadding=0 cellspacing=0>
      <tr>
        <?php
          if ($loggedin && !$hide_toolbar) {
            $bookDesc = "my";
            if ($member->isAdmin()) {
              $bookDesc = "";
            }
            print '<td><a href="mybookings.php">' . $bookDesc . ' bookings</a>&nbsp;&nbsp;|&nbsp;&nbsp;</td>';
            print '<td><a href="newbooking.php">make booking</a>&nbsp;&nbsp;|&nbsp;&nbsp;</td>';
            if ($member->isAdmin()) {
              print '<td><a href="fines.php">fines</a>&nbsp;&nbsp;|&nbsp;&nbsp;</td>';
            }
            print '<td><a href="logout.php">logout</a>&nbsp;&nbsp;|&nbsp;&nbsp;</td>';
            print '<td><a href="changepass.php">change password</a>&nbsp;&nbsp;|&nbsp;&nbsp;</td>';
            if ($member->isAdmin()) {
              print '<td><a href="users.php">users</a>&nbsp;&nbsp;|&nbsp;&nbsp;</td>';
              print '<td><a href="courtsview.php">courts</a>&nbsp;&nbsp;|&nbsp;&nbsp;</td>';
            }
          } else {
            print '<td><a href="login.php">login</a>&nbsp;&nbsp;|&nbsp;&nbsp;</td>';
          }
        ?>
        <td><a href="help.php">help</a></td>
      </tr>
    </table></td></tr>
    </table></td></tr>

    <tr><td colspan=2 width="100%" height="100%" valign=top>
<?
if (session_is_registered('flash') && !empty($_SESSION['flash'])) {
  Msg::statement($_SESSION['flash']);
  $_SESSION['flash'] = "";
}
?>