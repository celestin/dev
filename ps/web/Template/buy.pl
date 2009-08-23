#!/bin/perl

# Define fairly-constants
$cg_international="0" ;
$cg_europe="1" ;
$cg_uk="2" ;
$cartidfile = '/u/p/o/w/powersft/docs/cartid' ;

# Mail settings
$mailprog = '/usr/lib/sendmail' ;
$recipient = 'sales@powersoftware.com' ;

# Name of the template HTML file which will be used to build new download page
$newfile = '/u/p/o/w/powersft/docs/template.html' ;
# Separator text in above file, giving point of insertion
$separator = '<!--start-->' ;

# Title Separator & Title Text
$titleSeparator = '<!--titleText-->' ;
$titleText = 'Buy Online' ;

# Body, On Load event
$onLoadSeparator = "<!--onLoad-->" ;

# JavaScript to be inserted into the page
$scriptSeparator = '<!--Javascript-->' ;
$scriptFile = '/u/p/o/w/powersft/docs/script/buy.js' ;


# Print out a content-type for HTTP/1.0 compatibility
print "Content-type: text/html\n\n" ;

# Get the input
read(STDIN, $buffer, $ENV{'CONTENT_LENGTH'}) ;

# Split the name-value pairs
@pairs = split(/&/, $buffer);

foreach $pair (@pairs)
{
    ($name, $value) = split(/=/, $pair);

    # Un-Webify plus signs and %-encoding
    $value =~ tr/+/ /;
    $value =~ s/%([a-fA-F0-9][a-fA-F0-9])/pack("C", hex($1))/eg;

    # Stop people from using subshells to execute commands
    # Not a big deal when using sendmail, but very important
    # when using UCB mail (aka mailx).
    # $value =~ s/~!/ ~!/g;

    # Uncomment for debugging purposes
    #print "Setting $name to $value<P>" ;

    $FORM{$name} = $value ;
}

# Initialise code for "active page" which contains the real links for downloading
$actpage="" ;
$emailtext="" ;

$cartid=&increment_card_id() ;

$actpage.="<table border=0 cellspacing=0 cellpadding=2>" ;
$actpage.="<tr><td colspan=2><img src=\"http://www.powersoftware.com/img/title/invoice.gif\"></td></tr>" ;
$actpage.="<tr><td colspan=2 class=\"narr\">Invoice No. <b>".$cartid."</b></td></tr>" ;
$actpage.="<tr><td colspan=2 class=\"narr\">".$FORM{'name'}." (".$FORM{'email'}.")</td></tr>" ;
$actpage.="<tr><td colspan=2 class=\"narr\"><b>".$FORM{'company'}."</b></td></tr>" ;
$actpage.="<tr><td colspan=2 class=\"narr\">".$FORM{'street'}."<br>".$FORM{'city'}.", ".$FORM{'state'} ;
$actpage.="<br>".$FORM{'postcode'}."</td></tr>" ;
$actpage.="<tr><td colspan=2 class=\"narr\">".$FORM{'countryname'}."</td></tr>" ;

$emailtext.="INVOICE No. ".$cartid."\n\n" ;
$emailtext.=$FORM{'name'}." (".$FORM{'email'}.")\n\n" ;
$emailtext.=$FORM{'company'}."\n".$FORM{'street'}."\n".$FORM{'city'}.", ".$FORM{'state'}."\n" ;
$emailtext.=$FORM{'postcode'}."\n".$FORM{'countryname'}."\n\n" ;

if ($FORM{'countrygroup'} eq $cg_europe) {
$actpage.="<tr><td class=\"narr\"><b>EC VAT No.</b> ".$FORM{'vatno'}."</td></tr>" ;
$emailtext.="EC VAT No. ".$FORM{'vatno'}."\n\n" ;
}

$actpage.="<tr><td class=\"narr\"><b>Tel</b></td><td width=\"100%\" class=\"narr\">".$FORM{'tel'}."</td></tr>" ;
$actpage.="<tr><td class=\"narr\"><b>Fax</b></td><td class=\"narr\">".$FORM{'fax'}."</td></tr>" ;

$emailtext.="tel ".$FORM{'tel'}."\nfax ".$FORM{'fax'}."\n" ;

$emailtext.="=================================================================\n" ;

$actpage.="</table>" ;

$actpage.="<FORM name=\"buy\" action=\"https://select.worldpay.com/wcc/purchase\" method=post>" ;

$actpage.="<table width=\"90%\" border=1><tr width=\"100%\">" ;
$actpage.="<td width=\"58%\" class=\"narr\">&nbsp;</td>" ;
$actpage.="<td width=\"16%\" align=center colspan=2 class=\"narr\"><b>Host-locked</b></td>" ;
$actpage.="<td width=\"16%\" align=center colspan=2 class=\"narr\"><b>Floating</b></td>" ;
$actpage.="<td width=\"10%\" class=\"narr\" align=center>&nbsp;</td></tr><tr>" ;
$actpage.="<td width=\"58%\" class=\"narr\"><b>Product Description</b></td>" ;
$actpage.="<td width=\"8%\" class=\"narr\" align=center><b>Qty</b></td>" ;
$actpage.="<td width=\"8%\" class=\"narr\" align=right><b>Price</b></td>" ;
$actpage.="<td width=\"8%\" class=\"narr\" align=center><b>Qty</b></td>" ;
$actpage.="<td width=\"8%\" class=\"narr\" align=right><b>Price</b></td>" ;
$actpage.="<td width=\"10%\" class=\"narr\" align=right><b>Subtotal</b></td></tr>" ;

$userlocation="" ;
$currency="USD" ;
$vat=1 ;
$subtotal=0.0 ;
$vatamount=0 ;
$amount = 0 ;
$desc = "" ;
$userlocation = $FORM{'userlocation'} ;

if ($FORM{'countrygroup'} eq $cg_international) {
  $currency="USD" ;
  $vat=1 ;   
} elsif ($FORM{'countrygroup'} eq $cg_uk) {
  $currency="GBP" ;
  $vat=0 ;
} else { # $cg_europe
  $currency="GBP" ;
  $vat=1 ;
}

# =-=-=-= GENERATED CODE BEGINS =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

# -- Krakatau Lite (C++) for Solaris -------------------------------------------

if ($FORM{'klsolcppv2'} eq 'y') {
  $actpage.="<input type=hidden name=\"klsolcppv2\" value=\"y\"><tr width=\"100%\"><td class=\"narr\">Krakatau Lite (C++) for Solaris</td>" ;
  if ($FORM{'fromscr02'} eq '1') {
    if (!$FORM{'nklsolcppv2H'}) {$FORM{'nklsolcppv2H'} = 1 ;}
    if (!$FORM{'nklsolcppv2F'}) {$FORM{'nklsolcppv2F'} = 0 ;}
  }
  $strLicH=$FORM{'nklsolcppv2H'} ;
  if ($strLicH < 0) { $strLicH = 0 ; }
  $strLicF=$FORM{'nklsolcppv2F'} ;
  if ($strLicF < 0) { $strLicF = 0 ; }

  $actpage.="<td class=\"narr\" align=center><input type=text onChange=\"verify(this)\" name=\"nklsolcppv2H\" value=\"$strLicH\" size=\"2\"></td>\n<td class=\"narr\" align=right>" ;
  if ($strLicH > 0) {
    $actpage.= "<b>895.00</b>" ;
  } else {
    $actpage.= "895.00" ;
  }
  $actpage.="<td class=\"narr\" align=center><input type=text onChange=\"verify(this)\" name=\"nklsolcppv2F\" value=\"$strLicF\" size=\"2\"></td>\n<td class=\"narr\" align=right>" ;
  if ($strLicF > 0) {
    $actpage.= "<b>1995.00</b>" ;
  } else {
    $actpage.= "1995.00" ;
  }
  $actpage.="</td>\n<td class=\"narr\" align=right>" . sprintf("%.2f",(($strLicH * 895) + ($strLicF * 1995))) . "</td></tr>\n" ;
  if ($strLicH > 0) { 
    $desc.= "$strLicH x HL Krakatau Lite (C++) for Solaris + Maint.<br>" ;
    $emailtext.="Host-locked Krakatau Lite (C++) for Solaris\n  ".$strLicH." x (895 + 95) = ".sprintf("%.0f",($strLicH * (895 + 95)))."\n" ;
  }
  if ($strLicF > 0) { 
    $desc.= "$strLicF x FLOAT Krakatau Lite (C++) for Solaris + Maint.<br>" ;
    $emailtext.="Floating Krakatau Lite (C++) for Solaris\n  ".$strLicF." x (1995 + 295) = ".sprintf("%.0f",($strLicF * (1995 + 295))) . "\n" ;
  }
  $actpage.="<tr width=\"100%\">" ;
  $actpage.="\n<td class=\"narr\">Annual Maintenance for above</td>\n" ;
  $actpage.="<td class=\"narr\" align=center>$strLicH</td><td class=\"narr\" align=right>" ;
  if ($strLicH > 0) {
    $actpage.= "<b>95.00</b>" ;
  } else {
    $actpage.= "95.00" ;
  }
  $actpage.="</td>\n<td class=\"narr\" align=center>$strLicF</td><td class=\"narr\" align=right>" ;
  if ($strLicF > 0) {
    $actpage.= "<b>295.00</b>" ;
  } else {
    $actpage.= "295.00" ;
  }
  $actpage.="</td>\n<td class=\"narr\" align=right>" . sprintf("%.2f",(($strLicH * 95) + ($strLicF * 295))) . "</td></tr>\n" ;

  $amount += ($strLicH * 895) ;
  $amount += ($strLicF * 1995) ;
  $amount += ($strLicH * 95) ;
  $amount += ($strLicF * 295) ;
}


