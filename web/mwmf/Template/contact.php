<?
function addField($current, $desc, $new_item) {
  $rval = $current;

  if ($new_item != "") {
    if ($desc != "") $rval = $rval.$desc;
    $rval = $rval.$new_item."\n";
  }

  return $rval;
}

$b_name_reqd = false;
$b_email_reqd = false;
$b_real_submit = false;

if (${"real_submit"} != "") {
  $sSubject=trim(${"subject"});

  $s_contact=${"contact"};
  if ($s_contact=="") {
    $b_name_reqd = true;
  }

  $s_email=${"email"};
  if ($s_email=="") {
    $theEmail="No email address supplied";
    $b_email_reqd = true;
  } else {
    $theEmail=$s_email;
  }

  /* Telephone Details */
  $s_Tele_Day=${"Tele_Day"};
  $s_Tele_Eve=${"Tele_Eve"};

  /* Postal address */
  $s_name=${"name"};
  $s_add1=${"add1"};
  $s_add2=${"add2"};
  $s_town=${"town"};
  $s_county=${"county"};
  $s_postcde=${"postcde"};

  $s_MessageBody=$s_MessageBody."Name: ".$s_contact."\n";
  $s_MessageBody=$s_MessageBody."Email address: ".$s_email."\n";

  $s_MessageBody = addField($s_MessageBody,"Daytime tel: ",$s_Tele_Day);
  $s_MessageBody = addField($s_MessageBody,"Evening tel: ",$s_Tele_Eve);

  $s_FullAddress = addField($s_FullAddress,"   ",$s_name);
  $s_FullAddress = addField($s_FullAddress,"   ",$s_add1);
  $s_FullAddress = addField($s_FullAddress,"   ",$s_add2);
  $s_FullAddress = addField($s_FullAddress,"   ",$s_town);
  $s_FullAddress = addField($s_FullAddress,"   ",$s_county);
  $s_FullAddress = addField($s_FullAddress,"   ",$s_postcde);

  $s_MessageBody = addField($s_MessageBody,"Postal Address:\n",$s_FullAddress);

  $s_MessageBody = $s_MessageBody."\n";

  /*Request Q & A from the email form*/

  $Q1=${"Q1"};
  $A1=${"A1"};

  if ($A1!="") {
    $s_MessageBody=$s_MessageBody.$Q1." ".$A1."\n\n";
  }


  $A2=${"A2"};

  if ($A2!="") {
    $s_MessageBody=$s_MessageBody.$A2."\n\n";
  }

  $s_machine=${"machine"};
  $s_modelno=${"modelno"};

  if ($s_machine != "" || $s_modelno != "") {
    $s_MessageBody=$s_MessageBody."I require information on the following Replacement Jug:\nMachine Name: ".$s_machine."\nModel No: ".$s_modelno."\n\n";
  }

  $Q3=${"Q3"};
  $A3=${"A3"};

  if ($A3!="") {
    $s_MessageBody=$s_MessageBody.$Q3." ".$A3."\n\n";
  }


  $A4=${"A4"};

  if ($A4!="") {
    $s_MessageBody=$s_MessageBody.$A4."\n\n";
  }


  $Q5=${"Q5"};
  $A5=${"A5"};

  if ($A5!="") {
    $s_MessageBody=$s_MessageBody.$Q5." ".$A5."\n\n";
  }


  $A6=${"A6"};

  if ($A6!="") {
    $s_MessageBody=$s_MessageBody.$A6."\n\n";
  }


  $Q7=${"Q7"};
  $A7=${"A7"};

  if ($A7!="") {
    $s_MessageBody=$s_MessageBody.$Q7."\n";
    $s_MessageBody=$s_MessageBody.$A7."\n\n";
  }


  $sMsgText=$s_MessageBody;

  $strEmailTo = "mwmf@btconnect.com";

  if (!$b_name_reqd && !$b_email_reqd) {
    $b_real_submit = true;
    mail ($strEmailTo,"New Contact Query",$sMsgText,"Reply-To: ".$theEmail."\r\n"."FROM: ".$theEmail);
  }
}

?>

<form method="post" action="index.php">
<table border=0 cellspacing="0" cellpadding="2" width="100%">

