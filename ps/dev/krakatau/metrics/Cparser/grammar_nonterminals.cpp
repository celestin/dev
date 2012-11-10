/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 * Krakatau C/C++ Parser (CPARSER.EXE)
 * Copyright (c) 2000,2008 Power Software
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * $Id$
 *
 * Who  When       Why
 * D01  02/10/2001 CAM  'default' should not affect McCabe cyclo.
 * CAM  27-Mar-08  345 : File added to source control.
 * CAM  27-Mar-08  345 : Corrected carriage-returns, POSIX naming and removed old commented-out code.
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

#include <stdio.h>
#include <string.h>
#include <fstream>
using namespace std ;

#include "types.h"
#include "y.tab.h"
#include <stack>
#include "parser.h"
#include "grammar.h"
#include "grammar_terminals.h"

extern int ptr;
extern int np;
extern int suppress;
extern int yylineno;
extern const int debug=0 ;
extern token *tokens;

extern code_type code;

int decl_ptr_operator();
extern int no_parenthesised_declarators;
int direct_declarator_with_params();
void fb_statement_seq_opt();
int declarator_with_params();

// ***************************************************

int asm_definition() {
  token tok;
  int old=ptr;
  int oldnp=np;

  tok=nexttok();
  if (tok.tok!=ASM) {ptr=old;np=oldnp;return(-1);}
  advance();tok=nexttok();
  if (tok.tok!='(') {ptr=old;np=oldnp;return(-1);}
  advance();tok=nexttok();
  if (tok.tok!=STRING_LITERAL) {ptr=old;np=oldnp;return(-1);}
  advance();tok=nexttok();
  if (tok.tok!=')') {ptr=old;np=oldnp;return(-1);}
  advance();tok=nexttok();
  if (tok.tok!=';') {ptr=old;np=oldnp;return(-1);}
  advance();
  return(0);
}

/* **************************************** */

int storage_class_specifier() {
  token tok=nexttok();

  advance();

  switch (tok.tok) {
    case AUTO:  return (0);
    case REGISTER: return (0);
    case STATIC: return (0);
    case EXTERN: return (0);
    case MUTABLE: return (0);
    default: unadvance();return (-1);
  };

}

/* **************************************** */

int lookahead_end_template_argument() {
  token tok=nexttok();

  if ((tok.tok==',')||(tok.tok==GT)) return (0);
  return (-1);
}

/* **************************************** */

int parse_enumerator () {
  if (!parse_IDENTIFIER()) return (0);
  return (-1);
}

/* **************************************** */

int enumerator_definition() {
  int old=ptr;
  int oldnp=np;

  if (!parse_enumerator()) {
    if (parse_ASSIGN()) return(0);
    if (!constant_expression()) return(0);
    ptr=old;
    np=oldnp;
    return(-1);
  } else {
    ptr=old;
    np=oldnp;
    return (-1);
  }
}

/* **************************************** */

void enumerator_list_opt (){
  int res;

  while (!the_end()) {
    res=enumerator_definition();
    if (res && parse_COMMA()) break;
  };
};

/* **************************************** */

int enum_specifier () {
  token tok;
  int old=ptr;
  int oldnp=np;

  tok=nexttok();
  if (tok.tok!=ENUM) {return (-1);};
  advance();
  parse_IDENTIFIER_opt();
  tok=nexttok();
  if (tok.tok!='{') {np=oldnp;ptr=old;return (-1);}
  advance();
  enumerator_list_opt();
  tok=nexttok();
  if (tok.tok!='}') {np=oldnp;ptr=old;return (-1);}

  advance();
  return (0);
}

/* **************************************** */

int type_id() {
  int old=ptr;
  int oldnp=np;

  if (!type_specifier_seq()) {
    abstract_declarator_opt();
    return (0);
  };

  ptr=old;np=oldnp;
  return (-1);
};

/* **************************************** */

int smart_type_id () {
  int old=ptr;
  int oldnp=np;

  if (inclusive_type_specifier_seq()) {ptr=old;np=oldnp;return(-1);};
  abstract_declarator_opt();
  return (0);
};

/* **************************************** */

int literal () {
  int oldnp=np;
  if (!parse_CONSTANT()) return (0);
  if (!parse_STRING_LITERAL()) return (0);
  np=oldnp;
  return (-1);
};

/* **************************************** */

int class_or_namespace_name () {
  int oldnp=np;

  if (!class_name()) return (0);
  if (!namespace_name()) return (0);

  np=oldnp;
  return (-1);
};

/* **************************************** */

int nested_name_specifier () {

int old=ptr;
int oldnp=np;

if (!class_or_namespace_name())
  if (!parse_SCOPE()) {
    old=ptr;oldnp=np;
    while (!class_or_namespace_name()) {
      if (parse_SCOPE()) {
        ptr=old;np=oldnp;return(0);
      } else {
        old=ptr;oldnp=np;
      }
    }
    ptr=old;np=oldnp;return(0);
  }

ptr=old;np=oldnp;
return(-1);

}

/* **************************************** */

void nested_name_specifier_opt() {
  (void)nested_name_specifier();
};

/* **************************************** */

int type_name () {
  if (!class_name()) return (0);
  if (!parse_IDENTIFIER()) return (0);
  return(-1);
};

/* **************************************** */

int inclusive_simple_type_specifier () {
  int old=ptr;
  int oldnp=np;
  int save;

  token tok=nexttok();
  advance();

  if (tok.tok==CHAR) {set_command(SYM_TYPE_ID,0,_strdup("char"),0,0,0);return (0);};
  if (tok.tok==WCHAR_T) {set_command(SYM_TYPE_ID,0,_strdup("wchar_t"),0,0,0);return (0);};
  if (tok.tok==BOOL) {set_command(SYM_TYPE_ID,0,_strdup("bool"),0,0,0);return (0);};
  if (tok.tok==SHORT) {set_command(SYM_TYPE_ID,0,_strdup("short"),0,0,0);return (0);};
  if (tok.tok==INT) {set_command(SYM_TYPE_ID,0,_strdup("int"),0,0,0);return (0);};
  if (tok.tok==LONG) {set_command(SYM_TYPE_ID,0,_strdup("long"),0,0,0);return (0);};
  if (tok.tok==SIGNED) {set_command(SYM_TYPE_ID,0,_strdup("signed"),0,0,0);return (0);};
  if (tok.tok==UNSIGNED) {set_command(SYM_TYPE_ID,0,_strdup("unsigned"),0,0,0);return (0);};
  if (tok.tok==FLOAT) {set_command(SYM_TYPE_ID,0,_strdup("float"),0,0,0);return (0);};
  if (tok.tok==DOUBLE) {set_command(SYM_TYPE_ID,0,_strdup("double"),0,0,0);return (0);};
  if (tok.tok==VOID) {set_command(SYM_TYPE_ID,0,_strdup("void"),0,0,0);return (0);};
  ptr=old;

  parse_SCOPE_opt();
  nested_name_specifier_opt();
  save=ptr;
  if (!type_name()) {
    set_command(SYM_TYPE_ID,0,sym_text(save,ptr),0,0,0);
    set_command(SYM_TYPE_NAME,0,sym_text(save,ptr),0,0,0);
    return (0);
  }

  ptr=old;np=oldnp;return(-1);
};


/* **************************************** */

int simple_type_specifier () {
  int old=ptr;
  token tok=nexttok();

  advance();
  if (tok.tok==CHAR)    {set_command(SYM_TYPE_ID,0,_strdup("char"),0,0,0);return (0);};
  if (tok.tok==WCHAR_T) {set_command(SYM_TYPE_ID,0,_strdup("wchar_t"),0,0,0);return (0);};
  if (tok.tok==BOOL)    {set_command(SYM_TYPE_ID,0,_strdup("bool"),0,0,0);return (0);};
  if (tok.tok==SHORT)   {set_command(SYM_TYPE_ID,0,_strdup("short"),0,0,0);return (0);};
  if (tok.tok==INT)     {set_command(SYM_TYPE_ID,0,_strdup("int"),0,0,0);return (0);};
  if (tok.tok==LONG)    {set_command(SYM_TYPE_ID,0,_strdup("long"),0,0,0);return (0);};
  if (tok.tok==SIGNED)  {set_command(SYM_TYPE_ID,0,_strdup("signed"),0,0,0);return (0);};
  if (tok.tok==UNSIGNED){set_command(SYM_TYPE_ID,0,_strdup("unsigned"),0,0,0);return (0);};
  if (tok.tok==FLOAT)   {set_command(SYM_TYPE_ID,0,_strdup("float"),0,0,0);return (0);};
  if (tok.tok==DOUBLE)  {set_command(SYM_TYPE_ID,0,_strdup("double"),0,0,0);return (0);};
  if (tok.tok==VOID)    {set_command(SYM_TYPE_ID,0,_strdup("void"),0,0,0);return (0);};

  ptr=old;
  return(-1);
};

/* **************************************** */

int class_key () {
  if (!parse_CLASS()) {
    set_command(BEGIN_CD,ptr,_strdup(""),thisline(),0,0);
    return (0);
  }
  if (!parse_STRUCT()) {
    set_command(BEGIN_SD,ptr,_strdup(""),thisline(),0,0);
    return (0);
  }
  if (!parse_UNION()) {
    set_command(BEGIN_UD,ptr,_strdup(""),thisline(),0,0);
    return (0);
  }
  return (-1);
};

/* **************************************** */

int zero () {
  token tok=nexttok();

  if (!strcmp(tok.str,"0")) {advance();return(0);};

  return (-1);
};

/* **************************************** */

int using_declaration () {
  int old=ptr;
  int oldnp=np;
  int save;

  if (parse_USING()) {ptr=old;np=oldnp;return(-1);};
  save=ptr;
  if (!parse_SCOPE()) {
    if (unqualified_id()) {ptr=save;goto u_d_l;};
    if (parse_SEMICOLON()) {ptr=save;goto u_d_l;};
    return(0);
  };
  u_d_l:
  parse_TYPENAME_opt();
  parse_SCOPE_opt();
  if (nested_name_specifier()) {ptr=old;np=oldnp;return(-1);};
  if (unqualified_id()) {ptr=old;np=oldnp;return(-1);};
  if (parse_SEMICOLON()) {ptr=old;np=oldnp;return(-1);};
  return(0);
};

/* **************************************** */

int using_directive () {
  int old=ptr;
  int oldnp=np;

  if (parse_USING()) {ptr=old;return(-1);};
  if (parse_NAMESPACE()) {ptr=old;return(-1);};
  parse_SCOPE_opt();
  nested_name_specifier_opt();
  if (namespace_name()) {ptr=old;np=oldnp;return(-1);};
  if (parse_SEMICOLON()) {ptr=old;np=oldnp;return(-1);};
  return(0);
}

/* **************************************** */

int namespace_alias_definition () {
  int old=ptr;
  int oldnp=np;

  if (parse_NAMESPACE()) {ptr=old;return(-1);};
  if (parse_IDENTIFIER()) {ptr=old;return(-1);};
  if (parse_ASSIGN()) {ptr=old;np=oldnp;return(-1);};
  if (qualified_namespace_specifier()) {ptr=old;np=oldnp;return(-1);};
  if (parse_SEMICOLON()) {ptr=old;np=oldnp;return(-1);};

  return(0);
};

/* **************************************** */

int qualified_namespace_specifier () {

int old=ptr;
int oldnp=np;

parse_SCOPE_opt();
nested_name_specifier_opt();
if (namespace_name()) {ptr=old;np=oldnp;return(-1);};

return(0);

};

/* **************************************** */

int namespace_definition () {

int oldnp=np;

if (!named_namespace_definition()) return (0);
if (!unnamed_namespace_definition()) return (0);

np=oldnp;
return (-1);
};

/* **************************************** */

int named_namespace_definition() {

int oldnp=np;

if (!original_namespace_definition()) return (0);
if (!extension_namespace_definition()) return (0);

np=oldnp;
return (-1);

};

/* **************************************** */

int original_namespace_definition () {

int old=ptr;
int oldnp=np;

if (parse_NAMESPACE()) {ptr=old;np=oldnp;return(-1);};
if (parse_IDENTIFIER()) {ptr=old;np=oldnp;return(-1);};
if (parse_LEFTBRACE()) {ptr=old;np=oldnp;return(-1);};
if (namespace_body()) {ptr=old;np=oldnp;return(-1);};
if (parse_RIGHTBRACE()) {ptr=old;np=oldnp;return(-1);};
return(0);

};

/* **************************************** */

int extension_namespace_definition () {

int old=ptr;
int oldnp=np;

if (parse_NAMESPACE()) {ptr=old;return(-1);};
if (original_namespace_name()) {ptr=old;return(-1);};
if (parse_LEFTBRACE()) {ptr=old;np=oldnp;return(-1);};
if (namespace_body()) {ptr=old;np=oldnp;return(-1);};
if (parse_RIGHTBRACE()) {ptr=old;np=oldnp;return(-1);};
return(0);

};

/* **************************************** */

int unnamed_namespace_definition () {

int old=ptr;
int oldnp=np;

if (parse_NAMESPACE()) {ptr=old;np=oldnp;return(-1);};
if (parse_LEFTBRACE()) {ptr=old;np=oldnp;return(-1);};
if (namespace_body()) {ptr=old;np=oldnp;return(-1);};
if (parse_RIGHTBRACE()) {ptr=old;np=oldnp;return(-1);};
return(0);

};

/* **************************************** */

int namespace_body () {

while (!declaration()) ;

return (0);

};

/* **************************************** */

