<?php
/* * * * * * * * * * * * * * * * * * * * * * * *
 * ASRC.biz (Aberdeen Squash Racquets Club)
 *
 * Copyright (c) 2006 Frontburner
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * New User Form
 *
 * $Id: activate.php 39 2006-05-04 22:27:43Z craig $
 *
 * Who  When         Why
 * CAM  19-Mar-2004  File created.
 * * * * * * * * * * * * * * * * * * * * * * * */

$member_new = NULL;       if (!empty($_POST['member_new'])) $member_new = strtoupper($_POST['member_new']);
$member_parent = NULL;    if (!empty($_POST['member_parent'])) $member_parent = strtoupper($_POST['member_parent']);
$first_name = NULL;       if (!empty($_POST['first_name'])) $first_name = $_POST['first_name'];
$last_name = NULL;        if (!empty($_POST['last_name'])) $last_name = $_POST['last_name'];
$email_address = NULL;    if (!empty($_POST['email_address'])) $email_address = $_POST['email_address'];
$member_type = NULL;      if (!empty($_POST['member_type'])) $member_type = $_POST['member_type'];
$dob = NULL;              if (!empty($_POST['dob'])) $dob = $_POST['dob'];
$retry = NULL;            if (!empty($_POST['retry'])) $retry = $_POST['retry'];

?>

<form action="newuser.php" method="post" name="" id="">
  <table border="0" align="center" cellpadding="0" cellspacing="8">
    <tr>
      <td class="fld">Member ID</td>
      <td><input name="member_new" type="text" id="member_new" size=6
      <?php print 'value="'. $member_new . '">';?></td>
    </tr>
    <tr title="Enter the parent or main Membership No. for Family/Corporate memberships">
      <td class="fldopt">Parent Member ID</td>
      <td><input name="member_parent" type="text" id="member_parent" size=6
      <?php print 'value="'. $member_parent . '">';?></td>
    </tr>
    <tr>
      <td class="fld">First name</td>
      <td><input name="first_name" type="text" id="first_name" size=15
      <?php print 'value="'. $first_name . '">';?></td>
    </tr>
    <tr>
      <td class="fld">Surname</td>
      <td><input name="last_name" type="text" id="last_name" size=15
      <?php print 'value="'. $last_name . '">';?></td>
    </tr>
    <tr>
      <td class="fld">Date of Birth</td>
      <td><input name="dob" type="text" id="dob" size=10 onChange="checkDate(this);"
      <?php print 'value="'. $dob . '">';?></td>
    </tr>
    <tr>
      <td class="fld">Email Address</td>
      <td><input name="email_address" type="text" id="email_address" size=30
      <?php print 'value="'. $email_address . '">';?></td>
    </tr>
    <tr>
      <td class="fld">Membership Type</td>
      <td><select name="member_type" id="member_type"><?php

      $sql = mysql_query("SELECT member_type mtype, type_name FROM member_type ".
                         "WHERE valid=1 ORDER BY disp_order");
      $name_check = mysql_num_rows($sql);

      if ($name_check > 0) {
        while ($row = mysql_fetch_array($sql)) {
          foreach($row AS $key => $val) {
            $$key = stripslashes($val);
          }

          print "<option ";

          if ($mtype == $member_type) print "SELECTED ";

          print "value=\"" . $mtype. "\">" . $type_name . "</option>";
        }
      }
      ?></select></td>
    </tr>
    <tr>
      <td>&nbsp;</td>
      <td><input name="retry" type="hidden" id="email_address" value="1">
          <input class="button" type="submit" value="Create/Update"></td>
    </tr>
  </table>
</form>
