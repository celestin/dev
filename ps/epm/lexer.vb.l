/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 * Essential Project Manager (EPM)
 * Copyright (c) 2004-2005 PowerSoftware.com
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * VB Parser
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  11-May-05    96 : File created.
 * CAM  24-Apr-08    358 : Corrected compiler warnings moving to VS2008 (from VC++6).
 * CAM  22-Sep-2010  10648 : Converted from string operands to PowerHashed.
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

%{

#include <stdio.h>
#include <string.h>
#include "y.vb.h"
#include "PowerHash.h"

#ifdef WIN32

#include <io.h>
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
set<unsigned int> operands;
int nsemi=0 ;           // Number of semi-colons
int noperators=0 ;      // Total number of operators
int noperands=0;        // Total number of operands

#define NOTE_SLOC()       sloc.insert(vb_lineno)
#define STORE_OPERATOR(X) operators.insert(X); noperators++; NOTE_SLOC();
#define STORE_OPERAND(X)  operands.insert(PowerHash(X)); noperands++; NOTE_SLOC();
#define SEMI()            nsemi++; NOTE_SLOC();

void lexclear();

%}

%p 3500
%x DEFINE

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

\n                      {vb_lineno++;}

^[ \t\v\f]*#            {NOTE_SLOC(); BEGIN DEFINE;}
<DEFINE>[^\\]"\n"       {NOTE_SLOC(); vb_lineno++; BEGIN 0;}
<DEFINE>"\n"            {NOTE_SLOC(); vb_lineno++;}
<DEFINE>.               {;}

\".*\"                  {STORE_OPERAND(yytext);}

"&"                     {STORE_OPERATOR(CONCAT);}
"*"                     {STORE_OPERATOR(ASTERISK);}
"+"                     {STORE_OPERATOR(PLUS);}
"-"                     {STORE_OPERATOR(MINUS);}
"/"                     {STORE_OPERATOR(SLASH);}
"<"                     {STORE_OPERATOR(LESS_THAN);}
"<<"                    {STORE_OPERATOR(SHIFT_LEFT);}
"<="                    {STORE_OPERATOR(LESS_EQUAL);}
"<>"                    {STORE_OPERATOR(NOT_EQUAL);}
"="                     {STORE_OPERATOR(EQUAL);}
">"                     {STORE_OPERATOR(GREATER_THAN);}
">="                    {STORE_OPERATOR(GREATER_EQUAL);}
">>"                    {STORE_OPERATOR(SHIFT_RIGHT);}
"\\"                    {STORE_OPERATOR(INT_DIVIDE);}
"^"                     {STORE_OPERATOR(EXPONENT);}

