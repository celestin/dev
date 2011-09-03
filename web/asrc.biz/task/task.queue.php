<?
/* * * * * * * * * * * * * * * * * * * * * * * *
 * ASRC.biz (Aberdeen Squash Racquets Club)
 * Copyright (c) 2007 Frontburner
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  26-Oct-2007  10195 : File created.
 * * * * * * * * * * * * * * * * * * * * * * * */

// Send the next 10 queued emails

$ssql = "SELECT q.id, ".
               "q.item_id,".
               "q.item_type,".
               "q.memberid,".
               "DATE_FORMAT(e.event_date,'%d %b %Y') event_date_fmt,".
               "e.event_title,".
               "e.event_text ".
        "FROM queue q ".
        "LEFT OUTER JOIN event e ON e.id = q.item_id ".
        "ORDER BY q.id ".
        "LIMIT 10";
$sql = mysql_query($ssql) or die (mysql_error());

$items = array();
$i=0;

while ($row = mysql_fetch_array($sql)) {
  foreach($row AS $key => $val) {
    $$key = stripslashes($val);
  }

  $items[$i++] = $id;

  if ($item_type == "EVENT") {
    $eventEmail = new EventEmail($memberid, $event_date_fmt, $event_title, $event_text);
    $eventEmail->send();
  }
}

if (count($items) > 0) {
  $ssql = "DELETE FROM queue WHERE id IN (" . implode(",", $items) . ")";
  $sql = mysql_query($ssql) or die (mysql_error());
}

?>