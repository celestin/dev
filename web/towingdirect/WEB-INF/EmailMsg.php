<?php
/* * * * * * * * * * * * * * * * * * * * * * * *
 * TowingDirect Website
 * Copyright (c) 2012 Front Burner
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * EmailMsg - Sends an Email
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  13-Apr-2006  File created.
 * CAM  11-Aug-2007  10149 : Ensure Forgotten Passwords send correctly.
 * CAM  11-Aug-2007  10150 : Changed 'Request for Quotation' to 'Confirmation of Request'.
 * CAM  11-Aug-2007  10150 : Changed back to 'Request for Quotation' and set email as though it has come from form filler.
 * CAM  18-Feb-2012  11082 : Updated Request Form for Carried Safely.
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
      $this->typeDesc = "Confirmation of Request";
    } else if ($emailType == 'V') {
      $this->typeDesc = "User Verification";
    } else {
      $this->typeDesc = "Password Reminder";
    }
  }

  function getHeaders($cc='', $from='') {
    global $cfg;

    if (empty($from)) $from = $cfg['Site']['Name'] . "<" . $cfg['Site']['Email'] . ">";

    $cr = "\r\n";
    $headers = "From: $from$cr";
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
          "<link href=" . $cfg['Site']['URL'] . "/wce.css rel=stylesheet type=text/css>".
          "</head><body style='background-color:white'>".
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

  function sendRequest($vehiclemake, $vehiclemodel, $vehiclelength, $vehicleweight, $vehiclevalue, $vehiclecondition,
                       $collectionaddress, $deliveryaddress, $earlydate, $comments,
                       $contactemail, $contactname, $contacttel) {
    global $cfg;

    $to = $cfg['Site']['Email'];
    $subject = "Request for Quotation";
    $cr = "\r\n";

    $message = $this->getHTMLStart($subject) .
      "<tr><td class=fld>Vehicle Model               </td><td>" . $vehiclemake . "</td></tr>$cr$cr".
      "<tr><td class=fld>Vehicle Make                </td><td>" . $vehiclemodel . "</td></tr>$cr$cr".
      "<tr><td class=fld>Length of Vehicle           </td><td>" . $vehiclelength . "</td></tr>$cr$cr".
      "<tr><td class=fld>Weight of Vehicle           </td><td>" . $vehicleweight . "</td></tr>$cr$cr".
      "<tr><td class=fld>Approximate Vehicle Value   </td><td>" . $vehiclevalue . "</td></tr>$cr$cr".
      "<tr><td class=fld>Condition of Vehicle        </td><td>" . (empty($vehiclecondition) || ($vehiclecondition == "RUNNING")) ? "Running" : "Not running" . "</td></tr>$cr$cr".
      "<tr><td class=fld>Collection Address          </td><td>" . $collectionaddress . "</td></tr>$cr$cr".
      "<tr><td class=fld>Delivery Address            </td><td>" . $deliveryaddress . "</td></tr>$cr$cr".
      "<tr><td class=fld>Ealiest preferred date      </td><td>" . $earlydate . "</td></tr>$cr$cr".
      "<tr><td class=fld>Additional comments         </td><td>" . $comments . "</td></tr>$cr$cr".
      "<tr><td class=fld>Email Address               </td><td>" . $contactemail . "</td></tr>$cr$cr".
      "<tr><td class=fld>Contact Name                </td><td>" . $contactname . "</td></tr>$cr$cr".
      "<tr><td class=fld>Contact Tel                 </td><td>" . $contacttel . "</td></tr>$cr$cr".
      $this->getHTMLEnd();

    mail($to,$subject,$message,$this->getHeaders('', "\"$contactname (via " . $cfg['Site']['Name'] . ")\" <$contactemail>"));
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