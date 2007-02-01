<?php
/* * * * * * * * * * * * * * * * * * * * * * * *
 * First Summerhouses
 * Copyright (c) 2006-2007 Frontburner
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * Testimonals
 *
 * $Id: news.php 310 2006-10-10 21:31:17Z craig $
 *
 * Who  When         Why
 * CAM  01-Feb-2007  10081 : File created.
 * * * * * * * * * * * * * * * * * * * * * * * */

$title = "Testimonals";
include 'tpl/top.php';

$uphoto = NULL;        if (!empty($_GET['photo'])) $uphoto = $_GET['photo'];

global $flash;

showFlash();

?><table border=0 cellpadding=0 cellspacing=0 width="100%">
<tr><td valign="top"><?

$ssql = "SELECT p.id, p.imgfile ".
        "FROM testimonals t, testimonalphotos p ".
        "WHERE p.testimonal_id = t.id ";

if (!empty($uphoto)) $ssql .= "AND p.id = '$uphoto' ";

$ssql .= "ORDER BY t.testimonal_date DESC, p.disporder ".
         "LIMIT 1";
$sql = mysql_query($ssql) or die (mysql_error());

if ($row = mysql_fetch_array($sql)) {
  foreach($row AS $key => $val) {
    $$key = stripslashes($val);
  }
  echo "<img src=\"img/test/f/$imgfile\" width=\"250\">";
} else {
  echo "&nbsp;";
}


?></td>
<td><table border=0 cellpadding=0 cellspacing=8 width="100%">
<?

$ssql = "SELECT id testimonal_id, customer_name, testimonal, ".
        "DATE_FORMAT(testimonal_date, '%d %b %Y') testimonal_date_fmt ".
        "FROM testimonals ".
        "ORDER BY testimonal_date DESC ";
$sql = mysql_query($ssql) or die (mysql_error());
$counter=0;

while ($row = mysql_fetch_array($sql)) {
  foreach($row AS $key => $val) {
    $$key = stripslashes($val);
  }

  if ($counter>0) {
?>
<tr><td align=right height=6><img src="img/bar1.gif" width=300 height=2></td></tr>
<?
  }

  if ($loggedin && $member->isAdmin()) {
  ?>
<tr><td><table border=0 cellpadding=0 cellspacing=0>
  <tr>
    <td><b><? echo "$customer_name - $testimonal_date_fmt"; ?></b></b>
    <td><a href="testimonals.edit.php?testimonal_id=<? echo $testimonal_id; ?>"><img border=0 class="sep" src="img/edit/edit.png"></a></td>
    <td><a href="testimonals.delete.php?testimonal_id=<? echo $testimonal_id; ?>"><img border=0 class="sep" src="img/edit/delete.png"></a></td>
  </tr>
</table></td></tr>
  <?
  }

$ssql2 = "SELECT id photo_id, imgfile ".
        "FROM testimonalphotos p ".
        "WHERE testimonal_id = '$testimonal_id' ".
        "ORDER BY disporder ";
$sql2 = mysql_query($ssql2) or die (mysql_error());
$counter=0;
$html = "";

while ($row2 = mysql_fetch_array($sql2)) {

  if (empty($html)) $html = "<tr><td align=right><table border=0 cellpadding=0 cellspacing=0><tr>";

  foreach($row2 AS $key => $val) {
    $$key = stripslashes($val);
  }
  $html .= "<td class=\"testthumb\"><a class=\"imgnav\" href=\"testimonals.php?photo=$photo_id\"><img border=0 src=\"img/test/t/$imgfile\" width=\"80\" height=\"80\"></a></td>";
}

if (!empty($html)) {
  $html .= "</tr></table></td></tr>";
  echo $html;
}

?>
<tr><td><table border=0 cellpadding=2 cellspacing=0 width="100%">
  <tr><td>&quot;<? echo $testimonal; ?>&quot;</td></tr>
  <tr><td align="right">-&nbsp;<b><? echo $customer_name; ?></b></td></tr>
</table></td></tr>
  <?
  $counter++;
}
if ($loggedin && $member->isAdmin()) {
?>
<tr><td align="center"><table border=0 cellpadding=0 cellspacing=0>
  <tr>
    <td><a href="testimonals.add.php"><img border=0 class="sep" src="img/edit/add.png"></a></td>
    <td><a href="testimonals.add.php">Add a Testimonal</a></td>
  </tr>
</table></td></tr>
<?
}
?>
<tr><td><br><br></td></tr>
</table>
<?
include 'tpl/bot.php';
?>