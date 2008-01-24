/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 * Krakatau Metrics (metrics.exe)
 * Copyright (c) 2001,2008 SourceCodeMetrics.com
 * Author Craig McKay <craig.mckay@powersoftware.com>
 *
 * $Id$
 *
 * Who  When       Why
 * CAM  24-Jan-08  337 : Add to source control.
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

#include "ComparePhase.h"
#include "Diff.h"
using namespace metrics ;
using namespace std ;


const int ComparePhase::DIFFERENT_CAT = 0 ;
const int ComparePhase::EQUAL = 1;
const int ComparePhase::UNEQUAL = 2 ;


void ComparePhase::execute(RootNode *root)
{
	cout << "Hello" << endl	;
}


void ComparePhase::calcDiff(SymbolNode &node1, SymbolNode &node2)
{
	int category = node1.getCategoryID() ;
	int symID = node1.getID() ;

	// Removed CAM 03/04/01
	//float *metrics1 = new float[MasterData::getMaxMetricTypeID(category)] ;
	//float *metrics2 = new float[MasterData::getMaxMetricTypeID(category)] ;

	// Added CAM 03/04/01
	float *metrics1 ;
	float *metrics2 ;

	node1.getMetrics(metrics1) ;
	node2.getMetrics(metrics2) ;

	for (int c=0 ; c<MasterData::getMaxMetricTypeID(category) ; c++)
	{
		theMetricCompBuff.add(new MetricComp(symID,MasterData::codeMtt(c,category),metrics1[c]-metrics2[c])) ;
	}

	delete [] metrics1 ;
	delete [] metrics2 ;
}


int ComparePhase::changed(SymbolNode &node1, SymbolNode &node2)
{
	int cat1 = node1.getCategoryID() ;
	int cat2 = node2.getCategoryID() ;

	if (cat1!=cat2) return DIFFERENT_CAT ;

	if (cat1==MasterData::FILE_CAT)
	{
		// Changed for Modification accuracy

//		float mod1 = node1.getMetric(MasterData::LMODT_MET) ;
//		float mod2 = node2.getMetric(MasterData::LMODT_MET) ;

		long mod1 = Utilities::getLastModTime(node1.getName()) ;
		long mod2 = Utilities::getLastModTime(node2.getName()) ;

		if (mod1!=mod2) return UNEQUAL ;

		return EQUAL ;
	}
	else if (cat1==MasterData::CLASS_CAT)
	{
		float met1 = node1.getMetric(MasterData::LOC_MET) ;
		float met2 = node2.getMetric(MasterData::LOC_MET) ;

		if (met1!=met2) return UNEQUAL ;

		met1 = node1.getMetric(MasterData::SLOC_MET) ;
		met2 = node2.getMetric(MasterData::SLOC_MET) ;

		if (met1!=met2) return UNEQUAL ;

		return EQUAL ;
	}
	else if (cat1==MasterData::METHOD_CAT)
	{
		float met1 = node1.getMetric(MasterData::V_MET) ;
		float met2 = node2.getMetric(MasterData::V_MET) ;

		if (met1!=met2) return UNEQUAL ;

		met1 = node1.getMetric(MasterData::LOC_MET) ;
		met2 = node2.getMetric(MasterData::LOC_MET) ;

		if (met1!=met2) return UNEQUAL ;

		met1 = node1.getMetric(MasterData::SLOC_MET) ;
		met2 = node2.getMetric(MasterData::SLOC_MET) ;

		if (met1!=met2) return UNEQUAL ;

		return EQUAL ;
	}
	else if (cat1==MasterData::PROJECT_CAT)
	{
		float met1 = node1.getMetric(MasterData::NMETH_MET) ;
		float met2 = node2.getMetric(MasterData::NMETH_MET) ;

		if (met1!=met2) return UNEQUAL ;

		met1 = node1.getMetric(MasterData::LOC_MET) ;
		met2 = node2.getMetric(MasterData::LOC_MET) ;

		if (met1!=met2) return UNEQUAL ;

		met1 = node1.getMetric(MasterData::SLOC_MET) ;
		met2 = node2.getMetric(MasterData::SLOC_MET) ;

		if (met1!=met2) return UNEQUAL ;

		return EQUAL ;
	}

	return UNEQUAL ;
}


