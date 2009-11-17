/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 * Essential Project Manager (EPM)
 * Copyright (c) 2004,2009 PowerSoftware.com
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * PHP Parser
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  14-Apr-2009  10401 : File created.
 * CAM  05-May-2009  10441 : Added HTML operands and operators.
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

%{

#include <stdio.h>
#include <string.h>
#include "y.ht.h"

#ifdef WIN32

#include <io.h>
#include <vector>
#include <set>
using namespace std;

#else

#include <stl.h>
#include <unistd.h>

#endif

int html_lineno=0;
int j_comments=0;
int c_comments=0;
int cpp_comments=0;
int com_loc=0;

set<int> sloc;
set<int> slhtm;
set<int> slscr;
set<int> operators;
vector<char*> operands[255];
int nsemi=0 ;           // Number of semi-colons
int noperators=0 ;      // Total number of operators
int noperands=0;        // Total number of operands

#define NOTE_SLOC() sloc.insert(html_lineno)
#define NOTE_SLOC_SCR() NOTE_SLOC(); slscr.insert(html_lineno)
#define NOTE_SLOC_HTM() NOTE_SLOC(); slhtm.insert(html_lineno)

void lexclear();
void store_operand(char* txt);
void store_operator(int op, int typ);

%}

%p 4096
%x HTML_COM
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
<HTML_COM>\n                      {com_loc++; html_lineno++;}
<HTML_COM>.                       {;}

"<script"                         {NOTE_SLOC_SCR(); BEGIN SLOC_SCR; /* Script tags */}
<SLOC_SCR>"/>"                    |
<SLOC_SCR>"</script>"             {NOTE_SLOC_SCR(); BEGIN 0;}
<SLOC_SCR>"//"                    {BEGIN SLOC_SCR_ECOM; cpp_comments++;}
<SLOC_SCR>\n                      {html_lineno++;}

<SLOC_SCR>"<"                     |
<SLOC_SCR>">"                     |
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
<SLOC_SCR>"."{DIGITS}[eE]{SIGN}?                                      {store_operand(_strdup(yytext));NOTE_SLOC_SCR();}

<SLOC_SCR>.                       {;}

<SLOC_SCR_ECOM>.                  {/* To-end-of-line Comments within Script */}
<SLOC_SCR_ECOM>\n                 {html_lineno++; com_loc++; BEGIN SLOC_SCR;}

\n                                {html_lineno++;}

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
"."{DIGITS}[eE]{SIGN}?                                      {store_operand(_strdup(yytext));NOTE_SLOC_HTM();}

"<"                               {store_operator(HTM_LT,3);}
">"                               {store_operator(HTM_GT,3);}
"="                               {store_operator(HTM_EQ,3);}

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
  html_lineno=1;

  sloc.clear();
  operators.clear();

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
    case 3:
      slhtm.insert(html_lineno);
      break;
    case 4:
      slscr.insert(html_lineno);
      break;
  }
}
