<?
/* * * * * * * * * * * * * * * * * * * * * * * *
 * Talisman WMS Users
 * Copyright (c) 2012 Front Burner
 *
 * Active Directory Uploader
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  05-Sep-2012  11128 : Created AD uploader.
 * CAM  14-Oct-2012  11138 : Ensure First/Last names with apostrophes save correctly.
 * * * * * * * * * * * * * * * * * * * * * * * */

error_reporting(E_ALL ^ E_NOTICE);

$title = "Upload AD Users";
require_once 'excel_reader2.php';
include 'tpl/top.php';

$filename = (!empty($_FILES['adfile']['tmp_name'])) ? $_FILES['adfile']['tmp_name'] : "";
$validfile = FALSE;

if (!empty($filename)) {
  $data = new Spreadsheet_Excel_Reader($filename);

  $validfile = (($data->val(1,8,0) == "SAM Account Name"));
}

function show_summary_table($errorcount, $matchnochange, $matchupdate) {
	?><table border=1>
		  <tr>
 		    <th>Item</th>
 		    <th>Count</th>
 		  </tr><?
		?><tr><td>No match</td><td align="right"><?=$errorcount?></td></tr><?
  	?><tr><td>Match, details unchanged</td><td align="right"><?=$matchnochange?></td></tr><?
  	?><tr><td>Matched &amp; updated!</td><td align="right"><?=$matchupdate?></td></tr><?
  	?><tr><td>Total Matches</td><td align="right"><?=($matchupdate + $matchnochange)?></td></tr><?
  ?></table><?
}
function sqltext($text) {
  return str_replace("'", "\'", $text);
}

function process_matches() {
	global $data;

	if (!empty($data)) {
		$sht=0;
		$rows = $data->rowcount($sheet_index=$sht);

		$errorcount = 0;
		$matchnochange = 0;
		$matchupdate = 0;

		for($r=2; $r < $rows; $r++) {

			$username = strtoupper($data->val($r,8,$sht));
			$first_name = sqltext($data->val($r,2,$sht));
			$last_name = sqltext($data->val($r,3,$sht));
			$email_address = $data->val($r,4,$sht);

			$sql = "select status, first_name, last_name, work_email from usr where username='$username'";

			$res = mysql_query($sql) or die (mysql_error());
			if ($row = mysql_fetch_array($res)) {
				$status = ($row[0]);

				if (($status != "Init") || (!empty($row[1]))) {
					$matchnochange++;
				} else {
					$sql = "update usr set first_name='$first_name', last_name='$last_name', work_email='$email_address' where username='$username'";
					mysql_query($sql);
				//echo "$username : $first_name<br>";
					$matchupdate++;
				}

			} else {
				$errorcount++;
			}
		}

		show_summary_table($errorcount, $matchnochange, $matchupdate);
	}
}
?>
	<form enctype="multipart/form-data" action="upload_ad.php" method="POST">
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