int namespace_alias () {

if (!parse_IDENTIFIER()) return (0);
return (-1);

};

/* **************************************** */

int original_namespace_name () {

if (!parse_IDENTIFIER()) return (0);
return (-1);

};

/* **************************************** */

int namespace_name () {

if (!parse_IDENTIFIER()) return (0);

return(-1);

}

/* **************************************** */

int access_specifier() {

if (!parse_PRIVATE()) {
  set_command(PROTECTION_LEVEL,PRO_PRIVATE,_strdup(""),0,0,0);
  return(0);
  };
if (!parse_PROTECTED()) {
  set_command(PROTECTION_LEVEL,PRO_PROTECTED,_strdup(""),0,0,0);
  return(0);
  };
if (!parse_PUBLIC()) {
  set_command(PROTECTION_LEVEL,PRO_PUBLIC,_strdup(""),0,0,0);
  return (0);
  };
return(-1);
};

/* **************************************** */

void access_specifier_opt() {

int nowhere;

nowhere=access_specifier();

return;

};

/* **************************************** */

int class_name () {

int oldnp=np;

//printf("LOOK CLASS_NAME %d\n",ptr);
if (!template_id()) {
//  printf("GOT CLASS_NAME %d\n",ptr);
  return (0);
};
if (!parse_IDENTIFIER()) {/*printf("GOT CLASS_NAME %d\n",ptr);*/return (0);};
//printf("NOT GOT CLASS_NAME %d\n",ptr);
np=oldnp;
return(-1);

};

/* **************************************** */

int base_specifier () {

int old=ptr;
int oldnp=np;
int mark;

if (!parse_VIRTUAL()) {
  access_specifier_opt();
  mark=ptr;
  parse_SCOPE_opt();
  nested_name_specifier_opt();
  if (class_name()) {ptr=old;np=oldnp;return(-1);};
  set_command(ID,0,sym_text(mark,ptr),0,0,0);
  return (0);
};

if (!access_specifier()) {
  parse_VIRTUAL_opt();
  mark=ptr;
  parse_SCOPE_opt();
  nested_name_specifier_opt();
  if (class_name()) {ptr=old;np=oldnp;return(-1);};
  set_command(ID,0,sym_text(mark,ptr),0,0,0);
  return(0);
};
mark=ptr;
parse_SCOPE_opt();
nested_name_specifier_opt();
if (class_name()) {ptr=old;np=oldnp;return (-1);};
set_command(ID,0,sym_text(mark,ptr),0,0,0);
return (0);

};

/* **************************************** */

int base_specifier_list () {

int old=ptr;
int save;
int savenp;

set_command(BEGIN_BASES,0,_strdup(""),0,0,0);

if (base_specifier()) {
  ptr=old;
  set_command(END_BASES,0,_strdup(""),0,0,0);
  return(-1);
};

save=ptr;savenp=np;
while (!parse_COMMA()) {
  if (base_specifier()) {ptr=save;np=savenp;return(0);};
  old=ptr;
};
set_command(END_BASES,0,_strdup(""),0,0,0);
return (0);

};

/* **************************************** */

int base_clause() {

int old=ptr;
int savenp=np;

if (parse_COLON()) {ptr=old;return (-1);};
if (base_specifier_list()) {ptr=old;np=savenp;return(-1);};
return(0);

};

/* **************************************** */

void base_clause_opt() {

int nowhere;

nowhere=base_clause();

}

/* **************************************** */

int class_head() {

int old=ptr;
int oldnp=np;
int startcol=thiscol();
int line=thisline();

if (!nested_name_specifier()) {
  if (parse_IDENTIFIER()) {ptr=old;np=oldnp;return(-1);};
  set_command(ID,0,sym_text(old,ptr),line,startcol,lastcol());
  base_clause_opt();
  return(0);
};

if (!parse_IDENTIFIER())
  set_command(ID,0,sym_text(old,ptr),line,startcol,lastcol());

base_clause_opt();

if (look_LEFTBRACE()) {ptr=old;np=oldnp;return(-1);};

return(0);
}

/* **************************************** */

int pure_specifier() {

int old=ptr;

  if (parse_ASSIGN()) {ptr=old;return(-1);};
  if (zero()) {ptr=old;return(-1);};
  return(0);

};

/* **************************************** */

void pure_specifier_opt () {

int nowhere;

nowhere=pure_specifier();

return ;

};

/* **************************************** */

int constant_initializer() {

int old=ptr;
int oldnp=np;

  if (parse_ASSIGN()) {ptr=old;return(-1);};
  if (constant_expression()) {ptr=old;np=oldnp;return(-1);};
  return(0);

};

/* **************************************** */

void constant_initializer_opt() {

int nowhere;

nowhere=constant_initializer();

return ;

};

/* **************************************** */

int member_declarator () {

int old=ptr;
int oldnp=np;

set_command(BEGIN_MEMB_DECLARATOR,0,_strdup(""),0,0,0);
if (!declarator()) {
  pure_specifier_opt();
  constant_initializer_opt();
  set_command(END_MEMB_DECLARATOR,0,_strdup(""),0,0,0);
  return (0);
};
parse_IDENTIFIER_opt();
if (parse_COLON()) {ptr=old;np=oldnp;return(-1);};
if (constant_expression()) {ptr=old;np=oldnp;return(-1);};
set_command(END_MEMB_DECLARATOR,0,_strdup(""),0,0,0);
return(0);

}

/* **************************************** */

int member_declarator_list () {

int count=0;
int save;
int old=ptr;
int oldnp=np;

while (!member_declarator()) {
  count++;
  save=ptr;
  if (parse_COMMA()) {ptr=save;return(0);};
};
if (count) return (0);
ptr=old;np=oldnp;
return (-1);
}

/* **************************************** */

void member_declarator_list_opt () {

int nowhere;

nowhere=member_declarator_list();

return ;

};

/* **************************************** */

int member_declaration() {

// should this be in an ESSENCE enclosure?

int old=ptr;
int oldnp=np;

if (!parse_SEMICOLON())
  return (0);

// modified by GNS 31/5/99 for Chris Griffin to avoid output with this
if (!qualified_id())
  if (!look_SEMICOLON())  {
  np=oldnp;
    return (0);
  }
ptr=old;np=oldnp;

if (!function_definition())
  if (!parse_SEMICOLON()) {
    return (0);
  }
  else {
    return (0);
  }
ptr=old;np=oldnp;

if (!simple_declaration())
  return 0;
ptr=old;np=oldnp;

if (!class_specifier())
  return 0;

if (!using_declaration())
  return (0);

if (!template_declaration())
  return (0);

if (!function_definition())
  if (!parse_SEMICOLON())
    return (0);
  else
    return (0);
ptr=old;np=oldnp;
return(-1);

}

/* **************************************** */

int member_specification () {

int old=ptr;
int oldnp=np;

if (!access_specifier())
        if (!parse_COLON()) {
//      if (debug) printf("GOT MS %d\n",ptr);
      return (0);
    }

ptr=old;np=oldnp;

if (!member_declaration())
  return(0);

ptr=old;np=oldnp;
return(-1);

}

/* **************************************** */

void member_specification_opt () {

// try to get some member specs
// if we don't end up facing a '}', try to skip forward.  If we get a semicolon, go start again

int ttl;

mso_startagain:
while (!member_specification());
ttl=0;
if (look_RIGHTBRACE()) {   // if we are not facing this, there's a problem...minipanic?
  while ((look_RIGHTBRACE())&&(ttl<50)) {
 //   printf("SKIPPY2\n");
    if (!look_SEMICOLON()) goto mso_startagain;
    advance();ttl++;
  };
};

}

/* **************************************** */

int class_specifier() {

int old=ptr;
int oldnp=np;

if (class_key()) {ptr=old;return(-1);};

//set_command(BEGIN_CD,ptr,_strdup(""),thisline(),0,0);

if (class_head()) {
  ptr=old;np=oldnp;
  return(-1);
  };

set_command(MID_CD,0,_strdup(""),0,0,0);
set_command(PROTECTION_LEVEL,PRO_PRIVATE,_strdup(""),0,0,0);

if (parse_LEFTBRACE()) {
  ptr=old;np=oldnp;
  return(-1);
  }
member_specification_opt();

if (parse_RIGHTBRACE()) {
  ptr=old;np=oldnp;
  return(-1);
  }

/* joy to the world */
//if (debug) printf("------------------------ thisline() = %d\n",thisline());
set_command(END_CD,ptr,_strdup(""),tokens[ptr].line/*thisline()*/,0,0);
return (0);

}

/* **************************************** */

int inclusive_type_specifier() {

int old=ptr;
int oldnp=np;

if (!enum_specifier()) return (0);
if (!inclusive_simple_type_specifier()) return (0);
if (!class_specifier()) return (0);
if (!cv_qualifier()) return (0);
if (!elaborated_type_specifier()) return (0);

ptr=old;oldnp=np;
return(-1);

}

/* **************************************** */

int type_specifier () {

int old=ptr;
int oldnp=np;

if (!enum_specifier()) return (0);
if (!inclusive_simple_type_specifier()) return (0);
if (!class_specifier()) return (0);
if (!cv_qualifier()) return (0);
if (!elaborated_type_specifier()) return (0);

ptr=old;np=oldnp;
return(-1);
}

/* **************************************** */

void type_specifier_opt () {

(void)type_specifier();

}

/* **************************************** */

int elaborated_type_specifier () {

int old=ptr;
int save;
int oldnp=np;

if (!class_key()) {
  // added this to try to parse some declarations properly
  np=oldnp; // don't need the BEGIN_CD/BEGIN_UD/BEGIN_SD
  set_command(SYM_TYPE_ID,0,_strdup(tokens[ptr].str),0,0,0);

  parse_SCOPE_opt();
  nested_name_specifier_opt();
  if (!parse_IDENTIFIER()) {
    old=ptr;oldnp=np;
    if (!parse_LESSTHAN())
      if (!template_argument_list())
        if (!parse_GREATERTHAN())
          return (0);
    ptr=old;np=oldnp;return(0);
  }
  ptr=old;np=oldnp;
  return(-1);
}

if (!parse_ENUM()) {
  parse_SCOPE_opt();
  nested_name_specifier_opt();
  if (!parse_IDENTIFIER())  return(0);
}

ptr=old;np=oldnp;return(-1);
if (!parse_TYPENAME()) {
  parse_SCOPE_opt();
  if (nested_name_specifier()) {ptr=old;np=oldnp;return(-1);};
  if (parse_IDENTIFIER()) {ptr=old;np=oldnp;return(-1);};
  save=ptr;
  if (parse_LESSTHAN()) {ptr=save;return(0);};
  if (template_argument_list()) {ptr=save;return(0);};
  if (parse_GREATERTHAN()) {ptr=save;return(0);};
  return(0);
};

ptr=old;np=oldnp;
return (-1);

};

/* **************************************** */

int type_specifier_seq () {

int count=0;
int old=ptr;
int oldnp=np;

while (!type_specifier()) count++;
if (count) {
  return (0);};

ptr=old;np=oldnp;
return (-1);

};

/* **************************************** */

int inclusive_type_specifier_seq () {

int count=0;
int old=ptr;
int oldnp=np;

while (!inclusive_type_specifier()) count++;
if (count) {
  return (0);};
ptr=old;np=oldnp;
return (-1);

};

/* **************************************** */

int get_typedef() {

token tok;

tok=nexttok();

if (tok.tok!=TYPEDEF) {return(-1);};
set_command(TYPE_SYNONYM,0,_strdup(""),0,0,0);
advance();
return (0);

};

/* **************************************** */

int function_specifier() {

int old=ptr;
token tok;

tok=nexttok();
advance();
if (tok.tok==INLINE) return (0);
if (tok.tok==VIRTUAL) return (0);
if (tok.tok==EXPLICIT) return (0);
unadvance();
ptr=old;
return(-1);

};

/* **************************************** */

int parenthesised_abstract_declarator() {

int old=ptr;
int oldnp=np;

if (parse_LEFTPARENTH()) {ptr=old;return (-1);};
if (abstract_declarator()) {ptr=old;return (-1);};
if (parse_RIGHTPARENTH()) {ptr=old;np=oldnp;return (-1);};

return (0);

}

/* **************************************** */

int parenthesised_declarator () {

int old=ptr;
int oldnp=np;

if (parse_LEFTPARENTH()) {ptr=old;return (-1);};
if (declarator()) {ptr=old;np=oldnp;return (-1);};
if (parse_RIGHTPARENTH()) {ptr=old;np=oldnp;return(-1);};

return (0);

}


/* **************************************** */

int abstract_declarator () {

int old=ptr;
int oldnp=np;
int count =0 ;

while (!decl_ptr_operator()) count++;       /* soak up the ptr_operators */

if (!direct_abstract_declarator()) return (0);
if (count)  return (0);

ptr=old;np=oldnp;
return(-1);

};

/* **************************************** */

void abstract_declarator_opt () {

int nowhere;

nowhere = abstract_declarator ();

return ;

}

/* **************************************** */

int direct_abstract_declarator() {

int old=ptr;
int oldnp=np;

if (!decl_param_part()) return (0);
if (!decl_const_part()) return (0);
if (!parenthesised_abstract_declarator()) {
  while ( (!decl_param_part()) || (!decl_const_part())) ;
  return (0);
};

ptr=old;np=oldnp;
return (-1);

}

/* **************************************** */

