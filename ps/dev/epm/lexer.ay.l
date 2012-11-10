/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 * Essential Project Manager (EPM)
 * Copyright (c) 2009 PowerSoftware.com
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * TI Assembler parser
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  14-Apr-2009  10402 : File created.
 * CAM  09-Sep-2009  10479 : Added PLOC.
 * CAM  22-Sep-2010  10648 : Converted from string operands to PowerHashed.
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

%{
#include <stdio.h>
#include <string.h>
#include "y.ay.h"
#include "PowerHash.h"

int yylex();

#ifdef WIN32
  #include <io.h>
  #include <set>
  using namespace std;
#else
  #include <stl.h>
  #include <unistd.h>
#endif

int ay_lineno=0;
int j_comments=0;
int c_comments=0;
int cpp_comments=0;
int com_loc=0;
int prev_com_line=-1;
int ploc_count=0;

set<int> sloc;
set<int> operators;
set<unsigned int> operands;

int nsemi=0;           // Number of semi-colons
int noperators=0;      // Total number of operators
int noperands=0;       // Total number of operands

#define NOTE_SLOC()       sloc.insert(ay_lineno)
#define STORE_OPERATOR(X) operators.insert(X); noperators++; NOTE_SLOC();
#define STORE_OPERAND(X)  operands.insert(PowerHash(X)); noperands++; NOTE_SLOC();
#define SEMI()            nsemi++; NOTE_SLOC();

void lexclear();
void remove_sloc(int);

%}
%x DEFINE

