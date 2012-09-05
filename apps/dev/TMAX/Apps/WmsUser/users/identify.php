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
 * * * * * * * * * * * * * * * * * * * * * * * */

$title = "Identify Users";
include 'tpl/top.php';
$member = NULL;  if (session_is_registered('member_person')) $member = $_SESSION['member_person'];
$loggedin = (session_is_registered('member_person') && session_is_registered('Talisman WMS Users'));

?>
<script language="Javascript">
  function confirm_site(username, rowid, sitecombo, button) {
    var site = getObjRef(sitecombo);
    var row = getObjRef(rowid);

    button.style.display="none";

    saveSiteChange(username, site.options[site.selectedIndex].value, row);
  }

  function validate_workemail(txt) {
    if (txt.value.indexOf("@") < 0) txt.value += "@talisman-energy.com";
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

function nvhtml($value) {
  if (empty($value)) return "&nbsp;";
  return $value;
}

$site = NULL;      if (!empty($_GET['site'])) $site = $_GET['site'];
$username = NULL;  if (!empty($_GET['username'])) $username = $_GET['username'];
$cid = NULL;       if (!empty($_GET['cid'])) $cid = $_GET['cid'];

if ($loggedin) {
  if ($member->isAdmin()) {
    $site = "";
    $username = $member->id;
  }
} else if (md5($site . $username) != $cid) {
  redirect($cfg['Site']['URL']);
  exit();
}

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

?>
<h1>Identification of Users for Site <?=$site?> by <?=$username?></h1>

<?
if (empty($site)) {
?>
<h2>Users normally working in the office (including Apps support) or Third-Party</h2>
<?
} else {
?>
<h2>Users normally on an offshore rota on <?=$site?></h2>
<?
}
?>
<p>Please check and update all details</p>

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
    (empty($site) ? "and site in ('00','80','81','83') ": "and site='$site' ").
    "and site <> '82' ".
    "order by job_title, last_name, first_name";
  $sql = mysql_query($ssql) or die (mysql_error());

  while ($row = mysql_fetch_array($sql)) {
    $rowid_main = $row[0] . "_a";
    $rowid_site = $row[0] . "_b";
    $rowid_user = $row[0] . "_c";
    $rowid_user2 = $row[0] . "_d";
    $jtcom = $row[0] . "_jtcom";
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
      <td colspan="2" valign="top"><b>Email</b><br /><?=inputBox($row[0], "workemail", $row[3], 45, true)?></td>
      <td colspan="3"><b>Job Title Comments</b> (e.g. 5th Week resp.)<br /><textarea cols="70" rows="5" id="<?=$jtcom?>" name="<?=$jtcom?>"><?=$row[6]?></textarea></td>
    </tr>

    <?
  }

?>
</table>

<h2>Users whose site is not known</h2>
<p>Please mark those who are normally on an offshore rota on <?=$site?></p>

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
    (empty($site) ? "and (site IS NULL OR site NOT IN ('00','80','81','83')) ": "and site IS NULL ").
    "order by site, last_name, first_name";
  $sql = mysql_query($ssql) or die (mysql_error());

  while ($row = mysql_fetch_array($sql)) {
    $rowid = $row[0]."_unknown_row";
?>
    <tr>
      <td><?=nvhtml($row[0])?></td>
      <td><?=nvhtml($row[1])?></td>
      <td><?=nvhtml($row[2])?></td>
      <td id="<?=$rowid?>"><?=siteCombo($row[0], "unknown_site", $row[3], false)?></td>
      <td><input type="button" onclick="confirm_site('<?=$row[0]?>','<?=$rowid?>','<?=$row[0]?>_unknown_site',this);return false;" value="Change Site"></td>
    </tr>
<?
  }
?>
</table>
<?
include 'tpl/bot.php';
?>