Attribute VB_Name = "Registry"

Public Const APP_NAME = "LicenseGenerator"
Public Const SEC_SETUP = "Setup"
Public Const LICENSE_FILE = "LicenseFile"
Public Const CREATE_ZIP = "CreateZip"
Public Const REG_TRUE = "TRUE"
Public Const REG_FALSE = "FALSE"

Public Function GetLicenseFile() As String
  GetLicenseFile = GetSetting(APP_NAME, SEC_SETUP, LICENSE_FILE)
End Function

Public Function GetCreateZip() As Long
  Dim strCreate As String
  strCreate = GetSetting(APP_NAME, SEC_SETUP, CREATE_ZIP)
  If IsNumeric(strCreate) Then
    GetCreateZip = Val(strCreate)
  Else
    GetCreateZip = 0
  End If
End Function

Public Function GetZipFile() As String
  Dim strFile As String
  strFile = GetSetting(APP_NAME, SEC_SETUP, LICENSE_FILE)
  GetZipFile = """" & Left(strFile, Len(strFile) - 3) & "zip"""
End Function

Public Sub SetLicenseFile(ByVal strFilename As String)
  SaveSetting APP_NAME, SEC_SETUP, LICENSE_FILE, strFilename
End Sub

Public Sub SetCreateZip(ByVal lngCreateZip As Long)
  SaveSetting APP_NAME, SEC_SETUP, CREATE_ZIP, Trim(Str(lngCreateZip))
End Sub


