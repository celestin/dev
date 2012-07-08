<?php
/* * * * * * * * * * * * * * * * * * * * * * * *
 * Talisman WMS Users
 * Copyright (c) 2012 Front Burner
 *
 * Action Utilities
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  27-Dec-2005  File created.
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