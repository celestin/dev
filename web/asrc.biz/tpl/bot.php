<?php
/* * * * * * * * * * * * * * * * * * * * * * * *
 * ASRC.biz (Aberdeen Squash Racquets Club)
 * Copyright (c) 2006-2008 Frontburner
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  19-Mar-2004  File created.
 * CAM  29-May-2005  5 : Added Version.
 * CAM  30-May-2005  4 : Version 1.02.
 * CAM  02-Jun-2005  11 : Added King Street Cars.
 * CAM  10-Jun-2005  11 : Added Active Aircon.
 * CAM  19-Jan-2006  9 : Version 1.03 - Block Booking.
 * CAM  06-Feb-2006  10 : Version 1.04 - Created_by.
 * CAM  06-Feb-2006   8 : Version 1.05 - Guest User.
 * CAM  08-Feb-2007  10098 : Include the Valentines Image.
 * CAM  05-Mar-2007  10098 : Remove the Valentines Image.
 * CAM  25-Jun-2007  10128 : Version 1.07 - No Bookings if on Fine Board, and colour coding.
 * CAM  12-Aug-2007  10157 : Version 1.08 - Added Unconfirmed Bookings (if booked outwith Reception hours).
 * CAM  23-Oct-2007  10182 : Version 1.09 - Added Events.
 * CAM  26-Oct-2007  10195 : Version 1.10 - Added Events Emailing.
 * CAM  15-Nov-2007  10183 : Added Event Summary.  Version 1.11 - Events to footer/emails and User Privs.
 * CAM  12-Feb-2008  10230 : Added TWMA logo, shuffled others.
 * CAM  25-Nov-2008  10314 : New colours/layout in line with new asrc.co.uk.
 * * * * * * * * * * * * * * * * * * * * * * * */
?>
</td></tr>
</table></td>
<td valign=top>
<table id="Table_01" width="155" height="465" border="0" cellpadding="0" cellspacing="0">
  <tr>
    <td colspan="3"><img src="img/ad/Sponsors.gif" width="155" height="47" alt=""></td>
  </tr>
  <tr>
    <td rowspan="8"><img src="img/ad/Untitled-3_02.gif" width="38" height="418" alt=""></td>
    <td><img src="img/ad/twma.gif" width="112" height="67" alt=""></td>
    <td rowspan="8"><img src="img/ad/Untitled-3_04.gif" width="5" height="418" alt=""></td>
  </tr>
  <tr>
    <td><img src="img/ad/Untitled-3_05.gif" width="112" height="64" alt=""></td>
  </tr>
  <tr>
    <td><img src="img/ad/monitor.gif" width="112" height="24" alt=""></td>
  </tr>
  <tr>
    <td><img src="img/ad/Untitled-3_07.gif" width="112" height="60" alt=""></td>
  </tr>
  <tr>
    <td><img src="img/ad/MrChips.gif" width="112" height="77" alt=""></td>
  </tr>
  <tr>
    <td><img src="img/ad/Untitled-3_09.gif" width="112" height="31" alt=""></td>
  </tr>
  <tr>
    <td><img src="img/ad/solutions.gif" width="112" height="80" alt=""></td>
  </tr>
  <tr>
    <td><img src="img/ad/Untitled-3_11.gif" width="112" height="15" alt=""></td>
  </tr>
</table>
</td>
<tr>
  <td colspan=2><table width="100%" border=0 cellpadding=0 cellspacing=0>
    <tr>
      <td colspan=2 align=left valign=bottom><table border=0 cellpadding=4 cellspacing=0 width="100%" height="100%" class="outerBox">
        <tr>
          <td class="eventsummary">Upcoming Events</td>
<?
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
?>
          <td class="eventItem"><b><? echo $event_date_fmt; ?></b> <a href="events.php#event<? echo $event_id; ?>"><? echo $event_title; ?></a></td>
<?
    }
?>
        </tr>
      </table></td>
    </tr>
</table></td></tr>
</table></td></tr>
<tr><td colspan=3><table class="cpyrght" border=0 cellpadding=10 cellspacing=0 width="100%">
  <tr>
    <td width="25%" align="left"><img src="img/logo/asrc_small.gif"></td>
    <td class="cpyrght" width="50%"><b>V1.11</b> System designed and maintained by <a class="cpyrght" href="http://www.frontburner.co.uk/">frontburner.co.uk</a></td>
    <td class="cpyrght" width="25%"></td>
  </tr>
</table></td></tr>
</table></td></tr>
</table>
</body>
</html>
