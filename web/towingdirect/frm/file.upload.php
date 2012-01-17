<?php
/* * * * * * * * * * * * * * * * * * * * * * * *
 * TowingDirect Website
 * Copyright (c) 2012 Front Burner
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * File Upload
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  13-Apr-2006  File created.
 * CAM  21-Dec-2006  10068 : Enable uploading of new photos.
 * CAM  11-Aug-2007  10149 : Changed to 'photo.upload.php'.
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
