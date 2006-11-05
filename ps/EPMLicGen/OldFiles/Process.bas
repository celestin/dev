Attribute VB_Name = "Process"
Private Declare Function WaitForSingleObject Lib "kernel32" _
   (ByVal hHandle As Long, ByVal dwMilliseconds As Long) As Long

Private Declare Function CloseHandle Lib "kernel32" _
   (ByVal hObject As Long) As Long
   
Private Declare Function OpenProcess Lib "kernel32" _
   (ByVal dwDesiredAccess As Long, ByVal bInheritHandle As Long, _
    ByVal dwProcessId As Long) As Long


Private Const INFINITE = -1&
Private Const SYNCHRONIZE = &H100000

Public Sub ExecuteAndWait(ByVal strFile As String, ByVal strParm As String)
    Dim iTask As Long, ret As Long, pHandle As Long
    iTask = Shell(strFile & " " & strParm, vbHide)
    pHandle = OpenProcess(SYNCHRONIZE, False, iTask)
    ret = WaitForSingleObject(pHandle, INFINITE)
    ret = CloseHandle(pHandle)
End Sub


 
