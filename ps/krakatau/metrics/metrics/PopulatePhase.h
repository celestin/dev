/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 * Krakatau Metrics (metrics.exe)
 * Copyright (c) 2001,2008 SourceCodeMetrics.com
 * Author Craig McKay <craig.mckay@powersoftware.com>
 *
 * $Id$
 *
 * Who  When       Why
 * CAM  24-Jan-08  337 : Add to source control.
 * CAM  22-Jan-08  339 : Corrected deprecation warnings.
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

#ifndef METRICS_POPULATEPHASE
#define METRICS_POPULATEPHASE

//#include <iostream>

#include "Lexeme.h"
#include "MasterData.h"
#include "Phase.h"
#include "RootNode.h"
#include "SymbolNode.h"
#include "Subproject.h"
#include "prep.h"

//#include <io.h>
#include <fcntl.h>

#include <string>
#include <vector>
//#include <fstream.h>

#define LOOK_TERMINAL(X) () { if (((unsigned int)lex_index<lexemes.size())&&(lexemes[lex_index]->com==X)) { return 0; } return -1; }

//typedef enum {PACKAGE,PUBLIC,PROTECTED,PRIVATE} protection;

#define FOUND 0
#define NOT_FOUND -1

#ifdef LANGUAGE_CPP
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
#define BEGIN_UD 64
#define BEGIN_SD 65
#endif


#ifdef LANGUAGE_JAVA
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
#define BEGIN_READ 18
#define END_READ 19
#define BEGIN_WRITE 20
#define END_WRITE 21
#define PATH 22
#define END_PATH_JIL 23
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
#define ETYPE 58
#endif

namespace metrics
{

