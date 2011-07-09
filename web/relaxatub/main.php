<?
/* * * * * * * * * * * * * * * * * * * * * * * *
 * Relaxatub
 * Copyright (c) 2006 Frontburner
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * General Includes
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  18-Jul-2006  File added to source control.
 * CAM  30-Mar-2010  10616 : Added pdfLink.
 * * * * * * * * * * * * * * * * * * * * * * * */

include_once dirname(__FILE__).'/config.php';
include_once dirname(__FILE__).'/db.php';
include_once dirname(__FILE__).'/WEB-INF/inc.php';
include_once dirname(__FILE__).'/util.php';

function pdfLink($pdfFile, $linkText) {
?>
<table border=0 cellpadding=4 cellspacing=0 align=center>
  <tr>
    <td valign=middle><a href="<? echo $pdfFile; ?>"><img border=0 src="img/pdf_40.png"></a></td>
    <td valign=middle><a href="<? echo $pdfFile; ?>"><? echo $linkText; ?></a></td>
  </tr>
</table>
<?
}

session_start();

?>