void ComparePhase::compare(SymbolNode &node1, SymbolNode &node2)
{
#ifdef PM
	//MasterData::theLog << "compare: " << node1.getName() << " and " << node2.getName() << endl ;
	// Get sorted children

	// Added CAM 03/04/01
	node1.sortChildren() ;
	node2.sortChildren() ;
	int children1 = node1.childCount() ;
	int children2 = node2.childCount() ;

	SymbolNode tmp1 = node1 ;
	SymbolNode tmp2 = node2 ;

	int newParentID = tmp1.getID() ;

	/*
	 * i is the index for the files2 vector
	 * j is the index for the files1 vector
	 */

	int i=0,j=0,comparison ;
	bool proceed ;

	while (i<children2 || j<children1)
	{
		if (j>=children1) // This must be a DELETED node
		{
			tmp2 = node2.getChild(i) ;
			comparison = 1 ; // so set comparison to 1
		}
		else if (i>=children2) // This must be a NEW node
		{
			tmp1 = node1.getChild(j) ;
			comparison = -1 ; // so set comparison to -1
		}
		else
		{
			tmp1 = node1.getChild(j) ;
			tmp2 = node2.getChild(i) ;
			comparison = tmp1.getName().compare(tmp2.getName()) ;
		}

		proceed = true ;
		if (tmp1.getCategoryID() == MasterData::FIELD_CAT)
		{
			j++ ;
			proceed = false ;
		}

		if (tmp2.getCategoryID() == MasterData::FIELD_CAT)
		{
			i++ ;
			proceed = false ;
		}


		if (proceed)
		{
			if (comparison==0)
			{
				int state = changed(tmp1,tmp2) ;

				if (state==UNEQUAL)
				{
					theProjectChanged = true ;
					//MasterData::theLog << tmp1.getName() << " has changed." << endl ;
					theSymbolCompBuff.add(new SymbolComp(tmp1.getID(), MasterData::CHANGED_STATE)) ;
					calcDiff(tmp1,tmp2) ;
					compare(tmp1,tmp2) ;

					int category = tmp1.getCategoryID() ;
					if (category == MasterData::CLASS_CAT)
					{
						theProjNode.incMetric(MasterData::CHG_CLASS_MET) ;
						//theNChgClass++ ;
					}
#ifdef LANGUAGE_JAVA
					else if (category==MasterData::PACKAGE_CAT)
					{
						//theNChgPack++ ;
						theProjNode.incMetric(MasterData::CHG_PACK_MET) ;
					}
#endif
					else if (category==MasterData::METHOD_CAT)
					{
						//theNChgMeth++ ;
						theProjNode.incMetric(MasterData::CHG_METH_MET) ;
					}
				}
				else if (state==EQUAL)
				{
					theSymbolCompBuff.add(new SymbolComp(tmp1.getID(), MasterData::UNCHANGED_STATE)) ;
					//MasterData::theLog << tmp1.getName() << " has not changed." << endl ;
				}

				i++ ;
				j++ ;
			}
			else if (comparison < 0)
			{
				theSymbolCompBuff.add(new SymbolComp(tmp1.getID(), MasterData::NEW_STATE)) ;

				j++ ;

				int category = tmp1.getCategoryID() ;
				if (category == MasterData::CLASS_CAT)
				{
					theProjNode.incMetric(MasterData::INS_CLASS_MET) ;
				}
#ifdef LANGUAGE_JAVA
				else if (category==MasterData::PACKAGE_CAT)
				{
					theProjNode.incMetric(MasterData::INS_PACK_MET) ;
				}
#endif
				else if (category==MasterData::METHOD_CAT)
				{
					theProjNode.incMetric(MasterData::INS_METH_MET) ;
				}
			}
			else
			{ // ie (comparison > 0)

				theSymbolDelBuff.add(new SymbolDel(
					tmp2.getID(),
					tmp2.getParentID(),		// Original Parent ID
					newParentID,			// Parent in new tree so deleted...
					tmp2.getName(),			// ...may be shown in the correct place
					tmp2.getTypeID(),
					tmp2.getCategoryID(),
					tmp2.getProtectionID())) ;

				//MasterData::theLog << tmp2.getName() << " has been deleted." << endl ;

				i++;

				int category = tmp2.getCategoryID() ;
				if (category == MasterData::CLASS_CAT)
				{
					theProjNode.incMetric(MasterData::DEL_CLASS_MET) ;
				}
#ifdef LANGUAGE_JAVA
				else if (category==MasterData::PACKAGE_CAT)
				{
					theProjNode.incMetric(MasterData::DEL_PACK_MET) ;
				}
#endif
				else if (category==MasterData::METHOD_CAT)
				{
					theProjNode.incMetric(MasterData::DEL_METH_MET) ;
				}
			}
		}
	}
#endif
}


