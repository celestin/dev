/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 * Krakatau Metrics (metrics.exe)
 * Copyright (c) 2001,2008 SourceCodeMetrics.com
 * Author Craig McKay <craig.mckay@powersoftware.com>
 *
 * $Id$
 *
 * --------------------------------------------------------------------------------
 * ID  By    Date        Description
 * C01 CAM   27/09/2001  Put this line back in
 * D01 CAM   27/09/2001  Removed this line because NP no longer calculated
 *             based on PARAMETER links, but directly from PopulatePhase
 * --------------------------------------------------------------------------------
 * Who  When       Why
 * CAM  24-Jan-08  337 : Add to source control.
 * CAM  22-Feb-08  341 : Calculate CBO correctly.
 * CAM  26-Mar-08  338 : Calculate SEIMI correctly.
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

#include "MetricPhase.h"
using namespace metrics;
using namespace std;

#define LOG2 0.693147


/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 * Common Methods                                                                      *
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */


MetricPhase::MetricPhase()
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

  theStage = 0;
  theNoStages = 1;
}


MetricPhase::~MetricPhase()
{
}


int MetricPhase::getProgress()
{
  float ratio;

  LOCKMUTEX(progress_lock);
  ratio = theStage / theNoStages;
  UNLOCKMUTEX(progress_lock);

  return (int) (ratio * 100);
}


float MetricPhase::calc_Statements(SymbolNode& sn)
{
  float CDENS = 0;
  float NSTAT = 0;
  float control = theMetrics[MasterData::CONTROL_MET];
  float executable = theMetrics[MasterData::EXECUTABLE_MET];

  if (control>0)
    CDENS = (float) control / ((float) executable + (float) control);

  NSTAT = control + executable;

  sn.setMetric(MasterData::CDENS_MET, CDENS);
  sn.setMetric(MasterData::NSTAT_MET, NSTAT);
  return CDENS;
}


void MetricPhase::summariseFile(SymbolNode &fileNode)
{
  //MasterData::theLog << "FILE: " << fileNode.getName() << "[" << fileNode.getID() << "]" << endl;

  // Total Lines, Source lines and Comment lines this file and keep
  // running total for project
  float COM_RAT = 0;
  float TCOM_RAT = 0;

  // Gather Lines of code/comment for this file
  float LOC = theMetrics[MasterData::LOC_MET];
  float SLOC = theMetrics[MasterData::SLOC_MET];
  float CCOM = theMetrics[MasterData::CCOM_MET];
  float CPPCOM = theMetrics[MasterData::CPPCOM_MET];
#ifdef LANGUAGE_JAVA
  float JCOM = theMetrics[MasterData::JCOM_MET];
#endif
  //float COM = CCOM + CPPCOM;
  float COM = theMetrics[MasterData::COM_MET];
  float WLOC = LOC - (SLOC + COM);

  // Comment Ratio (comment lines / total lines of code) for this File
  if (LOC > 0)
    COM_RAT = COM / LOC;
  else
    COM_RAT = 0;

  // True Comment Ratio (comment liens / source lines of code) for this File
  if (SLOC > 0)
    TCOM_RAT = COM / SLOC;
  else
    TCOM_RAT = 0;

  fileNode.setMetric(MasterData::FILE_COM_RAT_MET, COM_RAT);
  fileNode.setMetric(MasterData::FILE_TCOM_RAT_MET, TCOM_RAT);
  fileNode.setMetric(MasterData::WLOC_MET, WLOC);

  theProjNode.incMetric(MasterData::LOC_MET, LOC);
  theProjNode.incMetric(MasterData::SLOC_MET, SLOC);
  theProjNode.incMetric(MasterData::CCOM_MET, CCOM);
  theProjNode.incMetric(MasterData::CPPCOM_MET, CPPCOM);
  theProjNode.incMetric(MasterData::WLOC_MET, WLOC);
#ifdef LANGUAGE_JAVA
  theProjNode.incMetric(MasterData::JCOM_MET, JCOM);
#endif
  theProjNode.incMetric(MasterData::COM_MET, COM);
  theProjNode.incMetric(MasterData::NSC_MET, theMetrics[MasterData::NSC_MET]);
}


void MetricPhase::initialiseProject()
{
  MasterData::theLog << "Init " << theProjNode.getName() << endl;

  theProjNode.setMetric(MasterData::LOC_MET, 0);
  theProjNode.setMetric(MasterData::SLOC_MET, 0);
  theProjNode.setMetric(MasterData::NSC_MET, 0);
  theProjNode.setMetric(MasterData::COM_MET, 0);
  theProjNode.setMetric(MasterData::CCOM_MET, 0);
  theProjNode.setMetric(MasterData::CPPCOM_MET, 0);
//  theProjNode.setMetric(MasterData::B_MET, 0);
#ifdef LANGUAGE_JAVA
  theProjNode.setMetric(MasterData::JCOM_MET, 0);
#endif
  theProjNode.setMetric(MasterData::WLOC_MET, 0);

  theProjNode.setMetric(MasterData::MHF_MET, 0);
  theProjNode.setMetric(MasterData::AHF_MET, 0);
  theProjNode.setMetric(MasterData::MIF_MET, 0);
  theProjNode.setMetric(MasterData::AIF_MET, 0);
  theProjNode.setMetric(MasterData::POF_MET, 0);
//  theProjNode.setMetric(MasterData::COF_MET, 0);
  theProjNode.setMetric(MasterData::HIER_MET, 0);
  theProjNode.setMetric(MasterData::AVPATHS_MET, 0);
  theProjNode.setMetric(MasterData::PROJDEPTH_MET, 0);
  theProjNode.setMetric(MasterData::PDIT_MET, 0);
  theProjNode.setMetric(MasterData::COM_RAT_MET, 0);
  theProjNode.setMetric(MasterData::TCOM_RAT_MET, 0);
  theProjNode.setMetric(MasterData::SEIMI_MET, 0);
  theProjNode.setMetric(MasterData::NCLASS_MET, 0);
#ifdef LANGUAGE_JAVA
  theProjNode.setMetric(MasterData::NINTER_MET, 0);
#endif
  theProjNode.setMetric(MasterData::NFILE_MET, 0);
  theProjNode.setMetric(MasterData::NMETH_MET, 0);
  theProjNode.setMetric(MasterData::NORC_MET, 0);
  theProjNode.setMetric(MasterData::ACLOC_MET, 0);
  theProjNode.setMetric(MasterData::AMLOC_MET, 0);
  theProjNode.setMetric(MasterData::P_CHG_LOC_MET, 0);
  theProjNode.setMetric(MasterData::P_DEL_LOC_MET, 0);
  theProjNode.setMetric(MasterData::P_INS_LOC_MET, 0);
#ifdef PM
  theProjNode.setMetric(MasterData::CHG_FILE_MET, 0);
  theProjNode.setMetric(MasterData::DEL_FILE_MET, 0);
  theProjNode.setMetric(MasterData::INS_FILE_MET, 0);

  theProjNode.setMetric(MasterData::CHG_CLASS_MET, 0);
  theProjNode.setMetric(MasterData::DEL_CLASS_MET, 0);
  theProjNode.setMetric(MasterData::INS_CLASS_MET, 0);

  theProjNode.setMetric(MasterData::CHG_METH_MET, 0);
  theProjNode.setMetric(MasterData::DEL_METH_MET, 0);
  theProjNode.setMetric(MasterData::INS_METH_MET, 0);
#endif
  theProjNode.setMetric(MasterData::SUMV_MET, 0);
  theProjNode.setMetric(MasterData::SUMVG_MET, 0);
}


