<?
/* * * * * * * * * * * * * * * * * * * * * * * *
 * ASRC.biz (Aberdeen Squash Racquets Club)
 *
 * Copyright (c) 2006 Frontburner
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * View and Manage Fines
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  30-May-2004  4 : File created.
 * CAM  19-May-2012  11122 : Xodus Group Court naming.
 * * * * * * * * * * * * * * * * * * * * * * * */

$title = "Fines";
include_once 'Main.php';
include 'tpl/top.php';

if ($member->isAdmin()) {
  $memberid = NULL;         if (!empty($_GET['memberid'])) $memberid = $_GET['memberid'];
  $sb = "F";                if (!empty($_GET['sb']))       $sb = $_GET['sb'];

  if ($memberid==NULL) {
?>
<table cellspacing=0 cellpadding=0 width="100%" border=0>
<tr><td valign=top><table border=1 cellspacing=0 cellpadding=2>
<tr>
  <th><a href="fines.php?sb=M">Member No.</a></th>
  <th><a href="fines.php?sb=F">First Name</a></th>
  <th><a href="fines.php?sb=L">Surname</a></th>
  <th>Fines</th>
</tr>
<?
    $ssql = "SELECT m.memberid, MAX(m.first_name) first_name, ".
            "MAX(m.last_name) last_name, COUNT(b.charge) fine_count ".
            "FROM booking b INNER JOIN member m on b.memberid = m.memberid ".
            "WHERE status = 'X' ".
            "GROUP BY m.memberid ".
            "ORDER BY ";

    if ($sb == "F") $ssql .= "m.first_name";
    if ($sb == "L") $ssql .= "m.last_name";
    if ($sb == "M") $ssql .= "SUBSTRING(CONCAT('0000000000',m.memberid),1+LENGTH(m.memberid),10)";

    $sql = mysql_query($ssql) or die (mysql_error());

    while ($row = mysql_fetch_array($sql)) {
      foreach($row AS $key => $val) {
        $$key = stripslashes($val);
      }

      print "<tr>".
        "<td class=bc><a href=\"fines.php?memberid=$memberid\">$memberid</a></td>".
        "<td class=bc>$first_name</td>".
        "<td class=bc>$last_name</td>".
        "<td class=bc>$fine_count</td>".
      "</tr>";
    }
?>
</table></td></tr></table>
<?
  } else {
    $member = Person::getPerson($memberid);

    print "<p><b>Fine Report</b> for " . $member->toHtmlString(true) . "</p>";
?>
<table cellspacing=0 cellpadding=0 width="100%" border=0>
<tr><td valign=top><table border=1 cellspacing=0 cellpadding=2>
<tr>
  <th>Date</th>
  <th>Time</th>
  <th>Court</th>
  <th>Opponent</th>
  <th>Charge</th>
  <th>Action</th>
</tr>
<?
    $ssql = "SELECT b.book_date, s.start_time, b.court, COALESCE(c.shortname, c.court) courtname, b.slot, b.opponentid, b.charge, ".
            "DATE_FORMAT(b.book_date,'%d %b %Y') book_date_disp,".
            "TIME_FORMAT(s.start_time,'%H:%i') start_time_fmt ".
	          "FROM booking b, court c, slot s ".
	          "WHERE c.court = b.court ".
            "AND s.court = b.court ".
	          "AND s.slot = b.slot ".
            "AND b.status = 'X' ".
            "AND b.memberid = '$memberid' ".
            "ORDER BY 1,2";

    $sql = mysql_query($ssql) or die (mysql_error());
    $total_fines = 0;

    while ($row = mysql_fetch_array($sql)) {
      foreach($row AS $key => $val) {
        $$key = stripslashes($val);
      }

      if ($opponentid) {
        $tupOpponent = Person::getPerson($opponentid);
      } else {
        $tupOpponent = new Tuple("Guest", "Guest");
      }

      $total_fines += $charge;

      print "<tr>".
        "<td class=bc>$book_date_disp</td>".
        "<td class=bc>$start_time_fmt</td>".
        "<td class=bc>$courtname</td>".
        "<td class=bc title=\"" . $tupOpponent->toString(true) . "\">" . $tupOpponent->getDesc() . "</td>".
        "<td class=br>£$charge</td>".
        "<td><a href=\"". ActionUtil::url("C", $book_date, $court, $slot) . "\">confirm</a></td>".
      "</tr>";
    }
?>
<tr><td colspan=3>&nbsp;</td>
<td class=br>Total</td><td class=br>£<? print $total_fines  ?>
</td><td>
<? print "<a href=\"". ActionUtil::urlPay("P", $memberid) . "\">pay all</a>"; ?>
</td></tr>
</table></td></tr></table>
<?
  }
}
?>

<?
include 'tpl/bot.php';
?>