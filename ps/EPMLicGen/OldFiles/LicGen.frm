VERSION 5.00
Object = "{86CF1D34-0C5F-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCT2.OCX"
Begin VB.Form frmLicGen 
   BackColor       =   &H00DC6041&
   Caption         =   "FLEXlm EPM License Generator"
   ClientHeight    =   3405
   ClientLeft      =   60
   ClientTop       =   630
   ClientWidth     =   6360
   Icon            =   "LicGen.frx":0000
   LinkTopic       =   "Form1"
   ScaleHeight     =   3405
   ScaleWidth      =   6360
   StartUpPosition =   2  'CenterScreen
   Begin VB.ComboBox cmbHostid 
      Height          =   315
      ItemData        =   "LicGen.frx":0442
      Left            =   4560
      List            =   "LicGen.frx":0449
      TabIndex        =   14
      Text            =   "Any"
      Top             =   1200
      Width           =   1575
   End
   Begin MSComCtl2.DTPicker dtpDate 
      Height          =   315
      Left            =   960
      TabIndex        =   8
      Top             =   1200
      Width           =   1815
      _ExtentX        =   3201
      _ExtentY        =   556
      _Version        =   393216
      Format          =   20381696
      CurrentDate     =   37041
      MinDate         =   33970
   End
   Begin VB.OptionButton optLicFloat 
      Caption         =   "&Floating"
      Height          =   255
      Left            =   4920
      TabIndex        =   2
      Top             =   480
      Width           =   975
   End
   Begin VB.OptionButton optLicHost 
      Caption         =   "&Host-locked"
      Height          =   255
      Left            =   2640
      TabIndex        =   1
      Top             =   480
      Width           =   1215
   End
   Begin VB.OptionButton optLicTimed 
      Caption         =   "&Timed Expiry"
      Height          =   255
      Left            =   360
      TabIndex        =   0
      Top             =   480
      Value           =   -1  'True
      Width           =   1215
   End
   Begin VB.TextBox txtOutput 
      BackColor       =   &H0048A9F0&
      BeginProperty Font 
         Name            =   "Tahoma"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   735
      Left            =   3120
      Locked          =   -1  'True
      MultiLine       =   -1  'True
      TabIndex        =   5
      Top             =   1770
      Width           =   3135
   End
   Begin VB.CommandButton cmdGenerate 
      BackColor       =   &H00DC6041&
      Caption         =   "&Generate"
      Default         =   -1  'True
      Height          =   555
      Left            =   120
      MaskColor       =   &H00DC6041&
      TabIndex        =   4
      Top             =   2760
      Width           =   6135
   End
   Begin VB.Frame frmLicType 
      Caption         =   "License Type"
      Height          =   855
      Left            =   120
      TabIndex        =   7
      Top             =   120
      Width           =   6015
   End
   Begin VB.TextBox txtName 
      BeginProperty Font 
         Name            =   "Tahoma"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   315
      Left            =   960
      TabIndex        =   3
      Top             =   1200
      Width           =   2415
   End
   Begin VB.Frame fmeProds 
      Caption         =   "&Select Products"
      BeginProperty Font 
         Name            =   "Tahoma"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   855
      Left            =   120
      TabIndex        =   9
      Top             =   1680
      Width           =   2895
      Begin VB.TextBox txtQty 
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   285
         Index           =   0
         Left            =   1560
         TabIndex        =   12
         Top             =   360
         Width           =   855
      End
      Begin VB.CheckBox chkProds 
         Caption         =   "krakatau"
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   255
         Index           =   0
         Left            =   240
         TabIndex        =   11
         Top             =   360
         Width           =   1095
      End
      Begin VB.OptionButton optProds 
         Caption         =   "krakatau"
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   255
         Index           =   0
         Left            =   240
         TabIndex        =   10
         Top             =   360
         Width           =   1335
      End
   End
   Begin VB.Label lblHostid 
      Caption         =   "Host &ID"
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
      Left            =   3720
      TabIndex        =   13
      Top             =   1230
      Width           =   735
   End
   Begin VB.Label lblDesc 
      Caption         =   "&Expiry"
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
      TabIndex        =   6
      Top             =   1230
      Width           =   855
   End
   Begin VB.Menu mnuFile 
      Caption         =   "&File"
      Begin VB.Menu mnuExit 
         Caption         =   "E&xit"
      End
   End
   Begin VB.Menu mnuTools 
      Caption         =   "&Tools"
      Begin VB.Menu mnuOptions 
         Caption         =   "&Options"
      End
   End
   Begin VB.Menu mnuHelp 
      Caption         =   "&Help"
      Begin VB.Menu mnuAbout 
         Caption         =   "&About"
      End
   End
End
Attribute VB_Name = "frmLicGen"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Const LICENSE_FILE = "license.dat"
Const FLEXLM = "lmcrypt.exe"
Const WINZIP32 = "C:\Program Files\Winzip\Winzip32.exe "
Const FRAME_SINGLE = "Select Product"
Const FRAME_FLOAT = "Select Products && Quantities"
Const MAX_LIC_LINE_LEN = 45

Private Sub chkProds_Click(Index As Integer)
  txtQty(Index).Visible = chkProds(Index).Value
End Sub

Private Sub cmdExit_Click()
  Unload frmLicGen
End Sub

