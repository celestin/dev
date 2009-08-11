<?php
/* * * * * * * * * * * * * * * * * * * * * * * *
 * Airylea Motors Website
 * Copyright (c) 2006-2007 Frontburner
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * Contact Page Context
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  28-Aug-2008  10280 : File created.
 * CAM  05-Feb-2009  10280 : Added Page Id.
 * CAM  11-Aug-2009  10467 : Implemented First Found recommendations.
 * * * * * * * * * * * * * * * * * * * * * * * */

$title = "Services - Diesel Cars, Agricultural, Commercial, Marine, Plant &amp; Generators";
$pageId = "services";
include 'tpl/top.php';
?>
<h1>Services</h1>

<table border=0 width="100%" cellspacing=0 cellpadding=1>

  <tr>
    <td align=center><a href="cars.php" ><img src="img/serv/car1.jpg" alt="Car Diesels" border=1 width=210 height=130></a></td>
    <td align=center><a href="agricultural.php" ><img src="img/serv/agr1.jpg" alt="Agricultural" border=1 width=210 height=130></a></td>
  </tr><tr>
    <td align=center class=annot>Diesel Cars</td>
    <td align=center class=annot>Agricultural</td>
  </tr><tr>

    <td colspan=2 height=10>&nbsp;</td>

  </tr><tr>
    <td align=center><a href="marine.php" ><img src="img/serv/marine1.jpg" alt="Marine Diesels" border=1 width=210 height=130></a></td>
    <td align=center><a href="commercial.php" ><img src="img/serv/comm1.jpg" alt="Commercial Van and Truck Diesels" border=1 width=210 height=130></a></td>
  </tr><tr>
    <td align=center class=annot>Marine</td>
    <td align=center class=annot>Commercial</td>

  </tr><tr>

    <td colspan=2 height=10>&nbsp;</td>

  </tr><tr>
    <td align=center><a href="plant.php" ><img src="img/serv/plant1.jpg" alt="Plant and Generator Diesels" border=1 width=210 height=130></a></td>
    <td align=center>&nbsp;</td>
  </tr><tr>
    <td align=center class=annot>Plant &amp; Generators</td>
    <td align=center class=annot>&nbsp;</td>
  </tr>

</table>
<?
include 'tpl/bot.php';
?>