<?php
/* * * * * * * * * * * * * * * * * * * * * * * *
 * Action Utilities
 * Copyright (c) 2004-2005 Southesk.com
 *
 * $Log: /web/asrc.biz/WEB-INF/ActionUtil.php $
 * 
 * 2     30/05/05 21:50 Craig
 * 4
 * 
 * 1     23/05/05 21:45 Craig
 *
 * Who  When         Why
 * CAM  23-Jun-2004  File created.
 * CAM  30-May-2004  4 : Added Paying of Fines.
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
  function getDesc($action) {
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
  function url($action, $book_date, $court, $slot, $proceed='') {
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
  function urlPay($action, $memberid, $proceed='') {
    $rval = "action.php?action=$action&memberid=$memberid";

    if (!empty($proceed)) {
      $rval .= "&proceed=1";
    }

    return $rval;
  }

}
?>