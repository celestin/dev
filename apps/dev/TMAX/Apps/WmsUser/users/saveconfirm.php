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
 * CAM  14-Oct-2012  11136 : Replaced deprecated session_is_registered call.
 * * * * * * * * * * * * * * * * * * * * * * * */

include_once 'Main.php';
$member = NULL;  if (isset($_SESSION['member_person'])) $member = $_SESSION['member_person'];

$username = "";  if (!empty($_GET['username'])) $username = $_GET['username'];
$fname = "";  if (!empty($_GET['fname'])) $fname = $_GET['fname'];
$lname = "";  if (!empty($_GET['lname'])) $lname = $_GET['lname'];
$workemail = "";  if (!empty($_GET['workemail'])) $workemail = $_GET['workemail'];
$jt = "";  if (!empty($_GET['jt'])) $jt = $_GET['jt'];
$jtcom = "";  if (!empty($_GET['jtcom'])) $jtcom = $_GET['jtcom'];

$sql =
  "UPDATE usr ".
  "SET work_email='$workemail'" .
  ", status='Confirmed' ".
  ", cnf_username='" . $member->id . "' ".
  ", cnf_fullname='" . $member->firstname . " " . $member->lastname . "' ".
  ", cnf_datetime=NOW() ".
  (!empty($fname) ? ", first_name='$fname' " : "").
  (!empty($lname) ? ", last_name='$lname' " : "").
  (!empty($jt) ? ", job_title='$jt' " : "").
  (!empty($jtcom) ? ", job_title_comments='$jtcom' " : "").
  "WHERE username='$username'";

$res = mysql_query($sql) or die (mysql_error());
if (mysql_affected_rows()>0) {
	echo "$username confirmed";
  //echo $sql;
} else {
	echo "No data updated";
}

?>