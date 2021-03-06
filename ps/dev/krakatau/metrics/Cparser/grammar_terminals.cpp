/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 * Krakatau C/C++ Parser (CPARSER.EXE)
 * Copyright (c) 2000,2008 Power Software
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * $Id$
 *
 * Who  When       Why
 * CAM  27-Mar-08  345 : File added to source control.
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

#include "types.h"
#include "y.tab.h"

extern int ptr;
extern int ntokens;
extern token* tokens;

#define PARSE_TERMINAL(X)   {if (((ptr+1)!=ntokens)&&(tokens[ptr+1].tok==X)) {ptr++;return 0;} else return (-1);}
#define PARSE_OPT_TERMINAL(X) {if (((ptr+1)!=ntokens)&&(tokens[ptr+1].tok==X)) ptr++; return;}
#define LOOK_TERMINAL(X)    {if (((ptr+1)!=ntokens)&&(tokens[ptr+1].tok==X)) return 0; else return -1;}

int parse_ASM() PARSE_TERMINAL(ASM);
int parse_AUTO() PARSE_TERMINAL(AUTO);
int parse_BOOL() PARSE_TERMINAL(BOOL);
int parse_BREAK() PARSE_TERMINAL(BREAK);
int parse_CASE() PARSE_TERMINAL(CASE);
int parse_CHAR() PARSE_TERMINAL(CHAR);
int parse_CLASS() PARSE_TERMINAL(CLASS);
int parse_CONST_CAST() PARSE_TERMINAL(CONST_CAST);
int parse_CONST() PARSE_TERMINAL(CONST);
int parse_CONTINUE() PARSE_TERMINAL(CONTINUE);
int parse_DEFAULT() PARSE_TERMINAL(DEFAULT);
int parse_DO() PARSE_TERMINAL(DO);
int parse_DOUBLE() PARSE_TERMINAL(DOUBLE);
int parse_DYNAMIC_CAST() PARSE_TERMINAL(DYNAMIC_CAST);
int parse_ELSE() PARSE_TERMINAL(ELSE);
int parse_ENUM() PARSE_TERMINAL(ENUM);
int parse_EXPLICIT() PARSE_TERMINAL(EXPLICIT);
int parse_EXPORT() PARSE_TERMINAL(EXPORT);
int parse_EXTERN() PARSE_TERMINAL(EXTERN);
int parse_FLOAT() PARSE_TERMINAL(FLOAT);
int parse_FOR() PARSE_TERMINAL(FOR);
int parse_FRIEND() PARSE_TERMINAL(FRIEND);
int parse_GOTO() PARSE_TERMINAL(GOTO);
int parse_IF() PARSE_TERMINAL(IF);
int parse_INLINE() PARSE_TERMINAL(INLINE);
int parse_INT() PARSE_TERMINAL(INT);
int parse_LONG() PARSE_TERMINAL(LONG);
int parse_OPERATOR() PARSE_TERMINAL(OPERATOR);
int parse_MUTABLE() PARSE_TERMINAL(MUTABLE);
int parse_NAMESPACE() PARSE_TERMINAL(NAMESPACE);
int parse_PRIVATE() PARSE_TERMINAL(PRIVATE);
int parse_PROTECTED() PARSE_TERMINAL(PROTECTED);
int parse_PUBLIC() PARSE_TERMINAL(PUBLIC);
int parse_REGISTER() PARSE_TERMINAL(REGISTER);
int parse_REINTERPRET_CAST() PARSE_TERMINAL(REINTERPRET_CAST);
int parse_RETURN() PARSE_TERMINAL(RETURN);
int parse_SHORT() PARSE_TERMINAL(SHORT);
int parse_SIGNED() PARSE_TERMINAL(SIGNED);
int parse_SIZEOF() PARSE_TERMINAL(SIZEOF);
int parse_STATIC_CAST() PARSE_TERMINAL(STATIC_CAST);
int parse_STATIC() PARSE_TERMINAL(STATIC);
int parse_STRUCT() PARSE_TERMINAL(STRUCT);
int parse_SWITCH() PARSE_TERMINAL(SWITCH);
int parse_TEMPLATE() PARSE_TERMINAL(TEMPLATE);
int parse_TRY() PARSE_TERMINAL(TRY);
int parse_CATCH() PARSE_TERMINAL(CATCH);
int parse_TYPEDEF() PARSE_TERMINAL(TYPEDEF);
int parse_TYPEID() PARSE_TERMINAL(TYPEID);
int parse_TYPENAME() PARSE_TERMINAL(TYPENAME);
int parse_UNION() PARSE_TERMINAL(UNION);
int parse_VOID() PARSE_TERMINAL(VOID);
int parse_VIRTUAL() PARSE_TERMINAL(VIRTUAL);
int parse_VOLATILE() PARSE_TERMINAL(VOLATILE);
int parse_WCHAR_T() PARSE_TERMINAL(WCHAR_T);
int parse_WHILE() PARSE_TERMINAL(WHILE);
int parse_USING() PARSE_TERMINAL(USING);
int parse_UNSIGNED() PARSE_TERMINAL(UNSIGNED);
int parse_NEW() PARSE_TERMINAL(NEW);
int parse_DELETE() PARSE_TERMINAL(DELETE);
int parse_THIS() PARSE_TERMINAL(THIS);
int parse_THROW() PARSE_TERMINAL(THROW);
int parse_IDENTIFIER() PARSE_TERMINAL(IDENTIFIER);
int parse_CONSTANT() PARSE_TERMINAL(CONSTANT);
int parse_STRING_LITERAL() PARSE_TERMINAL(STRING_LITERAL);
int parse_SCOPE() PARSE_TERMINAL(COLONCOLON);
int parse_ELLIPSIS() PARSE_TERMINAL(ELLIPSIS);
int parse_GREATGREATEQUALS() PARSE_TERMINAL(GREATGREATEQUALS);
int parse_LESSLESSEQUALS() PARSE_TERMINAL(LESSLESSEQUALS);
int parse_PLUSEQUALS() PARSE_TERMINAL(PLUSEQUALS);
int parse_MINUSEQUALS() PARSE_TERMINAL(MINUSEQUALS);
int parse_TIMESEQUALS() PARSE_TERMINAL(TIMESEQUALS);
int parse_DIVEQUALS() PARSE_TERMINAL(DIVEQUALS);
int parse_MODEQUALS() PARSE_TERMINAL(MODEQUALS);
int parse_ANDEQUALS() PARSE_TERMINAL(ANDEQUALS);
int parse_CARETEQUALS() PARSE_TERMINAL(CARETEQUALS);
int parse_BAREQUALS() PARSE_TERMINAL(BAREQUALS);
int parse_GREATERGREATER() PARSE_TERMINAL(GREATERGREATER);
int parse_LESSLESS() PARSE_TERMINAL(LESSLESS);
int parse_INC_OP() PARSE_TERMINAL(INC_OP);
int parse_DEC_OP() PARSE_TERMINAL(DEC_OP);
int parse_DOT_STAR() PARSE_TERMINAL(DOT_STAR);
int parse_PTR_OP_STAR() PARSE_TERMINAL(PTR_OP_STAR);
int parse_PTR_OP() PARSE_TERMINAL(PTR_OP);
int parse_AND_OP() PARSE_TERMINAL(AND_OP);
int parse_OR_OP() PARSE_TERMINAL(OR_OP);
int parse_LESSEQUALS() PARSE_TERMINAL(LESSEQUALS);
int parse_GREATEREQUALS() PARSE_TERMINAL(GREATEREQUALS);
int parse_EQUALS() PARSE_TERMINAL(EQUALS);
int parse_NOTEQUALS() PARSE_TERMINAL(NOTEQUALS);
int parse_SEMICOLON() PARSE_TERMINAL(';');
int parse_LEFTBRACE() PARSE_TERMINAL('{');
int parse_RIGHTBRACE() PARSE_TERMINAL('}');
int parse_COMMA() PARSE_TERMINAL(',');
int parse_COLON() PARSE_TERMINAL(':');
int parse_ASSIGN() PARSE_TERMINAL('=')
int parse_LEFTPARENTH() PARSE_TERMINAL('(');
int parse_RIGHTPARENTH() PARSE_TERMINAL(')');
int parse_LEFTBRACKET() PARSE_TERMINAL('[');
int parse_RIGHTBRACKET() PARSE_TERMINAL(']');
int parse_DOT() PARSE_TERMINAL('.');
int parse_AMPERSAND() PARSE_TERMINAL('&');
int parse_PLING() PARSE_TERMINAL('!');
int parse_TILDE() PARSE_TERMINAL('~');
int parse_MINUS() PARSE_TERMINAL('-');
int parse_PLUS() PARSE_TERMINAL('+');
int parse_TIMES() PARSE_TERMINAL('*');
int parse_DIVIDE() PARSE_TERMINAL('/');
int parse_PERCENT() PARSE_TERMINAL('%');
int parse_LESSTHAN() PARSE_TERMINAL(LT);
int parse_GREATERTHAN() PARSE_TERMINAL(GT);
int parse_CARET() PARSE_TERMINAL('^');
int parse_BAR() PARSE_TERMINAL('|');
int parse_QUERY() PARSE_TERMINAL('?');
void parse_ASM_opt() PARSE_OPT_TERMINAL(ASM);
void parse_AUTO_opt() PARSE_OPT_TERMINAL(AUTO);
void parse_BOOL_opt() PARSE_OPT_TERMINAL(BOOL);
void parse_BREAK_opt() PARSE_OPT_TERMINAL(BREAK);
void parse_CASE_opt() PARSE_OPT_TERMINAL(CASE);
void parse_CHAR_opt() PARSE_OPT_TERMINAL(CHAR);
void parse_CLASS_opt() PARSE_OPT_TERMINAL(CLASS);
void parse_CONST_CAST_opt() PARSE_OPT_TERMINAL(CONST_CAST);
void parse_CONST_opt() PARSE_OPT_TERMINAL(CONST);
void parse_CONTINUE_opt() PARSE_OPT_TERMINAL(CONTINUE);
void parse_DEFAULT_opt() PARSE_OPT_TERMINAL(DEFAULT);
void parse_DO_opt() PARSE_OPT_TERMINAL(DO);
void parse_DOUBLE_opt() PARSE_OPT_TERMINAL(DOUBLE);
void parse_DYNAMIC_CAST_opt() PARSE_OPT_TERMINAL(DYNAMIC_CAST);
void parse_ELSE_opt() PARSE_OPT_TERMINAL(ELSE);
void parse_ENUM_opt() PARSE_OPT_TERMINAL(ENUM);
void parse_EXPLICIT_opt() PARSE_OPT_TERMINAL(EXPLICIT);
void parse_EXPORT_opt() PARSE_OPT_TERMINAL(EXPORT);
void parse_EXTERN_opt() PARSE_OPT_TERMINAL(EXTERN);
void parse_FLOAT_opt() PARSE_OPT_TERMINAL(FLOAT);
void parse_FOR_opt() PARSE_OPT_TERMINAL(FOR);
void parse_FRIEND_opt() PARSE_OPT_TERMINAL(FRIEND);
void parse_GOTO_opt() PARSE_OPT_TERMINAL(GOTO);
void parse_IF_opt() PARSE_OPT_TERMINAL(IF);
void parse_INLINE_opt() PARSE_OPT_TERMINAL(INLINE);
void parse_INT_opt() PARSE_OPT_TERMINAL(INT);
void parse_LONG_opt()  PARSE_OPT_TERMINAL(LONG);
void parse_OPERATOR_opt() PARSE_OPT_TERMINAL(OPERATOR);
void parse_MUTABLE_opt()  PARSE_OPT_TERMINAL(MUTABLE);
void parse_NAMESPACE_opt() PARSE_OPT_TERMINAL(NAMESPACE);
void parse_PRIVATE_opt()  PARSE_OPT_TERMINAL(PRIVATE);
void parse_PROTECTED_opt() PARSE_OPT_TERMINAL(PROTECTED);
void parse_PUBLIC_opt() PARSE_OPT_TERMINAL(PUBLIC);
void parse_REGISTER_opt()  PARSE_OPT_TERMINAL(REGISTER);
void parse_REINTERPRET_CAST_opt()  PARSE_OPT_TERMINAL(REINTERPRET_CAST);
void parse_RETURN_opt()  PARSE_OPT_TERMINAL(RETURN);
void parse_SHORT_opt()  PARSE_OPT_TERMINAL(SHORT);
void parse_SIGNED_opt()  PARSE_OPT_TERMINAL(SIGNED);
void parse_SIZEOF_opt()  PARSE_OPT_TERMINAL(SIZEOF);
void parse_STATIC_CAST_opt()  PARSE_OPT_TERMINAL(STATIC_CAST);
void parse_STATIC_opt()  PARSE_OPT_TERMINAL(STATIC);
void parse_STRUCT_opt()  PARSE_OPT_TERMINAL(STRUCT);
void parse_SWITCH_opt() PARSE_OPT_TERMINAL(SWITCH);
void parse_TEMPLATE_opt()  PARSE_OPT_TERMINAL(TEMPLATE);
void parse_TRY_opt()  PARSE_OPT_TERMINAL(TRY);
void parse_CATCH_opt()  PARSE_OPT_TERMINAL(CATCH);
void parse_TYPEDEF_opt()  PARSE_OPT_TERMINAL(TYPEDEF);
void parse_TYPEID_opt()  PARSE_OPT_TERMINAL(TYPEID);
void parse_TYPENAME_opt()  PARSE_OPT_TERMINAL(TYPENAME);
void parse_UNION_opt()  PARSE_OPT_TERMINAL(UNION);
void parse_VOID_opt()  PARSE_OPT_TERMINAL(VOID);
void parse_VIRTUAL_opt()  PARSE_OPT_TERMINAL(VIRTUAL);
void parse_VOLATILE_opt()  PARSE_OPT_TERMINAL(VOLATILE);
void parse_WCHAR_T_opt()  PARSE_OPT_TERMINAL(WCHAR_T);
void parse_WHILE_opt()  PARSE_OPT_TERMINAL(WHILE);
void parse_USING_opt()  PARSE_OPT_TERMINAL(USING);
void parse_UNSIGNED_opt()  PARSE_OPT_TERMINAL(UNSIGNED);
void parse_NEW_opt()  PARSE_OPT_TERMINAL(NEW);
void parse_DELETE_opt()  PARSE_OPT_TERMINAL(DELETE);
void parse_THIS_opt()  PARSE_OPT_TERMINAL(THIS);
void parse_THROW_opt()  PARSE_OPT_TERMINAL(THROW);
void parse_IDENTIFIER_opt()  PARSE_OPT_TERMINAL(IDENTIFIER);
void parse_CONSTANT_opt()  PARSE_OPT_TERMINAL(CONSTANT);
void parse_STRING_LITERAL_opt()  PARSE_OPT_TERMINAL(STRING_LITERAL);
void parse_SCOPE_opt() PARSE_OPT_TERMINAL(COLONCOLON);
void parse_ELLIPSIS_opt() PARSE_OPT_TERMINAL(ELLIPSIS);
void parse_GREATGREATEQUALS_opt() PARSE_OPT_TERMINAL(GREATGREATEQUALS);
void parse_LESSLESSEQUALS_opt() PARSE_OPT_TERMINAL(LESSLESSEQUALS);
void parse_PLUSEQUALS_opt() PARSE_OPT_TERMINAL(PLUSEQUALS);
void parse_MINUSEQUALS_opt() PARSE_OPT_TERMINAL(MINUSEQUALS);
void parse_TIMESEQUALS_opt() PARSE_OPT_TERMINAL(TIMESEQUALS);
void parse_DIVEQUALS_opt() PARSE_OPT_TERMINAL(DIVEQUALS);
void parse_MODEQUALS_opt() PARSE_OPT_TERMINAL(MODEQUALS);
void parse_ANDEQUALS_opt() PARSE_OPT_TERMINAL(ANDEQUALS);
void parse_CARETEQUALS_opt() PARSE_OPT_TERMINAL(CARETEQUALS);
void parse_BAREQUALS_opt() PARSE_OPT_TERMINAL(BAREQUALS);
void parse_GREATERGREATER_opt() PARSE_OPT_TERMINAL(GREATERGREATER);
void parse_LESSLESS_opt() PARSE_OPT_TERMINAL(LESSLESS);
void parse_INC_OP_opt() PARSE_OPT_TERMINAL(INC_OP);
void parse_DEC_OP_opt() PARSE_OPT_TERMINAL(DEC_OP);
void parse_DOT_STAR_opt() PARSE_OPT_TERMINAL(DOT_STAR);
void parse_PTR_OP_STAR_opt() PARSE_OPT_TERMINAL(PTR_OP_STAR);
void parse_PTR_OP_opt() PARSE_OPT_TERMINAL(PTR_OP);
void parse_AND_OP_opt() PARSE_OPT_TERMINAL(AND_OP);
void parse_OR_OP_opt() PARSE_OPT_TERMINAL(OR_OP);
void parse_LESSEQUALS_opt() PARSE_OPT_TERMINAL(LESSEQUALS);
void parse_GREATEREQUALS_opt() PARSE_OPT_TERMINAL(GREATEREQUALS);
void parse_EQUALS_opt() PARSE_OPT_TERMINAL(EQUALS);
void parse_NOTEQUALS_opt() PARSE_OPT_TERMINAL(NOTEQUALS);
void parse_SEMICOLON_opt() PARSE_OPT_TERMINAL(';');
void parse_LEFTBRACE_opt() PARSE_OPT_TERMINAL('{');
void parse_RIGHTBRACE_opt() PARSE_OPT_TERMINAL('}');
void parse_COMMA_opt() PARSE_OPT_TERMINAL(',');
void parse_COLON_opt() PARSE_OPT_TERMINAL(':');
void parse_ASSIGN_opt() PARSE_OPT_TERMINAL('=');
void parse_LEFTPARENTH_opt() PARSE_OPT_TERMINAL('(');
void parse_RIGHTPARENTH_opt() PARSE_OPT_TERMINAL(')');
void parse_LEFTBRACKET_opt() PARSE_OPT_TERMINAL('[');
void parse_RIGHTBRACKET_opt() PARSE_OPT_TERMINAL(']');
void parse_DOT_opt() PARSE_OPT_TERMINAL('.');
void parse_AMPERSAND_opt() PARSE_OPT_TERMINAL('&');
void parse_PLING_opt() PARSE_OPT_TERMINAL('!');
void parse_TILDE_opt() PARSE_OPT_TERMINAL('~');
void parse_MINUS_opt() PARSE_OPT_TERMINAL('-');
void parse_PLUS_opt() PARSE_OPT_TERMINAL('+');
void parse_TIMES_opt() PARSE_OPT_TERMINAL('*');
void parse_DIVIDE_opt() PARSE_OPT_TERMINAL('/');
void parse_PERCENT_opt() PARSE_OPT_TERMINAL('%');
void parse_LESSTHAN_opt() PARSE_OPT_TERMINAL(LT);
void parse_GREATERTHAN_opt() PARSE_OPT_TERMINAL(GT);
void parse_CARET_opt() PARSE_OPT_TERMINAL('^');
void parse_BAR_opt() PARSE_OPT_TERMINAL('|');
void parse_QUERY_opt() PARSE_OPT_TERMINAL('?');

