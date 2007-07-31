<?php
/* * * * * * * * * * * * * * * * * * * * * * * *
 * ASRC.biz (Aberdeen Squash Racquets Club)
 *
 * Copyright (c) 2006 Frontburner
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * Account activation form
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  19-Mar-2004  File created.
 * * * * * * * * * * * * * * * * * * * * * * * */

$memberid = NULL;     if (!empty($_POST['memberid'])) $memberid = strtoupper($_POST['memberid']);
if (!$memberid) $memberid = $_SESSION['memberid'];

$password1 = NULL;    if (!empty($_POST['password1'])) $password1 = $_POST['password1'];
$password2 = NULL;    if (!empty($_POST['password2'])) $password2 = $_POST['password2'];
$email = NULL;        if (!empty($_POST['email'])) $email = $_POST['email'];

if (empty($confirm_set))  $confirm_set = "N";
?>

<form action="activate.php" method="post" name="" id="">
  <table border="0" align="center" cellpadding="0" cellspacing="8">
    <tr>
      <td class="fld">Member ID</td>
      <td><? print $memberid; ?>
        <input name="memberid" type="hidden" id="memberid" size=6
        <? print 'value="'. $memberid . '">'; ?>
      </td>
    </tr>
    <tr>
      <td class="fld">Your name</td>
      <td><?php

      $sql = mysql_query("SELECT * FROM member WHERE memberid='$memberid'");
      $name_check = mysql_num_rows($sql);

      if ($name_check > 0) {
        if ($row = mysql_fetch_array($sql)) {
          foreach($row AS $key => $val) {
            $$key = stripslashes($val);
          }

          print $first_name . " " . $last_name;
          if (!empty($email)) $email_address = $email;
        }
      }
      ?></td>
    </tr>
    <tr>
      <td class="fld">Email Address</td>
      <td><input name="email" type="text" id="email" size=30
      <?php print 'value="'. $email_address . '">';?></td>
    </tr>
<?
      if ($confirm_set == "Y") {
?>
    <tr>
      <td><input name="password1" type="hidden" id="password1" size=12 <? print 'value="'.$password1.'">';?></td>
      <td><input name="password2" type="hidden" id="password2" size=12 <? print 'value="'.$password2.'">';?></td>
      <td><input name="confirm" type="hidden" id="confirm" size=12 value="Y"></td>
    </tr>
<?
      } else {
?>
    <tr>
      <td class="fld">Password</td>
      <td><input name="password1" type="password" id="password1" size=12></td>
    </tr>
    <tr>
      <td class="fld">Re-enter password</td>
      <td><input name="password2" type="password" id="password2" size=12></td>
    </tr>
<?
      }
?>
    <tr>
      <td>&nbsp;</td>
      <td><input class="button" type="submit" value="Login"></td>
    </tr>
  </table>
</form>
