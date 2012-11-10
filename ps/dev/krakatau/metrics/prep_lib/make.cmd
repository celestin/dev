@echo off

echo Parser Makefile
echo Copyright (c) 2001,2008 SourceCodeMetrics.com
echo Author Craig McKay craig@frontburner.co.uk
echo $Id$

echo.

echo Creating config file reader scanner...
flex -Pcfg_ -f -oconf.yy.cpp conf.l

echo Creating config file reader parser...
bison -p cfg_ -d -oconf.tab.cpp conf.y

move conf.tab.cpp.h conf.tab.h

echo Creating preprocessor scanner...
flex -f -oprep.yy.tmp prep.l

echo Tidy flex generated code

sed -f prep.sed <conf.yy.cpp >conf.yy.cpp.new
del conf.yy.cpp
move conf.yy.cpp.new conf.yy.cpp

sed -f prep.sed <prep.yy.tmp >prep.yy.cpp
del prep.yy.tmp
