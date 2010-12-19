<?php
/* * * * * * * * * * * * * * * * * * * * * * * *
 * TC Munro
 * Copyright (c) 2007 Frontburner
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * Action Utilities
 *
 * $Id: ActionUtil.php 76 2006-05-10 22:47:06Z craig $
 *
 * Who  When         Why
 * CAM  13-Apr-2006  File created.
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
  }

  /**
  * Return the URL for an Action
  *
  * @public
  * @returns String
  */
  function url($action, $proceed='') {
    $rval = "action.php?action=$action";

    if (!empty($proceed)) {
      $rval .= "&proceed=1";
    }

    return $rval;
  }
}
?>