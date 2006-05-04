<?php
/* * * * * * * * * * * * * * * * * * * * * * * *
 * ASRC.biz (Aberdeen Squash Racquets Club)
 *
 * Copyright (c) 2006 Frontburner
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * Membership Type Restriction
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  06-May-2005  File created.
 * * * * * * * * * * * * * * * * * * * * * * * */

include_once 'inc.php';

/**
* Restriction for a given Membership Type.
*
* @author Craig McKay
* @version 2005
* @public
*/
class Restriction {

  /**
  * Day restriction applies to (MySQL WEEKDAY function - 0=Monday)
  * @private
  * @type int
  */
  var $day;

  /**
  * Starting Time of Restriction.
  * @private
  * @type Time
  */
  var $timestart;

  /**
  * End Time of Restriction (i.e. Game must end before this point)
  * @private
  * @type Time
  */
  var $timeend;

  function Restriction($day, $timestart, $timeend) {
    $this->day = $day;
    $this->timestart = Util::strToTimestamp($timestart);
    $this->timeend = Util::strToTimestamp($timeend);
  }

  function isValid($date, $slot) {
    $dateStart = Util::strToTimestamp($slot->getStartTime());
    $dateEnd = $dateStart + ($slot->getDuration() * 60);

    $ok = ((($dateStart >= $this->timestart) && ($dateStart <= $this->timeend))
            && (($dateEnd >= $this->timestart) && ($dateEnd <= $this->timeend)));

    return $ok;
  }

  function forToday($date) {
    $dow = Util::myWeekday($date);
    return ($dow == $this->day);
  }
}
?>