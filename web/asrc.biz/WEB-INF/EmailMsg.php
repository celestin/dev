<?php
/* * * * * * * * * * * * * * * * * * * * * * * *
 * ASRC.biz (Aberdeen Squash Racquets Club)
 * Copyright (c) 2006-2007 Frontburner
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * Sends Emails for the system
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  4-May-2005   File created.
 * CAM  08-Feb-2007  10098 : Added Valentines Dance.
 * CAM  05-Mar-2007  10098 : Removed Valentines Dance.
 * CAM  05-Mar-2007  10098 : Corrected CSS.
 * CAM  25-Jun-2007  10133 : Ensure Test emails are sent to the Development email.
 * CAM  12-Aug-2007  10157 : Improve HTML emails.
 * CAM  26-Oct-2007  10195 : Functionality split into subclasses.
 * * * * * * * * * * * * * * * * * * * * * * * */

include_once 'Main.php';

/**
* EmailMsg information.
*
* @author Craig McKay
* @version 2005
* @public
*/
class EmailMsg {

  /**
  * Originator Member
  * @private
  * @type String
  */
  var $memberId;

  function EmailMsg($memberId) {
    $this->memberId = $memberId;
  }

  function getHeaders($cc='') {
    global $cfg;
    $cr = "\r\n";

    $headers = "From: " . $cfg['Site']['Email'] . "$cr";
    if (!empty($cc)) $headers .= "Cc: $cc$cr";
    $headers .= "MIME-Version: 1.0$cr";
    $headers .= "X-Priority: 1$cr";
    $headers .= "Content-Type: text/html; charset=ISO-8859-1$cr";

    return $headers;
  }

  function getTop($title) {
    global $cfg;
    $cr = "\r\n";

    return "<html><head>$cr".
    "<link href=" . $cfg['Site']['URL'] . "/asrc.css rel=stylesheet type=text/css>".
    "</head><body>$cr".
    "<table cellspacing=0 cellpadding=0 border=0 width=\"100%\">".
      "<tr><td valign=center align=center><table cellspacing=5 cellpadding=0 border=0>".
        "<tr>".
          "<td colspan=2 align=center><b>$title</b></td>$cr".
        "</tr><tr>".
          "<td class=topnav><table width=\"100%\" border=0 cellpadding=2 class=thinBox>$cr";
  }

  function getBottom() {
    global $cfg;
    $cr = "\r\n";

    return "</table></td>".
          "</tr></table>".
        "</td></tr>$cr".
        "<tr><td align=center>" . $cfg['Site']['Name'] . " - <a href=\"" . $cfg['Site']['URL'] . "\">" . $cfg['Site']['URL'] . "</a></td></tr>".
      "</table>".
    "</body></html>";
  }
}
?>