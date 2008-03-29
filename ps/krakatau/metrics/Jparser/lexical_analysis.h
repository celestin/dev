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

#define INITIAL_MAX_LEXEMES 1000

extern void expand_lexeme_storage_array() ;
extern void store_lexeme(int,char*,int) ;
extern int symbol_is_identifier(int) ;
extern int lexical_analysis(char*) ;
extern int getCurrentLineNumber() ;
void errorFile(FILE*) ;
