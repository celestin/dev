<?php
/* * * * * * * * * * * * * * * * * * * * * * * *
 * Ministry Search Engine
 * Copyright (c) 2007 frontburner.co.uk
 *
 * Top of the page
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  29-Jul-2007  File created.
 * * * * * * * * * * * * * * * * * * * * * * * */

include_once 'Main.php';
$member = NULL;  if (session_is_registered('member_person')) $member = $_SESSION['member_person'];
$loggedin = (session_is_registered('memberid') && session_is_registered('Ministry Search Engine'));
global $tab,$tabs;

if (empty($title)) {
  $title = $cfg['Site']['Name'];
} else {
  $title = $cfg['Site']['Name'] . " - $title";
}


?>
<head>
  <title><? echo $title;?></title>
  <link href="mse.css" rel=stylesheet type="text/css" />
  <script language="Javascript" src="date.js"></script>
</head>

<body topmargin=2 leftmargin=0>

<table border=0 cellpadding=0 cellspacing=0 align=center cols=3>
<tr><td><table border=0 cellpadding=0 cellspacing=0 class=outerBox width="900">
  <tr>
    <td class="topnav"><img src="img/f.gif" border=0 width=500 height=0></td>
    <td class="topnav"><img src="img/f.gif" border=0 width=20 height=0></td>
    <td class="topnav"><img src="img/f.gif" border=0 width=460 height=0></td>
  </tr>
  <tr>
  <td valign=top colspan=3><table border=0 cellpadding=0 cellspacing=0 width="100%" height="100%" class="topnav">
    <tr><td rowspan=2><b><? echo str_replace(" ", "&nbsp;", $cfg['Site']['Name']); ?></b></td>

    <td width="100%" class="loggedin" align=right><?php
      if ($loggedin) {
        echo "Logged in as <b>" . $member->getFullname() . "</b>";
      } else {
        echo "&nbsp;";
      }
    ?></td>

    </tr>
    <tr><td><table border=0 cellpadding=0 cellspacing=0 class="topnav" align=right>
      <tr>
        <td><a class="nav" href="index.php">new search</a><span class="sep">|</sep></td>
        <?
          if ($loggedin) {
            // Nothing currently
?>
<?
            if ($member->isAdmin()) {
            // Nothing currently
?>
<?
            }
?>
            <td><a class="nav" href="logout.php">logout</a><span class="sep">|</sep></td>
<?
          } else {
?>
            <td><a class="nav" href="login.php">login</a><span class="sep">|</sep></td>
            <td><a class="nav" href="register.php">register</a><span class="sep">|</sep></td>
<?
          }
        ?>
        <td><a class="nav" href="help.php">help</a></td>
      </tr>
    </table></td></tr>

<?
    if ($tabs) {
      $className = $tab . "border";
?>
    <tr><td colspan=3><? include 'tpl/tabs.php'; ?></td></tr>
<?
    } else {
      $className = "mainborder";
?>
    <tr><td colspan=3><img src="img/f.gif" height=10></td></tr>
<?
    }
?>
    </table></td></tr>

    <tr><td colspan=3 width="100%" height="100%" valign=top class="<? echo $className; ?>">