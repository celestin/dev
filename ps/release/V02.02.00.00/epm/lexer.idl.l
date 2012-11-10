/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 * Essential Project Manager (EPM)
 * Copyright (c) 2004,2008 PowerSoftware.com
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * Ericsson IDL parser
 *
 * $Id$
 *
 * Who  When       Why
 * CAM  28-Jun-07   314 : File created.
 * CAM  24-Apr-08   358 : Corrected compiler warnings moving to VS2008 (from VC++6).
 * CAM  22-Sep-2010  10648 : Converted from string operands to PowerHashed.
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
#include "y.idl.h"
#include "PowerHash.h"

#ifdef WIN32

#include <io.h>
#include <set>
using namespace std;

#else

#include <stl.h>
#include <unistd.h>

#endif

const int INITIAL_STATE=0;
const int WAITING_START_OF_COMMENT=1;
const int WAITING_END_OF_COMMENT=2;

int idl_lineno=0;
int j_comments=0;
int c_comments=0;
int cpp_comments=0;
int com_loc=0;
int prev_com_line=-1;

void comment_skip();
void string_literal();
void eol_comment_skip();

set<int> sloc;
set<int> operators;
set<unsigned int> operands;

int nsemi=0 ;           // Number of semi-colons
int noperators=0 ;      // Total number of operators
int noperands=0;        // Total number of operands

#define NOTE_SLOC()       sloc.insert(idl_lineno)
#define STORE_OPERATOR(X) operators.insert(X); noperators++; NOTE_SLOC();
#define STORE_OPERAND(X)  operands.insert(PowerHash(X)); noperands++; NOTE_SLOC();
#define SEMI()            nsemi++; NOTE_SLOC();

void lexclear();

%}

%p 3500

%%

"/**"                   {comment_skip();j_comments++;}
"/*"                    {comment_skip();c_comments++;}
"//"                    {eol_comment_skip(); }

"active"                     {STORE_OPERATOR(ACTIVE);}
"boolean"                    {STORE_OPERATOR(BOOLEAN);}
"bscc_uuid_version"          {STORE_OPERATOR(BSCC_UUID_VERSION);}
"callback"                   {STORE_OPERATOR(CALLBACK);}
"char"                       {STORE_OPERATOR(CHAR);}
"component"                  {STORE_OPERATOR(COMPONENT);}
"const"                      {STORE_OPERATOR(CONST);}
"custom_marshal"             {STORE_OPERATOR(CUSTOM_MARSHAL);}
"discr_union_default_value"  {STORE_OPERATOR(DISCR_UNION_DEFAULT_VALUE);}
"discr_union_type"           {STORE_OPERATOR(DISCR_UNION_TYPE);}
"discr_union_value"          {STORE_OPERATOR(DISCR_UNION_VALUE);}
"discriminant_is"            {STORE_OPERATOR(DISCRIMINANT_IS);}
"double"                     {STORE_OPERATOR(DOUBLE);}
"enum"                       {STORE_OPERATOR(ENUM);}
"FALSE"                      {STORE_OPERATOR(FALSE);}
"float"                      {STORE_OPERATOR(FLOAT);}
"gen_message"                {STORE_OPERATOR(GEN_MESSAGE);}
"handcode_marshal"           {STORE_OPERATOR(HANDCODE_MARSHAL);}
"iid_is"                     {STORE_OPERATOR(IID_IS);}
"import"                     {STORE_OPERATOR(IMPORT);}
"in"                         {STORE_OPERATOR(IN);}
"interface"                  {STORE_OPERATOR(INTERFACE);}
"it_callback"                {STORE_OPERATOR(IT_CALLBACK);}
"it_proxy"                   {STORE_OPERATOR(IT_PROXY);}
"it_proxy_timeout"           {STORE_OPERATOR(IT_PROXY_TIMEOUT);}
"it_proxy_uuid"              {STORE_OPERATOR(IT_PROXY_UUID);}
"long"                       {STORE_OPERATOR(LONG);}
"marshallable"               {STORE_OPERATOR(MARSHALLABLE);}
"max_is"                     {STORE_OPERATOR(MAX_IS);}
"not_marshalled"             {STORE_OPERATOR(NOT_MARSHALLED);}
"NULL"                       {STORE_OPERATOR(NULL_KEYWORD);}
"out"                        {STORE_OPERATOR(OUT);}
"ptr"                        {STORE_OPERATOR(PTR);}
"restricted"                 {STORE_OPERATOR(RESTRICTED);}
"short"                      {STORE_OPERATOR(SHORT);}
"signed"                     {STORE_OPERATOR(SIGNED);}
"singleton"                  {STORE_OPERATOR(SINGLETON);}
"size_is"                    {STORE_OPERATOR(SIZE_IS);}
"small"                      {STORE_OPERATOR(SMALL);}
"source"                     {STORE_OPERATOR(SOURCE);}
"static"                     {STORE_OPERATOR(STATIC);}
"string"                     {STORE_OPERATOR(STRING);}
"thread_safe"                {STORE_OPERATOR(THREAD_SAFE);}
"TRUE"                       {STORE_OPERATOR(TRUE);}
"type_is"                    {STORE_OPERATOR(TYPE_IS);}
"typedef"                    {STORE_OPERATOR(TYPEDEF);}
"union"                      {STORE_OPERATOR(UNION);}
"unique_naming"              {STORE_OPERATOR(UNIQUE_NAMING);}
"unsigned"                   {STORE_OPERATOR(UNSIGNED);}
"uuid"                       {STORE_OPERATOR(UUID);}
"uuid_version"               {STORE_OPERATOR(UUID_VERSION);}
"void"                       {STORE_OPERATOR(VOID);}


