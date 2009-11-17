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
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

%{

#include <stdio.h>
#include <string.h>
#include "y.rb.h"

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

int ruby_lineno=0;
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

#define COUNT() sloc.insert(ruby_lineno)

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

^"=begin"               {com_loc++; c_comments++; BEGIN RBDOC;}
<RBDOC>^"=end"          {BEGIN 0;}
<RBDOC>\n               {com_loc++;ruby_lineno++;}
<RBDOC>.                {;}

\n                      {ruby_lineno++;}

"("                     {COUNT();}
")"                     {COUNT();}
"{"                     {COUNT();}
"}"                     {COUNT();}
"["                     {COUNT();}
"]"                     {COUNT();}

\".*\\\"*\"             |
\".*\"                  {store_operand(_strdup(yytext));COUNT();}
"'"."'"                 {store_operand(_strdup(yytext));COUNT();}

"-"                     {store_operator(SYM_MINUS);}
"%"                     {store_operator(SYM_PCT);}
"&"                     {store_operator(SYM_AND);}
"^"                     {store_operator(SYM_CARAT);}
"~"                     {store_operator(SYM_TILDE);}
"+"                     {store_operator(SYM_PLUS);}
"="                     {store_operator(SYM_EQ);}
"!"                     {store_operator(SYM_NOT);}
"*"                     {store_operator(SYM_AST);}
"/"                     {store_operator(SYM_DIV);}
"|"                     {store_operator(SYM_OR);}
"<"                     {store_operator(SYM_LT);}
">"                     {store_operator(SYM_GT);}

"!~"                    {store_operator(SYM_NOTTILDE);}
"%="                    {store_operator(SYM_PCTEQ);}
"&&"                    {store_operator(SYM_ORAND);}
"&="                    {store_operator(SYM_AMPEQ);}
"**"                    {store_operator(SYM_ASTAST);}
"*="                    {store_operator(SYM_ASTEQ);}
"/="                    {store_operator(SYM_DIVEQ);}
"::"                    {store_operator(SYM_SCOPE);}
"^="                    {store_operator(SYM_TILDEEQ);}
"||"                    {store_operator(SYM_LOGOR);}
"|="                    {store_operator(SYM_OREQ);}
"+="                    {store_operator(SYM_PLUSEQ);}
"<="                    {store_operator(SYM_LTEQ);}
"-="                    {store_operator(SYM_MINUSEQ);}
">>"                    {store_operator(SYM_GTGT);}
".."                    {store_operator(SYM_DOTDOT);}
"!="                    {store_operator(SYM_NOTEQ);}
"<<"                    {store_operator(SYM_LTLT);}
"=~"                    {store_operator(SYM_EQTILDE);}
"=="                    {store_operator(SYM_EQEQ);}
">="                    {store_operator(SYM_GTEQ);}

"&&="                   {store_operator(SYM_LOGANDEQ);}
"**="                   {store_operator(SYM_ASTASTEQ);}
"||="                   {store_operator(SYM_LOGOREQ);}
"<<="                   {store_operator(SYM_LTLTEQ);}
">>="                   {store_operator(SYM_GTGTEQ);}
"<=>"                   {store_operator(SYM_LTEQGT);}
"==="                   {store_operator(SYM_EQEQEQ);}
"..."                   {store_operator(SYM_ELLIPSIS);}

[ \t\v\f]               {;}

"alias"                 {store_operator(KEY_ALIAS);}
"and"                   {store_operator(KEY_AND);}
"begin"                 {store_operator(KEY_BEGIN);}
"break"                 {store_operator(KEY_BREAK);}
"case"                  {store_operator(KEY_CASE);}
"class"                 {store_operator(KEY_CLASS);}
"def"                   {store_operator(KEY_DEF);}
"defined"               {store_operator(KEY_DEFINED);}
"do"                    {store_operator(KEY_DO);}
"else"                  {store_operator(KEY_ELSE);}
"elsif"                 {store_operator(KEY_ELSIF);}
"end"                   {store_operator(KEY_END);}
"ensure"                {store_operator(KEY_ENSURE);}
"false"                 {store_operator(KEY_FALSE);}
"for"                   {store_operator(KEY_FOR);}
"high"                  {store_operator(KEY_HIGH);}
"if"                    {store_operator(KEY_IF);}
"in"                    {store_operator(KEY_IN);}
"low"                   {store_operator(KEY_LOW);}
"module"                {store_operator(KEY_MODULE);}
"next"                  {store_operator(KEY_NEXT);}
"nil"                   {store_operator(KEY_NIL);}
"not"                   {store_operator(KEY_NOT);}
"or"                    {store_operator(KEY_OR);}
"redo"                  {store_operator(KEY_REDO);}
"rescue"                {store_operator(KEY_RESCUE);}
"retry"                 {store_operator(KEY_RETRY);}
"return"                {store_operator(KEY_RETURN);}
"self"                  {store_operator(KEY_SELF);}
"super"                 {store_operator(KEY_SUPER);}
"then"                  {store_operator(KEY_THEN);}
"true"                  {store_operator(KEY_TRUE);}
"undef"                 {store_operator(KEY_UNDEF);}
"unless"                {store_operator(KEY_UNLESS);}
"until"                 {store_operator(KEY_UNTIL);}
"when"                  {store_operator(KEY_WHEN);}
"while"                 {store_operator(KEY_WHILE);}
"yield"                 {store_operator(KEY_YIELD);}

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