# -- Krakatau Lite (C++) for Windows -------------------------------------------

if ($FORM{'klwincppv2'} eq 'y') {
  $actpage.="<input type=hidden name=\"klwincppv2\" value=\"y\"><tr width=\"100%\"><td class=\"narr\">Krakatau Lite (C++) for Windows</td>" ;
  if ($FORM{'fromscr02'} eq '1') {
    if (!$FORM{'nklwincppv2H'}) {$FORM{'nklwincppv2H'} = 1 ;}
    if (!$FORM{'nklwincppv2F'}) {$FORM{'nklwincppv2F'} = 0 ;}
  }
  $strLicH=$FORM{'nklwincppv2H'} ;
  if ($strLicH < 0) { $strLicH = 0 ; }
  $strLicF=$FORM{'nklwincppv2F'} ;
  if ($strLicF < 0) { $strLicF = 0 ; }

  $actpage.="<td class=\"narr\" align=center><input type=text onChange=\"verify(this)\" name=\"nklwincppv2H\" value=\"$strLicH\" size=\"2\"></td>\n<td class=\"narr\" align=right>" ;
  if ($strLicH > 0) {
    $actpage.= "<b>895.00</b>" ;
  } else {
    $actpage.= "895.00" ;
  }
  $actpage.="<td class=\"narr\" align=center><input type=text onChange=\"verify(this)\" name=\"nklwincppv2F\" value=\"$strLicF\" size=\"2\"></td>\n<td class=\"narr\" align=right>" ;
  if ($strLicF > 0) {
    $actpage.= "<b>1995.00</b>" ;
  } else {
    $actpage.= "1995.00" ;
  }
  $actpage.="</td>\n<td class=\"narr\" align=right>" . sprintf("%.2f",(($strLicH * 895) + ($strLicF * 1995))) . "</td></tr>\n" ;
  if ($strLicH > 0) { 
    $desc.= "$strLicH x HL Krakatau Lite (C++) for Windows + Maint.<br>" ;
    $emailtext.="Host-locked Krakatau Lite (C++) for Windows\n  ".$strLicH." x (895 + 95) = ".sprintf("%.0f",($strLicH * (895 + 95)))."\n" ;
  }
  if ($strLicF > 0) { 
    $desc.= "$strLicF x FLOAT Krakatau Lite (C++) for Windows + Maint.<br>" ;
    $emailtext.="Floating Krakatau Lite (C++) for Windows\n  ".$strLicF." x (1995 + 295) = ".sprintf("%.0f",($strLicF * (1995 + 295))) . "\n" ;
  }
  $actpage.="<tr width=\"100%\">" ;
  $actpage.="\n<td class=\"narr\">Annual Maintenance for above</td>\n" ;
  $actpage.="<td class=\"narr\" align=center>$strLicH</td><td class=\"narr\" align=right>" ;
  if ($strLicH > 0) {
    $actpage.= "<b>95.00</b>" ;
  } else {
    $actpage.= "95.00" ;
  }
  $actpage.="</td>\n<td class=\"narr\" align=center>$strLicF</td><td class=\"narr\" align=right>" ;
  if ($strLicF > 0) {
    $actpage.= "<b>295.00</b>" ;
  } else {
    $actpage.= "295.00" ;
  }
  $actpage.="</td>\n<td class=\"narr\" align=right>" . sprintf("%.2f",(($strLicH * 95) + ($strLicF * 295))) . "</td></tr>\n" ;

  $amount += ($strLicH * 895) ;
  $amount += ($strLicF * 1995) ;
  $amount += ($strLicH * 95) ;
  $amount += ($strLicF * 295) ;
}


# -- Krakatau Lite (Java) for Solaris ------------------------------------------

if ($FORM{'klsoljavav2'} eq 'y') {
  $actpage.="<input type=hidden name=\"klsoljavav2\" value=\"y\"><tr width=\"100%\"><td class=\"narr\">Krakatau Lite (Java) for Solaris</td>" ;
  if ($FORM{'fromscr02'} eq '1') {
    if (!$FORM{'nklsoljavav2H'}) {$FORM{'nklsoljavav2H'} = 1 ;}
    if (!$FORM{'nklsoljavav2F'}) {$FORM{'nklsoljavav2F'} = 0 ;}
  }
  $strLicH=$FORM{'nklsoljavav2H'} ;
  if ($strLicH < 0) { $strLicH = 0 ; }
  $strLicF=$FORM{'nklsoljavav2F'} ;
  if ($strLicF < 0) { $strLicF = 0 ; }

  $actpage.="<td class=\"narr\" align=center><input type=text onChange=\"verify(this)\" name=\"nklsoljavav2H\" value=\"$strLicH\" size=\"2\"></td>\n<td class=\"narr\" align=right>" ;
  if ($strLicH > 0) {
    $actpage.= "<b>895.00</b>" ;
  } else {
    $actpage.= "895.00" ;
  }
  $actpage.="<td class=\"narr\" align=center><input type=text onChange=\"verify(this)\" name=\"nklsoljavav2F\" value=\"$strLicF\" size=\"2\"></td>\n<td class=\"narr\" align=right>" ;
  if ($strLicF > 0) {
    $actpage.= "<b>1995.00</b>" ;
  } else {
    $actpage.= "1995.00" ;
  }
  $actpage.="</td>\n<td class=\"narr\" align=right>" . sprintf("%.2f",(($strLicH * 895) + ($strLicF * 1995))) . "</td></tr>\n" ;
  if ($strLicH > 0) { 
    $desc.= "$strLicH x HL Krakatau Lite (Java) for Solaris + Maint.<br>" ;
    $emailtext.="Host-locked Krakatau Lite (Java) for Solaris\n  ".$strLicH." x (895 + 95) = ".sprintf("%.0f",($strLicH * (895 + 95)))."\n" ;
  }
  if ($strLicF > 0) { 
    $desc.= "$strLicF x FLOAT Krakatau Lite (Java) for Solaris + Maint.<br>" ;
    $emailtext.="Floating Krakatau Lite (Java) for Solaris\n  ".$strLicF." x (1995 + 295) = ".sprintf("%.0f",($strLicF * (1995 + 295))) . "\n" ;
  }
  $actpage.="<tr width=\"100%\">" ;
  $actpage.="\n<td class=\"narr\">Annual Maintenance for above</td>\n" ;
  $actpage.="<td class=\"narr\" align=center>$strLicH</td><td class=\"narr\" align=right>" ;
  if ($strLicH > 0) {
    $actpage.= "<b>95.00</b>" ;
  } else {
    $actpage.= "95.00" ;
  }
  $actpage.="</td>\n<td class=\"narr\" align=center>$strLicF</td><td class=\"narr\" align=right>" ;
  if ($strLicF > 0) {
    $actpage.= "<b>295.00</b>" ;
  } else {
    $actpage.= "295.00" ;
  }
  $actpage.="</td>\n<td class=\"narr\" align=right>" . sprintf("%.2f",(($strLicH * 95) + ($strLicF * 295))) . "</td></tr>\n" ;

  $amount += ($strLicH * 895) ;
  $amount += ($strLicF * 1995) ;
  $amount += ($strLicH * 95) ;
  $amount += ($strLicF * 295) ;
}


# -- Krakatau Lite (Java) for Windows ------------------------------------------

