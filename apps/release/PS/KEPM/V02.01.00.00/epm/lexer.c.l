/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 * Essential Project Manager (EPM)
 * Copyright (c) 2004,2009 PowerSoftware.com
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * C/C++ parser
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  12-Apr-05    File added.
 * CAM  09-May-05    49 : Changed variables to be more consistent.
 * CAM  11-May-05    96 : Rationalised variables.
 * CAM  24-Apr-08    358 : Corrected compiler warnings moving to VS2008 (from VC++6).
 * CAM  18-Apr-2009  10422 : Removed old GS comment/string code and replaced with flex states and correct rule order.
 * CAM  09-Sep-2009  10479 : Add PLOC.
 * CAM  22-Sep-2010  10648 : Converted from string operands to PowerHashed.
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

%{

#include <stdio.h>
#include <string.h>
#include "y.c.h"
#include "PowerHash.h"

#ifdef WIN32

#include <io.h>
#include <set>
using namespace std;

#else

#include <stl.h>
#include <unistd.h>

#endif

int cpp_lineno=0;
int j_comments=0;
int c_comments=0;
int cpp_comments=0;
int com_loc=0;
int prev_com_line=-1;
int ploc_count=0;

set<int> sloc;
set<int> operators;
set<unsigned int> operands;

int nsemi=0;            // Number of semi-colons
int noperators=0;       // Total number of operators
int noperands=0;        // Total number of operands

#define NOTE_SLOC()         sloc.insert(cpp_lineno)
#define STORE_OPERATOR(X)   operators.insert(X); noperators++; NOTE_SLOC();
#define STORE_OPERAND(X)    operands.insert(PowerHash(X)); noperands++; NOTE_SLOC();
#define SEMI()              nsemi++; NOTE_SLOC();

void lexclear();

%}

%p 3500
%x DEFINE
%x JCOM CCOM
%x STRD

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

[ \t\v\f]*              {;}

"/**"                   {com_loc++; j_comments++; BEGIN JCOM;}
<JCOM>"*/"              {BEGIN 0;}
<JCOM>\n                {com_loc++; cpp_lineno++;}
<JCOM>.                 {;}

"/*"                    {com_loc++; c_comments++; BEGIN CCOM;}
<CCOM>"*/"              {BEGIN 0;}
<CCOM>\n                {com_loc++; cpp_lineno++;}
<CCOM>.                 {;}

\n                      {cpp_lineno++;}

^[ \t\v\f]*#            {NOTE_SLOC(); BEGIN DEFINE;}
<DEFINE>[^\\]\n         {NOTE_SLOC(); cpp_lineno++; ploc_count++; BEGIN 0;}
<DEFINE>\n              {NOTE_SLOC(); cpp_lineno++; ploc_count++;}
<DEFINE>.               {;}

\".*\\\"*\"             |
\".*\"                  {STORE_OPERAND(yytext);}
"'"."'"                 {STORE_OPERAND(yytext);}

";"                     {SEMI();}
"{"                     {NOTE_SLOC();}
"}"                     {NOTE_SLOC();}
","                     {NOTE_SLOC();}
":"                     {NOTE_SLOC();}
"="                     {STORE_OPERATOR('=');}
"("                     {NOTE_SLOC();}
")"                     {NOTE_SLOC();}
"["                     {STORE_OPERATOR('[');}
"]"                     {NOTE_SLOC();}
"."                     {STORE_OPERATOR('.');}
"&"                     {STORE_OPERATOR('&');}
"!"                     {STORE_OPERATOR('!');}
"~"                     {STORE_OPERATOR('~');}
"-"                     {STORE_OPERATOR('-');}
"+"                     {STORE_OPERATOR('+');}
"*"                     {STORE_OPERATOR('*');}
"/"                     {STORE_OPERATOR('/');}
"%"                     {STORE_OPERATOR('%');}
"<"                     {STORE_OPERATOR(LT);}
">"                     {STORE_OPERATOR(GT);}
"^"                     {STORE_OPERATOR('^');}
"|"                     {STORE_OPERATOR('|');}
"?"                     {STORE_OPERATOR('?');}

"::"                    {STORE_OPERATOR(COLONCOLON);}
"..."                   {NOTE_SLOC();}
">>="                   {STORE_OPERATOR(GREATGREATEQUALS);}
"<<="                   {STORE_OPERATOR(LESSLESSEQUALS);}
"+="                    {STORE_OPERATOR(PLUSEQUALS);}
"-="                    {STORE_OPERATOR(MINUSEQUALS);}
"*="                    {STORE_OPERATOR(TIMESEQUALS);}
"/="                    {STORE_OPERATOR(DIVEQUALS);}
"%="                    {STORE_OPERATOR(MODEQUALS);}
"&="                    {STORE_OPERATOR(ANDEQUALS);}
"^="                    {STORE_OPERATOR(CARETEQUALS);}
"|="                    {STORE_OPERATOR(BAREQUALS);}
">>"                    {STORE_OPERATOR(GREATERGREATER);}
"<<"                    {STORE_OPERATOR(LESSLESS);}
"++"                    {STORE_OPERATOR(INC_OP);}
"--"                    {STORE_OPERATOR(DEC_OP);}
".*"                    {STORE_OPERATOR(DOT_STAR);}
"->*"                   {STORE_OPERATOR(PTR_OP_STAR);}
"->"                    {STORE_OPERATOR(PTR_OP);}
"&&"                    {STORE_OPERATOR(AND_OP);}
"||"                    {STORE_OPERATOR(OR_OP);}
"<="                    {STORE_OPERATOR(LESSEQUALS);}
">="                    {STORE_OPERATOR(GREATEREQUALS);}
"=="                    {STORE_OPERATOR(EQUALS);}
"!="                    {STORE_OPERATOR(NOTEQUALS);}

