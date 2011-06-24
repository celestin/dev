<?php
/* * * * * * * * * * * * * * * * * * * * * * * *
 * Relaxatub
 * Copyright (c) 2006,2009 Frontburner
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * Template: Top of every page
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  18-Jul-2006  File added to source control.
 * CAM  29-Mar-2007  10109 : Added link to Garden page (Decking).
 * CAM  14-Feb-2008  10243 : Updated look and feel.
 * CAM  14-Feb-2008  10243 : Highlight link associated with current page.
 * CAM  23-Feb-2008  10235 : Added Favourite Icon.
 * CAM  12-Apr-2008  10241 : Corrected HTML .
 * CAM  20-Aug-2008  10113 : Added AquaFinesse bottle beside Beachcomber logo.
 * CAM  08-Nov-2008  10236 : Added QuickShip and BarrelSauna.
 * CAM  11-Aug-2009  10470 : Added email icon and link.
 * CAM  11-Aug-2009  10472 : Added AECC Renovation and Selfbuild button.
 * CAM  01-Mar-2010  10586 : Remove AECC banner.
 * CAM  08-Mar-2010  10602 : Test for correct session variable.
 * CAM  24-Mar-2010  10603 : Added links for castlewood.
 * CAM  24-Jun-2011  10977 : Added Facebook at top of page.
 * CAM  24-Jun-2011  10978 : Added Google Analytics.
 * * * * * * * * * * * * * * * * * * * * * * * */

include_once 'main.php';
$member = NULL;  if (session_is_registered('member_person')) $member = $_SESSION['member_person'];
$loggedin = (session_is_registered('member_person') && session_is_registered('Relaxatub'));

if (empty($pageTitle)) {
  $pageTitle = $cfg['Site']['Name'];
} else {
  $pageTitle = $cfg['Site']['Name'] . " - $pageTitle";
}

?>
<html>
<head>
  <title><? print $pageTitle; ?></title>
  <meta name="Description" content="Hot Tubs Aberdeen, Scotland, UK, Spas.  Check out - <? print $pageTitle; ?>">
  <meta name="Keywords" content="hot, tubs, hottubs, beachcomber, scotland, uk, spa, spas, aberdeen, glasgow, edinburgh">

  <link href="relaxatub.css" rel=stylesheet type=text/css>
  <link rel="shortcut icon" href="favicon.ico" type="image/x-icon" />
</head>
<script type="text/javascript">
  var _gaq = _gaq || [];
  _gaq.push(['_setAccount', 'UA-24170059-1']);
  _gaq.push(['_trackPageview']);
  (function() {
    var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
    ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
    var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
  })();
</script>
<body marginwidth=0 marginheight=0 topmargin=0 leftmargin=0 rightmargin=0 id="<? echo $pageId; ?>">

<table cellspacing=5 cellpadding=0 border=0 width="100%" height="100%">

  <tr height="100%"><td valign="top" align="center"><table cellspacing=5 cellpadding=0 border=0>

  <tr>
    <td valign=top><table cellspacing=10 cellpadding=0 border=0 width=250>
      <tr><td align=center><a href="index.php"><img width=240 height=90 src="img/relaxatub2.png" border=0 alt="Beachcomber Hot Tubs"></a></td></tr>
<?
if ($loggedin) {
?>      <tr><td align=center><a class="nav" href="logout.php">logout</a></td></tr><?
} else {
?>      <tr><td align=center><a class="nav" href="login.php">login</a></td></tr><?
}
?>
      <tr><td><img src="img/f.gif"></td></tr>
      <tr><td align=center><a id="linktub300" class="nav" href="tub.php?series=300">300</a>
        <a id="linktub500" class="nav" href="tub.php?series=500">500</a>
        <a id="linktub700" class="nav" href="tub.php?series=700">700</a></td></tr>
      <tr><td align=center><a id="linkquickship" class="nav" href="quickship.php">quick ship!</a></td></tr>
      <tr><td><img src="img/f.gif"></td></tr>
      <tr><td align=center><a id="linkphoto" class="nav" href="photo.php">photo album</a></td></tr>
      <tr><td><img src="img/f.gif"></td></tr>
      <tr><td align=center><a id="linkaccessories" class="nav" href="accessories.php">accessories</a></td></tr>
      <tr><td align=center><a id="linkgarden" class="nav" href="garden.php">decking ideas</a></td></tr>
      <tr><td align=center><a id="linkcastlewood" class="nav" href="castlewood.php">short break with a hot tub</a></td></tr>
      <tr><td><img src="img/f.gif"></td></tr>
      <tr><td align=center><a id="linkbarrelsauna" class="nav" href="barrelsauna.php">barrel sauna</a></td></tr>
      <tr><td><img src="img/f.gif"></td></tr>
      <tr><td align=center><a id="linkprotec" class="nav" href="protec.php">protec</a></td></tr>
      <tr><td align=center><a id="linkevolution" class="nav" href="evolution.php">hot tub evolution</a></td></tr>
      <tr><td><img src="img/f.gif"></td></tr>
      <tr><td align=center><a id="linkcontact" class="nav" href="contact.php">contact us</a></td></tr>
      <tr><td align=center><table border="0">
      <tr>
        <td><a href="watercare.php"><img width=123 height=92 src="img/af/small.png" border=0 alt="Beachcomber Hot Tubs"></a></td>
        <td><a href="http://www.beachcomberhottubs.com/"><img width=123 height=118 src="img/bc4.gif" border=0 alt="Beachcomber Hot Tubs"></a></td>
      </tr>
      </table></td></tr>
    </table></td>
    <td valign=top>
    	<div id="fb-relaxatub"><div id="fb-root"></div><script src="http://connect.facebook.net/en_US/all.js#appId=155574457848908&amp;xfbml=1"></script><fb:like href="http://www.facebook.com/?sk=lf#!/pages/Relaxatub/119710291449980" send="true" width="650" show_faces="false" action="recommend" font="arial"></fb:like></div>
    	<div id="rxbox">
    	<table cellspacing=0 cellpadding=0 border=0 width="650" height="600">
      <tr>
        <td align=center class="rxtop">
        <div id="rxfeature">
        <ul>
            <li><a id="linkwater" href="water.php">water</a></li>
            <li><a id="linkhealth" href="health.php">health &amp; well-being</a></li>
            <li><a id="linkrelaxation" href="relaxation.php">relaxation</a></li>
            <li><a id="linkquality" href="quality.php">quality</a></li>
            <li><a id="linkcomfort" href="comfort.php">comfort</a></li>
            <li><a id="linkfaq" href="faq.php">faq</a></li>
        </ul>
        </div>
        </td>
        <td class="rxtop"><a title="Send us an email!" href="mailto:hazel@relaxatub.com?subject=Website%20Response"><img border=0 src="img/icon/mail_write.png"></a></td>
      </tr>
      <tr><td align=center valign=middle>

