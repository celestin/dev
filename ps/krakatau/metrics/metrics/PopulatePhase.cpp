/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 * Krakatau Metrics (metrics.exe)
 * Copyright (c) 2001,2008 SourceCodeMetrics.com
 * Author Craig McKay <craig.mckay@powersoftware.com>
 *
 * $Id$
 *
 * --------------------------------------------------------------------------------
 * ID  By    Date        Description
 * A01 CAM   27/09/2001  Added code to ignore structs within class body
 * A02 CAM   27/09/2001  Set NP_MET (C++)
 * C01 CAM   28/09/2001  Increment NP_MET again (Java)
 * A03 CAM   27/09/2001  Increment NP_MET for other functions (C++)
 * --------------------------------------------------------------------------------
 * Who  When       Why
 * CAM  24-Jan-08  337 : Add to source control.
 * CAM  22-Jan-08  339 : Corrected deprecation warnings.
 * CAM  02-Apr-08  339 : Corrected deprecation warnings.
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

/*
 * PopulatePhase.cpp
 * =================
 *
 * Populates the tree by calling (c/j)parser.exe on each input file
 *
 * date 27/10/2000
 * author Craig McKay & Stephen Webster
 *
 */

#include <string>
#include <fstream>
using namespace std;

#include <stdio.h>
#include <errno.h>

#include "Lexeme.h"
#include "MasterData.h"
#include "PopulatePhase.h"
#include "RootNode.h"
#include "Subproject.h"
#include "SymbolNode.h"
#include "TempLink.h"
#include "Utilities.h"
using namespace metrics ;

bool output=false ;

FILE *infile,*outfile ;

#ifdef WIN32
HANDLE parser_lock ;
#elif sun
pthread_mutex_t parser_lock ;
#elif hpux
pthread_mutex_t parser_lock ;
#elif linux
pthread_mutex_t parser_lock ;
#endif


#ifdef LANGUAGE_CPP
#define outputLexeme(x) //MasterData::theLog << x->com << "," << x->param << "," << x->str << "," << x->line << "," << x->startcol << "," << x->endcol << endl
#elif LANGUAGE_JAVA
#define outputLexeme(x) //MasterData::theLog << x->com << "\n" << x->param << "\n" << x->str << endl
#endif

//---------------------------------------------------------
//
// The following methods are used in the Java PopulatePhase
//
//---------------------------------------------------------


#ifdef LANGUAGE_JAVA
void PopulatePhase::parseProtection_opt(SymbolNode &item)
{
  item.setProtectionID(MasterData::PACKAGE_PROT);

  if (!look_JIL_PACKAGE()) {
    item.setProtectionID(MasterData::PACKAGE_PROT);
    lex_index++;
  }

  if (!look_JIL_PUBLIC()) {
    item.setProtectionID(MasterData::PUBLIC_PROT);
    lex_index++;
  }
  if (!look_JIL_PROTECTED()) {
    item.setProtectionID(MasterData::PROTECTED_PROT);
    lex_index++;
  }
  if (!look_JIL_PRIVATE()) {
    item.setProtectionID(MasterData::PRIVATE_PROT);
    lex_index++;
  }

  // TODO:
  if (!look_JIL_PRIVATE_PROTECTED()) {
  //  item->setProtection(PRIVATE_PROTECTED);
    lex_index++;
  }
}


void PopulatePhase::parseProtection_opt()
{
  if (!look_JIL_PACKAGE()) {
    lex_index++;
  }

  if (!look_JIL_PUBLIC()) {
    lex_index++;
  }
  if (!look_JIL_PROTECTED()) {
    lex_index++;
  }
  if (!look_JIL_PRIVATE()) {
    lex_index++;
  }

  if (!look_JIL_PRIVATE_PROTECTED()) {
    lex_index++;
  }
}
#endif


#ifdef LANGUAGE_JAVA
void PopulatePhase::parseGregariousModifiers_opt(SymbolNode &item)
{
  // TODO:
  if (!look_MODS()) {
    lex_index++ ;
    //item->setModifierFlags((int)((*lexemes)[lex_index++].text));
  }
}

void PopulatePhase::parseGregariousModifiers_opt()
{
  if (!look_MODS()) {
    lex_index++ ;
  }
}

#endif


#ifdef LANGUAGE_JAVA
void PopulatePhase::parseFieldExpression()
{
  lex_index++;
  while (look_END_EXPRESSION())
  {
    if (!look_BEGIN_EXPRESSION())
    parseFieldExpression();
    else
    lex_index++;
  }
  lex_index++;
}
#endif


#ifdef LANGUAGE_JAVA
void PopulatePhase::parseExpression(SymbolNode &parent)
{
  string thisRef = "" ;
  lex_index++; // BEGIN_EXPRESSION

  while (look_END_EXPRESSION()) {
    if (!look_LOWCOMPLEX()) {
    lex_index++;
    parent.incMetric(MasterData::OC_MET,0.5) ;
    }
    if  (!look_MIDCOMPLEX()) {
    lex_index++;
    parent.incMetric(MasterData::OC_MET,1.0) ;
    }
    if (!look_HIGHCOMPLEX()) {
    lex_index++;
    parent.incMetric(MasterData::OC_MET,1.5) ;
    }

    if (!look_SEP()) {
    lex_index++;
    if (thisRef.size()>0)
    {
      thisRef = thisRef.substr(0,thisRef.size()-1);
      //theRoot->theTempBuffer.add(new TempLink(parent.getID(),MasterData::XREF_LINK, thisRef)) ;
#ifdef PROFESSIONAL
      theRoot->theTempBuffer.add(new Link(parent.getID(),MasterData::XREF_LINK, thisRef)) ;
#endif
    }
    thisRef = "" ;
  }
  if (!look_XREF()) {
    //strcat(this_ref,(*lexemes)[lex_index++].text);
    //strcat(this_ref,".");
    thisRef = thisRef + lexemes[lex_index++]->str + "." ;
  }
    if (!look_BEGIN_EXPRESSION())
    parseExpression(parent);
    if (!look_JIL_CLASS())
    parseClassDecl(parent);
  }
  lex_index++; // END_EXPRESSION

  //if (strlen(this_ref)>0) {
  //  this_ref[strlen(this_ref)-1]='\0';
  //  parent->addReference(_strdup(this_ref));
  //}

  if (thisRef.size()>0)
  {
    thisRef = thisRef.substr(0,thisRef.size()-1);
    //theRoot->theTempBuffer.add(new TempLink(parent.getID(),MasterData::XREF_LINK, thisRef)) ;
#ifdef PROFESSIONAL
    theRoot->theTempBuffer.add(new Link(parent.getID(),MasterData::XREF_LINK, thisRef)) ;
#endif
  }
}
#endif


#ifdef LANGUAGE_JAVA
void PopulatePhase::parseField(SymbolNode &parent)
{
  //reference* type;
  string type = "" ;

#ifdef PROFESSIONAL
  SymbolNode fieldNode = theRoot->createSymbolNode(MasterData::FIELD_CAT) ;
  //parent.addNode(fieldNode) ;
#endif

  //type=new reference();
  //field=new fieldNode();
  //field->setParent(parent);

  lex_index++;  // FIELD

#ifdef PROFESSIONAL
  parseProtection_opt(fieldNode) ;
  parseGregariousModifiers_opt(fieldNode) ;
#else
  parseProtection_opt() ;
  parseGregariousModifiers_opt() ;
#endif

  if (!look_TYPE()) {
    lex_index++;  // TYPE
    type = lexemes[lex_index++]->str ;
    //field->setType(type);

    // TODO: check this
    long typeID = theRoot->getSymbolTypeID(type) ;
    if (typeID==-1)
    {
#ifdef PROFESSIONAL
      //theRoot->theTempBuffer.add(new TempLink(fieldNode.getID(),MasterData::TYPE_LINK,type));
      theRoot->theTempBuffer.add(new Link(fieldNode.getID(),MasterData::TYPE_LINK,type)) ;
#endif
      parent.setTypeID(0) ;
    }
    else
    {
      parent.setTypeID(typeID) ;
    }
  }

  while (!look_ID()) {
    //field=new fieldNode(field);
    //field->setParent(parent);
    //field->setName((*lexemes)[lex_index++].text);
#ifdef PROFESSIONAL
    fieldNode = theRoot->createSymbolNode(MasterData::FIELD_CAT) ;
    //fieldNode.setCategoryID(MasterData::FIELD_CAT) ;

    fieldNode.setName(lexemes[lex_index]->str);
    parent.addNode(fieldNode) ;
#endif
    lex_index++ ;

    long typeID = theRoot->getSymbolTypeID(type);
    if (typeID==-1)
    {
#ifdef PROFESSIONAL
      //theRoot->theTempBuffer.add(new TempLink(fieldNode.getID(),MasterData::TYPE_LINK,type));
      theRoot->theTempBuffer.add(new Link(fieldNode.getID(),MasterData::TYPE_LINK,type));
#endif
      parent.setTypeID(0) ;
    }
    else
    {
      parent.setTypeID(typeID) ;
    }

    //((containerNode*)parent)->addNode(field);
    if (!look_ETYPE()) {
        lex_index++; // ETYPE

        // TODO
        //field->extratype=_strdup(((*lexemes)[lex_index++].text));
        //hack
        lex_index++ ;
      }
    while (!look_BEGIN_EXPRESSION())
        parseFieldExpression() ;
  }
  if (!look_ETYPE()) {
    lex_index++; // ETYPE
    // TODO
    //field->extratype=_strdup(((*lexemes)[lex_index++].text));
    //hack
    lex_index++;
  }

  while (!look_BEGIN_EXPRESSION())
    parseFieldExpression();
}
#endif


#ifdef LANGUAGE_JAVA
void PopulatePhase::parseInherits(SymbolNode &parent)
{
  //reference* superclass;

  //superclass=new reference();
  lex_index++; // INHERITS
  //superclass->setName((*lexemes)[lex_index++].text);
  //parent->setSuperclass(superclass);
  //theRoot->theTempBuffer.add(new TempLink(parent.getID(),MasterData::SUPER_LINK, lexemes[lex_index++]->str)) ;
#ifdef PROFESSIONAL
  theRoot->theTempBuffer.add(new Link(parent.getID(),MasterData::SUPER_LINK, lexemes[lex_index]->str)) ;
#endif
  lex_index++ ;
}
#endif


#ifdef LANGUAGE_JAVA
void PopulatePhase::parseClassImplements(SymbolNode &parent)
{
  //reference* interface;

  lex_index++; // JIL_IMPLEMENTS
  while (look_END_IMPLEMENTS()) {
    //interface=new reference();
    //interface->setName((*lexemes)[lex_index++].text);
    //parent->addImplements(interface);
    //theRoot->theTempBuffer.add(new TempLink(parent.getID(),MasterData::IMPLEMENTS_LINK, lexemes[lex_index++]->str)) ;
#ifdef PROFESSIONAL
    theRoot->theTempBuffer.add(new Link(parent.getID(),MasterData::IMPLEMENTS_LINK, lexemes[lex_index]->str)) ;
#endif
    lex_index++ ;
  }
  lex_index++; // END_IMPLEMENTS
}
#endif


#ifdef LANGUAGE_JAVA
void PopulatePhase::parseClassBody(SymbolNode &parent)
{
  while (look_END_BODY()) {
    if (!look_LOCAL())
      parseField(parent);
    else if (!look_FIELD())
      parseField(parent);
    else if (!look_METHOD())
      parseMethod(parent);
    else if (!look_JIL_CLASS())
      parseClassDecl(parent);
    else if (!look_JIL_INTERFACE())
      parseInterfaceDecl(parent);
    else
      lex_index++;
  }
}
#endif


#ifdef LANGUAGE_JAVA
void PopulatePhase::parseInterfaceBody(SymbolNode &parent)
{
  while (look_END_BODY()) {
    if (!look_FIELD())
      parseField(parent);
    else
      parseMethodHeader(parent);
  }
}
#endif


