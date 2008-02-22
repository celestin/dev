LIT				[!-&|(-~]+


%{

#include <iostream>
#include <fstream>
using namespace std ;

#include <malloc.h>
#include <io.h>

#include <sys/types.h>
#include <sys/stat.h>

#include <fcntl.h>

#include <string.h>

#include "conf.h"
#include "prep.h"
#include "conf.tab.h"

#define ECHO

#define INITIAL_STATE 0
#define ESCAPED_STATE 1

void getLiteral() ;
char literal[2048] ;

%}

%%

"#".*\n						{ ; }
"\n"						{ ; }
";"							{ return ';' ; }
"'"							{ getLiteral() ; return LITERAL ; }
"replace"					{ return REPLACE ; }
"replace_parenthesis"		{ return PAREN ; }
"with"						{ return WITH ; }
"to"						{ return TO ; }
"from"						{ return FROM ; }

%%

int yywrap() {
        return(1);
}

void getLiteral() {
    char c=0 ;
	int i=0 ;

	int state=INITIAL_STATE ;
	
	while (c!=EOF) {
		c=yyinput() ;

		switch (c) {
			case '\\':
				state = ESCAPED_STATE ;
				break ;

			case '\'':
				if (state!=ESCAPED_STATE) {
					literal[i++] = '\0' ;
					cfg_lval.sval = _strdup(literal) ;
					return ;
				}

			default:
				state = INITIAL_STATE ;				
				literal[i++] = c ;
				break ;
		}
	}
	return ;
}