void ComparePhase::comparePackages(SymbolNode &node1, int offset1, SymbolNode &node2, int offset2)
{
	node1.sortChildren() ;
	node2.sortChildren() ;

	int children1 = node1.childCount() ;
	int children2 = node2.childCount() ;

	SymbolNode tmp1 = node1 ;
	SymbolNode tmp2 = node2 ;

	int newParentID = tmp1.getID() ;

	/*
	 * i is the index for the files2 vector
	 * j is the index for the files1 vector
	 */

//	MasterData::theLog << "children1=" << children1 << " children2=" << children2 << endl ;
//	MasterData::theLog << "node1.getName()=" << node1.getName() << endl ;
//	MasterData::theLog << "node2.getName()=" << node2.getName() << endl ;

	int i=0,j=0,comparison ;

	while (i<children2 || j<children1)
	{
		if (j>=children1) // This must be a DELETED node
		{
			tmp2 = node2.getChild(i) ;
			comparison = 1; // so set comparison to 1
		}
		else if (i>=children2) // This must be a NEW node
		{
			tmp1 = node1.getChild(j) ;
			//MasterData::theLog << ",*" << endl ;
			comparison = -1; // so set comparison to -1
		}
		else
		{
			tmp1 = node1.getChild(j) ;
			tmp2 = node2.getChild(i) ;
//			MasterData::theLog << tmp1.getName() << " & " << tmp2.getName() << endl ;
			comparison = tmp1.getName().compare(tmp2.getName()) ;
		}

		if (comparison==0){
			// Matched Package - compare files within the packages
//			MasterData::theLog << "Matched Package, comparing files..." << endl ;
			if (compareFiles(tmp1, offset1, tmp2, offset2))
			{
				theSymbolCompBuff.add(new SymbolComp(tmp1.getID(), MasterData::CHANGED_STATE)) ;
			}
			else
			{
				theSymbolCompBuff.add(new SymbolComp(tmp1.getID(), MasterData::UNCHANGED_STATE)) ;
			}

			calcDiff(tmp1, tmp2) ;

			i++ ;
			j++ ;
		} else if (comparison < 0) {
			// Package is new
			int childCount = tmp1.childCount() ;

			// Flag the Package as new
			theSymbolCompBuff.add(new SymbolComp(tmp1.getID(), MasterData::NEW_STATE)) ;

			for(int n=0; n<childCount; n++)
			{
				//theTotalInsertedLines += tmp1.getChild(n).getMetric(MasterData::SLOC_MET) ;
				theProjNode.incMetric(MasterData::P_CHG_LOC_MET,
					tmp1.getChild(n).getMetric(MasterData::SLOC_MET)) ;
				// Flag the files within this package as new
				theSymbolCompBuff.add(new SymbolComp(tmp1.getChild(n).getID(), MasterData::NEW_STATE)) ;
			}
			j++ ;

		} else { // ie (comparison > 0)
			// Package has been deleted
			int childCount = tmp2.childCount() ;

			// Flag the Package as deleted
			theSymbolDelBuff.add(new SymbolDel(
				tmp2.getID(),
				tmp2.getParentID(),
				newParentID,
				tmp2.getName(),
				tmp2.getTypeID(),
				tmp2.getCategoryID(),
				tmp2.getProtectionID())) ;

			for(int d=0; d<childCount; d++)
			{
				SymbolNode delFile = tmp2.getChild(d) ;

				//theTotalDeletedLines += delFile.getMetric(MasterData::SLOC_MET) ;
				theProjNode.incMetric(MasterData::P_DEL_LOC_MET,
					delFile.getMetric(MasterData::SLOC_MET)) ;

				// Flag the files within this package as deleted
				theSymbolDelBuff.add(new SymbolDel(
					delFile.getID(),
					delFile.getParentID(),
					tmp2.getID(),
					delFile.getName(),
					delFile.getTypeID(),
					delFile.getCategoryID(),
					delFile.getProtectionID())) ;
			}
			i++ ;
		}
	}
}


