<?
/* * * * * * * * * * * * * * * * * * * * * * * *
 * WestCoastExpress Website
 * Copyright (c) 2006-2007 Frontburner
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * Session Registration
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  13-Apr-2006  File created.
 * CAM  21-Dec-2006  10069 : Ensure login to West Coast Express is distinct.
 * CAM  11-Aug-2007  10149 : Prevent Apache crashes with Session variables.
 * * * * * * * * * * * * * * * * * * * * * * * */

include_once 'Main.php';

  $_SESSION['memberid'] = $memberid;
  $_SESSION['first_name'] = $first_name;
  $_SESSION['last_name'] = $last_name;
  $_SESSION['email_address'] = $email_address;
  $_SESSION['westcoastexpress_net'] = "westcoastexpress_net";

  $p = Person::getPerson($memberid);
  $_SESSION['member_person'] = $p;

  mysql_query("UPDATE member SET last_login=now() WHERE memberid='$memberid'");

?>
<script language="javascript">top.location.href="index.php";</script>
<?