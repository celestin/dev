<?php
/* * * * * * * * * * * * * * * * * * * * * * * *
 * Court Class
 * Copyright (c) 2004-2005 Southesk.com
 *
 * $Log: /web/asrc.biz/WEB-INF/Court.php $
 * 
 * 1     23/05/05 21:45 Craig
 *
 * Who  When         Why
 * CAM  20-Mar-2004  File created.
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

  function Court($id, $desc, $cutoff) {
    $this->id = $id;
    $this->desc = $desc;
    $this->cutoff = $cutoff;

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