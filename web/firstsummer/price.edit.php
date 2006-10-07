<?php
/* * * * * * * * * * * * * * * * * * * * * * * *
 * First Summerhouses
 * Copyright (c) 2006 Frontburner
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * Price Edit page
 *
 * $Id: range.php 184 2006-07-05 00:15:13Z craig $
 *
 * Who  When         Why
 * CAM  02-Oct-2006  10038 : Make Prices editable.
 * * * * * * * * * * * * * * * * * * * * * * * */

include_once 'Main.php';

$price_id = NULL;      if (!empty($_GET['price_id'])) $price_id = $_GET['price_id'];
                       if (empty($price_id) && (!empty($_POST['price_id']))) $price_id = $_POST['price_id'];
$confirm = NULL;       if (!empty($_POST['confirm'])) $confirm = $_POST['confirm'];
$price = NULL;         if (!empty($_POST['price'])) $price = $_POST['price'];
$product_id = NULL;    if (!empty($_POST['product_id'])) $product_id = $_POST['product_id'];

$title = "Edit Price";
include 'tpl/top.php';

if ($member == NULL || !$member->isAdmin()) {
?>
<script language="javascript">top.location.href="index.php";</script>
<?
}

if (($confirm==='1') && !empty($price)) {

  $sql = "UPDATE prodprices SET price='$price' WHERE id='$price_id'";
  $res = mysql_query($sql);

?>
<script language="javascript">top.location.href="product.php?product=<? echo $product_id; ?>";</script>
<?

} else {

  $sql = mysql_query("SELECT price, product_id ".
                     "FROM prodprices ".
                     "WHERE id ='$price_id'");

  if ($row = mysql_fetch_array($sql)) {
    foreach($row AS $key => $val) {
      $$key = stripslashes($val);
    }

    include 'frm/price.edit.php';
  }
}

include 'tpl/bot.php';
?>