vector<long> ComparePhase::getChildrenOfCat(RootNode *root, SymbolNode &sub, long catID)
{
	vector<long> children = sub.sortChildren() ;
	vector<long> retval ;
	vector<long>::iterator iter ;
	SymbolNode child = sub ;
	int i=0 ;

	for(iter = children.begin(); iter != children.end(); iter++)
	{
		if (root->findSymbolNode((*iter), child))
		{
			if (child.getCategoryID() == catID) {
				//children.erase(iter) ;
				//MasterData::theLog << "Child[" << i++ << "]=" << child.getName() << endl ;
				retval.push_back((*iter)) ;
			}
		}
	}

	return retval ;
}


bool ComparePhase::compareFiles(SymbolNode &node1, int offset1, SymbolNode &node2, int offset2)
{
	bool retval = false ;
#ifdef PM
	vector<long> chdrn1 = getChildrenOfCat(theRoot1, node1, MasterData::FILE_CAT) ;
	vector<long> chdrn2 = getChildrenOfCat(theRoot2, node2, MasterData::FILE_CAT) ;

	int children1 = chdrn1.size() ;
	int children2 = chdrn2.size() ;

	SymbolNode tmp1 = node1 ;
	SymbolNode tmp2 = node2 ;

	int newParentID = tmp1.getID() ;

	/*
	 * i is the index for the files2 vector
	 * j is the index for the files1 vector
	 */

	//MasterData::theLog << "children1=" << children1 << " children2=" << children2 << endl ;
	//MasterData::theLog << "node1.getName()=" << node1.getName() << " (" << tmp1.getID() << "," << newParentID << ")" << endl ;
	//MasterData::theLog << "node2.getName()=" << node2.getName() << endl ;

	int i=0,j=0,comparison ;

	while (i<children2 || j<children1)
	{
		if (j>=children1) // This must be a DELETED node
		{
			//tmp2 = node2.getChild(i) ;
			node2.findSymbolNode(chdrn2[i], tmp2) ;
			MasterData::theLog << tmp2.getName() << " is deleted" << endl ;
			comparison = 1 ; // so set comparison to 1
		}
		else if (i>=children2) // This must be a NEW node
		{
			//tmp1 = node1.getChild(j) ;
			node1.findSymbolNode(chdrn1[j], tmp1) ;
			//MasterData::theLog << ",*" << endl ;
			MasterData::theLog << tmp2.getName() << " is new" << endl ;
			comparison = -1 ; // so set comparison to -1
		}
		else
		{
			//tmp1 = node1.getChild(j) ;
			//tmp2 = node2.getChild(i) ;
			node1.findSymbolNode(chdrn1[j], tmp1) ;
			node2.findSymbolNode(chdrn2[i], tmp2) ;
			comparison = tmp1.getName().substr(offset1).compare(tmp2.getName().substr(offset2)) ;
		}


		if (comparison==0){
			int state = changed(tmp1,tmp2) ;

			if ( state==UNEQUAL)
			{
				theProjectChanged = true ;
				MasterData::theLog << tmp1.getName().substr(offset1) << " has changed." << endl ;

				calcDiff(tmp1,tmp2) ;

				compare(tmp1,tmp2) ;

				Diff d ;
				d.compare(tmp2.getName().c_str(), tmp1.getName().c_str()) ;

				boolean actualChanges = true ;

				if (d.getChangedLines()==d.getDeletedLines()==d.getInsertedLines()==0) {
					long sz1 = Utilities::getFileSize(tmp1.getName()) ;
					long sz2 = Utilities::getFileSize(tmp2.getName()) ;

					MasterData::theLog << tmp1.getName() << ": " << sz1 << endl ;
					MasterData::theLog << tmp2.getName() << ": " << sz2 << endl ;

					if (sz1==sz2) {
						actualChanges = false ;
					}
				}

				if (actualChanges) {
					theSymbolCompBuff.add(new SymbolComp(tmp1.getID(), MasterData::CHANGED_STATE)) ;

					tmp1.setMetric(MasterData::CHG_LOC_MET, d.getChangedLines()) ;
					tmp1.setMetric(MasterData::DEL_LOC_MET, d.getDeletedLines()) ;
					tmp1.setMetric(MasterData::INS_LOC_MET, d.getInsertedLines()) ;

					//theTotalChangedLines += d.getChangedLines() ;
					//theTotalDeletedLines += d.getDeletedLines() ;
					//theTotalInsertedLines += d.getInsertedLines() ;

					theProjNode.incMetric(MasterData::P_CHG_LOC_MET,
						d.getChangedLines()) ;
					theProjNode.incMetric(MasterData::P_DEL_LOC_MET,
						d.getDeletedLines()) ;
					theProjNode.incMetric(MasterData::P_INS_LOC_MET,
						d.getInsertedLines()) ;

					//theNChgFiles++ ;
					theProjNode.incMetric(MasterData::CHG_FILE_MET) ;
					retval = true ;
				} else {
					theSymbolCompBuff.add(new SymbolComp(tmp1.getID(), MasterData::UNCHANGED_STATE)) ;
				}


			}
			else if (state==EQUAL)
			{
				theSymbolCompBuff.add(new SymbolComp(tmp1.getID(), MasterData::UNCHANGED_STATE)) ;
			}
			i++;
			j++;
		} else if (comparison < 0) {
			theProjectChanged = true ;
			//theTotalInsertedLines += tmp1.getMetric(MasterData::SLOC_MET) ;
			theProjNode.incMetric(MasterData::P_INS_LOC_MET,
				tmp1.getMetric(MasterData::SLOC_MET)) ;

			theSymbolCompBuff.add(new SymbolComp(tmp1.getID(), MasterData::NEW_STATE)) ;
			MasterData::theLog << tmp1.getName().substr(offset2) << " has been added." << endl ;
			//theNAddFiles++ ;
			theProjNode.incMetric(MasterData::INS_FILE_MET) ;
			j++;
		} else { // ie (comparison > 0)
			theProjectChanged = true ;
			//theTotalDeletedLines += tmp2.getMetric(MasterData::SLOC_MET) ;
			theProjNode.incMetric(MasterData::P_DEL_LOC_MET,
				tmp2.getMetric(MasterData::SLOC_MET)) ;

			theSymbolDelBuff.add(new SymbolDel(
					tmp2.getID(),
					tmp2.getParentID(),
					newParentID,
					tmp2.getName(),
					tmp2.getTypeID(),
					tmp2.getCategoryID(),
					tmp2.getProtectionID())) ;

			MasterData::theLog << tmp2.getName().substr(offset1) << " has been deleted." << endl ;
			//theNDelFiles++ ;
			theProjNode.incMetric(MasterData::DEL_FILE_MET) ;
			i++;
		}
	}
#endif

	return retval ;
}


