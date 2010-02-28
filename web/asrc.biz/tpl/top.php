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
  <link href="asrc3.css" rel=stylesheet type="text/css" />
  <script language="Javascript" src="dhtml.js"></script>
  <script language="Javascript" src="date.js"></script>
</head>

<body topmargin=0 leftmargin=0>

<table border=0 cellpadding=0 cellspacing=0 width="100%">
<tr><td align="center"><table border=0 cellpadding=0 cellspacing=0>
<tr><td><table id="main" border=0 cellpadding=2 cellspacing=0 bgcolor="white">
<tr><td colspan=3>
<div id="header">
      <object classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" width="574" height="74" class="header-left" id="FlashID">
              <param name="movie" value="img/ad/orion_574x74.swf" />
              <param name="quality" value="high" />
              <param name="wmode" value="opaque" />
              <param name="swfversion" value="8.0.35.0" />
              <!-- This param tag prompts users with Flash Player 6.0 r65 and higher to download the latest version of Flash Player. Delete it if you don’t want users to see the prompt. -->
              <param name="expressinstall" value="Scripts/expressInstall.swf" />
              <!-- Next object tag is for non-IE browsers. So hide it from IE using IECC. -->
              <!--[if !IE]>-->
              <object type="application/x-shockwave-flash" data="img/ad/orion_574x74.swf" width="574" height="74">
                <!--<![endif]-->
                <param name="quality" value="high" />
                <param name="wmode" value="opaque" />
                <param name="swfversion" value="8.0.35.0" />
                <param name="expressinstall" value="Scripts/expressInstall.swf" />
                <!-- The browser displays the following alternative content for users with Flash Player 6.0 and older. -->
                <div>
                  <h4>Content on this page requires a newer version of Adobe Flash Player.</h4>
                  <p><a href="http://www.adobe.com/go/getflashplayer"><img src="http://www.adobe.com/images/shared/download_buttons/get_flash_player.gif" alt="Get Adobe Flash player" width="112" height="33" /></a></p>
                  </div>
                <!--[if !IE]>-->
                </object>
              <!--<![endif]-->
          </object>
      <img class="header-right" alt="" src="img/ad/league.gif">
</div>
<table id="asrc-logo" bgcolor="black" width="984" height="159" border="0" cellpadding="0" cellspacing="0">
  <tr>
    <td colspan="5"><img src="img/logo/spacer.gif" width="717" height="57" alt=""></td>
    <td rowspan="5"><img src="img/logo/Racquet.gif" width="24" height="158" alt=""></td>
    <td rowspan="3"><img src="img/logo/Ball.gif" width="95" height="108" alt=""></td>
    <td rowspan="5"><img src="img/logo/Racquet-05.gif" width="148" height="158" alt=""></td>
  </tr>
  <tr>
    <td rowspan="4"><img src="img/logo/spacer.gif" width="22" height="101" alt=""></td>
    <td rowspan="3"><img src="img/logo/Logo.gif" width="66" height="78" alt=""></td>
    <td colspan="3"><img src="img/logo/spacer.gif" width="629" height="14" alt=""></td>
  </tr>
  <tr>
    <td><img src="img/logo/Aberdeen.gif" width="148" height="37" alt=""></td>
    <td colspan="2"><img src="img/logo/spacer.gif" width="481" height="37" alt=""></td>
  </tr>
  <tr>
    <td colspan="2"><img src="img/logo/SRC.gif" width="242" height="27" alt=""></td>
    <td rowspan="2"><img src="img/logo/spacer.gif" width="387" height="50" alt=""></td>
    <td rowspan="2"><img src="img/logo/Racquet-13.gif" width="95" height="50" alt=""></td>
  </tr>
  <tr>
    <td colspan="3"><img src="img/logo/spacer.gif" width="308" height="23" alt=""></td>
  </tr>
  <tr>
    <td><img src="img/logo/spacer.gif" width="22" height="1" alt=""></td>
    <td><img src="img/logo/spacer.gif" width="66" height="1" alt=""></td>
    <td><img src="img/logo/spacer.gif" width="148" height="1" alt=""></td>
    <td><img src="img/logo/spacer.gif" width="94" height="1" alt=""></td>
    <td><img src="img/logo/spacer.gif" width="387" height="1" alt=""></td>
    <td><img src="img/logo/spacer.gif" width="24" height="1" alt=""></td>
    <td><img src="img/logo/spacer.gif" width="95" height="1" alt=""></td>
    <td><img src="img/logo/spacer.gif" width="148" height="1" alt=""></td>
  </tr>
</table>
</td></tr>

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