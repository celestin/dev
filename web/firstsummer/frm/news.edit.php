<?php
/* * * * * * * * * * * * * * * * * * * * * * * *
 * First Summerhouses
 * Copyright (c) 2006 Frontburner
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * News Item Form
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  06-Oct-2006  10040 : File created.
 * * * * * * * * * * * * * * * * * * * * * * * */
?>

<form action="<? echo $form_action; ?>" method="post" name="" id="">
  <table border="0" align="center" cellpadding="0" cellspacing="8">
    <tr>
      <td class="<? echo (!empty($retry) && empty($news_date)) ? "fldmand" : "fld" ?>">News Date</td>
      <td><input name="news_date" type="text" id="news_date" size=10 onChange="checkDate(this);"
      <? echo 'value="'. $news_date . '">';?></td>
    </tr>
    <tr>
      <td class="<? echo (!empty($retry) && empty($newsitem)) ? "fldmand" : "fld" ?>">News Title</td>
      <td><input name="newsitem" type="text" id="newsitem" size=30
      <? echo 'value="'. $newsitem . '">';?></td>
    </tr>
    <tr>
      <td class="<? echo (!empty($retry) && empty($news_text)) ? "fldmand" : "fld" ?>">Text</td>
      <td><textarea name="news_text" type="text" id="news_text" rows=8 cols=80><? echo $news_text;?></textarea>
    </tr>
    <tr>
      <td>&nbsp;</td>
      <td>
        <input name="retry" type="hidden" id="retry" value="1">
        <input name="newsitem_id" type="hidden" id="newsitem_id" value="<? echo $newsitem_id; ?>">
        <input class="button" type="submit" value="<? echo $form_button; ?>">
      </td>
    </tr>
  </table>
</form>
