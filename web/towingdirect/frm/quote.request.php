<?php
/* * * * * * * * * * * * * * * * * * * * * * * *
 * West Coast Express Website
 * Copyright (c) 2006 Frontburner
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * Request Quotation form
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  10-May-2006  File created.
 * * * * * * * * * * * * * * * * * * * * * * * */

include_once "db.php";

function f_mand($testvalue) {
  global $retry;

  if ( (empty($testvalue)) && ($retry == 1) ) {
    echo "fldmand";
  } else {
    echo "fld";
  }
}

global $boattype, $boatlength, $boatweight, $boatkeel,
       $boatloc, $boatdest, $earlydate, $estval, $owntrailer, $comments,
       $contactemail, $contactname, $contacttel;
?>

<form enctype="multipart/form-data" action="request.php" method="POST">
  <input type="hidden" name="MAX_FILE_SIZE" value="300000" />
<table border=0 cellspacing=0 cellpadding=5>

<tr><td class="<? f_mand($boattype); ?>">Type of Boat</td><td><select name="boattype" />
<option value="YACHT" <? echo (empty($boattype) || ($boattype == "YACHT")) ? "SELECTED" : "" ?>>Yacht</option>
<option value="CRUISER" <? echo ($boattype == "CRUISER") ? "SELECTED" : "" ?>>Motor cruiser</option>
<option value="FISHING" <? echo ($boattype == "FISHING") ? "SELECTED" : "" ?>>Fishing boat</option>
</select></td></tr>

<tr><td class="<? f_mand($boatlength); ?>">Length of boat</td><td><input name="boatlength" size="20" value="<? echo $boatlength; ?>" /></td></tr>
<tr><td class="<? f_mand($boatweight); ?>">Weight of boat</td><td><input name="boatweight" size="20" value="<? echo $boatweight; ?>" /></td></tr>

<tr><td class="<? f_mand($boatkeel); ?>">Type of Keel (Yacht only)</td><td><select name="boatkeel" />
<option value="BILGE" <? echo (empty($boatkeel) || ($boatkeel == "BILGE")) ? "SELECTED" : "" ?>>Bilge</option>
<option value="FIN" <? echo ($boatkeel == "FIN") ? "SELECTED" : "" ?>>Fin</option>
</select></td></tr>

<tr><td valign=top class="<? f_mand($boatloc); ?>">Location (present position)</td><td><textarea name="boatloc" rows="2" cols=50><? echo $boatloc; ?></textarea></td></tr>
<tr><td valign=top class="<? f_mand($boatdest); ?>">Destination</td><td><textarea name="boatdest" rows="2" cols=50><? echo $boatdest; ?></textarea></td></tr>

<tr><td class="<? f_mand($earlydate); ?>">Earliest preferred date</td><td><input name="earlydate" size="12" value="<? echo $earlydate; ?>" onChange="checkDate(this);" /></td></tr>
<tr><td class="<? f_mand($estval); ?>">Estimated value</td><td><input name="estval" size="12" value="<? echo $estval; ?>" /></td></tr>
<tr><td class="<? f_mand($owntrailer); ?>">Is the boat on its own trailer?</td><td><input name="owntrailer" size="5" value="<? echo $owntrailer; ?>" /></td></tr>

<tr><td valign=top class="fld">Additional comments</td><td><textarea name="comments" rows="3" cols=50><? echo $comments; ?></textarea></td></tr>

<tr><td class="<? f_mand($contactemail); ?>">Email Address</td><td><input name="contactemail" size="40" value="<? echo $contactemail; ?>" /></td></tr>
<tr><td class="<? f_mand($contactname); ?>">Contact Name</td><td><input name="contactname" size="40" value="<? echo $contactname; ?>" /></td></tr>
<tr><td class="<? f_mand($contacttel); ?>">Contact Tel</td><td><input name="contacttel" size="40" value="<? echo $contacttel; ?>" /></td></tr>

<tr><td align=center colspan=2>
  <input class="button" type=submit value="Send Request">
  <input type=hidden name="retry" value="1">
</td></tr>

</table>
</form>
