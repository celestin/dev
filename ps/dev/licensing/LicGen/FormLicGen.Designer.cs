/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 * Power Software License Generator
 * Copyright (c) 2006,2008,2009 PowerSoftware.com
 * Author Craig McKay <craig.mckay@powersoftware.com>
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  27-Sep-08   1000 : Upgraded to include Classic licensing options.
 * CAM  26-Mar-09  10404 : Added Assembler (AY), Python (PY), JavaScript (JT) and HTML (HT).
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

using System;
using System.Drawing;
using System.ComponentModel;
using System.Windows.Forms;

namespace PowerSoftware.Tools.Licensing.LicGen
{
  partial class FormLicGen
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
      this.components = new System.ComponentModel.Container();
      System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(FormLicGen));
      this.cmbHostid = new System.Windows.Forms.ComboBox();
      this.txtName = new System.Windows.Forms.TextBox();
      this.fmeProds = new System.Windows.Forms.GroupBox();
      this.chkAllClassic = new System.Windows.Forms.CheckBox();
      this.txtClassic = new System.Windows.Forms.TextBox();
      this.chkClassic = new System.Windows.Forms.CheckBox();
      this.chkAll = new System.Windows.Forms.CheckBox();
      this.txtQty = new System.Windows.Forms.TextBox();
      this.chkProd = new System.Windows.Forms.CheckBox();
      this.ToolTip1 = new System.Windows.Forms.ToolTip(this.components);
      this.lblHostid = new System.Windows.Forms.Label();
      this.lblDesc = new System.Windows.Forms.Label();
      this.optLicFloat = new System.Windows.Forms.RadioButton();
      this.optLicHost = new System.Windows.Forms.RadioButton();
      this.optLicTimed = new System.Windows.Forms.RadioButton();
      this.frmLicType = new System.Windows.Forms.GroupBox();
      this.txtOutput = new System.Windows.Forms.TextBox();
      this.dtpDate = new System.Windows.Forms.DateTimePicker();
      this.toolStripContainer1 = new System.Windows.Forms.ToolStripContainer();
      this.tableLayoutPanel1 = new System.Windows.Forms.TableLayoutPanel();
      this.panel1 = new System.Windows.Forms.Panel();
      this.panel2 = new System.Windows.Forms.Panel();
      this.menuStrip1 = new System.Windows.Forms.MenuStrip();
      this.fileToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
      this.exitToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
      this.toolsToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
      this.generateToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
      this.toolStripSeparator1 = new System.Windows.Forms.ToolStripSeparator();
      this.optionsToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
      this.helpToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
      this.aboutToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
      this.toolStrip1 = new System.Windows.Forms.ToolStrip();
      this._tsbHeph = new System.Windows.Forms.ToolStripButton();
      this._tsbGenerate = new System.Windows.Forms.ToolStripButton();
      this._tsbOptions = new System.Windows.Forms.ToolStripButton();
      this._tsbExit = new System.Windows.Forms.ToolStripButton();
      this.fmeProds.SuspendLayout();
      this.frmLicType.SuspendLayout();
      this.toolStripContainer1.ContentPanel.SuspendLayout();
      this.toolStripContainer1.TopToolStripPanel.SuspendLayout();
      this.toolStripContainer1.SuspendLayout();
      this.tableLayoutPanel1.SuspendLayout();
      this.panel1.SuspendLayout();
      this.panel2.SuspendLayout();
      this.menuStrip1.SuspendLayout();
      this.toolStrip1.SuspendLayout();
      this.SuspendLayout();
      // 
      // cmbHostid
      // 
      this.cmbHostid.BackColor = System.Drawing.SystemColors.Window;
      this.cmbHostid.Cursor = System.Windows.Forms.Cursors.Default;
      this.cmbHostid.Font = new System.Drawing.Font("Tahoma", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
      this.cmbHostid.ForeColor = System.Drawing.SystemColors.WindowText;
      this.cmbHostid.Items.AddRange(new object[] {
            "Any"});
      this.cmbHostid.Location = new System.Drawing.Point(296, 3);
      this.cmbHostid.Name = "cmbHostid";
      this.cmbHostid.RightToLeft = System.Windows.Forms.RightToLeft.No;
      this.cmbHostid.Size = new System.Drawing.Size(105, 21);
      this.cmbHostid.TabIndex = 25;
      this.cmbHostid.Text = "Any";
      // 
      // txtName
      // 
      this.txtName.AcceptsReturn = true;
      this.txtName.BackColor = System.Drawing.SystemColors.Window;
      this.txtName.Cursor = System.Windows.Forms.Cursors.IBeam;
      this.txtName.Font = new System.Drawing.Font("Tahoma", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
      this.txtName.ForeColor = System.Drawing.SystemColors.WindowText;
      this.txtName.Location = new System.Drawing.Point(60, 3);
      this.txtName.MaxLength = 0;
      this.txtName.Name = "txtName";
      this.txtName.RightToLeft = System.Windows.Forms.RightToLeft.No;
      this.txtName.Size = new System.Drawing.Size(161, 21);
      this.txtName.TabIndex = 18;
      // 
      // fmeProds
      // 
      this.fmeProds.BackColor = System.Drawing.SystemColors.Control;
      this.fmeProds.Controls.Add(this.chkAllClassic);
      this.fmeProds.Controls.Add(this.txtClassic);
      this.fmeProds.Controls.Add(this.chkClassic);
      this.fmeProds.Controls.Add(this.chkAll);
      this.fmeProds.Controls.Add(this.txtQty);
      this.fmeProds.Controls.Add(this.chkProd);
      this.fmeProds.Font = new System.Drawing.Font("Tahoma", 8.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
      this.fmeProds.ForeColor = System.Drawing.SystemColors.ControlText;
      this.fmeProds.Location = new System.Drawing.Point(1, 0);
      this.fmeProds.Name = "fmeProds";
      this.fmeProds.RightToLeft = System.Windows.Forms.RightToLeft.No;
      this.fmeProds.Size = new System.Drawing.Size(401, 86);
      this.fmeProds.TabIndex = 23;
      this.fmeProds.TabStop = false;
      this.fmeProds.Text = "&Select Products";
      // 
      // chkAllClassic
      // 
      this.chkAllClassic.BackColor = System.Drawing.SystemColors.Control;
      this.chkAllClassic.Cursor = System.Windows.Forms.Cursors.Default;
      this.chkAllClassic.Font = new System.Drawing.Font("Tahoma", 8.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
      this.chkAllClassic.ForeColor = System.Drawing.SystemColors.ControlText;
      this.chkAllClassic.Location = new System.Drawing.Point(243, 24);
      this.chkAllClassic.Name = "chkAllClassic";
      this.chkAllClassic.RightToLeft = System.Windows.Forms.RightToLeft.No;
      this.chkAllClassic.Size = new System.Drawing.Size(137, 17);
      this.chkAllClassic.TabIndex = 16;
      this.chkAllClassic.Text = "Select All Classic";
      this.chkAllClassic.UseVisualStyleBackColor = false;
      this.chkAllClassic.CheckedChanged += new System.EventHandler(this.chkAllClassic_CheckedChanged);
      // 
      // txtClassic
      // 
      this.txtClassic.AcceptsReturn = true;
      this.txtClassic.BackColor = System.Drawing.SystemColors.Window;
      this.txtClassic.Cursor = System.Windows.Forms.Cursors.IBeam;
      this.txtClassic.Font = new System.Drawing.Font("Tahoma", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
      this.txtClassic.ForeColor = System.Drawing.SystemColors.WindowText;
      this.txtClassic.Location = new System.Drawing.Point(328, 44);
      this.txtClassic.MaxLength = 0;
      this.txtClassic.Name = "txtClassic";
      this.txtClassic.RightToLeft = System.Windows.Forms.RightToLeft.No;
      this.txtClassic.Size = new System.Drawing.Size(57, 21);
      this.txtClassic.TabIndex = 15;
      // 
      // chkClassic
      // 
      this.chkClassic.BackColor = System.Drawing.SystemColors.Control;
      this.chkClassic.Cursor = System.Windows.Forms.Cursors.Default;
      this.chkClassic.Font = new System.Drawing.Font("Tahoma", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
      this.chkClassic.ForeColor = System.Drawing.SystemColors.ControlText;
      this.chkClassic.Location = new System.Drawing.Point(243, 46);
      this.chkClassic.Name = "chkClassic";
      this.chkClassic.RightToLeft = System.Windows.Forms.RightToLeft.No;
      this.chkClassic.Size = new System.Drawing.Size(73, 17);
      this.chkClassic.TabIndex = 14;
      this.chkClassic.Text = "Start";
      this.chkClassic.UseVisualStyleBackColor = false;
      // 
      // chkAll
      // 
      this.chkAll.BackColor = System.Drawing.SystemColors.Control;
      this.chkAll.Cursor = System.Windows.Forms.Cursors.Default;
      this.chkAll.Font = new System.Drawing.Font("Tahoma", 8.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
      this.chkAll.ForeColor = System.Drawing.SystemColors.ControlText;
      this.chkAll.Location = new System.Drawing.Point(16, 24);
      this.chkAll.Name = "chkAll";
      this.chkAll.RightToLeft = System.Windows.Forms.RightToLeft.No;
      this.chkAll.Size = new System.Drawing.Size(96, 17);
      this.chkAll.TabIndex = 13;
      this.chkAll.Text = "Select All";
      this.chkAll.UseVisualStyleBackColor = false;
      this.chkAll.CheckedChanged += new System.EventHandler(this.chkAll_CheckedChanged);
      // 
      // txtQty
      // 
      this.txtQty.AcceptsReturn = true;
      this.txtQty.BackColor = System.Drawing.SystemColors.Window;
      this.txtQty.Cursor = System.Windows.Forms.Cursors.IBeam;
      this.txtQty.Font = new System.Drawing.Font("Tahoma", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
      this.txtQty.ForeColor = System.Drawing.SystemColors.WindowText;
      this.txtQty.Location = new System.Drawing.Point(95, 44);
      this.txtQty.MaxLength = 0;
      this.txtQty.Name = "txtQty";
      this.txtQty.RightToLeft = System.Windows.Forms.RightToLeft.No;
      this.txtQty.Size = new System.Drawing.Size(57, 21);
      this.txtQty.TabIndex = 12;
      // 
      // chkProd
      // 
      this.chkProd.BackColor = System.Drawing.SystemColors.Control;
      this.chkProd.Cursor = System.Windows.Forms.Cursors.Default;
      this.chkProd.Font = new System.Drawing.Font("Tahoma", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
      this.chkProd.ForeColor = System.Drawing.SystemColors.ControlText;
      this.chkProd.Location = new System.Drawing.Point(16, 46);
      this.chkProd.Name = "chkProd";
      this.chkProd.RightToLeft = System.Windows.Forms.RightToLeft.No;
      this.chkProd.Size = new System.Drawing.Size(73, 17);
      this.chkProd.TabIndex = 11;
      this.chkProd.Text = "Start";
      this.chkProd.UseVisualStyleBackColor = false;
      // 
      // lblHostid
      // 
      this.lblHostid.BackColor = System.Drawing.SystemColors.Control;
      this.lblHostid.Cursor = System.Windows.Forms.Cursors.Default;
      this.lblHostid.Font = new System.Drawing.Font("Tahoma", 8.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
      this.lblHostid.ForeColor = System.Drawing.SystemColors.ControlText;
      this.lblHostid.Location = new System.Drawing.Point(241, 5);
      this.lblHostid.Name = "lblHostid";
      this.lblHostid.RightToLeft = System.Windows.Forms.RightToLeft.No;
      this.lblHostid.Size = new System.Drawing.Size(49, 17);
      this.lblHostid.TabIndex = 24;
      this.lblHostid.Text = "Host &ID";
      // 
      // lblDesc
      // 
      this.lblDesc.BackColor = System.Drawing.SystemColors.Control;
      this.lblDesc.Cursor = System.Windows.Forms.Cursors.Default;
      this.lblDesc.Font = new System.Drawing.Font("Tahoma", 8.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
      this.lblDesc.ForeColor = System.Drawing.SystemColors.ControlText;
      this.lblDesc.Location = new System.Drawing.Point(4, 5);
      this.lblDesc.Name = "lblDesc";
      this.lblDesc.RightToLeft = System.Windows.Forms.RightToLeft.No;
      this.lblDesc.Size = new System.Drawing.Size(48, 17);
      this.lblDesc.TabIndex = 21;
      this.lblDesc.Text = "&Expiry";
      // 
      // optLicFloat
      // 
      this.optLicFloat.BackColor = System.Drawing.SystemColors.Control;
      this.optLicFloat.Cursor = System.Windows.Forms.Cursors.Default;
      this.optLicFloat.Font = new System.Drawing.Font("Tahoma", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
      this.optLicFloat.ForeColor = System.Drawing.SystemColors.ControlText;
      this.optLicFloat.Location = new System.Drawing.Point(300, 23);
      this.optLicFloat.Name = "optLicFloat";
      this.optLicFloat.RightToLeft = System.Windows.Forms.RightToLeft.No;
      this.optLicFloat.Size = new System.Drawing.Size(65, 17);
      this.optLicFloat.TabIndex = 17;
      this.optLicFloat.TabStop = true;
      this.optLicFloat.Text = "&Floating";
      this.optLicFloat.UseVisualStyleBackColor = false;
      this.optLicFloat.CheckedChanged += new System.EventHandler(this.optLicFloat_CheckedChanged);
      // 
      // optLicHost
      // 
      this.optLicHost.BackColor = System.Drawing.SystemColors.Control;
      this.optLicHost.Cursor = System.Windows.Forms.Cursors.Default;
      this.optLicHost.Font = new System.Drawing.Font("Tahoma", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
      this.optLicHost.ForeColor = System.Drawing.SystemColors.ControlText;
      this.optLicHost.Location = new System.Drawing.Point(151, 20);
      this.optLicHost.Name = "optLicHost";
      this.optLicHost.RightToLeft = System.Windows.Forms.RightToLeft.No;
      this.optLicHost.Size = new System.Drawing.Size(96, 17);
      this.optLicHost.TabIndex = 16;
      this.optLicHost.TabStop = true;
      this.optLicHost.Text = "&Host-locked";
      this.optLicHost.UseVisualStyleBackColor = false;
      this.optLicHost.CheckedChanged += new System.EventHandler(this.optLicHost_CheckedChanged);
      // 
      // optLicTimed
      // 
      this.optLicTimed.BackColor = System.Drawing.SystemColors.Control;
      this.optLicTimed.Checked = true;
      this.optLicTimed.Cursor = System.Windows.Forms.Cursors.Default;
      this.optLicTimed.Font = new System.Drawing.Font("Tahoma", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
      this.optLicTimed.ForeColor = System.Drawing.SystemColors.ControlText;
      this.optLicTimed.Location = new System.Drawing.Point(6, 20);
      this.optLicTimed.Name = "optLicTimed";
      this.optLicTimed.RightToLeft = System.Windows.Forms.RightToLeft.No;
      this.optLicTimed.Size = new System.Drawing.Size(96, 17);
      this.optLicTimed.TabIndex = 15;
      this.optLicTimed.TabStop = true;
      this.optLicTimed.Text = "&Timed Expiry";
      this.optLicTimed.UseVisualStyleBackColor = false;
      this.optLicTimed.CheckedChanged += new System.EventHandler(this.optLicTimed_CheckedChanged);
      // 
      // frmLicType
      // 
      this.frmLicType.BackColor = System.Drawing.SystemColors.Control;
      this.frmLicType.Controls.Add(this.optLicTimed);
      this.frmLicType.Controls.Add(this.optLicFloat);
      this.frmLicType.Controls.Add(this.optLicHost);
      this.frmLicType.Font = new System.Drawing.Font("Tahoma", 8.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
      this.frmLicType.ForeColor = System.Drawing.SystemColors.ControlText;
      this.frmLicType.Location = new System.Drawing.Point(3, 3);
      this.frmLicType.Name = "frmLicType";
      this.frmLicType.RightToLeft = System.Windows.Forms.RightToLeft.No;
      this.frmLicType.Size = new System.Drawing.Size(401, 46);
      this.frmLicType.TabIndex = 22;
      this.frmLicType.TabStop = false;
      this.frmLicType.Text = "&License Type";
      // 
      // txtOutput
      // 
      this.txtOutput.AcceptsReturn = true;
      this.txtOutput.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(255)))), ((int)(((byte)(255)))), ((int)(((byte)(128)))));
      this.txtOutput.Cursor = System.Windows.Forms.Cursors.IBeam;
      this.txtOutput.Dock = System.Windows.Forms.DockStyle.Fill;
      this.txtOutput.Font = new System.Drawing.Font("Tahoma", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
      this.txtOutput.ForeColor = System.Drawing.SystemColors.WindowText;
      this.txtOutput.Location = new System.Drawing.Point(414, 3);
      this.txtOutput.MaxLength = 0;
      this.txtOutput.Multiline = true;
      this.txtOutput.Name = "txtOutput";
      this.txtOutput.ReadOnly = true;
      this.txtOutput.RightToLeft = System.Windows.Forms.RightToLeft.No;
      this.tableLayoutPanel1.SetRowSpan(this.txtOutput, 3);
      this.txtOutput.ScrollBars = System.Windows.Forms.ScrollBars.Vertical;
      this.txtOutput.Size = new System.Drawing.Size(455, 304);
      this.txtOutput.TabIndex = 20;
      // 
      // dtpDate
      // 
      this.dtpDate.Font = new System.Drawing.Font("Tahoma", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
      this.dtpDate.Location = new System.Drawing.Point(60, 3);
      this.dtpDate.Name = "dtpDate";
      this.dtpDate.Size = new System.Drawing.Size(128, 21);
      this.dtpDate.TabIndex = 26;
      // 
      // toolStripContainer1
      // 
      // 
      // toolStripContainer1.ContentPanel
      // 
      this.toolStripContainer1.ContentPanel.Controls.Add(this.tableLayoutPanel1);
      this.toolStripContainer1.ContentPanel.Size = new System.Drawing.Size(872, 310);
      this.toolStripContainer1.Dock = System.Windows.Forms.DockStyle.Fill;
      this.toolStripContainer1.Location = new System.Drawing.Point(0, 0);
      this.toolStripContainer1.Name = "toolStripContainer1";
      this.toolStripContainer1.Size = new System.Drawing.Size(872, 359);
      this.toolStripContainer1.TabIndex = 27;
      this.toolStripContainer1.Text = "toolStripContainer1";
      // 
      // toolStripContainer1.TopToolStripPanel
      // 
      this.toolStripContainer1.TopToolStripPanel.Controls.Add(this.menuStrip1);
      this.toolStripContainer1.TopToolStripPanel.Controls.Add(this.toolStrip1);
      // 
      // tableLayoutPanel1
      // 
      this.tableLayoutPanel1.ColumnCount = 2;
      this.tableLayoutPanel1.ColumnStyles.Add(new System.Windows.Forms.ColumnStyle(System.Windows.Forms.SizeType.Percent, 47.13303F));
      this.tableLayoutPanel1.ColumnStyles.Add(new System.Windows.Forms.ColumnStyle(System.Windows.Forms.SizeType.Percent, 52.86697F));
      this.tableLayoutPanel1.Controls.Add(this.frmLicType, 0, 0);
      this.tableLayoutPanel1.Controls.Add(this.panel1, 0, 1);
      this.tableLayoutPanel1.Controls.Add(this.txtOutput, 1, 0);
      this.tableLayoutPanel1.Controls.Add(this.panel2, 0, 2);
      this.tableLayoutPanel1.Dock = System.Windows.Forms.DockStyle.Fill;
      this.tableLayoutPanel1.Location = new System.Drawing.Point(0, 0);
      this.tableLayoutPanel1.Name = "tableLayoutPanel1";
      this.tableLayoutPanel1.RowCount = 3;
      this.tableLayoutPanel1.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Absolute, 52F));
      this.tableLayoutPanel1.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Absolute, 43F));
      this.tableLayoutPanel1.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Percent, 100F));
      this.tableLayoutPanel1.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Absolute, 20F));
      this.tableLayoutPanel1.Size = new System.Drawing.Size(872, 310);
      this.tableLayoutPanel1.TabIndex = 0;
      // 
      // panel1
      // 
      this.panel1.Controls.Add(this.dtpDate);
      this.panel1.Controls.Add(this.txtName);
      this.panel1.Controls.Add(this.cmbHostid);
      this.panel1.Controls.Add(this.lblHostid);
      this.panel1.Controls.Add(this.lblDesc);
      this.panel1.Dock = System.Windows.Forms.DockStyle.Fill;
      this.panel1.Location = new System.Drawing.Point(3, 55);
      this.panel1.Name = "panel1";
      this.panel1.Size = new System.Drawing.Size(405, 37);
      this.panel1.TabIndex = 23;
      // 
      // panel2
      // 
      this.panel2.Controls.Add(this.fmeProds);
      this.panel2.Dock = System.Windows.Forms.DockStyle.Fill;
      this.panel2.Location = new System.Drawing.Point(3, 98);
      this.panel2.Name = "panel2";
      this.panel2.Size = new System.Drawing.Size(405, 209);
      this.panel2.TabIndex = 24;
      // 
      // menuStrip1
      // 
      this.menuStrip1.Dock = System.Windows.Forms.DockStyle.None;
      this.menuStrip1.Items.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.fileToolStripMenuItem,
            this.toolsToolStripMenuItem,
            this.helpToolStripMenuItem});
      this.menuStrip1.Location = new System.Drawing.Point(0, 0);
      this.menuStrip1.Name = "menuStrip1";
      this.menuStrip1.Size = new System.Drawing.Size(872, 24);
      this.menuStrip1.TabIndex = 0;
      this.menuStrip1.Text = "menuStrip1";
      // 
      // fileToolStripMenuItem
      // 
      this.fileToolStripMenuItem.DropDownItems.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.exitToolStripMenuItem});
      this.fileToolStripMenuItem.Name = "fileToolStripMenuItem";
      this.fileToolStripMenuItem.Size = new System.Drawing.Size(37, 20);
      this.fileToolStripMenuItem.Text = "&File";
      // 
      // exitToolStripMenuItem
      // 
      this.exitToolStripMenuItem.Image = global::PowerSoftware.Tools.LicGen.Properties.Resources.Exit;
      this.exitToolStripMenuItem.Name = "exitToolStripMenuItem";
      this.exitToolStripMenuItem.ShortcutKeys = ((System.Windows.Forms.Keys)((System.Windows.Forms.Keys.Control | System.Windows.Forms.Keys.X)));
      this.exitToolStripMenuItem.Size = new System.Drawing.Size(133, 22);
      this.exitToolStripMenuItem.Text = "E&xit";
      this.exitToolStripMenuItem.Click += new System.EventHandler(this.exitToolStripMenuItem_Click);
      // 
      // toolsToolStripMenuItem
      // 
      this.toolsToolStripMenuItem.DropDownItems.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.generateToolStripMenuItem,
            this.toolStripSeparator1,
            this.optionsToolStripMenuItem});
      this.toolsToolStripMenuItem.Name = "toolsToolStripMenuItem";
      this.toolsToolStripMenuItem.Size = new System.Drawing.Size(48, 20);
      this.toolsToolStripMenuItem.Text = "&Tools";
      // 
      // generateToolStripMenuItem
      // 
      this.generateToolStripMenuItem.Image = global::PowerSoftware.Tools.LicGen.Properties.Resources.Generate;
      this.generateToolStripMenuItem.Name = "generateToolStripMenuItem";
      this.generateToolStripMenuItem.ShortcutKeys = ((System.Windows.Forms.Keys)((System.Windows.Forms.Keys.Control | System.Windows.Forms.Keys.G)));
      this.generateToolStripMenuItem.Size = new System.Drawing.Size(163, 22);
      this.generateToolStripMenuItem.Text = "&Generate";
      this.generateToolStripMenuItem.Click += new System.EventHandler(this.generateToolStripMenuItem_Click);
      // 
      // toolStripSeparator1
      // 
      this.toolStripSeparator1.Name = "toolStripSeparator1";
      this.toolStripSeparator1.Size = new System.Drawing.Size(160, 6);
      // 
      // optionsToolStripMenuItem
      // 
      this.optionsToolStripMenuItem.Image = global::PowerSoftware.Tools.LicGen.Properties.Resources.Options;
      this.optionsToolStripMenuItem.Name = "optionsToolStripMenuItem";
      this.optionsToolStripMenuItem.ShortcutKeys = ((System.Windows.Forms.Keys)((System.Windows.Forms.Keys.Control | System.Windows.Forms.Keys.O)));
      this.optionsToolStripMenuItem.Size = new System.Drawing.Size(163, 22);
      this.optionsToolStripMenuItem.Text = "&Options";
      this.optionsToolStripMenuItem.Click += new System.EventHandler(this.optionsToolStripMenuItem_Click);
      // 
      // helpToolStripMenuItem
      // 
      this.helpToolStripMenuItem.DropDownItems.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.aboutToolStripMenuItem});
      this.helpToolStripMenuItem.Name = "helpToolStripMenuItem";
      this.helpToolStripMenuItem.Size = new System.Drawing.Size(44, 20);
      this.helpToolStripMenuItem.Text = "&Help";
      // 
      // aboutToolStripMenuItem
      // 
      this.aboutToolStripMenuItem.Image = global::PowerSoftware.Tools.LicGen.Properties.Resources.HelpAbout;
      this.aboutToolStripMenuItem.Name = "aboutToolStripMenuItem";
      this.aboutToolStripMenuItem.Size = new System.Drawing.Size(107, 22);
      this.aboutToolStripMenuItem.Text = "&About";
      this.aboutToolStripMenuItem.Click += new System.EventHandler(this.AboutLicenseGenerator);
      // 
      // toolStrip1
      // 
      this.toolStrip1.Dock = System.Windows.Forms.DockStyle.None;
      this.toolStrip1.Items.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this._tsbHeph,
            this._tsbGenerate,
            this._tsbOptions,
            this._tsbExit});
      this.toolStrip1.Location = new System.Drawing.Point(3, 24);
      this.toolStrip1.Name = "toolStrip1";
      this.toolStrip1.Size = new System.Drawing.Size(320, 25);
      this.toolStrip1.TabIndex = 1;
      // 
      // _tsbHeph
      // 
      this._tsbHeph.Checked = true;
      this._tsbHeph.CheckOnClick = true;
      this._tsbHeph.CheckState = System.Windows.Forms.CheckState.Checked;
      this._tsbHeph.Image = global::PowerSoftware.Tools.LicGen.Properties.Resources.HephaestusLogo;
      this._tsbHeph.ImageTransparentColor = System.Drawing.Color.Magenta;
      this._tsbHeph.Name = "_tsbHeph";
      this._tsbHeph.Size = new System.Drawing.Size(89, 22);
      this._tsbHeph.Text = "Hephaestus";
      this._tsbHeph.ToolTipText = "Use Hephaestus License";
      this._tsbHeph.CheckStateChanged += new System.EventHandler(this.HephaestusStateChanged);
      // 
      // _tsbGenerate
      // 
      this._tsbGenerate.Image = global::PowerSoftware.Tools.LicGen.Properties.Resources.Generate;
      this._tsbGenerate.ImageTransparentColor = System.Drawing.Color.Magenta;
      this._tsbGenerate.Name = "_tsbGenerate";
      this._tsbGenerate.Size = new System.Drawing.Size(74, 22);
      this._tsbGenerate.Text = "Generate";
      this._tsbGenerate.Click += new System.EventHandler(this._tsbGenerate_Click);
      // 
      // _tsbOptions
      // 
      this._tsbOptions.Image = global::PowerSoftware.Tools.LicGen.Properties.Resources.Options;
      this._tsbOptions.ImageTransparentColor = System.Drawing.Color.Magenta;
      this._tsbOptions.Name = "_tsbOptions";
      this._tsbOptions.Size = new System.Drawing.Size(69, 22);
      this._tsbOptions.Text = "Options";
      this._tsbOptions.Click += new System.EventHandler(this._tsbOptions_Click);
      // 
      // _tsbExit
      // 
      this._tsbExit.Image = global::PowerSoftware.Tools.LicGen.Properties.Resources.Exit;
      this._tsbExit.ImageTransparentColor = System.Drawing.Color.Magenta;
      this._tsbExit.Name = "_tsbExit";
      this._tsbExit.Size = new System.Drawing.Size(45, 22);
      this._tsbExit.Text = "Exit";
      this._tsbExit.Click += new System.EventHandler(this._tsbExit_Click);
      // 
      // FormLicGen
      // 
      this.AutoScaleBaseSize = new System.Drawing.Size(5, 13);
      this.ClientSize = new System.Drawing.Size(872, 359);
      this.Controls.Add(this.toolStripContainer1);
      this.Icon = ((System.Drawing.Icon)(resources.GetObject("$this.Icon")));
      this.MainMenuStrip = this.menuStrip1;
      this.Name = "FormLicGen";
      this.Text = "PowerSoftware.com License Generator";
      this.fmeProds.ResumeLayout(false);
      this.fmeProds.PerformLayout();
      this.frmLicType.ResumeLayout(false);
      this.toolStripContainer1.ContentPanel.ResumeLayout(false);
      this.toolStripContainer1.TopToolStripPanel.ResumeLayout(false);
      this.toolStripContainer1.TopToolStripPanel.PerformLayout();
      this.toolStripContainer1.ResumeLayout(false);
      this.toolStripContainer1.PerformLayout();
      this.tableLayoutPanel1.ResumeLayout(false);
      this.tableLayoutPanel1.PerformLayout();
      this.panel1.ResumeLayout(false);
      this.panel1.PerformLayout();
      this.panel2.ResumeLayout(false);
      this.menuStrip1.ResumeLayout(false);
      this.menuStrip1.PerformLayout();
      this.toolStrip1.ResumeLayout(false);
      this.toolStrip1.PerformLayout();
      this.ResumeLayout(false);

    }
    #endregion

    private CheckBox chkAll;
    private TextBox txtClassic;
    private CheckBox chkClassic;
    private CheckBox chkAllClassic;
    private TableLayoutPanel tableLayoutPanel1;
    private Panel panel1;
    private ToolStripContainer toolStripContainer1;
    private Panel panel2;
    private MenuStrip menuStrip1;
    private ToolStripMenuItem fileToolStripMenuItem;
    private ToolStripMenuItem exitToolStripMenuItem;
    private ToolStrip toolStrip1;
    private ToolStripButton _tsbGenerate;
    private ToolStripButton _tsbOptions;
    private ComboBox cmbHostid;
    private TextBox txtName;
    private GroupBox fmeProds;
    private ToolTip ToolTip1;
    private Label lblHostid;
    private Label lblDesc;
    private RadioButton optLicFloat;
    private RadioButton optLicHost;
    private RadioButton optLicTimed;
    private GroupBox frmLicType;
    private TextBox txtOutput;
    private DateTimePicker dtpDate;
    private TextBox txtQty;
    private CheckBox chkProd;
    private ToolStripMenuItem toolsToolStripMenuItem;
    private ToolStripMenuItem optionsToolStripMenuItem;
    private ToolStripMenuItem helpToolStripMenuItem;
    private ToolStripMenuItem aboutToolStripMenuItem;
    private ToolStripMenuItem generateToolStripMenuItem;
    private ToolStripSeparator toolStripSeparator1;
    private ToolStripButton _tsbExit;
    private ToolStripButton _tsbHeph;
  }
}