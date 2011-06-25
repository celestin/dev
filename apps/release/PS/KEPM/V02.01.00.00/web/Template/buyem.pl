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
$titleText = 'Buy Essential Metrics Online' ;

# Body, On Load event
$onLoadSeparator = "<!--onLoad-->" ;

# JavaScript to be inserted into the page
$scriptSeparator = '<!--Javascript-->' ;
$scriptFile = '/u/p/o/w/powersft/docs/script/buyem.js' ;


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
$actpage.="<td width=\"70%\" class=\"narr\"><img src=\"http://www.powersoftware.com/img/f.gif\"</td>" ;
$actpage.="<td width=\"10%\" class=\"narr\" align=center><b>Qty</b></td>" ;
$actpage.="<td width=\"10%\" class=\"narr\" align=right><b>Price</b></td>" ;
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
# === Home user ================================================================
  $actpage.="<tr width=\"100%\"><td colspan=4 class=\"narr\"><b>Home user</b></td></tr>" ;

# -- Single machine license ----------------------------------------------------

  $actpage.="<tr width=\"100%\"><td class=\"narr\">Single machine license</td>" ;
  $strQty=$FORM{'h01'} ;
  if ($strQty < 0) { $strQty = 0 ; }

  $actpage.="<td class=\"narr\" align=center><input type=text onChange=\"verify(this)\" name=\"h01\" value=\"$strQty\" size=\"2\"></td>\n<td class=\"narr\" align=right>" ;
  if ($strQty > 0) {
    $actpage.= "<b>99.00</b>" ;
  } else {
    $actpage.= "99.00" ;
  }
  
  $actpage.="</td>\n<td class=\"narr\" align=right>" . sprintf("%.2f",($strQty * 99.00)) . "</td></tr>\n" ;
  if ($strQty > 0) {
    $desc.= $strQty." x Home:Single machine license @ 99.00<br>" ;
    $emailtext.= $strQty." x Home:Single machine license @ 99.00\n" ;
  }

  if ($FORM{'h01'} > 0) {
    $amount += ($strQty * 99) ;
  }


# -- 90 days Maintenance and Email Support -------------------------------------

  $actpage.="<tr width=\"100%\"><td class=\"narr\">90 days Maintenance and Email Support</td>" ;
  $strQty=$FORM{'h51'} ;
  if ($strQty < 0) { $strQty = 0 ; }

  $actpage.="<td class=\"narr\" align=center><input type=text onChange=\"verify(this)\" name=\"h51\" value=\"$strQty\" size=\"2\"></td>\n<td class=\"narr\" align=right>" ;
  if ($strQty > 0) {
    $actpage.= "<b>99.00</b>" ;
  } else {
    $actpage.= "99.00" ;
  }
  
  $actpage.="</td>\n<td class=\"narr\" align=right>" . sprintf("%.2f",($strQty * 99.00)) . "</td></tr>\n" ;
  if ($strQty > 0) {
    $desc.= $strQty." x Home:90 days Maintenance and Email Support @ 99.00<br>" ;
    $emailtext.= $strQty." x Home:90 days Maintenance and Email Support @ 99.00\n" ;
  }

  if ($FORM{'h51'} > 0) {
    $amount += ($strQty * 99) ;
  }


# === Educational Licenses =====================================================
  $actpage.="<tr width=\"100%\"><td colspan=4 class=\"narr\"><b>Educational Licenses</b></td></tr>" ;

# -- Single machine license ----------------------------------------------------

  $actpage.="<tr width=\"100%\"><td class=\"narr\">Single machine license</td>" ;
  $strQty=$FORM{'e01'} ;
  if ($strQty < 0) { $strQty = 0 ; }

  $actpage.="<td class=\"narr\" align=center><input type=text onChange=\"verify(this)\" name=\"e01\" value=\"$strQty\" size=\"2\"></td>\n<td class=\"narr\" align=right>" ;
  if ($strQty > 0) {
    $actpage.= "<b>99.00</b>" ;
  } else {
    $actpage.= "99.00" ;
  }
  
  $actpage.="</td>\n<td class=\"narr\" align=right>" . sprintf("%.2f",($strQty * 99.00)) . "</td></tr>\n" ;
  if ($strQty > 0) {
    $desc.= $strQty." x Edu:Single machine license @ 99.00<br>" ;
    $emailtext.= $strQty." x Edu:Single machine license @ 99.00\n" ;
  }

  if ($FORM{'e01'} > 0) {
    $amount += ($strQty * 99) ;
  }


