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
$titleText = 'Buy Visualize it! Online' ;

# Body, On Load event
$onLoadSeparator = "<!--onLoad-->" ;

# JavaScript to be inserted into the page
$scriptSeparator = '<!--Javascript-->' ;
$scriptFile = '/u/p/o/w/powersft/docs/script/buyvz.js' ;


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

# -- Single host-locked license ------------------------------------------------

  $actpage.="<tr width=\"100%\"><td class=\"narr\">Single host-locked license</td>" ;
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
    $desc.= $strQty." x Home:Single host-locked license @ 99.00<br>" ;
    $emailtext.= $strQty." x Home:Single host-locked license @ 99.00\n" ;
  }

  if ($FORM{'h01'} > 0) {
    $amount += ($strQty * 99) ;
  }


# === Educational Licenses =====================================================
  $actpage.="<tr width=\"100%\"><td colspan=4 class=\"narr\"><b>Educational Licenses</b></td></tr>" ;

# -- 1 license -----------------------------------------------------------------

  $actpage.="<tr width=\"100%\"><td class=\"narr\">1 license</td>" ;
  $strQty=$FORM{'e01'} ;
  if ($strQty < 0) { $strQty = 0 ; }

  $actpage.="<td class=\"narr\" align=center><input type=text onChange=\"verify(this)\" name=\"e01\" value=\"$strQty\" size=\"2\"></td>\n<td class=\"narr\" align=right>" ;
  if ($strQty > 0) {
    $actpage.= "<b>149.00</b>" ;
  } else {
    $actpage.= "149.00" ;
  }
  
  $actpage.="</td>\n<td class=\"narr\" align=right>" . sprintf("%.2f",($strQty * 149.00)) . "</td></tr>\n" ;
  if ($strQty > 0) {
    $desc.= $strQty." x Edu:1 license @ 149.00<br>" ;
    $emailtext.= $strQty." x Edu:1 license @ 149.00\n" ;
  }

  if ($FORM{'e01'} > 0) {
    $amount += ($strQty * 149) ;
  }


# -- 10 license pack -----------------------------------------------------------

  $actpage.="<tr width=\"100%\"><td class=\"narr\">10 license pack</td>" ;
  $strQty=$FORM{'e02'} ;
  if ($strQty < 0) { $strQty = 0 ; }

  $actpage.="<td class=\"narr\" align=center><input type=text onChange=\"verify(this)\" name=\"e02\" value=\"$strQty\" size=\"2\"></td>\n<td class=\"narr\" align=right>" ;
  if ($strQty > 0) {
    $actpage.= "<b>499.00</b>" ;
  } else {
    $actpage.= "499.00" ;
  }
  
  $actpage.="</td>\n<td class=\"narr\" align=right>" . sprintf("%.2f",($strQty * 499.00)) . "</td></tr>\n" ;
  if ($strQty > 0) {
    $desc.= $strQty." x Edu:10 license pack @ 499.00<br>" ;
    $emailtext.= $strQty." x Edu:10 license pack @ 499.00\n" ;
  }

  if ($FORM{'e02'} > 0) {
    $amount += ($strQty * 499) ;
  }


# -- Department license --------------------------------------------------------

  $actpage.="<tr width=\"100%\"><td class=\"narr\">Department license</td>" ;

  $checked = " " ;
  if ($FORM{'e03'} eq 'y') {
    $checked = " checked " ;
  }
  $actpage.="<td class=\"narr\" align=center><input type=checkbox".$checked."onChange=\"recalculate()\" name=\"e03\" value=\"y\" size=\"2\"></td>\n<td class=\"narr\" align=right>" ;
  if ($FORM{'e03'} eq 'y') {
    $bulkcost = 995.00 ;
    $actpage.= "<b>995.00</b>" ;
  } else {
    $bulkcost = 0 ;
    $actpage.= "995.00" ;
  }
  
  $actpage.="</td>\n<td class=\"narr\" align=right>" . sprintf("%.2f", $bulkcost) . "</td></tr>\n" ;
  if ($FORM{'e03'} eq 'y') {
    $desc.= "Edu:Department license @ 995.00<br>" ;
    $emailtext.= "Edu:Department license @ 995.00\n" ;
  }

  if ($FORM{'e03'} eq 'y') {
    $amount += 995.00 ;
  }


