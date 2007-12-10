/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 * Essential Project Manager (EPM)
 * Copyright (c) 2006-2007 Power Software
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * JSP Parser
 *
 * $Id: $
 *
 * Who  When       Why
 * CAM  04-Dec-07   324 : File created.
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
#include "y.jsp.h"

#ifdef WIN32

#include <io.h>
#include <vector>
#include <set>
using namespace std;

#else

#include <stl.h>
#include <unistd.h>

#endif

int jsp_lineno=0;
int j_comments=0;
int c_comments=0;
int cpp_comments=0;
int com_loc=0;

set<int> sloc;
set<int> slnat;
set<int> sltag;
set<int> slhtm;
set<int> slscr;
set<int> operators;
vector<char*> operands[255];
int nsemi=0 ;           // Number of semi-colons
int noperators=0 ;      // Total number of operators
int noperands=0;        // Total number of operands

#define NOTE_SLOC() sloc.insert(jsp_lineno)
#define NOTE_SLOC_TAG() NOTE_SLOC(); sltag.insert(jsp_lineno)
#define NOTE_SLOC_NAT() NOTE_SLOC(); slnat.insert(jsp_lineno)

void lexclear();
void store_operand(char* txt);
void store_operator(int op, int typ);

%}

%p 4096
%x HTML_COM
%x SLOC_NAT
%x SLOC_TAG
%x SLOC_NAT_ECOM
%x SLOC_NAT_MCOM
%x SLOC_NAT_STRS
%x SLOC_NAT_STRD
%x SLOC_SCR
%x SLOC_SCR_ECOM
%x STR_LIT

%%

^[ \t\v\f]*                       {;}

"<!--"                            {com_loc++; c_comments++; BEGIN HTML_COM;}
<HTML_COM>"-->"                   {BEGIN 0;}
<HTML_COM>"\n"                    {com_loc++; jsp_lineno++;}
<HTML_COM>.                       {;}

"<jsp"                            {NOTE_SLOC_TAG(); BEGIN SLOC_TAG; }
<SLOC_TAG>"</jsp"                 {NOTE_SLOC_TAG(); BEGIN 0;}
<SLOC_TAG>"\n"                    {NOTE_SLOC_TAG(); jsp_lineno++;}
<SLOC_TAG>.                       {NOTE_SLOC_TAG(); }

"<%"                              {NOTE_SLOC_NAT(); BEGIN SLOC_NAT; }
<SLOC_NAT>"%>"                    {NOTE_SLOC_NAT(); BEGIN 0;}
<SLOC_NAT>"\n"                    {NOTE_SLOC_NAT(); jsp_lineno++;}

<SLOC_NAT>\"                      {BEGIN SLOC_NAT_STRD;}
<SLOC_NAT>"'"                     {BEGIN SLOC_NAT_STRS;}
<SLOC_NAT>"/*"                    {BEGIN SLOC_NAT_MCOM;}
<SLOC_NAT>"//"                    {BEGIN SLOC_NAT_ECOM;}

