<?
/* * * * * * * * * * * * * * * * * * * * * * * *
 * Create a new search
 * Copyright (c) 2006 frontburner.co.uk
 *
 * $Id: login.php 263 2006-09-30 20:31:40Z craig $
 *
 * Who  When         Why
 * CAM  30-Sep-2006  File created.
 * * * * * * * * * * * * * * * * * * * * * * * */

$title = "New Search";
include_once 'Main.php';
include 'tpl/top.php';

function retry_login($error='') {
  global $memberid;
  if (!empty($error)) Msg::error($error);
  include 'frm/search.add.php';
  include 'tpl/bot.php';
  exit();
}

$sort = NULL;           if (!empty($_POST['sort'])) $sort = $_POST['sort'];
$max_records = NULL;    if (!empty($_POST['max_records'])) $max_records = $_POST['max_records'];
$make = NULL;           if (!empty($_POST['make'])) $make = $_POST['make'];
$model = NULL;          if (!empty($_POST['model'])) $model = $_POST['model'];
$variant = NULL;        if (!empty($_POST['variant'])) $variant = $_POST['variant'];
$keywords = NULL;       if (!empty($_POST['keywords'])) $keywords = $_POST['keywords'];
$min_pr = NULL;         if (!empty($_POST['min_pr'])) $min_pr = $_POST['min_pr'];
$max_pr = NULL;         if (!empty($_POST['max_pr'])) $max_pr = $_POST['max_pr'];
$mileage = NULL;        if (!empty($_POST['mileage'])) $mileage = $_POST['mileage'];
$agerange = NULL;       if (!empty($_POST['agerange'])) $agerange = $_POST['agerange'];
$postcode = NULL;       if (!empty($_POST['postcode'])) $postcode = $_POST['postcode'];
$miles = NULL;          if (!empty($_POST['miles'])) $miles = $_POST['miles'];
$source = NULL;         if (!empty($_POST['source'])) $source = $_POST['source'];
$retry = NULL;          if (!empty($_POST['retry'])) $retry = $_POST['retry'];
$search = NULL;         if (!empty($_GET['search'])) $search = $_GET['search'];

if ($search) {
  $sql = "SELECT make, model, variant, keywords, min_pr, max_pr, mileage, agerange, postcode, miles, source ".
         "FROM autosearch WHERE memberid = '". $member->getId() . "' AND id = '$search'";
  $res = mysql_query($sql) or die (mysql_error());
  if ($row = mysql_fetch_array($res)) {
    foreach($row AS $key => $val) {
      $$key = stripslashes($val);
    }
  }
} else if (!empty($_POST['search'])) {
  $search = $_POST['search'];
}

$form_error = false;

if(!$postcode){
  $form_error = true;
  retry_login('You must specify your postcode');
} else if (!$make && $min_pr<100){
  $form_error = true;
  retry_login('Please select a Make or a Minimum Price');
} else if (!$retry) {
  retry_login();
} else {
  $sql = "REPLACE INTO autosearch ( ".
           "id, memberid, make, model, variant, keywords, min_pr, max_pr, mileage, agerange, postcode, miles, source ".
           ") VALUES (".
           "'$search', '" . $member->getId() . "', '$make', '$model', '$variant', '$keywords', '$min_pr', '$max_pr', '$mileage', '$agerange', '$postcode', '$miles', '$source' ".
           ")";
  $res = mysql_query($sql) or die (mysql_error());

?>
<script language="javascript">top.location.href="view.search.php";</script>
<?
}

include 'tpl/bot.php';
?>

