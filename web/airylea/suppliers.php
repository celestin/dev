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

?><table border=0 cellpadding=0 cellspacing=0 width="100%">
<tr>
  <td colspan=2 width=700>
    <h1>Welcome to Airylea Motors</h1>
    <p><span class=am>Airylea Motors</span> are specialists in all types of diesel
    fuel injection systems.</p>

    <p>With over 35 years in the business we have the experience to service and repair
    all your diesel fuel systems quickly and efficiently. We deal with both marine and
    commercial vehicle fuel injection systems as well as most other types of industrial
    diesel applications.</p>

    <p>Although we are based in Aberdeen, UK, we do business all over Scotland.</p>

    <p>We stock and can order spare parts for
      <a href="lorange.php">L'Orange</a>,
      <a href="delphi.php">Delphi</a>,
      <a href="bosch.php">Bosch</a>,
      <a href="stanadyne.php">Stanadyne</a> and
      <a href="woodward.php">Woodward</a>.
    </p>
  </td>
</tr>
</table>

<?
include 'tpl/bot.php';
?>
