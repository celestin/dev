/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 * Essential Project Manager (EPM)
 * Copyright (c) 2004-2005 Power Software
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * PL/SQL parser
 *
 * $Id$
 *
 * Who  When       Why
 * CAM  17-May-05    97 : File created.
 * CAM  24-Apr-08   358 : Corrected compiler warnings moving to VS2008 (from VC++6).
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
#include "y.s1.h"

#ifdef WIN32

#include <io.h>
#include <vector>
#include <set>
using namespace std;

#else

#include <stl.h>
#include <unistd.h>

#endif

const int INITIAL_STATE=0;
const int WAITING_START_OF_COMMENT=1;
const int WAITING_END_OF_COMMENT=2;

int s1_lineno=0;
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

#define SEMI() nsemi++;
#define COUNT() sloc.insert(s1_lineno)

void lexclear() {
  BEGIN 0 ;
  noperands=0;
  j_comments=c_comments=cpp_comments=com_loc=0;
  prev_com_line=-1;
  s1_lineno=nsemi=noperators=0;

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
  sloc.insert(s1_lineno);
}

void store_operator(int op) {
  operators.insert(op);
  noperators++;
  sloc.insert(s1_lineno);
}

void comment_skip();
void string_literal();
void eol_comment_skip();

%}

%p 3500
%x DEFINE

%%

"/*"                    {comment_skip();c_comments++;}
"--"                    {eol_comment_skip(); }

