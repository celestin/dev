<?
/* * * * * * * * * * * * * * * * * * * * * * * *
 * ASRC.biz (Aberdeen Squash Racquets Club)
 * Copyright (c) 2004-2007 Frontburner
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * New Booking Workflow
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  19-Mar-2004  File created.
 * CAM  01-Jun-2004  9 : Admin members see 15 days ahead.
 * CAM  19-Jan-2006  9 : Block booking.
 * CAM  06-Feb-2006  10: Added created_by.
 * CAM  25-Jun-2007  10128 : No more New Bookings if on "Fine Board".
 * CAM  23-Jul-2007  10152 : Ensure Block bookings appear correctly for Courts not yet online.
 * CAM  05-Oct-2007  10155 : Ensure next Wednesday's courts cannot be booked until after 1pm this Wednesday .
 * CAM  15-Oct-2007  10155 : Moved code from here into Calendar.php - it only applies to Courts 1 & 2.
 * CAM  26-Oct-2007  10195 : Use new ReminderEmail class.
 * CAM  15-Nov-2007  10156 : Check for Coach privs - extend bookable days.
 * CAM  25-Nov-2008  10314 : Ensure button displays in new colours/layout in line with new asrc.co.uk.
 * CAM  19-May-2012  11122 : Xodus Group Court naming.
 * CAM  17-Feb-2013  11162 : Ensure that Coaches can book 15 days ahead. 
 * * * * * * * * * * * * * * * * * * * * * * * */

//SELECT concat(book_date, ' ', start_time) start_time,
//date_add(concat(book_date, ' ', start_time),interval (duration-1) minute) end_time
//FROM booking b, slot s
//WHERE b.court = s.court
//AND b.slot = s.slot

$title = "New Booking";
include_once 'Main.php';
include 'tpl/top.php';

$book_date = NULL;        if (!empty($_GET['book_date'])) $book_date = $_GET['book_date'];
$book_time = NULL;        if (!empty($_GET['book_time'])) $book_time = $_GET['book_time'];
$duration = NULL;         if (!empty($_GET['duration'])) $duration = $_GET['duration'];
$court = NULL;            if (!empty($_GET['court'])) $court = $_GET['court'];
$slot = NULL;             if (!empty($_GET['slot'])) $slot = $_GET['slot'];
$confirm = NULL;          if (!empty($_GET['confirm'])) $confirm = $_GET['confirm'];
$member_orig = NULL;      if (!empty($_GET['member_orig'])) $member_orig = $_GET['member_orig'];

$colspp = 5;

$memberOrig = $_SESSION['member_person'];
if ($member->isAdmin()) {
  if (isset($member_orig)) {
    $memberOrig = Person::getPerson($member_orig);
  } else {
    $memberOrig = null;
  }
} else {
  $member_orig = "";
}

