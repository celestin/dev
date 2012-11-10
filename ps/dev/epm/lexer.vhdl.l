/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 * Essential Project Manager (EPM)
 * Copyright (c) 2004,2008 PowerSoftware.com
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * VHDL Parser
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  26-Jul-07    316 : File created.
 * CAM  24-Apr-08    358 : Corrected compiler warnings moving to VS2008 (from VC++6).
 * CAM  29-Sep-2010  10648 : Converted from string operands to PowerHashed.
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
#include "y.vhdl.h"
#include "PowerHash.h"

#ifdef WIN32

#include <io.h>
#include <set>
using namespace std;

#else

#include <stl.h>
#include <unistd.h>

#endif

int vhdl_lineno=0;
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

#define NOTE_SLOC()       sloc.insert(vhdl_lineno)
#define STORE_OPERATOR(X) operators.insert(X); noperators++; NOTE_SLOC();
#define STORE_OPERAND(X)  operands.insert(PowerHash(X)); noperands++; NOTE_SLOC();
#define SEMI()            nsemi++; NOTE_SLOC();

void lexclear();
void string_literal();
void eol_comment_skip();

%}

%p 3500
%x DEFINE

%%

"--"                    {eol_comment_skip(); }

^[ \t\v\f]*#            {NOTE_SLOC(); BEGIN DEFINE;}
<DEFINE>[^\\]"\n"       {NOTE_SLOC(); vhdl_lineno++; BEGIN 0;}
<DEFINE>"\n"            {NOTE_SLOC(); vhdl_lineno++;}
<DEFINE>.               {;}

