<?
/* * * * * * * * * * * * * * * * * * * * * * * *
 * File upload
 * Copyright (c) 2006 frontburner.co.uk
 *
 * $Log: /web/maia/fileupload.php $
 * 
 * 2     3/02/06 20:42 Craig
 *
 * 1     3/02/06 1:52 Craig
 * 1000
 *
 * Who  When         Why
 * CAM  02-Feb-2006  File created.
 * * * * * * * * * * * * * * * * * * * * * * * */

$title = "Register";
include_once 'Main.php';
include 'tpl/top.php';

$documentdate = NULL;     if (!empty($_POST['documentdate'])) $documentdate = $_POST['documentdate'];
$documenttype = NULL;     if (!empty($_POST['documenttype'])) $documenttype = $_POST['documenttype'];
$uplfilename = NULL;      if (!empty($_FILES['uplfile']['name'])) $uplfilename = $_FILES['uplfile']['name'];
$retry = NULL;            if (!empty($_POST['retry'])) $retry = $_POST['retry'];

if (empty($retry)) {
  include 'frm/file.upload.php';
} else if (empty($documentdate)) {
  Msg::error("Please enter the Document date.");
  include 'frm/file.upload.php';
} else if (empty($uplfilename)) {
  Msg::error("Please enter filename.");
  include 'frm/file.upload.php';
} else {

  $uploaddir = $cfg['Site']['Dir'] . 'pdf/';
  $uploadbase = basename($_FILES['uplfile']['name']);
  if ($documenttype == "L") {
    $uploadbase = date("Y_m", strtotime($documentdate)) . ".pdf";
  }

  $uploadfile = $uploaddir . $uploadbase;

  //$mdocumentdate = mdate($documentdate);

  if (move_uploaded_file($_FILES['uplfile']['tmp_name'], $uploadfile)) {
    Msg::statement("File successfully uploaded.");

    $ssql = "REPLACE INTO upload (uplfile, docdate, doctype) VALUES ".
            "('$uploadbase', '" . mdate($documentdate) . "', '$documenttype') ";
    $sql = mysql_query($ssql) or die (mysql_error());

  } else {
    Msg::statement("Possible file upload attack! (only upload PDF files)");
  }
}

include "tpl/bot.php";
?>

