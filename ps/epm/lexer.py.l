/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 * Essential Project Manager (EPM)
 * Copyright (c) 2009 PowerSoftware.com
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * Python Lexer
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  14-Apr-2009  10403 : File created.
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

%{
#include <stdio.h>
#include <string.h>
#include "y.py.h"

int yylex() ;

#include <io.h>
#include <list>
#include <set>
#include <vector>
using namespace std;

set<int> sloc;
set<int> operators;
vector<char*> operands[255];

int j_comments=0;
int c_comments=0;
int cpp_comments=0;
int com_loc=0;
int prev_com_line=-1;
int py_lineno=0;

int nsemi=0 ;           // Number of semi-colons
int noperators=0 ;      // Total number of operators
int noperands=0;        // Total number of operands

#define STORE_OPERATOR(X) operators.insert(X); noperators++;
#define SEMI() nsemi++;
#define COUNT() sloc.insert(py_lineno)

void lexclear() {
  noperands=0;
  j_comments=c_comments=cpp_comments=com_loc=0;
  prev_com_line=-1;
  py_lineno=nsemi=noperators=0;

  sloc.clear();
  operators.clear();

  for (int i=0; i<255; i++) {
    if (operands[i].size() > 0) operands[i].clear();
  }
}

void store_operand(char* txt) {
  char c;
  unsigned int i;

  noperands++;
  c=txt[0];
  for (i=0;i<operands[c].size();i++) {
    if (!strcmp(txt,operands[c][i])) return;
  }
  operands[c].push_back(txt);
}

%}

%x JCOM CCOM