# -- Campus license ------------------------------------------------------------

  $actpage.="<tr width=\"100%\"><td class=\"narr\">Campus license</td>" ;
  $strQty=$FORM{'e02'} ;
  if ($strQty < 0) { $strQty = 0 ; }

  $actpage.="<td class=\"narr\" align=center><input type=text onChange=\"verify(this)\" name=\"e02\" value=\"$strQty\" size=\"2\"></td>\n<td class=\"narr\" align=right>" ;
  if ($strQty > 0) {
    $actpage.= "<b>2995.00</b>" ;
  } else {
    $actpage.= "2995.00" ;
  }
  
  $actpage.="</td>\n<td class=\"narr\" align=right>" . sprintf("%.2f",($strQty * 2995.00)) . "</td></tr>\n" ;
  if ($strQty > 0) {
    $desc.= $strQty." x Edu:Campus license @ 2995.00<br>" ;
    $emailtext.= $strQty." x Edu:Campus license @ 2995.00\n" ;
  }

  if ($FORM{'e02'} > 0) {
    $amount += ($strQty * 2995) ;
  }


# -- 90 days Maintenance and Email Support -------------------------------------

  $actpage.="<tr width=\"100%\"><td class=\"narr\">90 days Maintenance and Email Support</td>" ;
  $strQty=$FORM{'e51'} ;
  if ($strQty < 0) { $strQty = 0 ; }

  $actpage.="<td class=\"narr\" align=center><input type=text onChange=\"verify(this)\" name=\"e51\" value=\"$strQty\" size=\"2\"></td>\n<td class=\"narr\" align=right>" ;
  if ($strQty > 0) {
    $actpage.= "<b>995.00</b>" ;
  } else {
    $actpage.= "995.00" ;
  }
  
  $actpage.="</td>\n<td class=\"narr\" align=right>" . sprintf("%.2f",($strQty * 995.00)) . "</td></tr>\n" ;
  if ($strQty > 0) {
    $desc.= $strQty." x Edu:90 days Maintenance and Email Support @ 995.00<br>" ;
    $emailtext.= $strQty." x Edu:90 days Maintenance and Email Support @ 995.00\n" ;
  }

  if ($FORM{'e51'} > 0) {
    $amount += ($strQty * 995) ;
  }


# === Commerical Licenses ======================================================
  $actpage.="<tr width=\"100%\"><td colspan=4 class=\"narr\"><b>Commerical Licenses</b></td></tr>" ;

# -- Single machine license ----------------------------------------------------

  $actpage.="<tr width=\"100%\"><td class=\"narr\">Single machine license</td>" ;
  $strQty=$FORM{'c01'} ;
  if ($strQty < 0) { $strQty = 0 ; }

  $actpage.="<td class=\"narr\" align=center><input type=text onChange=\"verify(this)\" name=\"c01\" value=\"$strQty\" size=\"2\"></td>\n<td class=\"narr\" align=right>" ;
  if ($strQty > 0) {
    $actpage.= "<b>199.00</b>" ;
  } else {
    $actpage.= "199.00" ;
  }
  
  $actpage.="</td>\n<td class=\"narr\" align=right>" . sprintf("%.2f",($strQty * 199.00)) . "</td></tr>\n" ;
  if ($strQty > 0) {
    $desc.= $strQty." x Com:Single machine license @ 199.00<br>" ;
    $emailtext.= $strQty." x Com:Single machine license @ 199.00\n" ;
  }

  if ($FORM{'c01'} > 0) {
    $amount += ($strQty * 199) ;
  }