if ($FORM{'klwinjavav2'} eq 'y') {
  $actpage.="<input type=hidden name=\"klwinjavav2\" value=\"y\"><tr width=\"100%\"><td class=\"narr\">Krakatau Lite (Java) for Windows</td>" ;
  if ($FORM{'fromscr02'} eq '1') {
    if (!$FORM{'nklwinjavav2H'}) {$FORM{'nklwinjavav2H'} = 1 ;}
    if (!$FORM{'nklwinjavav2F'}) {$FORM{'nklwinjavav2F'} = 0 ;}
  }
  $strLicH=$FORM{'nklwinjavav2H'} ;
  if ($strLicH < 0) { $strLicH = 0 ; }
  $strLicF=$FORM{'nklwinjavav2F'} ;
  if ($strLicF < 0) { $strLicF = 0 ; }

  $actpage.="<td class=\"narr\" align=center><input type=text onChange=\"verify(this)\" name=\"nklwinjavav2H\" value=\"$strLicH\" size=\"2\"></td>\n<td class=\"narr\" align=right>" ;
  if ($strLicH > 0) {
    $actpage.= "<b>895.00</b>" ;
  } else {
    $actpage.= "895.00" ;
  }
  $actpage.="<td class=\"narr\" align=center><input type=text onChange=\"verify(this)\" name=\"nklwinjavav2F\" value=\"$strLicF\" size=\"2\"></td>\n<td class=\"narr\" align=right>" ;
  if ($strLicF > 0) {
    $actpage.= "<b>1995.00</b>" ;
  } else {
    $actpage.= "1995.00" ;
  }
  $actpage.="</td>\n<td class=\"narr\" align=right>" . sprintf("%.2f",(($strLicH * 895) + ($strLicF * 1995))) . "</td></tr>\n" ;
  if ($strLicH > 0) { 
    $desc.= "$strLicH x HL Krakatau Lite (Java) for Windows + Maint.<br>" ;
    $emailtext.="Host-locked Krakatau Lite (Java) for Windows\n  ".$strLicH." x (895 + 95) = ".sprintf("%.0f",($strLicH * (895 + 95)))."\n" ;
  }
  if ($strLicF > 0) { 
    $desc.= "$strLicF x FLOAT Krakatau Lite (Java) for Windows + Maint.<br>" ;
    $emailtext.="Floating Krakatau Lite (Java) for Windows\n  ".$strLicF." x (1995 + 295) = ".sprintf("%.0f",($strLicF * (1995 + 295))) . "\n" ;
  }
  $actpage.="<tr width=\"100%\">" ;
  $actpage.="\n<td class=\"narr\">Annual Maintenance for above</td>\n" ;
  $actpage.="<td class=\"narr\" align=center>$strLicH</td><td class=\"narr\" align=right>" ;
  if ($strLicH > 0) {
    $actpage.= "<b>95.00</b>" ;
  } else {
    $actpage.= "95.00" ;
  }
  $actpage.="</td>\n<td class=\"narr\" align=center>$strLicF</td><td class=\"narr\" align=right>" ;
  if ($strLicF > 0) {
    $actpage.= "<b>295.00</b>" ;
  } else {
    $actpage.= "295.00" ;
  }
  $actpage.="</td>\n<td class=\"narr\" align=right>" . sprintf("%.2f",(($strLicH * 95) + ($strLicF * 295))) . "</td></tr>\n" ;

  $amount += ($strLicH * 895) ;
  $amount += ($strLicF * 1995) ;
  $amount += ($strLicH * 95) ;
  $amount += ($strLicF * 295) ;
}


# -- Krakatau Professional (C++) for Solaris -----------------------------------

if ($FORM{'kpsolcppv2'} eq 'y') {
  $actpage.="<input type=hidden name=\"kpsolcppv2\" value=\"y\"><tr width=\"100%\"><td class=\"narr\">Krakatau Professional (C++) for Solaris</td>" ;
  if ($FORM{'fromscr02'} eq '1') {
    if (!$FORM{'nkpsolcppv2H'}) {$FORM{'nkpsolcppv2H'} = 1 ;}
    if (!$FORM{'nkpsolcppv2F'}) {$FORM{'nkpsolcppv2F'} = 0 ;}
  }
  $strLicH=$FORM{'nkpsolcppv2H'} ;
  if ($strLicH < 0) { $strLicH = 0 ; }
  $strLicF=$FORM{'nkpsolcppv2F'} ;
  if ($strLicF < 0) { $strLicF = 0 ; }

  $actpage.="<td class=\"narr\" align=center><input type=text onChange=\"verify(this)\" name=\"nkpsolcppv2H\" value=\"$strLicH\" size=\"2\"></td>\n<td class=\"narr\" align=right>" ;
  if ($strLicH > 0) {
    $actpage.= "<b>2995.00</b>" ;
  } else {
    $actpage.= "2995.00" ;
  }
  $actpage.="<td class=\"narr\" align=center><input type=text onChange=\"verify(this)\" name=\"nkpsolcppv2F\" value=\"$strLicF\" size=\"2\"></td>\n<td class=\"narr\" align=right>" ;
  if ($strLicF > 0) {
    $actpage.= "<b>4995.00</b>" ;
  } else {
    $actpage.= "4995.00" ;
  }
  $actpage.="</td>\n<td class=\"narr\" align=right>" . sprintf("%.2f",(($strLicH * 2995) + ($strLicF * 4995))) . "</td></tr>\n" ;
  if ($strLicH > 0) { 
    $desc.= "$strLicH x HL Krakatau Professional (C++) for Solaris + Maint.<br>" ;
    $emailtext.="Host-locked Krakatau Professional (C++) for Solaris\n  ".$strLicH." x (2995 + 495) = ".sprintf("%.0f",($strLicH * (2995 + 495)))."\n" ;
  }
  if ($strLicF > 0) { 
    $desc.= "$strLicF x FLOAT Krakatau Professional (C++) for Solaris + Maint.<br>" ;
    $emailtext.="Floating Krakatau Professional (C++) for Solaris\n  ".$strLicF." x (4995 + 695) = ".sprintf("%.0f",($strLicF * (4995 + 695))) . "\n" ;
  }
  $actpage.="<tr width=\"100%\">" ;
  $actpage.="\n<td class=\"narr\">Annual Maintenance for above</td>\n" ;
  $actpage.="<td class=\"narr\" align=center>$strLicH</td><td class=\"narr\" align=right>" ;
  if ($strLicH > 0) {
    $actpage.= "<b>495.00</b>" ;
  } else {
    $actpage.= "495.00" ;
  }
  $actpage.="</td>\n<td class=\"narr\" align=center>$strLicF</td><td class=\"narr\" align=right>" ;
  if ($strLicF > 0) {
    $actpage.= "<b>695.00</b>" ;
  } else {
    $actpage.= "695.00" ;
  }
  $actpage.="</td>\n<td class=\"narr\" align=right>" . sprintf("%.2f",(($strLicH * 495) + ($strLicF * 695))) . "</td></tr>\n" ;

  $amount += ($strLicH * 2995) ;
  $amount += ($strLicF * 4995) ;
  $amount += ($strLicH * 495) ;
  $amount += ($strLicF * 695) ;
}


# -- Krakatau Professional (C++) for Windows -----------------------------------

if ($FORM{'kpwincppv2'} eq 'y') {
  $actpage.="<input type=hidden name=\"kpwincppv2\" value=\"y\"><tr width=\"100%\"><td class=\"narr\">Krakatau Professional (C++) for Windows</td>" ;
  if ($FORM{'fromscr02'} eq '1') {
    if (!$FORM{'nkpwincppv2H'}) {$FORM{'nkpwincppv2H'} = 1 ;}
    if (!$FORM{'nkpwincppv2F'}) {$FORM{'nkpwincppv2F'} = 0 ;}
  }
  $strLicH=$FORM{'nkpwincppv2H'} ;
  if ($strLicH < 0) { $strLicH = 0 ; }
  $strLicF=$FORM{'nkpwincppv2F'} ;
  if ($strLicF < 0) { $strLicF = 0 ; }

  $actpage.="<td class=\"narr\" align=center><input type=text onChange=\"verify(this)\" name=\"nkpwincppv2H\" value=\"$strLicH\" size=\"2\"></td>\n<td class=\"narr\" align=right>" ;
  if ($strLicH > 0) {
    $actpage.= "<b>2995.00</b>" ;
  } else {
    $actpage.= "2995.00" ;
  }
  $actpage.="<td class=\"narr\" align=center><input type=text onChange=\"verify(this)\" name=\"nkpwincppv2F\" value=\"$strLicF\" size=\"2\"></td>\n<td class=\"narr\" align=right>" ;
  if ($strLicF > 0) {
    $actpage.= "<b>4995.00</b>" ;
  } else {
    $actpage.= "4995.00" ;
  }
  $actpage.="</td>\n<td class=\"narr\" align=right>" . sprintf("%.2f",(($strLicH * 2995) + ($strLicF * 4995))) . "</td></tr>\n" ;
  if ($strLicH > 0) { 
    $desc.= "$strLicH x HL Krakatau Professional (C++) for Windows + Maint.<br>" ;
    $emailtext.="Host-locked Krakatau Professional (C++) for Windows\n  ".$strLicH." x (2995 + 495) = ".sprintf("%.0f",($strLicH * (2995 + 495)))."\n" ;
  }
  if ($strLicF > 0) { 
    $desc.= "$strLicF x FLOAT Krakatau Professional (C++) for Windows + Maint.<br>" ;
    $emailtext.="Floating Krakatau Professional (C++) for Windows\n  ".$strLicF." x (4995 + 695) = ".sprintf("%.0f",($strLicF * (4995 + 695))) . "\n" ;
  }
  $actpage.="<tr width=\"100%\">" ;
  $actpage.="\n<td class=\"narr\">Annual Maintenance for above</td>\n" ;
  $actpage.="<td class=\"narr\" align=center>$strLicH</td><td class=\"narr\" align=right>" ;
  if ($strLicH > 0) {
    $actpage.= "<b>495.00</b>" ;
  } else {
    $actpage.= "495.00" ;
  }
  $actpage.="</td>\n<td class=\"narr\" align=center>$strLicF</td><td class=\"narr\" align=right>" ;
  if ($strLicF > 0) {
    $actpage.= "<b>695.00</b>" ;
  } else {
    $actpage.= "695.00" ;
  }
  $actpage.="</td>\n<td class=\"narr\" align=right>" . sprintf("%.2f",(($strLicH * 495) + ($strLicF * 695))) . "</td></tr>\n" ;

  $amount += ($strLicH * 2995) ;
  $amount += ($strLicF * 4995) ;
  $amount += ($strLicH * 495) ;
  $amount += ($strLicF * 695) ;
}