#ifdef LANGUAGE_JAVA
void PopulatePhase::parseInterfaceExtends(SymbolNode &parent)
{
  // TODO: look at this
  //reference* interface;
  lex_index++; // JIL_IMPLEMENTS
  while (look_END_EXTENDS())
  {
    //interface=new reference();
    //interface->setName((*lexemes)[lex_index++].text);
    //parent->addExtends(interface);

    //theRoot->theTempBuffer.add(new TempLink(parent.getID(),MasterData::SUPER_LINK, lexemes[lex_index++]->str)) ;
#ifdef PROFESSIONAL
    theRoot->theTempBuffer.add(new Link(parent.getID(),MasterData::SUPER_LINK, lexemes[lex_index]->str)) ;
#endif
    lex_index++ ;
  }
}
#endif


#ifdef LANGUAGE_JAVA
void PopulatePhase::parseInterfaceDecl(SymbolNode &parent)
{
  int SLOC = 0;
  int startline,endline ;

  SymbolNode interfaceNode = theRoot->createSymbolNode(MasterData::INTERFACE_CAT) ;
  startline = lexemes[lex_index]->param ;

  lex_index++;      // Goto start of Interface

  parseProtection_opt(interfaceNode);
  parseGregariousModifiers_opt(interfaceNode);

  interfaceNode.setName(lexemes[lex_index++]->str);

  if (!look_JIL_EXTENDS())
    parseInterfaceExtends(interfaceNode);

  lex_index++;  // END IMPLEMENTS

  if (look_END_BODY())
    parseInterfaceBody(interfaceNode);

  lex_index++;  // END_BODY

  int interfaceLOC = lexemes[lex_index++]->param ;
  endline = startline + interfaceLOC ;

  interfaceNode.setMetric(MasterData::LOC_MET, (float)interfaceLOC) ;

  parent.addNode(interfaceNode);
}
#endif


#ifdef LANGUAGE_JAVA
void PopulatePhase::parseBlockStatement(SymbolNode &parent)
{
  string type ;
  long typeID ;

  if (!look_LOCAL()) {
    lex_index++;

    if (!look_TYPE()) {
      lex_index++; // TYPE
      type = lexemes[lex_index++]->str ;
      typeID = theRoot->getSymbolTypeID(type);
    }
    while (!look_ID()) {
#ifdef PROFESSIONAL
      SymbolNode fieldNode = theRoot->createSymbolNode(MasterData::FIELD_CAT) ;
      fieldNode.setName(lexemes[lex_index]->str) ;
      //fieldNode.setCategoryID(MasterData::FIELD_CAT) ;
      parent.addNode(fieldNode) ;
      if (typeID==-1)
      {
        theRoot->theTempBuffer.add(new Link(fieldNode.getID(),MasterData::TYPE_LINK,type));
        fieldNode.setTypeID(0) ;
      }
      else
      {
        fieldNode.setTypeID(typeID) ;
      }
#endif
      lex_index++ ;
    }
    if (!look_ETYPE()) {
      // TODO:
      lex_index++; // ETYPE
      //field->extratype=((*lexemes)[lex_index++].text);
      //hack
      lex_index++ ;
    }
    return;
  }
  if (!look_CYCLO()) {
    parent.incMetric(MasterData::CYCLO_MET) ;
    lex_index++;
    return;
  }

  if (!look_BEGIN_EXPRESSION())
    parseExpression(parent);

  if (!look_ETYPE())
     lex_index++;

  if (!look_TYPE())
    lex_index++;

  if (!look_ID())
    lex_index++;


  if (!look_JIL_CLASS())
    parseClassDecl(parent);
}
#endif


#ifdef LANGUAGE_JAVA
void PopulatePhase::parseMethodHeader(SymbolNode &parent)
{
  SymbolNode methodNode = theRoot->createSymbolNode(MasterData::METHOD_CAT) ;
  string type ;

  lex_index++;  // METHOD

  parseProtection_opt(methodNode) ;
  parseGregariousModifiers_opt(methodNode) ;

  if (!look_TYPE())
  {
    lex_index++; // TYPE
    //type->setName((*lexemes)[lex_index++].text);
    type = lexemes[lex_index++]->str ;
    //thisMethod->setType(type);
    long typeID = theRoot->getSymbolTypeID(type);
    if (typeID==-1)
    {
      //theRoot->theTempBuffer.add(new TempLink(methodNode.getID(),MasterData::TYPE_LINK,type));
#ifdef PROFESSIONAL
      theRoot->theTempBuffer.add(new Link(methodNode.getID(),MasterData::TYPE_LINK,type));
#endif
      parent.setTypeID(0) ;
    }
    else
    {
      parent.setTypeID(typeID) ;
    }
//    theRoot->theTempBuffer.add(new TempLink(methodNode.getID(),MasterData::TYPE_LINK,type)) ;
  } else {
    //type->setName("");
    type = "" ;
    //thisMethod->setType(type);
    long typeID = theRoot->getSymbolTypeID(type);
    if (typeID==-1)
    {
      //theRoot->theTempBuffer.add(new TempLink(methodNode.getID(),MasterData::TYPE_LINK,type));
#ifdef PROFESSIONAL
      theRoot->theTempBuffer.add(new Link(methodNode.getID(),MasterData::TYPE_LINK,type));
#endif
      parent.setTypeID(0) ;
    }
    else
    {
      parent.setTypeID(typeID) ;
    }
//    theRoot->theTempBuffer.add(new TempLink(methodNode.getID(),MasterData::TYPE_LINK,type)) ;
  }

  parseMethodDeclarator(methodNode);

  parent.addNode(methodNode);

  lex_index++;        // END_BODY
  lex_index+=4;       // don't need the halstead info
}
#endif


#ifdef LANGUAGE_JAVA
void PopulatePhase::parseMethodBody(SymbolNode &parent)
{
  int depth=0;
  int nest=1 ;
  int mark=0 ;
  int last_ret_depth=-1;
  int n=0;

  parent.setMetric(MasterData::ANION_MET,1) ;
  parent.setMetric(MasterData::NION_MET,1) ;
  parent.setMetric(MasterData::NEST_MET,0) ;

  while (look_END_BODY()) {
    n=1;
    parseBlockStatement(parent);
    if (!look_MARK_IF()) {
      lex_index++;
    }
    if (!look_MARK_ENDIF()) {
      lex_index++;
    }
    if (!look_RET()) {
      parent.incMetric(MasterData::NION_MET) ;
      if (depth!=last_ret_depth) {
        last_ret_depth=depth;
        parent.incMetric(MasterData::ANION_MET) ;
      }
      lex_index++ ;
    }
    if (!look_MORE_DEPTH()) {
      depth++ ;

      if (nest<depth)
      {
        nest++ ;
        parent.incMetric(MasterData::NEST_MET) ;
      }

      last_ret_depth=-1 ;
      lex_index++ ;
    }
    if (!look_LESS_DEPTH()) {
      depth-- ;
      last_ret_depth=-1 ;
      if ((depth==0)&&(mark>0)) {
        parent.incMetric(MasterData::EVG_MET, (float)mark) ;
        mark=0 ;
      }
      lex_index++;
    }
    if (!look_MARK_UNSTRUCT()) {
      parent.incMetric(MasterData::BRANCH_MET) ;
      if (depth>0) {
        mark=depth ;
      }
      lex_index++;
    }
  }

  if ((n==0)||(depth!=last_ret_depth))
  {
    parent.incMetric(MasterData::ANION_MET) ;
    parent.incMetric(MasterData::NION_MET) ;
  }
}
#endif


#ifdef LANGUAGE_JAVA
void PopulatePhase::parseParameter(SymbolNode &parent)
{
  //reference* type;
  //fieldNode* field;

  //field=new fieldNode();
  string type ;
#ifdef PROFESSIONAL
  SymbolNode fieldNode = theRoot->createSymbolNode(MasterData::FIELD_CAT) ;
  parseGregariousModifiers_opt(fieldNode) ;
#else
  parseGregariousModifiers_opt() ;
#endif

  if (!look_TYPE()) {
    lex_index++; // TYPE
    //type=new reference();
    //type->setName((*lexemes)[lex_index++].text);
    type = lexemes[lex_index++]->str;
    //field->setType(type);
    long typeID = theRoot->getSymbolTypeID(type);
    if (typeID==-1)
    {
#ifdef PROFESSIONAL
      //theRoot->theTempBuffer.add(new TempLink(fieldNode.getID(),MasterData::TYPE_LINK,type));
      theRoot->theTempBuffer.add(new Link(fieldNode.getID(),MasterData::TYPE_LINK,type));
#endif
      parent.setTypeID(0) ;
    }
    else
    {
      parent.setTypeID(typeID) ;
    }
//    theRoot->theTempBuffer.add(new TempLink(fieldNode.getID(),MasterData::TYPE_LINK,type));
  }

  while (!look_ID()) {
#ifdef PROFESSIONAL
    fieldNode.setName(lexemes[lex_index]->str);
    parent.addNode(fieldNode) ;

    // C01 Begin ----------------------------------
    parent.incMetric(MasterData::NP_MET) ;
    // parent->incNparams();
    // C01 End ------------------------------------
#endif
    lex_index++ ;
  }

  if (!look_ETYPE()) {
    lex_index++; // ETYPE
    // TODO:
    //field->extratype=_strdup(((*lexemes)[lex_index++].text));  // ID
    //hack
    lex_index++ ;
  }
  //field->setParent(parent);
}
#endif


#ifdef LANGUAGE_JAVA
void PopulatePhase::parseMethodDeclarator(SymbolNode &methodNode)
{
  methodNode.setName(lexemes[lex_index++]->str);
  while (look_END_PARAMS())
    parseParameter(methodNode);

  lex_index++;  // END_PARAMS
}
#endif


#ifdef LANGUAGE_JAVA
void PopulatePhase::parseMethod(SymbolNode &parent)
{
  //methodNode* thisMethod;
  //reference* type;

  string type ;
  int startline,endline ;

  int SLOC = 0;

  //type=new reference();
  //thisMethod=new methodNode();
  //thisMethod->setParent(parent);

  SymbolNode methodNode = theRoot->createSymbolNode(MasterData::METHOD_CAT) ;
//  methodNode.setCategoryID(MasterData::METHOD_CAT) ;

  startline = lexemes[lex_index]->param ;
  lex_index++;    // METHOD

  parseProtection_opt(methodNode);
  parseGregariousModifiers_opt(methodNode);

  if (!look_TYPE()) {
    lex_index++; // TYPE
    //type->setName((*lexemes)[lex_index++].text);
    type = lexemes[lex_index++]->str;
    //thisMethod->setType(type);
    long typeID = theRoot->getSymbolTypeID(type);
    if (typeID==-1)
    {
      //theRoot->theTempBuffer.add(new TempLink(methodNode.getID(),MasterData::TYPE_LINK,type));
#ifdef PROFESSIONAL
      theRoot->theTempBuffer.add(new Link(methodNode.getID(),MasterData::TYPE_LINK,type));
#endif
      parent.setTypeID(0) ;
    }
    else
    {
      parent.setTypeID(typeID) ;
    }
//    theRoot->theTempBuffer.add(new TempLink(methodNode.getID(),MasterData::TYPE_LINK,type));

  //DEBUG      printf("found type: %s\n",(*lexemes)[lex_index-1].text);
  } else {
    //type->setName("");
    type = "" ;
    //thisMethod->setType(type);
    long typeID = theRoot->getSymbolTypeID(type);
    if (typeID==-1)
    {
      //theRoot->theTempBuffer.add(new TempLink(methodNode.getID(),MasterData::TYPE_LINK,type));
#ifdef PROFESSIONAL
      theRoot->theTempBuffer.add(new Link(methodNode.getID(),MasterData::TYPE_LINK,type));
#endif
      parent.setTypeID(0) ;
    }
    else
    {
      parent.setTypeID(typeID) ;
    }
//    theRoot->theTempBuffer.add(new TempLink(methodNode.getID(),MasterData::TYPE_LINK,type));
  }

  parseMethodDeclarator(methodNode);

  // 17.11.1998 if (look_END_BODY())
    parseMethodBody(methodNode);

  lex_index++; // END_BODY

  // TODO: check the state of LOC
  //methodNode->setLOC((int)((*lexemes)[lex_index++].text));

  int methodLOC = lexemes[lex_index++]->param ;
  endline = startline + methodLOC ;

  methodNode.setMetric(MasterData::LOC_MET, (float)methodLOC) ;

  for (unsigned int sloc_iter = 0 ; sloc_iter < sloc_v.size() ; sloc_iter++ ) {
    if ( ( sloc_v[sloc_iter] + 1 ) >= startline && ( sloc_v[sloc_iter] + 1 ) <= endline ) {
      SLOC++ ;
    }
  }
  methodNode.setMetric(MasterData::SLOC_MET, (float)SLOC) ;

  methodNode.setMetric(MasterData::NSC_MET,(float)lexemes[lex_index++]->param) ;
  methodNode.setMetric(MasterData::N1_MET,(float)lexemes[lex_index++]->param) ;
  methodNode.setMetric(MasterData::N2_MET,(float)lexemes[lex_index++]->param) ;
  methodNode.setMetric(MasterData::n1_MET,(float)lexemes[lex_index++]->param) ;
  methodNode.setMetric(MasterData::n2_MET,(float)lexemes[lex_index++]->param) ;
  methodNode.setMetric(MasterData::CONTROL_MET,(float)lexemes[lex_index++]->param) ;
  methodNode.setMetric(MasterData::EXECUTABLE_MET,(float)lexemes[lex_index++]->param) ;

  parent.addNode(methodNode);
}
#endif


