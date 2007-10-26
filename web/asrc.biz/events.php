<?php
/* * * * * * * * * * * * * * * * * * * * * * * *
 * ASRC.biz (Aberdeen Squash Racquets Club)
 * Copyright (c) 2006-2007 Frontburner
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  22-Oct-2007  10182 : File created.
 * CAM  26-Oct-2007  10195 : Added Email and View Queue buttons.
 * * * * * * * * * * * * * * * * * * * * * * * */

$title = "ASRC Events - Social Noticeboard";
$events_read = true;
include 'tpl/top.php';

global $flash;
showFlash();

?><table border=0 cellpadding=0 cellspacing=0 width="100%">
<?

$ssql = "SELECT id event_id, event_title, event_text, email_count, ".
        "DATE_FORMAT(event_date,'%d %b %Y') event_date_fmt ".
        "FROM event ".
        "ORDER BY event_date ASC ";
$sql = mysql_query($ssql) or die (mysql_error());
$counter=0;
$style = "";

while ($row = mysql_fetch_array($sql)) {
  foreach($row AS $key => $val) {
    $$key = stripslashes($val);
  }
  $style = "";
  if ($counter++ > 0) {
    $style = "style=\"padding-top:20px\"";
  }

  $emailed_desc = "";
  if ($email_count == 0) {
    $emailed_desc = "Never emailed";
  } else if ($email_count == 1) {
    $emailed_desc = "Emailed Once";
  } else if ($email_count == 2) {
    $emailed_desc = "Emailed Twice";
  } else {
    $emailed_desc = "Emailed $email_count times";
  }


?>
<tr>
<td <? echo $style; ?>><table border=0 cellpadding=0 cellspacing=0>
  <tr>
    <td class="item_date"><? echo $event_date_fmt; ?></td><td class="item_title"><? echo $event_title; ?></td>
<?
if ($loggedin && $member->isAdmin()) {
?>
    <td style="padding-left:5px"><a href="event.edit.php?event_id=<? echo $event_id; ?>"><img border=0 class="sep" src="img/edit/edit.png"></a></td>
    <td><a href="event.delete.php?event_id=<? echo $event_id; ?>"><img border=0 class="sep" src="img/edit/delete.png"></a></td>
    <td>&nbsp;<? echo $emailed_desc; ?>&nbsp;</td>
    <td><a href="event.email.php?event_id=<? echo $event_id; ?>"><img border=0 class="sep" src="img/edit/mail.png"></a></td>
    <td><a href="queue.php"><img border=0 class="sep" src="img/edit/view.png"></a></td>
<?
}
?>
  </tr>
</table></td></tr>
</td></tr>
<td class="item_text"><? echo Util::textBoxToHtml($event_text); ?></td></tr>
<?
}
?>
</td></tr>
<?
if ($loggedin && $member->isAdmin()) {
?>
<tr><td <? echo $style; ?> align="center"><table border=0 cellpadding=0 cellspacing=0>
  <tr>
    <td><a href="event.add.php"><img border=0 class="sep" src="img/edit/add.png"></a></td>
    <td>&nbsp;<a href="event.add.php">Add an Event</a></td>
  </tr>
</table></td></tr>
<?
}
?>
</table>
<?
include 'tpl/bot.php';
?>
