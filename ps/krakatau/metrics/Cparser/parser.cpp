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

#include "y.tab.h"
#include "grammar.h"
#include <string.h>
#include <stdio.h>
#include "lexer.h"
#include "types.h"
#include <sys/stat.h>
#include <sys/types.h>
#include <fcntl.h>
#include <stdlib.h>
#ifdef WIN32
#include <io.h>
#include <stack>
#include <vector>
#include <list>
#include <set>
#include <fstream>
using namespace std;

#else
#include <stl.h>
#include <function.h>
#endif
#include "parser.h"
int suppress=0 ;
extern char* yytext_back ;
extern int maxtree ;
extern char* codefn(char*) ;

extern int totalOperators ;
extern int last_comment_line ;
extern int lastsline ;  // Most recent source code line number
extern int nsloc;   // Number of Source Lines Of Code
extern int nsemi ;    // Number of Semi-colons

const int debug=0;
int direct_declarator_with_params();
int declarator_with_params();
void k_and_r_params_opt();
int no_parenthesised_declarators=0;
int local_variable_declaration_statement();
void fb_statement_seq_opt();
extern vector<int> sloc;
//extern list<int> operators;
extern set<int> operators ;
extern vector<char*> operands[255];
extern int noperands;
int decl_ptr_operator();
extern int CPP_COMMENTS,C_COMMENTS,COMMENT_LINES;


bool operator==(const control_exec& x, const control_exec& y){
    return (x.control == y.control) && (x.executable == y.executable);
}

bool operator<(const control_exec& x, const control_exec& y){
  return x.control < y.control;
}

stack< control_exec* > density;

//#define printf dontprintf
void dontprintf(char* s,...) {};


/* **************************************** */

/* ************************************* */

code_type code;
int np=-1;

/* ************************************* */
token* tokens;
token badtoken;

int lex_ceiling=200000;
int ntokens=0;
int ptr=-1;

