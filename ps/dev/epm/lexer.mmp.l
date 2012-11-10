/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 * Essential Project Manager (EPM)
 * Copyright (c) 2011 PowerSoftware.com
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * Modular Maths Processer parser
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  21-Jun-2011  10964 : File created.
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

%{

#include <stdio.h>
#include <string.h>
#include "y.mmp.h"
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

int mmp_lineno=0;
int j_comments=0;
int c_comments=0;
int cpp_comments=0;
int com_loc=0;
int ploc_count=0;

set<int> sloc;
set<int> operators;
set<unsigned int> operands;

int nsemi=0 ;           // Number of semi-colons
int noperators=0 ;      // Total number of operators
int noperands=0;        // Total number of operands

#define NOTE_SLOC()       sloc.insert(mmp_lineno)
#define STORE_OPERATOR(X) operators.insert(X); noperators++; NOTE_SLOC();
#define STORE_OPERAND(X)  operands.insert(PowerHash(X)); noperands++; NOTE_SLOC();

void lexclear();

%}

%x COMC 
%x COMEOL
%x DEFINE

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

"/*"                    {com_loc++; c_comments++; BEGIN COMC;}
<COMC>"*/"              {BEGIN 0;}
<COMC>\n                {++com_loc;++mmp_lineno;}
<COMC>.                 {;}

"//"                    {cpp_comments++; BEGIN COMEOL;}
<COMEOL>\n              {mmp_lineno++; com_loc++; BEGIN 0;}
<COMEOL>.               {}

^[ \t\v\f]*"#"          {NOTE_SLOC(); BEGIN DEFINE;}
<DEFINE>[^\\]\n         {NOTE_SLOC(); mmp_lineno++; ploc_count++;}
<DEFINE>\n              {NOTE_SLOC(); mmp_lineno++; ploc_count++; BEGIN 0;}
<DEFINE>.               {;}


\n                      {mmp_lineno++;}

";"                     {STORE_OPERATOR(SYM_SEMI);}
"-"                     {STORE_OPERATOR(SYM_MINUS);}
"%"                     {STORE_OPERATOR(SYM_PCT);}
"&"                     {STORE_OPERATOR(SYM_AND);}
"^"                     {STORE_OPERATOR(SYM_CARAT);}
"~"                     {STORE_OPERATOR(SYM_TILDE);}
"+"                     {STORE_OPERATOR(SYM_PLUS);}
"="                     {STORE_OPERATOR(SYM_EQ);}
"!"                     {STORE_OPERATOR(SYM_NOT);}
"*"                     {STORE_OPERATOR(SYM_AST);}
"/"                     {STORE_OPERATOR(SYM_DIV);}
"|"                     {STORE_OPERATOR(SYM_OR);}
"<"                     {STORE_OPERATOR(SYM_LT);}
">"                     {STORE_OPERATOR(SYM_GT);}

[ \t\v\f]               {;}

"("                     {NOTE_SLOC();}
")"                     {NOTE_SLOC();}
"{"                     {NOTE_SLOC();}
"}"                     {NOTE_SLOC();}
"."                     {NOTE_SLOC();}
","                     {NOTE_SLOC();}


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

"L"?{QUOTE}({STRCHAR}|{ESCAPE})*{QUOTE} {NOTE_SLOC();}

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
  ploc_count=mmp_lineno=nsemi=noperators=0;

  sloc.clear();
  operators.clear();
  operands.clear();
}
