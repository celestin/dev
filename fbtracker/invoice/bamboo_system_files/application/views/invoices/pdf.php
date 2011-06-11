<?php
/**
 * This file is essentially a stripped down version of /views/invoices/view.php
 * Any changes you make to that formatting, you may consider adding to this.
 */
?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title><?php echo $page_title;?></title>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<style type="text/css">
/**
 * Invoice view styles notes
 *
 * This file NEEDS a locally located stylesheet to generate the appropriate formatting for
 * transformation into a PDF.  If you alter this file (and you are encouraged to do so) just
 * keep in mind that all of your formatting must be located here.  You might also find that
 * there is limited or no support for a specific CSS style you want (ie: floating) and you'll
 * need to work around with old-school tables.  Sorry for that... ;)
 */

body {
  margin: 0.5in;
}
h1, h2, h3, h4, h5, h6, li, blockquote, p, th, td {
  font-family: Helvetica, Arial, Verdana, sans-serif; /*Trebuchet MS,*/
}
h1, h2, h3, h4 {
  color: #0098CC;
  font-weight: normal;
}
h4, h5, h6 {
  color: #0098CC;
}
h2 {
  margin: 0 auto auto auto;
  font-size: x-large;
}
h2 span {
  text-transform: uppercase;
}
li, blockquote, p, th, td {
  font-size: 80%;
}
ul {
  list-style: url(img/bullet.gif) none;
}
table {
  width: 100%;
}
td p {
  font-size: small;
  margin: 0;
}
th {
  color: white;
  text-align: left;
  background-color:#2A67B3;
}
td.fld {
  text-align: right;
  color: #333366;
}
td.total {
  text-align: right;
  font-weight: bold;
  border-top: 1px solid #000;
  border-bottom: 1px double #000;
}
.currency {
  text-align: right;
}
.bamboo_invoice_inv {
  font-weight: bold;
  font-variant: small-caps;
  color: #333;
}
#remittance {
  border-top: 1px dashed #2A67B3;
}
#footer {
  border-top: 1px solid #CCC;
  text-align: left;
  color: #333333;
}
table.stripe {
  border-collapse: collapse;
  page-break-after: auto;
}
table.stripe td {
  border-bottom: 1pt solid #CCC;
}
table.stripe td.nowt {
  border: 0px;
}
table.stripe td.totals {
  border: 0px;
}

