/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 * Essential Project Manager (EPM)
 * Copyright (c) 2007 Power Software
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * VHDL Parser
 *
 * $Id$
 *
 * Who  When       Why
 * CAM  26-Jul-07   316 : File created.
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

#ifdef WIN32

#include <io.h>
#include <vector>
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
vector<char*> operands[255];
int nsemi=0 ;           // Number of semi-colons
int noperators=0 ;      // Total number of operators
int noperands=0;        // Total number of operands

#define NOTE_SLOC() sloc.insert(vhdl_lineno)

void lexclear() {
  BEGIN 0;
  noperands=0;
  j_comments=c_comments=cpp_comments=com_loc=0;
  prev_com_line=-1;
  vhdl_lineno=nsemi=noperators=0;

  sloc.clear();
  operators.clear();

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

void store_operator(int op) {
  operators.insert(op);
  noperators++;
  NOTE_SLOC();
}

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

"abs"                   {store_operator(ABS_KEYWRD);}
"access"                {store_operator(ACCESS_KEYWRD);}
"after"                 {store_operator(AFTER_KEYWRD);}
"alias"                 {store_operator(ALIAS_KEYWRD);}
"all"                   {store_operator(ALL_KEYWRD);}
"and"                   {store_operator(AND_KEYWRD);}
"architecture"          {store_operator(ARCHITECTURE_KEYWRD);}
"array"                 {store_operator(ARRAY_KEYWRD);}
"assert"                {store_operator(ASSERT_KEYWRD);}
"attribute"             {store_operator(ATTRIBUTE_KEYWRD);}
"begin"                 {store_operator(BEGIN_KEYWRD);}
"block"                 {store_operator(BLOCK_KEYWRD);}
"body"                  {store_operator(BODY_KEYWRD);}
"buffer"                {store_operator(BUFFER_KEYWRD);}
"bus"                   {store_operator(BUS_KEYWRD);}
"case"                  {store_operator(CASE_KEYWRD);}
"component"             {store_operator(COMPONENT_KEYWRD);}
"configuration"         {store_operator(CONFIGURATION_KEYWRD);}
"constant"              {store_operator(CONSTANT_KEYWRD);}
"disconnect"            {store_operator(DISCONNECT_KEYWRD);}
"downto"                {store_operator(DOWNTO_KEYWRD);}
"else"                  {store_operator(ELSE_KEYWRD);}
"elsif"                 {store_operator(ELSIF_KEYWRD);}
"end"                   {store_operator(END_KEYWRD);}
"entity"                {store_operator(ENTITY_KEYWRD);}
"exit"                  {store_operator(EXIT_KEYWRD);}
"file"                  {store_operator(FILE_KEYWRD);}
"for"                   {store_operator(FOR_KEYWRD);}
"function"              {store_operator(FUNCTION_KEYWRD);}
"generate"              {store_operator(GENERATE_KEYWRD);}
"generic"               {store_operator(GENERIC_KEYWRD);}
"group"                 {store_operator(GROUP_KEYWRD);}
"guarded"               {store_operator(GUARDED_KEYWRD);}
"if"                    {store_operator(IF_KEYWRD);}
"impure"                {store_operator(IMPURE_KEYWRD);}
"in"                    {store_operator(IN_KEYWRD);}
"inertial"              {store_operator(INERTIAL_KEYWRD);}
"inout"                 {store_operator(INOUT_KEYWRD);}
"is"                    {store_operator(IS_KEYWRD);}
"label"                 {store_operator(LABEL_KEYWRD);}
"library"               {store_operator(LIBRARY_KEYWRD);}
"linkage"               {store_operator(LINKAGE_KEYWRD);}
"literal"               {store_operator(LITERAL_KEYWRD);}
"loop"                  {store_operator(LOOP_KEYWRD);}
"map"                   {store_operator(MAP_KEYWRD);}
"mod"                   {store_operator(MOD_KEYWRD);}
"nand"                  {store_operator(NAND_KEYWRD);}
"new"                   {store_operator(NEW_KEYWRD);}
"next"                  {store_operator(NEXT_KEYWRD);}
"nor"                   {store_operator(NOR_KEYWRD);}
"not"                   {store_operator(NOT_KEYWRD);}
"null"                  {store_operator(NULL_KEYWRD);}
"of"                    {store_operator(OF_KEYWRD);}
"on"                    {store_operator(ON_KEYWRD);}
"open"                  {store_operator(OPEN_KEYWRD);}
"or"                    {store_operator(OR_KEYWRD);}
"others"                {store_operator(OTHERS_KEYWRD);}
"out"                   {store_operator(OUT_KEYWRD);}
"package"               {store_operator(PACKAGE_KEYWRD);}
"port"                  {store_operator(PORT_KEYWRD);}
"postponed"             {store_operator(POSTPONED_KEYWRD);}
"procedural"            {store_operator(PROCEDURAL_KEYWRD);}
"procedure"             {store_operator(PROCEDURE_KEYWRD);}
"process"               {store_operator(PROCESS_KEYWRD);}
"protected"             {store_operator(PROTECTED_KEYWRD);}
"pure"                  {store_operator(PURE_KEYWRD);}
"range"                 {store_operator(RANGE_KEYWRD);}
"record"                {store_operator(RECORD_KEYWRD);}
"reference"             {store_operator(REFERENCE_KEYWRD);}
"register"              {store_operator(REGISTER_KEYWRD);}
"reject"                {store_operator(REJECT_KEYWRD);}
"rem"                   {store_operator(REM_KEYWRD);}
"report"                {store_operator(REPORT_KEYWRD);}
"return"                {store_operator(RETURN_KEYWRD);}
"rol"                   {store_operator(ROL_KEYWRD);}
"ror"                   {store_operator(ROR_KEYWRD);}
"select"                {store_operator(SELECT_KEYWRD);}
"severity"              {store_operator(SEVERITY_KEYWRD);}
"shared"                {store_operator(SHARED_KEYWRD);}
"signal"                {store_operator(SIGNAL_KEYWRD);}
"sla"                   {store_operator(SLA_KEYWRD);}
"sll"                   {store_operator(SLL_KEYWRD);}
"sra"                   {store_operator(SRA_KEYWRD);}
"srl"                   {store_operator(SRL_KEYWRD);}
"subtype"               {store_operator(SUBTYPE_KEYWRD);}
"then"                  {store_operator(THEN_KEYWRD);}
"to"                    {store_operator(TO_KEYWRD);}
"transport"             {store_operator(TRANSPORT_KEYWRD);}
"type"                  {store_operator(TYPE_KEYWRD);}
"unaffected"            {store_operator(UNAFFECTED_KEYWRD);}
"units"                 {store_operator(UNITS_KEYWRD);}
"until"                 {store_operator(UNTIL_KEYWRD);}
"use"                   {store_operator(USE_KEYWRD);}
"variable"              {store_operator(VARIABLE_KEYWRD);}
"wait"                  {store_operator(WAIT_KEYWRD);}
"when"                  {store_operator(WHEN_KEYWRD);}
"while"                 {store_operator(WHILE_KEYWRD);}
"with"                  {store_operator(WITH_KEYWRD);}
"xnor"                  {store_operator(XNOR_KEYWRD);}
"xor"                   {store_operator(XOR_KEYWRD);}

{L}({L}|{D})*           {store_operand(strdup(yytext));}
0[xX]{H}+{IS}?          {store_operand(strdup(yytext));}
0{D}+{IS}?              {store_operand(strdup(yytext));}
{D}+{IS}?               {store_operand(strdup(yytext));}
{D}+{E}{FS}?            {store_operand(strdup(yytext));}
{D}*"."{D}+({E})?{FS}?  {store_operand(strdup(yytext));}
{D}+"."{D}*({E})?{FS}?  {store_operand(strdup(yytext));}
\"                      {sloc.insert(vhdl_lineno); string_literal();}

";"                     {NOTE_SLOC(); nsemi++;}

"&"                     {store_operator(OP_BITAND);}
"*"                     {store_operator(OP_MULTIPLY);}
"**"                    {store_operator(OP_EXPONENT);}
"+"                     {store_operator(OP_ADD);}
"-"                     {store_operator(OP_SUBTRACT);}
"/"                     {store_operator(OP_DIVIDE);}

"="                     {store_operator(OP_EQUAL);}
"/="                    {store_operator(OP_NOTEQUAL);}

"<"                     {store_operator(OP_LESSTHAN);}
"<="                    {store_operator(OP_LESSEQUAL);}
">"                     {store_operator(OP_GREATERTHAN);}
">="                    {store_operator(OP_GREATEREQUAL);}

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

void string_literal() {
  char c=0;

  while ((c!='\"') && (c!=EOF))
     if ((c=yyinput())=='\\')
        if ((c=yyinput())=='\"')
           c=yyinput();

  sloc.insert(vhdl_lineno);
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