void parse_extra_decl_spec () {

int old=ptr;
int oldnp=np;
int line=thisline();
int startcol=thiscol();

parse_SCOPE_opt();
nested_name_specifier_opt();
if (type_name()) {np=oldnp; ptr=old;};
if (ptr!=old) {
  set_command(SYM_TYPE_ID,0,sym_text(old,ptr),line,startcol,lastcol());
}

}

/* **************************************** */

int decl_specifier() {

if (!get_typedef()) return (0);
if (!parse_FRIEND()) return (0);
if (!storage_class_specifier()) return(0);
if (!type_specifier()) return (0);
if (!function_specifier()) return (0);

return(-1);

}

/* **************************************** */

int param_decl_specifier_seq () {

int old=ptr;
int oldnp=np;

int count=0;

while (!decl_specifier()) count++;

if (count) return (0);

ptr=old;np=oldnp;
return(-1);

};

/* **************************************** */

int decl_specifier_seq () {

int count=0;
int old=ptr;
int oldnp=np;

while (!decl_specifier()) count++;
if (count) return (0);
ptr=old;np=oldnp;
return(-1);

};

/* **************************************** */

void decl_specifier_seq_opt() {

int nowhere;

//set_command(decl_specifier_seq_opt_begin,0,_strdup(""),0,0,0);
nowhere=decl_specifier_seq();
//set_command(decl_specifier_seq_opt_end,0,_strdup(""),0,0,0);
return;

}

/* **************************************** */

void init_declarator_list_opt() {

int nowhere;

nowhere=init_declarator_list();

}

/* **************************************** */

int sing_init_declarator_list();

void sing_init_declarator_list_opt() {

(void)sing_init_declarator_list();

}

/* **************************************** */

void param_dss_opt(int);

int simple_declaration () {

int old=ptr;
int oldnp=np;
int npsave=np;
int npsaveb,saveb;
int line=thisline();
int startcol=thiscol();
int i;

set_command(BEGIN_SIMPLE_DECL,0,_strdup(""),line,startcol,lastcol());
npsave=np;

if (!enum_specifier()) {
  if (!look_SEMICOLON()) {
    set_command(END_SIMPLE_DECL,0,_strdup(""),line,startcol,lastcol());
    return 0;
  }
}

ptr=old;np=npsave;

if (!look_SEMICOLON()) {
  set_command(END_SIMPLE_DECL,0,_strdup(""),line,startcol,lastcol());
//  fprintf(stderr,"SIMP D %d\n",ptr);
  if (!parse_SEMICOLON()) return 0;
  return (0);
}

for (i=0;i<=2;i++) {
  if (i==0) param_dss_opt(0);
  else param_dss_opt(1);
  npsaveb=np;saveb=ptr;
  if (!init_declarator_list())
    if ((!look_SEMICOLON())||(!look_COMMA())) {
      set_command(END_SIMPLE_DECL,0,_strdup(""),line,startcol,lastcol());
  return 0;
    };
  np=npsaveb;ptr=saveb;
};

ptr=old;np=npsave;
for (i=0;i<=2;i++) {
  if (i==0) param_dss_opt(0);
  else param_dss_opt(1);
  if (ptr>old) {
    set_command(END_SIMPLE_DECL,0,_strdup(""),line,startcol,lastcol());
  };
};

ptr=old;np=oldnp;return (-1);

}

/* ***************************************** */

int local_variable_declaration_statement() {

int old=ptr;
int oldnp=np;
int npsave=np;
int npsaveb,saveb;
int line=thisline();
int startcol=thiscol();
int i;

set_command(BEGIN_SIMPLE_DECL,0,_strdup(""),line,startcol,lastcol());
npsave=np;

if (!enum_specifier()) {
  if (!look_SEMICOLON()) {
    set_command(END_SIMPLE_DECL,0,_strdup(""),line,startcol,lastcol());
    return 0;
  }
}

ptr=old;np=npsave;

if (!look_SEMICOLON()) {
        set_command(END_SIMPLE_DECL,0,_strdup(""),line,startcol,lastcol());
//      fprintf(stderr,"SIMP D %d\n",ptr);
        if (!parse_SEMICOLON()) return 0;
        return (0);
}

for (i=0;i<=2;i++) {
  if (i==0) param_dss_opt(1);
  else param_dss_opt(1);
  npsaveb=np;saveb=ptr;
  no_parenthesised_declarators=0;
  if (!init_declarator_list()) {
    no_parenthesised_declarators=0;
    if ((!look_SEMICOLON())||(!look_COMMA())) {
        set_command(END_SIMPLE_DECL,0,_strdup(""),line,startcol,lastcol());
        return 0;
    };
  }
  no_parenthesised_declarators=0;
  np=npsaveb;ptr=saveb;
};

ptr=old;np=npsave;
for (i=0;i<=2;i++) {
  if (i==0) param_dss_opt(1);
  else param_dss_opt(1);
  if (ptr>old) {
    set_command(END_SIMPLE_DECL,0,_strdup(""),line,startcol,lastcol());
  };
};

ptr=old;np=oldnp;return (-1);

}

/* ******************************************* */

int single_pointer_declaration_statement() {

// just like simple_declaration but ensures decl_specifiers
int old=ptr;
int npsave=np;
int line=thisline();
int startcol=thiscol();

set_command(BEGIN_SIMPLE_DECL,0,_strdup(""),line,startcol,lastcol());

// d_s_s i_d_l
ptr=old;np=npsave;
set_command(BEGIN_SIMPLE_DECL,0,_strdup(""),line,startcol,lastcol());
if (!decl_specifier_seq()) {
  //if (debug) printf("SING 1A %s\n",sym_text(old,ptr));
  if (ptr>old)
    if (!sing_init_declarator_list()) {
      set_command(END_SIMPLE_DECL,0,_strdup(""),line,startcol,lastcol());
      //if (debug) printf("SING A %s\n",sym_text(old,ptr));
      return (0);
    }
}
// d_s_s BS i_d_l
ptr=old;np=npsave;
set_command(BEGIN_SIMPLE_DECL,0,_strdup(""),line,startcol,lastcol());
if (!decl_specifier_seq()) {
  if ((ptr>old)&&(np>npsave)) {ptr--;np--;}
    if (ptr>old) {
      sing_init_declarator_list_opt();
      set_command(END_SIMPLE_DECL,0,_strdup(""),line,startcol,lastcol());
      if ((!look_SEMICOLON())||(!look_COMMA())) {
        //if (debug) printf("SING B %s\n",sym_text(old,ptr));
        return 0;
      }
    }
}
ptr=old;np=npsave;return (-1);

}

/* ***************************************** */

int block_declaration () {

int old=ptr;
int oldnp=np;

//if (!type_definition()) return (0);

// 15/6/98
if (!function_definition()) return 0;

// record simple declarations
if (!simple_declaration()) return (0);

// don't do much with asm's
if (!asm_definition()) return (0);

if (!namespace_alias_definition()) return (0);

if (!using_declaration()) return (0);

if (!using_directive()) return (0);

ptr=old;np=oldnp;
return(-1);

};

int k_and_r_block_declaration () {

int old=ptr;
int oldnp=np;

//if (!type_definition()) return (0);


// record simple declarations
if (!simple_declaration()) return (0);

// don't do much with asm's
if (!asm_definition()) return (0);

if (!namespace_alias_definition()) return (0);

if (!using_declaration()) return (0);

if (!using_directive()) return (0);

ptr=old;np=oldnp;
return(-1);

};


/* ***************************************** */

int fb_compound_statement() {
// includes class specifiers...

int old=ptr;
int oldnp=np;

if (parse_LEFTBRACE()) {ptr=old;np=oldnp;return(-1);};

fb_statement_seq_opt();

if (parse_RIGHTBRACE()) {ptr=old;np=oldnp;return -1;};
return(0);

};

int compound_statement () {

int old=ptr;
int oldnp=np;

if (parse_LEFTBRACE()) {ptr=old;np=oldnp;return(-1);};
statement_seq_opt();
//if (parse_RIGHTBRACE()) {
  //while ( > original bracedepth and not end of lexemes)
    // nudge forward to brace or end of lexemes
    // ????
//  ptr=old;np=oldnp;
//  bracedepth--;
//  return(-1);
//  };
/*
if (parse_RIGHTBRACE()) {
  depth=1;
  while ((depth>0)&&(!the_end())) {
    if (!parse_LEFTBRACE())
      ptr++,depth++;
    else if (!look_RIGHTBRACE())
      depth--;
    else
      ptr++;
  };
};
*/
if (parse_RIGHTBRACE()) {ptr=old;np=oldnp;return -1;};
return(0);

};

/* ***************************************** */

int labeled_statement () {

int old=ptr;
int oldnp=np;

if (!parse_IDENTIFIER()) {
  set_command(LABEL,0,sym_text(old,ptr),0,0,0);
  if (parse_COLON()) {ptr=old;np=oldnp;return(-1);};
  if (statement()) {ptr=old;np=oldnp;return(-1);};
  return(0);
};
if (!parse_CASE()) {
  set_command(MORE_DEPTH,0,_strdup(""),0,0,0);
  set_command(BEGIN_EXPRESSION,0,_strdup(""),0,0,0);
  if (constant_expression()) {ptr=old;np=oldnp;return(-1);};
  set_command(END_EXPRESSION,0,_strdup(""),0,0,0);
  if (parse_COLON()) {ptr=old;np=oldnp;return(-1);};
  if (statement()) {ptr=old;np=oldnp;return(-1);};
  set_command(CYCLO,0,_strdup(""),0,0,0);
  set_command(LESS_DEPTH,0,_strdup(""),0,0,0);
  return(0);
};
if (!parse_DEFAULT()) {
  set_command(MORE_DEPTH,0,_strdup(""),0,0,0);
  if (parse_COLON()) {ptr=old;np=oldnp;return(-1);};
  if (statement()) {ptr=old;np=oldnp;return(-1);};
  // D01 Begin -------------------------------------------
  // default case should not affect cyclomatic complexity
  //set_command(CYCLO,0,_strdup(""),0,0,0);
  // D01 End ---------------------------------------------
  set_command(LESS_DEPTH,0,_strdup(""),0,0,0);
  return(0);
};
ptr=old;np=oldnp;
return(-1);
};

/* ***************************************** */

int expression_statement() {

  //debugging
  //step1

  int old=ptr;
  int oldnp=np;

  expression_opt();
  if (parse_SEMICOLON()) {ptr=old;np=oldnp;return(-1);};

  if (ptr-old==1)
    density.top()->executable--;

  return(0);
}

/* ***************************************** */

int jump_statement () {

int old=ptr;
int oldnp=np;

if (!parse_BREAK()) {
  if (parse_SEMICOLON()) {ptr=old;return(-1);};
  set_command(MARK_UNSTRUCT,0,_strdup(""),0,0,0);
  return(0);
};
if (!parse_CONTINUE()) {
  if (parse_SEMICOLON()) {ptr=old;return(-1);};
  set_command(MARK_UNSTRUCT,0,_strdup(""),0,0,0);
  return(0);
};
if (!parse_RETURN()) {
  expression_opt();
  if (parse_SEMICOLON()) {ptr=old;np=oldnp;return(-1);};
  set_command(RET,0,_strdup(""),0,0,0);
  return(0);
};
if (!parse_GOTO()) {
  if (parse_IDENTIFIER()) {ptr=old;return(-1);};
  if (parse_SEMICOLON()) {ptr=old;np=oldnp;return(-1);};
  set_command(MARK_UNSTRUCT,0,_strdup(""),0,0,0);
  return(0);
};
ptr=old;np=oldnp;
return(-1);
};

/* ***************************************** */

int for_init_statement() {

int old=ptr;
int oldnp=np;

if (!expression_statement()) return (0);
if (!simple_declaration()) return (0);
ptr=old;np=oldnp;
return (-1);

};

/* ***************************************** */

int condition() {

  int old=ptr;
  int oldnp=np;

  if (!expression())
    return 0;

  ptr=old;
  np=oldnp;

  if (!type_specifier_seq())
    if (!declarator())
      if (!parse_ASSIGN())
        if (!assignment_expression())
          return 0;

  ptr=old;
  np=oldnp;

  if (!type_specifier_seq()) {
    if ((ptr>old)&&(np>oldnp)) {
      ptr-- ;
      np-- ;
    }
    if (!declarator())
      if (!parse_ASSIGN())
        if (!assignment_expression())
          return 0;
  }

  ptr=old ;
  np=oldnp ;
  return -1 ;

/*

int old=ptr;
int oldnp=np;
int temp;
int tempnp;
int save;

if (type_specifier_seq()) {
  temp=ptr;tempnp=np;
  parse_extra_decl_spec();
  if (ptr==temp) {
    ptr=old;np=oldnp;
    goto cond_next;
  }
  if (declarator()) {
    ptr=old;np=oldnp;
    goto cond_next;
  }
  if (parse_EQUALS()) {
    ptr=old;np=oldnp;
    goto cond_next;
  }
  if (assignment_expression()) {
    ptr=old;np=oldnp;
    goto cond_next;
  }
  return (0);
};
save=ptr;tempnp=np;
if (declarator()) goto cond_extra;
if (parse_EQUALS()) {ptr=save;np=tempnp;goto cond_extra;}
if (assignment_expression()) {ptr=save;np=tempnp;goto cond_extra;}
return (0);
cond_extra:
parse_extra_decl_spec();
  if (declarator()) {
    ptr=old;np=oldnp;
    goto cond_next;
  }
  if (parse_EQUALS()) {
    ptr=old;np=oldnp;
    goto cond_next;
  }
  if (assignment_expression()) {
    ptr=old;np=oldnp;
    goto cond_next;
  }
  return (0);
cond_next:
if (expression()) {ptr=old;np=oldnp;return(-1);}
return (0);
*/
};

