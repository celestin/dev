
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

