<?php
/* * * * * * * * * * * * * * * * * * * * * * * *
 * SourceCodeMetrics.com
 * Copyright (c) 2006 SourceCodeMetrics.com
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * Top of the page
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  18-Nov-2006  File created.
 * * * * * * * * * * * * * * * * * * * * * * * */

include_once 'Main.php';
$member = NULL;  if (session_is_registered('member_person')) $member = $_SESSION['member_person'];
$loggedin = (session_is_registered('memberid') && session_is_registered('sourcecodemetrics_com'));

if (empty($title)) {
  $title = $cfg['Site']['Name'];
} else {
  $title = $cfg['Site']['Name'] . " - $title";
}

function showMenu($sMenuName, $sUrl) {
  global $menuOption;

  $sClass = "menuNormal";
  $button = "mnu" . $sMenuName;

  if (empty($menuOption) && ($sMenuName == "Home")) {
    $sClass = "menuActive";
  } else if ($menuOption == $sMenuName) {
    $sClass = "menuActive";
  }

  echo "<tr><td id=\"$button\" name=\"$button\" class=\"$sClass\"><a href=\"$sUrl\" class=\"nav\" ".
       "onMouseOver=\"scm_linkOver('$button');\" onMouseOut=\"scm_linkOut('$button');\">$sMenuName</a></td></tr>";

}


?>
<head>
  <title><? echo $title;?></title>
  <link href="scm.css" rel=stylesheet type="text/css" />
  <link rel="shortcut icon" href="sourcecodemetrics.ico" type="image/x-icon" />
  <script language="Javascript" src="date.js"></script>
  <script language="Javascript" src="visualisation.js"></script>
</head>

<body topmargin=0 leftmargin=0>

<table border=0 cellpadding=0 cellspacing=0 align=left width="800">
<tr>
  <td class="toplogo" width=680 align=center valign=middle><img src="img/scm1.png" width=374 height=33 border=0></td>
  <td width=120><img src="img/smalltape2.jpg" width=120 height=120 border=0></td>
</tr>
<?
if (1==2) {
?>
<tr>
  <td valign=top colspan=2><table border=0 cellpadding=0 cellspacing=0 class="topnav">
    <tr>
      <?
        if ($loggedin) {
?>
          <td><a class="nav" href="list.php">list</a><span class="sep">|</sep></td>
          <td><a class="nav" href="question.add.php">add question</a><span class="sep">|</sep></td>
          <td><a class="nav" href="quiz.php">quiz me</a><span class="sep">|</sep></td>
          <td><a class="nav" href="changepass.php">change password</a><span class="sep">|</sep></td>
<?
          if ($member->isAdmin()) {
?>
          <td><a class="nav" href="verify.php">verify</a><span class="sep">|</sep></td>
          <td><a class="nav" href="pdfupload.php">pdf upload</a><span class="sep">|</sep></td>
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
  </table></td>
</tr>
<?
}
?>

<tr><td colspan=2><table border=0 cellpadding=0 cellspacing=0 height=600>

<tr><td valign=top class="menuBackground"><table border=0 cellpadding=0 cellspacing=4 width=150>

<? showMenu("Home", "index.php"); ?>
<tr><td><img src="img/f.gif" height=5></td></tr>
<? showMenu("Products", "products.php"); ?>
<tr><td><img src="img/f.gif" height=5></td></tr>
<? showMenu("Download", "download.php"); ?>
<tr><td><img src="img/f.gif" height=5></td></tr>
<? showMenu("Contact", "contact.php"); ?>
<tr><td><img src="img/f.gif" height=5></td></tr>

</table></td> <!-- menu navigation -->

<td width="100%" height="100%" valign=top style="padding:5px">
