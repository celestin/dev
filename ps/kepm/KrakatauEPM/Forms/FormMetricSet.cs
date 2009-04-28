/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 * Krakatau Essential PM (KEPM)
 * Copyright (c) 2004,2009 SourceCodeMetrics.com
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * Dialog to edit a Metric Set.
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  14-Jun-06    258 : File created.
 * CAM  12-Jul-06    282 : Ensure Cancel button can be pressed even if Metric Set exists.
 * CAM  18-Jul-06    272 : Added CHG,DEL,ADD LLOC metrics.
 * CAM  02-Nov-06    117 : Renumber Metric IDs to suit new SLOC* metrics.
 * CAM  24-Apr-08    357 : Correctly number Metric IDs.
 * CAM  17-Apr-2009  10433 : Added Churn metrics.
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

using System;
using System.Drawing;
using System.Collections;
using System.ComponentModel;
using System.Windows.Forms;

using SourceCodeMetrics.Krakatau.Kepm.Config;

namespace SourceCodeMetrics.Krakatau.Kepm.Forms
{
  /// <summary>
  /// Allowing the editing of a Metric Set.
  /// </summary>
  public class FormMetricSet : System.Windows.Forms.Form
  {
    private System.Windows.Forms.Button btnOK;
    private System.Windows.Forms.Button btnCancel;
    private System.Windows.Forms.TextBox txtName;
    private System.Windows.Forms.GroupBox grpChgMet;
    private System.Windows.Forms.CheckBox chkLower2;
    private System.Windows.Forms.TextBox txtLower2;
    private System.Windows.Forms.CheckBox chkUpper2;
    private System.Windows.Forms.CheckBox chkMet2;
    private System.Windows.Forms.TextBox txtUpper2;
    private System.Windows.Forms.Label label1;
    private System.Windows.Forms.GroupBox grpFileMet;
    private System.Windows.Forms.CheckBox chkLower1;
    private System.Windows.Forms.TextBox txtLower1;
    private System.Windows.Forms.CheckBox chkUpper1;
    private System.Windows.Forms.CheckBox chkMet1;
    private System.Windows.Forms.TextBox txtUpper1;
    private System.Windows.Forms.StatusBar stbMsg;

    protected SortedList _mets1;
    protected SortedList _mets2;
    protected int _tabIndex;
    protected MetricSetItem _msi;
    protected Button _btnLastPressed;

    /// <summary>
    /// Required designer variable.
    /// </summary>
    private System.ComponentModel.Container components = null;

    public FormMetricSet(MetricSetItem msi)
    {
      this._msi = msi;
      InitializeComponent();
      AddExtraMetrics();
      this.txtName.Text = this._msi.Text;
    }

    private void SetLocation(GroupBox grp, Control refObj, Control newObj, bool bold)
    {
      newObj.Location = new Point(refObj.Location.X, refObj.Location.Y + 24);
      newObj.Size = new Size(refObj.Size.Width, refObj.Size.Height);

      if (newObj is CheckBox)
      {
        newObj.Text = refObj.Text;
      }

      if (bold)
      {
        newObj.Font = new Font("Tahoma", 8.25F, FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((System.Byte)(0)));
      }
      else
      {
        newObj.Font = new Font("Tahoma", 8.25F, FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((System.Byte)(0)));
      }

      grp.Controls.Add(newObj);
    }