"abs"                   {STORE_OPERATOR(ABS_KEYWRD);}
"access"                {STORE_OPERATOR(ACCESS_KEYWRD);}
"after"                 {STORE_OPERATOR(AFTER_KEYWRD);}
"alias"                 {STORE_OPERATOR(ALIAS_KEYWRD);}
"all"                   {STORE_OPERATOR(ALL_KEYWRD);}
"and"                   {STORE_OPERATOR(AND_KEYWRD);}
"architecture"          {STORE_OPERATOR(ARCHITECTURE_KEYWRD);}
"array"                 {STORE_OPERATOR(ARRAY_KEYWRD);}
"assert"                {STORE_OPERATOR(ASSERT_KEYWRD);}
"attribute"             {STORE_OPERATOR(ATTRIBUTE_KEYWRD);}
"begin"                 {STORE_OPERATOR(BEGIN_KEYWRD);}
"block"                 {STORE_OPERATOR(BLOCK_KEYWRD);}
"body"                  {STORE_OPERATOR(BODY_KEYWRD);}
"buffer"                {STORE_OPERATOR(BUFFER_KEYWRD);}
"bus"                   {STORE_OPERATOR(BUS_KEYWRD);}
"case"                  {STORE_OPERATOR(CASE_KEYWRD);}
"component"             {STORE_OPERATOR(COMPONENT_KEYWRD);}
"configuration"         {STORE_OPERATOR(CONFIGURATION_KEYWRD);}
"constant"              {STORE_OPERATOR(CONSTANT_KEYWRD);}
"disconnect"            {STORE_OPERATOR(DISCONNECT_KEYWRD);}
"downto"                {STORE_OPERATOR(DOWNTO_KEYWRD);}
"else"                  {STORE_OPERATOR(ELSE_KEYWRD);}
"elsif"                 {STORE_OPERATOR(ELSIF_KEYWRD);}
"end"                   {STORE_OPERATOR(END_KEYWRD);}
"entity"                {STORE_OPERATOR(ENTITY_KEYWRD);}
"exit"                  {STORE_OPERATOR(EXIT_KEYWRD);}
"file"                  {STORE_OPERATOR(FILE_KEYWRD);}
"for"                   {STORE_OPERATOR(FOR_KEYWRD);}
"function"              {STORE_OPERATOR(FUNCTION_KEYWRD);}
"generate"              {STORE_OPERATOR(GENERATE_KEYWRD);}
"generic"               {STORE_OPERATOR(GENERIC_KEYWRD);}
"group"                 {STORE_OPERATOR(GROUP_KEYWRD);}
"guarded"               {STORE_OPERATOR(GUARDED_KEYWRD);}
"if"                    {STORE_OPERATOR(IF_KEYWRD);}
"impure"                {STORE_OPERATOR(IMPURE_KEYWRD);}
"in"                    {STORE_OPERATOR(IN_KEYWRD);}
"inertial"              {STORE_OPERATOR(INERTIAL_KEYWRD);}
"inout"                 {STORE_OPERATOR(INOUT_KEYWRD);}
"is"                    {STORE_OPERATOR(IS_KEYWRD);}
"label"                 {STORE_OPERATOR(LABEL_KEYWRD);}
"library"               {STORE_OPERATOR(LIBRARY_KEYWRD);}
"linkage"               {STORE_OPERATOR(LINKAGE_KEYWRD);}
"literal"               {STORE_OPERATOR(LITERAL_KEYWRD);}
"loop"                  {STORE_OPERATOR(LOOP_KEYWRD);}
"map"                   {STORE_OPERATOR(MAP_KEYWRD);}
"mod"                   {STORE_OPERATOR(MOD_KEYWRD);}
"nand"                  {STORE_OPERATOR(NAND_KEYWRD);}
"new"                   {STORE_OPERATOR(NEW_KEYWRD);}
"next"                  {STORE_OPERATOR(NEXT_KEYWRD);}
"nor"                   {STORE_OPERATOR(NOR_KEYWRD);}
"not"                   {STORE_OPERATOR(NOT_KEYWRD);}
"null"                  {STORE_OPERATOR(NULL_KEYWRD);}
"of"                    {STORE_OPERATOR(OF_KEYWRD);}
"on"                    {STORE_OPERATOR(ON_KEYWRD);}
"open"                  {STORE_OPERATOR(OPEN_KEYWRD);}
"or"                    {STORE_OPERATOR(OR_KEYWRD);}
"others"                {STORE_OPERATOR(OTHERS_KEYWRD);}
"out"                   {STORE_OPERATOR(OUT_KEYWRD);}
"package"               {STORE_OPERATOR(PACKAGE_KEYWRD);}
"port"                  {STORE_OPERATOR(PORT_KEYWRD);}
"postponed"             {STORE_OPERATOR(POSTPONED_KEYWRD);}
"procedural"            {STORE_OPERATOR(PROCEDURAL_KEYWRD);}
"procedure"             {STORE_OPERATOR(PROCEDURE_KEYWRD);}
"process"               {STORE_OPERATOR(PROCESS_KEYWRD);}
"protected"             {STORE_OPERATOR(PROTECTED_KEYWRD);}
"pure"                  {STORE_OPERATOR(PURE_KEYWRD);}
"range"                 {STORE_OPERATOR(RANGE_KEYWRD);}
"record"                {STORE_OPERATOR(RECORD_KEYWRD);}
"reference"             {STORE_OPERATOR(REFERENCE_KEYWRD);}
"register"              {STORE_OPERATOR(REGISTER_KEYWRD);}
"reject"                {STORE_OPERATOR(REJECT_KEYWRD);}
"rem"                   {STORE_OPERATOR(REM_KEYWRD);}
"report"                {STORE_OPERATOR(REPORT_KEYWRD);}
"return"                {STORE_OPERATOR(RETURN_KEYWRD);}
"rol"                   {STORE_OPERATOR(ROL_KEYWRD);}
"ror"                   {STORE_OPERATOR(ROR_KEYWRD);}
"select"                {STORE_OPERATOR(SELECT_KEYWRD);}
"severity"              {STORE_OPERATOR(SEVERITY_KEYWRD);}
"shared"                {STORE_OPERATOR(SHARED_KEYWRD);}
"signal"                {STORE_OPERATOR(SIGNAL_KEYWRD);}
"sla"                   {STORE_OPERATOR(SLA_KEYWRD);}
"sll"                   {STORE_OPERATOR(SLL_KEYWRD);}
"sra"                   {STORE_OPERATOR(SRA_KEYWRD);}
"srl"                   {STORE_OPERATOR(SRL_KEYWRD);}
"subtype"               {STORE_OPERATOR(SUBTYPE_KEYWRD);}
"then"                  {STORE_OPERATOR(THEN_KEYWRD);}
"to"                    {STORE_OPERATOR(TO_KEYWRD);}
"transport"             {STORE_OPERATOR(TRANSPORT_KEYWRD);}
"type"                  {STORE_OPERATOR(TYPE_KEYWRD);}
"unaffected"            {STORE_OPERATOR(UNAFFECTED_KEYWRD);}
"units"                 {STORE_OPERATOR(UNITS_KEYWRD);}
"until"                 {STORE_OPERATOR(UNTIL_KEYWRD);}
"use"                   {STORE_OPERATOR(USE_KEYWRD);}
"variable"              {STORE_OPERATOR(VARIABLE_KEYWRD);}
"wait"                  {STORE_OPERATOR(WAIT_KEYWRD);}
"when"                  {STORE_OPERATOR(WHEN_KEYWRD);}
"while"                 {STORE_OPERATOR(WHILE_KEYWRD);}
"with"                  {STORE_OPERATOR(WITH_KEYWRD);}
"xnor"                  {STORE_OPERATOR(XNOR_KEYWRD);}
"xor"                   {STORE_OPERATOR(XOR_KEYWRD);}

