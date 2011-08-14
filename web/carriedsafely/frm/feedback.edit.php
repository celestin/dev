<?php
/* * * * * * * * * * * * * * * * * * * * * * * *
 * West Coast Express Website
 * Copyright (c) 2007 Frontburner
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * Feedback Form
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  11-Aug-2007  10154 : File created.
 * * * * * * * * * * * * * * * * * * * * * * * */
?>

<form action="<? echo $form_action; ?>" method="post" name="" id="">
  <table border="0" align="left" cellpadding="0" cellspacing="8">
    <tr>
      <td class="<? echo (!empty($retry) && empty($news_date)) ? "fldmand" : "fld" ?>">Feedback Date</td>
      <td><input name="feedback_date" type="text" id="feedback_date" size=10 onChange="checkDate(this);"
      <? echo 'value="'. $feedback_date . '">';?></td>
    </tr>
    <tr>
      <td class="<? echo (!empty($retry) && empty($newsitem)) ? "fldmand" : "fld" ?>">Customer&#039;s Name</td>
      <td><input name="customer_name" type="text" id="customer_name" size=30
      <? echo 'value="'. $customer_name . '">';?></td>
    </tr>
    <tr>
      <td class="<? echo (!empty($retry) && empty($feedback)) ? "fldmand" : "fld" ?>">Feedback</td>
      <td><textarea name="feedback" type="text" id="feedback" rows=8 cols=70><? echo $feedback;?></textarea>
    </tr>
    <tr>
      <td>&nbsp;</td>
      <td>
        <input name="retry" type="hidden" id="retry" value="1">
        <input name="feedback_id" type="hidden" id="feedback_id" value="<? echo $feedback_id; ?>">
        <input class="button" type="submit" value="<? echo $form_button; ?>">
      </td>
    </tr>
  </table>
</form>
