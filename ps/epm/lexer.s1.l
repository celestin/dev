/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 * Essential Project Manager (EPM)
 * Copyright (c) 2004-2005 PowerSoftware.com
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * PL/SQL parser
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  17-May-05    97 : File created.
 * CAM  24-Apr-08    358 : Corrected compiler warnings moving to VS2008 (from VC++6).
 * CAM  30-Sep-2010  10648 : Converted from string operands to PowerHashed.
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

%{

#include <stdio.h>
#include <string.h>
#include "y.s1.h"
#include "PowerHash.h"

#ifdef WIN32

#include <io.h>
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
set<unsigned int> operands;

int nsemi=0 ;           // Number of semi-colons
int noperators=0 ;      // Total number of operators
int noperands=0;        // Total number of operands

#define NOTE_SLOC()       sloc.insert(s1_lineno)
#define STORE_OPERATOR(X) operators.insert(X); noperators++; NOTE_SLOC();
#define STORE_OPERAND(X)  operands.insert(PowerHash(X)); noperands++; NOTE_SLOC();
#define SEMI()            nsemi++; NOTE_SLOC();

void lexclear();
void comment_skip();
void string_literal();

%}

%p 3500
%x DEFINE

NL                                "\n"
NOTNL                             .
D                       [0-9]
L                       [a-zA-Z_]
H                       [a-fA-F0-9]
E                       [Ee][+-]?{D}+
FS                      (f|F|l|L)
IS                      (u|U|l|L)*

%%

"/*"                    {comment_skip();c_comments++;}

