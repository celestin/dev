

#include "windows.h"
#include "lmgrstdc.h"
#define PC
#define WINNT
#include "lmclient.h"
/****************************************************************************
   FUNCTION: DllMain(HANDLE, DWORD, LPVOID)

   PURPOSE:  DllMain is called by Windows when
             the DLL is initialized, Thread Attached, and other times.
             Refer to SDK documentation, as to the different ways this
             may be called.
             
             The DllMain function should perform additional initialization
             tasks required by the DLL.  In this example, no initialization
             tasks are required.  DllMain should return a value of 1 if
             the initialization is successful.
           
*******************************************************************************/
BOOL APIENTRY DllMain(HANDLE hInst, DWORD ul_reason_being_called, LPVOID lpReserved)
{
    return 1;
        UNREFERENCED_PARAMETER(hInst);
        UNREFERENCED_PARAMETER(ul_reason_being_called);
        UNREFERENCED_PARAMETER(lpReserved);
}

__stdcall s_lc_baddate (LM_HANDLE_PTR job)
{
	return lc_baddate(job);
}

_stdcall s_lc_checkin (LM_HANDLE_PTR job, LM_CHAR_PTR feature,
					int keep)
{
	return  lc_checkin (job, feature, keep);
}

_stdcall s_lc_checkout (LM_HANDLE_PTR job, LM_CHAR_PTR feature,
			       LM_CHAR_PTR  version, int nlic, int flag,
			       VENDORCODE_PTR key, int dup)
{
	return lc_checkout (job,feature, version,  nlic,  flag, key,  dup);
}

_stdcall s_lc_cryptstr (LM_HANDLE_PTR job , LM_CHAR_PTR a, 
					LM_CHAR_PTR_PTR b , VENDORCODE_PTR c , 
					int d , LM_CHAR_PTR e , LM_CHAR_PTR_PTR f)
{
	return lc_cryptstr (job,a,b,c,d,e,f);
}


_stdcall s_lc_disconn (LM_HANDLE_PTR job, int force)
{
	return	lc_disconn (job, force);
}

LM_CHAR_PTR _stdcall s_lc_errstring (LM_HANDLE_PTR job)
{
	return	lc_errstring ( job);
}
long _stdcall s_lc_expire_days (LM_HANDLE_PTR job, CONFIG_PTR c)
{
	return	lc_expire_days (job , c );
}

int _stdcall s_lc_get_errno (LM_HANDLE_PTR job)
{
	return	lc_get_errno ( job );
}

HOSTID_PTR _stdcall s_lc_getid_type (LM_HANDLE_PTR job, int idtype)
{
	return	lc_getid_type(job, idtype);
}

_stdcall s_lc_init (LM_HANDLE_PTR job, LM_CHAR_PTR vendor_id, 
				     VENDORCODE_PTR vendor_key,
				     LM_HANDLE_PTR_PTR job_id)
{
	return	lc_init ( job,  vendor_id, vendor_key,job_id);
}

_stdcall s_lc_status (LM_HANDLE_PTR job, LM_CHAR_PTR prompt)
{
	return	lc_status ( job,  prompt);
}

int _stdcall s_lc_timer (LM_HANDLE_PTR job)
{
	return	lc_timer ( job);
}


