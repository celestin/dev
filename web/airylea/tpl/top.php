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
 * CAM  18-Sep-2008  10280 : Added Suppliers.
 * CAM  05-Feb-2009  10280 : Converted Topbar to Div and added Navbar.
 * CAM  14-Mar-2009  10334 : Use new Bosch logo.
 * CAM  11-Aug-2009  10467 : Implemented First Found recommendations.
 * * * * * * * * * * * * * * * * * * * * * * * */

include_once 'Main.php';
$member = NULL;  if (session_is_registered('member_person')) $member = $_SESSION['member_person'];
$loggedin = (session_is_registered('memberid') && session_is_registered('airylea_co_uk'));

$pageTitle = $cfg['Site']['Name'];

if (!empty($title)) {
  $pageTitle = $cfg['Site']['Name'] . " - $title";
}

$pageTitle .= ", " . $cfg['Site']['Location'];

$toolbar = "none";
if ($loggedin || (endsWith($_SERVER['REQUEST_URI'], "login.php"))) {
  $toolbar = "inline";
}
?>
<html>
<head>
  <title><? echo $pageTitle;?></title>
  <link rel="stylesheet" href="css/airylea.css" type="text/css" media="screen" />
  <link rel="stylesheet" href="css/lightbox.css" type="text/css" media="screen" />

  <script type="text/javascript" src="js/date.js"></script>
  <script type="text/javascript" src="js/ajax.js"></script>
  <script type="text/javascript" src="js/prototype.js"></script>
  <script type="text/javascript" src="js/scriptaculous.js?load=effects,builder"></script>
  <script type="text/javascript" src="js/lightbox.js"></script>

</head>
<body topmargin=0 leftmargin=0<?
if (!empty($pageId)) {
  echo " id=\"page_$pageId\"";
}
?>>
<table border=0 cellspacing=0 cellpadding=0 align=center width=1000><tr>
<td valign=top><table border=0 cellspacing=0 cellpadding=0 align=center width="100%">

<tr>
  <td colspan=2><table border=0 cellpadding=0 cellspacing=0 id="topbanner" width="100%">
    <tr>
      <td align=right id="toolbar" height=10><table id="tbtab" style="display:<? echo $toolbar; ?>" border=0 cellpadding=5 cellspacing=0>
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
      <td><table cellpadding=0 cellspacing=8 id="toplogo" width="100%">
        <tr>
          <td width=232 class="whitebox" align=left><img onclick="toogleToolbar();" src="img/am3.png"></td>
          <td align=right><table border=0 cellpadding=4 cellspacing=8>
            <tr>
              <td><a href="bosch.php"><img border=0 src="img/logo/m/supp_bdc.png"></a></td>
              <td><a href="delphi.php"><img border=0 src="img/logo/m/supp_delphi.gif"></a></td>
              <td align=right><a href="lorange.php"><img border=0 src="img/logo/m/supp_lorange.png"></a></td>
            </tr><tr>
              <td>&nbsp;</td>
              <td align=center><a href="woodward.php"><img border=0 src="img/logo/m/supp_woodward.gif"></a></td>
              <td><a href="stanadyne.php"><img border=0 src="img/logo/m/supp_stanadyne.gif"></a></td>
            </tr>
          </table></td>
        </tr>
      </table></td>
    </tr>
    <tr>
      <td class="topbar">
        <div id="topbar">
          <ul>
            <li><a id="link_home" href="index.php">Home</a></li>
            <li><a id="link_services" href="services.php">Services</a></li>
            <li><a id="link_history" href="history.php">History</a></li>
            <li><a id="link_contact" href="contact.php">Contact</a></li>
          </ul>
        </div>
      </td>
    </tr>
  </table></td>
</tr>

<tr>
  <td width="160" class="navbar" valign="top">
    <div id="navbar">
      <ul>
        <li><a id="link_cars" href="cars.php">Cars</a></li>
        <li><a id="link_agricultural" href="agricultural.php">Agricultural</a></li>
        <li><a id="link_marine" href="marine.php">Marine</a></li>
        <li><a id="link_commercial" href="commercial.php">Commercial</a></li>
        <li><a id="link_plant" href="plant.php">Plant</a></li>
      </ul>
    </div>
  </td>
  <td align=center class="bodybox">
