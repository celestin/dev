VERSION 5.00
Begin VB.Form frmOptions 
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "License Generator Options"
   ClientHeight    =   1965
   ClientLeft      =   2760
   ClientTop       =   3750
   ClientWidth     =   6030
   Icon            =   "Options.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   1965
   ScaleWidth      =   6030
   ShowInTaskbar   =   0   'False
   Begin VB.CheckBox chkCreateZip 
      Caption         =   "Create 'license.zip' too"
      BeginProperty Font 
         Name            =   "Tahoma"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   495
      Left            =   120
      TabIndex        =   5
      Top             =   720
      Width           =   2655
   End
   Begin VB.TextBox txtLicFile 
      Height          =   285
      Left            =   120
      TabIndex        =   4
      Top             =   360
      Width           =   4575
   End
   Begin VB.CommandButton cmdBrowse 
      Caption         =   "&Browse"
      BeginProperty Font 
         Name            =   "Tahoma"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   375
      Left            =   4800
      TabIndex        =   3
      Top             =   320
      Width           =   1095
   End
   Begin VB.CommandButton cmdCancel 
      Caption         =   "Cancel"
      BeginProperty Font 
         Name            =   "Tahoma"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   375
      Left            =   3240
      TabIndex        =   1
      Top             =   1440
      Width           =   1215
   End
   Begin VB.CommandButton cmdOK 
      Caption         =   "&OK"
      Default         =   -1  'True
      BeginProperty Font 
         Name            =   "Tahoma"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   375
      Left            =   4680
      TabIndex        =   0
      Top             =   1440
      Width           =   1215
   End
   Begin VB.Label lblOpt1 
      Caption         =   "Location for license.dat"
      BeginProperty Font 
         Name            =   "Tahoma"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   255
      Left            =   120
      TabIndex        =   2
      Top             =   120
      Width           =   2775
   End
End
Attribute VB_Name = "frmOptions"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Private Sub Form_Load()
  txtLicFile.Text = GetLicenseFile
  chkCreateZip = GetCreateZip
  
  If txtLicFile.Text = "" Then
    txtLicFile.Text = "C:\license.dat"
    SetLicenseFile txtLicFile.Text
  End If
End Sub

Private Sub Form_Unload(Cancel As Integer)
  ReturnToMain
End Sub

Private Sub ReturnToMain()
  Me.Visible = False
  frmLicGen.Visible = True
End Sub

Private Sub cmdBrowse_Click()
  Dim strPath As String
  strPath = BrowseForFolder(Me, "Select location for license.dat")
  If Right(strPath, 1) <> "\" Then strPath = strPath & "\"
  
  txtLicFile.Text = strPath & "license.dat"
  SetLicenseFile txtLicFile.Text
End Sub

Private Sub cmdCancel_Click()
  ReturnToMain
End Sub

Private Sub cmdOK_Click()
  SetLicenseFile txtLicFile.Text
  SetCreateZip chkCreateZip.Value
  ReturnToMain
End Sub

