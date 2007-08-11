<?php
/* * * * * * * * * * * * * * * * * * * * * * * *
 * First Summerhouses
 * Copyright (c) 2006-2007 Frontburner
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * EmailMsg - Sends an Email
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  10-Feb-2006  File created.
 * CAM  25-Nov-2006  10012 : File added.
 * CAM  11-Aug-2007  10158 : Added missing properties and methods to support sendForgot.
 * * * * * * * * * * * * * * * * * * * * * * * */

include_once 'Main.php';

class EmailMsg {

  /**
  * Email Type (Notification or Reminder).
  * @private
  * @type String
  */
  var $emailType;

  /**
  * Description of Email Type (Notification or Reminder).
  * @private
  * @type String
  */
  var $typeDesc;

  /**
  * Originator Member
  * @private
  * @type Person
  */
  var $memPerson;

  function EmailMsg($emailType, $memberId) {
    $this->emailType = $emailType;
    $this->memPerson = Person::getPerson($memberId);

    if ($emailType == 'N') {
      $this->typeDesc = "Notification";
    } else if ($emailType == 'F') {
      $this->typeDesc = "Password Reminder";
    } else {
      $this->typeDesc = "Reminder";
    }
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

  function sendForgot($new_pwd) {
    global $cfg;

    $to = $this->memPerson->getEmail();
    $subject = "Your " . $cfg['Site']['Name'] . " password for " . $this->memPerson->getID();
    $cr = "\r\n";

    $url = $cfg['Site']['URL'] . "/login.php";

    $message = $this->getHTMLStart($subject);
    $message .= "<tr><td><p>Hi " . $this->memPerson->getFirstname() . ",</p>$cr$cr".
            "<p>We have reset your password to: <b>$new_pwd</b>.</p>$cr".
            "<p>Please use the link below to login:<br>$cr".
            "<a href=\"$url\">$url</a></p>$cr$cr".
            "<p>Thanks!<br>$cr".
            "<b>" . $cfg['Site']['Name'] . "</b></p>$cr".
            "</td></tr>$cr";
    $message .= $this->getHTMLEnd();

    mail($to,$subject,$message,$this->getHeaders());
  }
}
?>