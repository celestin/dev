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
$sql = mysql_query("SELECT h.imgfile, p.id, p.product ".
                    "FROM photos h, products p ".
                    "WHERE h.product_id = p.id ".
                    "ORDER BY rand() LIMIT 1");
if ($row = mysql_fetch_array($sql)) {
  $rand_link = "<a class=imgnav href=\"product.php?product=$row[1]\">".
               "<img src=\"img/g/m/$row[0]\"><br>$row[2]</a>";
}
?>
<tr>
  <td align=center>
    <table border=0 class=modbod cellpadding=10 cellspacing=0>
      <tr>
      <td>Bellhouse<br>
    Langhouse Rd<br>
    Inverkip<br>
    PA16 0DE.</td>
      <td align=center><? echo $rand_link; ?></td>
      </tr>
    </table>
  </td>
</tr>
<tr valign=bottom><td align=center>
<?
include 'tpl/cards.php';
?>
</td></tr>

</table>

<?
include 'tpl/bot.php';
?>