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

#include "grammar_terminals.h"
#include "grammar_nonterminals.h"
#include "jil.h"
#include "lexical_analysis.h"
#include "modflags.h"
#include <string.h>
#include <stdlib.h>
#include <stdio.h>
#ifndef WIN32
	#include <stl.h>
#else
	#include <iostream>
	#include <stack>
	#include <list>
	#include <vector>
	using namespace std;
#endif
extern lexeme* jil_lexemes;
extern int j_comments,c_comments,cpp_comments,com_loc;
extern int nsemi ;		// Number of Semi-colons

//#include <fstream>
//ofstream logFile("log\\parse.log") ;

struct halstead {
  int N1,N2,n1,n2, nsc ;
};

/*struct control_exec {
		int control,executable;
}*/
class control_exec {
public:
  int control;
  int executable;

  control_exec() : control(0), executable(0) {}
};

bool operator==(const control_exec& x, const control_exec& y){
    return (x.control == y.control) && (x.executable == y.executable);
}

bool operator<(const control_exec& x, const control_exec& y){    
	return x.control < y.control;
}

stack<control_exec*> density;

#define printf dontprintf
void dontprintf(char* s,...) {};

extern int noperands;
extern int lex_index;
extern lexeme* lexemes;

extern int jil_index;

int can_finish;

const int FOUND=0;
const int NOT_FOUND=-1;

extern int yylineno;
extern list<int> sloc;
extern list<int> operators;
extern vector<char*> operands[255];

// ********************************************

int partition(char** a,int l,int r) {

int lp,rp,f;
char* temp;

//printf("PARTITION: %d %d\n",l,r);
// select f as the element to go in the final position
f=r; // select rightmost element
lp=l;rp=r; // initialise left/right pointers

// go until scan pointers cross
while (rp>lp) {
 // printf("1: LP %d RP %d\n",lp,rp);
  while (rp>lp) {
    if (strcmp(a[lp],a[f])>0)
      goto lpdone;
    lp++;
  };
  lpdone:
  while (rp>lp)  {
    if (strcmp(a[rp],a[f])<0)
      goto rpdone;
   rp--;
  };
  rpdone:
  if (lp!=rp) {
    // swap elements
    temp=a[lp];
    a[lp]=a[rp];
    a[rp]=temp;
  };
};

temp=a[lp];
a[lp]=a[f];
a[f]=temp;
//printf("RET\n");
return r;
}

// *******************************************

void quicksort(char** a,int N) {
  int i,l,r;
  stack<int> st;
  l=1;r=N;
  for (;;) {
    while (r>l) {
      i=partition(a,l,r);
      if (i-l>r-i) {
        st.push(l);st.push(i-1);l=i+1;
      } else {
        st.push(i+1);st.push(r);r=i-1;
      };
    }
    if (st.size()==0) break;
    r=st.top();st.pop();l=st.top();st.pop();
  }
}

/* *************************************** */

int get_n_unique_operands(vector<char*> *in) {

unsigned int i;
char** a;
int ret=0;
char* laststring="KRAKATAU_DUMMY_STRING";

a=(char**)malloc(sizeof(char*)*in->size());
for (i=0;i<in->size();i++) 
  a[i]=(*in)[i];
//printf("begin quicksort\n");fflush(0);
quicksort(a,in->size()-1);
//printf("done quicksort\n");fflush(0);
for (i=0;i<in->size();i++) {
  if (strcmp(a[i],laststring)) {
    laststring=a[i];
    ret++;
  };
};

return ret;

};

char* text_from(int,int);
// ********************************************

halstead compute_halstead(int min,int max) {

	halstead ret ;
	int i ;
	list<int> operator_list ;
	vector<char*> operand_vec ;
	ret.nsc=0 ;

	//fprintf(stderr,"compute_halstead for: %s\n",text_from(min,max));
	for (i=min;i<=max;i++) {
	  switch(lexemes[i].symbol) {
		case IDENTIFIER:
		case INTEGER_LITERAL:
		case BOOLEAN_LITERAL:
		case CHARACTER_LITERAL:
		case NULL_LITERAL:
    		operand_vec.push_back(lexemes[i].text);
    		break;
		case COLON:
		case SEMICOLON:
			ret.nsc++ ;
			break ;
		case LEFT_BRACE:
		case RIGHT_BRACE:
    		break;
		default:
    		operator_list.push_back(lexemes[i].symbol);
		break;
	  }
	}
	ret.N1=operator_list.size() ;
	ret.N2=operand_vec.size() ;
	operator_list.sort() ;
	operator_list.unique() ;
	ret.n1=operator_list.size() ;
	ret.n2=get_n_unique_operands(&operand_vec) ;

	return ret ;
}

// ********************************************

char* text_from (int start, int end) {

char* ret,*tmp;
int i;
int sz=1000;int l=0;
ret=(char*)malloc(sz);
ret[0]='\0';

for (i=start;i<=end;i++) {
	l+=strlen(lexemes[i].text);
	if (l>sz) {
	  ret=(char*)realloc(ret,sz*2);
	  sz*=2;
	}
	strcat(ret,lexemes[i].text);
}

tmp=strdup(ret);
free(ret);
return tmp;

}

// ********************************************

int parse_Goal(char* fname) {

lex_index=0;

store_jil_lexeme(ID,strdup(fname));
if (!parse_CompilationUnit()) 
	return (FOUND);
else 
	return (NOT_FOUND);

}

// ********************************************

int parse_Literal() {

if (!parse_INTEGER_LITERAL())  return (FOUND);
if (!parse_FLOATING_LITERAL()) return(FOUND);
if (!parse_BOOLEAN_LITERAL()) return (FOUND);
if (!parse_CHARACTER_LITERAL()) return (FOUND);
if (!parse_STRING_LITERAL()) return (FOUND);
if (!parse_NULL_LITERAL()) return (FOUND);

return (NOT_FOUND);

}

// *******************************************

int parse_DeclType() {
int save_lex_index=lex_index;

if (!parse_DeclReferenceType()) {
 store_jil_lexeme(TYPE,NULL);
 store_jil_lexeme(ID,text_from(save_lex_index,lex_index-1));
 return FOUND;
 }
if (!parse_PrimitiveType()) {
 store_jil_lexeme(TYPE,NULL);
 store_jil_lexeme(ID,text_from(save_lex_index,lex_index-1));
 return FOUND;
 }
return NOT_FOUND;

}

// *******************************************

int parse_Type() {

if (!parse_ReferenceType()) return (FOUND);
if (!parse_PrimitiveType()) return (FOUND);
return (NOT_FOUND);

}

// ********************************************

int parse_PrimitiveType() {

if (!parse_NumericType()) return (FOUND);
if (!parse_BOOLEAN()) return (FOUND);

return (NOT_FOUND);

}

// ********************************************

int parse_NumericType() {

if (!parse_IntegralType()) return (FOUND);
if (!parse_FloatingPointType()) return (FOUND);

return (NOT_FOUND);

}

int parse_IntegralType() {

if (!parse_BYTE()) return (FOUND);
if (!parse_SHORT()) return (FOUND);
if (!parse_INT()) return (FOUND);
if (!parse_LONG()) return (FOUND);
if (!parse_CHAR()) return (FOUND);

return (NOT_FOUND);

}
// ******************************************

int parse_FloatingPointType() {

if (!parse_FLOAT()) return (FOUND);
if (!parse_DOUBLE()) return (FOUND);

return (NOT_FOUND);

}
// ******************************************

int parse_DeclReferenceType() {

if (!parse_DeclArrayType()) return FOUND;
if (!parse_DeclClassOrInterfaceType()) return FOUND;
return NOT_FOUND;

}
// ******************************************

int parse_ReferenceType() {

if (!parse_ArrayType()) return (FOUND);
if (!parse_ClassOrInterfaceType()) return (FOUND);
return (NOT_FOUND);

}
// ******************************************

int parse_ClassOrInterfaceType() {

if (!parse_Name()) return (FOUND);
return (NOT_FOUND);

}
// ******************************************

int parse_DeclClassOrInterfaceType() {

if (!parse_Name()) {
   return FOUND;
};
return NOT_FOUND;

}
// ******************************************

int parse_ClassType() {

if (!parse_ClassOrInterfaceType()) return (FOUND);

return (NOT_FOUND);

}
// ******************************************

int parse_InterfaceType() {

if (!parse_ClassOrInterfaceType()) {
	return (FOUND);
}
return (NOT_FOUND);

}

// ****************************************************

int parse_ArrayType() {

int save_lex_index=lex_index;int save_jil_index=jil_index;

if ((!parse_PrimitiveType())||(!parse_Name())) {
	if (!parse_LEFT_BRACKET()) {
		if (!parse_RIGHT_BRACKET()) {
			save_lex_index=lex_index;save_jil_index=jil_index;
			while (!parse_LEFT_BRACKET()) {
				if (parse_RIGHT_BRACKET()) {
					lex_index=save_lex_index;jil_index=save_jil_index;
					return (FOUND);
				}
				save_lex_index=lex_index;save_jil_index=jil_index;
			}
			lex_index=save_lex_index;jil_index=save_jil_index;
			return (FOUND);
		}
	}
}

lex_index=save_lex_index;jil_index=save_jil_index;
return(NOT_FOUND);

}
// ******************************************


int parse_DeclArrayType() {

int save_lex_index=lex_index;int save_jil_index=jil_index;

if ((!parse_PrimitiveType())||(!parse_Name())) {
	if (!parse_LEFT_BRACKET()) {
		if (!parse_RIGHT_BRACKET()) {
			save_lex_index=lex_index;save_jil_index=jil_index;
			while (!parse_LEFT_BRACKET()) {
				if (parse_RIGHT_BRACKET()) {
					lex_index=save_lex_index;jil_index=save_jil_index;
					return (FOUND);
				}
				save_lex_index=lex_index;save_jil_index=jil_index;
			}
			lex_index=save_lex_index;jil_index=save_jil_index;
			return (FOUND);
		}
	}
}

lex_index=save_lex_index;jil_index=save_jil_index;
return(NOT_FOUND);

}

// ***************************************************

int parse_Name() {

if (!parse_QualifiedName()) return (FOUND);
if (!parse_SimpleName()) return (FOUND);
return (NOT_FOUND);

}

int parse_SimpleName() {

if (!parse_IDENTIFIER()) {return (FOUND);}
return (NOT_FOUND);

}
// ******************************************

int parse_QualifiedName () {

int save_lex_index,save_jil_index;

if (!parse_IDENTIFIER()) {

        save_lex_index=lex_index;save_jil_index=jil_index;

        if (!parse_DOT()) {
                while (!parse_IDENTIFIER()) {
                        save_lex_index=lex_index;save_jil_index=jil_index;
                        if (parse_DOT()) {
                                lex_index=save_lex_index;jil_index=save_jil_index;
                                return (FOUND);
                        }
                }
                lex_index=save_lex_index;jil_index=save_jil_index;
                return (FOUND);
        }

        return (FOUND);

}

return (NOT_FOUND);


}