  class PopulatePhase : public Phase
  {
  private:

#ifdef LANGUAGE_CPP
    unsigned int look_ACCESS_PUBLIC LOOK_TERMINAL(ACCESS_PUBLIC)
    int look_ACCESS_PRIVATE LOOK_TERMINAL(ACCESS_PRIVATE)
    int look_ACCESS_PROTECTED LOOK_TERMINAL(ACCESS_PROTECTED)
    int look_BEGIN_WRITE LOOK_TERMINAL(BEGIN_WRITE)
    int look_BEGIN_SIMPLE_DECL LOOK_TERMINAL(BEGIN_SIMPLE_DECL)
    int look_BEGIN_EXPRESSION LOOK_TERMINAL(BEGIN_EXPRESSION)
    int look_BEGIN_FDEF LOOK_TERMINAL(BEGIN_FDEF)
    int look_BEGIN_MEMBER_DECLARATION LOOK_TERMINAL(BEGIN_MEMBER_DECLARATION)
    int look_BEGIN_MEMB LOOK_TERMINAL(BEGIN_MEMB)
    int look_BEGIN_DECLARATOR LOOK_TERMINAL(BEGIN_DECLARATOR)
    int look_BEGIN_INIT_D LOOK_TERMINAL(BEGIN_INIT_D)
    int look_BEGIN_FDECL LOOK_TERMINAL(BEGIN_FDECL)
    int look_BEGIN_TD LOOK_TERMINAL(BEGIN_TD)
    int look_BEGIN_FBODY LOOK_TERMINAL(BEGIN_FBODY)
    int look_BEGIN_BASES LOOK_TERMINAL(BEGIN_BASES)
    int look_BEGIN_MEMB_DECLARATOR LOOK_TERMINAL(BEGIN_MEMB_DECLARATOR)
    int look_BEGIN_SDECL LOOK_TERMINAL(BEGIN_SDECL)
    int look_BEGIN_FPARAMS LOOK_TERMINAL(BEGIN_FPARAMS)
    int look_BEGIN_CD LOOK_TERMINAL(BEGIN_CD)
    int look_CYCLO LOOK_TERMINAL(CYCLO)
    int look_DECL_PARAM_PART_END LOOK_TERMINAL(DECL_PARAM_PART_END)
    int look_decl_specifier_seq_opt_begin LOOK_TERMINAL(decl_specifier_seq_opt_begin)
    int look_DECL_PARAM_PART_BEGIN LOOK_TERMINAL(DECL_PARAM_PART_BEGIN)
    int look_decl_specifier_seq_opt_end LOOK_TERMINAL(decl_specifier_seq_opt_end)
    int look_END_BASES LOOK_TERMINAL(END_BASES)
    int look_END_CD LOOK_TERMINAL(END_CD)
    int look_END_DECLARATOR LOOK_TERMINAL(END_DECLARATOR)
    int look_END_EXPRESSION LOOK_TERMINAL(END_EXPRESSION)
    int look_END_FILE LOOK_TERMINAL(END_FILE)
    int look_END_FDEF LOOK_TERMINAL(END_FDEF)
    int look_END_FDECL LOOK_TERMINAL(END_FDECL)
    int look_END_FBODY LOOK_TERMINAL(END_FBODY)
    int look_END_FPARAMS LOOK_TERMINAL(END_FPARAMS)
    int look_END_INIT_D LOOK_TERMINAL(END_INIT_D)
    int look_END_MEMB LOOK_TERMINAL(END_MEMB)
    int look_END_MEMB_DECLARATOR LOOK_TERMINAL(END_MEMB_DECLARATOR)
    int look_END_MEMBER_DECLARATION LOOK_TERMINAL(END_MEMBER_DECLARATION)
    int look_END_SDECL LOOK_TERMINAL(END_SDECL)
    int look_END_SIMPLE_DECL LOOK_TERMINAL(END_SIMPLE_DECL)
    int look_END_TD LOOK_TERMINAL(END_TD)
    int look_END_WRITE LOOK_TERMINAL(END_WRITE)
    int look_FREF LOOK_TERMINAL(FREF)
    int look_HIGHCOMPLEX LOOK_TERMINAL(HIGHCOMPLEX)
    int look_ID LOOK_TERMINAL(ID)
    int look_LABEL LOOK_TERMINAL(LABEL)
    int look_LESS_DEPTH LOOK_TERMINAL(LESS_DEPTH)
    int look_LOWCOMPLEX LOOK_TERMINAL(LOWCOMPLEX)
    int look_MARK_IF LOOK_TERMINAL(MARK_IF)
    int look_MARK_UNSTRUCT LOOK_TERMINAL(MARK_UNSTRUCT)
    int look_MARK_ENDIF LOOK_TERMINAL(MARK_ENDIF)
    int look_marker LOOK_TERMINAL(marker)
    int look_MID_CD LOOK_TERMINAL(MID_CD)
    int look_MIDCOMPLEX LOOK_TERMINAL(MIDCOMPLEX)
    int look_MORE_DEPTH LOOK_TERMINAL(MORE_DEPTH)
    int look_PROTECTION_LEVEL LOOK_TERMINAL(PROTECTION_LEVEL)
    int look_REF LOOK_TERMINAL(REF)
    int look_RET LOOK_TERMINAL(RET)
    int look_SEP LOOK_TERMINAL(SEP)
    int look_sym_decl_id LOOK_TERMINAL(sym_decl_id)
    int look_sym_func_decl_id LOOK_TERMINAL(sym_func_decl_id)
    int look_SYM_TYPE_ID LOOK_TERMINAL(SYM_TYPE_ID)
    int look_TYPE_SYNONYM LOOK_TERMINAL(TYPE_SYNONYM)
    int look_BEGIN_STRUCT LOOK_TERMINAL(BEGIN_SD)
#endif

#ifdef LANGUAGE_JAVA
    int look_ACCESS_IDS LOOK_TERMINAL(ACCESS_IDS)
    int look_BEGIN_EXPRESSION LOOK_TERMINAL(BEGIN_EXPRESSION)
    int look_CYCLO LOOK_TERMINAL(CYCLO)
    int look_END_ACCESS_IDS LOOK_TERMINAL(END_ACCESS_IDS)
    int look_END_BODY LOOK_TERMINAL(END_BODY)
    int look_END_EXTENDS LOOK_TERMINAL(END_EXTENDS)
    int look_END_EXPRESSION LOOK_TERMINAL(END_EXPRESSION)
    int look_END_IMPLEMENTS LOOK_TERMINAL(END_IMPLEMENTS)
    int look_END_PATH_JIL LOOK_TERMINAL(END_PATH_JIL)
    int look_END_PARAMS LOOK_TERMINAL(END_PARAMS)
    int look_END_READ LOOK_TERMINAL(END_READ)
    int look_END_UNIT LOOK_TERMINAL(END_UNIT)
    int look_END_UNIT_HEADER LOOK_TERMINAL(END_UNIT_HEADER)
    int look_END_WRITE LOOK_TERMINAL(END_WRITE)
    int look_ETYPE LOOK_TERMINAL(ETYPE)
    int look_FIELD LOOK_TERMINAL(FIELD)
    int look_HIGHCOMPLEX LOOK_TERMINAL(HIGHCOMPLEX)
    int look_ID LOOK_TERMINAL(ID)
    int look_INHERITS LOOK_TERMINAL(INHERITS)
    int look_INVOKE LOOK_TERMINAL(INVOKE)
    int look_JIL_CLASS LOOK_TERMINAL(JIL_CLASS)
    int look_JIL_COM_LOC LOOK_TERMINAL(JIL_COM_LOC)
    int look_JIL_C_COM LOOK_TERMINAL(JIL_C_COM)
    int look_JIL_CPP_COM LOOK_TERMINAL(JIL_CPP_COM)
    int look_JIL_CTRL LOOK_TERMINAL(JIL_CTRL)
    int look_JIL_EXTENDS LOOK_TERMINAL(JIL_EXTENDS)
    int look_JIL_EXEC LOOK_TERMINAL(JIL_EXEC)
    int look_JIL_IMPLEMENTS LOOK_TERMINAL(JIL_IMPLEMENTS)
    int look_JIL_IMPORT LOOK_TERMINAL(JIL_IMPORT)
    int look_JIL_INTERFACE LOOK_TERMINAL(JIL_INTERFACE)
    int look_JIL_J_COM LOOK_TERMINAL(JIL_J_COM)
    int look_JIL_n1 LOOK_TERMINAL(JIL_n1)
    int look_JIL_n2 LOOK_TERMINAL(JIL_n2)
    int look_JIL_N1 LOOK_TERMINAL(JIL_N1)
    int look_JIL_N2 LOOK_TERMINAL(JIL_N2)
    int look_JIL_PROTECTED LOOK_TERMINAL(JIL_PROTECTED)
    int look_JIL_PRIVATE_PROTECTED LOOK_TERMINAL(JIL_PRIVATE_PROTECTED)
    int look_JIL_PACKAGE LOOK_TERMINAL(JIL_PACKAGE)
    int look_JIL_PRIVATE LOOK_TERMINAL(JIL_PRIVATE)
    int look_JIL_PUBLIC LOOK_TERMINAL(JIL_PUBLIC)
    int look_JIL_SLOC LOOK_TERMINAL(JIL_SLOC)
    int look_LESS_DEPTH LOOK_TERMINAL(LESS_DEPTH)
    int look_LOCAL LOOK_TERMINAL(LOCAL)
    int look_LOWCOMPLEX LOOK_TERMINAL(LOWCOMPLEX)
    int look_MARK_IF LOOK_TERMINAL(MARK_IF)
    int look_MARK_UNSTRUCT LOOK_TERMINAL(MARK_UNSTRUCT)
    int look_MARK_ENDIF LOOK_TERMINAL(MARK_ENDIF)
    int look_METHOD LOOK_TERMINAL(METHOD)
    int look_MIDCOMPLEX LOOK_TERMINAL(MIDCOMPLEX)
    int look_MODS LOOK_TERMINAL(MODS)
    int look_MORE_DEPTH LOOK_TERMINAL(MORE_DEPTH)
    int look_PATH LOOK_TERMINAL(PATH)
    int look_READ LOOK_TERMINAL(BEGIN_READ)
    int look_RET LOOK_TERMINAL(RET)
    int look_SEP LOOK_TERMINAL(SEP)
    int look_TYPE LOOK_TERMINAL(TYPE)
    int look_WRITE LOOK_TERMINAL(BEGIN_WRITE)
    int look_XREF LOOK_TERMINAL(XREF)
#endif