/* ***************************************** */

void condition_opt() {

int nowhere;

nowhere=condition();

return ;

};

/* ***************************************** */

int iteration_statement () {

int old=ptr;
int oldnp=np;

if (!parse_WHILE()) {
  set_command(MORE_DEPTH,0,_strdup(""),0,0,0);
  if (parse_LEFTPARENTH()) {ptr=old;np=oldnp;return(-1);};
  if (condition()) {ptr=old;np=oldnp;return(-1);};
  if (parse_RIGHTPARENTH()) {ptr=old;np=oldnp;return(-1);};
  if (statement()) {ptr=old;np=oldnp;return(-1);};
  set_command(CYCLO,0,_strdup(""),0,0,0);
  set_command(LESS_DEPTH,0,_strdup(""),0,0,0);
  return (0);
};

if (!parse_DO()) {
  set_command(MORE_DEPTH,0,_strdup(""),0,0,0);
  if (statement()) {ptr=old;np=oldnp;return (-1);};
  if (parse_WHILE()) {ptr=old;np=oldnp;return (-1);};
  if (parse_LEFTPARENTH()) {ptr=old;np=oldnp;return (-1);};
  if (expression()) {ptr=old;np=oldnp;return (-1);};
  if (parse_RIGHTPARENTH ()) {ptr=old;np=oldnp;return (-1);};
  if (parse_SEMICOLON()) {ptr=old;np=oldnp;return(-1);};
  set_command(CYCLO,0,_strdup(""),0,0,0);
  set_command(LESS_DEPTH,0,_strdup(""),0,0,0);
  return (0);
};

if (!parse_FOR()) {
  if (parse_LEFTPARENTH()) {ptr=old;return (-1);};
  set_command(MORE_DEPTH,0,_strdup(""),0,0,0);
  (void)for_init_statement();
  parse_SEMICOLON_opt();
  condition_opt();
  parse_SEMICOLON_opt();
  //if (semicolon()) {ptr=old;np=oldnp;return (-1);};
  expression_opt();
  if (parse_RIGHTPARENTH()) {ptr=old;np=oldnp;return(-1);};
  if (statement()) {ptr=old;np=oldnp;return (-1);};
  set_command(LESS_DEPTH,0,_strdup(""),0,0,0);
  set_command(CYCLO,0,_strdup(""),0,0,0);
  return (0);
};

ptr=old;np=oldnp;
return (-1);
};

/* ***************************************** */

int declaration_statement () {

int oldnp=np;

if (!block_declaration()) return (0);
if (!function_definition()) return (0); // C but not C++
np=oldnp;
return (-1);

};

/* ***************************************** */

int k_and_r_declaration_statement () {

int oldnp=np;

if (!k_and_r_block_declaration()) return (0);
np=oldnp;
return (-1);

};


/* ***************************************** */

int else_part() {

int old=ptr;
int oldnp=np;

if (!parse_ELSE()) {
  if (statement()) {ptr=old;np=oldnp;return(-1);};
  return(0);
};

ptr=old;np=oldnp;
return(-1);

};

/* ***************************************** */

void else_part_opt() {

int nowhere;

nowhere=else_part();

return ;

};

/* ***************************************** */

int selection_statement() {

  int old=ptr;
  int oldnp=np;

  if (!parse_SWITCH()) {
    if (parse_LEFTPARENTH()) {ptr=old;return(-1);};
    set_command(BEGIN_EXPRESSION,0,_strdup(""),0,0,0);
    if (condition()) {ptr=old;return(-1);};
    set_command(END_EXPRESSION,0,_strdup(""),0,0,0);
    if (parse_RIGHTPARENTH()) {ptr=old;np=oldnp;return(-1);};
    if (statement()) {ptr=old;np=oldnp;return(-1);};
    return(0);
  }

  if (!parse_IF()) {
    set_command(MORE_DEPTH,0,_strdup(""),0,0,0);
    set_command(MARK_IF,0,_strdup(""),0,0,0);
    if (parse_LEFTPARENTH()) {ptr=old;np=oldnp;return(-1);};
    if (condition()) {ptr=old;np=oldnp;return(-1);};
    if (parse_RIGHTPARENTH()) {ptr=old;np=oldnp;return(-1);};
    if (statement()) {ptr=old;np=oldnp;return(-1);};
    else_part_opt();
    set_command(MARK_ENDIF,0,_strdup(""),0,0,0);
    set_command(LESS_DEPTH,0,_strdup(""),0,0,0);
    set_command(CYCLO,0,_strdup(""),0,0,0);
    return(0);
  }

  ptr=old;np=oldnp;
  return (-1);

}

/* ***************************************** */

int statement () {
// 26/6/98
  //if (!single_pointer_declaration_statement()) return 0;

// 15/2/99
//  if (!local_variable_declaration_statement()) return 0;

  // debugging
  // Almost certainly called from here
  // possible fix would be to switch the top two lines.

  // Testing: The following two lines have been switch

  if (!local_variable_declaration_statement()) return 0;
  if (!expression_statement())  {density.top()->executable++;return (0);};

  if (!labeled_statement())     {density.top()->executable++;return (0);};
  if (!compound_statement())    {density.top()->executable++;return (0);};
  if (!selection_statement())   {density.top()->control++;   return (0);};
  if (!iteration_statement())   {density.top()->control++;   return (0);};
  if (!jump_statement())        {density.top()->control++;   return (0);};
  if (!declaration_statement()) {                            return (0);};
  if (!try_block())             {density.top()->control++;   return (0);};
  return (-1);

}

/* ***************************************** */

int statement_seq () {

int old=ptr;
int oldnp=np;
int count=0;
int save,ttl;

while (!statement()) count++;
if (look_RIGHTBRACE()) {
  ttl=0;save=ptr;
  while ((look_RIGHTBRACE())&&(ttl<50)&&(!the_end())) {
 //   printf("SKIPPY3\n");
    ttl++,ptr++;
  };
  if (ttl==50) ptr=save;
};
if (count>0) return 0;
ptr=old;np=oldnp;
return -1;

};

// **********************************************

int fb_statement_seq () {

int old=ptr;
int oldnp=np;
int count=0;
int save,ttl;

while ((!statement())||(!class_specifier()))
  count++;

if (look_RIGHTBRACE()) {
  ttl=0;save=ptr;
  while ((look_RIGHTBRACE())&&(ttl<50)&&(!the_end())) {
 //   printf("SKIPPY3\n");
    ttl++,ptr++;
  };
  if (ttl==50) ptr=save;
};
if (count>0) return 0;
ptr=old;np=oldnp;
return -1;

}

/* ***************************************** */

void statement_seq_opt() {

int nowhere;

nowhere=statement_seq();

};

void fb_statement_seq_opt() {

(void)fb_statement_seq();

}

/* **************************************** */

void k_and_r_params_opt() {

(void)k_and_r_parameter_declaration_clause();

};

/* **************************************** */

int function_definition() {

int old=ptr;
int tmp;
int oldnp=np;
int npsave,save,saveb,npsaveb;
int i;
int before;
halstead h;
control_exec* current_density;
int nsc=0 ; // No. Semicolon count - added CAM 09/05/2001

// for these, must compute Halstead

set_command(BEGIN_FDEF,0,_strdup(""),thisline(),thiscol(),0);

for (i=0;i<=2;i++) {
  if (i==0) param_dss_opt(0);
  else param_dss_opt(1);
  save=ptr;npsave=np;

  if (!declarator_with_params()) {
    /*fprintf(stderr,"DECLARATOR_WITH_PARAMS: %s\n",sym_text(save,ptr));
    gstmp=ptr;
    exception_specification_opt();
    if (gstmp!=ptr)
      fprintf(stderr,"EXCEPTION: %s\n",sym_text(gstmp,ptr));*/

    saveb=ptr;npsaveb=np ;
    ctor_initializer_opt() ;
    before=ptr ;
    k_and_r_params_opt() ;
    if (ptr>before)
      parse_SEMICOLON_opt() ;

    // must set up a current function scope for number of
  // control statements, executable statements
    current_density=new control_exec;
    current_density->control=0;
    current_density->executable=0;
    density.push(current_density);

    // HOW DO WE HANDLE BACKTRACKING AND CONTROL DENSITY!!????

    tmp=ptr;
    if (!function_body()) {
      h=compute_halstead(tmp,ptr) ;
      set_command(END_FDEF,h.N1,(char*)(tokens[ptr].line)/*thisline()*/,h.N2,h.n1,h.n2) ;
      set_command(END_FDEF,density.top()->control,_strdup(""),density.top()->executable,h.nsc,0) ;
      density.pop() ;
      return 0 ;
    };

    ptr=saveb;np=npsaveb;
    tmp=ptr;

    if (!function_try_block()) {
      h=compute_halstead(tmp,ptr);
      set_command(END_FDEF,h.N1,(char*)(tokens[ptr].line)/*thisline()*/,h.N2,h.n1,h.n2);
      set_command(END_FDEF,density.top()->control,_strdup(""),density.top()->executable,h.nsc,0);
      density.pop();
      return 0;
    };
  };
  ptr=save;np=npsave;
};

ptr=old;np=oldnp;
return -1;

}

/* ***************************************** */

int function_body () {

int ttl;
int old=ptr;
int oldnp=np;

set_command(BEGIN_FBODY,0,_strdup(""),0,0,0);
if (!fb_compound_statement()) {set_command(END_FBODY,0,_strdup(""),0,0,0);return 0;};

ttl=0;
ptr=old;np=oldnp;
return -1;

}

/* ***************************************** */

int ctor_initializer() {

int old=ptr;

if (parse_COLON()) {ptr=old;return(-1);};
if (mem_initializer_list()) {ptr=old;return(-1);};
return (0);

}

/* ***************************************** */

void ctor_initializer_opt () {

int nowhere;

nowhere=ctor_initializer();

return ;

}

/* ***************************************** */

int mem_initializer_list () {

int old=ptr;
int count=0;

while (!mem_initializer()) {
count++;

if (parse_COMMA()) goto out;
};

out:
if (count) return (0);

ptr=old;
return (-1);

}

/* ***************************************** */

int mem_initializer() {

int old=ptr;
int oldnp=np;

if (mem_initializer_id()) {ptr=old;return (-1);};
if (parse_LEFTPARENTH()) {ptr=old;np=oldnp;return(-1);};
expression_list_opt();
if (parse_RIGHTPARENTH()) {ptr=old;np=oldnp;return(-1);};
return(0);

};

/* ***************************************** */

int mem_initializer_id () {

int old=ptr;
int oldnp=np;

if (!parse_IDENTIFIER()) return (0);
parse_SCOPE_opt();
nested_name_specifier_opt();
if (class_name()) {ptr=old;np=oldnp;return (-1);};
return (0);

}

/* ***************************************** */

int declaration () {

int old=ptr,oldnp=np;
// BEGIN 8/6/98

if (!parse_SEMICOLON()) return 0;

set_command(BEGIN_SIMPLE_DECL,0,_strdup(""),0,0,0);
if (!class_specifier()) {
  //if (!init_declarator_list()) ;
  set_command(END_SIMPLE_DECL,0,_strdup(""),0,0,0);
  return 0;
}
ptr=old;np=oldnp;

// END 8/6/98

if (!function_definition()) {return (0);};

if (!block_declaration()) {return(0);};

if (!explicit_instantiation()) {return(0);};

if (!template_declaration()) return(0);

if (!explicit_specialization()) {return(0);};

if (!linkage_specification()) return(0);

if (!namespace_definition()) {return(0);};

return (-1);

}

/* ***************************************** */

int explicit_instantiation () {

int old=ptr;
int oldnp=np;

if (parse_TEMPLATE()) {ptr=old;return(-1);};
if (declaration()) {ptr=old;np=oldnp;return(-1);};

return(0);

};

/* ***************************************** */

int explicit_specialization() {

int old=ptr;

if (parse_TEMPLATE()) {ptr=old;return(-1);};
if (parse_LESSTHAN()) {ptr=old;return(-1);};
if (parse_GREATERTHAN()) {ptr=old;return(-1);};
if (declaration()) {ptr=old;return(-1);};
return(0);

};

/* ***************************************** */

int linkage_specification () {

int old=ptr;
int save;
int oldnp=np;

if (parse_EXTERN()) {ptr=old;return(-1);};
if (parse_STRING_LITERAL()) {ptr=old;return(-1);};
save=ptr;
if (!parse_LEFTBRACE()) {
  declaration_seq_opt();
  if (parse_RIGHTBRACE()) {ptr=old;np=oldnp;return(-1);};
  return (0);
};
if (declaration()) {ptr=old;np=oldnp;return(-1);};

return (0);

};

/* ***************************************** */

int cv_qualifier() {

token tok;

tok=nexttok();
if ((tok.tok==CONST)||(tok.tok==VOLATILE)) {advance();return(0);}
return (-1);

};

/* ***************************************** */

void cv_qualifier_seq_opt () {

while (!cv_qualifier()) ;

};

/* ***************************************** */

int decl_ptr_operator () {

token tok;
int old=ptr;
int oldnp=np;

tok=nexttok();

if (tok.tok=='*') {advance();cv_qualifier_seq_opt();set_command(SYM_TYPE_ID,0,_strdup("*"),0,0,0);return(0);}
if (tok.tok=='&') {advance();set_command(SYM_TYPE_ID,0,_strdup("&"),0,0,0);return(0);}
parse_SCOPE_opt();
if (nested_name_specifier()) {ptr=old;return(-1);}
if (parse_TIMES()) {ptr=old;np=oldnp;return(-1);};
cv_qualifier_seq_opt();
return(0);

};