<SLOC_NAT>"abstract"              {store_operator(JSP_ABSTRACT,1);}
<SLOC_NAT>"default"               {store_operator(JSP_DEFAULT,1);}
<SLOC_NAT>"if"                    {store_operator(JSP_IF,1);}
<SLOC_NAT>"private"               {store_operator(JSP_PRIVATE,1);}
<SLOC_NAT>"throw"                 {store_operator(JSP_THROW,1);}
<SLOC_NAT>"boolean"               {store_operator(JSP_BOOLEAN,1);}
<SLOC_NAT>"do"                    {store_operator(JSP_DO,1);}
<SLOC_NAT>"implements"            {store_operator(JSP_IMPLEMENTS,1);}
<SLOC_NAT>"protected"             {store_operator(JSP_PROTECTED,1);}
<SLOC_NAT>"throws"                {store_operator(JSP_THROWS,1);}
<SLOC_NAT>"break"                 {store_operator(JSP_BREAK,1);}
<SLOC_NAT>"double"                {store_operator(JSP_DOUBLE,1);}
<SLOC_NAT>"import"                {store_operator(JSP_IMPORT,1);}
<SLOC_NAT>"public"                {store_operator(JSP_PUBLIC,1);}
<SLOC_NAT>"transient"             {store_operator(JSP_TRANSIENT,1);}
<SLOC_NAT>"byte"                  {store_operator(JSP_BYTE,1);}
<SLOC_NAT>"else"                  {store_operator(JSP_ELSE,1);}
<SLOC_NAT>"instanceof"            {store_operator(JSP_INSTANCEOF,1);}
<SLOC_NAT>"return"                {store_operator(JSP_RETURN,1);}
<SLOC_NAT>"try"                   {store_operator(JSP_TRY,1);}
<SLOC_NAT>"case"                  {store_operator(JSP_CASE,1);}
<SLOC_NAT>"extends"               {store_operator(JSP_EXTENDS,1);}
<SLOC_NAT>"int"                   {store_operator(JSP_INT,1);}
<SLOC_NAT>"short"                 {store_operator(JSP_SHORT,1);}
<SLOC_NAT>"void"                  {store_operator(JSP_VOID,1);}
<SLOC_NAT>"catch"                 {store_operator(JSP_CATCH,1);}
<SLOC_NAT>"final"                 {store_operator(JSP_FINAL,1);}
<SLOC_NAT>"interface"             {store_operator(JSP_INTERFACE,1);}
<SLOC_NAT>"static"                {store_operator(JSP_STATIC,1);}
<SLOC_NAT>"volatile"              {store_operator(JSP_VOLATILE,1);}
<SLOC_NAT>"char"                  {store_operator(JSP_CHAR,1);}
<SLOC_NAT>"finally"               {store_operator(JSP_FINALLY,1);}
<SLOC_NAT>"long"                  {store_operator(JSP_LONG,1);}
<SLOC_NAT>"super"                 {store_operator(JSP_SUPER,1);}
<SLOC_NAT>"while"                 {store_operator(JSP_WHILE,1);}
<SLOC_NAT>"class"                 {store_operator(JSP_CLASS,1);}
<SLOC_NAT>"native"                {store_operator(JSP_NATIVE,1);}
<SLOC_NAT>"float"                 {store_operator(JSP_FLOAT,1);}
<SLOC_NAT>"switch"                {store_operator(JSP_SWITCH,1);}
<SLOC_NAT>"const"                 {store_operator(JSP_CONST,1);}
<SLOC_NAT>"for"                   {store_operator(JSP_FOR,1);}
<SLOC_NAT>"new"                   {store_operator(JSP_NEW,1);}
<SLOC_NAT>"synchronized"          {store_operator(JSP_SYNCHRONIZED,1);}
<SLOC_NAT>"continue"              {store_operator(JSP_CONTINUE,1);}
<SLOC_NAT>"goto"                  {store_operator(JSP_GOTO,1);}
<SLOC_NAT>"package"               {store_operator(JSP_PACKAGE,1);}
<SLOC_NAT>"this"                  {store_operator(JSP_THIS,1);}
<SLOC_NAT>"="                     {store_operator(JSP_EQUALS,1);}
<SLOC_NAT>">"                     {store_operator(JSP_GT,1);}
<SLOC_NAT>"<"                     {store_operator(JSP_LT,1);}
<SLOC_NAT>"!"                     {store_operator(JSP_NOT,1);}
<SLOC_NAT>"~"                     {store_operator(JSP_TILDE,1);}
<SLOC_NAT>"?"                     {store_operator(JSP_QUERY,1);}
<SLOC_NAT>":"                     {store_operator(JSP_COLON,1);}
<SLOC_NAT>"=="                    {store_operator(JSP_EQUALITY,1);}
<SLOC_NAT>"<="                    {store_operator(JSP_LTEQUAL,1);}
<SLOC_NAT>">="                    {store_operator(JSP_GTEQUAL,1);}
<SLOC_NAT>"!="                    {store_operator(JSP_NOTEQUAL,1);}
<SLOC_NAT>"&&"                    {store_operator(JSP_AND,1);}
<SLOC_NAT>"||"                    {store_operator(JSP_OR,1);}
<SLOC_NAT>"++"                    {store_operator(JSP_INCREMENT,1);}
<SLOC_NAT>"--"                    {store_operator(JSP_DECREMENT,1);}
<SLOC_NAT>"+"                     {store_operator(JSP_ADD,1);}
<SLOC_NAT>"-"                     {store_operator(JSP_SUBTRACT,1);}
<SLOC_NAT>"*"                     {store_operator(JSP_MULTIPLY,1);}
<SLOC_NAT>"/"                     {store_operator(JSP_DIVIDE,1);}
<SLOC_NAT>"&"                     {store_operator(JSP_BINAND,1);}
<SLOC_NAT>"|"                     {store_operator(JSP_BINOR,1);}
<SLOC_NAT>"^"                     {store_operator(JSP_CARET,1);}
<SLOC_NAT>"%"                     {store_operator(JSP_PCT,1);}
<SLOC_NAT>"<<"                    {store_operator(JSP_LEFTSHIFT,1);}
<SLOC_NAT>">>"                    {store_operator(JSP_RIGHTSHIFT,1);}
<SLOC_NAT>">>>"                   {store_operator(JSP_DBLRGHTSHIFT,1);}
<SLOC_NAT>"+="                    {store_operator(JSP_PLUSEQUALS,1);}
<SLOC_NAT>"-="                    {store_operator(JSP_MINUSEQUALS,1);}
<SLOC_NAT>"*="                    {store_operator(JSP_MULTIPLYEQUALS,1);}
<SLOC_NAT>"/="                    {store_operator(JSP_DIVIDEEQUALS,1);}
<SLOC_NAT>"&="                    {store_operator(JSP_ANDEQUALS,1);}
<SLOC_NAT>"|="                    {store_operator(JSP_OREQUALS,1);}
<SLOC_NAT>"^="                    {store_operator(JSP_CARETEQUALS,1);}
<SLOC_NAT>"%="                    {store_operator(JSP_PCTEQUALS,1);}
<SLOC_NAT>"<<="                   {store_operator(JSP_LEFTEQUALS,1);}
<SLOC_NAT>">>="                   {store_operator(JSP_RIGHTEQUALS,1);}
<SLOC_NAT>">>>="                  {store_operator(JSP_DBLRGHTEQUALS,1);}
<SLOC_NAT>"("                     {store_operator(JSP_OPENPARENTH,1);}
<SLOC_NAT>")"                     {store_operator(JSP_CLOSEPARENTH,1);}
<SLOC_NAT>"{"                     {store_operator(JSP_OPENBRACE,1);}
<SLOC_NAT>"}"                     {store_operator(JSP_CLOSEBRACE,1);}
<SLOC_NAT>"["                     {store_operator(JSP_OPENBRACKET,1);}
<SLOC_NAT>"]"                     {store_operator(JSP_CLOSEBRACKET,1);}
<SLOC_NAT>";"                     {store_operator(JSP_SEMICOLON,1); nsemi++;}
<SLOC_NAT>","                     {store_operator(JSP_COMMA,1);}
<SLOC_NAT>"."                     {store_operator(JSP_PERIOD,1);}