<?
if ($b_real_submit) {
?>
  <tr><td><h2>Thank you for your enquiry - it will be dealt with as soon as possible.</h2></td></tr>

  <tr><td><table border=0 cellspacing=0 cellpadding=3 width="100%">
    <tr>
      <td colspan=3 align=center><img src="./img/mwmf.gif" border=0 width=102 height=82></td>
    </tr><tr>
      <td class=fld>MidWest Market Force Ltd</td>
      <td colspan=2>&nbsp;</td>
    </tr><tr>
      <td>46 Raddens Road</td>
      <td class=fld>Tel</td><td>+44 (0) 121 421 2333</td>
    </tr><tr>
      <td>Halesowen</td>
      <td class=fld>Fax</td><td>+44 (0) 121 421 3555</td>
    </tr><tr>
      <td>B62 0AN</td>
      <td colspan=2>&nbsp;</td>
    </tr><tr>
      <td>England</td>
      <td class=fld>Email</td><td><a href="mailto:mwmf@btconnect.com">mwmf@btconnect.com</a></td>
    </tr>
  </table></td></tr>
<?
} else {
?>

<tr><td><h2>Contact/Enquiry Form</h2></td></tr>

<tr><td><table border=0 cellspacing="4" cellpadding="0">
  <tr>
    <td <?
      if ($b_name_reqd) {
        print "class='reqdMissing'";
      } else {
        print "class='fld'";
      }
    ?>>Name</td>
    <td><input type="text" name="contact" maxlength="38" size=24 value="<? print $s_contact; ?>"></td>

    <td>Address</td>
    <td><input type="text" name="add1" maxlength="38" size=24 value="<? print $s_add1; ?>"></td>
  </tr>

  <tr>
    <td>Company Name</td>
    <td><input type="text" name="name" maxlength="38" size=24 value="<? print $s_name; ?>"></td>

    <td>Area</td>
    <td><input type="text" name="add2" maxlength="38" size=24 value="<? print $s_add2; ?>"></td>
  </tr>

  <tr>
    <td <?
      if ($b_email_reqd) {
        print "class='reqdMissing'";
      } else {
        print "class='fld'";
      }
    ?>>Email Address</td>
    <td><input type="text" name="email" maxlength="38" size=24 value="<? print $s_email; ?>"></td>

    <td>Town</td>
    <td><input type="text" name="town" maxlength="38" size=24 value="<? print $s_town; ?>"></td>
  </tr>

  <tr>
    <td>Tel. Day</td>
    <td><input type="text" name="Tele_Day" maxlength="38" size="18" value="<? print $s_Tele_Day; ?>"></td>

    <td>County</td>
    <td><input type="text" name="county" maxlength="38" size=24 value="<? print $s_county; ?>"></td>
  </tr>

  <tr>
    <td>Tel. Evening</td>
    <td><input type="text" name="Tele_Eve" maxlength="38" size="18" value="<? print $s_Tele_Eve; ?>"></td>

    <td>Postcode</td>
    <td><input type="text" name="postcde" maxlength="38" size="10" value="<? print $s_postcde; ?>"></td>
  </tr>
</table>

</td></tr><tr><td>

<table width="100%" border=0 cellspacing="4" cellpadding="0">
  <tr>
    <td class=fld>Grinders and Machines</td>
    <td><input type="hidden" name="Q1" value="I require specific information on the Grinder/Machine:">
          <select name="A1" size="1">
            <option selected value="">Select one of the following:</option>
            <option>Melitta Look Range</option>
            <option>Melitta Aromaboy Range</option>
            <option>Ufesa Coffee Machine</option>
            <option>Hand Grinders</option>
            <option>Electric Grinders</option>
          </select>
   </td>
 </tr>

 <tr>
   <td>I would like further information on the full Grinder/Machine range</td>
   <td><input type="checkbox" name="A2" value="I would like further information on the full Grinder/Machine range."></td>
 </tr>

 <tr>
   <td>I require specific information on a Replacement Jug</td>
   <td><table border=0 width="100%">
         <tr>
           <td>Machine Name</td><td>Model No.</td>
         </tr><tr>
           <td><input type="text" name="machine" size="10" value="<? print $s_machine; ?>"></td>
           <td><input type="text" name="modelno" size="10" value="<? print $s_modelno; ?>"></td>
         </tr>
       </table>
   </td>
 </tr>


 <tr>
   <td class=fld>Filter Papers (Wholesale Provision Only)</td>
   <td><input type="hidden" name="Q3" value="I require specific information on Filter Papers:">
          <select name="A3" size="1">
            <option selected value="">Select one of the following:</option>
            <option>Filtropa Filter Papers</option>
            <option>Basket Filters</option>
            <option>Shrink wrapped filter papers</option>
            <option>Large Round filter papers</option>
            <option>Melitta Filter papers</option>
          </select>
   </td>
 </tr>

 <tr>
   <td>I would like further information on the full Filter Paper range</td>
   <td><input type="checkbox" name="A4" value="I would like further information on the full Filter Paper range."></td>
 </tr>

 <tr>
   <td class=fld>Accessories</td>
   <td><input type="hidden" name="Q5" value="I require specific information on the Accessory:">
          <select name="A5" size="1">
            <option selected value="">Select one of the following:</option>
            <option>Filter cones</option>
            <option>Express Coffee Makers</option>
            <option>Filter Paper Holder</option>
            <option>Hot Plates</option>
            <option>Creamers/ Frothers</option>
            <option>Coffee Spoons</option>
            <option>Cocoa shakers</option>
            <option>Milk frother jugs</option>
            <option>Descalers</option>
          </select>
   </td>
 </tr>

 <tr>
   <td>I would like further information on the full Accessories range</td>
   <td><input type="checkbox" name="A6" value="I would like further information on the full Accessories range."></td>
 </tr>

 <tr>
   <td colspan=2 valign=top class=fld>Other queries/requests<br>
   <input type="hidden" name="Q7" value="General Queries">
          <textarea name="A7" cols="65" wrap="VIRTUAL" rows="6"><? print $A7; ?></textarea></td>
 </tr>

 <tr><td colspan=2 align=right><input type=hidden name="real_submit" value="1">
     <input type="reset" name="Reset" value="Reset">
     <input type="submit" name="Submit2" value="Submit"></td>
 </tr>

</table>

<?
}
?>

</td></tr></table>
</form>
