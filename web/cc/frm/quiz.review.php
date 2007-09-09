<?php
/* * * * * * * * * * * * * * * * * * * * * * * *
 * Form - Add Quiz Question
 * Copyright (c) 2005 frontburner.co.uk
 *
 * $Id$
 *
 * 1     28/12/05 15:45 Craig
 *
 * Who  When         Why
 * CAM  27-Dec-2005  File created.
 * * * * * * * * * * * * * * * * * * * * * * * */

  include_once "db.php";
?>

<form action="question.review.php" method=post>
<table border=1>
<tr><td class="<? echo (empty($uage)) ? "fldmand" : "fld" ?>">Age Group</td><td><select name="uage">
<?
  $sql = mysql_query("SELECT age,ageName FROM age");
  while ($row = mysql_fetch_array($sql)) {
    foreach($row AS $key => $val) {
      $$key = stripslashes($val);
    }

    if ($uage == $age) {
      $selected = "SELECTED";
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
<tr><td class="fld">Answer Type</td>
<td><? echo ($uqtype == "T") ? "Text" : "Multiple Choice"; ?></td></tr>

<tr><td class="<? echo (empty($uanswer1)) ? "fldmand" : "fld" ?>">Answer</td><td><textarea name="uanswer1" rows=6 cols=40><? echo $uanswer1; ?></textarea></td></tr>

<tr><td align=center colspan=2>
  <input class="button" type=submit value="Save">
  <input type=hidden name="action" value="accept">
  <input type=hidden name="question" value="<? echo $question; ?>">
</td></tr>

</table>
</form>