int partition(char** a,int l,int r) {

int lp,rp,f;
char* temp;

//printf("PARTITION: %d %d\n",l,r);
// select f as the element to go in the final position
f=r; // select rightmost element
lp=l;rp=r; // initialise left/right pointers

// go until scan pointers cross
while (rp>lp) {
 // printf("1: LP %d RP %d\n",lp,rp) ;
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

void quicksort(char** a,int l,int r) {
  int i;
  if (r>l) {
    i=partition(a,l,r);
    quicksort(a,l,i-1);
    quicksort(a,i+1,r);
  };
}


void quicksort(char** a,int N) {
  int i,l,r;
  stack<int > st;
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


  quicksort(a,in->size()-1);

  for (i=0;i<in->size();i++) {
    if (strcmp(a[i],laststring)) {
    laststring=a[i];
    ret++;
    };
  };

  free (a);
  return ret;

};

char* num_to_com(int);

halstead compute_halstead(int min,int max) {

  halstead ret ;
  int i ;
  list<int> operator_list ;
  vector<char*> operand_vec ;
  ret.nsc=0 ;

  min++ ;
  //printf("MIN   : %d  MAX   : %d\n",min,max);
  //printf("MINTOK: %d  MAXTOK: %d\n",tokens[min].tok,tokens[max].tok);

  for (i=min;i<=max;i++) {
    switch (tokens[i].tok) {
    case CONSTANT:
      operand_vec.push_back(tokens[i].str) ;
      break ;
    case IDENTIFIER:
      operand_vec.push_back(tokens[i].str) ;
      break ;
    case STRING_LITERAL:
  //      operand_vec.push_back(tokens[i].str);
      break ;

    case COLONCOLON:case GREATGREATEQUALS:case LESSLESSEQUALS:
    case PLUSEQUALS:case MINUSEQUALS:case TIMESEQUALS:
    case DIVEQUALS:case MODEQUALS:case ANDEQUALS:
    case CARETEQUALS:case BAREQUALS:case GREATERGREATER:
    case LESSLESS:case INC_OP:case DEC_OP:
    case DOT_STAR:case PTR_OP_STAR:case PTR_OP:
    case AND_OP:case OR_OP:case LESSEQUALS:
    case GREATEREQUALS:case EQUALS:case NOTEQUALS:
    case '[':case '.':case '&':case '!':
    case '~':case '-':case '+':case '*':
    case '/':case '%':case LT:case GT:
    case '^':case '|':case '?': case '=':
      operator_list.push_back(tokens[i].tok) ;
      break ;
    case ';':
      ret.nsc++ ;
      break ;
    }
  }

  ret.N1=operator_list.size();
  ret.N2=operand_vec.size();
  ret.n2=get_n_unique_operands(&operand_vec);
  operator_list.sort();
  operator_list.unique();
  ret.n1=operator_list.size();

  return ret ;
}

void set_command (int com,int param,char* str,int line, int startcol, int endcol) {
  /*
    if (com==BEGIN_DECLARATOR)
      printf("SET_COMMAND HERE\n");
  */
  if (suppress==1) return;
  np++;
  if (np>=maxtree) {
    code.tree=(node*)realloc((void*)(code.tree),sizeof(node)*(2*maxtree));
    maxtree*=2;
   //printf("RESIZING code.tree to: %d\n",maxtree);
  };
  //printf("COM: %s\n",num_to_com(com));
  code.tree[np].com=com;
  code.tree[np].param=param;
  code.tree[np].str=str;
  code.tree[np].line=line;
  code.tree[np].startcol=startcol;
  code.tree[np].endcol=endcol;
};

/* ************************************** */

char* num_to_com(int comm) {

switch (comm) {
  case marker: return ("MARKER\t");
  case BEGIN_MEMBER_DECLARATION: return ("BEGIN_MEMBER_DECLARATION");
  case END_MEMBER_DECLARATION: return ("END_MEMBER_DECLARATION");
  case BEGIN_SIMPLE_DECL: return ("BEGIN_SIMPLE_DECL");
  case END_SIMPLE_DECL: return ("END_SIMPLE_DECL");
  case BEGIN_MEMB: return ("BEGIN_MEMB");
  case END_MEMB: return ("END_MEMB");
  case BEGIN_DECLARATOR: return ("BEGIN_DECLARATOR");
  case END_DECLARATOR: return ("END_DECLARATOR");
  case BEGIN_INIT_D:  return ("BEGIN_INIT_D");
  case END_INIT_D: return ("END_INIT_D");
  case BEGIN_FDEF: return ("BEGIN_FDEF");
  case END_FDEF: return ("END_FDEF");
  case BEGIN_FDECL: return ("BEGIN_FDECL");
  case END_FDECL: return ("END_FDECL");
  case BEGIN_FBODY: return ("BEGIN_FBODY");
  case END_FBODY: return ("END_FBODY");
  case BEGIN_CD: return ("BEGIN_CD");
  case MID_CD: return ("MID_CD");
  case END_CD: return ("END_CD");
  case sym_func_decl_id: return ("SYM_FUNC_DECL_ID");
  case sym_decl_id: return ("SYM_DECL_ID");
  case BEGIN_FPARAMS: return ("BEGIN_FPARAMS");
  case END_FPARAMS: return ("END_FPARAMS");
  case ACCESS_PRIVATE: return ("ACCESS_PRIVATE");
  case ACCESS_PUBLIC: return ("ACCESS_PUBLIC");
  case ACCESS_PROTECTED: return ("ACCESS_PROTECTED");
  case decl_specifier_seq_opt_begin: return ("DECL_SPECIFIER_SEQ_OPT_BEGIN");
  case decl_specifier_seq_opt_end: return ("DECL_SPECIFIER_SEQ_OPT_END");
  case BEGIN_MEMB_DECLARATOR: return ("MEMBER_DECLARATOR_BEGIN");
  case END_MEMB_DECLARATOR: return ("MEMBER_DECLARATOR_END");
  case SYM_TYPE_ID: return  ("SYM_TYPE_ID");
  case DECL_PARAM_PART_BEGIN: return ("DECL_PARAM_PART_BEGIN");
  case DECL_PARAM_PART_END: return ("DECL_PARAM_PART_END");
  case BEGIN_BASES: return ("BEGIN_BASES");
  case END_BASES: return ("END_BASES");
  case ID: return ("ID");
  case BEGIN_TD: return ("BEGIN_TD");
  case END_TD: return ("END_TD");
  case BEGIN_SDECL: return ("BEGIN_SDECL");
  case END_SDECL: return ("END_SDECL");
  case PROTECTION_LEVEL: return ("PROTECTION_LEVEL");
  case TYPE_SYNONYM: return ("TYPE_SYNONYM");
  case BEGIN_EXPRESSION: return ("BEGIN_EXPRESSION");
  case END_EXPRESSION: return ("END_EXPRESSION");
  case BEGIN_WRITE: return ("BEGIN_WRITE");
  case END_WRITE: return ("END_WRITE");
  case SEP: return ("SEP");
  case REF: return ("REF");
  case FREF: return ("FREF");
  case CYCLO: return ("CYCLO");
  case END_FILE: return ("END_FILE");
  case LOWCOMPLEX : return ("LOWCOMPLEX");
  case MIDCOMPLEX : return ("MIDCOMPLEX");
  case HIGHCOMPLEX: return ("HIGHCOMPLEX");
  case LABEL : return ("LABEL");
  case MARK_IF : return ("MARK_IF");
  case MARK_ENDIF : return ("MARK_ENDIF");
  case MORE_DEPTH: return ("MORE_DEPTH");
  case LESS_DEPTH: return ("LESS_DEPTH");
  case MARK_UNSTRUCT: return ("MARK_UNSTRUCT");
  case SYM_TYPE_NAME: return ("SYM_TYPE_NAME");
  case RET : return ("RET");
  case BEGIN_UD: return ("BEGIN_UD");
  case BEGIN_SD: return ("BEGIN_SD");
  default: return ("********* UNKNOWN");
  };
};

/* *************************************** */

void show_tree () {

int i;

//fprintf(stderr,"DISPLAY SECTION\n");
//fflush(stderr);
if (debug) printf("SHOW_TREE (SIZE: %d, %d)\n",code.size,np);
//fprintf(stderr,"SHOW_TREE (SIZE: %d, %d)\n",code.size,np);
//fflush(stderr);
if (np>-1) {
  for (i=0;i<=np;i++) {
//    fprintf(stderr,"ntc:%s str:%s I:%d\n",num_to_com(code.tree[i].com),(code.tree[i]).str,i);
//    if (debug)
    if (code.tree[i].com!=END_FDEF)
      printf("NODE: %s, %d, %s, %d,%d,%d\n",num_to_com(code.tree[i].com),(code.tree[i]).param,(code.tree[i]).str,code.tree[i].line,code.tree[i].startcol,code.tree[i].endcol);
          else
      printf("NODE: %s, %d, %d, %d,%d,%d\n",num_to_com(code.tree[i].com),(code.tree[i]).param,(int)((code.tree[i]).str),code.tree[i].line,code.tree[i].startcol,code.tree[i].endcol);
  }
  };
if (debug) printf("SHOW_TREE_DONE\n");
};

/* *************************************** */

/* *************************************** */


/* *************************************** */

bool alphabet(char* str_a,char* str_b) {

return (lexicographical_compare(str_a,strchr(str_a,'\0')-1,str_b,strchr(str_b,'\0')-1));

}

/* *************************************** */

void errorFile(FILE* outfile) {
  // Output END

  //logFile << "errorFile called" << endl ;

  fprintf(outfile,"%d\n",-101) ;
  fprintf(outfile,"%d\n",-1) ;
  fprintf(outfile,"-----\n") ;
  fprintf(outfile,"%d\n",-1) ;
  fprintf(outfile,"-1\n") ;
  fprintf(outfile,"-1\n") ;

  fflush(outfile) ;
  //logFile << "flushed." << endl ;

  //fprintf(outfile,"0\n");
}


//void statistics (char* outfilename) {
void statistics (FILE* outfile) {

  int i,g;
  //logFile << "statistics called" << endl ;


  for (i=0;i<=np;i++) {
    if (code.tree[i].com==END_FDEF) {
      fprintf(outfile,"%d\n%d\n%d\n%d\n%d\n%d\n",code.tree[i].com,code.tree[i].param,(int)(code.tree[i].str),code.tree[i].line,code.tree[i].startcol,code.tree[i].endcol);

      /*logFile << code.tree[i].com << '\t' <<
        code.tree[i].param << '\t' <<
        '*' << (int)(code.tree[i].str) << '\t' <<
        code.tree[i].line << '\t' <<
        code.tree[i].startcol << '\t' <<
        code.tree[i].endcol << endl ;*/

    } else {
        if (strlen(code.tree[i].str)>0)
      {
        fprintf(outfile,"%d\n%d\n%s\n%d\n%d\n%d\n",code.tree[i].com,code.tree[i].param,code.tree[i].str,code.tree[i].line,code.tree[i].startcol,code.tree[i].endcol);

        /*logFile << code.tree[i].com << '\t' <<
          code.tree[i].param << '\t' <<
          code.tree[i].str << '\t' <<
          code.tree[i].line << '\t' <<
          code.tree[i].startcol << '\t' <<
          code.tree[i].endcol << endl ;*/

      }
      else
      {
        fprintf(outfile,"%d\n%d\nX\n%d\n%d\n%d\n",code.tree[i].com,code.tree[i].param,code.tree[i].line,code.tree[i].startcol,code.tree[i].endcol);

        /*logFile << code.tree[i].com << '\t' <<
          code.tree[i].param << "\tnull\t" <<
          code.tree[i].line << '\t' <<
          code.tree[i].startcol << '\t' <<
          code.tree[i].endcol << endl ;*/

      }
    }
  }

  // now output the Halstead information



  // calculate number of unique operands

  g=0;
  for (i=0;i<255;i++)
    g+=operands[i].size();

  fprintf(outfile,"%d\n",noperands);
  //fprintf(outfile,"%d\n",operators.size());
  fprintf(outfile,"%d\n",totalOperators);
  fprintf(outfile,"X\n");

  // calculate number of unique operators

  //operators.sort();
  //operators.unique();

  fprintf(outfile,"%d\n",g) ;
  fprintf(outfile,"%d\n",operators.size()) ;
  fprintf(outfile,"0\n") ;

  fprintf(outfile,"%d\n",C_COMMENTS) ;
  fprintf(outfile,"%d\n",CPP_COMMENTS) ;
  fprintf(outfile,"X\n") ;
  fprintf(outfile,"%d\n",COMMENT_LINES) ;
  fprintf(outfile,"%d\n", nsemi) ;
  fprintf(outfile,"0\n") ;

  // Output END
  fprintf(outfile,"%d\n",-100) ;
  fprintf(outfile,"%d\n",-1) ;
  fprintf(outfile,"-----\n") ;
  fprintf(outfile,"%d\n",-1) ;
  fprintf(outfile,"-1\n") ;
  fprintf(outfile,"-1\n") ;

  fflush(outfile) ;
  //logFile << "flushed." << endl ;

}

/* *************************************** */

char s_t_g[1000000];

char* sym_text(int a,int b) {

  int i;
  s_t_g[0]='\0';
  for (i=(a+1);i<=b;i++)
    strcat((char*)s_t_g,tokens[i].str);
  return strdup((char*)s_t_g);

};

/* *************************************** */

void sym_name(int a,int b) {

int i;

for (i=(a+1);i<=b;i++)
  if (debug) printf("==> %s \n",tokens[i].str);

};

/* *************************************** */

void expand_lexeme_storage_array () {

token* tmp;
long tmpsize;
//printf("Expand from: %d\n",lex_ceiling);
tmp=tokens;
tmpsize=sizeof(token)*(lex_ceiling+200000);
tokens=(token*)realloc(tmp,sizeof(token)*(lex_ceiling+200000));
if (tokens==NULL) {
  fprintf(stderr,"Out of memory.\n");
  _exit(0);
}
//fprintf(stderr,"Realloc to %d\n",tmpsize);

if (tokens!=tmp) {
 // printf("moved!\n");
 //  free(tmp);
}
lex_ceiling+=200000;
//if (lex_ceiling>200000) exit(0);
//printf("New size: %d bytes, %d k, %d mb\n",sizeof(token)*lex_ceiling,(sizeof(token)*lex_ceiling)/1024,(sizeof(token)*lex_ceiling)/1024/1024);

}

/* *************************************** */
extern FILE *yyin ;
//void initialise(char* filename,char* origfilename) {
void initialise() {
  // Initialise global vars - for using parser multiple times

  totalOperators=0;
  yylineno=0;
  C_COMMENTS=0;
  CPP_COMMENTS=0;
  COMMENT_LINES=0;
  last_comment_line=-1;

  noperands=0;

  lastsline=-1;
  nsloc=0;

  lex_ceiling=200000;
  maxtree=100000 ;
  ntokens=0;
  ptr=-1;
  yytext[0]='\0';

  int tok;
  np=-1;

  code.tree=(node*)malloc(sizeof(node)*maxtree);

  tokens=(token*)malloc(sizeof(token)*lex_ceiling);

  badtoken.tok=-1;

  while ((tok=yylex())>0)
  {
    if (ntokens==lex_ceiling)
      expand_lexeme_storage_array();

    tokens[ntokens].tok=tok;
    tokens[ntokens].line=yylineno;

    if ((tok!=IDENTIFIER)&&(tok!=CONSTANT)&&(tok!=STRING_LITERAL))
    {
      tokens[ntokens++].str=strdup((char*)yytext);
    }
    else
    {
      if (yytext_back)
        tokens[ntokens++].str=strdup(yytext_back);
      else
        tokens[ntokens++].str=strdup("");
    }
  }

//  while ((c=getchar())!=EOF)
//    if (c=='\n')
//      yylineno++ ;

  yylineno++ ;
  //codefn(origfilename) ;
  //set_command(ID,0,origfilename,0,0,0) ;

  set_command(ID,0,strdup("aaa"),0,0,0) ;
}

void tidyup()
{
  int i;
  for (i=0;i<=np;i++) {
    if (code.tree[i].com!=END_FDEF)
    {
//      if ( ((code.tree[i]).str!=NULL) && (strlen(code.tree[i].str)>0) )
//      {
        free (code.tree[i].str) ;
//      }
    }
  }

  for (i=0;i<ntokens;i++)
  {
    //if ( (tokens[i].str!=NULL) && (strlen(tokens[i].str)>0) )
//    {
      free (tokens[i].str);
//    }
  }

  for (i=0 ; i<255 ; i++)
  {
    for (int j=0 ; j<operands[i].size() ;i++)
    {
      free(operands[i][j]) ;
      operands[i].clear() ;
    }
  }
  operators.clear();

  free (code.tree);

  free (tokens) ;

}

/* **************************************** */

token nexttok() {

  if (!the_end()) return(tokens[ptr+1]);
  return (badtoken);

}

/* ****************************************** */

// `Where are we?' information

int thiscol() {return 0;};//return (nexttok().startcol);};
int lastcol() {return 0;};//return (tokens[ptr].endcol);};
int thisline() {if (nexttok().tok==-1) return (tokens[ptr].line); else return (nexttok().line);}

/* ****************************************** */

void advance() {
  ptr++;
}

/* ****************************************** */

void unadvance() {
  ptr--;
}

/* ****************************************** */

/* detect the end of the lexemes */
int the_end() {
  return((ptr+1)==ntokens);
}

/* ***************************************** */

void panic() {

// need a better panic algm. got one!

// make a stack for  {} [] ()
// while (not(the_end)AND not(done))
//   if we see a (){}[], put it's complement on the stack and assert 'done'
//   else if we see a parse_SEMICOLON, goto DONE
// while not(the_end)
//   if other_symbol
//     move on
//   else
//     if stack_empty
//       place complement on stack
//     else if on top of stack
//             pop
//             if empty goto DONE
//             move on
//          else
//             clear stack
//             move on
// DONE:

  token tok;

  //#ifdef solaris
  stack< char  > enclosures;
  //#else
  //stack<char > enclosures;
  //#endif

  int done;

  // get the first one!
  tok=nexttok();
  done=0;
  while ((!the_end())&&(!done)) {
    switch (tok.tok) {
    case ';':
      goto panic_over;
        break;  // notionally!

    case '{':
      enclosures.push('}');
      done=1;
      break;

    case '[':
      enclosures.push(']');
      done=1;
      break;

    case '(':
      enclosures.push(')');
      done=1;
      break;

    case LT:
      enclosures.push((char)GT);
      done=1;
      break;

    default:  // stuff here?  Don't think so...
       break;
    } ;
    if (debug) printf("SHIFTING: %s\n",tok.str);
    advance();
    tok=nexttok();
  };
  if (debug) printf("PHASE2SHIFT\n");
  if (the_end()) goto panic_over;

  while (!the_end()) {
    if (debug) printf("STACK: %d\n",enclosures.size());
    switch(tok.tok) {
      case '{': enclosures.push('}');
          break;
      case '}':
        if (!enclosures.empty()) {
          if (enclosures.top()=='}') {
          enclosures.pop();
          if (enclosures.empty()) {
                  if (debug) printf("SHIFTING: %s\n",tok.str);
            advance();tok=nexttok();
            goto panic_over;
          };
          } else {
            while (!enclosures.empty()) enclosures.pop();
          };
        };
        break;
      case '[': enclosures.push(']');
          break;
      case ']':
        if (!enclosures.empty()) {
          if (enclosures.top()==']') {
            enclosures.pop();
            if (enclosures.empty()) {
                  if (debug) printf("SHIFTING: %s\n",tok.str);
            advance();tok=nexttok();
          goto panic_over;
            };
          } else {
            while (!enclosures.empty()) enclosures.pop();
          };
           };
        break;
      case '(': enclosures.push(')');
          break;
      case ')':if (!enclosures.empty()) {
          if (enclosures.top()==')') {
          enclosures.pop();
          if (enclosures.empty()) {
                  if (debug) printf("SHIFTING: %s\n",tok.str);
            advance();tok=nexttok();
          goto panic_over;
            };
          } else {
            while (!enclosures.empty()) enclosures.pop();
          };
           };
        break;
      case LT: enclosures.push((char)GT);
        break;
      case GT: if (!enclosures.empty()) {
          if (enclosures.top()==(char)GT) {
            enclosures.pop();
            if (enclosures.empty()) {
            if (debug) printf("SHIFTING: %s\n",tok.str);
            advance();tok=nexttok();
            goto panic_over;
            };
          } else {
            while (!enclosures.empty()) enclosures.pop();
          };

        };
        break;
      default:
        break;
    };
      if (debug) printf("SHIFTING: %s\n",tok.str);
    advance();tok=nexttok();
  };
  panic_over:
  if (debug) printf("...PANICOVER\n");
  return;
}
/* ***************************************** */

void append_sloc_information() {
  unsigned int i;

  set_command(marker,sloc.size(),strdup(""),0,0,0);
  for (i=0;i<sloc.size();i++)
    set_command(marker,sloc[i],strdup(""),0,0,0);

  set_command(END_FILE,0,strdup(""),0,0,0);
}

/* **************************************** */