NL                      "\n"
NOTNL                   .
ANY                     ({NOTNL}|{NL})
BACKSL                  "\\"
BOL                     ^
LETTER                  [A-Za-z_]
ALNUM                   [A-Za-z_0-9]
DIGIT                   [0-9]
HEXDIGIT                [0-9A-Fa-f]
DIGITS                  ({DIGIT}+)
EXP                     [Ee][+-]?DIGITS
HEXDIGITS               ({HEXDIGIT}+)
SIGN                    ("+"|"-")
ELL_SUFFIX              [lL]([lL]?)
INT_SUFFIX              ([uU]{ELL_SUFFIX}?|{ELL_SUFFIX}[uU]?)
FLOAT_SUFFIX            [flFL]
STRCHAR                 [^\"\n\\]
ESCAPE                  ({BACKSL}{ANY})
QUOTE                   [\"]
SPTAB                   [ \t]

%%

\n                      {py_lineno++;}

"+"                     {STORE_OPERATOR(OP_PLUS);COUNT();}
"-"                     {STORE_OPERATOR(OP_MINUS);COUNT();}
"*"                     {STORE_OPERATOR(OP_MULTIPLY);COUNT();}
"/"                     {STORE_OPERATOR(OP_DIVIDE);COUNT();}
"//"                    {STORE_OPERATOR(OP_TRUNCDIVIDE);COUNT();}
"**"                    {STORE_OPERATOR(OP_EXPONENT);COUNT();}
"%"                     {STORE_OPERATOR(OP_MOD);COUNT();}
"<<"                    {STORE_OPERATOR(OP_SHIFTLT);COUNT();}
">>"                    {STORE_OPERATOR(OP_SHIFTRT);COUNT();}
"&"                     {STORE_OPERATOR(OP_LOGAND);COUNT();}
"|"                     {STORE_OPERATOR(OP_LOGOR);COUNT();}
"^"                     {STORE_OPERATOR(OP_BITXOR);COUNT();}
"~"                     {STORE_OPERATOR(OP_BITNEG);COUNT();}
"<"                     {STORE_OPERATOR(OP_LT);COUNT();}
">"                     {STORE_OPERATOR(OP_GT);COUNT();}
"=="                    {STORE_OPERATOR(OP_EQUALS);COUNT();}
"!="                    {STORE_OPERATOR(OP_NOTEQUALS);COUNT();}
">="                    {STORE_OPERATOR(OP_GTEQUALS);COUNT();}
"<="                    {STORE_OPERATOR(OP_LTEQUALS);COUNT();}
"="                     {STORE_OPERATOR(OP_ASSIGN);COUNT();}
"+="                    {STORE_OPERATOR(OP_ASSIGNPLUS);COUNT();}
"-="                    {STORE_OPERATOR(OP_ASSIGNMINUS);COUNT();}
"*="                    {STORE_OPERATOR(OP_ASSIGNMULTIPLY);COUNT();}
"/="                    {STORE_OPERATOR(OP_ASSIGNDIVIDE);COUNT();}
"//="                   {STORE_OPERATOR(OP_ASSIGNTRUNCDIVIDE);COUNT();}
"**="                   {STORE_OPERATOR(OP_ASSIGNEXPONENT);COUNT();}
"%="                    {STORE_OPERATOR(OP_ASSIGNMOD);COUNT();}
">>="                   {STORE_OPERATOR(OP_ASSIGNSHIFTLT);COUNT();}
"<<="                   {STORE_OPERATOR(OP_ASSIGNSHIFTRT);COUNT();}

"("                     {COUNT();}
")"                     {COUNT();}
"["                     {COUNT();}
"]"                     {COUNT();}
"{"                     {COUNT();}
"}"                     {COUNT();}
","                     {COUNT();}
"."                     {COUNT();}
":"                     {COUNT();}
";"                     {COUNT();}
"@"                     {COUNT();}

"and"                   {STORE_OPERATOR(KEY_AND);COUNT();}
"as"                    {STORE_OPERATOR(KEY_AS);COUNT();}
"assert"                {STORE_OPERATOR(KEY_ASSERT);COUNT();}
"break"                 {STORE_OPERATOR(KEY_BREAK);COUNT();}
"class"                 {STORE_OPERATOR(KEY_CLASS);COUNT();}
"continue"              {STORE_OPERATOR(KEY_CONTINUE);COUNT();}
"def"                   {STORE_OPERATOR(KEY_DEF);COUNT();}
"del"                   {STORE_OPERATOR(KEY_DEL);COUNT();}
"elif"                  {STORE_OPERATOR(KEY_ELIF);COUNT();}
"else"                  {STORE_OPERATOR(KEY_ELSE);COUNT();}
"except"                {STORE_OPERATOR(KEY_EXCEPT);COUNT();}
"exec"                  {STORE_OPERATOR(KEY_EXEC);COUNT();}
"finally"               {STORE_OPERATOR(KEY_FINALLY);COUNT();}
"for"                   {STORE_OPERATOR(KEY_FOR);COUNT();}
"from"                  {STORE_OPERATOR(KEY_FROM);COUNT();}
"global"                {STORE_OPERATOR(KEY_GLOBAL);COUNT();}
"if"                    {STORE_OPERATOR(KEY_IF);COUNT();}
"import"                {STORE_OPERATOR(KEY_IMPORT);COUNT();}
"in"                    {STORE_OPERATOR(KEY_IN);COUNT();}
"is"                    {STORE_OPERATOR(KEY_IS);COUNT();}
"lambda"                {STORE_OPERATOR(KEY_LAMBDA);COUNT();}
"not"                   {STORE_OPERATOR(KEY_NOT);COUNT();}
"or"                    {STORE_OPERATOR(KEY_OR);COUNT();}
"pass"                  {STORE_OPERATOR(KEY_PASS);COUNT();}
"print"                 {STORE_OPERATOR(KEY_PRINT);COUNT();}
"raise"                 {STORE_OPERATOR(KEY_RAISE);COUNT();}
"return"                {STORE_OPERATOR(KEY_RETURN);COUNT();}
"try"                   {STORE_OPERATOR(KEY_TRY);COUNT();}
"while"                 {STORE_OPERATOR(KEY_WHILE);COUNT();}
"with"                  {STORE_OPERATOR(KEY_WITH);COUNT();}
"yield"                 {STORE_OPERATOR(KEY_YIELD);COUNT();}

{LETTER}{ALNUM}*                                            |
[1-9][0-9]*{INT_SUFFIX}?                                    |
[0][0-7]*{INT_SUFFIX}?                                      |
[0][xX][0-9A-Fa-f]+{INT_SUFFIX}?                            |
[0][xX]                                                     |
{DIGITS}"."{DIGITS}?([eE]{SIGN}?{DIGITS})?{FLOAT_SUFFIX}?   |
{DIGITS}"."?([eE]{SIGN}?{DIGITS})?{FLOAT_SUFFIX}?           |
"."{DIGITS}([eE]{SIGN}?{DIGITS})?{FLOAT_SUFFIX}?            |
{DIGITS}"."{DIGITS}?[eE]{SIGN}?                             |
{DIGITS}"."?[eE]{SIGN}?                                     |
"."{DIGITS}[eE]{SIGN}?                                      {store_operand(_strdup(yytext));COUNT();}

"#"{NOTNL}*{NL}        {++cpp_comments;++com_loc;++py_lineno;}

[ \t\v\f]               { /* ignore whitespace     */ }
.                       { /* ignore bad characters */ }

%%

int yywrap() {
  return(1) ;
}

