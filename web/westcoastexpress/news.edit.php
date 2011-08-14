<?
/* * * * * * * * * * * * * * * * * * * * * * * *
 * Carried Safely Website
 * Copyright (c) 2007 Frontburner
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * News Item Creation
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  11-Aug-2007  10153 : File created.
 * * * * * * * * * * * * * * * * * * * * * * * */

$title = "Edit News Item";
include_once 'Main.php';
include 'tpl/top.php';

function retry_create($error="") {
  global $newsitem_id, $news_date, $newsitem, $news_text, $retry, $form_action, $form_button;
  if (!empty($error)) Msg::error($error);
  include 'frm/news.edit.php';
  include 'tpl/bot.php';
  exit();
}

$newsitem_id = NULL;      if (!empty($_GET['newsitem_id'])) $newsitem_id = $_GET['newsitem_id'];

$news_date = NULL;
$newsitem = NULL;
$news_text = NULL;
$retry = NULL;

if (!empty($newsitem_id)) {
  // Must be the initial Edit - retrieve details
  $ssql = "SELECT id newsitem_id, newsitem, DATE_FORMAT(news_date,'%d-%b-%Y') news_date, news_text ".
          "FROM newsitems ".
          "WHERE id = '$newsitem_id'";
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
  if (!empty($_POST['newsitem_id'])) $newsitem_id = $_POST['newsitem_id'];
  if (!empty($_POST['news_date'])) $news_date = $_POST['news_date'];
  if (!empty($_POST['newsitem'])) $newsitem = $_POST['newsitem'];
  if (!empty($_POST['news_text'])) $news_text = $_POST['news_text'];
  if (!empty($_POST['retry'])) $retry = $_POST['retry'];
}

$form_action = "news.edit.php";
$form_button = "Edit";

if (!$retry) {
  retry_create();
} else if (!$news_date) {
  retry_create("You must specify a date for the News item.");
} else if (!$newsitem) {
  retry_create("You must enter a Title for the News item.");
} else if (!$news_text) {
  retry_create("You must enter the text of the News item.");
} else {
echo "<h3>!!!!</h3>";
  storeFlash("News Item <b>$news_date - $newsitem</b> edited.");

  $news_date = Util::displayToSqlDate($news_date);
  $newsitem = Util::textToSql($newsitem);
  $news_text = Util::textToSql($news_text);

  $ssql = "UPDATE newsitems SET ".
            "news_date = '$news_date',".
            "newsitem = '$newsitem',".
            "news_text = '$news_text' ".
          "WHERE id = '$newsitem_id'";
  $sql = mysql_query($ssql);

  redirect("index.php");
}

?>

