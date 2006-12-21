<?php
/* * * * * * * * * * * * * * * * * * * * * * * *
 * West Coast Express Website
 * Copyright (c) 2006 Frontburner
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * Photo text update
 *
 * $Id: file.upload.php 76 2006-05-10 22:47:06Z craig $
 *
 * Who  When         Why
 * CAM  10-May-2006  File created.
 * * * * * * * * * * * * * * * * * * * * * * * */

include_once "db.php";

global $uphoto, $uboat, $ulocation, $udisporder;
?>

<form action="photos.php" method="POST">
<table border=0 cellspacing=0 cellpadding=5>

<tr><td class="fld">Boat</td><td><input name="boat" size="36" value="<? echo $uboat; ?>" /></td></tr>
<tr><td valign=top class="fld">Location</td><td><textarea name="location" rows="6" cols=34><? echo $ulocation; ?></textarea></td></tr>
<tr><td class="fld">Display<br>Order</td><td><input name="disporder" size="10" value="<? echo $udisporder; ?>" /></td></tr>

<tr><td align=center colspan=2>
  <input class="button" type=submit value="Update">
  <input type=hidden name="photo" value="<? echo $uphoto; ?>">
  <input type=hidden name="retry" value="1">
</td></tr>

</table>
</form>
