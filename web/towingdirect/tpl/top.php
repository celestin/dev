<?php
/* * * * * * * * * * * * * * * * * * * * * * * *
 * TowingDirect Website
 * Copyright (c) 2012 Front Burner
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * Top of the page
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  17-Jan-2012  11077 : Changed CSS file to TD.css
 * * * * * * * * * * * * * * * * * * * * * * * */

include_once 'Main.php';
$member = NULL;  if (session_is_registered('member_person')) $member = $_SESSION['member_person'];
$loggedin = (session_is_registered('memberid') && session_is_registered('westcoastexpress_net'));

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
  <link href="td.css" rel=stylesheet type="text/css" />
  <script language="Javascript" src="date.js"></script>
  <script language="Javascript" src="ajax.js"></script>
</head>
<body topmargin=8 leftmargin=0>
<table border=0 cellspacing=0 cellpadding=0 align=center ><tr>
<td valign=top><table border=0 cellspacing=0 cellpadding=0 align=center>

<tr>
  <td><table border=0 cellpadding=0 cellspacing=0 class="topbanner" width=800>
    <tr>
      <td align=right class="toolbar" colspan=5 height=10 id="tb"><table id="tbtab" style="display:<? echo $toolbar; ?>" border=0 cellpadding=5 cellspacing=0>
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
      <td width=175 align=center><img src="img/boattrans<? echo $boattrans_idx; ?>.jpg"></td>
      <td colspan=3 class="whitebox" align=center><a href="<?=$cfg['Site']['URL']?>"><img border="0" src="img/wce1.gif"></a></td>
      <td width=175 align=center><img onclick="toogleToolbar();" src="img/boattrans4.png"></td>
    </tr>
    <tr height=26>
      <td class="redbanner" align=center><a class="nav" href="index.php">CAR TRANSPORT</a></td>
      <td class="redbanner" align=center><a class="nav" href="feedback.php">FEEDBACK</a></td>
      <td class="redbanner" width=150 align=center><a class="nav" href="contact.php">CONTACT US</a></td>
      <td class="redbanner" width=150 align=center><a class="nav" href="request.php">REQUEST QUOTE</a></td>
      <td class="redbanner" width=150 align=center><a class="nav" href="photos.php">PHOTOS</a></td>
    </tr>
  </table></td>
</tr>

<tr>
  <td align=center class="bodybox">
