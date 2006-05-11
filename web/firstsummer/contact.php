<?
/* * * * * * * * * * * * * * * * * * * * * * * *
 * First Summerhouses
 * Copyright (c) 2006 Frontburner
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * Contact page
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  08-Apr-2006  File created.
 * * * * * * * * * * * * * * * * * * * * * * * */

$title = "Contact Us";
include 'tpl/top.php';
?>

<table height="100%" width="100%" border=0 cellpadding=10 cellspacing=0>
<tr>
  <td align=center><h3>We are always ready to hear from you!</h3>
  <p>Please give us a ring on <span class="fldtxt">01475 522 999</span> or drop us an email at
  <a href="mailto:<? echo $cfg['Site']['Email']; ?>?Subject=Sales%20Inquiry"><? echo $cfg['Site']['Email']; ?></a>.</p></td>
</tr>
<?
$sql2 = mysql_query("SELECT id,imgfile FROM photos ORDER BY rand() LIMIT 1");
if ($row2 = mysql_fetch_array($sql2)) {
  foreach($row2 AS $key2 => $val) {
    $$key2 = stripslashes($val);
  }
  $rand_img = $imgfile;
}
?>
<tr><td align=center><img src="img/g/f/<? echo $rand_img; ?>"></td></tr>
<tr valign=bottom><td align=center>
<?
include 'tpl/cards.php';
?>
</td></tr>

</table>

<?
include 'tpl/bot.php';
?>