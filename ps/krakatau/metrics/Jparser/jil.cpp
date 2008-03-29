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

#include "debug.h"
#include "jil.h"
#include "lexical_analysis.h"
#include "codefn.h"
#include <string.h>
#include <stdlib.h>

#ifdef WIN32
	#include <malloc.h>
#endif

#include <stdio.h>

int jil_ceiling=2000;

lexeme* jil_lexemes;

int jil_index;

int n_jil_lexemes;

// *******************************************

char* java_filename_to_jil_filename(char* filename) {

char* jil_filename;

jil_filename=(char*)malloc(strlen(filename)+5);
strcpy(jil_filename,filename);
strcat(jil_filename,".jil\0");
return (jil_filename);
}

// *******************************************

void expand_jil_lexeme_storage_array() {

//        int i;
//        lexeme* new_lexeme_array;

//        DEBUGOUT("EXPAND %d\n",lex_index);
//      new_lexeme_array=(lexeme*)malloc(sizeof(lexeme[jil_ceiling+2000]));
        jil_ceiling+=2000;

//      for (i=0;i<=(jil_index-1);i++) new_lexeme_array[i]=jil_lexemes[i];

//      free(jil_lexemes);
//      jil_lexemes=new_lexeme_array;
#ifdef WIN32
        jil_lexemes=(lexeme *)realloc(jil_lexemes,sizeof(lexeme)*(jil_ceiling));
#else
        jil_lexemes=(lexeme *)realloc(jil_lexemes,sizeof(lexeme[jil_ceiling]));
#endif
		//        DEBUGOUT(stderr,"expanded to %d\n",jil_ceiling);

}

// *******************************************

void store_jil_lexeme(int symbol,char* text) {
if (jil_index>=jil_ceiling) expand_jil_lexeme_storage_array();

jil_lexemes[jil_index].symbol=symbol;
jil_lexemes[jil_index++].text=text;

}

// ******************************************

void init_jil () {

#ifdef WIN32
jil_lexemes=(lexeme*)malloc(sizeof(lexeme)*(jil_ceiling));
#else
jil_lexemes=(lexeme*)malloc(sizeof(lexeme[jil_ceiling]));
#endif
jil_index=0;

}

// *******************************************

void errorFile(FILE* outfile) {
	// Output END
	fprintf(outfile,"%d\n",-101);
	fprintf(outfile,"%d\n",-1);
	fprintf(outfile,"-----\n");
	fprintf(outfile,"%d\n",-1);
	fprintf(outfile,"-1\n");
	fprintf(outfile,"-1\n");

	fflush(outfile) ;
	//fprintf(outfile,"0\n");
}


void output_jil_to_file (FILE* outfile) {

//FILE* outfile;
int i;

//outfile=fopen(filename,"w");
for (i=0;i<=n_jil_lexemes;i++) {
	fprintf(outfile,"%d\n",jil_lexemes[i].symbol);

	if (jil_lexemes[i].symbol==ID)
	{
		fprintf(outfile,"%d\n%s\n",-1,codefn(jil_lexemes[i].text));
	}
	else if (jil_lexemes[i].symbol==XREF)
	{
		fprintf(outfile,"%d\n%s\n",-1,jil_lexemes[i].text);
	}
	else if ((jil_lexemes[i].symbol==LOC)||(jil_lexemes[i].symbol==MODS)||(jil_lexemes[i].symbol==JIL_SLOC)||(jil_lexemes[i].symbol==JIL_N1)||(jil_lexemes[i].symbol==JIL_N2)||(jil_lexemes[i].symbol==JIL_n1)||(jil_lexemes[i].symbol==JIL_n2)||(jil_lexemes[i].symbol==JIL_J_COM)||(jil_lexemes[i].symbol==JIL_C_COM)||(jil_lexemes[i].symbol==JIL_CPP_COM)||(jil_lexemes[i].symbol==JIL_COM_LOC)||(jil_lexemes[i].symbol==JIL_CTRL)||(jil_lexemes[i].symbol==JIL_EXEC)||(jil_lexemes[i].symbol==JIL_CLASS)||(jil_lexemes[i].symbol==JIL_INTERFACE)||(jil_lexemes[i].symbol==METHOD)||(jil_lexemes[i].symbol==JIL_NSC))
	{
		fprintf(outfile,"%d\n%s\n",((int)jil_lexemes[i].text),"-");
	}
	else
	{
		fprintf(outfile,"%d\n%s\n",-1,"-");
	}
}	

fprintf(outfile,"%d\n",-100);
fprintf(outfile,"%d\n",-1);
fprintf(outfile,"-----\n");
fflush(outfile) ;
//fclose(outfile);

}

