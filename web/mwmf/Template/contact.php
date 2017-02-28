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

$real_submit = NULL;      if (!empty($_POST["real_submit"]))     $real_submit = $_POST["real_submit"];
$sSubject = NULL;         if (!empty($_POST["subject"]))         $sSubject = $_POST["subject"];
$s_contact = NULL;        if (!empty($_POST["contact"]))         $s_contact = $_POST["contact"];
$s_email = NULL;          if (!empty($_POST["email"]))           $s_email = $_POST["email"];
$s_Tele_Day = NULL;       if (!empty($_POST["Tele_Day"]))        $s_Tele_Day = $_POST["Tele_Day"];
$s_Tele_Eve = NULL;       if (!empty($_POST["Tele_Eve"]))        $s_Tele_Eve = $_POST["Tele_Eve"];
$s_name = NULL;           if (!empty($_POST["name"]))            $s_name = $_POST["name"];
$s_add1 = NULL;           if (!empty($_POST["add1"]))            $s_add1 = $_POST["add1"];
$s_add2 = NULL;           if (!empty($_POST["add2"]))            $s_add2 = $_POST["add2"];
$s_town = NULL;           if (!empty($_POST["town"]))            $s_town = $_POST["town"];
$s_county = NULL;         if (!empty($_POST["county"]))          $s_county = $_POST["county"];
$s_postcde = NULL;        if (!empty($_POST["postcde"]))         $s_postcde = $_POST["postcde"];
$Q1 = NULL;               if (!empty($_POST["Q1"]))              $Q1 = $_POST["Q1"];
$Q3 = NULL;               if (!empty($_POST["Q3"]))              $Q1 = $_POST["Q3"];
$Q4 = NULL;               if (!empty($_POST["Q4"]))              $Q1 = $_POST["Q4"];
$Q5 = NULL;               if (!empty($_POST["Q5"]))              $Q1 = $_POST["Q5"];
$Q6 = NULL;               if (!empty($_POST["Q6"]))              $Q1 = $_POST["Q6"];
$Q7 = NULL;               if (!empty($_POST["Q7"]))              $Q1 = $_POST["Q7"];
$A1 = NULL;               if (!empty($_POST["A1"]))              $A1 = $_POST["A1"];
$A2 = NULL;               if (!empty($_POST["A2"]))              $A2 = $_POST["A2"];
$A3 = NULL;               if (!empty($_POST["A3"]))              $A3 = $_POST["A3"];
$A4 = NULL;               if (!empty($_POST["A4"]))              $A4 = $_POST["A4"];
$A5 = NULL;               if (!empty($_POST["A5"]))              $A5 = $_POST["A5"];
$A6 = NULL;               if (!empty($_POST["A6"]))              $A6 = $_POST["A6"];
$A7 = NULL;               if (!empty($_POST["A7"]))              $A7 = $_POST["A7"];
$s_machine = NULL;        if (!empty($_POST["machine"]))         $s_machine = $_POST["machine"];
$s_modelno = NULL;        if (!empty($_POST["modelno"]))         $s_modelno = $_POST["modelno"];

if (!empty($real_submit)) {
  if (empty($s_contact)) $b_name_reqd = true;

  if (empty($s_email)) {
    $theEmail="No email address supplied";
    $b_email_reqd = true;
  } else {
    $theEmail=$s_email;
  }


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

  if ($A1!="") {
    $s_MessageBody=$s_MessageBody.$Q1." ".$A1."\n\n";
  }

  if ($A2!="") {
    $s_MessageBody=$s_MessageBody.$A2."\n\n";
  }

  if ($A3!="") {
    $s_MessageBody=$s_MessageBody.$Q3." ".$A3."\n\n";
  }

  if ($A4!="") {
    $s_MessageBody=$s_MessageBody.$A4."\n\n";
  }

  if ($A5!="") {
    $s_MessageBody=$s_MessageBody.$Q5." ".$A5."\n\n";
  }

  if ($A6!="") {
    $s_MessageBody=$s_MessageBody.$A6."\n\n";
  }

  if ($A7!="") {
    $s_MessageBody=$s_MessageBody.$Q7."\n";
    $s_MessageBody=$s_MessageBody.$A7."\n\n";
  }

  $sMsgText=$s_MessageBody;

  $strEmailTo = "sales@mwmf.co.uk";

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
      <td class=fld>Email</td><td><a href="mailto:sales@mwmf.co.uk">sales@mwmf.co.uk</a></td>
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
            <option>Santos</option>
            <option>Tristart</option>
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
   <td class=fld>Filter Papers (Wholesale Provision Only)</td>
   <td><input type="hidden" name="Q3" value="I require specific information on Filter Papers:">
          <select name="A3" size="1">
            <option selected value="">Select one of the following:</option>
            <option>Filtropa Filter Papers</option>
            <option>Basket Filters</option>
            <option>Shrink wrapped Filter papers</option>
            <option>Large Round Filter papers</option>
            <option>Polywrapped Filter papers</option>
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
            <option>Coffee Accessories</option>
            <option>Tea Accessories</option>
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
