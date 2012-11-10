/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 * Krakatau Metrics (metrics.exe)
 * Copyright (c) 2001,2008 SourceCodeMetrics.com
 * Author Craig McKay <craig.mckay@powersoftware.com>
 *
 * $Id$
 *
 * Who  When       Why
 * CAM  24-Jan-08  337 : Add to source control.
 * CAM  22-Jan-08  341 : Added classID to getUniqueTypesOfChildren to ensure we don't return the parent class.
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

#ifndef METRICS_SYMBOLNODE
#define METRICS_SYMBOLNODE

#include <list>
#include <map>
#include <vector>

#include "AutoNumber.h"
#include "MasterData.h"
#include "TreeHelper.h"
#include "Link.h"
//#include "Cache.h"
#include "Node.h"

#include <stdlib.h>
//#include "Symbol.h"

// Width of Symbol.QName & SymbolXtra.QName columns
#define COLW_QNAME_SHORT 255
#define COLW_QNAME_EXTRA 4096
#define NLINKTYPES 8

namespace metrics
{

	class SymbolNode : public Node
	{
	private:

//		SymbolNode *actualNode ;
		Links theLinks ;

	protected:

		//friend class Cache ;

		float *theMetrics ;			// Metric data
		char *theMetricsDirty ;		// Array of (char) flags:
									//  Have any Metrics changed?

		TreeHelper *theTreeHelper ;

		static const char MET_DIRTY_TRUE ;
		static const char MET_DIRTY_FALSE ;

		long theParentID ;
		std::vector<long> theChildren ;

		bool theIsRoot ;

		//long theID ;			// This Symbol ID
		std::string theName;	// Symbol Name
		long theTypeID;			// Symbol Type (i.e. data type, return value)
		//long theCatID;			// Symbol Cagegory (e.g. METHOD, CLASS)
		long theProtectionID;	// Symbol Protection Level (e.g. Public, Private)

		bool theDirty ;			// Has the data changed since the last write to the db?
		bool theFirstTime ;		// Is this the first time the data has been written?
		bool theWritten ;

		//static Cache theCache ;

//		bool theAdded ;
		bool theActual ;

		SymbolNode(long newID, long newParentID, std::vector<long> newChildren) ;
		SymbolNode(long newID, bool unused) ;

		virtual SymbolNode *getSymbolNode(long ID) ;
		SymbolNode *read(long ID) ;
		SymbolNode *find(SymbolNode *scope, long catID, std::string objName) ;

		void traverseAllOfCategory(long, bool, std::vector<long>&) ;


		// Protected Metrics Methods
		void checkMetrics() ;
		void clearMetricsDirty() ;

		// Actions
		void write() ;
		void read() ;
		void erase() ;
		void removeChildren() ;
		std::string formSqlInsert() ;
		std::string formSqlUpdate() ;

		void addChild(long childID) ;
		long getChildID(int i) { return theChildren[i] ; }

		//void initLinks() ;		// Initialise array
		//void clearLinks() ;		// Remove all links vectors
		void readLinks() ;		// Read the links vectors from DB

		// Old Constructors moved to protected to aid debugging

/*		SymbolNode() // Default Constructor
		{
			 // theID = theAutoNumber.newID() ;
			theID = theTreeHelper.newID() ;

			theActual = false ;
			theIsRoot = false ;

			SymbolNode *actualNode = theCache.get(theID) ;
			if (!actualNode)
			{
				actualNode = new SymbolNode(theID, false) ;	// bool used to distinguish
				theCache.add(theID, actualNode) ;	// Node(long theID) and Node(long catID)
			}
		}


		SymbolNode(string newName, long newCatID)
		{
			//theID = theAutoNumber.newID() ;
			theID = theTreeHelper.newID() ;

			theActual = false ;
			theIsRoot = false ;

			SymbolNode *actualNode = theCache.get(theID) ;
			if (!actualNode)
			{
				actualNode = new SymbolNode(theID, false) ;	// see explan. of bool above
				actualNode->theName = newName ;
				actualNode->theCatID = newCatID ;
				theCache.add(theID, actualNode) ;
			}
		}


		SymbolNode(long newCatID)
		{
			//theID = theAutoNumber.newID() ;
			theID = theTreeHelper.newID() ;

			theActual = false ;
			theIsRoot = false ;

			SymbolNode *actualNode = theCache.get(theID) ;
			if (!actualNode)
			{
				actualNode = new SymbolNode(theID, false) ;	// see explan. of bool above
				actualNode->theCatID = newCatID ;
				theCache.add(theID, actualNode) ;
			}
		}*/


	public:

		// Housekeeping

		bool theAdded ;

		SymbolNode()
		{
			theID = -1 ;

			theActual = false ;
			theIsRoot = false ;
		}


		SymbolNode(TreeHelper *newTreeHelper)
		{
			theTreeHelper = newTreeHelper ;

			 // theID = theAutoNumber.newID() ;
			theID = theTreeHelper->newID() ;

			theActual = false ;
			theIsRoot = false ;

			//SymbolNode *actualNode = dynamic_cast<SymbolNode*> (theCache.get(theID)) ;
			SymbolNode *actualNode ;/* = dynamic_cast<SymbolNode*> (theTreeHelper->get(theID)) ;
			if (!actualNode)
			{*/
				actualNode = new SymbolNode(theID, false) ;	// bool used to distinguish
				actualNode->theNReferences = 1;
				actualNode->theTreeHelper = theTreeHelper ;
				//theCache.add(theID, actualNode) ;
				theTreeHelper->add(theID, actualNode) ;
			//}
		}