# -- Krakatau Professional (Java) for Solaris ----------------------------------

if ($FORM{'kpsoljavav2'} eq 'y') {
  $actpage.="<input type=hidden name=\"kpsoljavav2\" value=\"y\"><tr width=\"100%\"><td class=\"narr\">Krakatau Professional (Java) for Solaris</td>" ;
  if ($FORM{'fromscr02'} eq '1') {
    if (!$FORM{'nkpsoljavav2H'}) {$FORM{'nkpsoljavav2H'} = 1 ;}
    if (!$FORM{'nkpsoljavav2F'}) {$FORM{'nkpsoljavav2F'} = 0 ;}
  }
  $strLicH=$FORM{'nkpsoljavav2H'} ;
  if ($strLicH < 0) { $strLicH = 0 ; }
  $strLicF=$FORM{'nkpsoljavav2F'} ;
  if ($strLicF < 0) { $strLicF = 0 ; }

  $actpage.="<td class=\"narr\" align=center><input type=text onChange=\"verify(this)\" name=\"nkpsoljavav2H\" value=\"$strLicH\" size=\"2\"></td>\n<td class=\"narr\" align=right>" ;
  if ($strLicH > 0) {
    $actpage.= "<b>2995.00</b>" ;
  } else {
    $actpage.= "2995.00" ;
  }
  $actpage.="<td class=\"narr\" align=center><input type=text onChange=\"verify(this)\" name=\"nkpsoljavav2F\" value=\"$strLicF\" size=\"2\"></td>\n<td class=\"narr\" align=right>" ;
  if ($strLicF > 0) {
    $actpage.= "<b>4995.00</b>" ;
  } else {
    $actpage.= "4995.00" ;
  }
  $actpage.="</td>\n<td class=\"narr\" align=right>" . sprintf("%.2f",(($strLicH * 2995) + ($strLicF * 4995))) . "</td></tr>\n" ;
  if ($strLicH > 0) { 
    $desc.= "$strLicH x HL Krakatau Professional (Java) for Solaris + Maint.<br>" ;
    $emailtext.="Host-locked Krakatau Professional (Java) for Solaris\n  ".$strLicH." x (2995 + 495) = ".sprintf("%.0f",($strLicH * (2995 + 495)))."\n" ;
  }
  if ($strLicF > 0) { 
    $desc.= "$strLicF x FLOAT Krakatau Professional (Java) for Solaris + Maint.<br>" ;
    $emailtext.="Floating Krakatau Professional (Java) for Solaris\n  ".$strLicF." x (4995 + 695) = ".sprintf("%.0f",($strLicF * (4995 + 695))) . "\n" ;
  }
  $actpage.="<tr width=\"100%\">" ;
  $actpage.="\n<td class=\"narr\">Annual Maintenance for above</td>\n" ;
  $actpage.="<td class=\"narr\" align=center>$strLicH</td><td class=\"narr\" align=right>" ;
  if ($strLicH > 0) {
    $actpage.= "<b>495.00</b>" ;
  } else {
    $actpage.= "495.00" ;
  }
  $actpage.="</td>\n<td class=\"narr\" align=center>$strLicF</td><td class=\"narr\" align=right>" ;
  if ($strLicF > 0) {
    $actpage.= "<b>695.00</b>" ;
  } else {
    $actpage.= "695.00" ;
  }
  $actpage.="</td>\n<td class=\"narr\" align=right>" . sprintf("%.2f",(($strLicH * 495) + ($strLicF * 695))) . "</td></tr>\n" ;

  $amount += ($strLicH * 2995) ;
  $amount += ($strLicF * 4995) ;
  $amount += ($strLicH * 495) ;
  $amount += ($strLicF * 695) ;
}


# -- Krakatau Professional (Java) for Windows ----------------------------------

if ($FORM{'kpwinjavav2'} eq 'y') {
  $actpage.="<input type=hidden name=\"kpwinjavav2\" value=\"y\"><tr width=\"100%\"><td class=\"narr\">Krakatau Professional (Java) for Windows</td>" ;
  if ($FORM{'fromscr02'} eq '1') {
    if (!$FORM{'nkpwinjavav2H'}) {$FORM{'nkpwinjavav2H'} = 1 ;}
    if (!$FORM{'nkpwinjavav2F'}) {$FORM{'nkpwinjavav2F'} = 0 ;}
  }
  $strLicH=$FORM{'nkpwinjavav2H'} ;
  if ($strLicH < 0) { $strLicH = 0 ; }
  $strLicF=$FORM{'nkpwinjavav2F'} ;
  if ($strLicF < 0) { $strLicF = 0 ; }

  $actpage.="<td class=\"narr\" align=center><input type=text onChange=\"verify(this)\" name=\"nkpwinjavav2H\" value=\"$strLicH\" size=\"2\"></td>\n<td class=\"narr\" align=right>" ;
  if ($strLicH > 0) {
    $actpage.= "<b>2995.00</b>" ;
  } else {
    $actpage.= "2995.00" ;
  }
  $actpage.="<td class=\"narr\" align=center><input type=text onChange=\"verify(this)\" name=\"nkpwinjavav2F\" value=\"$strLicF\" size=\"2\"></td>\n<td class=\"narr\" align=right>" ;
  if ($strLicF > 0) {
    $actpage.= "<b>4995.00</b>" ;
  } else {
    $actpage.= "4995.00" ;
  }
  $actpage.="</td>\n<td class=\"narr\" align=right>" . sprintf("%.2f",(($strLicH * 2995) + ($strLicF * 4995))) . "</td></tr>\n" ;
  if ($strLicH > 0) { 
    $desc.= "$strLicH x HL Krakatau Professional (Java) for Windows + Maint.<br>" ;
    $emailtext.="Host-locked Krakatau Professional (Java) for Windows\n  ".$strLicH." x (2995 + 495) = ".sprintf("%.0f",($strLicH * (2995 + 495)))."\n" ;
  }
  if ($strLicF > 0) { 
    $desc.= "$strLicF x FLOAT Krakatau Professional (Java) for Windows + Maint.<br>" ;
    $emailtext.="Floating Krakatau Professional (Java) for Windows\n  ".$strLicF." x (4995 + 695) = ".sprintf("%.0f",($strLicF * (4995 + 695))) . "\n" ;
  }
  $actpage.="<tr width=\"100%\">" ;
  $actpage.="\n<td class=\"narr\">Annual Maintenance for above</td>\n" ;
  $actpage.="<td class=\"narr\" align=center>$strLicH</td><td class=\"narr\" align=right>" ;
  if ($strLicH > 0) {
    $actpage.= "<b>495.00</b>" ;
  } else {
    $actpage.= "495.00" ;
  }
  $actpage.="</td>\n<td class=\"narr\" align=center>$strLicF</td><td class=\"narr\" align=right>" ;
  if ($strLicF > 0) {
    $actpage.= "<b>695.00</b>" ;
  } else {
    $actpage.= "695.00" ;
  }
  $actpage.="</td>\n<td class=\"narr\" align=right>" . sprintf("%.2f",(($strLicH * 495) + ($strLicF * 695))) . "</td></tr>\n" ;

  $amount += ($strLicH * 2995) ;
  $amount += ($strLicF * 4995) ;
  $amount += ($strLicH * 495) ;
  $amount += ($strLicF * 695) ;
}


# -- Krakatau Project Manager (C++) for Solaris --------------------------------

