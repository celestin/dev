<?
/* * * * * * * * * * * * * * * * * * * * * * * *
 * ASRC.biz (Aberdeen Squash Racquets Club)
 *
 * Copyright (c) 2006-2007 Frontburner
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * Session Registration
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  19-Mar-2004  File created.
 * CAM  19-Jan-2006  9 : Block booking.
 * CAM  06-Feb-2006  8 : Added news for non-Admin members.
 * CAM  22-Jun-2007  10132 : Removed session_register.
 * * * * * * * * * * * * * * * * * * * * * * * */

  include_once 'Main.php';

  $_SESSION['memberid'] = $memberid;
  $_SESSION['first_name'] = $first_name;
  $_SESSION['last_name'] = $last_name;
  $_SESSION['email_address'] = $email_address;

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
?>