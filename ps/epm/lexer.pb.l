/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 * Essential Project Manager (EPM)
 * Copyright (c) 2009 PowerSoftware.com
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * PowerBuilder parser
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  10-Dec-2009  10508 : File created.
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

%{

#include <stdio.h>
#include <string.h>
#include "y.pb.h"

#ifdef WIN32

#include <io.h>
#include <vector>
#include <set>
using namespace std;

#else

#include <stl.h>
#include <unistd.h>

#endif

int pb_lineno=0;
int j_comments=0;
int c_comments=0;
int cpp_comments=0;
int com_loc=0;
int prev_com_line=-1;
int ploc_count=0;

set<int> sloc;
set<int> operators;
vector<char*> operands[255];

int nsemi=0;            // Number of semi-colons
int noperators=0;       // Total number of operators
int noperands=0;        // Total number of operands

#define STORE_OPERATOR(X) operators.insert(X); noperators++;
#define SEMI() nsemi++;
#define COUNT() sloc.insert(pb_lineno)

void lexclear();
void store_operand(char* txt);

%}

%p 3500
%x CCOM
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

"/*"                    {com_loc++; c_comments++; BEGIN CCOM;}
<CCOM>"*/"              {BEGIN 0;}
<CCOM>\n                {com_loc++; pb_lineno++;}
<CCOM>.                 {;}

\n                      {pb_lineno++;}

\".*\\\"*\"             |
\".*\"                  {store_operand(_strdup(yytext));COUNT();}
"'"."'"                 {store_operand(_strdup(yytext));COUNT();}

";"                     {COUNT(); SEMI();}
"{"                     {COUNT();}
"}"                     {COUNT();}
","                     {COUNT();}
":"                     {COUNT();}
"="                     {COUNT(); STORE_OPERATOR('=');}
"("                     {COUNT();}
")"                     {COUNT();}
"["                     {COUNT(); STORE_OPERATOR('[');}
"]"                     {COUNT();}
"."                     {COUNT(); STORE_OPERATOR('.');}
"&"                     {COUNT(); STORE_OPERATOR('&');}
"!"                     {COUNT(); STORE_OPERATOR('!');}
"~"                     {COUNT(); STORE_OPERATOR('~');}
"-"                     {COUNT(); STORE_OPERATOR('-');}
"+"                     {COUNT(); STORE_OPERATOR('+');}
"*"                     {COUNT(); STORE_OPERATOR('*');}
"/"                     {COUNT(); STORE_OPERATOR('/');}
"%"                     {COUNT(); STORE_OPERATOR('%');}
"<"                     {COUNT(); STORE_OPERATOR(LT);}
">"                     {COUNT(); STORE_OPERATOR(GT);}
"^"                     {COUNT(); STORE_OPERATOR('^');}
"|"                     {COUNT(); STORE_OPERATOR('|');}
"?"                     {COUNT(); STORE_OPERATOR('?');}

"::"                    {COUNT(); STORE_OPERATOR(COLONCOLON);}
"..."                   {COUNT(); }
">>="                   {COUNT(); STORE_OPERATOR(GREATGREATEQUALS);}
"<<="                   {COUNT(); STORE_OPERATOR(LESSLESSEQUALS);}
"+="                    {COUNT(); STORE_OPERATOR(PLUSEQUALS);}
"-="                    {COUNT(); STORE_OPERATOR(MINUSEQUALS);}
"*="                    {COUNT(); STORE_OPERATOR(TIMESEQUALS);}
"/="                    {COUNT(); STORE_OPERATOR(DIVEQUALS);}
"%="                    {COUNT(); STORE_OPERATOR(MODEQUALS);}
"&="                    {COUNT(); STORE_OPERATOR(ANDEQUALS);}
"^="                    {COUNT(); STORE_OPERATOR(CARETEQUALS);}
"|="                    {COUNT(); STORE_OPERATOR(BAREQUALS);}
">>"                    {COUNT(); STORE_OPERATOR(GREATERGREATER);}
"<<"                    {COUNT(); STORE_OPERATOR(LESSLESS);}
"++"                    {COUNT(); STORE_OPERATOR(INC_OP);}
"--"                    {COUNT(); STORE_OPERATOR(DEC_OP);}
".*"                    {COUNT(); STORE_OPERATOR(DOT_STAR);}
"->*"                   {COUNT(); STORE_OPERATOR(PTR_OP_STAR);}
"->"                    {COUNT(); STORE_OPERATOR(PTR_OP);}
"&&"                    {COUNT(); STORE_OPERATOR(AND_OP);}
"||"                    {COUNT(); STORE_OPERATOR(OR_OP);}
"<="                    {COUNT(); STORE_OPERATOR(LESSEQUALS);}
">="                    {COUNT(); STORE_OPERATOR(GREATEREQUALS);}
"=="                    {COUNT(); STORE_OPERATOR(EQUALS);}
"!="                    {COUNT(); STORE_OPERATOR(NOTEQUALS);}

