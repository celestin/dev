#!/usr/bin/perl

# Mail settings
$mailprog = '/usr/sbin/sendmail' ;
$recipient = 'download@powersoftware.com' ;

# Name of the template HTML file which will be used to build new download page
$newfile = 'template.html' ;

# Separator text in above file, giving point of insertion
$separator = '<!--start-->' ;

# Title Separator & Title Text
$titleSeparator = '<!--titleText-->' ;
$titleText = 'Files for Download' ;
$onLoadSeparator = '<!--onLoad-->' ;
$onLoadText = '' ;
$scriptSeparator = '<!--Javascript-->' ;


# Print out a content-type for HTTP/1.0 compatibility
print "Content-type: text/html\n\n" ;

# Get the input
read(STDIN, $buffer, $ENV{'CONTENT_LENGTH'}) ;

# Split the name-value pairs
@pairs = split(/&/, $buffer);

foreach $pair (@pairs)
{
    ($name, $value) = split(/=/, $pair) ;

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

# If the comments are blank, then give a "blank form" response
&blank_response unless ($FORM{'name'} && $FORM{'email'} && $FORM{'company'} && $FORM{'phone'});


# Initialise code for "active page" which contains the real links for downloading

$actpage="<br><h1 class=\"narr\">Thank you</H1>\n" ;
$actpage.="<p class=\"narr\">Thank you for choosing to evaluate our products!</p>\n" ;
$actpage.="<p class=\"narr\">To complete the downloading, click below for your selected products.</p>\n" ;

# Now send mail to $recipient

open (MAIL, "|$mailprog $recipient") || die "Can't open $mailprog!\n";
print MAIL "To: \"Power Software Sales\" <$recipient>\n";
print MAIL "From: \"Power Software Downloads\" <$recipient>\n";
print MAIL "Reply-to: $FORM{'email'} ($FORM{'name'})\n";
print MAIL "Subject: " . uc($ENV{'SERVER_NAME'}) . " download from $FORM{'name'}\n\n";
print MAIL "Download made by $FORM{'email'} ($FORM{'name'})\n\n";
if ($FORM{'company'})   { print MAIL "Company      : $FORM{'company'}\n"; }
if ($FORM{'job'})       { print MAIL "Job Title    : $FORM{'job'}\n"; }
if ($FORM{'address'})   { print MAIL "Address:\n$FORM{'address'}\n"; }
if ($FORM{'phone'})     { print MAIL "Phone number : $FORM{'phone'}\n"; }

$leadtext="" ;

if ($FORM{'lead'} ne '(Pick One)') {

  if ($FORM{'radSrch'}) { $leadtext.= "Search Engine" ; }
  if ($FORM{'radColl'}) { $leadtext.= "Colleague" ; }

  if ($FORM{'lead'} ne 'Other') {
    $leadtext.=  " -> $FORM{'lead'}" ;
    $joinsym = " + " ;
  } else {
    $joinsym = " -> " ;
  }

  if ($FORM{'leadother'}) {
    $leadtext.=$joinsym ;
    $leadtext.= "$FORM{'leadother'}" ;
  }

  $leadtext.=  "\n" ;

} else {
  if ($FORM{'leadother'}) { $leadtext.=  "$FORM{'leadother'}\n"; }
}

print MAIL "Lead from    : ". $leadtext ;


if ($FORM{'langcsharp'}||$FORM{'langsql'}||$FORM{'langvb'}||$FORM{'langc'}||$FORM{'langcpp'}||$FORM{'langjava'}||$FORM{'langcob'}||$FORM{'langtcl'}||$FORM{'langfort'}||$FORM{'langperl'})
{
  print MAIL "Using        : " ;

  if ($FORM{'langc'})                     { $langs.= "C "; }
  if ($FORM{'langcpp'})                   { $langs.= "C++ "; }
  if ($FORM{'langjava'})                  { $langs.= "Java "; }
  if ($FORM{'langcob'})                   { $langs.= "COBOL "; }
  if ($FORM{'langtcl'})                   { $langs.= "Tcl "; }
  if ($FORM{'langfort'})                  { $langs.= "FORTRAN "; }
  if ($FORM{'langperl'})                  { $langs.= "Perl "; }

  if ($FORM{'langcsharp'})                { $langs.= "C# "; }
  if ($FORM{'langsql'})                   { $langs.= "SQL "; }
  if ($FORM{'langvb'})                    { $langs.= "Visual Basic "; }

  print MAIL $langs."\n";
}

if ($FORM{'users'})     { print MAIL "No. of users : $FORM{'users'}\n\n"; }
print MAIL "------------------------------------------------------------\n";


#==PRODUCTS==

# Visualize it

  if ($FORM{'vzwinjava'}||$FORM{'vzwin9java'}||$FORM{'vzsoljava'}||$FORM{'vzlnxjava'})
  { $actpage.="<p class=\"narr\"><b>Visualize it!</b><br>" ;

    if (($FORM{'vzwinjava'} eq 'y') && ($FORM{'vzwin9java'} eq 'y'))
    { $actpage.="<a href=/download/vz/viz_java_100.zip>Visualize it! for Java (Windows 95/98/NT/2000) <b>Version 1.0</b></a><br>\n";
      $products.= "Visualize it! for Java (Windows 95/98/NT/2000) Version 1.0\n"; }
    elsif ($FORM{'vzwinjava'} eq 'y')
    { $actpage.="<a href=/download/vz/viz_java_100.zip>Visualize it! for Java (Windows NT/2000) <b>Version 1.0</b></a><br>\n";
      $products.= "Visualize it! for Java (Windows NT/2000) Version 1.0\n"; }
    elsif ($FORM{'vzwin9java'} eq 'y')
    { $actpage.="<a href=/download/vz/viz_java_100.zip>Visualize it! for Java (Windows 95/98) <b>Version 1.0</b></a><br>\n";
      $products.= "Visualize it! for Java (Windows 95/98) Version 1.0\n"; }

    if ($FORM{'vzsoljava'} eq 'y')
    { $actpage.="<a href=/download/vz/viz_java_100.tar.gz>Visualize it! for Java (Solaris) <b>Version 1.0</b></a><br>\n";
      $products.= "Visualize it! for Java (Solaris) Version 1.0\n"; }

    if ($FORM{'vzlnxjava'} eq 'y') {
      $actpage.="<a href=/download/vz/LINUX_README>Visualize it! for Java (Linux) README - please read before downloading and installing</a><br>\n" ;
      $actpage.="<a href=/download/vz/j2re-1_4_0-beta2-linux-i386.rpm><b>Java JRE</b></a>&nbsp;|&nbsp;\n" ;
      $actpage.="<a href=/download/vz/MySQL-3.23.42-1.i386.rpm><b>MySQL Database engine</b></a>&nbsp;|&nbsp;\n" ;
      $actpage.="<a href=/download/vz/MySQL-client-3.23.42-1.i386.rpm><b>MySQL Client</b></a><br>\n" ;
      $actpage.="<a href=/download/vz/viz_java_100.tar.gz>Visualize it! for Java (Linux) <b>Version 1.0</b></a><br>\n" ;
      $products.= "Visualize it! for Java (Linux) Version 1.0\n" ;
    }

    $actpage.="</p>" ; }

# Krakatau PM

  if ($FORM{'pmwincppv3'}||$FORM{'pmpwincppv3'}||$FORM{'pmwincppv2'}||$FORM{'pmpwincppv2'}||$FORM{'pmwincpp'}||$FORM{'pmsolcppv2'}||$FORM{'pmwinjavav2'}||$FORM{'pmwinjava'}||$FORM{'pmsoljavav2'})
  { $actpage.="<p class=\"narr\"><b>Krakatau Project Manager</b><br>" ;

    if ($FORM{'pmwincppv2'} eq 'y')
    { $actpage.="<a href=/download/pm/krak_pm_cpp_211.zip>Krakatau Project Manager C/C++ (Windows 95/98/NT/2000) <b>Version 2.11</b></a><br>\n";
      $products.= "Krakatau PM C/C++ (Windows 95/98/NT/2000) Version 2.11\n"; }

    if ($FORM{'pmwincppv3'} eq 'y')
    { $actpage.="<a href=/download/pm/krak_pm_cpp_300.zip>Krakatau Project Manager C/C++ (Windows 95/98/NT/2000) <b>Version 3 Beta</b></a><br>\n";
      $products.= "Krakatau PM C/C++ (Windows 95/98/NT/2000) Version 3 Beta\n"; }

    if ($FORM{'pmwincpp'} eq 'y')
    { $actpage.="<a href=/download/pm/krak_pm_cpp.zip>Krakatau Project Manager C/C++ (Windows) Version 1.0</a><br>\n";
      $products.= "Krakatau PM C/C++ (Windows)\n"; }

    if ($FORM{'pmwinjavav2'} eq 'y')
    { $actpage.="<a href=/download/pm/krak_pm_java_211.zip>Krakatau Project Manager Java (Windows 95/98/NT/2000) <b>Version 2.11</b></a><br>\n";
      $products.= "Krakatau PM Java (Windows 95/98/NT/2000) Version 2.11\n"; }

    if ($FORM{'pmwinjavav3'} eq 'y')
    { $actpage.="<a href=/download/pm/krak_pm_java_300.zip>Krakatau Project Manager Java (Windows 95/98/NT/2000) <b>Version 3 Beta</b></a><br>\n";
      $products.= "Krakatau PM Java (Windows 95/98/NT/2000) Version 3 Beta\n"; }

    if ($FORM{'pmwinjava'} eq 'y')
    { $actpage.="<a href=/download/pm/krak_pm_java.zip>Krakatau Project Manager Java (Windows) Version 1.0</a><br>\n";
      $products.= "Krakatau PM Java (Windows)\n"; }

    if ($FORM{'pmsolcppv2'} eq 'y')
    { $actpage.="<a href=/download/pm/krak_pm_cpp_210.tar.gz>Krakatau Project Manager C/C++ (Solaris) <b>Version 2.1</b></a><br>\n";
      $products.= "Krakatau PM C/C++ (Solaris) Version 2.1\n"; }
    if ($FORM{'pmsoljavav2'} eq 'y')
    { $actpage.="<a href=/download/pm/krak_pm_java_210.tar.gz>Krakatau Project Manager Java (Solaris) <b>Version 2.1</b></a><br>\n";
      $products.= "Krakatau PM Java (Solaris) Version 2.1\n"; }

    $actpage.="</p>" ; }

# Krakatau Professional

  if ($FORM{'kpwincppv2'}||$FORM{'kpwincpp'}||$FORM{'kpsolcppv2'}||$FORM{'kpwinjavav2'}||$FORM{'kpwinjava'}||$FORM{'kpsoljavav2'})
  { $actpage.="<p class=\"narr\"><b>Krakatau Professional</b><br>" ;

    if ($FORM{'kpwincppv2'} eq 'y')
    { $actpage.="<a href=/download/kp/krak_pro_cpp_211_005.zip>Krakatau Professional for C/C++ (Windows NT/2000/XP/2003) <b>Version 2.11.005</b></a><br>\n";
      $products.= "Krakatau Professional for C/C++ (Windows NT/2000/XP/2003) Version 2.11.005\n"; }
    if ($FORM{'kpwincpp'} eq 'y')
    { $actpage.="<a href=/download/kp/krak_pro_cpp.zip>Krakatau Professional for C/C++ (Windows) Version 1.0</a><br>\n";
      $products.= "Krakatau Professional for C/C++ (Windows)\n"; }
    if ($FORM{'kpwinjavav2'} eq 'y')
    { $actpage.="<a href=/download/kp/krak_pro_java_211_003.zip>Krakatau Professional for Java (Windows NT/2000/XP/2003) <b>Version 2.11.003</b></a><br>\n";
      $products.= "Krakatau Professional for Java (Windows NT/2000/XP/2003) Version 2.11.003\n"; }
    if ($FORM{'kpwinjava'} eq 'y')
    { $actpage.="<a href=/download/kp/krak_pro_java.zip>Krakatau Professional for Java (Windows) Version 1.0</a><br>\n";
      $products.= "Krakatau Professional for Java (Windows)\n"; }
    if ($FORM{'kpsolcppv2'} eq 'y')
    { $actpage.="<a href=/download/kp/krak_pro_cpp_210.tar.gz>Krakatau Professional for C/C++ (Solaris) <b>Version 2.1</b></a><br>\n";
      $products.= "Krakatau Professional for C/C++ (Solaris) Version 2.1\n"; }
    if ($FORM{'kpsoljavav2'} eq 'y')
    { $actpage.="<a href=/download/kp/krak_pro_java_210.tar.gz>Krakatau Professional for Java (Solaris) <b>Version 2.1</b></a><br>\n";
      $products.= "Krakatau Professional for Java (Solaris) Version 2.1\n"; }

    $actpage.="</p>" ; }


# Krakatau Lite

  if ($FORM{'klwincppv2'}||$FORM{'klwinjavav2'}||$FORM{'klsolcppv2'}||$FORM{'klsoljavav2'})
  { $actpage.="<p class=\"narr\"><b>Krakatau Lite</b><br>" ;

    if ($FORM{'klwincppv2'} eq 'y')
    { $actpage.="<a href=/download/kl/krak_lite_cpp_210.zip>Krakatau Lite C/C++ (Windows NT/2000) <b>Version 2.1</b></a><br>\n";
      $products.= "Krakatau Lite C/C++ (Windows NT/2000) Version 2.1\n"; }
    if ($FORM{'klwinjavav2'} eq 'y')
    { $actpage.="<a href=/download/kl/krak_lite_java_210.zip>Krakatau Lite Java (Windows NT/2000) <b>Version 2.1</b></a><br>\n";
      $products.= "Krakatau Lite Java (Windows NT/2000) Version 2.1\n"; }

    if ($FORM{'klsolcppv2'} eq 'y')
    { $actpage.="<a href=/download/kl/krak_lite_cpp_201.tar.gz>Krakatau Lite C/C++ (Solaris) <b>Version 2.01</b></a><br>\n";
      $products.= "Krakatau Lite C/C++ (Solaris) Version 2.01\n"; }
    if ($FORM{'klsoljavav2'} eq 'y')
    { $actpage.="<a href=/download/kl/krak_lite_java_201.tar.gz>Krakatau Lite Java (Solaris) <b>Version 2.01</b></a><br>\n";
      $products.= "Krakatau Lite Java (Solaris) Version 2.01\n"; }

    $actpage.="</p>" ; }

# Essential Metrics

  if ($FORM{'emsolcppv12'}||$FORM{'emsoljavav12'}||$FORM{'emwincppv1'}||$FORM{'emwinjavav1'}||$FORM{'emwinepm'}||$FORM{'emwinkepm'}||$FORM{'emwincpppmv1'}||$FORM{'emwinjavapmv1'})
  { $actpage.="<p class=\"narr\"><b>Essential Metrics</b><br>" ;

    if ($FORM{'emsolcppv12'} eq 'y') {
      $actpage.="<a href=/download/em/emetrics_12b.tar.gz>Essential Metrics <b>C/C++</b> (Solaris 2.7 or higher) <b>Version 1.2b</b></a><br>\n";
      $products.= "Essential Metrics C/C++ (Solaris 2.7 or higher) Version 1.2b\n";
    }

    if ($FORM{'emsoljavav12'} eq 'y') {
      $actpage.="<a href=/download/em/emetrics_j12b.tar.gz>Essential Metrics <b>Java</b> (Solaris 2.7 or higher) <b>Version 1.2b</b></a><br>\n";
      $products.= "Essential Metrics Java (Solaris 2.7 or higher) Version 1.2b\n";
    }

    if ($FORM{'emwincppv1'} eq 'y') {
      $actpage.="<a href=/download/em/emetrics_cpp_100_003.zip>Essential Metrics C/C++ (Windows NT/2000/XP/2003) <b>Version 1.00.003</b></a><br>\n";
      $products.= "Essential Metrics C/C++ (Windows NT/2000/XP/2003) Version 1.00.003\n";
    }

    if ($FORM{'emwinjavav1'} eq 'y')
    { $actpage.="<a href=/download/em/emetrics_java_100_003.zip>Essential Metrics Java (Windows NT/2000/XP/2003) <b>Version 1.00.003</b></a><br>\n";
      $products.= "Essential Metrics Java (Windows NT/2000/XP/2003) Version 1.00.003\n"; }

    if ($FORM{'emwinepm'} eq 'y') {
      $actpage.="<a href=/download/em/epm_119_0000.zip>Essential Metrics PM Edition ADA Assembly ASP C# C/C++ CSS Fortran IDL HTML Java JavaScript JSP Perl PHP PL/SQL Python Ruby ShellScript Textfiles VB6 / VB.NET / VBScript VHDL WindowsBatch and XML (Windows NT/2000/XP/2003/<span class=hotnew>Vista</span>) <b>Version 1.19.0.0</b></a><br>\n";
      $products.= "Essential Metrics PM Edition ADA Assembly ASP C# C/C++ Fortran IDL HTML Java JavaScript JSP Perl PHP PL/SQL Python Ruby ShellScript Textfiles VB6 / VB.NET / VBScript VHDL WindowsBatch and XML (Windows NT/2000/XP/2003/Vista) Version 1.19.0.0\n";
    }

    if ($FORM{'emwinkepm'} eq 'y') {
      $actpage.="<a href=/download/em/kepm_112_0000.zip>Krakatau Essential ADA Assembly ASP C# C/C++ CSS Fortran IDL HTML Java JavaScript JSP Perl PHP PL/SQL Python Ruby ShellScript Textfiles VB6 / VB.NET / VBScript VHDL WindowsBatch and XML (Windows NT/2000/XP/2003/<span class=hotnew>Vista</span>) <b>Version 1.12.0.0</b></a><br>\n";
      $products.= "Krakatau Essential PM ADA Assembly ASP C# C/C++ CSS Fortran IDL HTML Java JavaScript JSP Perl PHP PL/SQL Python Ruby ShellScript Textfiles VB6 / VB.NET / VBScript VHDL WindowsBatch and XML (Windows NT/2000/XP/2003/Vista) Version 1.12.0.0\n";
    }

    if ($FORM{'emwincpppmv1'} eq 'y')
    { $actpage.="<a href=/download/em/emetrics_cpp_pm_100.zip>Essential Metrics PM Edition C/C++ (Windows 95/98/NT/2000) <b>Version 1.0</b></a><br>\n";
      $products.= "Essential Metrics PM Edition C/C++ (Windows 95/98/NT/2000) Version 1.0\n"; }
    if ($FORM{'emwinjavapmv1'} eq 'y')
    { $actpage.="<a href=/download/em/emetrics_java_pm_100.zip>Essential Metrics PM Edition Java (Windows 95/98/NT/2000) <b>Version 1.0</b></a><br>\n";
      $products.= "Essential Metrics PM Edition Java (Windows 95/98/NT/2000) Version 1.0\n"; }

    $actpage.="</p>" ; }


# Imagix

  if ($FORM{'iwin'}||$FORM{'ihpux'}||$FORM{'iirix'}||$FORM{'isol'}||$FORM{'isunos'})
  { $actpage.="<p class=\"narr\"><b>Imagix</b><br>" ;

    if ($FORM{'ihpux'}||$FORM{'iirix'}||$FORM{'isol'}||$FORM{'isunos'})
    { $actpage.="<a href=/download/im/README_UNIX>Imagix 4D Unix installation instructions</a><br>\n" ; }
    if ($FORM{'ihpux'} eq 'y')
    { $actpage.="<a href=/download/im/imgx.hpux.tar.Z>Imagix 4D for HP-UX</a><br>\n";
      $products.= "Imagix 4D for HP-UX\n"; }
    if ($FORM{'iirix'} eq 'y')
    { $actpage.="<a href=/download/im/imgx.irix.tar.Z>Imagix 4D for Irix</a><br>\n";
      $products.= "Imagix 4D for Irix\n"; }
    if ($FORM{'isol'} eq 'y')
    { $actpage.="<a href=/download/im/imgx.solaris.tar.Z>Imagix 4D for Solaris</a><br>\n";
      $products.= "Imagix 4D for Solaris\n"; }
    if ($FORM{'isunos'} eq 'y')
    { $actpage.="<a href=/download/im/imgx.sunos.tar.Z>Imagix 4D for SunOS</a><br>\n";
      $products.= "Imagix 4D for SunOS\n"; }

    if ($FORM{'iwin'} eq 'y')
    { $actpage.="<a href=/download/im/README_WIN>Imagix 4D Windows installation instructions</a><br>\n";
            $actpage.="<a href=/download/im/imgx_win.zip>Imagix 4D for Windows</a><br>\n";
      $products.= "Imagix 4D for Windows\n"; }

    $actpage.="</p>" ; }


print MAIL $products ;
print MAIL "\n------------------------------------------------------------\n";
print MAIL "User's browser: $ENV{'HTTP_USER_AGENT'}\n";
print MAIL "Remote host: $ENV{'REMOTE_HOST'}\n";
print MAIL "Remote IP address: $ENV{'REMOTE_ADDR'}\n";
close (MAIL);

$page=&get_file_contents($newfile) ;
$page=~s/$separator\s*/$actpage/ ;
$page=~s/$titleSeparator\s*/$titleText/ ;
$page=~s/$onLoadSeparator\s*/$onLoadText/ ;

#$script=&get_file_contents($scriptFile) ;
#$page=~s/$scriptSeparator\s*/$script/ ;

$page=~s/$scriptSeparator\s*// ;

print $page ;
exit ;


# ------------------------------------------------------------

sub blank_response
{
   $actpage="<h1 class=\"narr\">Incomplete Form</h1>\n" ;
   $actpage.="<p class=\"narr\">You must submit at least your name, email address, company name and\n" ;
   $actpage.="phone number to gain access to the download area.</p>\n" ;
   $actpage.="<p class=\"narr\">Please <a href=/download/>return\n" ;
   $actpage.="to our download page</a>, and re-enter your details.</p>\n" ;

   $page=&get_file_contents($newfile) ;
   $page=~s/$separator\s*/$actpage/ ;
   $page=~s/$titleSeparator\s*/$titleText/ ;
   $page=~s/$onLoadSeparator\s*/$onLoadText/ ;
   $page=~s/$scriptSeparator\s*// ;
   print $page ;

   exit ;
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

