<?php
/* * * * * * * * * * * * * * * * * * * * * * * *
 * ASRC.biz (Aberdeen Squash Racquets Club)
 *
 * Copyright (c) 2006 Frontburner
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * Action Utilities
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  23-Jun-2004  File created.
 * CAM  30-May-2004  4 : Added Paying of Fines.
 * CAM  17-Feb-2013  11162 : Added visibility and static keywords for strict OO PHP.
 * * * * * * * * * * * * * * * * * * * * * * * */

/**
* A utility class for Actions
*
* @author Craig McKay
* @version 2004
* @public
*/
class ActionUtil {

  /**
  * Return the Action name for a code.
  *
  * @public
  * @returns String
  */
  public static function getDesc($action) {
    if ($action == 'C') return "Confirm";
    if ($action == 'X') return "Cancel";
    if ($action == 'P') return "Pay All";
  }

  /**
  * Return the URL for an Action
  *
  * @public
  * @returns String
  */
  public static function url($action, $book_date, $court, $slot, $proceed='') {
    $rval = "action.php?action=$action&book_date=$book_date&court=$court&slot=$slot";

    if (!empty($proceed)) {
      $rval .= "&proceed=1";
    }

    return $rval;
  }

  /**
  * Return the URL for an Action
  *
  * @public
  * @returns String
  */
  public static function urlPay($action, $memberid, $proceed='') {
    $rval = "action.php?action=$action&memberid=$memberid";

    if (!empty($proceed)) {
      $rval .= "&proceed=1";
    }

    return $rval;
  }
}
?>