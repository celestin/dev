/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 * Essential Project Manager (EPM)
 * Copyright (c) 2004,2010 PowerSoftware.com
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * PParse - XML Configuration File Parser
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  16-Aug-05    File added.
 * CAM  28-Jan-06    168 : Set global MetricSet (metSet).
 * CAM  24-Apr-08    358 : Corrected compiler warnings moving to VS2008 (from VC++6).
 * CAM  13-Mar-2010  10581 : Refer to Home dir for EPM.XML (to ensure Vista/7 compatibility).
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

#include <xercesc/util/PlatformUtils.hpp>
#include <xercesc/framework/XMLPScanToken.hpp>
#include <xercesc/parsers/SAXParser.hpp>
#include "PParse.hpp"
#include <xercesc/util/OutOfMemoryException.hpp>

#define STRING_MAX 4096

static char* xmlFile = 0;
static SAXParser::ValSchemes valScheme = SAXParser::Val_Auto;

Extension *ext;
MetricSet *metSet;

extern char szHomeDir[];

void xmlConfigParse() {
  try {
    XMLPlatformUtils::Initialize();
  } catch (const XMLException&) {
    ext->nErrors |= ERR_GEN_INIT;
    return;
  }

  char xmlFullpath[STRING_MAX];
  strcpy_s(xmlFullpath, STRING_MAX, szHomeDir);
  strcat_s(xmlFullpath, STRING_MAX, "epm.xml");
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
      XERCES_STD_QUALIFIER cout << ext->sLang[i].fId << " using parser " << ext->sLang[i].fDesc << XERCES_STD_QUALIFIER endl;

      for (int j=0; j<ext->nType[i]; j++) {
        XERCES_STD_QUALIFIER cout << " " << ext->sType[i][j].fId << XERCES_STD_QUALIFIER endl;

        for (int k=0; k<ext->nExt[i][j]; k++) {
          XERCES_STD_QUALIFIER cout << "   [." << ext->sExt[i][j][k].fDesc << "] " << ext->sExt[i][j][k].fId << XERCES_STD_QUALIFIER endl;
        }
      }

      XERCES_STD_QUALIFIER cout << XERCES_STD_QUALIFIER endl;
    }
  }

  delete parser;
  XMLPlatformUtils::Terminate();
}

int xmlConfig() {
  xmlConfigParse();

  if (ext->nErrors & ERR_NEW_LANG)     XERCES_STD_QUALIFIER cout << "XMLConfig: Error Adding New Language" << XERCES_STD_QUALIFIER endl;
  if (ext->nErrors & ERR_NEW_FTYPE)    XERCES_STD_QUALIFIER cout << "XMLConfig: Error Adding New File Type" << XERCES_STD_QUALIFIER endl;
  if (ext->nErrors & ERR_NEW_EXTN)     XERCES_STD_QUALIFIER cout << "XMLConfig: Error Adding New Extension" << XERCES_STD_QUALIFIER endl;
  if (ext->nErrors & ERR_TYPE_ERROR)   XERCES_STD_QUALIFIER cout << "XMLConfig: General Error" << XERCES_STD_QUALIFIER endl;
  if (ext->nErrors & ERR_TYPE_FATAL)   XERCES_STD_QUALIFIER cout << "XMLConfig: General Fatal Error" << XERCES_STD_QUALIFIER endl;
  if (ext->nErrors & ERR_TYPE_WARN)    XERCES_STD_QUALIFIER cout << "XMLConfig: General Warning" << XERCES_STD_QUALIFIER endl;
  if (ext->nErrors & ERR_GEN_FAIL)     XERCES_STD_QUALIFIER cout << "XMLConfig: General Failure" << XERCES_STD_QUALIFIER endl;
  if (ext->nErrors & ERR_GEN_MEM)      XERCES_STD_QUALIFIER cout << "XMLConfig: Out of Memory" << XERCES_STD_QUALIFIER endl;
  if (ext->nErrors & ERR_GEN_XML)      XERCES_STD_QUALIFIER cout << "XMLConfig: XML Parsing Error" << XERCES_STD_QUALIFIER endl;
  if (ext->nErrors & ERR_GEN_INIT)     XERCES_STD_QUALIFIER cout << "XMLConfig: Error Initialising XML Parser" << XERCES_STD_QUALIFIER endl;

  return ext->nErrors;
}

