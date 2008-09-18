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

?><p align="right"><img src="img/logo/bosch.png"></center>
<p><span class=bosch>Bosch</span> develops and manufactures diesel fuel injection systems
for trucks, marine generators and small marine vessels.</p>

<table cellspacing=0 cellpadding=0 align=center>
  <tr>
    <td class=thinBox><img src="img/supp/bosch/bosch_volvo1.jpg" alt="Truck Diesels"></td>
    <td width=50>&nbsp;</td>
    <td class=thinBox><img src="img/supp/bosch/bosch_boat1.jpg" alt="Small Marine Diesels"></td>
  </tr>
  <tr>
    <td align=center class=annot><span class=bosch>Bosch</span>
    Systems<br/>used by Volvo</td>

    <td>&nbsp;</td>

    <td align=center class=annot><span class=bosch>Bosch</span>
    Marine Systems</td>
  <tr>
</table>
<?
include 'tpl/bot.php';
?>
