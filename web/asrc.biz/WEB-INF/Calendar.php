<?php
/* * * * * * * * * * * * * * * * * * * * * * * *
 * ASRC.biz (Aberdeen Squash Racquets Club)
 *
 * Copyright (c) 2006 Frontburner
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * Calendar Class
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  20-Mar-2004  File created.
 * CAM  08-Feb-2007  10097 : Correct Sort order.
 * * * * * * * * * * * * * * * * * * * * * * * */

include_once 'inc.php';

/**
* Calendar for handling Dates and Times.
*
* @author Craig McKay
* @version 2004
* @public
*/
class Calendar {

  /**
  * The Timenow.
  * @private
  * @type String
  */
  var $today;

  /**
  * Originator Member - for whom Court bookings will be made.
  * @private
  * @type String
  */
  var $member_orig;

  /**
  * Court details.
  * @private
  * @type Array of Courts
  */
  var $court;

  /**
  * Slot details.  Available when a Booking Date is specified.
  * @private
  * @type Array of Slots
  */
  var $slot;

  /**
  * Membership Restrictions details.
  * @private
  * @type Array of Restrictions
  */
  var $restrict;

  /**
  * Previously made Bookings.
  * @private
  * @type Array of Bookings
  */
  var $bookings;

  function Calendar($member_orig='', $bookDate='', $bookTime='', $duration='', $court='', $slot='') {
    $this->today = time();
    $this->member_orig = $member_orig;

    $this->retrieveRestrictions();

    if (!empty($bookDate)) {
      $this->retrieveOtherBookings($bookDate);
      $this->retrieveSlots($bookDate, $bookTime, $duration, $court, $slot);
    }
  }

  function getCourts() {
    $this->court = array();
    $i=0;

    $sql = mysql_query("SELECT court,name,week_cutoff FROM court ORDER BY court");
    while ($row = mysql_fetch_array($sql)) {
      foreach($row AS $key => $val) {
        $$key = stripslashes($val);
      }

      $this->court[$i++] = new Court($court,$name,$week_cutoff);
    }
  }

  function retrieveSlots($bookDate='', $bookTime='', $duration='', $court='', $slot='') {
    $this->slot = array();
    $i=0;

    $ssql = "SELECT ";

    if (empty($bookTime)) {
      $ssql .= "DISTINCT -1 court,null court_name, -1 slot,s.start_time, -1 duration ";
    } else {
      $ssql .= "c.court,c.name court_name,s.slot,s.start_time,s.duration ";
    }

    $ssql .= "FROM slot s, court c " .
             "LEFT JOIN booking b " .
             "ON s.slot = b.slot " .
             "AND s.court = b.court  " .
             "AND b.book_date = '" . Util::displayToSqlDate($bookDate) . "' " .
             "WHERE s.court = c.court " .
             "AND c.online = 1 ";
             "AND b.slot IS NULL ";

    if (!empty($bookTime)) {
      $ssql .= "AND s.start_time = '" . $bookTime . "' ";
    }
    if (!empty($duration)) {
      $ssql .= "AND s.duration = '" . $duration . "' ";
    }
    if (!empty($court)) {
      $ssql .= "AND s.court = '" . $court . "' ";
    }
    if (!empty($slot)) {
      $ssql .= "AND s.slot = '" . $slot . "' ";
    } else {
      $ssql .= "AND b.slot IS NULL ";
    }

    $ssql .= "ORDER BY 1,4";

    $sql = mysql_query($ssql) or die (mysql_error());
    while ($row = mysql_fetch_array($sql)) {
      foreach($row AS $key => $val) {
        $$key = stripslashes($val);
      }

      $s = new Slot($this->member_orig, $court, $court_name, $slot, $start_time, $duration);

      $ok = true;
      $rc = count($this->restrict);
      $j = 0;
      if ($rc > 0) {
        $ok = false;
        while ($j < $rc) {
          $r = $this->restrict[$j++];
          if ($r->forToday($bookDate)) {
            if ($r->isValid($bookDate, $s)) {
              $ok = true;
            }
          }
        }
      }

      $rc = count($this->booking);
      $j = 0;
      if ($rc > 0) {
        while ($j < $rc) {
          $bk = $this->booking[$j++];
          if (!$bk->isValid($s)) {
            $ok = false;
          }
        }
      }

      if ($ok) {
        $this->slot[$i++] = $s;
      }
    }
  }

  function retrieveRestrictions() {
    $this->restrict = array();
    $i=0;

    $ssql = "SELECT day,time_start,time_end ".
            "FROM member_limit ml, member m " .
            "WHERE ml.member_type = m.member_type " .
            "AND m.memberid ='" . $this->member_orig . "'";

    $sql = mysql_query($ssql) or die (mysql_error());
    while ($row = mysql_fetch_array($sql)) {
      foreach($row AS $key => $val) {
        $$key = stripslashes($val);
      }

      $this->restrict[$i++] = new Restriction($day, $time_start, $time_end);
    }
  }

  function retrieveOtherBookings($bookDate) {
    $this->booking = array();
    $i=0;

    $ssql = "SELECT s.start_time,s.duration ".
            "FROM booking b, slot s " .
            "WHERE s.court = b.court " .
            "AND s.slot = b.slot " .
            "AND memberid='" . $this->member_orig . "' " .
            "AND book_date='" . Util::displayToSqlDate($bookDate) . "'";

//print "<pre>" . $ssql . "</pre>";

    $sql = mysql_query($ssql) or die (mysql_error());
    while ($row = mysql_fetch_array($sql)) {
      foreach($row AS $key => $val) {
        $$key = stripslashes($val);
      }
      $this->booking[$i++] = new Booking($start_time, $duration);
    }
  }

  /**
  * Return the number of slots available for this date/time.
  *
  * @public
  * @returns int
  */
  function getSlotCount() {
    return count($this->slot);
  }

  /**
  * Return the specified slot.
  *
  * @public
  * @returns Slot
  */
  function getSlot($i) {
    return $this->slot[$i];
  }

  /**
  * Return the anchored text representing the date for the specified number of days from now.
  *
  * @public
  * @returns HTML
  */
  function dateLink($days=0) {
    $day = strtotime("+$days day", $this->today);

    $href = "<a href=\"newbooking.php?book_date=" . date("d-M-Y", $day);

    if ($days==7) $href .= "&day=7";
    if (!empty($this->member_orig)) $href .= "&member_orig=" . $this->member_orig;

    $href .= "\">" . date("l, d M Y", $day) . "</a>";

    return $href;
  }
}
?>