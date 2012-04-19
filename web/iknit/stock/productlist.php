<?
/* * * * * * * * * * * * * * * * * * * * * * * *
 * EPOS Interface - Lovie's Yarns (loviesyarn.com)
 * Copyright (c) 2011 Frontburner
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * Product List Web Service
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  27-Aug-2011  10925  Created file.
 * * * * * * * * * * * * * * * * * * * * * * * */

include '../includes/configure.php';

$con = mysql_connect(DB_SERVER,DB_SERVER_USERNAME,DB_SERVER_PASSWORD) or die('Could not connect: ' . mysql_error());
mysql_select_db(DB_DATABASE, $con);


$search = "";  if (!empty($_GET['search'])) $search = $_GET['search'];
$barcode = "";  if (!empty($_GET['barcode'])) $barcode = $_GET['barcode'];
$txtId = "";  if (!empty($_GET['txtid'])) $txtId = $_GET['txtid'];

$search = "%" . str_replace(" ", "%", $search) . "%";
$search = str_replace("%%", "%", $search);

$sql =
  "SELECT p.products_id, p.products_model, p.products_image, REPLACE(pd.products_name, '''', '') ".
  "FROM products p, products_description pd ".
  "WHERE pd.products_id = p.products_id ".
  "AND (pd.products_name LIKE '$search' OR p.products_model LIKE '$search') " .
  "ORDER BY 4";

$res = mysql_query($sql) or die (mysql_error());
while ($row = mysql_fetch_array($res)) {
  echo "<li><a href=\"javascript:void(0);\" onclick=\"confirmproduct('$txtId', '$barcode', '$row[0]', '$row[1]', '$row[2]', '$row[3]');return false;\">" . $row[3] . "</a></li>\n";
}

?>