<?
/* * * * * * * * * * * * * * * * * * * * * * * *
 * ASRC.biz (Aberdeen Squash Racquets Club)
 *
 * Copyright (c) 2006 Frontburner
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * Opponent Search Form
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  08-Jun-2004  File created.
 * CAM  25-Nov-2008  10314 : Ensure button displays in new colours/layout in line with new asrc.co.uk.
 * * * * * * * * * * * * * * * * * * * * * * * */
include_once 'Main.php';

$retry = NULL;        if (!empty($_POST['retry'])) $retry = $_POST['retry'];

if ($retry == NULL) {
  Msg::error("Enter your opponent's Member No or Name below:");
}

?>

<form action="opponent.php" method="post" name="" id="">
  <table border="0" align="center" cellpadding="0" cellspacing="8">
    <tr>
      <td class="fld">Member No.</td>
      <td><input name="member_id" type="text" id="member_id"></td>
    </tr>
    <tr>
      <td class="fld">Name</td>
      <td><input name="member_name" type="text" id="member_name"></td>
    </tr>
    <tr>
      <td><input type="hidden" name="book_date" id="book_date" value="<? print $book_date ?>">
          <input type="hidden" name="court" id="court" value="<? print $court ?>">
          <input type="hidden" name="slot" id="slot" value="<? print $slot ?>"></td>
      <td><input class="button" type="submit" value="Search"><input type="hidden" name="retry" value="1"></td>
    </tr>
  </table>
</form>

<script language="Javascript">getObjRef("member_id").focus();</script>