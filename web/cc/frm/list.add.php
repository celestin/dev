<?php
/* * * * * * * * * * * * * * * * * * * * * * * *
 * Form - Add List entry
 * Copyright (c) 2005 Southesk.com
 *
 * $Log: /web/cc/frm/list.add.php $
 * 
 * 2     8/04/06 20:40 Craig
 *
 * 1     28/12/05 15:45 Craig
 *
 * Who  When         Why
 * CAM  27-Dec-2005  File created.
 * * * * * * * * * * * * * * * * * * * * * * * */

  include_once "Main.php";

/*
$locality = NULL;         if (!empty($_POST['locality'])) $locality = $_POST['locality'];
$servant = NULL;          if (!empty($_POST['servant'])) $servant = $_POST['servant'];
$notes = NULL;            if (!empty($_POST['notes'])) $notes = $_POST['notes'];
*/
?>

<form action="list.php" method=post>
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
</select>&nbsp; <a href="servant.php">add</a></td></tr>

<tr><td align=center colspan=2>
  <input class="button" type=submit value="Update List">
  <input type=hidden name="retry" value="1">
</td></tr>

</table>
</form>
