<?php
/* * * * * * * * * * * * * * * * * * * * * * * *
 * Meter edit
 * Copyright (c) 2006 Southesk.com
 *
 * Who  When         Why
 * CAM  01-Jul-2006  File created.
 * * * * * * * * * * * * * * * * * * * * * * * */

$cfg['Site']['Db']['Hostname'] = "localhost";
$cfg['Site']['Db']['Username'] = "southesk";
$cfg['Site']['Db']['Password'] = "psalm45";
$cfg['Site']['Db']['Database'] = "southesk_com_-_cms";

$connection = mysql_pconnect($cfg['Site']['Db']['Hostname'],
                             $cfg['Site']['Db']['Username'],
                             $cfg['Site']['Db']['Password'])
              or die ("Couldn't connect to server.");

$db = mysql_select_db($cfg['Site']['Db']['Database'], $connection)
      or die("Couldn't select database.");

  $old_meter = $_POST['old_meter'];
  $language = $_POST['language'];
  $new_meter = $_POST['new_meter'];
  $existing_meter = $_POST['existing_meter'];
  $new_rythmn = $_POST['new_rythmn'];
  $new_chorus = $_POST['new_chorus'];
  $op = $_POST['op'];

?>
<html>
<head>
  <script>
  function getObjRef(p_ref) {
    return document.all ? document.all[p_ref] : document.getElementById(p_ref);
  }

  function toggle_language() {
    var frm = getObjRef("searchForm");
    frm.op.value = "toggle";
    frm.submit();
  }

  function use_existing() {
    var frm = getObjRef("searchForm");
    frm.op.value = "existing";
    frm.submit();
  }
  </script>
</head>
<body>

<?

if (($op == "upd") && (!empty($old_meter))) {

  echo "<h2>Insert new</h2>";

  $new_rythmn = (empty($new_rythmn) ? "NULL" : "'$new_rythmn'");
  $new_chorus = (empty($new_chorus) ? "NULL" : "'$new_chorus'");

  $sql = "INSERT INTO hymn_meter (meter, rythmn, chorus) VALUES ".
         "('$new_meter', $new_rythmn, $new_chorus)";
  mysql_query($sql);
  $id = mysql_insert_id();

  $sql = "UPDATE hymn$language SET meter_id = '$id' WHERE meter = '$old_meter'";

  echo "<h3>$sql</h3>";

  mysql_query($sql) or die("</select><h1>Query failed</h1><pre>$sql</pre>");
} else if ($op == "existing") {

  echo "<h2>Use Existing</h2>";
  $sql = "UPDATE hymn$language SET meter_id = '$existing_meter' WHERE meter = '$old_meter'";
  echo "<h3>$sql</h3>";
  mysql_query($sql) or die("</select><h1>Query failed</h1><pre>$sql</pre>");
}

?>

<form action="meter2.php" method="post" name="searchForm" target="_top" id="searchForm">
<table border=1 cellspacing=0 cellpadding=5>

<tr>

<td><b>Language</b></td><td><select name="language" id="language" class="dropdown" onchange="toggle_language();">
  <option value="" <? echo ($language == "" ? "SELECTED" : ""); ?>>English</option>
  <option value="_de" <? echo ($language == "_de" ? "SELECTED" : ""); ?>>Deutsche</option>
</select></td>

</tr>

<?
  $meterSql = "SELECT meter hymnmeter FROM hymn$language WHERE meter_id IS NULL LIMIT 1";
  $meterRes = mysql_query($meterSql) or die("</select><h1>Query failed</h1><pre>$meterSql</pre>");

  if ($row = mysql_fetch_row($meterRes)) {
?>
  <tr><td><b>Old Meter</b></td><td><input readonly size=40 name="old_meter" id="old_meter" value="<? echo $row[0]; ?>"></td></tr>
<?
  }
  mysql_free_result($meterRes);

?>
  <tr><td><b>Existing Meter</b></td><td><select name="existing_meter" id="existing_meter" class="dropdown">
<?
  $new_meter = str_replace(' ', '.', trim($row[0]));
  if (substr($new_meter, strlen($new_meter)-1, 1) != '.') $new_meter .= ".";
  $search_meter = substr($new_meter, 0, 1);

  $meterSql = "SELECT id,meter,rythmn,chorus FROM hymn_meter WHERE meter LIKE '$search_meter%' ORDER BY disp_order,meter";
  $meterRes = mysql_query($meterSql) or die("</select><h1>Query failed</h1><pre>$meterSql</pre>");

  while ($row = mysql_fetch_row($meterRes)) {
?>
    <option SELECTED value="<? echo $row[0]; ?>"><? echo " $row[1] $row[2] $row[3]"; ?></option>
<?
  }
  mysql_free_result($meterRes);
?>
    </select><input type="button" onclick="use_existing();" value="Use this"></td></tr>

<tr><td><b>New Meter</b></td><td><input type="text" name="new_meter" id="new_meter" size=40 value="<? echo $new_meter; ?>" /></td></tr>
<tr><td><b>Rhythm</b></td><td><input type="text" name="new_rythmn" id="new_rythmn" size=40/></td></tr>
<tr><td><b>Chorus</b></td><td><input type="text" name="new_chorus" id="new_chorus" size=40/></td></tr>


<tr>
  <td colspan=2 align=center>
    <input type="submit" name="hymn_search" value="Update" class="button" />
    <input type="hidden" name="op" value="upd" />
  </td>
</tr>

</table>
</form>
</body>
</html>