<?
/* * * * * * * * * * * * * * * * * * * * * * * *
 * ASRC.biz (Aberdeen Squash Racquets Club)
 *
 * Copyright (c) 2006 Frontburner
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * Login form
 *
 * $Id: activate.php 39 2006-05-04 22:27:43Z craig $
 *
 * Who  When         Why
 * CAM  19-Mar-2004  File created.
 * * * * * * * * * * * * * * * * * * * * * * * */
include_once 'Main.php';

$retry = NULL;        if (!empty($_POST['retry'])) $retry = $_POST['retry'];
$memberid = NULL;     if (!empty($_POST['memberid'])) $retry = $_POST['memberid'];

if ($retry == NULL && !isset($_REQUEST['logmeout'])) {
  Msg::error("First time logging in?&nbsp;&nbsp;Just enter your Member No and click 'Login'");
} else if ($memberid == NULL && !isset($_REQUEST['logmeout'])) {
  Msg::error("Please enter your Member ID!");
}

?>

<form action="login.php" method="post" name="" id="login">
  <table border="0" align="center" cellpadding="0" cellspacing="8">
    <tr>
      <td class="fld">Member No.</td>
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