#ifdef LANGUAGE_JAVA
SymbolNode PopulatePhase::getPackage(string packageName)
{
  vector<long> children = theRoot->getChildren() ;
  unsigned int i;
  SymbolNode tmp = (*theRoot) ;

  for (i=0 ; i<children.size() ; i++)
  {
    if (theRoot->findSymbolNode(children[i], tmp))
    {
      if (!packageName.compare(tmp.getName()))
      {
        return tmp ;
      }
    }
  }

  SymbolNode packNode = theRoot->createSymbolNode(MasterData::PACKAGE_CAT) ;
  packNode.setName(packageName) ;
  theProjNode.addNode(packNode) ;

  return packNode ;
}
#endif


#ifdef LANGUAGE_JAVA
void PopulatePhase::parseImportList(SymbolNode &file)
{
//  reference *import;

  while (look_END_UNIT_HEADER())
  {
    lex_index++ ;             // Got an import
    //import=new reference();
    //import->setName((*lexemes)[lex_index++].text);

    //theRoot->theTempBuffer.add(new TempLink(file.getID(), MasterData::IMPORT_LINK, lexemes[lex_index++]->str)) ;
#ifdef PROFESSIONAL
    theRoot->theTempBuffer.add(new Link(file.getID(), MasterData::IMPORT_LINK, lexemes[lex_index]->str)) ;
#endif
    lex_index++ ;
    //file->addImport(import);
  }
}
#endif


#ifdef LANGUAGE_JAVA
void PopulatePhase::parseTypeDecl(SymbolNode &parent)
{
  if (!look_JIL_CLASS())
    parseClassDecl(parent);
  else
    parseInterfaceDecl(parent);
}
#endif


//---------------------------------------------------------
//
// The following methods are used in the C++ PopulatePhase
//
//---------------------------------------------------------


#ifdef LANGUAGE_CPP
int PopulatePhase::parseClassMember(SymbolNode &parent,int *pro)
{
  int save;

  save=lex_index;
  if (!look_PROTECTION_LEVEL()) {
    switch(lexemes[lex_index]->param) {
    case 0:  *pro=MasterData::PUBLIC_PROT ;
           break;
    case 1:  *pro=MasterData::PROTECTED_PROT ;
           break;
    case 2:  *pro=MasterData::PRIVATE_PROT ;
         break;
    };
    lex_index++;
  };

  if (!look_ACCESS_PRIVATE()) {
    *pro=MasterData::PRIVATE_PROT ;
    lex_index++;
  };

  if (!look_ACCESS_PROTECTED()) {
    *pro=MasterData::PROTECTED_PROT ;
    lex_index++;
  }

  // A01 Begin ---------------------------------------
  // This detects and ignores struct definitions
  // within a class body
  if (!look_BEGIN_STRUCT())
  {
    lex_index++ ;
    while(look_END_CD())
    {
      lex_index++ ;
    }

    lex_index++ ;
    return FOUND  ;
  }
  // A01 End -----------------------------------------

  if (!look_BEGIN_SIMPLE_DECL())
    parseSimpleDecl(parent,*pro);

  if (!look_BEGIN_FDEF())
    parseFunction(parent,*pro);

  if (!look_BEGIN_CD())
    parseClassDecl(parent,*pro);

  if (save==lex_index) return NOT_FOUND;
  return FOUND;

}
#endif

#ifdef LANGUAGE_CPP
void PopulatePhase::parse_func_decl_spec(SymbolNode &parent)
{
  string type ;
  string realtype ;
  bool foundtype = false ;

  string str ;

  int save;

  while (look_BEGIN_DECLARATOR()) {

    save=lex_index;

    // deal with typedefs in function decl_specs which
    // should never really be here

    if (!look_TYPE_SYNONYM())
    {
      lex_index++;
    }

    // assign return type to function
    if (!look_SYM_TYPE_ID())
    {
      foundtype = true ;
      if (type.size()!=0)
      {
#ifdef PROFESSIONAL
        // concatenate type reference

        //debugging,
        //next two lines changed to switch
        //if ( (lexemes[lex_index]->str[0]!='*')&&(lexemes[lex_index]->str[0]!='['))
        //  type = lexemes[lex_index]->str ;
        switch (lexemes[lex_index]->str[0]) {
          case '*': case '[': case '&': break;
        }

        realtype = type + " " + lexemes[lex_index]->str ;
#endif
        lex_index++;
          } else {
            // not got a type yet, set it up
            type = lexemes[lex_index]->str;
        realtype = lexemes[lex_index]->str;

        lex_index++;
        }

      //theRoot->theBuffer.add(new TempLink(parent.getID(),MasterData::TYPE_LINK,realtype));
    }

    // deal with sickos who define classes and use them
    // as function return types
    if (!look_BEGIN_CD())
    {
      // this class is not `in' the method, so parse it
      // in the parent scope.
      SymbolNode par = parent.getParent() ;
      parseClassDecl(par,MasterData::PRIVATE_PROT);
    }

#ifdef PROFESSIONAL
    if (foundtype)
    {
      long typeID = theRoot->getSymbolTypeID(type);
      if (typeID==-1)
      {
        //theRoot->theTempBuffer.add(new TempLink(parent.getID(),MasterData::TYPE_LINK,type));
        theRoot->theTempBuffer.add(new Link(parent.getID(),MasterData::TYPE_LINK,type));
        parent.setTypeID(0) ;
      }
      else
      {
        parent.setTypeID(typeID) ;
      }
    }
    else
    {
      parent.setTypeID(-1) ;
    }
#endif

    if (lex_index==save)
      return;
  }

  return;

}
#endif


//This Method is only needed for C++
#ifdef LANGUAGE_CPP
int PopulatePhase::parseFunctionParameter(SymbolNode &func)
{
  int save=lex_index;
  string realtype ;
  string type ;
  bool foundtype = false ;
  int ok=0;

  if (look_BEGIN_DECLARATOR())
    return NOT_FOUND;

  //SymbolNode fieldNode(MasterData::FIELD_CAT) ;
#ifdef PROFESSIONAL
  SymbolNode fieldNode = theRoot->createSymbolNode(MasterData::FIELD_CAT) ;
#endif

  lex_index++; // BEGIN_DECLARATOR

  if (!look_SYM_TYPE_ID())
  {
    //TODO: find difference between realtype & type
    foundtype = true ;
#ifdef PROFESSIONAL
    realtype = lexemes[lex_index]->str ;
#endif
    type = lexemes[lex_index++]->str ;
    //theRoot->theBuffer.add(new TempLink(fieldNode.getID(),MasterData::TYPE_LINK,realtype));
    ok=1;
  }

  while (!look_SYM_TYPE_ID())
  {
    ok=1;
    foundtype = true ;

    if (type.size()!=0)
    {
#ifdef PROFESSIONAL
      // concatenate type reference
      //debugging,
      //next two lines changed to switch
      //if ( (lexemes[lex_index]->str[0]!='*')&&(lexemes[lex_index]->str[0]!='['))
      //  type = lexemes[lex_index]->str ;
      switch (lexemes[lex_index]->str[0]) {
        case '*': case '[': case '&': break;
      }

      realtype = type + " " + lexemes[lex_index]->str ;
#endif
      lex_index++;
      } else {
          // not got a type yet, set it up
#ifdef PROFESSIONAL
      realtype = lexemes[lex_index]->str;
#endif
          type = lexemes[lex_index]->str;
          lex_index++;
      }
  }

  if (!look_BEGIN_DECLARATOR())
  {
    lex_index++; // BEGIN_DECLARATOR
  }

  while (!look_SYM_TYPE_ID())
  {
    ok=1;
    foundtype = true ;
    if (type.size()!=0)
    {
#ifdef PROFESSIONAL
      // concatenate type reference
        //debugging
        //next two lines changed to switch
        //if ( (lexemes[lex_index]->str[0]!='*')&&(lexemes[lex_index]->str[0]!='['))
        //  type = lexemes[lex_index]->str ;
        switch (lexemes[lex_index]->str[0]) {
          case '*': case '[': case '&': break;
        }

      realtype = type + " " + lexemes[lex_index]->str ;
#endif
      lex_index++;
      }
    else
    {
          // not got a type yet, set it up
          type = lexemes[lex_index]->str;
#ifdef PROFESSIONAL
      realtype = lexemes[lex_index]->str;
#endif
          lex_index++ ;
      }
  }

  if (!look_ID())
  {
    ok=1;
#ifdef PROFESSIONAL
    //debugging
    //if (!lexemes[lex_index]->str.compare("it")) {
      //MasterData::theLog << "ID: " << fieldNode.getID() << endl ;
      //MasterData::theLog << "found the node, mark1" << endl ;
    //}

    fieldNode.setName(lexemes[lex_index]->str);
#endif
    lex_index++ ;
  }

  while (!look_SYM_TYPE_ID())
  {
    ok=1;
    foundtype = true ;
    if (type.size()!=0)
    {
#ifdef PROFESSIONAL
      // concatenate type reference
      //debugging,
      //next two lines changed to switch
      //if ( (lexemes[lex_index]->str[0]!='*')&&(lexemes[lex_index]->str[0]!='['))
      //  type = lexemes[lex_index]->str ;
      switch (lexemes[lex_index]->str[0]) {
        case '*': case '[': case '&': break;
      }

      realtype = type + " " + lexemes[lex_index]->str ;
#endif
      lex_index++ ;
      }
    else
    {
          // not got a type yet, set it up
          type = lexemes[lex_index]->str;
#ifdef PROFESSIONAL
      realtype = lexemes[lex_index]->str;
#endif
          lex_index++;
      }
  }

  if (!look_ID())
  {

    ok=1;
#ifdef PROFESSIONAL
    //debugging
    //if (!lexemes[lex_index]->str.compare("it"))
    //  MasterData::theLog << "found the node, mark2" << endl ;

    fieldNode.setName(lexemes[lex_index]->str); //ID
#endif
    lex_index++ ;
  }

  while (!look_SYM_TYPE_ID())
  {
    ok=1;
    foundtype = true ;
    if (type.size()!=0)
    {
#ifdef PROFESSIONAL
      // concatenate type reference
      //debugging
      //next two lines changed to switch
      //if ( (lexemes[lex_index]->str[0]!='*')&&(lexemes[lex_index]->str[0]!='['))
      //  type = lexemes[lex_index]->str ;
      switch (lexemes[lex_index]->str[0]) {
        case '*': case '[': case '&': break;
      }

      realtype = type + " " + lexemes[lex_index]->str ;
#endif
      lex_index++;
      }
    else
    {
          // not got a type yet, set it up
          type = lexemes[lex_index]->str;
#ifdef PROFESSIONAL
      realtype = lexemes[lex_index]->str;
#endif
          lex_index++;
      }
  }


  if (!look_END_DECLARATOR())
    lex_index++; // END_DECLARATOR

//  if (!look_END_DECLARATOR())
//    lex_index++; // END_DECLARATOR

  if (ok==1)
  {
#ifdef PROFESSIONAL
    func.addNode(fieldNode);

    //MasterData::theLog << fieldNode.getName() << " is a parameter of " << func.getName() << endl ;

// This will be added again once the parameter info has been verified

//    if (realtype.size()>0)
//      func.setName(func.getName()+realtype+",") ;
//    if ( (type.size()>0) && (realtype.compare("void")) )
//      func.addLink(fieldNode.getID(),MasterData::PARAMETER_LINK) ;


#endif

    // A02 Start -----------------------------
    if ( (type.size()>0) && (realtype.compare("void")) )
      func.incMetric(MasterData::NP_MET) ;
    // A02 End -------------------------------

#ifdef PROFESSIONAL
    if (foundtype)
    {
      long typeID = theRoot->getSymbolTypeID(type);
      if (typeID==-1)
      {
        //theRoot->theTempBuffer.add(new TempLink(fieldNode.getID(),MasterData::TYPE_LINK,type));
        theRoot->theTempBuffer.add(new Link(fieldNode.getID(),MasterData::TYPE_LINK,type));
        fieldNode.setTypeID(0) ;
      }
      else
      {
        fieldNode.setTypeID(typeID) ;
      }
    }
    else
    {
      fieldNode.setTypeID(-1) ;
    }
#endif
    return FOUND;
  }
  else
  {
    lex_index=save;
    return NOT_FOUND ;
  }
}
#endif