"ALL"                   {store_operator(ALL);}
"ALTER"                 {store_operator(ALTER);}
"AND"                   {store_operator(AND);}
"ANY"                   {store_operator(ANY);}
"ARRAY"                 {store_operator(ARRAY);}
"AS"                    {store_operator(AS);}
"ASC"                   {store_operator(ASC);}
"AT"                    {store_operator(AT);}
"AUTHID"                {store_operator(AUTHID);}
"AVG"                   {store_operator(AVG);}
"BEGIN"                 {store_operator(BEGIN_BLOCK);}
"BETWEEN"               {store_operator(BETWEEN);}
"BINARY_INTEGER"        {store_operator(BINARY_INTEGER);}
"BODY"                  {store_operator(BODY);}
"BOOLEAN"               {store_operator(BOOLEAN);}
"BULK"                  {store_operator(BULK);}
"BY"                    {store_operator(BY);}
"CASE"                  {store_operator(CASE);}
"CHAR"                  {store_operator(CHAR);}
"CHAR_BASE"             {store_operator(CHAR_BASE);}
"CHECK"                 {store_operator(CHECK);}
"CLOSE"                 {store_operator(CLOSE);}
"CLUSTER"               {store_operator(CLUSTER);}
"COALESCE"              {store_operator(COALESCE);}
"COLLECT"               {store_operator(COLLECT);}
"COMMENT"               {store_operator(COMMENT);}
"COMMIT"                {store_operator(COMMIT);}
"COMPRESS"              {store_operator(COMPRESS);}
"CONNECT"               {store_operator(CONNECT);}
"CONSTANT"              {store_operator(CONSTANT);}
"CREATE"                {store_operator(CREATE);}
"CURRENT"               {store_operator(CURRENT);}
"CURRVAL"               {store_operator(CURRVAL);}
"CURSOR"                {store_operator(CURSOR);}
"DATE"                  {store_operator(DATE);}
"DAY"                   {store_operator(DAY);}
"DECIMAL"               {store_operator(DECIMAL);}
"DECLARE"               {store_operator(DECLARE);}
"DEFAULT"               {store_operator(DEFAULT);}
"DELETE"                {store_operator(DELETE);}
"DESC"                  {store_operator(DESC);}
"DISTINCT"              {store_operator(DISTINCT);}
"DO"                    {store_operator(DO);}
"DROP"                  {store_operator(DROP);}
"ELSE"                  {store_operator(ELSE);}
"ELSIF"                 {store_operator(ELSIF);}
"END"                   {store_operator(END_BLOCK);}
"EXCEPTION"             {store_operator(EXCEPTION);}
"EXCLUSIVE"             {store_operator(EXCLUSIVE);}
"EXECUTE"               {store_operator(EXECUTE);}
"EXISTS"                {store_operator(EXISTS);}
"EXIT"                  {store_operator(EXIT);}
"EXTENDS"               {store_operator(EXTENDS);}
"EXTRACT"               {store_operator(EXTRACT);}
"FALSE"                 {store_operator(FALSE);}
"FETCH"                 {store_operator(FETCH);}
"FLOAT"                 {store_operator(FLOAT);}
"FOR"                   {store_operator(FOR);}
"FORALL"                {store_operator(FORALL);}
"FROM"                  {store_operator(FROM);}
"FUNCTION"              {store_operator(FUNCTION);}
"GOTO"                  {store_operator(GOTO);}
"GROUP"                 {store_operator(GROUP);}
"HAVING"                {store_operator(HAVING);}
"HEAP"                  {store_operator(HEAP);}
"HOUR"                  {store_operator(HOUR);}
"IF"                    {store_operator(IF);}
"IMMEDIATE"             {store_operator(IMMEDIATE);}
"IN"                    {store_operator(IN);}
"INDEX"                 {store_operator(INDEX);}
"INDICATOR"             {store_operator(INDICATOR);}
"INSERT"                {store_operator(INSERT);}
"INTEGER"               {store_operator(INTEGER);}
"INTERFACE"             {store_operator(INTERFACE);}
"INTERSECT"             {store_operator(INTERSECT);}
"INTERVAL"              {store_operator(INTERVAL);}
"INTO"                  {store_operator(INTO);}
"IS"                    {store_operator(IS);}
"ISOLATION"             {store_operator(ISOLATION);}
"JAVA"                  {store_operator(JAVA);}
"LEVEL"                 {store_operator(LEVEL);}
"LIKE"                  {store_operator(LIKE);}
"LIMITED"               {store_operator(LIMITED);}
"LOCK"                  {store_operator(LOCK);}
"LONG"                  {store_operator(LONG);}
"LOOP"                  {store_operator(LOOP);}
"MAX"                   {store_operator(MAX);}
"MIN"                   {store_operator(MIN);}
"MINUS"                 {store_operator(MINUS_WORD);}
"MINUTE"                {store_operator(MINUTE);}
"MLSLABEL"              {store_operator(MLSLABEL);}
"MOD"                   {store_operator(MOD);}
"MODE"                  {store_operator(MODE);}
"MONTH"                 {store_operator(MONTH);}
"NATURAL"               {store_operator(NATURAL);}
"NATURALN"              {store_operator(NATURALN);}
"NEW"                   {store_operator(NEW);}
"NEXTVAL"               {store_operator(NEXTVAL);}
"NOCOPY"                {store_operator(NOCOPY);}
"NOT"                   {store_operator(NOT);}
"NOWAIT"                {store_operator(NOWAIT);}
"NULL"                  {store_operator(NULL_WORD);}
"NULLIF"                {store_operator(NULLIF);}
"NUMBER"                {store_operator(NUMBER);}
"NUMBER_BASE"           {store_operator(NUMBER_BASE);}
"OCIROWID"              {store_operator(OCIROWID);}
"OF"                    {store_operator(OF);}
"ON"                    {store_operator(ON);}
"OPAQUE"                {store_operator(OPAQUE);}
"OPEN"                  {store_operator(OPEN);}
"OPERATOR"              {store_operator(OPERATOR);}
"OPTION"                {store_operator(OPTION);}
"OR"                    {store_operator(OR);}
"ORDER"                 {store_operator(ORDER);}
"ORGANIZATION"          {store_operator(ORGANIZATION);}
"OTHERS"                {store_operator(OTHERS);}
"OUT"                   {store_operator(OUT);}
"PACKAGE"               {store_operator(PACKAGE);}
"PARTITION"             {store_operator(PARTITION);}
"PCTFREE"               {store_operator(PCTFREE);}
"PLS_INTEGER"           {store_operator(PLS_INTEGER);}
"POSITIVE"              {store_operator(POSITIVE);}
"POSITIVEN"             {store_operator(POSITIVEN);}
"PRAGMA"                {store_operator(PRAGMA);}
"PRIOR"                 {store_operator(PRIOR);}
"PRIVATE"               {store_operator(PRIVATE);}
"PROCEDURE"             {store_operator(PROCEDURE);}
"PUBLIC"                {store_operator(PUBLIC);}
"RAISE"                 {store_operator(RAISE);}
"RANGE"                 {store_operator(RANGE_WORD);}
"RAW"                   {store_operator(RAW);}
"REAL"                  {store_operator(REAL);}
"RECORD"                {store_operator(RECORD);}
"REF"                   {store_operator(REF);}
"RELEASE"               {store_operator(RELEASE);}
"RETURN"                {store_operator(RETURN);}
"REVERSE"               {store_operator(REVERSE);}
"ROLLBACK"              {store_operator(ROLLBACK);}
"ROW"                   {store_operator(ROW);}
"ROWID"                 {store_operator(ROWID);}
"ROWNUM"                {store_operator(ROWNUM);}
"ROWTYPE"               {store_operator(ROWTYPE);}
"SAVEPOINT"             {store_operator(SAVEPOINT);}
"SECOND"                {store_operator(SECOND);}
"SELECT"                {store_operator(SELECT);}
"SEPARATE"              {store_operator(SEPARATE);}
"SET"                   {store_operator(SET);}
"SHARE"                 {store_operator(SHARE);}
"SMALLINT"              {store_operator(SMALLINT);}
"SPACE"                 {store_operator(SPACE);}
"SQL"                   {store_operator(SQL);}
"SQLCODE"               {store_operator(SQLCODE);}
"SQLERRM"               {store_operator(SQLERRM);}
"START"                 {store_operator(START);}
"STDDEV"                {store_operator(STDDEV);}
"SUBTYPE"               {store_operator(SUBTYPE);}
"SUCCESSFUL"            {store_operator(SUCCESSFUL);}
"SUM"                   {store_operator(SUM);}
"SYNONYM"               {store_operator(SYNONYM);}
"SYSDATE"               {store_operator(SYSDATE);}
"TABLE"                 {store_operator(TABLE);}
"THEN"                  {store_operator(THEN);}
"TIME"                  {store_operator(TIME);}
"TIMESTAMP"             {store_operator(TIMESTAMP);}
"TIMEZONE_ABBR"         {store_operator(TIMEZONE_ABBR);}
"TIMEZONE_HOUR"         {store_operator(TIMEZONE_HOUR);}
"TIMEZONE_MINUTE"       {store_operator(TIMEZONE_MINUTE);}
"TIMEZONE_REGION"       {store_operator(TIMEZONE_REGION);}
"TO"                    {store_operator(TO);}
"TRIGGER"               {store_operator(TRIGGER);}
"TRUE"                  {store_operator(TRUE);}
"TYPE"                  {store_operator(TYPE);}
"UID"                   {store_operator(UID);}
"UNION"                 {store_operator(UNION);}
"UNIQUE"                {store_operator(UNIQUE);}
"UPDATE"                {store_operator(UPDATE);}
"USE"                   {store_operator(USE);}
"USER"                  {store_operator(USER);}
"VALIDATE"              {store_operator(VALIDATE);}
"VALUES"                {store_operator(VALUES);}
"VARCHAR"               {store_operator(VARCHAR);}
"VARCHAR2"              {store_operator(VARCHAR2);}
"VARIANCE"              {store_operator(VARIANCE);}
"VIEW"                  {store_operator(VIEW);}
"WHEN"                  {store_operator(WHEN);}
"WHENEVER"              {store_operator(WHENEVER);}
"WHERE"                 {store_operator(WHERE);}
"WHILE"                 {store_operator(WHILE);}
"WITH"                  {store_operator(WITH);}
"WORK"                  {store_operator(WORK);}
"WRITE"                 {store_operator(WRITE);}
"YEAR"                  {store_operator(YEAR);}
"ZONE"                  {store_operator(ZONE);}

