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

$title = "Products";
$menuOption = "Products";

include 'tpl/top.php';
?>

<p class="title">Essential Project Manager (EPM)</p>

<p class="strapline">The multi-language metrics solution for measuring changed, added and deleted source lines of code.</p>

<p>EPM is a command line (batch mode) tool that can be easly integrated into your build process to
automatically measure both the size of your source code and the number of "new, changed and deleted" lines
of source code across the entire project and in each individual source file. Of course EPM also shows which
files have been removed, added and deleted across the project as a whole. It does this by referencing the
new version of the source code project against the previous or any other prior version of your project.</p>

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

<p class="title">Krakatau Essential Project Manager (KEPM)</p>

<p class="strapline">A graphical user interface for EPM...  manage multi-language projects easily!</p>

<p>Krakatau Essential PM makes using EPM (our market leading changed SLOC) tool even easier.
Featuring a carefully designed GUI to facilitate fast and efficient project creation Krakatau EPM
allows software professional to compare two versions of a software project and within seconds view
changed, new and deleted files and SLOC values. Krakatau EPM enables the user to take snapshots of the
software project and pinpoint areas of the source code that are changing too frequently or unexpectedly
(without authorisation). In this respect, project management, quality and control are clearly improved.</p>

<?
include 'tpl/bot.php';
?>