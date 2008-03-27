/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 * Krakatau C/C++ Parser (CPARSER.EXE)
 * Copyright (c) 2000,2008 Power Software
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * $Id$
 *
 * Who  When       Why
 * CAM  27-Mar-08  345 : File added to source control.
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
#include "y.tab.h"

#ifdef WIN32

#include <io.h>
#include <vector>
#include <list>
#include <set>
#include <stack>
using namespace std;

#else

#include <stl.h>
#include <unistd.h>

#endif

const int INITIAL_STATE=0;
const int WAITING_START_OF_COMMENT=1;
const int WAITING_END_OF_COMMENT=2;

int yylineno=0;
int C_COMMENTS=0;
int CPP_COMMENTS=0;
int COMMENT_LINES=0;
int last_comment_line=-1;

//void count();
void comment();
void string_literal();
void cpp_comment();
void macro();
//void semi();

vector<int> sloc;

class store_operator {
  int op;
  int line;
};

store_operator CUR_OPERATOR;

class operand_holder {
  char* op;
  int line;
};

operand_holder OPERAND;

//list<int> operators;
set<int> operators ;
vector<char*> operands[255];
int noperands=0;
char* yytext_back;

int lastsline=-1 ;    // most recent source code line number
int nsloc=0 ;         // number of Source Lines Of Code
int nsemi=0 ;     // Number of semi-colons
int totalOperators=0 ;  // Total number of operators

#define STORE_OPERATOR(X) operators.insert(X); totalOperators++;
#define STORE_OPERAND(X) operands.push_back(X);
#define SEMI() nsemi++;
#define COUNT() if (yylineno!=lastsline) { sloc.push_back(yylineno);lastsline=yylineno;}

void store_operand(char* txt) {
  unsigned char c;
  unsigned int i;
  yytext_back=txt;
  noperands++;

  c=txt[0];
  for (i=0;i<operands[c].size();i++)
  if (!strcmp(txt,operands[c][i]))
    return;
  operands[c].push_back(txt) ;
}

%}

%p 3500
%x DEFINE

%%

"/*"                    { comment(); }
"//"          { cpp_comment(); }

^[ \t\v\f]*#          { COUNT(); BEGIN DEFINE ;}

<DEFINE>[^\\]"\n"   { COUNT(); yylineno++ ; BEGIN 0 ; }
<DEFINE>"\n"      { COUNT(); yylineno++ ; }
<DEFINE>.       { ; }

