<html>
	<head>
		<title>Invoice Summary</title>
	</head>
	<body>
		<h1>Invoice Summary</h1>
		<table border="1">
			<tr>
				<th>invoice_number</th>
				<th>status</th>
				<th>client_id</th>
				<th>dateissued</th>
				<th>client_name</th>
				<th>invoice_note</th>
				<th>subtotal</th>
				<th>vat</th>
				<th>total</th>
			</tr>
<?php

$connection = mysql_pconnect("localhost","bamboo","bamboo", MYSQL_CLIENT_INTERACTIVE) or die ("Couldn't connect to server.");
$db = mysql_select_db("bamboo", $connection) or die("Couldn't select database.");

// some code

$sql =
	"SELECT i.invoice_number, MIN(i.client_id)client_id, MIN(i.dateissued)dateissued, ".
	"MIN(c.name)client_name, MIN(i.invoice_note)invoice_note, SUM(quantity*amount)subtotal, ".
	"if(taxable=1,SUM(quantity*amount*(tax1_rate/100)),0)vat, ".
	"if(taxable=1,SUM(quantity*amount*((100+tax1_rate)/100)),0)total ".
	"FROM bb_invoices i, bb_invoice_items t, bb_clients c ".
	"WHERE t.invoice_id = i.id ".
	"AND c.id = i.client_id ".
	"GROUP BY i.invoice_number ";
$result = mysql_query($sql) or die("Error in query.");
while ($row = mysql_fetch_array($result)) {
  foreach($row AS $key => $val) {
    $$key = stripslashes($val);
  }
?>
			<tr>
				<td><?=$invoice_number?></td>
				<td>SENT</td>
				<td><?=$client_id?></td>
				<td><?=$dateissued?></td>
				<td><?=$client_name?></td>
				<td><?=$invoice_note?></td>
				<td><?=$subtotal?></td>
				<td><?=$vat?></td>
				<td><?=$total?></td>
			</tr>
<?php
}
?>
		</table>
	</body>
</html>