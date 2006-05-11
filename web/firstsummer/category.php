<?php
/* * * * * * * * * * * * * * * * * * * * * * * *
 * First Summerhouses
 * Copyright (c) 2006 Frontburner
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * Category page
 *
 * $Id: forgot.php 71 2006-05-09 21:09:10Z craig $
 *
 * Who  When         Why
 * CAM  10-Feb-2006  File created.
 * * * * * * * * * * * * * * * * * * * * * * * */

include_once 'Main.php';
if (!isset($ucategory)) {
  $ucategory = NULL;          if (!empty($_GET['category'])) $ucategory = $_GET['category'];
}

$sql = "SELECT c.category category_name, r.range range_name, p.product product_name, h.imgfile rand_img ".
       "FROM photos h, products p, prodranges r, categories c ".
       "WHERE p.id = h.product_id ".
       "AND r.id = p.prodrange_id ".
       "AND c.id = r.category_id ".
       "AND c.id = '$ucategory' ".
       "ORDER BY rand() ".
       "LIMIT 1";

$sql2 = mysql_query($sql);
if ($row2 = mysql_fetch_array($sql2)) {
  foreach($row2 AS $key2 => $val) {
    $$key2 = stripslashes($val);
  }
}

$title = "$category_name Category";
include 'tpl/top.php';

?>
<table border=0>
<tr>
  <td><h3><? echo $category_name; ?></h3></td>
</tr><tr>
  <td><img height=376 src="img/g/f/<? echo $rand_img; ?>"></td>
</tr>
</table>
<?

include 'tpl/bot.php';
?>