// ***********************************

int parse_CompilationUnit () {

	int n2=0;
	parse_PackageDeclaration_opt();
	parse_ImportDeclarations_opt();
	store_jil_lexeme(END_UNIT_HEADER,NULL);
	parse_TypeDeclarations_opt();
	store_jil_lexeme(END_UNIT,NULL);

	// Lines of Code
	store_jil_lexeme(LOC,(char*)yylineno);
	// Source Lines of Code
	sloc.sort();  
	sloc.unique();
	store_jil_lexeme(JIL_SLOC,(char*)sloc.size());
	list<int>::iterator iter;
	for ( iter = sloc.begin() ; iter!=sloc.end() ; iter++ ){
		store_jil_lexeme( JIL_SLOC, (char*)(*iter));
	}	
	// Halstead
	store_jil_lexeme(JIL_NSC,(char*)nsemi) ;
	store_jil_lexeme(JIL_N1,(char*)operators.size()) ;
	store_jil_lexeme(JIL_N2,(char*)noperands) ;
	operators.sort();operators.unique() ;
	store_jil_lexeme(JIL_n1,(char*)operators.size()) ;
	for (int i=0;i<255;i++)
	  n2+=operands[i].size() ;
	store_jil_lexeme(JIL_n2,(char*)n2) ;
	// Comments
	store_jil_lexeme(JIL_J_COM,(char*)j_comments);
	store_jil_lexeme(JIL_C_COM,(char*)c_comments);
	store_jil_lexeme(JIL_CPP_COM,(char*)cpp_comments);
	store_jil_lexeme(JIL_COM_LOC,(char*)com_loc);
	return (FOUND);

}

// ***********************************

int parse_ImportDeclarations() {

if (!parse_ImportDeclaration()) {
	while(!parse_ImportDeclaration()) ;
	return (FOUND);
}
return (NOT_FOUND);

}

// ******************************************


void parse_ImportDeclarations_opt() {

(void) parse_ImportDeclarations();

}

// ******************************************


int parse_TypeDeclarations() {

if (!parse_TypeDeclaration()) {
	while (!parse_TypeDeclaration()) ;
	return (FOUND);
}

return (NOT_FOUND);

}

// ******************************************


void parse_TypeDeclarations_opt() {

(void) parse_TypeDeclarations();

}

// ******************************************


int parse_PackageDeclaration() {

int save_lex_index=lex_index;int save_jil_index=jil_index;


if (!parse_PACKAGE())
	if (!parse_Name()) {
	        store_jil_lexeme(ID,text_from(save_lex_index+1,lex_index-1));
		if (!parse_SEMICOLON()) {
			return (FOUND);
			}
	}
lex_index=save_lex_index;jil_index=save_jil_index;

return (NOT_FOUND);

}

// ******************************************


void parse_PackageDeclaration_opt () {
	(void)parse_PackageDeclaration();
}

// ******************************************


int parse_ImportDeclaration () {

if (!parse_SingleTypeImportDeclaration()) return(FOUND);
if (!parse_TypeImportOnDemandDeclaration()) return (FOUND);
return (NOT_FOUND);

}

// ******************************************


int parse_SingleTypeImportDeclaration() {

int save_lex_index=lex_index;int save_jil_index=jil_index;

if (!parse_IMPORT()) {
	store_jil_lexeme(JIL_IMPORT,NULL);
	if (!parse_Name()) {
		store_jil_lexeme(ID,text_from(save_lex_index+1,lex_index-1));
		if (!parse_SEMICOLON())
			return (FOUND);
	}
}
lex_index=save_lex_index;jil_index=save_jil_index;
return (NOT_FOUND);

}

// ******************************************


int parse_TypeImportOnDemandDeclaration() {

int save_lex_index=lex_index;int save_jil_index=jil_index;
if (!parse_IMPORT()) {
	store_jil_lexeme(JIL_IMPORT,NULL);
	if (!parse_Name()) 
		if (!parse_DOT())
			if (!parse_TIMES()) {
				store_jil_lexeme(ID,text_from(save_lex_index+1,lex_index-1));
				if (!parse_SEMICOLON()) 
					return (FOUND);
			}
}
lex_index=save_lex_index;jil_index=save_jil_index;
return (NOT_FOUND);

}

// ******************************************


int parse_TypeDeclaration() {

if (!parse_InterfaceDeclaration()) return (FOUND);
if (!parse_ClassDeclaration()) return (FOUND);
if (!parse_InterfaceDeclaration()) return (FOUND);
if (!parse_SEMICOLON()) return (FOUND);

return (NOT_FOUND);

}

// ******************************************


int parse_Modifiers() {

if (!parse_Modifier()) {
	while (!parse_Modifier()) ;
	return (FOUND);
}

return (NOT_FOUND);

}

// ******************************************

void parse_Modifiers_opt () {

(void) parse_Modifiers();

}
// ******************************************

int parse_Gregarious_Modifiers_opt() {

int protection=JIL_PACKAGE;
int flags=0;
int keepgoing=1;

while (keepgoing==1) {
	if (!parse_PUBLIC()) protection=JIL_PUBLIC;
	else if (!parse_PROTECTED()) {
		if (protection==JIL_PRIVATE) protection=JIL_PRIVATE_PROTECTED;
		else protection=JIL_PROTECTED;
		}
	else if (!parse_PRIVATE()) protection=JIL_PRIVATE;

	else if (!parse_STATIC()) flags|=FLAG_STATIC;		// Set one bit flag
	else if (!parse_ABSTRACT()) flags|=FLAG_ABSTRACT;	// for each potential
	else if (!parse_FINAL()) flags|=FLAG_FINAL;		// modifier
	else if (!parse_NATIVE()) flags|=FLAG_NATIVE;
	else if (!parse_SYNCHRONIZED()) flags|=FLAG_SYNCHRONIZED;
	else if (!parse_TRANSIENT()) flags|=FLAG_TRANSIENT;
	else if (!parse_VOLATILE()) flags|=FLAG_VOLATILE;
	else keepgoing=0;
}
return ((flags<<8)+protection);	// Combine both data items for passing back

}
// ******************************************

int parse_Modifier() {

if (!parse_PUBLIC()) return (FOUND);
if (!parse_PROTECTED()) return (FOUND);
if (!parse_PRIVATE()) return (FOUND);
if (!parse_STATIC()) return (FOUND);
if (!parse_ABSTRACT()) return (FOUND);
if (!parse_FINAL()) return (FOUND);
if (!parse_NATIVE()) return (FOUND);
if (!parse_SYNCHRONIZED()) return (FOUND);
if (!parse_TRANSIENT()) return (FOUND);
if (!parse_VOLATILE()) return (FOUND);
return (NOT_FOUND);

} 
// ******************************************

int parse_ClassDeclaration() {

int save_lex_index=lex_index;int save_jil_index=jil_index;
int protection,modifiers;
int startline=0,endline=0;

protection=parse_Gregarious_Modifiers_opt();	// Return is combination of modifiers and protection level
modifiers=(protection>>8);			// Split modifiers
protection=protection&((1<<8)-1);		// Split real protection level

if (!parse_CLASS()) {
	startline=getCurrentLineNumber();
	store_jil_lexeme(JIL_CLASS,(char*)startline);
	fflush(stdout);
	store_jil_lexeme(protection,NULL);
	store_jil_lexeme(MODS,(char*)modifiers);
	if (!parse_IDENTIFIER()) {
		store_jil_lexeme(ID,lexemes[lex_index-1].text);
		parse_Super_opt();
		parse_Interfaces_opt();
		if (!parse_ClassBody()) {
			store_jil_lexeme(END_BODY,NULL);
			endline=getCurrentLineNumber();
			store_jil_lexeme(LOC,(char*)(endline-startline+1));
			return (FOUND);
		}
	}
}
lex_index=save_lex_index;jil_index=save_jil_index;
return (NOT_FOUND);

}

// ******************************************

int parse_Super() {

int save_lex_index=lex_index;int save_jil_index=jil_index;
int save_classtype;

if (!parse_EXTENDS()) {
	store_jil_lexeme(INHERITS,NULL);
	save_classtype=lex_index;
	if (!parse_ClassType())  {
		//store_jil_lexeme(ID,lexemes[lex_index-1].text);
		// changed to get the whole extended class 23/4/99 GS
		store_jil_lexeme(ID,text_from(save_classtype,lex_index-1));
		return (FOUND);
	}
}

lex_index=save_lex_index;jil_index=save_jil_index;

return (NOT_FOUND);

}

// ******************************************


void parse_Super_opt () {

(void) parse_Super();

}

// ******************************************


int parse_Interfaces() {

int save_lex_index=lex_index;int save_jil_index=jil_index;

if (!parse_IMPLEMENTS()) {
	store_jil_lexeme(JIL_IMPLEMENTS,NULL);
	if (!parse_InterfaceTypeList()) {
		store_jil_lexeme(END_IMPLEMENTS,NULL);
		return (FOUND);
	}
}
lex_index=save_lex_index;jil_index=save_jil_index;

return (NOT_FOUND);

}


void parse_Interfaces_opt () {

(void)parse_Interfaces();

}



int parse_InterfaceTypeList() {

int save_lex_index=lex_index;
int save_jil_index=jil_index;

if (!parse_InterfaceType()) {
        store_jil_lexeme(ID,text_from(save_lex_index,lex_index-1));
	save_lex_index=lex_index;save_jil_index=jil_index;
	if (!parse_COMMA()) {
		while (!parse_InterfaceType()) {
	                store_jil_lexeme(ID,text_from(save_lex_index+1,lex_index-1));
			save_lex_index=lex_index;save_jil_index=jil_index;
			if (parse_COMMA()) {
				lex_index=save_lex_index;jil_index=save_jil_index;
				return (FOUND);
			}	
		}
		lex_index=save_lex_index;jil_index=save_jil_index;
		return (FOUND);		
	}
	return (FOUND);

}
return (NOT_FOUND);

}



int parse_ClassBody () {

int save_lex_index=lex_index;int save_jil_index=jil_index;

if (!parse_LEFT_BRACE()) {
	parse_ClassBodyDeclarations_opt();
	if (!parse_RIGHT_BRACE()) {
	//	printf("GOT A CLASS BODY: %s\n",text_from(save_lex_index,lex_index-1));
		return (FOUND);
	}
}

lex_index=save_lex_index;jil_index=save_jil_index;

return (NOT_FOUND);

}

void parse_ClassBody_opt () {

int save_jil_index=jil_index;
int startline,endline;

startline=getCurrentLineNumber();
store_jil_lexeme(JIL_CLASS,(char*)startline);
store_jil_lexeme(JIL_PUBLIC,NULL);
store_jil_lexeme(ID,"anon");


if (!parse_ClassBody()) {
  endline=getCurrentLineNumber();
  store_jil_lexeme(END_BODY,NULL);
  store_jil_lexeme(LOC,(char*)(endline-startline+1));
  return;
} else {

jil_index=save_jil_index;

}

return;

}

