/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 * Essential Project Manager (EPM)
 * Copyright (c) 2004,2009 PowerSoftware.com
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * Java parser
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  29-Apr-05    File added.
 * CAM  11-May-05    96 : Rationalised variables.
 * CAM  24-Apr-08    358 : Corrected compiler warnings moving to VS2008 (from VC++6).
 * CAM  14-Apr-2009  10424 : Removed old GS comment/string code and replaced with flex states and correct rule order.
 * CAM  22-Sep-2010  10648 : Converted from string operands to PowerHashed.
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

%{
#include <stdio.h>
#include <string.h>
#include "y.j.h"
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

int java_lineno=0;
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
int noperands=0;        // Total number of operands

#define NOTE_SLOC()       sloc.insert(java_lineno)
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
<JCOM>\n                                {com_loc++; java_lineno++;}
<JCOM>.                                 {;}

"/*"                                    {com_loc++; c_comments++; BEGIN CCOM;}
<CCOM>"*/"                              {BEGIN 0;}
<CCOM>\n                                {com_loc++; java_lineno++;}
<CCOM>.                                 {;}

\n                                      {java_lineno++;}

"="                                     {STORE_OPERATOR(ASSIGN);}
">"                                     {STORE_OPERATOR(GT);}
"<"                                     {STORE_OPERATOR(LT);}
"!"                                     {STORE_OPERATOR(NOT);}
"~"                                     {STORE_OPERATOR(BIT_NOT);}
"?"                                     {STORE_OPERATOR(QUERY);}
":"                                     {STORE_OPERATOR(COLON);}
"+"                                     {STORE_OPERATOR(PLUS);}
"-"                                     {STORE_OPERATOR(MINUS);}
"*"                                     {STORE_OPERATOR(TIMES);}
"/"                                     {STORE_OPERATOR(DIVIDE);}
"&"                                     {STORE_OPERATOR(BIT_AND);}
"|"                                     {STORE_OPERATOR(BIT_OR);}
"^"                                     {STORE_OPERATOR(CARET);}
"%"                                     {STORE_OPERATOR(MOD);}
"("                                     {NOTE_SLOC();}
")"                                     {NOTE_SLOC();}
"{"                                     {NOTE_SLOC();}
"}"                                     {NOTE_SLOC();}
"["                                     {NOTE_SLOC();}
"]"                                     {NOTE_SLOC();}
";"                                     {SEMI();}
","                                     {STORE_OPERATOR(COMMA);}
"."                                     {STORE_OPERATOR(DOT);}

"=="                                    {STORE_OPERATOR(EQUALITY);}
"<="                                    {STORE_OPERATOR(LE);}
">="                                    {STORE_OPERATOR(GE);}
"!="                                    {STORE_OPERATOR(NE);}
"&&"                                    {STORE_OPERATOR(AND);}
"||"                                    {STORE_OPERATOR(OR);}
"++"                                    {STORE_OPERATOR(PLUSPLUS);}
"--"                                    {STORE_OPERATOR(MINUSMINUS);}
"<<"                                    {STORE_OPERATOR(LEFT_SHIFT);}
">>"                                    {STORE_OPERATOR(RIGHT_SHIFT);}
">>>"                                   {STORE_OPERATOR(GTGTGT);}
"+="                                    {STORE_OPERATOR(PLUSEQUALS);}
"-="                                    {STORE_OPERATOR(MINUSEQUALS);}
"*="                                    {STORE_OPERATOR(TIMESEQUALS);}
"/="                                    {STORE_OPERATOR(DIVEQUALS);}
"&="                                    {STORE_OPERATOR(BIT_ANDEQUALS);}
"|="                                    {STORE_OPERATOR(BIT_OREQUALS);}
"^="                                    {STORE_OPERATOR(CARETEQUALS);}
"%="                                    {STORE_OPERATOR(MODEQUALS);}
"<<="                                   {STORE_OPERATOR(LEFT_SHIFTEQUALS);}
">>="                                   {STORE_OPERATOR(RIGHT_SHIFTEQUALS);}
">>>="                                  {STORE_OPERATOR(GTGTGTEQUALS);}

"abstract"                              {STORE_OPERATOR(ABSTRACT);}
"default"                               {STORE_OPERATOR(DEFAULT);}
"if"                                    {STORE_OPERATOR(IF);}
"private"                               {STORE_OPERATOR(PRIVATE);}
"throw"                                 {STORE_OPERATOR(THROW);}
"boolean"                               {STORE_OPERATOR(BOOLEAN);}
"do"                                    {STORE_OPERATOR(DO);}
"implements"                            {STORE_OPERATOR(IMPLEMENTS);}
"protected"                             {STORE_OPERATOR(PROTECTED);}
"throws"                                {STORE_OPERATOR(THROWS);}
"break"                                 {STORE_OPERATOR(BREAK);}
"double"                                {STORE_OPERATOR(DOUBLE);}
"import"                                {STORE_OPERATOR(IMPORT);}
"public"                                {STORE_OPERATOR(PUBLIC);}
"transient"                             {STORE_OPERATOR(TRANSIENT);}
"byte"                                  {STORE_OPERATOR(BYTE);}
"else"                                  {STORE_OPERATOR(ELSE);}
"instanceof"                            {STORE_OPERATOR(INSTANCEOF);}
"return"                                {STORE_OPERATOR(RETURN);}
"try"                                   {STORE_OPERATOR(TRY);}
"case"                                  {STORE_OPERATOR(CASE);}
"extends"                               {STORE_OPERATOR(EXTENDS);}
"int"                                   {STORE_OPERATOR(INT);}
"short"                                 {STORE_OPERATOR(SHORT);}
"void"                                  {STORE_OPERATOR(VOID);}
"catch"                                 {STORE_OPERATOR(CATCH);}
"final"                                 {STORE_OPERATOR(FINAL);}
"interface"                             {STORE_OPERATOR(INTERFACE);}
"static"                                {STORE_OPERATOR(STATIC);}
"volatile"                              {STORE_OPERATOR(VOLATILE);}
"char"                                  {STORE_OPERATOR(CHAR);}
"finally"                               {STORE_OPERATOR(FINALLY);}
"long"                                  {STORE_OPERATOR(LONG);}
"super"                                 {STORE_OPERATOR(SUPER);}
"while"                                 {STORE_OPERATOR(WHILE);}
"class"                                 {STORE_OPERATOR(CLASS);}
"native"                                {STORE_OPERATOR(NATIVE);}
"float"                                 {STORE_OPERATOR(FLOAT);}
"switch"                                {STORE_OPERATOR(SWITCH);}
"const"                                 {STORE_OPERATOR(CONST);}
"for"                                   {STORE_OPERATOR(FOR);}
"new"                                   {STORE_OPERATOR(NEW);}
"synchronized"                          {STORE_OPERATOR(SYNCHRONIZED);}
"continue"                              {STORE_OPERATOR(CONTINUE);}
"goto"                                  {STORE_OPERATOR(GOTO);}
"package"                               {STORE_OPERATOR(PACKAGE);}
"this"                                  {STORE_OPERATOR(THIS);}

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

"//"{NOTNL}*{NL}                        {++cpp_comments;++com_loc;++java_lineno;}

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
  java_lineno=nsemi=noperators=0;

  sloc.clear();
  operators.clear();
  operands.clear();
}
