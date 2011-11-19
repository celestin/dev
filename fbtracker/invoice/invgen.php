<?php

?>
<html>
  <head>
    <title>Front Burner FBtracker</title>
    <style type="text/css">
      body {
        text-align:center;
        margin-top: 40px;
      }

      body, p {
        font-family: Arial;
      }

      h1 {
        background-color: #0066CC;
        color: white;
      }

      img {
        border: 0px;
      }

      a.app {
        background-color: #0066CC;
        color: white;
        padding: 2px;
        text-decoration: none;
      }

      a.app:hover {
        background-color: #0099CC;
      }

      #apps {
        width: 800px;
        margin-left: auto;
        margin-right: auto ;
      }

      #apps td {
        text-align: center;
        width: 20%;
      }

      #fblogo {
        text-align: left;
      }

    </style>
    <link rel="shortcut icon" href="../img/favicon.ico">
  </head>
  <body>
    <div id="apps">
      <div id="fblogo"><img src="../img/fb4.png"></div>
      <h1>FBtracker</h1>
      <table border=0 width="100%">

        <tr>
          <td><a href="invoice"><img src="../img/bamboo.png"></a></td>

					<td><form method="post"><table border=1>
						<tr>
							<td>Client</td>
							<td><select name="client_id">
								  <option value="" SELECTED>&lt;Select client&gt;</option>
<?
      	$connection = mysql_pconnect("localhost","bamboo","bamboo", MYSQL_CLIENT_INTERACTIVE) or die ("Couldn't connect to server.");
				$db = mysql_select_db("bamboo", $connection) or die("Couldn't select database.");
				$sql =
					"SELECT id, name FROM bb_clients ".
					"ORDER BY name ";
				$result = mysql_query($sql) or die("Error in query.");
				while ($row = mysql_fetch_array($result)) {
					?><option value="<?=$row['id']?>"><?=$row['name']?></option><?
			  }
?>
								</select></td>
							<td><input type="submit" value="Go!"></td>
					  </tr>
					</table></form></td>

          <td><a href="invlist.php">Invoice Export</a></td>

        </tr>

      </table>

      <div>
      	<?

      	$client_id = ""; if (!empty($_POST["client_id"])) $client_id = $_POST["client_id"];

				if (!empty($client_id)) {
					$result = mysql_query("CALL kimai.fbtracker_generate_client_invoice(".$client_id.")") or die(mysql_error());
					echo "Invoice generated for $client_id";
				}

      	?>
      </div>

    </div>

  </body>
</html>