#define ADD_METRIC(X) theProjNode.setMetric(X, projMetrics[X] + subMetrics[X])
void MetricPhase::addMetrics(SymbolNode &sub)
{
  float *projMetrics, *subMetrics;

  theProjNode.getMetrics(projMetrics);
  sub.getMetrics(subMetrics);

  if ((projMetrics != NULL) && (subMetrics != NULL))
  {
    /*projMetrics[MasterData::HIER_MET] += subMetrics[MasterData::HIER_MET];
    projMetrics[MasterData::AVPATHS_MET] += subMetrics[MasterData::AVPATHS_MET];
    projMetrics[MasterData::PROJDEPTH_MET] += subMetrics[MasterData::PROJDEPTH_MET]; */

    if (subMetrics[MasterData::PDIT_MET] > projMetrics[MasterData::PDIT_MET])
    {
      theProjNode.setMetric(MasterData::PDIT_MET, subMetrics[MasterData::PDIT_MET]);
    }

    ADD_METRIC(MasterData::LOC_MET);
    ADD_METRIC(MasterData::SLOC_MET);
    ADD_METRIC(MasterData::NSC_MET);
    ADD_METRIC(MasterData::COM_MET);
    ADD_METRIC(MasterData::CCOM_MET);
    ADD_METRIC(MasterData::CPPCOM_MET);
#ifdef LANGUAGE_JAVA
    ADD_METRIC(MasterData::JCOM_MET);
#endif
    ADD_METRIC(MasterData::WLOC_MET);


    ADD_METRIC(MasterData::NCLASS_MET);
#ifdef LANGUAGE_JAVA
    ADD_METRIC(MasterData::NINTER_MET);
#endif
    ADD_METRIC(MasterData::NFILE_MET);
    ADD_METRIC(MasterData::NMETH_MET);
    ADD_METRIC(MasterData::NORC_MET);
    ADD_METRIC(MasterData::ACLOC_MET);
    ADD_METRIC(MasterData::AMLOC_MET);
    ADD_METRIC(MasterData::P_CHG_LOC_MET);
    ADD_METRIC(MasterData::P_DEL_LOC_MET);
    ADD_METRIC(MasterData::P_INS_LOC_MET);
#ifdef PM
    ADD_METRIC(MasterData::CHG_FILE_MET);
    ADD_METRIC(MasterData::DEL_FILE_MET);
    ADD_METRIC(MasterData::INS_FILE_MET);

    ADD_METRIC(MasterData::CHG_CLASS_MET);
    ADD_METRIC(MasterData::DEL_CLASS_MET);
    ADD_METRIC(MasterData::INS_CLASS_MET);

    ADD_METRIC(MasterData::CHG_METH_MET);
    ADD_METRIC(MasterData::DEL_METH_MET);
    ADD_METRIC(MasterData::INS_METH_MET);
#endif
    ADD_METRIC(MasterData::SUMV_MET);
    ADD_METRIC(MasterData::SUMVG_MET);

    delete [] projMetrics;
    delete [] subMetrics;
  }
}


void MetricPhase::calculateMetrics(SymbolNode &node)
{
  nextStage();

  if (node.getCategoryID() == MasterData::METHOD_CAT)
  {
    //MasterData::theLog << "METHOD: " << node.getParent().getName() << "." <<
    //  node.getName() << "[" << node.getID() << "]" << endl;
    theProjNode.incMetric(MasterData::NMETH_MET);
    node.getMetrics(theMetrics);

    if (theMetrics != NULL)
    {
#ifdef PROFESSIONAL
      calc_NnVDE(node, true);
      //calc_QCP(node);
      calc_ECC(node);
      //calc_CALLS(node);
      calc_OAC(node);
      calc_Statements(node);
      calc_NP(node);
      calc_RLOC(node);
      calc_DEPTH(node);

      theProjNode.incMetric(MasterData::MLOC_MET,theMetrics[MasterData::LOC_MET]);

      node.setMetric(MasterData::DEPTH_MET, 1);
#else
      calc_Complexity(node);
      //calc_QCP(node);
      calc_Statements(node);
#endif

      delete [] theMetrics;
    }
  }
#ifdef LANGUAGE_JAVA
  else if (node.getCategoryID() == MasterData::PACKAGE_CAT)
  {
    node.setMetric(MasterData::PACK_NFILE_MET, node.childCount());
  }
#endif
  else if (node.getCategoryID() == MasterData::CLASS_CAT)
  {
    theProjNode.incMetric(MasterData::NCLASS_MET);
  }
#ifdef LANGUAGE_JAVA
  else if (node.getCategoryID() == MasterData::INTERFACE_CAT)
  {
    theProjNode.incMetric(MasterData::NINTER_MET);
  }
#endif
  else if (node.getCategoryID() == MasterData::FILE_CAT)
  {
    theProjNode.incMetric(MasterData::NFILE_MET);
    node.getMetrics(theMetrics);

    if (theMetrics != NULL)
    {
#ifdef PROFESSIONAL
//      calc_NnVDE(node, false);
      calc_NTopLevel(node);
#else
//      calc_Complexity(node);
#endif
      summariseFile(node);

      delete [] theMetrics;
    }
  }

  int c;
  for(c = 0; c < node.childCount(); c++)
  {
    SymbolNode nextChild = node.getChild(c);
    if (nextChild.getCategoryID() == MasterData::PROJECT_CAT)
    {
      // Subproject: add metrics to this project's metrics
      addMetrics(nextChild);
    }
    else
    {
      // Any other node: calculate
      calculateMetrics(nextChild);
    }
  }
}


