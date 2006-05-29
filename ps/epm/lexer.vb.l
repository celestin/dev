/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 * Essential Project Manager (EPM)
 * Copyright (c) 2004-2005 Power Software
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * VB Parser
 *
 * $Id$
 *
 * Who  When       Why
 * CAM  11-May-05    96 : File created.
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
#include "y.vb.h"

#ifdef WIN32

#include <io.h>
#include <vector>
#include <set>
using namespace std;

#else

#include <stl.h>
#include <unistd.h>

#endif

int vb_lineno=0;
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

void lexclear() {
  BEGIN 0;
  noperands=0;
  j_comments=c_comments=cpp_comments=com_loc=0;
  prev_com_line=-1;
  vb_lineno=nsemi=noperators=0;

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

  sloc.insert(vb_lineno);
}

void store_operator(int op) {
  operators.insert(op);
  noperators++;
  sloc.insert(vb_lineno);
}

void string_literal();
void eol_comment_skip();

%}

%p 3500
%x DEFINE

%%

"'"                     {eol_comment_skip(); }
"REM"                   {eol_comment_skip(); }

^[ \t\v\f]*#            {sloc.insert(vb_lineno); BEGIN DEFINE;}
<DEFINE>[^\\]"\n"       {sloc.insert(vb_lineno); vb_lineno++; BEGIN 0;}
<DEFINE>"\n"            {sloc.insert(vb_lineno); vb_lineno++;}
<DEFINE>.               {;}

"AddHandler"            {store_operator(ADD_HANDLER);}
"AddressOf"             {store_operator(ADDRESS_OF);}
"Alias"                 {store_operator(ALIAS);}
"And"                   {store_operator(AND);}
"AndAlso"               {store_operator(AND_ALSO);}
"Ansi"                  {store_operator(ANSI);}
"As"                    {store_operator(AS);}
"Assembly"              {store_operator(ASSEMBLY);}
"Auto"                  {store_operator(AUTO);}
"Boolean"               {store_operator(BOOLEAN);}
"ByRef"                 {store_operator(BY_REF);}
"ByVal"                 {store_operator(BY_VAL);}
"Byte"                  {store_operator(BYTE);}
"CBool"                 {store_operator(CBOOL);}
"CByte"                 {store_operator(CBYTE);}
"CChar"                 {store_operator(CCHAR);}
"CDate"                 {store_operator(CDATE);}
"CDbl"                  {store_operator(CDBL);}
"CDec"                  {store_operator(CDEC);}
"CInt"                  {store_operator(CINT);}
"CLng"                  {store_operator(CLNG);}
"CObj"                  {store_operator(COBJ);}
"CShort"                {store_operator(CSHORT);}
"CSng"                  {store_operator(CSNG);}
"CStr"                  {store_operator(CSTR);}
"CType"                 {store_operator(CTYPE);}
"Call"                  {store_operator(CALL);}
"Case"                  {store_operator(CASE);}
"Catch"                 {store_operator(CATCH);}
"Char"                  {store_operator(CHAR);}
"Class"                 {store_operator(CLASS);}
"Const"                 {store_operator(CONST);}
"Date"                  {store_operator(DATE);}
"Decimal"               {store_operator(DECIMAL);}
"Declare"               {store_operator(DECLARE);}
"Default"               {store_operator(DEFAULT);}
"Delegate"              {store_operator(DELEGATE);}
"Dim"                   {store_operator(DIM);}
"DirectCast"            {store_operator(DIRECT_CAST);}
"Do"                    {store_operator(DO);}
"Double"                {store_operator(DOUBLE);}
"Each"                  {store_operator(EACH);}
"Else"                  {store_operator(ELSE);}
"ElseIf"                {store_operator(ELSE_IF);}
"End"                   {store_operator(END);}
"EndIf"                 {store_operator(END_IF);}
"Enum"                  {store_operator(ENUM);}
"Erase"                 {store_operator(ERASE);}
"Error"                 {store_operator(ERROR);}
"Event"                 {store_operator(EVENT);}
"Exit"                  {store_operator(EXIT);}
"False"                 {store_operator(FALSE);}
"Finally"               {store_operator(FINALLY);}
"For"                   {store_operator(FOR);}
"Friend"                {store_operator(FRIEND);}
"Function"              {store_operator(FUNCTION);}
"Get"                   {store_operator(GET);}
"GetType"               {store_operator(GET_TYPE);}
"GoSub"                 {store_operator(GOSUB);}
"GoTo"                  {store_operator(GOTO);}
"Handles"               {store_operator(HANDLES);}
"If"                    {store_operator(IF);}
"Implements"            {store_operator(IMPLEMENTS);}
"Imports"               {store_operator(IMPORTS);}
"In"                    {store_operator(IN);}
"Inherits"              {store_operator(INHERITS);}
"Integer"               {store_operator(INTEGER);}
"Interface"             {store_operator(INTERFACE);}
"Is"                    {store_operator(IS);}
"Let"                   {store_operator(LET);}
"Lib"                   {store_operator(LIB);}
"Like"                  {store_operator(LIKE);}
"Long"                  {store_operator(LONG);}
"Loop"                  {store_operator(LOOP);}
"Me"                    {store_operator(ME);}
"Mod"                   {store_operator(MODULUS);}
"Module"                {store_operator(MODULE);}
"MustInherit"           {store_operator(MUST_INHERIT);}
"MustOverride"          {store_operator(MUST_OVERRIDE);}
"MyBase"                {store_operator(MY_BASE);}
"MyClass"               {store_operator(MY_CLASS);}
"Namespace"             {store_operator(NAMESPACE);}
"New"                   {store_operator(NEW);}
"Next"                  {store_operator(NEXT);}
"Not"                   {store_operator(NOT);}
"NotInheritable"        {store_operator(NOT_INHERITABLE);}
"NotOverridable"        {store_operator(NOT_OVERRIDABLE);}
"Nothing"               {store_operator(NOTHING);}
"Object"                {store_operator(OBJECT);}
"On"                    {store_operator(ON);}
"Option"                {store_operator(OPTION);}
"Optional"              {store_operator(OPTIONAL);}
"Or"                    {store_operator(OR);}
"OrElse"                {store_operator(OR_ELSE);}
"Overloads"             {store_operator(OVERLOADS);}
"Overridable"           {store_operator(OVERRIDABLE);}
"Overrides"             {store_operator(OVERRIDES);}
"ParamArray"            {store_operator(PARAM_ARRAY);}
"Preserve"              {store_operator(PRESERVE);}
"Private"               {store_operator(PRIVATE);}
"Property"              {store_operator(PROPERTY);}
"Protected"             {store_operator(PROTECTED);}
"Public"                {store_operator(PUBLIC);}
"RaiseEvent"            {store_operator(RAISE_EVENT);}
"ReDim"                 {store_operator(RE_DIM);}
"ReadOnly"              {store_operator(READ_ONLY);}
"RemoveHandler"         {store_operator(REMOVE_HANDLER);}
"Resume"                {store_operator(RESUME);}
"Return"                {store_operator(RETURN);}
"Select"                {store_operator(SELECT);}
"Set"                   {store_operator(SET);}
"Shadows"               {store_operator(SHADOWS);}
"Shared"                {store_operator(SHARED);}
"Short"                 {store_operator(SHORT);}
"Single"                {store_operator(SINGLE);}
"Static"                {store_operator(STATIC);}
"Step"                  {store_operator(STEP);}
"Stop"                  {store_operator(STOP);}
"String"                {store_operator(STRING);}
"Structure"             {store_operator(STRUCTURE);}
"Sub"                   {store_operator(SUB);}
"SyncLock"              {store_operator(SYNC_LOCK);}
"Then"                  {store_operator(THEN);}
"Throw"                 {store_operator(THROW);}
"To"                    {store_operator(TO);}
"True"                  {store_operator(TRUE);}
"Try"                   {store_operator(TRY);}
"TypeOf"                {store_operator(TYPEOF);}
"Unicode"               {store_operator(UNICODE);}
"Until"                 {store_operator(UNTIL);}
"Variant"               {store_operator(VARIANT);}
"Wend"                  {store_operator(WEND);}
"When"                  {store_operator(WHEN);}
"While"                 {store_operator(WHILE);}
"With"                  {store_operator(WITH);}
"WithEvents"            {store_operator(WITH_EVENTS);}
"WriteOnly"             {store_operator(WRITE_ONLY);}
"Xor"                   {store_operator(XOR);}