"asm"                   {COUNT(); STORE_OPERATOR(ASM);}
"auto"                  {COUNT(); STORE_OPERATOR(AUTO);}
"bool"                  {COUNT(); STORE_OPERATOR(BOOL);}
"break"                 {COUNT(); STORE_OPERATOR(BREAK);}
"case"                  {COUNT(); STORE_OPERATOR(CASE);}
"char"                  {COUNT(); STORE_OPERATOR(CHAR);}
"class"                 {COUNT(); STORE_OPERATOR(CLASS);}
"const_cast"            {COUNT(); STORE_OPERATOR(CONST_CAST);}
"const"                 {COUNT(); STORE_OPERATOR(CONST);}
"continue"              {COUNT(); STORE_OPERATOR(CONTINUE);}
"default"               {COUNT(); STORE_OPERATOR(DEFAULT);}
"do"                    {COUNT(); STORE_OPERATOR(DO);}
"double"                {COUNT(); STORE_OPERATOR(DOUBLE);}
"dynamic_cast"          {COUNT(); STORE_OPERATOR(DYNAMIC_CAST);}
"else"                  {COUNT(); STORE_OPERATOR(ELSE);}
"enum"                  {COUNT(); STORE_OPERATOR(ENUM);}
"explicit"              {COUNT(); STORE_OPERATOR(EXPLICIT);}
"export"                {COUNT(); STORE_OPERATOR(EXPORT);}
"extern"                {COUNT(); STORE_OPERATOR(EXTERN);}
"float"                 {COUNT(); STORE_OPERATOR(FLOAT);}
"for"                   {COUNT(); STORE_OPERATOR(FOR);}
"friend"                {COUNT(); STORE_OPERATOR(FRIEND);}
"goto"                  {COUNT(); STORE_OPERATOR(GOTO);}
"if"                    {COUNT(); STORE_OPERATOR(IF);}
"inline"                {COUNT(); STORE_OPERATOR(INLINE);}
"int"                   {COUNT(); STORE_OPERATOR(INT);}
"long"                  {COUNT(); STORE_OPERATOR(LONG);}
"operator"              {COUNT(); STORE_OPERATOR(OPERATOR);}
"mutable"               {COUNT(); STORE_OPERATOR(MUTABLE);}
"namespace"             {COUNT(); STORE_OPERATOR(NAMESPACE);}
"private"               {COUNT(); STORE_OPERATOR(PRIVATE);}
"protected"             {COUNT(); STORE_OPERATOR(PROTECTED);}
"public"                {COUNT(); STORE_OPERATOR(PUBLIC);}
"register"              {COUNT(); STORE_OPERATOR(REGISTER);}
"reinterpret_cast"      {COUNT(); STORE_OPERATOR(REINTERPRET_CAST);}
"return"                {COUNT(); STORE_OPERATOR(RETURN);}
"short"                 {COUNT(); STORE_OPERATOR(SHORT);}
"signed"                {COUNT(); STORE_OPERATOR(SIGNED);}
"sizeof"                {COUNT(); STORE_OPERATOR(SIZEOF);}
"static_cast"           {COUNT(); STORE_OPERATOR(STATIC_CAST);}
"static"                {COUNT(); STORE_OPERATOR(STATIC);}
"struct"                {COUNT(); STORE_OPERATOR(STRUCT);}
"switch"                {COUNT(); STORE_OPERATOR(SWITCH);}
"template"              {COUNT(); STORE_OPERATOR(TEMPLATE);}
"try"                   {COUNT(); STORE_OPERATOR(TRY);}
"catch"                 {COUNT(); STORE_OPERATOR(CATCH);}
"typedef"               {COUNT(); STORE_OPERATOR(TYPEDEF);}
"typeid"                {COUNT(); STORE_OPERATOR(TYPEID);}
"typename"              {COUNT(); STORE_OPERATOR(TYPENAME);}
"union"                 {COUNT(); STORE_OPERATOR(UNION);}
"void"                  {COUNT(); STORE_OPERATOR(VOID);}
"virtual"               {COUNT(); STORE_OPERATOR(VIRTUAL);}
"volatile"              {COUNT(); STORE_OPERATOR(VOLATILE);}
"wchar_t"               {COUNT(); STORE_OPERATOR(WCHAR_T);}
"while"                 {COUNT(); STORE_OPERATOR(WHILE);}
"using"                 {COUNT(); STORE_OPERATOR(USING);}
"unsigned"              {COUNT(); STORE_OPERATOR(UNSIGNED);}
"new"                   {COUNT(); STORE_OPERATOR(NEW);}
"delete"                {COUNT(); STORE_OPERATOR(DELETE);}
"this"                  {COUNT(); STORE_OPERATOR(THIS);}
"throw"                 {COUNT(); STORE_OPERATOR(THROW);}

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

<STRD>\n                                                    { /* Double-quoted string literals */ pb_lineno++;}
<STRD>\"                                                    {BEGIN 0;}
<STRD>.                                                     {COUNT();}

"//"{NOTNL}*{NL}        {cpp_comments++;com_loc++;pb_lineno++;}

.                       { /* ignore bad characters */ }

%%
int yywrap() {
  return(1);
}

void lexclear() {
  BEGIN 0 ;
  noperands=0;
  j_comments=c_comments=cpp_comments=com_loc=ploc_count=0;
  prev_com_line=-1;
  pb_lineno=nsemi=noperators=0;

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
  operands[c].push_back(txt) ;
}

