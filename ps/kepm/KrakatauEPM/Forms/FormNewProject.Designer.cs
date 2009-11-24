/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 * Krakatau Essential PM (KEPM)
 * Copyright (c) 2009 PowerSoftware.com
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  17-Nov-2009  10502 : File created.
 * CAM  24-Nov-2009  10506 : Ensure Excluded Directories button is disabled on launch of the New Project form..
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

using System.Windows.Forms;
using SourceCodeMetrics.Krakatau.Kepm.Config;
using SourceCodeMetrics.Krakatau.Kepm.Projects;

namespace SourceCodeMetrics.Krakatau.Kepm.Forms
{
  partial class NewProject
  {
    /// <summary>
    /// Required designer variable.
    /// </summary>
    private System.ComponentModel.IContainer components = null;

    /// <summary>
    /// Clean up any resources being used.
    /// </summary>
    /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
    protected override void Dispose(bool disposing)
    {
      if (disposing && (components != null))
      {
        components.Dispose();
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
      System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(NewProject));
      this.label1 = new System.Windows.Forms.Label();
      this.txtTitle = new System.Windows.Forms.TextBox();
      this.label2 = new System.Windows.Forms.Label();
      this.dtpSnapshot = new System.Windows.Forms.DateTimePicker();
      this.fbdBase = new System.Windows.Forms.FolderBrowserDialog();
      this.txtBase = new System.Windows.Forms.TextBox();
      this.label3 = new System.Windows.Forms.Label();
      this.cmdBrowse = new System.Windows.Forms.Button();
      this.cmdOK = new System.Windows.Forms.Button();
      this.cmdCancel = new System.Windows.Forms.Button();
      this.clbFileTypes = new System.Windows.Forms.CheckedListBox();
      this.cmdSaveAs = new System.Windows.Forms.Button();
      this.txtProj = new System.Windows.Forms.TextBox();
      this.label5 = new System.Windows.Forms.Label();
      this.sfdProj = new System.Windows.Forms.SaveFileDialog();
      this.label6 = new System.Windows.Forms.Label();
      this.chkFileTypes = new System.Windows.Forms.CheckBox();
      this.label4 = new System.Windows.Forms.Label();
      this.lbxExcludedDirectories = new System.Windows.Forms.ListBox();
      this.cmdSelect = new System.Windows.Forms.Button();
      this.SuspendLayout();
      //
      // label1
      //
      this.label1.Font = new System.Drawing.Font("Tahoma", 8.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
      this.label1.Location = new System.Drawing.Point(8, 11);
      this.label1.Name = "label1";
      this.label1.Size = new System.Drawing.Size(100, 24);
      this.label1.TabIndex = 0;
      this.label1.Text = "Project Title";
      //
      // txtTitle
      //
      this.txtTitle.Location = new System.Drawing.Point(112, 8);
      this.txtTitle.Name = "txtTitle";
      this.txtTitle.Size = new System.Drawing.Size(136, 20);
      this.txtTitle.TabIndex = 1;
      this.txtTitle.TextChanged += new System.EventHandler(this.TitleChanged);
      //
      // label2
      //
      this.label2.Font = new System.Drawing.Font("Tahoma", 8.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
      this.label2.Location = new System.Drawing.Point(8, 38);
      this.label2.Name = "label2";
      this.label2.Size = new System.Drawing.Size(100, 24);
      this.label2.TabIndex = 2;
      this.label2.Text = "Snapshot Date";
      //
      // dtpSnapshot
      //
      this.dtpSnapshot.CustomFormat = "dd-MMM-yyyy";
      this.dtpSnapshot.Font = new System.Drawing.Font("Tahoma", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
      this.dtpSnapshot.Format = System.Windows.Forms.DateTimePickerFormat.Custom;
      this.dtpSnapshot.Location = new System.Drawing.Point(112, 34);
      this.dtpSnapshot.Name = "dtpSnapshot";
      this.dtpSnapshot.Size = new System.Drawing.Size(112, 21);
      this.dtpSnapshot.TabIndex = 4;
      this.dtpSnapshot.ValueChanged += new System.EventHandler(this.SnapshotDateChanged);
      //
      // fbdBase
      //
      this.fbdBase.Description = "Locate the base directory, the starting point in the folder tree, for your projec" +
          "t source files";
      this.fbdBase.ShowNewFolderButton = false;
      //
      // txtBase
      //
      this.txtBase.Location = new System.Drawing.Point(112, 61);
      this.txtBase.Name = "txtBase";
      this.txtBase.Size = new System.Drawing.Size(256, 20);
      this.txtBase.TabIndex = 6;
      this.txtBase.TextChanged += new System.EventHandler(this.BaseDirectoryChanged);
      this.txtBase.Leave += new System.EventHandler(this.LeaveBaseDirectory);
      //
      // label3
      //
      this.label3.Font = new System.Drawing.Font("Tahoma", 8.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
      this.label3.Location = new System.Drawing.Point(8, 64);
      this.label3.Name = "label3";
      this.label3.Size = new System.Drawing.Size(100, 24);
      this.label3.TabIndex = 5;
      this.label3.Text = "Base Directory";
      //
      // cmdBrowse
      //
      this.cmdBrowse.Font = new System.Drawing.Font("Tahoma", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
      this.cmdBrowse.Location = new System.Drawing.Point(376, 60);
      this.cmdBrowse.Name = "cmdBrowse";
      this.cmdBrowse.Size = new System.Drawing.Size(56, 20);
      this.cmdBrowse.TabIndex = 7;
      this.cmdBrowse.Text = "&Browse";
      this.cmdBrowse.Click += new System.EventHandler(this.BrowseForBaseDirectory);
      //
      // cmdOK
      //
      this.cmdOK.DialogResult = System.Windows.Forms.DialogResult.OK;
      this.cmdOK.Enabled = false;
      this.cmdOK.Font = new System.Drawing.Font("Tahoma", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
      this.cmdOK.Location = new System.Drawing.Point(272, 536);
      this.cmdOK.Name = "cmdOK";
      this.cmdOK.Size = new System.Drawing.Size(75, 23);
      this.cmdOK.TabIndex = 8;
      this.cmdOK.Text = "&OK";
      this.cmdOK.Click += new System.EventHandler(this.SaveProjectFileAndClose);
      //
      // cmdCancel
      //
      this.cmdCancel.DialogResult = System.Windows.Forms.DialogResult.Cancel;
      this.cmdCancel.Font = new System.Drawing.Font("Tahoma", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
      this.cmdCancel.Location = new System.Drawing.Point(360, 536);
      this.cmdCancel.Name = "cmdCancel";
      this.cmdCancel.Size = new System.Drawing.Size(75, 23);
      this.cmdCancel.TabIndex = 9;
      this.cmdCancel.Text = "&Cancel";
      //
      // clbFileTypes
      //
      this.clbFileTypes.Location = new System.Drawing.Point(112, 149);
      this.clbFileTypes.Name = "clbFileTypes";
      this.clbFileTypes.Size = new System.Drawing.Size(320, 334);
      this.clbFileTypes.TabIndex = 10;
      //
      // cmdSaveAs
      //
      this.cmdSaveAs.Font = new System.Drawing.Font("Tahoma", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
      this.cmdSaveAs.Location = new System.Drawing.Point(376, 496);
      this.cmdSaveAs.Name = "cmdSaveAs";
      this.cmdSaveAs.Size = new System.Drawing.Size(56, 20);
      this.cmdSaveAs.TabIndex = 14;
      this.cmdSaveAs.Text = "&Save As";
      this.cmdSaveAs.Click += new System.EventHandler(this.ProjectFileSaveAs);
      //
      // txtProj
      //
      this.txtProj.Location = new System.Drawing.Point(112, 496);
      this.txtProj.Name = "txtProj";
      this.txtProj.ReadOnly = true;
      this.txtProj.Size = new System.Drawing.Size(256, 20);
      this.txtProj.TabIndex = 13;
      this.txtProj.TextChanged += new System.EventHandler(this.ProjectFileChanged);
      //
      // label5
      //
      this.label5.Font = new System.Drawing.Font("Tahoma", 8.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
      this.label5.Location = new System.Drawing.Point(8, 499);
      this.label5.Name = "label5";
      this.label5.Size = new System.Drawing.Size(100, 24);
      this.label5.TabIndex = 12;
      this.label5.Text = "Project File";
      //
      // sfdProj
      //
      this.sfdProj.DefaultExt = "txt";
      this.sfdProj.Filter = "KEPM Project files|*.txt";
      this.sfdProj.Title = "Save Project File As...";
      //
      // label6
      //
      this.label6.Font = new System.Drawing.Font("Tahoma", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
      this.label6.Location = new System.Drawing.Point(256, 10);
      this.label6.Name = "label6";
      this.label6.Size = new System.Drawing.Size(100, 24);
      this.label6.TabIndex = 15;
      //
      // chkFileTypes
      //
      this.chkFileTypes.AutoSize = true;
      this.chkFileTypes.Checked = true;
      this.chkFileTypes.CheckState = System.Windows.Forms.CheckState.Indeterminate;
      this.chkFileTypes.Font = new System.Drawing.Font("Tahoma", 8.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
      this.chkFileTypes.Location = new System.Drawing.Point(11, 149);
      this.chkFileTypes.Name = "chkFileTypes";
      this.chkFileTypes.Size = new System.Drawing.Size(82, 17);
      this.chkFileTypes.TabIndex = 16;
      this.chkFileTypes.Text = "File Types";
      this.chkFileTypes.UseVisualStyleBackColor = true;
      this.chkFileTypes.CheckedChanged += new System.EventHandler(this.FileTypesChanged);
      //
      // label4
      //
      this.label4.Font = new System.Drawing.Font("Tahoma", 8.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
      this.label4.Location = new System.Drawing.Point(8, 88);
      this.label4.Name = "label4";
      this.label4.Size = new System.Drawing.Size(100, 35);
      this.label4.TabIndex = 17;
      this.label4.Text = "Excluded Directories";
      //
      // lbxExcludedDirectories
      //
      this.lbxExcludedDirectories.FormattingEnabled = true;
      this.lbxExcludedDirectories.Location = new System.Drawing.Point(112, 87);
      this.lbxExcludedDirectories.Name = "lbxExcludedDirectories";
      this.lbxExcludedDirectories.Size = new System.Drawing.Size(256, 56);
      this.lbxExcludedDirectories.TabIndex = 18;
      //
      // cmdSelect
      //
      this.cmdSelect.Enabled = false;
      this.cmdSelect.Font = new System.Drawing.Font("Tahoma", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
      this.cmdSelect.Image = global::SourceCodeMetrics.Krakatau.Kepm.Properties.Resources.directory_selector;
      this.cmdSelect.Location = new System.Drawing.Point(376, 88);
      this.cmdSelect.Name = "cmdSelect";
      this.cmdSelect.Size = new System.Drawing.Size(56, 55);
      this.cmdSelect.TabIndex = 19;
      this.cmdSelect.Click += new System.EventHandler(this.SelectExcludedDirectories);
      //
      // NewProject
      //
      this.AutoScaleBaseSize = new System.Drawing.Size(5, 13);
      this.CancelButton = this.cmdCancel;
      this.ClientSize = new System.Drawing.Size(448, 566);
      this.Controls.Add(this.cmdSelect);
      this.Controls.Add(this.lbxExcludedDirectories);
      this.Controls.Add(this.label4);
      this.Controls.Add(this.chkFileTypes);
      this.Controls.Add(this.label6);
      this.Controls.Add(this.cmdSaveAs);
      this.Controls.Add(this.txtProj);
      this.Controls.Add(this.label5);
      this.Controls.Add(this.clbFileTypes);
      this.Controls.Add(this.cmdCancel);
      this.Controls.Add(this.cmdOK);
      this.Controls.Add(this.cmdBrowse);
      this.Controls.Add(this.txtBase);
      this.Controls.Add(this.label3);
      this.Controls.Add(this.dtpSnapshot);
      this.Controls.Add(this.label2);
      this.Controls.Add(this.txtTitle);
      this.Controls.Add(this.label1);
      this.Icon = ((System.Drawing.Icon)(resources.GetObject("$this.Icon")));
      this.MaximumSize = new System.Drawing.Size(456, 600);
      this.MinimumSize = new System.Drawing.Size(456, 600);
      this.Name = "NewProject";
      this.Text = "New Project Wizard";
      this.ResumeLayout(false);
      this.PerformLayout();

    }
    #endregion

    private System.Windows.Forms.Label label1;
    private System.Windows.Forms.TextBox txtTitle;
    private System.Windows.Forms.Label label2;
    private System.Windows.Forms.DateTimePicker dtpSnapshot;
    private System.Windows.Forms.FolderBrowserDialog fbdBase;
    private System.Windows.Forms.Label label3;
    private System.Windows.Forms.Button cmdBrowse;
    private System.Windows.Forms.TextBox txtBase;
    private System.Windows.Forms.Button cmdOK;
    private System.Windows.Forms.Button cmdCancel;
    private System.Windows.Forms.CheckedListBox clbFileTypes;
    private Project _project = null;
    private System.Windows.Forms.Label label5;
    private System.Windows.Forms.Button cmdSaveAs;
    private System.Windows.Forms.TextBox txtProj;
    private System.Windows.Forms.SaveFileDialog sfdProj;
    private CheckBox chkFileTypes;
    private Label label4;
    private ListBox lbxExcludedDirectories;
    private Button cmdSelect;
    private System.Windows.Forms.Label label6;
  }
}