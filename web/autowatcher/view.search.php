<?
/* * * * * * * * * * * * * * * * * * * * * * * *
 * Create a new search
 * Copyright (c) 2006 frontburner.co.uk
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  30-Sep-2006  File created.
 * * * * * * * * * * * * * * * * * * * * * * * */

$title = "My Searches";
include_once 'Main.php';
include 'tpl/top.php';

$sql = "SELECT id, make, model, variant, keywords, min_pr, max_pr, mileage, agerange, postcode, miles, source ".
       "FROM autosearch WHERE memberid = '". $member->getId() . "'";
$res = mysql_query($sql) or die (mysql_error());
?>
<table border=1 cellpadding=5 cellspacing=0>

  <tr>
    <th>Action</th>
    <th>Make</th>
    <th>Model</th>
    <th>Trim</th>
    <th>Keywords</th>
    <th>Min. Price</th>
    <th>Max. Price</th>
    <th>Mileage</th>
    <th>Age</th>
    <th>Postcode</th>
    <th>Miles</th>
    <th>Seller Type</th>
  </tr>
<?
while ($row = mysql_fetch_array($res)) {
  foreach($row AS $key => $val) {
    $$key = stripslashes($val);
  }
?>

  <tr>
    <td><a href="refresh.php?search=<? echo $id; ?>">Refresh</a>&nbsp;|&nbsp;<a href="new.search.php?search=<? echo $id; ?>">Edit</a></td>
    <td><? echo $make; ?></td>
    <td><? echo $model; ?></td>
    <td><? echo $variant; ?></td>
    <td><? echo $keywords; ?></td>
    <td><? echo $min_pr; ?></td>
    <td><? echo $max_pr; ?></td>
    <td><? echo $mileage; ?></td>
    <td><? echo $agerange; ?></td>
    <td><? echo $postcode; ?></td>
    <td><? echo $miles; ?></td>
    <td><? echo $source; ?></td>
  </tr>
<?
}

include 'tpl/bot.php';
?>

