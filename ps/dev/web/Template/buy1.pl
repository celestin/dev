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

