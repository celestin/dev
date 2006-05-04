<?php
/* * * * * * * * * * * * * * * * * * * * * * * *
 * Slot Class
 * Copyright (c) 2004-2005 Southesk.com
 *
 * $Log: /web/asrc.biz/WEB-INF/Slot.php $
 * 
 * 1     23/05/05 21:45 Craig
 *
 * Who  When         Why
 * CAM  20-Mar-2004  File created.
 * * * * * * * * * * * * * * * * * * * * * * * */

include_once 'Main.php';

/**
* Slot information.  Mirrors the 'slot' database table.
*
* @author Craig McKay
* @version 2004
* @public
*/
class Slot {

  /**
  * Court ID.
  * @private
  * @type String
  */
  var $court;

  /**
  * Court Name.
  * @private
  * @type String
  */
  var $courtName;

  /**
  * Originator Member - for whom Court bookings will be made.
  * @private
  * @type String
  */
  var $member_orig;

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

  function Slot($member_orig='', $court, $courtName, $id='', $startTime, $duration) {
    $this->member_orig = $member_orig;

    $this->court = $court;
    $this->courtName = $courtName;

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

  function isAfter($givenDate) {
    $givenTime = strtotime($givenDate);
    $dateStart = strtotime(date("j-M-Y", $givenTime) . " " . $this->startTime);

    if ($dateStart > time()) {
      return true;
    }

    return false;
  }

  /**
  * Return the anchored text representing the Slot time, including the specified date.
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
}
?>