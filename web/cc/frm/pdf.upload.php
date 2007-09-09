<?php
/* * * * * * * * * * * * * * * * * * * * * * * *
 * Form - Add Quiz Question
 * Copyright (c) 2005 Southesk.com
 *
 * $Log: /web/cc/frm/pdf.upload.php $
 * 
 * 1     28/12/05 15:45 Craig
 *
 * Who  When         Why
 * CAM  27-Dec-2005  File created.
 * * * * * * * * * * * * * * * * * * * * * * * */

  include_once "db.php";
?>

<form enctype="multipart/form-data" action="pdfupload.php" method="POST">
  <input type="hidden" name="MAX_FILE_SIZE" value="300000" />
<table border=0 cellspacing=0 cellpadding=5>
<tr><td class="<? echo (empty($documentdate)) ? "fldmand" : "fld" ?>">Document Date</td><td><input name="documentdate" size="12" value="<? echo $documentdate; ?>" onChange="checkDate(this);" /></td></tr>
<tr><td class="<? echo (empty($documenttype)) ? "fldmand" : "fld" ?>">Document Type</td><td><select name="documenttype" />
<option value="L" <? echo (empty($documenttype) || ($documenttype == "L")) ? "SELECTED" : "" ?>>List</option>
<option value="N" <? echo ($documenttype == "N") ? "SELECTED" : "" ?>>Notes</option>
</select></td></tr>
<tr><td class="<? echo (empty($pdffilename)) ? "fldmand" : "fld" ?>">PDF file</td><td><input name="pdffile" type="file" /></td></tr>

<tr><td align=center colspan=2>
  <input class="button" type=submit value="Upload File">
  <input type=hidden name="retry" value="1">
</td></tr>

</table>
</form>
