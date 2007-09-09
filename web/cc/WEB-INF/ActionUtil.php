<?php
/* * * * * * * * * * * * * * * * * * * * * * * *
 * Action Utilities
 * Copyright (c) 2004-2005 Southesk.com
 *
 * $Log: /web/cc/WEB-INF/ActionUtil.php $
 * 
 * 1     28/12/05 15:49 Craig
 *
 * Who  When         Why
 * CAM  23-Jun-2004  File created.
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