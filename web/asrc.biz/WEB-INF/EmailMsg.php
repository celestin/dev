<?php
/* * * * * * * * * * * * * * * * * * * * * * * *
 * ASRC.biz (Aberdeen Squash Racquets Club)
 * Copyright (c) 2006-2007 Frontburner
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * Sends Emails for the system
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  4-May-2005   File created.
 * CAM  08-Feb-2007  10098 : Added Valentines Dance.
 * CAM  05-Mar-2007  10098 : Removed Valentines Dance.
 * CAM  05-Mar-2007  10098 : Corrected CSS.
 * CAM  25-Jun-2007  10133 : Ensure Test emails are sent to the Development email.
 * CAM  12-Aug-2007  10157 : Improve HTML emails.
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
  * Booking Date (formatted).
  * @private
  * @type date (String)
  */
  var $bookDate;

  /**
  * Start time of Booking (formatted).
  * @private
  * @type time (String)
  */
  var $startTime;

  /**
  * Court ID.
  * @private
  * @type int
  */
  var $court;

  /**
  * Originator Member
  * @private
  * @type String
  */
  var $memberId;

  /**
  * Opponent Member
  * @private
  * @type String
  */
  var $opponentId;

  /**
  * Email for booking made on behalf on the Opponent
  * @private
  * @type boolean
  */
  var $behalf;

  function EmailMsg($emailType, $bookDate, $startTime, $court, $memberId, $opponentId='', $behalf=false) {
    $this->emailType = $emailType;
    $this->bookDate = date("l d M", strtotime($bookDate));
    $this->startTime = $startTime;
    $this->court = $court;
    $this->memberId = $memberId;
    $this->opponentId = $opponentId;
    $this->behalf = $behalf;

    if ($emailType == 'N') {
      $this->typeDesc = "Notification";
    } else {
      $this->typeDesc = "Reminder";
    }
  }

  function send() {
    global $cfg;

    $memPerson = Person::getPerson($this->memberId);

    $opp = false;
    if (!empty($this->opponentId)) {
      $oppPerson = Person::getPerson($this->opponentId);
      $opp = true;
    }

    $cr = "\r\n";
    $to = "";
    $cc = "";

    if ($this->behalf) {
      $to = $oppPerson->getEmail();
      if ($this->emailType == 'R') $cc = $memPerson->getEmail();
    } else {
      $to = $memPerson->getEmail();
      if ($opp) $cc = $oppPerson->getEmail();
    }

    if ($cfg['Site']['Test'] === TRUE) {
      $to = $cfg['Site']['Email'];
      $cc = "";
    }

    $headers = "From: ASRC <bookings@asrc.biz>$cr";
    if (!empty($cc)) $headers .= "Cc: $cc$cr";
    $headers .= "MIME-Version: 1.0$cr";
    $headers .= "X-Priority: 1$cr";
    $headers .= "Content-Type: text/html; charset=ISO-8859-1$cr";

    $title = "Squash Booking " . $this->typeDesc;
    $subject = $title . ": " . $this->bookDate . " at " . $this->startTime;

    if ($cfg['Site']['Test'] === TRUE) {
      $subject .= " (TEST SYSTEM)";
    }

    $message = "<html><head>$cr".
    "<link href=" . $cfg['Site']['URL'] . "/asrc.css rel=stylesheet type=text/css>".
    "</head><body>$cr".
    "<table cellspacing=0 cellpadding=0 border=0 width=\"100%\">".
      "<tr><td valign=center align=center><table cellspacing=5 cellpadding=0 border=0>".
        "<tr>".
          "<td colspan=2 align=center><b>$title</b></td>".
        "</tr><tr>".
          "<td class=topnav><table width=\"100%\" border=0 cellpadding=2 class=thinBox>$cr".
            "<tr><td class=fld>Booking on </td><td>" . $this->bookDate . "</td></tr>$cr".
            "<tr><td class=fld>At </td><td>" . $this->startTime . "</td></tr>$cr".
            "<tr><td class=fld>On Court </td><td>" . $this->court . "</td></tr>$cr";

            if ($this->behalf) {
              $message .= "<tr><td class=fld>For you </td><td>" . $oppPerson->toHtmlString(true) . "</td></tr>$cr".
              "<tr><td class=fld>On your behalf by </td><td>" . $memPerson->toHtmlString(true) . "</td></tr>$cr";
            } else {
              $message .= "<tr><td class=fld>For you </td><td>" . $memPerson->toHtmlString(true) . "</td></tr>$cr";
              if ($opp) {
                $message .= "<tr><td class=fld>With </td><td>" . $oppPerson->toHtmlString(true) . "</td></tr>$cr";
              }
            }

          $message .= "</table></td>".
        "</tr></table>".
      "</td></tr>";

/*
      $message .= "<tr><td>A.S.R.C. are celebrating <br>$cr".
              "<b>Valentine's Day</b> by holding <br>$cr".
              "a Valentine Dance <br>$cr".
              "on <b>Saturday 17th February</b> <br>$cr".
              "in our Newly-refurbished Lounge Bar.<br>$cr".
              "<br>$cr".
              "<b>Tickets are only &pound;10.</b><br>$cr".
              "<br>$cr".
              "Dancing from <b>8pm to 1am</b> to <br>$cr".
              "the extraordinary sound of <br>$cr".
              "<b>The Smokin' Bert Cooper Band</b><br>$cr".
              "Sumptuous buffet included! <br>$cr".
              "Don't miss this great night out...<br>$cr".
              "get your tickets from reception.<br>$cr".
              "Numbers restricted - <b>so be quick</b>!</td></tr>";
*/

    $message .= "</table>".
    "</body></html>";

    mail($to,$subject,$message,$headers);
  }
}
?>