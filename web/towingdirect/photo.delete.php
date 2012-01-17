<?
/* * * * * * * * * * * * * * * * * * * * * * * *
 * TowingDirect Website
 * Copyright (c) 2012 Front Burner
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * Delete a Photo.
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  11-Aug-2007  10149 : File created.
 * * * * * * * * * * * * * * * * * * * * * * * */

$title = "Delete a Photo";
include_once 'Main.php';
include 'tpl/top.php';

$photo_id = NULL;            if (!empty($_GET['photo_id'])) $photo_id = $_GET['photo_id'];
$areyousure = NULL;          if (!empty($_GET['areyousure'])) $areyousure = $_GET['areyousure'];

if ($loggedin && $member->isAdmin()) {
  // Proceed
} else {
  storeFlash("You do not have permission to delete photos!");
  redirect("photos.php");
}

$ssql = "SELECT id photo_id,photo,boat,location ".
        "FROM photos ".
        "WHERE id = '$photo_id'";
$sql = mysql_query($ssql) or die (mysql_error());
if ($row = mysql_fetch_array($sql)) {
  foreach($row AS $key => $val) {
    $$key = stripslashes($val);
  }
} else {
  redirect("photos.php");
}

$flashMsg = "Photo $photo - <b>$boat</b> deleted.<br>";

if(!empty($areyousure)){
  $ssql = "DELETE FROM photos WHERE id='$photo_id'";
  $sql = mysql_query($ssql);

  $success = unlink($cfg['Site']['Dir'] . "img/ph/t/$photo");
  if($success=="1") {
    $flashMsg .= "The thumbnail was deleted successfully.<br>";
  } else {
    $flashMsg .= "There was an error trying to delete the thumbnail.<br>";
  }

  $success = unlink($cfg['Site']['Dir'] . "img/ph/f/$photo");
  if($success=="1") {
    $flashMsg .= "The full size photo was deleted successfully.<br>";
  } else {
    $flashMsg .= "There was an error trying to delete the full size photo.<br>";
  }
}

if(empty($areyousure)) {
  echo "<center><img src=\"img/ph/f/$photo\"></center><br />";
  echo "<center>Are you sure you want to delete <b>$boat</b>?</center><br />";
  echo "<center><a href=photo.delete.php?photo_id=$photo_id&areyousure=yes>Yes</a> | <a href=photos.php>No</a>";
} else {
  storeFlash($flashMsg);
  redirect("photos.php");
}
include 'tpl/bot.php';
?>