    std::vector<Lexeme*> lexemes;
    std::vector<int> sloc_v;

    unsigned int lex_index,lexsize;

    int N1,N2,n1,n2 ;
    int cpp_com, j_com, c_com, com, nsemi ;

    int theNoOfFiles, currentFile ;
    bool committing ;

    bool debugging ;

    bool useTranslationFile ;
    std::string theTranslationFile ;

    std::ifstream theInput ;
    SymbolNode theProjNode ;

    SymbolNode getPackage(std::string) ;


#ifdef LANGUAGE_JAVA
    std::string parseID() { return lexemes[lex_index++]->str ; }
    void parseGregariousModifiers_opt (SymbolNode &item) ;
    void parseGregariousModifiers_opt() ;
    void parseBlockStatement(SymbolNode &parent) ;
    void parseProtection_opt(SymbolNode &item) ;
    void parseProtection_opt() ;
    void parseExpression(SymbolNode &parent) ;
    void parseFieldExpression() ;
    void parseField(SymbolNode &parent) ;
    void parseParameter(SymbolNode &parent) ;
    void parseImportList(SymbolNode &file) ;
    void parseInherits(SymbolNode &parent) ;
    void parseClassImplements(SymbolNode &parent) ;
    void parseTypeDecl(SymbolNode &parent) ;
    void parseClassBody(SymbolNode &parent) ;
    void parseMethod(SymbolNode &parent) ;
    void parseMethodBody(SymbolNode &parent) ;
    void parseMethodDeclarator(SymbolNode &methodNode) ;
    void parseMethodHeader(SymbolNode &parent) ;
    void parseInterfaceDecl(SymbolNode &parent) ;
    void parseInterfaceBody(SymbolNode &parent) ;
    void parseInterfaceExtends(SymbolNode &parent) ;
    int parseClassDecl(SymbolNode &parent) ;
#endif

#ifdef LANGUAGE_CPP
    int parseClassDecl(SymbolNode &parent,int in_pro) ;
    void parse_func_decl_spec(SymbolNode &parent) ;
    int parseFunctionParameter(SymbolNode &func) ;
    int parseAbstractFunctionParameter(SymbolNode &func) ;
    int parseMethodExpression(SymbolNode &func,int mode) ;
    int parseFunction(SymbolNode &parent,int pro) ;
    int parseSimpleDecl(SymbolNode &parent,int pro) ;
#endif

