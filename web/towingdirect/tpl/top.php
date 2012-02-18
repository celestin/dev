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
 * CAM  23-Jan-2012  11085 : Added Towing link
 * CAM  01-Feb-2012  11077 : Changed layout for new Carried Safely.
 * CAM  18-Feb-2012  11084 : Enabled logo override.
 * * * * * * * * * * * * * * * * * * * * * * * */

include_once 'Main.php';
$member = NULL;  if (session_is_registered('member_person')) $member = $_SESSION['member_person'];
$loggedin = (session_is_registered('memberid') && session_is_registered('westcoastexpress_net'));

if (empty($title)) {
  $title = $cfg['Site']['Name'];
} else {
  $title = $cfg['Site']['Name'] . " - $title";
}

if (empty($logo)) {
	$logo = "cs2.png";
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
  <td colspan=2><table border=0 cellpadding=0 cellspacing=0 class="topbanner" width=1000>
    <tr>
      <td align=right class="toolbar" colspan=6 height=10 id="tb"><table id="tbtab" style="display:<? echo $toolbar; ?>" border=0 cellpadding=5 cellspacing=0>
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
      <td width=175 align=center><img src="img/car<? echo $boattrans_idx; ?>.png"></td>
      <td class="whitebox" align=center><a href="<?=$cfg['Site']['URL']?>"><img border="0" src="img/<?=$logo?>"></a></td>
      <td width=175 align=center><img onclick="toogleToolbar();" src="img/car4.png"></td>
    </tr>
  </table></td>
</tr>

    <tr>
      <td align=right class="tbshadow" colspan=6 height=5 id="tb"></td>
    </tr>

<tr>
  <td width="175" valign="top" class="mnubar">
  	<div id="mnu">
    	<ul>
    		<li><a href="index.php">CAR TRANSPORT</a></li>
    		<li><a href="feedback.php">FEEDBACK</a></li>
    		<li><a href="contact.php">CONTACT US</a></li>
    		<li><a href="request.php">REQUEST QUOTE</a></li>
    		<li><a href="photos.php">PHOTOS</a></li>
    		<li><a href="towing.php">TOWING</a></li>
    	</ul>
    </div>
  </td>

  <td align=center class="bodybox">
