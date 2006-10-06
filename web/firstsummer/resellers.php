<?php
/* * * * * * * * * * * * * * * * * * * * * * * *
 * First Summerhouses
 * Copyright (c) 2006 Frontburner
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * Resellers page
 *
 * $Id: category.php 184 2006-07-05 00:15:13Z craig $
 *
 * Who  When         Why
 * CAM  02-Oct-2006  10044 : File created.
 * * * * * * * * * * * * * * * * * * * * * * * */

include_once 'Main.php';

$title = "Resellers";
include 'tpl/top.php';

$reseller_id = NULL;     if (!empty($_GET['reseller_id'])) $reseller_id = $_GET['reseller_id'];

?>

<script language="javascript">

function mover(img) {
  img.src = "img/reseller_on.gif";
}

function mout(img) {
  img.src = "img/reseller_off.gif";
}

</script>

<?
$address = "";
$sql = mysql_query("SELECT id, reseller, address1, address2, town, county, postcode, ".
                   "telephone, email, website, locx, locy ".
                   "FROM resellers");

while ($row = mysql_fetch_array($sql)) {
  foreach($row AS $key => $val) {
    $$key = stripslashes($val);
  }

  if ($id === $reseller_id || empty($reseller_id)) {
    $reseller_id = $id;

    $address = "<b>$reseller</b><br>$address1";
    if (!empty($address2)) $address .= "<br>$address2";
    if (!empty($town)) $address .= "<br>$town";
    if (!empty($county)) $address .= "<br>$county";
    $address .= "<br><b>$postcode</b>";
    $address .= "<br><br><b>tel</b>&nbsp;$telephone";
    $address .= "<br><a href=\"mailto:$email?Subject=Link from 1stsummerhouses.com\">email</a><span class=\"sep\">|</span>";
    $address .= "<a href=\"$website\">website</a>";
  }

?>
<div style="position:absolute; z-index:1; left:<? echo $locx;?>px; top:<? echo $locy;?>px;"><a href="resellers.php?reseller_id=<? echo $id;?>" title="<? echo "$town - $reseller";?>"><img onmouseover="mover(this);" onmouseout="mout(this);" src="img/reseller_off.gif" width="27" height="19" border="0"></a></div>
<?
}
?>

<table border=0 cellpadding=10 cellspacing=0 width="100%">

<tr height="200">

  <td width="100%" valign=top><h3>Reseller</h3>

  <p><? echo $address;?></p></td>

  <td rowspan=2 align=right><img src="img/ukresellers.gif"></td>

</tr>

<tr>

  <td valign=top><h3>Products</h3><ul>
<?
$sql = mysql_query("SELECT e.product_id, IFNULL(p.htmlname,p.product) htmlname ".
                   "FROM resellerproducts e, products p ".
                   "WHERE e.product_id = p.id ".
                   "AND e.reseller_id = '$reseller_id' ".
                   "ORDER BY p.disporder");

while ($row = mysql_fetch_array($sql)) {
  foreach($row AS $key => $val) {
    $$key = stripslashes($val);
  }
?>
<li><a href="product.php?product=<? echo $product_id; ?>"><? echo $htmlname; ?></a></li>
<?
}
?>
</ul></td></tr>

</table>

<?
include 'tpl/bot.php';
?>