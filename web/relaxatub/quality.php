<?
/* * * * * * * * * * * * * * * * * * * * * * * *
 * Relaxatub
 * Copyright (c) 2006 Frontburner
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * Quality Page
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  18-Jul-2006  File added to source control.
 * * * * * * * * * * * * * * * * * * * * * * * */

$pageTitle = "Quality";
include "tpl/top.php";
?>

<script language="javascript">
  var currentItem = null;

  var cont = new Array();
  cont["01"] = new Array("Safe maintenance-free handrails",   "no leaks, rusting or discolouration.");
  cont["02"] = new Array("Interchangeable recessed jets",     "the ultimate hydrotherapy.");
  cont["03"] = new Array("Gravity Floor drain",               "easy, total drainage.");
  cont["04"] = new Array("Large footwell",                    "plenty of space and comfort.");
  cont["05"] = new Array("Contoured Seating",                 "designed for total relaxation.");
  cont["06"] = new Array("Safety Step",                       "safe, easy entry to the hot tub.");
  cont["07"] = new Array("Micro Filter",                      "for safe, clean, filtered water.");
  cont["08"] = new Array("Digital Control Panel",             "total control at the touch of a button.");

  function showDiv(item, x, y) {
    if (currentItem == item) return;

    var d = document.all.desc;
    var img = document.all.qualImg;

    d.style.width = 200;
    d.style.height = 50;
    d.style.left = img.offsetLeft + x - 25;
    d.style.top = img.offsetTop + y-54;
    d.innerHTML = "<b>" + cont[item][0] + "</b>" + "... " + cont[item][1];
    d.className = "popup";
    d.style.display = "inline";

    currentItem = item;
  }

  function hideDiv() {
    var d = document.all.desc;
    d.style.display = "none";
    currentItem = null;
  }
</script>

<table border=0 cellpadding=0 cellspacing=8 align=left>

<tr>

  <td>
    <p align=left><img src="img/tt/quality.gif" width="70" height="27" alt="Beachcomber Quality"></p>

    <p class="desc">&quot;Here is my best quality and here is my lower quality,&quot; are words
    no Beachcomber customer will ever hear.  Every Beachcomber Hot Tub is built to the same
    exacting standards, the same quality and guarantee no matter which model you choose.</p>

    <p class="desc">You get to choose the model and features you want knowing that the Hot Tub
    you have purchased is driven by quality and not by price.</p>
  </td>

  <td valign=top><img style="position:relative" id=qualImg src="img/qa/qual.gif" width="428" height="416" usemap="#qual" border="0" alt="Aspects of Beachcomber Hot Tub Quality"></td>

</tr><tr>

  <td colspan=2>
    <p class="desc">Available in a variety of cabinet finishes, from the traditional Western Red Cedar
    with superb lasting qualities to the Enviroskirt maintenance-free option.  Every cabinet is built to last.</p>
  </td>

</tr>

</table>

<?
  include "tpl/bot.php";
?>

<MAP NAME="qual">
  <AREA SHAPE=RECT onmouseover="javascript:showDiv('08',149,371);" onmouseout="javascript:hideDiv();" COORDS="149,371,207,394">
  <AREA SHAPE=RECT onmouseover="javascript:showDiv('07',3,339);" onmouseout="javascript:hideDiv();" COORDS="3,339,56,366">
  <AREA SHAPE=RECT onmouseover="javascript:showDiv('06',100,303);" onmouseout="javascript:hideDiv();" COORDS="100,303,141,331">
  <AREA SHAPE=RECT onmouseover="javascript:showDiv('05',297,251);" onmouseout="javascript:hideDiv();" COORDS="297,251,368,278">
  <AREA SHAPE=RECT onmouseover="javascript:showDiv('04',213,232);" onmouseout="javascript:hideDiv();" COORDS="213,232,285,258">
  <AREA SHAPE=RECT onmouseover="javascript:showDiv('03',188,172);" onmouseout="javascript:hideDiv();" COORDS="188,172,235,195">
  <AREA SHAPE=RECT onmouseover="javascript:showDiv('02',352,77);" onmouseout="javascript:hideDiv();" COORDS="352,77,402,106">
  <AREA SHAPE=RECT onmouseover="javascript:showDiv('01',201,4);" onmouseout="javascript:hideDiv();" COORDS="201,4,272,27">
</MAP>

<div id=desc style="position:absolute"></div>