int ptr_operator () {

token tok;
int old=ptr;
int oldnp=np;

tok=nexttok();

if (tok.tok=='*') {advance();cv_qualifier_seq_opt();return(0);}
if (tok.tok=='&') {advance();return(0);}
parse_SCOPE_opt();
if (nested_name_specifier()) {ptr=old;return(-1);}
if (parse_TIMES()) {ptr=old;np=oldnp;return(-1);};
cv_qualifier_seq_opt();
return(0);

};

/* ***************************************** */

int ob_ptr_thing() {

if (parse_LEFTPARENTH()) return (-1);
while (!ptr_operator()) ;
return (0);

}

/* ***************************************** */

int primary_expression () {

int old=ptr;
int oldnp=np;

//if (debug) printf("LOOKING PRIMARY EXPRESSION(%d)\n",ptr);
if (debug) printf("PRIMARY 1\n");
if (!literal()) return(0);
if (debug) printf("1");
if (!parse_THIS()) return(0);
if (debug) printf("2\n");
if (!id_expression(1)) {
  //set_command(REF,0,sym_text(old,ptr),0,0,0);
  return(0);
}
if (debug) printf("PRIMARY 2\n");
if (!parse_LEFTPARENTH()) {
  if (expression()) {ptr=old;return(-1);};
  if (parse_RIGHTPARENTH()) {ptr=old;np=oldnp;return(-1);};
  return(0);
};
if (debug) printf("PRIMARY 3\n");
if (!parse_SCOPE()) {
  if (!parse_IDENTIFIER()) {set_command(REF,0,sym_text(old,ptr),0,0,0);set_command(LOWCOMPLEX,0,"",0,0,0);return (0);};
  if (!operator_function_id()) {set_command(REF,0,sym_text(old,ptr),0,0,0);set_command(LOWCOMPLEX,0,"",0,0,0);return (0);};
  if (!qualified_id()) {/*set_command(REF,0,sym_text(old,ptr),0,0,0);*/set_command(LOWCOMPLEX,0,"",0,0,0);return (0);};
  ptr=old;np=oldnp;
  return(-1);
};
if (debug) printf("PRIMARY 4\n");
ptr=old;np=oldnp;
return(-1);
};

/* ***************************************** */

int decl_id_expression() {

if (!/*decl_*/qualified_id()) return 0;
if (!/*decl_*/unqualified_id()) return 0;
return -1;

}

int id_expression(int talkback) {

int old=ptr;
int oldnp=np;

if (debug) printf("a");
if (!qualified_id()) {if (talkback==0) np=oldnp;return (0);}
if (debug) printf("b\n");
if (!unqualified_id()) {if (talkback==0) np=oldnp;return (0);}
if (debug) printf("c\n");

np=oldnp;
ptr=old;
return (-1);

}

/* ***************************************** */

int unqualified_id() {

int old=ptr;
int oldnp=np;

if (!operator_function_id()) return (0);

if (!template_id()) return (0);

if (!conversion_function_id()) return(0);

if (!parse_IDENTIFIER()) {
    if (debug) printf("ident");
// xref here?
        set_command(REF,0,sym_text(old,ptr),0,0,0);

  return (0);
}

if (!parse_TILDE()) {
  if (!class_name()) return (0);
  ptr=old;
  np=oldnp;
  return(-1);
};

ptr=old;
np=oldnp;
return(-1);

}

/* ***************************************** */

int qualified_id () {

int old=ptr;
int oldnp=np;

  if (!nested_name_specifier()) {
    template_opt();
    if (!unqualified_id())
      return (0);
  }

  ptr=old;np=oldnp;

  return(-1);

}

/* ***************************************** */

int pf_tail() {

int old=ptr;
int oldnp=np;
int mark;
int oldcom;

if (!parse_LEFTBRACKET()) {
  if (expression()) {
    ptr=old;return(-1);};
  if (parse_RIGHTBRACKET()) {ptr=old;np=oldnp;return(-1);};
  return(0);
};

oldcom=code.tree[np].com;

if (!parse_LEFTPARENTH()) {
  if (oldcom==REF)
    code.tree[np].com=FREF;
  expression_list_opt();
  if (parse_RIGHTPARENTH()) {ptr=old;np=oldnp;code.tree[np].com=oldcom;return(-1);};
    return(0);
};

if (!parse_PTR_OP()) {
  if (!pseudo_destructor_name()) return(0);
  template_opt();
  parse_SCOPE_opt();
  if (id_expression(1)) {ptr=old;np=oldnp;return(-1);};
  return(0);
};
if (!parse_DOT()) {
  if (!pseudo_destructor_name()) return(0);
        template_opt();
        parse_SCOPE_opt();
  mark=ptr;
        if (id_expression(1)) {ptr=old;np=oldnp;return(-1);};
  return(0);
};
if (!parse_INC_OP()) {
  set_command(LOWCOMPLEX,0,_strdup(""),0,0,0);
  return (0);
};
if (!parse_DEC_OP()) {
  set_command(LOWCOMPLEX,0,_strdup(""),0,0,0);
  return (0);
};
ptr=old;
return (-1);

};

/* ***************************************** */

void pf_tails_opt() {

while (!pf_tail()) ;

return ;

};

/* ***************************************** */

int new_declarator () {

int old=ptr;
int oldnp=np;

if (!ptr_operator()) {new_declarator_opt();return(0);};
if (!direct_new_declarator()) return (0);
ptr=old;np=oldnp;
return (-1);

};

/* ***************************************** */

void new_declarator_opt () {

while (!new_declarator()) ;

return;

};

/* ***************************************** */

int template_parameter () {

int old=ptr;

if (!type_parameter()) return (0);
if (!parameter_declaration()) return (0);

ptr=old;
return (-1);

};

/* ***************************************** */

int type_parameter () {

int old=ptr;
int save;
int oldnp=np;

if (!parse_CLASS()) {
  parse_IDENTIFIER_opt();
  save=ptr;
  if (parse_ASSIGN()) {ptr=save;return(0);};
  if (type_id()) {ptr=save;return(0);};
  return(0);
};

if (!parse_TYPENAME()) {
  parse_IDENTIFIER_opt();
        save=ptr;
        if (parse_ASSIGN()) {ptr=save;return(0);};
        if (type_id()) {ptr=save;return(0);};
        return(0);
};

if (!parse_TEMPLATE()) {
  if (parse_LESSTHAN()) {ptr=old;return(-1);};
  if (template_parameter_list()) {ptr=old;return(-1);};
  if (parse_GREATERTHAN()) {ptr=old;np=oldnp;return(-1);};
  if (parse_CLASS()) {ptr=old;np=oldnp;return(-1);};
  parse_IDENTIFIER_opt();
  save=ptr;
  if (parse_ASSIGN()) {ptr=save;return(0);};
    if (template_name()) {ptr=save;return(0);};
    return(0);
};

ptr=old;
return(-1);

};

/* ***************************************** */

int template_parameter_list () {

int count=0;
int old=ptr;

while (!template_parameter()) {
count++;
if (parse_COMMA()) break;
};
if (count>0) return (0);
ptr=old;
return (-1);

};

/* ***************************************** */

int template_declaration () {

int old=ptr;
int oldnp=np;

parse_EXPORT_opt();

if (parse_TEMPLATE()) {ptr=old;return(-1);};
if (parse_LESSTHAN()) {ptr=old;return(-1);};
if (template_parameter_list()) {ptr=old;return(-1);};
if (parse_GREATERTHAN()) {ptr=old;np=oldnp;return(-1);};
if (declaration()) {ptr=old;np=oldnp;return(-1);};
return(0);

};

/* ***************************************** */

int template_argument() {

int old=ptr;

if (!type_id()) {
  if (!lookahead_end_template_argument()){
    return (0);
  }
}

if (!assignment_expression()) {
  if (!lookahead_end_template_argument()){
    return (0);
  }
}


if (!template_name()) {
  if (!lookahead_end_template_argument()) {
    return (0);
  }
}

ptr=old;
return (-1);

};

/* ***************************************** */

int template_argument_list () {

int saveptr,savenp;

if (!template_argument()) {
  saveptr=ptr;savenp=np;
  if (!parse_COMMA()) {
    while (!template_argument()) {
      saveptr=ptr;savenp=np;
      if (parse_COMMA()) {
        ptr=saveptr;np=savenp;
        return (0);
      }
    }
    ptr=saveptr;np=savenp;
    return (0);
  }
  return (0);
}

return (-1);

}

/* ***************************************** */

int template_name () {

token tok;

tok=nexttok();
if (tok.tok==IDENTIFIER) {advance();return(0);};
return(-1);

}

/* ***************************************** */

int template_id () {
  int old=ptr;
  int oldnp=np;

  if (template_name()) {ptr=old;return(-1);};
  if (parse_LESSTHAN()) {ptr=old;return(-1);};
  if (template_argument_list()) {ptr=old;return(-1);};
  if (parse_GREATERTHAN()) {ptr=old;np=oldnp;return(-1);};
  np=oldnp; // needed to avoid mentioning types in <> more than in the whole thing
  return(0);
}

/* ***************************************** */

void template_opt () {
  int nowhere;

  nowhere=parse_TEMPLATE();
}

/* ***************************************** */

int conversion_declarator () {

int old=ptr;
int count=0;

while (!ptr_operator()) count++;
if (count) return (0);
ptr=old;
return (-1);

};

/* ***************************************** */

void conversion_declarator_opt () {

int nowhere;

nowhere=conversion_declarator();

return ;

};

/* ***************************************** */

int conversion_function_id () {

int old=ptr;

if (parse_OPERATOR()) {ptr=old;return(-1);};
if (conversion_type_id()) {ptr=old;return(-1);};
return (0);

};

/* ***************************************** */

int conversion_type_id () {

int old=ptr;

if (inclusive_type_specifier_seq()) {ptr=old;return(-1);};
conversion_declarator_opt();
return(0);

};

/* ***************************************** */

int deletesbs() {

int old=ptr;

if (parse_DELETE()) {ptr=old;return (-1);};
if (sbs()) {ptr=old;return (-1);};
return (0);

};

/* ***************************************** */

int sbs () {

int old=ptr;

if (parse_LEFTBRACKET()) {ptr=old;return (-1);};
if (parse_RIGHTBRACKET()) {ptr=old;return (-1);};
return (0);

};

/* ***************************************** */

int parentheses () {

int old=ptr;

if (parse_LEFTPARENTH()) {ptr=old;return (-1);};
if (parse_RIGHTPARENTH()) {ptr=old;return (-1);};
return (0);

};

/* ***************************************** */

int newsbs() {

int old=ptr;

if (parse_NEW()) {ptr=old;return (-1);};
if (sbs()) {ptr=old;return(-1);};
return (0);

};

/* ***************************************** */

int operator_terminal() {

int old=ptr;

if (!newsbs()) return(0);
if (!deletesbs()) return(0);
if (!parse_NEW()) return (0);
if (!parse_DELETE()) return (0);
if (!parse_PLUS()) return(0);
if (!parse_MINUS()) return (0);
if (!parse_TIMES()) return (0);
if (!parse_DIVIDE()) return (0);
if (!parse_PERCENT()) return (0);
if (!parse_CARET()) return (0);
if (!parse_AMPERSAND()) return (0);
if (!parse_BAR()) return (0);
if (!parse_TILDE()) return (0);
if (!parse_PLING()) return (0);
if (!parse_ASSIGN()) return (0);
if (!parse_LESSTHAN()) return (0);
if (!parse_GREATERTHAN()) return (0);
if (!parse_PLUSEQUALS()) return (0);
if (!parse_MINUSEQUALS()) return (0);
if (!parse_TIMESEQUALS()) return (0);
if (!parse_DIVEQUALS()) return (0);
if (!parse_MODEQUALS()) return (0);
if (!parse_CARETEQUALS()) return (0);
if (!parse_ANDEQUALS()) return (0);
if (!parse_BAREQUALS()) return (0);
if (!parse_LESSLESS()) return (0);
if (!parse_GREATERGREATER()) return (0);
if (!parse_LESSLESSEQUALS()) return (0);
if (!parse_GREATGREATEQUALS()) return (0);
if (!parse_EQUALS()) return (0);
if (!parse_NOTEQUALS()) return (0);
if (!parse_LESSEQUALS()) return (0);
if (!parse_GREATEREQUALS()) return (0);
if (!parse_AND_OP()) return (0);
if (!parse_OR_OP()) return (0);
if (!parse_INC_OP()) return (0);
if (!parse_DEC_OP()) return (0);
if (!parse_COMMA()) return (0);
if (!parse_PTR_OP_STAR()) return (0);
if (!parse_PTR_OP()) return (0);
if (!parentheses()) return (0);
if (!sbs()) return (0);

ptr=old;
return (-1);

};

/* ***************************************** */

int operator_function_id () {

int old=ptr;

if (parse_OPERATOR()) {ptr=old;return(-1);};
if (operator_terminal()) {ptr=old;return(-1);};
return(0);

};

/* ***************************************** */

void new_placement_opt () {

while (!new_placement()) ;

return ;

};

/* ***************************************** */

