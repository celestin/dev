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

  function EmailMsg($emailType, $memberId) {
    $this->emailType = $emailType;
    $this->memPerson = Person::getPerson($memberId);

    if ($emailType == 'N') {
      $this->typeDesc = "Notification";
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
          "<link href=" . $cfg['Site']['Name'] . "/cc.css rel=stylesheet type=text/css>".
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

  function sendVerify($verify_code) {
    global $cfg;

    $to = $this->memPerson->getEmail();
    $cc = $cfg['Site']['Email'];
    $subject = "Email Verification";
    $cr = "\r\n";

    $url = $cfg['Site']['URL'] . "/verifyemail.php?username=" . $this->memPerson->getID() .
           "&code=$verify_code";

    $message = $this->getHTMLStart($subject);
    $message .= "<tr><td>Hi " . $this->memPerson->getFirstname() . ",<br><br>$cr$cr".
            "Thank you for registering with Christian Corner.$cr".
            "Please verify your email address by clicking on the link below:<br>$cr".
            "<a href=\"$url\">$url</a>$cr".
            "</td></tr>$cr";
    $message .= $this->getHTMLEnd();

    mail($to,$subject,$message,$this->getHeaders($cc));
  }


  function sendReviewQuestion($question) {
    global $cfg;

    $to = $cfg['Site']['Email'];
    $subject = "Review Question";
    $cr = "\r\n";

    $url = $cfg['Site']['URL'] . "/question.review.php?question=$question";

    $message = $this->getHTMLStart($subject);
    $message .= "<tr><td>" . $this->memPerson->getDesc() .
            " has created a new question.<br>$cr".
            "Please review by clicking on the link below:<br>$cr".
            "<a href=\"$url\">$url</a></td></tr>$cr";
    $message .= $this->getHTMLEnd();

    mail($to,$subject,$message,$this->getHeaders());
  }


  function sendForgot($new_pwd) {
    global $cfg;

    $to = $this->memPerson->getEmail();
    $subject = "Your " . $cfg['Site']['Name'] . " password for $memberid";
    $cr = "\r\n";

    $url = $cfg['Site']['URL'] . "/login.php";

    $message = $this->getHTMLStart($subject);
    $message .= "<tr><td>Hi " . $this->memPerson->getFirstname() . ",<br>$cr".
            "We have reset your password to: $new_pwd.$cr".
            "Please use the link below to login:<br>$cr".
            "<a href=\"$url\">$url</a><br>$cr".
            "Thanks!<br>$cr".
            $cfg['Site']['Name'] . "<br>$cr".
            "</td></tr>$cr";
    $message .= $this->getHTMLEnd();

    mail($to,$subject,$message,$this->getHeaders());
  }
}
?>