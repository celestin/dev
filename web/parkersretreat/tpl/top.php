<?php
/* * * * * * * * * * * * * * * * * * * * * * * *
 * Top of the page
 * Copyright (c) 2006 frontburner.co.uk
 *
 * $Log: /web/parkersretreat/tpl/top.php $
 * 
 * 1     23/04/06 21:28 Craig
 *
 * Who  When         Why
 * CAM  11-Apr-2006  File created.
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

?>
<head>
  <title><? echo $title;?></title>
  <link href="parkersretreat.css" rel=stylesheet type="text/css" />
  <script language="Javascript" src="date.js"></script>
</head>

<body topmargin=0 leftmargin=0>

<table border=0 cellpadding=0 cellspacing=0 align=center>
<tr><td><table border=0 cellpadding=0 cellspacing=0 width="800" height="600" class=outerBox>
  <tr>
  <td valign=top><table border=0 cellpadding=0 cellspacing=0 width="100%" height="100%" class="tabtop">
    <tr>
      <td><img src="img/p2.gif" height=225 width=800></td>
    </tr>

    <tr>
      <td><table border=0 cellpadding=2 cellspacing=0 class="tabtop" BACKGROUND="img/p3.gif"><tr>
<?
  if ($tabs == "ON") {
    $prev = false;
    $sql2 = mysql_query("SELECT id tab_id,tab ".
                       "FROM tabs ".
                       "ORDER BY disporder");

    while ($row2 = mysql_fetch_array($sql2)) {
      foreach($row2 AS $key2 => $val) {
        $$key2 = stripslashes($val);
      }

      $cls = "";
      if ($tab_id == $utab) {
        $cls = "sel";
      }
?>
        <td class="tabspace"><img width=8 src="img/f.gif"></td>
        <td class="tab<? echo $cls;?>"><a class="itemnav<? echo $cls;?>" href="page.php?&tab=<? echo $tab_id;?>"><? echo $tab;?></a></td>
<?

      $prev = true;
    }
  } else {
?>
        <td class="tabspace"><img width=8 src="img/f.gif"></td>
<?
  }
?>
        <td class="tabspace" width="100%"><img src="img/f.gif"></td>
      </tr></table></td>
    </tr>

    </table></td></tr>

    <tr><td colspan=2 width="100%" height="100%" valign=top class="bodybox">