int postfix_expression () {

int old=ptr;
int oldnp=np;

if (!primary_expression()) {
  pf_tails_opt();
  return (0);};

if (!simple_type_specifier()) {
  if (parse_LEFTPARENTH()) {ptr=old;np=oldnp;return(-1);};
  expression_list_opt();
  if (parse_RIGHTPARENTH()) {ptr=old;np=oldnp;return(-1);};
  pf_tails_opt();
  set_command(LOWCOMPLEX,0,_strdup(""),0,0,0);
  return(0);
};
if (!parse_DYNAMIC_CAST()) {
  if (parse_LESSTHAN()) {ptr=old;return(-1);};
  if (type_id()) {ptr=old;return(-1);};
  if (parse_GREATERTHAN()) {ptr=old;np=oldnp;return(-1);};
  if (parse_LEFTPARENTH()) {ptr=old;np=oldnp;return(-1);};
  if (expression()) {ptr=old;np=oldnp;return(-1);};
  if (parse_RIGHTPARENTH()) {ptr=old;np=oldnp;return(-1);};
  pf_tails_opt();
  set_command(MIDCOMPLEX,0,_strdup(""),0,0,0);
  return(0);
};
if (!parse_STATIC_CAST()) {
  if (parse_LESSTHAN()) {ptr=old;return(-1);};
  if (type_id()) {ptr=old;return(-1);};
  if (parse_GREATERTHAN()) {ptr=old;np=oldnp;return(-1);};
  if (parse_LEFTPARENTH()) {ptr=old;np=oldnp;return(-1);};
      if (expression()) {ptr=old;np=oldnp;return(-1);};
      if (parse_RIGHTPARENTH()) {ptr=old;np=oldnp;return(-1);};
      pf_tails_opt();
      set_command(MIDCOMPLEX,0,_strdup(""),0,0,0);
      return(0);
};
if (!parse_REINTERPRET_CAST()) {
  if (parse_LESSTHAN()) {ptr=old;return(-1);};
        if (type_id()) {ptr=old;return(-1);};
        if (parse_GREATERTHAN()) {ptr=old;np=oldnp;return(-1);};
        if (parse_LEFTPARENTH()) {ptr=old;np=oldnp;return(-1);};
        if (expression()) {ptr=old;np=oldnp;return(-1);};
        if (parse_RIGHTPARENTH()) {ptr=old;np=oldnp;return(-1);};
        pf_tails_opt();
  set_command(MIDCOMPLEX,0,_strdup(""),0,0,0);
        return(0);
};
if (!parse_CONST_CAST()) {
  if (parse_LESSTHAN()) {ptr=old;return(-1);};
        if (type_id()) {ptr=old;return(-1);};
        if (parse_GREATERTHAN()) {ptr=old;np=oldnp;return(-1);};
        if (parse_LEFTPARENTH()) {ptr=old;np=oldnp;return(-1);};
        if (expression()) {ptr=old;np=oldnp;return(-1);};
        if (parse_RIGHTPARENTH()) {ptr=old;np=oldnp;return(-1);};
        pf_tails_opt();
  set_command(MIDCOMPLEX,0,_strdup(""),0,0,0);
        return(0);
};
if (!parse_TYPEID()) {
  if (parse_LEFTPARENTH()) {ptr=old;np=oldnp;return(-1);};
  if (!expression()) {
    if (parse_RIGHTPARENTH()) {ptr=old;np=oldnp;return(-1);};
    pf_tails_opt();
    set_command(MIDCOMPLEX,0,_strdup(""),0,0,0);
    return(0);
  };
  if (!type_id()) {
    if (parse_RIGHTPARENTH()) {ptr=old;np=oldnp;return(-1);};
    pf_tails_opt();
    set_command(LOWCOMPLEX,0,_strdup(""),0,0,0);
    return(0);
  };
};
ptr=old;
return(-1);
};

/* ***************************************** */

int expression_list () {

int old=ptr;
int oldnp=np;

set_command(BEGIN_EXPRESSION,0,_strdup(""),0,0,0);
if (!assignment_expression()) {
set_command(END_EXPRESSION,0,_strdup(""),0,0,0);
while (!parse_COMMA()) {
  old=ptr;oldnp=np;
  set_command(SEP,0,_strdup(""),0,0,0);
  set_command(BEGIN_EXPRESSION,0,_strdup(""),0,0,0);
  if (assignment_expression()) {
    ptr=old;np=oldnp;
    return 0;
  }
  set_command(END_EXPRESSION,0,_strdup(""),0,0,0);
}
return 0;
}

np=oldnp;
return (-1);
};

/* ***************************************** */

void expression_opt() {

int nowhere;

nowhere=expression();

return ;

};

/* ***************************************** */

void expression_list_opt () {

int nowhere;

nowhere=expression_list();

return ;

};

/* ***************************************** */

int pseudo_destructor_name () {

int old=ptr;
int oldnp=np;

parse_SCOPE_opt();
nested_name_specifier_opt();
if (!parse_TILDE()) {
  if (type_name()) {ptr=old;np=oldnp;return(-1);};
  set_command(REF,0,sym_text(old,ptr),0,0,0);
  return(0);
};
if (type_name()) {ptr=old;np=oldnp;return(-1);};
if (parse_SCOPE()) {ptr=old;np=oldnp;return(-1);};
if (parse_TILDE()) {ptr=old;np=oldnp;return(-1);};
if (type_name()) {ptr=old;np=oldnp;return(-1);};
return(0);
};

/* ***************************************** */

int unary_expression () {

int old=ptr;
int oldnp=np;

if (!postfix_expression()) {
  return (0);
}
if (!parse_INC_OP()) {
  if (cast_expression()) {ptr=old;return(-1);};
  return(0);
}
if (!parse_DEC_OP()) {
  if (cast_expression()) {ptr=old;return(-1);};
  return(0);
}
if (!unary_operator()) {
  if (cast_expression()) {ptr=old;return(-1);};
  set_command(LOWCOMPLEX,0,_strdup(""),0,0,0);
  return(0);
}
if (!parse_SIZEOF()) {
  if (!unary_expression()) {
    set_command(LOWCOMPLEX,0,_strdup(""),0,0,0);
    return (0);
  }
  if (parse_LEFTPARENTH()) {ptr=old;np=oldnp;return(-1);};
  if (type_id()) {ptr=old;np=oldnp;return(-1);};
  if (parse_RIGHTPARENTH()) {ptr=old;np=oldnp;return(-1);};
  set_command(LOWCOMPLEX,0,_strdup(""),0,0,0);
  return(0);
}
if (!new_expression()) return (0);
if (!delete_expression()) return (0);

ptr=old;
return(-1);

};

/* ***************************************** */


int unary_operator() {

token tok;

tok=nexttok();
advance();
switch (tok.tok) {
case '*': return (0);
case '&': return (0);
case '+': return (0);
case '-': return (0);
case '!': return (0);
case '~': return (0);
default: unadvance();return (-1);
};

};

/* ***************************************** */

int new_expression () {

int old=ptr;
int oldnp=np;
int save;

parse_SCOPE_opt();
if (parse_NEW()) {ptr=old;np=oldnp;return(-1);};

save=ptr;
new_placement_opt();

if (!new_type_id()) {
  new_initializer_opt();
  set_command(MIDCOMPLEX,0,_strdup(""),0,0,0);
  return(0);
};

if (!parse_LEFTPARENTH()) {
  if (type_id()) {ptr=old;np=oldnp;return(-1);};
  if (parse_RIGHTPARENTH()) {ptr=old;np=oldnp;return(-1);};
  new_initializer_opt();
  set_command(MIDCOMPLEX,0,_strdup(""),0,0,0);
  return(0);
};
if (ptr>save)
  return 0;
ptr=old;np=oldnp;
return(-1);

};

/* ***************************************** */

int new_placement () {

int old=ptr;
int oldnp=np;

if (parse_LEFTPARENTH()) {ptr=old;return(-1);};
if (expression_list()) {ptr=old;return(-1);};
if (parse_RIGHTPARENTH()) {ptr=old;np=oldnp;return(-1);};

return(0);

};

/* ***************************************** */

int new_type_id() {

int old=ptr;

if (inclusive_type_specifier_seq()) {ptr=old;return (-1);};
new_declarator_opt();

return(0);

};

/* ***************************************** */

int d_n_d_2() {

int old=ptr;
int oldnp=np;

if (parse_LEFTBRACKET()) {ptr=old;return(-1);};
if (constant_expression()) {ptr=old;return(-1);};
if (parse_RIGHTBRACKET()) {ptr=old;np=oldnp;return(-1);};
set_command(SYM_TYPE_ID,0,_strdup("[]"),0,0,0);
return(0);

};

/* ***************************************** */

void d_n_d_2_list_opt() {

while (!d_n_d_2()) ;

};

/* ***************************************** */

int direct_new_declarator() {

int old=ptr;
int oldnp=np;

if (parse_LEFTBRACKET()) {ptr=old;return(-1);};
if (expression()) {ptr=old;return(-1);};
if (parse_RIGHTBRACKET()) {ptr=old;np=oldnp;return(-1);};
d_n_d_2_list_opt();
return(0);

};

/* ***************************************** */

int new_initializer () {

int old=ptr;

if (parse_LEFTPARENTH()) {ptr=old;return(-1);};
expression_list_opt();
if (parse_RIGHTPARENTH()) {ptr=old;return(-1);};
return(0);

};

/* ***************************************** */

void new_initializer_opt () {

int nowhere;

nowhere=new_initializer();

return ;

};

/* ***************************************** */

int delete_expression () {

int old=ptr;
int oldnp=np;

if (parse_DELETE()) {ptr=old;return(-1); };
if (!cast_expression()) {set_command(LOWCOMPLEX,0,_strdup(""),0,0,0);return (0);};
if (parse_LEFTBRACKET()) {ptr=old;np=oldnp;return(-1);};
if (parse_RIGHTBRACKET()) {ptr=old;np=oldnp;return(-1);};
if (cast_expression()) {ptr=old;np=oldnp;return(-1);};
set_command(LOWCOMPLEX,0,_strdup(""),0,0,0);
return (0);

};

/* ***************************************** */

int cast_expression () {

int old=ptr;
int oldnp=np;

if (parse_LEFTPARENTH()) {ptr=old;goto no_cast;};
if (smart_type_id()) {ptr=old;goto no_cast;};
if (parse_RIGHTPARENTH()) {ptr=old;np=oldnp;goto no_cast;};
if (cast_expression()) {ptr=old;np=oldnp;goto no_cast;};
set_command(LOWCOMPLEX,0,_strdup(""),0,0,0);
return(0);
no_cast:
if (!unary_expression()) return (0);
ptr=old;
return(-1);

};

/* ***************************************** */

int pm_expression () {

int old=ptr;
int save;
int another=1;
int saveb;

if (cast_expression()) {ptr=old;return(-1);};
saveb=ptr;
while (another) {
  save=ptr;
  if (!parse_DOT_STAR()) {
    if (cast_expression()) {ptr=save;set_command(MIDCOMPLEX,0,_strdup(""),0,0,0);return(0);};
  }
  else if (!parse_PTR_OP_STAR()) {
    if (cast_expression()) {ptr=save;set_command(MIDCOMPLEX,0,_strdup(""),0,0,0);return(0);};
  }
  else another=0;
};
if (ptr>saveb) set_command(MIDCOMPLEX,0,_strdup(""),0,0,0);
return (0);
};

/* ***************************************** */

int multiplicative_expression () {

int old=ptr;
int save;
int another=1;
int saveb;

if (pm_expression()) {ptr=old;return(-1);};
saveb=ptr;
while (another) {
        save=ptr;
        if (!parse_TIMES()) {
        set_command(SEP,0,_strdup(""),0,0,0);
        if (pm_expression()) {ptr=save;set_command(LOWCOMPLEX,0,_strdup(""),0,0,0);return(0);};
        }
        else if (!parse_DIVIDE()) {
        set_command(SEP,0,_strdup(""),0,0,0);
                if (pm_expression()) {ptr=save;set_command(LOWCOMPLEX,0,_strdup(""),0,0,0);return(0);};
        }
    else if (!parse_PERCENT()) {
        set_command(SEP,0,_strdup(""),0,0,0);
      if (pm_expression()) {ptr=save;set_command(MIDCOMPLEX,0,_strdup(""),0,0,0);return(0);};
    }
        else another=0;
};
if (ptr>saveb) set_command(MIDCOMPLEX,0,_strdup(""),0,0,0);
return (0);

};

/* ***************************************** */

int additive_expression () {

  int old=ptr;
  int save;
  int another=1;
  int saveb;
  if (multiplicative_expression()) {ptr=old;return(-1);};
  saveb=ptr;
  while (another) {
      save=ptr;
      if (!parse_PLUS()) {
          set_command(SEP,0,_strdup(""),0,0,0);
          if (multiplicative_expression()) {ptr=save;set_command(LOWCOMPLEX,0,_strdup(""),0,0,0);return(0);};
      }
      else if (!parse_MINUS()) {
          set_command(SEP,0,_strdup(""),0,0,0);
          if (multiplicative_expression()) {ptr=save;set_command(LOWCOMPLEX,0,_strdup(""),0,0,0);return(0);};
      }
      else another=0;
  };
  if (ptr>saveb) set_command(LOWCOMPLEX,0,_strdup(""),0,0,0);
  return (0);

};


/* ***************************************** */

