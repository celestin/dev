<?
/* * * * * * * * * * * * * * * * * * * * * * * *
 * West Coast Express Website
 * Copyright (c) 2006 Frontburner
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * Session Registration
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  13-Apr-2006  File created.
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
session_register('special_user');
$_SESSION['user_level'] = $user_level;

session_register('member_person');
$_SESSION['member_person'] = Person::getPerson($memberid);

mysql_query("UPDATE member SET last_login=now() WHERE memberid='$memberid'");

?>
<script language="javascript">top.location.href="index.php";</script>
<?