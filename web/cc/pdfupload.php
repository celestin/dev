<?
/* * * * * * * * * * * * * * * * * * * * * * * *
 * PDF file upload
 * Copyright (c) 2005 frontburner.co.uk
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  27-Dec-2005  File created.
 * CAM  09-Sep-2007  Added chmod.
 * * * * * * * * * * * * * * * * * * * * * * * */

$title = "Register";
include_once 'Main.php';
include 'tpl/top.php';

$documentdate = NULL;         if (!empty($_POST['documentdate'])) $documentdate = $_POST['documentdate'];
$documenttype = NULL;         if (!empty($_POST['documenttype'])) $documenttype = $_POST['documenttype'];
$pdffilename = NULL;      if (!empty($_FILES['pdffile']['name'])) $pdffilename = $_FILES['pdffile']['name'];
$retry = NULL;            if (!empty($_POST['retry'])) $retry = $_POST['retry'];

if (empty($retry)) {
  include 'frm/pdf.upload.php';
} else if (empty($documentdate)) {
  Msg::error("Please enter the Document date.");
  include 'frm/pdf.upload.php';
} else if (empty($pdffilename)) {
  Msg::error("Please enter PDF filename.");
  include 'frm/pdf.upload.php';
} else {

  $uploaddir = $cfg['Site']['Dir'] . 'pdf/';
  $uploadbase = basename($_FILES['pdffile']['name']);
  if ($documenttype == "L") {
    $uploadbase = date("Y_m", strtotime($documentdate)) . ".pdf";
  }

  $uploadfile = $uploaddir . $uploadbase;

  //$mdocumentdate = mdate($documentdate);

  if (move_uploaded_file($_FILES['pdffile']['tmp_name'], $uploadfile)) {

    chmod($uploadfile, 644);

    Msg::statement("File successfully uploaded.");

    $ssql = "REPLACE INTO pdf (pdffile, docdate, doctype) VALUES ".
            "('$uploadbase', '" . mdate($documentdate) . "', '$documenttype') ";
    $sql = mysql_query($ssql) or die (mysql_error());

  } else {
    Msg::statement("Possible file upload attack! (only upload PDF files)");
  }
}

include "tpl/bot.php";
?>

