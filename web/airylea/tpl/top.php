<?php
/* * * * * * * * * * * * * * * * * * * * * * * *
 * Airylea Motors Website
 * Copyright (c) 2008 Frontburner
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * Top of the page
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  28-Aug-2008  10280 : File created.
 * * * * * * * * * * * * * * * * * * * * * * * */

include_once 'Main.php';
$member = NULL;  if (session_is_registered('member_person')) $member = $_SESSION['member_person'];
$loggedin = (session_is_registered('memberid') && session_is_registered('airylea_co_uk'));

if (empty($title)) {
  $title = $cfg['Site']['Name'];
} else {
  $title = $cfg['Site']['Name'] . " - $title";
}

$toolbar = "none";
if ($loggedin || (endsWith($_SERVER['REQUEST_URI'], "login.php"))) {
  $toolbar = "inline";
}

$boattrans_idx = ((rand()%2)+2);  // a number between 2 and 3

?>
<html>
<head>
  <title><? echo $title;?></title>
  <link href="airylea.css" rel=stylesheet type="text/css" />
  <script language="Javascript" src="date.js"></script>
  <script language="Javascript" src="ajax.js"></script>
</head>
<body topmargin=0 leftmargin=0>
<table border=0 cellspacing=0 cellpadding=0 align=center width=1000><tr>
<td valign=top><table border=0 cellspacing=0 cellpadding=0 align=center>

<tr>
  <td colspan=2><table border=0 cellpadding=0 cellspacing=0 id="topbanner">
    <tr>
      <td align=right id="toolbar" colspan=6 height=10><table id="tbtab" style="display:<? echo $toolbar; ?>" border=0 cellpadding=5 cellspacing=0>
        <tr height=24>
<?
if (!$loggedin) {
?>
          <td><a class="tbr" href="login.php">LOGIN</a></td>
<?
}
if ($loggedin) {
?>
          <td><a class="tbr" href="changepass.php">CHANGE PASSWORD</a></td>
          <td><a class="tbr" href="logout.php">LOGOUT</a></td>
<?
}
?>
        </tr>
      </table></td>
    </tr>
    <tr>
      <td colspan=5><table cellpadding=0 cellspacing=8 id="toplogo" width="100%">
        <tr>
          <td width=232 class="whitebox" align=left><img onclick="toogleToolbar();" src="img/am3.png"></td>
          <td align=right><table border=0 cellpadding=4 cellspacing=8>
            <tr>
              <td><img src="img/logo/m/supp_bosch.gif"></td>
              <td><img src="img/logo/m/supp_delphi.gif"></td>
              <td align=right><img src="img/logo/m/supp_lorange2.png"></td>
            </tr><tr>
              <td>&nbsp;</td>
              <td align=center><img src="img/logo/m/supp_woodward.gif"></td>
              <td><img src="img/logo/m/supp_stanadyne.gif"></td>
            </tr>
          </table></td>
        </tr>
      </table></td>
    </tr>
    <tr height=26>
      <td class="redbanner" width=200 align=center><a class="nav" href="index.php">HOME</a></td>
      <td class="redbanner" width=200 align=center><a class="nav" href="contact.php">SERVICES</a></td>
      <td class="redbanner" width=200 align=center><a class="nav" href="contact.php">SUPPLIERS</a></td>
      <td class="redbanner" width=200 align=center><a class="nav" href="history.php">HISTORY</a></td>
      <td class="redbanner" width=200 align=center><a class="nav" href="contact.php">CONTACT</a></td>
    </tr>
  </table></td>
</tr>

<tr>
  <td width="200" id="navbar">&nbsp;</td>
  <td align=center class="bodybox">
