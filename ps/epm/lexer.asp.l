/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 * Essential Project Manager (EPM)
 * Copyright (c) 2006-2007 Power Software
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * ASP Parser
 *
 * $Id$
 *
 * Who  When       Why
 * CAM  19-Sep-06   117 : File created.
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
#include "y.asp.h"

#ifdef WIN32

#include <io.h>
#include <vector>
#include <set>
using namespace std;

#else

#include <stl.h>
#include <unistd.h>

#endif

int asp_lineno=0;
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

#define NOTE_SLOC() sloc.insert(asp_lineno)

void lexclear();
void store_operand(char* txt);
void store_operator(int op, int typ);
void string_literal();
void eat_eol();

%}

%p 4096
%x HTML_COM
%x SLOC_TAG
%x SLOC_NAT
%x SLOC_SCR
%x ASP_TAG
%x ASP_END
%x STR_LIT

%%

^[ \t\v\f]*             {;}

"<!--"                  {com_loc++; c_comments++; BEGIN HTML_COM;}
<HTML_COM>"-->"         {BEGIN 0;}
<HTML_COM>"\n"          {com_loc++; asp_lineno++;}
<HTML_COM>.             {;}

"<%"                    {NOTE_SLOC(); sltag.insert(asp_lineno); BEGIN SLOC_TAG; }
<SLOC_TAG>"%>"          {NOTE_SLOC(); sltag.insert(asp_lineno); BEGIN 0;}
<SLOC_TAG>"\n"          {NOTE_SLOC(); sltag.insert(asp_lineno); asp_lineno++;}
<SLOC_TAG>.             {NOTE_SLOC(); sltag.insert(asp_lineno); }

"<script".*"runat"[ ]*"="     {NOTE_SLOC(); slnat.insert(asp_lineno); BEGIN SLOC_NAT; }
<SLOC_NAT>"/>"                |
<SLOC_NAT>"</script>"         {NOTE_SLOC(); slnat.insert(asp_lineno); BEGIN 0;}
<SLOC_NAT>";"                 {nsemi++; slnat.insert(asp_lineno);}
<SLOC_NAT>^[ \t\v\f]*"//"     {com_loc++; cpp_comments++; asp_lineno++; eat_eol();}
<SLOC_NAT>"\n"                {NOTE_SLOC(); slnat.insert(asp_lineno); asp_lineno++;}
<SLOC_NAT>.                   {NOTE_SLOC(); slnat.insert(asp_lineno); }

"<script"               {NOTE_SLOC(); slscr.insert(asp_lineno); BEGIN SLOC_SCR; }
<SLOC_SCR>"/>"          |
<SLOC_SCR>"</script>"   {NOTE_SLOC(); slscr.insert(asp_lineno); BEGIN 0;}
<SLOC_SCR>^[ \t\v\f]*"//"          {com_loc++; cpp_comments++; asp_lineno++; eat_eol();}
<SLOC_SCR>"\n"          {NOTE_SLOC(); slscr.insert(asp_lineno); asp_lineno++;}
<SLOC_SCR>.             {NOTE_SLOC(); slscr.insert(asp_lineno); }

\"                      {NOTE_SLOC(); string_literal();}

"<asp"                  {NOTE_SLOC(); sltag.insert(asp_lineno); BEGIN ASP_TAG; }
<ASP_TAG>">"            {NOTE_SLOC(); sltag.insert(asp_lineno); BEGIN 0;}
<ASP_TAG>"\n"           {NOTE_SLOC(); sltag.insert(asp_lineno); asp_lineno++;}
<ASP_TAG>.              {NOTE_SLOC(); sltag.insert(asp_lineno);}

"</asp"                 {NOTE_SLOC(); sltag.insert(asp_lineno); BEGIN ASP_END; }
<ASP_END>">"            {NOTE_SLOC(); sltag.insert(asp_lineno); BEGIN 0;}
<ASP_END>.              {NOTE_SLOC(); sltag.insert(asp_lineno);}

