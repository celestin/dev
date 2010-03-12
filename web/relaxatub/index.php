<?php
/* * * * * * * * * * * * * * * * * * * * * * * *
 * Relaxatub
 * Copyright (c) 2006,2008 Frontburner
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * Home Page
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  18-Jul-2006  File added to source control.
 * CAM  24-Sep-2006  10031 : Added 350SE advert to home page.
 * CAM  07-Oct-2006  10055 : Added October offer and Finance Deal.
 * CAM  25-Nov-2006  10055 : Added Typical 0% APR.
 * CAM  16-Dec-2006  10055 : Removed Interest-free credit offer.
 * CAM  29-Mar-2007  10109 : Exposed original design until "Beach Scene" is created.
 * CAM  30-Oct-2007  10197 : Added Christmas 2007 image.
 * CAM  14-Feb-2008  10243 : Reverted back to standard page.
 * CAM  23-Feb-2008  10235 : Added Random Image and Tub Series below.
 * CAM  17-May-2008  10232 : Corrected links for 350H.
 * CAM  20-Aug-2008  10113 : Added AquaFinesse logo under tubs.
 * CAM  20-Aug-2008  10284 : Added "30 years" logo under tubs.
 * CAM  11-Aug-2009  10472 : Added AECC Renovation and Selfbuild banner.
 * CAM  01-Mar-2010  10586 : Remove AECC banner.
 * * * * * * * * * * * * * * * * * * * * * * * */

$pageTitle = "Home";
include_once 'main.php';
include "tpl/top.php";

$randomImage = new RandomImage("img/re");
?>

<div id="RandomImage">

<img src="<? echo $randomImage->GetRandomImage(); ?>" width="538" height="301">
<table border=0 width="538">
  <tr>
    <td align=center><a href="tub.php?tub=350"><img border=0 src="img/tub/series/300.png" width="120"></a></td>
    <td align=center><a href="tub.php?tub=550"><img border=0 src="img/tub/series/500.png" width="120"></a></td>
    <td align=center><a href="tub.php?tub=750"><img border=0 src="img/tub/series/700.png" width="120"></a></td>
  </tr>
  <tr>
    <td align=center><a class="nav" href="tub.php?tub=350">300 series</a></td>
    <td align=center><a class="nav" href="tub.php?tub=550">500 series</a></td>
    <td align=center><a class="nav" href="tub.php?tub=750">700 series</a></td>
  </tr>
  <tr>
    <td align=center colspan="2"><div id="AquaFinesseLogo"><a href="watercare.php"><img border=0 src="img/af/logosmall.png" width="300" height="53"></a></div></td>
    <td align=center><div id="AquaFinesseLogo"><img border=0 src="img/30.png" width="79" height="99"></div></td>
  </tr>
</table>
</div>

<!--
      <table border=0 cellpadding=5 valign=middle>
      <tr><td align=center><img src="img/xmas07.jpg" width=600 height=460></td></tr>
      </table>
<!--
<!--

      <table border=0 cellspacing=0 cellpadding=0 valign=middle>
      <tr><td><img src="img/pro/2006oct1.jpg" width=620 height=355></td></tr>
      <tr><td><img src="img/pro/2006oct2.jpg" width=620 height=355></td></tr>
      </table>
<!--
<div class="promotion" style="position:relative; z-index:1; left:-180px; top:-330px; width:200px;"><p class="promotion">From <b>25th September 2006</b> to
<b>15th December 2006</b> you can buy a
Beachcomber Stock Hot Tub on</p>

<p class="promotion"><b>12 months interest free credit</b>,</p>

<p class="promotion">or if you prefer you can</p>

<p class="promotion"><b>Buy Now, Pay in 6 months</b>...</p>

<p class="promotion">the choice is yours!</p>

<p class="legal">Typical 0% APR</p></div>
-->

<!--
      <table border=0 cellpadding=5 valign=middle>

      <tr><td align=center><table border=0 cellpadding=0 cellspacing=0>
      <tr>
        <td><a href="health.php"><img width="121" height="120" src="img/fr1a.gif" border=0 alt="Health & Well-being"></a></td>
        <td valign=top><a href="health.php"><img width="176" height="50" src="img/fr1b.gif" border=0 alt="Health & Well-being"></a></td>
      </tr>
      </table></td></tr>

      <tr><td align=center><table border=0 cellpadding=0 cellspacing=0>
      <tr>
        <td><a href="water.php"><img width="121" height="120" src="img/fr2a.gif" border=0 alt="Water"></a></td>
        <td valign=top width=140><a href="water.php"><img width="64" height="49" src="img/fr2b.gif" border=0 alt="Water"></a></td>
        <td valign=top width=140 align=right><a href="comfort.php"><img width="80" height="50" src="img/fr3b.gif" border=0 alt="Comfort"></a></td>
        <td><a href="comfort.php"><img width="122" height="120" src="img/fr3a.gif" border=0 alt="Comfort"></a></td>
      </tr>
      </table></td></tr>

      <tr><td align=center><table border=0 cellpadding=0 cellspacing=0>
      <tr>
        <td><a href="quality.php"><img width="121" height="120" src="img/fr4a.gif" border=0 alt="Quality"></a></td>
        <td valign=top width=100><a href="quality.php"><img width="70" height="49" src="img/fr4b.gif" border=0 alt="Quality"></a></td>
        <td valign=top><a href="relaxation.php"><img width="99" height="50" src="img/fr5b.gif" border=0 alt="Relaxation"></a></td>
        <td><a href="relaxation.php"><img width="122" height="120" src="img/fr5a.gif" border=0 alt="Relaxation"></a></td>
      </tr>
      </table></td></tr>

      </table>
 -->
<?
  include "tpl/bot.php";
?>