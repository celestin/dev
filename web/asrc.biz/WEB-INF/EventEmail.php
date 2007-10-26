<?php
/* * * * * * * * * * * * * * * * * * * * * * * *
 * ASRC.biz (Aberdeen Squash Racquets Club)
 * Copyright (c) 2007 Frontburner
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  26-Oct-2007  10195 : File created.
 * * * * * * * * * * * * * * * * * * * * * * * */

include_once 'Main.php';

/**
* EventEmail information.
*
* @author Craig McKay
* @version 2007
* @public
*/
class EventEmail extends EmailMsg {

  var $eventDate;
  var $eventTitle;
  var $eventText;

  function EventEmail($memberId, $eventDate, $eventTitle, $eventText) {
    $this->memberId = $memberId;

    $this->eventDate = $eventDate;
    $this->eventTitle = $eventTitle;
    $this->eventText = $eventText;
  }

  function send() {
    global $cfg;

    $memPerson = Person::getPerson($this->memberId);

    $cr = "\r\n";

    $to = $memPerson->getEmail();
    if ($cfg['Site']['Test'] === TRUE) {
      $to = $cfg['Site']['Email'];
    }

    $title = "ASRC Event";
    $subject = $title . ": " . $this->eventDate . " - " . $this->eventTitle;

    if ($cfg['Site']['Test'] === TRUE) {
      $subject .= " (TEST SYSTEM)";
    }

    $message = $this->getTop($title) .
            "<tr><td class=item_date>" . $this->eventDate . "  </td><td class=item_title>" . $this->eventTitle . "</td></tr>$cr$cr".
            "<tr><td colspan=2 class=item_text>" . Util::textBoxToHtml($this->eventText) . "</td></tr>$cr";

    $message .= $this->getBottom();

    mail($to,$subject,$message,$this->getHeaders());
  }
}
?>