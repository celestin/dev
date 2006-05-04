<?
/* * * * * * * * * * * * * * * * * * * * * * * *
 * ASRC.biz (Aberdeen Squash Racquets Club)
 *
 * Copyright (c) 2006 Frontburner
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * Standard Database Tasks
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  19-Aug-2004  File created.
 * CAM  06-Feb-2006  10: Added created_by.
 * * * * * * * * * * * * * * * * * * * * * * * */

  // Fine missed bookings
  $ssql = "UPDATE booking b, slot s ".
          "SET b.status = 'X', b.charge = 5 ".
          "WHERE b.court = s.court ".
          "AND b.slot = s.slot ".
          "AND CONCAT(b.book_date,  ' ', s.start_time) < DATE_SUB(NOW(), INTERVAL 30 MINUTE) ".
          "AND confirm_date IS NULL ".
          "AND b.status = 'O'";
  $sql = mysql_query($ssql);

  // Archive completed and paid bookings
  $ssql = "INSERT INTO booking_arc (book_date,court,slot,memberid,opponentid,created_by,confirm_date,confirm_user,status,reminder_sent,charge) ".
          "SELECT book_date,court,slot,memberid,opponentid,created_by,confirm_date,confirm_user,status,reminder_sent,charge ".
          "FROM booking ".
          "WHERE status in ('C','P')";
  $sql = mysql_query($ssql);

  $ssql = "DELETE FROM booking ".
          "WHERE status in ('C','P')";
  $sql = mysql_query($ssql);

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

    $msg = new EmailMsg("R", $book_date_disp, $start_time_fmt, $court, $memberid, $opponentid);
    $msg->send();
  }

?>