</style>
</head>
<body>

  <table border="0">
    <tr>
			<td colspan="2" rowspan="3"><img src="<?php echo base_url();?>img/logo/fb4.png"></td>
      <td class="fld">Tel</td><td>+44 775 669 88 66</td>
    </tr>
 		<tr><td class="fld">Email</td><td><?php echo $companyInfo->primary_contact_email;?></td></tr>
 		<tr><td class="fld">Web</td><td><?php echo auto_link(prep_url($companyInfo->website));?></td></tr>

 		<tr><td class="fld" width="10"><?php echo $this->lang->line('invoice_invoice');?></td><td colspan="3"><b><?php echo $row->invoice_number;?></b>&nbsp;<?php echo $row->invoice_note;?></td></tr>

 		<tr>
			<td class="fld" valign="top">Client</td><td><b><?php echo $row->client_id;?></b>&nbsp;<?php echo $row->name;?><br />
		    <?php if ($row->address1 != '') {echo $row->address1;}?>
		    <?php if ($row->address2 != '') {echo ', ' . $row->address2;}?>
		    <?php if ($row->address1 != '' || $row->address2 != '') {echo '<br />';}?>
		    <?php if ($row->city != '') {echo $row->city;}?>
		    <?php if ($row->province != '') {if ($row->city != '') {echo ', ';} echo $row->province;}?>
		    <?php if ($row->country != '') {if ($row->province != '' || ($row->province == '' && $row->city != '')){echo ', ';} echo $row->country;}?>
		    <?php if ($row->postal_code != '') {echo ' ' . $row->postal_code;}?>
		    <?php if ($row->city != '' || $row->province != '' || $row->country != '' || $row->postal_code != '') {echo '<br />';}?>
		    <?php echo auto_link(prep_url($row->website));?>
		    <?php if ($row->tax_code != '') {echo '<br />'.$this->lang->line('settings_tax_code').': '.$row->tax_code;}?>
	  	</td>
      <td class="fld">Registered Address</td><td>
				<?php echo $companyInfo->company_name;?><br />
				<?php echo $companyInfo->address1;?><br />
				<?php if ($companyInfo->address2 != '') {echo $companyInfo->address2.'<br />';}?>
				<?php echo $companyInfo->city;?>,
				<?php if ($companyInfo->province != '') {echo $companyInfo->province.'<br />';}?>
				<?php if ($companyInfo->country != '') {echo $companyInfo->country.'<br />';}?>
				<?php echo $companyInfo->postal_code;?>
   		</td>
   </tr>

	 <tr>
	   <td class="fld">Date</td><td><?php echo $date_invoice_issued;?></td>
  	 <td class="fld">Company No.</td><td><?php echo $companyInfo->company_no;?></td>
	 </tr>

 	 <tr>
 	 	 <td colspan="2">&nbsp;</td>
 	 	 <td class="fld">VAT Reg. No.</td><td><?php echo $companyInfo->vat_reg_no;?></td>
 	 </tr>
  </table>

  <br /><br />

  <table class="invoice_items stripe">
    <tr>
      <th>Item</th>
      <th><?php echo $this->lang->line('invoice_work_description');?></th>
      <th class="currency"><?php echo $this->lang->line('invoice_quantity');?></th>
      <th class="currency"><?php echo $this->lang->line('invoice_amount_item');?></th>
      <th class="currency"><?php echo $this->lang->line('invoice_total');?></th>
    </tr>
    <?php $i=1;?>
    <?php foreach ($items->result() as $item):?>
    <tr valign="top">
      <td><?php echo $i++;?></td>
      <td><?php echo nl2br(str_replace(array('\n', '\r'), "\n", $item->work_description));?></td>
      <td class="currency"><?php echo str_replace('.00', '', $item->quantity);?></td>
      <td class="currency"><?php echo $this->settings_model->get_setting('currency_symbol') . str_replace('.', $this->config->item('currency_decimal'), $item->amount);?> <?php if ($item->taxable == 0){echo '(' . $this->lang->line('invoice_not_taxable') . ')';}?></td>
      <td class="currency"><?php echo $this->settings_model->get_setting('currency_symbol') . number_format($item->quantity * $item->amount, 2, $this->config->item('currency_decimal'), '');?></td>
    </tr>
    <?php endforeach;?>
    <tr>
      <td class="nowt" colspan="3" rowspan="3">&nbsp;</td>
      <td class="currency totals">Sub-total</td>
      <td class="currency"><?php echo $this->settings_model->get_setting('currency_symbol').number_format($row->total_notax, 2, $this->config->item('currency_decimal'), ''); ?></td>
    </tr>
    <tr>
      <td class="currency totals"><?php echo $row->tax1_desc . " (" . number_format($row->tax1_rate, 1) ."%)"; ?></td>
      <td class="currency"><?php echo $this->settings_model->get_setting('currency_symbol').number_format($row->total_with_tax - $row->total_notax, 2, $this->config->item('currency_decimal'), ''); ?></td>
    </tr>
    <tr>
      <td class="currency totals">Total</td>
      <td class="currency"><?php echo $this->settings_model->get_setting('currency_symbol').number_format($row->total_with_tax, 2, $this->config->item('currency_decimal'), ''); ?></td>
    </tr>
  </table>

  <br /><br /><br /><br />

  <div id="remittance">

    <br />

    <h3>Remittance Advice</h3>

	  <table border="0">
		<tr>
		  <td class="fld"><?php echo $this->lang->line('invoice_invoice');?></td><td><b><?php echo $row->invoice_number;?></b></td>
		  <td class="fld">Date</td><td><b><?php echo $date_invoice_issued;?></b></td>
		  <td class="fld">Client</td><td><b><?php echo $row->client_id;?></b>&nbsp;<?php echo $row->name;?></b></td>
		  <td class="fld">Total</td><td class="total"><?php echo $this->settings_model->get_setting('currency_symbol').number_format($row->total_with_tax, 2, $this->config->item('currency_decimal'), ''); ?></td>
		</tr>
      </table>
  </div>

  <div id="footer">
	  <p>
		Instructions to our bankers: The Royal Bank of Scotland, Sort Code: <b>83-04-25</b>, Account Number: <b>10118143</b>.
		<br />
		Please make cheques payable to: <b>FRONT BURNER LTD</b>.
	  </p>
  </div>

</body>
</html>