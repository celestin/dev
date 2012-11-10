#!/bin/perl

# This should match the mail program on your system.
$mailprog = '/usr/lib/sendmail' ;

# This should be set to the username or alias that runs your
# WWW server.
$recipient = 'craig.mckay@powersoftware.com' ;
#$recipient = 'themcmoose@hotmail.com' ;

# Name of the template HTML file which will be used to build new download page
$newfile = '/u/p/o/w/powersft/docs/template.html' ;
# Separator text in above file, giving point of insertion
$separator = '<!--start-->' ;

# Title Separator & Title Text
$titleSeparator = '<!--titleText-->' ;
$titleText = 'Date and Time' ;

# Body, On Load event
$onLoadSeparator = "<!--onLoad-->" ;
#$onLoadText = "onLoad=\"setRadios();\"  " ;

# JavaScript to be inserted into the page
$scriptSeparator = '<!--Javascript-->' ;
#$scriptFile = '/u/p/o/w/powersft/docs/script/license.js' ;


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
    $value =~ s/%([a-fA-F0-9][a-fA-F0-9])/pack("C", hex($1))/eg ;

    # Stop people from using subshells to execute commands
    # Not a big deal when using sendmail, but very important
    # when using UCB mail (aka mailx).
    # $value =~ s/~!/ ~!/g;

    # Uncomment for debugging purposes
    #print "Setting $name to $value<br>" ;

    $FORM{$name} = $value ;
}


# Determine neat date & time strings
@rightnow=localtime() ;
$thistime=$rightnow[2].":".$rightnow[1] ;
$rightnow[4]++ ;
#$thisday=(Sun,Mon,Tue,Wed,Thu,Fri,Sat)[$rightnow[6]] ;
#$thismonth=(Jan,Feb,Mar,Apr,May,Jun,Jul,Aug,Sep,Oct,Nov,Dec)[$rightnow[4]] ;
$thisdate=$thisday.", ".$rightnow[3]." ".$thismonth." ".($rightnow[5]+1900) ;

$timenow=&zeropad($rightnow[2],2).":".&zeropad($rightnow[1],2)." ".&zeropad($rightnow[3],2)."/".&zeropad($rightnow[4],2)."/".($rightnow[5]+1900) ;

$actpage="<h1 class=\"narr\">The time (sponsored by Demon...) is <font color=\"AA2222\">".$timenow ;
$actpage.="</font>.<br><br>Please email <a href=\"mailto:craig.mckay@powersoftware.com\">craig.mckay@powersoftware.com</a> to confirm this is incorrect and that you can fix it.</h1>" ;

$page=&get_file_contents($newfile) ;
$page=~s/$separator\s*/$actpage/ ;
$page=~s/$titleSeparator\s*/$titleText/ ;
$page=~s/$onLoadSeparator\s*/ / ;

#$script=&get_file_contents($scriptFile) ;
#$page=~s/$scriptSeparator\s*/$script/ ;
$page=~s/$scriptSeparator\s*/ / ;

open (MAIL, "|$mailprog $recipient") || die "Can't open $mailprog!\n" ;
print MAIL "Reply-to: support@demon.net\n" ;
print MAIL "Subject: Date&Time check made by Demon\n\n" ;
print MAIL "Server says date/time is: ".$timenow."\n\n" ;
print MAIL "Remote host: $ENV{'REMOTE_HOST'}\n" ;
print MAIL "Remote IP address: $ENV{'REMOTE_ADDR'}\n" ;
close (MAIL) ;

print $page ;
exit ;

sub zeropad {
  $zpnum = @_[0] ;
  $zplen = @_[1] ;
  $zppad = "" ;
  
  for($i=0; $i<$zplen; $i++) {
    $zppad.="0" ;
  }
  
  $zppad.=$zpnum ;
  
  return substr($zppad, length($zppad)-$zplen) ;
}


sub get_file_contents {
  $filename = @_[0] ;
  $filecontents = '' ;
  
  unless (open (FILE, "$filename"))
  {
    return "" ;
  }
  undef ($/) ;
  $filecontents=<FILE> ;
  close FILE ;
  return $filecontents ;
}