//This Method is only needed for C++
#ifdef LANGUAGE_CPP
int PopulatePhase::parseAbstractFunctionParameter(SymbolNode &func)
{
  int ok=0;
  string type ;
#ifdef PROFESSIONAL
  string realtype ;
#endif
  bool foundtype = false ;

  int save=lex_index;
  int ntypes=0,nids=0;

  if (look_BEGIN_DECLARATOR()){
    return NOT_FOUND ;
  }

  //SymbolNode fieldNode(MasterData::FIELD_CAT) ;
#ifdef PROFESSIONAL
  SymbolNode fieldNode= theRoot->createSymbolNode(MasterData::FIELD_CAT) ;
#endif

  lex_index++; // BEGIN_DECLARATOR

  if (!look_SYM_TYPE_ID()) {
    foundtype = true ;
#ifdef PROFESSIONAL
    realtype = lexemes[lex_index]->str ;
#endif
    type = lexemes[lex_index++]->str ;

    ok=1;
    ntypes++;
  }


   if (!look_BEGIN_DECLARATOR())
    lex_index++;


  while (!look_SYM_TYPE_ID())
  {
    ntypes++;
    ok=1;
    foundtype = true ;
    if (type.size()!=0)
    {
#ifdef PROFESSIONAL
      // concatenate type reference
      //debugging
      //next two lines changed to switch
      //if ( (lexemes[lex_index]->str[0]!='*')&&(lexemes[lex_index]->str[0]!='['))
      //  type = lexemes[lex_index]->str ;
      switch (lexemes[lex_index]->str[0]) {
        case '*': case '[': case '&': break;
      }


      realtype = type + " " + lexemes[lex_index]->str ;
#endif
      lex_index++;
      }
    else
    {
          // not got a type yet, set it up
          type = lexemes[lex_index]->str;
#ifdef PROFESSIONAL
      realtype = lexemes[lex_index]->str;
#endif
          lex_index++;
      }
  }

  if (!look_BEGIN_DECLARATOR())
    lex_index++;

  if (!look_ID())
  {
#ifdef PROFESSIONAL
    //debugging
    //if (!lexemes[lex_index]->str.compare("it"))
    //  MasterData::theLog << "found the node, mark3" << endl ;

    fieldNode.setName(lexemes[lex_index]->str);
#endif
    lex_index++;
    nids++;
    ok=1;
  }

  if (!look_BEGIN_DECLARATOR())
    lex_index++;

  while (!look_SYM_TYPE_ID())
  {
    foundtype = true ;
    ntypes++;
    ok=1;
    if (type.size()!=0)
    {
#ifdef PROFESSIONAL
      // concatenate type reference
      //debugging
      //next two lines changed to switch
      //if ( (lexemes[lex_index]->str[0]!='*')&&(lexemes[lex_index]->str[0]!='['))
      //  type = lexemes[lex_index]->str ;
      switch (lexemes[lex_index]->str[0]) {
        case '*': case '[': case '&': break;
      }

      realtype = type + " " + lexemes[lex_index]->str ;
#endif
      lex_index++;
      }
    else
    {
          // not got a type yet, set it up
          type = lexemes[lex_index]->str;
#ifdef PROFESSIONAL
      realtype = lexemes[lex_index]->str;
#endif
          lex_index++;
      }
  }

  if (!look_ID())
  {
    nids++;
#ifdef PROFESIONAL
    //debugging
    if (!lexemes[lex_index]->str.compare("it"))
      MasterData::theLog << "found the node, mark4" << endl ;

    fieldNode.setName(lexemes[lex_index]->str); //ID
#endif
    lex_index++ ;
    ok=1;
  }
#ifdef PROFESSIONAL
  else
  {
    if (nids==0)
      fieldNode.setName(_strdup("ABSTRACT"));
  }
#endif

  while (!look_SYM_TYPE_ID())
  {
    foundtype = true ;
    ok=1;
    ntypes++;
    if (type.size()!=0)
    {
#ifdef PROFESSIONAL
      // concatenate type reference
      //debugging
      //next two lines changed to switch
      //if ( (lexemes[lex_index]->str[0]!='*')&&(lexemes[lex_index]->str[0]!='['))
      //  type = lexemes[lex_index]->str ;
      switch (lexemes[lex_index]->str[0]) {
        case '*': case '[': case '&': break;
      }

      realtype = type + " " + lexemes[lex_index]->str ;
#endif
      lex_index++;
      }
    else
    {
          // not got a type yet, set it up
          type = lexemes[lex_index]->str;
#ifdef PROFESSIONAL
      realtype = lexemes[lex_index]->str;
#endif
          lex_index++;
      }
  }

  if (!look_END_DECLARATOR())
  {
    lex_index++;
  }

  if (!look_END_DECLARATOR())
  {
    lex_index++; // END_DECLARATOR
  }

  if (ok==1)
  {
    //Note: do I need to do this?
//    if ((realtype!=NULL)&&(!strcmp("void",realtype)))
//    ;
//    else
//    //Metric: ((methodNode*)func)->incNparams();
  }

//    if (realtype==NULL)
//    obj->fulltype=_strdup("");
//    else
//    obj->fulltype=realtype;


//  if (ok==1) {
//    // if we have a name but no type, type=name
//    if (       ((strlen(obj->fulltype)==0)) &&  (   (strlen(obj->name)>0)  ||  (!strcmp("ABSTRACT",obj->name) ))) {
//    obj->fulltype=obj->name;
//    }
//  }

  if (ok==1) {
#ifdef PROFESSIONAL
    if (foundtype)
    {
      long typeID = theRoot->getSymbolTypeID(type);
      if (typeID==-1)
      {
        //theRoot->theTempBuffer.add(new TempLink(fieldNode.getID(),MasterData::TYPE_LINK,type));
        theRoot->theTempBuffer.add(new Link(fieldNode.getID(),MasterData::TYPE_LINK,type));
        fieldNode.setTypeID(0) ;
      }
      else
      {
        fieldNode.setTypeID(typeID) ;
      }
    }
    else
    {
      fieldNode.setTypeID(-1) ;
    }


    func.addNode(fieldNode);

    // A03 Begin -----------------------------
    func.incMetric(MasterData::NP_MET) ;
    // A03 End -------------------------------

#endif

    // lex_index++; // END_DECLARATOR
    return FOUND;
  }
  else
  {
    //debugging
    //changed the following line from FOUND to NOT_FOUND
    return NOT_FOUND; // kludge...
  }

  return NOT_FOUND;
}
#endif

//This Method is only needed for C++
#ifdef LANGUAGE_CPP
int PopulatePhase::parseMethodExpression(SymbolNode &func,int mode)
{
  int currmode=0;
  string reftext;
  int sz=2;
  int max=100;

  if (look_BEGIN_EXPRESSION()&&look_BEGIN_WRITE()) {
    return NOT_FOUND;
  }

  lex_index++; // BEGIN_EXPRESSION/BEGIN_WRITE
  while (look_END_EXPRESSION()&&look_END_WRITE()) {
    if (!look_LOWCOMPLEX()) {
      lex_index++;
      func.incMetric(MasterData::OC_MET,0.5) ;
    } else if (!look_MIDCOMPLEX()) {
      lex_index++;
      func.incMetric(MasterData::OC_MET,1.0) ;
    } else if (!look_HIGHCOMPLEX()) {
      lex_index++;
      func.incMetric(MasterData::OC_MET,1.5) ;
    } else if (!look_BEGIN_WRITE()) {
      parseMethodExpression(func,1);
    } else if (!look_BEGIN_EXPRESSION()) {
      parseMethodExpression(func,currmode);
    } else if (!look_REF()) {
#ifdef PROFESSIONAL
      if (reftext.size()>0)
      {
        reftext += '.' ;
      }
      reftext += lexemes[lex_index++]->str ;
#else
      lex_index++ ;
#endif
    }
    else if (!look_FREF())
    {
#ifdef PROFESSIONAL
      if (reftext.size()>0)
      {
        reftext += '.' ;
      }
      reftext += lexemes[lex_index++]->str ;
#else
      lex_index++ ;
#endif
    }
    else if (!look_SEP())
    {
#ifdef PROFESSIONAL
      if (reftext.size()>0)
      {
        //theRoot->theTempBuffer.add(new TempLink(func.getID(),MasterData::XREF_LINK, reftext)) ;
        theRoot->theTempBuffer.add(new Link(func.getID(),MasterData::XREF_LINK, reftext)) ;
      }
      reftext = "" ;
#endif
      lex_index++; // SEP
    }
    else if (!look_SYM_TYPE_ID())
    {
       // BETTER LOG A TYPE REF HERE!
       lex_index++; //not for the moment though
    } else
    {
      return NOT_FOUND;
    }
  }

  if (look_END_EXPRESSION()&&look_END_WRITE()) {
    return NOT_FOUND;
  }

  lex_index++; // END_EXPRESSION


#ifdef PROFESSIONAL
  if (reftext.size()>0)
  {
    //theRoot->theTempBuffer.add(new TempLink(func.getID(), MasterData::XREF_LINK, reftext));
    theRoot->theTempBuffer.add(new Link(func.getID(), MasterData::XREF_LINK, reftext));
  }
#endif

  return FOUND;
}
#endif