int parse_ClassBodyDeclarations () {
if (!parse_ClassBodyDeclaration()) {
	while (!parse_ClassBodyDeclaration()) ;
	return (FOUND);
}
return (NOT_FOUND);

}


void parse_ClassBodyDeclarations_opt () {

(void) parse_ClassBodyDeclarations ();

}



int parse_ClassBodyDeclaration () {

int save_lex_index=lex_index;
// 1.1 support
// inner classes
if (!parse_ClassDeclaration()) return FOUND;
// inner interface classes
if (!parse_InterfaceDeclaration()) return FOUND;
// instance initializers
if (!parse_Block()) return FOUND;

if (!parse_ClassMemberDeclaration()) {
 //  printf("GOT ClassMemberDeclaration: %s\n",text_from(save_lex_index,lex_index-1));
   return FOUND;
}
if (!parse_StaticInitializer()) return FOUND;
if (!parse_ConstructorDeclaration()) return FOUND;

return NOT_FOUND;

}



int parse_ClassMemberDeclaration () {
int save_lex_index=lex_index;
if (!parse_FieldDeclaration()) return (FOUND);
if (!parse_MethodDeclaration()) {
//printf("\nGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGG\n");
 return (FOUND);
}
if (!parse_SEMICOLON()) return FOUND;
return (NOT_FOUND);

}

// *****************************************

int parse_FieldDeclaration () {

int save_lex_index=lex_index;int save_jil_index=jil_index;

int protection=0,modifiers;

store_jil_lexeme(FIELD,NULL);
protection=parse_Gregarious_Modifiers_opt();// Return is combination of modifiers and protection level
modifiers=(protection>>8);		    // Split modifiers
protection=protection&((1<<8)-1);	    // Split real protection level

store_jil_lexeme(protection,NULL);
store_jil_lexeme(MODS,(char*)modifiers);
if (!parse_DeclType()) {
	if (!parse_VariableDeclarators())
		if (!parse_SEMICOLON()) 
			return (FOUND);
}
lex_index=save_lex_index;jil_index=save_jil_index;

return (NOT_FOUND);

}

// *****************************************

int parse_VariableDeclarators () {

int save_lex_index=lex_index;int save_jil_index=jil_index;

if (!parse_VariableDeclarator()) {

        save_lex_index=lex_index;save_jil_index=jil_index;

        if (!parse_COMMA()) {
                while (!parse_VariableDeclarator()) {
                        save_lex_index=lex_index;save_jil_index=jil_index;
                        if (parse_COMMA()) {
                                lex_index=save_lex_index;jil_index=save_jil_index;
                                return (FOUND);
                        }
                }
                lex_index=save_lex_index;jil_index=save_jil_index;
                return (FOUND);
        }
	lex_index=save_lex_index;jil_index=save_jil_index;
        return (FOUND);

}
lex_index=save_lex_index;jil_index=save_jil_index;
return (NOT_FOUND);

}

// ***************************************

int parse_VariableDeclarator () {

int save_lex_index=lex_index;int save_jil_index=jil_index;

if (!parse_VariableDeclaratorId()) {
	save_lex_index=lex_index;save_jil_index=jil_index;
	if (!parse_ASSIGN())
		if (!parse_VariableInitializer())
			return (FOUND);

	lex_index=save_lex_index;jil_index=save_jil_index;
	return (FOUND);
}

return (NOT_FOUND);

}

// ***************************************

int parse_VariableDeclaratorId () {

int save_lex_index=lex_index;int save_jil_index=jil_index;
int tmp;
if (!parse_IDENTIFIER()) {
        store_jil_lexeme(ID,lexemes[lex_index-1].text);
	save_lex_index=lex_index;save_jil_index=jil_index;
	tmp=lex_index;
	while (!parse_LEFT_BRACKET()) {
		if (parse_RIGHT_BRACKET()) {
			lex_index=save_lex_index;jil_index=save_jil_index;
			return (FOUND);
		}
		save_lex_index=lex_index;save_jil_index=jil_index;
	}
	lex_index=save_lex_index;jil_index=save_jil_index;
	if (lex_index>tmp) {
	  store_jil_lexeme(ETYPE,NULL);
	  store_jil_lexeme(ID,text_from(tmp,lex_index-1));//text_from(save_lex_index,lex_index-1));
	}
	return (FOUND);
}

lex_index=save_lex_index;jil_index=save_jil_index;
return (NOT_FOUND);

}

// ******************************************


int parse_VariableInitializer () {

if (!parse_Expression()) return (FOUND);
if (!parse_ArrayInitializer()) return (FOUND);

return (NOT_FOUND);

}

// ******************************************


int parse_MethodDeclaration () {

int save_lex_index=lex_index;int save_jil_index=jil_index;
int startline=0,endline=0;
halstead h;
int tmp;
control_exec* current_density;

store_jil_lexeme(METHOD,NULL);
if (!parse_MethodHeader()) {
	startline=getCurrentLineNumber();
	jil_lexemes[save_jil_index].text=(char*)startline;
	tmp=lex_index;
	current_density=new control_exec;
	current_density->control=0;
	current_density->executable=0;
	density.push(current_density);
	if (!parse_MethodBody()) {
	
	//	printf("GOT A WHOLE METHOD: %s\n",text_from(save_lex_index,lex_index-1));
		
		store_jil_lexeme(END_BODY,NULL) ;
		endline=getCurrentLineNumber() ;
		store_jil_lexeme(LOC,(char*)(endline-startline+1)) ;
		h=compute_halstead(tmp,lex_index) ;
		store_jil_lexeme(JIL_NSC,(char*)h.nsc) ;
		store_jil_lexeme(JIL_N1,(char*)h.N1) ;
		store_jil_lexeme(JIL_N2,(char*)h.N2) ;
		store_jil_lexeme(JIL_n1,(char*)h.n1) ;
		store_jil_lexeme(JIL_n2,(char*)h.n2) ;
		store_jil_lexeme(JIL_CTRL,(char*)density.top()->control) ;
		store_jil_lexeme(JIL_EXEC,(char*)density.top()->executable) ;
		density.pop();
	//	printf("RETURNING: %d\n",FOUND);
		return (FOUND);
	}
	density.pop();
}
lex_index=save_lex_index;jil_index=save_jil_index;
return (NOT_FOUND);

}

// ******************************************

int parse_MethodHeader () {

int save_lex_index=lex_index;int save_jil_index=jil_index;
int protection=0,modifiers;

protection=parse_Gregarious_Modifiers_opt();	// Return is combination of modifiers and protection level
modifiers=(protection>>8);			// Split modifiers
protection=protection&((1<<8)-1);		// Split real protection level

/*if (protection!=0) */
store_jil_lexeme(protection,NULL);
store_jil_lexeme(MODS,(char*)modifiers);
if (!parse_DeclType()) {
	if (!parse_MethodDeclarator()) {
		parse_Throws_opt();
		return (FOUND);
	}
}

lex_index=save_lex_index;jil_index=save_jil_index;
parse_Modifiers_opt();
if (!parse_VOID()) {
        if (!parse_MethodDeclarator()) {
                parse_Throws_opt();
                return (FOUND);
        }
}

lex_index=save_lex_index;jil_index=save_jil_index;
parse_Modifiers_opt();
if (!parse_MethodDeclarator()) {
  parse_Throws_opt();
  return FOUND;
}
lex_index=save_lex_index;jil_index=save_jil_index;
return (NOT_FOUND);

}

// ******************************************


int parse_MethodDeclarator () {

int save_lex_index=lex_index;int save_jil_index=jil_index;

if (!parse_IDENTIFIER()) {
	store_jil_lexeme(ID,lexemes[lex_index-1].text);
	if (!parse_LEFT_PARENTH()) {
		parse_FormalParameterList_opt();
		if (!parse_RIGHT_PARENTH()) {
			save_lex_index=lex_index;save_jil_index=jil_index;
			while (!parse_LEFT_BRACKET()) {
				if (parse_RIGHT_BRACKET()) {
					lex_index=save_lex_index;jil_index=save_jil_index;
					return (FOUND);
				}
			        save_lex_index=lex_index;save_jil_index=jil_index;
			}
			lex_index=save_lex_index;jil_index=save_jil_index;
			return(FOUND);
		}	
			
	}
}	
lex_index=save_lex_index;jil_index=save_jil_index;

return (NOT_FOUND);

}

// ******************************************


int parse_FormalParameterList () {

int save_lex_index,save_jil_index;

if (!parse_FormalParameter()) {

        save_lex_index=lex_index;save_jil_index=jil_index;

        if (!parse_COMMA()) {
                while (!parse_FormalParameter()) {
                        save_lex_index=lex_index;save_jil_index=jil_index;
                        if (parse_COMMA()) {
                                lex_index=save_lex_index;jil_index=save_jil_index;
				store_jil_lexeme(END_PARAMS,NULL);
                                return (FOUND);
                        }
                }
                lex_index=save_lex_index;jil_index=save_jil_index;
		store_jil_lexeme(END_PARAMS,NULL);
                return (FOUND);
        } 
	store_jil_lexeme(END_PARAMS,NULL); 
        return (FOUND);
 
}
store_jil_lexeme(END_PARAMS,NULL); 
return (NOT_FOUND);
 
}

// ******************************************


void parse_FormalParameterList_opt () {

(void) parse_FormalParameterList();

}

// ******************************************


int parse_FormalParameter () {

int save_lex_index=lex_index;int save_jil_index=jil_index;

// optional 'FINAL' for Java 1.1 support
parse_Modifiers_opt() ;

if (!parse_DeclType()) {
	//store_jil_lexeme(TYPE,NULL);
    //store_jil_lexeme(ID,lexemes[lex_index-1].text);
	if (!parse_VariableDeclaratorId())
		return (FOUND);
}
lex_index=save_lex_index;jil_index=save_jil_index;

return (NOT_FOUND);

}

// ******************************************


int parse_Throws () {

int save_lex_index=lex_index;int save_jil_index=jil_index;

if (!parse_THROWS())
	if (!parse_ClassTypeList())
		return (FOUND);

lex_index=save_lex_index;jil_index=save_jil_index;

return (NOT_FOUND);

}
// ******************************************


void parse_Throws_opt () {

(void) parse_Throws ();

}

// ******************************************


int parse_ClassTypeList () {

int save_lex_index,save_jil_index;
 
if (!parse_ClassType()) {
 
        save_lex_index=lex_index;save_jil_index=jil_index; 
 
        if (!parse_COMMA()) { 
                while (!parse_ClassType()) {
                        save_lex_index=lex_index;save_jil_index=jil_index; 
                        if (parse_COMMA()) { 
                                lex_index=save_lex_index;jil_index=save_jil_index; 
                                return (FOUND); 
                        } 
                } 
                lex_index=save_lex_index;jil_index=save_jil_index; 
                return (FOUND); 
        }  
  
        return (FOUND);  
  
} 
  
return (NOT_FOUND); 
  
} 

