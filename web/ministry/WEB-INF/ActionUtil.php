<?php
/* * * * * * * * * * * * * * * * * * * * * * * *
 * Ministry Search Engine
 * Copyright (c) 2007 frontburner.co.uk
 *
 * Action Utilities
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  29-Jul-2007  File created.
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

  /**
  * Return the HTML for an Action Button
  *
  * @public
  * @returns String
  */
  function linkButton($action, $buttonText) {
    $rval = "<input class=\"button\" type=\"submit\" onclick=\"top.location.href='$action';\" value=\"". $buttonText . "\">";

    return $rval;
  }

  /**
  * Return the HTML for a Submit Button
  *
  * @public
  * @returns String
  */
  function submitButton($buttonText) {
    return "<input class=\"button\" type=\"submit\" value=\"". $buttonText . "\">";
  }
}
?>