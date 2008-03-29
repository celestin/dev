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

#include "jil.h"
#include "y.tab.h"
#include <stdio.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <string.h>
#include <stdlib.h>
#ifdef WIN32
	#include <io.h>
	#include <malloc.h>
#else
	#include <unistd.h>
#endif
#include "lexical_analysis.h"

int yylex();
extern int yylineno;
//extern FILE *log ;

//extern char yytext[BUFSIZ];
extern char* yytext;

int lex_ceiling=2000;
lexeme* lexemes;
int lex_index;
int n_lexemes;

// *******************************************

int getCurrentLineNumber() {

return lexemes[lex_index-1].line;

}

// *******************************************

void expand_lexeme_storage_array() {

int i;
lexeme* new_lexeme_array;

//printf("EXPAND %d\n",lex_index);

#ifdef WIN32
new_lexeme_array=(lexeme*)malloc(sizeof(lexeme)*(lex_ceiling+2000));
#else
new_lexeme_array=(lexeme*)malloc(sizeof(lexeme[lex_ceiling+2000]));
#endif
lex_ceiling+=2000;

for (i=0;i<=(lex_index-1);i++) {new_lexeme_array[i].symbol=lexemes[i].symbol;new_lexeme_array[i].text=lexemes[i].text;new_lexeme_array[i].line=lexemes[i].line;}
free(lexemes);
lexemes=new_lexeme_array;

}

// *******************************************

void store_lexeme(int symbol,char* text, int line) {

static int c=0;
c++;
if (lex_index==lex_ceiling) expand_lexeme_storage_array();

lexemes[lex_index].symbol=symbol;
lexemes[lex_index].line=line;
lexemes[lex_index++].text=text;

}

// ******************************************

int symbol_is_identifier (int symbol) {

if (symbol==IDENTIFIER) return (0); else return (1);

}

// *******************************************

int lexical_analysis(char* filename) {

int symbol;
int infile;
char c;

lex_index=0;
//	fprintf(log,"marka");
//	fflush(log);

#ifdef WIN32
if ((infile=_open(filename,_O_RDONLY))==-1) {
#else
if ((infile=open(filename,O_RDONLY))==-1) {
#endif
	fprintf(stderr,"CANNOT OPEN FILE: %s\n",filename);
//	fprintf(log,"CANNOT OPEN FILE: %s\n",filename);
//	fflush(log);
  fflush(stderr);                
  exit(0);
}

//	fprintf(log,"markb");
//	fflush(log);

#ifdef WIN32
_dup2(infile,0);
#else
dup2(infile,0);
#endif

//	fprintf(log,"markc");
//	fflush(log);
lexemes=(lexeme*)malloc(sizeof(lexeme[2000]));
//	fprintf(log,"markci");
//	fflush(log);
int i=0;
while ((symbol=yylex())) {
//	fprintf(log,"i: %d\n",i);
	i++ ;
#ifdef WIN32
        store_lexeme(symbol,_strdup(yytext),yylineno);
#else
        store_lexeme(symbol,strdup(yytext),yylineno);
#endif
        //printf("Symbol: %d\n",symbol);
}
//	fprintf(log,"markd");
//	fflush(log);
while ((c=getchar())!=EOF) if (c=='\n') yylineno++;
#ifdef WIN32
_close(infile);
#else
close(infile);
#endif
//	fprintf(log,"marke");
//	fflush(log);
n_lexemes=lex_index;

return 0;
 
}
 
// *******************************************
 

