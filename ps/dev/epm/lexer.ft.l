/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 * Essential Project Manager (EPM)
 * Copyright (c) 2009 PowerSoftware.com
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * Fortran parser
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  14-Jul-2009  10451 : File created.
 * CAM  22-Sep-2010  10648 : Converted from string operands to PowerHashed.
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

%{

#include <stdio.h>
#include <string.h>
#include "y.ft.h"
#include "PowerHash.h"

#ifdef WIN32

#include <io.h>
#include <set>
#include <iostream>
using namespace std;

#else

#include <stl.h>
#include <unistd.h>

#endif

int fortran_lineno=0;
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

#define NOTE_SLOC()       sloc.insert(fortran_lineno)
#define STORE_OPERATOR(X) operators.insert(X); noperators++; NOTE_SLOC();
#define STORE_OPERAND(X)  operands.insert(PowerHash(X)); noperands++; NOTE_SLOC();
#define SEMI()            nsemi++; NOTE_SLOC();

void lexclear();

%}

NL            "\n"
NOTNL         .
ANY           ({NOTNL}|{NL})
BACKSL        "\\"
BOL           ^
LETTER        [A-Za-z_]
ALNUM         [A-Za-z_0-9]
DIGIT         [0-9]
HEXDIGIT      [0-9A-Fa-f]
DIGITS        ({DIGIT}+)
EXP           [Ee][+-]?DIGITS
HEXDIGITS     ({HEXDIGIT}+)
SIGN          ("+"|"-")
ELL_SUFFIX    [lL]([lL]?)
INT_SUFFIX    ([uU]{ELL_SUFFIX}?|{ELL_SUFFIX}[uU]?)
FLOAT_SUFFIX  [flFL]
STRCHAR       [^\"\n\\]
ESCAPE        ({BACKSL}{ANY})
QUOTE         [\"]
SPTAB         [ \t]

%%

"//"                    {STORE_OPERATOR(SYM_SLASHSLASH);}
"**"                    {STORE_OPERATOR(SYM_POWER);}
"=="                    {STORE_OPERATOR(SYM_EQ_EQ);}
"::"                    {STORE_OPERATOR(SYM_COLONCOLON);}
"=>"                    {STORE_OPERATOR(SYM_EQ_GT);}
">="                    {STORE_OPERATOR(SYM_GTEQ);}
"<="                    {STORE_OPERATOR(SYM_LTEQ);}

"*"                     {STORE_OPERATOR(SYM_ASTERISK);}
":"                     {STORE_OPERATOR(SYM_COLON);}
","                     {STORE_OPERATOR(SYM_COMMA);}
"="                     {STORE_OPERATOR(SYM_EQUALS);}
">"                     {STORE_OPERATOR(SYM_GT);}
"<"                     {STORE_OPERATOR(SYM_LT);}
"["                     {STORE_OPERATOR(SYM_LBRACKET);}
"("                     {STORE_OPERATOR(SYM_LPAREN);}
"-"                     {STORE_OPERATOR(SYM_MINUS);}
"%"                     {STORE_OPERATOR(SYM_PERCENT);}
"+"                     {STORE_OPERATOR(SYM_PLUS);}
"/"                     {STORE_OPERATOR(SYM_SLASH);}
"/="                    {STORE_OPERATOR(SYM_SLASHEQ);}
"]"                     {STORE_OPERATOR(SYM_RBRACKET);}
")"                     {STORE_OPERATOR(SYM_RPAREN);}
"_"                     {STORE_OPERATOR(SYM_UNDERSCORE);}

"ABSTRACT"              {STORE_OPERATOR(KEY_ABSTRACT);}
"ALLOCATABLE"           {STORE_OPERATOR(KEY_ALLOCATABLE);}
"ALLOCATE"              {STORE_OPERATOR(KEY_ALLOCATE);}
"ASSIGN"                {STORE_OPERATOR(KEY_ASSIGN);}
"ASSIGNMENT"            {STORE_OPERATOR(KEY_ASSIGNMENT);}
"ASSOCIATE"             {STORE_OPERATOR(KEY_ASSOCIATE);}
"ASYNCHRONOUS"          {STORE_OPERATOR(KEY_ASYNCHRONOUS);}
"BACKSPACE"             {STORE_OPERATOR(KEY_BACKSPACE);}
"BIND"                  {STORE_OPERATOR(KEY_BIND);}
"BLOCK"                 {STORE_OPERATOR(KEY_BLOCK);}
"BLOCKDATA"             {STORE_OPERATOR(KEY_BLOCKDATA);}
"CALL"                  {STORE_OPERATOR(KEY_CALL);}
"CASE"                  {STORE_OPERATOR(KEY_CASE);}
"CHARACTER"             {STORE_OPERATOR(KEY_CHARACTER);}
"CLASS"                 {STORE_OPERATOR(KEY_CLASS);}
"CLOSE"                 {STORE_OPERATOR(KEY_CLOSE);}
"COMMON"                {STORE_OPERATOR(KEY_COMMON);}
"COMPLEX"               {STORE_OPERATOR(KEY_COMPLEX);}
"CONTAINS"              {STORE_OPERATOR(KEY_CONTAINS);}
"CONTINUE"              {STORE_OPERATOR(KEY_CONTINUE);}
"CYCLE"                 {STORE_OPERATOR(KEY_CYCLE);}
"DATA"                  {STORE_OPERATOR(KEY_DATA);}
"DEALLOCATE"            {STORE_OPERATOR(KEY_DEALLOCATE);}
"DEFAULT"               {STORE_OPERATOR(KEY_DEFAULT);}
"DEFERRED"              {STORE_OPERATOR(KEY_DEFERRED);}
"DIMENSION"             {STORE_OPERATOR(KEY_DIMENSION);}
"DO"                    {STORE_OPERATOR(KEY_DO);}
"DOUBLE"                {STORE_OPERATOR(KEY_DOUBLE);}
"DOUBLECOMPLEX"         {STORE_OPERATOR(KEY_DOUBLECOMPLEX);}
"DOUBLEPRECISION"       {STORE_OPERATOR(KEY_DOUBLEPRECISION);}
"ELEMENTAL"             {STORE_OPERATOR(KEY_ELEMENTAL);}
"ELSE"                  {STORE_OPERATOR(KEY_ELSE);}
"ELSEIF"                {STORE_OPERATOR(KEY_ELSEIF);}
"ELSEWHERE"             {STORE_OPERATOR(KEY_ELSEWHERE);}
"END"                   {STORE_OPERATOR(KEY_END);}
"ENDASSOCIATE"          {STORE_OPERATOR(KEY_ENDASSOCIATE);}
"ENDBLOCK"              {STORE_OPERATOR(KEY_ENDBLOCK);}
"ENDBLOCKDATA"          {STORE_OPERATOR(KEY_ENDBLOCKDATA);}
"ENDDO"                 {STORE_OPERATOR(KEY_ENDDO);}
"ENDENUM"               {STORE_OPERATOR(KEY_ENDENUM);}
"ENDFILE"               {STORE_OPERATOR(KEY_ENDFILE);}
"ENDFORALL"             {STORE_OPERATOR(KEY_ENDFORALL);}
"ENDFUNCTION"           {STORE_OPERATOR(KEY_ENDFUNCTION);}
"ENDIF"                 {STORE_OPERATOR(KEY_ENDIF);}
"ENDINTERFACE"          {STORE_OPERATOR(KEY_ENDINTERFACE);}
"ENDMODULE"             {STORE_OPERATOR(KEY_ENDMODULE);}
"ENDPROGRAM"            {STORE_OPERATOR(KEY_ENDPROGRAM);}
"ENDSELECT"             {STORE_OPERATOR(KEY_ENDSELECT);}
"ENDSUBROUTINE"         {STORE_OPERATOR(KEY_ENDSUBROUTINE);}
"ENDTYPE"               {STORE_OPERATOR(KEY_ENDTYPE);}
"ENDWHERE"              {STORE_OPERATOR(KEY_ENDWHERE);}
"ENTRY"                 {STORE_OPERATOR(KEY_ENTRY);}
"ENUM"                  {STORE_OPERATOR(KEY_ENUM);}
"ENUMERATOR"            {STORE_OPERATOR(KEY_ENUMERATOR);}
"EQUIVALENCE"           {STORE_OPERATOR(KEY_EQUIVALENCE);}
"EXIT"                  {STORE_OPERATOR(KEY_EXIT);}
"EXTENDS"               {STORE_OPERATOR(KEY_EXTENDS);}
"EXTERNAL"              {STORE_OPERATOR(KEY_EXTERNAL);}
"FILE"                  {STORE_OPERATOR(KEY_FILE);}
"FINAL"                 {STORE_OPERATOR(KEY_FINAL);}
"FLUSH"                 {STORE_OPERATOR(KEY_FLUSH);}
"FORALL"                {STORE_OPERATOR(KEY_FORALL);}
"FORMAT"                {STORE_OPERATOR(KEY_FORMAT);}
"FORMATTED"             {STORE_OPERATOR(KEY_FORMATTED);}
"FUNCTION"              {STORE_OPERATOR(KEY_FUNCTION);}
"GENERIC"               {STORE_OPERATOR(KEY_GENERIC);}
"GO"                    {STORE_OPERATOR(KEY_GO);}
"GOTO"                  {STORE_OPERATOR(KEY_GOTO);}
"IF"                    {STORE_OPERATOR(KEY_IF);}
"IMPLICIT"              {STORE_OPERATOR(KEY_IMPLICIT);}
"IMPORT"                {STORE_OPERATOR(KEY_IMPORT);}
"IN"                    {STORE_OPERATOR(KEY_IN);}
"INOUT"                 {STORE_OPERATOR(KEY_INOUT);}
"INQUIRE"               {STORE_OPERATOR(KEY_INQUIRE);}
"INTEGER"               {STORE_OPERATOR(KEY_INTEGER);}
"INTENT"                {STORE_OPERATOR(KEY_INTENT);}
"INTERFACE"             {STORE_OPERATOR(KEY_INTERFACE);}
"INTRINSIC"             {STORE_OPERATOR(KEY_INTRINSIC);}
"KIND"                  {STORE_OPERATOR(KEY_KIND);}
"LEN"                   {STORE_OPERATOR(KEY_LEN);}
"LOGICAL"               {STORE_OPERATOR(KEY_LOGICAL);}
"MODULE"                {STORE_OPERATOR(KEY_MODULE);}
"NAMELIST"              {STORE_OPERATOR(KEY_NAMELIST);}
"NONE"                  {STORE_OPERATOR(KEY_NONE);}
"NON_INTRINSIC"         {STORE_OPERATOR(KEY_NON_INTRINSIC);}
"NON_OVERRIDABLE"       {STORE_OPERATOR(KEY_NON_OVERRIDABLE);}
"NOPASS"                {STORE_OPERATOR(KEY_NOPASS);}
"NULLIFY"               {STORE_OPERATOR(KEY_NULLIFY);}
"ONLY"                  {STORE_OPERATOR(KEY_ONLY);}
"OPEN"                  {STORE_OPERATOR(KEY_OPEN);}
"OPERATOR"              {STORE_OPERATOR(KEY_OPERATOR);}
"OPTIONAL"              {STORE_OPERATOR(KEY_OPTIONAL);}
"OUT"                   {STORE_OPERATOR(KEY_OUT);}
"PARAMETER"             {STORE_OPERATOR(KEY_PARAMETER);}
"PASS"                  {STORE_OPERATOR(KEY_PASS);}
"PAUSE"                 {STORE_OPERATOR(KEY_PAUSE);}
"POINTER"               {STORE_OPERATOR(KEY_POINTER);}
"PRECISION"             {STORE_OPERATOR(KEY_PRECISION);}
"PRINT"                 {STORE_OPERATOR(KEY_PRINT);}
"PRIVATE"               {STORE_OPERATOR(KEY_PRIVATE);}
"PROCEDURE"             {STORE_OPERATOR(KEY_PROCEDURE);}
"PROGRAM"               {STORE_OPERATOR(KEY_PROGRAM);}
"PROTECTED"             {STORE_OPERATOR(KEY_PROTECTED);}
"PUBLIC"                {STORE_OPERATOR(KEY_PUBLIC);}
"PURE"                  {STORE_OPERATOR(KEY_PURE);}
"READ"                  {STORE_OPERATOR(KEY_READ);}
"REAL"                  {STORE_OPERATOR(KEY_REAL);}
"RECURSIVE"             {STORE_OPERATOR(KEY_RECURSIVE);}
"RESULT"                {STORE_OPERATOR(KEY_RESULT);}
"RETURN"                {STORE_OPERATOR(KEY_RETURN);}
"REWIND"                {STORE_OPERATOR(KEY_REWIND);}
"SAVE"                  {STORE_OPERATOR(KEY_SAVE);}
"SELECT"                {STORE_OPERATOR(KEY_SELECT);}
"SELECTCASE"            {STORE_OPERATOR(KEY_SELECTCASE);}
"SELECTTYPE"            {STORE_OPERATOR(KEY_SELECTTYPE);}
"SEQUENCE"              {STORE_OPERATOR(KEY_SEQUENCE);}
"STOP"                  {STORE_OPERATOR(KEY_STOP);}
"SUBROUTINE"            {STORE_OPERATOR(KEY_SUBROUTINE);}
"TARGET"                {STORE_OPERATOR(KEY_TARGET);}
"THEN"                  {STORE_OPERATOR(KEY_THEN);}
"TO"                    {STORE_OPERATOR(KEY_TO);}
"TYPE"                  {STORE_OPERATOR(KEY_TYPE);}
"UNFORMATTED"           {STORE_OPERATOR(KEY_UNFORMATTED);}
"USE"                   {STORE_OPERATOR(KEY_USE);}
"VALUE"                 {STORE_OPERATOR(KEY_VALUE);}
"VOLATILE"              {STORE_OPERATOR(KEY_VOLATILE);}
"WAIT"                  {STORE_OPERATOR(KEY_WAIT);}
"WHERE"                 {STORE_OPERATOR(KEY_WHERE);}
"WHILE"                 {STORE_OPERATOR(KEY_WHILE);}
"WRITE"                 {STORE_OPERATOR(KEY_WRITE);}

{LETTER}{ALNUM}*        {STORE_OPERAND(yytext);}

[1-9][0-9]*{INT_SUFFIX}?           |
[0][0-7]*{INT_SUFFIX}?             |
[0][xX][0-9A-Fa-f]+{INT_SUFFIX}?          {STORE_OPERAND(yytext);}

[0][xX]                {STORE_OPERAND(yytext);}

{DIGITS}"."{DIGITS}?([eE]{SIGN}?{DIGITS})?{FLOAT_SUFFIX}?   |
{DIGITS}"."?([eE]{SIGN}?{DIGITS})?{FLOAT_SUFFIX}?     |
"."{DIGITS}([eE]{SIGN}?{DIGITS})?{FLOAT_SUFFIX}?    {STORE_OPERAND(yytext);}

{DIGITS}"."{DIGITS}?[eE]{SIGN}?   |
{DIGITS}"."?[eE]{SIGN}?           |
"."{DIGITS}[eE]{SIGN}?                    {STORE_OPERAND(yytext);}

"!"{NOTNL}*{NL}         {cpp_comments++;com_loc++;fortran_lineno++;BEGIN(INITIAL);}

\n                      {fortran_lineno++;}

[ \t\v\f]               {;}
.                       {;}

%%
int yywrap()
{
  return(1);
}

void lexclear() {
  BEGIN 0 ;
  noperands=0;
  j_comments=c_comments=cpp_comments=com_loc=0;
  prev_com_line=-1;
  fortran_lineno=nsemi=noperators=0;

  sloc.clear();
  operators.clear();
  operands.clear();
}
