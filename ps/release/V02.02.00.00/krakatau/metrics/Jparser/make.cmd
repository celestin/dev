@echo off

echo JParser Makefile
echo Copyright (c) 2004,2008 SourceCodeMetrics.com
echo Author Craig McKay craig@frontburner.co.uk
echo $Id$

echo.

attrib -r lex.*

echo Generating parser... Java
flex -olex.yy.tmp -8 -f jlexer.l
sed -f j.sed <lex.yy.tmp >lex.yy.cpp
del lex.yy.tmp

pause