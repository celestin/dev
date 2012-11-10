#!/bin/perl

# Define fairly-constants
$unitedstates="0US" ;
$cg_international="0" ;
$cg_europe="1" ;
$cg_uk="2" ;
$warning_text_insertion="<!--Insert Warning Here-->" ;
$showWarning=0 ;

# This should match the mail program on your system.
$mailprog = '/usr/lib/sendmail' ;

# This should be set to the username or alias that runs your
# WWW server.
#$recipient = 'sales@powersoftware.com' ;
$recipient = 'themcmoose@hotmail.com' ;

# Name of the template HTML file which will be used to build new download page
$newfile = '/u/p/o/w/powersft/docs/template.html' ;
# Separator text in above file, giving point of insertion
$separator = '<!--start-->' ;

# Title Separator & Title Text
$titleSeparator = '<!--titleText-->' ;
$titleText = 'Evaluation License' ;

# Body, On Load event
$onLoadSeparator = "<!--onLoad-->" ;
$onLoadText = "onLoad=\"setRadios();\"  " ;

# JavaScript to be inserted into the page
$scriptSeparator = '<!--Javascript-->' ;
$scriptFile = '/u/p/o/w/powersft/docs/script/license.js' ;


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
    #print "Setting $name to $value<br>" ;

    $FORM{$name} = $value ;
}


# Determine neat date & time strings
@rightnow=localtime() ;
$thistime=$rightnow[2].":".$rightnow[1] ;
$thisday=(Sun,Mon,Tue,Wed,Thu,Fri,Sat)[$rightnow[6]] ;
$thismonth=(Jan,Feb,Mar,Apr,May,Jun,Jul,Aug,Sep,Oct,Nov,Dec)[$rightnow[4]] ;
$thisdate=$thisday.", ".$rightnow[3]." ".$thismonth." ".($rightnow[5]+1900) ;

$country=$unitedstates ;

if ($FORM{'countryex'}) {
  $country = $FORM{'countryex'} ;
}

$countrygroup = substr($country,0,1) ;
$countrytidy = substr($country,1,2) ;

$actpage.="<FORM name=\"details\" action=\"/cgi-bin/www.power-soft.co.uk/buy.pl\" method=post>" ;

$actpage.="<table border=0 cellspacing=0 cellpadding=4>\n" ;
$actpage.="<tr><td colspan=2 ".$warning_text_insertion.&selected_products()."</td></tr>\n" ;
$actpage.="<tr>".&valid_title_cell('name','Name')."<td>".&input_field('text', 'name', 20)."</td></tr>\n" ;
$actpage.="<tr>".&valid_title_cell('email','Email')."<td>".&input_field('text', 'email', 40)."</td></tr>\n" ;
$actpage.="<tr>".&valid_title_cell('tel','Telephone')."<td>".&input_field('text', 'tel', 20)."</td></tr>\n" ;

$actpage.="<tr><td colspan=2 class=\"narr\">What is your Sign off level (amount you can spend on source code tools)</td></tr>\n" ;
$actpage.="<tr>".&valid_title_cell('signoff','Sign off')."<td><table border=0 cellspacing=0 cellpadding=2>" ;

$actpage.="<tr><td>".&radio_field('signoff', 'lt1')."</td><td class=\"narr\">less than 1,000</td>" ;
$actpage.="<td>".&radio_field('signoff', 'gt3')."</td><td class=\"narr\">greater than 3,000</td></tr>" ;
$actpage.="<tr><td>".&radio_field('signoff', 'lt3')."</td><td class=\"narr\">less than 3,000</td>" ;
$actpage.="<td>".&radio_field('signoff', 'none')."</td><td class=\"narr\">no sign off authority</td></tr>" ;
$actpage.="</table></td></tr>\n" ;

$actpage.="<tr><td colspan=2 class=\"narr\">Project Manager</td></tr>\n" ;
$actpage.="<tr>".&valid_title_cell('pname','Name')."<td>".&input_field('text', 'pname', 20)."</td></tr>\n" ;
$actpage.="<tr>".&valid_title_cell('pemail','Email')."<td>".&input_field('text', 'pemail', 40)."</td></tr>\n" ;
$actpage.="<tr>".&valid_title_cell('ptel','Telephone')."<td>".&input_field('text', 'ptel', 20)."</td></tr>\n" ;

$actpage.="<tr><td colspan=2 class=\"narr\">Please briefly descibe your requirements.</td></tr>\n" ;
$actpage.="<tr><td valign=top class=\"fldok\">Requirements</td><td colspan=2><textarea name=\"req\" cols=40 rows=5></textarea></td></tr>\n" ;


$actpage.="<tr><td colspan=2 align=right><input type=submit onclick=\"validateForm();\" value=\"Next >\"></td></tr>\n" ;

$actpage.="</table></form>\n" ;

# If any fields were incomplete, set warning text
$warning_text="class=\"narr\">To allow us to quickly process your evaluation license, please complete these few questions:" ;
if ($showWarning) {
  $warning_text="class=\"fldbad\">Please supply full information to enable us to issue an evaluation license." ;
}
$actpage=~s/$warning_text_insertion\s*/$warning_text/ ;


