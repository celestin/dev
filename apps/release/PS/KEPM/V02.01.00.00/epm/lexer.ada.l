/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 * Essential Project Manager (EPM)
 * Copyright (c) 2004,2009 PowerSoftware.com
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * ADA Parser
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  02-Aug-05    76 : File created.
 * CAM  18-Mar-06    208 : Correctly handle APOSTROPHEs.
 * CAM  08-Apr-06    230 : Added several missing delimiters, and removed redundant entries.
 * CAM  24-Apr-08    358 : Corrected compiler warnings moving to VS2008 (from VC++6).
 * CAM  18-Apr-2009  10420 : Removed old GS comment/string code and replaced with flex states and correct rule order.
 * CAM  22-Sep-2010  10648 : Converted from string operands to PowerHashed.
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

%{

#include <stdio.h>
#include <string.h>
#include "y.ada.h"
#include "PowerHash.h"

#ifdef WIN32

#include <io.h>
#include <set>
using namespace std;

#else

#include <stl.h>
#include <unistd.h>

#endif

int ada_lineno=0;
int j_comments=0;
int c_comments=0;
int cpp_comments=0;
int com_loc=0;
int prev_com_line=-1;

set<int> sloc;
set<int> operators;
set<unsigned int> operands;
int nsemi=0 ;           // Number of semi-colons
int noperators=0 ;      // Total number of operators
int noperands=0;        // Total number of operands

#define NOTE_SLOC()       sloc.insert(ada_lineno)
#define STORE_OPERATOR(X) operators.insert(X); noperators++; NOTE_SLOC();
#define STORE_OPERAND(X)  operands.insert(PowerHash(X)); noperands++; NOTE_SLOC();
#define SEMI()            nsemi++; NOTE_SLOC();

void lexclear();

%}

%p 3500
%x DEFINE
%x CCOM

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

\n                      {ada_lineno++;}

";"                     {NOTE_SLOC(); nsemi++;}

"&"                     {STORE_OPERATOR(AMPERSAND);}
"'"                     {STORE_OPERATOR(APOSTROPHE);}
"*"                     {STORE_OPERATOR(ASTERISK);}
"+"                     {STORE_OPERATOR(PLUS);}
"-"                     {STORE_OPERATOR(MINUS);}
"/"                     {STORE_OPERATOR(SLASH);}
"<"                     {STORE_OPERATOR(LESS_THAN);}
"="                     {STORE_OPERATOR(EQUAL);}
">"                     {STORE_OPERATOR(GREATER_THAN);}
"."                     {STORE_OPERATOR(DOT);}

","                     {NOTE_SLOC();}
":"                     {NOTE_SLOC();}
"("                     {NOTE_SLOC();}
")"                     {NOTE_SLOC();}
"["                     {NOTE_SLOC();}
"]"                     {NOTE_SLOC();}
"{"                     {NOTE_SLOC();}
"}"                     {NOTE_SLOC();}
"|"                     {NOTE_SLOC();}

"=>"                    {STORE_OPERATOR(ARROW);}
":="                    {STORE_OPERATOR(ASSIGNMENT);}
"**"                    {STORE_OPERATOR(EXPONENT);}
"/="                    {STORE_OPERATOR(NOT_EQUAL);}
">="                    {STORE_OPERATOR(GREATER_EQUAL);}
"<="                    {STORE_OPERATOR(LESS_EQUAL);}
"<<"                    {STORE_OPERATOR(LEFT_LABEL);}
">>"                    {STORE_OPERATOR(RIGHT_LABEL);}
"<>"                    {STORE_OPERATOR(BOX);}
".."                    {STORE_OPERATOR(DOUBLE_DOT);}

^[ \t\v\f]*#            {NOTE_SLOC(); BEGIN DEFINE;}
<DEFINE>[^\\]\n         {NOTE_SLOC(); ada_lineno++; BEGIN 0;}
<DEFINE>\n              {NOTE_SLOC(); ada_lineno++;}
<DEFINE>.               {;}

