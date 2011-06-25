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
$recipient = 'sales@powersoftware.com' ;
#$recipient = 'themcmoose@hotmail.com' ;

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
$scriptFile = '/u/p/o/w/powersft/docs/script/detailsvz.js' ;


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

$actpage.="<img src=\"http://www.powersoftware.com/img/title/buyvz.gif\" border=0>\n" ;

$actpage.="<FORM name=\"details\" action=\"/cgi-bin/www.power-soft.co.uk/buyvz.pl\" method=post>" ;

$actpage.="<table border=0 cellspacing=0 cellpadding=4>\n" ;
$actpage.="<tr><td colspan=2 class=\"fldbad\">".$warning_text_insertion.&country_fields()."</td></tr>\n" ;
$actpage.="<tr>".&valid_title_cell('name','Name')."<td>".&input_field('text', 'name', 20)."</td></tr>\n" ;
$actpage.="<tr>".&valid_title_cell('email','Email')."<td>".&input_field('text', 'email', 40)."</td></tr>\n" ;
$actpage.="<tr><td class=\"narr\"><b>Country</td><td><select name=\"countryex\" onChange=\"refreshForm();\">".&add_countries()."</select></td></tr>\n" ;
$actpage.="<tr>".&valid_title_cell('company','Company')."<td>".&input_field('text', 'company', 40)."</td></tr>\n" ;

if ($countrygroup eq $cg_europe) {
  $actpage.="<tr>".&valid_title_cell('vatno','EC VAT No.')."<td>".&input_field('text', 'vatno', 20)."</td></tr>\n" ;
}

$actpage.="<tr>".&valid_title_cell('street','Street')."<td>".&input_field('text', 'street', 40)."</td></tr>\n" ;
$actpage.="<tr>".&valid_title_cell('city','City')."<td>".&input_field('text', 'city', 20)."</td></tr>\n" ;

if ($country eq $unitedstates) {
  $actpage.="<tr><td class=\"fldok\"><b>State</td><td><select name=\"state\">".&add_states()."</select></td></tr>\n" ;
} else {
  $actpage.="<tr>".&valid_title_cell('state','Region')."<td>".&input_field('text', 'state', 20)."</td></tr>\n" ;
}

$postcode_description="Postcode" ;
if ($countrygroup eq $cg_international) {
  $postcode_description="Zipcode" ;
}

$actpage.="<tr>".&valid_title_cell('postcode',$postcode_description)."<td>".&input_field('text', 'postcode', 20)."</td></tr>\n" ;
$actpage.="<tr>".&valid_title_cell('tel','Telephone')."<td>".&input_field('text', 'tel', 20)."</td></tr>\n" ;
$actpage.="<tr>".&valid_title_cell('fax','Fax')."<td>".&input_field('text', 'fax', 20)."</td></tr>\n" ;

$actpage.="<tr><td colspan=2 align=right><input type=hidden name=\"countryname\"><input type=submit onclick=\"validateForm();\" value=\"Next >\"></td></tr>\n" ;

$actpage.="</table></form>\n" ;

