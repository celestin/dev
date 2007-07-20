<?php
/* * * * * * * * * * * * * * * * * * * * * * * *
 * First Summerhouses
 * Copyright (c) 2006 Frontburner
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * Price Edit page
 *
 * $Id: price.edit.php 310 2006-10-10 21:31:17Z craig $
 *
 * Who  When         Why
 * CAM  02-Oct-2006  10038 : Make Prices editable.
 * * * * * * * * * * * * * * * * * * * * * * * */

$cfg['Site']['Name']  = "EarnNow.info";
$cfg['Site']['URL']   = "http://www.earnnow.info";                 // no trailing slash
$cfg['Site']['Email'] = "acsupplies@aol.com";
$cfg['Site']['Test'] = FALSE;

if (strpos(strtolower($_SERVER['SERVER_NAME']), "king") !== FALSE) {
  $cfg['Site']['URL']   = "http://localhost/earnnow";
  $cfg['Site']['Test'] = TRUE;
  $cfg['Site']['Email'] = "craig@frontburner.co.uk";
}


function getHeaders($cc='') {
  global $cfg;

  $cr = "\r\n";
  $headers = "From: " . $cfg['Site']['Name'] . "<" . $cfg['Site']['Email'] . ">$cr";
  if (!empty($cc)) $headers .= "Cc: $cc$cr";
  $headers .= "MIME-Version: 1.0$cr";
  $headers .= "X-Priority: 1$cr";
  $headers .= "Content-Type: text/html; charset=ISO-8859-1$cr";
  return $headers;
}

function getHTMLStart($subject) {
  global $cfg;

  $cr = "\r\n";
  return "<html><head>".
        "<link href=" . $cfg['Site']['URL'] . "/earnnow.css rel=stylesheet type=text/css>".
        "</head><body>".
          "<table cellspacing=0 cellpadding=6 border=0>";
}

function getHTMLEnd() {
  $cr = "\r\n";
  return "</table>$cr$cr$cr".
    "</body></html>$cr";
}

$name = NULL;         if (!empty($_POST['name']))       $name = $_POST['name'];
$occupation = NULL;   if (!empty($_POST['occupation'])) $occupation = $_POST['occupation'];
$address1 = NULL;     if (!empty($_POST['address1']))   $address1 = $_POST['address1'];
$address2 = NULL;     if (!empty($_POST['address2']))   $address2 = $_POST['address2'];
$town = NULL;         if (!empty($_POST['town']))       $town = $_POST['town'];
$county = NULL;       if (!empty($_POST['county']))     $county = $_POST['county'];
$postcode = NULL;     if (!empty($_POST['postcode']))   $postcode = $_POST['postcode'];
$phone = NULL;        if (!empty($_POST['phone']))      $phone = $_POST['phone'];
$mobile = NULL;       if (!empty($_POST['mobile']))     $mobile = $_POST['mobile'];
$fax = NULL;          if (!empty($_POST['fax']))        $fax = $_POST['fax'];
$email = NULL;        if (!empty($_POST['email']))      $email = $_POST['email'];
$where = NULL;        if (!empty($_POST['where']))      $where = $_POST['where'];

$to = $cfg['Site']['Email'];
$subject = "Please contact me regarding EarnNow.info";
$cr = "\r\n";

$message = getHTMLStart($subject);
$message .= "<tr><td colspan=2><b>$name</b> would like an email about <b>" . $cfg['Site']['Name'] . "</b>.</td></tr>$cr".
        "<tr><td class=\"fldlbl\">Occupation</td>         <td class=\"fldtxt\">$occupation</td></tr>$cr".
        "<tr><td class=\"fldlbl\">Address 1</td>          <td class=\"fldtxt\">$address1</td></tr>$cr".
        "<tr><td class=\"fldlbl\">Address 2</td>          <td class=\"fldtxt\">$address2</td></tr>$cr".
        "<tr><td class=\"fldlbl\">Town</td>               <td class=\"fldtxt\">$town</td></tr>$cr".
        "<tr><td class=\"fldlbl\">County</td>             <td class=\"fldtxt\">$county</td></tr>$cr".
        "<tr><td class=\"fldlbl\">Postcode</td>           <td class=\"fldtxt\">$postcode</td></tr>$cr".
        "<tr><td class=\"fldlbl\">Phone</td>              <td class=\"fldtxt\">$phone</td></tr>$cr".
        "<tr><td class=\"fldlbl\">Mobile</td>             <td class=\"fldtxt\">$mobile</td></tr>$cr".
        "<tr><td class=\"fldlbl\">Fax</td>                <td class=\"fldtxt\">$fax</td></tr>$cr".
        "<tr><td class=\"fldlbl\">Email</td>              <td class=\"fldtxt\"><a href=\"mailto:$contactEmail\">$contactEmail</a></td></tr>$cr".
        "<tr><td class=\"fldlbl\">Where saw website</td>  <td class=\"fldtxt\">$where</td></tr>$cr";
$message .= getHTMLEnd();

echo $message . "<p>Thank you for your email enquiry, return <a href=\"/\">Home</a>.</p>";

mail($to,$subject,$message,getHeaders($email));

?>