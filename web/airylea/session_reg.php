<?
/* * * * * * * * * * * * * * * * * * * * * * * *
 * Airylea Motors Website
 * Copyright (c) 2008 Frontburner
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * Session Registration
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  28-Aug-2008  10280 : File created.
 * * * * * * * * * * * * * * * * * * * * * * * */

include_once 'Main.php';

  $_SESSION['memberid'] = $memberid;
  $_SESSION['first_name'] = $first_name;
  $_SESSION['last_name'] = $last_name;
  $_SESSION['email_address'] = $email_address;
  $_SESSION['airylea_co_uk'] = "airylea_co_uk";

  $p = Person::getPerson($memberid);
  $_SESSION['member_person'] = $p;

  mysql_query("UPDATE member SET last_login=now() WHERE memberid='$memberid'");

?>
<script language="javascript">top.location.href="index.php";</script>
<?