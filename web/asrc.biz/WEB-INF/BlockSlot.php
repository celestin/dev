<?php
/* * * * * * * * * * * * * * * * * * * * * * * *
 * ASRC.biz (Aberdeen Squash Racquets Club)
 *
 * Copyright (c) 2006 Frontburner
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * BlockSlot Class
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  19-Jan-2006  9 : File created.
 * * * * * * * * * * * * * * * * * * * * * * * */

include_once 'Main.php';

/**
* Slot information for Block Bookings.
*
* @author Craig McKay
* @version 2006
* @public
*/
class BlockSlot {

  /**
  * Court ID.
  * @private
  * @type String
  */
  var $court;

  /**
  * Member Booked - a member who has already booked this slot.
  * @private
  * @type String
  */
  var $member_booked;

  /**
  * Slot identifier.
  * @private
  * @type int
  */
  var $id;

  /**
  * Start time of slot.
  * @private
  * @type time (String)
  */
  var $startTime;

  /**
  * Duration of slot.
  * @private
  * @type int
  */
  var $duration;

  function BlockSlot($court, $member_booked, $id, $startTime, $duration) {
    $this->court = $court;
    $this->member_booked = $member_booked;
    $this->id = $id;
    $this->startTime = substr($startTime,0,5);
    $this->duration = $duration;
  }

  function getID()          { return $this->id; }
  function getStartTime()   { return $this->startTime; }
  function getDuration()    { return $this->duration; }

  function getEndTime($html=false) {
    $dateStart = strtotime("1-Jan-2004 " . $this->startTime);
    $dateEnd = strtotime("+" . $this->duration . " min", $dateStart);
    return date("H:i", $dateEnd);
  }

  /**
  * Return the checkbox and text representing the Slot time, including the specified date.
  *
  * @public
  * @returns HTML
  */
  function dateLink($book_date) {
    $href = "<a href=\"newbooking.php?book_date=$book_date" .
            "&book_time=" . urlencode($this->startTime);

    if (!empty($this->member_orig)) $href .= "&member_orig=" . $this->member_orig;

    if ($this->court>0) {
      $href .= "&court=" . $this->court .
               "&duration=" . $this->duration;
    }

    if (!empty($this->id)) {
      $href .= "&slot=" . $this->id;
    }

    $href .= "\">";

    if ($this->court>0) {
      $href .= "Court " . $this->courtName . ", ";
    }

    $href .= $this->getStartTime();


    if ($this->court>0) {
      $href .= " - " . $this->getEndTime();
    }

    $href .= "</a>";

    return $href;
  }

  /**
  * Format this BlockSlot as an HTML Form element.
  *
  * @public
  * @returns HTML Form String
  */
  function toFormString() {

    $id = implode("|", array($this->court, $this->id));

    $s = "<tr height=22><td>";

    if (!empty($this->member_booked)) {
      $s .= "&nbsp";
    } else {
      $s .= "<input type=\"checkbox\" name=\"blockslot[]\" value=\"$id\">";
    }

    $s .= "</td><td>";

    if (!empty($this->member_booked)) {
      $s .= "$this->startTime";
    } else {
      $s .= "<b>$this->startTime</b> ($this->duration)";
    }

    $s .= "</td></tr>";

    return $s;
  }

  /**
  * Format this BlockSlot as a String.
  *
  * @param boolean Show ID
  *
  * @public
  * @returns String
  */
  function toString() {
    return "$this->court, $this->member_booked, $this->id, $this->startTime, $this->duration";
  }
}
?>