"AddHandler"            {STORE_OPERATOR(ADD_HANDLER);}
"AddressOf"             {STORE_OPERATOR(ADDRESS_OF);}
"Alias"                 {STORE_OPERATOR(ALIAS);}
"And"                   {STORE_OPERATOR(AND);}
"AndAlso"               {STORE_OPERATOR(AND_ALSO);}
"Ansi"                  {STORE_OPERATOR(ANSI);}
"As"                    {STORE_OPERATOR(AS);}
"Assembly"              {STORE_OPERATOR(ASSEMBLY);}
"Auto"                  {STORE_OPERATOR(AUTO);}
"Boolean"               {STORE_OPERATOR(BOOLEAN);}
"ByRef"                 {STORE_OPERATOR(BY_REF);}
"ByVal"                 {STORE_OPERATOR(BY_VAL);}
"Byte"                  {STORE_OPERATOR(BYTE);}
"CBool"                 {STORE_OPERATOR(CBOOL);}
"CByte"                 {STORE_OPERATOR(CBYTE);}
"CChar"                 {STORE_OPERATOR(CCHAR);}
"CDate"                 {STORE_OPERATOR(CDATE);}
"CDbl"                  {STORE_OPERATOR(CDBL);}
"CDec"                  {STORE_OPERATOR(CDEC);}
"CInt"                  {STORE_OPERATOR(CINT);}
"CLng"                  {STORE_OPERATOR(CLNG);}
"CObj"                  {STORE_OPERATOR(COBJ);}
"CShort"                {STORE_OPERATOR(CSHORT);}
"CSng"                  {STORE_OPERATOR(CSNG);}
"CStr"                  {STORE_OPERATOR(CSTR);}
"CType"                 {STORE_OPERATOR(CTYPE);}
"Call"                  {STORE_OPERATOR(CALL);}
"Case"                  {STORE_OPERATOR(CASE);}
"Catch"                 {STORE_OPERATOR(CATCH);}
"Char"                  {STORE_OPERATOR(CHAR);}
"Class"                 {STORE_OPERATOR(CLASS);}
"Const"                 {STORE_OPERATOR(CONST);}
"Date"                  {STORE_OPERATOR(DATE);}
"Decimal"               {STORE_OPERATOR(DECIMAL);}
"Declare"               {STORE_OPERATOR(DECLARE);}
"Default"               {STORE_OPERATOR(DEFAULT);}
"Delegate"              {STORE_OPERATOR(DELEGATE);}
"Dim"                   {STORE_OPERATOR(DIM);}
"DirectCast"            {STORE_OPERATOR(DIRECT_CAST);}
"Do"                    {STORE_OPERATOR(DO);}
"Double"                {STORE_OPERATOR(DOUBLE);}
"Each"                  {STORE_OPERATOR(EACH);}
"Else"                  {STORE_OPERATOR(ELSE);}
"ElseIf"                {STORE_OPERATOR(ELSE_IF);}
"End"                   {STORE_OPERATOR(END);}
"EndIf"                 {STORE_OPERATOR(END_IF);}
"Enum"                  {STORE_OPERATOR(ENUM);}
"Erase"                 {STORE_OPERATOR(ERASE);}
"Error"                 {STORE_OPERATOR(ERROR);}
"Event"                 {STORE_OPERATOR(EVENT);}
"Exit"                  {STORE_OPERATOR(EXIT);}
"False"                 {STORE_OPERATOR(FALSE);}
"Finally"               {STORE_OPERATOR(FINALLY);}
"For"                   {STORE_OPERATOR(FOR);}
"Friend"                {STORE_OPERATOR(FRIEND);}
"Function"              {STORE_OPERATOR(FUNCTION);}
"Get"                   {STORE_OPERATOR(GET);}
"GetType"               {STORE_OPERATOR(GET_TYPE);}
"GoSub"                 {STORE_OPERATOR(GOSUB);}
"GoTo"                  {STORE_OPERATOR(GOTO);}
"Handles"               {STORE_OPERATOR(HANDLES);}
"If"                    {STORE_OPERATOR(IF);}
"Implements"            {STORE_OPERATOR(IMPLEMENTS);}
"Imports"               {STORE_OPERATOR(IMPORTS);}
"In"                    {STORE_OPERATOR(IN);}
"Inherits"              {STORE_OPERATOR(INHERITS);}
"Integer"               {STORE_OPERATOR(INTEGER);}
"Interface"             {STORE_OPERATOR(INTERFACE);}
"Is"                    {STORE_OPERATOR(IS);}
"Let"                   {STORE_OPERATOR(LET);}
"Lib"                   {STORE_OPERATOR(LIB);}
"Like"                  {STORE_OPERATOR(LIKE);}
"Long"                  {STORE_OPERATOR(LONG);}
"Loop"                  {STORE_OPERATOR(LOOP);}
"Me"                    {STORE_OPERATOR(ME);}
"Mod"                   {STORE_OPERATOR(MODULUS);}
"Module"                {STORE_OPERATOR(MODULE);}
"MustInherit"           {STORE_OPERATOR(MUST_INHERIT);}
"MustOverride"          {STORE_OPERATOR(MUST_OVERRIDE);}
"MyBase"                {STORE_OPERATOR(MY_BASE);}
"MyClass"               {STORE_OPERATOR(MY_CLASS);}
"Namespace"             {STORE_OPERATOR(NAMESPACE);}
"New"                   {STORE_OPERATOR(NEW);}
"Next"                  {STORE_OPERATOR(NEXT);}
"Not"                   {STORE_OPERATOR(NOT);}
"NotInheritable"        {STORE_OPERATOR(NOT_INHERITABLE);}
"NotOverridable"        {STORE_OPERATOR(NOT_OVERRIDABLE);}
"Nothing"               {STORE_OPERATOR(NOTHING);}
"Object"                {STORE_OPERATOR(OBJECT);}
"On"                    {STORE_OPERATOR(ON);}
"Option"                {STORE_OPERATOR(OPTION);}
"Optional"              {STORE_OPERATOR(OPTIONAL);}
"Or"                    {STORE_OPERATOR(OR);}
"OrElse"                {STORE_OPERATOR(OR_ELSE);}
"Overloads"             {STORE_OPERATOR(OVERLOADS);}
"Overridable"           {STORE_OPERATOR(OVERRIDABLE);}
"Overrides"             {STORE_OPERATOR(OVERRIDES);}
"ParamArray"            {STORE_OPERATOR(PARAM_ARRAY);}
"Preserve"              {STORE_OPERATOR(PRESERVE);}
"Private"               {STORE_OPERATOR(PRIVATE);}
"Property"              {STORE_OPERATOR(PROPERTY);}
"Protected"             {STORE_OPERATOR(PROTECTED);}
"Public"                {STORE_OPERATOR(PUBLIC);}
"RaiseEvent"            {STORE_OPERATOR(RAISE_EVENT);}
"ReDim"                 {STORE_OPERATOR(RE_DIM);}
"ReadOnly"              {STORE_OPERATOR(READ_ONLY);}
"RemoveHandler"         {STORE_OPERATOR(REMOVE_HANDLER);}
"Resume"                {STORE_OPERATOR(RESUME);}
"Return"                {STORE_OPERATOR(RETURN);}
"Select"                {STORE_OPERATOR(SELECT);}
"Set"                   {STORE_OPERATOR(SET);}
"Shadows"               {STORE_OPERATOR(SHADOWS);}
"Shared"                {STORE_OPERATOR(SHARED);}
"Short"                 {STORE_OPERATOR(SHORT);}
"Single"                {STORE_OPERATOR(SINGLE);}
"Static"                {STORE_OPERATOR(STATIC);}
"Step"                  {STORE_OPERATOR(STEP);}
"Stop"                  {STORE_OPERATOR(STOP);}
"String"                {STORE_OPERATOR(STRING);}
"Structure"             {STORE_OPERATOR(STRUCTURE);}
"Sub"                   {STORE_OPERATOR(SUB);}
"SyncLock"              {STORE_OPERATOR(SYNC_LOCK);}
"Then"                  {STORE_OPERATOR(THEN);}
"Throw"                 {STORE_OPERATOR(THROW);}
"To"                    {STORE_OPERATOR(TO);}
"True"                  {STORE_OPERATOR(TRUE);}
"Try"                   {STORE_OPERATOR(TRY);}
"TypeOf"                {STORE_OPERATOR(TYPEOF);}
"Unicode"               {STORE_OPERATOR(UNICODE);}
"Until"                 {STORE_OPERATOR(UNTIL);}
"Variant"               {STORE_OPERATOR(VARIANT);}
"Wend"                  {STORE_OPERATOR(WEND);}
"When"                  {STORE_OPERATOR(WHEN);}
"While"                 {STORE_OPERATOR(WHILE);}
"With"                  {STORE_OPERATOR(WITH);}
"WithEvents"            {STORE_OPERATOR(WITH_EVENTS);}
"WriteOnly"             {STORE_OPERATOR(WRITE_ONLY);}
"Xor"                   {STORE_OPERATOR(XOR);}

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

"'"{NOTNL}*{NL}         |
"REM "{NOTNL}*{NL}      {cpp_comments++;com_loc++;vb_lineno++;}

[ \t\v\f]*              {;}
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
  vb_lineno=nsemi=noperators=0;

  sloc.clear();
  operators.clear();
  operands.clear();
}
