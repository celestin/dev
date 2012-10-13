<?php
/* * * * * * * * * * * * * * * * * * * * * * * *
 * Talisman WMS Users
 * Copyright (c) 2012 Front Burner
 *
 * Top of the page
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  05-Sep-2012  11128 : Added menu options and getObjRef.
 * CAM  13-Oct-2012  11128 : Added member 'override' and additional menu options.
 * * * * * * * * * * * * * * * * * * * * * * * */

include_once 'Main.php';

if (!empty($member_override)) {
    $_SESSION['memberid'] = $member_override;

	$s = Site::getSite($site_override);
    $_SESSION['siteid'] = $s->id;
    $_SESSION['sitefullname'] = $s->desc;
    $_SESSION['siteshortname'] = $s->shortname;

	$_SESSION['first_name'] = $firstname_override;
	$_SESSION['last_name'] = $lastname_override;
	$_SESSION['email_address'] = $member_override."@talisman-energy.com";
	$_SESSION['Talisman WMS Users'] = "Talisman WMS Users";

	$p = Person::getPerson($member_override);
	$p->firstname = $_SESSION['first_name'];
	$p->lastname = $_SESSION['last_name'];
	$p->email = $_SESSION['email_address'];
	$p->desc = $p->firstname . " " . $p->lastname;
	$_SESSION['member_person'] = $p;

	mysql_query("UPDATE member SET last_login=now() WHERE memberid='$username'");
}

$member = NULL;  if (session_is_registered('member_person')) $member = $_SESSION['member_person'];
$loggedin = (session_is_registered('member_person') && session_is_registered('Talisman WMS Users'));

if (empty($title)) {
  $title = $cfg['Site']['Name'];
} else {
  $title = $cfg['Site']['Name'] . " - $title";
}

function nvhtml($value) {
  if (empty($value)) return "&nbsp;";
  return $value;
}

?>
<head>
  <title><? echo $title;?></title>
  <link href="twms.css" rel=stylesheet type="text/css" />
  <script language="Javascript" src="date.js"></script>
  <script language="Javascript">
    function getObjRef(p_ref) {
      return document.all ? document.all[p_ref] : document.getElementById(p_ref);
    }
  </script>
</head>

<body topmargin=0 leftmargin=0>

<table border=0 cellpadding=0 cellspacing=0 align=center>
<tr><td><table border="0" cellpadding=0 cellspacing=0 width="1000" height="600" class=outerBox>
  <tr><td align="center"><img src="img/TalismanLogo-100.jpg" id="logo"></td></tr>

  <tr>
  <td valign=top><table border=0 cellpadding=4 cellspacing=0 width="100%" height="100%" class="thinBox">
    <tr><td class="title"><b><? echo $cfg['Site']['Name']; ?></b>&nbsp;-&nbsp;<? echo strftime("%a %d %b %H:%M"); ?></td>

    <td class="title" align=right><?php
      if ($loggedin) {
        echo $member->toHtmlString(true);
      } else {
        echo "&nbsp;";
      }
    ?></td>

    </tr>
    <tr><td colspan=2 class="topnav"><table border=0 cellpadding=0 cellspacing=0 class="topnav">
      <tr>
        <?
          if ($loggedin) {
?>
            <td><a class="nav" href="identify.php">identify</a><span class="sep">|</sep></td>
<?
            if ($member->isAdmin()) {
?>
            <td><a class="nav" href="verify.php">verify</a><span class="sep">|</sep></td>
            <td><a class="nav" href="search.php">search</a><span class="sep">|</sep></td>
            <td><a class="nav" href="identifysite.php">identify site</a><span class="sep">|</sep></td>
            <td><a class="nav" href="upload_tmax.php">upload TMAX</a><span class="sep">|</sep></td>
            <td><a class="nav" href="upload_ad.php">upload AD</a><span class="sep">|</sep></td>
<?
            }
?>
            <td><a class="nav" href="logout.php">logout</a><span class="sep">|</sep></td>
<?
          } else {
?>
            <td><a class="nav" href="login.php">login</a><span class="sep">|</sep></td>
<?
          }
        ?>
        <td><a class="nav" href="help.php">help</a></td>
      </tr>
    </table></td></tr>
    </table></td></tr>

    <tr><td colspan=2 width="100%" height="100%" valign=top style="padding:5px">
