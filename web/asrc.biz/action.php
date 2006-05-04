<?
/* * * * * * * * * * * * * * * * * * * * * * * *
 * Booking Actions
 * Copyright (c) 2004-2005 Southesk.com
 *
 * Who  When         Why
 * CAM  23-Jun-2004  File created.
 * CAM  30-May-2004  4 : Added Paying of Fines.
 * * * * * * * * * * * * * * * * * * * * * * * */

$title = "Aberdeen Squash Racquets Club - Action";
include_once 'Main.php';
include 'tpl/top.php';

$action = NULL;        if (!empty($_GET['action'])) $action = $_GET['action'];
$book_date = NULL;     if (!empty($_GET['book_date'])) $book_date = $_GET['book_date'];
$court = NULL;         if (!empty($_GET['court'])) $court = $_GET['court'];
$slot = NULL;          if (!empty($_GET['slot'])) $slot = $_GET['slot'];
$proceed = NULL;       if (!empty($_GET['proceed'])) $proceed = $_GET['proceed'];
$memberid = NULL;      if (!empty($_GET['memberid'])) $memberid = $_GET['memberid'];

if ($action == "C" || $action == "X") {

  $ssql = "SELECT DATE_FORMAT(b.book_date,'%a') book_day,".
                 "DATE_FORMAT(b.book_date,'%d %b') book_date_disp,".
                 "DATE_FORMAT(b.book_date,'%Y-%m-%d') book_date,".
                 "s.duration,b.court,b.opponentid,".
                 "TIME_FORMAT(s.start_time,'%h:%i %p') start_time_fmt, ".
                 "b.memberid ".
          "FROM booking b, slot s ".
          "WHERE b.court = s.court ".
          "AND b.slot = s.slot ".
          "AND b.book_date='$book_date' ".
          "AND b.court='$court' ".
          "AND b.slot='$slot' ";

  $sql = mysql_query($ssql) or die (mysql_error());

  if ($row = mysql_fetch_array($sql)) {
    foreach($row AS $key => $val) {
      $$key = stripslashes($val);
    }

    if ($opponentid) {
      $tupOpponent = Person::getPerson($opponentid);
    } else {
      $tupOpponent = new Tuple("Guest", "Guest");
    }

    if (empty($proceed)) {
      Msg::question("Sure you wish to " . ActionUtil::getDesc($action) . " this game with " . $tupOpponent->toString());
      print "<center><a href=\"". ActionUtil::url($action, $book_date, $court, $slot, 1) . "\">Yes</a> | <a href=javascript:history.back()>No</a>";
    } else if ($action == 'X') {
      $ssql = "DELETE FROM booking ".
              "WHERE book_date='$book_date' ".
              "AND court='$court' ".
              "AND slot='$slot' ";
      $sql = mysql_query($ssql) or die (mysql_error());

      Msg::statement("Booking cancelled.");
    } else if ($action == 'C') {
      $ssql = "UPDATE booking ".
              "SET confirm_date = NOW(), confirm_user = '" . $member->getID() . "', status = 'C' ".
              "WHERE book_date='$book_date' ".
              "AND court='$court' ".
              "AND slot='$slot' ";
      $sql = mysql_query($ssql) or die (mysql_error());

      Msg::statement("Booking confirmed.");
    }

  }
} else if ($action == "P") {

  if ($memberid) {
    $member = Person::getPerson($memberid);
  }
  
  if (empty($proceed)) {
    Msg::question("Sure you wish to " . ActionUtil::getDesc($action) . " oustanding fines for " . $member->toString());
    print "<center><a href=\"". ActionUtil::urlPay($action, $memberid, 1) . "\">Yes</a> | <a href=javascript:history.back()>No</a>";
  } else {
    $ssql = "UPDATE booking ".
            "SET status='P' ".
            "WHERE memberid='$memberid' ".
            "AND status='X'";
    $sql = mysql_query($ssql) or die (mysql_error());

    Msg::statement("All Fines Paid.");
  }
}

include 'tpl/bot.php';
?>