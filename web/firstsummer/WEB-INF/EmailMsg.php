<?php
/* * * * * * * * * * * * * * * * * * * * * * * *
 * First Summerhouses
 * Copyright (c) 2006 Frontburner
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * EmailMsg - Sends an Email
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  10-Feb-2006  File created.
 * CAM  25-Nov-2006  10012 : File added.
 * * * * * * * * * * * * * * * * * * * * * * * */

include_once 'Main.php';

class EmailMsg {

  function EmailMsg() {
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
          "<link href=" . $cfg['Site']['URL'] . "/firstsummer.css rel=stylesheet type=text/css>".
          "</head><body>".
            "<table cellspacing=5 cellpadding=0 border=0>".
              "<tr>".
                "<td class=\"topLogo\"><img width=\"455\" height=\"50\" src=\"" . $cfg['Site']['URL'] . "/img/first_main1.png\"></td>".
              "</tr><tr>".
                "<td><table width=\"600\" border=0 cellpadding=2>";
  }

  function getHTMLEnd() {
    $cr = "\r\n";
    return "</table></td>".
        "</tr></table>$cr$cr$cr".
      "</body></html>$cr";
  }

  function sendRequestEmail($contactProduct, $contactName, $contactEmail, $contactComments) {
    global $cfg;

    $to = $cfg['Site']['Email'];
    $cc = $contactEmail;
    $subject = "Email me Now about the $contactProduct!";
    $cr = "\r\n";

    $message = $this->getHTMLStart($subject);
    $message .= "<tr><td colspan=2><b>$contactName</b> would like an email about the <b>$contactProduct</b>.</td></tr>$cr".
            "<tr><td colspan=2>&nbsp;</td></td>$cr".
            "<tr><td class=\"fldlbl\">Time Sent</td>  <td>". strftime("%a %d %b %H:%M") ."</td></tr>$cr".
            "<tr><td class=\"fldlbl\">Email</td>      <td><a href=\"mailto:$contactEmail\">$contactEmail</a></td></tr>$cr".
            "<tr><td class=\"fldlbl\">Comments</td>   <td>$contactComments</td></tr>$cr";
    $message .= $this->getHTMLEnd();

    mail($to,$subject,$message,$this->getHeaders($cc));
  }

  function sendRequestCall($contactProduct, $contactName, $contactTel, $contactComments) {
    global $cfg;

    $to = $cfg['Site']['Email'];
    $subject = "Call me Now about the $contactProduct!";
    $cr = "\r\n";

    $message = $this->getHTMLStart($subject);
    $message .= "<tr><td colspan=2><b>$contactName</b> would like a call about the <b>$contactProduct</b>.</td></tr>$cr".
            "<tr><td colspan=2>&nbsp;</td></td>$cr".
            "<tr><td class=\"fldlbl\">Time Sent</td>  <td>". strftime("%a %d %b %H:%M") ."</td></tr>$cr".
            "<tr><td class=\"fldlbl\">Telephone</td>  <td>$contactTel</td></tr>$cr".
            "<tr><td class=\"fldlbl\">Comments</td>   <td>$contactComments</td></tr>$cr";
    $message .= $this->getHTMLEnd();

    mail($to,$subject,$message,$this->getHeaders($cc));
  }

}
?>