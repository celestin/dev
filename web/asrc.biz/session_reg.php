<?
/* * * * * * * * * * * * * * * * * * * * * * * *
 * Session Registration
 * Copyright (c) 2004-2006 frontburner.co.uk
 *
 * Who  When         Why
 * CAM  19-Mar-2004  File created.
 * CAM  19-Jan-2006  9 : Block booking.
 * CAM  06-Feb-2006  8 : Added news for non-Admin members.
 * * * * * * * * * * * * * * * * * * * * * * * */

  include_once 'Main.php';

  session_register('memberid');
  $_SESSION['memberid'] = $memberid;
  session_register('first_name');
  $_SESSION['first_name'] = $first_name;
  session_register('last_name');
  $_SESSION['last_name'] = $last_name;
  session_register('email_address');
  $_SESSION['email_address'] = $email_address;

  session_register('member_person');
  $p = Person::getPerson($memberid);
  $_SESSION['member_person'] = $p;

  mysql_query("UPDATE member SET last_login=now() WHERE memberid='$memberid'");


  if ($p->isAdmin()) {
?>
<script language="javascript">top.location.href="mybookings.php";</script>
<?
  } else {
?>
<script language="javascript">top.location.href="news.php";</script>
<?
  }