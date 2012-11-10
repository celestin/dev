#!/usr/bin/perl

print "Content-type: text/html\n\n" ;

# This should match the mail program on your system.
$mailprog = '/usr/sbin/sendmail' ;

# This should be set to the username or alias that runs your
# WWW server.
$recipient = 'flash@powersoftware.com' ;

$fwidth =  "fwidth" ;
$fheight = "fheight" ;
$ftitle =  "ftitle" ;
$ffile =   "ffile" ;

# Get the input
read(STDIN, $buffer, $ENV{'CONTENT_LENGTH'}) ;

print "<html>" ;

# Split the name-value pairs
@pairs = split(/&/, $buffer) ;

foreach $pair (@pairs)
{
    ($name, $value) = split(/=/, $pair) ;

    # Un-Webify plus signs and %-encoding
    $value =~ tr/+/ /;
    $value =~ s/%([a-fA-F0-9][a-fA-F0-9])/pack("C", hex($1))/eg ;

    # Uncomment for debugging purposes
    #print "<p>Setting $name to $value</p>" ;

    $FORM{$name} = $value ;
}

# Now send mail to $recipient

$product = $FORM{'product'} ;

open (MAIL, "|$mailprog $recipient") || die "Can't open $mailprog!\n" ;
print MAIL "Subject: Visitor viewing Flash - ".$product."\n\n" ;
print MAIL $product."\n\n" ;
print MAIL "User's browser:    $ENV{'HTTP_USER_AGENT'}\n" ;
print MAIL "Remote host:       $ENV{'REMOTE_HOST'}\n" ;
print MAIL "Remote IP address: $ENV{'REMOTE_ADDR'}\n\n" ;
close (MAIL) ;

print "<head><title>".$FORM{$ftitle}."</title></head><body bgcolor=\"#FFFFFF\" marginwidth=0 marginheight=0 topmargin=0 leftmargin=0 rightmargin=0>" ;

print "<OBJECT classid=\"clsid:D27CDB6E-AE6D-11cf-96B8-444553540000\"" ;
print " codebase=\"http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=5,0,0,0\"" ;
print " WIDTH=".$FORM{$fwidth}. " HEIGHT=".$FORM{$fheight}.">" ;
print "<PARAM NAME=movie VALUE=\"".$FORM{$ffile}."\">" ;
print "<PARAM NAME=loop VALUE=false><PARAM NAME=quality VALUE=high>" ;
print "<PARAM NAME=bgcolor VALUE=#FFFFFF><EMBED src=\"".$FORM{$ffile}."\" loop=false quality=high bgcolor=#FFFFFF WIDTH=".$FORM{$fwidth}." HEIGHT=".$FORM{$fheight}." TYPE=\"application/x-shockwave-flash\" PLUGINSPAGE=\"http://www.macromedia.com/shockwave/download/index.cgi?P1_Prod_Version=ShockwaveFlash\"></EMBED>" ;
print "</OBJECT>" ;

print "</body></html>" ;
exit ;