"ABORT"                 {STORE_OPERATOR(ABORT);}
"ABS"                   {STORE_OPERATOR(ABS);}
"ABSTRACT"              {STORE_OPERATOR(ABSTRACT);}
"ACCEPT"                {STORE_OPERATOR(ACCEPT);}
"ACCESS"                {STORE_OPERATOR(ACCESS);}
"ALIASED"               {STORE_OPERATOR(ALIASED);}
"ALL"                   {STORE_OPERATOR(ALL);}
"AND"                   {STORE_OPERATOR(AND);}
"ARRAY"                 {STORE_OPERATOR(ARRAY);}
"AT"                    {STORE_OPERATOR(AT);}
"BEGIN"                 {STORE_OPERATOR(BEGIN_KEYWORD);}
"BODY"                  {STORE_OPERATOR(BODY);}
"CASE"                  {STORE_OPERATOR(CASE);}
"CONSTANT"              {STORE_OPERATOR(CONSTANT);}
"DECLARE"               {STORE_OPERATOR(DECLARE);}
"DELAY"                 {STORE_OPERATOR(DELAY);}
"DELTA"                 {STORE_OPERATOR(DELTA);}
"DIGITS"                {STORE_OPERATOR(DIGITS);}
"DO"                    {STORE_OPERATOR(DO);}
"ELSE"                  {STORE_OPERATOR(ELSE);}
"ELSIF"                 {STORE_OPERATOR(ELSIF);}
"END"                   {STORE_OPERATOR(END_KEYWORD);}
"ENTRY"                 {STORE_OPERATOR(ENTRY);}
"EXCEPTION"             {STORE_OPERATOR(EXCEPTION);}
"EXIT"                  {STORE_OPERATOR(EXIT);}
"FOR"                   {STORE_OPERATOR(FOR);}
"FUNCTION"              {STORE_OPERATOR(FUNCTION);}
"GENERIC"               {STORE_OPERATOR(GENERIC);}
"GOTO"                  {STORE_OPERATOR(GOTO);}
"IF"                    {STORE_OPERATOR(IF);}
"IN"                    {STORE_OPERATOR(IN);}
"INTERFACE"             {STORE_OPERATOR(INTERFACE);}
"IS"                    {STORE_OPERATOR(IS);}
"LIMITED"               {STORE_OPERATOR(LIMITED);}
"LOOP"                  {STORE_OPERATOR(LOOP);}
"MOD"                   {STORE_OPERATOR(MOD);}
"NEW"                   {STORE_OPERATOR(NEW);}
"NOT"                   {STORE_OPERATOR(NOT);}
"NULL"                  {STORE_OPERATOR(NULL_KEYWORD);}
"OF"                    {STORE_OPERATOR(OF);}
"OR"                    {STORE_OPERATOR(OR);}
"OTHERS"                {STORE_OPERATOR(OTHERS);}
"OUT"                   {STORE_OPERATOR(OUT);}
"OVERRIDING"            {STORE_OPERATOR(OVERRIDING);}
"PACKAGE"               {STORE_OPERATOR(PACKAGE);}
"PRAGMA"                {STORE_OPERATOR(PRAGMA);}
"PRIVATE"               {STORE_OPERATOR(PRIVATE);}
"PROCEDURE"             {STORE_OPERATOR(PROCEDURE);}
"PROTECTED"             {STORE_OPERATOR(PROTECTED);}
"RAISE"                 {STORE_OPERATOR(RAISE);}
"RANGE"                 {STORE_OPERATOR(RANGE);}
"RECORD"                {STORE_OPERATOR(RECORD);}
"REM"                   {STORE_OPERATOR(REM);}
"RENAMES"               {STORE_OPERATOR(RENAMES);}
"REQUEUE"               {STORE_OPERATOR(REQUEUE);}
"RETURN"                {STORE_OPERATOR(RETURN);}
"REVERSE"               {STORE_OPERATOR(REVERSE);}
"SELECT"                {STORE_OPERATOR(SELECT);}
"SEPARATE"              {STORE_OPERATOR(SEPARATE);}
"SUBTYPE"               {STORE_OPERATOR(SUBTYPE);}
"SYNCHRONIZED"          {STORE_OPERATOR(SYNCHRONIZED);}
"TAGGED"                {STORE_OPERATOR(TAGGED);}
"TASK"                  {STORE_OPERATOR(TASK);}
"TERMINATE"             {STORE_OPERATOR(TERMINATE);}
"THEN"                  {STORE_OPERATOR(THEN);}
"TYPE"                  {STORE_OPERATOR(TYPE);}
"UNTIL"                 {STORE_OPERATOR(UNTIL);}
"USE"                   {STORE_OPERATOR(USE);}
"WHEN"                  {STORE_OPERATOR(WHEN);}
"WHILE"                 {STORE_OPERATOR(WHILE);}
"WITH"                  {STORE_OPERATOR(WITH);}
"XOR"                   {STORE_OPERATOR(XOR);}

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

"--"{NOTNL}*{NL}        {cpp_comments++;com_loc++;ada_lineno++;}

[ \t\v\f]               {;}
.                       { /* ignore bad characters */ }

%%
int yywrap() {
  return(1);
}

void lexclear() {
  BEGIN 0;
  noperands=0;
  j_comments=c_comments=cpp_comments=com_loc=0;
  prev_com_line=-1;
  ada_lineno=nsemi=noperators=0;

  sloc.clear();
  operators.clear();
  operands.clear();
}
