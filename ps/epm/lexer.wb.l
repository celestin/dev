/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 * Essential Project Manager (EPM)
 * Copyright (c) 2009 Power Software
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * Windows Batch parser lexemes
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  22-Aug-2009  10455 : File created.
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

%{

#include <stdio.h>
#include <string.h>
#include "y.wb.h"

#ifdef WIN32

#include <io.h>
#include <vector>
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
vector<char*> operands[255];

int nsemi=0 ;           // Number of semi-colons
int noperators=0 ;      // Total number of operators
int noperands=0;        // Total number of operands

#define COUNT() sloc.insert(batch_lineno)

void lexclear();
void store_operator(int op);
void store_operand(char* txt);

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

"("                     {COUNT();}
")"                     {COUNT();}

\".*\\\"*\"             |
\".*\"                  {store_operand(_strdup(yytext));COUNT();}
"'"."'"                 {store_operand(_strdup(yytext));COUNT();}

"-"                     {store_operator(SYM_MINUS);}
"%"                     {store_operator(SYM_PCT);}
"="                     {store_operator(SYM_EQ);}
"!"                     {store_operator(SYM_NOT);}
"/"                     {store_operator(SYM_SLASH);}
"|"                     {store_operator(SYM_PIPE);}
"<"                     {store_operator(SYM_LT);}
">"                     {store_operator(SYM_OUT);}
"*"                     {store_operator(SYM_WILDANY);}
"?"                     {store_operator(SYM_WILDONE);}
"@"                     {store_operator(SYM_NOECHO);}
":"                     {store_operator(SYM_LABEL);}
"%%"                    {store_operator(SYM_DIVEQ);}
"&&"                    {store_operator(SYM_SCOPE);}
"=="                    {store_operator(SYM_EQUALITY);}
">>"                    {store_operator(SYM_APPEND);}

[ \t\v\f]               {;}

"append"                {store_operator(KEY_APPEND);}
"assoc"                 {store_operator(KEY_ASSOC);}
"attrib"                {store_operator(KEY_ATTRIB);}
"call"                  {store_operator(KEY_CALL);}
"cd"                    {store_operator(KEY_CD);}
"chdir"                 {store_operator(KEY_CHDIR);}
"cmd"                   {store_operator(KEY_CMD);}
"col"                   {store_operator(KEY_COL);}
"copy"                  {store_operator(KEY_COPY);}
"del"                   {store_operator(KEY_DEL);}
"dir"                   {store_operator(KEY_DIR);}
"do"                    {store_operator(KEY_DO);}
"echo"                  {store_operator(KEY_ECHO);}
"else"                  {store_operator(KEY_ELSE);}
"endlocal"              {store_operator(KEY_ENDLOCAL);}
"erase"                 {store_operator(KEY_ERASE);}
"find"                  {store_operator(KEY_FIND);}
"for"                   {store_operator(KEY_FOR);}
"ftype"                 {store_operator(KEY_FTYPE);}
"goto"                  {store_operator(KEY_GOTO);}
"if"                    {store_operator(KEY_IF);}
"in"                    {store_operator(KEY_IN);}
"md"                    {store_operator(KEY_MD);}
"mkdir"                 {store_operator(KEY_MKDIR);}
"move"                  {store_operator(KEY_MOVE);}
"net"                   {store_operator(KEY_NET);}
"nul"                   {store_operator(KEY_NUL);}
"off"                   {store_operator(KEY_OFF);}
"popd"                  {store_operator(KEY_POPD);}
"prompt"                {store_operator(KEY_PROMPT);}
"pushd"                 {store_operator(KEY_PUSHD);}
"rmdir"                 {store_operator(KEY_RMDIR);}
"set"                   {store_operator(KEY_SET);}
"setlocal"              {store_operator(KEY_SETLOCAL);}
"shift"                 {store_operator(KEY_SHIFT);}
"sort"                  {store_operator(KEY_SORT);}
"start"                 {store_operator(KEY_START);}
"xcopy"                 {store_operator(KEY_XCOPY);}

{LETTER}{ALNUM}*        {store_operand(_strdup(yytext));}

[1-9][0-9]*{INT_SUFFIX}?           |
[0][0-7]*{INT_SUFFIX}?             |
[0][xX][0-9A-Fa-f]+{INT_SUFFIX}?          {store_operand(_strdup(yytext));}

[0][xX]               {store_operand(_strdup(yytext));}

{DIGITS}"."{DIGITS}?([eE]{SIGN}?{DIGITS})?{FLOAT_SUFFIX}?   |
{DIGITS}"."?([eE]{SIGN}?{DIGITS})?{FLOAT_SUFFIX}?     |
"."{DIGITS}([eE]{SIGN}?{DIGITS})?{FLOAT_SUFFIX}?    {store_operand(_strdup(yytext));}

{DIGITS}"."{DIGITS}?[eE]{SIGN}?   |
{DIGITS}"."?[eE]{SIGN}?           |
"."{DIGITS}[eE]{SIGN}?                    {store_operand(_strdup(yytext));}

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

  for (int i=0; i<255; i++) {
    if (operands[i].size() > 0) operands[i].clear();
  }
}

void store_operator(int op) {
  operators.insert(op);
  noperators++;
  COUNT();
}

void store_operand(char* txt) {
  char c;
  unsigned int i;
  noperands++;

  c=txt[0];
  for (i=0;i<operands[c].size();i++) {
    if (!strcmp(txt,operands[c][i])) return;
  }
  operands[c].push_back(txt) ;
  COUNT();
}