#ifdef LANGUAGE_CPP
int PopulatePhase::parseFunction(SymbolNode &parent,int pro)
{
  int startline,endline,save,ttl,savec ;
  unsigned int slocIter ;
  bool removeTrailingComma = false ;

  int nest=1 ;
  int mark=0 ;
  int depth=0 ;

  long typeID = -1;
  bool foundtype = false ;

  int SLOC = 0;

  string type ;
#ifdef PROFESSIONAL
  string realtype ;
#endif

  int last_ret_depth;

  if (look_BEGIN_FDEF())
    return NOT_FOUND;

  SymbolNode methodNode = theRoot->createSymbolNode(MasterData::METHOD_CAT);


  if (methodNode.getID()==129) {
    MasterData::theLog << "starting..." << endl ;
  }

  startline=lexemes[lex_index]->line;

  //METRIC: obj->linenr=startline+1;

  lex_index++;  // BEGIN_FDEF
  parse_func_decl_spec(methodNode);

  //TODO: handle typeref.
  // typeref=obj->getType();

  if (methodNode.getID()==129) {
    MasterData::theLog << "mark1" << endl ;
  }

  //if (obj->fulltype==NULL)
  //  realtype=_strdup("");
  //else
  //  realtype=obj->fulltype;

  if (look_BEGIN_DECLARATOR())
    goto fn_bailout;

  while (!look_BEGIN_DECLARATOR())
  {
    lex_index++;  // BEGIN_DECLARATOR
    while (!look_SYM_TYPE_ID())
    {
      foundtype = true ;
      if (type.size()!=0)
      {
#ifdef PROFESSIONAL
        // concatenate type reference
        //debugging
        //next two lines changed to switch
        //if ( (lexemes[lex_index]->str[0]!='*')&&(lexemes[lex_index]->str[0]!='['))
        //  type = lexemes[lex_index]->str ;
        switch (lexemes[lex_index]->str[0]) {
          case '*': case '[': case '&': break;
        }

        realtype = type + " " + lexemes[lex_index]->str ;
#endif
        lex_index++;
      }
      else
      {
            // not got a type yet, set it up
            type = lexemes[lex_index]->str;
#ifdef PROFESSIONAL
        realtype = lexemes[lex_index]->str;
#endif
            lex_index++;
        }
    }

  if (methodNode.getID()==129) {
    MasterData::theLog << "mark2" << endl ;
  }
    if (look_ID())
    {
      return NOT_FOUND;
    }

// This will be added again once the parameter info has been verified
//    methodNode.setName(lexemes[lex_index++]->str + "(");  // ID
    methodNode.setName(lexemes[lex_index++]->str);  // ID
    methodNode.setProtectionID(pro);

    //TODO: handle typeref.
    // obj->fulltype=realtype;
    //Changed: methodNode.setTypeID(theRoot->getSymbolTypeID(realtype)) ;
    //theRoot->theBuffer.add(new TempLink(methodNode.getID(),MasterData::TYPE_LINK,realtype));

    // deal with function parameters
    //printf("in the beggining, contents for %s(%d)\n",obj->name,obj);


  if (methodNode.getID()==129) {
    MasterData::theLog << "mark3" << endl ;
  }
      if (look_DECL_PARAM_PART_BEGIN())
    {
      // printf("BAIL0\n");
      goto fn_windup;
    }

    lex_index++;  // DECL_PARAM_PART_BEGIN

    ttl=0;
    save=lex_index;


  if (methodNode.getID()==129) {
    MasterData::theLog << "mark4" << endl ;
  }

    while ((look_DECL_PARAM_PART_END())&&(ttl<50))
    {
      if (parseFunctionParameter(methodNode))
      {
        //printf("--------MOVE ON!\n");
            ttl++;
        lex_index++;
      } else {
        removeTrailingComma = true ;
      }
    }
      if (ttl==50)
    {
      goto fn_windup;
    }

  if (methodNode.getID()==129) {
    MasterData::theLog << "mark5" << endl ;
  }
    lex_index++;  // DECL_PARAM_PART_END

    while (!look_DECL_PARAM_PART_BEGIN())
    {
          lex_index++;
          while (look_DECL_PARAM_PART_END())
      {
        if (parseFunctionParameter(methodNode))
        {
          goto fn_windup;
        } else {
          removeTrailingComma = true ;
        }
      }

      lex_index++;
    }

  if (methodNode.getID()==129) {
    MasterData::theLog << "mark6" << endl ;
  }
    if (look_END_DECLARATOR())
    {
      // printf("BAIL 3\n");
      goto fn_bailout;
    }

  if (methodNode.getID()==129) {
    MasterData::theLog << "mark7" << endl ;
  }
    lex_index++;  // END_DECLARATOR

// This will be added again once the parameter info has been verified

//    if (removeTrailingComma) {
//      string name = methodNode.getName() ;
//      name = name.substr(0,name.length()-1) ;
//      methodNode.setName( name + ")");  // ID
//    } else
//      methodNode.setName(methodNode.getName() + ")");  // ID

    }

  ttl=0;
  if (methodNode.getID()==129) {
    MasterData::theLog << "mark8" << endl ;
  }

  while ((look_BEGIN_FBODY())&&(ttl<1000))
  {
    ttl++;
    lex_index++; // skip any constructory colon stuff
  }

  if (methodNode.getID()==129) {
    MasterData::theLog << "mark9" << endl ;
  }

  // don't forget the function body!
    if (look_BEGIN_FBODY())
    goto fn_bailout;

  if (methodNode.getID()==129) {
    MasterData::theLog << "mark10" << endl ;
  }
  lex_index++; // BEGIN_FBODY

  ttl=0;
  save=lex_index;

  methodNode.setMetric(MasterData::CYCLO_MET,1) ;
  methodNode.setMetric(MasterData::ANION_MET,1) ;
  methodNode.setMetric(MasterData::NION_MET,1) ;
  methodNode.setMetric(MasterData::NEST_MET,0) ;

  last_ret_depth=-1; // depth of last return statement

  if (methodNode.getID()==129) {
    MasterData::theLog << "mark11" << endl ;
  }
  while ((look_END_FBODY())&&(ttl<10000))
  {
    savec=lex_index;
    if (!look_CYCLO())
    {
      methodNode.incMetric(MasterData::CYCLO_MET) ;
      lex_index++;
    }
    else if (!look_RET())
    {
      methodNode.incMetric(MasterData::NION_MET) ;
      if (depth!=last_ret_depth)
      {
        last_ret_depth=depth;
        methodNode.incMetric(MasterData::ANION_MET) ;
      }
      lex_index++;
    } else if (!look_MORE_DEPTH())
    {
      depth++;
      if (nest<depth)
      {
        nest++ ;
        methodNode.incMetric(MasterData::NEST_MET) ;
      }
      last_ret_depth=-1;
      lex_index++;
    }
    else if (!look_LESS_DEPTH())
    {
      depth--;
      last_ret_depth=-1;
      if ((depth==0) && (mark>0))
      {
        methodNode.incMetric(MasterData::EVG_MET,mark) ;
        mark=0;
      }
      lex_index++;
    } else if (!look_MARK_UNSTRUCT())
    {
      methodNode.incMetric(MasterData::BRANCH_MET) ;
      if (depth>1)
        mark=depth;
      lex_index++;
    }
    else if (!look_MARK_IF())
    {
      lex_index++;
    }
    else if (!look_MARK_ENDIF())
    {
      //METRIC: if (NEST>(obj->NEST))
      //METRIC:   obj->NEST=NEST;

      // Removed CAM 13/04/01
      //NEST--;
      lex_index++;
    }
    else if (!look_BEGIN_FDEF())
    {
      if (parseFunction(methodNode,pro))
        lex_index++;
    }
    else if (!look_BEGIN_SIMPLE_DECL())
    {
      if (parseSimpleDecl(methodNode,pro))
        lex_index++;
    }
    else if (!look_BEGIN_CD())
    {
      if (parseClassDecl(methodNode,pro))
        lex_index++;
    } else if (!look_BEGIN_EXPRESSION())
    {
      if (parseMethodExpression(methodNode,0))
        lex_index++;
    }
    else if (!look_LABEL())
    {
      //TODO: METRIC: obj->nlabels++;
      lex_index++;
    }
    if (savec==lex_index)
    {
      //printf("SKIP FORWARD (%d)\n",lexemes[lex_index]->com);
      ttl++;
      lex_index++;
    }
  }
  if (methodNode.getID()==129) {
    MasterData::theLog << "mark12" << endl ;
  }

  if (depth!=last_ret_depth)
  {
    methodNode.incMetric(MasterData::ANION_MET) ;
    methodNode.incMetric(MasterData::NION_MET) ;
  }

  if (methodNode.getID()==129) {
    MasterData::theLog << "mark13" << endl ;
  }
  if (ttl==1000)
  {
    lex_index=save;
    goto fn_windup;
  }
  if (methodNode.getID()==129) {
    MasterData::theLog << "mark129" << endl ;
  }

  if (look_END_FBODY())
    goto fn_windup;

  lex_index++; // END_FBODY

  if (methodNode.getID()==129) {
    MasterData::theLog << "mark15" << endl ;
  }
  if (look_END_FDEF())
    goto fn_windup;

  lex_index++;  // END_FDEF

  if (methodNode.getID()==129) {
    MasterData::theLog << "mark16" << endl ;
  }
  //TODO: make nicer
  endline=atoi(lexemes[lex_index-1]->str.c_str());

  if (methodNode.getID()==129) {
    MasterData::theLog << "about to set N1_MET" << endl ;
    MasterData::theLog << "methodode: " << methodNode.getName() << endl ;
  }
  methodNode.setMetric(MasterData::N1_MET,lexemes[lex_index-1]->param) ;
  methodNode.setMetric(MasterData::N2_MET,lexemes[lex_index-1]->line) ;
  methodNode.setMetric(MasterData::n1_MET,lexemes[lex_index-1]->startcol) ;
  methodNode.setMetric(MasterData::n2_MET,lexemes[lex_index-1]->endcol) ;

  // got one END_FDEF (with the Halstead info), now get the other one;

  methodNode.setMetric(MasterData::EXECUTABLE_MET,lexemes[lex_index]->line) ;
  methodNode.setMetric(MasterData::CONTROL_MET,lexemes[lex_index]->param) ;
  methodNode.setMetric(MasterData::NSC_MET,lexemes[lex_index]->startcol) ;

  lex_index++;// second END_FDEF

  methodNode.setMetric(MasterData::LOC_MET,endline-startline+1);

  //Check: Took this out due to extra types.
  //theRoot->theBuffer.add(new TempLink(methodNode.getID(),MasterData::TYPE_LINK,realtype));

  parent.addNode(methodNode);

  for ( slocIter = 0 ; slocIter < sloc_v.size() ; slocIter++ )
  {
    if ( ( sloc_v[slocIter] <= endline ) && ( sloc_v[slocIter] >= startline ) )
    {
      SLOC++ ;
    }
  }

  methodNode.setMetric(MasterData::SLOC_MET ,   SLOC ) ;

  return FOUND;

fn_windup:

  if (methodNode.getID()==129) {
    MasterData::theLog << "fn_windup" << endl ;
  }

  ttl=0;
  save=lex_index;
  while ((look_END_FDEF())&&(ttl<1000))
  {
    lex_index++;ttl++;
  }

  if (ttl==1000)
  {
    lex_index=save;
    if (methodNode.getID()==563) {
      MasterData::theLog << "return " << endl ;
    }
    return NOT_FOUND ;
  }

  lex_index++;

  if (methodNode.getID()==563) {
    MasterData::theLog << "about to set N1_MET" << endl ;
    MasterData::theLog << "methodode: " << methodNode.getName() << endl ;
  }
  methodNode.setMetric(MasterData::N1_MET , lexemes[lex_index-1]->param ) ;
  methodNode.setMetric(MasterData::N2_MET , lexemes[lex_index-1]->line ) ;
  methodNode.setMetric(MasterData::n1_MET , lexemes[lex_index-1]->startcol ) ;
  methodNode.setMetric(MasterData::n2_MET , lexemes[lex_index-1]->endcol ) ;

  // got one END_FDEF (with the Halstead info), now get the other one;

  methodNode.setMetric(MasterData::EXECUTABLE_MET , lexemes[lex_index]->line ) ;
  methodNode.setMetric(MasterData::CONTROL_MET ,  lexemes[lex_index]->param ) ;

  lex_index++;// second END_FDEF

  methodNode.setMetric(MasterData::SLOC_MET , -1 ) ;

#ifdef PROFESSIONAL
  if (foundtype)
  {
    typeID = theRoot->getSymbolTypeID(type);
    if (typeID==-1)
    {
      //theRoot->theTempBuffer.add(new TempLink(methodNode.getID(),MasterData::TYPE_LINK,type));
      theRoot->theTempBuffer.add(new Link(methodNode.getID(),MasterData::TYPE_LINK,type));
      methodNode.setTypeID(0) ;
    }
    else
    {
      methodNode.setTypeID(typeID) ;
    }
  }
  else
  {
    methodNode.setTypeID(-1) ;
  }
#endif

  parent.addNode(methodNode);


  /*for ( slocIter = 0 ; slocIter < sloc_v.size() ; slocIter++ ){
    if ( ( sloc_v[slocIter] <= endline ) && ( sloc_v[slocIter] >= startline ) ) {
      obj->SLOC++ ;
    }
  }*/

  //METRIC: obj->SLOC = -1;
  return FOUND;

fn_bailout:

  ttl=0;
  save=lex_index;

  while ((look_END_FDEF())&&(ttl<1000))
  {
    lex_index++;ttl++;
  }

  if (ttl==1000)
    lex_index=save;

  return NOT_FOUND ;
}
#endif


