<?php
/* * * * * * * * * * * * * * * * * * * * * * * *
 * SourceCodeMetrics.com
 * Copyright (c) 2006 SourceCodeMetrics.com
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * Home Page Context
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  18-Nov-2006  File created.
 * * * * * * * * * * * * * * * * * * * * * * * */

$title = "Home";
$menuOption = "Home";

include 'tpl/top.php';
?>

<p class="title">Mission Statement</p>

<p>SourceCodeMetrics.com offers high quality, accurate source code measurement solutions for traditional and changed line of code metrics.</p>

<p>Our automated source code metrics tools, <a href="products.php">Krakatau Essential Project Manager (KEPM)</a> and
<a href="products.php">Essential Project Manager (EPM)</a>
measure changed, added (new), deleted SLOC (source lines of code)
and changed, added (new), deleted LLOC (logical lines of code - normally by counting semi-colon in source).</p>

<p>LOC metrics, including Halstead complexity metrics, are measured for Projects and Files for many popular languages:</p>

<table border=0 align=center cellpadding=4>
<tr>
  <td><img src="img/ico/lang/ada.png"></td><td><b>Ada</b> metrics</td>
  <td><img src="img/ico/lang/oracle.png"></td><td><b>Oracle PL/SQL</b> metrics</td>
</tr>
<tr>
  <td><img src="img/ico/lang/asp.png"></td><td><b>ASP/ASP.net</b> metrics</td>
  <td><img src="img/ico/lang/perl.png"></td><td><b>Perl</b> metrics</td>
</tr>
<tr>
  <td><img src="img/ico/lang/cpp.png"></td><td><b>C++</b> metrics</td>
  <td><img src="img/ico/lang/php.png"></td><td><b>PHP</b> metrics</td>
</tr>
<tr>
  <td><img src="img/ico/lang/cs.png"></td><td><b>C#</b> metrics</td>
  <td><img src="img/ico/lang/vb.png"></td><td><b>VB/VB.net</b> metrics</td>
</tr>
<tr>
  <td><img src="img/ico/lang/java.png"></td><td colspan=3><b>Java</b> metrics</td>
</tr>

</table>

<p>Our new ASP and PHP metrics include distinguish between HTML and native LOC/SLOC as well as changed SLOC/LLOC.</p>

<p>Our professional software metric tools measure changed SLOC/LLOC for all these languages. Other languages can be added on request.</p>

<?
include 'tpl/bot.php';
?>


