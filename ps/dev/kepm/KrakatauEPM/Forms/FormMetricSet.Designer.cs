/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 * Krakatau Essential PM (KEPM)
 * Copyright (c) 2004,2009 PowerSoftware.com
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  24-Feb-2010  10558 : Separated Designer code.
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

namespace PowerSoftware.Krakatau.Kepm.Forms
{
  public partial class FormMetricSet
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

    /// <summary>
    /// Required designer variable.
    /// </summary>
    private System.ComponentModel.Container components = null;

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
      this.btnOK.Click += new System.EventHandler(this.OkClicked);
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
      this.btnCancel.Click += new System.EventHandler(this.CancelClicked);
      // 
      // txtName
      // 
      this.txtName.Font = new System.Drawing.Font("Tahoma", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
      this.txtName.Location = new System.Drawing.Point(128, 13);
      this.txtName.Name = "txtName";
      this.txtName.Size = new System.Drawing.Size(152, 21);
      this.txtName.TabIndex = 0;
      this.txtName.TextChanged += new System.EventHandler(this.MetricSetNameChanged);
      this.txtName.Leave += new System.EventHandler(this.MetricSetNameLeft);
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