"asm"         { COUNT(); return(ASM); }
"auto"                  { COUNT(); return(AUTO); }
"bool"          { COUNT(); return(BOOL); }
"break"                 { COUNT(); return(BREAK); }
"case"                  { COUNT(); return(CASE); }
"char"                  { COUNT(); return(CHAR); }
"class"                 { COUNT(); return(CLASS); }
"const_cast"      { COUNT(); return(CONST_CAST);}
"const"                 { COUNT(); return(CONST); }
"continue"              { COUNT(); return(CONTINUE); }
"default"               { COUNT(); return(DEFAULT); }
"do"                    { COUNT(); return(DO); }
"double"                { COUNT(); return(DOUBLE); }
"dynamic_cast"      { COUNT(); return(DYNAMIC_CAST); }
"else"                  { COUNT(); return(ELSE); }
"enum"                  { COUNT(); return(ENUM); }
"explicit"        { COUNT(); return(EXPLICIT); }
"export"        { COUNT(); return(EXPORT); }
"extern"                { COUNT(); return(EXTERN); }
"float"                 { COUNT(); return(FLOAT); }
"for"                   { COUNT(); return(FOR); }
"friend"                { COUNT(); return(FRIEND); }
"goto"                  { COUNT(); return(GOTO); }
"if"                    { COUNT(); return(IF); }
"inline"                { COUNT(); return(INLINE); }
"int"                   { COUNT(); return(INT); }
"long"                  { COUNT(); return(LONG); }
"operator"              { COUNT(); return(OPERATOR); }
"mutable"       { COUNT(); return(MUTABLE); }
"namespace"       { COUNT(); return(NAMESPACE); }
"private"               { COUNT(); return(PRIVATE);}
"protected"             { COUNT(); return(PROTECTED);}
"__published"           { COUNT(); return(PUBLIC);}
"public"                { COUNT(); return(PUBLIC);}
"register"              { COUNT(); return(REGISTER); }
"reinterpret_cast"    { COUNT(); return(REINTERPRET_CAST);}
"return"                { COUNT(); return(RETURN); }
"short"                 { COUNT(); return(SHORT); }
"signed"                { COUNT(); return(SIGNED); }
"sizeof"                { COUNT(); return(SIZEOF); }
"static_cast"     { COUNT(); return(STATIC_CAST);}
"static"                { COUNT(); return(STATIC); }
"struct"                { COUNT(); return(STRUCT); }
"switch"                { COUNT(); return(SWITCH); }
"template"              { COUNT(); return(TEMPLATE);}
"try"                   { COUNT(); return(TRY);}
"catch"                 { COUNT(); return(CATCH);}
"typedef"               { COUNT(); return(TYPEDEF); }
"typeid"        { COUNT(); return(TYPEID);}
"typename"        { COUNT(); return(TYPENAME);}
"union"                 { COUNT(); return(UNION); }
"void"                  { COUNT(); return(VOID); }
"virtual"               { COUNT(); return(VIRTUAL); }
"volatile"              { COUNT(); return(VOLATILE); }
"wchar_t"       { COUNT(); return(WCHAR_T);}
"while"                 { COUNT(); return(WHILE); }
"using"         { COUNT(); return(USING); }
"unsigned"              { COUNT(); return(UNSIGNED);}
"new"                   { COUNT(); return(NEW);}
"delete"                { COUNT(); return(DELETE);}
"this"                  { COUNT(); return(THIS);}
"throw"                 { COUNT(); return(THROW);}
{L}({L}|{D})*           { COUNT(); store_operand(strdup(yytext));return(IDENTIFIER); }
0[xX]{H}+{IS}?          { COUNT(); store_operand(strdup(yytext));return(CONSTANT); }
0{D}+{IS}?              { COUNT(); store_operand(strdup(yytext));return(CONSTANT); }
{D}+{IS}?               { COUNT(); store_operand(strdup(yytext));return(CONSTANT); }
'(\\.|[^\\'])+'         { COUNT(); store_operand(strdup(yytext));return(CONSTANT); }
{D}+{E}{FS}?            { COUNT(); store_operand(strdup(yytext));return(CONSTANT); }
{D}*"."{D}+({E})?{FS}?  { COUNT(); store_operand(strdup(yytext));return(CONSTANT); }
{D}+"."{D}*({E})?{FS}?  { COUNT(); store_operand(strdup(yytext));return(CONSTANT); }
\"                { COUNT(); string_literal();return(STRING_LITERAL); }
"::"                    { COUNT(); STORE_OPERATOR(COLONCOLON);return(COLONCOLON);}
"..."                   { COUNT(); return(ELLIPSIS); }
">>="                   { COUNT(); STORE_OPERATOR(GREATGREATEQUALS);return(GREATGREATEQUALS); }
"<<="                   { COUNT(); STORE_OPERATOR(LESSLESSEQUALS);return(LESSLESSEQUALS); }
"+="                    { COUNT(); STORE_OPERATOR(PLUSEQUALS);return(PLUSEQUALS); }
"-="                    { COUNT(); STORE_OPERATOR(MINUSEQUALS);return(MINUSEQUALS); }
"*="                    { COUNT(); STORE_OPERATOR(TIMESEQUALS);return(TIMESEQUALS); }
"/="                    { COUNT(); STORE_OPERATOR(DIVEQUALS);return(DIVEQUALS); }
"%="                    { COUNT(); STORE_OPERATOR(MODEQUALS);return(MODEQUALS); }
"&="                    { COUNT(); STORE_OPERATOR(ANDEQUALS);return(ANDEQUALS); }
"^="                    { COUNT(); STORE_OPERATOR(CARETEQUALS);return(CARETEQUALS); }
"|="                    { COUNT(); STORE_OPERATOR(BAREQUALS);return(BAREQUALS); }
">>"                    { COUNT(); STORE_OPERATOR(GREATERGREATER);return(GREATERGREATER); }
"<<"                    { COUNT(); STORE_OPERATOR(LESSLESS);return(LESSLESS); }
"++"                    { COUNT(); STORE_OPERATOR(INC_OP);return(INC_OP); }
"--"                    { COUNT(); STORE_OPERATOR(DEC_OP);return(DEC_OP); }
".*"                    { COUNT(); STORE_OPERATOR(DOT_STAR);return(DOT_STAR);}
"->*"                   { COUNT(); STORE_OPERATOR(PTR_OP_STAR);return(PTR_OP_STAR);}
"->"                    { COUNT(); STORE_OPERATOR(PTR_OP);return(PTR_OP); }
"&&"                    { COUNT(); STORE_OPERATOR(AND_OP);return(AND_OP); }
"||"                    { COUNT(); STORE_OPERATOR(OR_OP);return(OR_OP); }
"<="                    { COUNT(); STORE_OPERATOR(LESSEQUALS);return(LESSEQUALS); }
">="                    { COUNT(); STORE_OPERATOR(GREATEREQUALS);return(GREATEREQUALS); }
"=="                    { COUNT(); STORE_OPERATOR(EQUALS);return(EQUALS); }
"!="                    { COUNT(); STORE_OPERATOR(NOTEQUALS);return(NOTEQUALS); }
";"                     { COUNT(); SEMI() ; return(';') ; }
"{"                     { COUNT(); return('{'); }
"}"                     { COUNT(); return('}'); }
","                     { COUNT(); return(','); }
":"                     { COUNT(); return(':'); }
"="                     { COUNT(); STORE_OPERATOR('=');return('='); }
"("                     { COUNT(); return('('); }
")"                     { COUNT(); return(')'); }
"["                     { COUNT(); STORE_OPERATOR('[');return('['); }
"]"                     { COUNT(); return(']'); }
"."                     { COUNT(); STORE_OPERATOR('.');return('.'); }
"&"                     { COUNT(); STORE_OPERATOR('&');return('&'); }
"!"                     { COUNT(); STORE_OPERATOR('!');return('!'); }
"~"                     { COUNT(); STORE_OPERATOR('~');return('~'); }
"-"                     { COUNT(); STORE_OPERATOR('-');return('-'); }
"+"                     { COUNT(); STORE_OPERATOR('+');return('+'); }
"*"                     { COUNT(); STORE_OPERATOR('*');return('*'); }
"/"                     { COUNT(); STORE_OPERATOR('/');return('/'); }
"%"                     { COUNT(); STORE_OPERATOR('%');return('%'); }
"<"                     { COUNT(); STORE_OPERATOR(LT);return(LT); }
">"                     { COUNT(); STORE_OPERATOR(GT);return(GT); }
"^"                     { COUNT(); STORE_OPERATOR('^');return('^'); }
"|"                     { COUNT(); STORE_OPERATOR('|');return('|'); }
"?"                     { COUNT(); STORE_OPERATOR('?');return('?'); }
[ \t\v\f]               { ; }
"\n" {yylineno++;};
.                       { /* ignore bad characters */ }
%%
int yywrap() {
        return(1);
}

