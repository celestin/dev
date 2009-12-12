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
 * CAM  12-Dec-2009  10508 : Added correct symbols and keywords.
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

#define STORE_OPERATOR(X) operators.insert(X); noperators++; COUNT();
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

"("                     {COUNT();}
")"                     {COUNT();}
"["                     {COUNT();}
"]"                     {COUNT();}
"."                     {COUNT();}
"::"                    {COUNT();}

"-"                     {STORE_OPERATOR(SYM_MINUS);}
"%"                     {STORE_OPERATOR(SYM_PCT);}
"&"                     {STORE_OPERATOR(SYM_AND);}
"^"                     {STORE_OPERATOR(SYM_CARAT);}
"~"                     {STORE_OPERATOR(SYM_TILDE);}
"+"                     {STORE_OPERATOR(SYM_PLUS);}
"="                     {STORE_OPERATOR(SYM_EQ);}
"!"                     {STORE_OPERATOR(SYM_NOT);}
"*"                     {STORE_OPERATOR(SYM_AST);}
"/"                     {STORE_OPERATOR(SYM_DIV);}
"|"                     {STORE_OPERATOR(SYM_OR);}
"<"                     {STORE_OPERATOR(SYM_LT);}
">"                     {STORE_OPERATOR(SYM_GT);}
"<>"                    {STORE_OPERATOR(SYM_NOT);}

