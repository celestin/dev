<?
/* * * * * * * * * * * * * * * * * * * * * * * *
 * Relaxatub
 * Copyright (c) 2010 Frontburner
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * Live Well Page
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  30-Mar-2010  10616 : File created.
 * CAM  31-Mar-2010  10616 : Added hybridlogo.
 * * * * * * * * * * * * * * * * * * * * * * * */

$pageId = "pagehybrid";
$pageTitle = "Hybrid";
$pageCss = "hybrid";
include "tpl/top.php";
?>

<div id="hybrid">

<h2>Hybrid Hot Tub</h2>

<table border=0 cellpadding=0 cellspacing=0 width="100%">
  <tr>
    <td>
      <p>Not all hot tubs are built alike...  Two leading energy saving design features must be in every Hybrid hot tub to
      lower the energy costs as confirmed by independent testing at the California Polytechnic State University:

      <ol>
        <li>maximise the amount of insulation you put in the hot tub cavity</li>
        <li>minimise the use of horsepower or motors to reduce the hot tub operation costs</li>
      </ol>
      </p>
    </td>
    <td id="hybridlogo" valign=top><img src="img/hy/hybrid1.png"></td>
  </tr>
</table>

<script type="text/javascript">
  AC_FL_RunContent( 'codebase','http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=9,0,28,0','width','680','height','375','src',
  'img/hy/hybrid','wmode','transparent','quality','high','pluginspage','http://www.adobe.com/shockwave/download/download.cgi?P1_Prod_Version=ShockwaveFlash',
  'movie','img/hy/hybrid' ); //end AC code
</script>
  <embed src="img/hy/hybrid.swf" wmode="transparent" quality="high" pluginspage="http://www.adobe.com/shockwave/download/download.cgi?P1_Prod_Version=ShockwaveFlash"
    type="application/x-shockwave-flash" width="680" height="375"></embed>
<noscript>
  <object classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=9,0,28,0" width="680" height="375">
    <param name="movie" value="img/hy/hybrid.swf">
    <param name="quality" value="high">
    <param name="wmode" value="transparent" />
    <embed src="img/hy/hybrid.swf" wmode="transparent" quality="high" pluginspage="http://www.adobe.com/shockwave/download/download.cgi?P1_Prod_Version=ShockwaveFlash"
      type="application/x-shockwave-flash" width="680" height="375"></embed>
  </object>
</noscript>


<table border=0 cellpadding=0 cellspacing=0 width="100%">

<tr>

  <td colspan=2>

    <h3>Seven extra benefits of Protec 4WALL Construction</h3>

  </td>

</tr><tr>

  <td>

    <a href="pdf/protec.pdf"><img border=0 src="img/hy/protec1.png" alt="Beachcomber Heatshield" /></a>

    <? pdfLink("pdf/protec.pdf", "Read more about Protec"); ?>

  </td>

  <td width="100%">

    <div id="protecbenefits">
      <table border=0 cellpadding=4 cellspacing=0>

        <tr>

          <td valign=top width="50%"><h4>1 Double Tiered Safety Entry Step</h4>
          <p>This custom built accessory gives you a safe, easy way to get in and out of your hot tub. It’s a tough built, quality insulated step.</p></td>

          <td valign=top><h4>5 Maximum Interior Space Design</h4>
          <p>With the external power source design, we can focus on form, fit and function for maximum space for people inside the hot tub.</p></td>

        </tr><tr>

          <td valign=top><h4>2 Natural Soundproofing</h4>
          <p>Maintenance free Enviroskirt, coupled with Protec 4WALL construction method gives you an integrated, quiet hot tub.</p></td>

          <td valign=top><h4>6 Quick Service Access</h4>
          <p>Our equipment technology design gives you quick disconnect union kits for easy service and accessibility.</p></td>

        </tr><tr>

          <td valign=top><h4>3 4WALL Insulation Package</h4>
          <p>All 4 walls are filled to keep heat in and cold out. It’s a Beachcomber Protec standard, versus the traditional 3 wall construction method.</p></td>

          <td valign=top><h4>7 Quiet, Efficient Operation</h4>
          <p>HushPump cleaning, heating, circulation and filtration gives you clean, sparkling water. It runs almost silent, 24/7/365.</p></td>

        </tr><tr>

          <td valign=top colspan=2><h4>4 Energy Efficient Operation</h4>
          <p>The Protec Construction Package is an integrated unit. It works together to give you the best quality, most energy efficient hot tub.</p></td>


        </tr>

      </table>
    </div>

  </td>

</tr>
</table>

<table border=0 cellpadding=0 cellspacing=0 width="100%">
<tr>

  <td colspan=2><h3>Beachcomber Heatshield</h3></td>

</tr><tr>

  <td valign=top>

  <p>Beachcomber Heatshield Covers insulate your hot tub just like a thermos bottle.
  Our heavy foam inserts keep the heat in and the cold out, saving you energy and money.
  This insulating cover keeps the heat that you pay for, where it belongs... in your hot tub!
  Beachcomber Heatshields, superior hand-made stitching and craftsmanship, quality and durability that are guaranteed for any climate.</p>

  <? pdfLink("pdf/heatshield.pdf", "Read more about our Heatshield"); ?>

  </td>

  <td align=right>
    <a href="pdf/heatshield.pdf"><img border=0 src="img/hy/heatshield1.png" alt="Beachcomber Heatshield"/></a>
  </td>
</tr>

</table>

</div>

<?
  include "tpl/bot.php";
?>