void macro() {
        char c;
        while ((c=yyinput()) !='\n' && c !=0) {};
  unput (c);
}

void comment() {

    char c=0 ;
  int state=INITIAL_STATE ;

  // Increment the c comments
  C_COMMENTS++ ;

  // If there are two c comments on one line it is treated as two
  // c comments but only one comment LOC. Therefore we have to check
  // what line the previous c comment was on.

  if (yylineno!=last_comment_line) {
    // Not on the same line as the previous comment so increment
    // comment LOC
    COMMENT_LINES++;

    // Set the previous c comment line no. to the current line
    last_comment_line=yylineno;
  }


  while (c!=EOF) {
    c=yyinput();

    switch (c) {
      case '*':
        state=WAITING_END_OF_COMMENT ;
        break ;

      case '\n':
        // Set the previous c comment line no. to the current line
        last_comment_line=yylineno;

        // Update the yylineno variable to correspond with moving
        // onto the next line
        yylineno++;

        // Increment the comment LOC
        COMMENT_LINES++;

        // Set the state to INITIAL_STATE
        state=INITIAL_STATE ;
        break ;

      case '/':
        if (state==WAITING_END_OF_COMMENT) {
          return ;
        }

        // Set the state to INITIAL_STATE
        state=INITIAL_STATE ;
        break ;

      default:
        state=INITIAL_STATE ;

    }
  }
}