    private void AddMetric(SortedList m, GroupBox grp, int id, string name)
    {
      Hashtable f = (Hashtable)m.GetByIndex(m.Count - 1);
      CheckBox chkMet = new CheckBox();
      CheckBox chkLower = new CheckBox();
      TextBox txtLower = new TextBox();
      CheckBox chkUpper = new CheckBox();
      TextBox txtUpper = new TextBox();

      CheckBox chkRefMet = (CheckBox)f["chkMet"];
      CheckBox chkRefLower = (CheckBox)f["chkLower"];
      TextBox txtRefLower = (TextBox)f["txtLower"];
      CheckBox chkRefUpper = (CheckBox)f["chkUpper"];
      TextBox txtRefUpper = (TextBox)f["txtUpper"];

      SetLocation(grp, chkRefMet, chkMet, true);
      SetLocation(grp, chkRefLower, chkLower, false);
      SetLocation(grp, txtRefLower, txtLower, false);
      SetLocation(grp, chkRefUpper, chkUpper, false);
      SetLocation(grp, txtRefUpper, txtUpper, false);
      chkMet.Text = name;

      MetricDef md = new MetricDef(id, chkMet, chkLower, txtLower, chkUpper, txtUpper, this._msi.MetricSet);
      f = new Hashtable();
      f["id"] = id;
      f["name"] = name;
      f["chkMet"] = chkMet;
      f["chkLower"] = chkLower;
      f["txtLower"] = txtLower;
      f["chkUpper"] = chkUpper;
      f["txtUpper"] = txtUpper;
      f["MetricDef"] = md;
      m.Add(id, f);
    }

    private void AddExtraMetrics()
    {
      Hashtable f;
      _tabIndex = 1;

      _mets1 = new SortedList();
      _mets2 = new SortedList();

      MetricDef md = new MetricDef(100, this.chkMet1, this.chkLower1, this.txtLower1, this.chkUpper1, this.txtUpper1, this._msi.MetricSet);
      f = new Hashtable();
      f["id"] = md.Id;
      f["name"] = "LOC";
      f["chkMet"] = this.chkMet1;
      f["chkLower"] = this.chkLower1;
      f["txtLower"] = this.txtLower1;
      f["chkUpper"] = this.chkUpper1;
      f["txtUpper"] = this.txtUpper1;
      f["MetricDef"] = md;
      _mets1.Add(f["id"], f);

      md = new MetricDef(123, this.chkMet2, this.chkLower2, this.txtLower2, this.chkUpper2, this.txtUpper2, this._msi.MetricSet);
      f = new Hashtable();
      f["id"] = md.Id;
      f["name"] = "CHG_SLOC";
      f["chkMet"] = this.chkMet2;
      f["chkLower"] = this.chkLower2;
      f["txtLower"] = this.txtLower2;
      f["chkUpper"] = this.chkUpper2;
      f["txtUpper"] = this.txtUpper2;
      f["MetricDef"] = md;
      _mets2.Add(f["id"], f);

      AddMetric(_mets1, grpFileMet, 101, "SLOC");
      AddMetric(_mets1, grpFileMet, 102, "SLOC_NAT");
      AddMetric(_mets1, grpFileMet, 103, "SLOC_TAG");
      AddMetric(_mets1, grpFileMet, 104, "SLOC_HTM");
      AddMetric(_mets1, grpFileMet, 105, "SLOC_SCR");
      AddMetric(_mets1, grpFileMet, 106, "LLOC");
      AddMetric(_mets1, grpFileMet, 107, "N1");
      AddMetric(_mets1, grpFileMet, 108, "N2");
      AddMetric(_mets1, grpFileMet, 109, "N1S");
      AddMetric(_mets1, grpFileMet, 110, "N2S");
      AddMetric(_mets1, grpFileMet, 111, "N");
      AddMetric(_mets1, grpFileMet, 112, "NS");
      AddMetric(_mets1, grpFileMet, 113, "V");
      AddMetric(_mets1, grpFileMet, 114, "D");
      AddMetric(_mets1, grpFileMet, 115, "E");
      AddMetric(_mets1, grpFileMet, 116, "B");
      AddMetric(_mets1, grpFileMet, 117, "J_COM");
      AddMetric(_mets1, grpFileMet, 118, "C_COM");
      AddMetric(_mets1, grpFileMet, 119, "CPP_COM");
      AddMetric(_mets1, grpFileMet, 120, "COM_LOC");
      AddMetric(_mets1, grpFileMet, 121, "BYTES");
      AddMetric(_mets1, grpFileMet, 122, "NFILE");

      AddMetric(_mets2, grpChgMet, 124, "DEL_SLOC");
      AddMetric(_mets2, grpChgMet, 125, "ADD_SLOC");
      AddMetric(_mets2, grpChgMet, 126, "CRN_SLOC");
      AddMetric(_mets2, grpChgMet, 127, "CHG_LLOC");
      AddMetric(_mets2, grpChgMet, 128, "DEL_LLOC");
      AddMetric(_mets2, grpChgMet, 129, "ADD_LLOC");
      AddMetric(_mets2, grpChgMet, 130, "CRN_LLOC");
      AddMetric(_mets2, grpChgMet, 131, "CHG_FILE");
      AddMetric(_mets2, grpChgMet, 132, "DEL_FILE");
      AddMetric(_mets2, grpChgMet, 133, "ADD_FILE");
      AddMetric(_mets2, grpChgMet, 134, "CRN_FILE");

      SetLayout(this._mets1, this.grpFileMet);
      SetLayout(this._mets2, this.grpChgMet);

      this.btnOK.TabIndex = _tabIndex++;
      this.btnCancel.TabIndex = _tabIndex++;
    }