$page=&get_file_contents($newfile) ;
$page=~s/$separator\s*/$actpage/ ;
$page=~s/$titleSeparator\s*/$titleText/ ;
$page=~s/$onLoadSeparator\s*/$onLoadText/ ;

$script=&get_file_contents($scriptFile) ;
$page=~s/$scriptSeparator\s*/$script/ ;

print $page ;
exit ;


# Add a Country Option to the current Select

sub add_country_option {
  ($countrycode, $countryname) = @_ ;
  $selected="" ;
  
  if ($countrycode eq $country) {
    $selected=" selected" ;
  }
  
  return "<option value=\"".$countrycode."\"".$selected.">".$countryname."\n" ;
}

# Build an input (with default value from previous page)
sub input_field {
  ($fieldtype, $fieldname, $fieldlen) = @_ ;
  $defaultvalue="" ;  
  
  if ($FORM{$fieldname}) {
    $defaultvalue=" value=\"".$FORM{$fieldname}."\"" ;
  }
  
  return "<input type=".$fieldtype." name=\"".$fieldname."\"".$defaultvalue." size=".$fieldlen.">"
}

sub radio_field {
  ($fieldname, $optval) = @_ ;
  $checked="" ;
  
  if ($FORM{$fieldname} eq $optval) {
    $checked=" checked" ;
  }
  
  return "<input type=radio name=\"".$fieldname."\" value=\"".$optval."\"".$checked.">" ;
}

sub valid_title_cell {
  ($fieldname, $fieldtitle) = @_ ;
  $retval = "<td class=\"fld" ;
  
  if ($FORM{'fromscr01'} eq '1') {
    # First time - field will be empty - this is ok
    $retval.="ok" ;
  } else {
    # Not first time, check contents of field
    if (length($FORM{$fieldname}) > 0) {
      # Contains sometime - ok
      $retval.="ok" ;
    } else {
      $retval.="bad" ;
      $showWarning=1 ;
    }
  }
  
  $retval.="\">".$fieldtitle."</td>" ;
  
  return $retval ;
}


# Build hidden fields for the selected products

sub selected_products { 
  $selprod = "" ;
  
  if ($FORM{'ihpux'} eq 'y') { $selprod.=&input_field('hidden', 'ihpux', 1) ; }
  if ($FORM{'iirix'} eq 'y') { $selprod.=&input_field('hidden', 'iirix', 1) ; }
  if ($FORM{'isol'} eq 'y') { $selprod.=&input_field('hidden', 'isol', 1) ; }
  if ($FORM{'isunos'} eq 'y') { $selprod.=&input_field('hidden', 'isunos', 1) ; }
  if ($FORM{'iwin'} eq 'y') { $selprod.=&input_field('hidden', 'iwin', 1) ; }
  if ($FORM{'klsolcppv2'} eq 'y') { $selprod.=&input_field('hidden', 'klsolcppv2', 1) ; }
  if ($FORM{'klwincppv2'} eq 'y') { $selprod.=&input_field('hidden', 'klwincppv2', 1) ; }
  if ($FORM{'klsoljavav2'} eq 'y') { $selprod.=&input_field('hidden', 'klsoljavav2', 1) ; }
  if ($FORM{'klwinjavav2'} eq 'y') { $selprod.=&input_field('hidden', 'klwinjavav2', 1) ; }
  if ($FORM{'kpsolcppv2'} eq 'y') { $selprod.=&input_field('hidden', 'kpsolcppv2', 1) ; }
  if ($FORM{'kpwincppv2'} eq 'y') { $selprod.=&input_field('hidden', 'kpwincppv2', 1) ; }
  if ($FORM{'kpsoljavav2'} eq 'y') { $selprod.=&input_field('hidden', 'kpsoljavav2', 1) ; }
  if ($FORM{'kpwinjavav2'} eq 'y') { $selprod.=&input_field('hidden', 'kpwinjavav2', 1) ; }
  if ($FORM{'pmsolcppv2'} eq 'y') { $selprod.=&input_field('hidden', 'pmsolcppv2', 1) ; }
  if ($FORM{'pmwincppv2'} eq 'y') { $selprod.=&input_field('hidden', 'pmwincppv2', 1) ; }
  if ($FORM{'pmsoljavav2'} eq 'y') { $selprod.=&input_field('hidden', 'pmsoljavav2', 1) ; }
  if ($FORM{'pmwinjavav2'} eq 'y') { $selprod.=&input_field('hidden', 'pmwinjavav2', 1) ; }
  if ($FORM{'optsolaris'} eq 'y') { $selprod.=&input_field('hidden', 'optsolaris', 1) ; }
  if ($FORM{'optwin'} eq 'y') { $selprod.=&input_field('hidden', 'optwin', 1) ; }
  
  $selprod.="<input type=hidden name=\"fromscr02\" value=1>" ;
  
  return $selprod ;
}

sub country_fields { 
  $countryfields = "<input type=hidden name=\"country\" value=\"".$countrytidy."\">" ;
  $countryfields.= "<input type=hidden name=\"countrygroup\" value=\"".$countrygroup."\">" ;

  return $countryfields ;
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

