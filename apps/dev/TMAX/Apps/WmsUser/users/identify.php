<?php
/* * * * * * * * * * * * * * * * * * * * * * * *
 * Talisman WMS Users
 * Copyright (c) 2012 Front Burner
 *
 * Identify Users
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  08-Jul-2012  File created.
 * CAM  05-Sep-2012  11128 : User saving and editing.
 * CAM  13-Oct-2012  11128 : Enable Identify by Supervisor, first requesting 'login' of Firstname/Surname.
 * CAM  14-Oct-2012  11136 : Replaced deprecated session_is_registered call.
 * CAM  16-Oct-2012  11139 : Show Site underneath Email when Confirming users (as a prompt for Admin users to change site if not correct).
 * * * * * * * * * * * * * * * * * * * * * * * */

include_once 'Main.php';
$member = NULL;  if (isset($_SESSION['member_person'])) $member = $_SESSION['member_person'];
$loggedin = (isset($_SESSION['member_person']) && isset($_SESSION['Talisman WMS Users']));

$site = NULL;        if (!empty($_GET['site'])) $site = $_GET['site'];
$username = NULL;    if (!empty($_GET['username'])) $username = $_GET['username'];
$cid = NULL;         if (!empty($_GET['cid'])) $cid = $_GET['cid'];
$firstname = NULL;   if (!empty($_GET['firstname'])) $firstname = $_GET['firstname'];
$lastname = NULL;    if (!empty($_GET['lastname'])) $lastname = $_GET['lastname'];

$member_override = "";
$firstname_override = "";
$lastname_override = "";
$site_override = "";

$showlogin = FALSE;

if ($loggedin) {
  $username = $member->id;
  if ($member->isAdmin()) {
    $site = "";
  } else {
    $site = $_SESSION['siteid'];
  }
} else if (md5($site . $username) == $cid) {
  if ((strlen($firstname) < 2) || (strlen($lastname) < 2)) {
	$showlogin = TRUE;
  } else {
    $member_override = $username;
    $firstname_override = $firstname;
    $lastname_override = $lastname;
	$site_override = $site;
  }
} else {
  redirect($cfg['Site']['URL']);
  exit();
}

$title = "Identify Users";
include 'tpl/top.php';
$member = NULL;  if (isset($_SESSION['member_person'])) $member = $_SESSION['member_person'];
$loggedin = (isset($_SESSION['member_person']) && isset($_SESSION['Talisman WMS Users']));

  if ($showlogin) {
?>
  <h3><?=$username?>, please provide your name to identify users for Site <?=$site?></h3>

  <form action="identify.php" method="get">
  <table border="1">
    <tr>
	  <td>First name</td>
	  <td>Last name</td>
	  <td>
	    <input type="hidden" id="site" name="site" value="<?=$site?>" size="20">
	    <input type="hidden" id="username" name="username" value="<?=$username?>" size="20">
	    <input type="hidden" id="cid" name="cid" value="<?=$cid?>" size="20">
	  </td>
    </tr>
	<tr>
	  <td><input id="firstname" name="firstname" value="<?=$firstname?>" size="20"></td>
	  <td><input id="lastname" name="lastname" value="<?=$lastname?>" size="20"></td>
	  <td><input type="submit" class="button" value="Continue"></td>
    </tr>
  </form>
<?
    exit();
  } else {
  	if (!empty($cid)) redirect($cfg['Site']['URL'] . "/identify.php");
  }
