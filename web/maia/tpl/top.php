<?php
/* * * * * * * * * * * * * * * * * * * * * * * *
 * Top of the page
 * Copyright (c) 2006 frontburner.co.uk
 *
 * $Log: /web/maia/tpl/top.php $
 * 
 * 2     3/02/06 20:42 Craig
 *
 * 1     3/02/06 1:53 Craig
 * 1000
 *
 * Who  When         Why
 * CAM  02-Feb-2006  File created.
 * * * * * * * * * * * * * * * * * * * * * * * */

include_once 'Main.php';
$member = NULL;  if (session_is_registered('member_person')) $member = $_SESSION['member_person'];
$loggedin = session_is_registered('memberid');

if (empty($title)) {
  $title = $cfg['Site']['Name'];
} else {
  $title = $cfg['Site']['Name'] . " - $title";
}

$section1 = NULL;          if (!empty($_GET['section1'])) $section1 = $_GET['section1'];
$section2 = NULL;          if (!empty($_GET['section2'])) $section2 = $_GET['section2'];
$section3 = NULL;          if (!empty($_GET['section3'])) $section3 = $_GET['section3'];
$editsection = NULL;       if (!empty($_GET['editsection'])) $editsection = $_GET['editsection'];

function f_section_sql($section='') {
  $rval = "SELECT section,sec_parent,sec_name,source,text ".
          "FROM section ";

  if (empty($section)) {
    $rval .= "WHERE sec_parent IS NULL ";
  } else {
    $rval .= "WHERE sec_parent = '$section' ";
  }

  $rval .= "ORDER BY sort_order ";
  return $rval;
}

?>
<head>
  <title><? echo $title;?></title>
  <link href="maia.css" rel=stylesheet type="text/css" />
  <script language="Javascript" src="date.js"></script>
</head>

<body topmargin=2 leftmargin=5>

<table border=0 cellpadding=0 cellspacing=0 align=left>
<tr><td><table border=0 cellpadding=0 cellspacing=0 height="450" class=outerBox>
  <tr>
    <td align=center colspan=2><table border=0 cellspacing=0 cellpadding=0>
    <tr>
      <td valign=bottom height=40><table border=0 cellspacing=0 cellpadding=0 width="100%">
        <tr>
          <td class="topnav" valign=bottom><table border=0 cellpadding=0 cellspacing=0 class="topnav">
            <tr><td>&nbsp;</td>
              <?
                if ($loggedin) {
?>
                  <td><a class="nav" href="changepass.php">Change Password</a><span class="sep">|</sep></td>
<?
                  if ($member->isAdmin()) {
?>
                  <td><a class="nav" href="fileupload.php">PDF Upload</a><span class="sep">|</sep></td>
<?
                    if (!empty($editsection)) {
?>
                  <td><a class="nav" href="edit.php?<? echo f_url($editsection);?>">Edit Page</a><span class="sep">|</sep></td>
<?
                    }
                  }
?>
                  <td><a class="nav" href="logout.php">Logout</a><span class="dummysep">|</sep></td>
<?
                } else {
?>
                  <td><a class="nav" href="login.php">Login</a><span class="sep">|</sep></td>
                  <td><a class="nav" href="register.php">Register</a><span class="dummysep">|</sep></td>
<?
                }
              ?>
            </tr></table></td>
          </tr></table></td>
        <td rowspan=2 height=75 valign=bottom><img src="img/maia2b.gif"></td>
      </tr>
      <tr><td height=34 valign=bottom><img src="img/maia2a.gif" ></td></tr>
    </table></td>
  </tr>

  <tr>
    <td class="navbox" width="200" valign=top><table border=0 cellpadding=0 cellspacing=0 width="100%">
      <tr>
        <td><a href="login.php"><img border=0 src="img/maia1sm.gif"></td><td width="100%" class="navboxtitle"><?
          if ($loggedin) {
            echo $member->toString(false);
          } else {
            echo strftime("%a %d %b");
          }
        ?></td>
      </tr>
      <tr><td colspan=2 align=left><ul class="menu"><?

$msource = "";
$mtext = "";

$sql = mysql_query(f_section_sql());
while ($row = mysql_fetch_array($sql)) {
  foreach($row AS $key => $val) {
    $$key = stripslashes($val);
  }
?><li class="menu"><a <? f_class($section);?> href="index.php?section1=<? echo f_admin($section);?>"><? echo $sec_name;?></a></li><?

  if ($section == $section1) {
    $msource = $source;  $mtext = $text;

    $sql2 = mysql_query(f_section_sql($section));
    $level2 = (mysql_num_rows($sql2)>0);
    if ($level2) { ?><ul class="menu"><? }
    while ($row2 = mysql_fetch_array($sql2)) {
      foreach($row2 AS $key2 => $val2) {
        $$key2 = stripslashes($val2);
      }

?><li class="menu"><a <? f_class($section);?> href="index.php?section1=<? echo $section1;?>&section2=<? echo f_admin($section);?>"><? echo $sec_name;?></a></li><?
      if ($section == $section2) {
        $msource = $source;  $mtext = $text;

        $sql3 = mysql_query(f_section_sql($section));
        $level3 = (mysql_num_rows($sql3)>0);
        if ($level3) { ?><ul class="menu"><? }
        while ($row3 = mysql_fetch_array($sql3)) {
          foreach($row3 AS $key3 => $val3) {
            $$key3 = stripslashes($val3);
          }

          if ($section == $section3) {
            $msource = $source;  $mtext = $text;
          }

?><li class="menu"><a <? f_class($section);?> href="index.php?section1=<? echo $section1;?>&section2=<? echo $section2;?>&section3=<? echo f_admin($section);?>"><? echo $sec_name;?></a></li><?
        }
        if ($level3) { ?></ul><? }
      }
    }
    if ($level2) { ?></ul><? }
  }
}
      ?></td></tr>
    </table></td>
    <td width="560" height="100%" valign=top style="padding:10px">
