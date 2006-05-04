<?
/* * * * * * * * * * * * * * * * * * * * * * * *
 * ASRC.biz (Aberdeen Squash Racquets Club)
 *
 * Copyright (c) 2006 Frontburner
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * View My Bookings
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  19-Mar-2004  File created.
 * CAM  29-May-2004  5 : View Admin Bookings by Day.
 * CAM  06-Feb-2006  8 : Changed 'Guest' for null opponent to 'Unspecified'.
 * * * * * * * * * * * * * * * * * * * * * * * */

$title = "Aberdeen Squash Racquets Club - Bookings";
include_once 'Main.php';
include 'tpl/top.php';

if ($member->isAdmin()) {
  $book_date = NULL;        if (!empty($_GET['book_date'])) $book_date = $_GET['book_date'];

  if ($book_date==NULL) {
    $ssql = "SELECT MIN(book_date) book_date FROM booking where status = 'O'";
    $sql = mysql_query($ssql) or die (mysql_error());

    if ($row = mysql_fetch_array($sql)) {
      foreach($row AS $key => $val) {
        $$key = stripslashes($val);
      }
    }
  }

  ?><table cellspacing=2 cellpadding=0 border=0><tr><td>&nbsp;</td><?

  $ssql = "SELECT DISTINCT book_date bk_date FROM booking where status = 'O' ORDER BY 1";
  $sql = mysql_query($ssql) or die (mysql_error());
  $days=0;

  while ($row = mysql_fetch_array($sql)) {
    foreach($row AS $key => $val) {
      $$key = stripslashes($val);
    }

    if ($days>0) {
      print "<td>&nbsp;|&nbsp;</td>";
    }

    $d = date("l", strtotime($bk_date));

    if ($book_date!=NULL && $book_date==$bk_date) {
      print "<td class=current><b>$d</b></td>";
    } else {
      print "<td><a href=\"mybookings.php?book_date=$bk_date\">$d</a></td>";
    }

    $days++;
  }

  ?></tr></table><br><?
}

?>

<table cellspacing=0 cellpadding=0 width="100%" border=0>
<tr><td valign=top><table border=1 cellspacing=0 cellpadding=2>
<tr>
  <th width="35">day</th>
  <th width="50">date</th>
  <th width="35">start</th>
  <th width="55">duration</th>
  <th width="35">court</th>
<? if ($member->isAdmin()) {
    print "<th width=\"140\">member</th>";
  } ?>
  <th width="140">opponent</th>
<?
  if ($member->isAdmin()) {
    print "<th width=\"120\" colspan=2>actions</th>";
  } else {
    print "<th width=\"60\">action</th>";
  }
