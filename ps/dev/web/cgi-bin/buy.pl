#!/usr/bin/perl

# Define fairly-constants
$cg_international="0" ;
$cg_europe="1" ;
$cg_uk="2" ;
$cartidfile = '../buy/cartid' ;

# Mail settings
$mailprog = '/usr/sbin/sendmail' ;
$recipient = 'stephen@powersoftware.com' ;

# Name of the template HTML file which will be used to build new download page
$newfile = '../buy/template.html' ;
# Separator text in above file, giving point of insertion
$separator = '<!--start-->' ;

# Title Separator & Title Text
$titleSeparator = '<!--titleText-->' ;
$titleText = 'Buy Online' ;

# Body, On Load event
$onLoadSeparator = "<!--onLoad-->" ;

# JavaScript to be inserted into the page
$scriptSeparator = '<!--Javascript-->' ;
$scriptFile = '../buy/buy.js' ;


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

$actpage.="<table width=\"90%\" border=0>" ;
$actpage.="<tr width=\"100%\" align=right><td class=\"narr\">" ;
$actpage.="<input type=\"radio\" name=\"license\" " ;
if ($FORM{'license'} eq "float") {
	$actpage.="<input type=\"radio\" name=\"license\" onclick=\"doCalc()\" value=\"host\"> Host-Locked<input type=\"radio\" name=\"license\" checked value=\"float\"> Floating Server" ;
	$actpage.="</td></tr><tr width=\"100%\"><td>" ;
	$actpage.="<table width=\"100%\" border=1><tr width=\"100%\">" ;
	$actpage.="<td width=\"58%\" class=\"narr\">&nbsp;</td>" ;
	$actpage.="<td width=\"32%\" align=center colspan=2 class=\"narr\"><b>Floating Server</b></td>" ;
	$actpage.="<td width=\"10%\" class=\"narr\" align=center>&nbsp;</td></tr><tr>" ;
	$actpage.="<td width=\"58%\" class=\"narr\"><b>Product Description</b></td>" ;
	$actpage.="<td width=\"8%\" class=\"narr\" align=center><b>Qty</b></td>" ;
	$actpage.="<td width=\"8%\" class=\"narr\" align=right><b>Price</b></td>" ;
	$actpage.="<td width=\"10%\" class=\"narr\" align=right><b>Subtotal</b></td></tr>" ;
} else {
	$actpage.="<input type=\"radio\" name=\"license\" checked value=\"host\"> Host-Locked<input type=\"radio\" name=\"license\" onclick=\"doCalc()\" value=\"float\"> Floating Server" ;
	$actpage.="</td></tr><tr width=\"100%\"><td>" ;
	$actpage.="<table width=\"100%\" border=1><tr width=\"100%\">" ;
	$actpage.="<td width=\"58%\" class=\"narr\">&nbsp;</td>" ;
	$actpage.="<td width=\"32%\" align=center colspan=2 class=\"narr\"><b>Host-locked</b></td>" ;
	$actpage.="<td width=\"10%\" class=\"narr\" align=center>&nbsp;</td></tr><tr>" ;
	$actpage.="<td width=\"58%\" class=\"narr\"><b>Product Description</b></td>" ;
	$actpage.="<td width=\"16%\" class=\"narr\" align=center><b>Qty</b></td>" ;
	$actpage.="<td width=\"16%\" class=\"narr\" align=right><b>Price</b></td>" ;
	$actpage.="<td width=\"10%\" class=\"narr\" align=right><b>Subtotal</b></td></tr>" ;
}

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

# -- Krakatau Professional (C++) for Windows -----------------------------------

if ($FORM{'license'} eq "float") {
	$actpage.="<tr><td class=\"narr\">Floating License Server</td>" ;
	$actpage.="<td class=\"narr\" align=center>1</td>" ;
	$actpage.="<td class=\"narr\" align=right><b>9995</b></td>" ;
	$actpage.="<td class=\"narr\" align=right>9995.00</td></tr>" ;
	$actpage.="<tr><td class=\"narr\">Annual Maintenance for above</td>" ;
	$actpage.="<td class=\"narr\" align=center>1</td>" ;
	$actpage.="<td class=\"narr\" align=right><b>995</b></td>" ;
	$actpage.="<td class=\"narr\" align=right>995.00</td></tr>" ;
	$actpage.="<tr height=10><td colspan=6>&nbsp;</td></tr>" ;
	
	$amount=10990 ;
}

doProduct('kp','Krakatau Professional','2995','495','995','95') ;
doProduct('pm','Krakatau Project Manager','4995','995','1495','145') ;
doProduct('kl','Krakatau Lite','895','95','295','45') ;
doProduct('em','Essential Metrics','495','45','95','25') ;
doProduct('vz','Visualize it','495','45','95','25') ;

