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

#define BEGIN_MEMBER_DECLARATION 1
#define END_MEMBER_DECLARATION 2
#define BEGIN_SIMPLE_DECL 3
#define END_SIMPLE_DECL 4
#define BEGIN_MEMB 5
#define END_MEMB 6
#define BEGIN_FDEF 7
#define END_FDEF 8
#define BEGIN_DECLARATOR 9
#define END_DECLARATOR 10
#define BEGIN_FDECL 11
#define END_FDECL 12
#define BEGIN_FBODY 13
#define END_FBODY 14
#define sym_func_decl_id 15
#define sym_decl_id 16
#define BEGIN_FPARAMS 17
#define END_FPARAMS 18
#define BEGIN_CD 19
#define MID_CD 20
#define END_CD 21
#define ACCESS_PUBLIC 22
#define ACCESS_PRIVATE 23
#define ACCESS_PROTECTED 24
#define decl_specifier_seq_opt_begin 25
#define decl_specifier_seq_opt_end 26
#define BEGIN_MEMB_DECLARATOR 27
#define END_MEMB_DECLARATOR 28
#define SYM_TYPE_ID 29
#define DECL_PARAM_PART_BEGIN 30
#define DECL_PARAM_PART_END 31
#define BEGIN_BASES 32
#define END_BASES 33
#define ID 34
#define BEGIN_TD 35
#define END_TD 36
#define BEGIN_SDECL 37
#define END_SDECL 38
#define BEGIN_INIT_D 39
#define END_INIT_D 40
#define PROTECTION_LEVEL 41
#define TYPE_SYNONYM 42
#define BEGIN_EXPRESSION 43
#define END_EXPRESSION 44
#define BEGIN_WRITE 45
#define END_WRITE 46
#define SEP 47
#define REF 48
#define FREF 49
#define marker 50
#define END_FILE 51
#define CYCLO 52
#define LOWCOMPLEX 53
#define MIDCOMPLEX 54
#define HIGHCOMPLEX 55
#define LABEL 56
#define MARK_IF 57
#define MARK_ENDIF 58
#define MORE_DEPTH 59
#define LESS_DEPTH 60
#define MARK_UNSTRUCT 61
#define SYM_TYPE_NAME 62
#define RET 63
// symbols for 'U'nions and 'S'tructs
#define BEGIN_UD 64
#define BEGIN_SD 65

struct halstead {
int N1,N2,n1,n2,nsc ;
} ;

//

typedef enum protection {
  PRO_PUBLIC,
  PRO_PROTECTED,
  PRO_PRIVATE,
  PRO_PACKAGE,
  GLOBAL
  } protection;

//

typedef enum prot_status_type {
  RELEVANT,
  IRRELEVANT
  } prot_status_type;

//

typedef struct location {
  int row,col;
  } location;

//

typedef struct range_type {
  int startcol,endcol;
  int startrow,endrow;
  } range_type;

//

typedef struct name_and_range {
  range_type range;
  char* name;
  } name_and_range;

//

typedef struct node {
  int com;
  int param;
  char* str;
  int line,startcol,endcol;
  } node;

//

typedef struct code_type {
  int size;
  node* tree;
  } code_type;

//

typedef struct token {
  int tok;
  char* str;
  int line;
/*  int startcol;
  int endcol;*/
} token;