int shift_expression () {

  int old=ptr;
  int save;
  int another=1;
  int saveb;

  if (additive_expression()) {ptr=old;return(-1);};
  saveb=ptr;

  while (another) {
      save=ptr;
      if (!parse_LESSLESS()) {
          if (additive_expression()) {ptr=save;set_command(HIGHCOMPLEX,0,_strdup(""),0,0,0);return(0);};
      }
      else if (!parse_GREATERGREATER()) {
          if (additive_expression()) {ptr=save;set_command(HIGHCOMPLEX,0,_strdup(""),0,0,0);return(0);};
      }
      else another=0;
  }

  if (ptr>saveb) set_command(HIGHCOMPLEX,0,_strdup(""),0,0,0);

  return 0;
}

/* ***************************************** */

int relational_expression () {

  int old=ptr;
  int save;
  int another=1;
  int saveb;

  if (shift_expression()) {
    ptr=old;
    return(-1);
  }

  saveb=ptr;
  while (another) {
    save=ptr;
    if (!parse_LESSTHAN()) {
      if (shift_expression()) {
        ptr=save;
        set_command(MIDCOMPLEX,0,_strdup(""),0,0,0);
        return 0;
      }
      set_command(SEP,0,_strdup(""),0,0,0);
    } else if (!parse_GREATERTHAN()) {
      if (shift_expression()) {
        ptr=save;
        set_command(MIDCOMPLEX,0,_strdup(""),0,0,0);
        return 0;
      }
      set_command(SEP,0,_strdup(""),0,0,0);
    } else if (!parse_LESSEQUALS()) {
      if (shift_expression()) {
        ptr=save;
        set_command(MIDCOMPLEX,0,_strdup(""),0,0,0);
        return 0;
      }
      set_command(SEP,0,_strdup(""),0,0,0);
    } else if (!parse_GREATEREQUALS()) {
      if (shift_expression()) {
        ptr=save;
        set_command(MIDCOMPLEX,0,_strdup(""),0,0,0);
        return 0;
      }
      set_command(SEP,0,_strdup(""),0,0,0);
    } else
      another=0;
  }

  if (ptr>saveb)
    set_command(MIDCOMPLEX,0,_strdup(""),0,0,0);

  return 0;
}

/* ***************************************** */

int equality_expression () {

  int old=ptr;
  int save;
  int another=1;
  int saveb;

  if (relational_expression()) {
    ptr=old;
    return -1;
  }

  saveb=ptr;
  while (another) {
    save=ptr;
    if (!parse_EQUALS()) {
      //debugging next line added
      set_command(SEP,0,_strdup(""),0,0,0);
      if (relational_expression()) {
        ptr=save;
        set_command(LOWCOMPLEX,0,_strdup(""),0,0,0);
        return(0);
      }
    }
    else if (!parse_NOTEQUALS()) {
      //debugging next line added
      set_command(SEP,0,_strdup(""),0,0,0);
      if (relational_expression()) {
        ptr=save;
        set_command(LOWCOMPLEX,0,_strdup(""),0,0,0);
        return(0);
      }
    } else
      another=0;
  }

  if (ptr>saveb)
    set_command(LOWCOMPLEX,0,_strdup(""),0,0,0);

  return (0);
}

/* ***************************************** */

int and_expression () {

int old=ptr;
int save;
int another=1;

if (equality_expression()) {ptr=old;return(-1);};
while (another) {
        save=ptr;
        if (!parse_AMPERSAND()) {
                if (equality_expression()) {ptr=save;set_command(MIDCOMPLEX,0,_strdup(""),0,0,0);return(0);};
        }
        else another=0;
};
if (ptr>old) set_command(MIDCOMPLEX,0,_strdup(""),0,0,0);
return (0);

};

/* ***************************************** */

int exclusive_or_expression () {

int old=ptr;
int save;
int another=1;
int saveb;

if (and_expression()) {ptr=old;return(-1);};
saveb=ptr;
while (another) {
        save=ptr;
        if (!parse_CARET()) {
                if (and_expression()) {ptr=save;set_command(MIDCOMPLEX,0,_strdup(""),0,0,0);return(0);};
        }
        else another=0;
};
if (ptr>saveb) set_command(MIDCOMPLEX,0,_strdup(""),0,0,0);
return (0);

};

/* ***************************************** */

int inclusive_or_expression () {

  int old=ptr;
  int save;
  int another=1;
  int saveb;

  if (exclusive_or_expression()) {
    ptr=old;
    return -1;
  }

  saveb=ptr;
  while (another) {
    save=ptr;
        if (!parse_BAR()) {
      if (exclusive_or_expression()) {
        ptr=save;
        set_command(MIDCOMPLEX,0,_strdup(""),0,0,0);
        return(0);
      }
        }
        else another=0;
  }

  if (ptr>saveb)
    set_command(MIDCOMPLEX,0,_strdup(""),0,0,0);

  return 0;
}

/* ***************************************** */

int logical_and_expression () {

  int old=ptr;
  int save;
  int another=1;
  int saveb;

  if (inclusive_or_expression()) {
    ptr=old;
    return(-1);
  }

  saveb=ptr;
  while (another) {
    save=ptr;
    if (!parse_AND_OP()) {
      //debugging next line added
      set_command(SEP,0,_strdup(""),0,0,0);

      if (inclusive_or_expression()) {
        ptr=save;
        set_command(MIDCOMPLEX,0,_strdup(""),0,0,0);
        return(0);
      }
    } else
      another=0;
  }

  if (ptr>saveb)
    set_command(MIDCOMPLEX,0,_strdup(""),0,0,0);

  return 0;
}

/* ***************************************** */

int logical_or_expression () {

int old=ptr;
int save;
int another=1;
 int saveb;

if (logical_and_expression()) {ptr=old;return(-1);};
saveb=ptr;
while (another) {
        save=ptr;
        if (!parse_OR_OP()) {
                if (logical_and_expression()) {ptr=save;set_command(MIDCOMPLEX,0,_strdup(""),0,0,0);return(0);};
        }
        else another=0;
};
if (ptr>saveb) set_command(MIDCOMPLEX,0,_strdup(""),0,0,0);
return (0);

};

/* ***************************************** */

int conditional_expression () {

int old=ptr;
int save;
int savenp;

if (logical_or_expression()) {ptr=old;return(-1);};
save=ptr;
savenp=np;
if (parse_QUERY()) {ptr=save;return(0);};
if (expression()) {ptr=save;return(0);};
if (parse_COLON()) {ptr=save;np=savenp;return(0);};
if (assignment_expression()) {ptr=save;np=savenp;return(0);};
return (0);

};

/* ***************************************** */

int assignment_expression () {
  int old=ptr;
  int oldnp=np;

  set_command(BEGIN_WRITE,0,_strdup(""),0,0,0);
  if (!logical_or_expression()) {
    set_command(END_WRITE,0,_strdup(""),0,0,0);
    if (assignment_operator()) {
      ptr=old;
      np=oldnp;
      goto ass_hack;
    }
    if (assignment_expression()) {
      ptr=old;
      np=oldnp;
      goto ass_hack;
    }
    return(0);
  }

ass_hack:
  ptr=old;np=oldnp;
  if (!conditional_expression()) {return(0);};
  if (!throw_expression()) {return(0);};

  ptr=old;

  return(-1);
}

/* ***************************************** */

int assignment_operator () {

token tok=nexttok();

advance();
switch (tok.tok) {
  case '=' :
    return (0);
  case TIMESEQUALS:
    return (0);
  case DIVEQUALS:
    return (0);
  case MODEQUALS:
    return (0);
  case PLUSEQUALS:
    return (0);
  case MINUSEQUALS:
    return (0);
  case GREATGREATEQUALS:
    return (0);
  case LESSLESSEQUALS:
    return (0);
  case ANDEQUALS:
    return (0);
  case CARETEQUALS:
    return (0);
  case BAREQUALS:
    return(0);
  default:
    unadvance();
    return (-1);
};

}

/* ***************************************** */

int throw_expression () {

int old=ptr;

if (parse_THROW()) {ptr=old;return(-1);};
assignment_expression_opt();
return(0);

}

/* ***************************************** */

void assignment_expression_opt () {

int nowhere;

nowhere=assignment_expression();

}

/* ***************************************** */

int expression () {
  int old=ptr,oldnp=np;
  int another=1;
  int save,savenp;

  set_command(BEGIN_EXPRESSION,0,_strdup(""),0,0,0);
  if (assignment_expression()) {ptr=old;np=oldnp;return(-1);};
  set_command(END_EXPRESSION,0,_strdup(""),0,0,0);

  while(another==1) {
    save=ptr;savenp=np;
    if (!parse_COMMA()) {
        set_command(BEGIN_EXPRESSION,0,_strdup(""),0,0,0);
      if (assignment_expression()) {
        ptr=save;np=savenp;
        return 0;
      }
      else
        set_command(END_EXPRESSION,0,_strdup(""),0,0,0);
    }
    else {
     return 0;
    }
  };

  return (0);

}

/* ***************************************** */

int constant_expression () {
  if (!conditional_expression()) {
    return (0);
  }
  else return (-1);
}

/* ****************************************** */

int decl_id() {
  int old=ptr;
  int oldnp=np;
  int line=thisline();
  int startcol=thiscol();

  if (!id_expression(0)) {
    set_command(ID,0,sym_text(old,ptr),line,startcol,lastcol());
    return(0);
  }
  parse_SCOPE_opt();
  nested_name_specifier_opt();
  if (!type_name()) {
    set_command(ID,0,sym_text(old,ptr),line,startcol,lastcol());
    return(0);
  }
  // fail
  ptr=old;np=oldnp;
  return(-1);
}

/* ***************************************** */

int ellipsis() {

token tok=nexttok();

if (tok.tok==ELLIPSIS) {advance();return(0);}
return(-1);

};

/* ***************************************** */

int lookahead_param_decl_ok () {

int old=ptr;

if (!parse_GREATERTHAN()) {ptr=old;return(0);};
if (!parse_COMMA()) {ptr=old;return(0);};
if (!parse_RIGHTPARENTH()) {ptr=old;return(0);};
ptr=old;
return (-1);

}

/* ***************************************** */

int param_decl_specifier() {
  int old=ptr;
  token tok;

  if (!get_typedef()) return 0;
  if (!parse_FRIEND()) return 0;
  if (!storage_class_specifier()) return 0;
  if (!enum_specifier()) return 0;
  if (!class_specifier()) return 0;
  if (!cv_qualifier()) return 0;
  if (!elaborated_type_specifier()) return 0;
  tok=nexttok();
  advance();
  if (tok.tok==CHAR)    {set_command(SYM_TYPE_ID,0,_strdup("char"),0,0,0);return (0);};
  if (tok.tok==WCHAR_T) {set_command(SYM_TYPE_ID,0,_strdup("wchar_t"),0,0,0);return (0);};
  if (tok.tok==BOOL)    {set_command(SYM_TYPE_ID,0,_strdup("bool"),0,0,0);return (0);};
  if (tok.tok==SHORT)   {set_command(SYM_TYPE_ID,0,_strdup("short"),0,0,0);return (0);};
  if (tok.tok==INT)     {set_command(SYM_TYPE_ID,0,_strdup("int"),0,0,0);return (0);};
  if (tok.tok==LONG)    {set_command(SYM_TYPE_ID,0,_strdup("long"),0,0,0);return (0);};
  if (tok.tok==SIGNED)  {set_command(SYM_TYPE_ID,0,_strdup("signed"),0,0,0);return (0);};
  if (tok.tok==UNSIGNED){set_command(SYM_TYPE_ID,0,_strdup("unsigned"),0,0,0);return (0);};
  if (tok.tok==FLOAT)   {set_command(SYM_TYPE_ID,0,_strdup("float"),0,0,0);return (0);};
  if (tok.tok==DOUBLE)  {set_command(SYM_TYPE_ID,0,_strdup("double"),0,0,0);return (0);};
  if (tok.tok==VOID)    {set_command(SYM_TYPE_ID,0,_strdup("void"),0,0,0);return (0);};
  ptr=old;
  if (!function_specifier()) return 0;
  ptr=old;
  return -1;
}

/* ***************************************** */

void param_dss_opt(int n) {
  int line=thisline();
  int startcol=thiscol();
  int save;

  while (!param_decl_specifier());
  while (n>0) {
      save=ptr;
      parse_SCOPE_opt();
      nested_name_specifier_opt();
      if (!type_name()) {
        set_command(SYM_TYPE_ID,0,sym_text(save,ptr),line,startcol,lastcol());
        // no return here?
        n--;
      }
      while (!param_decl_specifier()) ;
      if (ptr==save) return;
  }

  return;
}

/* ***************************************** */

int k_and_r_parameter_declaration() {
  int old=ptr;
  int oldnp=np;
  int save,saveb,npsave,npsaveb;
  int i;

  if (!k_and_r_declaration_statement()) if (ptr>(old+1)) return 0;
  ptr=old;np=oldnp;
  if (!ellipsis()) return 0;

  for (i=0;i<=2;i++) {
    if (i==0) param_dss_opt(0);
    else param_dss_opt(1);
    save=ptr;npsave=np;
    if (!declarator())
      if (!parse_ASSIGN()) {
        if (!assignment_expression())
          if ((!look_COMMA())||(!look_RIGHTPARENTH()))
            {return 0;};
      } else if ((!look_COMMA())||(!look_RIGHTPARENTH())||(!look_LEFTBRACE())||(!look_SEMICOLON())) {
        return 0;
      };
    ptr=save;np=npsave;
  };
  ptr=old;np=oldnp;
  for (i=0;i<=1;i++) {
    if (i==1) param_dss_opt(1);
    save=ptr;npsave=np;
    abstract_declarator_opt();
    saveb=ptr;npsaveb=np;
    if (!parse_ASSIGN())
      if (!assignment_expression())
        if ((!look_COMMA())||(!look_RIGHTPARENTH()))
          {return 0;};
    ptr=saveb;np=npsaveb;
    if (((!look_COMMA())||(!look_RIGHTPARENTH()))&&(ptr>old))
      {return 0;};
    ptr=save;np=npsave;
  };

  ptr=old;np=oldnp;
  return (-1);
}

