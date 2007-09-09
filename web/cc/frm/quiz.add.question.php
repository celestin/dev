<?php
/* * * * * * * * * * * * * * * * * * * * * * * *
 * Form - Add Quiz Question
 * Copyright (c) 2005 Southesk.com
 *
 * $Log: /web/cc/frm/quiz.add.question.php $
 * 
 * 1     28/12/05 15:45 Craig
 *
 * Who  When         Why
 * CAM  27-Dec-2005  File created.
 * * * * * * * * * * * * * * * * * * * * * * * */

  include_once "db.php";
?>

<form action="question.add.php" method=post>
<table border=1>
<tr><td class="<? echo (empty($uage)) ? "fldmand" : "fld" ?>">Age Group</td><td><select name="uage">
<?
  $sql = mysql_query("SELECT age,ageName FROM age");
  while ($row = mysql_fetch_array($sql)) {
    foreach($row AS $key => $val) {
      $$key = stripslashes($val);
    }

    if ($uage == $age) {
      $selected = "selected";
    } else {
      $selected = "";
    }
?>
    <option value="<? echo $age; ?>" <? echo $selected; ?>><? echo $ageName; ?></option>
<?
  }
?>
</select></td></tr>
<tr><td class="<? echo (empty($uquestion)) ? "fldmand" : "fld" ?>">Question</td><td><textarea name="uquestion" rows=6 cols=40><? echo $uquestion; ?></textarea></td></tr>
<tr><td class="fld">Answer Type</td><td>

<table border=0 cellspacing=2 cellpadding=0><tr>
  <td><input type=radio name="uqtype" value="T" <? echo ($uqtype == "T" || empty($uqtype)) ? "checked" : ""; ?>>Text</td>
  <td width="25">&nbsp;</td>
  <td><input type=radio name="uqtype" value="M" <? echo ($uqtype == "M") ? "checked" : ""; ?>>Multiple Choice</td>
</tr></table>
</td></tr>

<tr><td align=center colspan=2>
  <input class="button" type=submit value="Go to Answer screen" size=35>
  <input type=hidden name="action" value="ans">
</td></tr>

</table>
</form>
