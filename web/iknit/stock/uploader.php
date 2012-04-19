<?
/* * * * * * * * * * * * * * * * * * * * * * * *
 * EPOS Interface - iKnit
 * Copyright (c) 2011 Frontburner
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * Main View/Controller
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  27-Aug-2011  10925  Created file.
 * CAM  19-Apr-2012  11115 : Renamed to Lovie's Yarn.
 * * * * * * * * * * * * * * * * * * * * * * * */

error_reporting(E_ALL ^ E_NOTICE);
require_once 'excel_reader2.php';
include '../includes/configure.php';

$filename = (!empty($_FILES['stockfile']['tmp_name'])) ? $_FILES['stockfile']['tmp_name'] : "";
$operation = (!empty($_POST['operation'])) ? $_POST['operation'] : "";
$validfile = FALSE;

if (!empty($filename)) {
  $data = new Spreadsheet_Excel_Reader($filename);

  $validfile = (($data->val(1,1,0) == "LOVIES"));
}

$con = mysql_connect(DB_SERVER,DB_SERVER_USERNAME,DB_SERVER_PASSWORD) or die('Could not connect: ' . mysql_error());
mysql_select_db(DB_DATABASE, $con);

function radio_value($option, $selectedvalue) {
	return (($option == $selectedvalue) ? "CHECKED " : "") . "value=\"$option\"";
}

function show_summary_table($errorcount, $matchnochange, $matchupdate, $changemade) {

	$matchnochangetext = "Match, quantity identical (no change)";
	$matchupdatetext = "Match, change required";
	if ($changemade) {
		$matchnochangetext = "Match, quantity identical (no change made)";
		$matchupdatetext = "Matched &amp; updated!";
	}

  	?><table border=1>
  		  <tr>
  		    <th>Item</th>
  		    <th>Qty</th>
  		    <th>Bar</th>
  		  </tr><?
		?><tr><td>No match</td><td align="right"><?=$errorcount?></td><td><img src="../images/status/exc.png" height="20" width="<?=$errorcount*1.5?>"></td></tr><?
  	?><tr><td><?=$matchnochangetext?></td><td align="right"><?=$matchnochange?></td><td><img src="../images/status/new.png" height="20" width="<?=$matchnochange*1.5?>"></td></tr><?
  	?><tr><td><?=$matchupdatetext?></td><td align="right"><?=$matchupdate?></td><td><img src="../images/status/inc.png" height="20" width="<?=$matchupdate*1.5?>"></td></tr><?
  ?></table><?
}

function show_summary() {
	global $data;

  if (!empty($data)) {

		$sht=0;
	  $rows = $data->rowcount($sheet_index=$sht);

	  $errorcount = 0;
	  $matchnochange = 0;
	  $matchupdate = 0;

	  for($r=3; $r < $rows; $r++) {

			$barcode = $data->val($r,1,$sht);
	  	$qty = $data->val($r,4,$sht)*1;

        $sql = "select products_id, products_quantity from products where products_barcode='$barcode'";

        $res = mysql_query($sql) or die (mysql_error());
        if ($row = mysql_fetch_array($res)) {
        	$currqty = ($row[1]*1);

        	if ($row[1] == $qty) {
	        	$matchnochange++;
        	} else {
	        	$matchupdate++;
        	}

        } else {
        	$errorcount++;
        }
	 	}
		show_summary_table($errorcount, $matchnochange, $matchupdate, false);
	}
}


function show_errors() {
	global $data;

  if (!empty($data)) {

		$sht=0;
	  $rows = $data->rowcount($sheet_index=$sht);

	  ?><table border=1>
  		  <tr>
  		    <th>Barcode</th>
  		    <th>Qty</th>
  		    <th>EPOS Name</th>
  		    <th>Lovie&rsquo;s Yarn Product Selector</th>
  		  </tr><?

	  for($r=3; $r < $rows; $r++) {

			$barcode = $data->val($r,1,$sht);
			$prodname = $data->val($r,2,$sht);
	  	$qty = $data->val($r,4,$sht)*1;

      $sql = "select products_id, products_quantity from products where products_barcode='$barcode'";

      $res = mysql_query($sql) or die (mysql_error());
      if ($row = mysql_fetch_array($res)) {
      } else {
      	?><tr><td><?=$barcode?></td><td align="right"><?=$qty?></td>
      		<td><?=$prodname?></td>
      		<td><input id="<?="bc-" . $barcode . "-" . $r?>" type="text" size="40" onkeyup="prodprompt(this, '<?=$barcode?>');"></td></tr><?
      }
	 	}
    ?></table><?
	}
}


function process_matches() {
	global $data;

  if (!empty($data)) {

		$sht=0;
	  $rows = $data->rowcount($sheet_index=$sht);

	  $errorcount = 0;
	  $matchnochange = 0;
	  $matchupdate = 0;

	  for($r=3; $r < $rows; $r++) {

			$barcode = $data->val($r,1,$sht);
	  	$qty = $data->val($r,4,$sht)*1;

        $sql = "select products_id, products_quantity from products where products_barcode='$barcode'";

        $res = mysql_query($sql) or die (mysql_error());
        if ($row = mysql_fetch_array($res)) {
        	$currqty = ($row[1]*1);

        	if ($currqty == $qty) {
	        	$matchnochange++;
        	} else {

        		$sql = "update products set products_quantity='$qty' where products_barcode='$barcode'";
        		mysql_query($sql);

	        	$matchupdate++;
        	}

        } else {
        	$errorcount++;
        }
	 	}

		show_summary_table($errorcount, $matchnochange, $matchupdate, true);
	}
}