<SLOC_NAT>{L}({L}|{D})*           |
<SLOC_NAT>0[xX]{H}+{IS}?          |
<SLOC_NAT>0{D}+{IS}?              |
<SLOC_NAT>{D}+{IS}?               |
<SLOC_NAT>'(\\.|[^\\'])+'         |
<SLOC_NAT>{D}+{E}{FS}?            |
<SLOC_NAT>{D}*"."{D}+({E})?{FS}?  |
<SLOC_NAT>{D}+"."{D}*({E})?{FS}?  {NOTE_SLOC_NAT(); store_operand(strdup(yytext));}
<SLOC_NAT>.                       {NOTE_SLOC_NAT();}

<SLOC_NAT_STRD>"\n"               {jsp_lineno++; /* Double-quoted string literals */}
<SLOC_NAT_STRD>\"                 {BEGIN SLOC_NAT;}
<SLOC_NAT_STRD>.                  {NOTE_SLOC_NAT();}

<SLOC_NAT_STRS>"\n"               {jsp_lineno++; /* Single-quoted string literals */}
<SLOC_NAT_STRS>"'"                {BEGIN SLOC_NAT;}
<SLOC_NAT_STRS>.                  {NOTE_SLOC_NAT();}

<SLOC_NAT_MCOM>"\n"               {jsp_lineno++; com_loc++; /* Multi Line Comments within Native JSP */}
<SLOC_NAT_MCOM>.                  {;}
<SLOC_NAT_MCOM>"*/"               {c_comments++; com_loc++; BEGIN SLOC_NAT;}

<SLOC_NAT_ECOM>.                  {/* To-end-of-line Comments within Native JSP */}
<SLOC_NAT_ECOM>"\n"               {jsp_lineno++; com_loc++; cpp_comments++; BEGIN SLOC_NAT;}

"<script"                         {NOTE_SLOC(); slscr.insert(jsp_lineno); BEGIN SLOC_SCR; /* Script tags */}
<SLOC_SCR>"/>"                    |
<SLOC_SCR>"</script>"             {NOTE_SLOC(); slscr.insert(jsp_lineno); BEGIN 0;}
<SLOC_SCR>"//"                    {BEGIN SLOC_SCR_ECOM;}
<SLOC_SCR>"\n"                    {NOTE_SLOC(); slscr.insert(jsp_lineno); jsp_lineno++;}
<SLOC_SCR>.                       {NOTE_SLOC(); slscr.insert(jsp_lineno); }

<SLOC_SCR_ECOM>.                  {/* To-end-of-line Comments within Script */}
<SLOC_SCR_ECOM>"\n"               {jsp_lineno++; com_loc++; cpp_comments++; BEGIN SLOC_SCR;}

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
"\n"                              {jsp_lineno++;}
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
  jsp_lineno=1;

  sloc.clear();
  operators.clear();

  slnat.clear();
  sltag.clear();
  slhtm.clear();
  slscr.clear();

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

  NOTE_SLOC();
}

void store_operator(int op, int typ) {
  operators.insert(op);
  noperators++;
  NOTE_SLOC();

  switch (typ) {
    case 1:
      slnat.insert(jsp_lineno);
      break;
    case 2:
      sltag.insert(jsp_lineno);
      break;
    case 3:
      slhtm.insert(jsp_lineno);
      break;
    case 4:
      slscr.insert(jsp_lineno);
      break;
  }
}