# -- 12 months Maintenance and Email Support -----------------------------------

  $actpage.="<tr width=\"100%\"><td class=\"narr\">12 months Maintenance and Email Support</td>" ;
  $strQty=$FORM{'c51'} ;
  if ($strQty < 0) { $strQty = 0 ; }

  $actpage.="<td class=\"narr\" align=center><input type=text onChange=\"verify(this)\" name=\"c51\" value=\"$strQty\" size=\"2\"></td>\n<td class=\"narr\" align=right>" ;
  if ($strQty > 0) {
    $actpage.= "<b>99.00</b>" ;
  } else {
    $actpage.= "99.00" ;
  }
  
  $actpage.="</td>\n<td class=\"narr\" align=right>" . sprintf("%.2f",($strQty * 99.00)) . "</td></tr>\n" ;
  if ($strQty > 0) {
    $desc.= $strQty." x Com:12 months Maintenance and Email Support @ 99.00<br>" ;
    $emailtext.= $strQty." x Com:12 months Maintenance and Email Support @ 99.00\n" ;
  }

  if ($FORM{'c51'} > 0) {
    $amount += ($strQty * 99) ;
  }


# -- Ten machine licenses ------------------------------------------------------

  $actpage.="<tr width=\"100%\"><td class=\"narr\">Ten machine licenses</td>" ;
  $strQty=$FORM{'c10'} ;
  if ($strQty < 0) { $strQty = 0 ; }

  $actpage.="<td class=\"narr\" align=center><input type=text onChange=\"verify(this)\" name=\"c10\" value=\"$strQty\" size=\"2\"></td>\n<td class=\"narr\" align=right>" ;
  if ($strQty > 0) {
    $actpage.= "<b>995.00</b>" ;
  } else {
    $actpage.= "995.00" ;
  }
  
  $actpage.="</td>\n<td class=\"narr\" align=right>" . sprintf("%.2f",($strQty * 995.00)) . "</td></tr>\n" ;
  if ($strQty > 0) {
    $desc.= $strQty." x Com:Ten machine licenses @ 995.00<br>" ;
    $emailtext.= $strQty." x Com:Ten machine licenses @ 995.00\n" ;
  }

  if ($FORM{'c10'} > 0) {
    $amount += ($strQty * 995) ;
  }


# -- 12 months Maintenance and Email Support -----------------------------------

  $actpage.="<tr width=\"100%\"><td class=\"narr\">12 months Maintenance and Email Support</td>" ;
  $strQty=$FORM{'c52'} ;
  if ($strQty < 0) { $strQty = 0 ; }

  $actpage.="<td class=\"narr\" align=center><input type=text onChange=\"verify(this)\" name=\"c52\" value=\"$strQty\" size=\"2\"></td>\n<td class=\"narr\" align=right>" ;
  if ($strQty > 0) {
    $actpage.= "<b>195.00</b>" ;
  } else {
    $actpage.= "195.00" ;
  }
  
  $actpage.="</td>\n<td class=\"narr\" align=right>" . sprintf("%.2f",($strQty * 195.00)) . "</td></tr>\n" ;
  if ($strQty > 0) {
    $desc.= $strQty." x Com:12 months Maintenance and Email Support @ 195.00<br>" ;
    $emailtext.= $strQty." x Com:12 months Maintenance and Email Support @ 195.00\n" ;
  }

  if ($FORM{'c52'} > 0) {
    $amount += ($strQty * 195) ;
  }


# === FLEXlm Floating Licenses =================================================
  $actpage.="<tr width=\"100%\"><td colspan=4 class=\"narr\"><b>FLEXlm Floating Licenses</b></td></tr>" ;

