<?php
/* * * * * * * * * * * * * * * * * * * * * * * *
 * Addresses
 * Copyright (c) 2006 frontburner.co.uk
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  11-Feb-2006  File created.
 * * * * * * * * * * * * * * * * * * * * * * * */

$title = "List";
include 'tpl/top.php';

$ucountry = NULL;         if (!empty($_POST['ucountry'])) $ucountry = $_POST['ucountry'];
$ulocality = NULL;        if (!empty($_POST['ulocality'])) $ulocality = $_POST['ulocality'];
$uhousehold = NULL;       if (!empty($_POST['uhousehold'])) $uhousehold = $_POST['uhousehold'];
$search = NULL;           if (!empty($_POST['search'])) $search = $_POST['search'];

if (!session_is_registered('memberid')) {
  Msg::error("You must be logged in to use this functionality.");
  include 'tpl/bot.php';
  exit();
}

include 'frm/address.query.php';

function f_data_row($label, $value, $extra='') {
  if (empty($value)) return;

  if ($extra == 1) {
    $value = "<i>$value</i>";
  } else {
    if ($label == "Email") $value = "<a href=\"mailto:$value\">$value</a>";
  }

  ?>
  <tr><td class="fld"><? echo $label; ?></td><td><? echo $value; ?></td></tr>
  <?
}

if (!empty($uhousehold)) {
?>
  <br>
  <table border=0 cellspacing=0 cellpadding=6 align=center>
  <?

  $ssql = "SELECT name, dependants,addr1,addr2,addr3, ".
          "postcode,tel,fax,email,mobile ".
          "FROM address  ".
          "WHERE household = '$uhousehold' ";

  $sql = mysql_query($ssql) or die (mysql_error() . "<pre>$ssql</pre>");

  $mt = "";
  while ($row = mysql_fetch_array($sql)) {
    foreach($row AS $key => $val) {
      $$key = stripslashes($val);
    }

    $address = "<b>$name</b>";
    if (!empty($addr1)) $address .= "<br>$addr1";
    if (!empty($addr2)) $address .= "<br>$addr2";
    if (!empty($addr3)) $address .= "<br>$addr3";
    if (!empty($postcode)) $address .= "<br>$postcode";
    ?>
    <tr><td colspan=2 class="labelborder"><? echo $address; ?></td></tr>
    <?
    f_data_row("Others", $dependants, 1);
    f_data_row("Tel", $tel);
    f_data_row("Tel", $fax);
    f_data_row("Mobile", $mobile);
    f_data_row("Email", $email);
  }

  ?>
  </td></tr>
  </table>
<?

} else if (!empty($search) || !empty($ulocality)) {
?>

  <table border=0 cellspacing=0 cellpadding=2 align=center width="100%">
  <tr>
    <th>Name</th>
    <th>Address</th>
    <th>Postcode</th>
    <th>Tel</th>
<!--
    <th>Fax</th>
    <th>Email</th>
    <th>Mobile</th>
-->
  </tr>
  <?

  $ssql = "SELECT household,name,dependants,addr1,addr2,addr3, ".
          "postcode,tel,fax,email,mobile ".
          "FROM address  ".
          "WHERE LOWER(CONCAT(name,IFNULL(dependants, ''),IFNULL(addr1, ''),IFNULL(addr2, ''), ".
                "IFNULL(addr3, ''),IFNULL(postcode, ''),IFNULL(email, ''))) LIKE LOWER('%$search%') ";

  if (!empty($ulocality)) $ssql .= "AND locality = '$ulocality' ";
  if (!empty($ucountry)) $ssql .= "AND countrycode = '$ucountry' ";

  $sql = mysql_query($ssql) or die (mysql_error() . "<pre>$ssql</pre>");

  $mt = "";
  while ($row = mysql_fetch_array($sql)) {
    foreach($row AS $key => $val) {
      $$key = stripslashes($val);
    }
  ?>
  <tr>
    <td valign=top><a href="javascript:void();" onclick="setHouse('<? echo $household;?>');return false;"><? echo $name; ?></a><br><i><? echo $dependants; ?></i></td>
    <td><? echo "$addr1<br>$addr2<br>$addr3"; ?></td>
    <td><? echo $postcode; ?></td>
    <td><? echo $tel; ?></td>
<!--
    <td><? echo $fax; ?></td>
    <td><? echo $email; ?></td>
    <td><? echo $mobile; ?></td>
-->
  </tr>
  <?
  }

  ?>
  </td></tr>
  </table>
<?
}
?>

<center>

<?

include 'tpl/bot.php';
?>