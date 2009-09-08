/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 * Essential Project Manager (EPM)
 * Copyright (c) 2009 SourceCodeMetrics.com
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * CSS parser
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  12-Aug-2009  10450 : File created.
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

%{

#include <stdio.h>
#include <string.h>
#include "y.ss.h"

#ifdef WIN32

#include <io.h>
#include <vector>
#include <set>
using namespace std;

#else

#include <stl.h>
#include <unistd.h>

#endif

int css_lineno=0;
int j_comments=0;
int c_comments=0;
int cpp_comments=0;
int com_loc=0;
int prev_com_line=-1;

set<int> sloc;
set<int> operators;
vector<char*> operands[255];

int nsemi=0;            // Number of semi-colons
int noperators=0;       // Total number of operators
int noperands=0;        // Total number of operands

#define STORE_OPERATOR(X) operators.insert(X); noperators++; COUNT()
#define SEMI() nsemi++; COUNT()
#define COUNT() sloc.insert(css_lineno)

void lexclear();
void store_operand(char* txt);

%}

%p 3500
%x DEFINE
%x JCOM CCOM
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

"/**"                   {com_loc++; j_comments++; BEGIN JCOM;}
<JCOM>"*/"              {BEGIN 0;}
<JCOM>\n                {com_loc++; css_lineno++;}
<JCOM>.                 {;}

"/*"                    {com_loc++; c_comments++; BEGIN CCOM;}
<CCOM>"*/"              {BEGIN 0;}
<CCOM>\n                {com_loc++; css_lineno++;}
<CCOM>.                 {;}

\n                      {css_lineno++;}

\".*\\\"*\"             |
\".*\"                  {store_operand(_strdup(yytext));COUNT();}
"'"."'"                 {store_operand(_strdup(yytext));COUNT();}

";"                     {SEMI();}
"{"                     {COUNT();}
"}"                     {COUNT();}
","                     {STORE_OPERATOR(',');}
":"                     {COUNT();}
"("                     {COUNT();}
")"                     {COUNT();}
"."                     {STORE_OPERATOR('.');}

