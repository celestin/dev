/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 * Essential Project Manager (EPM)
 * Copyright (c) 2009 Power Software
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * Fortran parser
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  14-Jul-2009  10451 : File created.
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

%{

#include <stdio.h>
#include <string.h>
#include "y.ft.h"

#ifdef WIN32

#include <io.h>
#include <vector>
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
vector<char*> operands[255];

int nsemi=0 ;           // Number of semi-colons
int noperators=0 ;      // Total number of operators
int noperands=0;        // Total number of operands

#define COUNT() sloc.insert(fortran_lineno)

void lexclear();
void store_operator(int op);
void store_operand(char* txt);
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

"//"                    {store_operator(SYM_SLASHSLASH);}
"**"                    {store_operator(SYM_POWER);}
"=="                    {store_operator(SYM_EQ_EQ);}
"::"                    {store_operator(SYM_COLONCOLON);}
"=>"                    {store_operator(SYM_EQ_GT);}
">="                    {store_operator(SYM_GTEQ);}
"<="                    {store_operator(SYM_LTEQ);}

"*"                     {store_operator(SYM_ASTERISK);}
":"                     {store_operator(SYM_COLON);}
","                     {store_operator(SYM_COMMA);}
"="                     {store_operator(SYM_EQUALS);}
">"                     {store_operator(SYM_GT);}
"<"                     {store_operator(SYM_LT);}
"["                     {store_operator(SYM_LBRACKET);}
"("                     {store_operator(SYM_LPAREN);}
"-"                     {store_operator(SYM_MINUS);}
"%"                     {store_operator(SYM_PERCENT);}
"+"                     {store_operator(SYM_PLUS);}
"/"                     {store_operator(SYM_SLASH);}
"/="                    {store_operator(SYM_SLASHEQ);}
"]"                     {store_operator(SYM_RBRACKET);}
")"                     {store_operator(SYM_RPAREN);}
"_"                     {store_operator(SYM_UNDERSCORE);}

"ABSTRACT"              {store_operator(KEY_ABSTRACT);}
"ALLOCATABLE"           {store_operator(KEY_ALLOCATABLE);}
"ALLOCATE"              {store_operator(KEY_ALLOCATE);}
"ASSIGN"                {store_operator(KEY_ASSIGN);}
"ASSIGNMENT"            {store_operator(KEY_ASSIGNMENT);}
"ASSOCIATE"             {store_operator(KEY_ASSOCIATE);}
"ASYNCHRONOUS"          {store_operator(KEY_ASYNCHRONOUS);}
"BACKSPACE"             {store_operator(KEY_BACKSPACE);}
"BIND"                  {store_operator(KEY_BIND);}
"BLOCK"                 {store_operator(KEY_BLOCK);}
"BLOCKDATA"             {store_operator(KEY_BLOCKDATA);}
"CALL"                  {store_operator(KEY_CALL);}
"CASE"                  {store_operator(KEY_CASE);}
"CHARACTER"             {store_operator(KEY_CHARACTER);}
"CLASS"                 {store_operator(KEY_CLASS);}
"CLOSE"                 {store_operator(KEY_CLOSE);}
"COMMON"                {store_operator(KEY_COMMON);}
"COMPLEX"               {store_operator(KEY_COMPLEX);}
"CONTAINS"              {store_operator(KEY_CONTAINS);}
"CONTINUE"              {store_operator(KEY_CONTINUE);}
"CYCLE"                 {store_operator(KEY_CYCLE);}
"DATA"                  {store_operator(KEY_DATA);}
"DEALLOCATE"            {store_operator(KEY_DEALLOCATE);}
"DEFAULT"               {store_operator(KEY_DEFAULT);}
"DEFERRED"              {store_operator(KEY_DEFERRED);}
"DIMENSION"             {store_operator(KEY_DIMENSION);}
"DO"                    {store_operator(KEY_DO);}
"DOUBLE"                {store_operator(KEY_DOUBLE);}
"DOUBLECOMPLEX"         {store_operator(KEY_DOUBLECOMPLEX);}
"DOUBLEPRECISION"       {store_operator(KEY_DOUBLEPRECISION);}
"ELEMENTAL"             {store_operator(KEY_ELEMENTAL);}
"ELSE"                  {store_operator(KEY_ELSE);}
"ELSEIF"                {store_operator(KEY_ELSEIF);}
"ELSEWHERE"             {store_operator(KEY_ELSEWHERE);}
"END"                   {store_operator(KEY_END);}
"ENDASSOCIATE"          {store_operator(KEY_ENDASSOCIATE);}
"ENDBLOCK"              {store_operator(KEY_ENDBLOCK);}
"ENDBLOCKDATA"          {store_operator(KEY_ENDBLOCKDATA);}
"ENDDO"                 {store_operator(KEY_ENDDO);}
"ENDENUM"               {store_operator(KEY_ENDENUM);}
"ENDFILE"               {store_operator(KEY_ENDFILE);}
"ENDFORALL"             {store_operator(KEY_ENDFORALL);}
"ENDFUNCTION"           {store_operator(KEY_ENDFUNCTION);}
"ENDIF"                 {store_operator(KEY_ENDIF);}
"ENDINTERFACE"          {store_operator(KEY_ENDINTERFACE);}
"ENDMODULE"             {store_operator(KEY_ENDMODULE);}
"ENDPROGRAM"            {store_operator(KEY_ENDPROGRAM);}
"ENDSELECT"             {store_operator(KEY_ENDSELECT);}
"ENDSUBROUTINE"         {store_operator(KEY_ENDSUBROUTINE);}
"ENDTYPE"               {store_operator(KEY_ENDTYPE);}
"ENDWHERE"              {store_operator(KEY_ENDWHERE);}
"ENTRY"                 {store_operator(KEY_ENTRY);}
"ENUM"                  {store_operator(KEY_ENUM);}
"ENUMERATOR"            {store_operator(KEY_ENUMERATOR);}
"EQUIVALENCE"           {store_operator(KEY_EQUIVALENCE);}
"EXIT"                  {store_operator(KEY_EXIT);}
"EXTENDS"               {store_operator(KEY_EXTENDS);}
"EXTERNAL"              {store_operator(KEY_EXTERNAL);}
"FILE"                  {store_operator(KEY_FILE);}
"FINAL"                 {store_operator(KEY_FINAL);}
"FLUSH"                 {store_operator(KEY_FLUSH);}
"FORALL"                {store_operator(KEY_FORALL);}
"FORMAT"                {store_operator(KEY_FORMAT);}
"FORMATTED"             {store_operator(KEY_FORMATTED);}
"FUNCTION"              {store_operator(KEY_FUNCTION);}
"GENERIC"               {store_operator(KEY_GENERIC);}
"GO"                    {store_operator(KEY_GO);}
"GOTO"                  {store_operator(KEY_GOTO);}
"IF"                    {store_operator(KEY_IF);}
"IMPLICIT"              {store_operator(KEY_IMPLICIT);}
"IMPORT"                {store_operator(KEY_IMPORT);}
"IN"                    {store_operator(KEY_IN);}
"INOUT"                 {store_operator(KEY_INOUT);}
"INQUIRE"               {store_operator(KEY_INQUIRE);}
"INTEGER"               {store_operator(KEY_INTEGER);}
"INTENT"                {store_operator(KEY_INTENT);}
"INTERFACE"             {store_operator(KEY_INTERFACE);}
"INTRINSIC"             {store_operator(KEY_INTRINSIC);}
"KIND"                  {store_operator(KEY_KIND);}
"LEN"                   {store_operator(KEY_LEN);}
"LOGICAL"               {store_operator(KEY_LOGICAL);}
"MODULE"                {store_operator(KEY_MODULE);}
"NAMELIST"              {store_operator(KEY_NAMELIST);}
"NONE"                  {store_operator(KEY_NONE);}
"NON_INTRINSIC"         {store_operator(KEY_NON_INTRINSIC);}
"NON_OVERRIDABLE"       {store_operator(KEY_NON_OVERRIDABLE);}
"NOPASS"                {store_operator(KEY_NOPASS);}
"NULLIFY"               {store_operator(KEY_NULLIFY);}
"ONLY"                  {store_operator(KEY_ONLY);}
"OPEN"                  {store_operator(KEY_OPEN);}
"OPERATOR"              {store_operator(KEY_OPERATOR);}
"OPTIONAL"              {store_operator(KEY_OPTIONAL);}
"OUT"                   {store_operator(KEY_OUT);}
"PARAMETER"             {store_operator(KEY_PARAMETER);}
"PASS"                  {store_operator(KEY_PASS);}
"PAUSE"                 {store_operator(KEY_PAUSE);}
"POINTER"               {store_operator(KEY_POINTER);}
"PRECISION"             {store_operator(KEY_PRECISION);}
"PRINT"                 {store_operator(KEY_PRINT);}
"PRIVATE"               {store_operator(KEY_PRIVATE);}
"PROCEDURE"             {store_operator(KEY_PROCEDURE);}
"PROGRAM"               {store_operator(KEY_PROGRAM);}
"PROTECTED"             {store_operator(KEY_PROTECTED);}
"PUBLIC"                {store_operator(KEY_PUBLIC);}
"PURE"                  {store_operator(KEY_PURE);}
"READ"                  {store_operator(KEY_READ);}
"REAL"                  {store_operator(KEY_REAL);}
"RECURSIVE"             {store_operator(KEY_RECURSIVE);}
"RESULT"                {store_operator(KEY_RESULT);}
"RETURN"                {store_operator(KEY_RETURN);}
"REWIND"                {store_operator(KEY_REWIND);}
"SAVE"                  {store_operator(KEY_SAVE);}
"SELECT"                {store_operator(KEY_SELECT);}
"SELECTCASE"            {store_operator(KEY_SELECTCASE);}
"SELECTTYPE"            {store_operator(KEY_SELECTTYPE);}
"SEQUENCE"              {store_operator(KEY_SEQUENCE);}
"STOP"                  {store_operator(KEY_STOP);}
"SUBROUTINE"            {store_operator(KEY_SUBROUTINE);}
"TARGET"                {store_operator(KEY_TARGET);}
"THEN"                  {store_operator(KEY_THEN);}
"TO"                    {store_operator(KEY_TO);}
"TYPE"                  {store_operator(KEY_TYPE);}
"UNFORMATTED"           {store_operator(KEY_UNFORMATTED);}
"USE"                   {store_operator(KEY_USE);}
"VALUE"                 {store_operator(KEY_VALUE);}
"VOLATILE"              {store_operator(KEY_VOLATILE);}
"WAIT"                  {store_operator(KEY_WAIT);}
"WHERE"                 {store_operator(KEY_WHERE);}
"WHILE"                 {store_operator(KEY_WHILE);}
"WRITE"                 {store_operator(KEY_WRITE);}

{LETTER}{ALNUM}*        {store_operand(_strdup(yytext));}

[1-9][0-9]*{INT_SUFFIX}?           |
[0][0-7]*{INT_SUFFIX}?             |
[0][xX][0-9A-Fa-f]+{INT_SUFFIX}?          {store_operand(_strdup(yytext));}

[0][xX]                {store_operand(_strdup(yytext));}

{DIGITS}"."{DIGITS}?([eE]{SIGN}?{DIGITS})?{FLOAT_SUFFIX}?   |
{DIGITS}"."?([eE]{SIGN}?{DIGITS})?{FLOAT_SUFFIX}?     |
"."{DIGITS}([eE]{SIGN}?{DIGITS})?{FLOAT_SUFFIX}?    {store_operand(_strdup(yytext));}

{DIGITS}"."{DIGITS}?[eE]{SIGN}?   |
{DIGITS}"."?[eE]{SIGN}?           |
"."{DIGITS}[eE]{SIGN}?                    {store_operand(_strdup(yytext));}

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

  for (int i=0; i<255; i++) {
    if (operands[i].size() > 0) operands[i].clear();
  }
}

void store_operator(int op) {
  operators.insert(op);
  noperators++;
  COUNT();
}

void store_operand(char* txt) {
  char c;
  unsigned int i;
  noperands++;

  COUNT();

  c=txt[0];
  for (i=0;i<operands[c].size();i++) {
    if (!strcmp(txt,operands[c][i])) return;
  }
  operands[c].push_back(txt);
}
