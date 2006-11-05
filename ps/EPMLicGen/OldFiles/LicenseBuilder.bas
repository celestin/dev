Attribute VB_Name = "LicenseBuilder"
Private m_dtpDate As DTPicker
Private m_strMonth(1 To 12) As String

Public Function LicenseString() As String
  Dim retval As String
  
  With frmLicGen
    Set m_dtpDate = .dtpDate
    
    If .optLicTimed.Value Then
      For i = 0 To .chkProds.Count - 1
        If .chkProds.Item(i).Value Then
          retval = retval & "FEATURE " & .chkProds.Item(i).Caption & " KRAKATAU 1.0 " & _
          FLEXlmDate & " uncounted HOSTID=ANY ck=0 SIGN=0" & Chr(13) & Chr(10)
        End If
      Next
    ElseIf .optLicHost.Value Then
      For i = 0 To .chkProds.Count - 1
        If .chkProds.Item(i).Value Then
          retval = retval & "FEATURE " & .chkProds.Item(i).Caption & " KRAKATAU 1.0 " & _
          "permanent uncounted HOSTID=HOSTNAME=" & .txtName & " SIGN=0" & Chr(13) & Chr(10)
        End If
      Next
          
    ElseIf .optLicFloat.Value Then
      retval = "SERVER " & .txtName & " " & .cmbHostid.Text & Chr(13) & Chr(10) & _
      "VENDOR KRAKATAU" & Chr(13) & Chr(10)
            
      For i = 0 To .chkProds.Count - 1
        If .chkProds.Item(i).Value Then
          retval = retval & "FEATURE " & .chkProds.Item(i).Caption & _
          " KRAKATAU 1.0 permanent " & .txtQty.Item(i).Text & _
          " SIGN=0" & Chr(13) & Chr(10)
        End If
      Next
            
    End If
  End With
  
  LicenseString = retval
End Function

Private Function FLEXlmDate() As String
  FLEXlmDate = m_dtpDate.Day & "-" & _
    m_strMonth(m_dtpDate.Month) & "-" & m_dtpDate.Year
End Function

Private Function SelectedProd() As String
  With frmLicGen.optProds
    For i = 0 To .Count - 1
      If .Item(i).Value Then
        SelectedProd = .Item(i).Caption
        i = .Count
      End If
    Next
  End With
End Function

Public Sub PopulateMonths()
  m_strMonth(1) = "jan"
  m_strMonth(2) = "feb"
  m_strMonth(3) = "mar"
  m_strMonth(4) = "apr"
  m_strMonth(5) = "may"
  m_strMonth(6) = "jun"
  m_strMonth(7) = "jul"
  m_strMonth(8) = "aug"
  m_strMonth(9) = "sep"
  m_strMonth(10) = "oct"
  m_strMonth(11) = "nov"
  m_strMonth(12) = "dec"
End Sub


