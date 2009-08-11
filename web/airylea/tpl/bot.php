<?php
/* * * * * * * * * * * * * * * * * * * * * * * *
 * Airylea Motors Website
 * Copyright (c) 2008 Frontburner
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * Bottom of the page
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  28-Aug-2008  10280 : File created.
 * CAM  05-Feb-2009  10280 : Added auto copyright year.
 * CAM  11-Aug-2009  10467 : Implemented First Found recommendations.
 * * * * * * * * * * * * * * * * * * * * * * * */

$footer = $cfg['Site']['Location'];

if (!empty($title)) {
  $footer = $title . ", $footer.";
}

?>
</td></tr>
<tr><td colspan=2 class="cpyrght">
<br><? echo $footer; ?>
<br>Copyright &copy; <? echo strftime("%Y"); ?> Airylea Motors. All rights reserved.
<br>Site designed and maintained by <a href="http://www.frontburner.co.uk/">frontburner.co.uk</a></td></tr>
</table></td>
</tr></table>
</body>
</html>