//This Method is only needed for C++
#ifdef LANGUAGE_CPP
int PopulatePhase::parseSimpleDecl(SymbolNode &parent,int pro)
{
  string type ;
#ifdef PROFESSIONAL
  string realtype ;
#endif
  bool foundtype = false ;
  bool removeTrailingComma = false ;

  int startline,endline;
  int expr_count,save,ttl;
  int declarators;
  int depth;

  // if it goes crazy, can usually skip to the enclosing end_simple_decl...Then NOT_FOUND

  if (look_BEGIN_SIMPLE_DECL())
    return NOT_FOUND;

  startline=lexemes[lex_index]->line;
  lex_index++;  // BEGIN_SIMPLE_DECL

  if (!look_END_SIMPLE_DECL())
  {
    lex_index++; // END_SIMPLE_DECL
    return FOUND;
  }

  if (!look_BEGIN_CD())
  {
    parseClassDecl(parent,pro);
  }
  if (!look_END_SIMPLE_DECL())
  {
    lex_index++;
    return FOUND;
  }

  // first, parse the decl_specifiers
  while (look_BEGIN_INIT_D())
  {
    save=lex_index;
    // deal with typedefs (head in the sand approach)
    if (!look_TYPE_SYNONYM())
      lex_index++;
    // assign type to declaration
    if (!look_SYM_TYPE_ID())
    {
      foundtype = true ;
      if (type.size()!=0)
      {
#ifdef PROFESSIONAL
        realtype += " " ;
            // concatenate type reference
        //debugging
        //next two lines changed to switch
        //if ( (lexemes[lex_index]->str[0]!='*')&&(lexemes[lex_index]->str[0]!='['))
        //  type = lexemes[lex_index]->str ;
        switch (lexemes[lex_index]->str[0]) {
          case '*': case '[': case '&': break;
        }
#endif
//Note:     realtype = type + " " + lexemes[lex_index]->str ;
        lex_index++;
          } else {
            // not got a type yet, set it up
            type = lexemes[lex_index]->str;
#ifdef PROFESSIONAL
        realtype = lexemes[lex_index]->str;
#endif
            lex_index++;
        }
    }

    // deal with class declaration
    if (!look_BEGIN_CD())
    {
      parseClassDecl(parent,pro);
        goto class_decl_out;
    }

    if ((save==lex_index)&&(look_BEGIN_INIT_D()))
    {
      goto wind_to_end_simple_decl;
    }
  }

class_decl_out:

  // now, parse those init_declarators
  while (look_END_SIMPLE_DECL())
  {
    SymbolNode fieldNode = theRoot->createSymbolNode(MasterData::FIELD_CAT) ;
    //fieldNode.setCategoryID(MasterData::FIELD_CAT) ;

    SymbolNode methodNode = theRoot->createSymbolNode(MasterData::METHOD_CAT) ;
//    methodNode.setCategoryID(MasterData::METHOD_CAT) ;


    if (look_BEGIN_INIT_D())
      return NOT_FOUND;

    lex_index++;  // BEGIN_INIT_D

    declarators=0;
    while (!look_BEGIN_DECLARATOR())
    {
      lex_index++;
      declarators++;
    }

    if (declarators==0)
      goto wind_to_end_simple_decl;

    if ((look_ID())&&(look_SYM_TYPE_ID()))
      goto wind_to_end_simple_decl;

    while (!look_SYM_TYPE_ID())
    {
      foundtype = true ;
      if (type.size()!=0)
      {
#ifdef PROFESSIONAL
        // concatenate type reference
        //debugging
        //next two lines changed to switch
        //if ( (lexemes[lex_index]->str[0]!='*')&&(lexemes[lex_index]->str[0]!='['))
        //  type = lexemes[lex_index]->str ;
        switch (lexemes[lex_index]->str[0]) {
          case '*': case '[': case '&': break;
        }

        realtype = type + " " + lexemes[lex_index]->str ;
#endif
        lex_index++;
      }
      else
      {
            // not got a type yet, set it up
            type = lexemes[lex_index]->str;
#ifdef PROFESSIONAL
        realtype = lexemes[lex_index]->str;
#endif
            lex_index++;
        }
    }

    startline=lexemes[lex_index]->line;

#ifdef PROFESSIONAL
    fieldNode.setName(lexemes[lex_index++]->str); // ID
#else
    string name = lexemes[lex_index++]->str ;
#endif

    while ((!look_SYM_TYPE_ID())||(!look_MIDCOMPLEX())||(!look_LOWCOMPLEX())||(!look_HIGHCOMPLEX()))
    {
      if (look_SYM_TYPE_ID())
        lex_index++;
      else if (type.size()!=0)
      {
#ifdef PROFESSIONAL
        foundtype = true ;
            // concatenate type reference
        //debugging
        //next two lines changed to switch
        //if ( (lexemes[lex_index]->str[0]!='*')&&(lexemes[lex_index]->str[0]!='['))
        //  type = lexemes[lex_index]->str ;
        switch (lexemes[lex_index]->str[0]) {
          case '*': case '[': case '&': break;
        }

        realtype = type + " " + lexemes[lex_index]->str ;
#endif
        lex_index++;
      }
      else
      {
        foundtype = true ;
            // not got a type yet, set it up
            type = lexemes[lex_index]->str;
#ifdef PROFESSIONAL
        realtype = lexemes[lex_index]->str;
#endif
            lex_index++;
        }
    }

    // printf("SIMPLEDECL OBJ TYPES: %s   REAL: %s\n",type->getName(),realtype);

    //TODO: handle typeref.
    // obj->setType(typeref);

    //if (realtype!=NULL)
    //  obj->fulltype=_strdup(realtype);
    //else
    //  obj->fulltype=_strdup("");

    //Changed: fieldNode.setTypeID(theRoot->getSymbolTypeID(realtype)) ;

    fieldNode.setProtectionID(pro);

#ifdef PROFESSIONAL
// This will be added again once the parameter info has been verified
//    methodNode.setName(fieldNode.getName()+"(");
    methodNode.setName(fieldNode.getName());
#else
// This will be added again once the parameter info has been verified
//    methodNode.setName(name+"(");
    methodNode.setName(name);
#endif

    //Note: no longer. methodNode.setParent(parent);

    //Metric: methodNode.linenr=startline+1;

    // printf("SIMPLEDECL FNOBJ TYPES: %s   REAL: %s\n",typeref->getName(),realtype);

    //theRoot->theBuffer.add(new TempLink(methodNode.getID(),MasterData::TYPE_LINK,realtype));

      methodNode.setProtectionID(pro);

    if (!look_DECL_PARAM_PART_BEGIN())
    {
      lex_index++;
      ttl=0;
      save=lex_index;

      while ((look_DECL_PARAM_PART_END())&&(ttl<50))
      {
        if (parseAbstractFunctionParameter(methodNode))
        {
          ttl++;
          //debugging
          //next line removed
          //lex_index++;
        } else {
          removeTrailingComma = true ;
        }
      }

      if (ttl==50)
      {
        goto tmp_fn_windup;
      }

      lex_index++;  // DECL_PARAM_PART_END

      while (!look_DECL_PARAM_PART_BEGIN())
      {
        lex_index++;
        while (look_DECL_PARAM_PART_END())
        {
          if (parseAbstractFunctionParameter(methodNode))
          {
            goto tmp_fn_windup;
          } else {
            removeTrailingComma = true ;
          }
        }
        lex_index++;
      }

    //      // function prototype
    //      ttl=0;save=lex_index;
    //      while ((look_DECL_PARAM_PART_END())&&(ttl<100)) {
    //  lex_index++;ttl++;
    //      }
    //      if (ttl==100) {
    //        lex_index=save;
    //  goto wind_to_end_simple_decl;
    //      }
    //      if (look_DECL_PARAM_PART_END())
    //        goto wind_to_end_simple_decl;
    //      lex_index++; // DECL_PARAM_PART_END


tmp_fn_windup:

// This will be added again once the parameter info has been verified

//    if (removeTrailingComma) {
//      string name = methodNode.getName() ;
//      name = name.substr(0,name.length()-1) ;
//      methodNode.setName( name + ")");  // ID
//    } else
//      methodNode.setName(methodNode.getName() + ")");  // ID


// GNS added this back in 12/2/99

      // Changed 12/06/2001
      // Previously this if statement added the methodNode
      // to the parent if the parent was not a file.
      // This resulted in methods being added to methods
      // which should not happen. I have output an error to
      // the log any time the situation arises where the parent
      // is a file (previously this would have done nothing).
      // Also now if the parent is a method it adds the fieldNode
      // to the parent.

      // The reason for this is that a method declaration
      // within a class can look the same as a constructor call
      // within a method. So we check to see what the parent
      // is and add the symbol accordingly.


      if (parent.getCategoryID()==MasterData::FILE_CAT) {
        //MasterData::theLog << "Error: PopulatePhase[2253]" << endl ;
      } else if (parent.getCategoryID()==MasterData::METHOD_CAT) {
        // debugging
        // To check where this situation appears I am logging it
        //MasterData::theLog << "Debugging: adding field " << fieldNode.getID() << ", " << fieldNode.getName() << endl ;
        parent.addNode(fieldNode) ;
      } else {
        // debugging
        // To check where this situation appears I am logging it
        //MasterData::theLog << "Debugging: adding method " << methodNode.getID() << ", " << methodNode.getName() << endl ;
        parent.addNode(methodNode);
      }

    }
#ifdef PROFESSIONAL
    else
    {
      parent.addNode(fieldNode);
      if (foundtype)
      {
        long typeID = theRoot->getSymbolTypeID(type);
        if (typeID==-1)
        {
          //theRoot->theTempBuffer.add(new TempLink(fieldNode.getID(),MasterData::TYPE_LINK,type));
          theRoot->theTempBuffer.add(new Link(fieldNode.getID(),MasterData::TYPE_LINK,type));
          fieldNode.setTypeID(0) ;
        }
        else
        {
          fieldNode.setTypeID(typeID) ;
        }
      }
      else
      {
        fieldNode.setTypeID(-1) ;
      }
    }
#endif

    while (declarators>0)
    {
      if (look_END_DECLARATOR())
        goto wind_to_end_simple_decl;
      lex_index++;
      declarators--;
    }
    expr_count=0;

    if (!look_BEGIN_EXPRESSION())
    {
      expr_count++;
      lex_index++;
      ttl=0;
      save=lex_index;
      while ((expr_count>0) && (ttl<1000))
      {
        if (!look_END_EXPRESSION())
        {
          expr_count--;
        }

        if (!look_BEGIN_EXPRESSION())
        {
          expr_count++;
        }

        lex_index++;
        ttl++;
      }


      if (ttl==1000) {
            lex_index=save; goto wind_to_end_simple_decl;
      }
    }

    if (look_END_INIT_D())
      goto wind_to_end_simple_decl;

    lex_index++;  // END_INIT_D
  }


  endline=lexemes[lex_index]->line;

  if (look_END_SIMPLE_DECL())
    return NOT_FOUND;

  lex_index++; // END_SIMPLE_DECL

  //  ((containerNode*)parent)->addNode(obj); // new GNS 12/2/99

  return FOUND;

wind_to_end_simple_decl:

  depth=1;
  while ((depth>0)  &&(lex_index<lexemes.size()))
  {
      if (!look_BEGIN_SIMPLE_DECL())
      depth++;
    if (!look_END_SIMPLE_DECL())
      depth--;
    lex_index++;
  }

  return FOUND;
}
#endif


//---------------------------------------------------------
//
// The following methods are used in both PopulatePhases
//
//---------------------------------------------------------


void PopulatePhase::clearLexemes()
{
  vector<Lexeme*>::iterator current = lexemes.begin();

  for ( ; current<lexemes.end() ; current++)
  {
    delete (*current) ;   // destroy the Symbol
  }

  lexemes.clear() ;
}