/* ***************************************** */

int parameter_declaration() {
  int old=ptr;
  int oldnp=np;
  int npsave,npsaveb,save,saveb;
  int i;

  if (!ellipsis())
    return 0;

  for (i=0;i<=2;i++) {
    if (i==0) param_dss_opt(0);
    else param_dss_opt(1);
    save=ptr;npsave=np;
    if (!declarator()) {
      saveb=ptr;npsaveb=np;
      if (!parse_ASSIGN())
        if (!assignment_expression())
          if ((!look_COMMA())||(!look_RIGHTPARENTH()))
      return 0;
      ptr=saveb;np=npsaveb;
      if ((!look_COMMA())||(!look_RIGHTPARENTH()))
        return 0;
    };
    ptr=save;np=npsave;
  };

  ptr=old;np=oldnp;
  for (i=0;i<=2;i++) {
    if (i==0) param_dss_opt(0);
    else param_dss_opt(1);
    save=ptr;npsave=np;
    abstract_declarator_opt();
    saveb=ptr;npsaveb=np;
    if (!parse_ASSIGN())
      if (!assignment_expression())
        if ((!look_COMMA())||(!look_RIGHTPARENTH()))
          return 0;
    ptr=saveb;np=npsaveb;
    if ((!look_COMMA())||(!look_RIGHTPARENTH())) {
      return 0;
    };
    ptr=save;np=npsave;
  };
  ptr=old;np=oldnp;
  return (-1);
}

/* ***************************************** */

void declarator_opt() {
  int nowhere;

  nowhere=declarator();
}

/* ***************************************** */

int k_and_r_parameter_declaration_clause() {
  while (!k_and_r_parameter_declaration()) ;
  return (0);
}

/* ***************************************** */

int parameter_declaration_clause() {
  int savenp;

  savenp=np;
  set_command(BEGIN_DECLARATOR,0,_strdup(""),0,0,0);
  while (!parameter_declaration()) {
    set_command(END_DECLARATOR,0,_strdup(""),0,0,0);
    if (parse_COMMA())
            goto pdc_getout;
    savenp=np;
    set_command(BEGIN_DECLARATOR,0,_strdup(""),0,0,0);
  };
  np=savenp;
  pdc_getout:
  return (0);
}

/* ***************************************** */

int exception_declaration () {

int old=ptr;
int save,save_b;
int temp;
int oldnp_b;

if (!ellipsis()) return (0);

if (!type_specifier_seq()) {
  save=ptr;
  oldnp_b=np;
  if (!declarator()) {
    save_b=ptr;
    if (parse_RIGHTPARENTH()) {
      ptr=save;
      parse_extra_decl_spec();
      np=oldnp_b;
      if (!declarator()) return (0);
      if (!abstract_declarator()) return (0);
      return (0);
    };
    ptr=save_b;
    return (0);
  };
  if (!abstract_declarator()) {
    save_b=ptr;
    oldnp_b=np;
    if (parse_RIGHTPARENTH()) {
      ptr=save;
      parse_extra_decl_spec();
      np=oldnp_b;
      if (!declarator()) return (0);
      if (!abstract_declarator()) return (0);
      return (0);
    };
    ptr=save_b;
    return (0);
  };
  ptr=save;
  return (0);
};

temp=ptr;
parse_extra_decl_spec();
if (ptr==temp) {ptr=old;return (-1);};
if (!declarator()) return (0);
if (!abstract_declarator()) return(0);
return(0);

};

/* ***************************************** */

int type_id_list () {

int old=ptr;
int save;

while (!type_id()) {
  save=ptr;
  if (parse_COMMA()) {ptr=save;return (0);};
};
ptr=old;
return (-1);
};

/* ***************************************** */

void type_id_list_opt () {

int nowhere;

nowhere=type_id_list();

return ;

};

/* ***************************************** */

int exception_specification () {

int old=ptr;
int oldnp=np;
if (parse_THROW()) {ptr=old;return(-1);};
if (parse_LEFTPARENTH()) {ptr=old;return(-1);};
type_id_list_opt();
if (parse_RIGHTPARENTH()) {ptr=old;np=oldnp;return(-1);};
return (0);

};

/* ***************************************** */

void exception_specification_opt() {

(void)exception_specification();

}

/* ***************************************** */

int decl_param_part () {
  int old=ptr;
  int oldnp=np;

  if (parse_LEFTPARENTH()) {ptr=old;np=oldnp;return (-1);}

  set_command(DECL_PARAM_PART_BEGIN,0,_strdup(""),0,0,1);

  if (parameter_declaration_clause()) {ptr=old;np=oldnp;return(-1);};

  if (parse_RIGHTPARENTH()) {ptr=old;np=oldnp;return (-1);}
  cv_qualifier_seq_opt();
  exception_specification_opt();

  set_command(DECL_PARAM_PART_END,0,_strdup(""),0,0,0);

  return(0);
}

/* ***************************************** */

int try_block () {

int old=ptr;
int oldnp=np;

if (parse_TRY()) {ptr=old;return(-1);};
if (compound_statement()) {ptr=old;return(-1);};
if (handler_seq()) {ptr=old;np=oldnp;return(-1);};
return (0);
};

/* ***************************************** */

int function_try_block () {

int old=ptr;
int oldnp=np;

if (parse_TRY()) {ptr=old;return(-1);};
ctor_initializer_opt();
if (function_body()) {ptr=old;np=oldnp;return(-1);};
if (handler_seq()) {ptr=old;np=oldnp;return (-1);};
return (0);

};

/* ***************************************** */

int handler_seq () {

int old=ptr;
int count=0;

while (!handler())
  count++;

if (count>0) {
  density.top()->control+=count; // one control statement for each handler
  return (0);
}
ptr=old;
return (-1);

};

/* ***************************************** */

int handler () {

int old=ptr;
int oldnp=np;

if (parse_CATCH()) {ptr=old;return (-1);};
if (parse_LEFTPARENTH()) {ptr=old;return(-1);};
if (exception_declaration()) {ptr=old;return(-1);};
if (parse_RIGHTPARENTH()) {ptr=old;np=oldnp;return (-1);};
if (compound_statement()) {ptr=old;np=oldnp;return (-1);};
return(0);

}

/* ***************************************** */

void constant_expression_opt() {

int nowhere;

nowhere=constant_expression();

return;

};

/* ***************************************** */

int decl_const_part () {
  int old=ptr;
  int oldnp=np;

  if (parse_LEFTBRACKET()) {ptr=old;return (-1);}
  // changed by gns to cope with: int xyz[][ABC]; declarations...
  int savenp=np;
  expression_opt();
  np=savenp;// ignore any expression references in the declaration
  if (parse_RIGHTBRACKET()) {ptr=old;np=oldnp;return(-1);}

  set_command(SYM_TYPE_ID,0,_strdup("[]"),0,0,0);

  return(0);
}

/* ***************************************** */

int declarator_with_params() {
  int old=ptr;
  int oldnp=np;

  set_command(BEGIN_DECLARATOR,0,_strdup(""),thisline(),thiscol(),0);

  while (!decl_ptr_operator()) ; /* absorb pointer operators */
  if (!direct_declarator_with_params()) {
    set_command(END_DECLARATOR,0,_strdup(""),thisline(),thiscol(),0);
    return (0);
  };

  np=oldnp;ptr=old;
  return (-1);
}

/* ****************************************** */

int declarator() {
  int old=ptr;
  int oldnp=np;

  set_command(BEGIN_DECLARATOR,0,_strdup(""),thisline(),thiscol(),0);

  while (!decl_ptr_operator()) ; /* absorb pointer operators */

  if (!direct_declarator()) {
    set_command(END_DECLARATOR,0,_strdup(""),thisline(),thiscol(),0);
    return (0);
  };

  np=oldnp;ptr=old;
  return (-1);
}

/* ****************************************** */

int sing_direct_declarator();

int sing_declarator() {

int old=ptr;
int oldnp=np;

set_command(BEGIN_DECLARATOR,0,_strdup(""),thisline(),thiscol(),0);

while (!decl_ptr_operator()) ; /* absorb pointer operators */

if (!sing_direct_declarator()) {
  set_command(END_DECLARATOR,0,_strdup(""),thisline(),thiscol(),0);
  return (0);
};

np=oldnp;ptr=old;
return (-1);

}

/* ***************************************** */

int direct_declarator_with_params() {

int old=ptr;
int oldnp=np;
int n;

n=0;

if (!decl_id()) {
  if (!decl_param_part()) n=1;
  while ((!decl_param_part())||(!decl_const_part()))
    ;
  if (n==1) return (0);
};
if (!parenthesised_declarator()) {
  if (!decl_param_part()) n=1;
  while ((!decl_param_part())||(!decl_const_part()))
    ;
  if (n==1) return (0);
};

ptr=old;np=oldnp;
return (-1);

}

/* ***************************************** */

int direct_declarator() {

int old=ptr;
int oldnp=np;

if (!decl_id()) {
  while ((!decl_param_part())||(!decl_const_part())) ;
  return (0);
};
if (no_parenthesised_declarators==0)
  if (!parenthesised_declarator()) {
    while ((!decl_param_part())||(!decl_const_part())) ;
  return (0);
  };

ptr=old;np=oldnp;
return (-1);

}

/* ***************************************** */

int sing_direct_declarator() {

int old=ptr;
int oldnp=np;

if (!decl_id()) {
  while ((!decl_param_part())||(!decl_const_part())) ;
  return (0);
};
/* if (!parenthesised_declarator()) {
  while ((!decl_param_part())||(!decl_const_part())) ;
  return (0);
}; */

ptr=old;np=oldnp;
return (-1);

}

/* ***************************************** */

int initializer_list () {
  int count=0;
  int old=ptr;

  while (!initializer_clause()) {
    count++;
    if (parse_COMMA()) break;
  };
  if (count>0) {return (0);};
  ptr=old;
  return (-1);
};

/* ***************************************** */

void initializer_list_opt () {
  int nowhere;
  nowhere=initializer_list();
  return;
};

/* ***************************************** */

int initializer_clause() {
  int old=ptr;
  int oldnp=np;
  int count;

  if (!parse_LEFTBRACE()) {
    count=1;
    while ((count>0)&&(!the_end())) {
      if (!look_LEFTBRACE())
        count++;
      else if (!look_RIGHTBRACE())
        count--;
      ptr++;
    }
    if (the_end()) {
      ptr=old;
      np=oldnp;
      return -1;
    }
    return 0;
  }

  ptr=old;np=oldnp;
  suppress=1;
  set_command(BEGIN_EXPRESSION,0,_strdup(""),0,0,0);
  if (!assignment_expression()) {
    set_command(END_EXPRESSION,0,_strdup(""),0,0,0);
    suppress=0;
    return (0);
  }
  suppress=0;
  ptr=old;np=oldnp;
  return -1;
};

/* ***************************************** */

int initializer() {

int old=ptr;
int oldnp=np;

if (!parse_ASSIGN()) {
  if (!initializer_clause())
          return(0);
  else {
          ptr=old;
    np=oldnp;
          return(-1);
        }
};

if (parse_LEFTPARENTH()) {ptr=old;return(-1);};
if (expression_list()) {ptr=old;return(-1);};
if (parse_RIGHTPARENTH()) {ptr=old;np=oldnp;return(-1);};

return(0);

};

/* ***************************************** */

void initializer_opt () {

(void)initializer();

}

/* ***************************************** */

int init_declarator () {

int old=ptr;
int oldnp=np;

set_command(BEGIN_INIT_D,0,_strdup(""),0,0,0);

if (declarator()) {
  ptr=old;np=oldnp;
  return(-1);
  };

initializer_opt();

set_command(END_INIT_D,0,_strdup(""),0,0,0);
return (0);

};

/* ***************************************** */

int sing_init_declarator () {

int old=ptr;
int oldnp=np;

set_command(BEGIN_INIT_D,0,_strdup(""),0,0,0);

if (sing_declarator()) {
  ptr=old;np=oldnp;
  return(-1);
  };

initializer_opt();

set_command(END_INIT_D,0,_strdup(""),0,0,0);
return (0);

};


/* ***************************************** */

int init_declarator_list() {
  int old=ptr;
  token tok;

  if (init_declarator()) {ptr=old;return (-1);};

  while (!the_end()){
    tok=nexttok();
    if (tok.tok!=',')  {
            return 0;
    }
    advance();
    if (init_declarator()) {unadvance();return -1;};
  };
  return(0);
};

/* ***************************************** */

int sing_init_declarator_list() {

int old=ptr;

token tok;

if (sing_init_declarator()) {ptr=old;return (-1);};

while (!the_end()){
  tok=nexttok();
  if (tok.tok!=',') return (0);
  advance();
  if (sing_init_declarator()) {unadvance();return (-1);};
};

return(0);

};

/* ***************************************** */

void declaration_seq() {
  while (!the_end()) {
    if (declaration()) {
      panic();
    }
  }

  set_command(END_FILE,0,_strdup(""),yylineno-1,0,0);
  code.size=np;
}

/* ***************************************** */

void declaration_seq_opt () {
  (void)declaration_seq() ;
};
