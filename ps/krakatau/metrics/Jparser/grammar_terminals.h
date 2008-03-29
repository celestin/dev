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

#include "y.tab.h"

extern int parse_ABSTRACT();
extern int parse_DEFAULT();
extern int parse_IF();
extern int parse_PRIVATE();
extern int parse_THROW();
extern int parse_BOOLEAN();
extern int parse_DO();
extern int parse_IMPLEMENTS();
extern int parse_PROTECTED();
extern int parse_THROWS();
extern int parse_BREAK();
extern int parse_DOUBLE();
extern int parse_IMPORT();
extern int parse_PUBLIC();
extern int parse_TRANSIENT();
extern int parse_BYTE();
extern int parse_ELSE();
extern int parse_INSTANCEOF();
extern int parse_RETURN();
extern int parse_TRY();
extern int parse_CASE();
extern int parse_EXTENDS();
extern int parse_INT();
extern int parse_SHORT();
extern int parse_VOID();
extern int parse_CATCH();
extern int parse_FINAL();
extern int parse_INTERFACE() ;
extern int parse_STATIC();
extern int parse_VOLATILE() ;
extern int parse_CHAR() ;
extern int parse_FINALLY() ;
extern int parse_LONG() ;
extern int parse_SUPER() ;
extern int parse_WHILE() ;
extern int parse_CLASS() ;
extern int parse_FLOAT() ;
extern int parse_NATIVE() ;
extern int parse_SWITCH() ;
extern int parse_CONST() ;
extern int parse_FOR() ;
extern int parse_NEW() ;
extern int parse_SYNCHRONIZED() ;
extern int parse_CONTINUE() ;
extern int parse_GOTO() ;
extern int parse_PACKAGE() ;
extern int parse_THIS() ;
extern int parse_STRING_LITERAL() ;
extern int parse_IDENTIFIER() ;
extern int parse_FLOATING_LITERAL() ;
extern int parse_INTEGER_LITERAL() ;
extern int parse_BOOLEAN_LITERAL() ;
extern int parse_CHARACTER_LITERAL() ;
extern int parse_ASSIGN() ;
extern int parse_GT() ;
extern int parse_LT() ;
extern int parse_NOT() ;
extern int parse_BIT_NOT() ;
extern int parse_QUERY() ;
extern int parse_COLON() ;
extern int parse_EQUALITY() ;
extern int parse_LE() ;
extern int parse_GE() ;
extern int parse_NE() ;
extern int parse_AND() ;
extern int parse_OR() ;
extern int parse_PLUSPLUS() ;
extern int parse_MINUSMINUS() ;
extern int parse_PLUS() ;
extern int parse_MINUS() ;
extern int parse_TIMES() ;
extern int parse_DIVIDE() ;
extern int parse_BIT_AND() ;
extern int parse_BIT_OR() ;
extern int parse_CARET() ;
extern int parse_MOD() ;
extern int parse_LEFT_SHIFT() ;
extern int parse_RIGHT_SHIFT() ;
extern int parse_GTGTGT() ;
extern int parse_PLUSEQUALS() ;
extern int parse_MINUSEQUALS() ;
extern int parse_TIMESEQUALS() ;
extern int parse_DIVEQUALS() ;
extern int parse_BIT_ANDEQUALS() ;
extern int parse_BIT_OREQUALS() ;
extern int parse_CARETEQUALS() ;
extern int parse_MODEQUALS() ;
extern int parse_LEFT_SHIFTEQUALS() ;
extern int parse_RIGHT_SHIFTEQUALS() ;
extern int parse_GTGTGTEQUALS() ;
extern int parse_LEFT_PARENTH() ;
extern int parse_RIGHT_PARENTH() ;
extern int parse_LEFT_BRACE() ;
extern int parse_RIGHT_BRACE() ;
extern int parse_LEFT_BRACKET() ;
extern int parse_RIGHT_BRACKET() ;
extern int parse_SEMICOLON() ;
extern int parse_COMMA() ;
extern int parse_DOT() ;
extern int parse_NULL_LITERAL();

void parse_COMMA_opt();
void parse_IDENTIFIER_opt();

