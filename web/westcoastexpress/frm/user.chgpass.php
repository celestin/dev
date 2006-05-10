<?
/* * * * * * * * * * * * * * * * * * * * * * * *
 * West Coast Express Website
 * Copyright (c) 2006 Frontburner
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * Change Password Form
 *
 * $Id: activate.php 50 2006-05-04 23:09:33Z craig $
 *
 * Who  When         Why
 * CAM  13-Apr-2006  File created.
 * * * * * * * * * * * * * * * * * * * * * * * */

?>

<form action="changepass.php" method="post" name="" id="">
  <table border="0" align="center" cellpadding="0" cellspacing="8">
    <tr>
      <td class="fld">Old Password</td>
      <td><input name="old_password" type="password" id="old_password"></td>
    </tr>
    <tr>
      <td class="fld">New Password</td>
      <td><input name="new_password1" type="password" id="new_password1"></td>
    </tr>
    <tr>
      <td class="fld">New Password (again)</td>
      <td><input name="new_password2" type="password" id="new_password2"></td>
    </tr>
    <tr>
      <td>&nbsp;</td>
      <td><input class="button" type="submit" value="Change"><input type="hidden" name="retry" value="1"></td>
    </tr>
  </table>
</form>
