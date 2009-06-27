/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 * Essential Project Manager (EPM)
 * Copyright (c) 2009 SourceCodeMetrics.com
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * Shell Script Parser
 *
 * $Id: $
 *
 * Who  When         Why
 * CAM  25-Jun-2009  10453 : File created.
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

%{

#include <stdio.h>
#include <string.h>
#include "y.sh.h"

#ifdef WIN32

#include <io.h>
#include <vector>
#include <set>
using namespace std;

#else

#include <stl.h>
#include <unistd.h>

#endif

int sh_lineno=0;
int j_comments=0;
int c_comments=0;
int cpp_comments=0;
int com_loc=0;

set<int> sloc;
set<int> operators;
vector<char*> operands[255];
int nsemi=0 ;           // Number of semi-colons
int noperators=0 ;      // Total number of operators
int noperands=0;        // Total number of operands

#define NOTE_SLOC() sloc.insert(sh_lineno)

void lexclear();
void store_operand(char* txt);
void store_operator(int op);

%}

%p 4096
%x SH_ECOM

NL                                "\n"
NOTNL                             .
ANY                               ({NOTNL}|{NL})
BACKSL                            "\\"
BOL                               ^
LETTER                            [A-Za-z_]
ALNUM                             [A-Za-z_0-9]
DIGIT                             [0-9]
HEXDIGIT                          [0-9A-Fa-f]
DIGITS                            ({DIGIT}+)
EXP                               [Ee][+-]?DIGITS
HEXDIGITS                         ({HEXDIGIT}+)
SIGN                              ("+"|"-")
ELL_SUFFIX                        [lL]([lL]?)
INT_SUFFIX                        ([uU]{ELL_SUFFIX}?|{ELL_SUFFIX}[uU]?)
FLOAT_SUFFIX                      [flFL]
STRCHAR                           [^\"\n\\]
ESCAPE                            ({BACKSL}{ANY})
QUOTE                             [\"]
SPTAB                             [ \t]

%%

"\$#"                             {store_operand(_strdup(yytext));}
"#"{NOTNL}*{NL}                   {cpp_comments++;com_loc++;sh_lineno++;}

\n                                {sh_lineno++;}

"alias"                           {store_operator(KEY_ALIAS);}
"bg"                              {store_operator(KEY_BG);}
"case"                            {store_operator(KEY_CASE);}
"cat"                             {store_operator(KEY_CAT);}
"cd"                              {store_operator(KEY_CD);}
"command"                         {store_operator(KEY_COMMAND);}
"do"                              {store_operator(KEY_DO);}
"done"                            {store_operator(KEY_DONE);}
"echo"                            {store_operator(KEY_ECHO);}
"elif"                            {store_operator(KEY_ELIF);}
"else"                            {store_operator(KEY_ELSE);}
"eof"                             {store_operator(KEY_EOF);}
"esac"                            {store_operator(KEY_ESAC);}
"exit"                            {store_operator(KEY_EXIT);}
"export"                          {store_operator(KEY_EXPORT);}
"false"                           {store_operator(KEY_FALSE);}
"fc"                              {store_operator(KEY_FC);}
"fg"                              {store_operator(KEY_FG);}
"fi"                              {store_operator(KEY_FI);}
"for"                             {store_operator(KEY_FOR);}
"function"                        {store_operator(KEY_FUNCTION);}
"getopts"                         {store_operator(KEY_GETOPTS);}
"if"                              {store_operator(KEY_IF);}
"in"                              {store_operator(KEY_IN);}
"jobs"                            {store_operator(KEY_JOBS);}
"kill"                            {store_operator(KEY_KILL);}
"ls"                              {store_operator(KEY_LS);}
"mkdir"                           {store_operator(KEY_MKDIR);}
"newgrp"                          {store_operator(KEY_NEWGRP);}
"read"                            {store_operator(KEY_READ);}
"readonly"                        {store_operator(KEY_READONLY);}
"rm"                              {store_operator(KEY_RM);}
"rmdir"                           {store_operator(KEY_RMDIR);}
"select"                          {store_operator(KEY_SELECT);}
"set"                             {store_operator(KEY_SET);}
"shift"                           {store_operator(KEY_SHIFT);}
"then"                            {store_operator(KEY_THEN);}
"touch"                           {store_operator(KEY_TOUCH);}
"trap"                            {store_operator(KEY_TRAP);}
"true"                            {store_operator(KEY_TRUE);}
"umask"                           {store_operator(KEY_UMASK);}
"unalias"                         {store_operator(KEY_UNALIAS);}
"unset"                           {store_operator(KEY_UNSET);}
"until"                           {store_operator(KEY_UNTIL);}
"wait"                            {store_operator(KEY_WAIT);}
"while"                           {store_operator(KEY_WHILE);}

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
"."{DIGITS}[eE]{SIGN}?                                      {store_operand(_strdup(yytext));}

"&&"                              {store_operator(SYM_ANDLIST);}
"||"                              {store_operator(SYM_ORLIST);}
"&"                               {store_operator(SYM_AND);}
"*"                               {store_operator(SYM_ASTERISK);}
"`"                               {store_operator(SYM_BACKAPOS);}
"}"                               {store_operator(SYM_CLOSEBRACE);}
"]"                               {store_operator(SYM_CLOSEBRACKET);}
")"                               {store_operator(SYM_CLOSEPAREN);}
":"                               {store_operator(SYM_COLON);}
">"                               {store_operator(SYM_GT);}
"<"                               {store_operator(SYM_LT);}
"-"                               {store_operator(SYM_MINUS);}
"{"                               {store_operator(SYM_OPENBRACE);}
"["                               {store_operator(SYM_OPENBRACKET);}
"("                               {store_operator(SYM_OPENPAREN);}
"!"                               {store_operator(SYM_PLING);}
"\""                              {store_operator(SYM_QUOTE);}
";"                               {store_operator(SYM_SEMICOLON);}

[ \t\v\f]                         {;}
.                                 { /* ignore bad characters */ }
%%
int yywrap() {
  return(1);
}

void lexclear() {
  BEGIN 0;
  noperands=0;
  j_comments=c_comments=cpp_comments=com_loc=0;
  nsemi=noperators=0;
  sh_lineno=1;

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

  NOTE_SLOC();
}

void store_operator(int op) {
  operators.insert(op);
  noperators++;
  NOTE_SLOC();

  sloc.insert(sh_lineno);
}
