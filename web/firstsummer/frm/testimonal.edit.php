<?php
/* * * * * * * * * * * * * * * * * * * * * * * *
 * First Summerhouses
 * Copyright (c) 2006-2007 Frontburner
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * Testinomal Form
 *
 * $Id: news.edit.php 310 2006-10-10 21:31:17Z craig $
 *
 * Who  When         Why
 * CAM  01-Feb-2007  10081 : File created.
 * * * * * * * * * * * * * * * * * * * * * * * */
?>

<form action="<? echo $form_action; ?>" method="post" name="" id="">
  <table border="0" align="left" cellpadding="0" cellspacing="8">
    <tr>
      <td class="<? echo (!empty($retry) && empty($news_date)) ? "fldmand" : "fld" ?>">Testimonal Date</td>
      <td><input name="testimonal_date" type="text" id="testimonal_date" size=10 onChange="checkDate(this);"
      <? echo 'value="'. $testimonal_date . '">';?></td>
    </tr>
    <tr>
      <td class="<? echo (!empty($retry) && empty($newsitem)) ? "fldmand" : "fld" ?>">Customer&#039;s Name</td>
      <td><input name="customer_name" type="text" id="customer_name" size=30
      <? echo 'value="'. $customer_name . '">';?></td>
    </tr>
    <tr>
      <td class="<? echo (!empty($retry) && empty($testimonal)) ? "fldmand" : "fld" ?>">Testimonal</td>
      <td><textarea name="testimonal" type="text" id="testimonal" rows=8 cols=70><? echo $testimonal;?></textarea>
    </tr>
    <tr>
      <td>&nbsp;</td>
      <td>
        <input name="retry" type="hidden" id="retry" value="1">
        <input name="testimonal_id" type="hidden" id="testimonal_id" value="<? echo $testimonal_id; ?>">
        <input class="button" type="submit" value="<? echo $form_button; ?>">
      </td>
    </tr>
  </table>
</form>
