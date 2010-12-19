/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 * Essential Project Manager (EPM)
 * Copyright (c) 2009 PowerSoftware.com
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * Windows Batch parser lexemes
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  22-Aug-2009  10455 : File created.
 * CAM  22-Sep-2010  10648 : Converted from string operands to PowerHashed.
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

%{

#include <stdio.h>
#include <string.h>
#include "y.wb.h"
#include "PowerHash.h"

#ifdef WIN32

#include <io.h>
#include <set>
#include <iostream>
using namespace std;

#else

#include <stl.h>
#include <unistd.h>

#endif

int batch_lineno=0;
int j_comments=0;
int c_comments=0;
int cpp_comments=0;
int com_loc=0;
int prev_com_line=-1;

set<int> sloc;
set<int> operators;
set<unsigned int> operands;

int nsemi=0 ;           // Number of semi-colons
int noperators=0 ;      // Total number of operators
int noperands=0;        // Total number of operands

#define NOTE_SLOC()       sloc.insert(batch_lineno)
#define STORE_OPERATOR(X) operators.insert(X); noperators++; NOTE_SLOC();
#define STORE_OPERAND(X)  operands.insert(PowerHash(X)); noperands++; NOTE_SLOC();
#define SEMI()            nsemi++; NOTE_SLOC();

void lexclear();

%}

%x RBDOC

