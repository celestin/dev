@echo off

echo Parser Makefile
echo Copyright (c) 2004,2009 SourceCodeMetrics.com
echo Author Craig McKay craig@frontburner.co.uk
echo $Id$

echo.

attrib -r lex.*

rem echo Generating parser... C#
rem flex -olex.cs.cpp -8 -f lexer.cs.l
rem sed -f sed/cs.sed <lex.cs.cpp >lex.cs.tmp
rem move lex.cs.tmp lex.cs.cpp
rem 
rem echo Generating parser... C/C++
rem flex -olex.c.cpp -8 -f lexer.c.l
rem sed -f sed/c.sed <lex.c.cpp >lex.c.tmp
rem move lex.c.tmp lex.c.cpp
rem 
rem echo Generating parser... Java
rem flex -olex.j.cpp -8 -f lexer.j.l
rem sed -f sed/j.sed <lex.j.cpp >lex.j.tmp
rem move lex.j.tmp lex.j.cpp
rem 
rem echo Generating parser... VB6/VB.NET
rem flex -i -olex.vb.cpp -8 -f lexer.vb.l
rem sed -f sed/vb.sed <lex.vb.cpp >lex.vb.tmp
rem move lex.vb.tmp lex.vb.cpp
rem 
rem echo Generating parser... PL/SQL
rem flex -i -olex.s1.cpp -8 -f lexer.s1.l
rem sed -f sed/s1.sed <lex.s1.cpp >lex.s1.tmp
rem move lex.s1.tmp lex.s1.cpp
rem 
rem echo Generating parser... Ada
rem flex -i -olex.ada.cpp -8 -f lexer.ada.l
rem sed -f sed/ada.sed <lex.ada.cpp >lex.ada.tmp
rem move lex.ada.tmp lex.ada.cpp
rem 
rem echo Generating parser... Perl
rem flex -i -olex.pl.cpp -8 -f lexer.pl.l
rem sed -f sed/pl.sed <lex.pl.cpp >lex.pl.tmp
rem move lex.pl.tmp lex.pl.cpp
rem 
rem echo Generating parser... ASP
rem flex -i -olex.asp.cpp -8 -f lexer.asp.l
rem sed -f sed/asp.sed <lex.asp.cpp >lex.asp.tmp
rem move lex.asp.tmp lex.asp.cpp
rem 
rem echo Generating parser... PHP
rem flex -i -olex.php.cpp -8 -f lexer.php.l
rem sed -f sed/php.sed <lex.php.cpp >lex.php.tmp
rem move lex.php.tmp lex.php.cpp
rem 
rem echo Generating parser... Ericsson IDL
rem flex -i -olex.idl.cpp -8 -f lexer.idl.l
rem sed -f sed/idl.sed <lex.idl.cpp >lex.idl.tmp
rem move lex.idl.tmp lex.idl.cpp
rem 
rem echo Generating parser... VHDL
rem flex -i -olex.vhdl.cpp -8 -f lexer.vhdl.l
rem sed -f sed/vhdl.sed <lex.vhdl.cpp >lex.vhdl.tmp
rem move lex.vhdl.tmp lex.vhdl.cpp
rem 
rem echo Generating parser... JSP
rem flex -i -olex.jsp.cpp -8 -f lexer.jsp.l
rem sed -f sed/jsp.sed <lex.jsp.cpp >lex.jsp.tmp
rem move lex.jsp.tmp lex.jsp.cpp
rem 
rem echo Generating parser... XML
rem flex -i -olex.xml.cpp -8 -f lexer.xml.l
rem sed -f sed/xml.sed <lex.xml.cpp >lex.xml.tmp
rem move lex.xml.tmp lex.xml.cpp
rem 
rem echo Generating parser... JavaScript
rem flex -olex.jt.cpp -8 -f lexer.jt.l
rem sed -f sed/jt.sed <lex.jt.cpp >lex.jt.tmp
rem move lex.jt.tmp lex.jt.cpp
rem 
rem echo Generating parser... HTML
rem flex -olex.ht.cpp -i -8 -f lexer.ht.l
rem sed -f sed/ht.sed <lex.ht.cpp >lex.ht.tmp
rem move lex.ht.tmp lex.ht.cpp
rem 
rem echo Generating parser... Python
rem flex -i -olex.py.cpp -8 -f lexer.py.l
rem sed -f sed/py.sed <lex.py.cpp >lex.py.tmp
rem move lex.py.tmp lex.py.cpp
rem 
rem echo Generating parser... Assembler
rem flex -olex.ay.cpp -8 -f lexer.ay.l
rem sed -f sed/ay.sed <lex.ay.cpp >lex.ay.tmp
rem move lex.ay.tmp lex.ay.cpp
rem 
rem echo Generating parser... Shell Script
rem flex -olex.sh.cpp -8 -f lexer.sh.l
rem sed -f sed/sh.sed <lex.sh.cpp >lex.sh.tmp
rem move lex.sh.tmp lex.sh.cpp
rem 
rem echo Generating parser... Textfile
rem flex -olex.tx.cpp -8 -f lexer.tx.l
rem sed -f sed/tx.sed <lex.tx.cpp >lex.tx.tmp
rem move lex.tx.tmp lex.tx.cpp
rem 
rem echo Generating parser... Fortran
rem flex -i -olex.ft.cpp -8 -f lexer.ft.l
rem sed -f sed/ft.sed <lex.ft.cpp >lex.ft.tmp
rem move lex.ft.tmp lex.ft.cpp
rem 
rem echo Generating parser... CSS
rem flex -i -olex.ss.cpp -8 -f lexer.ss.l
rem sed -f sed/ss.sed <lex.ss.cpp >lex.ss.tmp
rem move lex.ss.tmp lex.ss.cpp
rem 
rem echo Generating parser... Ruby
rem flex -i -olex.rb.cpp -8 -f lexer.rb.l
rem sed -f sed/rb.sed <lex.rb.cpp >lex.rb.tmp
rem move lex.rb.tmp lex.rb.cpp
rem 
rem echo Generating parser... Windows Batch
rem flex -i -olex.wb.cpp -8 -f lexer.wb.l
rem sed -f sed/wb.sed <lex.wb.cpp >lex.wb.tmp
rem move lex.wb.tmp lex.wb.cpp
rem 
rem echo Generating parser... PowerBuilder
rem flex -i -olex.pb.cpp -8 -f lexer.pb.l
rem sed -f sed/pb.sed <lex.pb.cpp >lex.pb.tmp
rem move lex.pb.tmp lex.pb.cpp
      
echo Generating parser... UC
flex -i -olex.uc.cpp -8 -f lexer.uc.l
sed -f sed/uc.sed <lex.uc.cpp >lex.uc.tmp
move lex.uc.tmp lex.uc.cpp
      
echo.