{L}({L}|{D})*           {STORE_OPERAND(yytext);}
0[xX]{H}+{IS}?          {STORE_OPERAND(yytext);}
0{D}+{IS}?              {STORE_OPERAND(yytext);}
{D}+{IS}?               {STORE_OPERAND(yytext);}
{D}+{E}{FS}?            {STORE_OPERAND(yytext);}
{D}*"."{D}+({E})?{FS}?  {STORE_OPERAND(yytext);}
{D}+"."{D}*({E})?{FS}?  {STORE_OPERAND(yytext);}
\"                      {NOTE_SLOC(); string_literal();}

";"                     {SEMI();}

"&"                     {STORE_OPERATOR(OP_BITAND);}
"*"                     {STORE_OPERATOR(OP_MULTIPLY);}
"**"                    {STORE_OPERATOR(OP_EXPONENT);}
"+"                     {STORE_OPERATOR(OP_ADD);}
"-"                     {STORE_OPERATOR(OP_SUBTRACT);}
"/"                     {STORE_OPERATOR(OP_DIVIDE);}

"="                     {STORE_OPERATOR(OP_EQUAL);}
"/="                    {STORE_OPERATOR(OP_NOTEQUAL);}

"<"                     {STORE_OPERATOR(OP_LESSTHAN);}
"<="                    {STORE_OPERATOR(OP_LESSEQUAL);}
">"                     {STORE_OPERATOR(OP_GREATERTHAN);}
">="                    {STORE_OPERATOR(OP_GREATEREQUAL);}

","                     {NOTE_SLOC();}
":"                     {NOTE_SLOC();}
"("                     {NOTE_SLOC();}
")"                     {NOTE_SLOC();}
"["                     {NOTE_SLOC();}
"]"                     {NOTE_SLOC();}
"{"                     {NOTE_SLOC();}
"}"                     {NOTE_SLOC();}
"|"                     {NOTE_SLOC();}

[ \t\v\f]               {;}
"\n"                    {vhdl_lineno++;}
.                       { /* ignore bad characters */ }
%%
int yywrap() {
  return(1);
}

void lexclear() {
  BEGIN 0;
  noperands=0;
  j_comments=c_comments=cpp_comments=com_loc=0;
  prev_com_line=-1;
  vhdl_lineno=nsemi=noperators=0;

  sloc.clear();
  operators.clear();
  operands.clear();
}

void string_literal() {
  char c=0;

  while ((c!='\"') && (c!=EOF))
     if ((c=yyinput())=='\\')
        if ((c=yyinput())=='\"')
           c=yyinput();

  NOTE_SLOC();
}


void eol_comment_skip() {
  char c;

  while (((c=yyinput()) !='\n') && (c!=0) && (c!=EOF)) ;

  cpp_comments++;

  if (vhdl_lineno!=prev_com_line)
    com_loc++;

  prev_com_line=vhdl_lineno;
  if (c=='\n') vhdl_lineno++;
}
