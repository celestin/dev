#!/bin/perl

# Define fairly-constants
$cg_international="0" ;
$cg_europe="1" ;
$cg_uk="2" ;
$cartidfile = '/u/p/o/w/powersft/docs/cartid' ;

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

$cartid=&increment_card_id() ;

$actpage.="<h1>Manual Credit Card Entry</h1>\n" ;

$actpage.="<FORM name=\"buy\" action=\"https://select.worldpay.com/wcc/purchase\" method=post>" ;

$actpage.="<table width=\"90%\" border=1><tr><td colspan=2>" ;
$actpage.="<input type=hidden name=\"instId\" value=\"26311\">\n  " ;
$actpage.="<input type=hidden name=\"userlocation\" value=\"" . $userlocation . "\">\n  " ;
$actpage.="<input type=hidden name=\"cartId\" value=\"" . $cartid . "\"></td></tr>\n  " ;

$actpage.="<tr><td><b>Description</b></td><td><input type=text size=100 name=\"desc\"></td></tr>" ;
$actpage.="<tr><td><b>Amount</b></td><td><input type=text size=20 name=\"amount\"></td></tr>" ;

$actpage.="<tr><td><b>Currency</b></td><td>" ;
$actpage.="<select name=\"currency\" value=\"USD\">" ;
$actpage.="  <option value=\"USD\">US Dollars\n" ;
$actpage.="  <option value=\"GBP\">UK Pounds\n" ;
$actpage.="</select></tr></tr>\n" ;

$actpage.="<input type=hidden name=\"testMode\" value=\"0\"><img src=\"http://www.powersoftware.com/img/f.gif\" width=1 height=10></td></tr>" ;

$actpage.="<tr><td colspan=6 class=\"narr\" align=right valign=center><input type=submit name=\"submit\" value=\"Buy Now\"></td></tr></table>" ;

print $actpage ;
exit ;


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