NL                                      "\n"
NOTNL                                   .
ANY                                     ({NOTNL}|{NL})
BACKSL                                  "\\"
BOL                                     ^
LETTER                                  [A-Za-z_]
ALNUM                                   [A-Za-z_0-9]
DIGIT                                   [0-9]
HEXDIGIT                                [0-9A-Fa-f]
DIGITS                                  ({DIGIT}+)
EXP                                     [Ee][+-]?DIGITS
HEXDIGITS                               ({HEXDIGIT}+)
SIGN                                    ("+"|"-")
ELL_SUFFIX                              [lL]([lL]?)
INT_SUFFIX                              ([uU]{ELL_SUFFIX}?|{ELL_SUFFIX}[uU]?)
FLOAT_SUFFIX                            [flFL]
STRCHAR                                 [^\"\n\\]
ESCAPE                                  ({BACKSL}{ANY})
QUOTE                                   [\"]
SPTAB                                   [ \t]

%%

\n                                      {ay_lineno++;}

":"                                     {STORE_OPERATOR(SYM_COLON);}
"."                                     {STORE_OPERATOR(SYM_PERIOD);}
","                                     {STORE_OPERATOR(SYM_COMMA);}

^[ \t\v\f]*#                            {NOTE_SLOC(); BEGIN DEFINE;}
<DEFINE>[^\\]\n                         {NOTE_SLOC(); ay_lineno++; ploc_count++; BEGIN 0;}
<DEFINE>\n                              {NOTE_SLOC(); ay_lineno++; ploc_count++;}
<DEFINE>.                               {;}

"algebraic"                             {STORE_OPERATOR(KEY_ALGEBRAIC);}
"align"                                 {STORE_OPERATOR(KEY_ALIGN);}
"asg"                                   {STORE_OPERATOR(KEY_ASG);}
"bes"                                   {STORE_OPERATOR(KEY_BES);}
"break"                                 {STORE_OPERATOR(KEY_BREAK);}
"bss"                                   {STORE_OPERATOR(KEY_BSS);}
"byte"                                  {STORE_OPERATOR(KEY_BYTE);}
"c_mode"                                {STORE_OPERATOR(KEY_C_MODE);}
"char"                                  {STORE_OPERATOR(KEY_CHAR);}
"clink"                                 {STORE_OPERATOR(KEY_CLINK);}
"copy"                                  {STORE_OPERATOR(KEY_COPY);}
"data"                                  {STORE_OPERATOR(KEY_DATA);}
"def"                                   {STORE_OPERATOR(KEY_DEF);}
"double"                                {STORE_OPERATOR(KEY_DOUBLE);}
"drlist"                                {STORE_OPERATOR(KEY_DRLIST);}
"drnolist"                              {STORE_OPERATOR(KEY_DRNOLIST);}
"else"                                  {STORE_OPERATOR(KEY_ELSE);}
"elseif"                                {STORE_OPERATOR(KEY_ELSEIF);}
"emsg"                                  {STORE_OPERATOR(KEY_EMSG);}
"end"                                   {STORE_OPERATOR(KEY_END);}
"endif"                                 {STORE_OPERATOR(KEY_ENDIF);}
"endloop"                               {STORE_OPERATOR(KEY_ENDLOOP);}
"endm"                                  {STORE_OPERATOR(KEY_ENDM);}
"endstruct"                             {STORE_OPERATOR(KEY_ENDSTRUCT);}
"endunion"                              {STORE_OPERATOR(KEY_ENDUNION);}
"equ"                                   {STORE_OPERATOR(KEY_EQU);}
"eval"                                  {STORE_OPERATOR(KEY_EVAL);}
"even"                                  {STORE_OPERATOR(KEY_EVEN);}
"far_mode"                              {STORE_OPERATOR(KEY_FAR_MODE);}
"fclist"                                {STORE_OPERATOR(KEY_FCLIST);}
"fcnolist"                              {STORE_OPERATOR(KEY_FCNOLIST);}
"field"                                 {STORE_OPERATOR(KEY_FIELD);}
"float"                                 {STORE_OPERATOR(KEY_FLOAT);}
"global"                                {STORE_OPERATOR(KEY_GLOBAL);}
"half"                                  {STORE_OPERATOR(KEY_HALF);}
"if"                                    {STORE_OPERATOR(KEY_IF);}
"include"                               {STORE_OPERATOR(KEY_INCLUDE);}
"int"                                   {STORE_OPERATOR(KEY_INT);}
"label"                                 {STORE_OPERATOR(KEY_LABEL);}
"ldouble"                               {STORE_OPERATOR(KEY_LDOUBLE);}
"length"                                {STORE_OPERATOR(KEY_LENGTH);}
"list"                                  {STORE_OPERATOR(KEY_LIST);}
"long"                                  {STORE_OPERATOR(KEY_LONG);}
"loop"                                  {STORE_OPERATOR(KEY_LOOP);}
"macro"                                 {STORE_OPERATOR(KEY_MACRO);}
"mexit"                                 {STORE_OPERATOR(KEY_MEXIT);}
"mlib"                                  {STORE_OPERATOR(KEY_MLIB);}
"mlist"                                 {STORE_OPERATOR(KEY_MLIST);}
"mmregs"                                {STORE_OPERATOR(KEY_MMREGS);}
"mmsg"                                  {STORE_OPERATOR(KEY_MMSG);}
"mnolist"                               {STORE_OPERATOR(KEY_MNOLIST);}
"newblock"                              {STORE_OPERATOR(KEY_NEWBLOCK);}
"nolist"                                {STORE_OPERATOR(KEY_NOLIST);}
"noremark"                              {STORE_OPERATOR(KEY_NOREMARK);}
"option"                                {STORE_OPERATOR(KEY_OPTION);}
"page"                                  {STORE_OPERATOR(KEY_PAGE);}
"pstring"                               {STORE_OPERATOR(KEY_PSTRING);}
"ref"                                   {STORE_OPERATOR(KEY_REF);}
"remark"                                {STORE_OPERATOR(KEY_REMARK);}
"sblock"                                {STORE_OPERATOR(KEY_SBLOCK);}
"sect"                                  {STORE_OPERATOR(KEY_SECT);}
"set"                                   {STORE_OPERATOR(KEY_SET);}
"short"                                 {STORE_OPERATOR(KEY_SHORT);}
"space"                                 {STORE_OPERATOR(KEY_SPACE);}
"sslist"                                {STORE_OPERATOR(KEY_SSLIST);}
"ssnolist"                              {STORE_OPERATOR(KEY_SSNOLIST);}
"string"                                {STORE_OPERATOR(KEY_STRING);}
"struct"                                {STORE_OPERATOR(KEY_STRUCT);}
"tab"                                   {STORE_OPERATOR(KEY_TAB);}
"tag"                                   {STORE_OPERATOR(KEY_TAG);}
"text"                                  {STORE_OPERATOR(KEY_TEXT);}
"title"                                 {STORE_OPERATOR(KEY_TITLE);}
"ubyte"                                 {STORE_OPERATOR(KEY_UBYTE);}
"uchar"                                 {STORE_OPERATOR(KEY_UCHAR);}
"uhalf"                                 {STORE_OPERATOR(KEY_UHALF);}
"uint"                                  {STORE_OPERATOR(KEY_UINT);}
"ulong"                                 {STORE_OPERATOR(KEY_ULONG);}
"union"                                 {STORE_OPERATOR(KEY_UNION);}
"usect"                                 {STORE_OPERATOR(KEY_USECT);}
"ushort"                                {STORE_OPERATOR(KEY_USHORT);}
"uword"                                 {STORE_OPERATOR(KEY_UWORD);}
"var"                                   {STORE_OPERATOR(KEY_VAR);}
"version"                               {STORE_OPERATOR(KEY_VERSION);}
"width"                                 {STORE_OPERATOR(KEY_WIDTH);}
"wmsg"                                  {STORE_OPERATOR(KEY_WMSG);}
"word"                                  {STORE_OPERATOR(KEY_WORD);}
"xfloat"                                {STORE_OPERATOR(KEY_XFLOAT);}
"xlong"                                 {STORE_OPERATOR(KEY_XLONG);}

{LETTER}{ALNUM}*                                            |
[1-9][0-9]*{INT_SUFFIX}?                                    |
[0][0-7]*{INT_SUFFIX}?                                      |
[0-9A-Fa-f]+h                                               |
[0][xX]                                                     |
{DIGITS}"."{DIGITS}?([eE]{SIGN}?{DIGITS})?{FLOAT_SUFFIX}?   |
{DIGITS}"."?([eE]{SIGN}?{DIGITS})?{FLOAT_SUFFIX}?           |
"."{DIGITS}([eE]{SIGN}?{DIGITS})?{FLOAT_SUFFIX}?            |
{DIGITS}"."{DIGITS}?[eE]{SIGN}?                             |
{DIGITS}"."?[eE]{SIGN}?                                     |
"."{DIGITS}[eE]{SIGN}?                                      {STORE_OPERAND(yytext);}

";"{NOTNL}*{NL}                         {cpp_comments++;com_loc++;ay_lineno++; /* To EOL Comments */}
"*"{NOTNL}*{NL}                         {c_comments++;com_loc++;remove_sloc(ay_lineno++); /* Whole line is comment and must be excluded from SLOC */}

[ \t\v\f]                               { /* ignore whitespace     */ }
.                                       { /* ignore bad characters */ }

%%

int yywrap() {
        return(1);
}

void lexclear() {
  BEGIN 0;
  noperands=0;
  j_comments=c_comments=cpp_comments=com_loc=ploc_count=0;
  prev_com_line=-1;
  ay_lineno=nsemi=noperators=0;

  sloc.clear();
  operators.clear();
  operands.clear();
}

void remove_sloc(int lineno) {
  // The current line is not SLOC
  set<int>::iterator iter = sloc.begin();
  while (iter != sloc.end())
  {
    if (*iter == lineno)
    {
      sloc.erase(iter++);
    }
    else
    {
      ++iter;
    }
  }
}