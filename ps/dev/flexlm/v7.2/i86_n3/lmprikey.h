#include "lmclient.h"		
lm_extern int (*l_prikey_sign)() = 0;		
static unsigned char lm_prikey[3][40] = {{0}};
		
static unsigned int lm_prisize[3] = {0x0, 0x0, 0x0};
