<?
/* * * * * * * * * * * * * * * * * * * * * * * *
 * ASRC.biz (Aberdeen Squash Racquets Club)
 * Copyright (c) 2006-2007 Frontburner
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  26-Oct-2007  10195 : File separated from single file.
 * * * * * * * * * * * * * * * * * * * * * * * */

// Send reminder emails for forthcoming bookings
$ssql = "SELECT DATE_FORMAT(b.book_date,'%d-%b-%Y') book_date_disp,".
               "DATE_FORMAT(b.book_date,'%Y-%m-%d') book_date,".
               "s.duration,b.court,b.slot,b.opponentid,".
               "TIME_FORMAT(s.start_time,'%H:%i') start_time_fmt, ".
               "b.memberid ".
        "FROM booking b, slot s ".
        "WHERE b.court = s.court ".
        "AND b.slot = s.slot ".
        "AND b.status = 'O' ".
        "AND b.reminder_sent = 0 ".
        "AND CONCAT(b.book_date,  ' ', s.start_time) < DATE_ADD(NOW(), INTERVAL 60 MINUTE) ";

$sql = mysql_query($ssql);

while ($row = mysql_fetch_array($sql)) {
  foreach($row AS $key => $val) {
    $$key = stripslashes($val);
  }

  // Reminder sent
  $ssql1 = "UPDATE booking ".
           "SET reminder_sent = 1 ".
           "WHERE book_date = '$book_date' ".
           "AND court = $court ".
           "AND slot = $slot ";

  $sql1 = mysql_query($ssql1);

  $msg = new ReminderEmail("R", $book_date_disp, $start_time_fmt, $court, $memberid, $opponentid);
  $msg->send();
}

?>