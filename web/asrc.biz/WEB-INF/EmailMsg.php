<?php
/* * * * * * * * * * * * * * * * * * * * * * * *
 * ASRC.biz (Aberdeen Squash Racquets Club)
 * Copyright (c) 2006,2008 Frontburner
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
 * CAM  04-Dec-2008  10318 : Added Reply-To to getHeaders.
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

    $headers = "From: <" . $cfg['Site']['Email'] . ">$cr";
    $headers = "Reply-To: <" . $cfg['Site']['Email'] . ">$cr";
    if (!empty($cc)) $headers .= "Cc: $cc$cr";
    $headers .= "MIME-Version: 1.0$cr";
    $headers .= "X-Priority: 1$cr";
    $headers .= "X-Mailer: ASRC.biz";
    $headers .= "Content-Type: text/html; charset=ISO-8859-1$cr";

    return $headers;
  }

  function getTop($title) {
    global $cfg;
    $cr = "\r\n";

    return "<html><head>$cr".
    "<link href=" . $cfg['Site']['URL'] . "/asrc2.css rel=stylesheet type=text/css>".
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

    $bottom = "</table></td>".
          "</tr></table>".
        "</td></tr>$cr$cr";

    $bottom .= "<tr><td style=\"padding-top:10px;padding-bottom:10px;\"><table border=0 cellpadding=4 cellspacing=0 width=\"100%\" height=\"100%\" class=\"outerBox\">".
      "<tr><td class=\"eventsummary\">Upcoming Events</td>$cr";

    $ssql = "SELECT id event_id, event_title, ".
            "DATE_FORMAT(event_date,'%d %b %Y') event_date_fmt ".
            "FROM event ".
            "ORDER BY event_date ASC ".
            "LIMIT 0,3 ";
    //echo "<pre>$ssql</pre>\n";

    $sql = mysql_query($ssql) or die (mysql_error());
    while ($row = mysql_fetch_array($sql)) {
      foreach($row AS $key => $val) {
        $$key = stripslashes($val);
      }
       $bottom .= "<td><b>$event_date_fmt</b> <a href=\"" . $cfg['Site']['URL'] . "/events.php#event$event_id\">$event_title</a></td>$cr";
    }

    $bottom .= "</tr></table></td></tr>$cr";

    $bottom .= "<tr><td align=center>" . $cfg['Site']['Name'] . " - <a href=\"" . $cfg['Site']['URL'] . "\">" . $cfg['Site']['URL'] . "</a></td></tr>".
      "</table>".
    "</body></html>";

    return $bottom;
  }
}
?>