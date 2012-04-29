<?
/* * * * * * * * * * * * * * * * * * * * * * * *
 * Sirdar - iKnit
 * Copyright (c) 2010 Frontburner
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * Ajax save of yarns and shades.
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  28-Oct-2010  10800  File created.
 * CAM  23-Nov-2010  10823  Added Sirdar leaflets
 * CAM  28-Jul-2011  10998  Added ChangeDate.
 * * * * * * * * * * * * * * * * * * * * * * * */

include 'sirdar.db.php';

$yarn_code = "";  if (!empty($_GET['yarn_code'])) $yarn_code = $_GET['yarn_code'];
$sub_type = "";  if (!empty($_GET['sub_type'])) $sub_type = $_GET['sub_type'];
$sub_code = "";  if (!empty($_GET['sub_code'])) $sub_code = $_GET['sub_code'];
$status = "";  if (!empty($_GET['status'])) $status = $_GET['status'];


$table_name = "sirdar_yarn";
$status_name = "yarn_status";
if ($sub_type == 'Shade') {
  $table_name = "sirdar_yarn_shade";
  $status_name = "shade_status";
} elseif ($sub_type == 'Leaflet') {
  $table_name = "sirdar_yarn_leaflet";
  $status_name = "leaflet_status";
}

$ssql =
  "UPDATE $table_name ".
  "SET $status_name='$status', ".
  "changedate=NOW() ".
  "WHERE yarn_code='$yarn_code' ";

if ($sub_type == 'Shade') {
  $ssql .=
    "AND shade_code='$sub_code' ";
} elseif ($sub_type == 'Leaflet') {
  $ssql .=
    "AND leaflet_code='$sub_code' ";
}

$sql = mysql_query($ssql);

echo "Saved.";

//echo $ssql;

?>