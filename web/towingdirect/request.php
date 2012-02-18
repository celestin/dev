<?php
/* * * * * * * * * * * * * * * * * * * * * * * *
 * TowingDirect Website
 * Copyright (c) 2010 Frontburner
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * Request for Quotation Page Context
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  10-May-2006  File created.
 * CAM  11-Aug-2007  10149 : Call appropriate EmailMsg.
 * CAM  11-Aug-2007  10150 : Removed 'Quotation' in the information message.
 * CAM  11-Aug-2007  10150 : Add 'Quotation' back into the information message.
 * CAM  11-Aug-2007  10153 : Added new Title graphic.
 * CAM  30-Oct-2010  10802 : Added Google Code for Lead Conversion.
 * CAM  18-Feb-2012  11082 : Updated Request Form for Carried Safely.
 * * * * * * * * * * * * * * * * * * * * * * * */

$title = "Request for Quotation";
include 'tpl/top.php';
?>
<center><img style="padding-bottom:5px" src="img/title/rfq.png"></center>
<?

$retry = NULL;               if (!empty($_POST['retry'])) $retry = $_POST['retry'];

$vehiclemake = NULL;         if (!empty($_POST['vehiclemake'])) $vehiclemake = $_POST['vehiclemake'];
$vehiclemodel = NULL;        if (!empty($_POST['vehiclemodel'])) $vehiclemodel = $_POST['vehiclemodel'];
$vehiclelength = NULL;       if (!empty($_POST['vehiclelength'])) $vehiclelength = $_POST['vehiclelength'];
$vehicleweight = NULL;       if (!empty($_POST['vehicleweight'])) $vehicleweight = $_POST['vehicleweight'];
$vehiclevalue = NULL;        if (!empty($_POST['vehiclevalue'])) $vehiclevalue = $_POST['vehiclevalue'];
$vehiclecondition = NULL;    if (!empty($_POST['vehiclecondition'])) $vehiclecondition = $_POST['vehiclecondition'];

$collectionaddress = NULL;   if (!empty($_POST['collectionaddress'])) $collectionaddress = $_POST['collectionaddress'];
$deliveryaddress = NULL;     if (!empty($_POST['deliveryaddress'])) $deliveryaddress = $_POST['deliveryaddress'];

$earlydate = NULL;        if (!empty($_POST['earlydate'])) $earlydate = $_POST['earlydate'];
$estval = NULL;           if (!empty($_POST['estval'])) $estval = $_POST['estval'];
$comments = NULL;         if (!empty($_POST['comments'])) $comments = $_POST['comments'];
$contactemail = NULL;     if (!empty($_POST['contactemail'])) $contactemail = $_POST['contactemail'];
$contactname = NULL;      if (!empty($_POST['contactname'])) $contactname = $_POST['contactname'];
$contacttel = NULL;       if (!empty($_POST['contacttel'])) $contacttel = $_POST['contacttel'];

if (empty($retry)) {
  include 'frm/quote.request.php';
} else if (empty($vehiclemake)) {
  Msg::error("Please specify the make of the vehicle.");
  include 'frm/quote.request.php';
} else if (empty($vehiclemodel)) {
  Msg::error("Please specify the model of the vehicle.");
  include 'frm/quote.request.php';
} else if (empty($vehiclelength)) {
  Msg::error("Please specify the length of the vehicle.");
  include 'frm/quote.request.php';
} else if (empty($vehicleweight)) {
  Msg::error("Please specify the weight of the vehicle.");
  include 'frm/quote.request.php';
} else if (empty($vehiclevalue)) {
  Msg::error("Please specify the approximate value of the vehicle.");
  include 'frm/quote.request.php';
} else if (empty($collectionaddress)) {
  Msg::error("Please provide details of the vehicle&#039;s current physical location.");
  include 'frm/quote.request.php';
} else if (empty($deliveryaddress)) {
  Msg::error("What is the vehicle&#039;s final destination?");
  include 'frm/quote.request.php';
} else if (empty($earlydate)) {
  Msg::error("When is the earliest date we can collect the boat?");
  include 'frm/quote.request.php';
} else if (empty($contactemail)) {
  Msg::error("Please provide a contact Email address (or N/A if not available).");
  include 'frm/quote.request.php';
} else if (empty($contactname)) {
  Msg::error("Please provide a Contact Name.");
  include 'frm/quote.request.php';
} else if (empty($contacttel)) {
  Msg::error("Please provide a Contact Telephone (Landline or Mobile) number.");
  include 'frm/quote.request.php';
} else {

  Msg::statement("Thank you - your Request for Quotation has been submitted.");

?>
<!-- Google Code for Lead Conversion Page -->
<script type="text/javascript">
/* <![CDATA[ */
var google_conversion_id = 999768902;
var google_conversion_language = "en";
var google_conversion_format = "2";
var google_conversion_color = "ffffff";
var google_conversion_label = "O9B8CJL07gEQxobd3AM";
var google_conversion_value = 0;
/* ]]> */
</script>
<script type="text/javascript" src="http://www.googleadservices.com/pagead/conversion.js">
</script>
<noscript>
<div style="display:inline;">
<img height="1" width="1" style="border-style:none;" alt="" src="http://www.googleadservices.com/pagead/conversion/999768902/?label=O9B8CJL07gEQxobd3AM&amp;guid=ON&amp;script=0"/>
</div>
</noscript>
<?

  $em = new EmailMsg('R');

  $em->sendRequest($vehiclemake, $vehiclemodel, $vehiclelength, $vehicleweight, $vehiclevalue, $vehiclecondition,
                   $collectionaddress, $deliveryaddress, $earlydate, $comments,
                   $contactemail, $contactname, $contacttel);

  echo "<br><br><br><br><br><br>";

}

include 'tpl/bot.php';
?>