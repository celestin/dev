<?php
/* * * * * * * * * * * * * * * * * * * * * * * *
 * Talisman WMS Users
 * Copyright (c) 2012 Front Burner
 *
 * Save User
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  24-Nov-2012  11137 : File created.
 * * * * * * * * * * * * * * * * * * * * * * * */

$title = "Search Users";
include 'tpl/top.php';
$member = NULL;  if (isset($_SESSION['member_person'])) $member = $_SESSION['member_person'];
$loggedin = (isset($_SESSION['member_person']) && isset($_SESSION['Talisman WMS Users']));

$username = NULL;        if (!empty($_POST['username'])) $username = $_POST['username'];
$edit_status = NULL;     if (!empty($_POST['edit_status'])) $edit_status = $_POST['edit_status'];
$edit_site = NULL;       if (!empty($_POST['edit_site'])) $edit_site = $_POST['edit_site'];
$edit_firstname = NULL;  if (!empty($_POST['edit_firstname'])) $edit_firstname = $_POST['edit_firstname'];
$edit_lastname = NULL;   if (!empty($_POST['edit_lastname'])) $edit_lastname = $_POST['edit_lastname'];
$edit_email = NULL;      if (!empty($_POST['edit_email'])) $edit_email = $_POST['edit_email'];
$edit_jobtitle = NULL;   if (!empty($_POST['edit_jobtitle'])) $edit_jobtitle = $_POST['edit_jobtitle'];
$edit_jtcomments = NULL; if (!empty($_POST['edit_jtcomments'])) $edit_jtcomments = $_POST['edit_jtcomments'];

if ($loggedin && $member->isAdmin()) {
} else {
  redirect($cfg['Site']['URL']);
  exit();
}

$sql =
  "UPDATE usr ".
  "SET work_email='$edit_email'" .
  (!empty($edit_site) ? ", site='$edit_site' " : "").
  (!empty($edit_firstname) ? ", first_name='$edit_firstname' " : "").
  (!empty($edit_lastname) ? ", last_name='$edit_lastname' " : "").
  (!empty($edit_jobtitle) ? ", job_title='$edit_jobtitle' " : "").
  ", job_title_comments='$edit_jtcomments' ".
  "WHERE username='$username'";

$res = mysql_query($sql) or die (mysql_error());
if (mysql_affected_rows()>0) {
	echo "$username confirmed";
  //echo $sql;
} else {
	echo "No data updated";
}

redirect("search.php");
include 'tpl/bot.php';
?>