if ($FORM{'pmsolcppv2'} eq 'y') {
  $actpage.="<input type=hidden name=\"pmsolcppv2\" value=\"y\"><tr width=\"100%\"><td class=\"narr\">Krakatau Project Manager (C++) for Solaris</td>" ;
  if ($FORM{'fromscr02'} eq '1') {
    if (!$FORM{'npmsolcppv2H'}) {$FORM{'npmsolcppv2H'} = 1 ;}
    if (!$FORM{'npmsolcppv2F'}) {$FORM{'npmsolcppv2F'} = 0 ;}
  }
  $strLicH=$FORM{'npmsolcppv2H'} ;
  if ($strLicH < 0) { $strLicH = 0 ; }
  $strLicF=$FORM{'npmsolcppv2F'} ;
  if ($strLicF < 0) { $strLicF = 0 ; }

  $actpage.="<td class=\"narr\" align=center><input type=text onChange=\"verify(this)\" name=\"npmsolcppv2H\" value=\"$strLicH\" size=\"2\"></td>\n<td class=\"narr\" align=right>" ;
  if ($strLicH > 0) {
    $actpage.= "<b>4995.00</b>" ;
  } else {
    $actpage.= "4995.00" ;
  }
  $actpage.="<td class=\"narr\" align=center><input type=text onChange=\"verify(this)\" name=\"npmsolcppv2F\" value=\"$strLicF\" size=\"2\"></td>\n<td class=\"narr\" align=right>" ;
  if ($strLicF > 0) {
    $actpage.= "<b>6995.00</b>" ;
  } else {
    $actpage.= "6995.00" ;
  }
  $actpage.="</td>\n<td class=\"narr\" align=right>" . sprintf("%.2f",(($strLicH * 4995) + ($strLicF * 6995))) . "</td></tr>\n" ;
  if ($strLicH > 0) { 
    $desc.= "$strLicH x HL Krakatau Project Manager (C++) for Solaris + Maint.<br>" ;
    $emailtext.="Host-locked Krakatau Project Manager (C++) for Solaris\n  ".$strLicH." x (4995 + 995) = ".sprintf("%.0f",($strLicH * (4995 + 995)))."\n" ;
  }
  if ($strLicF > 0) { 
    $desc.= "$strLicF x FLOAT Krakatau Project Manager (C++) for Solaris + Maint.<br>" ;
    $emailtext.="Floating Krakatau Project Manager (C++) for Solaris\n  ".$strLicF." x (6995 + 1295) = ".sprintf("%.0f",($strLicF * (6995 + 1295))) . "\n" ;
  }
  $actpage.="<tr width=\"100%\">" ;
  $actpage.="\n<td class=\"narr\">Annual Maintenance for above</td>\n" ;
  $actpage.="<td class=\"narr\" align=center>$strLicH</td><td class=\"narr\" align=right>" ;
  if ($strLicH > 0) {
    $actpage.= "<b>995.00</b>" ;
  } else {
    $actpage.= "995.00" ;
  }
  $actpage.="</td>\n<td class=\"narr\" align=center>$strLicF</td><td class=\"narr\" align=right>" ;
  if ($strLicF > 0) {
    $actpage.= "<b>1295.00</b>" ;
  } else {
    $actpage.= "1295.00" ;
  }
  $actpage.="</td>\n<td class=\"narr\" align=right>" . sprintf("%.2f",(($strLicH * 995) + ($strLicF * 1295))) . "</td></tr>\n" ;

  $amount += ($strLicH * 4995) ;
  $amount += ($strLicF * 6995) ;
  $amount += ($strLicH * 995) ;
  $amount += ($strLicF * 1295) ;
}


# -- Krakatau Project Manager (C++) for Windows --------------------------------

if ($FORM{'pmwincppv2'} eq 'y') {
  $actpage.="<input type=hidden name=\"pmwincppv2\" value=\"y\"><tr width=\"100%\"><td class=\"narr\">Krakatau Project Manager (C++) for Windows</td>" ;
  if ($FORM{'fromscr02'} eq '1') {
    if (!$FORM{'npmwincppv2H'}) {$FORM{'npmwincppv2H'} = 1 ;}
    if (!$FORM{'npmwincppv2F'}) {$FORM{'npmwincppv2F'} = 0 ;}
  }
  $strLicH=$FORM{'npmwincppv2H'} ;
  if ($strLicH < 0) { $strLicH = 0 ; }
  $strLicF=$FORM{'npmwincppv2F'} ;
  if ($strLicF < 0) { $strLicF = 0 ; }

  $actpage.="<td class=\"narr\" align=center><input type=text onChange=\"verify(this)\" name=\"npmwincppv2H\" value=\"$strLicH\" size=\"2\"></td>\n<td class=\"narr\" align=right>" ;
  if ($strLicH > 0) {
    $actpage.= "<b>4995.00</b>" ;
  } else {
    $actpage.= "4995.00" ;
  }
  $actpage.="<td class=\"narr\" align=center><input type=text onChange=\"verify(this)\" name=\"npmwincppv2F\" value=\"$strLicF\" size=\"2\"></td>\n<td class=\"narr\" align=right>" ;
  if ($strLicF > 0) {
    $actpage.= "<b>6995.00</b>" ;
  } else {
    $actpage.= "6995.00" ;
  }
  $actpage.="</td>\n<td class=\"narr\" align=right>" . sprintf("%.2f",(($strLicH * 4995) + ($strLicF * 6995))) . "</td></tr>\n" ;
  if ($strLicH > 0) { 
    $desc.= "$strLicH x HL Krakatau Project Manager (C++) for Windows + Maint.<br>" ;
    $emailtext.="Host-locked Krakatau Project Manager (C++) for Windows\n  ".$strLicH." x (4995 + 995) = ".sprintf("%.0f",($strLicH * (4995 + 995)))."\n" ;
  }
  if ($strLicF > 0) { 
    $desc.= "$strLicF x FLOAT Krakatau Project Manager (C++) for Windows + Maint.<br>" ;
    $emailtext.="Floating Krakatau Project Manager (C++) for Windows\n  ".$strLicF." x (6995 + 1295) = ".sprintf("%.0f",($strLicF * (6995 + 1295))) . "\n" ;
  }
  $actpage.="<tr width=\"100%\">" ;
  $actpage.="\n<td class=\"narr\">Annual Maintenance for above</td>\n" ;
  $actpage.="<td class=\"narr\" align=center>$strLicH</td><td class=\"narr\" align=right>" ;
  if ($strLicH > 0) {
    $actpage.= "<b>995.00</b>" ;
  } else {
    $actpage.= "995.00" ;
  }
  $actpage.="</td>\n<td class=\"narr\" align=center>$strLicF</td><td class=\"narr\" align=right>" ;
  if ($strLicF > 0) {
    $actpage.= "<b>1295.00</b>" ;
  } else {
    $actpage.= "1295.00" ;
  }
  $actpage.="</td>\n<td class=\"narr\" align=right>" . sprintf("%.2f",(($strLicH * 995) + ($strLicF * 1295))) . "</td></tr>\n" ;

  $amount += ($strLicH * 4995) ;
  $amount += ($strLicF * 6995) ;
  $amount += ($strLicH * 995) ;
  $amount += ($strLicF * 1295) ;
}


# -- Krakatau Project Manager (Java) for Solaris -------------------------------

if ($FORM{'pmsoljavav2'} eq 'y') {
  $actpage.="<input type=hidden name=\"pmsoljavav2\" value=\"y\"><tr width=\"100%\"><td class=\"narr\">Krakatau Project Manager (Java) for Solaris</td>" ;
  if ($FORM{'fromscr02'} eq '1') {
    if (!$FORM{'npmsoljavav2H'}) {$FORM{'npmsoljavav2H'} = 1 ;}
    if (!$FORM{'npmsoljavav2F'}) {$FORM{'npmsoljavav2F'} = 0 ;}
  }
  $strLicH=$FORM{'npmsoljavav2H'} ;
  if ($strLicH < 0) { $strLicH = 0 ; }
  $strLicF=$FORM{'npmsoljavav2F'} ;
  if ($strLicF < 0) { $strLicF = 0 ; }

  $actpage.="<td class=\"narr\" align=center><input type=text onChange=\"verify(this)\" name=\"npmsoljavav2H\" value=\"$strLicH\" size=\"2\"></td>\n<td class=\"narr\" align=right>" ;
  if ($strLicH > 0) {
    $actpage.= "<b>4995.00</b>" ;
  } else {
    $actpage.= "4995.00" ;
  }
  $actpage.="<td class=\"narr\" align=center><input type=text onChange=\"verify(this)\" name=\"npmsoljavav2F\" value=\"$strLicF\" size=\"2\"></td>\n<td class=\"narr\" align=right>" ;
  if ($strLicF > 0) {
    $actpage.= "<b>6995.00</b>" ;
  } else {
    $actpage.= "6995.00" ;
  }
  $actpage.="</td>\n<td class=\"narr\" align=right>" . sprintf("%.2f",(($strLicH * 4995) + ($strLicF * 6995))) . "</td></tr>\n" ;
  if ($strLicH > 0) { 
    $desc.= "$strLicH x HL Krakatau Project Manager (Java) for Solaris + Maint.<br>" ;
    $emailtext.="Host-locked Krakatau Project Manager (Java) for Solaris\n  ".$strLicH." x (4995 + 995) = ".sprintf("%.0f",($strLicH * (4995 + 995)))."\n" ;
  }
  if ($strLicF > 0) { 
    $desc.= "$strLicF x FLOAT Krakatau Project Manager (Java) for Solaris + Maint.<br>" ;
    $emailtext.="Floating Krakatau Project Manager (Java) for Solaris\n  ".$strLicF." x (6995 + 1295) = ".sprintf("%.0f",($strLicF * (6995 + 1295))) . "\n" ;
  }
  $actpage.="<tr width=\"100%\">" ;
  $actpage.="\n<td class=\"narr\">Annual Maintenance for above</td>\n" ;
  $actpage.="<td class=\"narr\" align=center>$strLicH</td><td class=\"narr\" align=right>" ;
  if ($strLicH > 0) {
    $actpage.= "<b>995.00</b>" ;
  } else {
    $actpage.= "995.00" ;
  }
  $actpage.="</td>\n<td class=\"narr\" align=center>$strLicF</td><td class=\"narr\" align=right>" ;
  if ($strLicF > 0) {
    $actpage.= "<b>1295.00</b>" ;
  } else {
    $actpage.= "1295.00" ;
  }
  $actpage.="</td>\n<td class=\"narr\" align=right>" . sprintf("%.2f",(($strLicH * 995) + ($strLicF * 1295))) . "</td></tr>\n" ;

  $amount += ($strLicH * 4995) ;
  $amount += ($strLicF * 6995) ;
  $amount += ($strLicH * 995) ;
  $amount += ($strLicF * 1295) ;
}


