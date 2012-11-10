/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 * Essential Project Manager (EPM)
 * Copyright (c) 2009 PowerSoftware.com
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * Ruby parser
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  20-Aug-2009  10452 : File created.
 * CAM  22-Sep-2010  10648 : Converted from string operands to PowerHashed.
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

%{

#include <stdio.h>
#include <string.h>
#include "y.rb.h"
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

int ruby_lineno=0;
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

#define NOTE_SLOC()       sloc.insert(ruby_lineno)
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

^"=begin"               {com_loc++; c_comments++; BEGIN RBDOC;}
<RBDOC>^"=end"          {BEGIN 0;}
<RBDOC>\n               {com_loc++;ruby_lineno++;}
<RBDOC>.                {;}

\n                      {ruby_lineno++;}

"("                     {NOTE_SLOC();}
")"                     {NOTE_SLOC();}
"{"                     {NOTE_SLOC();}
"}"                     {NOTE_SLOC();}
"["                     {NOTE_SLOC();}
"]"                     {NOTE_SLOC();}

\".*\\\"*\"             |
\".*\"                  {STORE_OPERAND(yytext);}
"'"."'"                 {STORE_OPERAND(yytext);}

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

"!~"                    {STORE_OPERATOR(SYM_NOTTILDE);}
"%="                    {STORE_OPERATOR(SYM_PCTEQ);}
"&&"                    {STORE_OPERATOR(SYM_ORAND);}
"&="                    {STORE_OPERATOR(SYM_AMPEQ);}
"**"                    {STORE_OPERATOR(SYM_ASTAST);}
"*="                    {STORE_OPERATOR(SYM_ASTEQ);}
"/="                    {STORE_OPERATOR(SYM_DIVEQ);}
"::"                    {STORE_OPERATOR(SYM_SCOPE);}
"^="                    {STORE_OPERATOR(SYM_TILDEEQ);}
"||"                    {STORE_OPERATOR(SYM_LOGOR);}
"|="                    {STORE_OPERATOR(SYM_OREQ);}
"+="                    {STORE_OPERATOR(SYM_PLUSEQ);}
"<="                    {STORE_OPERATOR(SYM_LTEQ);}
"-="                    {STORE_OPERATOR(SYM_MINUSEQ);}
">>"                    {STORE_OPERATOR(SYM_GTGT);}
".."                    {STORE_OPERATOR(SYM_DOTDOT);}
"!="                    {STORE_OPERATOR(SYM_NOTEQ);}
"<<"                    {STORE_OPERATOR(SYM_LTLT);}
"=~"                    {STORE_OPERATOR(SYM_EQTILDE);}
"=="                    {STORE_OPERATOR(SYM_EQEQ);}
">="                    {STORE_OPERATOR(SYM_GTEQ);}

"&&="                   {STORE_OPERATOR(SYM_LOGANDEQ);}
"**="                   {STORE_OPERATOR(SYM_ASTASTEQ);}
"||="                   {STORE_OPERATOR(SYM_LOGOREQ);}
"<<="                   {STORE_OPERATOR(SYM_LTLTEQ);}
">>="                   {STORE_OPERATOR(SYM_GTGTEQ);}
"<=>"                   {STORE_OPERATOR(SYM_LTEQGT);}
"==="                   {STORE_OPERATOR(SYM_EQEQEQ);}
"..."                   {STORE_OPERATOR(SYM_ELLIPSIS);}

[ \t\v\f]               {;}

"alias"                 {STORE_OPERATOR(KEY_ALIAS);}
"and"                   {STORE_OPERATOR(KEY_AND);}
"begin"                 {STORE_OPERATOR(KEY_BEGIN);}
"break"                 {STORE_OPERATOR(KEY_BREAK);}
"case"                  {STORE_OPERATOR(KEY_CASE);}
"class"                 {STORE_OPERATOR(KEY_CLASS);}
"def"                   {STORE_OPERATOR(KEY_DEF);}
"defined"               {STORE_OPERATOR(KEY_DEFINED);}
"do"                    {STORE_OPERATOR(KEY_DO);}
"else"                  {STORE_OPERATOR(KEY_ELSE);}
"elsif"                 {STORE_OPERATOR(KEY_ELSIF);}
"end"                   {STORE_OPERATOR(KEY_END);}
"ensure"                {STORE_OPERATOR(KEY_ENSURE);}
"false"                 {STORE_OPERATOR(KEY_FALSE);}
"for"                   {STORE_OPERATOR(KEY_FOR);}
"high"                  {STORE_OPERATOR(KEY_HIGH);}
"if"                    {STORE_OPERATOR(KEY_IF);}
"in"                    {STORE_OPERATOR(KEY_IN);}
"low"                   {STORE_OPERATOR(KEY_LOW);}
"module"                {STORE_OPERATOR(KEY_MODULE);}
"next"                  {STORE_OPERATOR(KEY_NEXT);}
"nil"                   {STORE_OPERATOR(KEY_NIL);}
"not"                   {STORE_OPERATOR(KEY_NOT);}
"or"                    {STORE_OPERATOR(KEY_OR);}
"redo"                  {STORE_OPERATOR(KEY_REDO);}
"rescue"                {STORE_OPERATOR(KEY_RESCUE);}
"retry"                 {STORE_OPERATOR(KEY_RETRY);}
"return"                {STORE_OPERATOR(KEY_RETURN);}
"self"                  {STORE_OPERATOR(KEY_SELF);}
"super"                 {STORE_OPERATOR(KEY_SUPER);}
"then"                  {STORE_OPERATOR(KEY_THEN);}
"true"                  {STORE_OPERATOR(KEY_TRUE);}
"undef"                 {STORE_OPERATOR(KEY_UNDEF);}
"unless"                {STORE_OPERATOR(KEY_UNLESS);}
"until"                 {STORE_OPERATOR(KEY_UNTIL);}
"when"                  {STORE_OPERATOR(KEY_WHEN);}
"while"                 {STORE_OPERATOR(KEY_WHILE);}
"yield"                 {STORE_OPERATOR(KEY_YIELD);}

{LETTER}{ALNUM}*            {STORE_OPERAND(yytext);}

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

"#"{NOTNL}*{NL}         {cpp_comments++;com_loc++;ruby_lineno++;BEGIN(INITIAL);}

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
  ruby_lineno=nsemi=noperators=0;

  sloc.clear();
  operators.clear();
  operands.clear();
}