"ACTION"                {store_operator(ACTION,3);}
"ADDRESS"               {store_operator(ADDRESS,3);}
"ALIGN"                 {store_operator(ALIGN,3);}
"ALINK"                 {store_operator(ALINK,3);}
"ALT"                   {store_operator(ALT,3);}
"APPLET"                {store_operator(APPLET,3);}
"AREA"                  {store_operator(AREA,3);}
"A"                     {store_operator(HTMA,3);}
"BACKGROUND"            {store_operator(BACKGROUND,3);}
"BASE"                  {store_operator(BASE,3);}
"BGCOLOR"               {store_operator(BGCOLOR,3);}
"BIG"                   {store_operator(BIG,3);}
"BLINK"                 {store_operator(BLINK,3);}
"BLOCKQUOTE"            {store_operator(BLOCKQUOTE,3);}
"BODY"                  {store_operator(BODY,3);}
"BORDERCOLOR"           {store_operator(BORDERCOLOR,3);}
"BORDER"                {store_operator(BORDER,3);}
"BOTTOMMARGIN"          {store_operator(BOTTOMMARGIN,3);}
"BR"                    {store_operator(BR,3);}
"BUTTON"                {store_operator(BUTTON,3);}
"B"                     {store_operator(HTMB,3);}
"CAPTION"               {store_operator(CAPTION,3);}
"CELLPADDING"           {store_operator(CELLPADDING,3);}
"CELLSPACING"           {store_operator(CELLSPACING,3);}
"CENTER"                {store_operator(CENTER,3);}
"CHECKED"               {store_operator(CHECKED,3);}
"CLASS"                 {store_operator(CLASS,3);}
"CLASSID"               {store_operator(CLASSID,3);}
"CLEAR"                 {store_operator(CLEAR,3);}
"CODEBASE"              {store_operator(CODEBASE,3);}
"CODETYPE"              {store_operator(CODETYPE,3);}
"CODE"                  {store_operator(CODE,3);}
"COLGROUP"              {store_operator(COLGROUP,3);}
"COLOR"                 {store_operator(COLOR,3);}
"COLS"                  {store_operator(COLS,3);}
"COLSPAN"               {store_operator(COLSPAN,3);}
"COL"                   {store_operator(COL,3);}
"COMPACT"               {store_operator(COMPACT,3);}
"CONTENT"               {store_operator(CONTENT,3);}
"COORDS"                {store_operator(COORDS,3);}
"DATA"                  {store_operator(DATA,3);}
"DD"                    {store_operator(DD,3);}
"DEL"                   {store_operator(DEL,3);}
"DISABLED"              {store_operator(DISABLED,3);}
"DIV"                   {store_operator(DIV,3);}
"DL"                    {store_operator(DL,3);}
"DT"                    {store_operator(DT,3);}
"EMBED"                 {store_operator(EMBED,3);}
"EM"                    {store_operator(EM,3);}
"EVENT"                 {store_operator(EVENT,3);}
"FACE"                  {store_operator(FACE,3);}
"FONT"                  {store_operator(FONT,3);}
"FORM"                  {store_operator(FORM,3);}
"FRAMEBORDER"           {store_operator(FRAMEBORDER,3);}
"FRAMESET"              {store_operator(FRAMESET,3);}
"FRAMESPACING"          {store_operator(FRAMESPACING,3);}
"FRAME"                 {store_operator(FRAME,3);}
"H1"                    {store_operator(H1,3);}
"H2"                    {store_operator(H2,3);}
"H3"                    {store_operator(H3,3);}
"H4"                    {store_operator(H4,3);}
"H5"                    {store_operator(H5,3);}
"H6"                    {store_operator(H6,3);}
"HEAD"                  {store_operator(HEAD,3);}
"HEIGHT"                {store_operator(HEIGHT,3);}
"HIDDEN"                {store_operator(HIDDEN,3);}
"HR"                    {store_operator(HR,3);}
"HREF"                  {store_operator(HREF,3);}
"HSPACE"                {store_operator(HSPACE,3);}
"HTML"                  {store_operator(HTML,3);}
"HTTP-EQUIV"            {store_operator(HTTPEQUIV,3);}
"ID"                    {store_operator(ID,3);}
"IFRAME"                {store_operator(IFRAME,3);}
"ILAYER"                {store_operator(ILAYER,3);}
"IMG"                   {store_operator(IMG,3);}
"INPUT"                 {store_operator(INPUT,3);}
"LABEL"                 {store_operator(LABEL,3);}
"LANGUAGE"              {store_operator(LANGUAGE,3);}
"LANG"                  {store_operator(LANG,3);}
"LAYER"                 {store_operator(LAYER,3);}
"LEFTMARGIN"            {store_operator(LEFTMARGIN,3);}
"LEGEND"                {store_operator(LEGEND,3);}
"LI"                    {store_operator(LI,3);}
"LINK"                  {store_operator(LINK,3);}
"LOOP"                  {store_operator(LOOP,3);}
"MAP"                   {store_operator(MAP,3);}
"MENU"                  {store_operator(MENU,3);}
"META"                  {store_operator(META,3);}
"MULTICOL"              {store_operator(MULTICOL,3);}
"MULTIPLE"              {store_operator(MULTIPLE,3);}
"NAME"                  {store_operator(NAME,3);}
"NOBR"                  {store_operator(NOBR,3);}
"NOEMBED"               {store_operator(NOEMBED,3);}
"NOFRAMES"              {store_operator(NOFRAMES,3);}
"NOHREF"                {store_operator(NOHREF,3);}
"NOLAYER"               {store_operator(NOLAYER,3);}
"NORESIZE"              {store_operator(NORESIZE,3);}
"NOSCRIPT"              {store_operator(NOSCRIPT,3);}
"NOSHADE"               {store_operator(NOSHADE,3);}
"NOWRAP"                {store_operator(NOWRAP,3);}
"OBJECT"                {store_operator(OBJECT,3);}
"OL"                    {store_operator(OL,3);}
"OPTGROUP"              {store_operator(OPTGROUP,3);}
"OPTION"                {store_operator(OPTION,3);}
"PALETTE"               {store_operator(PALETTE,3);}
"PARAM"                 {store_operator(PARAM,3);}
"PLAINTEXT"             {store_operator(PLAINTEXT,3);}
"PRE"                   {store_operator(PRE,3);}
"PUBLIC"                {store_operator(PUBLIC,3);}
"P"                     {store_operator(HTMP,3);}
"READONLY"              {store_operator(READONLY,3);}
"REL"                   {store_operator(REL,3);}
"REV"                   {store_operator(REV,3);}
"RIGHTMARGIN"           {store_operator(RIGHTMARGIN,3);}
"ROWSPAN"               {store_operator(ROWSPAN,3);}
"ROWS"                  {store_operator(ROWS,3);}
"SELECTED"              {store_operator(SELECTED,3);}
"SELECT"                {store_operator(SELECT,3);}
"SERVER"                {store_operator(SERVER,3);}
"SHAPE"                 {store_operator(SHAPE,3);}
"SIZE"                  {store_operator(SIZE,3);}
"SMALL"                 {store_operator(SMALL,3);}
"SOUND"                 {store_operator(SOUND,3);}
"SPACER"                {store_operator(SPACER,3);}
"SPAN"                  {store_operator(SPAN,3);}
"SRC"                   {store_operator(SRC,3);}
"START"                 {store_operator(START,3);}
"STRIKE"                {store_operator(STRIKE,3);}
"STRONG"                {store_operator(STRONG,3);}
"STYLE"                 {store_operator(STYLE,3);}
"SUB"                   {store_operator(SUB,3);}
"SUP"                   {store_operator(SUP,3);}
"TABINDEX"              {store_operator(TABINDEX,3);}
"TABLE"                 {store_operator(TABLE,3);}
"TARGET"                {store_operator(TARGET,3);}
"TBODY"                 {store_operator(TBODY,3);}
"TD"                    {store_operator(TD,3);}
"TEXTAREA"              {store_operator(TEXTAREA,3);}
"TEXT"                  {store_operator(TEXT,3);}
"TFOOT"                 {store_operator(TFOOT,3);}
"THEAD"                 {store_operator(THEAD,3);}
"TH"                    {store_operator(TH,3);}
"TITLE"                 {store_operator(TITLE,3);}
"TOPMARGIN"             {store_operator(TOPMARGIN,3);}
"TRUESPEED"             {store_operator(TRUESPEED,3);}
"TR"                    {store_operator(TR,3);}
"TT"                    {store_operator(TT,3);}
"TYPE"                  {store_operator(TYPE,3);}
"UL"                    {store_operator(UL,3);}
"URL"                   {store_operator(URL,3);}
"URN"                   {store_operator(URN,3);}
"USEMAP"                {store_operator(USEMAP,3);}
"VALIGN"                {store_operator(VALIGN,3);}
"VALUE"                 {store_operator(VALUE,3);}
"VAR"                   {store_operator(VAR,3);}
"VLINK"                 {store_operator(VLINK,3);}
"VOLUME"                {store_operator(VOLUME,3);}
"VRML"                  {store_operator(VRML,3);}
"VSPACE"                {store_operator(VSPACE,3);}
"WIDTH"                 {store_operator(WIDTH,3);}
"WRAP"                  {store_operator(WRAP,3);}

{L}({L}|{D})*           |
0[xX]{H}+{IS}?          |
0{D}+{IS}?              |
{D}+{IS}?               |
'(\\.|[^\\'])+'         |
{D}+{E}{FS}?            |
{D}*"."{D}+({E})?{FS}?  |
{D}+"."{D}*({E})?{FS}?  {NOTE_SLOC(); store_operand(strdup(yytext));}

[ \t\v\f]               {;}
"\n"                    {asp_lineno++;}
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
}


void eat_eol() {
  register int c;
  while ((c = yyinput()) != '\n' && c != EOF);
}

void lexclear() {
  BEGIN 0;
  noperands=0;
  j_comments=c_comments=cpp_comments=com_loc=0;
  nsemi=noperators=0;
  asp_lineno=1;

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
      slnat.insert(asp_lineno);
      break;
    case 2:
      sltag.insert(asp_lineno);
      break;
    case 3:
      slhtm.insert(asp_lineno);
      break;
    case 4:
      slscr.insert(asp_lineno);
      break;
  }
}
