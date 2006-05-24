<?php
/* * * * * * * * * * * * * * * * * * * * * * * *
 * West Coast Express Website
 * Copyright (c) 2006 Frontburner
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * Top of the page
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  13-Apr-2006  File created.
 * * * * * * * * * * * * * * * * * * * * * * * */

include_once 'Main.php';
$member = NULL;  if (session_is_registered('member_person')) $member = $_SESSION['member_person'];
$loggedin = session_is_registered('memberid');

if (empty($title)) {
  $title = $cfg['Site']['Name'];
} else {
  $title = $cfg['Site']['Name'] . " - $title";
}


?>
<head>
  <title><? echo $title;?></title>
  <link href="wce.css" rel=stylesheet type="text/css" />
  <script language="Javascript" src="date.js"></script>
</head>

<body topmargin=8 leftmargin=0>

<table border=0 cellspacing=0 cellpadding=0 align=center>

<tr>
  <td><table border=0 cellpadding=0 cellspacing=0 class="topbanner" width=800>
    <tr>
      <td width=175 align=center><img src="img/boattrans1.jpg"></td>
      <td colspan=3 class="whitebox" align=center><img src="img/wce1.gif"></td>
      <td width=175 align=center><img src="img/parceldel1.jpg"></td>
    </tr>
    <tr>
      <td class="redbanner" align=center><a class="nav" href="index.php">BOAT TRANSPORT</a></td>
      <td class="redbanner" width=150 align=center><a class="nav" href="contact.php">CONTACT</a></td>
      <td class="redbanner" width=150 align=center><a class="nav" href="request.php">REQUEST QUOTE</a></td>
      <td class="redbanner" width=150 align=center><a class="nav" href="photos.php">PHOTOS</a></td>
      <td class="redbanner" align=center><a class="nav" href="express.php">EXPRESS DELIVERY</a></td>
    </tr>
  </table></td>
</tr>

<tr>
  <td align=center class="bodybox">