void MetricPhase::calculateProjectAverages()
{
  // Total comments
  float COM_RAT = 0;
  float TCOM_RAT = 0;
  float LOC = theProjNode.getMetric(MasterData::LOC_MET);

  MasterData::theLog << theProjNode.getName() << " LOC=" << LOC << endl;

  float SLOC = theProjNode.getMetric(MasterData::SLOC_MET);
  float COM = theProjNode.getMetric(MasterData::COM_MET);

  // Comment Ratio (comment lines / total lines of code) for all Files
  if (LOC > 0)
    COM_RAT = COM / LOC;
  else
    COM_RAT = 0;

  // True Comment Ratio (comment liens / source lines of code) for all Files
  if (SLOC > 0)
    TCOM_RAT = COM / SLOC;
  else
    TCOM_RAT = 0;

  theProjNode.setMetric(MasterData::COM_RAT_MET, COM_RAT);
  theProjNode.setMetric(MasterData::TCOM_RAT_MET, TCOM_RAT);

  // Average LOC per Class and Method
#ifdef PROFESSIONAL
  float ACLOC = 0;
  float AMLOC = 0;
#ifdef LANGUAGE_CPP
//  theTLOC = 0;
#endif

  float numClasses = theProjNode.getMetric(MasterData::NCLASS_MET);
  float numMethods = theProjNode.getMetric(MasterData::NMETH_MET);

#ifdef LANGUAGE_CPP
  if (numClasses > 0) ACLOC = theProjNode.getMetric(MasterData::CLOC_MET) / numClasses;
#elif LANGUAGE_JAVA
  if (numClasses > 0) ACLOC = theProjNode.getMetric(MasterData::CLOC_MET) / numClasses;
#endif
  if (numMethods > 0) AMLOC = theProjNode.getMetric(MasterData::MLOC_MET) / numMethods;

  theProjNode.setMetric(MasterData::ACLOC_MET, ACLOC);
  theProjNode.setMetric(MasterData::AMLOC_MET, AMLOC);
#endif

  // Software Engineering Institute (SEI) Maintainability Index
  // Added by user request, this metric is designed to quantify
  // the maintainability of the code, based on Halstead &
  // Cyclomatic complexity.
  double SEIMI = 0;
  double aveLOC = 0;  // avg lines of code
  double perCM = 0; // avg percentage of lines of comments per module
  double NMETH = theProjNode.getMetric(MasterData::NMETH_MET);
  double sumV = theProjNode.getMetric(MasterData::SUMV_MET);
  double sumVg = theProjNode.getMetric(MasterData::SUMVG_MET);

  if ((NMETH > 0) && (sumV > 0) && (sumVg > 0))
  {
    sumV /= NMETH;
    sumVg /= NMETH;
    aveLOC = LOC / NMETH;
    perCM = COM_RAT / NMETH;

    SEIMI = 171 - 5.2 * log(sumV) - 0.23 * sumVg -
      16.2 * log(aveLOC) - 50 * sin(sqrt(2.4 * perCM));
  }

  theProjNode.setMetric(MasterData::SEIMI_MET, (float)SEIMI);
}

void MetricPhase::execute(RootNode *root)
{
  LOCKMUTEX(progress_lock);
  theRoot = root;

#ifdef PROFESSIONAL
//  theFieldV = theFieldTC = theMethodV = theMethodTC = 0;

#ifdef LANGUAGE_CPP
//  theTLOC = 0;
#endif

//  theInherAttrib = theTotalAttrib = theInherOp = theTotalOp = 0;
//  theOpsOver = theAddSub = 0;
//  theV = theVg = 0;
  theHIER = theDEPTH = theAVPATHS = 0;

  theNoStages = (theRoot->getNodeCount() * 2);
#else
  theNoStages = theRoot->getNodeCount();
#endif
  UNLOCKMUTEX(progress_lock);

  long symID=0;
  theProjNode = (*theRoot);
  SubprojectTree subs(theRoot);

  while (subs.getNextSub(symID))
  {
    if (theRoot->findSymbolNode(symID, theProjNode))
    {
      MasterData::theLog << "Subproject " << theProjNode.getName() << " [" << theProjNode.getID() << "]" << endl;
      initialiseProject();
      calculateMetrics(theProjNode);
#ifdef PROFESSIONAL
      calculateClassMetrics((*theRoot), false);
      calculateProjectMetrics();
#endif
      calculateProjectAverages();

    }
  }

  MasterData::theLog << "Finished MetricPhase::execute()" << endl;
}




/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 * PROFESSIONAL Metrics                                                                *
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

#ifdef PROFESSIONAL


float MetricPhase::calc_ECC(SymbolNode& sn)
{
  float oc = theMetrics[MasterData::OC_MET];
  float cyclo = theMetrics[MasterData::CYCLO_MET];
  float ecc = 0;

  if (cyclo>0)
    ecc = oc / cyclo;
  else
    ecc = 0;

  sn.setMetric(MasterData::ECC_MET, ecc);

  return ecc;
}


void MetricPhase::calc_NnVDE(SymbolNode& sn, bool isMethod)
{
  float N1 = theMetrics[MasterData::N1_MET];
  float N2 = theMetrics[MasterData::N2_MET];
  float n1 = theMetrics[MasterData::n1_MET];
  float n2 = theMetrics[MasterData::n2_MET];

  float N = N1 + N2;
  float n = n1 + n2;

  float V = 0;
  if (n > 0) V = N * (log(n) / LOG2 );

  float D = 0;
  if (n2 > 0) D = ( (double) n1 / 2 ) * ( (double) N2 / (double) n2 );

  float E = D * V;

  float B = ((float)pow((double)E, ((double)2/(double)3))) / (double)3000;

  if (isMethod) {
    float cyclo = theMetrics[MasterData::CYCLO_MET];
    theProjNode.incMetric(MasterData::SUMV_MET, V);
    theProjNode.incMetric(MasterData::SUMVG_MET, cyclo);
  }

  sn.setMetric(MasterData::N_MET, N);
  sn.setMetric(MasterData::n_MET, n);
  sn.setMetric(MasterData::V_MET, V);
  sn.setMetric(MasterData::D_MET, D);
  sn.setMetric(MasterData::E_MET, E);
  sn.setMetric(MasterData::B_MET, B);
}


float MetricPhase::calc_CALLS(SymbolNode& sn)
{
  float CALLS = sn.getOperationUsage();

  sn.setMetric(MasterData::CALLS_MET, CALLS);
  return CALLS;
}


float MetricPhase::calc_OAC(SymbolNode& sn)
{
  float OAC = 0;

  //TODO: Need parameter info

  sn.setMetric(MasterData::OAC_MET, OAC);
  return OAC;
}


void MetricPhase::calc_RLOC(SymbolNode &methodNode)
{
  // Relative Lines of Code (i.e. this Method LOC / total Class LOC)

  SymbolNode classNode = methodNode.getParent();
  float RLOC = 0;

  if (classNode.getCategoryID() == MasterData::CLASS_CAT)
  {
    float MLOC = theMetrics[MasterData::LOC_MET];
    float CLOC = classNode.getMetric(MasterData::LOC_MET);

    if (CLOC > 0) RLOC = MLOC / CLOC;
  }

  methodNode.setMetric(MasterData::RLOC_MET, RLOC);
}


void MetricPhase::buildDepthGauge(int depth, SymbolNode &method,
                  vector<DepthItem>& depthGauge)
{
  // Firstly create a DepthItem representing the current method node
  DepthItem current(method.getID(), depth);

  // Now check depthGauge vector for a deeper version of this method
  vector<DepthItem>::iterator gIter;
  for( gIter = depthGauge.begin(); gIter < depthGauge.end(); gIter++ )
  {
    if (gIter->deeper(current))
      return; // a deeper copy of this method exists - quit
  }

  // Proceed - add this method to the depthGauge
  depthGauge.push_back(current);

  // Now check current method's calls
  vector<Link> refs = method.getLinks(MasterData::XREF_LINK);
  vector<Link>::iterator r;
  SymbolNode next = method;

  for( r = refs.begin(); r < refs.end(); r++ )
  {
    if (r->getDestID() != method.getID())
    {
      if (method.findSymbolNode(r->getDestID(), next))
      {
        if (next.getCategoryID() == MasterData::METHOD_CAT)
        {
          buildDepthGauge(depth+1, next, depthGauge);
        }
      }
    }
  }
}

