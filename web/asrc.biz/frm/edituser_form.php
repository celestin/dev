<?php
/* * * * * * * * * * * * * * * * * * * * * * * *
 * ASRC.biz (Aberdeen Squash Racquets Club)
 *
 * Copyright (c) 2006 Frontburner
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * Edit User Form
 *
 * $Id: newuser_form.php 44 2006-05-04 22:34:22Z craig $
 *
 * Who  When         Why
 * CAM  29-Jul-2006  10021 : File added.
 * * * * * * * * * * * * * * * * * * * * * * * */

$member_id = NULL;        if (!empty($_POST['member_id'])) $member_id = strtoupper($_POST['member_id']);
$member_parent = NULL;    if (!empty($_POST['member_parent'])) $member_parent = strtoupper($_POST['member_parent']);
$first_name = NULL;       if (!empty($_POST['first_name'])) $first_name = $_POST['first_name'];
$last_name = NULL;        if (!empty($_POST['last_name'])) $last_name = $_POST['last_name'];
$email_address = NULL;    if (!empty($_POST['email_address'])) $email_address = $_POST['email_address'];
$member_type = NULL;      if (!empty($_POST['member_type'])) $member_type = $_POST['member_type'];
$block_booker = NULL;     if (!empty($_POST['block_booker'])) $block_booker = $_POST['block_booker'];
$dob = NULL;              if (!empty($_POST['dob'])) $dob = $_POST['dob'];
$retry = NULL;            if (!empty($_POST['retry'])) $retry = $_POST['retry'];

$id = NULL;               if (!empty($_GET['member_id'])) $id = strtoupper($_GET['member_id']);

if (!empty($id)){
  $ssql = "SELECT memberid member_id,".
                 "parent member_parent,".
                 "first_name,".
                 "last_name,".
                 "email_address,".
                 "block_booker,".
                 "DATE_FORMAT(dob,'%d-%b-%Y') dob,".
                 "member_type ".
          "FROM member ".
          "WHERE memberid = '$id' ".
          "ORDER BY first_name";

  $sql = mysql_query($ssql) or die (mysql_error());

  if ($row = mysql_fetch_array($sql)) {
    foreach($row AS $key => $val) {
      $$key = stripslashes($val);
    }
  }
}
?>

<form action="edituser.php" method="post" name="" id="">
  <table border="0" align="center" cellpadding="0" cellspacing="8">
    <tr>
      <td class="fld">Member ID</td>
      <td><input name="member_id" type="text" id="member_id" size=6
      <?php print 'value="'. $member_id . '">';?></td>
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
      <td class="fld">Block booker?</td>
      <td><input name="block_booker" type="checkbox" id="block_booker"
      <? if ($block_booker == 1) echo "CHECKED "; ?> value=1></td>
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

          echo "<option ";

          if ($mtype == $member_type) echo "SELECTED ";

          echo "value=\"$mtype\">$type_name</option>";
        }
      }
      ?></select></td>
    </tr>
    <tr>
      <td>&nbsp;</td>
      <td><input name="retry" type="hidden" id="email_address" value="1">
          <input class="button" type="submit" value="Update"></td>
    </tr>
  </table>
</form>
