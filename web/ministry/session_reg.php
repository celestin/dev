<?
/* * * * * * * * * * * * * * * * * * * * * * * *
 * Ministry Search Engine
 * Copyright (c) 2007 frontburner.co.uk
 *
 * Session Registration
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  29-Jul-2007  File created.
 * * * * * * * * * * * * * * * * * * * * * * * */

include_once 'Main.php';

$_SESSION['memberid'] = $memberid;
$_SESSION['first_name'] = $first_name;
$_SESSION['last_name'] = $last_name;
$_SESSION['email_address'] = $email_address;
$_SESSION['Ministry Search Engine'] = "Ministry Search Engine";

$p = Person::getPerson($memberid);
$_SESSION['member_person'] = $p;

mysql_query("UPDATE member SET last_login=now() WHERE memberid='$memberid'");

?>
<script language="javascript">top.location.href="index.php";</script>
<?