?>
</tr>
<?
  $member = $_SESSION['member_person'];

  $ssql = "SELECT DATE_FORMAT(b.book_date,'%a') book_day,".
                 "DATE_FORMAT(b.book_date,'%d %b') book_date_disp,".
                 "DATE_FORMAT(b.book_date,'%Y-%m-%d') book_date,".
                 "s.duration,b.court,b.opponentid,".
                 "TIME_FORMAT(s.start_time,'%H:%i') start_time_fmt, ".
                 "b.memberid, b.court, b.slot, b.confirm_date ".
          "FROM booking b, slot s ".
          "WHERE b.court = s.court ".
          "AND b.slot = s.slot ".
          "AND b.status = 'O' ";
  if (!$member->isAdmin()) {
    $ssql .= "AND b.memberid='" . $member->getID() . "' ";
  } else {
    $ssql .= "AND b.book_date='" . $book_date . "' ";
  }

  $ssql .= "ORDER BY b.book_date, s.start_time";

  $sql = mysql_query($ssql) or die (mysql_error());

  while ($row = mysql_fetch_array($sql)) {
    foreach($row AS $key => $val) {
      $$key = stripslashes($val);
    }

    if ($opponentid) {
      $tupOpponent = Person::getPerson($opponentid);
    } else {
      $tupOpponent = new Tuple("UNSPEC", "Unspecified");
    }

    print "<tr>".
      "<td class=bc>$book_day</td>".
      "<td class=bc>$book_date_disp</td>".
      "<td class=bc>$start_time_fmt</td>".
      "<td class=bc>$duration</td>".
      "<td class=bc>$court</td>";

    if ($member->isAdmin()) {
      $tupMember = Person::getPerson($memberid);
      print "<td class=bc title=\"" . $tupMember->toString(true) . "\">" . $tupMember->getDesc() . "</td>";
    }

    print "<td class=bc title=\"" . $tupOpponent->toString(true) . "\">" . $tupOpponent->getDesc() . "</td>";

    if (empty($confirm_date) && (strtotime("$book_date $start_time_fmt") - time()) > 1800) {
      print "<td class=bc><a href=\"". ActionUtil::url('X', $book_date, $court, $slot) . "\">cancel</a></td>";
    } else {
      print "<td>&nbsp</td>";
    }

    if ($member->isAdmin()) {
      if (empty($confirm_date)) {
        print "<td class=bc><a href=\"". ActionUtil::url('C', $book_date, $court, $slot) . "\">confirm</a></td>";
      } else {
        print "<td>&nbsp</td>";
      }
    }

    print "</tr>";
  }
?>
</table></td></tr>

<? if (!$member->isAdmin()) { ?>

<tr height="40"><td valign=middle><b>Bookings made on my behalf</b></td></tr>

<tr><td valign=top><table border=1 cellspacing=0 cellpadding=2>
<tr>
  <th width="35">day</th>
  <th width="50">date</th>
  <th width="35">start</th>
  <th width="55">duration</th>
  <th width="35">court</th>
  <th width="140">opponent</th>
</tr>
<?php
  $member = $_SESSION['member_person'];

  $ssql = "SELECT DATE_FORMAT(b.book_date,'%a') book_day,".
                 "DATE_FORMAT(b.book_date,'%d %b') book_date_disp,".
                 "DATE_FORMAT(b.book_date,'%Y-%m-%d') book_date,".
                 "s.duration,b.court,b.memberid opponentid,".
                 "TIME_FORMAT(s.start_time,'%H:%i') start_time_fmt, ".
                 "b.memberid, b.court, b.slot, b.confirm_date ".
          "FROM booking b, slot s ".
          "WHERE b.court = s.court ".
          "AND b.slot = s.slot ".
          "AND b.status = 'O' ".
          "AND b.opponentid='" . $member->getID() . "' ";

  $ssql .= "ORDER BY b.book_date, s.start_time";

  $sql = mysql_query($ssql) or die (mysql_error());

  while ($row = mysql_fetch_array($sql)) {
    foreach($row AS $key => $val) {
      $$key = stripslashes($val);
    }

    if ($opponentid) {
      $tupOpponent = Person::getPerson($opponentid);
    } else {
      $tupOpponent = new Tuple("Guest", "Guest");
    }

    print "<tr>";
    print "<td class=bc>$book_day</td>".
      "<td class=bc>$book_date_disp</td>".
      "<td class=bc>$start_time_fmt</td>".
      "<td class=bc>$duration</td>".
      "<td class=bc>$court</td>";

    print "<td class=bc title=\"" . $tupOpponent->toString(true) . "\">" . $tupOpponent->getDesc() . "</td>";
    print "</tr>";
  }
?>
</table></td></tr>

<? } ?>

</table>

<? if ($member->isAdmin()) { ?>
<script language="JavaScript">
var objRefresh;
function refresh_now() {
  if (objRefresh) {
    clearTimeout(objRefresh);
  }
  top.location.reload();
}
var nMsec = 30 * 1000;
objRefresh = setTimeout("refresh_now()",nMsec);
</script>
<? } ?>

<?
include 'tpl/bot.php';
?>