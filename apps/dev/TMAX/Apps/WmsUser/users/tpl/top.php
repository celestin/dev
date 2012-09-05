<?php
/* * * * * * * * * * * * * * * * * * * * * * * *
 * Talisman WMS Users
 * Copyright (c) 2012 Front Burner
 *
 * Top of the page
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  05-Sep-2012  11128 : Added menu options and getObjRef.
 * * * * * * * * * * * * * * * * * * * * * * * */

include_once 'Main.php';

$member = NULL;  if (session_is_registered('member_person')) $member = $_SESSION['member_person'];
$loggedin = (session_is_registered('member_person') && session_is_registered('Talisman WMS Users'));

if (empty($title)) {
  $title = $cfg['Site']['Name'];
} else {
  $title = $cfg['Site']['Name'] . " - $title";
}


?>
<head>
  <title><? echo $title;?></title>
  <link href="twms.css" rel=stylesheet type="text/css" />
  <script language="Javascript" src="date.js"></script>
  <script language="Javascript">
    function getObjRef(p_ref) {
      return document.all ? document.all[p_ref] : document.getElementById(p_ref);
    }
  </script>
</head>

<body topmargin=0 leftmargin=0>

<table border=0 cellpadding=0 cellspacing=0 align=center>
<tr><td><table border="0" cellpadding=0 cellspacing=0 width="1000" height="600" class=outerBox>
  <tr><td align="center"><img src="img/TalismanLogo-100.jpg"></td></tr>

  <tr>
  <td valign=top><table border=0 cellpadding=4 cellspacing=0 width="100%" height="100%" class="thinBox">
    <tr><td class="title"><b><? echo $cfg['Site']['Name']; ?></b>&nbsp;-&nbsp;<? echo strftime("%a %d %b %H:%M"); ?></td>

    <td class="title" align=right><?php
      if ($loggedin) {
        echo $member->toHtmlString(true);
      } else {
        echo "&nbsp;";
      }
    ?></td>

    </tr>
    <tr><td colspan=2 class="topnav"><table border=0 cellpadding=0 cellspacing=0 class="topnav">
      <tr>
        <?
          if ($loggedin) {
?>
            <td><a class="nav" href="list.php">list</a><span class="sep">|</sep></td>
<?
            if ($member->isAdmin()) {
?>
            <td><a class="nav" href="verify.php">verify</a><span class="sep">|</sep></td>
            <td><a class="nav" href="identify.php">identify</a><span class="sep">|</sep></td>
            <td><a class="nav" href="identify.php?site=12&username=CLYOTL&cid=4f542e00cc3fcb76186c26627169ae19">identify CLY</a><span class="sep">|</sep></td>
            <td><a class="nav" href="upload_tmax.php">upload TMAX</a><span class="sep">|</sep></td>
            <td><a class="nav" href="upload_ad.php">upload AD</a><span class="sep">|</sep></td>
<?
            }
?>
            <td><a class="nav" href="logout.php">logout</a><span class="sep">|</sep></td>
<?
          } else {
?>
            <td><a class="nav" href="login.php">login</a><span class="sep">|</sep></td>
<?
          }
        ?>
        <td><a class="nav" href="help.php">help</a></td>
      </tr>
    </table></td></tr>
    </table></td></tr>

    <tr><td colspan=2 width="100%" height="100%" valign=top style="padding:5px">
