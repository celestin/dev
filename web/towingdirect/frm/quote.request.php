<?php
/* * * * * * * * * * * * * * * * * * * * * * * *
 * TowingDirect Website
 * Copyright (c) 2012 Front Burner
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * Request Quotation form
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  18-Feb-2012  11082 : Updated Request Form for Carried Safely.
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

global $vehiclemake, $vehiclemodel, $vehiclelength, $vehicleweight, $vehiclevalue, $vehiclecondition,
       $collectionaddress, $deliveryaddress, $earlydate, $comments,
       $contactemail, $contactname, $contacttel;
?>

<form enctype="multipart/form-data" action="request.php" method="POST">
  <input type="hidden" name="MAX_FILE_SIZE" value="300000" />
<table border=0 cellspacing=0 cellpadding=5>

<tr><td class="<? f_mand($vehiclemake); ?>">Vehicle Make</td><td><input name="vehiclemake" size="30" value="<? echo $vehiclemake; ?>" /></td></tr>
<tr><td class="<? f_mand($vehiclemodel); ?>">Vehicle Model</td><td><input name="vehiclemodel" size="30" value="<? echo $vehiclemodel; ?>" /></td></tr>
<tr><td class="<? f_mand($vehiclelength); ?>">Vehicle Length</td><td><input name="vehiclelength" size="12" value="<? echo $vehiclelength; ?>" /></td></tr>
<tr><td class="<? f_mand($vehicleweight); ?>">Vehicle Weight</td><td><input name="vehicleweight" size="12" value="<? echo $vehicleweight; ?>" /></td></tr>
<tr><td class="<? f_mand($vehiclevalue); ?>">Vehicle Value</td><td><input name="vehiclevalue" size="12" value="<? echo $vehiclevalue; ?>" /></td></tr>

<tr><td class="<? f_mand($vehiclecondition); ?>">Condition</td><td><select name="vehiclecondition" />
<option value="RUNNING" <? echo (empty($vehiclecondition) || ($vehiclecondition == "RUNNING")) ? "SELECTED" : "" ?>>Running</option>
<option value="NOT_RUNNING" <? echo ($vehiclecondition == "NOT_RUNNING") ? "SELECTED" : "" ?>>Not running</option>
</select></td></tr>

<tr><td valign=top class="<? f_mand($collectionaddress); ?>">Location (present position)</td><td><textarea name="collectionaddress" rows="2" cols=50><? echo $collectionaddress; ?></textarea></td></tr>
<tr><td valign=top class="<? f_mand($deliveryaddress); ?>">Destination</td><td><textarea name="deliveryaddress" rows="2" cols=50><? echo $deliveryaddress; ?></textarea></td></tr>

<tr><td class="<? f_mand($earlydate); ?>">Earliest preferred date</td><td><input name="earlydate" size="12" value="<? echo $earlydate; ?>" onChange="checkDate(this);" /></td></tr>

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
