<?php
error_reporting(E_ALL ^ E_NOTICE);
require_once 'excel_reader2.php';
include '../includes/configure.php';

$filename = (!empty($_FILES['stockfile']['tmp_name'])) ? $_FILES['stockfile']['tmp_name'] : "";

if (!empty($filename)) {
  $data = new Spreadsheet_Excel_Reader($filename);
}

$con = mysql_connect(DB_SERVER,DB_SERVER_USERNAME,DB_SERVER_PASSWORD) or die('Could not connect: ' . mysql_error());
mysql_select_db(DB_DATABASE, $con);

?>
<html>
<head>

</head>

<body>

	<form enctype="multipart/form-data" action="uploader.php" method="POST">
    <input type="hidden" name="MAX_FILE_SIZE" value="10000000" />
    Choose a file to upload <input name="stockfile" type="file" size="60" /><input type="submit" value="Upload File" />
  </form>


<?php

  if (!empty($data)) {

		$sht=0;
	  $rows = $data->rowcount($sheet_index=$sht);

    if ($data->val(1,1,$sht) != "LOVIES") {
    	echo "<div style=\"color:#EE1100\">May not be a valid file</div>";
    }

  	?><table border=1>
  		  <tr>
  		    <th>Barcode</th>
  		    <th>Qty</th>
  		    <th>Found product on website</th>
  		  </tr><?

	  for($r=3; $r < $rows; $r++) {

			$barcode = $data->val($r,1,$sht);
	  	$qty = $data->val($r,4,$sht)*1;

	  	?><tr><td><?=$barcode?></td><td><?=$qty?></td><td><?

        $sql = "select products_id from products where products_barcode='$barcode'";

        $res = mysql_query($sql) or die (mysql_error());
        if ($row = mysql_fetch_array($res)) {
        	echo $row[0];
        } else {
        	echo "<span style=\"color:#EE1100\">NOTFOUND</span>";
        }

	  	?></td><?

	 	}

  ?></table><?
	}
?>
</body>
</html>