#if ($FORM{'kpwincppv2'} eq 'y') {
#  $actpage.="<input type=hidden name=\"kpwincppv2\" value=\"y\"><tr width=\"100%\"><td class=\"narr\">Krakatau Professional (C++) for Windows</td>" ;
#  if ($FORM{'fromscr02'} eq '1') {
#    if (!$FORM{'nkpwincppv2H'}) {$FORM{'nkpwincppv2H'} = 1 ;}
#    if (!$FORM{'nkpwincppv2F'}) {$FORM{'nkpwincppv2F'} = 0 ;}
#  }
#  $strLicH=$FORM{'nkpwincppv2H'} ;
#  if ($strLicH < 0) { $strLicH = 0 ; }
#  $strLicF=$FORM{'nkpwincppv2F'} ;
#  if ($strLicF < 0) { $strLicF = 0 ; }
#
#  $actpage.="<td class=\"narr\" align=center><input type=text onChange=\"verify(this)\" name=\"nkpwincppv2H\" value=\"$strLicH\" size=\"2\"></td>\n<td class=\"narr\" align=right>" ;
#  if ($strLicH > 0) {
#    $actpage.= "<b>2995.00</b>" ;
#  } else {
#    $actpage.= "2995.00" ;
#  }
#  $actpage.="<td class=\"narr\" align=center><input type=text onChange=\"verify(this)\" name=\"nkpwincppv2F\" value=\"$strLicF\" size=\"2\"></td>\n<td class=\"narr\" align=right>" ;
#  if ($strLicF > 0) {
#    $actpage.= "<b>4995.00</b>" ;
#  } else {
#    $actpage.= "4995.00" ;
#  }
#  $actpage.="</td>\n<td class=\"narr\" align=right>" . sprintf("%.2f",(($strLicH * 2995) + ($strLicF * 4995))) . "</td></tr>\n" ;
#  if ($strLicH > 0) { 
#    $desc.= "$strLicH x HL Krakatau Professional (C++) for Windows + Maint.<br>" ;
#    $emailtext.="Host-locked Krakatau Professional (C++) for Windows\n  ".$strLicH." x (2995 + 495) = ".sprintf("%.0f",($strLicH * (2995 + 495)))."\n" ;
#  }
#  if ($strLicF > 0) { 
#    $desc.= "$strLicF x FLOAT Krakatau Professional (C++) for Windows + Maint.<br>" ;
#    $emailtext.="Floating Krakatau Professional (C++) for Windows\n  ".$strLicF." x (4995 + 695) = ".sprintf("%.0f",($strLicF * (4995 + 695))) . "\n" ;
#  }
#  $actpage.="<tr width=\"100%\">" ;
#  $actpage.="\n<td class=\"narr\">Annual Maintenance for above</td>\n" ;
#  $actpage.="<td class=\"narr\" align=center>$strLicH</td><td class=\"narr\" align=right>" ;
#  if ($strLicH > 0) {
#    $actpage.= "<b>495.00</b>" ;
#  } else {
#    $actpage.= "495.00" ;
#  }
#  $actpage.="</td>\n<td class=\"narr\" align=center>$strLicF</td><td class=\"narr\" align=right>" ;
#  if ($strLicF > 0) {
#    $actpage.= "<b>695.00</b>" ;
#  } else {
#    $actpage.= "695.00" ;
#  }
#  $actpage.="</td>\n<td class=\"narr\" align=right>" . sprintf("%.2f",(($strLicH * 495) + ($strLicF * 695))) . "</td></tr>\n" ;
#
#  $amount += ($strLicH * 2995) ;
#  $amount += ($strLicF * 4995) ;
#  $amount += ($strLicH * 495) ;
#  $amount += ($strLicF * 695) ;
#}
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
$actpage.="<td class=\"narr\" align=right>".sprintf("%.2f",$amount)."</td></tr>" ;

$emailtext.="        Total ".sprintf("%.2f",$amount)."\n" ;

$actpage.="<tr><td colspan=6 class=\"narr\" align=right valign=center><input type=submit name=\"submit\" value=\"Buy Now\"></td></tr></table>" ;
$actpage.="</td></tr></table>" ;

$actpage.="\n<p class=\"narr\">Maintenance includes all new releases (minor and major), \n" ;
$actpage.="bug-fixes and support via email for a period of twelve months from the date of purchase. \n" ;
$actpage.="Maintenance must be purchased with your license.  A renewal notification will be \n" ;
$actpage.="issued one month prior to the expiry date.</p>\n" ;


$emailtext.="=================================================================\n" ;
$emailtext.="Remote host: $ENV{'REMOTE_HOST'}\n" ;
$emailtext.="Remote IP address: $ENV{'REMOTE_ADDR'}\n" ;

#open (MAIL, "|$mailprog $recipient") || die "Can't open $mailprog!\n" ;
#print MAIL "Reply-to: $FORM{'email'} ($FORM{'name'})\n" ;
#print MAIL "Subject: Purchase in progress... Invoice $cartid\n\n" ;
#print MAIL $emailtext ;


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

