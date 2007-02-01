<?php
/* * * * * * * * * * * * * * * * * * * * * * * *
 * First Summerhouses
 * Copyright (c) 2006-2007 Frontburner
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * Top of the page
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  10-Feb-2006  File created.
 * CAM  09-Mar-2006  Design begun.
 * CAM  02-Oct-2006  10037 : Added login by clicking on logo.
 * CAM  04-Oct-2006  10046 : Remove ranges from navigation where Category show_ranges<>1.
 * CAM  04-Oct-2006  10047 : Add Change Password.
 * CAM  21-Dec-2006  10071 : Added meta tags.
 * CAM  01-Feb-2007  10081 : Added Testimonals link.
 * * * * * * * * * * * * * * * * * * * * * * * */

include_once 'Main.php';
$member = NULL;  if (session_is_registered('member_person')) $member = $_SESSION['member_person'];
$loggedin = (session_is_registered('memberid') && session_is_registered('1stsummerhouses_com'));

global $cfg;
global $productname;

if (empty($title)) {
  $title = $cfg['Site']['Name'];
} else {
  $title = $cfg['Site']['Name'] . " - $title";
}

if (!isset($ucategory)) {
  $ucategory = NULL;          if (!empty($_GET['category'])) $ucategory = $_GET['category'];
}
if (!isset($urange)) {
  $urange = NULL;             if (!empty($_GET['range'])) $urange = $_GET['range'];
}
$uproduct = NULL;           if (!empty($_GET['product'])) $uproduct = $_GET['product'];

?>
<html>
<head>
  <title><? echo $title;?></title>
  <link href="firstsummer.css" rel=stylesheet type="text/css" />
  <link rel="shortcut icon" href="img/ico/firstsummer.ico" type="image/x-icon" />

  <meta name="description " content="We construct high quality log cabins homes that blend beautifully into natural settings, creating a unique living environment. Our exclusive versatile designs  bringing together an extensive selection of comfortable and affordable authentic log cabin homes.">
  <meta http-equiv=Content-Type content="text/html; charset=iso-8859-1">
  <meta name="Language" content="en-gb">

  <script language="Javascript" src="date.js"></script>
  <script language="Javascript" src="contact.js"></script>
  <script language="Javascript" src="photo.js"></script>
<?
  if (!empty($productname)) {
?>
  <script language="Javascript">gblProduct = "<? echo $productname; ?>";</script>
<?
  }
?>
</head>
<body topmargin=0 leftmargin=0>
<table border=0 cellpadding=0 cellspacing=0 width="800">
  <tr>
    <td colspan=2 class="topLogo" height=75><table border=0 cellpadding=0 cellspacing=0 width="100%">
      <tr>
        <td rowspan=2 width="560"><img width="455" height="50" src="img/first_main1.png" onclick="top.location.href='login.php';"></td>
        <td class="toplbl" width="100" valign=bottom>email</td><td valign=bottom><a class="topemail" href="mailto:<? echo $cfg['Site']['Email']; ?>?Subject=Sales%20Inquiry">Sales</a></td>
      </tr><tr>
        <td class="toplbl">tel</td><td class="toptxt">01475&nbsp;522999</td>
      </tr><tr>
        <td colspan=3 style="padding-top:5px;padding-bottom:1px;"><a style="padding-left: 95px;"
            class="menu" href="index.php">home</a><span class="sep">|</span><a
            class="menu" href="about.php">about us</a><span class="sep">|</span><a
            class="menu" href="testimonals.php">testimonals</a><span class="sep">|</span><!--<a
            class="menu" href="resellers.php">find a reseller</a><span class="sep">|</span>--><a
            class="menu" href="contact.php">contact</a><?
          if ($loggedin) {
              ?><span class="sep">|</span><a
              class="menu" href="changepass.php">change password</a><span class="sep">|</span><a
              class="menu" href="logout.php">logout</a><?
          }
              ?>

        </td>
      </tr>
    </table><td>
  </tr>

  <tr height="550">
    <td valign=top class="prodnav"><table border=0 cellpadding=4 cellspacing=0 width="180"><tr><td>
    <table border=0 cellpadding=3 cellspacing=0 width="100%" class="prodnav">
<?
$sql = mysql_query("SELECT id category_id,category,show_ranges ".
                   "FROM categories ".
                   "ORDER BY disporder");

while ($row = mysql_fetch_array($sql)) {
  foreach($row AS $key => $val) {
    $$key = stripslashes($val);
  }

  $cls = "";
  if ($category_id == $ucategory) {
    $cls = "sel";
  }
?>
<tr><td class="category<? echo $cls;?>"><a class="nav<? echo $cls;?>" href="category.php?category=<? echo $category_id;?>"><? echo $category;?></a></td></tr>
<?

  if (($category_id <> $ucategory) && ($show_ranges <> '1')) {
    // For categories with only one range, just show a blank space
?>
<tr><td style="height:2px;"></td></tr>
<?
  }

  $sql2 = mysql_query("SELECT id range_id,range ".
                     "FROM prodranges ".
                     "WHERE category_id='$category_id'".
                     "ORDER BY disporder");

  while ($row2 = mysql_fetch_array($sql2)) {
    foreach($row2 AS $key2 => $val) {
      $$key2 = stripslashes($val);
    }

    $cls = "";
    if ($range_id == $urange) {
      $cls = "sel";
    }

    if ($show_ranges === '1') {
?>
<tr><td><a class="itemnav<? echo $cls;?>" href="range.php?range=<? echo $range_id;?>&category=<? echo $category_id;?>"><? echo $range;?></a></td></tr>
<?
    }

    if ($range_id == $urange) {
      $sql3 = mysql_query("SELECT id product_id,product ".
                         "FROM products ".
                         "WHERE prodrange_id='$range_id'".
                         "ORDER BY disporder");

      while ($row3 = mysql_fetch_array($sql3)) {
        foreach($row3 AS $key3 => $val) {
          $$key3 = stripslashes($val);
        }

        $cls = "";
        if ($product_id == $uproduct) {
          $cls = "sel";
        }
?>
<tr><td><img src="img/bu1.gif"><a class="itemnav<? echo $cls;?>" href="product.php?product=<? echo $product_id;?>&range=<? echo $range_id;?>&category=<? echo $category_id;?>"><? echo $product;?></a></td></tr>
<?
      }
    }
  }
}
?>
    </table></td></tr></table></td>

    <td class="topnav" valign=top><table border=0 cellpadding=0 cellspacing=0 width="620" class="topnav2">
    <tr valign=top><td>