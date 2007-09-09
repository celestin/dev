<?php
/* * * * * * * * * * * * * * * * * * * * * * * *
 * Msg Class
 * Copyright (c) 2004-2005 Southesk.com
 *
 * $Log: /web/cc/WEB-INF/Msg.php $
 * 
 * 1     28/12/05 15:49 Craig
 *
 * Who  When         Why
 * CAM  20-Mar-2004  File created.
 * * * * * * * * * * * * * * * * * * * * * * * */

/**
* Error handling.
*
* @author Craig McKay
* @version 2004
* @public
*/
class Msg {

  /**
  * Return the specific question in a formatted string.
  *
  * @public
  * @returns String
  */
  function question($quest) {
    echo "<p class=\"quest\">$quest?</p>";
  }

  /**
  * Return the specific statement in a formatted string.
  *
  * @public
  * @returns String
  */
  function statement($statement) {
    echo "<p class=\"statement\">$statement</p>";
  }

  /**
  * Return the specific error message in a formatted string.
  *
  * @public
  * @returns String
  */
  function error($err) {
    echo "<p class=\"err\">$err</p>";
  }
}
?>