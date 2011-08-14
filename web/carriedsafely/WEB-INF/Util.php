<?php
/* * * * * * * * * * * * * * * * * * * * * * * *
 * West Coast Express Website
 * Copyright (c) 2006-2007 Frontburner
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * General Utilities
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  13-Apr-2006  File created.
 * CAM  11-Aug-2007  10154 : Added textToSql.
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
  * Return the String encoded for saving to SQL
  *
  * @public
  * @returns String
  */
  function textToSql($text) {
    $ret = str_replace("'", "'", $text);
    $ret = str_replace("£", "&pound;", $ret);
    return $ret;
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