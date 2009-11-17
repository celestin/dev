/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 * Essential Project Manager (EPM)
 * Copyright (c) 2004,2009 PowerSoftware.com
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * Perl parser
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  03-Aug-05    114 : File created.
 * CAM  24-Apr-08    358 : Corrected compiler warnings moving to VS2008 (from VC++6).
 * CAM  07-Apr-2009  10415 : Rewrote parser to handle all Perl eventualities correctly.
 * CAM  14-Apr-2009  10416 : Corrected multi-line comments (in line with lexer.cs.l).
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

%{

#include <stdio.h>
#include <string.h>
#include "y.pl.h"

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

int perl_lineno=0;
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

#define SEMI() nsemi++;
#define COUNT() sloc.insert(perl_lineno)

void lexclear() {
  BEGIN 0 ;
  noperands=0;
  j_comments=c_comments=cpp_comments=com_loc=0;
  prev_com_line=-1;
  perl_lineno=nsemi=noperators=0;

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

%}

%x PODTAG

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

^=                      {com_loc++; c_comments++; BEGIN PODTAG;}
<PODTAG>^"=cut"         {BEGIN 0;}
<PODTAG>\n              {++com_loc;++perl_lineno;}
<PODTAG>.               {;}

\n                      {perl_lineno++;}

"!"                     {store_operator('!');}
"*"                     {store_operator('*');}
"+"                     {store_operator('+');}
","                     {store_operator(',');}
"-"                     {store_operator('-');}
"."                     {store_operator('.');}
":"                     {store_operator(':');}
"<"                     {store_operator('<');}
"="                     {store_operator('=');}
">"                     {store_operator('>');}
"?"                     {store_operator('?');}
"\\"                    {store_operator('\\');}
"^"                     {store_operator('^');}
"|"                     {store_operator('|');}
"~"                     {store_operator('~');}
"$"                     {store_operator('$');}

"^="                    {store_operator(CARAT_EQUALS);}
"||"                    {store_operator(BAR_BAR);}
"||="                   {store_operator(BAR_BAR_EQUALS);}
"|="                    {store_operator(BAR_EQUALS);}
"<="                    {store_operator(LEFT_EQUALS);}
"<=>"                   {store_operator(LEFT_EQUALS_RIGHT);}
"<<"                    {store_operator(LEFT_LEFT);}
"<<="                   {store_operator(LEFT_LEFT_EQUALS);}
"%"                     {store_operator(PERCENT);}
"%="                    {store_operator(PERCENT_EQUALS);}
">="                    {store_operator(RIGHT_EQUALS);}
">>"                    {store_operator(RIGHT_RIGHT);}
">>="                   {store_operator(RIGHT_RIGHT_EQUALS);}
"-="                    {store_operator(MINUS_EQUALS);}
"--"                    {store_operator(MINUS_MINUS);}
"->"                    {store_operator(MINUS_RIGHT);}
"/"                     {store_operator(SLASH);}
"/="                    {store_operator(SLASH_EQUALS);}
"!="                    {store_operator(PLING_EQUALS);}
"!~"                    {store_operator(PLING_TILDE);}
"+="                    {store_operator(PLUS_EQUALS);}
"++"                    {store_operator(PLUS_PLUS);}
"&"                     {store_operator(AMP);}
"&&"                    {store_operator(AMP_AMP);}
"&&="                   {store_operator(AMP_AMP_EQUALS);}
"&="                    {store_operator(AMP_EQUALS);}
"*="                    {store_operator(AMP_EQUALS);}
".."                    {store_operator(DOT_DOT);}
".="                    {store_operator(DOT_EQUALS);}
"=="                    {store_operator(EQUALS_EQUALS);}
"=>"                    {store_operator(EQUALS_RIGHT);}
"=~"                    {store_operator(EQUALS_TILDE);}
"**"                    {store_operator(AST_AST);}
"**="                   {store_operator(AST_AST_EQUALS);}
"x="                    {store_operator(X_EQUALS);}

";"                     {COUNT(); SEMI();}
[ \t\v\f]               {;}

"("                     {COUNT();}
")"                     {COUNT();}
"{"                     {COUNT();}
"}"                     {COUNT();}

"and"                   {store_operator(OP_AND);}
"bless"                 {store_operator(BLESS);}
"caller"                {store_operator(CALLER);}
"cmp"                   {store_operator(OP_CMP);}
"continue"              {store_operator(CONTINUE);}
"dbmclose"              {store_operator(DBMCLOSE);}
"dbmopen"               {store_operator(DBMOPEN);}
"die"                   {store_operator(DIE);}
"do"                    {store_operator(DO);}
"dump"                  {store_operator(DUMP);}
"else"                  {store_operator(ELSE);}
"elsif"                 {store_operator(ELSIF);}
"eq"                    {store_operator(OP_EQ);}
"eval"                  {store_operator(EVAL);}
"exit"                  {store_operator(EXIT);}
"for"                   {store_operator(FOR);}
"foreach"               {store_operator(FOREACH);}
"ge"                    {store_operator(OP_GE);}
"goto"                  {store_operator(GOTO);}
"gt"                    {store_operator(OP_GT);}
"if"                    {store_operator(IF);}
"import"                {store_operator(IMPORT);}
"last"                  {store_operator(LAST);}
"le"                    {store_operator(OP_LE);}
"local"                 {store_operator(LOCAL);}
"lt"                    {store_operator(OP_LT);}
"my"                    {store_operator(MY);}
"ne"                    {store_operator(OP_NE);}
"next"                  {store_operator(NEXT);}
"no"                    {store_operator(NO);}
"not"                   {store_operator(OP_NOT);}
"or"                    {store_operator(OP_OR);}
"our"                   {store_operator(OUR);}
"package"               {store_operator(PACKAGE);}
"redo"                  {store_operator(REDO);}
"ref"                   {store_operator(REF);}
"require"               {store_operator(REQUIRE);}
"return"                {store_operator(RETURN);}
"sub"                   {store_operator(SUB);}
"tie"                   {store_operator(TIE);}
"tied"                  {store_operator(TIED);}
"unary"                 {store_operator(OP_UNARY);}
"unless"                {store_operator(UNLESS);}
"untie"                 {store_operator(UNTIE);}
"until"                 {store_operator(UNTIL);}
"use"                   {store_operator(USE);}
"wantarray"             {store_operator(WANTARRAY);}
"x"                     {store_operator(OP_X);}
"xor"                   {store_operator(OP_XOR);}

{LETTER}{ALNUM}*            {store_operand(_strdup(yytext));}

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

"#"{NOTNL}*{NL}         {++cpp_comments;++com_loc;++perl_lineno;BEGIN(INITIAL);}

"L"?{QUOTE}({STRCHAR}|{ESCAPE})*{QUOTE} {COUNT();}

.                       {;}

%%
int yywrap()
{
  return(1);
}