int look_ASM() LOOK_TERMINAL(ASM);
int look_AUTO() LOOK_TERMINAL(AUTO);
int look_BOOL() LOOK_TERMINAL(BOOL);
int look_BREAK() LOOK_TERMINAL(BREAK);
int look_CASE() LOOK_TERMINAL(CASE);
int look_CHAR() LOOK_TERMINAL(CHAR);
int look_CLASS() LOOK_TERMINAL(CLASS);
int look_CONST_CAST() LOOK_TERMINAL(CONST_CAST);
int look_CONST() LOOK_TERMINAL(CONST);
int look_CONTINUE() LOOK_TERMINAL(CONTINUE);
int look_DEFAULT() LOOK_TERMINAL(DEFAULT);
int look_DO() LOOK_TERMINAL(DO);
int look_DOUBLE() LOOK_TERMINAL(DOUBLE);
int look_DYNAMIC_CAST() LOOK_TERMINAL(DYNAMIC_CAST);
int look_ELSE() LOOK_TERMINAL(ELSE);
int look_ENUM() LOOK_TERMINAL(ENUM);
int look_EXPLICIT() LOOK_TERMINAL(EXPLICIT);
int look_EXPORT() LOOK_TERMINAL(EXPORT);
int look_EXTERN() LOOK_TERMINAL(EXTERN);
int look_FLOAT() LOOK_TERMINAL(FLOAT);
int look_FOR() LOOK_TERMINAL(FOR);
int look_FRIEND() LOOK_TERMINAL(FRIEND);
int look_GOTO() LOOK_TERMINAL(GOTO);
int look_IF() LOOK_TERMINAL(IF);
int look_INLINE() LOOK_TERMINAL(INLINE);
int look_INT() LOOK_TERMINAL(INT);
int look_LONG() LOOK_TERMINAL(LONG);
int look_OPERATOR() LOOK_TERMINAL(OPERATOR);
int look_MUTABLE() LOOK_TERMINAL(MUTABLE);
int look_NAMESPACE() LOOK_TERMINAL(NAMESPACE);
int look_PRIVATE() LOOK_TERMINAL(PRIVATE);
int look_PROTECTED() LOOK_TERMINAL(PROTECTED);
int look_PUBLIC() LOOK_TERMINAL(PUBLIC);
int look_REGISTER() LOOK_TERMINAL(REGISTER);
int look_REINTERPRET_CAST() LOOK_TERMINAL(REINTERPRET_CAST);
int look_RETURN() LOOK_TERMINAL(RETURN);
int look_SHORT() LOOK_TERMINAL(SHORT);
int look_SIGNED() LOOK_TERMINAL(SIGNED);
int look_SIZEOF() LOOK_TERMINAL(SIZEOF);
int look_STATIC_CAST() LOOK_TERMINAL(STATIC_CAST);
int look_STATIC() LOOK_TERMINAL(STATIC);
int look_STRUCT() LOOK_TERMINAL(STRUCT);
int look_SWITCH() LOOK_TERMINAL(SWITCH);
int look_TEMPLATE() LOOK_TERMINAL(TEMPLATE);
int look_TRY() LOOK_TERMINAL(TRY);
int look_CATCH() LOOK_TERMINAL(CATCH);
int look_TYPEDEF() LOOK_TERMINAL(TYPEDEF);
int look_TYPEID() LOOK_TERMINAL(TYPEID);
int look_TYPENAME() LOOK_TERMINAL(TYPENAME);
int look_UNION() LOOK_TERMINAL(UNION);
int look_VOID() LOOK_TERMINAL(VOID);
int look_VIRTUAL() LOOK_TERMINAL(VIRTUAL);
int look_VOLATILE() LOOK_TERMINAL(VOLATILE);
int look_WCHAR_T() LOOK_TERMINAL(WCHAR_T);
int look_WHILE() LOOK_TERMINAL(WHILE);
int look_USING() LOOK_TERMINAL(USING);
int look_UNSIGNED() LOOK_TERMINAL(UNSIGNED);
int look_NEW() LOOK_TERMINAL(NEW);
int look_DELETE() LOOK_TERMINAL(DELETE);
int look_THIS() LOOK_TERMINAL(THIS);
int look_THROW() LOOK_TERMINAL(THROW);
int look_IDENTIFIER() LOOK_TERMINAL(IDENTIFIER);
int look_CONSTANT() LOOK_TERMINAL(CONSTANT);
int look_STRING_LITERAL() LOOK_TERMINAL(STRING_LITERAL);
int look_SCOPE() LOOK_TERMINAL(COLONCOLON);
int look_ELLIPSIS() LOOK_TERMINAL(ELLIPSIS);
int look_GREATGREATEQUALS() LOOK_TERMINAL(GREATGREATEQUALS);
int look_LESSLESSEQUALS() LOOK_TERMINAL(LESSLESSEQUALS);
int look_PLUSEQUALS() LOOK_TERMINAL(PLUSEQUALS);
int look_MINUSEQUALS() LOOK_TERMINAL(MINUSEQUALS);
int look_TIMESEQUALS() LOOK_TERMINAL(TIMESEQUALS);
int look_DIVEQUALS() LOOK_TERMINAL(DIVEQUALS);
int look_MODEQUALS() LOOK_TERMINAL(MODEQUALS);
int look_ANDEQUALS() LOOK_TERMINAL(ANDEQUALS);
int look_CARETEQUALS() LOOK_TERMINAL(CARETEQUALS);
int look_BAREQUALS() LOOK_TERMINAL(BAREQUALS);
int look_GREATERGREATER() LOOK_TERMINAL(GREATERGREATER);
int look_LESSLESS() LOOK_TERMINAL(LESSLESS);
int look_INC_OP() LOOK_TERMINAL(INC_OP);
int look_DEC_OP() LOOK_TERMINAL(DEC_OP);
int look_DOT_STAR() LOOK_TERMINAL(DOT_STAR);
int look_PTR_OP_STAR() LOOK_TERMINAL(PTR_OP_STAR);
int look_PTR_OP() LOOK_TERMINAL(PTR_OP);
int look_AND_OP() LOOK_TERMINAL(AND_OP);
int look_OR_OP() LOOK_TERMINAL(OR_OP);
int look_LESSEQUALS() LOOK_TERMINAL(LESSEQUALS);
int look_GREATEREQUALS() LOOK_TERMINAL(GREATEREQUALS);
int look_EQUALS() LOOK_TERMINAL(EQUALS);
int look_NOTEQUALS() LOOK_TERMINAL(NOTEQUALS);
int look_SEMICOLON() LOOK_TERMINAL(';');
int look_LEFTBRACE() LOOK_TERMINAL('{');
int look_RIGHTBRACE() LOOK_TERMINAL('}');
int look_COMMA() LOOK_TERMINAL(',');
int look_COLON() LOOK_TERMINAL(':');
int look_ASSIGN() LOOK_TERMINAL('=')
int look_LEFTPARENTH() LOOK_TERMINAL('(');
int look_RIGHTPARENTH() LOOK_TERMINAL(')');
int look_LEFTBRACKET() LOOK_TERMINAL('[');
int look_RIGHTBRACKET() LOOK_TERMINAL(']');
int look_DOT() LOOK_TERMINAL('.');
int look_AMPERSAND() LOOK_TERMINAL('&');
int look_PLING() LOOK_TERMINAL('!');
int look_TILDE() LOOK_TERMINAL('~');
int look_MINUS() LOOK_TERMINAL('-');
int look_PLUS() LOOK_TERMINAL('+');
int look_TIMES() LOOK_TERMINAL('*');
int look_DIVIDE() LOOK_TERMINAL('/');
int look_PERCENT() LOOK_TERMINAL('%');
int look_LESSTHAN() LOOK_TERMINAL(LT);
int look_GREATERTHAN() LOOK_TERMINAL(GT);
int look_CARET() LOOK_TERMINAL('^');
int look_BAR() LOOK_TERMINAL('|');
int look_QUERY() LOOK_TERMINAL('?');