void MetricPhase::calc_DEPTH(SymbolNode& methodNode)
{
  float DEPTH = 1;

  /*  // TODO Fix Depth
  vector<DepthItem> depthGauge;

  // Firstly create a DepthItem representing the method node
  // for which we are calculating the Depth
  DepthItem current(methodNode.getID(), 0);
  depthGauge.push_back(current);

  // Now build depthGauge vector with all methods called by this method
  vector<Link> refs = methodNode.getLinks(MasterData::XREF_LINK);
  vector<Link>::iterator r;
  SymbolNode next = methodNode;

  for( r = refs.begin(); r < refs.end(); r++ )
    if ((methodNode.findSymbolNode(r->getDestID(), next)) &&
      (next.getCategoryID() == MasterData::METHOD_CAT) )
    {
      buildDepthGauge(1, next, depthGauge);
    }


  // Read off the deepest item in the gauge
  DepthItem deepest(0,0);
  vector<DepthItem>::iterator gIter;
  for( gIter = depthGauge.begin(); gIter < depthGauge.end(); gIter++ )
  {
    if ((*gIter) > deepest)
      deepest.sinkTo(*gIter);
  }

  DEPTH = deepest.theDepth;
  */

  methodNode.setMetric(MasterData::DEPTH_MET, DEPTH);
  theProjNode.incMetric(MasterData::HIER_MET, DEPTH);

  if (DEPTH > theProjNode.getMetric(MasterData::DEPTH_MET))
    theProjNode.setMetric(MasterData::DEPTH_MET, DEPTH);

  vector<long> visited;
  theProjNode.incMetric(MasterData::AVPATHS_MET, pathsFrom(methodNode, visited));
}


void MetricPhase::calc_QCP(SymbolNode& sn)
{
  float QCP_MAINT;
  float QCP_CRCT;
  float QCP_RLBTY;

  float branch = theMetrics[MasterData::BRANCH_MET];
  float CDENS = theMetrics[MasterData::CDENS_MET];
  float control = theMetrics[MasterData::CONTROL_MET];
  float cyclomatic = theMetrics[MasterData::CYCLO_MET];
  float D = theMetrics[MasterData::D_MET];
  float executable = theMetrics[MasterData::EXECUTABLE_MET];
  float N = theMetrics[MasterData::N_MET];
  float n = theMetrics[MasterData::n_MET];
  float nest = theMetrics[MasterData::NEST_MET];


  QCP_MAINT = (3*N) + executable + control + nest + (2*cyclomatic) + branch;
  QCP_CRCT = (float) D + control + executable + (2*cyclomatic);
  QCP_RLBTY = N + (2*nest) + (3*cyclomatic) + branch + control + executable + CDENS;

  sn.setMetric(MasterData::QCP_MAINT_MET, QCP_MAINT);
  sn.setMetric(MasterData::QCP_CRCT_MET, QCP_CRCT);
  sn.setMetric(MasterData::QCP_RLBTY_MET, QCP_RLBTY);
}


void MetricPhase::calc_NP(SymbolNode& sn)
{
  vector<Link> parameters = sn.getLinks(MasterData::PARAMETER_LINK);

  // D01 Begin --------------------------------------------
  //sn.setMetric(MasterData::NP_MET, parameters.size());
  // D01 End ----------------------------------------------
}


// =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=


void MetricPhase::calc_Members(SymbolNode &node)
{
  float CSA, CSO, CSAO, PPP, i;

  CSA = CSO = CSAO = PPP = i = 0;

  for( i = 0; i < node.childCount(); i++)
  {
    SymbolNode child = node.getChild(i);

    if (child.getCategoryID() == MasterData::FIELD_CAT)
    {
      CSA++;    // Inc. Attributes
    }
    else if (child.getCategoryID() == MasterData::METHOD_CAT)
    {
      CSO++;    // Inc. Operations
    }

    if (child.getProtectionID() != MasterData::PRIVATE_PROT)
    {
      PPP++;    // Inc. Package/Public/Protected
    }
  }

  CSAO = CSA + CSO;
  if (CSAO > 0) PPP = 100 * (PPP/CSAO);

  node.setMetric(MasterData::CSA_MET, CSA);
  node.setMetric(MasterData::CSO_MET, CSO);
  node.setMetric(MasterData::CSAO_MET, CSAO);
  node.setMetric(MasterData::PAPAPAPC_MET, PPP);
}


#ifdef LANGUAGE_JAVA
void MetricPhase::calc_InterfaceMembers(SymbolNode &node)
{
  float ISA, ISO, ISAO, PPP, i;

  ISA = ISO = ISAO = PPP = i = 0;

  for( i = 0; i < node.childCount(); i++)
  {
    SymbolNode child = node.getChild(i);

    if (child.getCategoryID() == MasterData::FIELD_CAT)
    {
      ISA++;    // Inc. Attributes
    }
    else if (child.getCategoryID() == MasterData::METHOD_CAT)
    {
      ISO++;    // Inc. Operations
    }

    if (child.getProtectionID() != MasterData::PRIVATE_PROT)
    {
      PPP++;    // Inc. Package/Public/Protected
    }
  }

  ISAO = ISA + ISO;
  if (ISAO > 0) PPP = 100 * (PPP/ISAO);

  node.setMetric(MasterData::ISA_MET, ISA);
  node.setMetric(MasterData::ISO_MET, ISO);
  node.setMetric(MasterData::ISAO_MET, ISAO);
  node.setMetric(MasterData::INTER_PAPAPAPC_MET, PPP);
}

void MetricPhase::calc_NOCI(SymbolNode &node)
{
  float NOCI = node.countLinks(MasterData::SUB_LINK);
  node.setMetric(MasterData::NOCI_MET, NOCI);
}
#endif


void MetricPhase::calc_NOCC(SymbolNode &node)
{
  float NOCC = node.countLinks(MasterData::SUB_LINK);
  node.setMetric(MasterData::NOCC_MET, NOCC);
}


int MetricPhase::determineDIT(SymbolNode &node)
{
  int largestDepth = 0;
  int thisDepth = 0;
  SymbolNode super = node;

  vector<Link> supers = node.getLinks(MasterData::SUPER_LINK);
  vector<Link>::iterator supiter;

  for( supiter = supers.begin(); supiter < supers.end(); supiter++)
  {
    if (node.findSymbolNode(supiter->getDestID(), super))
    {
      thisDepth = 1 + determineDIT(super);

      if (thisDepth > largestDepth) largestDepth = thisDepth;
    }
  }

  if ((largestDepth ==0) && (supers.size() > 0))
    return 1;
  else
    return largestDepth;
}


void MetricPhase::calc_DIT(SymbolNode &node)
{
  // Depth of Inheritence Tree
  // From the current class, traces up entire inheritence HIERarchy counting
  // which route is the longest

  double DIT = 0;
  int thisDepth = 0;
  SymbolNode super = node;

  vector<Link> supers = node.getLinks(MasterData::SUPER_LINK);
  vector<Link>::iterator supiter;

  for( supiter = supers.begin(); supiter < supers.end(); supiter++)
  {
    if (node.findSymbolNode(supiter->getDestID(), super))
    {
      thisDepth = 1 + determineDIT(super);

      if (thisDepth > DIT) DIT = thisDepth;
    }
  }

  float CSI = 0;

  float CSO = node.getMetric(MasterData::CSO_MET);
  float NOOC = node.getMetric(MasterData::NOOC_MET);

  if (CSO != 0) CSI = (NOOC * DIT) / CSO;

  if (DIT > theProjNode.getMetric(MasterData::PDIT_MET))
    theProjNode.setMetric(MasterData::PDIT_MET, DIT);

  node.setMetric(MasterData::DIT_MET, DIT);
  node.setMetric(MasterData::CSI_MET, CSI);
}


