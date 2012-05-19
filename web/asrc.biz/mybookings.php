<?
/* * * * * * * * * * * * * * * * * * * * * * * *
 * ASRC.biz (Aberdeen Squash Racquets Club)
 *
 * Copyright (c) 2006-2007 Frontburner
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
 * CAM  22-Jun-2007  10132 : Distinguish between Unspecified, Unknown and Guest.
 * CAM  22-Jun-2007  10130 : Added Key to Colour-coding.
 * CAM  25-Jun-2007  10129 : Colour alternate rows.
 * CAM  27-Aug-2011  11014 : Corrected errors around member variables.
 * CAM  19-May-2012  11122 : Xodus Group Court naming.
 * * * * * * * * * * * * * * * * * * * * * * * */

$title = "Bookings";
include_once 'Main.php';
include 'tpl/top.php';
$alternate=true;
$prev_time="";

if (isset($member) && $member->isAdmin()) {
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
<? if (isset($member) && $member->isAdmin()) {
    print "<th width=\"140\">member</th>";
  } ?>
  <th width="140">opponent</th>
<?
  if (isset($member) && $member->isAdmin()) {
    print "<th width=\"120\" colspan=2>actions</th>";
  } else {
    print "<th width=\"60\">action</th>";
  }
?>
</tr>
<?
  if (isset($_SESSION['member_person'])) {
	  $member = $_SESSION['member_person'];

	  $ssql = "SELECT DATE_FORMAT(b.book_date,'%a') book_day,".
	                 "DATE_FORMAT(b.book_date,'%d %b') book_date_disp,".
	                 "DATE_FORMAT(b.book_date,'%Y-%m-%d') book_date,".
	                 "s.duration, COALESCE(c.shortname, c.court) courtname,b.opponentid,".
	                 "TIME_FORMAT(s.start_time,'%H:%i') start_time_fmt, ".
	                 "b.memberid, b.court, b.slot, b.confirm_date ".
	          "FROM booking b, court c, slot s ".
	          "WHERE c.court = b.court ".
            "AND s.court = b.court ".
	          "AND s.slot = b.slot ".
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
	      $tupOpponent = new Person("?", "Unspecified", "", "", "", 0, "Y", 0);
	    }

	    $rowclass="bc";
	    $start_time = $start_time_fmt;

	    if ($start_time_fmt != $prev_time) {
	      $alternate = (!$alternate);
	      $start_time = "<b>$start_time_fmt</b>";
	    }

	    if ($alternate) {
	      $rowclass="alt";
	    }

	    print "<tr>".
	      "<td class=$rowclass>$book_day</td>".
	      "<td class=$rowclass>$book_date_disp</td>".
	      "<td class=$rowclass>$start_time</td>".
	      "<td class=$rowclass>$duration</td>".
	      "<td class=$rowclass>$courtname</td>";

	    if ($member->isAdmin()) {
	      $tupMember = Person::getPerson($memberid);
	      print "<td class=" . $tupMember->getClass() . " title=\"" . $tupMember->toString(true) . "\">" . $tupMember->getDesc() . "</td>";
	    }

	    print "<td class=" . $tupOpponent->getClass() . " title=\"" . $tupOpponent->toString(true) . "\">" . $tupOpponent->getDesc() . "</td>";

	    if (empty($confirm_date) && (strtotime("$book_date $start_time_fmt") - time()) > 1800) {
	      print "<td class=$rowclass><a href=\"". ActionUtil::url('X', $book_date, $court, $slot) . "\">cancel</a></td>";
	    } else {
	      print "<td class=$rowclass>&nbsp</td>";
	    }

	    if ($member->isAdmin()) {
	      if (empty($confirm_date)) {
	        print "<td class=$rowclass><a href=\"". ActionUtil::url('C', $book_date, $court, $slot) . "\">confirm</a></td>";
	      } else {
	        print "<td class=$rowclass>&nbsp</td>";
	      }
	    }

	    $prev_time = $start_time_fmt;

	    print "</tr>";
	  }
	}
?>
</table></td></tr>

<? if (isset($member) && !$member->isAdmin()) { ?>

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
                 "s.duration, COALESCE(c.shortname, c.court) courtname,b.memberid opponentid,".
                 "TIME_FORMAT(s.start_time,'%H:%i') start_time_fmt, ".
                 "b.memberid, b.court, b.slot, b.confirm_date ".
	          "FROM booking b, court c, slot s ".
	          "WHERE c.court = b.court ".
            "AND s.court = b.court ".
	          "AND s.slot = b.slot ".
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
      $tupOpponent = new Person("Guest", "Guest", "", "", "", 0, "U", 0);
    }

    print "<tr>";
    print "<td class=bc>$book_day</td>".
      "<td class=bc>$book_date_disp</td>".
      "<td class=bc>$start_time_fmt</td>".
      "<td class=bc>$duration</td>".
      "<td class=bc>$courtname</td>";

    print "<td class=bc title=\"" . $tupOpponent->toString(true) . "\">" . $tupOpponent->getDesc() . "</td>";
    print "</tr>";
  }
?>
</table></td></tr>

<? } ?>

</table>

<? if (isset($member) && $member->isAdmin()) { ?>
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