# If any fields were incomplete, set warning text
$warning_text="" ;
if ($showWarning) {
  $warning_text="Please supply full information to help us track your purchase." ;
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


# Add States Select

sub add_states {
  $state_select="" ;
  $state_select.="<option value=\"AK\">Alaska " ;
  $state_select.="<option value=\"AZ\">Arizona" ;
  $state_select.="<option value=\"CT\">Connecticut" ;
  $state_select.="<option value=\"FL\">Florida" ;
  $state_select.="<option value=\"IO\">Iowa" ;
  $state_select.="<option value=\"IN\">Indiana" ;
  $state_select.="<option value=\"LA\">Louisiana" ;
  $state_select.="<option value=\"ME\">Maine" ;
  $state_select.="<option value=\"MO\">Missouri  " ;
  $state_select.="<option value=\"NC\">North Carolina" ;
  $state_select.="<option value=\"NH\">New Hampshire" ;
  $state_select.="<option value=\"NV\">Nevada" ;
  $state_select.="<option value=\"OK\">Oklahoma" ;
  $state_select.="<option value=\"RI\">Rhode Island" ;
  $state_select.="<option value=\"TN\">Tennessee" ;
  $state_select.="<option value=\"VA\">Virginia" ;
  $state_select.="<option value=\"WI\">Wisconsin" ;
  $state_select.="<option value=\"AL\">Alabama" ;
  $state_select.="<option value=\"CA\">California" ;
  $state_select.="<option value=\"DC\">District of Columbia" ;
  $state_select.="<option value=\"GA\">Georgia" ;
  $state_select.="<option value=\"ID\">Idaho" ;
  $state_select.="<option value=\"KS\">Kansas" ;
  $state_select.="<option value=\"MA\">Massachusetts" ;
  $state_select.="<option value=\"MI\">Michigan" ;
  $state_select.="<option value=\"MS\">Mississippi" ;
  $state_select.="<option value=\"ND\">North Dakota" ;
  $state_select.="<option value=\"NJ\">New Jersey" ;
  $state_select.="<option value=\"NY\">New York" ;
  $state_select.="<option value=\"OR\">Oregon" ;
  $state_select.="<option value=\"SC\">South Carolina" ;
  $state_select.="<option value=\"TX\">Texas" ;
  $state_select.="<option value=\"VT\">Vermont" ;
  $state_select.="<option value=\"WV\">West Virginia" ;
  $state_select.="<option value=\"AR\">Arkansas" ;
  $state_select.="<option value=\"CO\">Colorado" ;
  $state_select.="<option value=\"DE\">Delaware  " ;
  $state_select.="<option value=\"HI\">Hawaii" ;
  $state_select.="<option value=\"IL\">Illinois" ;
  $state_select.="<option value=\"KY\">Kentucky" ;
  $state_select.="<option value=\"MD\">Maryland" ;
  $state_select.="<option value=\"MN\">Minnesota" ;
  $state_select.="<option value=\"MT\">Montana" ;
  $state_select.="<option value=\"NE\">Nebraska" ;
  $state_select.="<option value=\"NM\">New Mexico" ;
  $state_select.="<option value=\"OH\">Ohio" ;
  $state_select.="<option value=\"PA\">Pennsylvania" ;
  $state_select.="<option value=\"SD\">South Dakota" ;
  $state_select.="<option value=\"UT\">Utah" ;
  $state_select.="<option value=\"WA\">Washington" ;
  $state_select.="<option value=\"WY\">Wyoming" ;
  
  return $state_select ;
}


sub add_countries {
  $country_codes="" ;
  
  $country_codes.=&add_country_option("0US","United States of America") ;
  $country_codes.=&add_country_option("0AR","Argentina") ;
  $country_codes.=&add_country_option("0AU","Australia") ;
  $country_codes.=&add_country_option("0AT","Austria") ;
  $country_codes.=&add_country_option("0BS","Bahamas") ;
  $country_codes.=&add_country_option("0BY","Belarus") ;
  $country_codes.=&add_country_option("1BE","Belgium") ;
  $country_codes.=&add_country_option("0BM","Bermuda") ;
  $country_codes.=&add_country_option("0BR","Brazil") ;
  $country_codes.=&add_country_option("0BG","Bulgaria") ;
  $country_codes.=&add_country_option("0CA","Canada") ;
  $country_codes.=&add_country_option("0KY","Cayman Islands") ;
  $country_codes.=&add_country_option("0CN","China") ;
  $country_codes.=&add_country_option("0HR","Croatia") ;
  $country_codes.=&add_country_option("0CU","Cuba") ;
  $country_codes.=&add_country_option("0CY","Cyprus") ;
  $country_codes.=&add_country_option("0CZ","Czech Republic") ;
  $country_codes.=&add_country_option("1DK","Denmark") ;
  $country_codes.=&add_country_option("0EG","Egypt") ;
  $country_codes.=&add_country_option("0EE","Estonia") ;
  $country_codes.=&add_country_option("0FI","Finland") ;
  $country_codes.=&add_country_option("1FR","France") ;
  $country_codes.=&add_country_option("0GE","Georgia") ;
  $country_codes.=&add_country_option("1DE","Germany") ;
  $country_codes.=&add_country_option("0GI","Gibraltar") ;
  $country_codes.=&add_country_option("1GR","Greece") ;
  $country_codes.=&add_country_option("0HK","Hong Kong") ;
  $country_codes.=&add_country_option("0HU","Hungary") ;
  $country_codes.=&add_country_option("0IS","Iceland") ;
  $country_codes.=&add_country_option("0IN","India") ;
  $country_codes.=&add_country_option("0ID","Indonesia") ;
  $country_codes.=&add_country_option("0IR","Iran") ;
  $country_codes.=&add_country_option("0IQ","Iraq") ;
  $country_codes.=&add_country_option("0IE","Ireland") ;
  $country_codes.=&add_country_option("0IL","Israel") ;
  $country_codes.=&add_country_option("1IT","Italy") ;
  $country_codes.=&add_country_option("0JM","Jamaica") ;
  $country_codes.=&add_country_option("0JP","Japan") ;
  $country_codes.=&add_country_option("0KW","Kuwait") ;
  $country_codes.=&add_country_option("0LI","Liechtenstein") ;
  $country_codes.=&add_country_option("1LU","Luxembourg") ;
  $country_codes.=&add_country_option("0MY","Malaysia") ;
  $country_codes.=&add_country_option("0MX","Mexico") ;
  $country_codes.=&add_country_option("0MC","Monaco") ;
  $country_codes.=&add_country_option("0MA","Morocco") ;
  $country_codes.=&add_country_option("1NL","Netherlands") ;
  $country_codes.=&add_country_option("0NZ","New Zealand") ;
  $country_codes.=&add_country_option("0NO","Norway") ;
  $country_codes.=&add_country_option("0OM","Oman") ;
  $country_codes.=&add_country_option("0PK","Pakistan") ;
  $country_codes.=&add_country_option("0PE","Peru") ;
  $country_codes.=&add_country_option("0PH","Philippines") ;
  $country_codes.=&add_country_option("0PL","Poland") ;
  $country_codes.=&add_country_option("1PT","Portugal") ;
  $country_codes.=&add_country_option("0RO","Romania") ;
  $country_codes.=&add_country_option("0RU","Russian Federation") ;
  $country_codes.=&add_country_option("0SA","Saudi Arabia") ;
  $country_codes.=&add_country_option("0SG","Singapore") ;
  $country_codes.=&add_country_option("0ZA","South Africa") ;
  $country_codes.=&add_country_option("0GS","South Georgia") ;
  $country_codes.=&add_country_option("0KR","South Korea") ;
  $country_codes.=&add_country_option("1ES","Spain") ;
  $country_codes.=&add_country_option("0LK","Sri Lanka") ;
  $country_codes.=&add_country_option("0SE","Sweden") ;
  $country_codes.=&add_country_option("0CH","Switzerland") ;
  $country_codes.=&add_country_option("0TW","Taiwan") ;
  $country_codes.=&add_country_option("0TH","Thailand") ;
  $country_codes.=&add_country_option("0TR","Turkey") ;
  $country_codes.=&add_country_option("0UA","Ukraine") ;
  $country_codes.=&add_country_option("0AE","United Arab Emirates") ;
  $country_codes.=&add_country_option("2GB","United Kingdom") ;
  $country_codes.=&add_country_option("0UY","Uruguay") ;
  $country_codes.=&add_country_option("0VE","Venezuela") ;
  $country_codes.=&add_country_option("0VN","Viet Nam") ;
  $country_codes.=&add_country_option("0YU","Yugoslavia") ;
  $country_codes.=&add_country_option("0ZW","Zimbabwe") ;
  
  return $country_codes ;
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

