<?php
/* * * * * * * * * * * * * * * * * * * * * * * *
 * West Coast Express Website
 * Copyright (c) 2007 Frontburner
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * Feedbacks
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  11-Aug-2007  10154 : File created.
 * * * * * * * * * * * * * * * * * * * * * * * */

$title = "Customer Feedback";
include 'tpl/top.php';

$uphoto = NULL;        if (!empty($_GET['photo'])) $uphoto = $_GET['photo'];

global $flash;

showFlash();

?><table border=0 cellpadding=0 cellspacing=0 width="100%">
<tr><td valign=top><table border=0 cellpadding=0 cellspacing=8>
<?

$ssql = "SELECT id feedback_id, customer_name, feedback, ".
        "DATE_FORMAT(feedback_date, '%d %b %Y') feedback_date_fmt ".
        "FROM feedback ".
        "ORDER BY feedback_date DESC ";
$sql = mysql_query($ssql) or die (mysql_error());
$counter=0;

while ($row = mysql_fetch_array($sql)) {
  foreach($row AS $key => $val) {
    $$key = stripslashes($val);
  }

  if ($counter>0) {
?>
  <tr><td align=right height=2><img src="img/f.gif" width=1 height=1></td></tr>
<?
  }


?>
  <tr><td><table border=0 style="padding:15px" cellpadding=0 cellspacing=0 width=350 class="quote">
  <?
  if ($loggedin && $member->isAdmin()) {
  ?>
  <tr><td colspan=3><table border=0 cellpadding=0 cellspacing=0 width="100%">
    <tr>
      <td><b><? echo "$feedback_date_fmt"; ?></b></b>
      <td width=16><a href="feedback.edit.php?feedback_id=<? echo $feedback_id; ?>"><img border=0 class="sep" src="img/edit/edit.png"></a></td>
      <td width=16><a href="feedback.delete.php?feedback_id=<? echo $feedback_id; ?>"><img border=0 class="sep" src="img/edit/delete.png"></a></td>
    </tr>
  </table><br></td></tr>
  <?
  }
  ?>
  <tr><td valign=top><img style="padding-right:5px" src="img/quoteleft.png"><td><? echo $feedback; ?></td>
  <td valign=bottom><img style="padding-left:5px" src="img/quoteright.png"></td></tr>
  <tr><td colspan=3 align="right">-&nbsp;<b><? echo $customer_name; ?></b></td></tr>
  </table></td></tr>
  <?
  $counter++;
}
?>
<tr><td>&nbsp;</td></tr>
<?
if ($loggedin && $member->isAdmin()) {
?>
<tr><td align="center"><br><table border=0 cellpadding=0 cellspacing=0>
  <tr>
    <td><a href="feedback.add.php"><img border=0 class="sep" src="img/edit/add.png"></a></td>
    <td><a href="feedback.add.php">Add Feedback</a></td>
  </tr>
</table></td></tr>
<?
}
?>
</table></td>
<td width=250 valign=top><table border=0 cellpadding=0 cellspacing=0>
  <tr><td align=right><img src="img/feedback1.jpg"></td></tr>
  <tr><td align=right><p class="underpicture">We pride ourselves in our reputation.</p>
    <p>Here's what some of our happy customers have said about our service and their experiences.</p></td></tr>
</table></td></tr></table>
<?
include 'tpl/bot.php';
?>