"asm"                   {STORE_OPERATOR(ASM);}
"auto"                  {STORE_OPERATOR(AUTO);}
"bool"                  {STORE_OPERATOR(BOOL);}
"break"                 {STORE_OPERATOR(BREAK);}
"case"                  {STORE_OPERATOR(CASE);}
"char"                  {STORE_OPERATOR(CHAR);}
"class"                 {STORE_OPERATOR(CLASS);}
"const_cast"            {STORE_OPERATOR(CONST_CAST);}
"const"                 {STORE_OPERATOR(CONST);}
"continue"              {STORE_OPERATOR(CONTINUE);}
"default"               {STORE_OPERATOR(DEFAULT);}
"do"                    {STORE_OPERATOR(DO);}
"double"                {STORE_OPERATOR(DOUBLE);}
"dynamic_cast"          {STORE_OPERATOR(DYNAMIC_CAST);}
"else"                  {STORE_OPERATOR(ELSE);}
"enum"                  {STORE_OPERATOR(ENUM);}
"explicit"              {STORE_OPERATOR(EXPLICIT);}
"export"                {STORE_OPERATOR(EXPORT);}
"extern"                {STORE_OPERATOR(EXTERN);}
"float"                 {STORE_OPERATOR(FLOAT);}
"for"                   {STORE_OPERATOR(FOR);}
"friend"                {STORE_OPERATOR(FRIEND);}
"goto"                  {STORE_OPERATOR(GOTO);}
"if"                    {STORE_OPERATOR(IF);}
"inline"                {STORE_OPERATOR(INLINE);}
"int"                   {STORE_OPERATOR(INT);}
"long"                  {STORE_OPERATOR(LONG);}
"operator"              {STORE_OPERATOR(OPERATOR);}
"mutable"               {STORE_OPERATOR(MUTABLE);}
"namespace"             {STORE_OPERATOR(NAMESPACE);}
"private"               {STORE_OPERATOR(PRIVATE);}
"protected"             {STORE_OPERATOR(PROTECTED);}
"public"                {STORE_OPERATOR(PUBLIC);}
"register"              {STORE_OPERATOR(REGISTER);}
"reinterpret_cast"      {STORE_OPERATOR(REINTERPRET_CAST);}
"return"                {STORE_OPERATOR(RETURN);}
"short"                 {STORE_OPERATOR(SHORT);}
"signed"                {STORE_OPERATOR(SIGNED);}
"sizeof"                {STORE_OPERATOR(SIZEOF);}
"static_cast"           {STORE_OPERATOR(STATIC_CAST);}
"static"                {STORE_OPERATOR(STATIC);}
"struct"                {STORE_OPERATOR(STRUCT);}
"switch"                {STORE_OPERATOR(SWITCH);}
"template"              {STORE_OPERATOR(TEMPLATE);}
"try"                   {STORE_OPERATOR(TRY);}
"catch"                 {STORE_OPERATOR(CATCH);}
"typedef"               {STORE_OPERATOR(TYPEDEF);}
"typeid"                {STORE_OPERATOR(TYPEID);}
"typename"              {STORE_OPERATOR(TYPENAME);}
"union"                 {STORE_OPERATOR(UNION);}
"void"                  {STORE_OPERATOR(VOID);}
"virtual"               {STORE_OPERATOR(VIRTUAL);}
"volatile"              {STORE_OPERATOR(VOLATILE);}
"wchar_t"               {STORE_OPERATOR(WCHAR_T);}
"while"                 {STORE_OPERATOR(WHILE);}
"using"                 {STORE_OPERATOR(USING);}
"unsigned"              {STORE_OPERATOR(UNSIGNED);}
"new"                   {STORE_OPERATOR(NEW);}
"delete"                {STORE_OPERATOR(DELETE);}
"this"                  {STORE_OPERATOR(THIS);}
"throw"                 {STORE_OPERATOR(THROW);}

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

<STRD>\n                                                    { /* Double-quoted string literals */ cpp_lineno++;}
<STRD>\"                                                    {BEGIN 0;}
<STRD>.                                                     {NOTE_SLOC();}

"//"{NOTNL}*{NL}        {cpp_comments++;com_loc++;cpp_lineno++;}

.                       { /* ignore bad characters */ }

%%
int yywrap() {
  return(1);
}

void lexclear()
{
  BEGIN 0;
  noperands=0;
  j_comments=c_comments=cpp_comments=com_loc=ploc_count=0;
  prev_com_line=-1;
  cpp_lineno=nsemi=noperators=0;

  sloc.clear();
  operators.clear();
  operands.clear();
}
