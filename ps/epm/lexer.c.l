/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 * Essential Project Manager (EPM)
 * Copyright (c) 2004-2005 Power Software
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * C/C++ parser
 *
 * $Id: $
 *
 * Who  When       Why
 * CAM  12-Apr-05  File added.
 * CAM  09-May-05    49 : Changed variables to be more consistent.
 * CAM  11-May-05    96 : Rationalised variables.
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
#include "y.c.h"

#ifdef WIN32

#include <io.h>
#include <vector>
#include <set>
using namespace std;

#else

#include <stl.h>
#include <unistd.h>

#endif

const int INITIAL_STATE=0;
const int WAITING_START_OF_COMMENT=1;
const int WAITING_END_OF_COMMENT=2;

int cpp_lineno=0;
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
vector<char*> operands[255];

int nsemi=0 ;           // Number of semi-colons
int noperators=0 ;      // Total number of operators
int noperands=0;        // Total number of operands

#define STORE_OPERATOR(X) operators.insert(X); noperators++;
#define SEMI() nsemi++;
#define COUNT() sloc.insert(cpp_lineno)

void lexclear() {
  BEGIN 0 ;
  noperands=0;
  j_comments=c_comments=cpp_comments=com_loc=0;
  prev_com_line=-1;
  cpp_lineno=nsemi=noperators=0;

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
  operands[c].push_back(txt) ;
}

%}

%p 3500
%x DEFINE

%%

"/**"                   {comment_skip();j_comments++;}
"/*"                    {comment_skip();c_comments++;}
"//"                    {eol_comment_skip(); }

^[ \t\v\f]*#            {COUNT(); BEGIN DEFINE;}
<DEFINE>[^\\]"\n"       {COUNT(); cpp_lineno++; BEGIN 0;}
<DEFINE>"\n"            {COUNT(); cpp_lineno++;}
<DEFINE>.               {;}

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
{L}({L}|{D})*           {COUNT(); store_operand(strdup(yytext));}
0[xX]{H}+{IS}?          {COUNT(); store_operand(strdup(yytext));}
0{D}+{IS}?              {COUNT(); store_operand(strdup(yytext));}
{D}+{IS}?               {COUNT(); store_operand(strdup(yytext));}
'(\\.|[^\\'])+'         {COUNT(); store_operand(strdup(yytext));}
{D}+{E}{FS}?            {COUNT(); store_operand(strdup(yytext));}
{D}*"."{D}+({E})?{FS}?  {COUNT(); store_operand(strdup(yytext));}
{D}+"."{D}*({E})?{FS}?  {COUNT(); store_operand(strdup(yytext));}
\"                      {COUNT(); string_literal();}
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
[ \t\v\f]               {;}
"\n"                    {cpp_lineno++;}
.                       { /* ignore bad characters */ }
%%
int yywrap() {
  return(1);
}

void comment_skip() {
  char c=0 ;
  int state=INITIAL_STATE ;

  // If there are two c comments on one line it is treated as two
  // c comments but only one comment LOC. Therefore we have to check
  // what line the previous c comment was on.
  if (cpp_lineno!=prev_com_line) {
    // Not on the same line as the previous comment so increment
    // comment LOC
    com_loc++;

    // Set the previous c comment line no. to the current line
    prev_com_line=cpp_lineno;
  }

  while (c!=EOF) {
    c=yyinput();

    switch (c) {
      case '*':
        state=WAITING_END_OF_COMMENT ;
        break ;

      case '\n':
        // Set the previous c comment line no. to the current line
        prev_com_line=cpp_lineno;

        // Update the cpp_lineno variable to correspond with moving
        // onto the next line
        cpp_lineno++;

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

  while ((c!='\"') && (c!=EOF))
     if ((c=yyinput())=='\\')
        if ((c=yyinput())=='\"')
           c=yyinput() ;
}


void eol_comment_skip() {
  char c;

  while (((c=yyinput()) !='\n') && (c!=0) && (c!=EOF)) ;

  cpp_comments++;

  if (cpp_lineno!=prev_com_line)
    com_loc++;

  prev_com_line=cpp_lineno;
  if (c=='\n') cpp_lineno++;
}

/* ************************************* */

