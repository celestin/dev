<?php
/* * * * * * * * * * * * * * * * * * * * * * * *
 * Talisman WMS Users
 * Copyright (c) 2012 Front Burner
 *
 * Search Users
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  08-Oct-2012  11128 : File created.
 * * * * * * * * * * * * * * * * * * * * * * * */

$title = "Search Users";
include 'tpl/top.php';
$member = NULL;  if (session_is_registered('member_person')) $member = $_SESSION['member_person'];
$loggedin = (session_is_registered('member_person') && session_is_registered('Talisman WMS Users'));

$search_status = NULL;        if (!empty($_POST['search_status'])) $search_status = $_POST['search_status'];
$search_site = NULL;          if (!empty($_POST['search_site'])) $search_site = $_POST['search_site'];
$search_jobtitle = NULL;      if (!empty($_POST['search_jobtitle'])) $search_jobtitle = $_POST['search_jobtitle'];
$search_username = NULL;      if (!empty($_POST['search_username'])) $search_username = $_POST['search_username'];
$search_firstname = NULL;     if (!empty($_POST['search_firstname'])) $search_firstname = $_POST['search_firstname'];
$search_lastname = NULL;      if (!empty($_POST['search_lastname'])) $search_lastname = $_POST['search_lastname'];

?>
<script language="Javascript">
</script>
<?

if ($loggedin && $member->isAdmin()) {
} else {
  redirect($cfg['Site']['URL']);
  exit();
}

function searchCombo($fieldName, $currentValue, $table, $codeField, $descField, $sortField) {
	$ssql = "SELECT $codeField, $descField ".
			"FROM $table ".
			"ORDER BY $sortField";
?>
	<select id="<?=$fieldName?>" name="<?=$fieldName?>">
	  <option value="">&lt;ANY&gt;</option>
<?	 
	$sql = mysql_query($ssql) or die (mysql_error());
	while ($row = mysql_fetch_array($sql)) {
?>
	  <option value="<?=$row[0]?>" <?=(($currentValue == $row[0]) ? "SELECTED " : "")?>><?=$row[1]?></option>
<?	 
	}
?>
	</select>
<?	 
}
?>

<h1>Search</h1>
<form method="post">
<table border="1" cellpadding="2" cellspacing="0">
  <tr>
    <th>Status</th>
    <th>Site</th>
    <th>Username</th>
    <th>First name</th>
    <th>Last name</th>
    <th>Job Title</th>
    <th>Action</th>
  </tr>

  <tr>
    <td><? searchCombo('search_status', $search_status, 'status', 'status', 'status', 'disporder'); ?></td>
    <td><? searchCombo('search_site', $search_site, 'site', 'site', 'sitefullname', 'sitefullname'); ?></td>
    <td><input size="20" id="search_username" name="search_username" value="<?=$search_username?>"></td>
    <td><input size="20" id="search_firstname" name="search_firstname" value="<?=$search_firstname?>"></td>
    <td><input size="20" id="search_lastname" name="search_lastname" value="<?=$search_lastname?>"></td>
    <td><? searchCombo('search_jobtitle', $search_jobtitle, 'job_title', 'job_title', 'job_title', 'job_title'); ?></td>
    <td align="center"><input class="button" type="submit" value="Go!"></td>
  </tr>
  
<?
  $filter = "";  
  if (!empty($search_status))     $filter .= (empty($filter) ? "": "AND ") . "u.status='".$search_status."' ";
  if (!empty($search_site))       $filter .= (empty($filter) ? "": "AND ") . "u.site='".$search_site."' ";
  if (!empty($search_jobtitle))   $filter .= (empty($filter) ? "": "AND ") . "u.job_title='".$search_jobtitle."' ";
  if (!empty($search_username))   $filter .= (empty($filter) ? "": "AND ") . "u.username LIKE '%".$search_username."%' ";
  if (!empty($search_firstname))  $filter .= (empty($filter) ? "": "AND ") . "u.first_name LIKE '%".$search_firstname."%' ";
  if (!empty($search_lastname))   $filter .= (empty($filter) ? "": "AND ") . "u.last_name LIKE '%".$search_lastname."%' ";

  $where = "WHERE ";  
  if (empty($filter)) {
	$where .= " u.username IS NULL ";
  } else {
    $where .= $filter;
  }

  $ssql =
    "SELECT u.status, s.SiteFullName, u.username, u.first_name, u.last_name, u.job_title ".
    "FROM usr u ".
    "LEFT OUTER JOIN site s ON s.site = u.site ".
	$where .
    "ORDER BY last_name, first_name, username";
  $sql = mysql_query($ssql) or die (mysql_error());

  while ($row = mysql_fetch_array($sql)) {
?>
    <tr>
      <td><?=nvhtml($row[0])?></td>
      <td><?=nvhtml($row[1])?></td>
      <td><?=nvhtml($row[2])?></td>
      <td><?=nvhtml($row[3])?></td>
      <td><?=nvhtml($row[4])?></td>
      <td><?=nvhtml($row[5])?></td>
      <td align="center"><?
	  if ($member->isAdmin()) {
	    ?><a href="edituser.php?username=<?=$row[2]?>"><img border="0" src="img/edit.png"></a><?
	  }	else {
	    ?>&nbsp;<?
	  }
	  ?></td>
	</tr>
    <?
  }

?>
</table>
</form>
<?
include 'tpl/bot.php';
?>