"ALL"                   {STORE_OPERATOR(ALL);}
"ALTER"                 {STORE_OPERATOR(ALTER);}
"AND"                   {STORE_OPERATOR(AND);}
"ANY"                   {STORE_OPERATOR(ANY);}
"ARRAY"                 {STORE_OPERATOR(ARRAY);}
"AS"                    {STORE_OPERATOR(AS);}
"ASC"                   {STORE_OPERATOR(ASC);}
"AT"                    {STORE_OPERATOR(AT);}
"AUTHID"                {STORE_OPERATOR(AUTHID);}
"AVG"                   {STORE_OPERATOR(AVG);}
"BEGIN"                 {STORE_OPERATOR(BEGIN_BLOCK);}
"BETWEEN"               {STORE_OPERATOR(BETWEEN);}
"BINARY_INTEGER"        {STORE_OPERATOR(BINARY_INTEGER);}
"BODY"                  {STORE_OPERATOR(BODY);}
"BOOLEAN"               {STORE_OPERATOR(BOOLEAN);}
"BULK"                  {STORE_OPERATOR(BULK);}
"BY"                    {STORE_OPERATOR(BY);}
"CASE"                  {STORE_OPERATOR(CASE);}
"CHAR"                  {STORE_OPERATOR(CHAR);}
"CHAR_BASE"             {STORE_OPERATOR(CHAR_BASE);}
"CHECK"                 {STORE_OPERATOR(CHECK);}
"CLOSE"                 {STORE_OPERATOR(CLOSE);}
"CLUSTER"               {STORE_OPERATOR(CLUSTER);}
"COALESCE"              {STORE_OPERATOR(COALESCE);}
"COLLECT"               {STORE_OPERATOR(COLLECT);}
"COMMENT"               {STORE_OPERATOR(COMMENT);}
"COMMIT"                {STORE_OPERATOR(COMMIT);}
"COMPRESS"              {STORE_OPERATOR(COMPRESS);}
"CONNECT"               {STORE_OPERATOR(CONNECT);}
"CONSTANT"              {STORE_OPERATOR(CONSTANT);}
"CREATE"                {STORE_OPERATOR(CREATE);}
"CURRENT"               {STORE_OPERATOR(CURRENT);}
"CURRVAL"               {STORE_OPERATOR(CURRVAL);}
"CURSOR"                {STORE_OPERATOR(CURSOR);}
"DATE"                  {STORE_OPERATOR(DATE);}
"DAY"                   {STORE_OPERATOR(DAY);}
"DECIMAL"               {STORE_OPERATOR(DECIMAL);}
"DECLARE"               {STORE_OPERATOR(DECLARE);}
"DEFAULT"               {STORE_OPERATOR(DEFAULT);}
"DELETE"                {STORE_OPERATOR(DELETE);}
"DESC"                  {STORE_OPERATOR(DESC);}
"DISTINCT"              {STORE_OPERATOR(DISTINCT);}
"DO"                    {STORE_OPERATOR(DO);}
"DROP"                  {STORE_OPERATOR(DROP);}
"ELSE"                  {STORE_OPERATOR(ELSE);}
"ELSIF"                 {STORE_OPERATOR(ELSIF);}
"END"                   {STORE_OPERATOR(END_BLOCK);}
"EXCEPTION"             {STORE_OPERATOR(EXCEPTION);}
"EXCLUSIVE"             {STORE_OPERATOR(EXCLUSIVE);}
"EXECUTE"               {STORE_OPERATOR(EXECUTE);}
"EXISTS"                {STORE_OPERATOR(EXISTS);}
"EXIT"                  {STORE_OPERATOR(EXIT);}
"EXTENDS"               {STORE_OPERATOR(EXTENDS);}
"EXTRACT"               {STORE_OPERATOR(EXTRACT);}
"FALSE"                 {STORE_OPERATOR(FALSE);}
"FETCH"                 {STORE_OPERATOR(FETCH);}
"FLOAT"                 {STORE_OPERATOR(FLOAT);}
"FOR"                   {STORE_OPERATOR(FOR);}
"FORALL"                {STORE_OPERATOR(FORALL);}
"FROM"                  {STORE_OPERATOR(FROM);}
"FUNCTION"              {STORE_OPERATOR(FUNCTION);}
"GOTO"                  {STORE_OPERATOR(GOTO);}
"GROUP"                 {STORE_OPERATOR(GROUP);}
"HAVING"                {STORE_OPERATOR(HAVING);}
"HEAP"                  {STORE_OPERATOR(HEAP);}
"HOUR"                  {STORE_OPERATOR(HOUR);}
"IF"                    {STORE_OPERATOR(IF);}
"IMMEDIATE"             {STORE_OPERATOR(IMMEDIATE);}
"IN"                    {STORE_OPERATOR(IN);}
"INDEX"                 {STORE_OPERATOR(INDEX);}
"INDICATOR"             {STORE_OPERATOR(INDICATOR);}
"INSERT"                {STORE_OPERATOR(INSERT);}
"INTEGER"               {STORE_OPERATOR(INTEGER);}
"INTERFACE"             {STORE_OPERATOR(INTERFACE);}
"INTERSECT"             {STORE_OPERATOR(INTERSECT);}
"INTERVAL"              {STORE_OPERATOR(INTERVAL);}
"INTO"                  {STORE_OPERATOR(INTO);}
"IS"                    {STORE_OPERATOR(IS);}
"ISOLATION"             {STORE_OPERATOR(ISOLATION);}
"JAVA"                  {STORE_OPERATOR(JAVA);}
"LEVEL"                 {STORE_OPERATOR(LEVEL);}
"LIKE"                  {STORE_OPERATOR(LIKE);}
"LIMITED"               {STORE_OPERATOR(LIMITED);}
"LOCK"                  {STORE_OPERATOR(LOCK);}
"LONG"                  {STORE_OPERATOR(LONG);}
"LOOP"                  {STORE_OPERATOR(LOOP);}
"MAX"                   {STORE_OPERATOR(MAX);}
"MIN"                   {STORE_OPERATOR(MIN);}
"MINUS"                 {STORE_OPERATOR(MINUS_WORD);}
"MINUTE"                {STORE_OPERATOR(MINUTE);}
"MLSLABEL"              {STORE_OPERATOR(MLSLABEL);}
"MOD"                   {STORE_OPERATOR(MOD);}
"MODE"                  {STORE_OPERATOR(MODE);}
"MONTH"                 {STORE_OPERATOR(MONTH);}
"NATURAL"               {STORE_OPERATOR(NATURAL);}
"NATURALN"              {STORE_OPERATOR(NATURALN);}
"NEW"                   {STORE_OPERATOR(NEW);}
"NEXTVAL"               {STORE_OPERATOR(NEXTVAL);}
"NOCOPY"                {STORE_OPERATOR(NOCOPY);}
"NOT"                   {STORE_OPERATOR(NOT);}
"NOWAIT"                {STORE_OPERATOR(NOWAIT);}
"NULL"                  {STORE_OPERATOR(NULL_WORD);}
"NULLIF"                {STORE_OPERATOR(NULLIF);}
"NUMBER"                {STORE_OPERATOR(NUMBER);}
"NUMBER_BASE"           {STORE_OPERATOR(NUMBER_BASE);}
"OCIROWID"              {STORE_OPERATOR(OCIROWID);}
"OF"                    {STORE_OPERATOR(OF);}
"ON"                    {STORE_OPERATOR(ON);}
"OPAQUE"                {STORE_OPERATOR(OPAQUE);}
"OPEN"                  {STORE_OPERATOR(OPEN);}
"OPERATOR"              {STORE_OPERATOR(OPERATOR);}
"OPTION"                {STORE_OPERATOR(OPTION);}
"OR"                    {STORE_OPERATOR(OR);}
"ORDER"                 {STORE_OPERATOR(ORDER);}
"ORGANIZATION"          {STORE_OPERATOR(ORGANIZATION);}
"OTHERS"                {STORE_OPERATOR(OTHERS);}
"OUT"                   {STORE_OPERATOR(OUT);}
"PACKAGE"               {STORE_OPERATOR(PACKAGE);}
"PARTITION"             {STORE_OPERATOR(PARTITION);}
"PCTFREE"               {STORE_OPERATOR(PCTFREE);}
"PLS_INTEGER"           {STORE_OPERATOR(PLS_INTEGER);}
"POSITIVE"              {STORE_OPERATOR(POSITIVE);}
"POSITIVEN"             {STORE_OPERATOR(POSITIVEN);}
"PRAGMA"                {STORE_OPERATOR(PRAGMA);}
"PRIOR"                 {STORE_OPERATOR(PRIOR);}
"PRIVATE"               {STORE_OPERATOR(PRIVATE);}
"PROCEDURE"             {STORE_OPERATOR(PROCEDURE);}
"PUBLIC"                {STORE_OPERATOR(PUBLIC);}
"RAISE"                 {STORE_OPERATOR(RAISE);}
"RANGE"                 {STORE_OPERATOR(RANGE_WORD);}
"RAW"                   {STORE_OPERATOR(RAW);}
"REAL"                  {STORE_OPERATOR(REAL);}
"RECORD"                {STORE_OPERATOR(RECORD);}
"REF"                   {STORE_OPERATOR(REF);}
"RELEASE"               {STORE_OPERATOR(RELEASE);}
"RETURN"                {STORE_OPERATOR(RETURN);}
"REVERSE"               {STORE_OPERATOR(REVERSE);}
"ROLLBACK"              {STORE_OPERATOR(ROLLBACK);}
"ROW"                   {STORE_OPERATOR(ROW);}
"ROWID"                 {STORE_OPERATOR(ROWID);}
"ROWNUM"                {STORE_OPERATOR(ROWNUM);}
"ROWTYPE"               {STORE_OPERATOR(ROWTYPE);}
"SAVEPOINT"             {STORE_OPERATOR(SAVEPOINT);}
"SECOND"                {STORE_OPERATOR(SECOND);}
"SELECT"                {STORE_OPERATOR(SELECT);}
"SEPARATE"              {STORE_OPERATOR(SEPARATE);}
"SET"                   {STORE_OPERATOR(SET);}
"SHARE"                 {STORE_OPERATOR(SHARE);}
"SMALLINT"              {STORE_OPERATOR(SMALLINT);}
"SPACE"                 {STORE_OPERATOR(SPACE);}
"SQL"                   {STORE_OPERATOR(SQL);}
"SQLCODE"               {STORE_OPERATOR(SQLCODE);}
"SQLERRM"               {STORE_OPERATOR(SQLERRM);}
"START"                 {STORE_OPERATOR(START);}
"STDDEV"                {STORE_OPERATOR(STDDEV);}
"SUBTYPE"               {STORE_OPERATOR(SUBTYPE);}
"SUCCESSFUL"            {STORE_OPERATOR(SUCCESSFUL);}
"SUM"                   {STORE_OPERATOR(SUM);}
"SYNONYM"               {STORE_OPERATOR(SYNONYM);}
"SYSDATE"               {STORE_OPERATOR(SYSDATE);}
"TABLE"                 {STORE_OPERATOR(TABLE);}
"THEN"                  {STORE_OPERATOR(THEN);}
"TIME"                  {STORE_OPERATOR(TIME);}
"TIMESTAMP"             {STORE_OPERATOR(TIMESTAMP);}
"TIMEZONE_ABBR"         {STORE_OPERATOR(TIMEZONE_ABBR);}
"TIMEZONE_HOUR"         {STORE_OPERATOR(TIMEZONE_HOUR);}
"TIMEZONE_MINUTE"       {STORE_OPERATOR(TIMEZONE_MINUTE);}
"TIMEZONE_REGION"       {STORE_OPERATOR(TIMEZONE_REGION);}
"TO"                    {STORE_OPERATOR(TO);}
"TRIGGER"               {STORE_OPERATOR(TRIGGER);}
"TRUE"                  {STORE_OPERATOR(TRUE);}
"TYPE"                  {STORE_OPERATOR(TYPE);}
"UID"                   {STORE_OPERATOR(UID);}
"UNION"                 {STORE_OPERATOR(UNION);}
"UNIQUE"                {STORE_OPERATOR(UNIQUE);}
"UPDATE"                {STORE_OPERATOR(UPDATE);}
"USE"                   {STORE_OPERATOR(USE);}
"USER"                  {STORE_OPERATOR(USER);}
"VALIDATE"              {STORE_OPERATOR(VALIDATE);}
"VALUES"                {STORE_OPERATOR(VALUES);}
"VARCHAR"               {STORE_OPERATOR(VARCHAR);}
"VARCHAR2"              {STORE_OPERATOR(VARCHAR2);}
"VARIANCE"              {STORE_OPERATOR(VARIANCE);}
"VIEW"                  {STORE_OPERATOR(VIEW);}
"WHEN"                  {STORE_OPERATOR(WHEN);}
"WHENEVER"              {STORE_OPERATOR(WHENEVER);}
"WHERE"                 {STORE_OPERATOR(WHERE);}
"WHILE"                 {STORE_OPERATOR(WHILE);}
"WITH"                  {STORE_OPERATOR(WITH);}
"WORK"                  {STORE_OPERATOR(WORK);}
"WRITE"                 {STORE_OPERATOR(WRITE);}
"YEAR"                  {STORE_OPERATOR(YEAR);}
"ZONE"                  {STORE_OPERATOR(ZONE);}

