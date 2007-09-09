<?
/* * * * * * * * * * * * * * * * * * * * * * * *
 * Change Password Form
 * Copyright (c) 2004-2005 Southesk.com
 *
 * $Log: /web/cc/frm/chgpass_form.php $
 * 
 * 1     28/12/05 15:45 Craig
 *
 * Who  When         Why
 * CAM  27-Dec-2005  File created.
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
