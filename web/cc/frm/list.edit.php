<?php
/* * * * * * * * * * * * * * * * * * * * * * * *
 * Form - Edit List entry
 * Copyright (c) 2006 frontburner.co.uk
 * Author Craig McKay <craig@southesk.com>
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  08-Apr-2006  File created.
 * * * * * * * * * * * * * * * * * * * * * * * */

include_once "Main.php";
?>

<form action="listedit.php" method=post>
<table border=0 cellspacing=0 cellpadding=5>
<tr><td class="<? fldmand($umtg_type); ?>">Meeting Type</td><td><select name="umtg_type" />
<option value="3" <? echo ($umtg_type == "3") ? "SELECTED" : "" ?>>3 Days</option>
<option value="F" <? echo (empty($umtg_type) || ($umtg_type == "F")) ? "SELECTED" : "" ?>>Fellowship</option>
<option value="M" <? echo ($umtg_type == "M") ? "SELECTED" : "" ?>>Marriage</option>
</select></td></tr>
<tr><td class="<? fldmand($umtg_date); ?>">Meeting Date</td><td><input name="umtg_date" size="12" value="<? echo $umtg_date; ?>" onChange="checkDate(this);" /></td></tr>

<tr><td class="<? fldmand($ulocality); ?>">Locality</td><td><select name="ulocality">
<?
  $sql = mysql_query("SELECT locality,locality_name,country ".
                     "FROM meeting_locality ".
                     "ORDER BY locality_name,country");
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
    <option value="<? echo $locality; ?>"<? echo $selected; ?>><? echo "$locality_name ($country)"; ?></option>
<?
  }
?>
</select></td></tr>

<tr><td class="<? fldmand($uservant); ?>">Servant</td><td><select name="uservant">
<?

  $sql = mysql_query("SELECT s.servant, s.servant_name, d.locality_name servant_locality ".
                     "FROM meeting_servant s, meeting_locality d ".
                     "WHERE s.locality = d.locality ".
                     "ORDER BY s.servant_name, d.locality_name");
  while ($row = mysql_fetch_array($sql)) {
    foreach($row AS $key => $val) {
      $$key = stripslashes($val);
    }

    if ($uservant == $servant) {
      $selected = " SELECTED";
    } else {
      $selected = "";
    }
?>
    <option value="<? echo $servant; ?>"<? echo $selected; ?>><? echo "$servant_name ($servant_locality)"; ?></option>
<?
  }
?>
</select></td></tr>

<tr><td align=center colspan=2>
  <input class="button" type=submit value="Update List">
  <input type=hidden name="retry" value="1">
</td></tr>

</table>
</form>
