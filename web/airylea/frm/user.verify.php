<?php
/* * * * * * * * * * * * * * * * * * * * * * * *
 * Airylea Motors Website
 * Copyright (c) 2008 Frontburner
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * Email Verification Resend form
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  28-Aug-2008  10280 : File created.
 * * * * * * * * * * * * * * * * * * * * * * * */

?>

<form action="resend.php" method="post" name="" id="">
  <table border="0" align="center" cellpadding="0" cellspacing="8">
    <tr>
      <td class="fld">Username</td><td><? echo $memberid; ?></td>
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

          echo $first_name . " " . $last_name;
        }
      }
      ?></td>
    </tr>
    <tr>
      <td class="fld">Email Address</td>
      <td><input name="email_address" type="text" id="email_address" size=30
      <? echo 'value="'. $email_address . '">';?></td>
    </tr>
    <tr>
      <td>&nbsp;</td>
      <td>
        <input class="button" type="submit" value="Resend">
        <input name="username" type="hidden" id="username" size=6 value="<? echo $memberid; ?>">
        <input name="verify_code" type="hidden" id="verify_code" size=6 value="<? echo $verify_code; ?>">
      </td>
    </tr>
  </table>
</form>
