<?
/* * * * * * * * * * * * * * * * * * * * * * * *
 * EPOS Interface - Lovie's Yarns (loviesyarn.com)
 * Copyright (c) 2011 Frontburner
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * Save changes to Product
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  27-Aug-2011  10925  Created file.
 * * * * * * * * * * * * * * * * * * * * * * * */

include '../includes/configure.php';

$con = mysql_connect(DB_SERVER,DB_SERVER_USERNAME,DB_SERVER_PASSWORD) or die('Could not connect: ' . mysql_error());
mysql_select_db(DB_DATABASE, $con);


$pid = "";  if (!empty($_GET['pid'])) $pid = $_GET['pid'];
$barcode = "";  if (!empty($_GET['barcode'])) $barcode = $_GET['barcode'];

$sql =
  "UPDATE products ".
  "SET products_barcode='$barcode' ".
  "WHERE products_id='$pid'";

$res = mysql_query($sql) or die (mysql_error());
if (mysql_affected_rows()>0) {
	echo "Saved.";
} else {
	echo "No data updated.";
}

?>