		SymbolNode(TreeHelper *newTreeHelper, std::string newName, long newCatID) : theName("")
		{
			theTreeHelper = newTreeHelper ;

			//theID = theAutoNumber.newID() ;
			theID = theTreeHelper->newID() ;

			theActual = false ;
			theIsRoot = false ;

			//SymbolNode *actualNode = dynamic_cast<SymbolNode*> (theCache.get(theID)) ;
			SymbolNode *actualNode ;/*= dynamic_cast<SymbolNode*> (theTreeHelper->get(theID)) ;
			if (!actualNode)
			{*/
				actualNode = new SymbolNode(theID, false) ;	// see explan. of bool above
				actualNode->theNReferences = 1;
				actualNode->theName = newName ;
				actualNode->theCatID = newCatID ;
				actualNode->theTreeHelper = theTreeHelper ;
				//theCache.add(theID, actualNode) ;
				theTreeHelper->add(theID, actualNode) ;
			//}
		}


		SymbolNode(TreeHelper *newTreeHelper, long newCatID)
		{
			theTreeHelper = newTreeHelper ;

			//theID = theAutoNumber.newID() ;
			theID = theTreeHelper->newID() ;

			theActual = false ;
			theIsRoot = false ;

			//SymbolNode *actualNode = dynamic_cast<SymbolNode*> (theCache.get(theID)) ;
			SymbolNode *actualNode ;/*= dynamic_cast<SymbolNode*> (theTreeHelper->get(theID)) ;
			if (!actualNode)
			{*/
				actualNode = new SymbolNode(theID, false) ;	// see explan. of bool above
				actualNode->theNReferences = 1;
				actualNode->theCatID = newCatID ;
				actualNode->theTreeHelper = theTreeHelper ;
				//theCache.add(theID, actualNode) ;
				theTreeHelper->add(theID, actualNode) ;
			//}
		}

		SymbolNode::SymbolNode(const SymbolNode& rhs)
		{
			theTreeHelper = rhs.theTreeHelper ;

			theID = rhs.theID ;
			theActual = false ;
			theIsRoot = rhs.theIsRoot ;

			SymbolNode *actualNode = getSymbolNode(theID) ;
			actualNode->theNReferences++ ;
		}

		virtual ~SymbolNode() ;


		// Operators
		virtual SymbolNode& operator=(const SymbolNode& rhs)
		{
			theID = rhs.theID ;
			theActual = false ;
			theIsRoot = rhs.theIsRoot ;

			theTreeHelper = rhs.theTreeHelper ;

			SymbolNode *actualNode = getSymbolNode(theID) ;
			actualNode->theNReferences++ ;

			return (*this) ;
		}

		virtual bool operator==(const SymbolNode& rhs) { return (theID == rhs.theID) ; }
		virtual bool operator!=(const SymbolNode& rhs) { return (theID != rhs.theID) ; }

		virtual bool isRoot()	{ return theIsRoot ; }
		bool isFirstTime()		{ return theFirstTime ; }
		bool isDirty()			{ return theDirty ; }

		// Accessors
		SymbolNode getParent() ;
		SymbolNode getChild(int i) ;
		std::vector<long> getChildren() ;
		std::vector<long> sortChildren() ;

		bool graft(SymbolNode &newParent) ;

		void setAdded(bool isAdded) ;
		bool getAdded() ;

		void removeChild(int i) ;
		void removeChild(SymbolNode &object) ;
		int childCount() ;

		long getID()			{ return theID ; }
		void setID(long newID)	{ theID = newID ; }

		std::string getName() ;
		void setName(std::string newName) ;

		/*std::string getQName() ;
		void setQName(std::string newQName) ;*/

		long getTypeID() ;
		void setTypeID(long newTypeID) ;

		long getCategoryID() ;
		void setCategoryID(long newCatID) ;

		long getParentID() ;
		void setParentID(long newParentID) ;

		long getProtectionID() ;
		void setProtectionID(long newProtectionID) ;

		// Links
		void addLink(long toSymID, long lktID) ;
		void addLink(long lnkID, long toSymID, long lktID) ;
		std::vector<Link> getLinks(long lktID) ;
		int countUniqueLinks(long lktID, long catID) ;
		int countLinks(long lktID) ;

		// Metrics
		void writeMetrics() ;
		void readMetrics() ;

		float getMetric(long mttID) ;
		std::vector<float> getMetrics() ;
		void getMetrics(float *&metrics) ;
		void setMetric(long mttID, float newValue) ;
		void incMetric(long mttID, float incAmount) ;
		void incMetric(long mttID) { incMetric(mttID, 1) ; }
		void decMetric(long mttID, float decAmount) ;
		void decMetric(long mttID) { decMetric(mttID, 1) ; }

		// Actions
		void addNode(SymbolNode &object) ;
		bool findSymbolNode(long ID, SymbolNode &ret) ;
		bool findSymbolNodeFromTypeID(long ID, SymbolNode &ret) ;
		bool find(long catID, std::string objName, SymbolNode &ret) ;
		std::list<long> &getUniqueTypesOfChildren(long catID, long classID, std::list<long>&) ;
		std::vector<int> &getAttributeUsage(std::vector<int>&) ;
		int getFieldUsage() ;
		int getAttributeUsage() ;
		int getOperationUsage() ;
		std::vector<long> &getAllOfCategory(long, bool, std::vector<long>&) ;

		// Tests
		bool isQNameLong() ;

		// SYMBOLNODE METHODS SPECIFIC TO A CATEGORY
		// Class
		bool hasSubclass(SymbolNode &classNode) ;
		int countSubclasses() ;

		// Method
		bool isVisible(SymbolNode &classNode) ;

	} ;

} ;

#endif