    protected void SetLayout(SortedList m, GroupBox grp)
    {
      CheckBox chkRefMet = null;
      CheckBox chkRefLower = null;
      TextBox txtRefLower = null;
      CheckBox chkRefUpper = null;
      TextBox txtRefUpper = null;
      Hashtable f;

      grp.TabIndex = _tabIndex++;

      IEnumerator e = m.GetEnumerator();
      while (e.MoveNext())
      {
        f = (Hashtable)((DictionaryEntry)e.Current).Value;
        chkRefMet = (CheckBox)f["chkMet"];
        chkRefLower = (CheckBox)f["chkLower"];
        txtRefLower = (TextBox)f["txtLower"];
        chkRefUpper = (CheckBox)f["chkUpper"];
        txtRefUpper = (TextBox)f["txtUpper"];

        chkRefMet.TabIndex = _tabIndex++;
        chkRefLower.TabIndex = _tabIndex++;
        txtRefLower.TabIndex = _tabIndex++;
        chkRefUpper.TabIndex = _tabIndex++;
        txtRefUpper.TabIndex = _tabIndex++;
      }

      int winsize = this.Size.Height - (grp.Location.Y + grp.Size.Height);

      int shift = (chkRefMet.Location.Y - this.chkMet1.Location.Y);
      grp.Size = new Size(grp.Size.Width, grp.Size.Height + shift);

      if (grp == this.grpFileMet)
      {
        this.Size = new Size(this.Size.Width, this.Size.Height + shift);
        shift = (grp.Size.Height + winsize - 20) - (this.btnOK.Size.Height);
        this.btnOK.Location = new Point(this.btnOK.Location.X, shift);
        this.btnCancel.Location = new Point(this.btnCancel.Location.X, shift);
      }
    }

    /// <summary>
    /// Clean up any resources being used.
    /// </summary>
    protected override void Dispose(bool disposing)
    {
      if (disposing)
      {
        if (components != null)
        {
          components.Dispose();
        }
      }
      base.Dispose(disposing);
    }

    private void AppendMetricDefs(SortedList mets)
    {
      MetricSet ms = this._msi.MetricSet;
      IEnumerator defs = mets.Values.GetEnumerator();
      Hashtable f;
      while (defs.MoveNext())
      {
        f = (Hashtable)defs.Current;
        MetricDef md = (MetricDef)f["MetricDef"];
        if (md != null && md.Active)
        {
          ms.Add(md);
        }
      }
    }

    private void btnOK_Click(object sender, System.EventArgs e)
    {
      _btnLastPressed = btnOK;

      this._msi.Text = this.txtName.Text;
      this._msi.MetricSet.Clear();
      AppendMetricDefs(this._mets1);
      AppendMetricDefs(this._mets2);
    }

    private void btnCancel_Click(object sender, System.EventArgs e)
    {
      _btnLastPressed = btnCancel;
    }

