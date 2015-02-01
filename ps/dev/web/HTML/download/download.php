<?php

require_once('recaptchalib.php');

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

# ------------------------------------------------------------

function response_page($response_text)
{
  global $newfile, $separator, $titleSeparator, $titleText, $onLoadSeparator, $onLoadText, $scriptSeparator;

   $page = file_get_contents($newfile);
   $page = preg_replace("/$separator\s*/", $response_text, $page);
   $page = preg_replace("/$titleSeparator\s*/", $titleText, $page);
   $page = preg_replace("/$onLoadSeparator\s*/", $onLoadText, $page);
   $page = preg_replace("/$scriptSeparator\s*/", "", $page);
   echo $page ;

   exit();
}

function blank_response()
{
   $actpage="<h1 class=\"narr\">Incomplete Form</h1>\n" ;
   $actpage.="<p class=\"narr\">You must submit at least your name, email address, company name and\n" ;
   $actpage.="phone number to gain access to the download area.</p>\n" ;
   $actpage.="<p class=\"narr\">Please <a href=/download/>return\n" ;
   $actpage.="to our download page</a>, and re-enter your details.</p>\n" ;
  response_page($actpage);
}

function captcha_error($captcha_error)
{
   $actpage="<h1 class=\"narr\">Incomplete Form</h1>\n" ;
   $actpage.="<p class=\"narr\">$captcha_error</p>\n" ;
   $actpage.="<p class=\"narr\">Please <a href=/download/>return\n" ;
   $actpage.="to our download page</a>, and re-enter your details.</p>\n" ;
  response_page($actpage);
}


# ------------------------------------------------------------


$dn_name = NULL;      if (!empty($_POST['name']))      $dn_name = $_POST['name'];
$dn_email = NULL;     if (!empty($_POST['email']))     $dn_email = $_POST['email'];
$dn_company = NULL;   if (!empty($_POST['company']))   $dn_company = $_POST['company'];
$dn_phone = NULL;     if (!empty($_POST['phone']))     $dn_phone = $_POST['phone'];



# If the comments are blank, then give a "blank form" response
if (empty($dn_name) || empty($dn_email) || empty($dn_company) || empty($dn_phone)) {
  blank_response();
  exit();
} else {

  $privatekey = "6LcojucSAAAAAOnxj2ne6p7JfrzNpOAYKlz_iDPR";
  $resp = recaptcha_check_answer ($privatekey,
                                $_SERVER["REMOTE_ADDR"],
                                $_POST["recaptcha_challenge_field"],
                                $_POST["recaptcha_response_field"]);

  if (!$resp->is_valid) {
    // What happens when the CAPTCHA was entered incorrectly
    captcha_error("The reCAPTCHA wasn't entered correctly. Go back and try it again." .
         "(reCAPTCHA said: " . $resp->error . ")");
  }
}


# Initialise code for "active page" which contains the real links for downloading

$actpage="<br><h1 class=\"narr\">Thank you</H1>\n" ;
$actpage.="<p class=\"narr\">Thank you for choosing to evaluate our products!</p>\n" ;
$actpage.="<p class=\"narr\">To complete the downloading, click below for your selected products.</p>\n" ;

# Now send mail to $recipient

$mailtext = "<h2>Download by $dn_name ($dn_email)</h2>\n\n";
$mailtext .= "<b>Site</b> : " .$_SERVER['SERVER_NAME'] . "<br>\n";

if (!empty($_POST['company']))   { $mailtext .=  "<b>Company</b>      : ". $_POST['company'] ."<br>\n"; }
if (!empty($_POST['job']))       { $mailtext .=  "<b>Job Title</b>    : ". $_POST['job'] ."<br>\n"; }
if (!empty($_POST['address']))   { $mailtext .=  "<b>Address</b>      : ". $_POST['address'] ."<br>\n"; }
if (!empty($_POST['phone']))     { $mailtext .=  "<b>Phone number</b> : ". $_POST['phone'] ."<br>\n"; }

$products = "";

  # Krakatau Essential Project Manager
  if (!empty($_POST['emwinkepm']))
  {
    $actpage.="<p class=\"narr\"><b>Krakatau Essential Project Manager</b><br>" ;

    if (!empty($_POST['emwinkepm']))
    {
      $actpage.="<a href=/download/em/kepm_203_0000.zip><b>KEPM</b> ADA Assembly ASP C# C/C++ CSS Fortran IDL HTML Java JavaScript JSP MMP Perl PHP PL/SQL PowerBuilder Python Ruby ShellScript Textfiles UCode VB6 / VB.NET / VBScript VHDL WindowsBatch and XML (Windows NT/2000/XP/2003/Vista/7<span class=hotnew>Windows 8</span>) <b>Version 2.3.0.0</b></a><br>\n";
      $products.= "<li><b>KEPM</b> | ADA Assembly ASP C# C/C++ CSS Fortran IDL HTML Java JavaScript JSP MMP Perl PHP PL/SQL PowerBuilder Python Ruby ShellScript Textfiles UCode VB6 / VB.NET / VBScript VHDL WindowsBatch and XML (Windows NT/2000/XP/2003/Vista/7/Windows 8) <b>Version 2.3.0.0</b></li>\n";
    }

    $actpage.="</p>" ;
  }


# Vista / Windows 7 / Windows 8 message

$actpage .= "<br><br><br><h2 class=\"narr\">Installing on Windows Vista, Windows 7 or Windows 8?</h2>\n";
$actpage .= "<p class=\"narr\">Please read the <a href=\"http://www.powersoftware.com/kepm/QuickStartGuideKEPM.pdf\">Quick Start Guide</a>.</p>\n";
$actpage .= "<p class=\"narr\">Be sure that you right-click on the KrakatauEpmSetup.exe and choose <b>Run as administrator</b>.</p>\n";
$actpage .= "<p class=\"narr\">Why?  If you don't, MySQL won't be properly registered and the service won't be started.</p>\n";
$actpage .= "<img src=\"../img/Win8-RunAsAdministrator.png\">\n";


if (strlen($products)>0) {
  $mailtext .= "<ul>$products</ul>";
}

$to      = "\"Power Software Sales\" <$recipient>";
$subject = "Download by $dn_name ($dn_email) from " .$_SERVER['SERVER_NAME'];
$message = $mailtext;
$from    = $dn_email;

$headers    = array
    (
        'MIME-Version: 1.0',
        'Content-Type: text/html; charset="UTF-8";',
        'Content-Transfer-Encoding: 7bit',
        'Date: ' . date('r', $_SERVER['REQUEST_TIME']),
        'Message-ID: <' . $_SERVER['REQUEST_TIME'] . md5($_SERVER['REQUEST_TIME']) . '@' . $_SERVER['SERVER_NAME'] . '>',
        'From: ' . $from,
        'Reply-To: ' . $from,
        'Return-Path: ' . $from,
        'X-Mailer: PHP v' . phpversion(),
        'X-Originating-IP: ' . $_SERVER['SERVER_ADDR'],
    );

mail($to, $subject, $message, implode("\n", $headers));

response_page($actpage);

?>