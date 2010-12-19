@echo off

echo Parser Makefile
echo Copyright (c) 2004,2009 SourceCodeMetrics.com
echo Author Craig McKay craig@frontburner.co.uk
echo $Id$

echo.

attrib -r lex.*

echo Generating parser... C#
flex -olex.cs.cpp -8 -f lexer.cs.l
sed -f sed/cs.sed <lex.cs.cpp >lex.cs.tmp
move lex.cs.tmp lex.cs.cpp

echo Generating parser... C/C++
flex -olex.c.cpp -8 -f lexer.c.l
sed -f sed/c.sed <lex.c.cpp >lex.c.tmp
move lex.c.tmp lex.c.cpp

echo Generating parser... Java
flex -olex.j.cpp -8 -f lexer.j.l
sed -f sed/j.sed <lex.j.cpp >lex.j.tmp
move lex.j.tmp lex.j.cpp

echo Generating parser... VB6/VB.NET
flex -i -olex.vb.cpp -8 -f lexer.vb.l
sed -f sed/vb.sed <lex.vb.cpp >lex.vb.tmp
move lex.vb.tmp lex.vb.cpp

echo Generating parser... PL/SQL
flex -i -olex.s1.cpp -8 -f lexer.s1.l
sed -f sed/s1.sed <lex.s1.cpp >lex.s1.tmp
move lex.s1.tmp lex.s1.cpp

echo Generating parser... Ada
flex -i -olex.ada.cpp -8 -f lexer.ada.l
sed -f sed/ada.sed <lex.ada.cpp >lex.ada.tmp
move lex.ada.tmp lex.ada.cpp

echo Generating parser... Perl
flex -i -olex.pl.cpp -8 -f lexer.pl.l
sed -f sed/pl.sed <lex.pl.cpp >lex.pl.tmp
move lex.pl.tmp lex.pl.cpp

echo Generating parser... ASP
flex -i -olex.asp.cpp -8 -f lexer.asp.l
sed -f sed/asp.sed <lex.asp.cpp >lex.asp.tmp
move lex.asp.tmp lex.asp.cpp

echo Generating parser... PHP
flex -i -olex.php.cpp -8 -f lexer.php.l
sed -f sed/php.sed <lex.php.cpp >lex.php.tmp
move lex.php.tmp lex.php.cpp

echo Generating parser... Ericsson IDL
flex -i -olex.idl.cpp -8 -f lexer.idl.l
sed -f sed/idl.sed <lex.idl.cpp >lex.idl.tmp
move lex.idl.tmp lex.idl.cpp

echo Generating parser... VHDL
flex -i -olex.vhdl.cpp -8 -f lexer.vhdl.l
sed -f sed/vhdl.sed <lex.vhdl.cpp >lex.vhdl.tmp
move lex.vhdl.tmp lex.vhdl.cpp

echo Generating parser... JSP
flex -i -olex.jsp.cpp -8 -f lexer.jsp.l
sed -f sed/jsp.sed <lex.jsp.cpp >lex.jsp.tmp
move lex.jsp.tmp lex.jsp.cpp

echo Generating parser... XML
flex -i -olex.xml.cpp -8 -f lexer.xml.l
sed -f sed/xml.sed <lex.xml.cpp >lex.xml.tmp
move lex.xml.tmp lex.xml.cpp

echo Generating parser... JavaScript
flex -olex.jt.cpp -8 -f lexer.jt.l
sed -f sed/jt.sed <lex.jt.cpp >lex.jt.tmp
move lex.jt.tmp lex.jt.cpp

echo Generating parser... HTML
flex -olex.ht.cpp -i -8 -f lexer.ht.l
sed -f sed/ht.sed <lex.ht.cpp >lex.ht.tmp
move lex.ht.tmp lex.ht.cpp

echo Generating parser... Python
flex -i -olex.py.cpp -8 -f lexer.py.l
sed -f sed/py.sed <lex.py.cpp >lex.py.tmp
move lex.py.tmp lex.py.cpp

echo Generating parser... Assembler
flex -olex.ay.cpp -8 -f lexer.ay.l
sed -f sed/ay.sed <lex.ay.cpp >lex.ay.tmp
move lex.ay.tmp lex.ay.cpp

echo Generating parser... Shell Script
flex -olex.sh.cpp -8 -f lexer.sh.l
sed -f sed/sh.sed <lex.sh.cpp >lex.sh.tmp
move lex.sh.tmp lex.sh.cpp

echo Generating parser... Textfile
flex -olex.tx.cpp -8 -f lexer.tx.l
sed -f sed/tx.sed <lex.tx.cpp >lex.tx.tmp
move lex.tx.tmp lex.tx.cpp

echo Generating parser... Fortran
flex -i -olex.ft.cpp -8 -f lexer.ft.l
sed -f sed/ft.sed <lex.ft.cpp >lex.ft.tmp
move lex.ft.tmp lex.ft.cpp

echo Generating parser... CSS
flex -i -olex.ss.cpp -8 -f lexer.ss.l
sed -f sed/ss.sed <lex.ss.cpp >lex.ss.tmp
move lex.ss.tmp lex.ss.cpp

echo Generating parser... Ruby
flex -i -olex.rb.cpp -8 -f lexer.rb.l
sed -f sed/rb.sed <lex.rb.cpp >lex.rb.tmp
move lex.rb.tmp lex.rb.cpp

echo Generating parser... Windows Batch
flex -i -olex.wb.cpp -8 -f lexer.wb.l
sed -f sed/wb.sed <lex.wb.cpp >lex.wb.tmp
move lex.wb.tmp lex.wb.cpp

echo Generating parser... PowerBuilder
flex -i -olex.pb.cpp -8 -f lexer.pb.l
sed -f sed/pb.sed <lex.pb.cpp >lex.pb.tmp
move lex.pb.tmp lex.pb.cpp
      
echo.




