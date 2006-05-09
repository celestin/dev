<?php
/* * * * * * * * * * * * * * * * * * * * * * * *
 * Parkers Retreat
 * Copyright (c) 2006 Frontburner
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * Top of Page template
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  11-Apr-2006  File created.
 * CAM  09-May-2006  Adjustments following meeting with AL.
 * * * * * * * * * * * * * * * * * * * * * * * */

include_once 'Main.php';
$member = NULL;  if (session_is_registered('member_person')) $member = $_SESSION['member_person'];
$loggedin = session_is_registered('memberid');
$utab = NULL;          if (!empty($_GET['tab'])) $utab = $_GET['tab'];
if (empty($utab)) $utab = 1;
if (empty($tabs)) $tabs = 'ON';

if (empty($title)) {
  $title = $cfg['Site']['Name'];
} else {
  $title = $cfg['Site']['Name'] . " - $title";
}

function f_tab($tab_id, $tab_name) {
  global $utab;

  $cls = "";
  $buttoncls="stone$tab_id";
  if ($tab_id == $utab) {
    $cls = "sel";
    $buttoncls="selstone";
  }

  echo "<td class=\"$buttoncls\"><a class=\"itemnav$cls\" href=\"page.php?&tab=$tab_id\">$tab_name</a></td>";
}

?>
<head>
  <title><? echo $title;?></title>
  <link href="parkersretreat.css" rel=stylesheet type="text/css" />
  <script language="Javascript" src="date.js"></script>
</head>

<body topmargin=0 leftmargin=0>

<table border=0 cellpadding=0 cellspacing=0 width="100%">
<tr>
  <td width="50%" class="topstone">&nbsp;</td>
  <td width="259"><img src="img/pc2top.jpg" width="259" height="50"></td>
  <td width="541" align="center" class="topstone"><img src="img/pb3.gif" width="294" height="50"></td>
  <td width="50%" class="topstone">&nbsp;</td>
</tr>
<tr>
  <td rowspan=4>&nbsp;</td>
  <td align="left"><img src="img/pc2bot.jpg" height=100></td>
  <td align="center" valign="middle"><table border=0 cellpadding=0 cellspacing=0>
    <tr><td align="center"><table border=0 cellpadding=6 cellspacing=6><tr>
      <? f_tab(1, "Contact");?>
      <? f_tab(2, "Accomodation");?>
      <? f_tab(4, "Pricing");?>
      <td class="stone3">Enquiry</td>
    </table></td></tr>
    <tr><td align="center"><table border=0 cellpadding=6 cellspacing=6><tr>
      <? f_tab(5, "Local Information &amp; Attractions");?>
      <? f_tab(6, "Parker&#039;s");?>
    </table></td></tr>
  </table></td>
  <td rowspan=4>&nbsp;</td>
</tr>
<tr>
  <td colspan=2><img src="img/wid.gif" width="800" height="4"></td>
</tr>
<tr>
  <td colspan=2 width="775" valign=top class="bodybox">
