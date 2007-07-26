@echo off

echo Parser Makefile
echo Copyright 2004-2007 Power Software
echo Author Craig McKay craig@frontburner.co.uk
echo $Id$

echo.

attrib -r lex.*

rem echo Generating parser... C#
rem flex -olex.cs.tmp -8 -f lexer.cs.l
rem sed -f sed/cs.sed <lex.cs.tmp >lex.cs.cpp
rem del lex.cs.tmp
rem 
rem echo Generating parser... C/C++
rem flex -olex.c.tmp -8 -f lexer.c.l
rem sed -f sed/c.sed <lex.c.tmp >lex.c.cpp
rem del lex.c.tmp
rem 
rem echo Generating parser... Java
rem flex -olex.j.tmp -8 -f lexer.j.l
rem sed -f sed/j.sed <lex.j.tmp >lex.j.cpp
rem del lex.j.tmp
rem 
rem echo Generating parser... VB6/VB.NET
rem flex -i -olex.vb.tmp -8 -f lexer.vb.l
rem sed -f sed/vb.sed <lex.vb.tmp >lex.vb.cpp
rem del lex.vb.tmp
rem 
rem echo Generating parser... PL/SQL
rem flex -i -olex.s1.tmp -8 -f lexer.s1.l
rem sed -f sed/s1.sed <lex.s1.tmp >lex.s1.cpp
rem del lex.s1.tmp
rem 
rem echo Generating parser... Ada
rem flex -i -olex.ada.tmp -8 -f lexer.ada.l
rem sed -f sed/ada.sed <lex.ada.tmp >lex.ada.cpp
rem del lex.ada.tmp
rem 
rem echo Generating parser... Perl
rem flex -i -olex.pl.tmp -8 -f lexer.pl.l
rem sed -f sed/pl.sed <lex.pl.tmp >lex.pl.cpp
rem del lex.pl.tmp
rem 
rem echo Generating parser... ASP
rem flex -i -olex.asp.tmp -8 -f lexer.asp.l
rem sed -f sed/asp.sed <lex.asp.tmp >lex.asp.cpp
rem del lex.asp.tmp
rem 
rem echo Generating parser... PHP
rem flex -i -olex.php.tmp -8 -f lexer.php.l
rem sed -f sed/php.sed <lex.php.tmp >lex.php.cpp
rem del lex.php.tmp
rem 
rem echo Generating parser... Ericsson IDL
rem flex -i -olex.idl.tmp -8 -f lexer.idl.l
rem sed -f sed/idl.sed <lex.idl.tmp >lex.idl.cpp
rem del lex.idl.tmp
rem 
echo Generating parser... VHDL
flex -i -olex.vhdl.tmp -8 -f lexer.vhdl.l
sed -f sed/vhdl.sed <lex.vhdl.tmp >lex.vhdl.cpp
del lex.vhdl.tmp

echo.