// *******************************************

char* sym_to_text(int sym) {

switch (sym) {
case ID: return ("\tID");
case JIL_IMPORT : return ("IMPORT");
case END_UNIT_HEADER: return ("END_UNIT_HEADER");
case JIL_CLASS: return ("JIL_CLASS");
case JIL_INTERFACE: return ("JIL_INTERFACE");
case INHERITS: return ("INHERITS");
case JIL_IMPLEMENTS: return ("JIL_IMPLEMENTS");
case END_IMPLEMENTS: return ("END_IMPLEMENTS");
case FIELD: return ("FIELD");
case METHOD: return ("METHOD");
case END_BODY: return ("END_BODY");
case END_PARAMS: return ("END_PARAMS");
case JIL_PUBLIC: return ("JIL_PUBLIC");
case JIL_PROTECTED: return ("JIL_PROTECTED");
case JIL_PRIVATE: return ("JIL_PRIVATE");
case JIL_PACKAGE: return ("JIL_PACKAGE");
case LOCAL: return ("LOCAL");
case ACCESS_IDS: return ("ACCESS_IDS");
case END_ACCESS_IDS: return ("END_ACCESS_IDS");
case READ: return ("READ");
case END_READ: return ("END_READ");
case WRITE: return ("WRITE");
case END_WRITE: return ("END_WRITE");
case PATH: return ("PATH");
case JEND_PATH: return ("END_PATH");
case INVOKE: return ("INVOKE");
case JIL_EXTENDS: return ("JIL_EXTENDS");
case END_EXTENDS: return ("END_EXTENDS");
case TYPE: return ("TYPE");
case END_UNIT: return ("END_UNIT");
case CYCLO: return ("CYCLO");
case XREF: return ("XREF");
case SEP: return ("SEP");
case BEGIN_EXPRESSION: return ("BEGIN_EXPRESSION");
case END_EXPRESSION: return ("END_EXPRESSION");
case LOC: return ("LOC");
case LOWCOMPLEX: return ("LOWCOMPLEX");
case MIDCOMPLEX: return ("MIDCOMPLEX");
case HIGHCOMPLEX: return ("HIGHCOMPLEX");
case MODS: return ("MODS");
case JIL_PRIVATE_PROTECTED: return ("JIL_PRIVATE_PROTECTED");
case JIL_SLOC: return ("JIL_SLOC");
case JIL_N1: return ("JIL_N1");
case JIL_N2: return ("JIL_N2");
case JIL_n1: return ("JIL_n1");
case JIL_n2: return ("JIL_n2");
case MARK_IF: return ("MARK_IF");
case MARK_ENDIF: return ("MARK_ENDIF");
case JIL_C_COM: return ("JIL_C_COM");
case JIL_CPP_COM: return ("JIL_CPP_COM");
case JIL_J_COM: return ("JIL_J_COM");
case JIL_COM_LOC: return ("JIL_COM_LOC");
case MARK_UNSTRUCT: return ("MARK_UNSTRUCT");
case MORE_DEPTH: return ("MORE_DEPTH");
case LESS_DEPTH: return ("LESS_DEPTH");
case RET:  return ("RET");
case JIL_CTRL: return ("JIL_CTRL");
case JIL_EXEC: return ("JIL_EXEC");
case ETYPE: return ("ETYPE");
default: return ("UNKNOWN SYMBOL");
}

}

// *******************************************
 
