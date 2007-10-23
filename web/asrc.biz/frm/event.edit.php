<?php
/* * * * * * * * * * * * * * * * * * * * * * * *
 * ASRC.biz (Aberdeen Squash Racquets Club)
 *
 * Copyright (c) 2006 Frontburner
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  22-Oct-2007  10182 : File created.
 * * * * * * * * * * * * * * * * * * * * * * * */
?>

<form action="<? echo $form_action; ?>" method="post" name="" id="">
  <table border="0" align="center" cellpadding="0" cellspacing="8">
    <tr>
      <td class="<? echo (!empty($retry) && empty($event_date)) ? "fldmand" : "fld" ?>">Event Date</td>
      <td><input name="event_date" type="text" id="event_date" size=10 onChange="checkDate(this);"
      <? echo 'value="'. $event_date . '">';?></td>
    </tr>
    <tr>
      <td class="<? echo (!empty($retry) && empty($event_title)) ? "fldmand" : "fld" ?>">Event Title</td>
      <td><input name="event_title" type="text" id="event_title" size=30
      <? echo 'value="'. $event_title . '">';?></td>
    </tr>
    <tr>
      <td class="<? echo (!empty($retry) && empty($event_text)) ? "fldmand" : "fld" ?>">Text</td>
      <td><textarea name="event_text" type="text" id="event_text" rows=8 cols=80><? echo $event_text;?></textarea>
    </tr>
    <tr>
      <td>&nbsp;</td>
      <td>
        <input name="retry" type="hidden" id="retry" value="1">
        <input name="event_id" type="hidden" id="event_id" value="<? echo $event_id; ?>">
        <input class="button" type="submit" value="<? echo $form_button; ?>">
      </td>
    </tr>
  </table>
</form>