Private Sub cmdGenerate_Click()
  txtOutput.Visible = False
  txtOutput.Text = ""
  Me.Refresh

  Open GetLicenseFile For Output As 1
  Print #1, LicenseString
  Close #1
  
  ExecuteAndWait AppPath & FLEXLM, """" & GetLicenseFile & """"
  
  Open GetLicenseFile For Input As 1
  Dim strLine As String
  Dim strLine2 As String
  
  While Not EOF(1)
    Line Input #1, strLine
    If Right(strLine, 1) = "\" Then
      strLine = Trim(Left(strLine, Len(strLine) - 1))
      If Not EOF(1) Then
        Line Input #1, strLine2
        If Left(strLine2, 1) = Chr(9) Then strLine2 = Trim(Mid(strLine2, 2))
        strLine = Trim(strLine) & " " & Trim(strLine2)
      End If
    End If
    'txtOutput.Text = Trim(txtOutput.Text) & " " & strLine
    
    txtOutput.Text = txtOutput.Text & ChopUp(strLine)
  Wend
  Close #1
  
  If GetCreateZip Then
    ExecuteAndWait WINZIP32, " -min -a -ex " & GetZipFile & " """ & GetLicenseFile & """"
  End If
  
  txtOutput.Visible = True
End Sub

Private Function ChopUp(ByVal strLine As String) As String
  Dim strRet As String
  Dim ch As String
  Dim intPos As Integer

  If Len(strLine) > MAX_LIC_LINE_LEN Then
    intPos = MAX_LIC_LINE_LEN
    ch = Mid(strLine, intPos, 1)
    
    While intPos > 1 And ch <> " "
      intPos = intPos - 1
      ch = Mid(strLine, intPos, 1)
    Wend
    
    strRet = Trim(Left(strLine, intPos)) & " \ " & _
    Chr(13) & Chr(10) & ChopUp(Trim(Mid(strLine, intPos))) & Chr(13) & Chr(10)
  Else
    strRet = strLine & Chr(13) & Chr(10)
  End If
  
  ChopUp = strRet
End Function

Private Sub Form_Load()
  dtpDate.Value = Date
  frmLicType.BackColor = frmLicGen.BackColor
  Me.optLicFloat.BackColor = frmLicGen.BackColor
  Me.optLicHost.BackColor = frmLicGen.BackColor
  Me.optLicTimed.BackColor = frmLicGen.BackColor
  Me.lblDesc.BackColor = frmLicGen.BackColor
  Me.lblHostid.BackColor = frmLicGen.BackColor
  Me.fmeProds.BackColor = frmLicGen.BackColor
  Me.chkProds.Item(0).BackColor = frmLicGen.BackColor
  Me.cmdGenerate.BackColor = frmLicGen.BackColor
  
  CreateProductOptions

  Load frmOptions
  frmOptions.Visible = False
  
  RefreshControls
  PopulateMonths
End Sub

Private Sub ApplicationExit()
  Unload frmLicGen
  Unload frmOptions
End Sub

Private Sub Form_Unload(Cancel As Integer)
  ApplicationExit
End Sub

Private Sub txtOutput_KeyDown(KeyCode As Integer, Shift As Integer)
  If KeyCode = 67 And Shift = vbCtrlMask Then
    Clipboard.Clear
    Clipboard.SetText txtOutput.SelText
   End If
End Sub

Private Sub optLicFloat_Click()
  RefreshControls
End Sub

Private Sub optLicHost_Click()
  RefreshControls
End Sub

Private Sub optLicTimed_Click()
  RefreshControls
End Sub

Private Sub RefreshControls()
  Dim blnDate As Boolean
  Dim blnName As Boolean
  Dim blnNumLic As Boolean
  
  If optLicTimed.Value Then
    lblDesc.Caption = "&Expiry"
    blnDate = True
    blnNumLic = False
    
  ElseIf optLicHost.Value Then
    lblDesc.Caption = "H&ost"
    blnDate = False
    blnNumLic = False
    
  ElseIf optLicFloat.Value Then
    lblDesc.Caption = "&Server"
    blnDate = False
    blnNumLic = True
    
  End If
  
  dtpDate.Visible = blnDate
  txtName.Visible = Not blnDate
  ProdCheckBoxes True
  ProdRadioButtons False
  cmbHostid.Visible = blnNumLic
  lblHostid.Visible = blnNumLic
  Me.Refresh
End Sub

Private Sub ProdCheckBoxes(ByVal blnVisible As Boolean)
  If blnVisible Then fmeProds.Caption = FRAME_FLOAT
  
  For i = 0 To chkProds.Count - 1
    chkProds(i).Visible = blnVisible
    txtQty(i).Visible = (blnVisible And chkProds(i).Value)
  Next
End Sub

Private Sub ProdRadioButtons(ByVal blnVisible As Boolean)
  If blnVisible Then fmeProds.Caption = FRAME_SINGLE
  
  For i = 0 To optProds.Count - 1
    optProds(i).Visible = blnVisible
  Next
End Sub

Private Function AppPath() As String
  Dim strRet As String
  strRet = App.Path
  
  If Right(strRet, 1) <> "\" Then strRet = strRet & "\"
  
  AppPath = strRet
End Function

' =-=-= Menus =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

Private Sub mnuExit_Click()
  ApplicationExit
End Sub

Private Sub mnuOptions_Click()
  frmOptions.Visible = True
  frmLicGen.Visible = False
End Sub

Private Sub mnuAbout_Click()
  Dim cr As String
  cr = Chr(13) & Chr(10)
  MsgBox "EPM License Generator" & cr & "by Craig McKay" & cr & "7-May-2005", vbOKOnly + vbInformation, "About License Generator"
End Sub


