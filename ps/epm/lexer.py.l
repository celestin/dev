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
 * CAM  01-Oct-2010  10648 : Converted from string operands to PowerHashed.
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

%{
#include <stdio.h>
#include <string.h>
#include "y.py.h"
#include "PowerHash.h"

int yylex() ;

#include <io.h>
#include <set>
using namespace std;

set<int> sloc;
set<int> operators;
set<unsigned int> operands;

int j_comments=0;
int c_comments=0;
int cpp_comments=0;
int com_loc=0;
int prev_com_line=-1;
int py_lineno=0;

int nsemi=0 ;           // Number of semi-colons
int noperators=0 ;      // Total number of operators
int noperands=0;        // Total number of operands

#define NOTE_SLOC()       sloc.insert(py_lineno)
#define STORE_OPERATOR(X) operators.insert(X); noperators++; NOTE_SLOC();
#define STORE_OPERAND(X)  operands.insert(PowerHash(X)); noperands++; NOTE_SLOC();
#define SEMI()            nsemi++; NOTE_SLOC();

void lexclear();

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

"+"                     {STORE_OPERATOR(OP_PLUS);}
"-"                     {STORE_OPERATOR(OP_MINUS);}
"*"                     {STORE_OPERATOR(OP_MULTIPLY);}
"/"                     {STORE_OPERATOR(OP_DIVIDE);}
"//"                    {STORE_OPERATOR(OP_TRUNCDIVIDE);}
"**"                    {STORE_OPERATOR(OP_EXPONENT);}
"%"                     {STORE_OPERATOR(OP_MOD);}
"<<"                    {STORE_OPERATOR(OP_SHIFTLT);}
">>"                    {STORE_OPERATOR(OP_SHIFTRT);}
"&"                     {STORE_OPERATOR(OP_LOGAND);}
"|"                     {STORE_OPERATOR(OP_LOGOR);}
"^"                     {STORE_OPERATOR(OP_BITXOR);}
"~"                     {STORE_OPERATOR(OP_BITNEG);}
"<"                     {STORE_OPERATOR(OP_LT);}
">"                     {STORE_OPERATOR(OP_GT);}
"=="                    {STORE_OPERATOR(OP_EQUALS);}
"!="                    {STORE_OPERATOR(OP_NOTEQUALS);}
">="                    {STORE_OPERATOR(OP_GTEQUALS);}
"<="                    {STORE_OPERATOR(OP_LTEQUALS);}
"="                     {STORE_OPERATOR(OP_ASSIGN);}
"+="                    {STORE_OPERATOR(OP_ASSIGNPLUS);}
"-="                    {STORE_OPERATOR(OP_ASSIGNMINUS);}
"*="                    {STORE_OPERATOR(OP_ASSIGNMULTIPLY);}
"/="                    {STORE_OPERATOR(OP_ASSIGNDIVIDE);}
"//="                   {STORE_OPERATOR(OP_ASSIGNTRUNCDIVIDE);}
"**="                   {STORE_OPERATOR(OP_ASSIGNEXPONENT);}
"%="                    {STORE_OPERATOR(OP_ASSIGNMOD);}
">>="                   {STORE_OPERATOR(OP_ASSIGNSHIFTLT);}
"<<="                   {STORE_OPERATOR(OP_ASSIGNSHIFTRT);}

"("                     {NOTE_SLOC();}
")"                     {NOTE_SLOC();}
"["                     {NOTE_SLOC();}
"]"                     {NOTE_SLOC();}
"{"                     {NOTE_SLOC();}
"}"                     {NOTE_SLOC();}
","                     {NOTE_SLOC();}
"."                     {NOTE_SLOC();}
":"                     {NOTE_SLOC();}
";"                     {NOTE_SLOC();}
"@"                     {NOTE_SLOC();}

"and"                   {STORE_OPERATOR(KEY_AND);}
"as"                    {STORE_OPERATOR(KEY_AS);}
"assert"                {STORE_OPERATOR(KEY_ASSERT);}
"break"                 {STORE_OPERATOR(KEY_BREAK);}
"class"                 {STORE_OPERATOR(KEY_CLASS);}
"continue"              {STORE_OPERATOR(KEY_CONTINUE);}
"def"                   {STORE_OPERATOR(KEY_DEF);}
"del"                   {STORE_OPERATOR(KEY_DEL);}
"elif"                  {STORE_OPERATOR(KEY_ELIF);}
"else"                  {STORE_OPERATOR(KEY_ELSE);}
"except"                {STORE_OPERATOR(KEY_EXCEPT);}
"exec"                  {STORE_OPERATOR(KEY_EXEC);}
"finally"               {STORE_OPERATOR(KEY_FINALLY);}
"for"                   {STORE_OPERATOR(KEY_FOR);}
"from"                  {STORE_OPERATOR(KEY_FROM);}
"global"                {STORE_OPERATOR(KEY_GLOBAL);}
"if"                    {STORE_OPERATOR(KEY_IF);}
"import"                {STORE_OPERATOR(KEY_IMPORT);}
"in"                    {STORE_OPERATOR(KEY_IN);}
"is"                    {STORE_OPERATOR(KEY_IS);}
"lambda"                {STORE_OPERATOR(KEY_LAMBDA);}
"not"                   {STORE_OPERATOR(KEY_NOT);}
"or"                    {STORE_OPERATOR(KEY_OR);}
"pass"                  {STORE_OPERATOR(KEY_PASS);}
"print"                 {STORE_OPERATOR(KEY_PRINT);}
"raise"                 {STORE_OPERATOR(KEY_RAISE);}
"return"                {STORE_OPERATOR(KEY_RETURN);}
"try"                   {STORE_OPERATOR(KEY_TRY);}
"while"                 {STORE_OPERATOR(KEY_WHILE);}
"with"                  {STORE_OPERATOR(KEY_WITH);}
"yield"                 {STORE_OPERATOR(KEY_YIELD);}

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
"."{DIGITS}[eE]{SIGN}?                                      {STORE_OPERAND(yytext);}

"#"{NOTNL}*{NL}        {++cpp_comments;++com_loc;++py_lineno;}

[ \t\v\f]               { /* ignore whitespace     */ }
.                       { /* ignore bad characters */ }

%%

int yywrap() {
  return(1) ;
}

void lexclear() {
  noperands=0;
  j_comments=c_comments=cpp_comments=com_loc=0;
  prev_com_line=-1;
  py_lineno=nsemi=noperators=0;

  sloc.clear();
  operators.clear();
  operands.clear();
}
