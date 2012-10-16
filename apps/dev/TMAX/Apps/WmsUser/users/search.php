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
 * CAM  14-Oct-2012  11136 : Reduced size of Search input boxes, stored Filter in session and added Security Group.
 * CAM  14-Oct-2012  11142 : Improved search: added clear and email.
 * * * * * * * * * * * * * * * * * * * * * * * */

$title = "Search Users";
include 'tpl/top.php';
$member = NULL;  if (isset($_SESSION['member_person'])) $member = $_SESSION['member_person'];
$loggedin = (isset($_SESSION['member_person']) && isset($_SESSION['Talisman WMS Users']));

$search_status = NULL;
if (!empty($_SESSION['search_status1']) && $_SESSION['search_status1'] != "*" && empty($_POST['search_clear'])) $search_status = $_SESSION['search_status1'];
if (!empty($_POST['search_status']) && empty($_POST['search_clear'])) { $search_status = $_POST['search_status']; }

$search_site = NULL;
if (!empty($_SESSION['search_site1']) && $_SESSION['search_site1'] != "*" && empty($_POST['search_clear'])) $search_site = $_SESSION['search_site1'];
if (!empty($_POST['search_site']) && empty($_POST['search_clear'])) { $search_site = $_POST['search_site']; }

$search_jobtitle = NULL;
if (!empty($_SESSION['search_jobtitle1']) && $_SESSION['search_jobtitle1'] != "*" && empty($_POST['search_clear'])) $search_jobtitle = $_SESSION['search_jobtitle1'];
if (!empty($_POST['search_jobtitle']) && empty($_POST['search_clear'])) { $search_jobtitle = $_POST['search_jobtitle']; }

$search_username = NULL;
if (!empty($_SESSION['search_username1']) && empty($_POST['search_clear'])) $search_username = $_SESSION['search_username1'];
if (!empty($_POST['search_username']) && empty($_POST['search_clear'])) { $search_username = $_POST['search_username']; }

$search_firstname = NULL;
if (!empty($_SESSION['search_firstname1']) && empty($_POST['search_clear'])) $search_firstname = $_SESSION['search_firstname1'];
if (!empty($_POST['search_firstname']) && empty($_POST['search_clear'])) { $search_firstname = $_POST['search_firstname']; }

$search_lastname = NULL;
if (!empty($_SESSION['search_lastname1']) && empty($_POST['search_clear'])) $search_lastname = $_SESSION['search_lastname1'];
if (!empty($_POST['search_lastname']) && empty($_POST['search_clear'])) { $search_lastname = $_POST['search_lastname']; }

$search_group = NULL;
if (isset($_SESSION['search_group1']) && empty($_POST['search_clear'])) $search_group = $_SESSION['search_group1'];
if (!empty($_POST['search_group']) && empty($_POST['search_clear'])) { $search_group = $_POST['search_group']; }

$search_workemail = NULL;
if (isset($_SESSION['search_workemail1']) && empty($_POST['search_clear'])) $search_workemail = $_SESSION['search_workemail1'];
if (!empty($_POST['search_workemail']) && empty($_POST['search_clear'])) { $search_workemail = $_POST['search_workemail']; }

$_SESSION['search_status1'] = $search_status;
$_SESSION['search_site1'] = $search_site;
$_SESSION['search_jobtitle1'] = $search_jobtitle;
$_SESSION['search_username1'] = $search_username;
$_SESSION['search_firstname1'] = $search_firstname;
$_SESSION['search_lastname1'] = $search_lastname;
$_SESSION['search_group1'] = $search_group;
$_SESSION['search_workemail1'] = $search_workemail;

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
	  <option value="*">&lt;ANY&gt;</option>
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
    <th>Group</th>
    <th>Job Title</th>
    <th>Email</th>
    <th>Action</th>
  </tr>

  <tr>
    <td><? searchCombo('search_status', $search_status, 'status', 'status', 'status', 'disporder'); ?></td>
    <td><? searchCombo('search_site', $search_site, 'site', 'site', 'sitefullname', 'sitefullname'); ?></td>
    <td><input size="8" id="search_username" name="search_username" value="<?=$search_username?>"></td>
    <td><input size="8" id="search_firstname" name="search_firstname" value="<?=$search_firstname?>"></td>
    <td><input size="8" id="search_lastname" name="search_lastname" value="<?=$search_lastname?>"></td>
    <td><input size="8" id="search_group" name="search_group" value="<?=$search_group?>"></td>
    <td><? searchCombo('search_jobtitle', $search_jobtitle, 'job_title', 'job_title', 'job_title', 'job_title'); ?></td>
    <td><input size="8" id="search_workemail" name="search_workemail" value="<?=$search_workemail?>"></td>
    <td align="center"><input type="checkbox" id="search_clear" name="search_clear" value="Y"><input class="button" type="submit" value="Go!"></td>
  </tr>

<?
  $filter = "";
  $status_filter = FALSE;
  if (!empty($search_status) && $search_status != "*") {
	  $filter .= (empty($filter) ? "": "AND ") . "u.status='".$search_status."' ";
    $status_filter = TRUE;
  }
  if (!empty($search_site) && $search_site != "*")           $filter .= (empty($filter) ? "": "AND ") . "u.site='".$search_site."' ";
  if (!empty($search_jobtitle) && $search_jobtitle != "*")   $filter .= (empty($filter) ? "": "AND ") . "u.job_title='".$search_jobtitle."' ";
  if (!empty($search_username))                              $filter .= (empty($filter) ? "": "AND ") . "u.username LIKE '%".$search_username."%' ";
  if (!empty($search_firstname))                             $filter .= (empty($filter) ? "": "AND ") . "u.first_name LIKE '%".$search_firstname."%' ";
  if (!empty($search_lastname))                              $filter .= (empty($filter) ? "": "AND ") . "u.last_name LIKE '%".$search_lastname."%' ";
  if (!empty($search_workemail))                             $filter .= (empty($filter) ? "": "AND ") . "u.work_email LIKE '%".$search_workemail."%' ";
  if (!empty($search_group))                                 $filter .= (empty($filter) ? "": "AND ") . "u.current_group LIKE '%".$search_group."%' ";

  $where = "WHERE ";
  if (empty($filter)) {
  	$where .= " u.username IS NULL ";
  } else {
    if (!$status_filter) $filter .= "AND u.status<>'System' ";
    $where .= $filter;
  }

  $ssql =
    "SELECT u.status, s.SiteFullName, u.username, u.first_name, u.last_name, u.current_group, u.job_title, u.work_email ".
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
      <td><?=nvhtml($row[6])?></td>
      <td><?=nvhtml($row[7])?></td>
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