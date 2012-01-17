<?
/* * * * * * * * * * * * * * * * * * * * * * * *
 * TowingDirect Website
 * Copyright (c) 2012 Front Burner
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * Add a new News Item.
 *
 * $Id $
 *
 * Who  When         Why
 * CAM  11-Aug-2007  10153 : File created.
 * * * * * * * * * * * * * * * * * * * * * * * */

$title = "Add News Item";
include_once 'Main.php';
include 'tpl/top.php';

function retry_create($error="") {
  global $newsitem_id, $news_date, $newsitem, $news_text, $retry, $form_action, $form_button;
  if (!empty($error)) Msg::error($error);
  include 'frm/news.edit.php';
  include 'tpl/bot.php';
  exit();
}

$newsitem_id = NULL;     if (!empty($_POST['newsitem_id'])) $newsitem_id = $_POST['newsitem_id'];
$news_date = NULL;       if (!empty($_POST['news_date'])) $news_date = $_POST['news_date'];
$newsitem = NULL;        if (!empty($_POST['newsitem'])) $newsitem = $_POST['newsitem'];
$news_text = NULL;       if (!empty($_POST['news_text'])) $news_text = $_POST['news_text'];
$retry = NULL;           if (!empty($_POST['retry'])) $retry = $_POST['retry'];

$form_action = "news.add.php";
$form_button = "Add";

if (!$retry) {
  retry_create();
} else if (!$news_date) {
  retry_create("You must specify a date for the News item.");
} else if (!$newsitem) {
  retry_create("You must enter a Title for the News item.");
} else if (!$news_text) {
  retry_create("You must enter the text of the News item.");
} else {
  storeFlash("News Item <b>$news_date - $newsitem</b> created.");

  $news_date = Util::displayToSqlDate($news_date);
  $newsitem = Util::textToSql($newsitem);
  $news_text = Util::textToSql($news_text);

  $ssql = "INSERT INTO newsitems (news_date,newsitem,news_text) VALUES ".
          "('$news_date','$newsitem','$news_text')";
  $sql = mysql_query($ssql);

  redirect("index.php");
}

?>

