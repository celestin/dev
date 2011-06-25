%{

#include <malloc.h>
#include <io.h>

#include <sys/types.h>
#include <sys/stat.h>

#include <fcntl.h>

#include <string.h>

#include <vector>
using namespace std ;

#include "conf.h"

int yyerror(const char*) ;
extern int cfg_lex() ;

vector<Replacement*> *cfg_Replacements ;

%}

%union {
	char *sval ;
}

%token REPLACE PAREN WITH FROM TO LITERAL
%type <sval> LITERAL


%%

statement_list: statement
		| statement_list statement
		;

statement:	REPLACE LITERAL WITH LITERAL ';'	{ cfg_Replacements->push_back(new Replacement($2,$4)) ; }
		|	REPLACE FROM LITERAL TO LITERAL 
			WITH LITERAL TO LITERAL ';'			{ cfg_Replacements->push_back(new Replacement($3,$5,$7,$9)) ; }
		|	REPLACE FROM LITERAL TO LITERAL 
			WITH LITERAL ';'					{ cfg_Replacements->push_back(new Replacement($3,$5,$7,NULL)) ; }
		|	PAREN LITERAL WITH LITERAL ';'		{ cfg_Replacements->push_back(new Replacement($2,$4,NULL)) ; }
		|	PAREN LITERAL WITH 
			LITERAL TO LITERAL';'				{ cfg_Replacements->push_back(new Replacement($2,$4,$6)) ; }
		;

%%

extern FILE *cfg_in ;
FILE *cfg_log ;

bool loadReplacements(const char *filename, vector<Replacement*> &reps) {

	yyerror("in loadReplacements") ;

	struct stat buf ;
	cfg_Replacements = &reps ;

	if (stat(filename,&buf)!=0) 
		return false ;

	cfg_in = fopen(filename,"r") ;

	if (cfg_parse()==1) return false ;

	return true ;
}

int yyerror(const char*msg) {

	if (cfg_log==NULL) {
		cfg_log = fopen("cfg.log","w") ;
	}

	fprintf(cfg_log,"%s\n",msg) ;

	return 1 ;
}

