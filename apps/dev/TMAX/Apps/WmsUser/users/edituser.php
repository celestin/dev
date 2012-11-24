<?php
/* * * * * * * * * * * * * * * * * * * * * * * *
 * Talisman WMS Users
 * Copyright (c) 2012 Front Burner
 *
 * Edit User
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
    "SELECT u.status, u.site, u.username, u.first_name, u.last_name, u.job_title, u.job_title_comments, u.work_email ".
    "FROM usr u ".
	"WHERE username='$username' ";
  $sql = mysql_query($ssql) or die (mysql_error());

  if ($row = mysql_fetch_array($sql)) {
?>

<h1>Edit</h1>
<form method="post" action="saveuser.php">
<table border="0" cellpadding="2" cellspacing="0">
  <tr>
    <td class="lbl">Username</td>
    <td><b><?=$row[2]?></b><input type="hidden" id="username" name="username" value="<?=$row[2]?>"></td>
<!--
    </tr><tr>
    <td>Status</td>
    <td><? editCombo('edit_status', $row[0], 'status', 'status', 'status', 'disporder'); ?></td>
-->
    </tr><tr>
    <td class="lbl">Site</td>
    <td><? editCombo('edit_site', $row[1], 'site', 'site', 'sitefullname', 'sitefullname'); ?></td>
  </tr><tr>
    <td class="lbl">First name</td>
    <td><input size="20" id="edit_firstname" name="edit_firstname" value="<?=$row[3]?>"></td>
  </tr><tr>
    <td class="lbl">Last name</td>
    <td><input size="20" id="edit_lastname" name="edit_lastname" value="<?=$row[4]?>"></td>
  </tr><tr>
    <td class="lbl">Email</td>
    <td><input size="60" id="edit_email" name="edit_email" value="<?=$row[7]?>"></td>
  </tr><tr>
    <td class="lbl">Job Title</td>
    <td><? editCombo('edit_jobtitle', $row[5], 'job_title', 'job_title', 'job_title', 'job_title'); ?></td>
  </tr><tr>
    <td class="lbl">Job Title Comments</td>
    <td><textarea cols="70" rows="5" id="edit_jtcomments" name="edit_jtcomments"><?=$row[6]?></textarea></td>
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