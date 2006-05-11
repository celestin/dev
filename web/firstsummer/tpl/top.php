<?php
/* * * * * * * * * * * * * * * * * * * * * * * *
 * First Summerhouses
 * Copyright (c) 2006 Frontburner
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * Top of the page
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  10-Feb-2006  File created.
 * CAM  09-Mar-2006  Design begun.
 * * * * * * * * * * * * * * * * * * * * * * * */

include_once 'Main.php';
$member = NULL;  if (session_is_registered('member_person')) $member = $_SESSION['member_person'];
$loggedin = session_is_registered('memberid');

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
<head>
  <title><? echo $title;?></title>
  <link href="firstsummer.css" rel=stylesheet type="text/css" />
  <script language="Javascript" src="date.js"></script>
</head>

<body topmargin=0 leftmargin=0>

<table border=0 cellpadding=0 cellspacing=0 width="800">

  <tr>
    <td colspan=2 class="topLogo" height=75><table border=0 cellpadding=0 cellspacing=0 width="100%">
      <tr>
        <td rowspan=2 width="100%"><img width="455" height="50" src="img/first_main1.png"></td>
        <td class="fldlbl">email</td><td><a href="mailto:<? echo $cfg['Site']['Email']; ?>?Subject=Sales%20Inquiry">Sales</a></td>
      </tr><tr>
        <td class="fldlbl">tel</td><td class="fldtxt">01475&nbsp;522999</td>
      </tr>
    </table><td>
  </tr>

  <tr height="550">
    <td valign=top class="prodnav"><table border=0 cellpadding=4 cellspacing=0 width="180"><tr><td>
    <table border=0 cellpadding=3 cellspacing=0 width="100%" class="prodnav">
<?
$sql = mysql_query("SELECT id category_id,category ".
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
      <tr>
        <td class="category<? echo $cls;?>"><a class="nav<? echo $cls;?>" href="category.php?category=<? echo $category_id;?>"><? echo $category;?></a></td>
      </tr>
<?
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
?>
        <tr>
          <td><a class="itemnav<? echo $cls;?>" href="range.php?range=<? echo $range_id;?>&category=<? echo $category_id;?>"><? echo $range;?></a></td>
        </tr>
<?
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
        <tr>
          <td><img src="img/bu1.gif"><a class="itemnav<? echo $cls;?>" href="product.php?product=<? echo $product_id;?>&range=<? echo $range_id;?>&category=<? echo $category_id;?>"><? echo $product;?></a></td>
        </tr>
<?
      }
    }
  }
}
?>
    </table></td></tr></table></td>

    <td class="topnav" valign=top><table border=0 cellpadding=0 cellspacing=0 width="620" class="topnav2">
      <tr><td><table border=0 cellpadding=3 cellspacing=0 class="topnav3" width="100%">
      <tr>
      <td><a class="nav" href="index.php">home</a><span class="sep">|</sep>
      <a class="nav" href="contact.php">contact</a><!--<span class="sep">|</sep>
      <a class="nav" href="home.php">instructions</a>--></td>
      </tr>
    </table>
    </td></tr>

    <tr valign=top><td style="padding-top:5px">
