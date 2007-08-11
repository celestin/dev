<?
/* * * * * * * * * * * * * * * * * * * * * * * *
 * West Coast Express Website
 * Copyright (c) 2006-2007 Frontburner
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * Photo upload
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  13-Apr-2006  File created.
 * CAM  17-Dec-2006  10068 : Enable uploading of new photos.
 * * * * * * * * * * * * * * * * * * * * * * * */

$title = "Register";
include_once 'Main.php';
include 'tpl/top.php';

$uplfilename = NULL;      if (!empty($_FILES['uplfile']['name'])) $uplfilename = $_FILES['uplfile']['name'];
$retry = NULL;            if (!empty($_POST['retry'])) $retry = $_POST['retry'];


/*
  Function createthumb($name,$filename,$new_w,$new_h)
  creates a resized image
  variables:
  $name   Original filename
  $filename Filename of the resized image
  $new_w    width of resized image
  $new_h    height of resized image
*/
function createthumb2($name,$filename,$new_w,$new_h) {
  $system=explode(".",$filename);
  $src_img=null;
  if (preg_match("/jpg|jpeg/",$system[1])){$src_img=imagecreatefromjpeg($name);}
  if (preg_match("/png/",$system[1])){$src_img=imagecreatefrompng($name);}
  $old_x=imageSX($src_img);
  $old_y=imageSY($src_img);
  if ($old_x > $old_y)
  {
    $thumb_w=$new_w;
    $thumb_h=$old_y*($new_h/$old_x);
  }
  if ($old_x < $old_y)
  {
    $thumb_w=$old_x*($new_w/$old_y);
    $thumb_h=$new_h;
  }
  if ($old_x == $old_y)
  {
    $thumb_w=$new_w;
    $thumb_h=$new_h;
  }
  $dst_img=ImageCreateTrueColor($thumb_w,$thumb_h);
  imagecopyresampled($dst_img,$src_img,0,0,0,0,$thumb_w,$thumb_h,$old_x,$old_y);
  if (preg_match("/png/",$system[1])) {
    imagepng($dst_img,$filename);
  } else {
    imagejpeg($dst_img,$filename);
  }
  imagedestroy($dst_img);
  imagedestroy($src_img);
}

function createSquareThumb($name,$filename,$new_size) {
  $system=explode(".",$filename);
  $src_img=null;

  $png = preg_match("/png/",$system[1]);

  if ($png) {
    $src_img=imagecreatefrompng($name);
  } else {
    $src_img=imagecreatefromjpeg($name);
  }

  $old_x=imageSX($src_img);
  $old_y=imageSY($src_img);
  $dst_x=$dst_y=0;
  if ($old_x < $old_y)
  {
    $thumb_w=$new_size;
    $thumb_h=$old_y*($new_size/$old_x);
    $dst_y=($new_size-$thumb_h)/2;
  }
  if ($old_x > $old_y)
  {
    $thumb_w=$old_x*($new_size/$old_y);
    $thumb_h=$new_size;
    $dst_x=($new_size-$thumb_w)/2;
  }
  if ($old_x == $old_y)
  {
    $thumb_w=$new_size;
    $thumb_h=$new_size;
  }

  $dst_img=ImageCreateTrueColor($new_size,$new_size);
  imagecopyresampled($dst_img,$src_img,$dst_x,$dst_y,0,0,$thumb_w,$thumb_h,$old_x,$old_y);
  if ($png) {
    imagepng($dst_img,$filename);
  } else {
    imagejpeg($dst_img,$filename);
  }
  imagedestroy($dst_img);
  imagedestroy($src_img);
}

function createFullsize($name,$filename,$new_w) {
  $system=explode(".",$filename);
  $src_img=null;

  $png = preg_match("/png/",$system[1]);
  if ($png) {
    $src_img=imagecreatefrompng($name);
  } else {
    $src_img=imagecreatefromjpeg($name);
  }

  $old_x=imageSX($src_img);
  $old_y=imageSY($src_img);
  $thumb_w=$new_w;
  $thumb_h=$old_y*($new_w/$old_x);

  $dst_img=ImageCreateTrueColor($thumb_w,$thumb_h);
  imagecopyresampled($dst_img,$src_img,0,0,0,0,$thumb_w,$thumb_h,$old_x,$old_y);
  if ($png) {
    imagepng($dst_img,$filename);
  } else {
    imagejpeg($dst_img,$filename);
  }
  imagedestroy($dst_img);
  imagedestroy($src_img);
}


if (!($loggedin && $member->isAdmin())) {
  Msg::error("Sorry, only Admin users can upload new photos.");
  exit();
}

if (empty($uplfilename)) {
  Msg::error("Please enter filename.");
  include 'frm/file.upload.php';
} else {

  $fulldir = $cfg['Site']['Dir'] . "/img/ph/f/";
  $thumbdir = $cfg['Site']['Dir'] . "/img/ph/t/";
  $uploadbase = basename($_FILES['uplfile']['name']);
  $fullfile = $fulldir . $uploadbase;
  $thumbfile = $thumbdir . $uploadbase;

  createSquareThumb($_FILES['uplfile']['tmp_name'], $thumbfile, 80);
  createFullsize($_FILES['uplfile']['tmp_name'], $fullfile, 361);

  Msg::statement("File successfully uploaded.");
?>
<img src="img/ph/f/<? echo $uploadbase; ?>"><?

  $ssql = "REPLACE INTO photos (photo) VALUES ('$uploadbase') ";
  $sql = mysql_query($ssql) or die (mysql_error());

}

include "tpl/bot.php";
?>

