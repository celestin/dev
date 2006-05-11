/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 * Essential Project Manager (EPM)
 * Copyright (c) 2004-2006 Power Software
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * PParseHandlers - XML Configuration File Parser
 *
 * $Id: $
 *
 * Who  When       Why
 * CAM  16-Aug-05  File added.
 * CAM  06-Jan-06  168 : Added Metrics Sets.
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

#include    <xercesc/sax/HandlerBase.hpp>
#include    "Extension.h"
#include    "MetricSet.h"
#include    "XMLConfig.h"

XERCES_CPP_NAMESPACE_USE

class PParseHandlers : public HandlerBase
{
public :
  PParseHandlers();
  ~PParseHandlers();

  bool isError() const;
  int getError() const;

  void startElement(const XMLCh* const name, AttributeList& attributes);
  void characters(const XMLCh* const chars, const unsigned int length);
  void ignorableWhitespace(const XMLCh* const chars, const unsigned int length);
  void resetDocument();

  Extension* getExtension() { return fExt; }
  MetricSet* getMetricSet() { return fMet; }

  void warning(const SAXParseException& exc);
  void error(const SAXParseException& exc);
  void fatalError(const SAXParseException& exc);

private:
  char            *fLocalForm;
  Extension       *fExt;
  MetricSet       *fMet;

};

