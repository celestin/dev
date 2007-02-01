<?php
/* * * * * * * * * * * * * * * * * * * * * * * *
 * First Summerhouses
 * Copyright (c) 2006 Frontburner
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * Bottom of the page
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  10-Feb-2006  File created.
 * CAM  21-Sep-2006  10029 : Include Google Adwords.
 * CAM  01-Feb-2007  10081 : Ignore Google Adwords when running locally.
 * * * * * * * * * * * * * * * * * * * * * * * */
?>
    </td></tr></table>
  </td></tr>
  <tr><td colspan=2 class="cpyrght">Site designed and maintained by <a href="http://www.frontburner.co.uk/">frontburner.co.uk</a></td></tr>
</table>
<?
if (strpos(strtolower($_SERVER['SERVER_NAME']), "local") !== FALSE) {
?>
<script src="http://www.google-analytics.com/urchin.js" type="text/javascript">
</script>
<script type="text/javascript">
_uacct = "UA-696152-1";
urchinTracker();
</script>
<?
}
?>
</body>
</html>