    private void FormMetricSet_Closing(object sender, System.ComponentModel.CancelEventArgs e)
    {
      if (_btnLastPressed != null && _btnLastPressed == btnOK)
      {
        MetricSet ms = XmlConfig.Config.GetMetricSet(txtName.Text);
        if (ms != null && ms != this._msi.MetricSet)
        {
          btnOK.Enabled = false;
          stbMsg.Text = "The name you have entered already exists - please specify another.";
          e.Cancel = true;
        }
      }
    }

    private void txtName_TextChanged(object sender, System.EventArgs e)
    {
      if (txtName.Text.IndexOf(" ") > 0)
      {
        stbMsg.Text = "No spaces in Metric Set names, please... they will be removed.";
      }
      else
      {
        stbMsg.Text = "";
      }

      btnOK.Enabled = false;
      if (txtName.Text.Length > 0)
      {
        btnOK.Enabled = true;
      }
    }

    private void txtName_Leave(object sender, System.EventArgs e)
    {
      txtName.Text = txtName.Text.Replace(" ", "");
      stbMsg.Text = "";
    }

    #region Windows Form Designer generated code
    /// <summary>
    /// Required method for Designer support - do not modify
    /// the contents of this method with the code editor.
    /// </summary>
    private void InitializeComponent()
    {
      System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(FormMetricSet));
      this.btnOK = new System.Windows.Forms.Button();
      this.btnCancel = new System.Windows.Forms.Button();
      this.txtName = new System.Windows.Forms.TextBox();
      this.grpChgMet = new System.Windows.Forms.GroupBox();
      this.chkLower2 = new System.Windows.Forms.CheckBox();
      this.txtLower2 = new System.Windows.Forms.TextBox();
      this.chkMet2 = new System.Windows.Forms.CheckBox();
      this.txtUpper2 = new System.Windows.Forms.TextBox();
      this.chkUpper2 = new System.Windows.Forms.CheckBox();
      this.label1 = new System.Windows.Forms.Label();
      this.grpFileMet = new System.Windows.Forms.GroupBox();
      this.chkLower1 = new System.Windows.Forms.CheckBox();
      this.txtLower1 = new System.Windows.Forms.TextBox();
      this.chkMet1 = new System.Windows.Forms.CheckBox();
      this.chkUpper1 = new System.Windows.Forms.CheckBox();
      this.txtUpper1 = new System.Windows.Forms.TextBox();
      this.stbMsg = new System.Windows.Forms.StatusBar();
      this.grpChgMet.SuspendLayout();
      this.grpFileMet.SuspendLayout();
      this.SuspendLayout();
      //
      // btnOK
      //
      this.btnOK.DialogResult = System.Windows.Forms.DialogResult.OK;
      this.btnOK.Enabled = false;
      this.btnOK.Font = new System.Drawing.Font("Tahoma", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
      this.btnOK.Location = new System.Drawing.Point(632, 120);
      this.btnOK.Name = "btnOK";
      this.btnOK.Size = new System.Drawing.Size(96, 32);
      this.btnOK.TabIndex = 0;
      this.btnOK.Text = "&OK";
      this.btnOK.Click += new System.EventHandler(this.btnOK_Click);
      //
      // btnCancel
      //
      this.btnCancel.DialogResult = System.Windows.Forms.DialogResult.Cancel;
      this.btnCancel.Font = new System.Drawing.Font("Tahoma", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
      this.btnCancel.Location = new System.Drawing.Point(736, 120);
      this.btnCancel.Name = "btnCancel";
      this.btnCancel.Size = new System.Drawing.Size(96, 32);
      this.btnCancel.TabIndex = 1;
      this.btnCancel.Text = "&Cancel";
      this.btnCancel.Click += new System.EventHandler(this.btnCancel_Click);
      //
      // txtName
      //
      this.txtName.Font = new System.Drawing.Font("Tahoma", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
      this.txtName.Location = new System.Drawing.Point(128, 13);
      this.txtName.Name = "txtName";
      this.txtName.Size = new System.Drawing.Size(152, 21);
      this.txtName.TabIndex = 0;
      this.txtName.TextChanged += new System.EventHandler(this.txtName_TextChanged);
      this.txtName.Leave += new System.EventHandler(this.txtName_Leave);
      //
      // grpChgMet
      //
      this.grpChgMet.Controls.Add(this.chkLower2);
      this.grpChgMet.Controls.Add(this.txtLower2);
      this.grpChgMet.Controls.Add(this.chkMet2);
      this.grpChgMet.Controls.Add(this.txtUpper2);
      this.grpChgMet.Controls.Add(this.chkUpper2);
      this.grpChgMet.Font = new System.Drawing.Font("Tahoma", 8.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
      this.grpChgMet.Location = new System.Drawing.Point(424, 48);
      this.grpChgMet.Name = "grpChgMet";
      this.grpChgMet.Size = new System.Drawing.Size(408, 56);
      this.grpChgMet.TabIndex = 11;
      this.grpChgMet.TabStop = false;
      this.grpChgMet.Text = "Changed Metrics";
      //
      // chkLower2
      //
      this.chkLower2.Font = new System.Drawing.Font("Tahoma", 8.25F);
      this.chkLower2.Location = new System.Drawing.Point(104, 24);
      this.chkLower2.Name = "chkLower2";
      this.chkLower2.Size = new System.Drawing.Size(64, 24);
      this.chkLower2.TabIndex = 10;
      this.chkLower2.Text = "Lower";
      //
      // txtLower2
      //
      this.txtLower2.Font = new System.Drawing.Font("Tahoma", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
      this.txtLower2.Location = new System.Drawing.Point(168, 25);
      this.txtLower2.Name = "txtLower2";
      this.txtLower2.Size = new System.Drawing.Size(72, 21);
      this.txtLower2.TabIndex = 9;
      //
      // chkMet2
      //
      this.chkMet2.Font = new System.Drawing.Font("Tahoma", 8.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
      this.chkMet2.Location = new System.Drawing.Point(8, 24);
      this.chkMet2.Name = "chkMet2";
      this.chkMet2.Size = new System.Drawing.Size(96, 24);
      this.chkMet2.TabIndex = 7;
      this.chkMet2.Text = "CHG_SLOC";
      //
      // txtUpper2
      //
      this.txtUpper2.Font = new System.Drawing.Font("Tahoma", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
      this.txtUpper2.Location = new System.Drawing.Point(328, 25);
      this.txtUpper2.Name = "txtUpper2";
      this.txtUpper2.Size = new System.Drawing.Size(72, 21);
      this.txtUpper2.TabIndex = 5;
      //
      // chkUpper2
      //
      this.chkUpper2.Font = new System.Drawing.Font("Tahoma", 8.25F);
      this.chkUpper2.Location = new System.Drawing.Point(264, 24);
      this.chkUpper2.Name = "chkUpper2";
      this.chkUpper2.Size = new System.Drawing.Size(64, 24);
      this.chkUpper2.TabIndex = 8;
      this.chkUpper2.Text = "Upper";
      //
      // label1
      //
      this.label1.Font = new System.Drawing.Font("Tahoma", 8.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
      this.label1.Location = new System.Drawing.Point(16, 16);
      this.label1.Name = "label1";
      this.label1.Size = new System.Drawing.Size(104, 16);
      this.label1.TabIndex = 4;
      this.label1.Text = "Metric Set Name";
      //
      // grpFileMet
      //
      this.grpFileMet.Controls.Add(this.chkLower1);
      this.grpFileMet.Controls.Add(this.txtLower1);
      this.grpFileMet.Controls.Add(this.chkMet1);
      this.grpFileMet.Controls.Add(this.chkUpper1);
      this.grpFileMet.Controls.Add(this.txtUpper1);
      this.grpFileMet.Font = new System.Drawing.Font("Tahoma", 8.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
      this.grpFileMet.Location = new System.Drawing.Point(8, 48);
      this.grpFileMet.Name = "grpFileMet";
      this.grpFileMet.Size = new System.Drawing.Size(408, 56);
      this.grpFileMet.TabIndex = 12;
      this.grpFileMet.TabStop = false;
      this.grpFileMet.Text = "File Metrics";
      //
      // chkLower1
      //
      this.chkLower1.Font = new System.Drawing.Font("Tahoma", 8.25F);
      this.chkLower1.Location = new System.Drawing.Point(104, 24);
      this.chkLower1.Name = "chkLower1";
      this.chkLower1.Size = new System.Drawing.Size(64, 24);
      this.chkLower1.TabIndex = 10;
      this.chkLower1.Text = "Lower";
      //
      // txtLower1
      //
      this.txtLower1.Font = new System.Drawing.Font("Tahoma", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
      this.txtLower1.Location = new System.Drawing.Point(168, 25);
      this.txtLower1.Name = "txtLower1";
      this.txtLower1.Size = new System.Drawing.Size(72, 21);
      this.txtLower1.TabIndex = 9;
      //
      // chkMet1
      //
      this.chkMet1.Font = new System.Drawing.Font("Tahoma", 8.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
      this.chkMet1.Location = new System.Drawing.Point(8, 24);
      this.chkMet1.Name = "chkMet1";
      this.chkMet1.Size = new System.Drawing.Size(96, 24);
      this.chkMet1.TabIndex = 7;
      this.chkMet1.Text = "LOC";
      //
      // chkUpper1
      //
      this.chkUpper1.Font = new System.Drawing.Font("Tahoma", 8.25F);
      this.chkUpper1.Location = new System.Drawing.Point(264, 24);
      this.chkUpper1.Name = "chkUpper1";
      this.chkUpper1.Size = new System.Drawing.Size(64, 24);
      this.chkUpper1.TabIndex = 8;
      this.chkUpper1.Text = "Upper";
      //
      // txtUpper1
      //
      this.txtUpper1.Font = new System.Drawing.Font("Tahoma", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
      this.txtUpper1.Location = new System.Drawing.Point(328, 25);
      this.txtUpper1.Name = "txtUpper1";
      this.txtUpper1.Size = new System.Drawing.Size(72, 21);
      this.txtUpper1.TabIndex = 5;
      //
      // stbMsg
      //
      this.stbMsg.Font = new System.Drawing.Font("Tahoma", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
      this.stbMsg.Location = new System.Drawing.Point(0, 153);
      this.stbMsg.Name = "stbMsg";
      this.stbMsg.Size = new System.Drawing.Size(842, 22);
      this.stbMsg.TabIndex = 13;
      //
      // FormMetricSet
      //
      this.AcceptButton = this.btnOK;
      this.AutoScaleBaseSize = new System.Drawing.Size(5, 13);
      this.CancelButton = this.btnCancel;
      this.ClientSize = new System.Drawing.Size(842, 175);
      this.ControlBox = false;
      this.Controls.Add(this.stbMsg);
      this.Controls.Add(this.label1);
      this.Controls.Add(this.txtName);
      this.Controls.Add(this.btnCancel);
      this.Controls.Add(this.btnOK);
      this.Controls.Add(this.grpChgMet);
      this.Controls.Add(this.grpFileMet);
      this.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedDialog;
      this.Icon = ((System.Drawing.Icon)(resources.GetObject("$this.Icon")));
      this.MaximizeBox = false;
      this.MinimizeBox = false;
      this.Name = "FormMetricSet";
      this.ShowInTaskbar = false;
      this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
      this.Text = "Metric Set";
      this.Closing += new System.ComponentModel.CancelEventHandler(this.FormMetricSet_Closing);
      this.grpChgMet.ResumeLayout(false);
      this.grpChgMet.PerformLayout();
      this.grpFileMet.ResumeLayout(false);
      this.grpFileMet.PerformLayout();
      this.ResumeLayout(false);
      this.PerformLayout();

    }
    #endregion
  }
}