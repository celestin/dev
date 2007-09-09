<?php
/* * * * * * * * * * * * * * * * * * * * * * * *
 * Form - Add Quiz Question
 * Copyright (c) 2005 frontburner.co.uk
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  27-Dec-2005  File created.
 * * * * * * * * * * * * * * * * * * * * * * * */

  include_once "db.php";
?>

<form action="question.add.php" method=post>
<table border=1>
<tr><td class="<? echo (empty($uanswer1)) ? "fldmand" : "fld" ?>">Answer</td><td><textarea name="uanswer1" rows=6 cols=40><? echo $uanswer1; ?></textarea></td></tr>

<tr><td align=center colspan=2>
  <input class="button" type=submit value="Save Answer" size=35>
  <input type=hidden name="action" value="save">
  <input type=hidden name="uage" value="<? echo $uage; ?>">
  <input type=hidden name="uquestion" value="<? echo $uquestion; ?>">
  <input type=hidden name="uqtype" value="<? echo $uqtype; ?>">
</td></tr>

</table>
</form>