NL            "\n"
NOTNL         .
ANY           ({NOTNL}|{NL})
BACKSL        "\\"
BOL           ^
LETTER        [A-Za-z_]
ALNUM         [A-Za-z_0-9]
DIGIT         [0-9]
HEXDIGIT      [0-9A-Fa-f]
DIGITS        ({DIGIT}+)
EXP           [Ee][+-]?DIGITS
HEXDIGITS     ({HEXDIGIT}+)
SIGN          ("+"|"-")
ELL_SUFFIX    [lL]([lL]?)
INT_SUFFIX    ([uU]{ELL_SUFFIX}?|{ELL_SUFFIX}[uU]?)
FLOAT_SUFFIX  [flFL]
STRCHAR       [^\"\n\\]
ESCAPE        ({BACKSL}{ANY})
QUOTE         [\"]
SPTAB         [ \t]

%%

\n                      {batch_lineno++;}

"("                     {NOTE_SLOC();}
")"                     {NOTE_SLOC();}

\".*\\\"*\"             |
\".*\"                  {STORE_OPERAND(yytext);}
"'"."'"                 {STORE_OPERAND(yytext);}

"-"                     {STORE_OPERATOR(SYM_MINUS);}
"%"                     {STORE_OPERATOR(SYM_PCT);}
"="                     {STORE_OPERATOR(SYM_EQ);}
"!"                     {STORE_OPERATOR(SYM_NOT);}
"/"                     {STORE_OPERATOR(SYM_SLASH);}
"|"                     {STORE_OPERATOR(SYM_PIPE);}
"<"                     {STORE_OPERATOR(SYM_LT);}
">"                     {STORE_OPERATOR(SYM_OUT);}
"*"                     {STORE_OPERATOR(SYM_WILDANY);}
"?"                     {STORE_OPERATOR(SYM_WILDONE);}
"@"                     {STORE_OPERATOR(SYM_NOECHO);}
":"                     {STORE_OPERATOR(SYM_LABEL);}
"%%"                    {STORE_OPERATOR(SYM_DIVEQ);}
"&&"                    {STORE_OPERATOR(SYM_SCOPE);}
"=="                    {STORE_OPERATOR(SYM_EQUALITY);}
">>"                    {STORE_OPERATOR(SYM_APPEND);}

[ \t\v\f]               {;}

"append"                {STORE_OPERATOR(KEY_APPEND);}
"assoc"                 {STORE_OPERATOR(KEY_ASSOC);}
"attrib"                {STORE_OPERATOR(KEY_ATTRIB);}
"call"                  {STORE_OPERATOR(KEY_CALL);}
"cd"                    {STORE_OPERATOR(KEY_CD);}
"chdir"                 {STORE_OPERATOR(KEY_CHDIR);}
"cmd"                   {STORE_OPERATOR(KEY_CMD);}
"col"                   {STORE_OPERATOR(KEY_COL);}
"copy"                  {STORE_OPERATOR(KEY_COPY);}
"del"                   {STORE_OPERATOR(KEY_DEL);}
"dir"                   {STORE_OPERATOR(KEY_DIR);}
"do"                    {STORE_OPERATOR(KEY_DO);}
"echo"                  {STORE_OPERATOR(KEY_ECHO);}
"else"                  {STORE_OPERATOR(KEY_ELSE);}
"endlocal"              {STORE_OPERATOR(KEY_ENDLOCAL);}
"erase"                 {STORE_OPERATOR(KEY_ERASE);}
"find"                  {STORE_OPERATOR(KEY_FIND);}
"for"                   {STORE_OPERATOR(KEY_FOR);}
"ftype"                 {STORE_OPERATOR(KEY_FTYPE);}
"goto"                  {STORE_OPERATOR(KEY_GOTO);}
"if"                    {STORE_OPERATOR(KEY_IF);}
"in"                    {STORE_OPERATOR(KEY_IN);}
"md"                    {STORE_OPERATOR(KEY_MD);}
"mkdir"                 {STORE_OPERATOR(KEY_MKDIR);}
"move"                  {STORE_OPERATOR(KEY_MOVE);}
"net"                   {STORE_OPERATOR(KEY_NET);}
"nul"                   {STORE_OPERATOR(KEY_NUL);}
"off"                   {STORE_OPERATOR(KEY_OFF);}
"popd"                  {STORE_OPERATOR(KEY_POPD);}
"prompt"                {STORE_OPERATOR(KEY_PROMPT);}
"pushd"                 {STORE_OPERATOR(KEY_PUSHD);}
"rmdir"                 {STORE_OPERATOR(KEY_RMDIR);}
"set"                   {STORE_OPERATOR(KEY_SET);}
"setlocal"              {STORE_OPERATOR(KEY_SETLOCAL);}
"shift"                 {STORE_OPERATOR(KEY_SHIFT);}
"sort"                  {STORE_OPERATOR(KEY_SORT);}
"start"                 {STORE_OPERATOR(KEY_START);}
"xcopy"                 {STORE_OPERATOR(KEY_XCOPY);}

{LETTER}{ALNUM}*        {STORE_OPERAND(yytext);}

[1-9][0-9]*{INT_SUFFIX}?           |
[0][0-7]*{INT_SUFFIX}?             |
[0][xX][0-9A-Fa-f]+{INT_SUFFIX}?          {STORE_OPERAND(yytext);}

[0][xX]               {STORE_OPERAND(yytext);}

{DIGITS}"."{DIGITS}?([eE]{SIGN}?{DIGITS})?{FLOAT_SUFFIX}?   |
{DIGITS}"."?([eE]{SIGN}?{DIGITS})?{FLOAT_SUFFIX}?     |
"."{DIGITS}([eE]{SIGN}?{DIGITS})?{FLOAT_SUFFIX}?    {STORE_OPERAND(yytext);}

{DIGITS}"."{DIGITS}?[eE]{SIGN}?   |
{DIGITS}"."?[eE]{SIGN}?           |
"."{DIGITS}[eE]{SIGN}?                    {STORE_OPERAND(yytext);}

"rem"{NL}           |
"rem "{NOTNL}*{NL}      {cpp_comments++;com_loc++;batch_lineno++;BEGIN(INITIAL);}

.                       {;}

%%
int yywrap()
{
  return(1);
}

void lexclear() {
  BEGIN 0 ;
  noperands=0;
  j_comments=c_comments=cpp_comments=com_loc=0;
  prev_com_line=-1;
  batch_lineno=nsemi=noperators=0;

  sloc.clear();
  operators.clear();
  operands.clear();
}
