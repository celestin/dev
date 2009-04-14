/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 * Essential Project Manager (EPM)
 * Copyright (c) 2004,2009 Power Software
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
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

%{
#include <stdio.h>
#include <string.h>
#include "y.j.h"

int yylex();

#ifdef WIN32
  #include <io.h>
  #include <vector>
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
vector<char*> operands[255];

int nsemi=0;           // Number of semi-colons
int noperators=0;      // Total number of operators
int noperands=0;        // Total number of operands

#define STORE_OPERATOR(X) operators.insert(X); noperators++;
#define SEMI() nsemi++;
#define COUNT() sloc.insert(java_lineno)

void lexclear() {
  BEGIN 0;
  noperands=0;
  j_comments=c_comments=cpp_comments=com_loc=0;
  prev_com_line=-1;
  java_lineno=nsemi=noperators=0;

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

"="                                     {STORE_OPERATOR(ASSIGN);COUNT();}
">"                                     {STORE_OPERATOR(GT);COUNT();}
"<"                                     {STORE_OPERATOR(LT);COUNT();}
"!"                                     {STORE_OPERATOR(NOT);COUNT();}
"~"                                     {STORE_OPERATOR(BIT_NOT);COUNT();}
"?"                                     {STORE_OPERATOR(QUERY);COUNT();}
":"                                     {STORE_OPERATOR(COLON);COUNT();}
"+"                                     {STORE_OPERATOR(PLUS);COUNT();}
"-"                                     {STORE_OPERATOR(MINUS);COUNT();}
"*"                                     {STORE_OPERATOR(TIMES);COUNT();}
"/"                                     {STORE_OPERATOR(DIVIDE);COUNT();}
"&"                                     {STORE_OPERATOR(BIT_AND);COUNT();}
"|"                                     {STORE_OPERATOR(BIT_OR);COUNT();}
"^"                                     {STORE_OPERATOR(CARET);COUNT();}
"%"                                     {STORE_OPERATOR(MOD);COUNT();}
"("                                     {COUNT();}
")"                                     {COUNT();}
"{"                                     {COUNT();}
"}"                                     {COUNT();}
"["                                     {COUNT();}
"]"                                     {COUNT();}
";"                                     {COUNT(); SEMI();}
","                                     {STORE_OPERATOR(COMMA);COUNT();}
"."                                     {STORE_OPERATOR(DOT);COUNT();}

"=="                                    {STORE_OPERATOR(EQUALITY);COUNT();}
"<="                                    {STORE_OPERATOR(LE);COUNT();}
">="                                    {STORE_OPERATOR(GE);COUNT();}
"!="                                    {STORE_OPERATOR(NE);COUNT();}
"&&"                                    {STORE_OPERATOR(AND);COUNT();}
"||"                                    {STORE_OPERATOR(OR);COUNT();}
"++"                                    {STORE_OPERATOR(PLUSPLUS);COUNT();}
"--"                                    {STORE_OPERATOR(MINUSMINUS);COUNT();}
"<<"                                    {STORE_OPERATOR(LEFT_SHIFT);COUNT();}
">>"                                    {STORE_OPERATOR(RIGHT_SHIFT);COUNT();}
">>>"                                   {STORE_OPERATOR(GTGTGT);COUNT();}
"+="                                    {STORE_OPERATOR(PLUSEQUALS);COUNT();}
"-="                                    {STORE_OPERATOR(MINUSEQUALS);COUNT();}
"*="                                    {STORE_OPERATOR(TIMESEQUALS);COUNT();}
"/="                                    {STORE_OPERATOR(DIVEQUALS);COUNT();}
"&="                                    {STORE_OPERATOR(BIT_ANDEQUALS);COUNT();}
"|="                                    {STORE_OPERATOR(BIT_OREQUALS);COUNT();}
"^="                                    {STORE_OPERATOR(CARETEQUALS);COUNT();}
"%="                                    {STORE_OPERATOR(MODEQUALS);COUNT();}
"<<="                                   {STORE_OPERATOR(LEFT_SHIFTEQUALS);COUNT();}
">>="                                   {STORE_OPERATOR(RIGHT_SHIFTEQUALS);COUNT();}
">>>="                                  {STORE_OPERATOR(GTGTGTEQUALS);COUNT();}

"abstract"                              {STORE_OPERATOR(ABSTRACT);COUNT();}
"default"                               {STORE_OPERATOR(DEFAULT);COUNT();}
"if"                                    {STORE_OPERATOR(IF);COUNT();}
"private"                               {STORE_OPERATOR(PRIVATE);COUNT();}
"throw"                                 {STORE_OPERATOR(THROW);COUNT();}
"boolean"                               {STORE_OPERATOR(BOOLEAN);COUNT();}
"do"                                    {STORE_OPERATOR(DO);COUNT();}
"implements"                            {STORE_OPERATOR(IMPLEMENTS);COUNT();}
"protected"                             {STORE_OPERATOR(PROTECTED);COUNT();}
"throws"                                {STORE_OPERATOR(THROWS);COUNT();}
"break"                                 {STORE_OPERATOR(BREAK);COUNT();}
"double"                                {STORE_OPERATOR(DOUBLE);COUNT();}
"import"                                {STORE_OPERATOR(IMPORT);COUNT();}
"public"                                {STORE_OPERATOR(PUBLIC);COUNT();}
"transient"                             {STORE_OPERATOR(TRANSIENT);COUNT();}
"byte"                                  {STORE_OPERATOR(BYTE);COUNT();}
"else"                                  {STORE_OPERATOR(ELSE);COUNT();}
"instanceof"                            {STORE_OPERATOR(INSTANCEOF);COUNT();}
"return"                                {STORE_OPERATOR(RETURN);COUNT();}
"try"                                   {STORE_OPERATOR(TRY);COUNT();}
"case"                                  {STORE_OPERATOR(CASE);COUNT();}
"extends"                               {STORE_OPERATOR(EXTENDS);COUNT();}
"int"                                   {STORE_OPERATOR(INT);COUNT();}
"short"                                 {STORE_OPERATOR(SHORT);COUNT();}
"void"                                  {STORE_OPERATOR(VOID);COUNT();}
"catch"                                 {STORE_OPERATOR(CATCH);COUNT();}
"final"                                 {STORE_OPERATOR(FINAL);COUNT();}
"interface"                             {STORE_OPERATOR(INTERFACE);COUNT();}
"static"                                {STORE_OPERATOR(STATIC);COUNT();}
"volatile"                              {STORE_OPERATOR(VOLATILE);COUNT();}
"char"                                  {STORE_OPERATOR(CHAR);COUNT();}
"finally"                               {STORE_OPERATOR(FINALLY);COUNT();}
"long"                                  {STORE_OPERATOR(LONG);COUNT();}
"super"                                 {STORE_OPERATOR(SUPER);COUNT();}
"while"                                 {STORE_OPERATOR(WHILE);COUNT();}
"class"                                 {STORE_OPERATOR(CLASS);COUNT();}
"native"                                {STORE_OPERATOR(NATIVE);COUNT();}
"float"                                 {STORE_OPERATOR(FLOAT);COUNT();}
"switch"                                {STORE_OPERATOR(SWITCH);COUNT();}
"const"                                 {STORE_OPERATOR(CONST);COUNT();}
"for"                                   {STORE_OPERATOR(FOR);COUNT();}
"new"                                   {STORE_OPERATOR(NEW);COUNT();}
"synchronized"                          {STORE_OPERATOR(SYNCHRONIZED);COUNT();}
"continue"                              {STORE_OPERATOR(CONTINUE);COUNT();}
"goto"                                  {STORE_OPERATOR(GOTO);COUNT();}
"package"                               {STORE_OPERATOR(PACKAGE);COUNT();}
"this"                                  {STORE_OPERATOR(THIS);COUNT();}

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

"//"{NOTNL}*{NL}                        {++cpp_comments;++com_loc;++java_lineno;}

[ \t\v\f]                               { /* ignore whitespace     */ }
.                                       { /* ignore bad characters */ }

%%

int yywrap() {
        return(1);
}

