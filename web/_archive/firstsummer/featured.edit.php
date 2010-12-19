<?
/* * * * * * * * * * * * * * * * * * * * * * * *
 * First Summerhouses
 * Copyright (c) 2006-2007 Frontburner
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * Editing of a Featured Product
 *
 * $Id: news.edit.php 310 2006-10-10 21:31:17Z craig $
 *
 * Who  When         Why
 * CAM  13-Feb-2007  10079 : File created.
 * * * * * * * * * * * * * * * * * * * * * * * */

$title = "Edit Featured Product";
include_once 'Main.php';
include 'tpl/top.php';

function retry_create($error="") {
  global $feature_id, $product_id, $product, $description, $price, $feature, $retry, $form_action, $form_button;
  if (!empty($error)) Msg::error($error);
  include 'frm/featured.edit.php';
  include 'tpl/bot.php';
  exit();
}

$feature_id = NULL;      if (!empty($_GET['feature_id'])) $feature_id = $_GET['feature_id'];

$product_id = NULL;
$product = NULL;
$description = NULL;
$price = NULL;
$feature = NULL;
$retry = NULL;

if (!empty($feature_id)) {
  // Must be the initial Edit - retrieve details
  $ssql = "SELECT id feature_id, product_id, product, description, price, feature ".
          "FROM featuredproducts ".
          "WHERE id = '$feature_id'";
  $sql = mysql_query($ssql) or die (mysql_error());
  if ($row = mysql_fetch_array($sql)) {
    foreach($row AS $key => $val) {
      $$key = stripslashes($val);
    }
  } else {
    redirect("index.php");
  }
} else {
  // Must be after an Edit - used edited details
  if (!empty($_POST['feature_id'])) $feature_id = $_POST['feature_id'];
  if (!empty($_POST['product_id'])) $product_id = $_POST['product_id'];
  if (!empty($_POST['product'])) $product = $_POST['product'];
  if (!empty($_POST['description'])) $description = $_POST['description'];
  if (!empty($_POST['price'])) $price = $_POST['price'];
  if (!empty($_POST['feature'])) $feature = $_POST['feature'];
  if (!empty($_POST['retry'])) $retry = $_POST['retry'];
}

$form_action = "featured.edit.php";
$form_button = "Edit";

if (!$retry) {
  retry_create();
} else if (!$product_id) {
  retry_create("You must select a Product to feature.");
} else if (!$product) {
  retry_create("You must name the specific Product variation.");
} else if (!$description) {
  retry_create("You must briefly describe the product.");
} else if (!$feature) {
  retry_create("You must describe the offer.");
} else if (!$price) {
  retry_create("You must specify the minimum Price.");
} else {
  storeFlash("Featured Product <b>$product</b> edited.");

  $product = Util::textToSql($product);
  $description = Util::textToSql($description);
  $feature = Util::textToSql($feature);
  $price = Util::textToSql($price);

  $ssql = "UPDATE featuredproducts SET ".
            "product_id = '$product_id',".
            "product = '$product',".
            "description = '$description',".
            "feature = '$feature',".
            "price = '$price' ".
          "WHERE id = '$feature_id'";
  //storeFlash($ssql);
  $sql = mysql_query($ssql);

  redirect("index.php");
}

?>