"azimuth"               {STORE_OPERATOR(CSS_AZIMUTH);}
"background"            {STORE_OPERATOR(CSS_BACKGROUND);}
"background-attachment" {STORE_OPERATOR(CSS_BACKGROUNDATTACHMENT);}
"background-color"      {STORE_OPERATOR(CSS_BACKGROUNDCOLOR);}
"background-image"      {STORE_OPERATOR(CSS_BACKGROUNDIMAGE);}
"background-position"   {STORE_OPERATOR(CSS_BACKGROUNDPOSITION);}
"background-repeat"     {STORE_OPERATOR(CSS_BACKGROUNDREPEAT);}
"border"                {STORE_OPERATOR(CSS_BORDER);}
"border-bottom"         {STORE_OPERATOR(CSS_BORDERBOTTOM);}
"border-bottom-color"   {STORE_OPERATOR(CSS_BORDERBOTTOMCOLOR);}
"border-bottom-style"   {STORE_OPERATOR(CSS_BORDERBOTTOMSTYLE);}
"border-bottom-width"   {STORE_OPERATOR(CSS_BORDERBOTTOMWIDTH);}
"border-collapse"       {STORE_OPERATOR(CSS_BORDERCOLLAPSE);}
"border-color"          {STORE_OPERATOR(CSS_BORDERCOLOR);}
"border-left"           {STORE_OPERATOR(CSS_BORDERLEFT);}
"border-left-color"     {STORE_OPERATOR(CSS_BORDERLEFTCOLOR);}
"border-left-style"     {STORE_OPERATOR(CSS_BORDERLEFTSTYLE);}
"border-left-width"     {STORE_OPERATOR(CSS_BORDERLEFTWIDTH);}
"border-right"          {STORE_OPERATOR(CSS_BORDERRIGHT);}
"border-right-color"    {STORE_OPERATOR(CSS_BORDERRIGHTCOLOR);}
"border-right-style"    {STORE_OPERATOR(CSS_BORDERRIGHTSTYLE);}
"border-right-width"    {STORE_OPERATOR(CSS_BORDERRIGHTWIDTH);}
"border-spacing"        {STORE_OPERATOR(CSS_BORDERSPACING);}
"border-style"          {STORE_OPERATOR(CSS_BORDERSTYLE);}
"border-top"            {STORE_OPERATOR(CSS_BORDERTOP);}
"border-top-color"      {STORE_OPERATOR(CSS_BORDERTOPCOLOR);}
"border-top-style"      {STORE_OPERATOR(CSS_BORDERTOPSTYLE);}
"border-top-width"      {STORE_OPERATOR(CSS_BORDERTOPWIDTH);}
"border-width"          {STORE_OPERATOR(CSS_BORDERWIDTH);}
"bottom"                {STORE_OPERATOR(CSS_BOTTOM);}
"caption-side"          {STORE_OPERATOR(CSS_CAPTIONSIDE);}
"clear"                 {STORE_OPERATOR(CSS_CLEAR);}
"clip"                  {STORE_OPERATOR(CSS_CLIP);}
"color"                 {STORE_OPERATOR(CSS_COLOR);}
"content"               {STORE_OPERATOR(CSS_CONTENT);}
"counter-increment"     {STORE_OPERATOR(CSS_COUNTERINCREMENT);}
"counter-reset"         {STORE_OPERATOR(CSS_COUNTERRESET);}
"cue"                   {STORE_OPERATOR(CSS_CUE);}
"cue-after"             {STORE_OPERATOR(CSS_CUEAFTER);}
"cue-before"            {STORE_OPERATOR(CSS_CUEBEFORE);}
"cursor"                {STORE_OPERATOR(CSS_CURSOR);}
"direction"             {STORE_OPERATOR(CSS_DIRECTION);}
"display"               {STORE_OPERATOR(CSS_DISPLAY);}
"elevation"             {STORE_OPERATOR(CSS_ELEVATION);}
"empty-cells"           {STORE_OPERATOR(CSS_EMPTYCELLS);}
"float"                 {STORE_OPERATOR(CSS_FLOAT);}
"font"                  {STORE_OPERATOR(CSS_FONT);}
"font-family"           {STORE_OPERATOR(CSS_FONTFAMILY);}
"font-size"             {STORE_OPERATOR(CSS_FONTSIZE);}
"font-style"            {STORE_OPERATOR(CSS_FONTSTYLE);}
"font-variant"          {STORE_OPERATOR(CSS_FONTVARIANT);}
"font-weight"           {STORE_OPERATOR(CSS_FONTWEIGHT);}
"height"                {STORE_OPERATOR(CSS_HEIGHT);}
"left"                  {STORE_OPERATOR(CSS_LEFT);}
"letter-spacing"        {STORE_OPERATOR(CSS_LETTERSPACING);}
"line-height"           {STORE_OPERATOR(CSS_LINEHEIGHT);}
"list-style"            {STORE_OPERATOR(CSS_LISTSTYLE);}
"list-style-image"      {STORE_OPERATOR(CSS_LISTSTYLEIMAGE);}
"list-style-position"   {STORE_OPERATOR(CSS_LISTSTYLEPOSITION);}
"list-style-type"       {STORE_OPERATOR(CSS_LISTSTYLETYPE);}
"margin"                {STORE_OPERATOR(CSS_MARGIN);}
"margin-bottom"         {STORE_OPERATOR(CSS_MARGINBOTTOM);}
"margin-left"           {STORE_OPERATOR(CSS_MARGINLEFT);}
"margin-right"          {STORE_OPERATOR(CSS_MARGINRIGHT);}
"margin-top"            {STORE_OPERATOR(CSS_MARGINTOP);}
"max-height"            {STORE_OPERATOR(CSS_MAXHEIGHT);}
"max-width"             {STORE_OPERATOR(CSS_MAXWIDTH);}
"min-height"            {STORE_OPERATOR(CSS_MINHEIGHT);}
"min-width"             {STORE_OPERATOR(CSS_MINWIDTH);}
"orphans"               {STORE_OPERATOR(CSS_ORPHANS);}
"outline"               {STORE_OPERATOR(CSS_OUTLINE);}
"outline-color"         {STORE_OPERATOR(CSS_OUTLINECOLOR);}
"outline-style"         {STORE_OPERATOR(CSS_OUTLINESTYLE);}
"outline-width"         {STORE_OPERATOR(CSS_OUTLINEWIDTH);}
"overflow"              {STORE_OPERATOR(CSS_OVERFLOW);}
"padding"               {STORE_OPERATOR(CSS_PADDING);}
"padding-bottom"        {STORE_OPERATOR(CSS_PADDINGBOTTOM);}
"padding-left"          {STORE_OPERATOR(CSS_PADDINGLEFT);}
"padding-right"         {STORE_OPERATOR(CSS_PADDINGRIGHT);}
"padding-top"           {STORE_OPERATOR(CSS_PADDINGTOP);}
"page-break-after"      {STORE_OPERATOR(CSS_PAGEBREAKAFTER);}
"page-break-before"     {STORE_OPERATOR(CSS_PAGEBREAKBEFORE);}
"page-break-inside"     {STORE_OPERATOR(CSS_PAGEBREAKINSIDE);}
"pause"                 {STORE_OPERATOR(CSS_PAUSE);}
"pause-after"           {STORE_OPERATOR(CSS_PAUSEAFTER);}
"pause-before"          {STORE_OPERATOR(CSS_PAUSEBEFORE);}
"pitch"                 {STORE_OPERATOR(CSS_PITCH);}
"pitch-range"           {STORE_OPERATOR(CSS_PITCHRANGE);}
"play-during"           {STORE_OPERATOR(CSS_PLAYDURING);}
"position"              {STORE_OPERATOR(CSS_POSITION);}
"quotes"                {STORE_OPERATOR(CSS_QUOTES);}
"richness"              {STORE_OPERATOR(CSS_RICHNESS);}
"right"                 {STORE_OPERATOR(CSS_RIGHT);}
"speak"                 {STORE_OPERATOR(CSS_SPEAK);}
"speak-header"          {STORE_OPERATOR(CSS_SPEAKHEADER);}
"speak-numeral"         {STORE_OPERATOR(CSS_SPEAKNUMERAL);}
"speak-punctuation"     {STORE_OPERATOR(CSS_SPEAKPUNCTUATION);}
"speech-rate"           {STORE_OPERATOR(CSS_SPEECHRATE);}
"stress"                {STORE_OPERATOR(CSS_STRESS);}
"table-layout"          {STORE_OPERATOR(CSS_TABLELAYOUT);}
"text-align"            {STORE_OPERATOR(CSS_TEXTALIGN);}
"text-decoration"       {STORE_OPERATOR(CSS_TEXTDECORATION);}
"text-indent"           {STORE_OPERATOR(CSS_TEXTINDENT);}
"text-transform"        {STORE_OPERATOR(CSS_TEXTTRANSFORM);}
"top"                   {STORE_OPERATOR(CSS_TOP);}
"unicode-bidi"          {STORE_OPERATOR(CSS_UNICODEBIDI);}
"vertical-align"        {STORE_OPERATOR(CSS_VERTICALALIGN);}
"visibility"            {STORE_OPERATOR(CSS_VISIBILITY);}
"voice-family"          {STORE_OPERATOR(CSS_VOICEFAMILY);}
"volume"                {STORE_OPERATOR(CSS_VOLUME);}
"white-space"           {STORE_OPERATOR(CSS_WHITESPACE);}
"widows"                {STORE_OPERATOR(CSS_WIDOWS);}
"width"                 {STORE_OPERATOR(CSS_WIDTH);}
"word-spacing"          {STORE_OPERATOR(CSS_WORDSPACING);}
"z-index"               {STORE_OPERATOR(CSS_ZINDEX);}
"A"                     {STORE_OPERATOR(HTM_A);}
"ACTION"                {STORE_OPERATOR(HTM_ACTION);}
"ALINK"                 {STORE_OPERATOR(HTM_ALINK);}
"AREA"                  {STORE_OPERATOR(HTM_AREA);}
"B"                     {STORE_OPERATOR(HTM_B);}
"BIG"                   {STORE_OPERATOR(HTM_BIG);}
"BLINK"                 {STORE_OPERATOR(HTM_BLINK);}
"BLOCKQUOTE"            {STORE_OPERATOR(HTM_BLOCKQUOTE);}
"BODY"                  {STORE_OPERATOR(HTM_BODY);}
"BR"                    {STORE_OPERATOR(HTM_BR);}
"BUTTON"                {STORE_OPERATOR(HTM_BUTTON);}
"CAPTION"               {STORE_OPERATOR(HTM_CAPTION);}
"DD"                    {STORE_OPERATOR(HTM_DD);}
"DIV"                   {STORE_OPERATOR(HTM_DIV);}
"DL"                    {STORE_OPERATOR(HTM_DL);}
"DT"                    {STORE_OPERATOR(HTM_DT);}
"EM"                    {STORE_OPERATOR(HTM_EM);}
"FORM"                  {STORE_OPERATOR(HTM_FORM);}
"H1"                    {STORE_OPERATOR(HTM_H1);}
"H2"                    {STORE_OPERATOR(HTM_H2);}
"H3"                    {STORE_OPERATOR(HTM_H3);}
"H4"                    {STORE_OPERATOR(HTM_H4);}
"H5"                    {STORE_OPERATOR(HTM_H5);}
"H6"                    {STORE_OPERATOR(HTM_H6);}
"HEAD"                  {STORE_OPERATOR(HTM_HEAD);}
"HR"                    {STORE_OPERATOR(HTM_HR);}
"IFRAME"                {STORE_OPERATOR(HTM_IFRAME);}
"IMG"                   {STORE_OPERATOR(HTM_IMG);}
"INPUT"                 {STORE_OPERATOR(HTM_INPUT);}
"LABEL"                 {STORE_OPERATOR(HTM_LABEL);}
"LI"                    {STORE_OPERATOR(HTM_LI);}
"LINK"                  {STORE_OPERATOR(HTM_LINK);}
"LOOP"                  {STORE_OPERATOR(HTM_LOOP);}
"MAP"                   {STORE_OPERATOR(HTM_MAP);}
"OBJECT"                {STORE_OPERATOR(HTM_OBJECT);}
"OL"                    {STORE_OPERATOR(HTM_OL);}
"OPTGROUP"              {STORE_OPERATOR(HTM_OPTGROUP);}
"OPTION"                {STORE_OPERATOR(HTM_OPTION);}
"P"                     {STORE_OPERATOR(HTM_P);}
"PRE"                   {STORE_OPERATOR(HTM_PRE);}
"SELECT"                {STORE_OPERATOR(HTM_SELECT);}
"SELECTED"              {STORE_OPERATOR(HTM_SELECTED);}
"SERVER"                {STORE_OPERATOR(HTM_SERVER);}
"SHAPE"                 {STORE_OPERATOR(HTM_SHAPE);}
"SMALL"                 {STORE_OPERATOR(HTM_SMALL);}
"SOUND"                 {STORE_OPERATOR(HTM_SOUND);}
"SPACER"                {STORE_OPERATOR(HTM_SPACER);}
"START"                 {STORE_OPERATOR(HTM_START);}
"STRIKE"                {STORE_OPERATOR(HTM_STRIKE);}
"STRONG"                {STORE_OPERATOR(HTM_STRONG);}
"STYLE"                 {STORE_OPERATOR(HTM_STYLE);}
"SUB"                   {STORE_OPERATOR(HTM_SUB);}
"SUP"                   {STORE_OPERATOR(HTM_SUP);}
"TABLE"                 {STORE_OPERATOR(HTM_TABLE);}
"TBODY"                 {STORE_OPERATOR(HTM_TBODY);}
"TD"                    {STORE_OPERATOR(HTM_TD);}
"TEXT"                  {STORE_OPERATOR(HTM_TEXT);}
"TEXTAREA"              {STORE_OPERATOR(HTM_TEXTAREA);}
"TFOOT"                 {STORE_OPERATOR(HTM_TFOOT);}
"TH"                    {STORE_OPERATOR(HTM_TH);}
"THEAD"                 {STORE_OPERATOR(HTM_THEAD);}
"TR"                    {STORE_OPERATOR(HTM_TR);}
"TT"                    {STORE_OPERATOR(HTM_TT);}
"UL"                    {STORE_OPERATOR(HTM_UL);}

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

<STRD>\n                                                    { /* Double-quoted string literals */ css_lineno++;}
<STRD>\"                                                    {BEGIN 0;}
<STRD>.                                                     {COUNT();}

.                       { /* ignore bad characters */ }

%%
int yywrap() {
  return(1);
}

void lexclear() {
  BEGIN 0 ;
  noperands=0;
  j_comments=c_comments=cpp_comments=com_loc=0;
  prev_com_line=-1;
  css_lineno=nsemi=noperators=0;

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