/*
 * This method looks as embeddded comments - this is unnecassary
 *
 * comment()
 *
 * This function is called whenever the start of a C-style comment is
 * found.  Depth is initially set to 1.  Code is scanned forward.
 *
 * End of comment   => depth is decremented (if depth==0, function returns)
 * Start of comment => depth is incremented
 * EOF              => function returns
 *
*/

/*
void comment() {

    char c=0;
  int depth=1;
  int state;

  if (yylineno!=last_comment_line) {
    COMMENT_LINES++;
    last_comment_line=yylineno;
  }
  state=INITIAL_STATE;

  while ((depth>0)&&(c!=EOF)) {
    c=yyinput();
    if (c=='\n') {
      last_comment_line=yylineno;
    yylineno++;
    COMMENT_LINES++;
    }
    if ((state==WAITING_END_OF_COMMENT)&&(c!='/'))
      state=INITIAL_STATE;
    if ((state==WAITING_START_OF_COMMENT)&&(c!='*'))
      state=INITIAL_STATE;

    if (state==INITIAL_STATE) {
      if (c=='*') {
        state=WAITING_END_OF_COMMENT;
      } else if (c=='/') {
        state=WAITING_START_OF_COMMENT;
    }
    } else if (state==WAITING_END_OF_COMMENT) {
      if (c=='/') {
      depth--;
      state=INITIAL_STATE;
    }
    } else if (state==WAITING_START_OF_COMMENT) {
      if (c=='*') {
      depth++;
      state=INITIAL_STATE;
    }
    }
  } // end while
  C_COMMENTS++;
}
*/

/*
 * This addition was added to allow foreign characters
 *
 */

void string_literal() {
  char c=0;

  while ((c!='\"') && (c!=EOF))
     if ((c=yyinput())=='\\')
        if ((c=yyinput())=='\"')
           c=yyinput() ;
}


void cpp_comment () {
  char c;

  while (((c=yyinput()) !='\n') && (c!=0) && (c!=EOF))
    ;

  CPP_COMMENTS++;

  if (yylineno!=last_comment_line)
    COMMENT_LINES++;

  last_comment_line=yylineno;
  if (c=='\n') yylineno++;
}

int column = 0;

/*void count() {
  int i;

  if (yylineno!=lastsline) {
    sloc.push_back(yylineno);
    lastsline=yylineno;
  }

  return;

  for (i = 0; yytext[i] != '\0'; i++)
    if (yytext[i] == '\n')
      column = 0;
    else if (yytext[i] == '\t')
      column += 8 - (column % 8);
    else
      column++;

}*/


//void semi() {
//
//  // Increment number of semi-colons
//  nsemi++ ;
//}

/* ************************************* */