void MetricPhase::calc_RFC(SymbolNode &node)
{
  // RFC - Response For Class
  // Number of Methods in a class, plus the number of
  // distinct methods called by those methods

  float RFC = 0;
  SymbolNode method = node;
  int i;

  for(i = 0; i < node.childCount(); i++)
  {
    method = node.getChild(i);

    if (method.getCategoryID() == MasterData::METHOD_CAT)
    {
      // Incremenet for this child method
      RFC++;

      // Add unique method calls from child method
      RFC += method.countUniqueLinks(MasterData::XREF_LINK, MasterData::METHOD_CAT);
    }
  }

  node.setMetric(MasterData::RFC_MET, RFC);
}


void MetricPhase::calc_CBO(SymbolNode &node)
{
  // Coupling Between Object classes
  // To calculate CBO for a class, we find the number of unique
  // classes which are used as:
  // 1. Member variable types
  // 2. Method parameter types
  // 3. Method local variable types

  float CBO = 0;
  int i;
  list<long> types;
  list<long>::iterator iter;

  types = node.getUniqueTypesOfChildren(MasterData::FIELD_CAT, node.getID(), types);

  for( i = 0; i < node.childCount(); i++ )
  {
    SymbolNode child = node.getChild(i);

    if (child.getCategoryID() == MasterData::METHOD_CAT)
    {
      types = child.getUniqueTypesOfChildren(MasterData::FIELD_CAT, node.getID(), types);
    }
  }

  for( iter = types.begin(); iter != types.end(); iter++ )
  {
    if (MasterData::isUserType((*iter))) CBO++;
  }

  node.setMetric(MasterData::CBO_MET, CBO);
}

void MetricPhase::calc_LCOM(SymbolNode &node)
{
  // Lack of Cohesion in Methods
  // This metric quantifies how much intercourse the methods of a class
  // have with the member variables of that class

  MasterData::theLog << "Calling calc_LCOM(" << node.getName() << ")" << endl;
  char sql[512], charNumber[30];

  // If any of the queries fail return

  // Create the temporary table
  strcpy(sql,"drop table if exists lcom");
  if (!theRoot->executeResultlessQuery(sql)) return;
  //strcpy(sql,"create table if not exists lcom (symid int not null)");
  strcpy(sql,"create table if not exists lcom (methid int not null, fldid int not null)");
  if (!theRoot->executeResultlessQuery(sql)) return;

  // Build LCOM table
  strcpy(sql,"insert lcom select s1.symid as methid, s2.symid as fldid from symbol s1 inner join link lk on s1.symID = lk.symID inner join symbol s2 on s2.symID = lk.sym2ID where s1.symParentID=");
  strcat(sql, ltostr(node.getID(), charNumber, 30));
  strcat(sql," and s2.symParentID=");
  strcat(sql, ltostr(node.getID(), charNumber, 30));
  strcat(sql," and s2.catID=");
  strcat(sql, ltostr(MasterData::FIELD_CAT, charNumber, 30));
  strcat(sql," group by s1.symid,s2.symid");
  if (!theRoot->executeResultlessQuery(sql)) return;

  // Determine dimensions for 2D array representing method/field usage
  // Firstly, get the maximum number of references to a field from a method
  long thisflds=0, maxflds=0, methods=0;
  strcpy(sql,"select count(methid) as max from lcom group by methid");
  if (theRoot->executeQuery(sql))
  {
    methods = theRoot->rows();

    for(int r=0; r<methods; r++)
    {
      if (theRoot->longCell(r,0)>maxflds)
      {
        maxflds = theRoot->longCell(r,0);
      }
    }
  }
  else
  {
    return;
  }

  // If there are fewer than two methods, there can be no method pairs
  if (methods < 2) {
    node.setMetric(MasterData::LCOM_MET, 0);
    return;
  }

  // Now build the usage array
  long **usage = new long*[methods];

  strcpy(sql,"select methid, fldid from lcom order by methid,fldid");
  if (theRoot->executeQuery(sql))
  {
    long thismethod=-1, thisrow=-1, thiscol=1;

    for(int r=0; r<theRoot->rows(); r++)
    {
      if (thismethod != theRoot->longCell(r,0))
      {
        // New Method, therefore start a new
        // row in the table
        thismethod = theRoot->longCell(r,0);
        thisrow++;
        thiscol=1;

        usage[thisrow] = new long[maxflds+1];
        usage[thisrow][0] = 0;
      }

      // Now add the actual value into the column in the 2D array
      usage[thisrow][thiscol++] = theRoot->longCell(r,1);
      // Increment the size count (stored in the first column)
      usage[thisrow][0]++;
    }
  }
  else
  {
    delete [] usage;
    return;
  }

  int p=0, q=0;
  for(int m=0; m<methods; m++) {
    for(int n=m+1; n<methods; n++) {

      if (checkIntersection(usage[m], usage[n])) {
        q++;
      } else {
        p++;
      }
    }
  }

  if (p>q) {
    node.setMetric(MasterData::LCOM_MET, p - q);
  } else {
    node.setMetric(MasterData::LCOM_MET, 0);
  }

  // Memory management
  for (int i=0; i<methods; i++) {
    if (usage[i]) {
      delete [] usage[i];
    }
  }
  delete [] usage;
}


bool MetricPhase::checkIntersection(const long *a, const long *b)
{
  // The first element in the array is the size of the array
  // It is assumed that the arrays are in ascending order

  int alen = *a++;
  int blen = *b++;

  int an=0, bn=0;
  while (an<alen && bn<blen) {
    if (*a==*b)   return true;

    if (*a<*b)  { a++; an++; }
    else    { b++; bn++; }
  }

  return false;
}


void MetricPhase::traverseAddedEntities(SymbolNode &sn, long catID, int &added,
                    vector<string> &entities)
{
  int i, snChildCount = sn.childCount();
  SymbolNode child = sn;
  vector<string>::iterator iter;

  for(i = 0; i < snChildCount; i++)
  {
    child = sn.getChild(i);
    if (child.getCategoryID() == catID)
    {
      // Found an entity with correct category
      // Attempt to match it within entities list
      for(iter = entities.begin(); iter < entities.end(); iter++)
      {
        if (!iter->compare(child.getName()))
        {
          (*iter) = "";
          added--;
        }
      }
    }
  }

  // Repeat from super classes of this super
  SymbolNode super = sn;

  vector<Link> supers = sn.getLinks(MasterData::SUPER_LINK);
  vector<Link>::iterator supiter;
  for( supiter = supers.begin(); supiter < supers.end(); supiter++)
  {
    if (sn.findSymbolNode(supiter->getDestID(), super))
    {
      traverseAddedEntities(super, catID, added, entities);
    }
  }
}


