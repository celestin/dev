/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 * Essential Project Manager (EPM)
 * Copyright (c) 2004,2009 SourceCodeMetrics.com
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * PHP Parser
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  04-Nov-06    301 : File created.
 * CAM  28-Nov-07    323 : Rewrote parser with many improvements.
 * CAM  24-Apr-08    358 : Corrected compiler warnings moving to VS2008 (from VC++6).
 * CAM  14-Apr-2009  10426 : Removed old GS comment/string code and replaced with flex states and rule ordering.
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

%{

#include <stdio.h>
#include <string.h>
#include "y.php.h"

#ifdef WIN32

#include <io.h>
#include <vector>
#include <set>
using namespace std;

#else

#include <stl.h>
#include <unistd.h>

#endif

int php_lineno=0;
int j_comments=0;
int c_comments=0;
int cpp_comments=0;
int com_loc=0;

set<int> sloc;
set<int> slnat;
set<int> slhtm;
set<int> slscr;
set<int> operators;
vector<char*> operands[255];
int nsemi=0 ;           // Number of semi-colons
int noperators=0 ;      // Total number of operators
int noperands=0;        // Total number of operands

#define NOTE_SLOC() sloc.insert(php_lineno)
#define NOTE_SLOC_NAT() NOTE_SLOC(); slnat.insert(php_lineno)
#define NOTE_SLOC_SCR() NOTE_SLOC(); slscr.insert(php_lineno)
#define NOTE_SLOC_HTM() NOTE_SLOC(); slhtm.insert(php_lineno)

void lexclear();
void store_operand(char* txt);
void store_operator(int op, int typ);

%}

%p 4096
%x HTML_COM
%x SLOC_NAT
%x SLOC_NAT_ECOM
%x SLOC_NAT_MCOM
%x SLOC_NAT_STRS
%x SLOC_NAT_STRD
%x SLOC_SCR
%x SLOC_SCR_ECOM

