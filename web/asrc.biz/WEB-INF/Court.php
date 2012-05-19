<?php
/* * * * * * * * * * * * * * * * * * * * * * * *
 * ASRC.biz (Aberdeen Squash Racquets Club)
 *
 * Copyright (c) 2006 Frontburner
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * Court Class
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  20-Mar-2004  File created.
 * CAM  19-May-2012  11122 : Xodus Group Court naming.
 * * * * * * * * * * * * * * * * * * * * * * * */

include_once 'Main.php';

/**
* Court information.  Mirrors the 'court' database table.
*
* @author Craig McKay
* @version 2004
* @public
*/
class Court extends Tuple {

  /**
  * Short name.
  * @private
  * @type string
  */
  var $shortname;

  /**
  * Cutoff Hour.
  * @private
  * @type int
  */
  var $cutoff;

  /**
  * Array of Slots.
  * @private
  * @type Array of Slots
  */
  var $slot;

  /**
  * The earliest time for each court for which a seventh-day booking can be made.
  * E.g., Court 1 = 13.  On a Monday, a booking cannot be made for the following Monday until
  * after 13:00.
  * @private
  * @type int
  */
  var $courtCutoff = NULL;

  function Court($id, $desc='', $cutoff='') {
    $this->id = $id;

    if ($desc=='') {
      $sql = mysql_query("SELECT name,shortname,week_cutoff FROM court WHERE court=$id");
      if ($row = mysql_fetch_array($sql)) {
        $this->desc = $row[0];
        $this->shortname = $row[1];
        $this->cutoff = $row[2];
      }
    } else {
      $this->desc = $desc;
      $this->cutoff = $cutoff;
    }

    //$this->getSlots();
  }


  function getSlots() {
    $this->slot = array();
    $i=0;

    $sql = mysql_query("SELECT slot,TIME_FORMAT(start_time,'%h:%i %p') start_time_fmt,duration FROM slot WHERE court=$this->id");
    while ($row = mysql_fetch_array($sql)) {
      foreach($row AS $key => $val) {
        $$key = stripslashes($val);
      }
//print "<pre><b>slot</b> $slot,$start_time_fmt,$duration</pre>";
      $this->slot[$i++] = new Slot($slot,$start_time_fmt,$duration);
    }
  }
}
?>