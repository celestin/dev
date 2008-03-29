/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 * Krakatau Java Parser (JPARSER.EXE)
 * Copyright (c) 2000,2008 Power Software
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * $Id$
 *
 * Who  When       Why
 * CAM  29-Mar-08  346 : File added to source control.
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

JL			[a-zA-Z_$]
JLD			[a-zA-Z0-9_$]

HIL			0[xX][0-9a-fA-F]+(l|L)?
DIL			(0|([1-9][0-9]*))(l|L)?
OIL			0([0-7])+(l|L)?

DIGS			([0-9])+
EXP			[eE][+-]?[0-9]+
FTS			[fFdD]

CH 			[^\'\\]
UNICODE_ESC		(\\u[0-9a-fA-F][0-9a-fA-F][0-9a-fA-F][0-9a-fA-F])
OCTAL_ESC		((\\[0-7])|(\\[0-7][0-7])|(\\[0-3][0-7][0-7]))
ESC_SEQ			(\\b|\\t|\\n|\\f|\\r|\\\"|\\\'|\\\\)
/*SCHARS			((\\\")|[^\"])*/
/*SCHARS			([^\\][^\"])* */

%{
#include <stdio.h>
#include <string.h>
#include "y.tab.h"

int yylex() ;

#ifdef WIN32
  #include <io.h>
  #include <vector>
  #include <list>
  using namespace std;
#else
  #include <stl.h>
  #include <unistd.h>
#endif

void parse_string_literal();
list<int> sloc;
list<int> operators;
vector<char*> operands[255];
int noperands=0;
int j_comments=0;
int c_comments=0;
int cpp_comments=0;
int com_loc=0;
int last_com_loc=-1;
int nsemi=0 ;			// Number of semi-colons

// *********************************

void store_operand(char* txt) {
unsigned char c;int i;

noperands++;
c=txt[0];
for (i=0;i<operands[c].size();i++)
  if (!strcmp(txt,operands[c][i])) return;
operands[c].push_back(txt);

}

#define SEMI() nsemi++;

// *********************************
void traditional_comment() ;
void comment() ;

void eol_comment() ;
int yylineno=0;
%}
%%
"/**"			{/*traditional_*/comment();j_comments++;}
"/*"            {/*traditional_*/comment();c_comments++;}
"//"			{eol_comment(); cpp_comments++;}
"abstract"      {operators.push_back(ABSTRACT);sloc.push_back(yylineno);return(ABSTRACT);}
"default"		{operators.push_back(DEFAULT);sloc.push_back(yylineno);return(DEFAULT);}
"if"			{operators.push_back(IF);sloc.push_back(yylineno);return(IF);}
"private"		{operators.push_back(PRIVATE);sloc.push_back(yylineno);return(PRIVATE);}
"throw"			{operators.push_back(THROW);sloc.push_back(yylineno);return(THROW);}
"boolean"		{operators.push_back(BOOLEAN);sloc.push_back(yylineno);return(BOOLEAN);}
"do"			{operators.push_back(DO);sloc.push_back(yylineno);return(DO);}
"implements"	{operators.push_back(IMPLEMENTS);sloc.push_back(yylineno);return(IMPLEMENTS);}
"protected"		{operators.push_back(PROTECTED);sloc.push_back(yylineno);return(PROTECTED);}
"throws"		{operators.push_back(THROWS);sloc.push_back(yylineno);return(THROWS);}
"break"			{operators.push_back(BREAK);sloc.push_back(yylineno);return(BREAK);}
"double"		{operators.push_back(DOUBLE);sloc.push_back(yylineno);return(DOUBLE);}
"import"		{operators.push_back(IMPORT);sloc.push_back(yylineno);return(IMPORT);}
"public"		{operators.push_back(PUBLIC);sloc.push_back(yylineno);return(PUBLIC);}
"transient"		{operators.push_back(TRANSIENT);sloc.push_back(yylineno);return(TRANSIENT);}
"byte"			{operators.push_back(BYTE);sloc.push_back(yylineno);return(BYTE);}
"else"			{operators.push_back(ELSE);sloc.push_back(yylineno);return(ELSE);}
"instanceof"	{operators.push_back(INSTANCEOF);sloc.push_back(yylineno);return(INSTANCEOF);}
"return"		{operators.push_back(RETURN);sloc.push_back(yylineno);return(RETURN);}
"try"			{operators.push_back(TRY);sloc.push_back(yylineno);return(TRY);}
"case"			{operators.push_back(CASE);sloc.push_back(yylineno);return(CASE);}
"extends"		{operators.push_back(EXTENDS);sloc.push_back(yylineno);return(EXTENDS);}
"int"			{operators.push_back(INT);sloc.push_back(yylineno);return(INT);}
"short"			{operators.push_back(SHORT);sloc.push_back(yylineno);return(SHORT);}
"void"			{operators.push_back(VOID);sloc.push_back(yylineno);return(VOID);}
"catch"			{operators.push_back(CATCH);sloc.push_back(yylineno);return(CATCH);}
"final"			{operators.push_back(FINAL);sloc.push_back(yylineno);return(FINAL);}
"interface"		{operators.push_back(INTERFACE);sloc.push_back(yylineno);return(INTERFACE);}
"static"		{operators.push_back(STATIC);sloc.push_back(yylineno);return(STATIC);}
"volatile"		{operators.push_back(VOLATILE);sloc.push_back(yylineno);return(VOLATILE);}
"char"			{operators.push_back(CHAR);sloc.push_back(yylineno);return(CHAR);}
"finally"		{operators.push_back(FINALLY);sloc.push_back(yylineno);return(FINALLY);}
"long"			{operators.push_back(LONG);sloc.push_back(yylineno);return(LONG);}
"super"			{operators.push_back(SUPER);sloc.push_back(yylineno);return(SUPER);}
"while"			{operators.push_back(WHILE);sloc.push_back(yylineno);return(WHILE);}
"class"			{operators.push_back(CLASS);sloc.push_back(yylineno);return(CLASS);}
"native"		{operators.push_back(NATIVE);sloc.push_back(yylineno);return(NATIVE);}
"float"			{operators.push_back(FLOAT);sloc.push_back(yylineno);return(FLOAT);}
"switch"		{operators.push_back(SWITCH);sloc.push_back(yylineno);return(SWITCH);}
"const"			{operators.push_back(CONST);sloc.push_back(yylineno);return(CONST);}
"for"			{operators.push_back(FOR);sloc.push_back(yylineno);return(FOR);}
"new"			{operators.push_back(NEW);sloc.push_back(yylineno);return(NEW);}
"synchronized"	{operators.push_back(SYNCHRONIZED);sloc.push_back(yylineno);return(SYNCHRONIZED);}
"continue"		{operators.push_back(CONTINUE);sloc.push_back(yylineno);return(CONTINUE);}
"goto"			{operators.push_back(GOTO);sloc.push_back(yylineno);return(GOTO);}
"package"		{operators.push_back(PACKAGE);sloc.push_back(yylineno);return(PACKAGE);}
"this"			{operators.push_back(THIS);sloc.push_back(yylineno);return(THIS);}
"\""			{parse_string_literal();store_operand(strdup(yytext));return STRING_LITERAL;}
({DIGS})"."({DIGS})?({EXP})?({FTS})?    {store_operand(strdup(yytext));sloc.push_back(yylineno);return(FLOATING_LITERAL); }
"."({DIGS})({EXP})?({FTS})?    			{store_operand(strdup(yytext)); sloc.push_back(yylineno);return(FLOATING_LITERAL); }
({DIGS})({EXP})({FTS})?       			{store_operand(strdup(yytext));sloc.push_back(yylineno);return(FLOATING_LITERAL); }
({DIGS})({EXP})?({FTS})       			{store_operand(strdup(yytext));sloc.push_back(yylineno);return(FLOATING_LITERAL); }

{DIL}|{HIL}|{OIL}	{/*printf("INTEGER_LITERAL: %s\n",yytext); */
			store_operand(strdup(yytext));sloc.push_back(yylineno);return(INTEGER_LITERAL);}

"true"			{store_operand(strdup(yytext));sloc.push_back(yylineno);return(BOOLEAN_LITERAL);}
"false"			{store_operand(strdup(yytext));sloc.push_back(yylineno);return(BOOLEAN_LITERAL);}
"null"                  {store_operand(strdup(yytext));sloc.push_back(yylineno);return (NULL_LITERAL);}

{JL}({JLD})*            {store_operand(strdup(yytext));sloc.push_back(yylineno);
                        return(IDENTIFIER);
                        }


("'")({CH})("'")	{store_operand(strdup(yytext));sloc.push_back(yylineno);return(CHARACTER_LITERAL);}

("'")({ESC_SEQ})("'")	{store_operand(strdup(yytext));sloc.push_back(yylineno);return(CHARACTER_LITERAL);}

("'")({OCTAL_ESC})("'")	{store_operand(strdup(yytext));sloc.push_back(yylineno);return(CHARACTER_LITERAL);}

("'")({UNICODE_ESC})("'") {store_operand(strdup(yytext));sloc.push_back(yylineno);return(CHARACTER_LITERAL);}
"="			{operators.push_back(ASSIGN);sloc.push_back(yylineno);return(ASSIGN);}
">"			{operators.push_back(GT);sloc.push_back(yylineno);return(GT);}
"<"			{operators.push_back(LT);sloc.push_back(yylineno);return(LT);}
"!"			{operators.push_back(NOT);sloc.push_back(yylineno);return(NOT);}
"~"			{operators.push_back(BIT_NOT);sloc.push_back(yylineno);return(BIT_NOT);}
"?"			{operators.push_back(QUERY);sloc.push_back(yylineno);return(QUERY);}
":"			{operators.push_back(COLON);sloc.push_back(yylineno);return(COLON);}
"=="		{operators.push_back(EQUALITY);sloc.push_back(yylineno);return(EQUALITY);}
"<="		{operators.push_back(LE);sloc.push_back(yylineno);return(LE);}
">="		{operators.push_back(GE);sloc.push_back(yylineno);return(GE);}
"!="		{operators.push_back(NE);sloc.push_back(yylineno);return(NE);}
"&&"		{operators.push_back(AND);sloc.push_back(yylineno);return(AND);}
"||"		{operators.push_back(OR);sloc.push_back(yylineno);return(OR);}
"++"		{operators.push_back(PLUSPLUS);sloc.push_back(yylineno);return(PLUSPLUS);}
"--"		{operators.push_back(MINUSMINUS);sloc.push_back(yylineno);return(MINUSMINUS);}
"+"			{operators.push_back(PLUS);sloc.push_back(yylineno);return(PLUS);}
"-"			{operators.push_back(MINUS);sloc.push_back(yylineno);return(MINUS);}
"*"			{operators.push_back(TIMES);sloc.push_back(yylineno);return(TIMES);}
"/"			{operators.push_back(DIVIDE);sloc.push_back(yylineno);return(DIVIDE);}
"&"			{operators.push_back(BIT_AND);sloc.push_back(yylineno);return(BIT_AND);}
"|"			{operators.push_back(BIT_OR);sloc.push_back(yylineno);return(BIT_OR);}
"^"			{operators.push_back(CARET);sloc.push_back(yylineno);return(CARET);}
"%"			{operators.push_back(MOD);sloc.push_back(yylineno);return(MOD);}
"<<"		{operators.push_back(LEFT_SHIFT);sloc.push_back(yylineno);return(LEFT_SHIFT);}
">>"		{operators.push_back(RIGHT_SHIFT);sloc.push_back(yylineno);return(RIGHT_SHIFT);}
">>>"		{operators.push_back(GTGTGT);sloc.push_back(yylineno);return(GTGTGT);}
"+="		{operators.push_back(PLUSEQUALS);sloc.push_back(yylineno);return(PLUSEQUALS);}
"-="		{operators.push_back(MINUSEQUALS);sloc.push_back(yylineno);return(MINUSEQUALS);}
"*="		{operators.push_back(TIMESEQUALS);sloc.push_back(yylineno);return(TIMESEQUALS);}
"/="		{operators.push_back(DIVEQUALS);sloc.push_back(yylineno);return(DIVEQUALS);}
"&="		{operators.push_back(BIT_ANDEQUALS);sloc.push_back(yylineno);return(BIT_ANDEQUALS);}
"|="		{operators.push_back(BIT_OREQUALS);sloc.push_back(yylineno);return(BIT_OREQUALS);}
"^="		{operators.push_back(CARETEQUALS);sloc.push_back(yylineno);return(CARETEQUALS);}
"%="		{operators.push_back(MODEQUALS);sloc.push_back(yylineno);return(MODEQUALS);}
"<<="		{operators.push_back(LEFT_SHIFTEQUALS);sloc.push_back(yylineno);return(LEFT_SHIFTEQUALS);}
">>="		{operators.push_back(RIGHT_SHIFTEQUALS);sloc.push_back(yylineno);return(RIGHT_SHIFTEQUALS);}
">>>="		{operators.push_back(GTGTGTEQUALS);sloc.push_back(yylineno);return(GTGTGTEQUALS);}
"("			{sloc.push_back(yylineno);return(LEFT_PARENTH);}
")"			{sloc.push_back(yylineno);return(RIGHT_PARENTH);}
"{"			{sloc.push_back(yylineno);return(LEFT_BRACE);}
"}"			{sloc.push_back(yylineno);return(RIGHT_BRACE);}
"["			{sloc.push_back(yylineno);return(LEFT_BRACKET);}
"]"			{sloc.push_back(yylineno);return(RIGHT_BRACKET);}
";"			{sloc.push_back(yylineno); SEMI(); return(SEMICOLON);}
","			{operators.push_back(COMMA);sloc.push_back(yylineno);return(COMMA);}
"."			{operators.push_back(DOT);sloc.push_back(yylineno);return(DOT);}

[ \t\v\f]   { /* ignore whitespace 	   */ }
.           { /* ignore bad characters */ }
"\n"   		{yylineno++;	}

%%

int yywrap() {
        return(1) ;
}

/* ************************************** */

void comment() {

    char c=0;
	int depth=1;

	const int INITIAL_STATE=0;
	const int WAITING_START_OF_COMMENT=1;
	const int WAITING_END_OF_COMMENT=2;
	int state;

	if (yylineno!=last_com_loc) {
	  com_loc++;
	  last_com_loc=yylineno;
	}
	state=INITIAL_STATE;

	while ((depth>0)&&(c!=EOF)) {
	  c=yyinput();
	  if (c=='\n') {
	    last_com_loc=yylineno;
		yylineno++;
		com_loc++;
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
}

/*void traditional_comment() {
  char c, c1 ;

loop:
  while (  ((c = yyinput()) != '*') && (c != 0) && (c!=EOF))

  if (c=='\n') {yylineno++;com_loc++;};

  if (  ((c1 = yyinput()) != '/')  && (c1 != 0) && (c1!=EOF)) {
    unput(c1) ;
    goto loop ;
  }

  if (yylineno!=last_com_loc) {
	com_loc++ ;
	last_com_loc=yylineno ;
  }
}*/

/* ************************************* */

void parse_string_literal() {

  int escaped=0 ;
  char c ;

  yytext[0]='\0' ;

  while (  ((c=yyinput())!='"')&&(c!=0)&&(c!=EOF)) {
    yytext[strlen(yytext)+1]='\0' ;
    yytext[strlen(yytext)]=c ;
    if (c=='\\') {
      c=yyinput() ;
      yytext[strlen(yytext)+1]='\0' ;
      yytext[strlen(yytext)]=c ;
      if ((c==0)||(c==EOF))
        return ;
    }
  }
}

/* ************************************* */

void eol_comment () {
  char c ;

  while (((c=yyinput()) !='\n') && (c!=0) &&(c!=EOF)) ;
  yylineno++ ;
  com_loc++ ;
}
