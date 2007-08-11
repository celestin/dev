<?php
/* * * * * * * * * * * * * * * * * * * * * * * *
 * West Coast Express Website
 * Copyright (c) 2006-2007 Frontburner
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * EmailMsg - Sends an Email
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  13-Apr-2006  File created.
 * CAM  11-Aug-2007  10149 : Ensure Forgotten Passwords send correctly.
 * * * * * * * * * * * * * * * * * * * * * * * */

include_once 'Main.php';

/**
* EmailMsg information.
*
* @author Craig McKay
* @version 2005
* @public
*/
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

  function EmailMsg($emailType, $memberId='') {
    $this->emailType = $emailType;
    $this->memPerson = Person::getPerson($memberId);

    if ($emailType == 'I') {
      $this->typeDesc = "Information Request";
    } else if ($emailType == 'V') {
      $this->typeDesc = "User Verification";
    } else {
      $this->typeDesc = "Password Reminder";
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
          "<link href=\"" . $cfg['Site']['URL'] . "/wce.css\" rel=stylesheet type=text/css>".
          "</head><body>".
          "<table cellspacing=0 cellpadding=0 border=0 width=\"100%\">".
            "<tr><td valign=center align=center><table cellspacing=5 cellpadding=0 border=0>".
              "<tr>".
                "<td colspan=2 align=center><b>$subject</b></td>$cr$cr".
              "</tr><tr>".
                "<td><table width=\"100%\" border=0 cellpadding=2>";
  }

  function getHTMLEnd() {
    $cr = "\r\n";
    return "</table></td>".
        "</tr></table>".
      "</td></tr>".
    "</table>$cr".
    "</body></html>$cr";
  }

  function sendRequest($boattype, $boatlength, $boatweight, $boatkeel,
                       $boatloc, $boatdest, $earlydate, $estval, $owntrailer, $comments,
                       $contactemail, $contactname, $contacttel) {
    global $cfg;

    $to = $cfg['Site']['Email'];
    $cc = $contactemail;
    $subject = "Request for Quotation";
    $cr = "\r\n";

    $message = $this->getHTMLStart($subject) .
      "<tr><td class=fld>Type of Boat                </td><td>" . $boattype . "</td></tr>$cr$cr".
      "<tr><td class=fld>Length of boat              </td><td>" . $boatlength . "</td></tr>$cr$cr".
      "<tr><td class=fld>Weight of boat              </td><td>" . $boatweight . "</td></tr>$cr$cr".
      "<tr><td class=fld>Type of Keel                </td><td>" . $boatkeel . "</td></tr>$cr$cr".
      "<tr><td class=fld>Location (present position) </td><td>" . $boatloc . "</td></tr>$cr$cr".
      "<tr><td class=fld>Destination                 </td><td>" . $boatdest . "</td></tr>$cr$cr".
      "<tr><td class=fld>Ealiest preferred date      </td><td>" . $earlydate . "</td></tr>$cr$cr".
      "<tr><td class=fld>Estimated value             </td><td>" . $estval . "</td></tr>$cr$cr".
      "<tr><td class=fld>Own trailer?                </td><td>" . $owntrailer . "</td></tr>$cr$cr".
      "<tr><td class=fld>Additional comments         </td><td>" . $comments . "</td></tr>$cr$cr".
      "<tr><td class=fld>Email Address               </td><td>" . $contactemail . "</td></tr>$cr$cr".
      "<tr><td class=fld>Contact Name                </td><td>" . $contactname . "</td></tr>$cr$cr".
      "<tr><td class=fld>Contact Tel                 </td><td>" . $contacttel . "</td></tr>$cr$cr".
      $this->getHTMLEnd();

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