WORD				[0-9|A-z]+

%{

#include <iostream>
#include <fstream>
#include <vector>
#include <stack>
using namespace std ;

#include <malloc.h>
#include <io.h>

#include <sys/types.h>
#include <sys/stat.h>

#include <fcntl.h>

#include <string.h>

#include "conf.h"
#include "prep.h"

#define ECHO

// Forward declare functions
void handleParenthesis(int type) ;
void outputChar(char, bool=true) ;
void outputString(const char*, bool=true) ;

vector<Replacement*> replace ;

stack<int> states ;
stack<int> indices ;

char* saved = NULL ;
FILE *fout ;
int prepPipe[2] ;

%}

%x  C_COMMENT
%x  CPP_COMMENT

%x  PAREN
%x  DEL


%%

"/*"							{ outputString("/*") ; BEGIN C_COMMENT ; }
"//"							{ outputString("//") ; BEGIN CPP_COMMENT ; }

{WORD}							{ return TOKEN ; }

"\n"							{ outputString("\n") ; }
.								{ outputChar(*yytext) ; }

<C_COMMENT>"*/"					{ outputString("*/") ; BEGIN 0 ; }
<C_COMMENT>\n					{ outputString("\n") ; }
<CPP_COMMENT>\n					{ outputString("\n") ; BEGIN 0 ; }

<PAREN>[ \t\v\f]*"("			{ outputString(replace[indices.top()]->with_start) ; handleParenthesis(replace[indices.top()]->type) ; }
<PAREN>.						{ outputString(saved) ; outputChar(*yytext) ; free(saved) ; BEGIN 0 ; }



%%

int yywrap() {
        return(1);
}

void outputChar(char c, bool check) {
	if (!check || (!states.empty() && states.top()!=IGNORE_SEEK)) {
		fprintf(fout,"%c",c) ;
		fflush(fout) ;
	}
//	if (!check || (!states.empty() && states.top()!=IGNORE_SEEK)) log << c <<flush  ;
}

void outputString(const char*s, bool check) {
	if (!check || (!states.empty() && states.top()!=IGNORE_SEEK)) {
		fprintf(fout,"%s",s) ;
		fflush(fout) ;
	}
//	if (!check || (!states.empty() && states.top()!=IGNORE_SEEK)) log << s <<flush ;
}

void handleParenthesis(int type) {
	int i=1 ;

	char c ;
	while (i) {
		c = yyinput() ;

		switch(c) {
		case '(':
			i++ ;
			break ;
		case ')':
			i-- ;
			break ;
		}

		if (i) outputChar(c) ;
	}

	if (replace[indices.top()]->type != PAREN_IGNORE) outputString(replace[indices.top()]->with_end,false) ; 
	
	states.pop() ; 
	indices.pop() ; 
	
	BEGIN 0 ;
}

void bubbleSort() {
	
	Replacement *temp;
	int size = replace.size() ;
	
	for (int i=0 ; i<size; i++){
		for (int j=0 ; i+j+1<size ; j++) {

			// traverse the nested loops
			if ( strcmp(replace[j]->replace_start,replace[j+1]->replace_start)>0 ) {
				
				// swap current element with next element in the array
				// if the current element is greater

				temp = replace[j];
				replace[j] = replace[j+1];
				replace[j+1] = temp;
			}
		}
	}
}

int indexOfToken() {
	char *c = yytext ;
	//char **i = replace ;

	int i=0 ;
	while (i<replace.size() && *c>*(replace[i]->replace_start)) {
		i++ ;
	}

	if (i<replace.size()) {
		while (i<replace.size() && *c==*(replace[i]->replace_start)) {

			if (!strcmp(c,replace[i]->replace_start)) return i ;

			i++ ;
		}
	}

	return -1 ;
}

int currIndex = -1 ;

void init() {
	// Initialise some vars

	states.push(DEFAULT) ;
	indices.push(-1) ;
}


void verifyToken() {

	int cState = states.top();
	if (cState == IGNORE_SEEK || cState == APPEND_SEEK) {

		char *end = NULL ;
		int type = replace[indices.top()]->type ;

		switch (type) {
		case DELIM_APPEND:
		case DELIM_IGNORE:
			end = _strdup(replace[indices.top()]->replace_end) ;
			break ;
		case PAREN_APPEND:
		case PAREN_IGNORE: 
			end = _strdup(")") ;
			break ;
		}

		if (!strcmp(yytext,end)) {
			outputString(replace[indices.top()]->with_end) ;

			states.pop() ;
			indices.pop() ;
			return ;
		}

		free (end) ;
	}

	int index = indexOfToken() ;

	if (index==-1) {
		outputString(yytext) ;
	} else {
		switch (replace[index]->type) {
		case SIMPLE:
			states.push(DEFAULT) ;
			indices.push(index) ;
			break ;
		case DELIM_APPEND:
			states.push(APPEND_SEEK) ;
			indices.push(index) ;
			break ;
		case DELIM_IGNORE:
			states.push(IGNORE_SEEK) ;
			indices.push(index) ;
			break ;
		case PAREN_APPEND:
			BEGIN PAREN ;
			states.push(APPEND_SEEK) ;
			indices.push(index) ;
			saved = _strdup(yytext) ;
			return ;
		case PAREN_IGNORE:
			BEGIN PAREN ;
			states.push(IGNORE_SEEK) ;
			indices.push(index) ;
			saved = _strdup(yytext) ;
			return ;
		}

		outputString(replace[index]->with_start,false) ;
	}

}

unsigned long _stdcall winThread(void *in) 
{
	int tok = -1 ;
	while ((tok=yylex())>0) {
		if (tok==TOKEN) verifyToken() ;
	}

	fputc(EOF,fout) ;
//	fflush(fout) ;

	return 0 ;
}


Prep::Prep() {
	yytext=(char*)malloc(10240);
}

Prep::Prep(const char *cfgfile) {
	yytext=(char*)malloc(10240);

    loadReplacements(cfgfile,replace) ;
	bubbleSort() ;
}

Prep::~Prep() {
	free (yytext) ;
}


void Prep::loadCfg(const char *cfgfile) {
    loadReplacements(cfgfile,replace) ;
	bubbleSort() ;
}

int Prep::prepFile(const char *inputFile) {
	init() ;

	struct stat buf;
	if (stat(inputFile,&buf)!=0) return NULL ;

	if (_pipe(prepPipe,102400,_O_BINARY|_O_NOINHERIT)==-1) {
		// Error creating pipe
		return NULL ;
	}
	
	fclose(yyin) ;
	fclose(fout) ;

	yyin = fopen(inputFile,"r") ;
	fout = fdopen(prepPipe[1],"w") ;

	DWORD id ;
	CreateThread(NULL,0,winThread,NULL,0,&id) ;

	return prepPipe[0] ;
}

bool Prep::prepFD(int sourceFD, int targetFD) {
	init() ;

	yyin = fdopen(sourceFD,"r") ;
	fout = fdopen(targetFD,"w") ;

	DWORD id ;
	CreateThread(NULL,0,winThread,NULL,0,&id) ;

	return true ;
}

int main(int argc, char *argv[]) {

	Prep p("replace.cfg");
	int fd = p.prepFile("ArgusPerfusionResults.cpp") ;

	FILE *result = fdopen(fd,"r") ;

	char buffer[1024] ;
	while (fgets(buffer,1024,result)) {
		cout << buffer << flush ;
	}

	return 1 ;
}

