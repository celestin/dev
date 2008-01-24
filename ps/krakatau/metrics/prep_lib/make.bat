@echo off
echo Creating config file reader scanner...
flex -Pcfg_ -f -oconf.yy.cpp conf.l

echo Creating config file reader parser...
bison -p cfg_ -d -oconf.tab.cpp conf.y

move conf.tab.cpp.h conf.tab.h

echo Creating preprocessor scanner...
flex -f -oprep.yy.cpp prep.l