# -- Campus license ------------------------------------------------------------

  $actpage.="<tr width=\"100%\"><td class=\"narr\">Campus license</td>" ;

  $checked = " " ;
  if ($FORM{'e04'} eq 'y') {
    $checked = " checked " ;
  }
  $actpage.="<td class=\"narr\" align=center><input type=checkbox".$checked."onChange=\"recalculate()\" name=\"e04\" value=\"y\" size=\"2\"></td>\n<td class=\"narr\" align=right>" ;
  if ($FORM{'e04'} eq 'y') {
    $bulkcost = 2995.00 ;
    $actpage.= "<b>2995.00</b>" ;
  } else {
    $bulkcost = 0 ;
    $actpage.= "2995.00" ;
  }
  
  $actpage.="</td>\n<td class=\"narr\" align=right>" . sprintf("%.2f", $bulkcost) . "</td></tr>\n" ;
  if ($FORM{'e04'} eq 'y') {
    $desc.= "Edu:Campus license @ 2995.00<br>" ;
    $emailtext.= "Edu:Campus license @ 2995.00\n" ;
  }

  if ($FORM{'e04'} eq 'y') {
    $amount += 2995.00 ;
  }


# === Commerical Licenses ======================================================
  $actpage.="<tr width=\"100%\"><td colspan=4 class=\"narr\"><b>Commerical Licenses</b></td></tr>" ;

# -- 1 host-locked license -----------------------------------------------------

  $actpage.="<tr width=\"100%\"><td class=\"narr\">1 host-locked license</td>" ;
  $strQty=$FORM{'c01'} ;
  if ($strQty < 0) { $strQty = 0 ; }

  $actpage.="<td class=\"narr\" align=center><input type=text onChange=\"verify(this)\" name=\"c01\" value=\"$strQty\" size=\"2\"></td>\n<td class=\"narr\" align=right>" ;
  if ($strQty > 0) {
    $actpage.= "<b>495.00</b>" ;
  } else {
    $actpage.= "495.00" ;
  }
  
  $actpage.="</td>\n<td class=\"narr\" align=right>" . sprintf("%.2f",($strQty * 495.00)) . "</td></tr>\n" ;
  if ($strQty > 0) {
    $desc.= $strQty." x Com:1 host-locked license @ 495.00<br>" ;
    $emailtext.= $strQty." x Com:1 host-locked license @ 495.00\n" ;
  }

  if ($FORM{'c01'} > 0) {
    $amount += ($strQty * 495) ;
  }


# -- 1 floating license --------------------------------------------------------

  $actpage.="<tr width=\"100%\"><td class=\"narr\">1 floating license</td>" ;
  $strQty=$FORM{'c02'} ;
  if ($strQty < 0) { $strQty = 0 ; }

  $actpage.="<td class=\"narr\" align=center><input type=text onChange=\"verify(this)\" name=\"c02\" value=\"$strQty\" size=\"2\"></td>\n<td class=\"narr\" align=right>" ;
  if ($strQty > 0) {
    $actpage.= "<b>995.00</b>" ;
  } else {
    $actpage.= "995.00" ;
  }
  
  $actpage.="</td>\n<td class=\"narr\" align=right>" . sprintf("%.2f",($strQty * 995.00)) . "</td></tr>\n" ;
  if ($strQty > 0) {
    $desc.= $strQty." x Com:1 floating license @ 995.00<br>" ;
    $emailtext.= $strQty." x Com:1 floating license @ 995.00\n" ;
  }

  if ($FORM{'c02'} > 0) {
    $amount += ($strQty * 995) ;
  }


# -- 5 floating license pack ---------------------------------------------------

  $actpage.="<tr width=\"100%\"><td class=\"narr\">5 floating license pack</td>" ;
  $strQty=$FORM{'c03'} ;
  if ($strQty < 0) { $strQty = 0 ; }

  $actpage.="<td class=\"narr\" align=center><input type=text onChange=\"verify(this)\" name=\"c03\" value=\"$strQty\" size=\"2\"></td>\n<td class=\"narr\" align=right>" ;
  if ($strQty > 0) {
    $actpage.= "<b>2995.00</b>" ;
  } else {
    $actpage.= "2995.00" ;
  }
  
  $actpage.="</td>\n<td class=\"narr\" align=right>" . sprintf("%.2f",($strQty * 2995.00)) . "</td></tr>\n" ;
  if ($strQty > 0) {
    $desc.= $strQty." x Com:5 floating license pack @ 2995.00<br>" ;
    $emailtext.= $strQty." x Com:5 floating license pack @ 2995.00\n" ;
  }

  if ($FORM{'c03'} > 0) {
    $amount += ($strQty * 2995) ;
  }


