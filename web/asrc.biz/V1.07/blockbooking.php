<?
/* * * * * * * * * * * * * * * * * * * * * * * *
 * ASRC.biz (Aberdeen Squash Racquets Club)
 *
 * Copyright (c) 2006 Frontburner
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * Block Booking Save
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  19-Jan-2006  9 : Block booking.
 * CAM  06-Feb-2006  10: Added created_by.
 * * * * * * * * * * * * * * * * * * * * * * * */

$title = "Aberdeen Squash Racquets Club - Block Booking";
include_once 'Main.php';
include 'tpl/top.php';

$book_date = NULL;        if (!empty($_POST['book_date'])) $book_date = $_POST['book_date'];
$blockslot = NULL;        if (!empty($_POST['blockslot'])) $blockslot = $_POST['blockslot'];
$member_orig = NULL;      if (!empty($_POST['member_orig'])) $member_orig = $_POST['member_orig'];

$colspp = 5;

$memberOrig = $_SESSION['member_person'];
if ($member->isAdmin()) {
  $successrows = $totalrows = 0;

  foreach ($blockslot as $slot) {
    $s = explode("|", $slot);
    //echo "$book_date  $member_orig Court $s[0] Slot $s[1] </br>";

    $sql = "INSERT INTO booking (book_date, court, slot, memberid, opponentid, created_by) " .
           "VALUES ('" . Util::displayToSqlDate($book_date) .
           "', '$s[0]', '$s[1]', '$member_orig', NULL, '".$member->getID()."') ";
    mysql_query($sql);
    if (mysql_affected_rows()==1) $successrows++;
    $totalrows++;
  }


  if ($totalrows == 0) {
    Msg::statement("No Court Slots were selected - nothing booked.");
  } else if ($successrows == 0) {
    Msg::error ("No bookings were successfully created.");
  } else if ($successrows < $totalrows) {
    Msg::error("$successrows out of $totalrows bookings were successfully created.");
  } else {
    Msg::statement("All your bookings were successfully created.");
  }
}


include 'tpl/bot.php';
?>