int MetricPhase::countAddedEntities(SymbolNode &sn, long catID)
{
  int added, i, snChildCount = sn.childCount();
  SymbolNode child = sn;
  vector<string> entities;

  for(i = 0; i < snChildCount; i++)
  {
    child = sn.getChild(i);
    if (child.getCategoryID() == catID)
    {
      // Found an entity with correct category
      // Add it to list of entities
      entities.push_back(child.getName());
    }
  }

  added = entities.size();

  // Now attempt to locate entities which have been inherited from
  // super classes, and reduce the "added" count until it represents
  // entities which have actually been added at this class level
  SymbolNode super = sn;
  vector<Link> supers = sn.getLinks(MasterData::SUPER_LINK);
  vector<Link>::iterator supiter;
  for( supiter = supers.begin(); supiter < supers.end(); supiter++)
  {
    if (sn.findSymbolNode(supiter->getDestID(), super))
    {
      traverseAddedEntities(super, catID, added, entities);
    }
  }

  return added;
}


void MetricPhase::traverseInherited(SymbolNode &node, long catID, int &inherited)
{
  vector<Link> supers = node.getLinks(MasterData::SUPER_LINK);
  vector<Link>::iterator iter;
  SymbolNode superNode = node;

  for(iter = supers.begin(); iter < supers.end(); iter++)
  {
    if (node.findSymbolNode(iter->getDestID(), superNode))
    {
      int i, superNodeChildCount = superNode.childCount();

      for(i = 0; i < superNodeChildCount; i++)
      {
        SymbolNode child = superNode.getChild(i);

        if (child.getCategoryID() == catID) inherited++;
      }

      traverseInherited(superNode, catID, inherited);
    }
  }
}


int MetricPhase::countInherited(SymbolNode &node, long catID)
{
  vector<Link> supers = node.getLinks(MasterData::SUPER_LINK);
  vector<Link>::iterator iter;
  SymbolNode superNode = node;
  int inherited = 0;

  for(iter = supers.begin(); iter < supers.end(); iter++)
  {
    if (node.findSymbolNode(iter->getDestID(), superNode))
    {
      int i, superNodeChildCount = superNode.childCount();

      for(i = 0; i < superNodeChildCount; i++)
      {
        SymbolNode child = superNode.getChild(i);

        if (child.getCategoryID() == catID) inherited++;
      }

      traverseInherited(superNode, catID, inherited);
    }
  }

  return inherited;
}


void MetricPhase::calc_Inheritence(SymbolNode &node)
{
  float CSO = node.getMetric(MasterData::CSO_MET);
  float CSA = node.getMetric(MasterData::CSA_MET);

  float NOAC = countAddedEntities(node, MasterData::METHOD_CAT);  // Added Operations
  float NAAC = countAddedEntities(node, MasterData::FIELD_CAT); // Added Attributes
  float NOOC = CSO - NOAC;  // Overridden Operations
  float NOIC = countInherited(node, MasterData::METHOD_CAT);  // Inherited Operations
  float NAIC = countInherited(node, MasterData::FIELD_CAT); // Inherited Attributes

  node.setMetric(MasterData::NOAC_MET, NOAC);
  node.setMetric(MasterData::NAAC_MET, NAAC);
  node.setMetric(MasterData::NOOC_MET, NOOC);
  node.setMetric(MasterData::NOIC_MET, NOIC);
  node.setMetric(MasterData::NAIC_MET, NAIC);

  // Keep running totals for Project Metrics

  // 04-12-2001 SJW
  // Changed from :
  //
  // theInherAttrib += NAIC;
  // theTotalAttrib += (NAIC + NAAC);
  // theInherOp += NOIC;
  // theTotalOp += (NOIC + NOAC);
  //
  // to:
  //
  theProjNode.incMetric(MasterData::SUM_INH_ATT_MET, NAIC);
  theProjNode.incMetric(MasterData::SUM_INH_ATT_TOT_MET, CSA);
  theProjNode.incMetric(MasterData::SUM_INH_OP_MET, NOIC);
  theProjNode.incMetric(MasterData::SUM_INH_OP_TOT_MET, CSO);

  // 04-12-2001 SJW
  // Changed from :
  //
  // theOpsOver += NOOC;
  // theAddSub += NOAC * node.countSubclasses();
  //
  // to:
  //
  theProjNode.incMetric(MasterData::SUM_OV_OP_MET, NOOC);
  theProjNode.incMetric(MasterData::SUM_ADD_SUB_MET, NOAC * node.countSubclasses());

}


void MetricPhase::calc_WMC(SymbolNode &node)
{
  // Weighted Methods in Class
  // Total Halstead Cyclomatic Complexity for
  // all methods of the class

  float WMC = 0;
  float OSavg = 0;
  float NPavgC = 0;
  float nMethods = 0;
  float params = 0;
#ifdef LANGUAGE_CPP
  float TLOC = node.getMetric(MasterData::LOC_MET);
#endif
  SymbolNode method = node;
  int i;

  for(i = 0; i < node.childCount(); i++)
  {
    method = node.getChild(i);

    if (method.getCategoryID() == MasterData::METHOD_CAT)
    {
      WMC += method.getMetric(MasterData::CYCLO_MET);
      nMethods++;
      // C01 Begin ------------------------------------
      params += method.getMetric(MasterData::NP_MET);
      // C01 End --------------------------------------

#ifdef LANGUAGE_CPP
      TLOC += method.getMetric(MasterData::LOC_MET);
#endif
    }
  }

  if (nMethods)
  {
    OSavg = WMC / nMethods;
    NPavgC = params / nMethods;
  }

  node.setMetric(MasterData::WMC_MET, WMC);
  node.setMetric(MasterData::OSavg_MET, OSavg);
  node.setMetric(MasterData::NPavgC_MET, NPavgC);
#ifdef LANGUAGE_CPP
  node.setMetric(MasterData::TLOC_MET, TLOC);
#endif
}


void MetricPhase::calc_PA(SymbolNode &node)
{
  float PA = 0;
  SymbolNode child = node;
  int i;

  for( i = 0; i < node.childCount(); i++)
  {
    child = node.getChild(i);
    if ((child.getCategoryID() == MasterData::FIELD_CAT) &&
      (child.getProtectionID() != MasterData::PRIVATE_PROT))
    {
      PA += child.getAttributeUsage();
    }
  }

  node.setMetric(MasterData::PA_MET, PA);
}


void MetricPhase::calc_AC(SymbolNode &node)
{
  float AC = 0;
  SymbolNode child = node;
  int i;

  for( i = 0; i < node.childCount(); i++)
  {
    child = node.getChild(i);
    if ((child.getCategoryID() == MasterData::FIELD_CAT))
    {
      AC += child.getID(); //TODO: Determine complexity
    }
  }

  node.setMetric(MasterData::AC_MET, AC);
}


float MetricPhase::calc_V(SymbolNode &node)
{
  // V is sum of "visibilities" of node (either method / field)
  // for all classes over one less than the number of classes

  int protection = node.getProtectionID();

  if (protection == MasterData::PRIVATE_PROT)
  {
    return 1;
  }
  else if (protection == MasterData::PUBLIC_PROT)
  {
    return 0;
  }
  else if (protection == MasterData::PROTECTED_PROT)
  {
    float numClasses = theProjNode.getMetric(MasterData::NCLASS_MET);
    float inheritenceTreeSize = theProjNode.getMetric(MasterData::INH_MET);

    if (numClasses > 1)
    {
      return (float) ((float) 1 - ( inheritenceTreeSize /
                  // ------------------------------
                    (float) (numClasses - 1)));
    }
    else
    {
      return 0;
    }
  }

  return 0;
}


