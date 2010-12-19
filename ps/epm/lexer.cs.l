/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 * Essential Project Manager (EPM)
 * Copyright (c) 2004,2009 PowerSoftware.com
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * C# Lexer
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  19-Dec-04    File added.
 * CAM  29-Dec-04    Added lexclear.
 * CAM  25-Feb-05    Removed parsing of string literals (Copyright and other characters causing problems).
 * CAM  25-Feb-05    Put back parsing of string literals and use -8 flex option.
 * CAM  04-May-05       50 : Modified for compatibility with other parsers.
 * CAM  11-May-05       96 : Rationalised variables.
 * CAM  28-Jan-06      168 : Fixed bug where number of operators was not being reset.
 * CAM  24-Apr-08      358 : Corrected compiler warnings moving to VS2008 (from VC++6).
 * CAM  14-Apr-2009  10416 : Removed old GS comment/string code and replaced with flex states.
 * CAM  22-Sep-2010  10648 : Converted from string operands to PowerHashed.
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

%{
#include <stdio.h>
#include <string.h>
#include "y.cs.h"
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
int cs_lineno=0;

int nsemi=0 ;           // Number of semi-colons
int noperators=0 ;      // Total number of operators
int noperands=0;        // Total number of operands

#define NOTE_SLOC()       sloc.insert(cs_lineno)
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

"/**"                   {com_loc++; j_comments++; BEGIN JCOM;}
<JCOM>"*/"              {BEGIN 0;}
<JCOM>\n                {com_loc++; cs_lineno++;}
<JCOM>.                 {;}

"/*"                    {com_loc++; c_comments++; BEGIN CCOM;}
<CCOM>"*/"              {BEGIN 0;}
<CCOM>\n                {com_loc++; cs_lineno++;}
<CCOM>.                 {;}

\n                      {cs_lineno++;}

"="                     {STORE_OPERATOR(ASSIGN);}
">"                     {STORE_OPERATOR(GT);}
"<"                     {STORE_OPERATOR(LT);}
"!"                     {STORE_OPERATOR(NOT);}
"~"                     {STORE_OPERATOR(BIT_NOT);}
"?"                     {STORE_OPERATOR(QUERY);}
":"                     {STORE_OPERATOR(COLON);}
"+"                     {STORE_OPERATOR(PLUS);}
"-"                     {STORE_OPERATOR(MINUS);}
"*"                     {STORE_OPERATOR(TIMES);}
"/"                     {STORE_OPERATOR(DIVIDE);}
"&"                     {STORE_OPERATOR(BIT_AND);}
"|"                     {STORE_OPERATOR(BIT_OR);}
"^"                     {STORE_OPERATOR(CARET);}
"%"                     {STORE_OPERATOR(MOD);}
","                     {STORE_OPERATOR(COMMA);}
"."                     {STORE_OPERATOR(DOT);}

";"                     {SEMI();}
"#"                     {NOTE_SLOC();}

"("                     {NOTE_SLOC();}
")"                     {NOTE_SLOC();}
"{"                     {NOTE_SLOC();}
"}"                     {NOTE_SLOC();}
"["                     {NOTE_SLOC();}
"]"                     {NOTE_SLOC();}

"=="                    {STORE_OPERATOR(EQUALITY);}
"<="                    {STORE_OPERATOR(LE);}
">="                    {STORE_OPERATOR(GE);}
"!="                    {STORE_OPERATOR(NE);}
"&&"                    {STORE_OPERATOR(AND);}
"||"                    {STORE_OPERATOR(OR);}
"++"                    {STORE_OPERATOR(PLUSPLUS);}
"--"                    {STORE_OPERATOR(MINUSMINUS);}
"<<"                    {STORE_OPERATOR(LEFT_SHIFT);}
">>"                    {STORE_OPERATOR(RIGHT_SHIFT);}
">>>"                   {STORE_OPERATOR(GTGTGT);}
"+="                    {STORE_OPERATOR(PLUSEQUALS);}
"-="                    {STORE_OPERATOR(MINUSEQUALS);}
"*="                    {STORE_OPERATOR(TIMESEQUALS);}
"/="                    {STORE_OPERATOR(DIVEQUALS);}
"&="                    {STORE_OPERATOR(BIT_ANDEQUALS);}
"|="                    {STORE_OPERATOR(BIT_OREQUALS);}
"^="                    {STORE_OPERATOR(CARETEQUALS);}
"%="                    {STORE_OPERATOR(MODEQUALS);}
"<<="                   {STORE_OPERATOR(LEFT_SHIFTEQUALS);}
">>="                   {STORE_OPERATOR(RIGHT_SHIFTEQUALS);}
">>>="                  {STORE_OPERATOR(GTGTGTEQUALS);}

"abstract"              {STORE_OPERATOR(ABSTRACT);}
"as"                    {STORE_OPERATOR(AS);}
"base"                  {STORE_OPERATOR(BASE);}
"bool"                  {STORE_OPERATOR(BOOL);}
"break"                 {STORE_OPERATOR(BREAK);}
"byte"                  {STORE_OPERATOR(BYTE);}
"case"                  {STORE_OPERATOR(CASE);}
"catch"                 {STORE_OPERATOR(CATCH);}
"char"                  {STORE_OPERATOR(CHAR);}
"checked"               {STORE_OPERATOR(CHECKED);}
"class"                 {STORE_OPERATOR(CLASS);}
"const"                 {STORE_OPERATOR(CONST);}
"continue"              {STORE_OPERATOR(CONTINUE);}
"decimal"               {STORE_OPERATOR(DECIMAL);}
"default"               {STORE_OPERATOR(DEFAULT);}
"delegate"              {STORE_OPERATOR(DELEGATE);}
"do"                    {STORE_OPERATOR(DO);}
"double"                {STORE_OPERATOR(DOUBLE);}
"else"                  {STORE_OPERATOR(ELSE);}
"enum"                  {STORE_OPERATOR(ENUM);}
"event"                 {STORE_OPERATOR(EVENT);}
"explicit"              {STORE_OPERATOR(EXPLICIT);}
"extern"                {STORE_OPERATOR(EXTERN);}
"finally"               {STORE_OPERATOR(FINALLY);}
"fixed"                 {STORE_OPERATOR(FIXED);}
"float"                 {STORE_OPERATOR(FLOAT);}
"for"                   {STORE_OPERATOR(FOR);}
"foreach"               {STORE_OPERATOR(FOREACH);}
"goto"                  {STORE_OPERATOR(GOTO);}
"if"                    {STORE_OPERATOR(IF);}
"implicit"              {STORE_OPERATOR(IMPLICIT);}
"in"                    {STORE_OPERATOR(IN);}
"int"                   {STORE_OPERATOR(INT);}
"interface"             {STORE_OPERATOR(INTERFACE);}
"internal"              {STORE_OPERATOR(INTERNAL);}
"is"                    {STORE_OPERATOR(IS);}
"lock"                  {STORE_OPERATOR(LOCK);}
"long"                  {STORE_OPERATOR(LONG);}
"namespace"             {STORE_OPERATOR(NAMESPACE);}
"new"                   {STORE_OPERATOR(NEW);}
"object"                {STORE_OPERATOR(OBJECT);}
"operator"              {STORE_OPERATOR(OPERATOR);}
"out"                   {STORE_OPERATOR(OUT);}
"override"              {STORE_OPERATOR(OVERRIDE);}
"params"                {STORE_OPERATOR(PARAMS);}
"private"               {STORE_OPERATOR(PRIVATE);}
"protected"             {STORE_OPERATOR(PROTECTED);}
"public"                {STORE_OPERATOR(PUBLIC);}
"readonly"              {STORE_OPERATOR(READONLY);}
"ref"                   {STORE_OPERATOR(REF);}
"return"                {STORE_OPERATOR(RETURN);}
"sbyte"                 {STORE_OPERATOR(SBYTE);}
"sealed"                {STORE_OPERATOR(SEALED);}
"short"                 {STORE_OPERATOR(SHORT);}
"sizeof"                {STORE_OPERATOR(SIZEOF);}
"stackalloc"            {STORE_OPERATOR(STACKALLOC);}
"static"                {STORE_OPERATOR(STATIC);}
"string"                {STORE_OPERATOR(STRING);}
"struct"                {STORE_OPERATOR(STRUCT);}
"switch"                {STORE_OPERATOR(SWITCH);}
"this"                  {STORE_OPERATOR(THIS);}
"throw"                 {STORE_OPERATOR(THROW);}
"try"                   {STORE_OPERATOR(TRY);}
"typeof"                {STORE_OPERATOR(TYPEOF);}
"uint"                  {STORE_OPERATOR(UINT);}
"ulong"                 {STORE_OPERATOR(ULONG);}
"unchecked"             {STORE_OPERATOR(UNCHECKED);}
"unsafe"                {STORE_OPERATOR(UNSAFE);}
"ushort"                {STORE_OPERATOR(USHORT);}
"using"                 {STORE_OPERATOR(USING);}
"virtual"               {STORE_OPERATOR(VIRTUAL);}
"void"                  {STORE_OPERATOR(VOID);}
"volatile"              {STORE_OPERATOR(VOLATILE);}
"while"                 {STORE_OPERATOR(WHILE);}

"true"                  {STORE_OPERAND(yytext);}
"false"                 {STORE_OPERAND(yytext);}
"null"                  {STORE_OPERAND(yytext);}

{LETTER}{ALNUM}*        {STORE_OPERAND(yytext);}

[1-9][0-9]*{INT_SUFFIX}?           |
[0][0-7]*{INT_SUFFIX}?             |
[0][xX][0-9A-Fa-f]+{INT_SUFFIX}?      {STORE_OPERAND(yytext);}

[0][xX]                 {STORE_OPERAND(yytext);}

{DIGITS}"."{DIGITS}?([eE]{SIGN}?{DIGITS})?{FLOAT_SUFFIX}?   |
{DIGITS}"."?([eE]{SIGN}?{DIGITS})?{FLOAT_SUFFIX}?     |
"."{DIGITS}([eE]{SIGN}?{DIGITS})?{FLOAT_SUFFIX}?  {STORE_OPERAND(yytext);}

{DIGITS}"."{DIGITS}?[eE]{SIGN}?   |
{DIGITS}"."?[eE]{SIGN}?           |
"."{DIGITS}[eE]{SIGN}?                {STORE_OPERAND(yytext);}

"//"{NOTNL}*{NL}        {++cpp_comments;++com_loc;++cs_lineno;}

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
  cs_lineno=nsemi=noperators=0;

  sloc.clear();
  operators.clear();
  operands.clear();
}