{L}({L}|{D})*           {store_operand(_strdup(yytext));}
0[xX]{H}+{IS}?          {store_operand(_strdup(yytext));}
0{D}+{IS}?              {store_operand(_strdup(yytext));}
{D}+{IS}?               {store_operand(_strdup(yytext));}
'(\\.|[^\\'])+'         {store_operand(_strdup(yytext));}
{D}+{E}{FS}?            {store_operand(_strdup(yytext));}
{D}*"."{D}+({E})?{FS}?  {store_operand(_strdup(yytext));}
{D}+"."{D}*({E})?{FS}?  {store_operand(_strdup(yytext));}

\'                      {COUNT(); string_literal();}
\"                      {COUNT(); string_literal();}

"!="                    {store_operator(NOT_EQUAL);}
"%"                     {store_operator(ATTRIBUTE);}
"("                     {COUNT();}
")"                     {COUNT();}
"*"                     {store_operator(MULTIPLY);}
"**"                    {store_operator(EXPONENT);}
","                     {COUNT();}
".."                    {store_operator(RANGE);}
"/"                     {store_operator(DIVIDE);}
":="                    {store_operator(ASSIGNMENT);}
"@"                     {store_operator(REMOTE_ACCESS);}  // Special? Metric?
"^="                    {store_operator(CARAT_EQUAL);}
"||"                    {store_operator(CONCATENATE);}
"~="                    {store_operator(TILDE_EQUAL);}
"<<"                    {store_operator(LABEL_BEGIN);}
"<="                    {store_operator(LESS_EQUAL);}
"<>"                    {store_operator(LESS_GREATER);}
"="                     {store_operator(EQUAL);}
"=>"                    {store_operator(ASSOCIATION);}
">="                    {store_operator(GREATER_EQUAL);}
">>"                    {store_operator(LABEL_END);}
"+"                     {store_operator(PLUS);}
"-"                     {store_operator(MINUS);}
":"                     {store_operator(HOST_VAR);}
"<"                     {store_operator(LESS_THAN);}
">"                     {store_operator(GREATER_THAN);}
"."                     {store_operator(COMPONENT);}
";"                     {COUNT(); SEMI();}