?>
<script language="Javascript">
  function confirm_site(username, rowid, sitecombo, button) {
    var site = getObjRef(sitecombo);
    var row = getObjRef(rowid);

    button.style.display="none";

    saveSiteChange(username, site.options[site.selectedIndex].value, row);
  }

  function validate_workemail(txt) {
    if ((txt.value.indexOf("@") < 0) && (txt.value.length > 0)) txt.value += "@talisman-energy.com";
  }

  function change_site_reveal(rowid_main, rowid_site, username, button) {
    var row_main = getObjRef(rowid_main);
    var row_site = getObjRef(rowid_site);

    row_main.style.display="none";
    row_site.style.display="inline";
  }

  function change_site(rowid_site, username, button) {
    var row_site = getObjRef(rowid_site);
    var fname_txt = getObjRef(username + "_fname");
    var lname_txt = getObjRef(username + "_lname");
    var site = getObjRef(username + "_site");

    button.style.display="none";

    if (window.XMLHttpRequest) {
      xmlhttp=new XMLHttpRequest();
    } else {
      xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
    }
    xmlhttp.onreadystatechange=function()
    {
      if (xmlhttp.readyState==4 && xmlhttp.status==200)
      {
        row_site.style.display = "none";
        //alert(xmlhttp.responseText);
      }
    }
    var url = "savesitechange.php?username=" + username + "&site=" + (site.options[site.selectedIndex].value) +
      "&fname=" + encodeURIComponent(fname_txt.value) + "&lname=" + encodeURIComponent(lname_txt.value);

    xmlhttp.open("GET",url,true);
    xmlhttp.send();
  }

  function confirm_user(rowid_user, rowid_user2, username, button) {
    var row_user = getObjRef(rowid_user);
    var row_user2 = getObjRef(rowid_user2);
    var fname_txt = getObjRef(username + "_fname2");
    var lname_txt = getObjRef(username + "_lname2");
    var workemail_txt = getObjRef(username + "_workemail");
    var jobtitle = getObjRef(username + "_jobtitle");
    var jtcom_txt = getObjRef(username + "_jtcom");

	if ((workemail_txt.value.length < 1) || (workemail_txt.value.indexOf('@') < 0) || (jobtitle.selectedIndex == 0)) {
	  alert('Please specify a valid Email address and Job Title.');
	  return;
	}

    button.style.display="none";

    if (window.XMLHttpRequest) {
      xmlhttp=new XMLHttpRequest();
    } else {
      xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
    }
    xmlhttp.onreadystatechange=function()
    {
      if (xmlhttp.readyState==4 && xmlhttp.status==200)
      {
        row_user.style.display = "none";
        row_user2.style.display = "none";
        //alert(xmlhttp.responseText);
      }
    }
    var url = "saveconfirm.php?username=" + username + "&jt=" + (jobtitle.options[jobtitle.selectedIndex].value) +
      "&fname=" + encodeURIComponent(fname_txt.value) + "&lname=" + encodeURIComponent(lname_txt.value) +
      "&workemail=" + encodeURIComponent(workemail_txt.value) + "&jtcom=" + encodeURIComponent(jtcom_txt.value);

    xmlhttp.open("GET",url,true);
    xmlhttp.send();
  }

  function confirm_user_reveal(rowid_main, rowid_user, rowid_user2, username, button) {
    var row_main = getObjRef(rowid_main);
    var row_user = getObjRef(rowid_user);
    var row_user2 = getObjRef(rowid_user2);

    row_main.style.display="none";
    row_user.style.display="inline";
    row_user2.style.display="inline";
  }

  function saveSiteChange(username, site, row)
  {
    if (window.XMLHttpRequest) {
      xmlhttp=new XMLHttpRequest();
    } else {
      xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
    }
    xmlhttp.onreadystatechange=function()
    {
      if (xmlhttp.readyState==4 && xmlhttp.status==200)
      {
        row.innerHTML = "<td colspan=5><span class=saveok>" + xmlhttp.responseText + "</span></td>";
      }
    }
    xmlhttp.open("GET","savesitechange.php?username=" + username + "&site=" + site,true);
    xmlhttp.send();
  }
</script>
<?

function inputBox($username, $id, $value, $size=20, $validate=false) {
  $fid = $username . "_" . $id;
  $rval = "<input id=\"$fid\" name=\"$fid\" value=\"$value\" size=\"$size\" ";

  if ($validate) {
    $rval .= "onblur=\"validate_" . strtolower($id) . "(this);\" ";
  }

  $rval .= ">";

  echo $rval;
}

function jobTitleCombo($username, $id, $job_title) {
  $fid = $username . "_" . $id;
  $html = "<select id=\"$fid\" name=\"$fid\">";

  $html .= "<option " . (empty($job_title) ? "SELECTED " : "") . "value=\"<NONE>\">&lt;Select Job Title&gt;</option>";

  $ssql =
    "SELECT job_title ".
    "FROM job_title ".
    "ORDER BY job_title";
  $sql = mysql_query($ssql) or die (mysql_error());
  while ($row = mysql_fetch_array($sql)) {
    $selected = "";
    if ($row[0] == $job_title) $selected="SELECTED";

    $html .= "<option $selected value=\"" . $row[0] . "\">" . $row[0] . "</option>";
  }

  $html .= "</select>";
  return $html;
}

function siteCombo($username, $id, $site, $addUnknown) {
  $fid = $username . "_" . $id;
  $html = "<select id=\"$fid\" name=\"$fid\">";

  if ($addUnknown) {
    $html .= "<option value=\"UNKNOWN\">UNKNOWN</option>";
  }

  $ssql =
    "SELECT site, sitefullname ".
    "FROM site ".
    "ORDER BY sitefullname";
  $sql = mysql_query($ssql) or die (mysql_error());
  while ($row = mysql_fetch_array($sql)) {
    $selected = "";
    if ($row[0] == $site) $selected="SELECTED";

    $html .= "<option $selected value=\"" . $row[0] . "\">" . $row[1] . "</option>";
  }

  $html .= "</select>";
  return $html;
}

if (empty($site)) {
?>
<h2>Users normally working in the office (including Apps support), Third-Party or Dales Base</h2>
<?
} else {
?>
<h2>Users normally on an offshore rota on <?=$_SESSION['siteshortname']?></h2>
<p>We believe the users below are normally on an offshore rota on <?=$_SESSION['siteshortname']?> (based on the workorders they have created/edited).
<ul>
<li>If the user is not associated with <?=$_SESSION['siteshortname']?>, please click <b>Change Site</b>, select the correct site (or UNKNOWN).  Click Change Site again
to remove the user from the list.</li>
<li>Click <b>Confirm User</b> to confirm that the user is on <?=$_SESSION['siteshortname']?>, and then enter the GENERIC email address for the role and select
the user's job title from the list.  If there is not an exact match for job title, type some brief job title comments.  Click Confirm User again to confirm
and remove from the list.
</ul></p>
<?
}
?>