# -- Server License ------------------------------------------------------------

  $actpage.="<tr width=\"100%\"><td class=\"narr\">Server License</td>" ;

  $checked = " " ;
  if ($FORM{'f01'} eq 'y') {
    $checked = " checked " ;
  }
  $actpage.="<td class=\"narr\" align=center><input type=checkbox".$checked."onChange=\"recalculate()\" name=\"f01\" value=\"y\" size=\"2\"></td>\n<td class=\"narr\" align=right>" ;
  if ($FORM{'f01'} eq 'y') {
    $bulkcost = 4995.00 ;
    $actpage.= "<b>4995.00</b>" ;
  } else {
    $bulkcost = 0 ;
    $actpage.= "4995.00" ;
  }
  
  $actpage.="</td>\n<td class=\"narr\" align=right>" . sprintf("%.2f", $bulkcost) . "</td></tr>\n" ;
  if ($FORM{'f01'} eq 'y') {
    $desc.= "Float:Server License @ 4995.00<br>" ;
    $emailtext.= "Float:Server License @ 4995.00\n" ;
  }

  if ($FORM{'f01'} eq 'y') {
    $amount += 4995.00 ;
  }


# -- User License<br><I>User Licenses must be purchased in conjunction with one 

  $actpage.="<tr width=\"100%\"><td class=\"narr\">User License<br><I>User Licenses must be purchased in conjunction with one Server License</I></td>" ;
  $strQty=$FORM{'f02'} ;
  if ($strQty < 0) { $strQty = 0 ; }

  $actpage.="<td class=\"narr\" align=center><input type=text onChange=\"verify(this)\" name=\"f02\" value=\"$strQty\" size=\"2\"></td>\n<td class=\"narr\" align=right>" ;
  if ($strQty > 0) {
    $actpage.= "<b>99.00</b>" ;
  } else {
    $actpage.= "99.00" ;
  }
  
  $actpage.="</td>\n<td class=\"narr\" align=right>" . sprintf("%.2f",($strQty * 99.00)) . "</td></tr>\n" ;
  if ($strQty > 0) {
    $desc.= $strQty." x Float:User License<br><I>User Licenses must be purchased in conjunction with one Server License</I> @ 99.00<br>" ;
    $emailtext.= $strQty." x Float:User License<br><I>User Licenses must be purchased in conjunction with one Server License</I> @ 99.00\n" ;
  }

  if ($FORM{'f02'} > 0) {
    $amount += ($strQty * 99) ;
  }


# -- 12 months Maintenance and Email Support<br><I>Support must be purchased for

  $actpage.="<tr width=\"100%\"><td class=\"narr\">12 months Maintenance and Email Support<br><I>Support must be purchased for each User License where required</I></td>" ;
  $strQty=$FORM{'f51'} ;
  if ($strQty < 0) { $strQty = 0 ; }

  $actpage.="<td class=\"narr\" align=center><input type=text onChange=\"verify(this)\" name=\"f51\" value=\"$strQty\" size=\"2\"></td>\n<td class=\"narr\" align=right>" ;
  if ($strQty > 0) {
    $actpage.= "<b>15.00</b>" ;
  } else {
    $actpage.= "15.00" ;
  }
  
  $actpage.="</td>\n<td class=\"narr\" align=right>" . sprintf("%.2f",($strQty * 15.00)) . "</td></tr>\n" ;
  if ($strQty > 0) {
    $desc.= $strQty." x Float:12 months Maintenance and Email Support<br><I>Support must be purchased for each User License where required</I> @ 15.00<br>" ;
    $emailtext.= $strQty." x Float:12 months Maintenance and Email Support<br><I>Support must be purchased for each User License where required</I> @ 15.00\n" ;
  }

  if ($FORM{'f51'} > 0) {
    $amount += ($strQty * 15) ;
  }


# -- Site License --------------------------------------------------------------

  $actpage.="<tr width=\"100%\"><td class=\"narr\">Site License</td>" ;

  $checked = " " ;
  if ($FORM{'f03'} eq 'y') {
    $checked = " checked " ;
  }
  $actpage.="<td class=\"narr\" align=center><input type=checkbox".$checked."onChange=\"recalculate()\" name=\"f03\" value=\"y\" size=\"2\"></td>\n<td class=\"narr\" align=right>" ;
  if ($FORM{'f03'} eq 'y') {
    $bulkcost = 9995.00 ;
    $actpage.= "<b>9995.00</b>" ;
  } else {
    $bulkcost = 0 ;
    $actpage.= "9995.00" ;
  }
  
  $actpage.="</td>\n<td class=\"narr\" align=right>" . sprintf("%.2f", $bulkcost) . "</td></tr>\n" ;
  if ($FORM{'f03'} eq 'y') {
    $desc.= "Float:Site License @ 9995.00<br>" ;
    $emailtext.= "Float:Site License @ 9995.00\n" ;
  }

  if ($FORM{'f03'} eq 'y') {
    $amount += 9995.00 ;
  }


