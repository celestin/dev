<?
/* * * * * * * * * * * * * * * * * * * * * * * *
 * Login form
 * Copyright (c) 2006 frontburner.co.uk
 *
 * $Log: /web/parkersretreat/frm/user.login.php $
 * 
 * 1     23/04/06 21:28 Craig
 *
 * Who  When         Why
 * CAM  11-Apr-2006  File created.
 * * * * * * * * * * * * * * * * * * * * * * * */

include_once 'Main.php';

$retry = NULL;        if (!empty($_POST['retry'])) $retry = $_POST['retry'];

if ($retry == NULL && !isset($_REQUEST['logmeout'])) {
  Msg::error("New user?  Please register.");
} else if ($memberid == NULL && !isset($_REQUEST['logmeout'])) {
  Msg::error("Please enter your Username!");
}

?>

<form action="login.php" method="post" name="" id="login">
  <table border="0" align="center" cellpadding="0" cellspacing="8">
    <tr>
      <td class="fld">Username</td>
      <td colspan=2><input name="memberid" type="text" id="memberid" value="<? echo $memberid; ?>"></td>
    </tr>
    <tr>
      <td class="fld">Password</td>
      <td colspan=2><input name="password" type="password" id="password"></td>
    </tr>
    <tr>
      <td>&nbsp;</td>
      <td><input class="button" type="submit" value="Login"><input type="hidden" name="retry" value="1"></td>
      <td valign=middle><a href="javascript:login.action='forgot.php';login.submit();">Forgotten Password?</a></td>
    </tr>
  </table>
</form>

<script language="Javascript">getObjRef("memberid").focus();</script>
