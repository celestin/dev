/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 * Essential Project Manager (EPM)
 * Copyright (c) 2009 Power Software
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * TI Assembler parser
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  14-Apr-2009  10402 : File created.
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

%{
#include <stdio.h>
#include <string.h>
#include "y.ay.h"

int yylex();

#ifdef WIN32
  #include <io.h>
  #include <vector>
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

set<int> sloc;
set<int> operators;
vector<char*> operands[255];

int nsemi=0;           // Number of semi-colons
int noperators=0;      // Total number of operators
int noperands=0;       // Total number of operands

#define STORE_OPERATOR(X) operators.insert(X); noperators++;
#define SEMI() nsemi++;
#define COUNT() sloc.insert(ay_lineno)

void lexclear();
void store_operand(char*);
void remove_sloc(int);

%}


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

":"                                     {STORE_OPERATOR(SYM_COLON);COUNT();}
"."                                     {STORE_OPERATOR(SYM_PERIOD);COUNT();}
","                                     {STORE_OPERATOR(SYM_COMMA);COUNT();}
"#"                                     {STORE_OPERATOR(SYM_HASH);COUNT();}

"algebraic"                             {STORE_OPERATOR(KEY_ALGEBRAIC);COUNT();}
"align"                                 {STORE_OPERATOR(KEY_ALIGN);COUNT();}
"asg"                                   {STORE_OPERATOR(KEY_ASG);COUNT();}
"bes"                                   {STORE_OPERATOR(KEY_BES);COUNT();}
"break"                                 {STORE_OPERATOR(KEY_BREAK);COUNT();}
"bss"                                   {STORE_OPERATOR(KEY_BSS);COUNT();}
"byte"                                  {STORE_OPERATOR(KEY_BYTE);COUNT();}
"c_mode"                                {STORE_OPERATOR(KEY_C_MODE);COUNT();}
"char"                                  {STORE_OPERATOR(KEY_CHAR);COUNT();}
"clink"                                 {STORE_OPERATOR(KEY_CLINK);COUNT();}
"copy"                                  {STORE_OPERATOR(KEY_COPY);COUNT();}
"data"                                  {STORE_OPERATOR(KEY_DATA);COUNT();}
"def"                                   {STORE_OPERATOR(KEY_DEF);COUNT();}
"double"                                {STORE_OPERATOR(KEY_DOUBLE);COUNT();}
"drlist"                                {STORE_OPERATOR(KEY_DRLIST);COUNT();}
"drnolist"                              {STORE_OPERATOR(KEY_DRNOLIST);COUNT();}
"else"                                  {STORE_OPERATOR(KEY_ELSE);COUNT();}
"elseif"                                {STORE_OPERATOR(KEY_ELSEIF);COUNT();}
"emsg"                                  {STORE_OPERATOR(KEY_EMSG);COUNT();}
"end"                                   {STORE_OPERATOR(KEY_END);COUNT();}
"endif"                                 {STORE_OPERATOR(KEY_ENDIF);COUNT();}
"endloop"                               {STORE_OPERATOR(KEY_ENDLOOP);COUNT();}
"endm"                                  {STORE_OPERATOR(KEY_ENDM);COUNT();}
"endstruct"                             {STORE_OPERATOR(KEY_ENDSTRUCT);COUNT();}
"endunion"                              {STORE_OPERATOR(KEY_ENDUNION);COUNT();}
"equ"                                   {STORE_OPERATOR(KEY_EQU);COUNT();}
"eval"                                  {STORE_OPERATOR(KEY_EVAL);COUNT();}
"even"                                  {STORE_OPERATOR(KEY_EVEN);COUNT();}
"far_mode"                              {STORE_OPERATOR(KEY_FAR_MODE);COUNT();}
"fclist"                                {STORE_OPERATOR(KEY_FCLIST);COUNT();}
"fcnolist"                              {STORE_OPERATOR(KEY_FCNOLIST);COUNT();}
"field"                                 {STORE_OPERATOR(KEY_FIELD);COUNT();}
"float"                                 {STORE_OPERATOR(KEY_FLOAT);COUNT();}
"global"                                {STORE_OPERATOR(KEY_GLOBAL);COUNT();}
"half"                                  {STORE_OPERATOR(KEY_HALF);COUNT();}
"if"                                    {STORE_OPERATOR(KEY_IF);COUNT();}
"include"                               {STORE_OPERATOR(KEY_INCLUDE);COUNT();}
"int"                                   {STORE_OPERATOR(KEY_INT);COUNT();}
"label"                                 {STORE_OPERATOR(KEY_LABEL);COUNT();}
"ldouble"                               {STORE_OPERATOR(KEY_LDOUBLE);COUNT();}
"length"                                {STORE_OPERATOR(KEY_LENGTH);COUNT();}
"list"                                  {STORE_OPERATOR(KEY_LIST);COUNT();}
"long"                                  {STORE_OPERATOR(KEY_LONG);COUNT();}
"loop"                                  {STORE_OPERATOR(KEY_LOOP);COUNT();}
"macro"                                 {STORE_OPERATOR(KEY_MACRO);COUNT();}
"mexit"                                 {STORE_OPERATOR(KEY_MEXIT);COUNT();}
"mlib"                                  {STORE_OPERATOR(KEY_MLIB);COUNT();}
"mlist"                                 {STORE_OPERATOR(KEY_MLIST);COUNT();}
"mmregs"                                {STORE_OPERATOR(KEY_MMREGS);COUNT();}
"mmsg"                                  {STORE_OPERATOR(KEY_MMSG);COUNT();}
"mnolist"                               {STORE_OPERATOR(KEY_MNOLIST);COUNT();}
"newblock"                              {STORE_OPERATOR(KEY_NEWBLOCK);COUNT();}
"nolist"                                {STORE_OPERATOR(KEY_NOLIST);COUNT();}
"noremark"                              {STORE_OPERATOR(KEY_NOREMARK);COUNT();}
"option"                                {STORE_OPERATOR(KEY_OPTION);COUNT();}
"page"                                  {STORE_OPERATOR(KEY_PAGE);COUNT();}
"pstring"                               {STORE_OPERATOR(KEY_PSTRING);COUNT();}
"ref"                                   {STORE_OPERATOR(KEY_REF);COUNT();}
"remark"                                {STORE_OPERATOR(KEY_REMARK);COUNT();}
"sblock"                                {STORE_OPERATOR(KEY_SBLOCK);COUNT();}
"sect"                                  {STORE_OPERATOR(KEY_SECT);COUNT();}
"set"                                   {STORE_OPERATOR(KEY_SET);COUNT();}
"short"                                 {STORE_OPERATOR(KEY_SHORT);COUNT();}
"space"                                 {STORE_OPERATOR(KEY_SPACE);COUNT();}
"sslist"                                {STORE_OPERATOR(KEY_SSLIST);COUNT();}
"ssnolist"                              {STORE_OPERATOR(KEY_SSNOLIST);COUNT();}
"string"                                {STORE_OPERATOR(KEY_STRING);COUNT();}
"struct"                                {STORE_OPERATOR(KEY_STRUCT);COUNT();}
"tab"                                   {STORE_OPERATOR(KEY_TAB);COUNT();}
"tag"                                   {STORE_OPERATOR(KEY_TAG);COUNT();}
"text"                                  {STORE_OPERATOR(KEY_TEXT);COUNT();}
"title"                                 {STORE_OPERATOR(KEY_TITLE);COUNT();}
"ubyte"                                 {STORE_OPERATOR(KEY_UBYTE);COUNT();}
"uchar"                                 {STORE_OPERATOR(KEY_UCHAR);COUNT();}
"uhalf"                                 {STORE_OPERATOR(KEY_UHALF);COUNT();}
"uint"                                  {STORE_OPERATOR(KEY_UINT);COUNT();}
"ulong"                                 {STORE_OPERATOR(KEY_ULONG);COUNT();}
"union"                                 {STORE_OPERATOR(KEY_UNION);COUNT();}
"usect"                                 {STORE_OPERATOR(KEY_USECT);COUNT();}
"ushort"                                {STORE_OPERATOR(KEY_USHORT);COUNT();}
"uword"                                 {STORE_OPERATOR(KEY_UWORD);COUNT();}
"var"                                   {STORE_OPERATOR(KEY_VAR);COUNT();}
"version"                               {STORE_OPERATOR(KEY_VERSION);COUNT();}
"width"                                 {STORE_OPERATOR(KEY_WIDTH);COUNT();}
"wmsg"                                  {STORE_OPERATOR(KEY_WMSG);COUNT();}
"word"                                  {STORE_OPERATOR(KEY_WORD);COUNT();}
"xfloat"                                {STORE_OPERATOR(KEY_XFLOAT);COUNT();}
"xlong"                                 {STORE_OPERATOR(KEY_XLONG);COUNT();}

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
"."{DIGITS}[eE]{SIGN}?                                      {store_operand(_strdup(yytext));COUNT();}

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
  j_comments=c_comments=cpp_comments=com_loc=0;
  prev_com_line=-1;
  ay_lineno=nsemi=noperators=0;

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