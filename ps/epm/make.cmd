@echo off

echo Parser Makefile
echo Copyright (c) 2004,2008 SourceCodeMetrics.com
echo Author Craig McKay craig@frontburner.co.uk
echo $Id$

echo.

attrib -r lex.*

echo Generating parser... C#
flex -olex.cs.tmp -8 -f lexer.cs.l
sed -f sed/cs.sed <lex.cs.tmp >lex.cs.cpp
del lex.cs.tmp

echo Generating parser... C/C++
flex -olex.c.tmp -8 -f lexer.c.l
sed -f sed/c.sed <lex.c.tmp >lex.c.cpp
del lex.c.tmp

echo Generating parser... Java
flex -olex.j.tmp -8 -f lexer.j.l
sed -f sed/j.sed <lex.j.tmp >lex.j.cpp
del lex.j.tmp

echo Generating parser... VB6/VB.NET
flex -i -olex.vb.tmp -8 -f lexer.vb.l
sed -f sed/vb.sed <lex.vb.tmp >lex.vb.cpp
del lex.vb.tmp

echo Generating parser... PL/SQL
flex -i -olex.s1.tmp -8 -f lexer.s1.l
sed -f sed/s1.sed <lex.s1.tmp >lex.s1.cpp
del lex.s1.tmp

echo Generating parser... Ada
flex -i -olex.ada.tmp -8 -f lexer.ada.l
sed -f sed/ada.sed <lex.ada.tmp >lex.ada.cpp
del lex.ada.tmp

echo Generating parser... Perl
flex -i -olex.pl.tmp -8 -f lexer.pl.l
sed -f sed/pl.sed <lex.pl.tmp >lex.pl.cpp
del lex.pl.tmp

echo Generating parser... ASP
flex -i -olex.asp.tmp -8 -f lexer.asp.l
sed -f sed/asp.sed <lex.asp.tmp >lex.asp.cpp
del lex.asp.tmp

echo Generating parser... PHP
flex -i -olex.php.tmp -8 -f lexer.php.l
sed -f sed/php.sed <lex.php.tmp >lex.php.cpp
del lex.php.tmp

echo Generating parser... Ericsson IDL
flex -i -olex.idl.tmp -8 -f lexer.idl.l
sed -f sed/idl.sed <lex.idl.tmp >lex.idl.cpp
del lex.idl.tmp

echo Generating parser... VHDL
flex -i -olex.vhdl.tmp -8 -f lexer.vhdl.l
sed -f sed/vhdl.sed <lex.vhdl.tmp >lex.vhdl.cpp
del lex.vhdl.tmp

echo Generating parser... JSP
flex -i -olex.jsp.tmp -8 -f lexer.jsp.l
sed -f sed/jsp.sed <lex.jsp.tmp >lex.jsp.cpp
del lex.jsp.tmp

echo Generating parser... XML
flex -i -olex.xml.tmp -8 -f lexer.xml.l
sed -f sed/xml.sed <lex.xml.tmp >lex.xml.cpp
del lex.xml.tmp

echo.
