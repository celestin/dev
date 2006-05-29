/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 * Essential Project Manager (EPM)
 * Copyright (c) 2004-2005 Power Software
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * ADA Parser
 *
 * $Id$
 *
 * Who  When       Why
 * CAM  02-Aug-05    76 : File created.
 * CAM  18-Mar-06   208 : Correctly handle APOSTROPHEs.
 * CAM  08-Apr-06   230 : Added several missing delimiters, and removed redundant entries.
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

D                       [0-9]
L                       [a-zA-Z_]
H                       [a-fA-F0-9]
E                       [Ee][+-]?{D}+
FS                      (f|F|l|L)
IS                      (u|U|l|L)*

%{

#include <stdio.h>
#include <string.h>
#include "y.ada.h"

#ifdef WIN32

#include <io.h>
#include <vector>
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
vector<char*> operands[255];
int nsemi=0 ;           // Number of semi-colons
int noperators=0 ;      // Total number of operators
int noperands=0;        // Total number of operands

#define NOTE_SLOC() sloc.insert(ada_lineno)

void lexclear() {
  BEGIN 0;
  noperands=0;
  j_comments=c_comments=cpp_comments=com_loc=0;
  prev_com_line=-1;
  ada_lineno=nsemi=noperators=0;

  sloc.clear();
  operators.clear();

  for (int i=0; i<255; i++) {
    if (operands[i].size() > 0) operands[i].clear();
  }
}

void store_operand(char* txt) {
  unsigned char c;int i;
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
}

void string_literal();
void eol_comment_skip();

%}

%p 3500
%x DEFINE

%%

"--"                    {eol_comment_skip(); }

^[ \t\v\f]*#            {NOTE_SLOC(); BEGIN DEFINE;}
<DEFINE>[^\\]"\n"       {NOTE_SLOC(); ada_lineno++; BEGIN 0;}
<DEFINE>"\n"            {NOTE_SLOC(); ada_lineno++;}
<DEFINE>.               {;}

"ABORT"                 {store_operator(ABORT);}
"ABS"                   {store_operator(ABS);}
"ABSTRACT"              {store_operator(ABSTRACT);}
"ACCEPT"                {store_operator(ACCEPT);}
"ACCESS"                {store_operator(ACCESS);}
"ALIASED"               {store_operator(ALIASED);}
"ALL"                   {store_operator(ALL);}
"AND"                   {store_operator(AND);}
"ARRAY"                 {store_operator(ARRAY);}
"AT"                    {store_operator(AT);}
"BEGIN"                 {store_operator(BEGIN_KEYWORD);}
"BODY"                  {store_operator(BODY);}
"CASE"                  {store_operator(CASE);}
"CONSTANT"              {store_operator(CONSTANT);}
"DECLARE"               {store_operator(DECLARE);}
"DELAY"                 {store_operator(DELAY);}
"DELTA"                 {store_operator(DELTA);}
"DIGITS"                {store_operator(DIGITS);}
"DO"                    {store_operator(DO);}
"ELSE"                  {store_operator(ELSE);}
"ELSIF"                 {store_operator(ELSIF);}
"END"                   {store_operator(END_KEYWORD);}
"ENTRY"                 {store_operator(ENTRY);}
"EXCEPTION"             {store_operator(EXCEPTION);}
"EXIT"                  {store_operator(EXIT);}
"FOR"                   {store_operator(FOR);}
"FUNCTION"              {store_operator(FUNCTION);}
"GENERIC"               {store_operator(GENERIC);}
"GOTO"                  {store_operator(GOTO);}
"IF"                    {store_operator(IF);}
"IN"                    {store_operator(IN);}
"INTERFACE"             {store_operator(INTERFACE);}
"IS"                    {store_operator(IS);}
"LIMITED"               {store_operator(LIMITED);}
"LOOP"                  {store_operator(LOOP);}
"MOD"                   {store_operator(MOD);}
"NEW"                   {store_operator(NEW);}
"NOT"                   {store_operator(NOT);}
"NULL"                  {store_operator(NULL_KEYWORD);}
"OF"                    {store_operator(OF);}
"OR"                    {store_operator(OR);}
"OTHERS"                {store_operator(OTHERS);}
"OUT"                   {store_operator(OUT);}
"OVERRIDING"            {store_operator(OVERRIDING);}
"PACKAGE"               {store_operator(PACKAGE);}
"PRAGMA"                {store_operator(PRAGMA);}
"PRIVATE"               {store_operator(PRIVATE);}
"PROCEDURE"             {store_operator(PROCEDURE);}
"PROTECTED"             {store_operator(PROTECTED);}
"RAISE"                 {store_operator(RAISE);}
"RANGE"                 {store_operator(RANGE);}
"RECORD"                {store_operator(RECORD);}
"REM"                   {store_operator(REM);}
"RENAMES"               {store_operator(RENAMES);}
"REQUEUE"               {store_operator(REQUEUE);}
"RETURN"                {store_operator(RETURN);}
"REVERSE"               {store_operator(REVERSE);}
"SELECT"                {store_operator(SELECT);}
"SEPARATE"              {store_operator(SEPARATE);}
"SUBTYPE"               {store_operator(SUBTYPE);}
"SYNCHRONIZED"          {store_operator(SYNCHRONIZED);}
"TAGGED"                {store_operator(TAGGED);}
"TASK"                  {store_operator(TASK);}
"TERMINATE"             {store_operator(TERMINATE);}
"THEN"                  {store_operator(THEN);}
"TYPE"                  {store_operator(TYPE);}
"UNTIL"                 {store_operator(UNTIL);}
"USE"                   {store_operator(USE);}
"WHEN"                  {store_operator(WHEN);}
"WHILE"                 {store_operator(WHILE);}
"WITH"                  {store_operator(WITH);}
"XOR"                   {store_operator(XOR);}