NL                                "\n"
NOTNL                             .
ANY                               ({NOTNL}|{NL})
BACKSL                            "\\"
BOL                               ^
LETTER                            [A-Za-z_]
ALNUM                             [A-Za-z_0-9]
DIGIT                             [0-9]
HEXDIGIT                          [0-9A-Fa-f]
DIGITS                            ({DIGIT}+)
EXP                               [Ee][+-]?DIGITS
HEXDIGITS                         ({HEXDIGIT}+)
SIGN                              ("+"|"-")
ELL_SUFFIX                        [lL]([lL]?)
INT_SUFFIX                        ([uU]{ELL_SUFFIX}?|{ELL_SUFFIX}[uU]?)
FLOAT_SUFFIX                      [flFL]
STRCHAR                           [^\"\n\\]
ESCAPE                            ({BACKSL}{ANY})
QUOTE                             [\"]
SPTAB                             [ \t]

%%

"<!--"                            {com_loc++; c_comments++; BEGIN HTML_COM;}
<HTML_COM>"-->"                   {BEGIN 0;}
<HTML_COM>\n                      {com_loc++; php_lineno++;}
<HTML_COM>.                       {;}

"<?"                              |
"<?php"                           {NOTE_SLOC_NAT(); BEGIN SLOC_NAT;}
<SLOC_NAT>"?>"                    {NOTE_SLOC_NAT(); BEGIN 0;}
<SLOC_NAT>\n                      {php_lineno++;}
<SLOC_NAT>\"                      {BEGIN SLOC_NAT_STRD;}
<SLOC_NAT>\'                      {BEGIN SLOC_NAT_STRS;}
<SLOC_NAT>"/*"                    {BEGIN SLOC_NAT_MCOM; c_comments++;}
<SLOC_NAT>"//"                    {BEGIN SLOC_NAT_ECOM; cpp_comments++;}
<SLOC_NAT>";"                     {nsemi++;}

<SLOC_NAT>"{"                     |
<SLOC_NAT>"}"                     |
<SLOC_NAT>"("                     |
<SLOC_NAT>")"                     |
<SLOC_NAT>"["                     |
<SLOC_NAT>"]"                     {NOTE_SLOC_NAT();}

<SLOC_NAT>"__CLASS__"             {store_operator(PHP__CLASS,1);}
<SLOC_NAT>"__FILE__"              {store_operator(PHP__FILE,1);}
<SLOC_NAT>"__FUNCTION__"          {store_operator(PHP__FUNCTION,1);}
<SLOC_NAT>"__LINE__"              {store_operator(PHP__LINE,1);}
<SLOC_NAT>"__METHOD__"            {store_operator(PHP__METHOD,1);}
<SLOC_NAT>"abstract"              {store_operator(PHP_ABSTRACT,1);}
<SLOC_NAT>"and"                   {store_operator(PHP_AND,1);}
<SLOC_NAT>"array"                 {store_operator(PHP_ARRAY,1);}
<SLOC_NAT>"as"                    {store_operator(PHP_AS,1);}
<SLOC_NAT>"break"                 {store_operator(PHP_BREAK,1);}
<SLOC_NAT>"case"                  {store_operator(PHP_CASE,1);}
<SLOC_NAT>"catch"                 {store_operator(PHP_CATCH,1);}
<SLOC_NAT>"cfunction"             {store_operator(PHP_CFUNCTION,1);}
<SLOC_NAT>"class"                 {store_operator(PHP_CLASS,1);}
<SLOC_NAT>"clone"                 {store_operator(PHP_CLONE,1);}
<SLOC_NAT>"const"                 {store_operator(PHP_CONST,1);}
<SLOC_NAT>"continue"              {store_operator(PHP_CONTINUE,1);}
<SLOC_NAT>"declare"               {store_operator(PHP_DECLARE,1);}
<SLOC_NAT>"default"               {store_operator(PHP_DEFAULT,1);}
<SLOC_NAT>"die"                   {store_operator(PHP_DIE,1);}
<SLOC_NAT>"do"                    {store_operator(PHP_DO,1);}
<SLOC_NAT>"echo"                  {store_operator(PHP_ECHO,1);}
<SLOC_NAT>"else"                  {store_operator(PHP_ELSE,1);}
<SLOC_NAT>"elseif"                {store_operator(PHP_ELSEIF,1);}
<SLOC_NAT>"empty"                 {store_operator(PHP_EMPTY,1);}
<SLOC_NAT>"enddeclare"            {store_operator(PHP_ENDDECLARE,1);}
<SLOC_NAT>"endfor"                {store_operator(PHP_ENDFOR,1);}
<SLOC_NAT>"endforeach"            {store_operator(PHP_ENDFOREACH,1);}
<SLOC_NAT>"endif"                 {store_operator(PHP_ENDIF,1);}
<SLOC_NAT>"endswitch"             {store_operator(PHP_ENDSWITCH,1);}
<SLOC_NAT>"endwhile"              {store_operator(PHP_ENDWHILE,1);}
<SLOC_NAT>"eval"                  {store_operator(PHP_EVAL,1);}
<SLOC_NAT>"exception"             {store_operator(PHP_EXCEPTION,1);}
<SLOC_NAT>"exit"                  {store_operator(PHP_EXIT,1);}
<SLOC_NAT>"extends"               {store_operator(PHP_EXTENDS,1);}
<SLOC_NAT>"final"                 {store_operator(PHP_FINAL,1);}
<SLOC_NAT>"for"                   {store_operator(PHP_FOR,1);}
<SLOC_NAT>"foreach"               {store_operator(PHP_FOREACH,1);}
<SLOC_NAT>"function"              {store_operator(PHP_FUNCTION,1);}
<SLOC_NAT>"global"                {store_operator(PHP_GLOBAL,1);}
<SLOC_NAT>"if"                    {store_operator(PHP_IF,1);}
<SLOC_NAT>"implements"            {store_operator(PHP_IMPLEMENTS,1);}
<SLOC_NAT>"include"               {store_operator(PHP_INCLUDE,1);}
<SLOC_NAT>"include_once"          {store_operator(PHP_INCLUDE_ONCE,1);}
<SLOC_NAT>"interface"             {store_operator(PHP_INTERFACE,1);}
<SLOC_NAT>"isset"                 {store_operator(PHP_ISSET,1);}
<SLOC_NAT>"list"                  {store_operator(PHP_LIST,1);}
<SLOC_NAT>"new"                   {store_operator(PHP_NEW,1);}
<SLOC_NAT>"old_function"          {store_operator(PHP_OLD_FUNCTION,1);}
<SLOC_NAT>"or"                    {store_operator(PHP_OR,1);}
<SLOC_NAT>"php_user_filter"       {store_operator(PHP_PHP_USER_FILTER,1);}
<SLOC_NAT>"print"                 {store_operator(PHP_PRINT,1);}
<SLOC_NAT>"private"               {store_operator(PHP_PRIVATE,1);}
<SLOC_NAT>"protected"             {store_operator(PHP_PROTECTED,1);}
<SLOC_NAT>"public"                {store_operator(PHP_PUBLIC,1);}
<SLOC_NAT>"require"               {store_operator(PHP_REQUIRE,1);}
<SLOC_NAT>"require_once"          {store_operator(PHP_REQUIRE_ONCE,1);}
<SLOC_NAT>"return"                {store_operator(PHP_RETURN,1);}
<SLOC_NAT>"static"                {store_operator(PHP_STATIC,1);}
<SLOC_NAT>"switch"                {store_operator(PHP_SWITCH,1);}
<SLOC_NAT>"throw"                 {store_operator(PHP_THROW,1);}
<SLOC_NAT>"try"                   {store_operator(PHP_TRY,1);}
<SLOC_NAT>"unset"                 {store_operator(PHP_UNSET,1);}
<SLOC_NAT>"use"                   {store_operator(PHP_USE,1);}
<SLOC_NAT>"var"                   {store_operator(PHP_VAR,1);}
<SLOC_NAT>"while"                 {store_operator(PHP_WHILE,1);}
<SLOC_NAT>"xor"                   {store_operator(PHP_XOR,1);}

<SLOC_NAT>{LETTER}{ALNUM}*                                            |
<SLOC_NAT>[1-9][0-9]*{INT_SUFFIX}?                                    |
<SLOC_NAT>[0][0-7]*{INT_SUFFIX}?                                      |
<SLOC_NAT>[0][xX][0-9A-Fa-f]+{INT_SUFFIX}?                            |
<SLOC_NAT>[0][xX]                                                     |
<SLOC_NAT>{DIGITS}"."{DIGITS}?([eE]{SIGN}?{DIGITS})?{FLOAT_SUFFIX}?   |
<SLOC_NAT>{DIGITS}"."?([eE]{SIGN}?{DIGITS})?{FLOAT_SUFFIX}?           |
<SLOC_NAT>"."{DIGITS}([eE]{SIGN}?{DIGITS})?{FLOAT_SUFFIX}?            |
<SLOC_NAT>{DIGITS}"."{DIGITS}?[eE]{SIGN}?                             |
<SLOC_NAT>{DIGITS}"."?[eE]{SIGN}?                                     |
<SLOC_NAT>"."{DIGITS}[eE]{SIGN}?                                      {store_operand(_strdup(yytext));NOTE_SLOC_NAT();}

<SLOC_NAT>.                       {;}

<SLOC_NAT_STRD>\n                 {php_lineno++; /* Double-quoted string literals */}
<SLOC_NAT_STRD>\"                 {BEGIN SLOC_NAT;}
<SLOC_NAT_STRD>.                  {NOTE_SLOC_NAT();}

<SLOC_NAT_STRS>\n                 {php_lineno++; /* Single-quoted string literals */}
<SLOC_NAT_STRS>"'"                {BEGIN SLOC_NAT;}
<SLOC_NAT_STRS>.                  {NOTE_SLOC_NAT();}

<SLOC_NAT_MCOM>\n                 {php_lineno++; com_loc++; /* Multi Line Comments within Native PHP */}
<SLOC_NAT_MCOM>"*/"               {BEGIN SLOC_NAT;}
<SLOC_NAT_MCOM>.                  {;}

<SLOC_NAT_ECOM>\n                 {php_lineno++; com_loc++; BEGIN SLOC_NAT;}
<SLOC_NAT_ECOM>.                  {/* To-end-of-line Comments within Native PHP */}

"<script"                         {NOTE_SLOC_SCR(); BEGIN SLOC_SCR; /* Script tags */}
<SLOC_SCR>"/>"                    |
<SLOC_SCR>"</script>"             {NOTE_SLOC_SCR(); BEGIN 0;}
<SLOC_SCR>"//"                    {BEGIN SLOC_SCR_ECOM; cpp_comments++;}
<SLOC_SCR>\n                      {php_lineno++;}

<SLOC_SCR>"{"                     |
<SLOC_SCR>"}"                     |
<SLOC_SCR>"("                     |
<SLOC_SCR>")"                     |
<SLOC_SCR>"["                     |
<SLOC_SCR>"]"                     {NOTE_SLOC_SCR();}

<SLOC_SCR>{LETTER}{ALNUM}*                                            |
<SLOC_SCR>[1-9][0-9]*{INT_SUFFIX}?                                    |
<SLOC_SCR>[0][0-7]*{INT_SUFFIX}?                                      |
<SLOC_SCR>[0][xX][0-9A-Fa-f]+{INT_SUFFIX}?                            |
<SLOC_SCR>[0][xX]                                                     |
<SLOC_SCR>{DIGITS}"."{DIGITS}?([eE]{SIGN}?{DIGITS})?{FLOAT_SUFFIX}?   |
<SLOC_SCR>{DIGITS}"."?([eE]{SIGN}?{DIGITS})?{FLOAT_SUFFIX}?           |
<SLOC_SCR>"."{DIGITS}([eE]{SIGN}?{DIGITS})?{FLOAT_SUFFIX}?            |
<SLOC_SCR>{DIGITS}"."{DIGITS}?[eE]{SIGN}?                             |
<SLOC_SCR>{DIGITS}"."?[eE]{SIGN}?                                     |
<SLOC_SCR>"."{DIGITS}[eE]{SIGN}?                                      {store_operand(_strdup(yytext));NOTE_SLOC_SCR();printf("%1", yytext);}

<SLOC_SCR>.                       {;}

<SLOC_SCR_ECOM>.                  {/* To-end-of-line Comments within Script */}
<SLOC_SCR_ECOM>\n                 {php_lineno++; com_loc++; BEGIN SLOC_SCR;}

\n                                {php_lineno++;}

"ALIGN"                           {store_operator(HTM_ALIGN,3);}
"ALT"                             {store_operator(HTM_ALT,3);}
"APPLET"                          {store_operator(HTM_APPLET,3);}
"AREA"                            {store_operator(HTM_AREA,3);}
"A"                               {store_operator(HTM_A,3);}
"BACKGROUND"                      {store_operator(HTM_BACKGROUND,3);}
"BGCOLOR"                         {store_operator(HTM_BGCOLOR,3);}
"BLOCKQUOTE"                      {store_operator(HTM_BLOCKQUOTE,3);}
"BODY"                            {store_operator(HTM_BODY,3);}
"BORDERCOLOR"                     {store_operator(HTM_BORDERCOLOR,3);}
"BORDER"                          {store_operator(HTM_BORDER,3);}
"BR"                              {store_operator(HTM_BR,3);}
"BUTTON"                          {store_operator(HTM_BUTTON,3);}
"B"                               {store_operator(HTM_B,3);}
"CENTER"                          {store_operator(HTM_CENTER,3);}
"CHECKED"                         {store_operator(HTM_CHECKED,3);}
"CLASS"                           {store_operator(HTM_CLASS,3);}
"CODE"                            {store_operator(HTM_CODE,3);}
"COLOR"                           {store_operator(HTM_COLOR,3);}
"COLS"                            {store_operator(HTM_COLS,3);}
"COLSPAN"                         {store_operator(HTM_COLSPAN,3);}
"DIV"                             {store_operator(HTM_DIV,3);}
"EMBED"                           {store_operator(HTM_EMBED,3);}
"FACE"                            {store_operator(HTM_FACE,3);}
"FONT"                            {store_operator(HTM_FONT,3);}
"FORM"                            {store_operator(HTM_FORM,3);}
"FRAMEBORDER"                     {store_operator(HTM_FRAMEBORDER,3);}
"FRAMESET"                        {store_operator(HTM_FRAMESET,3);}
"FRAMESPACING"                    {store_operator(HTM_FRAMESPACING,3);}
"FRAME"                           {store_operator(HTM_FRAME,3);}
"H1"                              {store_operator(HTM_H1,3);}
"H2"                              {store_operator(HTM_H2,3);}
"H3"                              {store_operator(HTM_H3,3);}
"H4"                              {store_operator(HTM_H4,3);}
"H5"                              {store_operator(HTM_H5,3);}
"H6"                              {store_operator(HTM_H6,3);}
"HEAD"                            {store_operator(HTM_HEAD,3);}
"HEIGHT"                          {store_operator(HTM_HEIGHT,3);}
"HIDDEN"                          {store_operator(HTM_HIDDEN,3);}
"HR"                              {store_operator(HTM_HR,3);}
"HREF"                            {store_operator(HTM_HREF,3);}
"HTML"                            {store_operator(HTM_HTML,3);}
"HTTP-EQUIV"                      {store_operator(HTM_HTTPEQUIV,3);}
"ID"                              {store_operator(HTM_ID,3);}
"IFRAME"                          {store_operator(HTM_IFRAME,3);}
"ILAYER"                          {store_operator(HTM_ILAYER,3);}
"IMG"                             {store_operator(HTM_IMG,3);}
"INPUT"                           {store_operator(HTM_INPUT,3);}
"LABEL"                           {store_operator(HTM_LABEL,3);}
"LANGUAGE"                        {store_operator(HTM_LANGUAGE,3);}
"LANG"                            {store_operator(HTM_LANG,3);}
"LAYER"                           {store_operator(HTM_LAYER,3);}
"LEFTMARGIN"                      {store_operator(HTM_LEFTMARGIN,3);}
"LI"                              {store_operator(HTM_LI,3);}
"LINK"                            {store_operator(HTM_LINK,3);}
"MAP"                             {store_operator(HTM_MAP,3);}
"MARGINHEIGHT"                    {store_operator(HTM_MARGINHEIGHT,3);}
"MARGINWIDTH"                     {store_operator(HTM_MARGINWIDTH,3);}
"META"                            {store_operator(HTM_META,3);}
"METHOD"                          {store_operator(HTM_METHOD,3);}
"MULTIPLE"                        {store_operator(HTM_MULTIPLE,3);}
"NAME"                            {store_operator(HTM_NAME,3);}
"OBJECT"                          {store_operator(HTM_OBJECT,3);}
"OL"                              {store_operator(HTM_OL,3);}
"OPTGROUP"                        {store_operator(HTM_OPTGROUP,3);}
"OPTION"                          {store_operator(HTM_OPTION,3);}
"PARAM"                           {store_operator(HTM_PARAM,3);}
"PRE"                             {store_operator(HTM_PRE,3);}
"PUBLIC"                          {store_operator(HTM_PUBLIC,3);}
"P"                               {store_operator(HTM_P,3);}
"READONLY"                        {store_operator(HTM_READONLY,3);}
"ROWSPAN"                         {store_operator(HTM_ROWSPAN,3);}
"SCROLLING"                       {store_operator(HTM_SCROLLING,3);}
"SCROLL"                          {store_operator(HTM_SCROLL,3);}
"SELECTED"                        {store_operator(HTM_SELECTED,3);}
"SELECT"                          {store_operator(HTM_SELECT,3);}
"SIZE"                            {store_operator(HTM_SIZE,3);}
"SMALL"                           {store_operator(HTM_SMALL,3);}
"SPAN"                            {store_operator(HTM_SPAN,3);}
"SRC"                             {store_operator(HTM_SRC,3);}
"STYLE"                           {store_operator(HTM_STYLE,3);}
"SUB"                             {store_operator(HTM_SUB,3);}
"SUP"                             {store_operator(HTM_SUP,3);}
"TABLE"                           {store_operator(HTM_TABLE,3);}
"TD"                              {store_operator(HTM_TD,3);}
"TEXTAREA"                        {store_operator(HTM_TEXTAREA,3);}
"TEXT"                            {store_operator(HTM_TEXT,3);}
"TH"                              {store_operator(HTM_TH,3);}
"TITLE"                           {store_operator(HTM_TITLE,3);}
"TR"                              {store_operator(HTM_TR,3);}
"UL"                              {store_operator(HTM_UL,3);}
"URL"                             {store_operator(HTM_URL,3);}
"URN"                             {store_operator(HTM_URN,3);}
"USEMAP"                          {store_operator(HTM_USEMAP,3);}
"VALIGN"                          {store_operator(HTM_VALIGN,3);}
"VALUE"                           {store_operator(HTM_VALUE,3);}
"WIDTH"                           {store_operator(HTM_WIDTH,3);}

[ \t\v\f]                         {;}
.                                 { /* ignore bad characters */ }
%%
int yywrap() {
  return(1);
}

void lexclear() {
  BEGIN 0;
  noperands=0;
  j_comments=c_comments=cpp_comments=com_loc=0;
  nsemi=noperators=0;
  php_lineno=1;

  sloc.clear();
  operators.clear();

  slnat.clear();
  slhtm.clear();
  slscr.clear();

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

  NOTE_SLOC();
}

void store_operator(int op, int typ) {
  operators.insert(op);
  noperators++;
  NOTE_SLOC();

  switch (typ) {
    case 1:
      slnat.insert(php_lineno);
      break;
    case 3:
      slhtm.insert(php_lineno);
      break;
    case 4:
      slscr.insert(php_lineno);
      break;
  }
}
