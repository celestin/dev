@echo off

echo Parser Makefile
echo Copyright (c) 2004,2008 SourceCodeMetrics.com
echo Author Craig McKay craig@frontburner.co.uk
echo $Id$

echo.

attrib -r lex.*

echo Generating parser... C/C++
flex -olex.yy.tmp -8 -f lexer.l
sed -f c.sed <lex.yy.tmp >lex.yy.cpp
del lex.yy.tmp
