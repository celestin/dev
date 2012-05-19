<?php
/* * * * * * * * * * * * * * * * * * * * * * * *
 * ASRC.biz (Aberdeen Squash Racquets Club)
 * Copyright (c) 2007 Frontburner
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  26-Oct-2007  10195 : File derived from EmailMsg.
 * CAM  19-May-2012  11122 : Xodus Group Court naming.
 * * * * * * * * * * * * * * * * * * * * * * * */

include_once 'Main.php';

/**
* ReminderEmail information.
*
* @author Craig McKay
* @version 2005
* @public
*/
class ReminderEmail extends EmailMsg {

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
  * Court Name.
  * @private
  * @type string
  */
  var $courtname;

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

  function ReminderEmail($emailType, $bookDate, $startTime, $court, $memberId, $opponentId='', $behalf=false) {
    $this->emailType = $emailType;
    $this->bookDate = date("l d M", strtotime($bookDate));
    $this->startTime = $startTime;
    $this->court = $court;
    $this->memberId = $memberId;
    $this->opponentId = $opponentId;
    $this->behalf = $behalf;

    $crt = new Court($court);
    $this->courtname = $crt->desc;

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

    $title = "Squash Booking " . $this->typeDesc;
    $subject = $title . ": " . $this->bookDate . " at " . $this->startTime;

    if ($cfg['Site']['Test'] === TRUE) {
      $subject .= " (TEST SYSTEM)";
    }

    $message = $this->getTop($title) .
            "<tr><td class=fld>Booking on </td><td>" . $this->bookDate . "</td></tr>$cr".
            "<tr><td class=fld>At </td><td>" . $this->startTime . "</td></tr>$cr".
            "<tr><td class=fld>On </td><td>" . $this->courtname . "</td></tr>$cr";

            if ($this->behalf) {
              $message .= "<tr><td class=fld>For you </td><td>" . $oppPerson->toHtmlString(true) . "</td></tr>$cr".
              "<tr><td class=fld>On your behalf by </td><td>" . $memPerson->toHtmlString(true) . "</td></tr>$cr";
            } else {
              $message .= "<tr><td class=fld>For you </td><td>" . $memPerson->toHtmlString(true) . "</td></tr>$cr";
              if ($opp) {
                $message .= "<tr><td class=fld>With </td><td>" . $oppPerson->toHtmlString(true) . "</td></tr>$cr";
              }
            }

    $message .= $this->getBottom();

    mail($to,$subject,$message,$this->getHeaders($cc));
  }
}
?>
