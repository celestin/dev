/* * * * * * * * * * * * * * * * * * * * * * * *
 * TMAX Ework Manager
 * Copyright (c) 2013 Front Burner Ltd
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  28-Oct-2013  11181 : Created.
 * * * * * * * * * * * * * * * * * * * * * * * */

namespace FrontBurner.Tmax.Apps.EworkManager.Forms
{
  partial class App
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
      System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(App));
      this.toolStripContainer1 = new System.Windows.Forms.ToolStripContainer();
      this.statusStrip1 = new System.Windows.Forms.StatusStrip();
      this.tableLayoutPanel1 = new System.Windows.Forms.TableLayoutPanel();
      this.label1 = new System.Windows.Forms.Label();
      this.txtEworkCrDb = new System.Windows.Forms.TextBox();
      this.toolStrip1 = new System.Windows.Forms.ToolStrip();
      this.tsbTakeNewSnapshot = new System.Windows.Forms.ToolStripButton();
      this.tsbExit = new System.Windows.Forms.ToolStripButton();
      this.tsbSetEworkCrDb = new System.Windows.Forms.ToolStripButton();
      this.statusLabel = new System.Windows.Forms.ToolStripStatusLabel();
      this.fileToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
      this.tsmTakeSnapshot = new System.Windows.Forms.ToolStripMenuItem();
      this.toolStripSeparator4 = new System.Windows.Forms.ToolStripSeparator();
      this.tsmSetEworkCrDb = new System.Windows.Forms.ToolStripMenuItem();
      this.toolStripSeparator1 = new System.Windows.Forms.ToolStripSeparator();
      this.exitToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
      this.helpToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
      this.aboutToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
      this.toolStripSeparator3 = new System.Windows.Forms.ToolStripSeparator();
      this.toolStripSeparator2 = new System.Windows.Forms.ToolStripSeparator();
      this.hierarchyStatus = new System.Windows.Forms.ImageList(this.components);
      this.cmsHierarchy = new System.Windows.Forms.ContextMenuStrip(this.components);
      this.copyToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
      this.ofdAccessDb = new System.Windows.Forms.OpenFileDialog();
      this.ofdEworkCrDb = new System.Windows.Forms.OpenFileDialog();
      this.bindingSource1 = new System.Windows.Forms.BindingSource(this.components);
      this.updateTimer = new System.Windows.Forms.Timer(this.components);
      this.tspSnapshot = new System.Windows.Forms.ToolStripProgressBar();
      this.tslStatus = new System.Windows.Forms.ToolStripStatusLabel();
      this.toolStripContainer1.BottomToolStripPanel.SuspendLayout();
      this.toolStripContainer1.ContentPanel.SuspendLayout();
      this.toolStripContainer1.TopToolStripPanel.SuspendLayout();
      this.toolStripContainer1.SuspendLayout();
      this.statusStrip1.SuspendLayout();
      this.tableLayoutPanel1.SuspendLayout();
      this.toolStrip1.SuspendLayout();
      this.cmsHierarchy.SuspendLayout();
      ((System.ComponentModel.ISupportInitialize)(this.bindingSource1)).BeginInit();
      this.SuspendLayout();
      // 
      // toolStripContainer1
      // 
      // 
      // toolStripContainer1.BottomToolStripPanel
      // 
      this.toolStripContainer1.BottomToolStripPanel.Controls.Add(this.statusStrip1);
      // 
      // toolStripContainer1.ContentPanel
      // 
      this.toolStripContainer1.ContentPanel.Controls.Add(this.tableLayoutPanel1);
      this.toolStripContainer1.ContentPanel.Size = new System.Drawing.Size(1019, 285);
      this.toolStripContainer1.Dock = System.Windows.Forms.DockStyle.Fill;
      this.toolStripContainer1.Location = new System.Drawing.Point(0, 0);
      this.toolStripContainer1.Name = "toolStripContainer1";
      this.toolStripContainer1.Size = new System.Drawing.Size(1019, 338);
      this.toolStripContainer1.TabIndex = 5;
      this.toolStripContainer1.Text = "toolStripContainer1";
      // 
      // toolStripContainer1.TopToolStripPanel
      // 
      this.toolStripContainer1.TopToolStripPanel.Controls.Add(this.toolStrip1);
      // 
      // statusStrip1
      // 
      this.statusStrip1.Dock = System.Windows.Forms.DockStyle.None;
      this.statusStrip1.Items.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.tspSnapshot,
            this.tslStatus});
      this.statusStrip1.Location = new System.Drawing.Point(0, 0);
      this.statusStrip1.Name = "statusStrip1";
      this.statusStrip1.Size = new System.Drawing.Size(1019, 22);
      this.statusStrip1.TabIndex = 0;
      // 
      // tableLayoutPanel1
      // 
      this.tableLayoutPanel1.ColumnCount = 2;
      this.tableLayoutPanel1.ColumnStyles.Add(new System.Windows.Forms.ColumnStyle(System.Windows.Forms.SizeType.Absolute, 200F));
      this.tableLayoutPanel1.ColumnStyles.Add(new System.Windows.Forms.ColumnStyle(System.Windows.Forms.SizeType.Percent, 100F));
      this.tableLayoutPanel1.Controls.Add(this.label1, 0, 0);
      this.tableLayoutPanel1.Controls.Add(this.txtEworkCrDb, 1, 0);
      this.tableLayoutPanel1.Dock = System.Windows.Forms.DockStyle.Fill;
      this.tableLayoutPanel1.Location = new System.Drawing.Point(0, 0);
      this.tableLayoutPanel1.Name = "tableLayoutPanel1";
      this.tableLayoutPanel1.RowCount = 4;
      this.tableLayoutPanel1.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Absolute, 40F));
      this.tableLayoutPanel1.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Absolute, 40F));
      this.tableLayoutPanel1.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Absolute, 40F));
      this.tableLayoutPanel1.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Percent, 100F));
      this.tableLayoutPanel1.Size = new System.Drawing.Size(1019, 285);
      this.tableLayoutPanel1.TabIndex = 0;
      // 
      // label1
      // 
      this.label1.Anchor = System.Windows.Forms.AnchorStyles.Left;
      this.label1.AutoSize = true;
      this.label1.Font = new System.Drawing.Font("Segoe UI", 11.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
      this.label1.Location = new System.Drawing.Point(3, 10);
      this.label1.Name = "label1";
      this.label1.Size = new System.Drawing.Size(131, 20);
      this.label1.TabIndex = 0;
      this.label1.Text = "Validate Database";
      // 
      // txtEworkCrDb
      // 
      this.txtEworkCrDb.Anchor = System.Windows.Forms.AnchorStyles.Left;
      this.txtEworkCrDb.Font = new System.Drawing.Font("Segoe UI", 11.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
      this.txtEworkCrDb.Location = new System.Drawing.Point(203, 6);
      this.txtEworkCrDb.Name = "txtEworkCrDb";
      this.txtEworkCrDb.ReadOnly = true;
      this.txtEworkCrDb.Size = new System.Drawing.Size(515, 27);
      this.txtEworkCrDb.TabIndex = 1;
      // 
      // toolStrip1
      // 
      this.toolStrip1.Dock = System.Windows.Forms.DockStyle.None;
      this.toolStrip1.Items.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.tsbTakeNewSnapshot,
            this.tsbExit,
            this.tsbSetEworkCrDb});
      this.toolStrip1.Location = new System.Drawing.Point(3, 0);
      this.toolStrip1.Name = "toolStrip1";
      this.toolStrip1.Size = new System.Drawing.Size(354, 31);
      this.toolStrip1.TabIndex = 1;
      // 
      // tsbTakeNewSnapshot
      // 
      this.tsbTakeNewSnapshot.Image = global::FrontBurner.Tmax.Apps.EworkManager.Properties.Resources.Snapshot;
      this.tsbTakeNewSnapshot.ImageScaling = System.Windows.Forms.ToolStripItemImageScaling.None;
      this.tsbTakeNewSnapshot.ImageTransparentColor = System.Drawing.Color.Magenta;
      this.tsbTakeNewSnapshot.Name = "tsbTakeNewSnapshot";
      this.tsbTakeNewSnapshot.Size = new System.Drawing.Size(137, 28);
      this.tsbTakeNewSnapshot.Text = "Take new Snapshot";
      this.tsbTakeNewSnapshot.Click += new System.EventHandler(this.TakeNewSnapshot);
      // 
      // tsbExit
      // 
      this.tsbExit.Image = global::FrontBurner.Tmax.Apps.EworkManager.Properties.Resources.Exit;
      this.tsbExit.ImageScaling = System.Windows.Forms.ToolStripItemImageScaling.None;
      this.tsbExit.ImageTransparentColor = System.Drawing.Color.Magenta;
      this.tsbExit.Name = "tsbExit";
      this.tsbExit.Size = new System.Drawing.Size(53, 28);
      this.tsbExit.Text = "Exit";
      this.tsbExit.Click += new System.EventHandler(this.ExitApplication);
      // 
      // tsbSetEworkCrDb
      // 
      this.tsbSetEworkCrDb.Image = global::FrontBurner.Tmax.Apps.EworkManager.Properties.Resources.MsAccess;
      this.tsbSetEworkCrDb.ImageScaling = System.Windows.Forms.ToolStripItemImageScaling.None;
      this.tsbSetEworkCrDb.ImageTransparentColor = System.Drawing.Color.Magenta;
      this.tsbSetEworkCrDb.Name = "tsbSetEworkCrDb";
      this.tsbSetEworkCrDb.Size = new System.Drawing.Size(152, 28);
      this.tsbSetEworkCrDb.Text = "Set EworkCR Database";
      this.tsbSetEworkCrDb.Click += new System.EventHandler(this.SetEworkCrDatabase);
      // 
      // statusLabel
      // 
      this.statusLabel.Name = "statusLabel";
      this.statusLabel.Size = new System.Drawing.Size(42, 17);
      this.statusLabel.Text = "Ready.";
      // 
      // fileToolStripMenuItem
      // 
      this.fileToolStripMenuItem.DropDownItems.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.tsmTakeSnapshot,
            this.toolStripSeparator4,
            this.tsmSetEworkCrDb,
            this.toolStripSeparator1,
            this.exitToolStripMenuItem});
      this.fileToolStripMenuItem.Name = "fileToolStripMenuItem";
      this.fileToolStripMenuItem.Size = new System.Drawing.Size(37, 20);
      this.fileToolStripMenuItem.Text = "&File";
      // 
      // tsmTakeSnapshot
      // 
      this.tsmTakeSnapshot.ImageScaling = System.Windows.Forms.ToolStripItemImageScaling.None;
      this.tsmTakeSnapshot.Name = "tsmTakeSnapshot";
      this.tsmTakeSnapshot.Size = new System.Drawing.Size(191, 22);
      this.tsmTakeSnapshot.Text = "Take new &Snapshot";
      this.tsmTakeSnapshot.Click += new System.EventHandler(this.TakeNewSnapshot);
      // 
      // toolStripSeparator4
      // 
      this.toolStripSeparator4.Name = "toolStripSeparator4";
      this.toolStripSeparator4.Size = new System.Drawing.Size(188, 6);
      // 
      // tsmSetEworkCrDb
      // 
      this.tsmSetEworkCrDb.ImageScaling = System.Windows.Forms.ToolStripItemImageScaling.None;
      this.tsmSetEworkCrDb.Name = "tsmSetEworkCrDb";
      this.tsmSetEworkCrDb.Size = new System.Drawing.Size(191, 22);
      this.tsmSetEworkCrDb.Text = "Set &EworkCR Database";
      this.tsmSetEworkCrDb.Click += new System.EventHandler(this.SetEworkCrDatabase);
      // 
      // toolStripSeparator1
      // 
      this.toolStripSeparator1.Name = "toolStripSeparator1";
      this.toolStripSeparator1.Size = new System.Drawing.Size(188, 6);
      // 
      // exitToolStripMenuItem
      // 
      this.exitToolStripMenuItem.ImageScaling = System.Windows.Forms.ToolStripItemImageScaling.None;
      this.exitToolStripMenuItem.Name = "exitToolStripMenuItem";
      this.exitToolStripMenuItem.Size = new System.Drawing.Size(191, 22);
      this.exitToolStripMenuItem.Text = "E&xit";
      this.exitToolStripMenuItem.Click += new System.EventHandler(this.ExitApplication);
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
      this.aboutToolStripMenuItem.ImageScaling = System.Windows.Forms.ToolStripItemImageScaling.None;
      this.aboutToolStripMenuItem.Name = "aboutToolStripMenuItem";
      this.aboutToolStripMenuItem.Size = new System.Drawing.Size(107, 22);
      this.aboutToolStripMenuItem.Text = "&About";
      this.aboutToolStripMenuItem.Click += new System.EventHandler(this.HelpAbout);
      // 
      // toolStripSeparator3
      // 
      this.toolStripSeparator3.Name = "toolStripSeparator3";
      this.toolStripSeparator3.Size = new System.Drawing.Size(6, 55);
      // 
      // toolStripSeparator2
      // 
      this.toolStripSeparator2.Name = "toolStripSeparator2";
      this.toolStripSeparator2.Size = new System.Drawing.Size(6, 55);
      // 
      // hierarchyStatus
      // 
      this.hierarchyStatus.ImageStream = ((System.Windows.Forms.ImageListStreamer)(resources.GetObject("hierarchyStatus.ImageStream")));
      this.hierarchyStatus.TransparentColor = System.Drawing.Color.Transparent;
      this.hierarchyStatus.Images.SetKeyName(0, "element.png");
      this.hierarchyStatus.Images.SetKeyName(1, "element_add.png");
      this.hierarchyStatus.Images.SetKeyName(2, "element_replace.png");
      this.hierarchyStatus.Images.SetKeyName(3, "element_stop.png");
      this.hierarchyStatus.Images.SetKeyName(4, "element_up.png");
      // 
      // cmsHierarchy
      // 
      this.cmsHierarchy.Items.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.copyToolStripMenuItem});
      this.cmsHierarchy.Name = "contextMenuStrip1";
      this.cmsHierarchy.Size = new System.Drawing.Size(103, 26);
      // 
      // copyToolStripMenuItem
      // 
      this.copyToolStripMenuItem.Name = "copyToolStripMenuItem";
      this.copyToolStripMenuItem.Size = new System.Drawing.Size(102, 22);
      this.copyToolStripMenuItem.Text = "&Copy";
      // 
      // ofdAccessDb
      // 
      this.ofdAccessDb.Filter = "Microsoft Access Databases|*.mdb";
      // 
      // ofdEworkCrDb
      // 
      this.ofdEworkCrDb.Filter = "Microsoft Access Databases|*.mdb";
      // 
      // bindingSource1
      // 
      this.bindingSource1.AllowNew = false;
      // 
      // updateTimer
      // 
      this.updateTimer.Tick += new System.EventHandler(this.UpdateTimerTick);
      // 
      // tspSnapshot
      // 
      this.tspSnapshot.Name = "tspSnapshot";
      this.tspSnapshot.Size = new System.Drawing.Size(500, 16);
      // 
      // tslStatus
      // 
      this.tslStatus.Name = "tslStatus";
      this.tslStatus.Size = new System.Drawing.Size(42, 17);
      this.tslStatus.Text = "Ready.";
      // 
      // App
      // 
      this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
      this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
      this.ClientSize = new System.Drawing.Size(1019, 338);
      this.Controls.Add(this.toolStripContainer1);
      this.Icon = ((System.Drawing.Icon)(resources.GetObject("$this.Icon")));
      this.Name = "App";
      this.Text = "Ework Manager";
      this.toolStripContainer1.BottomToolStripPanel.ResumeLayout(false);
      this.toolStripContainer1.BottomToolStripPanel.PerformLayout();
      this.toolStripContainer1.ContentPanel.ResumeLayout(false);
      this.toolStripContainer1.TopToolStripPanel.ResumeLayout(false);
      this.toolStripContainer1.TopToolStripPanel.PerformLayout();
      this.toolStripContainer1.ResumeLayout(false);
      this.toolStripContainer1.PerformLayout();
      this.statusStrip1.ResumeLayout(false);
      this.statusStrip1.PerformLayout();
      this.tableLayoutPanel1.ResumeLayout(false);
      this.tableLayoutPanel1.PerformLayout();
      this.toolStrip1.ResumeLayout(false);
      this.toolStrip1.PerformLayout();
      this.cmsHierarchy.ResumeLayout(false);
      ((System.ComponentModel.ISupportInitialize)(this.bindingSource1)).EndInit();
      this.ResumeLayout(false);

    }

    #endregion

    private System.Windows.Forms.ToolStripContainer toolStripContainer1;
    private System.Windows.Forms.StatusStrip statusStrip1;
    private System.Windows.Forms.ToolStripStatusLabel statusLabel;
    private System.Windows.Forms.ToolStrip toolStrip1;
    private System.Windows.Forms.BindingSource bindingSource1;
    private System.Windows.Forms.ToolStripMenuItem fileToolStripMenuItem;
    private System.Windows.Forms.ToolStripSeparator toolStripSeparator1;
    private System.Windows.Forms.ToolStripMenuItem exitToolStripMenuItem;
    private System.Windows.Forms.ToolStripMenuItem helpToolStripMenuItem;
    private System.Windows.Forms.ToolStripMenuItem aboutToolStripMenuItem;
    private System.Windows.Forms.ImageList hierarchyStatus;
    private System.Windows.Forms.ContextMenuStrip cmsHierarchy;
    private System.Windows.Forms.ToolStripMenuItem copyToolStripMenuItem;
    private System.Windows.Forms.OpenFileDialog ofdAccessDb;
    private System.Windows.Forms.ToolStripButton tsbSetEworkCrDb;
    private System.Windows.Forms.OpenFileDialog ofdEworkCrDb;
    private System.Windows.Forms.TableLayoutPanel tableLayoutPanel1;
    private System.Windows.Forms.Label label1;
    private System.Windows.Forms.TextBox txtEworkCrDb;
    private System.Windows.Forms.ToolStripSeparator toolStripSeparator3;
    private System.Windows.Forms.ToolStripButton tsbExit;
    private System.Windows.Forms.ToolStripSeparator toolStripSeparator2;
    private System.Windows.Forms.ToolStripButton tsbTakeNewSnapshot;
    private System.Windows.Forms.ToolStripMenuItem tsmTakeSnapshot;
    private System.Windows.Forms.ToolStripSeparator toolStripSeparator4;
    private System.Windows.Forms.ToolStripMenuItem tsmSetEworkCrDb;
    private System.Windows.Forms.Timer updateTimer;
    private System.Windows.Forms.ToolStripProgressBar tspSnapshot;
    private System.Windows.Forms.ToolStripStatusLabel tslStatus;
    
  }
}

