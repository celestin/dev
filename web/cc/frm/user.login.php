<?
/* * * * * * * * * * * * * * * * * * * * * * * *
 * Login form
 * Copyright (c) 2004-2005 frontburner.co.uk
 *
 * $Id$
 *
 * 1     28/12/05 15:45 Craig
 *
 * Who  When         Why
 * CAM  27-Dec-2005  File created.
 * * * * * * * * * * * * * * * * * * * * * * * */

include_once 'Main.php';

$retry = NULL;        if (!empty($_POST['retry'])) $retry = $_POST['retry'];
//$memberid = NULL;     if (!empty($_POST['memberid'])) $retry = $_POST['memberid'];

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
