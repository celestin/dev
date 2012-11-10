/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 * Essential Project Manager (EPM)
 * Copyright (c) 2009 PowerSoftware.com
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * JavaScript parser
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  14-Apr-2009  10400 : File created.
 * CAM  22-Sep-2010  10648 : Converted from string operands to PowerHashed.
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

%{
#include <stdio.h>
#include <string.h>
#include "y.jt.h"
#include "PowerHash.h"

int yylex();

#ifdef WIN32
  #include <io.h>
  #include <set>
  using namespace std;
#else
  #include <stl.h>
  #include <unistd.h>
#endif

int jt_lineno=0;
int j_comments=0;
int c_comments=0;
int cpp_comments=0;
int com_loc=0;
int prev_com_line=-1;

set<int> sloc;
set<int> operators;
set<unsigned int> operands;

int nsemi=0;           // Number of semi-colons
int noperators=0;      // Total number of operators
int noperands=0;       // Total number of operands

#define NOTE_SLOC()       sloc.insert(jt_lineno)

#define STORE_OPERATOR(X) operators.insert(X); noperators++; NOTE_SLOC();
#define STORE_OPERAND(X)  operands.insert(PowerHash(X)); noperands++; NOTE_SLOC();
#define SEMI()            nsemi++; NOTE_SLOC();

void lexclear();

%}


%x JCOM CCOM