// ******************************************


int parse_MethodBody () {

if (!parse_Block()) return (FOUND);
if (!parse_SEMICOLON()) return (FOUND);
return (NOT_FOUND);

}

// ******************************************


int parse_StaticInitializer () {

int save_lex_index=lex_index;int save_jil_index=jil_index;

if (!parse_STATIC())
	if (!parse_Block()) 
		return (FOUND);

lex_index=save_lex_index;jil_index=save_jil_index;

return (NOT_FOUND);

}

// ******************************************


int parse_ConstructorDeclaration () {

int save_lex_index=lex_index;int save_jil_index=jil_index;
int startline,endline;
int protection=0,modifiers;
int tmp;
halstead h;
int tmp_jil_index;

protection=parse_Gregarious_Modifiers_opt();	// Return is combination of modifiers and protection level
modifiers=(protection>>8);						// Split modifiers
protection=protection&((1<<8)-1);				// Split real protection level

tmp_jil_index=jil_index;
store_jil_lexeme(METHOD,NULL);

/*if (protection!=0)*/ store_jil_lexeme(protection,NULL);
store_jil_lexeme(MODS,(char*)modifiers);
startline=getCurrentLineNumber();
jil_lexemes[tmp_jil_index].text=(char*)startline;
if (!parse_ConstructorDeclarator()) {
	parse_Throws_opt ();
	tmp=lex_index;
	if (!parse_ConstructorBody()) {
		store_jil_lexeme(END_BODY,NULL);
		endline=getCurrentLineNumber();
		h=compute_halstead(tmp,lex_index);
		store_jil_lexeme(LOC,(char*)(endline-startline+1));
		store_jil_lexeme(JIL_NSC,(char*)h.nsc) ;
		store_jil_lexeme(JIL_N1,(char*)h.N1);
		store_jil_lexeme(JIL_N2,(char*)h.N2);
		store_jil_lexeme(JIL_n1,(char*)h.n1);
		store_jil_lexeme(JIL_n2,(char*)h.n2);
		return (FOUND);
	}
}

lex_index=save_lex_index;jil_index=save_jil_index;

return (NOT_FOUND);

}

// ******************************************


int parse_ConstructorDeclarator () {

int save_lex_index=lex_index;int save_jil_index=jil_index;

if (!parse_SimpleName()) {
        store_jil_lexeme(ID,lexemes[lex_index-1].text);
	if (!parse_LEFT_PARENTH()) {
		parse_FormalParameterList_opt();
		if (!parse_RIGHT_PARENTH())
			return (FOUND);
	}
}	

lex_index=save_lex_index;jil_index=save_jil_index;

return (NOT_FOUND);

}

// ******************************************


int parse_ConstructorBody () {

int save_lex_index=lex_index;int save_jil_index=jil_index;

if (!parse_LEFT_BRACE()) {
	parse_ExplicitConstructorInvocation_opt();
	parse_BlockStatements_opt();
	if (!parse_RIGHT_BRACE())
		return (FOUND);
}

lex_index=save_lex_index;jil_index=save_jil_index;

return (NOT_FOUND);

}

// ******************************************


int parse_ExplicitConstructorInvocation () {

int save_lex_index=lex_index;int save_jil_index=jil_index;

if (!parse_THIS()) {
	if (!parse_LEFT_PARENTH()) {
		parse_ArgumentList_opt();
		if (!parse_RIGHT_PARENTH())
			if (!parse_SEMICOLON())
				return (FOUND);
	}	
	lex_index=save_lex_index;jil_index=save_jil_index;
	return (NOT_FOUND);	
}
if (!parse_SUPER()) {
	if (!parse_LEFT_PARENTH()) {   
                parse_ArgumentList_opt();
                if (!parse_RIGHT_PARENTH())
                        if (!parse_SEMICOLON())
                                return (FOUND); 
        }        
        lex_index=save_lex_index;jil_index=save_jil_index;        
        return (NOT_FOUND);
}	

return (NOT_FOUND);

}
// ******************************************


void parse_ExplicitConstructorInvocation_opt () {

(void) parse_ExplicitConstructorInvocation();

}
// ******************************************



int parse_InterfaceDeclaration () {

int save_lex_index=lex_index;int save_jil_index=jil_index;
int protection,modifiers;
int startline=0,endline=0;

protection=parse_Gregarious_Modifiers_opt();	// Return is combination of modifiers and protection level
modifiers=(protection>>8);						// Split modifiers
protection=protection&((1<<8)-1);				// Split real protection level

if (!parse_INTERFACE()) {
	startline=getCurrentLineNumber();
	store_jil_lexeme(JIL_INTERFACE,(char*)startline);
        if (protection!=0) store_jil_lexeme(protection,NULL);
		store_jil_lexeme(MODS,(char*)modifiers);
	if (!parse_IDENTIFIER()) {
		store_jil_lexeme(ID,lexemes[lex_index-1].text);
		parse_ExtendsInterfaces_opt();
		if (!parse_InterfaceBody()) {
			store_jil_lexeme(END_BODY,NULL);
			endline=getCurrentLineNumber();
			store_jil_lexeme(LOC,(char*)(endline-startline+1));
			return (FOUND);
		}
	}
}

lex_index=save_lex_index;jil_index=save_jil_index;
return (NOT_FOUND);

}

// ******************************************


int parse_ExtendsInterfaces () {

int save_lex_index=lex_index;int save_jil_index=jil_index;

if (!parse_EXTENDS()) {
	store_jil_lexeme(JIL_EXTENDS,NULL);
	if (!parse_InterfaceType()) {
		store_jil_lexeme(ID,text_from(save_lex_index+1,lex_index-1));
		save_lex_index=lex_index;save_jil_index=jil_index;
		if (!parse_COMMA()) 
		while (!parse_InterfaceType()) {
	                store_jil_lexeme(ID,text_from(save_lex_index+1,lex_index-1));
			save_lex_index=lex_index;save_jil_index=jil_index;
			if (parse_COMMA()) {
				lex_index=save_lex_index;jil_index=save_jil_index;
				store_jil_lexeme(END_EXTENDS,NULL);
				return (FOUND);
			}
		}
		lex_index=save_lex_index;jil_index=save_jil_index;
		store_jil_lexeme(END_EXTENDS,NULL);
		return (FOUND);
	}
}
lex_index=save_lex_index;jil_index=save_jil_index;
store_jil_lexeme(END_EXTENDS,NULL);
return (NOT_FOUND);

}
// ******************************************


void parse_ExtendsInterfaces_opt () {

(void) parse_ExtendsInterfaces();

}

// ******************************************


int parse_InterfaceBody() {

int save_lex_index=lex_index;int save_jil_index=jil_index;

if (!parse_LEFT_BRACE()) {
	parse_InterfaceMemberDeclarations_opt();
	if (!parse_RIGHT_BRACE())
		return (FOUND);
}

lex_index=save_lex_index;jil_index=save_jil_index;

return (NOT_FOUND);

}

// ******************************************


int parse_InterfaceMemberDeclarations () {

if (!parse_InterfaceMemberDeclaration()) {
	while (!parse_InterfaceMemberDeclaration()) ;
	return (FOUND);
}

return (NOT_FOUND);

}
// ******************************************


void parse_InterfaceMemberDeclarations_opt () {

(void) parse_InterfaceMemberDeclarations();

}

// ******************************************


int parse_InterfaceMemberDeclaration () {

if (!parse_ConstantDeclaration()) return (FOUND);
if (!parse_AbstractMethodDeclaration()) return (FOUND);

return (NOT_FOUND);

}

// ******************************************


int parse_ConstantDeclaration () {

if (!parse_FieldDeclaration()) return (FOUND);

return (NOT_FOUND);

}

// ******************************************


int parse_AbstractMethodDeclaration () {

int save_lex_index=lex_index;int save_jil_index=jil_index;

store_jil_lexeme(METHOD,(char*)(getCurrentLineNumber()));
if (!parse_MethodHeader())
	if (!parse_SEMICOLON()) {
		store_jil_lexeme(END_BODY,NULL);
		store_jil_lexeme(JIL_N1,0);
		store_jil_lexeme(JIL_N2,0);
		store_jil_lexeme(JIL_n1,0);
		store_jil_lexeme(JIL_n2,0);
		return (FOUND);
	}
lex_index=save_lex_index;jil_index=save_jil_index;

return (NOT_FOUND);

}

// ******************************************


int parse_ArrayInitializer () {

int save_lex_index=lex_index;int save_jil_index=jil_index;

// add 1.1 support
if (!parse_NEW())
  if (!parse_PrimitiveType())
    if (!parse_Dims())
      if (!parse_LEFT_BRACE()) {
        parse_VariableInitializers_opt();
	parse_COMMA_opt();
	if (!parse_RIGHT_BRACE())
	  return FOUND;
      }
lex_index=save_lex_index;jil_index=save_jil_index;
if (!parse_NEW())
  if (!parse_ClassOrInterfaceType())
    if (!parse_Dims())
      if (!parse_LEFT_BRACE()) {
        parse_VariableInitializers_opt();
	parse_COMMA_opt();
	if (!parse_RIGHT_BRACE())
	  return FOUND;
      }
// end 1.1 support
lex_index=save_lex_index;jil_index=save_jil_index;
if (!parse_LEFT_BRACE()) {
	parse_VariableInitializers_opt();
	parse_COMMA_opt();
	if (!parse_RIGHT_BRACE()) 
		return (FOUND);
}

lex_index=save_lex_index;jil_index=save_jil_index;

return (NOT_FOUND);

}

// ******************************************

int parse_VariableInitializers () {

int save_lex_index,save_jil_index;

if (!parse_VariableInitializer()) {

        save_lex_index=lex_index;save_jil_index=jil_index;

        if (!parse_COMMA()) {
                while (!parse_VariableInitializer()) {
                        save_lex_index=lex_index;save_jil_index=jil_index;
                        if (parse_COMMA()) {
                                lex_index=save_lex_index;jil_index=save_jil_index;
                                return (FOUND);
                        }
                }
                lex_index=save_lex_index;jil_index=save_jil_index;
                return (FOUND);
        } 

        return (FOUND);
 
}
 
return (NOT_FOUND);
 
}

// ******************************************


void parse_VariableInitializers_opt () {

(void) parse_VariableInitializers();

}

// *******************************************

int parse_Block () {

int save_lex_index=lex_index;int save_jil_index=jil_index;

if (!parse_LEFT_BRACE()) {
	parse_BlockStatements_opt ();
	if (!parse_RIGHT_BRACE()) {
	//	printf("GOT A BLOCK: %s\n",text_from(save_lex_index,lex_index-1));
		return (FOUND);
	}

}

lex_index=save_lex_index;jil_index=save_jil_index;

return (NOT_FOUND);

}

