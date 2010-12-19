/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 * Essential Project Manager (EPM)
 * Copyright (c) 2009 PowerSoftware.com
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * Shell Script Parser
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  25-Jun-2009  10453 : File created.
 * CAM  01-Oct-2010  10648 : Converted from string operands to PowerHashed.
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

%{

#include <stdio.h>
#include <string.h>
#include "y.sh.h"
#include "PowerHash.h"

#ifdef WIN32

#include <io.h>
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
set<unsigned int> operands;
int nsemi=0 ;           // Number of semi-colons
int noperators=0 ;      // Total number of operators
int noperands=0;        // Total number of operands

#define NOTE_SLOC()       sloc.insert(sh_lineno)
#define STORE_OPERATOR(X) operators.insert(X); noperators++; NOTE_SLOC();
#define STORE_OPERAND(X)  operands.insert(PowerHash(X)); noperands++; NOTE_SLOC();

void lexclear();

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

"\$#"                             {STORE_OPERAND(yytext);}
"#"{NOTNL}*{NL}                   {cpp_comments++;com_loc++;sh_lineno++;}

\n                                {sh_lineno++;}

"alias"                           {STORE_OPERATOR(KEY_ALIAS);}
"bg"                              {STORE_OPERATOR(KEY_BG);}
"case"                            {STORE_OPERATOR(KEY_CASE);}
"cat"                             {STORE_OPERATOR(KEY_CAT);}
"cd"                              {STORE_OPERATOR(KEY_CD);}
"command"                         {STORE_OPERATOR(KEY_COMMAND);}
"do"                              {STORE_OPERATOR(KEY_DO);}
"done"                            {STORE_OPERATOR(KEY_DONE);}
"echo"                            {STORE_OPERATOR(KEY_ECHO);}
"elif"                            {STORE_OPERATOR(KEY_ELIF);}
"else"                            {STORE_OPERATOR(KEY_ELSE);}
"eof"                             {STORE_OPERATOR(KEY_EOF);}
"esac"                            {STORE_OPERATOR(KEY_ESAC);}
"exit"                            {STORE_OPERATOR(KEY_EXIT);}
"export"                          {STORE_OPERATOR(KEY_EXPORT);}
"false"                           {STORE_OPERATOR(KEY_FALSE);}
"fc"                              {STORE_OPERATOR(KEY_FC);}
"fg"                              {STORE_OPERATOR(KEY_FG);}
"fi"                              {STORE_OPERATOR(KEY_FI);}
"for"                             {STORE_OPERATOR(KEY_FOR);}
"function"                        {STORE_OPERATOR(KEY_FUNCTION);}
"getopts"                         {STORE_OPERATOR(KEY_GETOPTS);}
"if"                              {STORE_OPERATOR(KEY_IF);}
"in"                              {STORE_OPERATOR(KEY_IN);}
"jobs"                            {STORE_OPERATOR(KEY_JOBS);}
"kill"                            {STORE_OPERATOR(KEY_KILL);}
"ls"                              {STORE_OPERATOR(KEY_LS);}
"mkdir"                           {STORE_OPERATOR(KEY_MKDIR);}
"newgrp"                          {STORE_OPERATOR(KEY_NEWGRP);}
"read"                            {STORE_OPERATOR(KEY_READ);}
"readonly"                        {STORE_OPERATOR(KEY_READONLY);}
"rm"                              {STORE_OPERATOR(KEY_RM);}
"rmdir"                           {STORE_OPERATOR(KEY_RMDIR);}
"select"                          {STORE_OPERATOR(KEY_SELECT);}
"set"                             {STORE_OPERATOR(KEY_SET);}
"shift"                           {STORE_OPERATOR(KEY_SHIFT);}
"then"                            {STORE_OPERATOR(KEY_THEN);}
"touch"                           {STORE_OPERATOR(KEY_TOUCH);}
"trap"                            {STORE_OPERATOR(KEY_TRAP);}
"true"                            {STORE_OPERATOR(KEY_TRUE);}
"umask"                           {STORE_OPERATOR(KEY_UMASK);}
"unalias"                         {STORE_OPERATOR(KEY_UNALIAS);}
"unset"                           {STORE_OPERATOR(KEY_UNSET);}
"until"                           {STORE_OPERATOR(KEY_UNTIL);}
"wait"                            {STORE_OPERATOR(KEY_WAIT);}
"while"                           {STORE_OPERATOR(KEY_WHILE);}

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

"&&"                              {STORE_OPERATOR(SYM_ANDLIST);}
"||"                              {STORE_OPERATOR(SYM_ORLIST);}
"&"                               {STORE_OPERATOR(SYM_AND);}
"*"                               {STORE_OPERATOR(SYM_ASTERISK);}
"`"                               {STORE_OPERATOR(SYM_BACKAPOS);}
"}"                               {STORE_OPERATOR(SYM_CLOSEBRACE);}
"]"                               {STORE_OPERATOR(SYM_CLOSEBRACKET);}
")"                               {STORE_OPERATOR(SYM_CLOSEPAREN);}
":"                               {STORE_OPERATOR(SYM_COLON);}
">"                               {STORE_OPERATOR(SYM_GT);}
"<"                               {STORE_OPERATOR(SYM_LT);}
"-"                               {STORE_OPERATOR(SYM_MINUS);}
"{"                               {STORE_OPERATOR(SYM_OPENBRACE);}
"["                               {STORE_OPERATOR(SYM_OPENBRACKET);}
"("                               {STORE_OPERATOR(SYM_OPENPAREN);}
"!"                               {STORE_OPERATOR(SYM_PLING);}
"\""                              {STORE_OPERATOR(SYM_QUOTE);}
";"                               {STORE_OPERATOR(SYM_SEMICOLON);}

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
  operands.clear();
}
