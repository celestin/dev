<?php
/* * * * * * * * * * * * * * * * * * * * * * * *
 * West Coast Express Website
 * Copyright (c) 2006-2007 Frontburner
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * Photo text update
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  10-May-2006  File created.
 * CAM  15-Feb-2007  10102 : Corrected bad HTML.
 * CAM  11-Aug-2007  10149 : Increased size of "Location" box.
 * * * * * * * * * * * * * * * * * * * * * * * */

include_once "db.php";

global $uphoto, $uboat, $ulocation, $udisporder;
?>

<form action="photos.php" method="POST" name=photos id=photos>
<table border=0 cellspacing=0 cellpadding=5>

<tr><td class="fld">Boat</td><td><input name="boat" size="36" value="<? echo $uboat; ?>" /></td></tr>
<tr><td valign=top class="fld">Location</td><td><textarea name="location" rows="8" cols=34><? echo $ulocation; ?></textarea></td></tr>
<tr><td class="fld">Display<br>Order</td><td><input name="disporder" size="10" value="<? echo $udisporder; ?>" /></td></tr>

<tr><td align=center colspan=2>
  <input type=hidden name="photo" value="<? echo $uphoto; ?>">
  <input type=hidden name="retry" value="1">
  <input class="button" type="submit" value="Update">
</td></tr>

</table>
</form>
