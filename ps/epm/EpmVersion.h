/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 * Essential Project Manager (EPM)
 * Copyright (c) 2009,2010 PowerSoftware.com
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * EPM Version Number
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  27-Aug-2009  10483 : Version 1.19.1.0.
 * CAM  15-Sep-2009  10490 : Version 1.19.2.0.
 * CAM  27-Oct-2009  10499 : Version 1.19.3.0.
 * CAM  10-Nov-2009  10501 : Version 1.19.3.1 for Intel to test.
 * CAM  17-Nov-2009  10503 : Version 1.19.4.0.
 * CAM  12-Dec-2009  10509 : Version 1.20.0.0.
 * CAM  17-Feb-2010  10571 : Version 1.21.0.0.
 * CAM  05-Mar-2010  10592 : Version 1.21.1.0.
 * CAM  16-Mar-2010  10609 : Removed version define and replaced with GetEpmVersion.
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

#ifndef EPMVERSION_H
#define EPMVERSION_H

#include <windows.h>
#pragma comment(lib,"version.lib")

BOOL GetTranslationId(LPVOID lpData, UINT unBlockSize, WORD wLangId, DWORD &dwId, BOOL bPrimaryEnough/*= FALSE*/)
{
  LPWORD lpwData;

  for (lpwData = (LPWORD)lpData; (LPBYTE)lpwData < ((LPBYTE)lpData)+unBlockSize; lpwData+=2)
  {
    if (*lpwData == wLangId)
    {
      dwId = *((DWORD*)lpwData);
      return TRUE;
    }
  }

  if (!bPrimaryEnough)
    return FALSE;

  for (lpwData = (LPWORD)lpData; (LPBYTE)lpwData < ((LPBYTE)lpData)+unBlockSize; lpwData+=2)
  {
    if (((*lpwData)&0x00FF) == (wLangId&0x00FF))
    {
      dwId = *((DWORD*)lpwData);
      return TRUE;
    }
  }

  return FALSE;
}

void GetEpmVersion(char *szVersion, int bufflen)
{
  char buffer[_MAX_PATH];
  GetModuleFileName(NULL, buffer, _MAX_PATH);

  VS_FIXEDFILEINFO m_FileInfo;
  DWORD dwHandle;
  DWORD dwFileVersionInfoSize = GetFileVersionInfoSize(buffer, &dwHandle);
  if (!dwFileVersionInfoSize) return;

  LPVOID  lpData = (LPVOID)new BYTE[dwFileVersionInfoSize];
  if (!lpData) return;

  try
  {
    if (!GetFileVersionInfo(buffer, dwHandle, dwFileVersionInfoSize, lpData)) return;

    LPVOID  lpInfo;
    UINT    unInfoLen;
    if (VerQueryValue(lpData, "\\", &lpInfo, &unInfoLen))
    {
      if (unInfoLen == sizeof(m_FileInfo)) memcpy(&m_FileInfo, lpInfo, unInfoLen);
    }

    // find best matching language and codepage
    VerQueryValue(lpData, "\\VarFileInfo\\Translation", &lpInfo, &unInfoLen);

    DWORD dwLangCode = 0;
    if (!GetTranslationId(lpInfo, unInfoLen, GetUserDefaultLangID(), dwLangCode, FALSE))
    {
      if (!GetTranslationId(lpInfo, unInfoLen, GetUserDefaultLangID(), dwLangCode, TRUE))
      {
        if (!GetTranslationId(lpInfo, unInfoLen, MAKELANGID(LANG_NEUTRAL, SUBLANG_NEUTRAL), dwLangCode, TRUE))
        {
          if (!GetTranslationId(lpInfo, unInfoLen, MAKELANGID(LANG_ENGLISH, SUBLANG_NEUTRAL), dwLangCode, TRUE))
            dwLangCode = *((DWORD*)lpInfo);
        }
      }
    }

    // Now retrieve the key for ProductVersion
    char szSubBlock[1024];
    sprintf_s(szSubBlock, 1024, "\\StringFileInfo\\%04X%04X\\ProductVersion", dwLangCode&0x0000FFFF, (dwLangCode&0xFFFF0000)>>16);

    if (VerQueryValue(lpData, szSubBlock, &lpInfo, &unInfoLen))
    {
      std::string version = (LPCTSTR)lpInfo;

      std::string delim = ", ";
      std::string period = ".";
      version.replace(version.find(delim), delim.size(), period);
      version.replace(version.find(delim), delim.size(), period);
      version.replace(version.find(delim), delim.size(), period);

      strcpy_s(szVersion, bufflen, version.c_str());
    }

    delete[] lpData;
  }
  catch (BOOL)
  {
    delete[] lpData;
  }
}

#endif