@echo off

echo Parser Makefile
echo Copyright (c) 2004,2009 SourceCodeMetrics.com
echo Author Craig McKay craig@frontburner.co.uk
echo $Id$

echo.

attrib -r lex.*

rem    echo Generating parser... C#
rem    flex -olex.cs.tmp -8 -f lexer.cs.l
rem    sed -f sed/cs.sed <lex.cs.tmp >lex.cs.cpp
rem    del lex.cs.tmp
rem    
rem    echo Generating parser... C/C++
rem    flex -olex.c.tmp -8 -f lexer.c.l
rem    sed -f sed/c.sed <lex.c.tmp >lex.c.cpp
rem    del lex.c.tmp
rem    
rem    echo Generating parser... Java
rem    flex -olex.j.tmp -8 -f lexer.j.l
rem    sed -f sed/j.sed <lex.j.tmp >lex.j.cpp
rem    del lex.j.tmp
rem    
rem    echo Generating parser... VB6/VB.NET
rem    flex -i -olex.vb.tmp -8 -f lexer.vb.l
rem    sed -f sed/vb.sed <lex.vb.tmp >lex.vb.cpp
rem    del lex.vb.tmp
rem    
rem    echo Generating parser... PL/SQL
rem    flex -i -olex.s1.tmp -8 -f lexer.s1.l
rem    sed -f sed/s1.sed <lex.s1.tmp >lex.s1.cpp
rem    del lex.s1.tmp
rem    
rem    echo Generating parser... Ada
rem    flex -i -olex.ada.tmp -8 -f lexer.ada.l
rem    sed -f sed/ada.sed <lex.ada.tmp >lex.ada.cpp
rem    del lex.ada.tmp
rem     
rem    echo Generating parser... Perl
rem    flex -i -olex.pl.tmp -8 -f lexer.pl.l
rem    sed -f sed/pl.sed <lex.pl.tmp >lex.pl.cpp
rem    del lex.pl.tmp
rem    
rem    echo Generating parser... ASP
rem    flex -i -olex.asp.tmp -8 -f lexer.asp.l
rem    sed -f sed/asp.sed <lex.asp.tmp >lex.asp.cpp
rem    del lex.asp.tmp
rem   
rem    echo Generating parser... PHP
rem    flex -i -olex.php.tmp -8 -f lexer.php.l
rem    sed -f sed/php.sed <lex.php.tmp >lex.php.cpp
rem    del lex.php.tmp
rem    
rem    echo Generating parser... Ericsson IDL
rem    flex -i -olex.idl.tmp -8 -f lexer.idl.l
rem    sed -f sed/idl.sed <lex.idl.tmp >lex.idl.cpp
rem    del lex.idl.tmp
rem    
rem    echo Generating parser... VHDL
rem    flex -i -olex.vhdl.tmp -8 -f lexer.vhdl.l
rem    sed -f sed/vhdl.sed <lex.vhdl.tmp >lex.vhdl.cpp
rem    del lex.vhdl.tmp
rem    
rem    echo Generating parser... JSP
rem    flex -i -olex.jsp.tmp -8 -f lexer.jsp.l
rem    sed -f sed/jsp.sed <lex.jsp.tmp >lex.jsp.cpp
rem    del lex.jsp.tmp
rem    
rem    echo Generating parser... XML
rem    flex -i -olex.xml.tmp -8 -f lexer.xml.l
rem    sed -f sed/xml.sed <lex.xml.tmp >lex.xml.cpp
rem    del lex.xml.tmp
rem    
rem    echo Generating parser... JavaScript
rem    flex -olex.jt.tmp -8 -f lexer.jt.l
rem    sed -f sed/jt.sed <lex.jt.tmp >lex.jt.cpp
rem    del lex.jt.tmp
rem    
rem    echo Generating parser... HTML
rem    flex -olex.ht.tmp -i -8 -f lexer.ht.l
rem    sed -f sed/ht.sed <lex.ht.tmp >lex.ht.cpp
rem    del lex.ht.tmp
rem    
rem    echo Generating parser... Python
rem    flex -i -olex.py.tmp -8 -f lexer.py.l
rem    sed -f sed/py.sed <lex.py.tmp >lex.py.cpp
rem    del lex.py.tmp
rem    
rem    echo Generating parser... Assembler
rem    flex -olex.ay.tmp -8 -f lexer.ay.l
rem    sed -f sed/ay.sed <lex.ay.tmp >lex.ay.cpp
rem    del lex.ay.tmp
rem
rem    echo Generating parser... Shell Script
rem    flex -olex.sh.tmp -8 -f lexer.sh.l
rem    sed -f sed/sh.sed <lex.sh.tmp >lex.sh.cpp
rem    del lex.sh.tmp
rem    
rem    echo Generating parser... Textfile
rem    flex -olex.tx.tmp -8 -f lexer.tx.l
rem    sed -f sed/tx.sed <lex.tx.tmp >lex.tx.cpp
rem    del lex.tx.tmp
rem    
rem echo Generating parser... Fortran
rem flex -i -olex.ft.tmp -8 -f lexer.ft.l
rem sed -f sed/ft.sed <lex.ft.tmp >lex.ft.cpp
rem del lex.ft.tmp
rem    
rem    echo Generating parser... CSS
rem    flex -i -olex.ss.tmp -8 -f lexer.ss.l
rem    sed -f sed/ss.sed <lex.ss.tmp >lex.ss.cpp
rem    del lex.ss.tmp
rem    

echo Generating parser... Ruby
flex -i -olex.rb.tmp -8 -f lexer.rb.l
sed -f sed/rb.sed <lex.rb.tmp >lex.rb.cpp
del lex.rb.tmp

echo.