[ \t\v\f]               {;}
"\n"                    {s1_lineno++;}
.                       { /* ignore bad characters */ }
%%
int yywrap() {
  return(1);
}

void comment_skip() {
  char c=0 ;
  int state=INITIAL_STATE ;

  // If there are two c comments on one line it is treated as two
  // c comments but only one comment LOC. Therefore we have to check
  // what line the previous c comment was on.
  if (s1_lineno!=prev_com_line) {
    // Not on the same line as the previous comment so increment
    // comment LOC
    com_loc++;

    // Set the previous c comment line no. to the current line
    prev_com_line=s1_lineno;
  }

  while (c!=EOF) {
    c=yyinput();

    switch (c) {
      case '*':
        state=WAITING_END_OF_COMMENT ;
        break ;

      case '\n':
        // Set the previous c comment line no. to the current line
        prev_com_line=s1_lineno;

        // Update the s1_lineno variable to correspond with moving
        // onto the next line
        s1_lineno++;

        // Increment the comment LOC
        com_loc++;

        // Set the state to INITIAL_STATE
        state=INITIAL_STATE ;
        break ;

      case '/':
        if (state==WAITING_END_OF_COMMENT) {
          return;
        }

        // Set the state to INITIAL_STATE
        state=INITIAL_STATE ;
        break ;

      default:
        state=INITIAL_STATE ;
    }
  }
}


void string_literal() {
  char c=0;

  while ((c!='\"') && (c!=EOF))
     if ((c=yyinput())=='\\')
        if ((c=yyinput())=='\"')
           c=yyinput() ;
}


void eol_comment_skip() {
  char c;

  while (((c=yyinput()) !='\n') && (c!=0) && (c!=EOF)) ;

  cpp_comments++;

  if (s1_lineno!=prev_com_line)
    com_loc++;

  prev_com_line=s1_lineno;
  if (c=='\n') s1_lineno++;
}

/* ************************************* */

