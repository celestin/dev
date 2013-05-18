<?php
/* * * * * * * * * * * * * * * * * * * * * * * *
 * ASRC.biz (Aberdeen Squash Racquets Club)
 * Copyright (c) 2006-2007 Frontburner
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  05-Apr-2004  File created.
 * CAM  09-Aug-2007  10157 : Added myNextday to calculate the next MySQL weekday ordinal.
 * CAM  23-Oct-2007  10182 : Added textToSql and textBoxToHtml.
 * CAM  17-Feb-2013  11162 : Added visibility and static keywords for strict OO PHP.
 * * * * * * * * * * * * * * * * * * * * * * * */

class Util {

  /**
  * Return the String display date (21-Mar-2004) as MySQL date string (2004-03-21)
  *
  * @public
  * @return String
  */
  public static function displayToSqlDate($displayDate) {
    return date("Y-m-d", strtotime($displayDate));
  }

  /**
  * Return the String encoded for saving to SQL
  *
  * @public
  * @return String
  */
  public static function textToSql($text) {
    $ret = str_replace("'", "'", $text);
    $ret = str_replace("£", "&pound;", $ret);
    return $ret;
  }

  /**
  * Returns the text using HTML to correspond with the format of the text entered in a textbox.
  *
  * @public
  * @return String
  */
  public static function textBoxToHtml($text) {
    $rval = str_replace("\n", "<br>", $text);
    return $rval;
  }

  /**
  * Return a String time (16:30) as timestamp
  *
  * @public
  * @return Timestamp
  */
  public static function strToTimestamp($time) {
    return strtotime("1-Jan-2004 " . $time);
  }

  /**
  * Return the MySQL weekday for a given date.
  *
  * @public
  * @return int
  */
  public static function myWeekday($date) {
    $dow = (date("w", strtotime($date)) - 1);
    if ($dow == -1) $dow = 6;
    return $dow;
  }

  /**
  * Return the next MySQL weekday ordinal for a given ordinal.
  *
  * @public
  * @returns int
  */
  public static function myNextday($day) {
    $dow = $day+1;
    if ($dow > 6) $dow = 0;
    return $dow;
  }
}
?>