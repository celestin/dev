<?
/* * * * * * * * * * * * * * * * * * * * * * * *
 * ASRC.biz (Aberdeen Squash Racquets Club)
 *
 * Copyright (c) 2006 Frontburner
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * Current Courts View
 *
 * $Log: /web/asrc.biz/courtsview.php $
 * 
 * 2     3/05/06 22:37 Craig
 * 14
 *
 * 1     3/05/06 22:27 Craig
 * 14
 *
 * Who  When         Why
 * CAM  25-Apr-2006  14 : File created.
 * * * * * * * * * * * * * * * * * * * * * * * */

$title = "Aberdeen Squash Racquets Club - Current Courts View";
include_once 'Main.php';
$hide_toolbar = true;
include 'tpl/top.php';

session_destroy();

$book_date = NULL;        if (!empty($_GET['book_date'])) $book_date = $_GET['book_date'];

if ($book_date==NULL) {
/*
  $ssql = "SELECT DATE_ADD(MIN(book_date), INTERVAL 1 DAY) book_date FROM booking where status = 'O'";
  $sql = mysql_query($ssql) or die (mysql_error());

  if ($row = mysql_fetch_array($sql)) {
    foreach($row AS $key => $val) {
      $$key = stripslashes($val);
    }
  }
*/
  $book_date = date('Y-m-d');
}

?><table cellspacing=0 cellpadding=5 border=1>
<tr>
  <th with=50>time</th>
  <th width=150>Court 4</th>
  <th width=150>Court 5</th>
  <th width=150>Court 6</th>
  <th width=150>Court 7</th>
</tr><?

  $ssql = "SELECT MIN(x.start_time_first) start_time_first, ".
                 "MAX(x.start_time_last) start_time_last FROM ( ".
            "SELECT TIME_FORMAT(MIN(s.start_time),'%H:%i') start_time_first, ".
                   "TIME_FORMAT(MAX(s.start_time),'%H:%i') start_time_last ".
            "FROM booking b, slot s ".
            "WHERE b.court = s.court ".
            "AND b.slot = s.slot ".
            //"AND b.status = 'O' ".
            "AND b.book_date='" . $book_date . "' ".
            "AND CONCAT(DATE_FORMAT(NOW(), '%Y-%m-%d '), s.start_time) BETWEEN DATE_ADD(NOW(), INTERVAL -1 HOUR) AND DATE_ADD(NOW(), INTERVAL 5 HOUR) ".
            "UNION ".
            "SELECT TIME_FORMAT(MIN(s.start_time),'%H:%i') start_time_first, ".
                   "TIME_FORMAT(MAX(s.start_time),'%H:%i') start_time_last ".
            "FROM booking_arc b, slot s ".
            "WHERE b.court = s.court ".
            "AND b.slot = s.slot ".
            //"AND b.status = 'O' ".
            "AND b.book_date='" . $book_date . "' ".
            "AND CONCAT(DATE_FORMAT(NOW(), '%Y-%m-%d '), s.start_time) BETWEEN DATE_ADD(NOW(), INTERVAL -1 HOUR) AND DATE_ADD(NOW(), INTERVAL 5 HOUR) ".
          ") x";

          ?>
<!-- <? echo $ssql; ?> -->
          <?

  $sql = mysql_query($ssql) or die (mysql_error());

  if ($row = mysql_fetch_array($sql)) {
    foreach($row AS $key => $val) {
      $$key = stripslashes($val);
    }
  } else {
    echo "</table>";
    include 'tpl/bot.php';
    exit();
  }

  $curr_time = strtotime($start_time_first);
  $end_time = strtotime($start_time_last);
  $diff = 1;

  $courts = array();
  for ($i=4; $i<=7; $i++) {
    $courts[$i] = array();
    $courts[$i][0] = 0;
    $courts[$i][1] = 0;
    $courts[$i][2] = "";
    $courts[$i][3] = "";
    $courts[$i][4] = "";
  }


  while ($curr_time < $end_time) {

    ?><tr><td width=50><? echo date('H:i', $curr_time ); ?></td><?

    $ssql = "SELECT TIME_FORMAT(s.start_time,'%H:%i') start_time_fmt, ".
                   "b.court, b.memberid, s.duration, s.duration/10 blocks, ".
                   "CONCAT(m.first_name, ' ', m.last_name) member_name, ".
                   "CONCAT(o.first_name, ' ', o.last_name) opponent_name ".
            "FROM booking b, slot s ".
            "LEFT OUTER JOIN member o ON b.opponentid = o.memberid ".
            "LEFT OUTER JOIN member m ON b.memberid = m.memberid ".
            "WHERE b.court = s.court ".
            "AND b.slot = s.slot ".
            //"AND b.status = 'O' ".
            "AND b.book_date='$book_date' ".
            "AND UNIX_TIMESTAMP(CONCAT(DATE_FORMAT(NOW(), '%Y-%m-%d '), s.start_time))=$curr_time ".
            "UNION ".
            "SELECT TIME_FORMAT(s.start_time,'%H:%i') start_time_fmt, ".
                   "b.court, b.memberid, s.duration, s.duration/10 blocks, ".
                   "CONCAT(m.first_name, ' ', m.last_name) member_name, ".
                   "CONCAT(o.first_name, ' ', o.last_name) opponent_name ".
            "FROM booking_arc b, slot s ".
            "LEFT OUTER JOIN member o ON b.opponentid = o.memberid ".
            "LEFT OUTER JOIN member m ON b.memberid = m.memberid ".
            "WHERE b.court = s.court ".
            "AND b.slot = s.slot ".
            //"AND b.status = 'O' ".
            "AND b.book_date='$book_date' ".
            "AND UNIX_TIMESTAMP(CONCAT(DATE_FORMAT(NOW(), '%Y-%m-%d '), s.start_time))=$curr_time ".
            "ORDER BY 2";

    $sql = mysql_query($ssql) or die (mysql_error());
    while ($row = mysql_fetch_array($sql)) {
      foreach($row AS $key => $val) {
        $$key = stripslashes($val);
      }
      $courts[$court][0] = 1;
      $courts[$court][1] = $blocks;
      $courts[$court][2] = $memberid;
      $courts[$court][3] = $member_name;
      $courts[$court][4] = trim($opponent_name);
    }

    for ($i=4; $i<=7; $i++) {

      if ($courts[$i][0] == 1) {
        ?><td class=courtview rowspan=<? echo $courts[$i][1]; ?>><?

          echo $courts[$i][3];

          if ($courts[$i][4] != "") {
            echo "<br><i>vs.</i><br>" . $courts[$i][4];
          }

        ?></td><?
        $courts[$i][0] = 0;
        $courts[$i][1]--;
      } else if ($courts[$i][1] > 0) {
        $courts[$i][1]--;
      } else {
        ?><td>&nbsp;</td><?
      }

      echo "\n";
    }

    $curr_time = $curr_time+600;

    echo "</tr>\n";
  }

?></table>

<script language="JavaScript">
var objRefresh;
function refresh_now() {
  if (objRefresh) {
    clearTimeout(objRefresh);
  }
  top.location.reload();
}
var nMsec = 60 * 1000;
objRefresh = setTimeout("refresh_now()",nMsec);
</script>

<?
include 'tpl/bot.php';
?>