/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 * Essential Project Manager (EPM)
 * Copyright (c) 2004,2009 PowerSoftware.com
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * ASP Parser
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  19-Sep-06    117 : File created.
 * CAM  04-Dec-07    324 : Corrected issues prior to creating JSP parser.
 * CAM  24-Apr-08    358 : Corrected compiler warnings moving to VS2008 (from VC++6).
 * CAM  18-Apr-2009  10421 : Re-wrote to consider Native (CS&VB), Script (JS) and HTML symbols.
 * CAM  22-Sep-2010  10648 : Converted from string operands to PowerHashed.
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

%{

#include <stdio.h>
#include <string.h>
#include "y.asp.h"
#include "PowerHash.h"

#ifdef WIN32

#include <io.h>
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
set<unsigned int> operands;
int nsemi=0 ;           // Number of semi-colons
int noperators=0 ;      // Total number of operators
int noperands=0;        // Total number of operands

#define NOTE_SLOC()       sloc.insert(asp_lineno)
#define NOTE_SLOC_TAG()   NOTE_SLOC(); sltag.insert(asp_lineno)
#define NOTE_SLOC_NAT()   NOTE_SLOC(); slnat.insert(asp_lineno)
#define NOTE_SLOC_SCR()   NOTE_SLOC(); slscr.insert(asp_lineno)
#define NOTE_SLOC_HTM()   NOTE_SLOC(); slhtm.insert(asp_lineno)

#define STORE_OPERAND(X)  operands.insert(PowerHash(X)); noperands++; NOTE_SLOC();
#define SEMI()            nsemi++; NOTE_SLOC();

void lexclear();
void store_operator(int op, int typ);

%}

%p 4096
%x HTML_COM
%x SLOC_TAG
%x SLOC_NAT SLOC_NAT_STRD SLOC_NAT_ECOM
%x SLOC_SCR SLOC_SCR_STRD SLOC_SCR_ECOM
%x ASP_TAG
%x ASP_END
%x STR_LIT