"_debug"                {STORE_OPERATOR(KEY_UNDERDEBUG);}
"alias"                 {STORE_OPERATOR(KEY_ALIAS);}
"and"                   {STORE_OPERATOR(KEY_AND);}
"autoinstantiate"       {STORE_OPERATOR(KEY_AUTOINSTANTIATE);}
"blob"                  {STORE_OPERATOR(KEY_BLOB);}
"boolean"               {STORE_OPERATOR(KEY_BOOLEAN);}
"call"                  {STORE_OPERATOR(KEY_CALL);}
"case"                  {STORE_OPERATOR(KEY_CASE);}
"char"                  {STORE_OPERATOR(KEY_CHAR);}
"character"             {STORE_OPERATOR(KEY_CHARACTER);}
"choose"                {STORE_OPERATOR(KEY_CHOOSE);}
"close"                 {STORE_OPERATOR(KEY_CLOSE);}
"commit"                {STORE_OPERATOR(KEY_COMMIT);}
"connect"               {STORE_OPERATOR(KEY_CONNECT);}
"constant"              {STORE_OPERATOR(KEY_CONSTANT);}
"continue"              {STORE_OPERATOR(KEY_CONTINUE);}
"create"                {STORE_OPERATOR(KEY_CREATE);}
"cursor"                {STORE_OPERATOR(KEY_CURSOR);}
"date"                  {STORE_OPERATOR(KEY_DATE);}
"datetime"              {STORE_OPERATOR(KEY_DATETIME);}
"dec"                   {STORE_OPERATOR(KEY_DEC);}
"decimal"               {STORE_OPERATOR(KEY_DECIMAL);}
"declare"               {STORE_OPERATOR(KEY_DECLARE);}
"delete"                {STORE_OPERATOR(KEY_DELETE);}
"describe"              {STORE_OPERATOR(KEY_DESCRIBE);}
"descriptor"            {STORE_OPERATOR(KEY_DESCRIPTOR);}
"destroy"               {STORE_OPERATOR(KEY_DESTROY);}
"disconnect"            {STORE_OPERATOR(KEY_DISCONNECT);}
"do"                    {STORE_OPERATOR(KEY_DO);}
"double"                {STORE_OPERATOR(KEY_DOUBLE);}
"dynamic"               {STORE_OPERATOR(KEY_DYNAMIC);}
"else"                  {STORE_OPERATOR(KEY_ELSE);}
"elseif"                {STORE_OPERATOR(KEY_ELSEIF);}
"end"                   {STORE_OPERATOR(KEY_END);}
"enumerated"            {STORE_OPERATOR(KEY_ENUMERATED);}
"event"                 {STORE_OPERATOR(KEY_EVENT);}
"execute"               {STORE_OPERATOR(KEY_EXECUTE);}
"exit"                  {STORE_OPERATOR(KEY_EXIT);}
"external"              {STORE_OPERATOR(KEY_EXTERNAL);}
"fetch"                 {STORE_OPERATOR(KEY_FETCH);}
"first"                 {STORE_OPERATOR(KEY_FIRST);}
"for"                   {STORE_OPERATOR(KEY_FOR);}
"forward"               {STORE_OPERATOR(KEY_FORWARD);}
"from"                  {STORE_OPERATOR(KEY_FROM);}
"function"              {STORE_OPERATOR(KEY_FUNCTION);}
"global"                {STORE_OPERATOR(KEY_GLOBAL);}
"goto"                  {STORE_OPERATOR(KEY_GOTO);}
"halt"                  {STORE_OPERATOR(KEY_HALT);}
"if"                    {STORE_OPERATOR(KEY_IF);}
"immediate"             {STORE_OPERATOR(KEY_IMMEDIATE);}
"indirect"              {STORE_OPERATOR(KEY_INDIRECT);}
"insert"                {STORE_OPERATOR(KEY_INSERT);}
"int"                   {STORE_OPERATOR(KEY_INT);}
"integer"               {STORE_OPERATOR(KEY_INTEGER);}
"into"                  {STORE_OPERATOR(KEY_INTO);}
"intrinsic"             {STORE_OPERATOR(KEY_INTRINSIC);}
"is"                    {STORE_OPERATOR(KEY_IS);}
"last"                  {STORE_OPERATOR(KEY_LAST);}
"library"               {STORE_OPERATOR(KEY_LIBRARY);}
"long"                  {STORE_OPERATOR(KEY_LONG);}
"loop"                  {STORE_OPERATOR(KEY_LOOP);}
"next"                  {STORE_OPERATOR(KEY_NEXT);}
"not"                   {STORE_OPERATOR(KEY_NOT);}
"of"                    {STORE_OPERATOR(KEY_OF);}
"on"                    {STORE_OPERATOR(KEY_ON);}
"open"                  {STORE_OPERATOR(KEY_OPEN);}
"or"                    {STORE_OPERATOR(KEY_OR);}
"parent"                {STORE_OPERATOR(KEY_PARENT);}
"post"                  {STORE_OPERATOR(KEY_POST);}
"prepare"               {STORE_OPERATOR(KEY_PREPARE);}
"prior"                 {STORE_OPERATOR(KEY_PRIOR);}
"private"               {STORE_OPERATOR(KEY_PRIVATE);}
"privateread"           {STORE_OPERATOR(KEY_PRIVATEREAD);}
"privatewrite"          {STORE_OPERATOR(KEY_PRIVATEWRITE);}
"procedure"             {STORE_OPERATOR(KEY_PROCEDURE);}
"protected"             {STORE_OPERATOR(KEY_PROTECTED);}
"protectedread"         {STORE_OPERATOR(KEY_PROTECTEDREAD);}
"protectedwrite"        {STORE_OPERATOR(KEY_PROTECTEDWRITE);}
"prototypes"            {STORE_OPERATOR(KEY_PROTOTYPES);}
"public"                {STORE_OPERATOR(KEY_PUBLIC);}
"readonly"              {STORE_OPERATOR(KEY_READONLY);}
"real"                  {STORE_OPERATOR(KEY_REAL);}
"ref"                   {STORE_OPERATOR(KEY_REF);}
"return"                {STORE_OPERATOR(KEY_RETURN);}
"rollback"              {STORE_OPERATOR(KEY_ROLLBACK);}
"rpcfunc"               {STORE_OPERATOR(KEY_RPCFUNC);}
"select"                {STORE_OPERATOR(KEY_SELECT);}
"selectblob"            {STORE_OPERATOR(KEY_SELECTBLOB);}
"shared"                {STORE_OPERATOR(KEY_SHARED);}
"static"                {STORE_OPERATOR(KEY_STATIC);}
"step"                  {STORE_OPERATOR(KEY_STEP);}
"string"                {STORE_OPERATOR(KEY_STRING);}
"subroutine"            {STORE_OPERATOR(KEY_SUBROUTINE);}
"super"                 {STORE_OPERATOR(KEY_SUPER);}
"system"                {STORE_OPERATOR(KEY_SYSTEM);}
"systemread"            {STORE_OPERATOR(KEY_SYSTEMREAD);}
"systemwrite"           {STORE_OPERATOR(KEY_SYSTEMWRITE);}
"then"                  {STORE_OPERATOR(KEY_THEN);}
"this"                  {STORE_OPERATOR(KEY_THIS);}
"time"                  {STORE_OPERATOR(KEY_TIME);}
"to"                    {STORE_OPERATOR(KEY_TO);}
"trigger"               {STORE_OPERATOR(KEY_TRIGGER);}
"type"                  {STORE_OPERATOR(KEY_TYPE);}
"uint"                  {STORE_OPERATOR(KEY_UINT);}
"ulong"                 {STORE_OPERATOR(KEY_ULONG);}
"unsignedint"           {STORE_OPERATOR(KEY_UNSIGNEDINT);}
"unsignedinteger"       {STORE_OPERATOR(KEY_UNSIGNEDINTEGER);}
"unsignedlong"          {STORE_OPERATOR(KEY_UNSIGNEDLONG);}
"until"                 {STORE_OPERATOR(KEY_UNTIL);}
"update"                {STORE_OPERATOR(KEY_UPDATE);}
"updateblob"            {STORE_OPERATOR(KEY_UPDATEBLOB);}
"using"                 {STORE_OPERATOR(KEY_USING);}
"variables"             {STORE_OPERATOR(KEY_VARIABLES);}
"while"                 {STORE_OPERATOR(KEY_WHILE);}
"with"                  {STORE_OPERATOR(KEY_WITH);}
"within"                {STORE_OPERATOR(KEY_WITHIN);}
"false"                 {STORE_OPERATOR(KEY_FALSE);}
"true"                  {STORE_OPERATOR(KEY_TRUE);}

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

