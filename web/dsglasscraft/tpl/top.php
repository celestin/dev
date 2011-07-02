<?php
/* * * * * * * * * * * * * * * * * * * * * * * *
 * Dunc Smith Glasscraft
 * Copyright (c) 2009,2010 Dunc Smith
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  13-Jul-2009  10459 : Added new images and file headers.
 * CAM  19-Mar-2010  10610 : Added shortcut icon.
 * CAM  02-Jul-2011  10980 : Added Google Analytics.
 * * * * * * * * * * * * * * * * * * * * * * * */

include "db.php"
?>

<html>
<head>
  <title>Dunc Smith Glasscraft</title>

  <link href=./dsglasscraft.css rel=stylesheet type=text/css>
  <Script Language="JavaScript">
  <!-- hide
  var bActive = false;
  var aMnu = new Array();
  var bActive = false;
  var aMnu = new Array();
<?

  $ssql = "SELECT menu ".
          "FROM section ".
          "WHERE menu IS NOT NULL ".
          "ORDER BY sortOrder";
  $sql = mysql_query($ssql) or die (mysql_error());

  while ($row = mysql_fetch_array($sql)) {
    foreach($row AS $key => $val) {
      $$key = stripslashes($val);
    }

    print "  aMnu[aMnu.length+1] = \"mnu$menu\";\n";
  }

?>
  //-->
  </script>
  <Script Language="JavaScript" src="menu.js"></script>
  <Script Language="JavaScript" src="date.js"></script>
  <link rel="shortcut icon" href="dsg.ico" type="image/x-icon" />
	<script type="text/javascript">
	  var _gaq = _gaq || [];
	  _gaq.push(['_setAccount', 'UA-24317653-1']);
	  _gaq.push(['_trackPageview']);
	  (function() {
	    var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
	    ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
	    var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
	  })();
	</script>
</head>

<body onLoad="activateMenu(false);" onClick="hideMenu();" background="./img/mb1.gif" marginwidth=0 marginheight=0 topmargin=0 leftmargin=0 rightmargin=0>

<table border=0 width="100%" cellspacing=0 cellpadding=5>

<tr><td valign=top align=center><table border=0 cellpadding=0 cellspacing=0 class=box>

<tr>
  <td><img width="39" height="150" src="img/g3.png"></td>
  <td><img width="477" height="150" src="img/dsglass2.jpg"></td>
  <td><img width="39" height="150" src="img/g4.png"></td>
</tr>
<tr>
  <td><img width="39" height="25" src="img/g3.png"></td>
  <td class="nav"><table align=right id=mnuBar border=0><tr>
<?
  if (!empty($_GET['cat'])) {
    $cat = $_GET['cat'];
  } else if (!empty($_GET['section'])) {
    $section = $_GET['section'];
  } else {
    $section = 1;
  }

  if (!empty($_GET['piece'])) {
    $piece = $_GET['piece'];

  } else if (!empty($section)) {
    $ssql = "SELECT source ".
            "FROM context ".
            "WHERE section=$section";
    $sql = mysql_query($ssql) or die (mysql_error() . " " . $ssql);
    if ($row = mysql_fetch_array($sql)) {
      foreach($row AS $key => $val) {
        $$key = stripslashes($val);
      }
    }
  }

  $ssql = "SELECT section as thisSection, secName, menu ".
          "FROM section ".
          "ORDER BY sortOrder";
  $sql = mysql_query($ssql) or die (mysql_error() . " " . $ssql);
  $i=0;

  while ($row = mysql_fetch_array($sql)) {
    foreach($row AS $key => $val) {
      $$key = stripslashes($val);
    }

    if ($i>0) {
      echo '<td class="nav">&nbsp;|&nbsp;</td>';
    }

    if (!empty($menu)) {
      $menu = "mnu" . $menu;
      echo '<td onMouseOver="showMenu(this, \''.$menu.'\');">';
    } else {
      echo '<td onMouseOver="hideMenu(\'\');">';
    }

    echo '<a href="index.php?section='.$thisSection.'" class="nav">' . $secName . '</a></td>';
    $i++;
  }

?>
  </tr></table></td>
  <td><img width="39" height="25" src="img/g4.png"></td>
</tr>

</table></td></tr>

<tr><td valign=top align=center><table width="562" border=0 cellpadding=5 cellspacing=0 class=box>

<?
include "sidenav.php"
?>


