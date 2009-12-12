<?php

$fwidth = isset($_POST['fwidth']) ? $_POST['fwidth'] : '';
$fheight = isset($_POST['fheight']) ? $_POST['fheight'] : '';
$ftitle = isset($_POST['ftitle']) ? $_POST['ftitle'] : '';
$ffile = isset($_POST['ffile']) ? $_POST['ffile'] : '';
$product = isset($_POST['product']) ? $_POST['product'] : '';
$sourcepage = isset($_POST['sourcepage']) ? $_POST['sourcepage'] : '';
$recepient = "flash@powersoftware.com";

$cr = "\r\n";

$to = $recepient;

$headers = "From: $recepient $cr";
$headers .= "MIME-Version: 1.0$cr";
$headers .= "Content-Type: text/html; charset=ISO-8859-1$cr";

$subject = "Flash Viewing of $product";

$message = "<html><head>$cr".
"<style type=\"text/css\">$cr".
"td,p,li {font-family:Arial,Sans Serif;font-size:11pt;}$cr".
"b {color:#666666}$cr".
"b.server {color:#6666FF}$cr".
"p.cpyrght {font-size:9pt; color:#6666FF;text-align:center;}$cr".
"</style></head><body>$cr".
"<p>A user viewed the <b>$product</b> Flash Presentation on " . strftime("<b>%a %d %b</b> at <b>%H:%M</b>"). ".</p>$cr$cr".
"<ul><li>Page <b>$sourcepage</b>.</li>$cr$cr".
"<li>Server <b class=server>" . $_SERVER[SERVER_NAME] . "</b>.</li>$cr$cr".
"<li>IP address <b>" . $_SERVER[REMOTE_ADDR] . "</b>.</li>$cr$cr".
"<li>Browser <b>" . $_SERVER[HTTP_USER_AGENT] . "</b>.</li></ul>$cr$cr".
"<p class=cpyrght>Copyright &copy; " . strftime("%Y"). " PowerSoftware.com.  All Rights Reserved.</p>$cr$cr".
"</body></html>";

mail($to,$subject,$message,$headers);

/*
<OBJECT classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000"
        codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=5,0,0,0"
        WIDTH="<? echo $fwidth; ?>" HEIGHT="<? echo $fheight; ?>">
  <PARAM NAME=movie VALUE="<? echo $fheight; ?>">
  <PARAM NAME=loop VALUE=false>
  <PARAM NAME=quality VALUE=high>
  <PARAM NAME=bgcolor VALUE=#FFFFFF>
  <EMBED src="<? echo $ffile; ?>" loop=false quality=high bgcolor=#FFFFFF
    WIDTH="<? echo $fwidth; ?>" HEIGHT="<? echo $fheight; ?>"
    TYPE="application/x-shockwave-flash"
    PLUGINSPAGE="http://www.macromedia.com/shockwave/download/index.cgi?P1_Prod_Version=ShockwaveFlash"></EMBED>
</OBJECT>
*/

?>
<html>
<head><title><? echo $ftitle; ?></title></head>
<body bgcolor="#FFFFFF" marginwidth=0 marginheight=0 topmargin=0 leftmargin=0 rightmargin=0>

<object classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000"
        codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=7,0,19,0"
        width="<? echo $fwidth; ?>" height="<? echo $fheight; ?>" title="<? echo $product; ?>">
      <param name="movie" value="<? echo $ffile; ?>" />
      <param name="quality" value="high" />
      <embed src="<? echo $ffile; ?>" quality="high"
        pluginspage="http://www.macromedia.com/go/getflashplayer"
        type="application/x-shockwave-flash" width="<? echo $fwidth; ?>" height="<? echo $fheight; ?>"></embed>
    </object>

</body>
</html>
