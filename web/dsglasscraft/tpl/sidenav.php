<?php
/* * * * * * * * * * * * * * * * * * * * * * * *
 * Dunc Smith Glasscraft
 * Copyright (c) 2009 Dunc Smith
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  13-Jul-2009  10459 : Added new images and file headers.
 * * * * * * * * * * * * * * * * * * * * * * * */

function linkify($catName) {
  global $piece, $cat, $category, $section, $secName, $thisPieceName;

  $c = str_replace("/", "<br>", $catName);
  $bt = "";
  $sep = "&nbsp;|&nbsp;";

  $s = "<a href=\"index.php?section=$section\">$secName</a>";
  $c = "<a href=\"index.php?cat=$category\">$catName</a>";

  if (!empty($piece)) {
    return $s . $sep . $c . $sep . "<b>" . $thisPieceName . "</b>";
  }

  if (empty($piece) && !empty($cat)) {
    return $s . $sep . "<b>" . $catName . "</b>";
  }

  return $c;
}

if (!empty($source)) {
  return;
}

$imgPath = "s";
$imgRow = 10;
$imgAlign = "center";

if (empty($piece)) {
  if (!empty($cat)) {
    $imgPath = "m";
    $imgRow = 4;
  } else {
    $imgAlign = "left";
  }
} else {
  $ssql = "SELECT d.name thisPieceName " .
          "FROM piece d, category c, section s " .
          "WHERE c.cat = d.cat " .
          "AND s.section = c.section " .
          "AND d.piece='$piece' ";
  $sql = mysql_query($ssql) or die (mysql_error());
  if ($row = mysql_fetch_array($sql)) {
    foreach($row AS $key => $val) {
      $$key = stripslashes($val);
    }
  }
}

$ssql = "SELECT d.piece thispiece, d.name pieceName, c.cat category, c.catName, s.section, s.secName " .
        "FROM piece d, category c, section s " .
        "WHERE c.cat = d.cat " .
        "AND s.section = c.section ";

$currentSection = -1;
$count = 0;

if (!empty($cat)) {
  $ssql .= "AND c.cat='$cat' ";
} else if (!empty($section)) {
  $ssql .= "AND s.section='$section' ";
}

$ssql .= "ORDER by s.secName,c.catName,d.piece";

$sql = mysql_query($ssql) or die (mysql_error());

while ($row = mysql_fetch_array($sql)) {
  foreach($row AS $key => $val) {
    $$key = stripslashes($val);
  }

  $count++;
  $newstart = false;

  if ($category != $currentCat) {
    if (!empty($currentCat)) {
      print "</tr></table></td></tr>";
    }

    $catName = linkify($catName);

    print "<tr><td class=\"main\" width=\"100%\">$catName</td></tr><tr><td class=\"main\" align=$imgAlign><table border=0 cellspacing=0 cellpadding=2>";
    $currentCat = $category;
    $newstart = true;
    $count = 0;
  }

  if ($count == $imgRow) {
    print "</tr>";
    $count = 0;
    $newstart = true;
  }

  if ($newstart) {
    print "<tr>";
  }

  print "<td$attr><a href=\"index.php?piece=$thispiece&cat=$category\"><img border=0 title=\"$pieceName\" src=\"img/p/$imgPath/$thispiece.jpg\"></a></td>\n";
}

print "</table></td></tr>";

print "</tr>";

?>