?>
<html>
<head>
	<title>EPOS Stock Updater</title>
	<style TYPE="text/css">
<!--
  body,p,td {
  	font-family: sans-serif;
  }

	body {
  	background: white;
    color: #001166;
  }

  h1 {
  	color:#EE3333;
  	font-size: 12pt;
  }

  a:link { color: #ff8080 }
  a:visited { color: #ff0000 }
  a:active { color: #a05050 }

        -->
      </style>
  <script language="javascript">

    function ProductInfo() {
	    this.txtId = "";
	    this.pbarcode = "";
	    this.pid = "";
	    this.pmodel = "";
	    this.pimage = "";
	    this.pname = "";
		}

		var pi = new ProductInfo();

		function getObjRef(ref) {
		  return document.all ? document.all[ref] : document.getElementById(ref);
		}

		function getOffset( el ) {
		    var _x = 0;
		    var _y = 0;
		    while( el && !isNaN( el.offsetLeft ) && !isNaN( el.offsetTop ) ) {
		        _x += el.offsetLeft;// - el.scrollLeft;
		        _y += el.offsetTop;// - el.scrollTop;
		        el = el.offsetParent;
		    }
		    return { top: _y, left: _x };
		}

	  function getMatchingProduct(productText, pbarcode, txtId)
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
	        getObjRef("searchresults").innerHTML = xmlhttp.responseText;
	      }
	    }
	    xmlhttp.open("GET","productlist.php?txtid=" + txtId + "&barcode=" + pbarcode + "&search="+escape(productText.value),true);
	    xmlhttp.send();
	  }

	  function confirmproduct(txtId, pbarcode, pid, pmodel, pimage, pname) {
			var sr = getObjRef('searchresults');
			var ps = getObjRef('prodselect');
			var pst = getObjRef('pstext');

			ps.style.display = "inline";
			ps.style.top = sr.offsetTop + "px";
			ps.style.left = sr.offsetLeft + "px";

			pi.txtId = txtId;
			pi.pbarcode = pbarcode;
			pi.pid = pid;
			pi.pmodel = pmodel;
			pi.pimage = pimage;
			pi.pname = pname;

			pst.innerHTML = pi.pname + "<br /><b>" + pi.pmodel + "</b><br /><img src=\"../images/" + pi.pimage + "\"><br /><b>" + pi.pbarcode + "</b>";
	  }

	  function saveProduct()
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
	        var txt = getObjRef(pi.txtId);
	        txt.value=pi.pname;
	        txt.readOnly = true;
	        getObjRef("searchresults").innerHTML = xmlhttp.responseText;
	      }
	    }
	    xmlhttp.open("GET","saveproduct.php?pid=" + pi.pid + "&barcode=" + pi.pbarcode,true);
	    xmlhttp.send();
	  }

	  function acceptproduct() {
      closeproductconfirm();

      saveProduct();
	  }

	  function cancelproduct() {
      closeproductconfirm();
	  }

	  function closeproductconfirm() {
      var ps = getObjRef('prodselect');
	  	ps.style.display = "none";
	  }

  	function prodprompt(txt, pbarcode) {

  		if (txt.value.length > 1) {
  			closeproductconfirm();

	  		var txtpos = getOffset(txt);
	  		var sr = getObjRef('searchresults');

	  		sr.style.display = "inline";
				sr.style.top = txtpos.top + "px";
				sr.style.left = (txtpos.left + txt.offsetWidth + 20) + "px";
				sr.innerHTML = "Searching...";

				getMatchingProduct(txt, pbarcode, txt.id);
			}
  	}

  </script>
</head>

<body>

	<form enctype="multipart/form-data" action="uploader.php" method="POST">
		<table border="0" cellspacing="5" cellpadding="5">
			<tr><td><input type="hidden" name="MAX_FILE_SIZE" value="10000000" />Choose a file to
		upload <input name="stockfile" type="file" size="60" /></td></tr>
		<tr><td>
			<input type="radio" <?=radio_value("Summary", $operation)?> name="operation" id="radio1"><label for="radio1">Summary</label>
			<input type="radio" <?=radio_value("ShowErrors", $operation)?> name="operation" id="radio2"><label for="radio2">Show Errors</label>
			<input type="radio" <?=radio_value("ProcessMatches", $operation)?> name="operation" id="radio3"><label for="radio3">Process Matches</label>
		</td></tr>

				<tr><td><input type="submit" value="Upload File" /></td></tr>
    </table>
  </form>


<?php

  if (!$validfile) {
  	echo "<h1>Invalid File</h1>";

  } else if ($operation == "Summary") {
  	echo "<h1>Summary</h1>";
  	show_summary();
  } else if ($operation == "ShowErrors") {
  	echo "<h1>Show Errors</h1>";
  	show_errors();
  } else if ($operation == "ProcessMatches") {
  	echo "<h1>Process Matches</h1>";
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
</body>
</html>
