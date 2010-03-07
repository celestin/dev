<?
/* * * * * * * * * * * * * * * * * * * * * * * *
 * WEBSITE_NAME
 * Copyright (c) 2007 frontburner.co.uk
 *
 * Session Registration
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  27-Dec-2005  File created.
 * CAM  07-Mar-2010  10601 : Store Person object in session (rather than simply id).
 * * * * * * * * * * * * * * * * * * * * * * * */

include_once 'Main.php';

$_SESSION['memberid'] = $memberid;
$_SESSION['first_name'] = $first_name;
$_SESSION['last_name'] = $last_name;
$_SESSION['email_address'] = $email_address;
$_SESSION['WEBSITE_NAME'] = "WEBSITE_NAME";

$p = Person::getPerson($memberid);
$_SESSION['member_person'] = $p;

mysql_query("UPDATE member SET last_login=now() WHERE memberid='$memberid'");

?>
<script language="javascript">top.location.href="index.php";</script>
<?