if (empty($memberOrig)) {
  Msg::question("Who is the booking for, " . $member->getFirstname());
  include 'frm/orig_form.php';

} else if (!$book_date) {
  // Check if Member is on "Fine Board"
  $fines = false;

  $ssql = "SELECT DATE_FORMAT(b.book_date,'%a') book_day,".
                 "DATE_FORMAT(b.book_date,'%d %b %Y') book_date_disp,".
                 "s.duration,b.court,b.opponentid,".
                 "TIME_FORMAT(s.start_time,'%H:%i') start_time_fmt, ".
                 "b.memberid, b.court, b.slot ".
          "FROM booking b, slot s ".
          "WHERE b.court = s.court ".
          "AND b.slot = s.slot ".
          "AND b.status = 'X' ".
          "AND b.memberid='" . $memberOrig->getID() . "' ".
          "ORDER BY b.book_date, s.start_time";

  $sql = mysql_query($ssql) or die (mysql_error());

  while ($row = mysql_fetch_array($sql)) {
    foreach($row AS $key => $val) {
      $$key = stripslashes($val);
    }

    if (!$fines) {
      if ($member->isAdmin()) {
        Msg::error($memberOrig->getFirstname() . " has the following outstanding fines, and cannot book any more courts until they are paid:");
      } else {
        Msg::error("You have the following outstanding fines, and you cannot book any more courts until they are paid:");
      }
?>
      <table border=1 cellspacing=0 cellpadding=2>
      <tr>
        <th width="35">day</th>
        <th width="70">date</th>
        <th width="35">start</th>
        <th width="55">duration</th>
        <th width="35">court</th>
        <th width="140">opponent</th>
      </tr>
<?
    }
    $fines = true;

    if ($opponentid) {
      $tupOpponent = Person::getPerson($opponentid);
    } else {
      $tupOpponent = new Person("?", "Unspecified", "", "", "", 0, "Y", 0);
    }

    echo "<tr>".
           "<td class=bc>$book_day</td>".
           "<td class=bc>$book_date_disp</td>".
           "<td class=bc>$start_time_fmt</td>".
           "<td class=bc>$duration</td>".
           "<td class=bc>$court</td>".
           "<td class=" . $tupOpponent->getClass() . " title=\"" . $tupOpponent->toString(true) . "\">" . $tupOpponent->getDesc() . "</td>".
         "</tr>";
  }

  if ($fines) {
    echo "</table>";

  } else {

    if ($member->isAdmin()) {
      Msg::question("What day would " . $memberOrig->getFirstname() . " like to play");
    } else {
      Msg::question("What day would you like to play, " . $memberOrig->getFirstname());
    }

    $cal = new Calendar($member, $memberOrig->getID());
    print "<table border=0 cellspacing=10 cellpadding=0>";

    $daysAhead = 8;
    if ($member->isAdmin()) {
      $daysAhead = 15;
    } else if ($member->isCoach()) {
      $daysAhead = 15;
    }

    for ($i=0; $i<$daysAhead; $i++) {
      print "<tr><td>" . $cal->dateLink($i) . "</td></tr>";
    }
    print "</table>";
  }

} else if ($book_date && !$book_time && $memberOrig->isBlockBooker()) {
?>
  <form action="blockbooking.php" method=POST><table border=1><tr>
<?
  $block = new Block($book_date);
  $cc = $block->getCourtCount();

  for ($i=0; $i<$cc; $i++) {
    $bbc = $block->getCourt($i);
    echo "<td align=center>" . $bbc->getDesc() . "</td>";

  }
  echo "</tr><tr>\n";

  for ($i=0; $i<$cc; $i++) {
    echo "<td valign=top><table border=0>";
    for ($j=0; $j<$block->getSlotCount($i); $j++) {
      $bbs = $block->getSlot($i, $j);
      echo $bbs->toFormString();
    }
    if ($j==0) {
      echo "<tr><td>&nbsp;</td></tr>\n";
    }
    echo "</table></td>\n";
  }
?>
  </tr><tr>
    <td colspan="<? echo $cc; ?>" align=center>
      <input class="button" type="submit" value="Book">
      <input type="hidden" id="book_date" name="book_date" value="<? echo $book_date; ?>">
      <input type="hidden" id="member_orig" name="member_orig" value="<? echo $memberOrig->getID(); ?>">
    </td>
  </tr>
  </table></form>
<?
} else if ($book_date && !$book_time) {
  if ($member->isAdmin()) {
    Msg::question("What time would " . $memberOrig->getFirstname() . " like to play");
  } else {
    Msg::question("What time would you like to play, " . $memberOrig->getFirstname());
  }

  $cal = new Calendar($member, $memberOrig->getID(), $book_date);
  print "<table border=0 cellspacing=10 cellpadding=0 width=\"100%\">";

  for ($i=0; $i<$cal->getSlotCount(); $i++) {
    $slot = $cal->getSlot($i);

    if ($slot->isAfter($book_date)) {
      if (fmod($i,$colspp) == 0) {
        if ($i > 0) print "</tr>";
        print "<tr>";
      }
      print "<td>" . $slot->dateLink($book_date) . "</td>";
    }
  }
  if (fmod($i,$colspp) > 0) {
    print "<td colspan=" . ($colspp - fmod($i,$colspp)) . ">&nbsp;</td>";
  }
  print "</tr>";

  print "</table>";
} else if (!$court) {
  if ($member->isAdmin()) {
    Msg::question("Which Court would " . $memberOrig->getFirstname() . " like to play on");
  } else {
    Msg::question("Which Court would you like to play on, " . $memberOrig->getFirstname());
  }

  $cal = new Calendar($member, $memberOrig->getID(), $book_date, $book_time, $duration);
  print "<table border=0 cellspacing=10 cellpadding=0 width=\"100%\">";

  for ($i=0; $i<$cal->getSlotCount(); $i++) {
    $slot = $cal->getSlot($i);

    if ($slot->isAfter($book_date)) {
      print "<tr><td>" . $slot->dateLink($book_date) . "</td></tr>";
    }
  }
  print "</table>";
} else if (empty($confirm)) {
  $crt = new Court($court);

  $phrase = ", you want";
  if ($member->isAdmin()) {
    $phrase = " wants";
  }
  Msg::question("So, " . $memberOrig->getFirstname() . "$phrase to book " . $crt->desc . " for $book_time on $book_date");

  $s = "<a href=\"newbooking.php?book_date=$book_date" .
       "&book_time=" . urlencode($book_time) .
       "&court=" . $court .
       "&duration=" . $duration .
       "&slot=" . $slot;
  if (!empty($member_orig)) {
    $s .= "&member_orig=$member_orig";
  }

  echo $s . "&confirm=Y\">I confirm</a>";

} else {
  $cal = new Calendar($member, $memberOrig->getID(), $book_date, $book_time, $duration, $court, $slot);
  $success = false;
  //print "<table border=0 cellspacing=10 cellpadding=0 width=\"100%\"><tr><td>";
  $memid = $member->getID();
  if (!empty($member_orig)) {
    $memid = $member_orig;
  }

  for ($i=0; $i<$cal->getSlotCount(); $i++) {
    $slotTup = $cal->getSlot($i);

    if ($slotTup->isAfter($book_date)) {
      $sql = "INSERT INTO booking (book_date, court, slot, memberid, opponentid, created_by) " .
             "VALUES ('" . Util::displayToSqlDate($book_date) .
             "', '$court', '$slot', '$memid', NULL, '".$member->getID()."') ";
      $success = mysql_query($sql);
      $success = (mysql_affected_rows() < 1);

      $msg = new ReminderEmail("N", $book_date, $slotTup->getStartTime(), $court, $memid);
      $msg->send();
    }
  }

  if($success){
    Msg::error("Another user has just booked this court at this time - please try again.");
  } else {
    Msg::question("Your booking is confirmed.  Would you like to specify your opponent");
    include 'frm/opponent_form.php';
  }
}

include 'tpl/bot.php';
?>