void MetricPhase::calc_InheritenceTreeSize(SymbolNode &classNode)
{
  vector<Link> subs = classNode.getLinks(MasterData::SUB_LINK);
  SymbolNode subNode = classNode;
  int numSubs = subs.size();

  if (numSubs == 0) return;

  theProjNode.incMetric(MasterData::INH_MET,numSubs);

  vector<Link>::iterator iter;
  for(iter = subs.begin(); iter < subs.end(); iter++)
  {
    if (theRoot->findSymbolNode(iter->getDestID(), subNode))
    {
      calc_InheritenceTreeSize(subNode);
    }
  }
}


void MetricPhase::calculateClassMetrics(SymbolNode &node, bool classMember)
{
  bool parentIsClass = false;
  nextStage();

  if (node.getCategoryID() == MasterData::CLASS_CAT)
  {
    //MasterData::theLog << "CLASS: " << node.getName() << "[" << node.getID() << "]" << endl;
    node.getMetrics(theMetrics);

    calc_Members(node);
    calc_Inheritence(node);
    calc_NOCC(node);
    calc_DIT(node);
    calc_RFC(node);
    calc_CBO(node);
    calc_LCOM(node);
    calc_WMC(node);
    calc_PA(node);

#ifdef LANGUAGE_CPP
    theProjNode.incMetric(MasterData::CLOC_MET,node.getMetric(MasterData::TLOC_MET));
#elif LANGUAGE_JAVA
    theProjNode.incMetric(MasterData::CLOC_MET,node.getMetric(MasterData::LOC_MET));
#endif

//    theInheritenceTreeSize = 0;
    calc_InheritenceTreeSize(node);

    parentIsClass = true;

    delete [] theMetrics;
  }
#ifdef LANGUAGE_JAVA
  else if (node.getCategoryID() == MasterData::INTERFACE_CAT)
  {
    node.getMetrics(theMetrics);

    calc_InterfaceMembers(node);
    calc_NOCI(node);

    delete [] theMetrics;
  }
#endif
  else if (classMember)
  {
    // This Node is class member - Field or Method
    // Keep running total of "V" and the number class members
    if (node.getCategoryID() == MasterData::FIELD_CAT)
    {
      theProjNode.incMetric(MasterData::FIELDV_MET,calc_V(node));
//      theFieldV += calc_V(node);
      theProjNode.incMetric(MasterData::FIELDTC_MET);
//      theFieldTC++;
    }
    else if (node.getCategoryID() == MasterData::METHOD_CAT)
    {
      theProjNode.incMetric(MasterData::METHODV_MET,calc_V(node));
//      theMethodV += calc_V(node);
      theProjNode.incMetric(MasterData::METHODTC_MET);
//      theMethodTC++;
    }
  }

  int c;
  for(c = 0; c < node.childCount(); c++)
  {
    SymbolNode nextChild = node.getChild(c);
    calculateClassMetrics(nextChild, parentIsClass);
  }
}


void MetricPhase::calc_NTopLevel(SymbolNode &fileNode)
{
  float NTC = 0;
#ifdef LANGUAGE_CPP
  float NTM = 0;
#elif LANGUAGE_JAVA
  float NTI = 0;
#endif

  SymbolNode child = fileNode;
  int i;

  for( i = 0; i < fileNode.childCount(); i++)
  {
    child = fileNode.getChild(i);
    if ((child.getCategoryID() == MasterData::CLASS_CAT))
    {
      NTC++;
    }
#ifdef LANGUAGE_CPP
    else if ((child.getCategoryID() == MasterData::METHOD_CAT))
    {
      NTM++;
    }
#elif LANGUAGE_JAVA
    else if ((child.getCategoryID() == MasterData::INTERFACE_CAT))
    {
      NTI++;
    }
#endif
  }

  fileNode.setMetric(MasterData::NTC_MET, NTC);
#ifdef LANGUAGE_CPP
  fileNode.setMetric(MasterData::NTM_MET, NTM);
#elif LANGUAGE_JAVA
  fileNode.setMetric(MasterData::NTI_MET, NTI);
#endif
}



void MetricPhase::calc_HidingFactors()
{
  float AHF = 0;
  float MHF = 0;

  float fieldV = theProjNode.getMetric(MasterData::FIELDV_MET);
  float fieldTC = theProjNode.getMetric(MasterData::FIELDTC_MET);
  float methodV = theProjNode.getMetric(MasterData::METHODV_MET);
  float methodTC = theProjNode.getMetric(MasterData::METHODTC_MET);

  if (fieldTC > 0) AHF = fieldV / fieldTC;
  if (methodTC > 0) MHF = methodV / methodTC;

  theProjNode.setMetric(MasterData::AHF_MET, AHF);
  theProjNode.setMetric(MasterData::MHF_MET, MHF);
}


void MetricPhase::calc_InheritenceFactors()
{
  float MIF = 0;
  float AIF = 0;

  float inherAttrib = theProjNode.getMetric(MasterData::SUM_INH_ATT_MET);
  float totalAttrib = theProjNode.getMetric(MasterData::SUM_INH_ATT_TOT_MET);
  float inherOp = theProjNode.getMetric(MasterData::SUM_INH_OP_MET);
  float totalOp = theProjNode.getMetric(MasterData::SUM_INH_OP_TOT_MET);

  if (totalAttrib > 0)
    AIF = inherAttrib / totalAttrib;
  else
    AIF = 0;

  if (totalOp > 0)
    MIF = inherOp / totalOp;
  else
    MIF = 0;

  theProjNode.setMetric(MasterData::AIF_MET, AIF);
  theProjNode.setMetric(MasterData::MIF_MET, MIF);
}


void MetricPhase::calc_POF()
{
  // Polymorphism Factor
  float POF = 0;

  float opsOver = theProjNode.getMetric(MasterData::SUM_OV_OP_MET);
  float addSub = theProjNode.getMetric(MasterData::SUM_ADD_SUB_MET);

  if (addSub > 0) POF = opsOver / addSub;

  theProjNode.setMetric(MasterData::POF_MET, POF);
}


int MetricPhase::pathsFrom(SymbolNode &method, vector<long> &visited)
{
  vector<Link> calls = method.getLinks(MasterData::XREF_LINK);
  int paths = 0;

  // If no calls from this method, just count this method call itself
  if (calls.size() == 0) return 1;

  int i;
  for(i = 0; i < visited.size(); i++)
  {
    if (method.getID() == visited[i])
    {
      // This method already exists in the visited list -
      // return now to prevent infinite recursion
      return 1;
    }
  }

  SymbolNode methodCall = method;
  // Otherwise, look down the paths from this method
  for(i = 0; i < calls.size(); i++)
  {
    if (method.findSymbolNode(calls[i].getDestID(), methodCall))
    {
      if (methodCall.getCategoryID() == MasterData::METHOD_CAT)
      {
        visited.push_back(method.getID());
        paths += pathsFrom(methodCall, visited);
      }
    }
  }

  if (paths == 0) return 1;

  return paths;
}