# -- Krakatau Project Manager (Java) for Windows -------------------------------

if ($FORM{'pmwinjavav2'} eq 'y') {
  $actpage.="<input type=hidden name=\"pmwinjavav2\" value=\"y\"><tr width=\"100%\"><td class=\"narr\">Krakatau Project Manager (Java) for Windows</td>" ;
  if ($FORM{'fromscr02'} eq '1') {
    if (!$FORM{'npmwinjavav2H'}) {$FORM{'npmwinjavav2H'} = 1 ;}
    if (!$FORM{'npmwinjavav2F'}) {$FORM{'npmwinjavav2F'} = 0 ;}
  }
  $strLicH=$FORM{'npmwinjavav2H'} ;
  if ($strLicH < 0) { $strLicH = 0 ; }
  $strLicF=$FORM{'npmwinjavav2F'} ;
  if ($strLicF < 0) { $strLicF = 0 ; }

  $actpage.="<td class=\"narr\" align=center><input type=text onChange=\"verify(this)\" name=\"npmwinjavav2H\" value=\"$strLicH\" size=\"2\"></td>\n<td class=\"narr\" align=right>" ;
  if ($strLicH > 0) {
    $actpage.= "<b>4995.00</b>" ;
  } else {
    $actpage.= "4995.00" ;
  }
  $actpage.="<td class=\"narr\" align=center><input type=text onChange=\"verify(this)\" name=\"npmwinjavav2F\" value=\"$strLicF\" size=\"2\"></td>\n<td class=\"narr\" align=right>" ;
  if ($strLicF > 0) {
    $actpage.= "<b>6995.00</b>" ;
  } else {
    $actpage.= "6995.00" ;
  }
  $actpage.="</td>\n<td class=\"narr\" align=right>" . sprintf("%.2f",(($strLicH * 4995) + ($strLicF * 6995))) . "</td></tr>\n" ;
  if ($strLicH > 0) { 
    $desc.= "$strLicH x HL Krakatau Project Manager (Java) for Windows + Maint.<br>" ;
    $emailtext.="Host-locked Krakatau Project Manager (Java) for Windows\n  ".$strLicH." x (4995 + 995) = ".sprintf("%.0f",($strLicH * (4995 + 995)))."\n" ;
  }
  if ($strLicF > 0) { 
    $desc.= "$strLicF x FLOAT Krakatau Project Manager (Java) for Windows + Maint.<br>" ;
    $emailtext.="Floating Krakatau Project Manager (Java) for Windows\n  ".$strLicF." x (6995 + 1295) = ".sprintf("%.0f",($strLicF * (6995 + 1295))) . "\n" ;
  }
  $actpage.="<tr width=\"100%\">" ;
  $actpage.="\n<td class=\"narr\">Annual Maintenance for above</td>\n" ;
  $actpage.="<td class=\"narr\" align=center>$strLicH</td><td class=\"narr\" align=right>" ;
  if ($strLicH > 0) {
    $actpage.= "<b>995.00</b>" ;
  } else {
    $actpage.= "995.00" ;
  }
  $actpage.="</td>\n<td class=\"narr\" align=center>$strLicF</td><td class=\"narr\" align=right>" ;
  if ($strLicF > 0) {
    $actpage.= "<b>1295.00</b>" ;
  } else {
    $actpage.= "1295.00" ;
  }
  $actpage.="</td>\n<td class=\"narr\" align=right>" . sprintf("%.2f",(($strLicH * 995) + ($strLicF * 1295))) . "</td></tr>\n" ;

  $amount += ($strLicH * 4995) ;
  $amount += ($strLicF * 6995) ;
  $amount += ($strLicH * 995) ;
  $amount += ($strLicF * 1295) ;
}


# -- OptimizeIt 4.02 for Sparc/Solaris -----------------------------------------

if ($FORM{'optsolaris'} eq 'y') {
  $actpage.="<input type=hidden name=\"optsolaris\" value=\"y\"><tr width=\"100%\"><td class=\"narr\">OptimizeIt 4.02 for Sparc/Solaris</td>" ;
  if ($FORM{'fromscr02'} eq '1') {
    if (!$FORM{'noptsolarisH'}) {$FORM{'noptsolarisH'} = 1 ;}
    if (!$FORM{'noptsolarisF'}) {$FORM{'noptsolarisF'} = 0 ;}
  }
  $strLicH=$FORM{'noptsolarisH'} ;
  if ($strLicH < 0) { $strLicH = 0 ; }
  $strLicF=$FORM{'noptsolarisF'} ;
  if ($strLicF < 0) { $strLicF = 0 ; }

  $actpage.="<td class=\"narr\" align=center><input type=text onChange=\"verify(this)\" name=\"noptsolarisH\" value=\"$strLicH\" size=\"2\"></td>\n<td class=\"narr\" align=right>" ;
  if ($strLicH > 0) {
    $actpage.= "<b>695.00</b>" ;
  } else {
    $actpage.= "695.00" ;
  }
  $actpage.="<td class=\"narr\" align=center><input type=text onChange=\"verify(this)\" name=\"noptsolarisF\" value=\"$strLicF\" size=\"2\"></td>\n<td class=\"narr\" align=right>" ;
  if ($strLicF > 0) {
    $actpage.= "<b>995.00</b>" ;
  } else {
    $actpage.= "995.00" ;
  }
  $actpage.="</td>\n<td class=\"narr\" align=right>" . sprintf("%.2f",(($strLicH * 695) + ($strLicF * 995))) . "</td></tr>\n" ;
  if ($strLicH > 0) { 
    $desc.= "$strLicH x HL OptimizeIt 4.02 for Sparc/Solaris + Maint.<br>" ;
    $emailtext.="Host-locked OptimizeIt 4.02 for Sparc/Solaris\n  ".$strLicH." x (695 + 120) = ".sprintf("%.0f",($strLicH * (695 + 120)))."\n" ;
  }
  if ($strLicF > 0) { 
    $desc.= "$strLicF x FLOAT OptimizeIt 4.02 for Sparc/Solaris + Maint.<br>" ;
    $emailtext.="Floating OptimizeIt 4.02 for Sparc/Solaris\n  ".$strLicF." x (995 + 245) = ".sprintf("%.0f",($strLicF * (995 + 245))) . "\n" ;
  }
  $actpage.="<tr width=\"100%\">" ;
  $actpage.="\n<td class=\"narr\">Annual Maintenance for above</td>\n" ;
  $actpage.="<td class=\"narr\" align=center>$strLicH</td><td class=\"narr\" align=right>" ;
  if ($strLicH > 0) {
    $actpage.= "<b>120.00</b>" ;
  } else {
    $actpage.= "120.00" ;
  }
  $actpage.="</td>\n<td class=\"narr\" align=center>$strLicF</td><td class=\"narr\" align=right>" ;
  if ($strLicF > 0) {
    $actpage.= "<b>245.00</b>" ;
  } else {
    $actpage.= "245.00" ;
  }
  $actpage.="</td>\n<td class=\"narr\" align=right>" . sprintf("%.2f",(($strLicH * 120) + ($strLicF * 245))) . "</td></tr>\n" ;

  $amount += ($strLicH * 695) ;
  $amount += ($strLicF * 995) ;
  $amount += ($strLicH * 120) ;
  $amount += ($strLicF * 245) ;
}


