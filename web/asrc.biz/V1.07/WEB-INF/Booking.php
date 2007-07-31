<?php
/* * * * * * * * * * * * * * * * * * * * * * * *
 * ASRC.biz (Aberdeen Squash Racquets Club)
 *
 * Copyright (c) 2006 Frontburner
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * Booking already made.
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  06-May-2005  File created.
 * * * * * * * * * * * * * * * * * * * * * * * */

include_once 'inc.php';

/**
* Booking made.
*
* @author Craig McKay
* @version 2005
* @public
*/
class Booking {

  /**
  * Day Booking applies to (MySQL WEEKDAY function - 0=Monday)
  * @private
  * @type int
  */
  var $bookDate;

  /**
  * Starting Time of Booking.
  * @private
  * @type Time
  */
  var $timeStart;

  /**
  * End Time of Booking (i.e. Game must end before this point)
  * @private
  * @type Time
  */
  var $timeEnd;

  function Booking($timeStart, $duration) {
    $this->timeStart = Util::strToTimestamp($timeStart);
    $this->timeEnd = $this->timeStart + ($duration * 60);
  }

  function isValid($slot) {
    $dateStart = Util::strToTimestamp($slot->getStartTime());
    $dateEnd = $dateStart + ($slot->getDuration() * 60);

    return ((($dateStart < $this->timeStart) && ($dateEnd < $this->timeEnd))
         || (($dateStart > $this->timeStart) && ($dateEnd > $this->timeEnd)));
  }
}
?>