// *******************************************

int parse_BlockStatements () {

if (!parse_BlockStatement()) {
	while (!parse_BlockStatement()) ;
	return (FOUND);
}

return (NOT_FOUND);

}

// *******************************************

void parse_BlockStatements_opt () {

(void) parse_BlockStatements();

}

// *******************************************

int parse_BlockStatement() {

int save_executable,save_control;

if (!parse_LocalVariableDeclarationStatement()) return (FOUND);
if (!density.empty()) {
  save_executable=density.top()->executable;
  save_control=density.top()->control;
}
if (!parse_Statement()) return (FOUND);
if (!density.empty()) {
  density.top()->executable=save_executable;
  density.top()->control=save_control;
}
return (NOT_FOUND);
}

// ******************************************

int parse_LocalVariableDeclarationStatement () {

int save_lex_index=lex_index;int save_jil_index=jil_index;


// 1.1 support (local class)
if (!parse_ClassDeclaration()) return FOUND;

if (!parse_LocalVariableDeclaration())
	if (!parse_SEMICOLON()) 
		return (FOUND);

lex_index=save_lex_index;jil_index=save_jil_index;

return (NOT_FOUND);

}


// *****************************************

int parse_LocalVariableDeclaration () {

int save_lex_index=lex_index;int save_jil_index=jil_index;

store_jil_lexeme(LOCAL,NULL);
parse_Modifiers_opt();
if (!parse_DeclType()) {
	if (!parse_VariableDeclarators())
	  return (FOUND);

}

lex_index=save_lex_index;jil_index=save_jil_index;
return (NOT_FOUND);

}

// ***********************************************************

int parse_Statement () {
int old=lex_index;
int save_control;
int save_executable;

if (!parse_LabeledStatement()) 		{if (!density.empty()) density.top()->executable++;return (FOUND);}
if (!parse_IfThenElseStatement()) 	{if (!density.empty()) density.top()->control++;   return (FOUND);}
if (!parse_IfThenStatement()) 		{if (!density.empty()) density.top()->control++;   return (FOUND);}
if (!parse_WhileStatement()) 		{if (!density.empty()) density.top()->control++;   return (FOUND);}
if (!parse_ForStatement()) 		{if (!density.empty()) density.top()->control++;   return (FOUND);}
if (!density.empty()) {
  save_control=density.top()->control; 
  save_executable=density.top()->executable;
}
if (!parse_StatementWithoutTrailingSubstatement()) {return (FOUND);};
if (!density.empty()) {
  density.top()->control=save_control;
  density.top()->executable=save_executable;
}
return (NOT_FOUND);

}

// **********************************************************

int parse_StatementNoShortIf () {

int save_control,save_executable;
if (!density.empty()) {
 save_control=density.top()->control;
 save_executable=density.top()->executable;
}
if (!parse_StatementWithoutTrailingSubstatement()) 	{return (FOUND);};
if (!density.empty()) {
  density.top()->control=save_control;
  density.top()->executable=save_executable;
}
if (!parse_LabeledStatementNoShortIf()) 		{if (!density.empty()) density.top()->executable++;return (FOUND);}
if (!parse_IfThenElseStatementNoShortIf()) 		{if (!density.empty()) density.top()->control++;return (FOUND);}
if (!parse_WhileStatementNoShortIf()) 			{if (!density.empty()) density.top()->control++;return (FOUND);}
if (!parse_ForStatementNoShortIf()) 			{if (!density.empty()) density.top()->control++;return (FOUND);}

return (NOT_FOUND);

}

// **********************************************************

int parse_StatementWithoutTrailingSubstatement () {
int old=lex_index;
if (!parse_EmptyStatement()) 		{/*if (!density.empty()) density.top()->executable++;*/return (FOUND);}
if (!parse_ExpressionStatement()) 	{if (!density.empty()) density.top()->executable++;return (FOUND);}
if (!parse_SwitchStatement())     	{if (!density.empty()) density.top()->control++;return (FOUND);}
if (!parse_DoStatement()) 		{if (!density.empty()) density.top()->control++;return (FOUND);}
if (!parse_BreakStatement()) 		{if (!density.empty()) density.top()->control++;return (FOUND);}
if (!parse_ContinueStatement()) 	{if (!density.empty()) density.top()->control++;return (FOUND);}
if (!parse_ReturnStatement()) 		{if (!density.empty()) density.top()->control++;return (FOUND);}
if (!parse_SynchronizedStatement()) 	{if (!density.empty()) density.top()->control++;return (FOUND);}
if (!parse_ThrowStatement()) 		{if (!density.empty()) density.top()->control++;return (FOUND);}
if (!parse_TryStatement()) 		{if (!density.empty()) density.top()->control++;return (FOUND);}

if (!parse_Block()) 			{if (!density.empty()) density.top()->control++;return (FOUND);}

return (NOT_FOUND);

}

// ***************************************************

int parse_EmptyStatement () {

if (!parse_SEMICOLON()) return (FOUND);

return (NOT_FOUND);

}

// ***************************************************

int parse_LabeledStatement () {

int save_lex_index=lex_index;int save_jil_index=jil_index;

if (!parse_IDENTIFIER()) {
	if (!parse_COLON()) {
//		if (!parse_Statement()) 
		return (FOUND);
	}
}

lex_index=save_lex_index;jil_index=save_jil_index;
return (NOT_FOUND);

}

// ***************************************************

int parse_LabeledStatementNoShortIf () {

int save_lex_index=lex_index;int save_jil_index=jil_index;
int save_control,save_executable;

if (!parse_IDENTIFIER()) {
	if (!parse_COLON()) {
		if (!density.empty()) {
  		  save_control=density.top()->control;
 		  save_executable=density.top()->executable;
		}
		if (!parse_StatementNoShortIf())
			return (FOUND);
	}
if (!density.empty()) {
  density.top()->control=save_control;
  density.top()->executable=save_executable;
}
}
lex_index=save_lex_index;jil_index=save_jil_index;

return (NOT_FOUND);

}

// ***************************************************

int parse_ExpressionStatement () {

int save_lex_index=lex_index;int save_jil_index=jil_index;

if (!parse_StatementExpression()) 
	if (!parse_SEMICOLON())
		return (FOUND);

lex_index=save_lex_index;jil_index=save_jil_index;
return (NOT_FOUND);

}

// ***************************************************

int parse_StatementExpression () {

if (!parse_AssignmentExpression()) return (FOUND);

return (NOT_FOUND);

}

// *************************************************

int parse_IfThenStatement () {

int save_lex_index=lex_index;int save_jil_index=jil_index;
int save_executable,save_control;

if (!parse_IF()) {
	store_jil_lexeme(MORE_DEPTH,NULL);
	if (!parse_LEFT_PARENTH())
		if (!parse_Expression())
			if (!parse_RIGHT_PARENTH()) {
				store_jil_lexeme(MARK_IF,NULL);
				if (!density.empty()) {
				  save_executable=density.top()->executable;
				  save_control=density.top()->control;
				}
				if (!parse_Statement()) {
					store_jil_lexeme(CYCLO,NULL);
					store_jil_lexeme(MARK_ENDIF,NULL);
					store_jil_lexeme(LESS_DEPTH,NULL);
					return (FOUND);
				}
				if (!density.empty()) {
				  density.top()->executable=save_executable;
				  density.top()->control=save_control;
				}
			}
}
lex_index=save_lex_index;jil_index=save_jil_index;

return (NOT_FOUND);

}



int parse_IfThenElseStatement () {

int save_lex_index=lex_index;int save_jil_index=jil_index;
int save_executable,save_control;

if (!parse_IF()) {
	store_jil_lexeme(MARK_IF,NULL);
	store_jil_lexeme(MORE_DEPTH,NULL);
	if (!parse_LEFT_PARENTH())
		if (!parse_Expression())
			if (!parse_RIGHT_PARENTH()) { 
				if (!density.empty()) {
				  save_executable=density.top()->executable;
				  save_control=density.top()->control;
				}
				if (!parse_StatementNoShortIf()) 
					if (!parse_ELSE()) {
						if (!parse_Statement()) {
							store_jil_lexeme(CYCLO,NULL);
							store_jil_lexeme(MARK_ENDIF,NULL);
							store_jil_lexeme(LESS_DEPTH,NULL);
							return (FOUND);
						}
					}
				if (!density.empty()) {
				  density.top()->executable=save_executable;
				  density.top()->control=save_control;
				}
			}	
}
lex_index=save_lex_index;jil_index=save_jil_index;

return (NOT_FOUND);

}



int parse_IfThenElseStatementNoShortIf () {

int save_lex_index=lex_index;int save_jil_index=jil_index; 
int save_executable,save_control;

if (!parse_IF()) {
	store_jil_lexeme(MARK_IF,NULL);
	store_jil_lexeme(MORE_DEPTH,NULL);
        if (!parse_LEFT_PARENTH()) 
                if (!parse_Expression()) 
                        if (!parse_RIGHT_PARENTH())  {
				if (!density.empty()) {
                                  save_executable=density.top()->executable;
				  save_control=density.top()->control;
				}
				if (!parse_StatementNoShortIf()) {
                                        if (!parse_ELSE()) 
                                                if (!parse_StatementNoShortIf())  {
							store_jil_lexeme(CYCLO,NULL);
							store_jil_lexeme(MARK_ENDIF,NULL);
							store_jil_lexeme(LESS_DEPTH,NULL);
                                                        return (FOUND); 
						}
				} 
				if (!density.empty()) {
				  density.top()->executable=save_executable;
				  density.top()->control=save_control;
				}
			}
}
lex_index=save_lex_index;jil_index=save_jil_index;
 
return (NOT_FOUND); 
 
} 



int parse_SwitchStatement () {

int save_lex_index=lex_index;int save_jil_index=jil_index;

if (!parse_SWITCH()) {
	if (!parse_LEFT_PARENTH()) {
		if (!parse_Expression()) {
			if (!parse_RIGHT_PARENTH()) {
				if (!parse_SwitchBlock())
			     	  return (FOUND);
			}
		}
	}
}

lex_index=save_lex_index;jil_index=save_jil_index;

return (NOT_FOUND);

}



int parse_SwitchBlock () {

int save_lex_index=lex_index;int save_jil_index=jil_index;

if (!parse_LEFT_BRACE()) {
	parse_SwitchBlockStatementGroups_opt();
	parse_SwitchLabels_opt();
	if (!parse_RIGHT_BRACE())
		return (FOUND);
}

lex_index=save_lex_index;jil_index=save_jil_index;

return (NOT_FOUND);

}



int parse_SwitchBlockStatementGroups () {

if (!parse_SwitchBlockStatementGroup()) {
	while (!parse_SwitchBlockStatementGroup()) ;
	return (FOUND);
}

return (NOT_FOUND);

}


