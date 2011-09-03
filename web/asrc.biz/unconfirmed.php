<?
/* * * * * * * * * * * * * * * * * * * * * * * *
 * ASRC.biz (Aberdeen Squash Racquets Club)
 *
 * Copyright (c) 2007 Frontburner
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * Allow Confirmation of games played outwith Reception Hours
 *
 * $Id $
 *
 * Who  When         Why
 * CAM  12-Aug-2007  10157 : File created.
 * * * * * * * * * * * * * * * * * * * * * * * */

$title = "Unconfirmed Bookings";
include_once 'Main.php';
include 'tpl/top.php';

if (!$loggedin) {
  redirect("index.php");
}

if (!$member->isAdmin()) {
  storeFlash("You do not have permission to access Unconfirmed bookings!");
  redirect("mybookings.php");
}

?>

<p><b>Unconfirmed Bookings</b></p>
<table cellspacing=0 cellpadding=0 width="100%" border=0>
<tr><td valign=top><table border=1 cellspacing=0 cellpadding=2>
<tr>
  <th>Date</th>
  <th>Time</th>
  <th>Court</th>
  <th>Member</th>
  <th>Opponent</th>
  <th>Action</th>
</tr>
<?
    $ssql = "SELECT b.book_date, s.start_time, b.court, b.slot, b.memberid, b.opponentid, b.charge, ".
            "DATE_FORMAT(b.book_date,'%d %b %Y') book_date_disp,".
            "TIME_FORMAT(s.start_time,'%H:%i') start_time_fmt ".
            "FROM booking b inner join slot s on b.court = s.court and b.slot = s.slot ".
            "WHERE b.status = 'U' ".
            "ORDER BY 1,2,3";

    $sql = mysql_query($ssql) or die (mysql_error());
    $total_fines = 0;

    while ($row = mysql_fetch_array($sql)) {
      foreach($row AS $key => $val) {
        $$key = stripslashes($val);
      }

      $tupMember = Person::getPerson($memberid);

      if ($opponentid) {
        $tupOpponent = Person::getPerson($opponentid);
      } else {
        $tupOpponent = new Tuple("Guest", "Guest");
      }

      $total_fines += $charge;

      print "<tr>".
        "<td class=bc>$book_date_disp</td>".
        "<td class=bc>$start_time_fmt</td>".
        "<td class=bc>$court</td>".
        "<td class=bc title=\"" . $tupMember->toString(true) . "\">" . $tupMember->getDesc() . "</td>".
        "<td class=bc title=\"" . $tupOpponent->toString(true) . "\">" . $tupOpponent->getDesc() . "</td>".
        "<td><a href=\"". ActionUtil::url("C", $book_date, $court, $slot) . "\">confirm</a></td>".
      "</tr>";
    }
?>
</table></td></tr></table>
<?

include 'tpl/bot.php';
?>