<?php
/* * * * * * * * * * * * * * * * * * * * * * * *
 * Address Query Form
 * Copyright (c) 2006 frontburner.co.uk
 * Author Craig McKay <craig@southesk.com>
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  11-Feb-2006  File created.
 * * * * * * * * * * * * * * * * * * * * * * * */

  include_once "Main.php";
?>

<form action="address.php" method="post" name="action_form">

<table border=0 cellpadding=4 align=center width="50%">

<tr><td class="fld">Country</td><td><select name="ucountry" onchange="document.action_form.submit();">
<option value="">&lt;All&gt;</option>
<?
  $sql = mysql_query("SELECT countrycode,country_name ".
                     "FROM address_country  ".
                     "ORDER BY country_name");
  while ($row = mysql_fetch_array($sql)) {
    foreach($row AS $key => $val) {
      $$key = stripslashes($val);
    }

    if ($ucountry == $countrycode) {
      $selected = " SELECTED";
    } else {
      $selected = "";
    }
?>
    <option value="<? echo $countrycode; ?>"<? echo $selected; ?>><? echo $country_name; ?></option>
<?
  }
?>
</select></td></tr>

<?
if (!empty($ucountry)) {
?>
<tr><td class="fld">Locality</td><td><select name="ulocality" onchange="document.action_form.submit();">
<option value="">&lt;All&gt;</option>
<?
  $sql = mysql_query("SELECT locality,locality_name ".
                     "FROM address_locality ".
                     "WHERE countrycode = '$ucountry' ".
                     "ORDER BY locality_name");
  while ($row = mysql_fetch_array($sql)) {
    foreach($row AS $key => $val) {
      $$key = stripslashes($val);
    }

    if ($ulocality == $locality) {
      $selected = " SELECTED";
    } else {
      $selected = "";
    }
?>
    <option value="<? echo $locality; ?>"<? echo $selected; ?>><? echo $locality_name; ?></option>
<?
  }
}
?>
</select></td></tr>

    <tr>
      <td class="fld">Name</td>
      <td><input name="search" type="text" id="search" value="<? echo $search; ?>"></td>
    </tr>

<tr><td align=center colspan=2>
  <input class="button" type=submit value="Search">
  <input type=hidden name="retry" value="1">
  <input type=hidden name="uhousehold" id="uhousehold" value="">
</td></tr>

</table>
</form>
