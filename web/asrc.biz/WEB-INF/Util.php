<?php
/* * * * * * * * * * * * * * * * * * * * * * * *
 * General Utilities
 * Copyright (c) 2004-2005 Southesk.com
 *
 * $Log: /web/asrc.biz/WEB-INF/Util.php $
 * 
 * 1     23/05/05 21:45 Craig
 *
 * Who  When         Why
 * CAM  05-Apr-2004  File created.
 * * * * * * * * * * * * * * * * * * * * * * * */

class Util {

  /**
  * Return the String display date (21-Mar-2004) as MySQL date string (2004-03-21)
  *
  * @public
  * @returns String
  */
  function displayToSqlDate($displayDate) {
    return date("Y-m-d", strtotime($displayDate));
  }

  /**
  * Return a String time (16:30) as timestamp
  *
  * @public
  * @returns Timestamp
  */
  function strToTimestamp($time) {
    return strtotime("1-Jan-2004 " . $time);
  }

  /**
  * Return the MySQL weekday for a given date.
  *
  * @public
  * @returns int
  */
  function myWeekday($date) {
    $dow = (date("w", strtotime($date)) - 1);
    if ($dow == -1) $dow = 6;
    return $dow;
  }
}
?>