{L}({L}|{D})*           {STORE_OPERAND(yytext);}
0[xX]{H}+{IS}?          {STORE_OPERAND(yytext);}
0{D}+{IS}?              {STORE_OPERAND(yytext);}
{D}+{IS}?               {STORE_OPERAND(yytext);}
'(\\.|[^\\'])+'         {STORE_OPERAND(yytext);}
{D}+{E}{FS}?            {STORE_OPERAND(yytext);}
{D}*"."{D}+({E})?{FS}?  {STORE_OPERAND(yytext);}
{D}+"."{D}*({E})?{FS}?  {STORE_OPERAND(yytext);}
\"                      {string_literal();}
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
[ \t\v\f]               {;}
"\n"                    {idl_lineno++;}
.                       { /* ignore bad characters */ }
%%
int yywrap() {
  return(1);
}

void lexclear() {
  BEGIN 0 ;
  noperands=0;
  j_comments=c_comments=cpp_comments=com_loc=0;
  prev_com_line=-1;
  idl_lineno=nsemi=noperators=0;

  sloc.clear();
  operators.clear();
  operands.clear();
}

void comment_skip() {
  char c=0 ;
  int state=INITIAL_STATE ;

  // If there are two c comments on one line it is treated as two
  // c comments but only one comment LOC. Therefore we have to check
  // what line the previous c comment was on.
  if (idl_lineno!=prev_com_line) {
    // Not on the same line as the previous comment so increment
    // comment LOC
    com_loc++;

    // Set the previous c comment line no. to the current line
    prev_com_line=idl_lineno;
  }

  while (c!=EOF) {
    c=yyinput();

    switch (c) {
      case '*':
        state=WAITING_END_OF_COMMENT ;
        break ;

      case '\n':
        // Set the previous c comment line no. to the current line
        prev_com_line=idl_lineno;

        // Update the idl_lineno variable to correspond with moving
        // onto the next line
        idl_lineno++;

        // Increment the comment LOC
        com_loc++;

        // Set the state to INITIAL_STATE
        state=INITIAL_STATE ;
        break ;

      case '/':
        if (state==WAITING_END_OF_COMMENT) {
          return;
        }

        // Set the state to INITIAL_STATE
        state=INITIAL_STATE ;
        break ;

      default:
        state=INITIAL_STATE ;
    }
  }
}


void string_literal() {
  char c=0;

  NOTE_SLOC();

  while ((c!='\"') && (c!=EOF))
     if ((c=yyinput())=='\\')
        if ((c=yyinput())=='\"')
           c=yyinput() ;
}


void eol_comment_skip() {
  char c;

  while (((c=yyinput()) !='\n') && (c!=0) && (c!=EOF)) ;

  cpp_comments++;

  if (idl_lineno!=prev_com_line)
    com_loc++;

  prev_com_line=idl_lineno;
  if (c=='\n') idl_lineno++;
}

/* ************************************* */