void parse_SwitchBlockStatementGroups_opt () {

(void) parse_SwitchBlockStatementGroups();

}



int parse_SwitchBlockStatementGroup () {

int save_lex_index=lex_index;int save_jil_index=jil_index;

if (!parse_SwitchLabels())
	if (!parse_BlockStatements())
		return(FOUND);

lex_index=save_lex_index;jil_index=save_jil_index;

return (NOT_FOUND);

}



int parse_SwitchLabels () {

if (!parse_SwitchLabel()) {
	while (!parse_SwitchLabel()) ;
	return (FOUND);
}

return (NOT_FOUND);

}



void parse_SwitchLabels_opt () {

(void) parse_SwitchLabels();

}



int parse_SwitchLabel () {

int save_lex_index=lex_index;int save_jil_index=jil_index;

if (!parse_CASE()) {
	store_jil_lexeme(MORE_DEPTH,NULL);
	if (!parse_ConstantExpression())
		if (!parse_COLON()) {
			store_jil_lexeme(CYCLO,NULL);
			store_jil_lexeme(LESS_DEPTH,NULL);
			return (FOUND);
		}
}
lex_index=save_lex_index;jil_index=save_jil_index;

if (!parse_DEFAULT()) {
	store_jil_lexeme(MORE_DEPTH,NULL);
	if (!parse_COLON()) {
		store_jil_lexeme(CYCLO,NULL);
		store_jil_lexeme(LESS_DEPTH,NULL);
		return (FOUND);
	}
}
lex_index=save_lex_index;jil_index=save_jil_index;

return (NOT_FOUND);

}



int parse_WhileStatement () {

int save_lex_index=lex_index;int save_jil_index=jil_index;
int save_executable,save_control;

if (!parse_WHILE()) {
	store_jil_lexeme(MORE_DEPTH,NULL);
	if (!parse_LEFT_PARENTH())
		if (!parse_Expression())
			if (!parse_RIGHT_PARENTH()) {
				if (!density.empty()) {
				  save_executable=density.top()->executable;
				  save_control=density.top()->control;
				}
				if (!parse_Statement()) {
					store_jil_lexeme(CYCLO,NULL);
					store_jil_lexeme(LESS_DEPTH,NULL);
					return (FOUND);
				}
				if (!density.empty()) {
				  density.top()->executable=save_executable;
				  density.top()->control=save_control;
				}
			}

}
lex_index=save_lex_index;jil_index=save_jil_index;

return (NOT_FOUND);

}



int parse_WhileStatementNoShortIf () {

int save_lex_index=lex_index;int save_jil_index=jil_index; 
int save_executable,save_control;

if (!parse_WHILE()) 
        if (!parse_LEFT_PARENTH()) 
                if (!parse_Expression()) 
                        if (!parse_RIGHT_PARENTH()) {
				if (!density.empty()) {
                         	  save_executable=density.top()->executable;
				  save_control=density.top()->control;
				}
				if (!parse_StatementNoShortIf()) {
					store_jil_lexeme(CYCLO,NULL);
                                        return (FOUND); 
				}
				if (!density.empty()) {
				  density.top()->executable=save_executable;
				  density.top()->control=save_control;
				}
			}
 
lex_index=save_lex_index;jil_index=save_jil_index; 
 
return (NOT_FOUND); 
 
} 



int parse_DoStatement () {

int save_lex_index=lex_index;int save_jil_index=jil_index;
int save_executable,save_control;

if (!parse_DO()) {
	store_jil_lexeme(MORE_DEPTH,NULL);
	if (!density.empty()) {
	  save_executable=density.top()->executable;
	  save_control=density.top()->control;
	}
	if (!parse_Statement())
		if (!parse_WHILE())
			if (!parse_LEFT_PARENTH())
				if (!parse_Expression())
					if (!parse_RIGHT_PARENTH())
						if (!parse_SEMICOLON()) {
							store_jil_lexeme(CYCLO,NULL);
							store_jil_lexeme(LESS_DEPTH,NULL);
							return (FOUND);
						}
	if (!density.empty()) {
	  density.top()->executable=save_executable;
	  density.top()->control=save_control;
	}
}
lex_index=save_lex_index;jil_index=save_jil_index;

return (NOT_FOUND);

}



int parse_ForStatement () {

int save_lex_index=lex_index;int save_jil_index=jil_index;
int save_executable,save_control;

if (!parse_FOR()) {
	store_jil_lexeme(MORE_DEPTH,NULL);
	if (!parse_LEFT_PARENTH()) {
		parse_ForInit_opt();
		if (!parse_SEMICOLON()) {
			parse_Expression_opt();
			if (!parse_SEMICOLON()) {
				parse_ForUpdate_opt();
				if (!parse_RIGHT_PARENTH()) {
					if (!density.empty()) {
					  save_executable=density.top()->executable;
					  save_control=density.top()->control;
					}
					if (!parse_Statement()) {
						store_jil_lexeme(CYCLO,NULL);
						store_jil_lexeme(LESS_DEPTH,NULL);
						return (FOUND);
					}
					if (!density.empty()) {
					  density.top()->executable=save_executable;
					  density.top()->control=save_control;
					}
				}
			}
		}
	}
}
lex_index=save_lex_index;jil_index=save_jil_index;

return (NOT_FOUND);

}



int parse_ForStatementNoShortIf () {

int save_lex_index=lex_index;int save_jil_index=jil_index;
int save_executable,save_control;

if (!parse_FOR()) {
	store_jil_lexeme(MORE_DEPTH,NULL);
        if (!parse_LEFT_PARENTH()) { 
                parse_ForInit_opt();
                if (!parse_SEMICOLON()) {  
                        parse_Expression_opt();
                        if (!parse_SEMICOLON()) {
                                parse_ForUpdate_opt(); 
                                if (!parse_RIGHT_PARENTH()) {
					if (!density.empty()) {
					  save_executable=density.top()->executable;
					  save_control=density.top()->control;
					}
					if (!parse_StatementNoShortIf()) {
						store_jil_lexeme(CYCLO,NULL);
						store_jil_lexeme(LESS_DEPTH,NULL);
                                        	return (FOUND); 
					}
					if (!density.empty()) {
					  density.top()->control=save_control;
					  density.top()->executable=save_executable;
					}
				}
                        } 
                } 
        } 
}
lex_index=save_lex_index;jil_index=save_jil_index; 
 
return (NOT_FOUND);

} 

	

int parse_ForInit () {

if (!parse_LocalVariableDeclaration()) return (FOUND);
if (!parse_StatementExpressionList()) return (FOUND);

return (NOT_FOUND);

}


void parse_ForInit_opt () {

(void) parse_ForInit ();

}



int parse_ForUpdate () {

if (!parse_StatementExpressionList()) return (FOUND);
return (NOT_FOUND);

}



void parse_ForUpdate_opt () {

(void) parse_ForUpdate();

}

int parse_StatementExpressionList () {

int save_lex_index,save_jil_index;

if (!parse_StatementExpression()) {

        save_lex_index=lex_index;save_jil_index=jil_index;

        if (!parse_COMMA()) {
                while (!parse_StatementExpression()) {
                        save_lex_index=lex_index;save_jil_index=jil_index;
                        if (parse_COMMA()) {
                                lex_index=save_lex_index;jil_index=save_jil_index;
                                return (FOUND);
                        }
                } 
                lex_index=save_lex_index;jil_index=save_jil_index;
                return (FOUND);
        }

        return (FOUND);
 
}
 
return (NOT_FOUND);

}

// *****************************************

int parse_BreakStatement () { 

int save_lex_index=lex_index;int save_jil_index=jil_index;

if (!parse_BREAK()) {
	parse_IDENTIFIER_opt();
	if (!parse_SEMICOLON())
		{
		store_jil_lexeme(MARK_UNSTRUCT,NULL);
		return (FOUND);
		}
}

lex_index=save_lex_index;jil_index=save_jil_index;
return (NOT_FOUND);

}

// ****************************************

int parse_ContinueStatement () {

int save_lex_index=lex_index;int save_jil_index=jil_index;

if (!parse_CONTINUE()) {
	parse_IDENTIFIER_opt();
	if (!parse_SEMICOLON()) {
		store_jil_lexeme(MARK_UNSTRUCT,NULL);
		return (FOUND);
	};
}

lex_index=save_lex_index;jil_index=save_jil_index;

return (NOT_FOUND);

}



int parse_ReturnStatement () {

int save_lex_index=lex_index;int save_jil_index=jil_index;

if (!parse_RETURN()) {
	parse_Expression_opt();
	if (!parse_SEMICOLON()) {
		store_jil_lexeme(MARK_UNSTRUCT,NULL);
		store_jil_lexeme(RET,NULL);
		return (FOUND);
	};
}

lex_index=save_lex_index;jil_index=save_jil_index;

return (NOT_FOUND);

}



int parse_ThrowStatement () {

int save_lex_index=lex_index;int save_jil_index=jil_index;

if (!parse_THROW())
	if (!parse_Expression())
		if (!parse_SEMICOLON())
			return (FOUND);

lex_index=save_lex_index;jil_index=save_jil_index;

return (NOT_FOUND);

}



int parse_SynchronizedStatement () {

int save_lex_index=lex_index;int save_jil_index=jil_index;

if (!parse_SYNCHRONIZED())
	if (!parse_LEFT_PARENTH())
		if (!parse_Expression())
			if (!parse_RIGHT_PARENTH()) {
				if (!parse_Block()) 
					return (FOUND);
			}

lex_index=save_lex_index;jil_index=save_jil_index;

return (NOT_FOUND);

}



int parse_TryStatement () {

int save_lex_index=lex_index;int save_jil_index=jil_index;

if (!parse_TRY())
	if (!parse_Block()) {
		if (!parse_Finally())
			return (FOUND);
		if (!parse_Catches()) {
			parse_Finally_opt();
			return (FOUND);
		}
	}	

lex_index=save_lex_index;jil_index=save_jil_index;

return (NOT_FOUND);

}



int parse_Catches () {

if (!parse_CatchClause()) {
	if (!density.empty()) density.top()->control++;
        while(!parse_CatchClause()) 
			if (!density.empty()) density.top()->control++;
        return (FOUND);
}

return (NOT_FOUND);

}



int parse_CatchClause () {

int save_lex_index=lex_index;int save_jil_index=jil_index;

if (!parse_CATCH())
	if (!parse_LEFT_PARENTH())
		if (!parse_FormalParameter())
			if (!parse_RIGHT_PARENTH())
				if (!parse_Block())
					return (FOUND);

lex_index=save_lex_index;jil_index=save_jil_index;

return (NOT_FOUND);

}



int parse_Finally () {

int save_lex_index=lex_index;int save_jil_index=jil_index;

if (!parse_FINALLY())
	if (!parse_Block())
		return (FOUND);

lex_index=save_lex_index;jil_index=save_jil_index;

return (NOT_FOUND);

}


