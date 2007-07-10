/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 * Essential Project Manager (EPM)
 * Copyright (c) 2004-2007 Power Software
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * PParse - XML Configuration File Parser
 *
 * $Id$
 *
 * Who  When       Why
 * CAM  16-Aug-05  File added.
 * CAM  28-Jan-06   168 : Set global MetricSet (metSet).
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

#include <xercesc/util/PlatformUtils.hpp>
#include <xercesc/framework/XMLPScanToken.hpp>
#include <xercesc/parsers/SAXParser.hpp>
#include "PParse.hpp"
#include <xercesc/util/OutOfMemoryException.hpp>

static char* xmlFile = 0;
static SAXParser::ValSchemes valScheme = SAXParser::Val_Auto;

Extension *ext;
MetricSet *metSet;

extern char szAppDirectory[];

void xmlConfigParse() {
  try {
    XMLPlatformUtils::Initialize();
  } catch (const XMLException&) {
    ext->nErrors |= ERR_GEN_INIT;
    return;
  }

  char xmlFullpath[4096];
  strcpy(xmlFullpath, szAppDirectory);
  strcat(xmlFullpath, "epm.xml");
  xmlFile = xmlFullpath;

  SAXParser* parser = new SAXParser;
  PParseHandlers handler;
  parser->setDocumentHandler(&handler);
  parser->setErrorHandler(&handler);
  parser->setValidationScheme(valScheme);
  parser->setDoNamespaces(false);
  parser->setDoSchema(false);
  parser->setValidationSchemaFullChecking(false);

  ext = handler.getExtension();
  metSet = handler.getMetricSet();

  try {
    XMLPScanToken token;

    if (!parser->parseFirst(xmlFile, token)) {
      XMLPlatformUtils::Terminate();
      ext->nErrors |= ERR_GEN_FAIL;
      return;
    }

    bool gotMore = true;
    while (gotMore && !parser->getErrorCount()) {
      gotMore = parser->parseNext(token);
    }

    if (parser->getErrorCount() > 0) ext->nErrors |= ERR_TYPE_ERROR;
    parser->parseReset(token);

  } catch (const OutOfMemoryException&) {
    ext->nErrors |= ERR_GEN_MEM;
  } catch (const XMLException&) {
    ext->nErrors |= ERR_GEN_XML;
  }

  if (!ext->nErrors) {
    for (int i=0; i<ext->nLang; i++) {
      XERCES_STD_QUALIFIER cout << ext->sLang[i].fId << " using parser " << ext->sLang[i].fDesc << endl;

      for (int j=0; j<ext->nType[i]; j++) {
        XERCES_STD_QUALIFIER cout << " " << ext->sType[i][j].fId << endl;

        for (int k=0; k<ext->nExt[i][j]; k++) {
          XERCES_STD_QUALIFIER cout << "   [." << ext->sExt[i][j][k].fDesc << "] " << ext->sExt[i][j][k].fId << endl;
        }
      }

      XERCES_STD_QUALIFIER cout << endl;
    }
  }

  delete parser;
  XMLPlatformUtils::Terminate();
}

int xmlConfig() {
  xmlConfigParse();

  if (ext->nErrors & ERR_NEW_LANG)     XERCES_STD_QUALIFIER cout << "XMLConfig: Error Adding New Language" << endl;
  if (ext->nErrors & ERR_NEW_FTYPE)    XERCES_STD_QUALIFIER cout << "XMLConfig: Error Adding New File Type" << endl;
  if (ext->nErrors & ERR_NEW_EXTN)     XERCES_STD_QUALIFIER cout << "XMLConfig: Error Adding New Extension" << endl;
  if (ext->nErrors & ERR_TYPE_ERROR)   XERCES_STD_QUALIFIER cout << "XMLConfig: General Error" << endl;
  if (ext->nErrors & ERR_TYPE_FATAL)   XERCES_STD_QUALIFIER cout << "XMLConfig: General Fatal Error" << endl;
  if (ext->nErrors & ERR_TYPE_WARN)    XERCES_STD_QUALIFIER cout << "XMLConfig: General Warning" << endl;
  if (ext->nErrors & ERR_GEN_FAIL)     XERCES_STD_QUALIFIER cout << "XMLConfig: General Failure" << endl;
  if (ext->nErrors & ERR_GEN_MEM)      XERCES_STD_QUALIFIER cout << "XMLConfig: Out of Memory" << endl;
  if (ext->nErrors & ERR_GEN_XML)      XERCES_STD_QUALIFIER cout << "XMLConfig: XML Parsing Error" << endl;
  if (ext->nErrors & ERR_GEN_INIT)     XERCES_STD_QUALIFIER cout << "XMLConfig: Error Initialising XML Parser" << endl;

  return ext->nErrors;
}