NL                                      "\n"
NOTNL                                   .
ANY                                     ({NOTNL}|{NL})
BACKSL                                  "\\"
BOL                                     ^
LETTER                                  [A-Za-z_]
ALNUM                                   [A-Za-z_0-9]
DIGIT                                   [0-9]
HEXDIGIT                                [0-9A-Fa-f]
DIGITS                                  ({DIGIT}+)
EXP                                     [Ee][+-]?DIGITS
HEXDIGITS                               ({HEXDIGIT}+)
SIGN                                    ("+"|"-")
ELL_SUFFIX                              [lL]([lL]?)
INT_SUFFIX                              ([uU]{ELL_SUFFIX}?|{ELL_SUFFIX}[uU]?)
FLOAT_SUFFIX                            [flFL]
STRCHAR                                 [^\"\n\\]
ESCAPE                                  ({BACKSL}{ANY})
QUOTE                                   [\"]
SPTAB                                   [ \t]

%%

"/**"                                   {com_loc++; j_comments++; BEGIN JCOM;}
<JCOM>"*/"                              {BEGIN 0;}
<JCOM>\n                                {com_loc++; jt_lineno++;}
<JCOM>.                                 {;}

"/*"                                    {com_loc++; c_comments++; BEGIN CCOM;}
<CCOM>"*/"                              {BEGIN 0;}
<CCOM>\n                                {com_loc++; jt_lineno++;}
<CCOM>.                                 {;}

\n                                      {jt_lineno++;}

"="                                     {STORE_OPERATOR(SYM_ASSIGN);}
">"                                     {STORE_OPERATOR(SYM_GT);}
"<"                                     {STORE_OPERATOR(SYM_LT);}
"!"                                     {STORE_OPERATOR(SYM_NOT);}
"~"                                     {STORE_OPERATOR(SYM_TILDE);}
"?"                                     {STORE_OPERATOR(SYM_QUESTION);}
":"                                     {STORE_OPERATOR(SYM_COLON);}
"+"                                     {STORE_OPERATOR(SYM_PLUS);}
"-"                                     {STORE_OPERATOR(SYM_MINUS);}
"*"                                     {STORE_OPERATOR(SYM_ASTERISK);}
"/"                                     {STORE_OPERATOR(SYM_SLASH);}
"&"                                     {STORE_OPERATOR(SYM_BITAND);}
"|"                                     {STORE_OPERATOR(SYM_BITOR);}
"^"                                     {STORE_OPERATOR(SYM_EXPONENT);}
"%"                                     {STORE_OPERATOR(SYM_PERCENT);}
"("                                     {STORE_OPERATOR(SYM_PARENO);}
")"                                     {STORE_OPERATOR(SYM_PARENC);}
"{"                                     {STORE_OPERATOR(SYM_BRACEO);}
"}"                                     {STORE_OPERATOR(SYM_BRACEC);}
"["                                     {STORE_OPERATOR(SYM_BRACKETO);}
"]"                                     {STORE_OPERATOR(SYM_BRACKETC);}
";"                                     {SEMI();}
","                                     {STORE_OPERATOR(SYM_COMMA);}
"."                                     {STORE_OPERATOR(SYM_PERIOD);}

"=="                                    {STORE_OPERATOR(SYM_EQUALS);}
"<="                                    {STORE_OPERATOR(SYM_LTEQUAL);}
">="                                    {STORE_OPERATOR(SYM_GTEQUAL);}
"!="                                    {STORE_OPERATOR(SYM_NOTEQUAL);}
"&&"                                    {STORE_OPERATOR(SYM_LOGAND);}
"||"                                    {STORE_OPERATOR(SYM_LOGOR);}
"++"                                    {STORE_OPERATOR(SYM_INCREMENT);}
"--"                                    {STORE_OPERATOR(SYM_DECREMENT);}
"<<"                                    {STORE_OPERATOR(SYM_SHIFTLT);}
">>"                                    {STORE_OPERATOR(SYM_SHIFTRT);}
">>>"                                   {STORE_OPERATOR(SYM_SHIFTRTUNS);}
"+="                                    {STORE_OPERATOR(SYM_ASSIGNPLUS);}
"-="                                    {STORE_OPERATOR(SYM_ASSIGNMINUS);}
"*="                                    {STORE_OPERATOR(SYM_ASSIGNMULTIPLY);}
"/="                                    {STORE_OPERATOR(SYM_ASSIGNDIVIDE);}
"&="                                    {STORE_OPERATOR(SYM_ASSIGNBITAND);}
"|="                                    {STORE_OPERATOR(SYM_ASSIGNBITOR);}
"^="                                    {STORE_OPERATOR(SYM_ASSIGNEXPONENT);}
"%="                                    {STORE_OPERATOR(SYM_ASSIGNMOD);}
"<<="                                   {STORE_OPERATOR(SYM_ASSIGNSHIFTLT);}
">>="                                   {STORE_OPERATOR(SYM_ASSIGNSHIFTRT);}
">>>="                                  {STORE_OPERATOR(SYM_ASSIGNSHIFTRTUNS);}

"abstract"                              {STORE_OPERATOR(KEY_ABSTRACT);}
"boolean"                               {STORE_OPERATOR(KEY_BOOLEAN);}
"break"                                 {STORE_OPERATOR(KEY_BREAK);}
"byte"                                  {STORE_OPERATOR(KEY_BYTE);}
"case"                                  {STORE_OPERATOR(KEY_CASE);}
"catch"                                 {STORE_OPERATOR(KEY_CATCH);}
"char"                                  {STORE_OPERATOR(KEY_CHAR);}
"class"                                 {STORE_OPERATOR(KEY_CLASS);}
"const"                                 {STORE_OPERATOR(KEY_CONST);}
"continue"                              {STORE_OPERATOR(KEY_CONTINUE);}
"default"                               {STORE_OPERATOR(KEY_DEFAULT);}
"delete"                                {STORE_OPERATOR(KEY_DELETE);}
"do"                                    {STORE_OPERATOR(KEY_DO);}
"double"                                {STORE_OPERATOR(KEY_DOUBLE);}
"else"                                  {STORE_OPERATOR(KEY_ELSE);}
"extends"                               {STORE_OPERATOR(KEY_EXTENDS);}
"final"                                 {STORE_OPERATOR(KEY_FINAL);}
"finally"                               {STORE_OPERATOR(KEY_FINALLY);}
"float"                                 {STORE_OPERATOR(KEY_FLOAT);}
"for"                                   {STORE_OPERATOR(KEY_FOR);}
"function"                              {STORE_OPERATOR(KEY_FUNCTION);}
"goto"                                  {STORE_OPERATOR(KEY_GOTO);}
"if"                                    {STORE_OPERATOR(KEY_IF);}
"implements"                            {STORE_OPERATOR(KEY_IMPLEMENTS);}
"import"                                {STORE_OPERATOR(KEY_IMPORT);}
"in"                                    {STORE_OPERATOR(KEY_IN);}
"instanceof"                            {STORE_OPERATOR(KEY_INSTANCEOF);}
"int"                                   {STORE_OPERATOR(KEY_INT );}
"interface"                             {STORE_OPERATOR(KEY_INTERFACE);}
"long"                                  {STORE_OPERATOR(KEY_LONG);}
"native"                                {STORE_OPERATOR(KEY_NATIVE);}
"new"                                   {STORE_OPERATOR(KEY_NEW);}
"package"                               {STORE_OPERATOR(KEY_PACKAGE);}
"private"                               {STORE_OPERATOR(KEY_PRIVATE);}
"protected"                             {STORE_OPERATOR(KEY_PROTECTED);}
"public"                                {STORE_OPERATOR(KEY_PUBLIC);}
"return"                                {STORE_OPERATOR(KEY_RETURN);}
"short"                                 {STORE_OPERATOR(KEY_SHORT);}
"static"                                {STORE_OPERATOR(KEY_STATIC);}
"super"                                 {STORE_OPERATOR(KEY_SUPER);}
"switch"                                {STORE_OPERATOR(KEY_SWITCH);}
"synchronized"                          {STORE_OPERATOR(KEY_SYNCHRONIZED);}
"this"                                  {STORE_OPERATOR(KEY_THIS);}
"throw"                                 {STORE_OPERATOR(KEY_THROW);}
"throws"                                {STORE_OPERATOR(KEY_THROWS);}
"transient"                             {STORE_OPERATOR(KEY_TRANSIENT);}
"try"                                   {STORE_OPERATOR(KEY_TRY);}
"typeof"                                {STORE_OPERATOR(KEY_TYPEOF);}
"var"                                   {STORE_OPERATOR(KEY_VAR);}
"void"                                  {STORE_OPERATOR(KEY_VOID);}
"volatile"                              {STORE_OPERATOR(KEY_VOLATILE);}
"while"                                 {STORE_OPERATOR(KEY_WHILE);}
"with"                                  {STORE_OPERATOR(KEY_WITH);}

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

"//"{NOTNL}*{NL}                        {++cpp_comments;++com_loc;++jt_lineno;}

[ \t\v\f]                               { /* ignore whitespace     */ }
.                                       { /* ignore bad characters */ }

%%

int yywrap() {
        return(1);
}

void lexclear() {
  BEGIN 0;
  noperands=0;
  j_comments=c_comments=cpp_comments=com_loc=0;
  prev_com_line=-1;
  jt_lineno=nsemi=noperators=0;

  sloc.clear();
  operators.clear();
  operands.clear();
}
