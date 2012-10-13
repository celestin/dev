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

$username = NULL;        if (!empty($_GET['username'])) $username = $_GET['username'];

?>
<script language="Javascript">
</script>
<?

if ($loggedin && $member->isAdmin()) {
} else {
  redirect($cfg['Site']['URL']);
  exit();
}

function editCombo($fieldName, $currentValue, $table, $codeField, $descField, $sortField) {
	$ssql = "SELECT $codeField, $descField ".
			"FROM $table ".
			"ORDER BY $sortField";
?>
	<select id="<?=$fieldName?>" name="<?=$fieldName?>">
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
  $ssql =
    "SELECT u.status, u.site, u.username, u.first_name, u.last_name, u.job_title ".
    "FROM usr u ".
	"WHERE username='$username' ";
  $sql = mysql_query($ssql) or die (mysql_error());

  if ($row = mysql_fetch_array($sql)) {
?>	

<h1>Edit</h1>
<form method="post">
<table border="1" cellpadding="2" cellspacing="0">
  <tr>
    <td>Username</td>
    <td><?=$row[2]?></td>
  </tr><tr>	
    <td>Status</td>
    <td><? editCombo('search_status', $row[0], 'status', 'status', 'status', 'disporder'); ?></td>
  </tr><tr>	
    <td>Site</td>
    <td><? editCombo('search_site', $row[1], 'site', 'site', 'sitefullname', 'sitefullname'); ?></td>
  </tr><tr>	
    <td>First name</td>
    <td><input size="20" id="search_firstname" name="search_firstname" value="<?=$row[3]?>"></td>
  </tr><tr>	
    <td>Last name</td>
    <td><input size="20" id="search_lastname" name="search_lastname" value="<?=$row[4]?>"></td>
  </tr><tr>	
    <td>Job Title</td>
    <td><? editCombo('search_jobtitle', $row[5], 'job_title', 'job_title', 'job_title', 'job_title'); ?></td>
  </tr><tr>	
    <td>&nbsp;</td>
    <td><input class="button" type="submit" value="Save"></td>
  </tr>

<?
  }
?>
</table>
</form>
<?
include 'tpl/bot.php';
?>