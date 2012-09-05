<?
/* * * * * * * * * * * * * * * * * * * * * * * *
 * Talisman WMS Users
 * Copyright (c) 2012 Front Burner
 *
 * MAXUSRGROUPS Uploader
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  05-Sep-2012  11128 : Created MAXUSRGROUPS uploader.
 * * * * * * * * * * * * * * * * * * * * * * * */

error_reporting(E_ALL ^ E_NOTICE);

$title = "Upload TMAX Users";
require_once 'excel_reader2.php';
include 'tpl/top.php';

$filename = (!empty($_FILES['adfile']['tmp_name'])) ? $_FILES['adfile']['tmp_name'] : "";
$validfile = FALSE;

if (!empty($filename)) {
  $data = new Spreadsheet_Excel_Reader($filename);
  $validfile = (($data->val(1,1,0) == "Username") && ($data->val(1,2,0) == "Security Group"));
}

function show_summary_table($insertcount, $matchupdate, $deletes) {
	?><table border=1>
		  <tr>
 		    <th>Item</th>
 		    <th>Count</th>
 		  </tr><?
		?><tr><td>Inserted</td><td align="right"><?=$insertcount?></td></tr><?
  	?><tr><td>Matched &amp; updated!</td><td align="right"><?=$matchupdate?></td></tr><?
  	?><tr><td>Deleted users</td><td align="right"><?=$deletes?></td></tr><?
  	?><tr><td>Total Users</td><td align="right"><?=($insertcount + $matchupdate)?></td></tr><?
  ?></table><?
}

function process_matches() {
	global $data;

  if (!empty($data)) {

		$sht=0;
	  $rows = $data->rowcount($sheet_index=$sht);

	  $insertcount = 0;
	  $deletes = 0;
	  $matchupdate = 0;

    $sql = "update usr set current_group=null";
    mysql_query($sql) or die (mysql_error());

	  for($r=2; $r < $rows; $r++) {

			$username = strtoupper($data->val($r,1,$sht));
	  	$security_group = $data->val($r,2,$sht);

      $sql = "select status from usr where username='$username'";
      $res = mysql_query($sql) or die (mysql_error());
      if ($row = mysql_fetch_array($res)) {
        $status = $row[0];
        $statussql = "";
        if ($status == "Deleted" || empty($status)) {
          $statussql = ", status='$status'";
        }

        $sql = "update usr set current_group='$security_group' $statussql where username='$username'";
        //echo "<li>$sql</li>";
        mysql_query($sql);
        $matchupdate++;
      } else {
        $sql = "insert into usr (username, current_group, status) values ('$username','$security_group','Init')";
        mysql_query($sql);
        $insertcount++;
      }
    }

    $sql = "update usr set status='Deleted' where current_group is null and status<>'System'";
    $res = mysql_query($sql) or die (mysql_error());

    $sql = "select count(*) from usr where status='Deleted'";
    $res = mysql_query($sql) or die (mysql_error());
    if ($row = mysql_fetch_array($res)) {
      $deletes = $row[0];
    }

		show_summary_table($insertcount, $matchupdate, $deletes);
	}
}

?>

	<form enctype="multipart/form-data" action="upload_tmax.php" method="POST">
		<table border="0" cellspacing="5" cellpadding="5">
			<tr><td><input type="hidden" name="MAX_FILE_SIZE" value="10000000" />Choose a file to
		upload <input name="adfile" type="file" size="60" /></td></tr>

				<tr><td><input type="submit" value="Upload File" /></td></tr>
    </table>
  </form>


<?php

  if (empty($filename)) {
    echo "Select a file.";

  } else if (!$validfile) {
  	echo "<h1>Invalid File</h1>";

  } else {
  	echo "<h1>Process File</h1>";
  	process_matches();
  }


?>
<div id="searchresults" style="display:none;position:absolute"></div>
<div id="prodselect" style="background:#EEEEEE;padding:20px;display:none;position:absolute">
	<div id="pstext" style="padding-bottom:20px;">

	</div>
	<input type="button" value="Save" onclick="acceptproduct();">
	<input type="button" value="Cancel" onclick="cancelproduct();">
</div>
<?

include 'tpl/bot.php';
