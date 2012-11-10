#!/bin/perl

# Name of the template HTML file which will be used to build new download page
$newfile = '/u/p/o/w/powersft/docs/template.html' ;
$separator = '<!--start-->' ;
$titleSeparator = '<!--titleText-->' ;
$titleText = 'Buy Online' ;
$onLoadSeparator = "<!--onLoad-->" ;

print "Content-type: text/html\n\n" ;

# Get the input
read(STDIN, $buffer, $ENV{'CONTENT_LENGTH'}) ;

# Split the name-value pairs
@pairs = split(/&/, $buffer) ;

foreach $pair (@pairs)
{
    ($name, $value) = split(/=/, $pair);

    $value =~ tr/+/ /;
    $value =~ s/%([a-fA-F0-9][a-fA-F0-9])/pack("C", hex($1))/eg;

    $FORM{$name} = $value ;
}

$actpage="" ;

$continue='1' ;
$prodmsg=0 ; 

if ($FORM{'kbwincpp'} eq 'y')    { $continue=0 ; $prodmsg=1 ; }
if ($FORM{'kbwinjava'} eq 'y')   { $continue=0 ; $prodmsg=1 ; }
if ($FORM{'kbsolcpp'} eq 'y')    { $continue=0 ; $prodmsg=1 ; }
if ($FORM{'kbsoljava'} eq 'y')   { $continue=0 ; $prodmsg=1 ; }
if ($FORM{'pmwincppv2'} eq 'y')  { $continue=0 ; $prodmsg=2 ; }
if ($FORM{'pmwinjavav2'} eq 'y') { $continue=0 ; $prodmsg=2 ; }
if ($FORM{'pmsolcppv2'} eq 'y')  { $continue=0 ; $prodmsg=2 ; }
if ($FORM{'pmsoljavav2'} eq 'y') { $continue=0 ; $prodmsg=2 ; }

if ($continue eq '1') {
  do "" ; # details script
}