{L}({L}|{D})*           {STORE_OPERAND(yytext);}
0[xX]{H}+{IS}?          {STORE_OPERAND(yytext);}
0{D}+{IS}?              {STORE_OPERAND(yytext);}
{D}+{IS}?               {STORE_OPERAND(yytext);}
'(\\.|[^\\'])+'         {STORE_OPERAND(yytext);}
{D}+{E}{FS}?            {STORE_OPERAND(yytext);}
{D}*"."{D}+({E})?{FS}?  {STORE_OPERAND(yytext);}
{D}+"."{D}*({E})?{FS}?  {STORE_OPERAND(yytext);}

\'                      {string_literal();}
\"                      {string_literal();}

"!="                    {STORE_OPERATOR(NOT_EQUAL);}
"%"                     {STORE_OPERATOR(ATTRIBUTE);}
"("                     {NOTE_SLOC();}
")"                     {NOTE_SLOC();}
"*"                     {STORE_OPERATOR(MULTIPLY);}
"**"                    {STORE_OPERATOR(EXPONENT);}
","                     {NOTE_SLOC();}
".."                    {STORE_OPERATOR(RANGE);}
"/"                     {STORE_OPERATOR(DIVIDE);}
":="                    {STORE_OPERATOR(ASSIGNMENT);}
"@"                     {STORE_OPERATOR(REMOTE_ACCESS);}  // Special? Metric?
"^="                    {STORE_OPERATOR(CARAT_EQUAL);}
"||"                    {STORE_OPERATOR(CONCATENATE);}
"~="                    {STORE_OPERATOR(TILDE_EQUAL);}
"<<"                    {STORE_OPERATOR(LABEL_BEGIN);}
"<="                    {STORE_OPERATOR(LESS_EQUAL);}
"<>"                    {STORE_OPERATOR(LESS_GREATER);}
"="                     {STORE_OPERATOR(EQUAL);}
"=>"                    {STORE_OPERATOR(ASSOCIATION);}
">="                    {STORE_OPERATOR(GREATER_EQUAL);}
">>"                    {STORE_OPERATOR(LABEL_END);}
"+"                     {STORE_OPERATOR(PLUS);}
"-"                     {STORE_OPERATOR(MINUS);}
":"                     {STORE_OPERATOR(HOST_VAR);}
"<"                     {STORE_OPERATOR(LESS_THAN);}
">"                     {STORE_OPERATOR(GREATER_THAN);}
"."                     {STORE_OPERATOR(COMPONENT);}
";"                     {SEMI();}

[ \t\v\f]               {;}
"\n"                    {s1_lineno++;}

"--"{NOTNL}*{NL}        {cpp_comments++;com_loc++;s1_lineno++;BEGIN(INITIAL);}

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
  s1_lineno=nsemi=noperators=0;

  sloc.clear();
  operators.clear();
  operands.clear();
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

  NOTE_SLOC();

  while ((c!='\"') && (c!=EOF))
     if ((c=yyinput())=='\\')
        if ((c=yyinput())=='\"')
           c=yyinput() ;
}

