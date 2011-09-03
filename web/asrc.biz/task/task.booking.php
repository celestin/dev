<?
/* * * * * * * * * * * * * * * * * * * * * * * *
 * ASRC.biz (Aberdeen Squash Racquets Club)
 * Copyright (c) 2006-2007 Frontburner
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  09-Aug-2007  10157 : Added checks for Unconfirmed bookings.
 * CAM  26-Oct-2007  10195 : File separated from single file.
 * * * * * * * * * * * * * * * * * * * * * * * */

// Bookings Tasks

$shifts = array();    // Array by day, containing true if a working day
$charge = 5;          // Fine (in GBP)

// Mark missed bookings as Fines or Unconfirmed (if outwith normal hours)
$ssql = "SELECT b.book_date, b.court, s.slot, s.start_time, WEEKDAY(b.book_date) book_day, ".
               "f.day shift_day, f.start_time shift_start, f.end_time shift_end ".
        "FROM booking b LEFT OUTER JOIN shift f ".
        "ON f.day = weekday(b.book_date) ".
        "AND f.member_type = 'A', slot s  ".
        "WHERE b.court = s.court  ".
        "AND b.slot = s.slot  ".
        "AND CONCAT(b.book_date,  ' ', s.start_time) < DATE_SUB(NOW(), INTERVAL 30 MINUTE)  ".
        "AND b.confirm_date IS NULL  ".
        "AND b.status = 'O' ".
        "order by b.book_date, b.court, b.slot ";

$sql = mysql_query($ssql);

while ($row = mysql_fetch_array($sql)) {
  foreach($row AS $key => $val) {
    $$key = stripslashes($val);
  }

  // Default action is to Fine
  $upd_status = "X";
  $upd_extra = ",charge=$charge";

  if (($start_time >= $shift_start) &&
      ($start_time <= $shift_end)) {

    // Within Reception hours - Fine

  } else {

    // Outwith Reception hours - Mark as Unconfirmed with an Expiry Date of next working day

    if (count($shifts)==0) {
      // Need to cache the shift days
      $fsql = "SELECT DISTINCT day FROM shift";
      $fres = mysql_query($fsql);

      while ($frow = mysql_fetch_array($fres)) {
        $shifts[$frow[0]] = true;
      }
    }

    // Work out the expiry date - what is the next working day after today?
    $foundday = false;
    $nextday = Util::myNextday($book_day);
    $adddays = 1;

    while (!$foundday) {
      if (!empty($shifts[$nextday]) && $shifts[$nextday]) {
        // Tomorrow is a working day
        $foundday = true;
      } else {
        // Tomorrow is not a working day, keep looking
        $nextday = Util::myNextday($nextday);
        $adddays++;
      }
    }

    $upd_status = "U";
    $upd_extra = ", expiry_date=DATE_ADD('$book_date 12:00:00', INTERVAL $adddays DAY)";
  }

  $usql = "UPDATE booking SET status='$upd_status'$upd_extra ".
          "WHERE book_date='$book_date' ".
          "AND court='$court' ".
          "AND slot='$slot' ";

  mysql_query($usql);
}

// Look at Unconfirmed Bookings for previously-assigned Expiry Date: if it has passed - Fine
$ssql = "UPDATE booking ".
        "SET status = 'X', charge=$charge ".
        "WHERE expiry_date < NOW() ".
        "AND confirm_date IS NULL ".
        "AND status = 'U'";
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

?>