{L}({L}|{D})*           {store_operand(strdup(yytext));}
0[xX]{H}+{IS}?          {store_operand(strdup(yytext));}
0{D}+{IS}?              {store_operand(strdup(yytext));}
{D}+{IS}?               {store_operand(strdup(yytext));}
'(\\.|[^\\'])+'         {store_operand(strdup(yytext));}
{D}+{E}{FS}?            {store_operand(strdup(yytext));}
{D}*"."{D}+({E})?{FS}?  {store_operand(strdup(yytext));}
{D}+"."{D}*({E})?{FS}?  {store_operand(strdup(yytext));}
\"                      {sloc.insert(vb_lineno); string_literal();}

"&"                     {store_operator(CONCAT);}
"*"                     {store_operator(ASTERISK);}
"+"                     {store_operator(PLUS);}
"-"                     {store_operator(MINUS);}
"/"                     {store_operator(SLASH);}
"<"                     {store_operator(LESS_THAN);}
"<<"                    {store_operator(SHIFT_LEFT);}
"<="                    {store_operator(LESS_EQUAL);}
"<>"                    {store_operator(NOT_EQUAL);}
"="                     {store_operator(EQUAL);}
">"                     {store_operator(GREATER_THAN);}
">="                    {store_operator(GREATER_EQUAL);}
">>"                    {store_operator(SHIFT_RIGHT);}
"\\"                    {store_operator(INT_DIVIDE);}
"^"                     {store_operator(EXPONENT);}

[ \t\v\f]               {;}
"\n"                    {vb_lineno++;}
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

  sloc.insert(vb_lineno);
}


void eol_comment_skip() {
  char c;

  while (((c=yyinput()) !='\n') && (c!=0) && (c!=EOF)) ;

  cpp_comments++;

  if (vb_lineno!=prev_com_line)
    com_loc++;

  prev_com_line=vb_lineno;
  if (c=='\n') vb_lineno++;
}