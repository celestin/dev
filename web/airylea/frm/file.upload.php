<?php
/* * * * * * * * * * * * * * * * * * * * * * * *
 * Airylea Motors Website
 * Copyright (c) 2006-2007 Frontburner
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * File Upload
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  28-Aug-2008  10280 : File created.
 * * * * * * * * * * * * * * * * * * * * * * * */

  include_once "db.php";
?>

<form enctype="multipart/form-data" action="photo.upload.php" method="POST">
  <input type="hidden" name="MAX_FILE_SIZE" value="2000000" />
<table border=0 cellspacing=0 cellpadding=5>
<tr><td class="<? echo (empty($uplfilename)) ? "fldmand" : "fld" ?>">File</td><td><input name="uplfile" type="file" /></td></tr>

<tr><td align=center colspan=2>
  <input class="button" type=submit value="Upload File">
  <input type=hidden name="retry" value="1">
</td></tr>

</table>
</form>
