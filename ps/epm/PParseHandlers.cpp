/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 * Essential Project Manager (EPM)
 * Copyright (c) 2004-2006 Power Software
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * PParseHandlers - XML Configuration File Parser
 *
 * $Id$
 *
 * Who  When       Why
 * CAM  16-Aug-05  File added.
 * CAM  06-Jan-06  168 : Added Metrics Sets.
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

#include <xercesc/util/XMLUniDefs.hpp>
#include <xercesc/util/XMLUni.hpp>
#include <xercesc/sax/AttributeList.hpp>
#include "PParse.hpp"


PParseHandlers::PParseHandlers() {
  fExt = new Extension();
  fMet = new MetricSet();
}

PParseHandlers::~PParseHandlers() {}


void PParseHandlers::startElement(const XMLCh* const name, AttributeList& attributes) {
  fLocalForm = XMLString::transcode(name);
  unsigned int i;
  char *fLang, *fParser, *fFileName, *fExtName, *fExtension, *fSetName;
  int nL,nT,nS,nM;
  MetricConfig mc;

  if (!strcmp(fLocalForm, "lang")) {
    fLang = fParser = NULL;
    for (i=0; i<attributes.getLength(); i++) {
      fLocalForm = XMLString::transcode(attributes.getName(i));
      if (!strcmp(fLocalForm, "name")) {
        fLang = strdup(XMLString::transcode(attributes.getValue(i)));
      } else if (!strcmp(fLocalForm, "parser")) {
        fParser = strdup(XMLString::transcode(attributes.getValue(i)));
      }
    }

    if (!fLang || !fParser) {
      fExt->nErrors |= ERR_NEW_LANG;
    } else {
      fExt->sLang[fExt->nLang++].set(fLang, fParser);
    }

  } else if (!strcmp(fLocalForm, "filetype")) {
    fFileName = NULL;
    for (i=0; i<attributes.getLength(); i++) {
      fLocalForm = XMLString::transcode(attributes.getName(i));
      if (!strcmp(fLocalForm, "name")) {
        fFileName = strdup(XMLString::transcode(attributes.getValue(i)));
      }
    }

    if (!fFileName) {
      fExt->nErrors |= ERR_NEW_FTYPE;
    } else {
      nL = fExt->nLang-1;
      fExt->sType[nL][fExt->nType[nL]++].set(fFileName, fFileName);
    }

  } else if (!strcmp(fLocalForm, "ext")) {
    fExtName = fExtension = NULL;
    for (i=0; i<attributes.getLength(); i++) {
      fLocalForm = XMLString::transcode(attributes.getName(i));
      if (!strcmp(fLocalForm, "name")) {
        fExtName = strdup(XMLString::transcode(attributes.getValue(i)));
      } else if (!strcmp(fLocalForm, "value")) {
        fExtension = strdup(XMLString::transcode(attributes.getValue(i)));
      }
    }

    if (!fExtName || !fExtension) {
      fExt->nErrors |= ERR_NEW_EXTN;
    } else {
      nL = fExt->nLang-1;
      nT = fExt->nType[nL]-1;

      fExt->sExt[nL][nT][fExt->nExt[nL][nT]++].set(fExtName, fExtension);
    }

  } else if (!strcmp(fLocalForm, "set")) {
    fSetName = NULL;
    for (i=0; i<attributes.getLength(); i++) {
      fLocalForm = XMLString::transcode(attributes.getName(i));
      if (!strcmp(fLocalForm, "name")) {
        fSetName = strdup(XMLString::transcode(attributes.getValue(i)));
      }
    }

    if (!fSetName) {
      fMet->nErrors |= ERR_NEW_SET;
    } else {
      fMet->addSet(fSetName);
      //cout << fMet->sSet[fMet->nSet-1] << endl;
    }

  } else if (!strcmp(fLocalForm, "met")) {
    mc.fId = 0;
    mc.bLower = mc.bUpper = false;

    for (i=0; i<attributes.getLength(); i++) {
      fLocalForm = XMLString::transcode(attributes.getName(i));
      if (!strcmp(fLocalForm, "id")) {
        mc.fId = atoi(strdup(XMLString::transcode(attributes.getValue(i))));
      } else if (!strcmp(fLocalForm, "lower")) {
        mc.lower(atoi(strdup(XMLString::transcode(attributes.getValue(i)))));
      } else if (!strcmp(fLocalForm, "upper")) {
        mc.upper(atoi(strdup(XMLString::transcode(attributes.getValue(i)))));
      }
    }

    if (!mc.fId) {
      fMet->nErrors |= ERR_NEW_MET;
    } else {
      nS = fMet->nSet-1;
      nM = fMet->nMet[nS]++;

      fMet->metConfig[nS][nM].fId = mc.fId;
      if (mc.bLower) fMet->metConfig[nS][nM].lower(mc.lLower);
      if (mc.bUpper) fMet->metConfig[nS][nM].upper(mc.lUpper);

      //cout << fMet->metConfig[nS][nM] << endl;
    }
  }
}

void PParseHandlers::error(const SAXParseException& e) {
  fExt->nErrors |= ERR_TYPE_ERROR;
}

void PParseHandlers::fatalError(const SAXParseException& e) {
  fExt->nErrors |= ERR_TYPE_FATAL;
}

void PParseHandlers::warning(const SAXParseException& e) {
  fExt->nErrors |= ERR_TYPE_WARN;
}

bool PParseHandlers::isError() const {
  return (fExt->nErrors>0);
}

int PParseHandlers::getError() const {
  return fExt->nErrors;
}


void PParseHandlers::characters(const XMLCh* const chars , const unsigned int length) {}
void PParseHandlers::ignorableWhitespace(const XMLCh* const chars, const unsigned int length) {}
void PParseHandlers::resetDocument() {}