{L}({L}|{D})*           {store_operand(strdup(yytext));}
0[xX]{H}+{IS}?          {store_operand(strdup(yytext));}
0{D}+{IS}?              {store_operand(strdup(yytext));}
{D}+{IS}?               {store_operand(strdup(yytext));}
{D}+{E}{FS}?            {store_operand(strdup(yytext));}
{D}*"."{D}+({E})?{FS}?  {store_operand(strdup(yytext));}
{D}+"."{D}*({E})?{FS}?  {store_operand(strdup(yytext));}
\"                      {sloc.insert(ada_lineno); string_literal();}

";"                     {NOTE_SLOC(); nsemi++;}

"=>"                    {store_operator(ARROW);}
":="                    {store_operator(ASSIGNMENT);}
"**"                    {store_operator(EXPONENT);}
"/="                    {store_operator(NOT_EQUAL);}
">="                    {store_operator(GREATER_EQUAL);}
"<="                    {store_operator(LESS_EQUAL);}
"<<"                    {store_operator(LEFT_LABEL);}
">>"                    {store_operator(RIGHT_LABEL);}
"<>"                    {store_operator(BOX);}
".."                    {store_operator(DOUBLE_DOT);}

"&"                     {store_operator(AMPERSAND);}
"'"                     {store_operator(APOSTROPHE);}
"*"                     {store_operator(ASTERISK);}
"+"                     {store_operator(PLUS);}
"-"                     {store_operator(MINUS);}
"/"                     {store_operator(SLASH);}
"<"                     {store_operator(LESS_THAN);}
"="                     {store_operator(EQUAL);}
">"                     {store_operator(GREATER_THAN);}
"."                     {store_operator(DOT);}

","                     {NOTE_SLOC();}
":"                     {NOTE_SLOC();}
"("                     {NOTE_SLOC();}
")"                     {NOTE_SLOC();}
"["                     {NOTE_SLOC();}
"]"                     {NOTE_SLOC();}
"{"                     {NOTE_SLOC();}
"}"                     {NOTE_SLOC();}
"|"                     {NOTE_SLOC();}

[ \t\v\f]               {;}
"\n"                    {ada_lineno++;}
.                       { /* ignore bad characters */ }
%%
int yywrap() {
  return(1);
}

void string_literal() {
  char c=0;

  while ((c!='\"') && (c!=EOF))
     if ((c=yyinput())=='\\')
        if ((c=yyinput())=='\"')
           c=yyinput();

  sloc.insert(ada_lineno);
}


void eol_comment_skip() {
  char c;

  while (((c=yyinput()) !='\n') && (c!=0) && (c!=EOF)) ;

  cpp_comments++;

  if (ada_lineno!=prev_com_line)
    com_loc++;

  prev_com_line=ada_lineno;
  if (c=='\n') ada_lineno++;
}