<table border="1" cellpadding="2" cellspacing="0">
  <tr>
    <th>Username</th>
    <th>First name</th>
    <th>Surname</th>
    <th>Job title</th>
    <th colspan="2">Actions</th>
  </tr>

<?
  $ssql =
    "select username, first_name, last_name, work_email, company, job_title, job_title_comments, site ".
    "from usr ".
    "where status='Init' ".
    (empty($site) ? "and site in ('00','80','81','83','84','85','86') ": "and site='$site' ").
    "and site <> '82' ". // System
    "order by job_title, last_name, first_name";
  $sql = mysql_query($ssql) or die (mysql_error());

  while ($row = mysql_fetch_array($sql)) {
    $rowid_main = $row[0] . "_a";
    $rowid_site = $row[0] . "_b";
    $rowid_user = $row[0] . "_c";
    $rowid_user2 = $row[0] . "_d";
    $jtcom = $row[0] . "_jtcom";

    $s = Site::getSite($row[7]);
?>
    <tr id="<?=$rowid_main?>">
      <td><?=nvhtml($row[0])?></td>
      <td><?=nvhtml($row[1])?></td>
      <td><?=nvhtml($row[2])?></td>
      <td><?=nvhtml($row[5])?></td>
      <td><input type="button" class="button" onclick="change_site_reveal('<?=$rowid_main?>','<?=$rowid_site?>','<?=$row[0]?>',this);return false;" value="Change Site"></td>
      <td><input type="button" class="button" onclick="confirm_user_reveal('<?=$rowid_main?>','<?=$rowid_user?>','<?=$rowid_user2?>','<?=$row[0]?>',this);return false;" value="Confirm User"></td>
    </tr>

    <tr id="<?=$rowid_site?>" style="display:none">
      <td><b><?=nvhtml($row[0])?></b></td>
      <td><?=inputBox($row[0], "fname", $row[1])?></td>
      <td><?=inputBox($row[0], "lname", $row[2])?></td>
      <td>Site <?=siteCombo($row[0], "site", $row[7], true)?></td>

      <td colspan="2"><input type="button" class="button" onclick="change_site('<?=$rowid_site?>','<?=$row[0]?>',this);return false;" value="Change Site"></td>
    </tr>

    <tr id="<?=$rowid_user?>" style="display:none">
      <td rowspan="2"><b><?=nvhtml($row[0])?></b></td>
      <td><?=inputBox($row[0], "fname2", $row[1])?></td>
      <td><?=inputBox($row[0], "lname2", $row[2])?></td>
      <td><?=jobTitleCombo($row[0], "jobtitle", $row[5], true)?></td>

      <td colspan="2"><input type="button" class="button" onclick="confirm_user('<?=$rowid_user?>','<?=$rowid_user2?>','<?=$row[0]?>',this);return false;" value="Confirm User"></td>
    </tr>

    <tr id="<?=$rowid_user2?>" style="display:none">
      <td colspan="2" valign="top"><b>Email</b><br /><?=inputBox($row[0], "workemail", $row[3], 45, true)?><?
      if ($s != NULL) echo "<br /><br /><b>".$s->shortname."</b>";
      ?></td>
      <td colspan="3"><b>Job Title Comments</b> (e.g. 5th Week resp.)<br /><textarea cols="70" rows="5" id="<?=$jtcom?>" name="<?=$jtcom?>"><?=$row[6]?></textarea></td>
    </tr>

    <?
  }

?>
</table>

<h2>Users whose site is not known</h2>
<?
if (!empty($site)) {
?>
<p>Please click <b>Change Site</b> for those who are normally on an offshore rota on <?=$_SESSION['siteshortname']?>.
<br/>Or, if you know they are associated with another site, please select that site from the dropdown and click Change Site.</p>
<?
}
?>
<table border="1" cellpadding="0" cellspacing="0">
  <tr>
    <th>Username</th>
    <th>First name</th>
    <th>Surname</th>
    <th>Site</th>
    <th>Action</th>
  </tr>

<?
  $ssql =
    "select username, first_name, last_name, site ".
    "from usr ".
    "where status='Init' ".
	"and site IS NULL ".
    "order by site, last_name, first_name";
  $sql = mysql_query($ssql) or die (mysql_error());

  while ($row = mysql_fetch_array($sql)) {
    $rowid = $row[0]."_unknown_row";
?>
    <tr>
      <td><?=nvhtml($row[0])?></td>
      <td><?=nvhtml($row[1])?></td>
      <td><?=nvhtml($row[2])?></td>
      <td id="<?=$rowid?>"><?=siteCombo($row[0], "unknown_site", $site, false)?></td>
      <td><input type="button" class="button" onclick="confirm_site('<?=$row[0]?>','<?=$rowid?>','<?=$row[0]?>_unknown_site',this);return false;" value="Change Site"></td>
    </tr>
<?
  }
?>
</table>
<?
include 'tpl/bot.php';
?>