void parse_Finally_opt () {

(void) parse_Finally();

}


// ***************************************************

int parse_ArgumentList () {

int save_lex_index,save_jil_index;

if (!parse_Expression()) {
        save_lex_index=lex_index;save_jil_index=jil_index;

        if (!parse_COMMA()) {
                while (!parse_Expression()) {
                        save_lex_index=lex_index;save_jil_index=jil_index;
                        if (parse_COMMA()) {
                                lex_index=save_lex_index;jil_index=save_jil_index;
                                return (FOUND);
                        }
                } 
                lex_index=save_lex_index;jil_index=save_jil_index;
                return (FOUND);
        }
	lex_index=save_lex_index;jil_index=save_jil_index;
        return (FOUND);
 
}
return (NOT_FOUND);
 
}

	
void parse_ArgumentList_opt() {
	
(void) parse_ArgumentList();

}


int parse_PrimaryExpression() {

int save_lex_index=lex_index;int save_jil_index=jil_index;

if (!parse_LEFT_PARENTH())
  if (!parse_Expression())
    if (!parse_RIGHT_PARENTH())
      return FOUND;
lex_index=save_lex_index;jil_index=save_jil_index;
if (!parse_IDENTIFIER()) {
  store_jil_lexeme(XREF,text_from(lex_index-1,lex_index-1));
  return FOUND;
}
if (!parse_NewExpression()) 
  return FOUND;
if (!parse_Constant())
  return FOUND;
if (!parse_SUPER())
  return FOUND;
if (!parse_THIS())
  return FOUND;
// 26/6/98
if (!parse_CLASS())
  return FOUND;
if (!parse_BOOLEAN_LITERAL())
  return FOUND;
if (!parse_NULL_LITERAL())
  return FOUND;
if (!parse_STRING_LITERAL())
  return FOUND;
return NOT_FOUND;

}

// *****************************************	
	
int parse_ArrayCreationExpression () {

int save_lex_index=lex_index;int save_jil_index=jil_index;


if (!parse_NEW()) {
	if (!parse_PrimitiveType())
		if (!parse_DimExprs()) {
			parse_Dims_opt();
			return (FOUND);
		}
}

lex_index=save_lex_index;jil_index=save_jil_index;

if (!parse_NEW()) {
	if (!parse_ClassOrInterfaceType())
		if (!parse_DimExprs()) {
			parse_Dims_opt();
			return (FOUND);
		}
	lex_index=save_lex_index;jil_index=save_jil_index;
	return (NOT_FOUND);
}

lex_index=save_lex_index;jil_index=save_jil_index;
return (NOT_FOUND);

}

// ****************************************
			
int parse_DimExprs () {

if (!parse_DimExpr()) {
        while(!parse_DimExpr()) ;
        return (FOUND);
}

return (NOT_FOUND);

}



int parse_DimExpr () {

int save_lex_index=lex_index;int save_jil_index=jil_index;

if (!parse_LEFT_BRACKET())
	if (!parse_Expression())
		if (!parse_RIGHT_BRACKET())
			return (FOUND);

lex_index=save_lex_index;jil_index=save_jil_index;

return (NOT_FOUND);

}


int parse_Dims() {

int save_lex_index=lex_index;int save_jil_index=jil_index;

if (!parse_LEFT_BRACKET())
	if (!parse_RIGHT_BRACKET()) {
		save_lex_index=lex_index;save_jil_index=jil_index;
		while (!parse_LEFT_BRACKET()) 
			if (parse_RIGHT_BRACKET()) {
				lex_index=save_lex_index;jil_index=save_jil_index;
				return(FOUND);
			}
		lex_index=save_lex_index;jil_index=save_jil_index;
		return(FOUND);
	}

return (NOT_FOUND);

}


void parse_Dims_opt() {

(void) parse_Dims();

}

int parse_AssignmentOperator () {

if (!parse_ASSIGN()) return (FOUND);
if (!parse_TIMESEQUALS()) return (FOUND);
if (!parse_DIVEQUALS()) return (FOUND);
if (!parse_MODEQUALS()) return (FOUND);
if (!parse_PLUSEQUALS()) return (FOUND);
if (!parse_MINUSEQUALS()) return (FOUND);
if (!parse_LEFT_SHIFTEQUALS()) return (FOUND);
if (!parse_RIGHT_SHIFTEQUALS()) return (FOUND);
if (!parse_GTGTGTEQUALS()) return (FOUND);
if (!parse_BIT_ANDEQUALS()) return (FOUND);
if (!parse_CARETEQUALS()) return (FOUND);
if (!parse_BIT_OREQUALS()) return (FOUND);
return (NOT_FOUND);

}


int parse_AdditiveOperator () {

if (!parse_PLUS()) return (FOUND);
if (!parse_MINUS()) return (FOUND);

return (NOT_FOUND);

}


int parse_EqualityOperator() {

if (!parse_EQUALITY()) return (FOUND);
if (!parse_NE()) return (FOUND);
return (NOT_FOUND);

}


int parse_MultiplicativeOperator () {

if (!parse_TIMES()) return (FOUND);
if (!parse_DIVIDE()) return (FOUND);
if (!parse_MOD()) return (FOUND);

return (NOT_FOUND);

}


int parse_ShiftOperator() {

if (!parse_LEFT_SHIFT()) return (FOUND);
if (!parse_RIGHT_SHIFT()) return (FOUND);

return (NOT_FOUND);

}


int parse_RelationalOperator() {

if (!parse_LT()) return (FOUND);
if (!parse_GT()) return (FOUND);
if (!parse_LE()) return (FOUND);
if (!parse_GE()) return (FOUND);
if (!parse_INSTANCEOF()) return (FOUND);

return (NOT_FOUND);

}

int parse_Constant() {

if ((!parse_INTEGER_LITERAL())||(!parse_FLOATING_LITERAL())||(!parse_BOOLEAN_LITERAL())||(!parse_STRING_LITERAL())||(!parse_CHARACTER_LITERAL())) {
  store_jil_lexeme(LOWCOMPLEX,NULL);
  return FOUND;
}
return NOT_FOUND;

}

int parse_NewExpression() {

int save_lex_index=lex_index;int save_jil_index=jil_index;


if (!parse_NEW()) {
  if (!parse_Type()) {
    if (!parse_NewArray()) {
    	// 1.1 support...can have class body here (anonymous class)
	parse_ClassBody_opt(); 
	store_jil_lexeme(HIGHCOMPLEX,NULL);
        return FOUND;
    }
  }
}
lex_index=save_lex_index;jil_index=save_jil_index;
if (!parse_NEW())
  if (!parse_Type())
    if (!parse_LEFT_PARENTH()) {
      parse_ExpressionList_opt();
      if (!parse_RIGHT_PARENTH())
	    // 1.1 support...can have class body here (anonymous class)
	    parse_ClassBody_opt();
	    store_jil_lexeme(HIGHCOMPLEX,NULL);
	    return FOUND;
    }


lex_index=save_lex_index;jil_index=save_jil_index;
if (!parse_ArrayInitializer()) return (FOUND);

lex_index=save_lex_index;jil_index=save_jil_index;
return NOT_FOUND;

}

int parse_PostfixExpressionTails () {

int save_lex_index=lex_index;int save_jil_index=jil_index;

if (!parse_PLUSPLUS()) {
  store_jil_lexeme(LOWCOMPLEX,NULL);
  return FOUND;
 }
if (!parse_MINUSMINUS()) {
  store_jil_lexeme(LOWCOMPLEX,NULL);
  return FOUND;
}
if (!parse_LEFT_BRACKET())
  if (!parse_Expression())
    if (!parse_RIGHT_BRACKET()) {
      store_jil_lexeme(LOWCOMPLEX,NULL);
      return FOUND;
    }
lex_index=save_lex_index;jil_index=save_jil_index;
if (!parse_LEFT_PARENTH()) {
  parse_ExpressionList_opt();
  if (!parse_RIGHT_PARENTH())
    return FOUND;
}
lex_index=save_lex_index;jil_index=save_jil_index;
if (!parse_DOT())
  if (!parse_PrimaryExpression()) {
    store_jil_lexeme(LOWCOMPLEX,NULL);
    return FOUND;
   }
lex_index=save_lex_index;jil_index=save_jil_index;
return NOT_FOUND;

}

int parse_PostfixExpression() {

if (parse_PrimaryExpression())
  return NOT_FOUND;

while (!parse_PostfixExpressionTails()) ;

return FOUND;

}

int parse_NewArray() {

int save_lex_index=lex_index;int save_jil_index=jil_index;

if (!parse_LEFT_BRACKET()) {
  parse_Expression_opt();
  if (!parse_RIGHT_BRACKET()) {
    save_lex_index=lex_index;save_jil_index=jil_index;
    while (!parse_LEFT_BRACKET()) {
 	parse_Expression_opt();
        if (parse_RIGHT_BRACKET()) {
	  lex_index=save_lex_index;jil_index=save_jil_index;
          return FOUND;
	}
    }
    return FOUND;
  }
}
lex_index=save_lex_index;jil_index=save_jil_index;
return NOT_FOUND;
}

int parse_UnaryExpression() {

int save_lex_index=lex_index;int save_jil_index=jil_index;

if (!parse_PLUSPLUS())
  if (!parse_CastExpression()) {
    store_jil_lexeme(LOWCOMPLEX,NULL);
    return FOUND;
   }
lex_index=save_lex_index;jil_index=save_jil_index;
if (!parse_MINUSMINUS())
  if (!parse_CastExpression()) {
    store_jil_lexeme(LOWCOMPLEX,NULL);
    return FOUND;
   }
lex_index=save_lex_index;jil_index=save_jil_index;
if (!parse_MINUS()) 
  if (!parse_CastExpression()) {
    store_jil_lexeme(LOWCOMPLEX,NULL);
    return FOUND;
  }
lex_index=save_lex_index;jil_index=save_jil_index;
if (!parse_BIT_NOT())
  if (!parse_CastExpression()) {
    store_jil_lexeme(LOWCOMPLEX,NULL);
    return FOUND;
   }
lex_index=save_lex_index;jil_index=save_jil_index;
if (!parse_NOT())
  if (!parse_CastExpression()) {
    store_jil_lexeme(LOWCOMPLEX,NULL);
    return FOUND;
  } 
lex_index=save_lex_index;jil_index=save_jil_index;
if (!parse_PostfixExpression()) {
  save_lex_index=lex_index;save_jil_index=jil_index;
  if (!parse_INSTANCEOF())
    if (!parse_ReferenceType()) {
      store_jil_lexeme(MIDCOMPLEX,NULL);
      return FOUND;
    }
  lex_index=save_lex_index;jil_index=save_jil_index;
  return FOUND;
}
lex_index=save_lex_index;jil_index=save_jil_index;
return NOT_FOUND;

}

