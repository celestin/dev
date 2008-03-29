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

#include <stdio.h>

extern int jil_index;
extern int n_jil_lexemes;

typedef struct {
	int symbol;
	char* text;
	int line;
} lexeme; 

#define INITIAL_MAX_LEXEMES 1000

void expand_jil_lexeme_storage_array();
void store_jil_lexeme(int,char*);
int symbol_is_identifier(int);
void init_jil();
void output_jil_to_file(FILE*);

#define ID 0
#define JIL_IMPORT 1
#define END_UNIT_HEADER 2
#define JIL_CLASS 3
#define JIL_INTERFACE 4
#define INHERITS 5
#define JIL_IMPLEMENTS 6
#define END_IMPLEMENTS 7
#define FIELD 8
#define METHOD 9
#define END_BODY 10
#define END_PARAMS 11
#define JIL_PUBLIC 12
#define JIL_PROTECTED 13
#define JIL_PRIVATE 14
#define LOCAL 15
#define ACCESS_IDS 16
#define END_ACCESS_IDS 17
#define READ 18
#define END_READ 19
#define WRITE 20
#define END_WRITE 21
#define PATH 22
#define JEND_PATH 23
#define INVOKE 24
#define JIL_EXTENDS 25
#define END_EXTENDS 26
#define TYPE 27
#define END_UNIT 28
#define JIL_PACKAGE 29
#define CYCLO 30
#define XREF 31
#define SEP 32
#define BEGIN_EXPRESSION 33
#define END_EXPRESSION 34
#define LOC 35
#define LOWCOMPLEX 36
#define MIDCOMPLEX 37
#define HIGHCOMPLEX 38
#define JIL_PRIVATE_PROTECTED 39
#define MODS 40
#define JIL_SLOC 41
#define JIL_N1 42
#define JIL_N2 43
#define JIL_n1 44
#define JIL_n2 45
#define MARK_IF 46
#define MARK_ENDIF 47
#define JIL_J_COM 48
#define JIL_C_COM 49
#define JIL_CPP_COM 50
#define JIL_COM_LOC 51
#define MARK_UNSTRUCT 52
#define MORE_DEPTH 53
#define LESS_DEPTH 54
#define RET 55
#define JIL_CTRL 56
#define JIL_EXEC 57
#define JIL_NSC 59
#define ETYPE 58


