<?php
/* * * * * * * * * * * * * * * * * * * * * * * *
 * Form - Add Servant
 * Copyright (c) 2006 Southesk.com
 * Author Craig McKay <craig@southesk.com>
 *
 * $Log: /web/cc/frm/servant.add.php $
 * 
 * 1     8/04/06 20:41 Craig
 *
 * Who  When         Why
 * CAM  08-Apr-2006  File created.
 * * * * * * * * * * * * * * * * * * * * * * * */

include_once "Main.php";
?>

<form action="servant.php" method=post>
<table border=0 cellspacing=0 cellpadding=5>
<tr><td class="<? fldmand($uservant); ?>">Servant Name</td><td><input name="uservant" size="20" value="<? echo $uservant; ?>" /></td></tr>

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

<tr><td align=center colspan=2>
  <input class="button" type=submit value="Add Servant">
  <input type=hidden name="retry" value="1">
</td></tr>

</table>
</form>
