/******************************************************************************

	    COPYRIGHT (c) 1988, 1998 by Globetrotter Software Inc.
	This software has been provided pursuant to a License Agreement
	containing restrictions on its use.  This software contains
	valuable trade secrets and proprietary information of 
	Globetrotter Software Inc and is protected by law.  It may 
	not be copied or distributed in any form or medium, disclosed 
	to third parties, reverse engineered or used in any manner not 
	provided for in said License Agreement except with the prior 
	written authorization from Globetrotter Software Inc.

 *****************************************************************************/
/*	
 *	Module: $Id: lmflex.c,v 1.24.2.2 2000/12/16 00:50:44 jwong Exp $
 *
 *	Description:	This is a sample application program, to illustrate 
 *			the use of the Flexible License Manager.
 *
 *	Last changed:  06 Dec 1998
 *	D. Birns
 *
 */

#include "lmclient.h" 
#include <stdio.h>
#ifdef ANSI
#include <stdlib.h>
#endif
#include <time.h>
#include "lm_attr.h"
#ifdef PC
#define LICPATH "license.dat;."
#else
#define LICPATH "@localhost:license.dat:."
#endif /* PC */

#define FEATURE "f1"
VENDORCODE code;

void
main()
{
  char feature[MAX_FEATURE_LEN+1];
  LM_HANDLE *lm_job;

	if (lc_new_job(0, lc_new_job_arg2, &code, &lm_job))
	{
		lc_perror(lm_job, "lc_new_job failed");
		exit(lc_get_errno(lm_job));
	}
        LM_USE_FLEXLOCK();

#ifdef PC
	printf("Enter \"lcm\" to demo new LCM functionality\n");
	printf("Enter \"flexlock\" to demo FLEXlock functionality\n\n");
	printf("Enter \"f1\" to demo floating functionality\n");
	printf("Enter \"f2\" to node-locked functionality\n");
#endif
	printf("Enter feature to checkout [default: \"%s\"]: ", FEATURE);


	fgets(feature, MAX_FEATURE_LEN, stdin); 
	feature[strlen(feature)-1] = '\0'; /* truncate trailing newline */
	if (!*feature) strcpy(feature, FEATURE);
#ifdef PC
	if (!strcmp(feature, "lcm")) printf("Use key: OR10660-2377213\n");
#endif
/* 
 *      ISVs with high security requirements should not set LM_A_FLEXLOCK
 */
	lc_set_attr ( lm_job, LM_A_FLEXLOCK , (LM_A_VAL_TYPE) 1 );
	lc_set_attr(lm_job, LM_A_LICENSE_DEFAULT, (LM_A_VAL_TYPE)LICPATH);
	lc_set_attr(lm_job, LM_A_CKOUT_INSTALL_LIC, (LM_A_VAL_TYPE)1);
	if (lc_checkout(lm_job, feature, "1.0", 1, LM_CO_NOWAIT, &code, 
								LM_DUP_NONE))
	{
		lc_perror(lm_job, "checkout failed");
		exit (lc_get_errno(lm_job));
        }
	printf("%s checked out...", feature);
	printf("press return to exit..."); 
/*
 *	Wait till user hits return
 *	getchar may be interrupted by SIGALRM, so we loop if necessary
 */
	getchar();
	lc_checkin(lm_job, feature ,0);

	lc_free_job(lm_job);
        exit(0);
}
