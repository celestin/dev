'* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
'* Essential Project Manager (EPM)
'* Copyright (c) 2004,2010 PowerSoftware.com
'* Author Craig McKay <craig@frontburner.co.uk>
'*
'* $Id$
'*
'* Who  When         Why
'* CAM  17-Feb-2010  10570 : Functions to Start/Stop EPMdb
'* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *

Function StartEpmDb
  Set objWMIService = GetObject("winmgmts:{impersonationLevel=impersonate}!\\.\root\cimv2")
  Set colListOfServices = objWMIService.ExecQuery ("Select * from Win32_Service Where Name ='EPMdb'")
  For Each objService in colListOfServices
    objService.StartService()
  Next 
End Function 

Function StopEpmDb
  Set objWMIService = GetObject("winmgmts:{impersonationLevel=impersonate}!\\.\root\cimv2")
  Set colListOfServices = objWMIService.ExecQuery ("Select * from Win32_Service Where Name ='EPMdb'")
  For Each objService in colListOfServices
    objService.StopService()
  Next 
End Function 
