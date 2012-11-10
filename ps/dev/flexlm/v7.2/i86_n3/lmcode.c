#include <stdio.h>
#include "lmclient.h"
#include "lm_code.h"
VENDORCODE vendorkeys[] = {		/* Possible keys for vendor daemons */
		{ VENDORCODE_5, 
		ENCRYPTION_SEED1^VENDOR_KEY5, ENCRYPTION_SEED2^VENDOR_KEY5,
		  VENDOR_KEY1, VENDOR_KEY2, VENDOR_KEY3, VENDOR_KEY4,
		  {0}, {0}, LM_STRENGTH,  0,
		  FLEXLM_VERSION, FLEXLM_REVISION, FLEXLM_PATCH, 
		  LM_BEHAVIOR_CURRENT, {CRO_KEY1, CRO_KEY2}},
		    	   };	/* End of vendor codes*/
int keysize = sizeof(vendorkeys)/sizeof(vendorkeys[0]);
char *vendor_name = VENDOR_NAME;
unsigned long seed3 = ENCRYPTION_SEED3;
unsigned long seed4 = ENCRYPTION_SEED4;
int pubkey_strength = LM_STRENGTH;