bool ComparePhase::compareSubprojects(SymbolNode &node1, int offset1, SymbolNode &node2, int offset2)
{
	bool retval = false ;
#ifdef PM
	vector<long> chdrn1 = getChildrenOfCat(theRoot1, node1, MasterData::PROJECT_CAT) ;
	vector<long> chdrn2 = getChildrenOfCat(theRoot2, node2, MasterData::PROJECT_CAT) ;

	int children1 = chdrn1.size() ;
	int children2 = chdrn2.size() ;

	SymbolNode tmp1 = node1 ;
	SymbolNode tmp2 = node2 ;

	int newParentID = tmp1.getID() ;

	/*
	 * i is the index for the files2 vector
	 * j is the index for the files1 vector
	 */

	//MasterData::theLog << "children1=" << children1 << " children2=" << children2 << endl ;
	//MasterData::theLog << "node1.getName()=" << node1.getName() << " (" << tmp1.getID() << "," << newParentID << ")" << endl ;
	//MasterData::theLog << "node2.getName()=" << node2.getName() << endl ;

	int i=0,j=0,comparison ;

	while (i<children2 || j<children1)
	{
		if (j>=children1) // This must be a DELETED node
		{
			//tmp2 = node2.getChild(i) ;
			node2.findSymbolNode(chdrn2[i], tmp2) ;
			MasterData::theLog << tmp2.getName() << " is deleted" << endl ;
			comparison = 1 ; // so set comparison to 1
		}
		else if (i>=children2) // This must be a NEW node
		{
			//tmp1 = node1.getChild(j) ;
			node1.findSymbolNode(chdrn1[j], tmp1) ;
			//MasterData::theLog << ",*" << endl ;
			MasterData::theLog << tmp2.getName() << " is new" << endl ;
			comparison = -1 ; // so set comparison to -1
		}
		else
		{
			//tmp1 = node1.getChild(j) ;
			//tmp2 = node2.getChild(i) ;
			node1.findSymbolNode(chdrn1[j], tmp1) ;
			node2.findSymbolNode(chdrn2[i], tmp2) ;
			//MasterData::theLog << tmp1.getName() << " & " << tmp2.getName() << endl ;
			comparison = tmp1.getName().compare(tmp2.getName()) ;
		}

		if (comparison==0){
			// Matched Subprojects - compare them
			SymbolNode oldProj = theProjNode ;
			bool changed = false ;

			theProjNode = tmp1 ;

			if (compareSubprojects(tmp1, offset1, tmp2, offset2))
			{
				changed = true ;
			}

			theProjNode = tmp1 ;

			if (compareFiles(tmp1, offset1, tmp2, offset2))
			{
				changed = true ;
			}

			if (changed)
			{
				float *met ;
				tmp1.getMetrics(met) ;

				oldProj.incMetric(MasterData::INS_FILE_MET, met[MasterData::INS_FILE_MET]) ;
				oldProj.incMetric(MasterData::DEL_FILE_MET, met[MasterData::DEL_FILE_MET]) ;
				oldProj.incMetric(MasterData::CHG_FILE_MET, met[MasterData::CHG_FILE_MET]) ;
				oldProj.incMetric(MasterData::INS_CLASS_MET, met[MasterData::INS_CLASS_MET]) ;
				oldProj.incMetric(MasterData::DEL_CLASS_MET, met[MasterData::DEL_CLASS_MET]) ;
				oldProj.incMetric(MasterData::CHG_CLASS_MET, met[MasterData::CHG_CLASS_MET]) ;
				oldProj.incMetric(MasterData::INS_METH_MET, met[MasterData::INS_METH_MET]) ;
				oldProj.incMetric(MasterData::DEL_METH_MET, met[MasterData::DEL_METH_MET]) ;
				oldProj.incMetric(MasterData::CHG_METH_MET, met[MasterData::CHG_METH_MET]) ;
				oldProj.incMetric(MasterData::P_CHG_LOC_MET, met[MasterData::P_CHG_LOC_MET]) ;
				oldProj.incMetric(MasterData::P_INS_LOC_MET, met[MasterData::P_INS_LOC_MET]) ;
				oldProj.incMetric(MasterData::P_DEL_LOC_MET, met[MasterData::P_DEL_LOC_MET]) ;

				delete [] met ;

				theSymbolCompBuff.add(new SymbolComp(tmp1.getID(), MasterData::CHANGED_STATE)) ;
				retval = true ;
			}
			else
			{
				theSymbolCompBuff.add(new SymbolComp(tmp1.getID(), MasterData::UNCHANGED_STATE)) ;
			}

			theProjNode = oldProj ;

			calcDiff(tmp1, tmp2) ;

			i++ ;
			j++ ;

		} else if (comparison < 0) {
			// Subproject is new
			/*int childCount = chdrn1.size() ;

			// Flag the Subproject as new
			theSymbolCompBuff.add(new SymbolComp(newParentID, MasterData::NEW_STATE)) ;

			for(int n=0; n<childCount; n++)
			{
				node1.findSymbolNode(chdrn1[n], tmp1) ;

				//theTotalInsertedLines += tmp1.getMetric(MasterData::SLOC_MET) ;
				theProjNode.incMetric(MasterData::P_INS_LOC_MET,
					tmp1.getMetric(MasterData::SLOC_MET)) ;

				MasterData::theLog << "Finding " << tmp1.getName() << "[" << tmp1.getID() << "]=" << chdrn1[n] << endl ;

				// Flag the children of this Subproject as new
				theSymbolCompBuff.add(new SymbolComp(chdrn1[n], MasterData::NEW_STATE)) ;
			}*/

			newHierarchyFrom(tmp1) ;

			j++ ;
			retval = true ;

		} else { // ie (comparison > 0)

			// Flag the Subproject as deleted
			theSymbolDelBuff.add(new SymbolDel(
				tmp2.getID(),
				tmp2.getParentID(),
				newParentID,
				tmp2.getName(),
				tmp2.getTypeID(),
				tmp2.getCategoryID(),
				tmp2.getProtectionID())) ;

			delHierarchyFrom(tmp2) ;
			i++ ;
			retval = true ;
		}
	}
#endif
	return retval ;
}