    int parseClassMember(SymbolNode &parent,int *pro) ;
    int parseDeclaration(SymbolNode &parent) ;
    void clearLexemes() ;

#ifdef WIN32
    HANDLE progress_lock;
#elif sun
    mutex_t progress_lock;
#elif hpux
    pthread_mutex_t progress_lock;
#elif linux
    pthread_mutex_t progress_lock;
#endif

  protected:

    //void initParser() ;
    int  countFiles() ;
    void populateSub(SymbolNode, long, std::string) ;
    bool loadFile(std::string filename) ;
    void parseFile(std::string filename) ;
    void tamboraMetrics() ;
    void extractTypes(SymbolNode &sn) ;
    void extractLinks(SymbolNode &addFiles) ;
    //void delFiles(SourceFiles &delFiles) ;

    enum PIPES {READ,WRITE} ;

    void closeParser() ;
    int pipeA[2] ;
    int pipeB[2] ;
    char childWriteSTR[20] ;
    char childReadSTR[20] ;
    int parentWriteFD,parentReadFD ;
    char str[1000] ;

#ifdef LANGUAGE_CPP
    Prep thePreprocessor ;
#endif

  public:

    PopulatePhase() : theInput(), theProjNode(), theTranslationFile()
#ifdef LANGUAGE_CPP
      , thePreprocessor()
#endif

    {
#ifdef WIN32
      progress_lock=CreateMutex(NULL,FALSE,NULL);
#elif sun
      mutex_init(&progress_lock,0,NULL);
#elif hpux
      pthread_mutex_init(&progress_lock,pthread_mutexattr_default);
#elif linux
      pthread_mutex_init(&progress_lock,NULL);
#endif

      lex_index=lexsize = 0 ;

      committing = false ;
      currentFile = 0 ;
      theNoOfFiles = 1 ;
      useTranslationFile = false ;

//      LOCKMUTEX(progress_lock);
    }

    void setTranslationFile(std::string newFile)
    {
      theTranslationFile = newFile ;
      useTranslationFile = true ;
    }

    int getProgress() ;
    virtual void execute(RootNode *root) ;

  } ;


} ;

#endif
