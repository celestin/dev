Attribute VB_Name = "ProductOptions"
Const HORZ_INC = 380

Public Sub CreateProductOptions()
  AddProduct "epmkr", "Krakatau EPM"
  AddProduct "epmcp", "C/C++"
  AddProduct "epmcs", "C# (C Sharp)"
  AddProduct "epmjv", "Java"
  AddProduct "epmvb", "Visual Basic"
  AddProduct "epms1", "Oracle PL/SQL"
  AddProduct "epmad", "ADA"
  AddProduct "epmpl", "Perl"
  AddProduct "epmas", "ASP"
  AddProduct "epmph", "PHP"
End Sub

Private Sub AddProduct(ByVal strName As String, ByVal strDesc As String)
  Dim intCount As Integer
  
  With frmLicGen
    intCount = .chkProds().Count
    
    If .chkProds(0).Caption = "krakatau" Then
      .chkProds(0).Caption = strName
      .chkProds(0).ToolTipText = strDesc
    Else
      Load .chkProds(intCount)
      Load .optProds(intCount)
      Load .txtQty(intCount)
      
      .chkProds(intCount).Top = .chkProds(intCount - 1).Top + HORZ_INC
      .chkProds(intCount).Width = .chkProds(intCount - 1).Width
      .chkProds(intCount).Height = .chkProds(intCount - 1).Height
      .chkProds(intCount).BackColor = .chkProds(intCount - 1).BackColor
      .chkProds(intCount).Caption = strName
      .chkProds(intCount).ToolTipText = strDesc
      .chkProds(intCount).Visible = True
      
      .txtQty(intCount).Top = .txtQty(intCount - 1).Top + HORZ_INC
      .txtQty(intCount).Width = .txtQty(intCount - 1).Width
      .txtQty(intCount).Height = .txtQty(intCount - 1).Height
      .txtQty(intCount).Text = ""
      .txtQty(intCount).Visible = True
    
      .fmeProds.Height = .fmeProds.Height + HORZ_INC
      .cmdGenerate.Top = .cmdGenerate.Top + HORZ_INC
      .txtOutput.Height = .txtOutput.Height + HORZ_INC
      .Height = .Height + HORZ_INC + 50
    End If
  End With
End Sub