# -- 12 months Maintenance and Email Support<br><I>Applicable to Site License ab

  $actpage.="<tr width=\"100%\"><td class=\"narr\">12 months Maintenance and Email Support<br><I>Applicable to Site License above</I></td>" ;

  $checked = " " ;
  if ($FORM{'f52'} eq 'y') {
    $checked = " checked " ;
  }
  $actpage.="<td class=\"narr\" align=center><input type=checkbox".$checked."onChange=\"recalculate()\" name=\"f52\" value=\"y\" size=\"2\"></td>\n<td class=\"narr\" align=right>" ;
  if ($FORM{'f52'} eq 'y') {
    $bulkcost = 1995.00 ;
    $actpage.= "<b>1995.00</b>" ;
  } else {
    $bulkcost = 0 ;
    $actpage.= "1995.00" ;
  }
  
  $actpage.="</td>\n<td class=\"narr\" align=right>" . sprintf("%.2f", $bulkcost) . "</td></tr>\n" ;
  if ($FORM{'f52'} eq 'y') {
    $desc.= "Float:12 months Maintenance and Email Support<br><I>Applicable to Site License above</I> @ 1995.00<br>" ;
    $emailtext.= "Float:12 months Maintenance and Email Support<br><I>Applicable to Site License above</I> @ 1995.00\n" ;
  }

  if ($FORM{'f52'} eq 'y') {
    $amount += 1995.00 ;
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
  $actpage.="<tr width=\"100%\"><td colspan=3 class=\"narr\" align=right><b>Subtotal</b></td>" ;
  $actpage.="<td class=\"narr\" align=right>" . sprintf("%.2f",$subtotal) . "</td>" ;
  $actpage.="<tr width=\"100%\"><td colspan=3 class=\"narr\" align=right><b>VAT</b></td>" ;
  $actpage.="<td class=\"narr\" align=right>" . sprintf("%.2f",$vatamount) . "</td>" ;
  
  $emailtext.="     Subtotal ".sprintf("%.2f",$subtotal)."\n" ;
  $emailtext.="          VAT ".sprintf("%.2f",$vatamount)."\n" ;
}

$actpage.="<input type=hidden name=\"testMode\" value=\"0\"><img src=\"http://www.powersoftware.com/img/f.gif\" width=1 height=10></td></tr>" ;

$actpage.="<tr width=\"100%\">" ;
$actpage.="<td colspan=3 class=\"narr\" align=right><b>Total</b></td>" ;
$actpage.="<td class=\"narr\" align=right>".sprintf("%.2f",$amount)."</td>" ;

$emailtext.="        Total ".sprintf("%.2f",$amount)."\n" ;

$actpage.="<tr><td colspan=4 class=\"narr\" align=right valign=center><input type=submit name=\"submit\" value=\"Buy Now\"></td></tr></table>" ;

$actpage.="\n<p class=\"narr\"><b>Notes</b><ol><li class=\"narr\">Maintenance includes all new releases (minor and major), \n" ;
$actpage.="bug-fixes and support via email for a period of twelve months from the date of purchase. \n" ;
$actpage.="Maintenance must be purchased with your license.  A renewal notification will be \n" ;
$actpage.="issued one month prior to the expiry date.</li>" ;
$actpage.="<li class=\"narr\">Orders for less than 1,000.00 must be placed by Credit Card</li></ol></p></table>\n" ;


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

# -- FUNCTIONS -------------------------------------------------------------------------------------

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