# -- OptimizeIt 4.02 for Windows -----------------------------------------------

if ($FORM{'optwin'} eq 'y') {
  $actpage.="<input type=hidden name=\"optwin\" value=\"y\"><tr width=\"100%\"><td class=\"narr\">OptimizeIt 4.02 for Windows</td>" ;
  if ($FORM{'fromscr02'} eq '1') {
    if (!$FORM{'noptwinH'}) {$FORM{'noptwinH'} = 1 ;}
    if (!$FORM{'noptwinF'}) {$FORM{'noptwinF'} = 0 ;}
  }
  $strLicH=$FORM{'noptwinH'} ;
  if ($strLicH < 0) { $strLicH = 0 ; }
  $strLicF=$FORM{'noptwinF'} ;
  if ($strLicF < 0) { $strLicF = 0 ; }

  $actpage.="<td class=\"narr\" align=center><input type=text onChange=\"verify(this)\" name=\"noptwinH\" value=\"$strLicH\" size=\"2\"></td>\n<td class=\"narr\" align=right>" ;
  if ($strLicH > 0) {
    $actpage.= "<b>695.00</b>" ;
  } else {
    $actpage.= "695.00" ;
  }
  $actpage.="<td class=\"narr\" align=center><input type=text onChange=\"verify(this)\" name=\"noptwinF\" value=\"$strLicF\" size=\"2\"></td>\n<td class=\"narr\" align=right>" ;
  if ($strLicF > 0) {
    $actpage.= "<b>995.00</b>" ;
  } else {
    $actpage.= "995.00" ;
  }
  $actpage.="</td>\n<td class=\"narr\" align=right>" . sprintf("%.2f",(($strLicH * 695) + ($strLicF * 995))) . "</td></tr>\n" ;
  if ($strLicH > 0) { 
    $desc.= "$strLicH x HL OptimizeIt 4.02 for Windows + Maint.<br>" ;
    $emailtext.="Host-locked OptimizeIt 4.02 for Windows\n  ".$strLicH." x (695 + 120) = ".sprintf("%.0f",($strLicH * (695 + 120)))."\n" ;
  }
  if ($strLicF > 0) { 
    $desc.= "$strLicF x FLOAT OptimizeIt 4.02 for Windows + Maint.<br>" ;
    $emailtext.="Floating OptimizeIt 4.02 for Windows\n  ".$strLicF." x (995 + 245) = ".sprintf("%.0f",($strLicF * (995 + 245))) . "\n" ;
  }
  $actpage.="<tr width=\"100%\">" ;
  $actpage.="\n<td class=\"narr\">Annual Maintenance for above</td>\n" ;
  $actpage.="<td class=\"narr\" align=center>$strLicH</td><td class=\"narr\" align=right>" ;
  if ($strLicH > 0) {
    $actpage.= "<b>120.00</b>" ;
  } else {
    $actpage.= "120.00" ;
  }
  $actpage.="</td>\n<td class=\"narr\" align=center>$strLicF</td><td class=\"narr\" align=right>" ;
  if ($strLicF > 0) {
    $actpage.= "<b>245.00</b>" ;
  } else {
    $actpage.= "245.00" ;
  }
  $actpage.="</td>\n<td class=\"narr\" align=right>" . sprintf("%.2f",(($strLicH * 120) + ($strLicF * 245))) . "</td></tr>\n" ;

  $amount += ($strLicH * 695) ;
  $amount += ($strLicF * 995) ;
  $amount += ($strLicH * 120) ;
  $amount += ($strLicF * 245) ;
}


# -- Visualize it! for Solaris -------------------------------------------------

if ($FORM{'vzsoljava'} eq 'y') {
  $actpage.="<input type=hidden name=\"vzsoljava\" value=\"y\"><tr width=\"100%\"><td class=\"narr\">Visualize it! for Solaris</td>" ;
  if ($FORM{'fromscr02'} eq '1') {
    if (!$FORM{'nvzsoljavaH'}) {$FORM{'nvzsoljavaH'} = 1 ;}
    if (!$FORM{'nvzsoljavaF'}) {$FORM{'nvzsoljavaF'} = 0 ;}
  }
  $strLicH=$FORM{'nvzsoljavaH'} ;
  if ($strLicH < 0) { $strLicH = 0 ; }
  $strLicF=$FORM{'nvzsoljavaF'} ;
  if ($strLicF < 0) { $strLicF = 0 ; }

  $actpage.="<td class=\"narr\" align=center><input type=text onChange=\"verify(this)\" name=\"nvzsoljavaH\" value=\"$strLicH\" size=\"2\"></td>\n<td class=\"narr\" align=right>" ;
  if ($strLicH > 0) {
    $actpage.= "<b>495.00</b>" ;
  } else {
    $actpage.= "495.00" ;
  }
  $actpage.="<td class=\"narr\" align=center><input type=text onChange=\"verify(this)\" name=\"nvzsoljavaF\" value=\"$strLicF\" size=\"2\"></td>\n<td class=\"narr\" align=right>" ;
  if ($strLicF > 0) {
    $actpage.= "<b>995.00</b>" ;
  } else {
    $actpage.= "995.00" ;
  }
  $actpage.="</td>\n<td class=\"narr\" align=right>" . sprintf("%.2f",(($strLicH * 495) + ($strLicF * 995))) . "</td></tr>\n" ;
  if ($strLicH > 0) { 
    $desc.= "$strLicH x HL Visualize it! for Solaris + Maint.<br>" ;
    $emailtext.="Host-locked Visualize it! for Solaris\n  ".$strLicH." x (495 + 95) = ".sprintf("%.0f",($strLicH * (495 + 95)))."\n" ;
  }
  if ($strLicF > 0) { 
    $desc.= "$strLicF x FLOAT Visualize it! for Solaris + Maint.<br>" ;
    $emailtext.="Floating Visualize it! for Solaris\n  ".$strLicF." x (995 + 190) = ".sprintf("%.0f",($strLicF * (995 + 190))) . "\n" ;
  }
  $actpage.="<tr width=\"100%\">" ;
  $actpage.="\n<td class=\"narr\">Annual Maintenance for above</td>\n" ;
  $actpage.="<td class=\"narr\" align=center>$strLicH</td><td class=\"narr\" align=right>" ;
  if ($strLicH > 0) {
    $actpage.= "<b>95.00</b>" ;
  } else {
    $actpage.= "95.00" ;
  }
  $actpage.="</td>\n<td class=\"narr\" align=center>$strLicF</td><td class=\"narr\" align=right>" ;
  if ($strLicF > 0) {
    $actpage.= "<b>190.00</b>" ;
  } else {
    $actpage.= "190.00" ;
  }
  $actpage.="</td>\n<td class=\"narr\" align=right>" . sprintf("%.2f",(($strLicH * 95) + ($strLicF * 190))) . "</td></tr>\n" ;

  $amount += ($strLicH * 495) ;
  $amount += ($strLicF * 995) ;
  $amount += ($strLicH * 95) ;
  $amount += ($strLicF * 190) ;
}


# -- Visualize it! for Windows -------------------------------------------------