void ComparePhase::newHierarchyFrom(SymbolNode &node)
{
#ifdef PM
	// Flag this node and all its children (recursively) as new / added
	theSymbolCompBuff.add(new SymbolComp(node.getID(), MasterData::NEW_STATE)) ;
	SymbolNode child = node ;

	for(int i=0; i<node.childCount(); i++)
	{
		child = node.getChild(i) ;

		if (child.getCategoryID() == MasterData::FILE_CAT)
		{
			theProjNode.incMetric(MasterData::INS_FILE_MET) ;

			theProjNode.incMetric(MasterData::P_INS_LOC_MET,
				child.getMetric(MasterData::SLOC_MET)) ;
		}
		else if (child.getCategoryID() == MasterData::CLASS_CAT)
		{
			theProjNode.incMetric(MasterData::INS_CLASS_MET) ;
		}
		else if (child.getCategoryID() == MasterData::METHOD_CAT)
		{
			theProjNode.incMetric(MasterData::INS_METH_MET) ;
		}

		theSymbolCompBuff.add(new SymbolComp(child.getID(), MasterData::NEW_STATE)) ;
		newHierarchyFrom(child) ;
	}
#endif
}


void ComparePhase::delHierarchyFrom(SymbolNode &node)
{
#ifdef PM
	// Flag this node and all its children (recursively) as deleted
	SymbolNode child = node ;

	for(int i=0; i<node.childCount(); i++)
	{
		child = node.getChild(i) ;

		if (child.getCategoryID() == MasterData::FILE_CAT)
		{
			theProjNode.incMetric(MasterData::DEL_FILE_MET) ;

			theProjNode.incMetric(MasterData::P_DEL_LOC_MET,
				child.getMetric(MasterData::SLOC_MET)) ;
		}
		else if (child.getCategoryID() == MasterData::CLASS_CAT)
		{
			theProjNode.incMetric(MasterData::DEL_CLASS_MET) ;
		}
		else if (child.getCategoryID() == MasterData::METHOD_CAT)
		{
			theProjNode.incMetric(MasterData::DEL_METH_MET) ;
		}

		delHierarchyFrom(child) ;
	}
#endif
}


