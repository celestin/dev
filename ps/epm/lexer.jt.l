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
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

%{
#include <stdio.h>
#include <string.h>
#include "y.jt.h"

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

int jt_lineno=0;
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
int noperands=0;       // Total number of operands

#define STORE_OPERATOR(X) operators.insert(X); noperators++;
#define SEMI() nsemi++;
#define COUNT() sloc.insert(jt_lineno)

void lexclear() {
  BEGIN 0;
  noperands=0;
  j_comments=c_comments=cpp_comments=com_loc=0;
  prev_com_line=-1;
  jt_lineno=nsemi=noperators=0;

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
<JCOM>\n                                {com_loc++; jt_lineno++;}
<JCOM>.                                 {;}

"/*"                                    {com_loc++; c_comments++; BEGIN CCOM;}
<CCOM>"*/"                              {BEGIN 0;}
<CCOM>\n                                {com_loc++; jt_lineno++;}
<CCOM>.                                 {;}

\n                                      {jt_lineno++;}

"="                                     {STORE_OPERATOR(SYM_ASSIGN);COUNT();}
">"                                     {STORE_OPERATOR(SYM_GT);COUNT();}
"<"                                     {STORE_OPERATOR(SYM_LT);COUNT();}
"!"                                     {STORE_OPERATOR(SYM_NOT);COUNT();}
"~"                                     {STORE_OPERATOR(SYM_TILDE);COUNT();}
"?"                                     {STORE_OPERATOR(SYM_QUESTION);COUNT();}
":"                                     {STORE_OPERATOR(SYM_COLON);COUNT();}
"+"                                     {STORE_OPERATOR(SYM_PLUS);COUNT();}
"-"                                     {STORE_OPERATOR(SYM_MINUS);COUNT();}
"*"                                     {STORE_OPERATOR(SYM_ASTERISK);COUNT();}
"/"                                     {STORE_OPERATOR(SYM_SLASH);COUNT();}
"&"                                     {STORE_OPERATOR(SYM_BITAND);COUNT();}
"|"                                     {STORE_OPERATOR(SYM_BITOR);COUNT();}
"^"                                     {STORE_OPERATOR(SYM_EXPONENT);COUNT();}
"%"                                     {STORE_OPERATOR(SYM_PERCENT);COUNT();}
"("                                     {STORE_OPERATOR(SYM_PARENO);COUNT();}
")"                                     {STORE_OPERATOR(SYM_PARENC);COUNT();}
"{"                                     {STORE_OPERATOR(SYM_BRACEO);COUNT();}
"}"                                     {STORE_OPERATOR(SYM_BRACEC);COUNT();}
"["                                     {STORE_OPERATOR(SYM_BRACKETO);COUNT();}
"]"                                     {STORE_OPERATOR(SYM_BRACKETC);COUNT();}
";"                                     {COUNT();SEMI();}
","                                     {STORE_OPERATOR(SYM_COMMA);COUNT();}
"."                                     {STORE_OPERATOR(SYM_PERIOD);COUNT();}

"=="                                    {STORE_OPERATOR(SYM_EQUALS);COUNT();}
"<="                                    {STORE_OPERATOR(SYM_LTEQUAL);COUNT();}
">="                                    {STORE_OPERATOR(SYM_GTEQUAL);COUNT();}
"!="                                    {STORE_OPERATOR(SYM_NOTEQUAL);COUNT();}
"&&"                                    {STORE_OPERATOR(SYM_LOGAND);COUNT();}
"||"                                    {STORE_OPERATOR(SYM_LOGOR);COUNT();}
"++"                                    {STORE_OPERATOR(SYM_INCREMENT);COUNT();}
"--"                                    {STORE_OPERATOR(SYM_DECREMENT);COUNT();}
"<<"                                    {STORE_OPERATOR(SYM_SHIFTLT);COUNT();}
">>"                                    {STORE_OPERATOR(SYM_SHIFTRT);COUNT();}
">>>"                                   {STORE_OPERATOR(SYM_SHIFTRTUNS);COUNT();}
"+="                                    {STORE_OPERATOR(SYM_ASSIGNPLUS);COUNT();}
"-="                                    {STORE_OPERATOR(SYM_ASSIGNMINUS);COUNT();}
"*="                                    {STORE_OPERATOR(SYM_ASSIGNMULTIPLY);COUNT();}
"/="                                    {STORE_OPERATOR(SYM_ASSIGNDIVIDE);COUNT();}
"&="                                    {STORE_OPERATOR(SYM_ASSIGNBITAND);COUNT();}
"|="                                    {STORE_OPERATOR(SYM_ASSIGNBITOR);COUNT();}
"^="                                    {STORE_OPERATOR(SYM_ASSIGNEXPONENT);COUNT();}
"%="                                    {STORE_OPERATOR(SYM_ASSIGNMOD);COUNT();}
"<<="                                   {STORE_OPERATOR(SYM_ASSIGNSHIFTLT);COUNT();}
">>="                                   {STORE_OPERATOR(SYM_ASSIGNSHIFTRT);COUNT();}
">>>="                                  {STORE_OPERATOR(SYM_ASSIGNSHIFTRTUNS);COUNT();}

"abstract"                              {STORE_OPERATOR(KEY_ABSTRACT);COUNT();}
"boolean"                               {STORE_OPERATOR(KEY_BOOLEAN);COUNT();}
"break"                                 {STORE_OPERATOR(KEY_BREAK);COUNT();}
"byte"                                  {STORE_OPERATOR(KEY_BYTE);COUNT();}
"case"                                  {STORE_OPERATOR(KEY_CASE);COUNT();}
"catch"                                 {STORE_OPERATOR(KEY_CATCH);COUNT();}
"char"                                  {STORE_OPERATOR(KEY_CHAR);COUNT();}
"class"                                 {STORE_OPERATOR(KEY_CLASS);COUNT();}
"const"                                 {STORE_OPERATOR(KEY_CONST);COUNT();}
"continue"                              {STORE_OPERATOR(KEY_CONTINUE);COUNT();}
"default"                               {STORE_OPERATOR(KEY_DEFAULT);COUNT();}
"delete"                                {STORE_OPERATOR(KEY_DELETE);COUNT();}
"do"                                    {STORE_OPERATOR(KEY_DO);COUNT();}
"double"                                {STORE_OPERATOR(KEY_DOUBLE);COUNT();}
"else"                                  {STORE_OPERATOR(KEY_ELSE);COUNT();}
"extends"                               {STORE_OPERATOR(KEY_EXTENDS);COUNT();}
"final"                                 {STORE_OPERATOR(KEY_FINAL);COUNT();}
"finally"                               {STORE_OPERATOR(KEY_FINALLY);COUNT();}
"float"                                 {STORE_OPERATOR(KEY_FLOAT);COUNT();}
"for"                                   {STORE_OPERATOR(KEY_FOR);COUNT();}
"function"                              {STORE_OPERATOR(KEY_FUNCTION);COUNT();}
"goto"                                  {STORE_OPERATOR(KEY_GOTO);COUNT();}
"if"                                    {STORE_OPERATOR(KEY_IF);COUNT();}
"implements"                            {STORE_OPERATOR(KEY_IMPLEMENTS);COUNT();}
"import"                                {STORE_OPERATOR(KEY_IMPORT);COUNT();}
"in"                                    {STORE_OPERATOR(KEY_IN);COUNT();}
"instanceof"                            {STORE_OPERATOR(KEY_INSTANCEOF);COUNT();}
"int"                                   {STORE_OPERATOR(KEY_INT );COUNT();}
"interface"                             {STORE_OPERATOR(KEY_INTERFACE);COUNT();}
"long"                                  {STORE_OPERATOR(KEY_LONG);COUNT();}
"native"                                {STORE_OPERATOR(KEY_NATIVE);COUNT();}
"new"                                   {STORE_OPERATOR(KEY_NEW);COUNT();}
"package"                               {STORE_OPERATOR(KEY_PACKAGE);COUNT();}
"private"                               {STORE_OPERATOR(KEY_PRIVATE);COUNT();}
"protected"                             {STORE_OPERATOR(KEY_PROTECTED);COUNT();}
"public"                                {STORE_OPERATOR(KEY_PUBLIC);COUNT();}
"return"                                {STORE_OPERATOR(KEY_RETURN);COUNT();}
"short"                                 {STORE_OPERATOR(KEY_SHORT);COUNT();}
"static"                                {STORE_OPERATOR(KEY_STATIC);COUNT();}
"super"                                 {STORE_OPERATOR(KEY_SUPER);COUNT();}
"switch"                                {STORE_OPERATOR(KEY_SWITCH);COUNT();}
"synchronized"                          {STORE_OPERATOR(KEY_SYNCHRONIZED );COUNT();}
"this"                                  {STORE_OPERATOR(KEY_THIS);COUNT();}
"throw"                                 {STORE_OPERATOR(KEY_THROW);COUNT();}
"throws"                                {STORE_OPERATOR(KEY_THROWS);COUNT();}
"transient"                             {STORE_OPERATOR(KEY_TRANSIENT);COUNT();}
"try"                                   {STORE_OPERATOR(KEY_TRY);COUNT();}
"typeof"                                {STORE_OPERATOR(KEY_TYPEOF);COUNT();}
"var"                                   {STORE_OPERATOR(KEY_VAR);COUNT();}
"void"                                  {STORE_OPERATOR(KEY_VOID);COUNT();}
"volatile"                              {STORE_OPERATOR(KEY_VOLATILE);COUNT();}
"while"                                 {STORE_OPERATOR(KEY_WHILE);COUNT();}
"with"                                  {STORE_OPERATOR(KEY_WITH);COUNT();}

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

"//"{NOTNL}*{NL}                        {++cpp_comments;++com_loc;++jt_lineno;}

[ \t\v\f]                               { /* ignore whitespace     */ }
.                                       { /* ignore bad characters */ }

%%

int yywrap() {
        return(1);
}