void show_jil () {
int i;
printf("JIL LEXEMES:\n");
for (i=0;i<=n_jil_lexemes;i++) {
//	fprintf(stderr,"I: %d\n",i);


    if ((jil_lexemes[i].text!=NULL)&&(jil_lexemes[i].symbol!=LOC)&&(jil_lexemes[i].symbol!=MODS)&&(jil_lexemes[i].symbol!=JIL_SLOC)&&(jil_lexemes[i].symbol!=JIL_N1)&&(jil_lexemes[i].symbol!=JIL_N2)&&(jil_lexemes[i].symbol!=JIL_n1)&&(jil_lexemes[i].symbol!=JIL_n2)&&(jil_lexemes[i].symbol!=JIL_J_COM)&&(jil_lexemes[i].symbol!=JIL_C_COM)&&(jil_lexemes[i].symbol!=JIL_CPP_COM)&&(jil_lexemes[i].symbol!=JIL_COM_LOC)&&(jil_lexemes[i].symbol!=JIL_CTRL)&&(jil_lexemes[i].symbol!=JIL_EXEC)&&(jil_lexemes[i].symbol!=JIL_CLASS)&&(jil_lexemes[i].symbol!=JIL_INTERFACE)&&(jil_lexemes[i].symbol!=METHOD))


	//if ((jil_lexemes[i].text!=NULL)&&(jil_lexemes[i].symbol!=LOC)&&(jil_lexemes[i].symbol!=MODS)&&(jil_lexemes[i].symbol!=JIL_SLOC)&&(jil_lexemes[i].symbol!=JIL_N1)&&(jil_lexemes[i].symbol!=JIL_N2)&&(jil_lexemes[i].symbol!=JIL_n1)&&(jil_lexemes[i].symbol!=JIL_n2)&&(jil_lexemes[i].symbol!=JIL_C_COM)&&(jil_lexemes[i].symbol!=JIL_CPP_COM)&&(jil_lexemes[i].symbol!=JIL_J_COM)&&(jil_lexemes[i].symbol!=JIL_COM_LOC)&&(jil_lexemes[i].symbol!=JIL_CTRL)&&(jil_lexemes[i].symbol!=JIL_EXEC)) 
{	fprintf(stderr,"%s %s\n",sym_to_text(jil_lexemes[i].symbol),jil_lexemes[i].text);}
	else if (jil_lexemes[i].symbol==LOC)
	  fprintf(stderr,"LOC %d\n",(int)(jil_lexemes[i].text));
	else if (jil_lexemes[i].symbol==MODS)
	  fprintf(stderr,"MODS %d\n",(int)(jil_lexemes[i].text));
	else if (jil_lexemes[i].symbol==JIL_SLOC)
	  fprintf(stderr,"JIL_SLOC %d\n",(int)(jil_lexemes[i].text));
	else if (jil_lexemes[i].symbol==JIL_N1)
	  fprintf(stderr,"JIL_N1 %d\n",(int)(jil_lexemes[i].text));
	else if (jil_lexemes[i].symbol==JIL_N2)
	  fprintf(stderr,"JIL_N2 %d\n",(int)(jil_lexemes[i].text));
	else if (jil_lexemes[i].symbol==JIL_n1)
	  fprintf(stderr,"JIL_n1 %d\n",(int)(jil_lexemes[i].text));
	else if (jil_lexemes[i].symbol==JIL_n2)
	  fprintf(stderr,"JIL_n2 %d\n",(int)(jil_lexemes[i].text));
	else if (jil_lexemes[i].symbol==JIL_CTRL)
	  fprintf(stderr,"JIL_CTRL %d\n",(int)(jil_lexemes[i].text));
	else if (jil_lexemes[i].symbol==JIL_EXEC)
	  fprintf(stderr,"JIL_EXEC %d\n",(int)(jil_lexemes[i].text));
	else if (jil_lexemes[i].symbol==JIL_CLASS)
	  fprintf(stderr,"JIL_CLASS %d\n",(int)(jil_lexemes[i].text));
	else if (jil_lexemes[i].symbol==JIL_INTERFACE)
	  fprintf(stderr,"JIL_INTERFACE %d\n",(int)(jil_lexemes[i].text));
	else if (jil_lexemes[i].symbol==METHOD)
	  fprintf(stderr,"METHOD %d\n",(int)(jil_lexemes[i].text));
	else fprintf(stderr,"%s\n",sym_to_text(jil_lexemes[i].symbol));
}
printf("END JIL LEXEMES\n");
}


