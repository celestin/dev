<?php
/* * * * * * * * * * * * * * * * * * * * * * * *
 * First Summerhouses
 * Copyright (c) 2006 Frontburner
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * General Utilities
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  10-Feb-2006  File created.
 * CAM  06-Oct-2006  10040 : Added textToSql, getHtmlPrice.
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
    return str_replace("'", "'", $text);
  }

  /**
  * Return the number formatted as an HTML Price
  *
  * @public
  * @returns String
  */
  function getHtmlPrice($price) {
    if ($price == '-1') {
      return "Free";
    } else if ($price == '-2') {
      return "Included";
    }

    return "&pound;" . number_format($price, 0, '.', ',');
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