int MetricPhase::countUniqueWithLinks(long lktID)
{
  // Count the distinct number of Symbols that have
  // at least one Link of the specified type
  char sql[512], charNumber[30];

  strcpy(sql,"select count(distinct symID) from link where lktID=");
  strcat(sql, ltostr(lktID, charNumber, 30));


  try
  {
    if (theRoot->executeQuery(sql))
    {
      return theRoot->longCell(0,0);
    }
  }
  catch (...)
  {
    MasterData::theLog << "SymbolNode::countUniqueWithLinks() - Error executing query!" << endl;
  }

  return 0;
}


void MetricPhase::calc_ProjectDepth()
{
  // Calculate the DEPTH (i.e. the deepest extent of method calls in
  // entire project), HIERARCHY (i.e. total of methods depths over
  // the number of methods) and AVPATHS (number and size of paths from
  // all methods)
  int numMethodsWithXrefs = countUniqueWithLinks(MasterData::XREF_LINK);

  float numMethods = theProjNode.getMetric(MasterData::NMETH_MET);
  if (numMethods > 0) theHIER /= numMethods;
  if (numMethodsWithXrefs > 0) theAVPATHS /= numMethodsWithXrefs;

  theProjNode.setMetric(MasterData::HIER_MET, theHIER);
  theProjNode.setMetric(MasterData::DEPTH_MET, theDEPTH);
  theProjNode.setMetric(MasterData::AVPATHS_MET, theAVPATHS);
}


void MetricPhase::calc_NORC()
{
  try
  {
    theRoot->executeResultlessQuery("drop table if exists tmpsymbol");
    theRoot->executeResultlessQuery("create table if not exists tmpsymbol (symID int not null)");
    theRoot->executeResultlessQuery("insert tmpsymbol select s.symID from symbol s left outer join link l on s.symID = l.symID where l.lktID = 2 and s.catID = 5");

    if (theRoot->executeQuery("select count(distinct r.symID) from symbol r left join tmpsymbol t on r.symID = t.symID where r.catID = 5 and t.symID is null"))
    {
      float rootClasses = theRoot->longCell(0,0);
      theProjNode.setMetric(MasterData::NORC_MET, rootClasses);
    }

    theRoot->executeResultlessQuery("drop table if exists tmpsymbol");
  }
  catch (...)
  {
    MasterData::theLog << "MetricPhase::calc_NORC() - Error executing query" << endl;
  }
}


#ifdef LANGUAGE_JAVA
void MetricPhase::calc_PACK_NORC(SymbolNode &node)
{
  try
  {
    theRoot->executeResultlessQuery("drop table if exists tmpsymbol");
    theRoot->executeResultlessQuery("create table if not exists tmpsymbol (symID int not null)");
    theRoot->executeResultlessQuery("insert tmpsymbol select s.symID from symbol s left outer join link l on s.symID = l.symID where l.lktID = 2 and s.catID = 5");

    char sql[512];
    char charNumber[30];

    strcpy(sql,"select count(distinct r.symID) from symbol r left join tmpsymbol t on r.symID = t.symID where r.catID = 5 and t.symID is null and r.symParentID=");
    strcat(sql, ltostr(node.getID(), charNumber, 30));

    if (theRoot->executeQuery(sql))
    {
      float rootClasses = theRoot->longCell(0,0);
      node.setMetric(MasterData::PACK_NTC_MET, rootClasses);
    }

    theRoot->executeResultlessQuery("drop table if exists tmpsymbol");
    theRoot->executeResultlessQuery("create table if not exists tmpsymbol (symID int not null)");
    theRoot->executeResultlessQuery("insert tmpsymbol select s.symID from symbol s left outer join link l on s.symID = l.symID where l.lktID = 2 and s.catID = 6");

    strcpy(sql,"select count(distinct r.symID) from symbol r left join tmpsymbol t on r.symID = t.symID where r.catID = 5 and t.symID is null and r.symParentID=");
    strcat(sql, ltostr(node.getID(), charNumber, 30));

    if (theRoot->executeQuery(sql))
    {
      float rootClasses = theRoot->longCell(0,0);
      node.setMetric(MasterData::PACK_NTI_MET, rootClasses);
    }

    theRoot->executeResultlessQuery("drop table if exists tmpsymbol");
  }
  catch (...)
  {
    MasterData::theLog << "MetricPhase::calc_NORC() - Error executing query" << endl;
  }
}
#endif


void MetricPhase::calculateProjectMetrics()
{
  calc_HidingFactors();
  calc_InheritenceFactors();
  calc_POF();
  calc_ProjectDepth();
  calc_NORC();
}

// =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

#else

/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 * LITE / PM Metrics                                                                   *
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */


extern MasterData *md;

void MetricPhase::calc_Complexity(SymbolNode& sn)
{
  float N1 = theMetrics[MasterData::N1_MET];
  float N2 = theMetrics[MasterData::N2_MET];
  float n1 = theMetrics[MasterData::n1_MET];
  float n2 = theMetrics[MasterData::n2_MET];
  float oc = theMetrics[MasterData::OC_MET];
  float cyclo = theMetrics[MasterData::CYCLO_MET];

  double N = N1 + N2;
  double n = n1 + n2;

  float V;
  if (n > 0)
    V = N * (log(n) / log((double)2));
  else
    V = 0;

  float D;
  if (n2 > 0)
    D = ( (double) n1 / 2 ) * ( (double) N2 / (double) n2 );
  else
    D = 0;

  float E;
  E = D * V;

  float ecc = 0;
  if (cyclo>0)
    ecc = oc / cyclo;
  else
    ecc = 0;

  theProjNode.incMetric(MasterData::SUMV_MET, V);
  theProjNode.incMetric(MasterData::SUMVG_MET, cyclo);

  sn.setMetric(MasterData::N_MET, N);
  sn.setMetric(MasterData::n_MET, n);
  sn.setMetric(MasterData::V_MET, V);
  sn.setMetric(MasterData::D_MET, D);
  sn.setMetric(MasterData::E_MET, E);
  sn.setMetric(MasterData::ECC_MET, ecc);
}

void MetricPhase::calc_QCP(SymbolNode& sn)
{
  float QCP_MAINT;
  float QCP_CRCT;
  float QCP_RLBTY;

  float branch = theMetrics[MasterData::BRANCH_MET];
  float CDENS = theMetrics[MasterData::CDENS_MET];
  float control = theMetrics[MasterData::CONTROL_MET];
  float cyclomatic = theMetrics[MasterData::CYCLO_MET];
  float D = theMetrics[MasterData::D_MET];
  float executable = theMetrics[MasterData::EXECUTABLE_MET];
  float N = theMetrics[MasterData::N_MET];
  float n = theMetrics[MasterData::n_MET];
  float nest = theMetrics[MasterData::NEST_MET];

  QCP_MAINT = (3*N) + executable + control + nest + (2*cyclomatic) + branch;
  QCP_CRCT = (float) D + control + executable + (2*cyclomatic);
  QCP_RLBTY = N + (2*nest) + (3*cyclomatic) + branch + control + executable + CDENS;

  sn.setMetric(MasterData::QCP_MAINT_MET, QCP_MAINT);
  sn.setMetric(MasterData::QCP_CRCT_MET, QCP_CRCT);
  sn.setMetric(MasterData::QCP_RLBTY_MET, QCP_RLBTY);
}

// =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

#endif