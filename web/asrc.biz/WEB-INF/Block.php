<?php
/* * * * * * * * * * * * * * * * * * * * * * * *
 * ASRC.biz (Aberdeen Squash Racquets Club)
 *
 * Copyright (c) 2006-2007 Frontburner
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * Block Class
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  19-Jan-2006  9 : File created.
 * CAM  23-Jul-2007  10152 : Ensure Court Online date is observed.
 * * * * * * * * * * * * * * * * * * * * * * * */

include_once 'inc.php';

/**
* Calendar for handling Block Bookings.
*
* @author Craig McKay
* @version 2006
* @public
*/
class Block {

  /**
  * Booking Date.
  * @private
  * @type Date
  */
  var $bookdate;

  /**
  * Court details.
  * @private
  * @type Array of Courts
  */
  var $court;

  /**
  * Map of Court ID to index.
  * @private
  * @type Array of Courts
  */
  var $courtmap;

  /**
  * Slot details.  Available when a Booking Date is specified.
  * @private
  * @type 2D Array of Courts/Slots
  */
  var $slot;

  function Block($bookdate) {
    $this->bookdate = $bookdate;

    $this->getCourts();
    $this->retrieveSlots();
  }

  function getCourts() {
    $this->court = array();
    $this->courtmap = array();
    $i=0;

    $sql = mysql_query("SELECT court,name,week_cutoff FROM court");
    while ($row = mysql_fetch_array($sql)) {
      foreach($row AS $key => $val) {
        $$key = stripslashes($val);
      }

      $this->court[$i] = new Court($court,$name,$week_cutoff);
      $this->courtmap[$court] = $i++;
    }
  }

  function retrieveSlots() {
    $this->slot = array();
    for ($i=0; $i<count($this->court); $i++) {
      $this->slot[$i] = array();
    }
    $i=0;

    $ssql = "SELECT c.court, s.slot, s.start_time, s.duration, b.memberid ".
            "FROM court c, slot s ".
            "LEFT JOIN booking b ON s.slot = b.slot ".
            "AND s.court = b.court ".
            "AND b.book_date = '" . Util::displayToSqlDate($this->bookdate) . "'".
            "WHERE s.court = c.court ".
            "AND c.online <= '" . Util::displayToSqlDate($this->bookdate) . "'".
            "ORDER BY 1,2";

    $sql = mysql_query($ssql) or die (mysql_error());
    while ($row = mysql_fetch_array($sql)) {
      foreach($row AS $key => $val) {
        $$key = stripslashes($val);
      }

      $s = &$this->slot[$this->courtmap[$court]];
      $s[count($s)] = new BlockSlot($court, $memberid, $slot, $start_time, $duration);

      //echo $this->slot[$ci][$sc]->toFormString();
    }
  }

  /**
  * Return the number of Courts available for this date/time.
  *
  * @public
  * @returns int
  */
  function getCourtCount() {
    return count($this->court);
  }

  /**
  * Return the specified Court.
  *
  * @public
  * @returns Court
  */
  function getCourt($c) {
    return $this->court[$c];
  }

  /**
  * Return the number of BlockSlots available for this date/time.
  *
  * @public
  * @returns int
  */
  function getSlotCount($c) {
    return count($this->slot[$c]);
  }

  /**
  * Return the specified Block Slot.
  *
  * @public
  * @returns BlockSlot
  */
  function getSlot($c, $i) {
    return $this->slot[$c][$i];
  }
}
?>