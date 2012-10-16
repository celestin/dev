<?php
/* * * * * * * * * * * * * * * * * * * * * * * *
 * Talisman WMS Users
 * Copyright (c) 2012 Front Burner
 *
 * Identify Site
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  08-Oct-2012  11128 : File created.
 * CAM  14-Oct-2012  11136 : Replaced deprecated session_is_registered call.
 * CAM  16-Oct-2012  11140 : Added % complete as a figure, and a total line with total % complete.
 * * * * * * * * * * * * * * * * * * * * * * * */

$title = "Identify Site";
include 'tpl/top.php';
$member = NULL;  if (isset($_SESSION['member_person'])) $member = $_SESSION['member_person'];
$loggedin = (isset($_SESSION['member_person']) && isset($_SESSION['Talisman WMS Users']));

?>
<script language="Javascript">
</script>
<?

function supervisorlink($site, $supervisor) {
  global $cfg;

  if (empty($supervisor)) return "&nbsp;";

  return "<a href=\"" . $cfg['Site']['URL'] . "/identify.php?site=$site&username=$supervisor&cid=". md5($site . $supervisor) ."\">".$supervisor."</a>";
}

function ragprogress($value) {
  $width = 4 + (2 * $value);
  $colour = "red";
  if ($value >= 75) $colour = "green";
  else if ($value >=25) $colour = "amber";
  return "<img style=\"padding-top:2px;\" src=\"img/progress_$colour.jpg\" width=\"$width\" height=\"12\">";
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

?>
<h1>Identification by Site</h1>

<table border="1" cellpadding="2" cellspacing="0">
  <tr>
    <th>Site</th>
    <th>Initialised</th>
    <th>Confirmed</th>
    <th>Total</th>
    <th>% Complete</th>
    <th>Supervisor</th>
  </tr>

<?
  $ssql =
    "SELECT site, SiteFullName, InitCount, ConfirmedCount, InitCount+ConfirmedCount TotalCount, FLOOR(ConfirmedCount/(InitCount+ConfirmedCount)*100) PctComplete, memberid ".
    "FROM ( ".
    "SELECT u.site, MIN(s.SiteFullName) SiteFullName, sum(InitCount) InitCount, sum(ConfirmedCount) ConfirmedCount, MIN(m.memberid) memberid ".
    "FROM ( ".
    "SELECT site, count(*) InitCount, 0 ConfirmedCount  ".
    "FROM usr ".
    "WHERE status = 'Init' ".
    "GROUP BY site ".
    "UNION ALL ".
    "SELECT site, 0 InitCount, Count(*) ConfirmedCount  ".
    "FROM usr ".
    "WHERE status = 'Confirmed' ".
    "GROUP BY site ".
    ") u ".
    "LEFT OUTER JOIN member m ON m.site = u.site AND m.active = 2 ".
    "LEFT OUTER JOIN site s ON s.site = u.site ".
    "GROUP BY site ".
    ") u ".
    "ORDER BY SiteFullName";
  $sql = mysql_query($ssql) or die (mysql_error());

  $total_init = $total_conf = 0;

  while ($row = mysql_fetch_array($sql)) {
    $rowid_main = $row[0] . "_a";
?>
    <tr>
      <td><?=nvhtml($row[1])?></td>
      <td class="num"><?=nvhtml($row[2])?></td>
      <td class="num"><?=nvhtml($row[3])?></td>
      <td class="num"><?=nvhtml($row[4])?></td>
      <td valign="center"><?=ragprogress($row[5])?> <?=$row[5]?>%</td>
      <td><?=supervisorlink($row[0], $row[6])?></td>
    </tr>
    <?

    $total_init += $row[2];
    $total_conf += $row[3];
  }

  $total_pct = floor($total_conf/($total_init+$total_conf)*100);
?>
    <tr>
      <td class="num"><b>Total</b></td>
      <td class="num"><?=$total_init?></td>
      <td class="num"><?=$total_conf?></td>
      <td class="num"><?=$total_init+$total_conf?></td>
      <td valign="center"><?=ragprogress($total_pct)?> <?=$total_pct?>%</td>
      <td><?=supervisorlink($row[0], $row[6])?></td>
    </tr>
</table>
<?
include 'tpl/bot.php';
?>