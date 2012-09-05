<?
/* * * * * * * * * * * * * * * * * * * * * * * *
 * Talisman WMS Users
 * Copyright (c) 2012 Front Burner
 *
 * Save Site Changes
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  05-Sep-2012  11128 : User saving and editing.
 * * * * * * * * * * * * * * * * * * * * * * * */

include_once 'Main.php';

$username = "";  if (!empty($_GET['username'])) $username = $_GET['username'];
$site = "";  if (!empty($_GET['site'])) $site = $_GET['site'];
$fname = "";  if (!empty($_GET['fname'])) $fname = $_GET['fname'];
$lname = "";  if (!empty($_GET['lname'])) $lname = $_GET['lname'];

$sql =
  "UPDATE usr ".
  "SET site=". (($site == "UNKNOWN") ? "null" : "'$site' ") .
  (!empty($fname) ? ", first_name='$fname' " : "").
  (!empty($lname) ? ", last_name='$lname' " : "").
  "WHERE username='$username'";

$res = mysql_query($sql) or die (mysql_error());
if (mysql_affected_rows()>0) {
	echo "$username moved to Site $site";
  //echo $sql;
} else {
	echo "No data updated";
}

?>