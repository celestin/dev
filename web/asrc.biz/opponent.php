<?
/* * * * * * * * * * * * * * * * * * * * * * * *
 * Opponent Search Logic
 * Copyright (c) 2004-2005 Southesk.com
 *
 * Who  When         Why
 * CAM  08-Jun-2004  File created.
 * * * * * * * * * * * * * * * * * * * * * * * */

$title = "Aberdeen Squash Racquets Club - Opponent Search";
include_once 'Main.php';
$member = $_SESSION['member_person'];
include 'tpl/top.php';

if (!empty($_POST['opponent_id']))  $opponent_id = $_POST['opponent_id'];
if (!empty($_GET['opponent_id']))   $opponent_id = $_GET['opponent_id'];

if (!empty($_POST['member_id']))    $member_id = $_POST['member_id'];
if (!empty($_GET['member_id']))     $member_id = $_GET['member_id'];

if (!empty($_POST['member_name']))  $member_name = $_POST['member_name'];
if (!empty($_GET['member_name']))   $member_name = $_GET['member_name'];

if (!empty($_POST['retry']))        $retry = $_POST['retry'];
if (!empty($_GET['retry']))         $retry = $_GET['retry'];

if (!empty($_POST['book_date']))    $book_date = $_POST['book_date'];
if (!empty($_GET['book_date']))     $book_date = $_GET['book_date'];

if (!empty($_POST['court']))        $court = $_POST['court'];
if (!empty($_GET['court']))         $court = $_GET['court'];

if (!empty($_POST['slot']))         $slot = $_POST['slot'];
if (!empty($_GET['slot']))          $slot = $_GET['slot'];

if (!empty($opponent_id)) {

  $ssql = "UPDATE booking " .
          "SET opponentid='$opponent_id' " .
          "WHERE book_date='" . Util::displayToSqlDate($book_date) . "' " .
          "AND court = '$court' " .
          "AND slot = '$slot'";
  $success = mysql_query($ssql) or die (mysql_error());

  // Send email to Opponent
  $ssql = "SELECT b.opponentid email_opp,b.memberid email_mem,".
                 "TIME_FORMAT(s.start_time,'%H:%i') start_time_fmt ".
          "FROM booking b, slot s ".
          "WHERE b.court = s.court ".
          "AND b.slot = s.slot ".
          "AND b.book_date='" . Util::displayToSqlDate($book_date) . "' " .
          "AND b.court = '$court' " .
          "AND b.slot = '$slot'";
  $sql = mysql_query($ssql) or die (mysql_error());

  if ($row = mysql_fetch_array($sql)) {
    foreach($row AS $key => $val) {
      $$key = stripslashes($val);
    }
    $msg = new EmailMsg("N", $book_date, $start_time_fmt, $court, $email_mem, $email_opp, true);
    $msg->send();
  }

  Msg::statement('Booking opponent updated.');

} else if (empty($member_id) && empty($member_name)) {
  if (!empty($retry)) Msg::error("Enter either your opponent's Member No. or Name!");

  include 'frm/opponent_form.php';
} else {
  $ssql = "SELECT memberid opponent_id,last_name,first_name,active " .
          "FROM member " .
          "WHERE ";

  if (!empty($member_name)) {
    $ssql .= "(CONCAT(first_name, ' ', last_name) LIKE '%$member_name%')";
  } else {
    $ssql .= "memberid LIKE '%$member_id%' ";
  }

  $ssql .= "ORDER BY 2,3";

  $sql = mysql_query($ssql) or die (mysql_error());

  print "<table border=0 cellspacing=10 cellpadding=0>";
  $params = "book_date=$book_date&court=$court&slot=$slot";

  while ($row = mysql_fetch_array($sql)) {
    foreach($row AS $key => $val) {
      $$key = stripslashes($val);
    }

    print "<tr><td><a href=\"opponent.php?opponent_id=$opponent_id&$params\">$first_name $last_name ($opponent_id)</a></td></tr>";
  }

  print "<tr><td><a href=\"opponent.php?$params\">Search again...</a></td></tr>";

  print "</table>";
}

include 'tpl/bot.php';
?>