if ($FORM{'vzwinjava'} eq 'y') {
  $actpage.="<input type=hidden name=\"vzwinjava\" value=\"y\"><tr width=\"100%\"><td class=\"narr\">Visualize it! for Windows</td>" ;
  if ($FORM{'fromscr02'} eq '1') {
    if (!$FORM{'nvzwinjavaH'}) {$FORM{'nvzwinjavaH'} = 1 ;}
    if (!$FORM{'nvzwinjavaF'}) {$FORM{'nvzwinjavaF'} = 0 ;}
  }
  $strLicH=$FORM{'nvzwinjavaH'} ;
  if ($strLicH < 0) { $strLicH = 0 ; }
  $strLicF=$FORM{'nvzwinjavaF'} ;
  if ($strLicF < 0) { $strLicF = 0 ; }

  $actpage.="<td class=\"narr\" align=center><input type=text onChange=\"verify(this)\" name=\"nvzwinjavaH\" value=\"$strLicH\" size=\"2\"></td>\n<td class=\"narr\" align=right>" ;
  if ($strLicH > 0) {
    $actpage.= "<b>495.00</b>" ;
  } else {
    $actpage.= "495.00" ;
  }
  $actpage.="<td class=\"narr\" align=center><input type=text onChange=\"verify(this)\" name=\"nvzwinjavaF\" value=\"$strLicF\" size=\"2\"></td>\n<td class=\"narr\" align=right>" ;
  if ($strLicF > 0) {
    $actpage.= "<b>995.00</b>" ;
  } else {
    $actpage.= "995.00" ;
  }
  $actpage.="</td>\n<td class=\"narr\" align=right>" . sprintf("%.2f",(($strLicH * 495) + ($strLicF * 995))) . "</td></tr>\n" ;
  if ($strLicH > 0) { 
    $desc.= "$strLicH x HL Visualize it! for Windows + Maint.<br>" ;
    $emailtext.="Host-locked Visualize it! for Windows\n  ".$strLicH." x (495 + 95) = ".sprintf("%.0f",($strLicH * (495 + 95)))."\n" ;
  }
  if ($strLicF > 0) { 
    $desc.= "$strLicF x FLOAT Visualize it! for Windows + Maint.<br>" ;
    $emailtext.="Floating Visualize it! for Windows\n  ".$strLicF." x (995 + 190) = ".sprintf("%.0f",($strLicF * (995 + 190))) . "\n" ;
  }
  $actpage.="<tr width=\"100%\">" ;
  $actpage.="\n<td class=\"narr\">Annual Maintenance for above</td>\n" ;
  $actpage.="<td class=\"narr\" align=center>$strLicH</td><td class=\"narr\" align=right>" ;
  if ($strLicH > 0) {
    $actpage.= "<b>95.00</b>" ;
  } else {
    $actpage.= "95.00" ;
  }
  $actpage.="</td>\n<td class=\"narr\" align=center>$strLicF</td><td class=\"narr\" align=right>" ;
  if ($strLicF > 0) {
    $actpage.= "<b>190.00</b>" ;
  } else {
    $actpage.= "190.00" ;
  }
  $actpage.="</td>\n<td class=\"narr\" align=right>" . sprintf("%.2f",(($strLicH * 95) + ($strLicF * 190))) . "</td></tr>\n" ;

  $amount += ($strLicH * 495) ;
  $amount += ($strLicF * 995) ;
  $amount += ($strLicH * 95) ;
  $amount += ($strLicF * 190) ;
}



# =-=-=-= GENERATED CODE ENDS =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

$emailtext.="=================================================================\n" ;

if (length($desc) > 255)
{
	$desc = substr($desc,0,255) ;
	$desc = substr($desc,0,rindex($desc,"<br>")) ;
	$desc .= "..." ;
}

if ($vat eq 0) {
  $subtotal=$amount ;
  $vatamount=$subtotal * 0.175 ;
  $amount+=$vatamount ;
}

$actpage.="<tr height=10><td colspan=6>" ;
$actpage.=&address_fields() ;
$actpage.="  <input type=hidden name=\"instId\" value=\"26311\">\n  " ;
$actpage.="<input type=hidden name=\"userlocation\" value=\"" . $userlocation . "\">\n  " ;
$actpage.="<input type=hidden name=\"cartId\" value=\"" . $cartid . "\">\n  " ;
$actpage.="<input type=hidden name=\"amount\" value=\"" . $amount . "\">\n  " ;
$actpage.="<input type=hidden name=\"desc\" value=\"" . $desc . "\">\n  " ;

if ($FORM{'countrygroup'} eq $cg_international) {
  $actpage.="<input type=hidden name=\"currency\" value=\"USD\">" ;
  $emailtext.="     Currency USD\n" ;

} elsif ($FORM{'countrygroup'} eq $cg_uk) {
  $actpage.="<input type=hidden name=\"currency\" value=\"GBP\">" ;
  $emailtext.="     Currency GBP\n" ;
} else {
  $actpage.="<input type=hidden name=\"currency\" value=\"GBP\">" ;
  $emailtext.="     Currency GBP\n" ;
}

if ($vat eq 0) {
  $actpage.="<tr width=\"100%\"><td colspan=5 class=\"narr\" align=right><b>Subtotal</b></td>" ;
  $actpage.="<td class=\"narr\" align=right>" . sprintf("%.2f",$subtotal) . "</td>" ;
  $actpage.="<tr width=\"100%\"><td colspan=5 class=\"narr\" align=right><b>VAT</b></td>" ;
  $actpage.="<td class=\"narr\" align=right>" . sprintf("%.2f",$vatamount) . "</td>" ;
  
  $emailtext.="     Subtotal ".sprintf("%.2f",$subtotal)."\n" ;
  $emailtext.="          VAT ".sprintf("%.2f",$vatamount)."\n" ;
}

$actpage.="<input type=hidden name=\"testMode\" value=\"0\"><img src=\"http://www.powersoftware.com/img/f.gif\" width=1 height=10></td></tr>" ;

$actpage.="<tr width=\"100%\">" ;
$actpage.="<td colspan=5 class=\"narr\" align=right><b>Total</b></td>" ;
$actpage.="<td class=\"narr\" align=right>".sprintf("%.2f",$amount)."</td>" ;

$emailtext.="        Total ".sprintf("%.2f",$amount)."\n" ;

$actpage.="<tr><td colspan=6 class=\"narr\" align=right valign=center><input type=submit name=\"submit\" value=\"Buy Now\"></td></tr></table>" ;

$actpage.="\n<p class=\"narr\">Maintenance includes all new releases (minor and major), \n" ;
$actpage.="bug-fixes and support via email for a period of twelve months from the date of purchase. \n" ;
$actpage.="Maintenance must be purchased with your license.  A renewal notification will be \n" ;
$actpage.="issued one month prior to the expiry date.</p></table>\n" ;


$emailtext.="=================================================================\n" ;
$emailtext.="Remote host: $ENV{'REMOTE_HOST'}\n" ;
$emailtext.="Remote IP address: $ENV{'REMOTE_ADDR'}\n" ;

open (MAIL, "|$mailprog $recipient") || die "Can't open $mailprog!\n" ;
print MAIL "From: buyonline@powersoftware.com (Buy Online)\n" ;
print MAIL "Reply-to: $FORM{'email'} ($FORM{'name'})\n" ;
print MAIL "Subject: Purchase in progress... Invoice $cartid\n\n" ;
print MAIL $emailtext ;


$page=&get_file_contents($newfile) ;
$page=~s/$separator\s*/$actpage/ ;
$page=~s/$titleSeparator\s*/$titleText/ ;
$page=~s/$onLoadSeparator\s*/$onLoadText/ ;

$script=&get_file_contents($scriptFile) ;
$page=~s/$scriptSeparator\s*/$script/ ;

print $page ;
exit ;


# Build an input (with default value from previous page)
sub input_field {
  ($fieldtype, $fieldname, $fieldlen) = @_ ;
  $defaultvalue="" ;  
  
  if ($FORM{$fieldname}) {
    $defaultvalue=" value=\"".$FORM{$fieldname}."\"" ;
  }
  
  return "<input type=".$fieldtype." name=\"".$fieldname."\"".$defaultvalue." size=".$fieldlen.">"
}


sub address_fields {
  $addressfields = "" ;
  
  $addressfields.=&input_field('hidden', 'name', 1) ;
  $addressfields.=&input_field('hidden', 'email', 1) ;
  $addressfields.=&input_field('hidden', 'tel', 1) ;
  $addressfields.=&input_field('hidden', 'fax', 1) ;
  $addressfields.=&input_field('hidden', 'company', 1) ;

  $addressfields.=&input_field('hidden', 'street', 1) ;
  $addressfields.=&input_field('hidden', 'city', 1) ;
  $addressfields.=&input_field('hidden', 'state', 1) ;
  
  if ($FORM{'address'}) {
    $addressfields.=&input_field('hidden', 'address', 1) ;  
  } else {
    $addressfields.="<input type=hidden name=\"address\" value=\"" ;
    $addressfields.=$FORM{'street'}.",&#10;" ;
    $addressfields.=$FORM{'city'}.",&#10;" ;
    $addressfields.=$FORM{'state'}.".\">" ;
  }

  $addressfields.=&input_field('hidden', 'postcode', 1) ;
    
  $addressfields.="<input type=hidden name=\"countrygroup\" value=\"".$FORM{'countrygroup'}."\">" ;
  $addressfields.="<input type=hidden name=\"country\" value=\"".$FORM{'country'}."\">" ;
  $addressfields.="<input type=hidden name=\"countryname\" value=\"".$FORM{'countryname'}."\">" ;

  return $addressfields ;
}


sub increment_card_id {
  unless (open (FILE, "< $cartidfile"))
  {
    print "Cannot open $counterfile for reading." ;
    exit ;
  }

  undef ($/) ;
  $lastnum=<FILE> ;
  close FILE;

  $newnum=$lastnum+1 ;

  unless (open (FILE, "> $cartidfile"))
  {
    print "Cannot open $counterfile for writing." ;
    exit ;
  }
  
  undef ($/) ;
  print FILE $newnum ;
  close FILE ;

  return $newnum+'' ;
}

sub get_file_contents {
  $filename = @_[0] ;
  $filecontents = '' ;
  
  unless (open (FILE, "$filename"))
  {
    exit ;
  }
  undef ($/) ;
  $filecontents=<FILE> ;
  close FILE ;
  return $filecontents ;
}