void ComparePhase::execute(RootNode *root1, int offset1, RootNode *root2,int offset2)
{
	theRoot1 = root1 ;
	theRoot2 = root2 ;

	theMetricCompBuff.setConnection(root1) ;
	theSymbolCompBuff.setConnection(root1) ;
	theSymbolDelBuff.setConnection(root1) ;

	/*theNAddFiles = theNChgFiles = theNDelFiles = 0 ;
	theNAddClass = theNChgClass = theNDelClass = 0 ;
	theNAddMeth = theNChgMeth = theNDelMeth = 0 ;*/
	theProjNode = (*theRoot1) ;

	/*theProjNode.setMetric(MasterData::INS_FILE_MET, 0) ;
	theProjNode.setMetric(MasterData::DEL_FILE_MET, 0) ;
	theProjNode.setMetric(MasterData::CHG_FILE_MET, 0) ;
	theProjNode.setMetric(MasterData::INS_CLASS_MET, 0) ;
	theProjNode.setMetric(MasterData::DEL_CLASS_MET, 0) ;
	theProjNode.setMetric(MasterData::CHG_CLASS_MET, 0) ;
	theProjNode.setMetric(MasterData::INS_METH_MET, 0) ;
	theProjNode.setMetric(MasterData::DEL_METH_MET, 0) ;
	theProjNode.setMetric(MasterData::CHG_METH_MET, 0) ;
	theProjNode.setMetric(MasterData::P_CHG_LOC_MET, 0) ;
	theProjNode.setMetric(MasterData::P_INS_LOC_MET, 0) ;
	theProjNode.setMetric(MasterData::P_DEL_LOC_MET, 0) ;*/

	theProjectChanged = false ;

#ifdef LANGUAGE_CPP
	// Compare Subprojects

	SymbolNode oldProj = theProjNode ;
	bool changed = false ;

	if (compareSubprojects((*theRoot1), offset1, (*theRoot2), offset2))
	{
		changed = true ;
	}

	theProjNode = (*theRoot1) ;

	if (compareFiles((*theRoot1), offset1, (*theRoot2), offset2))
	{
		changed = true ;
	}

	if (changed)
	{
		theSymbolCompBuff.add(new SymbolComp(theRoot1->getID(), MasterData::CHANGED_STATE)) ;
	}
	else
	{
		theSymbolCompBuff.add(new SymbolComp(theRoot1->getID(), MasterData::UNCHANGED_STATE)) ;
	}

	theProjNode = oldProj ;
#else
	comparePackages(*theRoot1,offset1,*theRoot2,offset2) ;
#endif

	//if (changed(*theRoot1,*theRoot2) == UNEQUAL)
	if (theProjectChanged)
	{
		theSymbolCompBuff.add(new SymbolComp(theRoot1->getID(), MasterData::CHANGED_STATE)) ;
		calcDiff(*theRoot1,*theRoot2) ;
	}

	theMetricCompBuff.commit() ;
	theSymbolCompBuff.commit() ;
	theSymbolDelBuff.commit() ;
}