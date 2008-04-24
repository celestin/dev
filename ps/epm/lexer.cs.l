/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 * Essential Project Manager (EPM)
 * Copyright (c) 2004-2005 Power Software
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * C# Lexer
 *
 * $Id$
 *
 * Who  When       Why
 * CAM  19-Dec-04  File added.
 * CAM  29-Dec-04  Added lexclear.
 * CAM  25-Feb-05  Removed parsing of string literals (Copyright and other characters causing problems).
 * CAM  25-Feb-05  Put back parsing of string literals and use -8 flex option.
 * CAM  04-May-05    50 : Modified for compatibility with other parsers.
 * CAM  11-May-05    96 : Rationalised variables.
 * CAM  28-Jan-06   168 : Fixed bug where number of operators was not being reset.
 * CAM  24-Apr-08   358 : Corrected compiler warnings moving to VS2008 (from VC++6).
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

JL      [a-zA-Z_$]
JLD     [a-zA-Z0-9_$]

HIL     0[xX][0-9a-fA-F]+(l|L)?
DIL     (0|([1-9][0-9]*))(l|L)?
OIL     0([0-7])+(l|L)?

DIGS      ([0-9])+
EXP     [eE][+-]?[0-9]+
FTS     [fFdD]

CH      [^\'\\]
UNICODE_ESC   (\\u[0-9a-fA-F][0-9a-fA-F][0-9a-fA-F][0-9a-fA-F])
OCTAL_ESC   ((\\[0-7])|(\\[0-7][0-7])|(\\[0-3][0-7][0-7]))
ESC_SEQ     (\\b|\\t|\\n|\\f|\\r|\\\"|\\\'|\\\\)

%{
#include <stdio.h>
#include <string.h>
#include "y.cs.h"

int yylex() ;

#include <io.h>
#include <list>
#include <set>
#include <vector>
using namespace std;

void parse_string_literal();
set<int> sloc;
set<int> operators;
vector<char*> operands[255];

int j_comments=0;
int c_comments=0;
int cpp_comments=0;
int com_loc=0;
int prev_com_line=-1;
int cs_lineno=0;

int nsemi=0 ;           // Number of semi-colons
int noperators=0 ;      // Total number of operators
int noperands=0;        // Total number of operands

#define STORE_OPERATOR(X) operators.insert(X); noperators++;
#define SEMI() nsemi++;
#define COUNT() sloc.insert(cs_lineno)

void lexclear() {
  noperands=0;
  j_comments=c_comments=cpp_comments=com_loc=0;
  prev_com_line=-1;
  cs_lineno=nsemi=noperators=0;

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

void comment_skip();
void eol_comment_skip();

%}
%%
"/**"           {comment_skip();j_comments++;}
"/*"            {comment_skip();c_comments++;}
"//"            {eol_comment_skip(); cpp_comments++;}

"abstract"      {STORE_OPERATOR(ABSTRACT);COUNT();}
"as"            {STORE_OPERATOR(AS);COUNT();}
"base"          {STORE_OPERATOR(BASE);COUNT();}
"bool"          {STORE_OPERATOR(BOOL);COUNT();}
"break"         {STORE_OPERATOR(BREAK);COUNT();}
"byte"          {STORE_OPERATOR(BYTE);COUNT();}
"case"          {STORE_OPERATOR(CASE);COUNT();}
"catch"         {STORE_OPERATOR(CATCH);COUNT();}
"char"          {STORE_OPERATOR(CHAR);COUNT();}
"checked"       {STORE_OPERATOR(CHECKED);COUNT();}
"class"         {STORE_OPERATOR(CLASS);COUNT();}
"const"         {STORE_OPERATOR(CONST);COUNT();}
"continue"      {STORE_OPERATOR(CONTINUE);COUNT();}
"decimal"       {STORE_OPERATOR(DECIMAL);COUNT();}
"default"       {STORE_OPERATOR(DEFAULT);COUNT();}
"delegate"      {STORE_OPERATOR(DELEGATE);COUNT();}
"do"            {STORE_OPERATOR(DO);COUNT();}
"double"        {STORE_OPERATOR(DOUBLE);COUNT();}
"else"          {STORE_OPERATOR(ELSE);COUNT();}
"enum"          {STORE_OPERATOR(ENUM);COUNT();}
"event"         {STORE_OPERATOR(EVENT);COUNT();}
"explicit"      {STORE_OPERATOR(EXPLICIT);COUNT();}
"extern"        {STORE_OPERATOR(EXTERN);COUNT();}
"finally"       {STORE_OPERATOR(FINALLY);COUNT();}
"fixed"         {STORE_OPERATOR(FIXED);COUNT();}
"float"         {STORE_OPERATOR(FLOAT);COUNT();}
"for"           {STORE_OPERATOR(FOR);COUNT();}
"foreach"       {STORE_OPERATOR(FOREACH);COUNT();}
"goto"          {STORE_OPERATOR(GOTO);COUNT();}
"if"            {STORE_OPERATOR(IF);COUNT();}
"implicit"      {STORE_OPERATOR(IMPLICIT);COUNT();}
"in"            {STORE_OPERATOR(IN);COUNT();}
"int"           {STORE_OPERATOR(INT);COUNT();}
"interface"     {STORE_OPERATOR(INTERFACE);COUNT();}
"internal"      {STORE_OPERATOR(INTERNAL);COUNT();}
"is"            {STORE_OPERATOR(IS);COUNT();}
"lock"          {STORE_OPERATOR(LOCK);COUNT();}
"long"          {STORE_OPERATOR(LONG);COUNT();}
"namespace"     {STORE_OPERATOR(NAMESPACE);COUNT();}
"new"           {STORE_OPERATOR(NEW);COUNT();}
"object"        {STORE_OPERATOR(OBJECT);COUNT();}
"operator"      {STORE_OPERATOR(OPERATOR);COUNT();}
"out"           {STORE_OPERATOR(OUT);COUNT();}
"override"      {STORE_OPERATOR(OVERRIDE);COUNT();}
"params"        {STORE_OPERATOR(PARAMS);COUNT();}
"private"       {STORE_OPERATOR(PRIVATE);COUNT();}
"protected"     {STORE_OPERATOR(PROTECTED);COUNT();}
"public"        {STORE_OPERATOR(PUBLIC);COUNT();}
"readonly"      {STORE_OPERATOR(READONLY);COUNT();}
"ref"           {STORE_OPERATOR(REF);COUNT();}
"return"        {STORE_OPERATOR(RETURN);COUNT();}
"sbyte"         {STORE_OPERATOR(SBYTE);COUNT();}
"sealed"        {STORE_OPERATOR(SEALED);COUNT();}
"short"         {STORE_OPERATOR(SHORT);COUNT();}
"sizeof"        {STORE_OPERATOR(SIZEOF);COUNT();}
"stackalloc"    {STORE_OPERATOR(STACKALLOC);COUNT();}
"static"        {STORE_OPERATOR(STATIC);COUNT();}
"string"        {STORE_OPERATOR(STRING);COUNT();}
"struct"        {STORE_OPERATOR(STRUCT);COUNT();}
"switch"        {STORE_OPERATOR(SWITCH);COUNT();}
"this"          {STORE_OPERATOR(THIS);COUNT();}
"throw"         {STORE_OPERATOR(THROW);COUNT();}
"try"           {STORE_OPERATOR(TRY);COUNT();}
"typeof"        {STORE_OPERATOR(TYPEOF);COUNT();}
"uint"          {STORE_OPERATOR(UINT);COUNT();}
"ulong"         {STORE_OPERATOR(ULONG);COUNT();}
"unchecked"     {STORE_OPERATOR(UNCHECKED);COUNT();}
"unsafe"        {STORE_OPERATOR(UNSAFE);COUNT();}
"ushort"        {STORE_OPERATOR(USHORT);COUNT();}
"using"         {STORE_OPERATOR(USING);COUNT();}
"virtual"       {STORE_OPERATOR(VIRTUAL);COUNT();}
"void"          {STORE_OPERATOR(VOID);COUNT();}
"volatile"      {STORE_OPERATOR(VOLATILE);COUNT();}
"while"         {STORE_OPERATOR(WHILE);COUNT();}

"\""                                    {parse_string_literal();store_operand(_strdup(yytext));}
({DIGS})"."({DIGS})?({EXP})?({FTS})?    {store_operand(_strdup(yytext));COUNT();}
"."({DIGS})({EXP})?({FTS})?             {store_operand(_strdup(yytext)); COUNT();}
({DIGS})({EXP})({FTS})?                 {store_operand(_strdup(yytext));COUNT();}
({DIGS})({EXP})?({FTS})                 {store_operand(_strdup(yytext));COUNT();}
{DIL}|{HIL}|{OIL}                       {store_operand(_strdup(yytext));COUNT();}

"true"      {store_operand(_strdup(yytext));COUNT();}
"false"     {store_operand(_strdup(yytext));COUNT();}
"null"      {store_operand(_strdup(yytext));COUNT();}

{JL}({JLD})*              {store_operand(_strdup(yytext));COUNT();}
("'")({CH})("'")          {store_operand(_strdup(yytext));COUNT();}
("'")({ESC_SEQ})("'")     {store_operand(_strdup(yytext));COUNT();}
("'")({OCTAL_ESC})("'")   {store_operand(_strdup(yytext));COUNT();}
("'")({UNICODE_ESC})("'") {store_operand(_strdup(yytext));COUNT();}

"="     {STORE_OPERATOR(ASSIGN);COUNT();}
">"     {STORE_OPERATOR(GT);COUNT();}
"<"     {STORE_OPERATOR(LT);COUNT();}
"!"     {STORE_OPERATOR(NOT);COUNT();}
"~"     {STORE_OPERATOR(BIT_NOT);COUNT();}
"?"     {STORE_OPERATOR(QUERY);COUNT();}
":"     {STORE_OPERATOR(COLON);COUNT();}
"=="    {STORE_OPERATOR(EQUALITY);COUNT();}
"<="    {STORE_OPERATOR(LE);COUNT();}
">="    {STORE_OPERATOR(GE);COUNT();}
"!="    {STORE_OPERATOR(NE);COUNT();}
"&&"    {STORE_OPERATOR(AND);COUNT();}
"||"    {STORE_OPERATOR(OR);COUNT();}
"++"    {STORE_OPERATOR(PLUSPLUS);COUNT();}
"--"    {STORE_OPERATOR(MINUSMINUS);COUNT();}
"+"     {STORE_OPERATOR(PLUS);COUNT();}
"-"     {STORE_OPERATOR(MINUS);COUNT();}
"*"     {STORE_OPERATOR(TIMES);COUNT();}
"/"     {STORE_OPERATOR(DIVIDE);COUNT();}
"&"     {STORE_OPERATOR(BIT_AND);COUNT();}
"|"     {STORE_OPERATOR(BIT_OR);COUNT();}
"^"     {STORE_OPERATOR(CARET);COUNT();}
"%"     {STORE_OPERATOR(MOD);COUNT();}
"<<"    {STORE_OPERATOR(LEFT_SHIFT);COUNT();}
">>"    {STORE_OPERATOR(RIGHT_SHIFT);COUNT();}
">>>"   {STORE_OPERATOR(GTGTGT);COUNT();}
"+="    {STORE_OPERATOR(PLUSEQUALS);COUNT();}
"-="    {STORE_OPERATOR(MINUSEQUALS);COUNT();}
"*="    {STORE_OPERATOR(TIMESEQUALS);COUNT();}
"/="    {STORE_OPERATOR(DIVEQUALS);COUNT();}
"&="    {STORE_OPERATOR(BIT_ANDEQUALS);COUNT();}
"|="    {STORE_OPERATOR(BIT_OREQUALS);COUNT();}
"^="    {STORE_OPERATOR(CARETEQUALS);COUNT();}
"%="    {STORE_OPERATOR(MODEQUALS);COUNT();}
"<<="   {STORE_OPERATOR(LEFT_SHIFTEQUALS);COUNT();}
">>="   {STORE_OPERATOR(RIGHT_SHIFTEQUALS);COUNT();}
">>>="  {STORE_OPERATOR(GTGTGTEQUALS);COUNT();}
"("     {COUNT();}
")"     {COUNT();}
"{"     {COUNT();}
"}"     {COUNT();}
"["     {COUNT();}
"]"     {COUNT();}
";"     {COUNT(); SEMI();}
","     {STORE_OPERATOR(COMMA);COUNT();}
"."     {STORE_OPERATOR(DOT);COUNT();}

[ \t\v\f]   { /* ignore whitespace     */ }
.           { /* ignore bad characters */ }
"\n"        {cs_lineno++;}

%%

int yywrap() {
  return(1) ;
}

/**
 * Parse the remainder of a C/Java style (multi-line) comment
 */
void comment_skip() {
  char c=0;
  int depth=1;

  const int INITIAL_STATE=0;
  const int WAITING_START_OF_COMMENT=1;
  const int WAITING_END_OF_COMMENT=2;
  int state;

  if (cs_lineno!=prev_com_line) {
    com_loc++;
    prev_com_line=cs_lineno;
  }
  state=INITIAL_STATE;

  while ((depth>0)&&(c!=EOF)) {
    c=yyinput();
    if (c=='\n') {
      prev_com_line=cs_lineno;
    cs_lineno++;
    com_loc++;
    }
    if ((state==WAITING_END_OF_COMMENT)&&(c!='/'))
      state=INITIAL_STATE;
    if ((state==WAITING_START_OF_COMMENT)&&(c!='*'))
      state=INITIAL_STATE;

    if (state==INITIAL_STATE) {
      if (c=='*') {
        state=WAITING_END_OF_COMMENT;
      } else if (c=='/') {
        state=WAITING_START_OF_COMMENT;
    }
    } else if (state==WAITING_END_OF_COMMENT) {
      if (c=='/') {
      depth--;
      state=INITIAL_STATE;
    }
    } else if (state==WAITING_START_OF_COMMENT) {
      if (c=='*') {
      depth++;
      state=INITIAL_STATE;
    }
    }
  } // end while
}

/**
 * Parse the remainder of a C# style (to-end-of-line) comment
 */
void eol_comment_skip() {
  char c ;

  while (((c=yyinput()) !='\n') && (c!=0) &&(c!=EOF)) ;
  cs_lineno++ ;
  com_loc++ ;
}

/**
 * Parse the remainder of a string literal
 */
void parse_string_literal() {

  int escaped=0 ;
  char c ;

  yytext[0]='\0' ;

  while (  ((c=yyinput())!='"')&&(c!=0)&&(c!=EOF)) {
    yytext[strlen(yytext)+1]='\0' ;
    yytext[strlen(yytext)]=c ;
    if (c=='\\') {
      c=yyinput() ;
      yytext[strlen(yytext)+1]='\0' ;
      yytext[strlen(yytext)]=c ;
      if ((c==0)||(c==EOF))
        return ;
    }
  }
}