# -- 10 floating license pack --------------------------------------------------

  $actpage.="<tr width=\"100%\"><td class=\"narr\">10 floating license pack</td>" ;
  $strQty=$FORM{'c04'} ;
  if ($strQty < 0) { $strQty = 0 ; }

  $actpage.="<td class=\"narr\" align=center><input type=text onChange=\"verify(this)\" name=\"c04\" value=\"$strQty\" size=\"2\"></td>\n<td class=\"narr\" align=right>" ;
  if ($strQty > 0) {
    $actpage.= "<b>4995.00</b>" ;
  } else {
    $actpage.= "4995.00" ;
  }
  
  $actpage.="</td>\n<td class=\"narr\" align=right>" . sprintf("%.2f",($strQty * 4995.00)) . "</td></tr>\n" ;
  if ($strQty > 0) {
    $desc.= $strQty." x Com:10 floating license pack @ 4995.00<br>" ;
    $emailtext.= $strQty." x Com:10 floating license pack @ 4995.00\n" ;
  }

  if ($FORM{'c04'} > 0) {
    $amount += ($strQty * 4995) ;
  }


# -- Site license --------------------------------------------------------------

  $actpage.="<tr width=\"100%\"><td class=\"narr\">Site license</td>" ;

  $checked = " " ;
  if ($FORM{'c05'} eq 'y') {
    $checked = " checked " ;
  }
  $actpage.="<td class=\"narr\" align=center><input type=checkbox".$checked."onChange=\"recalculate()\" name=\"c05\" value=\"y\" size=\"2\"></td>\n<td class=\"narr\" align=right>" ;
  if ($FORM{'c05'} eq 'y') {
    $bulkcost = 9995.00 ;
    $actpage.= "<b>9995.00</b>" ;
  } else {
    $bulkcost = 0 ;
    $actpage.= "9995.00" ;
  }
  
  $actpage.="</td>\n<td class=\"narr\" align=right>" . sprintf("%.2f", $bulkcost) . "</td></tr>\n" ;
  if ($FORM{'c05'} eq 'y') {
    $desc.= "Com:Site license @ 9995.00<br>" ;
    $emailtext.= "Com:Site license @ 9995.00\n" ;
  }

  if ($FORM{'c05'} eq 'y') {
    $amount += 9995.00 ;
  }



# =-=-=-= GENERATED CODE ENDS =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

$emailtext.="=================================================================\n" ;

# Email Support & Update options
$actpage.="<tr width=\"100%\"><td colspan=4 class=\"narr\"><b>Support Options</b></td></tr>" ;

$tenpercent = $amount * 0.1 ;
$checkedsupport=" " ;
$checkedupdate=" " ;

if ($FORM{'maintsupport'} eq 'y') {
  $amountsupport ="<b>".sprintf("%.2f", $tenpercent)."</b>" ;
  $subsupport = sprintf("%.2f", $tenpercent) ;
  $amount += $tenpercent ;
  $checkedsupport=" checked " ;
  
  $desc.= "Support @ ".$subsupport."<br>" ;
  $emailtext.="      Support ".sprintf("%.2f",$tenpercent)."\n" ;

} else {
  $amountsupport = sprintf("%.2f", $tenpercent) ;
  $subsupport = sprintf("%.2f", 0) ;
}

if ($FORM{'maintupdate'} eq 'y') {
  $amountupdate ="<b>".sprintf("%.2f", $tenpercent)."</b>" ;
  $subupdate = sprintf("%.2f", $tenpercent) ;
  $amount += $tenpercent ;
  $checkedupdate=" checked " ;

  $desc.= "Updates @ ".$subupdate."<br>" ;
  $emailtext.="      Updates ".sprintf("%.2f",$tenpercent)."\n" ;
} else {
  $amountupdate = sprintf("%.2f", $tenpercent) ;
  $subupdate = sprintf("%.2f", 0) ;
}

$actpage.="<tr><td class=\"narr\">Email Support (10% of license cost)</td><td align=center><input type=checkbox".$checkedsupport."value=\"y\" name=maintsupport onchange=\"recalculate();\"></td>" ;
$actpage.="<td align=right class=\"narr\">".$amountsupport."</td><td align=right class=\"narr\">".$subsupport."</td></tr>" ;

$actpage.="<tr><td class=\"narr\">Updates and new Releases (10% of license cost)</td><td align=center><input type=checkbox".$checkedupdate."value=\"y\" name=maintupdate onchange=\"recalculate();\"></td>" ;
$actpage.="<td align=right class=\"narr\">".$amountupdate."</td><td align=right class=\"narr\">".$subupdate."</td></tr>" ;

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

