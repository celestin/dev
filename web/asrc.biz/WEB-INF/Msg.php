<?php
/* * * * * * * * * * * * * * * * * * * * * * * *
 * Msg Class
 * Copyright (c) 2004-2005 Southesk.com
 *
 * $Log: /web/asrc.biz/WEB-INF/Msg.php $
 * 
 * 1     23/05/05 21:45 Craig
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
    print "<p class=\"quest\">$quest?</p>";
  }

  /**
  * Return the specific statement in a formatted string.
  *
  * @public
  * @returns String
  */
  function statement($statement) {
    print "<p class=\"statement\">$statement</p>";
  }

  /**
  * Return the specific error message in a formatted string.
  *
  * @public
  * @returns String
  */
  function error($err) {
    print "<p class=\"err\">$err</p>";
  }
}
?>