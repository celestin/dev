<?php
/* * * * * * * * * * * * * * * * * * * * * * * *
 * West Coast Express Website
 * Copyright (c) 2006 Frontburner
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * Request Quotation Page Context
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  10-May-2006  File created.
 * CAM  11-Aug-2007  10149 : Call appropriate EmailMsg.
 * * * * * * * * * * * * * * * * * * * * * * * */

$title = "Request Quotation";
include 'tpl/top.php';
?>
<h3>Request Quotation</h3>
<?

$retry = NULL;            if (!empty($_POST['retry'])) $retry = $_POST['retry'];
$boattype = NULL;         if (!empty($_POST['boattype'])) $boattype = $_POST['boattype'];
$boatlength = NULL;       if (!empty($_POST['boatlength'])) $boatlength = $_POST['boatlength'];
$boatweight = NULL;       if (!empty($_POST['boatweight'])) $boatweight = $_POST['boatweight'];
$boatkeel = NULL;         if (!empty($_POST['boatkeel'])) $boatkeel = $_POST['boatkeel'];
$boatloc = NULL;          if (!empty($_POST['boatloc'])) $boatloc = $_POST['boatloc'];
$boatdest = NULL;         if (!empty($_POST['boatdest'])) $boatdest = $_POST['boatdest'];
$earlydate = NULL;        if (!empty($_POST['earlydate'])) $earlydate = $_POST['earlydate'];
$estval = NULL;           if (!empty($_POST['estval'])) $estval = $_POST['estval'];
$owntrailer = NULL;       if (!empty($_POST['owntrailer'])) $owntrailer = $_POST['owntrailer'];
$comments = NULL;         if (!empty($_POST['comments'])) $comments = $_POST['comments'];
$contactemail = NULL;     if (!empty($_POST['contactemail'])) $contactemail = $_POST['contactemail'];
$contactname = NULL;      if (!empty($_POST['contactname'])) $contactname = $_POST['contactname'];
$contacttel = NULL;       if (!empty($_POST['contacttel'])) $contacttel = $_POST['contacttel'];

if (empty($retry)) {
  include 'frm/quote.request.php';
} else if (empty($boatlength)) {
  Msg::error("Please specify the length of the boat.");
  include 'frm/quote.request.php';
} else if (empty($boatweight)) {
  Msg::error("Please specify the weight of the boat.");
  include 'frm/quote.request.php';
} else if (empty($boatloc)) {
  Msg::error("Please provide details of the boat&#039;s current physical location.");
  include 'frm/quote.request.php';
} else if (empty($boatdest)) {
  Msg::error("What is the boat&#039;s final destination?");
  include 'frm/quote.request.php';
} else if (empty($earlydate)) {
  Msg::error("When is the earliest date we can collect the boat?");
  include 'frm/quote.request.php';
} else if (empty($estval)) {
  Msg::error("What is the current estimated value of the boat (for insurance purposes)?");
  include 'frm/quote.request.php';
} else if (empty($owntrailer)) {
  Msg::error("What is the current estimated value of the boat (for insurance purposes)?");
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

  Msg::statement("Thank you - your request for quotation has been submitted.");

  $em = new EmailMsg('R');

  $em->sendRequest($boattype, $boatlength, $boatweight, $boatkeel,
                   $boatloc, $boatdest, $earlydate, $estval, $owntrailer, $comments,
                   $contactemail, $contactname, $contacttel);

  echo "<br><br><br><br><br><br>";

}

include 'tpl/bot.php';
?>