sub doProduct {

	$prodcode = @_[0] ;
	$prodname = @_[1] ;
	$priceH = @_[2] ;
	$maintH = @_[3] ;
	$priceF = @_[4] ;
	$maintF = @_[5] ;


	$nprodH = "n".$prodcode."H" ;
	$nprodF = "n".$prodcode."H" ;

	if ($FORM{$prodcode} eq 'y') {
		$actpage.="<input type=hidden name=\"" ;
		$actpage.=$prodcode ;
		$actpage.="\" value=\"y\"><tr width=\"100%\"><td class=\"narr\">" ;
		$actpage.=$prodname ;
		$actpage.="</td>" ;
  
#		if ($FORM{'fromscr02'} eq '1') {
#			if (!$FORM{$nprodH}) {$FORM{$nprodH} = 1 ;}
#			if (!$FORM{$nprodF}) {$FORM{$nprodF} = 0 ;}
#		}
#		$FORM{$nprodF} = $FORM{$nprodH} ;

		if ($FORM{$nprodH}) {
			if ($FORM{$nprodH}<1) { $FORM{$nprodH} =1 ;}
		} else {
			$FORM{$nprodH} =1 ;
		}


		$strLicH=$FORM{$nprodH} ;
		if ($strLicH < 0) { $strLicH = 0 ; }
		$strLicF=$FORM{$nprodF} ;
		if ($strLicF < 0) { $strLicF = 0 ; }

		if ($FORM{'license'} eq "float") {
			$actpage.="<td class=\"narr\" align=center><input type=text onChange=\"verify(this)\" name=\"" ;
			$actpage.=$nprodF ;
			$actpage.="\" value=\"$strLicF\" size=\"2\"></td>\n<td class=\"narr\" align=right>" ;
			if ($strLicF > 0) {
				$actpage.= "<b>$priceF</b>" ;
			} else {
				$actpage.= $priceF ;
			}

			if ($strLicF > 0) { 
				$desc.= "$strLicF x FLOAT " ;
				$desc.= $prodname ;
				$desc.= " + Maint.<br>" ;
	#			$emailtext.="Floating " ;
	#			$emailtext.=$prodname ;
	#			$emailtext.="\n  ".$strLicF." x ($priceF + $maintF) = ".sprintf("%.0f",($strLicF * ($priceF + $maintF))) . "\n" ;
			}

			$actpage.="</td>\n<td class=\"narr\" align=right>" . sprintf("%.2f",($strLicF * $priceF)) . "</td></tr>\n" ;

		} else {

			$actpage.="<td class=\"narr\" align=center><input type=text onChange=\"verify(this)\" name=\"" ;
			$actpage.=$nprodH ;
			$actpage.="\" value=\"$strLicH\" size=\"2\"></td>\n<td class=\"narr\" align=right>" ;
			if ($strLicH > 0) {
				$actpage.= "<b>$priceH</b>" ;
			} else {
				$actpage.= $priceH ;
			}

			if ($strLicH > 0) { 
				$desc.= "$strLicH x HL " ;
				$desc.= $prodname ;
				$desc.= " + Maint.<br>" ;
	#			$emailtext.="Host-locked " 
	#			$emailtext.=$prodname ;
	#			$emailtext.="\n  ".$strLicH." x ($priceH + $maintH) = ".sprintf("%.0f",($strLicH * ($priceH + $maintH)))."\n" ;
			}

			$actpage.="</td>\n<td class=\"narr\" align=right>" . sprintf("%.2f",($strLicH * $priceH)) . "</td></tr>\n" ;

		}
		

		$actpage.="<tr width=\"100%\">" ;
		$actpage.="\n<td class=\"narr\">Annual Maintenance for above</td>\n" ;
		
		if ($FORM{'license'} eq "float") {
			$actpage.="</td>\n<td class=\"narr\" align=center>$strLicF</td><td class=\"narr\" align=right>" ;
			if ($strLicF > 0) {
				$actpage.= "<b>$maintF</b>" ;
			} else {
				$actpage.= $maintF ;
			}

			$actpage.="</td>\n<td class=\"narr\" align=right>" . sprintf("%.2f",($strLicF * $maintF)) . "</td></tr>\n" ;

		} else {
			$actpage.="<td class=\"narr\" align=center>$strLicH</td><td class=\"narr\" align=right>" ;
			if ($strLicH > 0) {
				$actpage.= "<b>$maintH</b>" ;
			} else {
				$actpage.= $maintH ;
			}

			$actpage.="</td>\n<td class=\"narr\" align=right>" . sprintf("%.2f",($strLicH * $maintH)) . "</td></tr>\n" ;

		}
		

		if ($FORM{'license'} eq "float") {
			$amount += ($strLicF * $priceF) ;
			$amount += ($strLicF * $maintF) ;
		} else {
			$amount += ($strLicH * $priceH) ;
			$amount += ($strLicH * $maintH) ;
		}
	}
	
}
