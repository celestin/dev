<?
/* * * * * * * * * * * * * * * * * * * * * * * *
 * Relaxatub
 * Copyright (c) 2006 Frontburner
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * Home Page
 *
 * $Id: activate.php 84 2006-05-11 18:55:49Z craig $
 *
 * Who  When         Why
 * CAM  18-Jul-2006  File added to source control.
 * CAM  24-Sep-2006  10031 : Added 350SE advert to home page.
 * CAM  07-Oct-2006  10055 : Added October offer and Finance Deal.
 * CAM  25-Nov-2006  10055 : Added Typical 0% APR.
 * CAM  16-Dec-2006  10055 : Removed Interest-free credit offer.
 * CAM  29-Mar-2007  10109 : Exposed original design until "Beach Scene" is created.
 * * * * * * * * * * * * * * * * * * * * * * * */

$pageTitle = "Home";
include "tpl/top.php";
?>
<!--
      <table border=0 cellpadding=5 valign=middle>
      <tr><td align=center><img src="img/xmas01.jpg" width=269 height=415></td></tr>
      </table>

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

<?
  include "tpl/bot.php";
?>