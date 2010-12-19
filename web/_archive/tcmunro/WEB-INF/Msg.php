<?php
/* * * * * * * * * * * * * * * * * * * * * * * *
 * TC Munro
 * Copyright (c) 2007 Frontburner
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * Msg Class
 *
 * $Id: Msg.php 76 2006-05-10 22:47:06Z craig $
 *
 * Who  When         Why
 * CAM  13-Apr-2006  File created.
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