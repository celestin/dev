<?php
/* * * * * * * * * * * * * * * * * * * * * * * *
 * Maia Systems Website
 * Copyright (c) 2006 Maia Systems
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * Action Utilities
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  02-Feb-2006  File created.
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