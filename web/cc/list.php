<?php
/* * * * * * * * * * * * * * * * * * * * * * * *
 * List
 * Copyright (c) 2005-2006 Southesk.com
 * Author Craig McKay <craig@southesk.com>
 *
 * $Log: /web/cc/list.php $
 * 
 * 4     8/04/06 20:37 Craig
 *
 * 3     14/02/06 1:17 Craig
 *
 * 2     11/02/06 22:13 Craig
 *
 * 1     28/12/05 15:43 Craig
 *
 * Who  When         Why
 * CAM  27-Dec-2005  File created.
 * CAM  11-Feb-2006  Check for logged in user before displaying data.
 * CAM  08-Apr-2006  Use listedit link to edit existing dates.
 * * * * * * * * * * * * * * * * * * * * * * * */

$title = "List";
include 'tpl/top.php';

if (!empty($_GET['umtg_type'])) {
  $umtg_type = NULL;         if (!empty($_GET['umtg_type'])) $umtg_type = $_GET['umtg_type'];
  $umtg_date = NULL;         if (!empty($_GET['umtg_date'])) $umtg_date = $_GET['umtg_date'];
  $ulocality = NULL;         if (!empty($_GET['ulocality'])) $ulocality = $_GET['ulocality'];
} else {
  $umtg_type = NULL;         if (!empty($_POST['umtg_type'])) $umtg_type = $_POST['umtg_type'];
  $umtg_date = NULL;         if (!empty($_POST['umtg_date'])) $umtg_date = $_POST['umtg_date'];
  $ulocality = NULL;         if (!empty($_POST['ulocality'])) $ulocality = $_POST['ulocality'];
  $uservant = NULL;          if (!empty($_POST['uservant'])) $uservant = $_POST['uservant'];
  $unotes = NULL;            if (!empty($_POST['unotes'])) $unotes = $_POST['unotes'];
  $retry = NULL;            if (!empty($_POST['retry'])) $retry = $_POST['retry'];
}

if (!session_is_registered('memberid')) {
  Msg::error("You must be logged in to use this functionality.");
  include 'tpl/bot.php';
  exit();
}

?>

<table border=0 cellpadding=10 align=center><tr>

<?
$sql = mysql_query("SELECT pdffile, ".
                          "docdate, ".
                          "DATE_FORMAT(docdate,'%M %Y') docdate_fmt, ".
                          "DATE_FORMAT(docdate,'%D %M %Y') docdate_full ".
                   "FROM pdf ".
                   "WHERE doctype = 'L' ".
                   "ORDER BY docdate DESC");

$pdfCount = 0;
$mostRecent = NULL;
while ($row = mysql_fetch_array($sql)) {
  foreach($row AS $key => $val) {
    $$key = stripslashes($val);
  }

  if ($pdfCount++ < 3) {
?>
    <td align=center><a target=_blank href="pdf/<? echo $pdffile; ?>"><img border=0 src="img/pdf2.png"><br><? echo $docdate_fmt; ?></a></td>
<?
  }

  if (empty($mostRecent)) {
    $mostRecent = $docdate_full;
  }
}

?>

</tr></table>

<?
if (empty($retry)) {
?>

<table border=0 cellspacing=0 cellpadding=2 align=center>
<tr><td valign=top align=center colspan=3><b>List of Meetings</b><br>(Subject to the will of the Lord)</td></tr>
<tr><td valign=top align=right colspan=3><b><? echo $mostRecent; ?></b></td></tr>
<?

$ssql = "SELECT m.mtg_type, DATE_FORMAT(m.mtg_date,'%d %b %y') mtg_date, l.locality_name, l.country, ".
                          "m.mtg_date mtg_date_sql, DATE_FORMAT(m.mtg_date,'%d-%b-%Y') mtg_date_js, ".
                          "m.locality, ".
                          "s.servant_name, d.locality_name servant_locality, m.notes, s.wife_name, ".
                          "SIGN(UNIX_TIMESTAMP() - UNIX_TIMESTAMP(m.mtg_date)) future ".
                   "FROM meeting_list m, meeting_locality l, meeting_servant s, meeting_locality d ".
                   "WHERE m.locality = l.locality ".
                   "AND m.servant = s.servant ".
                   "AND s.locality = d.locality ".
                   "AND (m.mtg_date > DATE_SUB(NOW(), INTERVAL 30 DAY) ".
                   "     OR (m.mtg_date > DATE_SUB(NOW(), INTERVAL 300 DAY) AND m.notes IS NOT NULL)) ".
                   "ORDER BY m.mtg_type, SIGN(UNIX_TIMESTAMP() - UNIX_TIMESTAMP(m.mtg_date)), m.mtg_date" ;

$sql = mysql_query($ssql) or die (mysql_error() . "<pre>$ssql</pre>");

$mt = "";
while ($row = mysql_fetch_array($sql)) {
  foreach($row AS $key => $val) {
    $$key = stripslashes($val);
  }

  if ($mt != $mtg_type) {
    $mt = $mtg_type;
    if ($mt == "3") {
      echo "<tr><td colspan=3><b>Three Day Meetings</b></td></tr>";
    } else if ($mt == "F") {
      echo "<tr><td colspan=3><b>Fellowship Meetings</b></td></tr>";
    } else if ($mt == "M") {
      echo "<tr><td colspan=3><b>Marriage Meetings</b></td></tr>";
    }
  }

  if ($member->isAdmin()) {
    $mtg_date = "<a href=\"listedit.php?umtg_type=$mtg_type&umtg_date=$mtg_date_js&ulocality=$locality\">$mtg_date</a>";
  }

  $loc = "";
  if (!empty($notes)) {
    $loc .= "<a target=\"_blank\" href=\"pdf/$notes\">";
  }
  $loc .= $locality_name;
  if (!empty($notes)) {
    $loc .= "</a>";
  }
  $loc .= " ($country)";

  $classname="";
  if ($future > -1) {
    $classname="class=\"past\"";
  }

  echo "<tr $classname><td width=\"80\">$mtg_date</td><td width=\"200\">$loc</td><td>$servant_name ";
  if ($mt == "M") {
    echo " &amp; $wife_name</td></tr>";
  } else {
    echo "($servant_locality)</td></tr>";
  }

  echo "</td></tr>";
}



?>
</td></tr>
</table>

<?
}
?>

<center>

<?

if ($member->isAdmin()) {
  if (empty($retry)) {
    include 'frm/list.add.php';
  } else if (empty($umtg_date)) {
    Msg::error("Please enter the Meeting date.");
    include 'frm/list.add.php';
  } else {
    $ssql = "REPLACE INTO meeting_list (".
        "mtg_type,mtg_date,locality,servant".
      ") VALUES (".
        "'$umtg_type','" . mdate($umtg_date) . "','$ulocality','$uservant'".
      ")";

    $sql = mysql_query($ssql) or die(mysql_error());
    if(mysql_affected_rows() <= 2){
      // Replace does update two rows
      Msg::statement("List entry has been updated.");

    } else {
      Msg::error("An error occurred updating the list entry - please try again.");
    }
  }
}

include 'tpl/bot.php';
?>