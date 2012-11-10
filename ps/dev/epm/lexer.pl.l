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
 * CAM  30-Sep-2010  10648 : Converted from string operands to PowerHashed.
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

%{

#include <stdio.h>
#include <string.h>
#include "y.pl.h"
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

int perl_lineno=0;
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

#define NOTE_SLOC()       sloc.insert(perl_lineno)
#define STORE_OPERATOR(X) operators.insert(X); noperators++; NOTE_SLOC();
#define STORE_OPERAND(X)  operands.insert(PowerHash(X)); noperands++; NOTE_SLOC();
#define SEMI()            nsemi++; NOTE_SLOC();

void lexclear();

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

"!"                     {STORE_OPERATOR('!');}
"*"                     {STORE_OPERATOR('*');}
"+"                     {STORE_OPERATOR('+');}
","                     {STORE_OPERATOR(',');}
"-"                     {STORE_OPERATOR('-');}
"."                     {STORE_OPERATOR('.');}
":"                     {STORE_OPERATOR(':');}
"<"                     {STORE_OPERATOR('<');}
"="                     {STORE_OPERATOR('=');}
">"                     {STORE_OPERATOR('>');}
"?"                     {STORE_OPERATOR('?');}
"\\"                    {STORE_OPERATOR('\\');}
"^"                     {STORE_OPERATOR('^');}
"|"                     {STORE_OPERATOR('|');}
"~"                     {STORE_OPERATOR('~');}
"$"                     {STORE_OPERATOR('$');}

"^="                    {STORE_OPERATOR(CARAT_EQUALS);}
"||"                    {STORE_OPERATOR(BAR_BAR);}
"||="                   {STORE_OPERATOR(BAR_BAR_EQUALS);}
"|="                    {STORE_OPERATOR(BAR_EQUALS);}
"<="                    {STORE_OPERATOR(LEFT_EQUALS);}
"<=>"                   {STORE_OPERATOR(LEFT_EQUALS_RIGHT);}
"<<"                    {STORE_OPERATOR(LEFT_LEFT);}
"<<="                   {STORE_OPERATOR(LEFT_LEFT_EQUALS);}
"%"                     {STORE_OPERATOR(PERCENT);}
"%="                    {STORE_OPERATOR(PERCENT_EQUALS);}
">="                    {STORE_OPERATOR(RIGHT_EQUALS);}
">>"                    {STORE_OPERATOR(RIGHT_RIGHT);}
">>="                   {STORE_OPERATOR(RIGHT_RIGHT_EQUALS);}
"-="                    {STORE_OPERATOR(MINUS_EQUALS);}
"--"                    {STORE_OPERATOR(MINUS_MINUS);}
"->"                    {STORE_OPERATOR(MINUS_RIGHT);}
"/"                     {STORE_OPERATOR(SLASH);}
"/="                    {STORE_OPERATOR(SLASH_EQUALS);}
"!="                    {STORE_OPERATOR(PLING_EQUALS);}
"!~"                    {STORE_OPERATOR(PLING_TILDE);}
"+="                    {STORE_OPERATOR(PLUS_EQUALS);}
"++"                    {STORE_OPERATOR(PLUS_PLUS);}
"&"                     {STORE_OPERATOR(AMP);}
"&&"                    {STORE_OPERATOR(AMP_AMP);}
"&&="                   {STORE_OPERATOR(AMP_AMP_EQUALS);}
"&="                    {STORE_OPERATOR(AMP_EQUALS);}
"*="                    {STORE_OPERATOR(AMP_EQUALS);}
".."                    {STORE_OPERATOR(DOT_DOT);}
".="                    {STORE_OPERATOR(DOT_EQUALS);}
"=="                    {STORE_OPERATOR(EQUALS_EQUALS);}
"=>"                    {STORE_OPERATOR(EQUALS_RIGHT);}
"=~"                    {STORE_OPERATOR(EQUALS_TILDE);}
"**"                    {STORE_OPERATOR(AST_AST);}
"**="                   {STORE_OPERATOR(AST_AST_EQUALS);}
"x="                    {STORE_OPERATOR(X_EQUALS);}

";"                     {SEMI();}
[ \t\v\f]               {;}

"("                     {NOTE_SLOC();}
")"                     {NOTE_SLOC();}
"{"                     {NOTE_SLOC();}
"}"                     {NOTE_SLOC();}

"and"                   {STORE_OPERATOR(OP_AND);}
"bless"                 {STORE_OPERATOR(BLESS);}
"caller"                {STORE_OPERATOR(CALLER);}
"cmp"                   {STORE_OPERATOR(OP_CMP);}
"continue"              {STORE_OPERATOR(CONTINUE);}
"dbmclose"              {STORE_OPERATOR(DBMCLOSE);}
"dbmopen"               {STORE_OPERATOR(DBMOPEN);}
"die"                   {STORE_OPERATOR(DIE);}
"do"                    {STORE_OPERATOR(DO);}
"dump"                  {STORE_OPERATOR(DUMP);}
"else"                  {STORE_OPERATOR(ELSE);}
"elsif"                 {STORE_OPERATOR(ELSIF);}
"eq"                    {STORE_OPERATOR(OP_EQ);}
"eval"                  {STORE_OPERATOR(EVAL);}
"exit"                  {STORE_OPERATOR(EXIT);}
"for"                   {STORE_OPERATOR(FOR);}
"foreach"               {STORE_OPERATOR(FOREACH);}
"ge"                    {STORE_OPERATOR(OP_GE);}
"goto"                  {STORE_OPERATOR(GOTO);}
"gt"                    {STORE_OPERATOR(OP_GT);}
"if"                    {STORE_OPERATOR(IF);}
"import"                {STORE_OPERATOR(IMPORT);}
"last"                  {STORE_OPERATOR(LAST);}
"le"                    {STORE_OPERATOR(OP_LE);}
"local"                 {STORE_OPERATOR(LOCAL);}
"lt"                    {STORE_OPERATOR(OP_LT);}
"my"                    {STORE_OPERATOR(MY);}
"ne"                    {STORE_OPERATOR(OP_NE);}
"next"                  {STORE_OPERATOR(NEXT);}
"no"                    {STORE_OPERATOR(NO);}
"not"                   {STORE_OPERATOR(OP_NOT);}
"or"                    {STORE_OPERATOR(OP_OR);}
"our"                   {STORE_OPERATOR(OUR);}
"package"               {STORE_OPERATOR(PACKAGE);}
"redo"                  {STORE_OPERATOR(REDO);}
"ref"                   {STORE_OPERATOR(REF);}
"require"               {STORE_OPERATOR(REQUIRE);}
"return"                {STORE_OPERATOR(RETURN);}
"sub"                   {STORE_OPERATOR(SUB);}
"tie"                   {STORE_OPERATOR(TIE);}
"tied"                  {STORE_OPERATOR(TIED);}
"unary"                 {STORE_OPERATOR(OP_UNARY);}
"unless"                {STORE_OPERATOR(UNLESS);}
"untie"                 {STORE_OPERATOR(UNTIE);}
"until"                 {STORE_OPERATOR(UNTIL);}
"use"                   {STORE_OPERATOR(USE);}
"wantarray"             {STORE_OPERATOR(WANTARRAY);}
"x"                     {STORE_OPERATOR(OP_X);}
"xor"                   {STORE_OPERATOR(OP_XOR);}

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

"#"{NOTNL}*{NL}         {++cpp_comments;++com_loc;++perl_lineno;BEGIN(INITIAL);}

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
  prev_com_line=-1;
  perl_lineno=nsemi=noperators=0;

  sloc.clear();
  operators.clear();
  operands.clear();
}
