<?php
/* * * * * * * * * * * * * * * * * * * * * * * *
 * Airylea Motors Website
 * Copyright (c) 2008 Frontburner
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * Home Page Context
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  18-Sep-2008  10280 : File created.
 * * * * * * * * * * * * * * * * * * * * * * * */

$title = "Welcome";
include 'tpl/top.php';

global $flash;

showFlash();

?><p align="right"><img src="img/logo/stanadyne.png"></p>
<p><span class=stanadyne>Stanadyne</span> develops and manufactures diesel fuel injection systems
for a wide variety of applications, including tractors and generators.</p>

<table cellspacing=0 cellpadding=0 align=center>
  <tr>
    <td class=thinBox><img src="img/supp/stanadyne/stanadyne_tractor.gif" alt="Tractor Diesels"></td>
  </tr><tr>
    <td align=center class=annot><span class=stanadyne>Stanadyne</span>
    Systems used by John Deere</td>
  <tr>
</table>
<?
include 'tpl/bot.php';
?>