int parse_TypeSpec() {

int save_lex_index=lex_index;int save_jil_index=jil_index;

if ((!parse_QualifiedName())||(!parse_PrimitiveType())) {
  while (!parse_Dims())
    ;
  return FOUND;
}
lex_index=save_lex_index;jil_index=save_jil_index;
return NOT_FOUND;

}

int parse_CastExpressionHead() {

int save_lex_index=lex_index;int save_jil_index=jil_index;

if (!parse_LEFT_PARENTH())
  if (!parse_TypeSpec())
    if (!parse_RIGHT_PARENTH()) 
      return FOUND;
lex_index=save_lex_index;jil_index=save_jil_index;
return NOT_FOUND;

}

int parse_CastExpression () {

int save_lex_index=lex_index;int save_jil_index=jil_index;

if (!parse_CastExpressionHead()) 
  if (!parse_UnaryExpression()) {
    store_jil_lexeme(MIDCOMPLEX,NULL);
    return FOUND;
  }
lex_index=save_lex_index;jil_index=save_jil_index;
if (!parse_UnaryExpression())
  return FOUND;
return NOT_FOUND;

}

int parse_MultiplicativeExpression () {

int save_lex_index=lex_index;int save_jil_index=jil_index;

if (!parse_CastExpression()) {
  save_lex_index=lex_index;save_jil_index=jil_index;
} else return NOT_FOUND;

while ((!parse_TIMES())||(!parse_DIVIDE())||(!parse_MOD())) {
  store_jil_lexeme(SEP,NULL);
  store_jil_lexeme(LOWCOMPLEX,NULL);
  if (parse_CastExpression()) {
    lex_index=save_lex_index;jil_index=save_jil_index;
    return FOUND;
  }
  save_lex_index=lex_index;save_jil_index=jil_index;
}
  
lex_index=save_lex_index;jil_index=save_jil_index;

return FOUND;

}

int parse_AdditiveExpression () {

int save_lex_index=lex_index;int save_jil_index=jil_index;

if (!parse_MultiplicativeExpression()) {
  save_lex_index=lex_index;save_jil_index=jil_index;
} else return NOT_FOUND;

while ((!parse_MINUS())||(!parse_PLUS())) {
  store_jil_lexeme(SEP,NULL);
  store_jil_lexeme(LOWCOMPLEX,NULL);
  if (parse_MultiplicativeExpression()) {
    lex_index=save_lex_index;jil_index=save_jil_index;
    return FOUND;
  }
  save_lex_index=lex_index;save_jil_index=jil_index;
}
  
lex_index=save_lex_index;jil_index=save_jil_index;

return FOUND;

}

int parse_ShiftExpression() {

int save_lex_index=lex_index;int save_jil_index=jil_index;

if (!parse_AdditiveExpression()) {
  save_lex_index=lex_index;save_jil_index=jil_index;
} else return NOT_FOUND;

while ((!parse_LEFT_SHIFT())||(!parse_RIGHT_SHIFT())||(!parse_GTGTGT())) {
  store_jil_lexeme(SEP,NULL);
  store_jil_lexeme(HIGHCOMPLEX,NULL);
  if (parse_AdditiveExpression()) {
    lex_index=save_lex_index;jil_index=save_jil_index;
    return FOUND;
  }
  save_lex_index=lex_index;save_jil_index=jil_index;
}
  
lex_index=save_lex_index;jil_index=save_jil_index;

return FOUND;

}

int parse_RelationalExpression () {

int save_lex_index=lex_index;int save_jil_index=jil_index;

if (!parse_ShiftExpression()) {
  save_lex_index=lex_index;save_jil_index=jil_index;
} else return NOT_FOUND;

while (!parse_RelationalOperator()) {
  store_jil_lexeme(SEP,NULL);
  store_jil_lexeme(MIDCOMPLEX,NULL);
  if (parse_ShiftExpression()) {
    lex_index=save_lex_index;jil_index=save_jil_index;
    return FOUND;
  }
  save_lex_index=lex_index;save_jil_index=jil_index;
}
  
lex_index=save_lex_index;jil_index=save_jil_index;

return FOUND;

}

int parse_EqualityExpression () {

int save_lex_index=lex_index;int save_jil_index=jil_index;

if (!parse_RelationalExpression()) {
  save_lex_index=lex_index;save_jil_index=jil_index;
} else return NOT_FOUND;

while ((!parse_NE())||(!parse_EQUALITY())) {
  store_jil_lexeme(SEP,NULL);
  store_jil_lexeme(LOWCOMPLEX,NULL);
  if (parse_RelationalExpression()) {
    lex_index=save_lex_index;jil_index=save_jil_index;
    return FOUND;
  }
  save_lex_index=lex_index;save_jil_index=jil_index;
}
  
lex_index=save_lex_index;jil_index=save_jil_index;

return FOUND;


}

int parse_AndExpression () {

int save_lex_index=lex_index;int save_jil_index=jil_index;

if (!parse_EqualityExpression()) {
  save_lex_index=lex_index;save_jil_index=jil_index;
} else return NOT_FOUND;

while (!parse_BIT_AND()) {
  store_jil_lexeme(SEP,NULL);
  store_jil_lexeme(MIDCOMPLEX,NULL);
  if (parse_EqualityExpression()) {
    lex_index=save_lex_index;jil_index=save_jil_index;
    return FOUND;
  }
  save_lex_index=lex_index;save_jil_index=jil_index;
}
  
lex_index=save_lex_index;jil_index=save_jil_index;

return FOUND;

}

int parse_ExclusiveOrExpression () {

int save_lex_index=lex_index;int save_jil_index=jil_index;

if (!parse_AndExpression()) {
  save_lex_index=lex_index;save_jil_index=jil_index;
} else return NOT_FOUND;

while (!parse_CARET()) {
  store_jil_lexeme(SEP,NULL);
  store_jil_lexeme(MIDCOMPLEX,NULL);
  if (parse_AndExpression()) {
    lex_index=save_lex_index;jil_index=save_jil_index;
    return FOUND;
  }
  save_lex_index=lex_index;save_jil_index=jil_index;
}
  
lex_index=save_lex_index;jil_index=save_jil_index;

return FOUND;

}

int parse_InclusiveOrExpression () {

int save_lex_index=lex_index;int save_jil_index=jil_index;

if (!parse_ExclusiveOrExpression()) {
  save_lex_index=lex_index;save_jil_index=jil_index;
} else return NOT_FOUND;

while (!parse_BIT_OR()) {
  store_jil_lexeme(SEP,NULL);
  store_jil_lexeme(MIDCOMPLEX,NULL);
  if (parse_ExclusiveOrExpression()) {
    lex_index=save_lex_index;jil_index=save_jil_index;
    return FOUND;
  }
  save_lex_index=lex_index;save_jil_index=jil_index;
}
  
lex_index=save_lex_index;jil_index=save_jil_index;

return FOUND;

}

int parse_LogicalAndExpression () {

int save_lex_index=lex_index;int save_jil_index=jil_index;

if (!parse_InclusiveOrExpression()) {
  save_lex_index=lex_index;save_jil_index=jil_index;
} else return NOT_FOUND;

while (!parse_AND()) {
  store_jil_lexeme(SEP,NULL);
  store_jil_lexeme(MIDCOMPLEX,NULL);
  if (parse_InclusiveOrExpression()) {
    lex_index=save_lex_index;jil_index=save_jil_index;
    return FOUND;
  }
  save_lex_index=lex_index;save_jil_index=jil_index;
}
  
lex_index=save_lex_index;jil_index=save_jil_index;

return FOUND;

}

int parse_LogicalOrExpression () {

int save_lex_index=lex_index;int save_jil_index=jil_index;

if (!parse_LogicalAndExpression()) {
  save_lex_index=lex_index;save_jil_index=jil_index;
} else return NOT_FOUND;
while (!parse_OR()) {
  store_jil_lexeme(SEP,NULL);
  store_jil_lexeme(MIDCOMPLEX,NULL);
  if (parse_LogicalAndExpression()) {
    lex_index=save_lex_index;jil_index=save_jil_index;
    return FOUND;
  }
  save_lex_index=lex_index;save_jil_index=jil_index;
}
  
lex_index=save_lex_index;jil_index=save_jil_index;

return FOUND;

}

int parse_ConditionalExpression () {

int save_lex_index=lex_index;int save_jil_index=jil_index;

if (!parse_LogicalOrExpression()) {
  save_lex_index=lex_index;save_jil_index=jil_index;
} else return NOT_FOUND;
store_jil_lexeme(SEP,NULL);
if (!parse_QUERY())
  if (!parse_ConditionalExpression()) 
    if (!parse_COLON()) {
      store_jil_lexeme(SEP,NULL);
      if (!parse_ConditionalExpression()) {
        store_jil_lexeme(MIDCOMPLEX,NULL);
	return FOUND;
	}
    }
lex_index=save_lex_index;jil_index=save_jil_index;

return FOUND;

}

int parse_AssignmentExpression() {

int save_lex_index=lex_index;int save_jil_index=jil_index;

store_jil_lexeme(BEGIN_EXPRESSION,NULL);

if (!parse_ConditionalExpression()) {
  save_lex_index=lex_index;save_jil_index=jil_index;
} else {
  lex_index=save_lex_index;jil_index=save_jil_index;
  return NOT_FOUND;
}

if (!parse_AssignmentOperator()) {
  store_jil_lexeme(SEP,NULL);
  if (!parse_AssignmentExpression()) {
    store_jil_lexeme(LOWCOMPLEX,NULL);
    store_jil_lexeme(END_EXPRESSION,NULL);
    return FOUND;
  }
}

lex_index=save_lex_index;jil_index=save_jil_index;
store_jil_lexeme(END_EXPRESSION,NULL);
return FOUND;

}

int parse_Expression () {

int save_lex_index=lex_index;int save_jil_index=jil_index;
if (!parse_AssignmentExpression()) {
  return (FOUND);
};
lex_index=save_lex_index;jil_index=save_jil_index;
return NOT_FOUND;

}

int parse_ExpressionList () {

int save_lex_index=lex_index;int save_jil_index=jil_index;

if (!parse_Expression()) {
  save_lex_index=lex_index;save_jil_index=jil_index;
} else return NOT_FOUND;

while (!parse_COMMA()) {
  if (parse_Expression()) {
    lex_index=save_lex_index;jil_index=save_jil_index;
    return FOUND;
  }
  save_lex_index=lex_index;save_jil_index=jil_index;
}
  
lex_index=save_lex_index;jil_index=save_jil_index;

return FOUND;

}

void parse_ExpressionList_opt() {

(void) parse_ExpressionList () ;

}

void parse_Expression_opt () {

(void) parse_Expression ();

}

int parse_ConstantExpression () {

if (!parse_Expression()) return (FOUND);
return (NOT_FOUND);

}