#ifdef LANGUAGE_CPP
int PopulatePhase::parseClassDecl(SymbolNode &parent,int in_pro)
{
  int pro,save,ptr ;
#elif LANGUAGE_JAVA
int PopulatePhase::parseClassDecl(SymbolNode &parent)
{
  int ptr ;
#endif

  int startline=0,endline=0 ;
  unsigned int slocIter;

  int SLOC = 0;

  ptr=lex_index;

#ifdef LANGUAGE_CPP
  if (look_BEGIN_CD()) {
    lex_index=ptr ;
    return NOT_FOUND ;
  }
#endif

#ifdef LANGUAGE_CPP
  startline = lexemes[lex_index]->line ;
#elif LANGUAGE_JAVA
  startline = lexemes[lex_index]->param ;
#endif

  lex_index++ ;     // Move to start of class

  SymbolNode classNode = theRoot->createSymbolNode(MasterData::CLASS_CAT) ;
  classNode.setTypeID(-1) ;

#ifdef LANGUAGE_JAVA
  parseProtection_opt(classNode) ;
  parseGregariousModifiers_opt(classNode) ;
#endif

  classNode.setName(lexemes[lex_index++]->str) ;
  //MasterData::theLog << "Found a class: " << classNode.getName() << endl ;

#ifdef LANGUAGE_CPP
  classNode.setProtectionID(in_pro) ;
#endif

#ifdef LANGUAGE_JAVA
  if (!look_INHERITS())
    parseInherits(classNode) ;
  if (!look_JIL_IMPLEMENTS())
    parseClassImplements(classNode) ;
  if (look_END_BODY())
    parseClassBody(classNode) ;

  lex_index++ ; // END_BODY
#endif

#ifdef LANGUAGE_CPP
  //SymbolNode classNode(MasterData::CLASS_CAT) ;
  //Metric: obj->linenr=startline+1;

  if (!look_BEGIN_BASES())
  {
    lex_index++ ; // BEGIN_BASES

    while (look_END_BASES())
    {
    save=lex_index ;

    if (!look_PROTECTION_LEVEL())
    {
      lex_index++ ; // ignore this for now - not needed for metrics
    }
    else if (!look_ID())
    {
#ifdef PROFESSIONAL
      //theRoot->theTempBuffer.add(new TempLink(classNode.getID(),MasterData::SUPER_LINK, lexemes[lex_index++]->str)) ;
      theRoot->theTempBuffer.add(new Link(classNode.getID(),MasterData::SUPER_LINK, lexemes[lex_index]->str)) ;
#endif
      lex_index++ ;
    }
    else
    {
      lex_index++ ;
    }

    if (lex_index==save)
    {
      return NOT_FOUND ;
    }
    }

    lex_index++ ;
  }

  if (look_MID_CD()) {
    return NOT_FOUND ;
  }

  lex_index++ ; // MID_CD

  if (look_PROTECTION_LEVEL())
  {
    return NOT_FOUND ;
  }

  lex_index++ ; // PROTECTION_LEVEL yeah, yeah
  pro=MasterData::PRIVATE_PROT ;

  while (look_END_CD())
  {
    if (parseClassMember(classNode,&pro))
    {
      return NOT_FOUND ;
    }
  }

  if (look_END_CD())
  {
    return NOT_FOUND ;
  }
#endif

#ifdef PROFESSIONAL
  theRoot->addSymbolType(classNode.getID(), classNode.getName()) ;
#endif

#ifdef LANGUAGE_CPP
  endline=lexemes[lex_index]->line ;

  classNode.setMetric(MasterData::LOC_MET, endline-startline+1) ;
#elif LANGUAGE_JAVA
  int testLOC = lexemes[lex_index++]->param ;
  classNode.setMetric(MasterData::LOC_MET, (float)testLOC) ;

  endline=startline+testLOC ;
#endif

#ifdef LANGUAGE_CPP
  lex_index++; // END_CD
#endif

  parent.addNode(classNode) ;

  for (slocIter = 0 ; slocIter < sloc_v.size() ; slocIter++) {
    if ( ( sloc_v[slocIter] <= endline ) && ( sloc_v[slocIter] >= startline ) ) {
      SLOC++ ;
    }
  }

  classNode.setMetric(MasterData::SLOC_MET,(float)SLOC) ;

  return FOUND ;
}



int PopulatePhase::parseDeclaration(SymbolNode &parent)
{

#ifdef LANGUAGE_CPP

  while (look_END_FILE())
  {
    if (!look_BEGIN_FDEF())
    {
      if (parseFunction(parent,MasterData::PUBLIC_PROT))
      {
        lex_index++;
      }
    }
    else if (!look_BEGIN_SIMPLE_DECL())
    {
      if (parseSimpleDecl(parent,MasterData::PUBLIC_PROT)) {
        lex_index++;
      }
      }
    else if (lex_index>=lexemes.size())
    {
        return FOUND;
    }
    else
    {
         lex_index++;
    }
  }

  parent.setMetric(MasterData::LOC_MET , lexemes[lex_index++]->line ) ;
  parent.setMetric(MasterData::SLOC_MET , lexemes[lex_index++]->param ) ;

  //NOT YET PER FUNCTION
  //  while (look_END_FILE()) {
  //    // gather specific LOC info, use to set function SLOC
  //    for (i=0;i<parent->contents.size();i++) {
  //      if (((parent->contents[i])->myTypeID))==METHODNODE) {
  //
  //      };
  //    };
  //  };
  //
#elif LANGUAGE_JAVA

  if (!look_JIL_IMPORT())
    parseImportList(parent);

  lex_index++;          // END_UNIT_HEADER

  while (look_END_UNIT())
    parseTypeDecl(parent);

  lex_index++;          // END_UNIT

  parent.setMetric(MasterData::LOC_MET, (float)lexemes[lex_index++]->param) ;
  parent.setMetric(MasterData::SLOC_MET, (float)lexemes[lex_index++]->param) ;

#endif

  return FOUND;
}


bool PopulatePhase::loadFile(string filename)
{
  if (debugging) MasterData::theLog << "loadFile(" << filename << ")" << endl ;
  lexsize = 0 ;

  // Fixed: 23/02/2001
  // Now Checks existance of files before trying to open them
  //MasterData::theLog << "loading: " << filename.c_str() << endl ;
  struct stat buf;
  if (stat(filename.c_str(),&buf)!=0) return false ;

  #ifdef WIN32
  if (_pipe(pipeA,102400,_O_BINARY|_O_NOINHERIT)==-1) {
    MasterData::theLog << "Unable to create pipe." << endl ;
    return false ;
  }
  #else
  pipe(pipeA) ;
  #endif

  if (debugging) MasterData::theLog << "1," << flush ;

  int pid ;
  int childWriteFD ;

  #ifdef WIN32
  childWriteFD = _dup(pipeA[WRITE]);
  _close(pipeA[WRITE]) ;
  #else
  childWriteFD=dup(pipeA[WRITE]);
  close(pipeA[WRITE]) ;
  #endif

  /*char *fname = _strdup(filename.c_str()) ;
  for(char *f = fname ; *f!='\0'; f++)
  {
    if (*f==' ') (*f) = 1 ;
  }*/

  if (debugging) MasterData::theLog << "3," << flush ;

#ifdef LANGUAGE_CPP

#ifdef WIN32
  // Changed from fname to  FD
  // 15-11-01 SJW
  // Changed to allow both fname and FD
  // 19/11/2001 CAM

  char child[20] ;
  ltostr(childWriteFD, child, 20) ;

  if (useTranslationFile)
  {
    int prepFD = thePreprocessor.prepFile(filename.c_str()) ;
    int readFromPrep = _dup(prepFD) ;

    char prep[20] ;
    ltostr(readFromPrep, prep, 20) ;

    if ((pid=_spawnl(_P_NOWAIT,"bin/cparser.exe","bin/cparser.exe","-single",prep,child,NULL))==-1) {
      MasterData::theLog << "Spawn failed. " << endl ;
      return false ;
    }
  }
  else
  {
    char *fname = _strdup(filename.c_str()) ;
    for(char *f = fname ; *f!='\0'; f++)
    {
      if (*f==' ') (*f) = 1 ;
    }

    //MasterData::theLog << "Calling cparser traditionally with " << fname << endl ;

    if ((pid=_spawnl(_P_NOWAIT,"bin/cparser.exe","bin/cparser.exe",fname,child,NULL))==-1) {
      MasterData::theLog << "Spawn failed. " << endl ;
      return false ;
    }

    free(fname) ;
  }

#else
  if (debugging) MasterData::theLog << "4," << flush ;

  if ((pid=fork())==0) {
    char *childWriteChar = ltostr(childWriteFD, childWriteSTR, 20) ;
    MasterData::theLog << "childWrite: " << childWriteFD << flush ;
    MasterData::theLog << " [" << childWriteChar << "]" << endl ;
    int rval=execl("bin/cparser.exe","bin/cparser.exe","-single",fname, childWriteChar, NULL) ;

    MasterData::theLog << "rval=" << rval << endl ;
    MasterData::theLog << "errno=" << errno << endl ;

    if (rval == -1) {

      switch (errno)
      {
        case E2BIG:   MasterData::theLog << "E2BIG" << endl ;   break ;
          case EACCES:  MasterData::theLog << "EACCES" << endl ;  break ;
        case EAGAIN:  MasterData::theLog << "EAGAIN" << endl ;  break ;
        case EFAULT:  MasterData::theLog << "EFAULT" << endl ;  break ;
        case EINTR:   MasterData::theLog << "EINTR" << endl ;   break ;
          case ELOOP:   MasterData::theLog << "ELOOP" << endl ;   break ;
          case ENAMETOOLONG:  MasterData::theLog << "ENAMETOOLONG" << endl ;  break ;
          case ENOENT:  MasterData::theLog << "ENOENT" << endl ;  break ;
          case ENOEXEC: MasterData::theLog << "ENOEXEC" << endl ; break ;
          case ENOLINK: MasterData::theLog << "ENOLINK" << endl ; break ;
          case ENOMEM:  MasterData::theLog << "ENOMEM" << endl ;  break ;
        case ENOTDIR: MasterData::theLog << "ENOTDIR" << endl ; break ;
        default:    MasterData::theLog << "Some other error." << endl ; break;
      }
    }

    _exit(0) ;

  } else if (pid < 0) {
    MasterData::theLog << "Forking ERROR " << errno << endl ;
    switch (errno) {
    case EAGAIN:
        MasterData::theLog << "EAGAIN" << endl ;
      break ;

      case ENOMEM:
          MasterData::theLog << "ENOMEM" << endl ;
      break ;

        default:
            MasterData::theLog << "Some other error." << endl ;
      break ;
     }

     return false ;
  }
  if (debugging) MasterData::theLog << "5," << flush ;

#endif


#elif LANGUAGE_JAVA
  ltostr(childWriteFD, childWriteSTR, 20) ;

  char *fname = _strdup(filename.c_str()) ;
  for(char *f = fname ; *f!='\0'; f++)
  {
    if (*f==' ') (*f) = 1 ;
  }

#ifdef WIN32
  if ((pid=_spawnl(_P_NOWAIT,"bin/jparser.exe","bin/jparser.exe","-single",fname,childWriteSTR,NULL))==-1) {
    MasterData::theLog << "Spawn failed. " << endl ;
    return false ;
  }
#else
  if ((pid=fork())==0) {
    execl("bin/jparser.exe","bin/jparser.exe","-single",fname,ltostr(childWriteFD, childWriteSTR, 20),NULL);
    _exit(0) ;
  }
#endif

#endif

  FILE *infile=_fdopen(pipeA[READ],"r");

  str[0]='\0';

  Lexeme *currentLexeme;
  clearLexemes() ;

  int retval ;

  if (infile==NULL) {
    MasterData::theLog << "\nError: " << flush ;
    if (errno==EBADF) {
      MasterData::theLog << "The fildes argument is not a valid  file  descriptor." << endl ;
    } else if (errno==EINVAL) {
      MasterData::theLog << "The mode argument is not a valid mode" << endl ;
    } else if (errno==EMFILE) {
      MasterData::theLog << "The number of streams currently open in  the  calling process is either FOPEN_MAX or STREAM_MAX." << endl ;
    } else if (errno==ENOMEM) {
      MasterData::theLog << "Insufficient space to allocate a buffer." << endl ;
    }
  }

  if (debugging) MasterData::theLog << "6" << endl ;

  do
  {
    currentLexeme = new Lexeme() ;

#ifdef LANGUAGE_CPP     // A cpp lexeme has 6 components
    retval = fscanf(infile,"%d%d%s%d%d%d",&(currentLexeme->com),&(currentLexeme->param),str,&(currentLexeme->line),&(currentLexeme->startcol),&(currentLexeme->endcol)) ;

#elif LANGUAGE_JAVA     // A java lexeme has 3 components
    retval = fscanf_s(infile,"%d%d%s",& (currentLexeme->com),&(currentLexeme->param),str) ;
#endif
    if( currentLexeme->com < -10 ) {
      MasterData::theLog << "about to goto (1)" << endl ;
      goto end_load ;
    }

    currentLexeme->str = str ;

    outputLexeme(currentLexeme) ;

    str[0]='\0';
    lexemes.push_back(currentLexeme);

#ifdef LANGUAGE_CPP     // CPP sloc info occurs after the END_FILE identifier
    if( currentLexeme->com == END_FILE ){
#elif LANGUAGE_JAVA     // Java sloc info occurs after the first JIL_SLOC identifier
    if( currentLexeme->com == JIL_SLOC ){
#endif
      break;//exit this loop and start counting SLOC info
    }
  }
#ifdef LANGUAGE_CPP     // A cpp lexeme has 6 components
  while (retval==6) ;
#elif LANGUAGE_JAVA     // A java lexeme has 3 components
  while (retval==3) ;
#endif

  if (debugging) MasterData::theLog << "7," << flush ;

  // TODO: check if the extra scanf outwith the do-while is necessary

  currentLexeme = new Lexeme() ;

#ifdef LANGUAGE_CPP     // A cpp lexeme has 6 components
  retval = fscanf(infile,"%d%d%s%d%d%d",& (currentLexeme->com),&(currentLexeme->param),str,&(currentLexeme->line),&(currentLexeme->startcol),&(currentLexeme->endcol)) ;
#elif LANGUAGE_JAVA     // A java lexeme has 3 components
  retval = fscanf_s(infile,"%d%d%s",& (currentLexeme->com),&(currentLexeme->param),str) ;
#endif

  if (debugging) MasterData::theLog << "8," << flush ;

  sloc_v.clear();
  lexemes.push_back(currentLexeme);
  outputLexeme(currentLexeme) ;

  if (debugging) MasterData::theLog << "9," << flush ;

  do {
    currentLexeme = new Lexeme() ;

#ifdef LANGUAGE_CPP     // A cpp lexeme has 6 components
    retval = fscanf(infile,"%d%d%s%d%d%d",& (currentLexeme->com),&(currentLexeme->param),str,&(currentLexeme->line),&(currentLexeme->startcol),&(currentLexeme->endcol)) ;
#elif LANGUAGE_JAVA     // A java lexeme has 3 components
    retval = fscanf_s(infile,"%d%d%s",& (currentLexeme->com),&(currentLexeme->param),str) ;
#endif

    outputLexeme(currentLexeme) ;
    if( currentLexeme->com < -10 ){
      break ;
    }

    lexemes.push_back( currentLexeme );

#ifdef LANGUAGE_CPP
    if( currentLexeme->com == marker ){
#elif LANGUAGE_JAVA
    if( currentLexeme->com == JIL_SLOC ){
#endif
      sloc_v.push_back( currentLexeme->param );
    }
  }
#ifdef LANGUAGE_CPP     // A cpp lexeme has 6 components
  while (retval==6) ;
#elif LANGUAGE_JAVA     // A java lexeme has 3 components
  while (retval==3) ;
#endif

  if (debugging) MasterData::theLog << "10," << flush ;

  lexsize=lexemes.size() ;

#ifdef LANGUAGE_CPP
  if (debugging) MasterData::theLog << "11," << flush ;

  c_com = lexemes[lexsize-1]->com ;
  cpp_com = lexemes[lexsize-1]->param ;
  com = lexemes[lexsize-1]->line ;
  nsemi = lexemes[lexsize-1]->startcol ;

  if (debugging) MasterData::theLog << "12," << flush ;

  N1 = lexemes[lexsize-2]->param ;
  N2 = lexemes[lexsize-2]->com ;
  n1 = lexemes[lexsize-2]->startcol ;
  n2 = lexemes[lexsize-2]->line ;
#elif LANGUAGE_JAVA
  nsemi = lexemes[lexsize-9]->param ;
  N1 = lexemes[lexsize-8]->param ;
  N2 = lexemes[lexsize-7]->param ;
  n1 = lexemes[lexsize-6]->param ;
  n2 = lexemes[lexsize-5]->param ;

  j_com = lexemes[lexsize-4]->param ;
  c_com = lexemes[lexsize-3]->param ;
  cpp_com = lexemes[lexsize-2]->param ;
  com = lexemes[lexsize-1]->param ;
#endif

  if (debugging) MasterData::theLog << "13," << flush ;

#ifdef WIN32
//  _cwait(NULL,pid,NULL) ;
#elif sun
  waitpid(pid,NULL,NULL) ;
#endif


end_load:

  if (debugging) MasterData::theLog << "14" << endl ;

  _close(childWriteFD) ;
  fclose(infile) ;

  return lexsize!=0 ;
}


void PopulatePhase::parseFile(string filename)
{
  lex_index=1 ; // lex_index=0 holds filename - we know this so start at 1
  if (debugging) MasterData::theLog << "15," << flush ;

  SymbolNode fileNode = theRoot->createSymbolNode(MasterData::FILE_CAT) ;
  fileNode.setName(filename) ;
  fileNode.setTypeID(-1) ;

  if (debugging) MasterData::theLog << "16," << flush ;

#ifdef LANGUAGE_JAVA
  fileNode.setMetric(MasterData::JCOM_MET,(float)j_com) ;
#endif

  fileNode.setMetric(MasterData::CCOM_MET,(float)c_com) ;
  fileNode.setMetric(MasterData::CPPCOM_MET,(float)cpp_com) ;
  fileNode.setMetric(MasterData::COM_MET,(float)com) ;
  fileNode.setMetric(MasterData::NSC_MET,(float)nsemi) ;

  fileNode.setMetric(MasterData::N1_MET,(float)N1) ;
  fileNode.setMetric(MasterData::N2_MET,(float)N2) ;
  fileNode.setMetric(MasterData::n1_MET,(float)n1) ;
  fileNode.setMetric(MasterData::n2_MET,(float)n2) ;

#ifdef LANGUAGE_CPP

  if (debugging) MasterData::theLog << "17," << flush ;
  theProjNode.addNode(fileNode) ;

#elif LANGUAGE_JAVA

  SymbolNode package = fileNode ;   // Assign for speed

  if (!look_ID())
    package = getPackage(parseID()) ;
  else
    package = getPackage("default") ;

  package.addNode(fileNode) ;
  //theProjNode.addNode(package) ;

#endif

  if (debugging) MasterData::theLog << "18," << flush ;
  parseDeclaration(fileNode) ;
}


void PopulatePhase::extractTypes(SymbolNode &sn)
{
  try
  {
    // Check if there are any types that refer to this symbol
    char sql[1024], charNumber[30] ;

    strcpy_s(sql,1024,"select sytid from symboltype where symid=") ;
    strcat_s(sql,1024, ltostr(sn.getID(), charNumber, 30)) ;

    if (theRoot->executeQuery(sql))
    {
      long sytid = atol(theRoot->cell(0,0).c_str()) ;

      // There are so update all symbols that have this symbol as their type to have 0
      strcpy_s(sql,1024,"update symbol set sytid=0 where sytid=") ;
      strcat_s(sql,1024, ltostr(sytid, charNumber, 30)) ;
      theRoot->executeResultlessQuery(sql) ;

      // Delete the symboltype
      strcpy_s(sql,1024,"delete from symboltype where sytid=") ;
      strcat_s(sql,1024, ltostr(sytid, charNumber, 30)) ;
      theRoot->executeResultlessQuery(sql) ;
    }
  }
  catch (...)
  {
    MasterData::theLog << "Error in: PopulatePhase::extractTypes()" << endl ;
  }
}

void PopulatePhase::extractLinks(SymbolNode &sn)
{
  int i;
  SymbolNode tmp=sn;
  string ref = sn.getName() ;

  try
  {
    char sql[1024], charNumber[30] ;

    // Delete links from this symbol
    strcpy_s(sql,1024,"delete from link where symid=") ;
    strcat_s(sql,1024, ltostr(sn.getID(), charNumber, 30)) ;
    theRoot->executeResultlessQuery(sql) ;

    // Get links to this symbol
    strcpy_s(sql,1024,"select symID,lktID from link where sym2id=") ;
    strcat_s(sql,1024, ltostr(sn.getID(), charNumber, 30)) ;
    theRoot->executeResultlessQuery(sql) ;


    // Create templinks for these
    if (theRoot->executeQuery(sql))
    {
      for (i=0 ; i<theRoot->rows() ; i++)
      {
        long fromID = atol(theRoot->cell(i,0).c_str()) ;
        long lktID = atol(theRoot->cell(i,1).c_str()) ;

        //theRoot->theTempBuffer.add( new TempLink(fromID,lktID,ref) ) ;
        theRoot->theTempBuffer.add( new Link(fromID,lktID,ref) ) ;
      }
    }

    // Now delete links to this symbol
    strcpy_s(sql,1024,"delete from link where sym2id=") ;
    strcat_s(sql,1024, ltostr(sn.getID(), charNumber, 30)) ;
    theRoot->executeResultlessQuery(sql) ;
  }
  catch(...)
  {
    MasterData::theLog << "Error in: PopulatePhase::extractLinks()" << endl ;
  }

  for ( i=0 ; i<sn.childCount() ; i++)
  {
    SymbolNode nextChild = sn.getChild(i) ;
    extractLinks(nextChild) ;
  }
}


int PopulatePhase::getProgress()
{
  LOCKMUTEX(progress_lock) ;
  int retval = (int) 100*currentFile/theNoOfFiles ;
  UNLOCKMUTEX(progress_lock) ;
  MasterData::theLog << "PopulatePhase, progress: " << retval << endl;
  return retval ;
}


void PopulatePhase::populateSub(SymbolNode parent, long subID, string depth)
{
  Subproject subproj(theRoot, subID) ;
  string filename ;
  long nextSubID ;
  // Create Subproject node, and add to the parent
  theProjNode = theRoot->createSymbolNode() ;
  theProjNode.setCategoryID(MasterData::PROJECT_CAT) ;
  theProjNode.setName(subproj.getSubName()) ;
  subproj.updateSymbolID(theProjNode.getID()) ;

  parent.addNode(theProjNode) ;

  while (subproj.getNextFile(filename))
  {
    if (loadFile(filename)) {
      parseFile(filename) ;
    }

    LOCKMUTEX(progress_lock) ;
    currentFile++ ;
    UNLOCKMUTEX(progress_lock) ;
  }

  depth += " " ;
  SymbolNode tmpNode = theProjNode ;

  while (subproj.getNextSub(nextSubID))
  {
    populateSub(theProjNode, nextSubID, depth) ;
    theProjNode = tmpNode ;
  }
}


int PopulatePhase::countFiles()
{
  if (theRoot->executeQuery("select count(*) as RecordCount from sourcefile"))
  {
    return theRoot->longCell(0,0) ;
  }

  return 0 ;
}


void PopulatePhase::execute(RootNode *root)
{
  LOCKMUTEX(progress_lock) ;
  theRoot = root ;
  theRoot->createTempLink() ;
  debugging = true ;

#ifdef LANGUAGE_CPP
  if (useTranslationFile) {
    MasterData::theLog << "Translation file [" << theTranslationFile << "]" << endl ;
    thePreprocessor.loadCfg(theTranslationFile.c_str()) ;
  } else {
    MasterData::theLog << "Not using a Translation file." << endl ;
  }
#endif

  currentFile=0 ;

  theNoOfFiles = countFiles() ;
  MasterData::theLog << "Populating, no of files: " << theNoOfFiles << endl ;
  UNLOCKMUTEX(progress_lock) ;

  Subproject subproj(theRoot, 1) ;
  string filename ;
  long nextSubID ;
  subproj.updateSymbolID(1) ;
  theProjNode = (*theRoot) ;
  string depth="" ;

  while (subproj.getNextFile(filename))
  {
    MasterData::theLog << depth << " [" << filename << "]" << endl ;
    if (loadFile(filename)) {
      parseFile(filename) ;
    }

    LOCKMUTEX(progress_lock) ;
    currentFile++ ;
    UNLOCKMUTEX(progress_lock) ;
  }

  while (subproj.getNextSub(nextSubID))
  {
    populateSub((*theRoot), nextSubID, depth) ;
  }

  LOCKMUTEX(progress_lock) ;
  committing = true ;
  UNLOCKMUTEX(progress_lock) ;

  theRoot->flushBuffers() ;
}