NL                                                                    "\n"
NOTNL                                                                 .
ANY                                                                   ({NOTNL}|{NL})
BACKSL                                                                "\\"
BOL                                                                   ^
LETTER                                                                [A-Za-z_]
ALNUM                                                                 [A-Za-z_0-9]
DIGIT                                                                 [0-9]
HEXDIGIT                                                              [0-9A-Fa-f]
DIGITS                                                                ({DIGIT}+)
EXP                                                                   [Ee][+-]?DIGITS
HEXDIGITS                                                             ({HEXDIGIT}+)
SIGN                                                                  ("+"|"-")
ELL_SUFFIX                                                            [lL]([lL]?)
INT_SUFFIX                                                            ([uU]{ELL_SUFFIX}?|{ELL_SUFFIX}[uU]?)
FLOAT_SUFFIX                                                          [flFL]
STRCHAR                                                               [^\"\n\\]
ESCAPE                                                                ({BACKSL}{ANY})
QUOTE                                                                 [\"]
SPTAB                                                                 [ \t]

%%

^[ \t\v\f]*                                                           {;}

"<!--"                                                                {com_loc++; c_comments++; BEGIN HTML_COM;}
<HTML_COM>"-->"                                                       {BEGIN 0;}
<HTML_COM>"\n"                                                        {com_loc++; asp_lineno++;}
<HTML_COM>.                                                           {;}

"<%"                                                                  |
"<script".*"runat"[ ]*"=".*">"                                        { /* Server-side (native) script SLOC - within <% ... %> */ NOTE_SLOC_NAT(); BEGIN SLOC_NAT;}

<SLOC_NAT>"%>"                                                        |
<SLOC_NAT>"/>"                                                        |
<SLOC_NAT>"</script>"                                                 {NOTE_SLOC_NAT(); BEGIN 0;}

<SLOC_NAT>";"                                                         {NOTE_SLOC_NAT(); nsemi++;}
<SLOC_NAT>\n                                                          {asp_lineno++;}

<SLOC_NAT>\"                                                          {BEGIN SLOC_NAT_STRD;}

<SLOC_NAT>"'"                                                         |
<SLOC_NAT>"//"                                                        {BEGIN SLOC_NAT_ECOM; cpp_comments++;}

<SLOC_NAT>"'"."'"                                                     {STORE_OPERAND(yytext);NOTE_SLOC_NAT();}

<SLOC_NAT>"abstract"                                                  {store_operator(KEY_CS_ABSTRACT,1);}
<SLOC_NAT>"as"                                                        {store_operator(KEY_CS_AS,1);}
<SLOC_NAT>"base"                                                      {store_operator(KEY_CS_BASE,1);}
<SLOC_NAT>"bool"                                                      {store_operator(KEY_CS_BOOL,1);}
<SLOC_NAT>"break"                                                     {store_operator(KEY_CS_BREAK,1);}
<SLOC_NAT>"byte"                                                      {store_operator(KEY_CS_BYTE,1);}
<SLOC_NAT>"case"                                                      {store_operator(KEY_CS_CASE,1);}
<SLOC_NAT>"catch"                                                     {store_operator(KEY_CS_CATCH,1);}
<SLOC_NAT>"char"                                                      {store_operator(KEY_CS_CHAR,1);}
<SLOC_NAT>"checked"                                                   {store_operator(KEY_CS_CHECKED,1);}
<SLOC_NAT>"class"                                                     {store_operator(KEY_CS_CLASS,1);}
<SLOC_NAT>"const"                                                     {store_operator(KEY_CS_CONST,1);}
<SLOC_NAT>"continue"                                                  {store_operator(KEY_CS_CONTINUE,1);}
<SLOC_NAT>"decimal"                                                   {store_operator(KEY_CS_DECIMAL,1);}
<SLOC_NAT>"default"                                                   {store_operator(KEY_CS_DEFAULT,1);}
<SLOC_NAT>"delegate"                                                  {store_operator(KEY_CS_DELEGATE,1);}
<SLOC_NAT>"do"                                                        {store_operator(KEY_CS_DO,1);}
<SLOC_NAT>"double"                                                    {store_operator(KEY_CS_DOUBLE,1);}
<SLOC_NAT>"else"                                                      {store_operator(KEY_CS_ELSE,1);}
<SLOC_NAT>"enum"                                                      {store_operator(KEY_CS_ENUM,1);}
<SLOC_NAT>"event"                                                     {store_operator(KEY_CS_EVENT,1);}
<SLOC_NAT>"explicit"                                                  {store_operator(KEY_CS_EXPLICIT,1);}
<SLOC_NAT>"extern"                                                    {store_operator(KEY_CS_EXTERN,1);}
<SLOC_NAT>"finally"                                                   {store_operator(KEY_CS_FINALLY,1);}
<SLOC_NAT>"fixed"                                                     {store_operator(KEY_CS_FIXED,1);}
<SLOC_NAT>"float"                                                     {store_operator(KEY_CS_FLOAT,1);}
<SLOC_NAT>"for"                                                       {store_operator(KEY_CS_FOR,1);}
<SLOC_NAT>"foreach"                                                   {store_operator(KEY_CS_FOREACH,1);}
<SLOC_NAT>"goto"                                                      {store_operator(KEY_CS_GOTO,1);}
<SLOC_NAT>"if"                                                        {store_operator(KEY_CS_IF,1);}
<SLOC_NAT>"implicit"                                                  {store_operator(KEY_CS_IMPLICIT,1);}
<SLOC_NAT>"in"                                                        {store_operator(KEY_CS_IN,1);}
<SLOC_NAT>"int"                                                       {store_operator(KEY_CS_INT,1);}
<SLOC_NAT>"interface"                                                 {store_operator(KEY_CS_INTERFACE,1);}
<SLOC_NAT>"internal"                                                  {store_operator(KEY_CS_INTERNAL,1);}
<SLOC_NAT>"is"                                                        {store_operator(KEY_CS_IS,1);}
<SLOC_NAT>"lock"                                                      {store_operator(KEY_CS_LOCK,1);}
<SLOC_NAT>"long"                                                      {store_operator(KEY_CS_LONG,1);}
<SLOC_NAT>"namespace"                                                 {store_operator(KEY_CS_NAMESPACE,1);}
<SLOC_NAT>"new"                                                       {store_operator(KEY_CS_NEW,1);}
<SLOC_NAT>"object"                                                    {store_operator(KEY_CS_OBJECT,1);}
<SLOC_NAT>"operator"                                                  {store_operator(KEY_CS_OPERATOR,1);}
<SLOC_NAT>"out"                                                       {store_operator(KEY_CS_OUT,1);}
<SLOC_NAT>"override"                                                  {store_operator(KEY_CS_OVERRIDE,1);}
<SLOC_NAT>"params"                                                    {store_operator(KEY_CS_PARAMS,1);}
<SLOC_NAT>"private"                                                   {store_operator(KEY_CS_PRIVATE,1);}
<SLOC_NAT>"protected"                                                 {store_operator(KEY_CS_PROTECTED,1);}
<SLOC_NAT>"public"                                                    {store_operator(KEY_CS_PUBLIC,1);}
<SLOC_NAT>"readonly"                                                  {store_operator(KEY_CS_READONLY,1);}
<SLOC_NAT>"ref"                                                       {store_operator(KEY_CS_REF,1);}
<SLOC_NAT>"return"                                                    {store_operator(KEY_CS_RETURN,1);}
<SLOC_NAT>"sbyte"                                                     {store_operator(KEY_CS_SBYTE,1);}
<SLOC_NAT>"sealed"                                                    {store_operator(KEY_CS_SEALED,1);}
<SLOC_NAT>"short"                                                     {store_operator(KEY_CS_SHORT,1);}
<SLOC_NAT>"sizeof"                                                    {store_operator(KEY_CS_SIZEOF,1);}
<SLOC_NAT>"stackalloc"                                                {store_operator(KEY_CS_STACKALLOC,1);}
<SLOC_NAT>"static"                                                    {store_operator(KEY_CS_STATIC,1);}
<SLOC_NAT>"string"                                                    {store_operator(KEY_CS_STRING,1);}
<SLOC_NAT>"struct"                                                    {store_operator(KEY_CS_STRUCT,1);}
<SLOC_NAT>"switch"                                                    {store_operator(KEY_CS_SWITCH,1);}
<SLOC_NAT>"this"                                                      {store_operator(KEY_CS_THIS,1);}
<SLOC_NAT>"throw"                                                     {store_operator(KEY_CS_THROW,1);}
<SLOC_NAT>"try"                                                       {store_operator(KEY_CS_TRY,1);}
<SLOC_NAT>"typeof"                                                    {store_operator(KEY_CS_TYPEOF,1);}
<SLOC_NAT>"uint"                                                      {store_operator(KEY_CS_UINT,1);}
<SLOC_NAT>"ulong"                                                     {store_operator(KEY_CS_ULONG,1);}
<SLOC_NAT>"unchecked"                                                 {store_operator(KEY_CS_UNCHECKED,1);}
<SLOC_NAT>"unsafe"                                                    {store_operator(KEY_CS_UNSAFE,1);}
<SLOC_NAT>"ushort"                                                    {store_operator(KEY_CS_USHORT,1);}
<SLOC_NAT>"using"                                                     {store_operator(KEY_CS_USING,1);}
<SLOC_NAT>"virtual"                                                   {store_operator(KEY_CS_VIRTUAL,1);}
<SLOC_NAT>"void"                                                      {store_operator(KEY_CS_VOID,1);}
<SLOC_NAT>"volatile"                                                  {store_operator(KEY_CS_VOLATILE,1);}
<SLOC_NAT>"while"                                                     {store_operator(KEY_CS_WHILE,1);}
<SLOC_NAT>"AddHandler"                                                {store_operator(KEY_VB_ADDHANDLER,1);}
<SLOC_NAT>"AddressOf"                                                 {store_operator(KEY_VB_ADDRESSOF,1);}
<SLOC_NAT>"Alias"                                                     {store_operator(KEY_VB_ALIAS,1);}
<SLOC_NAT>"And"                                                       {store_operator(KEY_VB_AND,1);}
<SLOC_NAT>"AndAlso"                                                   {store_operator(KEY_VB_ANDALSO,1);}
<SLOC_NAT>"Ansi"                                                      {store_operator(KEY_VB_ANSI,1);}
<SLOC_NAT>"Assembly"                                                  {store_operator(KEY_VB_ASSEMBLY,1);}
<SLOC_NAT>"Auto"                                                      {store_operator(KEY_VB_AUTO,1);}
<SLOC_NAT>"Boolean"                                                   {store_operator(KEY_VB_BOOLEAN,1);}
<SLOC_NAT>"ByRef"                                                     {store_operator(KEY_VB_BYREF,1);}
<SLOC_NAT>"ByVal"                                                     {store_operator(KEY_VB_BYVAL,1);}
<SLOC_NAT>"Call"                                                      {store_operator(KEY_VB_CALL,1);}
<SLOC_NAT>"CBool"                                                     {store_operator(KEY_VB_CBOOL,1);}
<SLOC_NAT>"CByte"                                                     {store_operator(KEY_VB_CBYTE,1);}
<SLOC_NAT>"CChar"                                                     {store_operator(KEY_VB_CCHAR,1);}
<SLOC_NAT>"CDate"                                                     {store_operator(KEY_VB_CDATE,1);}
<SLOC_NAT>"CDbl"                                                      {store_operator(KEY_VB_CDBL,1);}
<SLOC_NAT>"CDec"                                                      {store_operator(KEY_VB_CDEC,1);}
<SLOC_NAT>"CInt"                                                      {store_operator(KEY_VB_CINT,1);}
<SLOC_NAT>"CLng"                                                      {store_operator(KEY_VB_CLNG,1);}
<SLOC_NAT>"CObj"                                                      {store_operator(KEY_VB_COBJ,1);}
<SLOC_NAT>"CShort"                                                    {store_operator(KEY_VB_CSHORT,1);}
<SLOC_NAT>"CSng"                                                      {store_operator(KEY_VB_CSNG,1);}
<SLOC_NAT>"CStr"                                                      {store_operator(KEY_VB_CSTR,1);}
<SLOC_NAT>"CType"                                                     {store_operator(KEY_VB_CTYPE,1);}
<SLOC_NAT>"Date"                                                      {store_operator(KEY_VB_DATE,1);}
<SLOC_NAT>"Declare"                                                   {store_operator(KEY_VB_DECLARE,1);}
<SLOC_NAT>"Dim"                                                       {store_operator(KEY_VB_DIM,1);}
<SLOC_NAT>"DirectCast"                                                {store_operator(KEY_VB_DIRECTCAST,1);}
<SLOC_NAT>"Each"                                                      {store_operator(KEY_VB_EACH,1);}
<SLOC_NAT>"ElseIf"                                                    {store_operator(KEY_VB_ELSEIF,1);}
<SLOC_NAT>"End"                                                       {store_operator(KEY_VB_END,1);}
<SLOC_NAT>"EndIf"                                                     {store_operator(KEY_VB_ENDIF,1);}
<SLOC_NAT>"Erase"                                                     {store_operator(KEY_VB_ERASE,1);}
<SLOC_NAT>"Error"                                                     {store_operator(KEY_VB_ERROR,1);}
<SLOC_NAT>"Exit"                                                      {store_operator(KEY_VB_EXIT,1);}
<SLOC_NAT>"False"                                                     {store_operator(KEY_VB_FALSE,1);}
<SLOC_NAT>"Friend"                                                    {store_operator(KEY_VB_FRIEND,1);}
<SLOC_NAT>"Function"                                                  {store_operator(KEY_VB_FUNCTION,1);}
<SLOC_NAT>"Get"                                                       {store_operator(KEY_VB_GET,1);}
<SLOC_NAT>"GetType"                                                   {store_operator(KEY_VB_GETTYPE,1);}
<SLOC_NAT>"GoSub"                                                     {store_operator(KEY_VB_GOSUB,1);}
<SLOC_NAT>"Handles"                                                   {store_operator(KEY_VB_HANDLES,1);}
<SLOC_NAT>"Implements"                                                {store_operator(KEY_VB_IMPLEMENTS,1);}
<SLOC_NAT>"Imports"                                                   {store_operator(KEY_VB_IMPORTS,1);}
<SLOC_NAT>"Inherits"                                                  {store_operator(KEY_VB_INHERITS,1);}
<SLOC_NAT>"Integer"                                                   {store_operator(KEY_VB_INTEGER,1);}
<SLOC_NAT>"Let"                                                       {store_operator(KEY_VB_LET,1);}
<SLOC_NAT>"Lib"                                                       {store_operator(KEY_VB_LIB,1);}
<SLOC_NAT>"Like"                                                      {store_operator(KEY_VB_LIKE,1);}
<SLOC_NAT>"Loop"                                                      {store_operator(KEY_VB_LOOP,1);}
<SLOC_NAT>"Me"                                                        {store_operator(KEY_VB_ME,1);}
<SLOC_NAT>"Mod"                                                       {store_operator(KEY_VB_MOD,1);}
<SLOC_NAT>"Module"                                                    {store_operator(KEY_VB_MODULE,1);}
<SLOC_NAT>"MustInherit"                                               {store_operator(KEY_VB_MUSTINHERIT,1);}
<SLOC_NAT>"MustOverride"                                              {store_operator(KEY_VB_MUSTOVERRIDE,1);}
<SLOC_NAT>"MyBase"                                                    {store_operator(KEY_VB_MYBASE,1);}
<SLOC_NAT>"MyClass"                                                   {store_operator(KEY_VB_MYCLASS,1);}
<SLOC_NAT>"Next"                                                      {store_operator(KEY_VB_NEXT,1);}
<SLOC_NAT>"Not"                                                       {store_operator(KEY_VB_NOT,1);}
<SLOC_NAT>"Nothing"                                                   {store_operator(KEY_VB_NOTHING,1);}
<SLOC_NAT>"NotInheritable"                                            {store_operator(KEY_VB_NOTINHERITABLE,1);}
<SLOC_NAT>"NotOverridable"                                            {store_operator(KEY_VB_NOTOVERRIDABLE,1);}
<SLOC_NAT>"On"                                                        {store_operator(KEY_VB_ON,1);}
<SLOC_NAT>"Option"                                                    {store_operator(KEY_VB_OPTION,1);}
<SLOC_NAT>"Optional"                                                  {store_operator(KEY_VB_OPTIONAL,1);}
<SLOC_NAT>"Or"                                                        {store_operator(KEY_VB_OR,1);}
<SLOC_NAT>"OrElse"                                                    {store_operator(KEY_VB_ORELSE,1);}
<SLOC_NAT>"Overloads"                                                 {store_operator(KEY_VB_OVERLOADS,1);}
<SLOC_NAT>"Overridable"                                               {store_operator(KEY_VB_OVERRIDABLE,1);}
<SLOC_NAT>"Overrides"                                                 {store_operator(KEY_VB_OVERRIDES,1);}
<SLOC_NAT>"ParamArray"                                                {store_operator(KEY_VB_PARAMARRAY,1);}
<SLOC_NAT>"Preserve"                                                  {store_operator(KEY_VB_PRESERVE,1);}
<SLOC_NAT>"Property"                                                  {store_operator(KEY_VB_PROPERTY,1);}
<SLOC_NAT>"RaiseEvent"                                                {store_operator(KEY_VB_RAISEEVENT,1);}
<SLOC_NAT>"ReDim"                                                     {store_operator(KEY_VB_REDIM,1);}
<SLOC_NAT>"RemoveHandler"                                             {store_operator(KEY_VB_REMOVEHANDLER,1);}
<SLOC_NAT>"Resume"                                                    {store_operator(KEY_VB_RESUME,1);}
<SLOC_NAT>"Select"                                                    {store_operator(KEY_VB_SELECT,1);}
<SLOC_NAT>"Set"                                                       {store_operator(KEY_VB_SET,1);}
<SLOC_NAT>"Shadows"                                                   {store_operator(KEY_VB_SHADOWS,1);}
<SLOC_NAT>"Shared"                                                    {store_operator(KEY_VB_SHARED,1);}
<SLOC_NAT>"Single"                                                    {store_operator(KEY_VB_SINGLE,1);}
<SLOC_NAT>"Step"                                                      {store_operator(KEY_VB_STEP,1);}
<SLOC_NAT>"Stop"                                                      {store_operator(KEY_VB_STOP,1);}
<SLOC_NAT>"Structure"                                                 {store_operator(KEY_VB_STRUCTURE,1);}
<SLOC_NAT>"Sub"                                                       {store_operator(KEY_VB_SUB,1);}
<SLOC_NAT>"SyncLock"                                                  {store_operator(KEY_VB_SYNCLOCK,1);}
<SLOC_NAT>"Then"                                                      {store_operator(KEY_VB_THEN,1);}
<SLOC_NAT>"To"                                                        {store_operator(KEY_VB_TO,1);}
<SLOC_NAT>"True"                                                      {store_operator(KEY_VB_TRUE,1);}
<SLOC_NAT>"Unicode"                                                   {store_operator(KEY_VB_UNICODE,1);}
<SLOC_NAT>"Until"                                                     {store_operator(KEY_VB_UNTIL,1);}
<SLOC_NAT>"Variant"                                                   {store_operator(KEY_VB_VARIANT,1);}
<SLOC_NAT>"Wend"                                                      {store_operator(KEY_VB_WEND,1);}
<SLOC_NAT>"When"                                                      {store_operator(KEY_VB_WHEN,1);}
<SLOC_NAT>"With"                                                      {store_operator(KEY_VB_WITH,1);}
<SLOC_NAT>"WithEvents"                                                {store_operator(KEY_VB_WITHEVENTS,1);}
<SLOC_NAT>"WriteOnly"                                                 {store_operator(KEY_VB_WRITEONLY,1);}
<SLOC_NAT>"Xor"                                                       {store_operator(KEY_VB_XOR,1);}
<SLOC_NAT>"&"                                                         {store_operator(SYM_AMPERSAND,1);}
<SLOC_NAT>"&&"                                                        {store_operator(SYM_ANDAND,1);}
<SLOC_NAT>"&="                                                        {store_operator(SYM_ANDEQ,1);}
<SLOC_NAT>"*"                                                         {store_operator(SYM_ASTERISK,1);}
<SLOC_NAT>"*="                                                        {store_operator(SYM_ASTERISKEQ,1);}
<SLOC_NAT>"|"                                                         {store_operator(SYM_BAR,1);}
<SLOC_NAT>"||"                                                        {store_operator(SYM_BARBAR,1);}
<SLOC_NAT>"|="                                                        {store_operator(SYM_BAREQ,1);}
<SLOC_NAT>"\\"                                                        {store_operator(SYM_BKSLASHBKSLASH,1);}
<SLOC_NAT>"^"                                                         {store_operator(SYM_CARET,1);}
<SLOC_NAT>"^="                                                        {store_operator(SYM_CARETEQ,1);}
<SLOC_NAT>":"                                                         {store_operator(SYM_COLON,1);}
<SLOC_NAT>","                                                         {store_operator(SYM_COMMA,1);}
<SLOC_NAT>"=="                                                        {store_operator(SYM_EQEQ,1);}
<SLOC_NAT>"="                                                         {store_operator(SYM_EQUAL,1);}
<SLOC_NAT>"!"                                                         {store_operator(SYM_EXCLAIM,1);}
<SLOC_NAT>">"                                                         {store_operator(SYM_GT,1);}
<SLOC_NAT>">="                                                        {store_operator(SYM_GTEQ,1);}
<SLOC_NAT>">>"                                                        {store_operator(SYM_GTGT,1);}
<SLOC_NAT>">>="                                                       {store_operator(SYM_GTGTEQ,1);}
<SLOC_NAT>">>>"                                                       {store_operator(SYM_GTGTGT,1);}
<SLOC_NAT>">>>="                                                      {store_operator(SYM_GTGTGTEQ,1);}
<SLOC_NAT>"<"                                                         {store_operator(SYM_LT,1);}
<SLOC_NAT>"<="                                                        {store_operator(SYM_LTEQ,1);}
<SLOC_NAT>"<>"                                                        {store_operator(SYM_LTGT,1);}
<SLOC_NAT>"<<"                                                        {store_operator(SYM_LTLT,1);}
<SLOC_NAT>"<<="                                                       {store_operator(SYM_LTLTEQ,1);}
<SLOC_NAT>"-"                                                         {store_operator(SYM_MINUS,1);}
<SLOC_NAT>"-="                                                        {store_operator(SYM_MINUSEQ,1);}
<SLOC_NAT>"--"                                                        {store_operator(SYM_MINUSMINUS,1);}
<SLOC_NAT>"!="                                                        {store_operator(SYM_NOTEQ,1);}
<SLOC_NAT>"%"                                                         {store_operator(SYM_PERCENT,1);}
<SLOC_NAT>"%="                                                        {store_operator(SYM_PERCENTEQ,1);}
<SLOC_NAT>"."                                                         {store_operator(SYM_PERIOD,1);}
<SLOC_NAT>"+"                                                         {store_operator(SYM_PLUS,1);}
<SLOC_NAT>"+="                                                        {store_operator(SYM_PLUSEQ,1);}
<SLOC_NAT>"++"                                                        {store_operator(SYM_PLUSPLUS,1);}
<SLOC_NAT>"?"                                                         {store_operator(SYM_QUERY,1);}
<SLOC_NAT>"/"                                                         {store_operator(SYM_SLASH,1);}
<SLOC_NAT>"/="                                                        {store_operator(SYM_SLASHEQ,1);}
<SLOC_NAT>"~"                                                         {store_operator(SYM_TIDLE,1);}

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
<SLOC_NAT>"."{DIGITS}[eE]{SIGN}?                                      {STORE_OPERAND(yytext);NOTE_SLOC_NAT();}

<SLOC_NAT>[ \t\v\f]                                                   {;}
<SLOC_NAT>.                                                           {;}

<SLOC_NAT_STRD>\n                                                     { /* Double-quoted string literals within ASP native */ asp_lineno++;}
<SLOC_NAT_STRD>\"                                                     {BEGIN SLOC_NAT;}
<SLOC_NAT_STRD>.                                                      {NOTE_SLOC_NAT();}

<SLOC_NAT_ECOM>\n                                                     { /* To-end-of-line Comments within ASP native */ asp_lineno++; com_loc++; BEGIN SLOC_NAT;}
<SLOC_NAT_ECOM>.                                                      {}

"<script".*">"                                                        { /* Client-side Script SLOC - within <script> ... </script> */ NOTE_SLOC_SCR(); BEGIN SLOC_SCR; }
<SLOC_SCR>"/>"                                                        |
<SLOC_SCR>"</script>"                                                 {NOTE_SLOC_SCR(); BEGIN 0;}

<SLOC_SCR>\"                                                          {BEGIN SLOC_SCR_STRD;}
<SLOC_SCR>"//"                                                        {BEGIN SLOC_SCR_ECOM; cpp_comments++;}

<SLOC_SCR>\n                                                          {asp_lineno++;}

<SLOC_SCR>"abstract"                                                  {store_operator(KEY_JS_ABSTRACT,4);}
<SLOC_SCR>"boolean"                                                   {store_operator(KEY_JS_BOOLEAN,4);}
<SLOC_SCR>"break"                                                     {store_operator(KEY_JS_BREAK,4);}
<SLOC_SCR>"byte"                                                      {store_operator(KEY_JS_BYTE,4);}
<SLOC_SCR>"case"                                                      {store_operator(KEY_JS_CASE,4);}
<SLOC_SCR>"catch"                                                     {store_operator(KEY_JS_CATCH,4);}
<SLOC_SCR>"char"                                                      {store_operator(KEY_JS_CHAR,4);}
<SLOC_SCR>"class"                                                     {store_operator(KEY_JS_CLASS,4);}
<SLOC_SCR>"const"                                                     {store_operator(KEY_JS_CONST,4);}
<SLOC_SCR>"continue"                                                  {store_operator(KEY_JS_CONTINUE,4);}
<SLOC_SCR>"default"                                                   {store_operator(KEY_JS_DEFAULT,4);}
<SLOC_SCR>"delete"                                                    {store_operator(KEY_JS_DELETE,4);}
<SLOC_SCR>"do"                                                        {store_operator(KEY_JS_DO,4);}
<SLOC_SCR>"double"                                                    {store_operator(KEY_JS_DOUBLE,4);}
<SLOC_SCR>"else"                                                      {store_operator(KEY_JS_ELSE,4);}
<SLOC_SCR>"extends"                                                   {store_operator(KEY_JS_EXTENDS,4);}
<SLOC_SCR>"final"                                                     {store_operator(KEY_JS_FINAL,4);}
<SLOC_SCR>"finally"                                                   {store_operator(KEY_JS_FINALLY,4);}
<SLOC_SCR>"float"                                                     {store_operator(KEY_JS_FLOAT,4);}
<SLOC_SCR>"for"                                                       {store_operator(KEY_JS_FOR,4);}
<SLOC_SCR>"function"                                                  {store_operator(KEY_JS_FUNCTION,4);}
<SLOC_SCR>"goto"                                                      {store_operator(KEY_JS_GOTO,4);}
<SLOC_SCR>"if"                                                        {store_operator(KEY_JS_IF,4);}
<SLOC_SCR>"implements"                                                {store_operator(KEY_JS_IMPLEMENTS,4);}
<SLOC_SCR>"import"                                                    {store_operator(KEY_JS_IMPORT,4);}
<SLOC_SCR>"in"                                                        {store_operator(KEY_JS_IN,4);}
<SLOC_SCR>"instanceof"                                                {store_operator(KEY_JS_INSTANCEOF,4);}
<SLOC_SCR>"int"                                                       {store_operator(KEY_JS_INT,4);}
<SLOC_SCR>"interface"                                                 {store_operator(KEY_JS_INTERFACE,4);}
<SLOC_SCR>"long"                                                      {store_operator(KEY_JS_LONG,4);}
<SLOC_SCR>"native"                                                    {store_operator(KEY_JS_NATIVE,4);}
<SLOC_SCR>"new"                                                       {store_operator(KEY_JS_NEW,4);}
<SLOC_SCR>"package"                                                   {store_operator(KEY_JS_PACKAGE,4);}
<SLOC_SCR>"private"                                                   {store_operator(KEY_JS_PRIVATE,4);}
<SLOC_SCR>"protected"                                                 {store_operator(KEY_JS_PROTECTED,4);}
<SLOC_SCR>"public"                                                    {store_operator(KEY_JS_PUBLIC,4);}
<SLOC_SCR>"return"                                                    {store_operator(KEY_JS_RETURN,4);}
<SLOC_SCR>"short"                                                     {store_operator(KEY_JS_SHORT,4);}
<SLOC_SCR>"static"                                                    {store_operator(KEY_JS_STATIC,4);}
<SLOC_SCR>"super"                                                     {store_operator(KEY_JS_SUPER,4);}
<SLOC_SCR>"switch"                                                    {store_operator(KEY_JS_SWITCH,4);}
<SLOC_SCR>"synchronized"                                              {store_operator(KEY_JS_SYNCHRONIZED,4);}
<SLOC_SCR>"this"                                                      {store_operator(KEY_JS_THIS,4);}
<SLOC_SCR>"throw"                                                     {store_operator(KEY_JS_THROW,4);}
<SLOC_SCR>"throws"                                                    {store_operator(KEY_JS_THROWS,4);}
<SLOC_SCR>"transient"                                                 {store_operator(KEY_JS_TRANSIENT,4);}
<SLOC_SCR>"try"                                                       {store_operator(KEY_JS_TRY,4);}
<SLOC_SCR>"typeof"                                                    {store_operator(KEY_JS_TYPEOF,4);}
<SLOC_SCR>"var"                                                       {store_operator(KEY_JS_VAR,4);}
<SLOC_SCR>"void"                                                      {store_operator(KEY_JS_VOID,4);}
<SLOC_SCR>"volatile"                                                  {store_operator(KEY_JS_VOLATILE,4);}
<SLOC_SCR>"while"                                                     {store_operator(KEY_JS_WHILE,4);}
<SLOC_SCR>"with"                                                      {store_operator(KEY_JS_WITH,4);}
<SLOC_SCR>"="                                                         {store_operator(SYM_JS_ASSIGN,4);}
<SLOC_SCR>"&="                                                        {store_operator(SYM_JS_ASSIGNBITAND,4);}
<SLOC_SCR>"|="                                                        {store_operator(SYM_JS_ASSIGNBITOR,4);}
<SLOC_SCR>"/="                                                        {store_operator(SYM_JS_ASSIGNDIVIDE,4);}
<SLOC_SCR>"^="                                                        {store_operator(SYM_JS_ASSIGNEXPONENT,4);}
<SLOC_SCR>"-="                                                        {store_operator(SYM_JS_ASSIGNMINUS,4);}
<SLOC_SCR>"%="                                                        {store_operator(SYM_JS_ASSIGNMOD,4);}
<SLOC_SCR>"*="                                                        {store_operator(SYM_JS_ASSIGNMULTIPLY,4);}
<SLOC_SCR>"+="                                                        {store_operator(SYM_JS_ASSIGNPLUS,4);}
<SLOC_SCR>"<<="                                                       {store_operator(SYM_JS_ASSIGNSHIFTLT,4);}
<SLOC_SCR>">>="                                                       {store_operator(SYM_JS_ASSIGNSHIFTRT,4);}
<SLOC_SCR>">>>="                                                      {store_operator(SYM_JS_ASSIGNSHIFTRTUNS,4);}
<SLOC_SCR>"*"                                                         {store_operator(SYM_JS_ASTERISK,4);}
<SLOC_SCR>"&"                                                         {store_operator(SYM_JS_BITAND,4);}
<SLOC_SCR>"|"                                                         {store_operator(SYM_JS_BITOR,4);}
<SLOC_SCR>"}"                                                         {store_operator(SYM_JS_BRACEC,4);}
<SLOC_SCR>"{"                                                         {store_operator(SYM_JS_BRACEO,4);}
<SLOC_SCR>"]"                                                         {store_operator(SYM_JS_BRACKETC,4);}
<SLOC_SCR>"["                                                         {store_operator(SYM_JS_BRACKETO,4);}
<SLOC_SCR>":"                                                         {store_operator(SYM_JS_COLON,4);}
<SLOC_SCR>","                                                         {store_operator(SYM_JS_COMMA,4);}
<SLOC_SCR>"--"                                                        {store_operator(SYM_JS_DECREMENT,4);}
<SLOC_SCR>"=="                                                        {store_operator(SYM_JS_EQUALS,4);}
<SLOC_SCR>"^"                                                         {store_operator(SYM_JS_EXPONENT,4);}
<SLOC_SCR>">"                                                         {store_operator(SYM_JS_GT,4);}
<SLOC_SCR>">="                                                        {store_operator(SYM_JS_GTEQUAL,4);}
<SLOC_SCR>"++"                                                        {store_operator(SYM_JS_INCREMENT,4);}
<SLOC_SCR>"&&"                                                        {store_operator(SYM_JS_LOGAND,4);}
<SLOC_SCR>"||"                                                        {store_operator(SYM_JS_LOGOR,4);}
<SLOC_SCR>"<"                                                         {store_operator(SYM_JS_LT,4);}
<SLOC_SCR>"<="                                                        {store_operator(SYM_JS_LTEQUAL,4);}
<SLOC_SCR>"-"                                                         {store_operator(SYM_JS_MINUS,4);}
<SLOC_SCR>"!"                                                         {store_operator(SYM_JS_NOT,4);}
<SLOC_SCR>"!="                                                        {store_operator(SYM_JS_NOTEQUAL,4);}
<SLOC_SCR>")"                                                         {store_operator(SYM_JS_PARENC,4);}
<SLOC_SCR>"("                                                         {store_operator(SYM_JS_PARENO,4);}
<SLOC_SCR>"%"                                                         {store_operator(SYM_JS_PERCENT,4);}
<SLOC_SCR>"."                                                         {store_operator(SYM_JS_PERIOD,4);}
<SLOC_SCR>"+"                                                         {store_operator(SYM_JS_PLUS,4);}
<SLOC_SCR>"?"                                                         {store_operator(SYM_JS_QUESTION,4);}
<SLOC_SCR>";"                                                         {store_operator(SYM_JS_SEMICOLON,4);}
<SLOC_SCR>"<<"                                                        {store_operator(SYM_JS_SHIFTLT,4);}
<SLOC_SCR>">>"                                                        {store_operator(SYM_JS_SHIFTRT,4);}
<SLOC_SCR>">>>"                                                       {store_operator(SYM_JS_SHIFTRTUNS,4);}
<SLOC_SCR>"/"                                                         {store_operator(SYM_JS_SLASH,4);}
<SLOC_SCR>"~"                                                         {store_operator(SYM_JS_TILDE,4);}

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
<SLOC_SCR>"."{DIGITS}[eE]{SIGN}?                                      {STORE_OPERAND(yytext);NOTE_SLOC_SCR();}

<SLOC_SCR>[ \t\v\f]                                                   {;}
<SLOC_SCR>.                                                           {NOTE_SLOC_SCR(); }

<SLOC_SCR_STRD>\n                                                     { /* Double-quoted string literals within Client-side Script */ asp_lineno++;}
<SLOC_SCR_STRD>\"                                                     {BEGIN SLOC_SCR;}
<SLOC_SCR_STRD>.                                                      {NOTE_SLOC_SCR();}

<SLOC_SCR_ECOM>\n                                                     { /* To-end-of-line Comments within Client-side Script */ asp_lineno++; com_loc++; BEGIN SLOC_SCR;}
<SLOC_SCR_ECOM>.                                                      {;}

"<asp"                                                                {NOTE_SLOC_TAG(); BEGIN ASP_TAG; }
<ASP_TAG>">"                                                          {NOTE_SLOC_TAG(); BEGIN 0;}
<ASP_TAG>\n                                                           {asp_lineno++;}
<ASP_TAG>.                                                            {;}

"</asp"                                                               {NOTE_SLOC_TAG(); BEGIN ASP_END; }
<ASP_END>">"                                                          {NOTE_SLOC_TAG(); BEGIN 0;}
<ASP_END>\n                                                           {asp_lineno++;}
<ASP_END>.                                                            {;}

\n                                                                    {asp_lineno++;}

"A"                                                                   {store_operator(KEY_HTM_A,3);}
"ACTION"                                                              {store_operator(KEY_HTM_ACTION,3);}
"ADDRESS"                                                             {store_operator(KEY_HTM_ADDRESS,3);}
"ALIGN"                                                               {store_operator(KEY_HTM_ALIGN,3);}
"ALINK"                                                               {store_operator(KEY_HTM_ALINK,3);}
"ALT"                                                                 {store_operator(KEY_HTM_ALT,3);}
"APPLET"                                                              {store_operator(KEY_HTM_APPLET,3);}
"AREA"                                                                {store_operator(KEY_HTM_AREA,3);}
"B"                                                                   {store_operator(KEY_HTM_B,3);}
"BACKGROUND"                                                          {store_operator(KEY_HTM_BACKGROUND,3);}
"BASE"                                                                {store_operator(KEY_HTM_BASE,3);}
"BGCOLOR"                                                             {store_operator(KEY_HTM_BGCOLOR,3);}
"BIG"                                                                 {store_operator(KEY_HTM_BIG,3);}
"BLINK"                                                               {store_operator(KEY_HTM_BLINK,3);}
"BLOCKQUOTE"                                                          {store_operator(KEY_HTM_BLOCKQUOTE,3);}
"BODY"                                                                {store_operator(KEY_HTM_BODY,3);}
"BORDER"                                                              {store_operator(KEY_HTM_BORDER,3);}
"BORDERCOLOR"                                                         {store_operator(KEY_HTM_BORDERCOLOR,3);}
"BOTTOMMARGIN"                                                        {store_operator(KEY_HTM_BOTTOMMARGIN,3);}
"BR"                                                                  {store_operator(KEY_HTM_BR,3);}
"BUTTON"                                                              {store_operator(KEY_HTM_BUTTON,3);}
"CAPTION"                                                             {store_operator(KEY_HTM_CAPTION,3);}
"CELLPADDING"                                                         {store_operator(KEY_HTM_CELLPADDING,3);}
"CELLSPACING"                                                         {store_operator(KEY_HTM_CELLSPACING,3);}
"CENTER"                                                              {store_operator(KEY_HTM_CENTER,3);}
"CHECKED"                                                             {store_operator(KEY_HTM_CHECKED,3);}
"CLASS"                                                               {store_operator(KEY_HTM_CLASS,3);}
"CLASSID"                                                             {store_operator(KEY_HTM_CLASSID,3);}
"CLEAR"                                                               {store_operator(KEY_HTM_CLEAR,3);}
"CODE"                                                                {store_operator(KEY_HTM_CODE,3);}
"CODEBASE"                                                            {store_operator(KEY_HTM_CODEBASE,3);}
"CODETYPE"                                                            {store_operator(KEY_HTM_CODETYPE,3);}
"COL"                                                                 {store_operator(KEY_HTM_COL,3);}
"COLGROUP"                                                            {store_operator(KEY_HTM_COLGROUP,3);}
"COLOR"                                                               {store_operator(KEY_HTM_COLOR,3);}
"COLS"                                                                {store_operator(KEY_HTM_COLS,3);}
"COLSPAN"                                                             {store_operator(KEY_HTM_COLSPAN,3);}
"COMPACT"                                                             {store_operator(KEY_HTM_COMPACT,3);}
"CONTENT"                                                             {store_operator(KEY_HTM_CONTENT,3);}
"COORDS"                                                              {store_operator(KEY_HTM_COORDS,3);}
"DATA"                                                                {store_operator(KEY_HTM_DATA,3);}
"DD"                                                                  {store_operator(KEY_HTM_DD,3);}
"DEL"                                                                 {store_operator(KEY_HTM_DEL,3);}
"DISABLED"                                                            {store_operator(KEY_HTM_DISABLED,3);}
"DIV"                                                                 {store_operator(KEY_HTM_DIV,3);}
"DL"                                                                  {store_operator(KEY_HTM_DL,3);}
"DT"                                                                  {store_operator(KEY_HTM_DT,3);}
"EM"                                                                  {store_operator(KEY_HTM_EM,3);}
"EMBED"                                                               {store_operator(KEY_HTM_EMBED,3);}
"EVENT"                                                               {store_operator(KEY_HTM_EVENT,3);}
"FACE"                                                                {store_operator(KEY_HTM_FACE,3);}
"FONT"                                                                {store_operator(KEY_HTM_FONT,3);}
"FORM"                                                                {store_operator(KEY_HTM_FORM,3);}
"FRAME"                                                               {store_operator(KEY_HTM_FRAME,3);}
"FRAMEBORDER"                                                         {store_operator(KEY_HTM_FRAMEBORDER,3);}
"FRAMESET"                                                            {store_operator(KEY_HTM_FRAMESET,3);}
"FRAMESPACING"                                                        {store_operator(KEY_HTM_FRAMESPACING,3);}
"H1"                                                                  {store_operator(KEY_HTM_H1,3);}
"H2"                                                                  {store_operator(KEY_HTM_H2,3);}
"H3"                                                                  {store_operator(KEY_HTM_H3,3);}
"H4"                                                                  {store_operator(KEY_HTM_H4,3);}
"H5"                                                                  {store_operator(KEY_HTM_H5,3);}
"H6"                                                                  {store_operator(KEY_HTM_H6,3);}
"HEAD"                                                                {store_operator(KEY_HTM_HEAD,3);}
"HEIGHT"                                                              {store_operator(KEY_HTM_HEIGHT,3);}
"HIDDEN"                                                              {store_operator(KEY_HTM_HIDDEN,3);}
"HR"                                                                  {store_operator(KEY_HTM_HR,3);}
"HREF"                                                                {store_operator(KEY_HTM_HREF,3);}
"HSPACE"                                                              {store_operator(KEY_HTM_HSPACE,3);}
"HTML"                                                                {store_operator(KEY_HTM_HTML,3);}
"HTTP-EQUIV"                                                          {store_operator(KEY_HTM_HTTPEQUIV,3);}
"ID"                                                                  {store_operator(KEY_HTM_ID,3);}
"IFRAME"                                                              {store_operator(KEY_HTM_IFRAME,3);}
"ILAYER"                                                              {store_operator(KEY_HTM_ILAYER,3);}
"IMG"                                                                 {store_operator(KEY_HTM_IMG,3);}
"INPUT"                                                               {store_operator(KEY_HTM_INPUT,3);}
"LABEL"                                                               {store_operator(KEY_HTM_LABEL,3);}
"LANG"                                                                {store_operator(KEY_HTM_LANG,3);}
"LANGUAGE"                                                            {store_operator(KEY_HTM_LANGUAGE,3);}
"LAYER"                                                               {store_operator(KEY_HTM_LAYER,3);}
"LEFTMARGIN"                                                          {store_operator(KEY_HTM_LEFTMARGIN,3);}
"LEGEND"                                                              {store_operator(KEY_HTM_LEGEND,3);}
"LI"                                                                  {store_operator(KEY_HTM_LI,3);}
"LINK"                                                                {store_operator(KEY_HTM_LINK,3);}
"LOOP"                                                                {store_operator(KEY_HTM_LOOP,3);}
"MAP"                                                                 {store_operator(KEY_HTM_MAP,3);}
"MENU"                                                                {store_operator(KEY_HTM_MENU,3);}
"META"                                                                {store_operator(KEY_HTM_META,3);}
"MULTICOL"                                                            {store_operator(KEY_HTM_MULTICOL,3);}
"MULTIPLE"                                                            {store_operator(KEY_HTM_MULTIPLE,3);}
"NAME"                                                                {store_operator(KEY_HTM_NAME,3);}
"NOBR"                                                                {store_operator(KEY_HTM_NOBR,3);}
"NOEMBED"                                                             {store_operator(KEY_HTM_NOEMBED,3);}
"NOFRAMES"                                                            {store_operator(KEY_HTM_NOFRAMES,3);}
"NOHREF"                                                              {store_operator(KEY_HTM_NOHREF,3);}
"NOLAYER"                                                             {store_operator(KEY_HTM_NOLAYER,3);}
"NORESIZE"                                                            {store_operator(KEY_HTM_NORESIZE,3);}
"NOSCRIPT"                                                            {store_operator(KEY_HTM_NOSCRIPT,3);}
"NOSHADE"                                                             {store_operator(KEY_HTM_NOSHADE,3);}
"NOWRAP"                                                              {store_operator(KEY_HTM_NOWRAP,3);}
"OBJECT"                                                              {store_operator(KEY_HTM_OBJECT,3);}
"OL"                                                                  {store_operator(KEY_HTM_OL,3);}
"OPTGROUP"                                                            {store_operator(KEY_HTM_OPTGROUP,3);}
"OPTION"                                                              {store_operator(KEY_HTM_OPTION,3);}
"P"                                                                   {store_operator(KEY_HTM_P,3);}
"PALETTE"                                                             {store_operator(KEY_HTM_PALETTE,3);}
"PARAM"                                                               {store_operator(KEY_HTM_PARAM,3);}
"PLAINTEXT"                                                           {store_operator(KEY_HTM_PLAINTEXT,3);}
"PRE"                                                                 {store_operator(KEY_HTM_PRE,3);}
"PUBLIC"                                                              {store_operator(KEY_HTM_PUBLIC,3);}
"READONLY"                                                            {store_operator(KEY_HTM_READONLY,3);}
"REL"                                                                 {store_operator(KEY_HTM_REL,3);}
"REV"                                                                 {store_operator(KEY_HTM_REV,3);}
"RIGHTMARGIN"                                                         {store_operator(KEY_HTM_RIGHTMARGIN,3);}
"ROWS"                                                                {store_operator(KEY_HTM_ROWS,3);}
"ROWSPAN"                                                             {store_operator(KEY_HTM_ROWSPAN,3);}
"SELECT"                                                              {store_operator(KEY_HTM_SELECT,3);}
"SELECTED"                                                            {store_operator(KEY_HTM_SELECTED,3);}
"SERVER"                                                              {store_operator(KEY_HTM_SERVER,3);}
"SHAPE"                                                               {store_operator(KEY_HTM_SHAPE,3);}
"SIZE"                                                                {store_operator(KEY_HTM_SIZE,3);}
"SMALL"                                                               {store_operator(KEY_HTM_SMALL,3);}
"SOUND"                                                               {store_operator(KEY_HTM_SOUND,3);}
"SPACER"                                                              {store_operator(KEY_HTM_SPACER,3);}
"SPAN"                                                                {store_operator(KEY_HTM_SPAN,3);}
"SRC"                                                                 {store_operator(KEY_HTM_SRC,3);}
"START"                                                               {store_operator(KEY_HTM_START,3);}
"STRIKE"                                                              {store_operator(KEY_HTM_STRIKE,3);}
"STRONG"                                                              {store_operator(KEY_HTM_STRONG,3);}
"STYLE"                                                               {store_operator(KEY_HTM_STYLE,3);}
"SUB"                                                                 {store_operator(KEY_HTM_SUB,3);}
"SUP"                                                                 {store_operator(KEY_HTM_SUP,3);}
"TABINDEX"                                                            {store_operator(KEY_HTM_TABINDEX,3);}
"TABLE"                                                               {store_operator(KEY_HTM_TABLE,3);}
"TARGET"                                                              {store_operator(KEY_HTM_TARGET,3);}
"TBODY"                                                               {store_operator(KEY_HTM_TBODY,3);}
"TD"                                                                  {store_operator(KEY_HTM_TD,3);}
"TEXT"                                                                {store_operator(KEY_HTM_TEXT,3);}
"TEXTAREA"                                                            {store_operator(KEY_HTM_TEXTAREA,3);}
"TFOOT"                                                               {store_operator(KEY_HTM_TFOOT,3);}
"TH"                                                                  {store_operator(KEY_HTM_TH,3);}
"THEAD"                                                               {store_operator(KEY_HTM_THEAD,3);}
"TITLE"                                                               {store_operator(KEY_HTM_TITLE,3);}
"TOPMARGIN"                                                           {store_operator(KEY_HTM_TOPMARGIN,3);}
"TR"                                                                  {store_operator(KEY_HTM_TR,3);}
"TRUESPEED"                                                           {store_operator(KEY_HTM_TRUESPEED,3);}
"TT"                                                                  {store_operator(KEY_HTM_TT,3);}
"TYPE"                                                                {store_operator(KEY_HTM_TYPE,3);}
"UL"                                                                  {store_operator(KEY_HTM_UL,3);}
"URL"                                                                 {store_operator(KEY_HTM_URL,3);}
"URN"                                                                 {store_operator(KEY_HTM_URN,3);}
"USEMAP"                                                              {store_operator(KEY_HTM_USEMAP,3);}
"VALIGN"                                                              {store_operator(KEY_HTM_VALIGN,3);}
"VALUE"                                                               {store_operator(KEY_HTM_VALUE,3);}
"VAR"                                                                 {store_operator(KEY_HTM_VAR,3);}
"VLINK"                                                               {store_operator(KEY_HTM_VLINK,3);}
"VOLUME"                                                              {store_operator(KEY_HTM_VOLUME,3);}
"VRML"                                                                {store_operator(KEY_HTM_VRML,3);}
"VSPACE"                                                              {store_operator(KEY_HTM_VSPACE,3);}
"WIDTH"                                                               {store_operator(KEY_HTM_WIDTH,3);}
"WRAP"                                                                {store_operator(KEY_HTM_WRAP,3);}

[ \t\v\f]                                                             {;}
.                                                                     {;}

%%
int yywrap() {
  return(1);
}

void lexclear() {
  BEGIN 0;
  noperands=0;
  j_comments=c_comments=cpp_comments=com_loc=0;
  nsemi=noperators=0;
  asp_lineno=1;

  sloc.clear();
  operators.clear();
  operands.clear();

  slnat.clear();
  sltag.clear();
  slhtm.clear();
  slscr.clear();
}

void store_operator(int op, int typ) {
  operators.insert(op);
  noperators++;
  NOTE_SLOC();

  switch (typ) {
    case 1:
      slnat.insert(asp_lineno);
      break;
    case 3:
      slhtm.insert(asp_lineno);
      break;
    case 4:
      slscr.insert(asp_lineno);
      break;
  }
}
