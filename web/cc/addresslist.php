<?php
/* * * * * * * * * * * * * * * * * * * * * * * *
 * Addresses
 * Copyright (c) 2006 Southesk.com
 *
 * $Log: /web/cc/address.php $
 *
 * 2     11/02/06 22:17 Craig
 *
 * 1     11/02/06 22:13 Craig
 *
 * Who  When         Why
 * CAM  11-Feb-2006  File created.
 * * * * * * * * * * * * * * * * * * * * * * * */

$title = "List";
include 'Main.php';
$prev_country_name = "";
$prev_locality_name = "";
?>
<html>
<head></head>
<body>
  <table border=0 cellspacing=0 cellpadding=0 align=center>
  <?
  $ssql = "SELECT c.country_name, l.locality_name, a.name, a.dependants, ".
                 "a.addr1, a.addr2, a.addr3, ".
                 "a.postcode,a.tel ".
          "FROM address a, address_locality l, address_country c ".
          "WHERE a.countrycode = l.countrycode ".
          "AND a.locality = l.locality ".
          "AND a.countrycode = c.countrycode ".
          "ORDER BY 1,2,3 ";

  $sql = mysql_query($ssql) or die (mysql_error() . "<pre>$ssql</pre>");

  $mt = "";
  while ($row = mysql_fetch_array($sql)) {
    foreach($row AS $key => $val) {
      $$key = stripslashes($val);
    }

    if (!empty($dependants)) $name .= "<br>&nbsp;&nbsp;&nbsp;$dependants";
    if (!empty($addr2))     $addr1 .= "<br>$addr2";
    if (!empty($addr3))     $addr1 .= "<br>$addr3";
    if (empty($postcode))   $postcode = "&nbsp;";
    if (empty($tel))        $tel = "&nbsp;";

    if ($country_name != $prev_country_name) {
?>
    <tr>
      <td colspan=4><h1><?echo $country_name; ?><h1></td>
    </tr>
<?
    }
    if ($locality_name != $prev_locality_name) {
?>
    <tr>
      <td colspan=4><h2><?echo $locality_name; ?><h2></td>
    </tr>
<?
    }
?>
    <tr>
      <td><?echo $name; ?></td>
      <td><?echo $addr1; ?></td>
      <td><?echo $postcode; ?></td>
      <td><?echo $tel; ?></td>
    </tr>
<?
    $prev_country_name = $country_name;
    $prev_locality_name = $locality_name;
  }
  ?>
  </table>
</body>
</html>