/* * * * * * * * * * * * * * * * * * * * * * * *
 * TMAX Maintenance Build Review
 * Copyright (c) 2012 Front Burner Ltd
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  17-Dec-2012  11149 : Created.
 * * * * * * * * * * * * * * * * * * * * * * * */

namespace FrontBurner.Tmax.Apps.MaintenanceBuildReview.Forms
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
      this.statusLabel = new System.Windows.Forms.ToolStripStatusLabel();
      this.splitContainer1 = new System.Windows.Forms.SplitContainer();
      this.splitContainer2 = new System.Windows.Forms.SplitContainer();
      this.tableLayoutPanel1 = new System.Windows.Forms.TableLayoutPanel();
      this.lblHierarchy = new System.Windows.Forms.Label();
      this.trvHierarchy = new System.Windows.Forms.TreeView();
      this.hierarchyStatus = new System.Windows.Forms.ImageList(this.components);
      this.tableLayoutPanel2 = new System.Windows.Forms.TableLayoutPanel();
      this.lblLocation = new System.Windows.Forms.Label();
      this.tabLocation = new System.Windows.Forms.TabControl();
      this.tabDetails = new System.Windows.Forms.TabPage();
      this.tableLayoutPanel5 = new System.Windows.Forms.TableLayoutPanel();
      this.label1 = new System.Windows.Forms.Label();
      this.label2 = new System.Windows.Forms.Label();
      this.label3 = new System.Windows.Forms.Label();
      this.label4 = new System.Windows.Forms.Label();
      this.label5 = new System.Windows.Forms.Label();
      this.label6 = new System.Windows.Forms.Label();
      this.label7 = new System.Windows.Forms.Label();
      this.label8 = new System.Windows.Forms.Label();
      this.txtLocation = new System.Windows.Forms.TextBox();
      this.txtStatus = new System.Windows.Forms.TextBox();
      this.txtParentNew = new System.Windows.Forms.TextBox();
      this.txtParentCurr = new System.Windows.Forms.TextBox();
      this.txtSCENew = new System.Windows.Forms.TextBox();
      this.txtSCECurr = new System.Windows.Forms.TextBox();
      this.txtECENew = new System.Windows.Forms.TextBox();
      this.txtECECurr = new System.Windows.Forms.TextBox();
      this.txtPCENew = new System.Windows.Forms.TextBox();
      this.txtPCECurr = new System.Windows.Forms.TextBox();
      this.txtDescriptionNew = new System.Windows.Forms.TextBox();
      this.txtDescriptionCurr = new System.Windows.Forms.TextBox();
      this.tabFavourites = new System.Windows.Forms.TabPage();
      this.splitContainer3 = new System.Windows.Forms.SplitContainer();
      this.tableLayoutPanel3 = new System.Windows.Forms.TableLayoutPanel();
      this.lblMaintenance = new System.Windows.Forms.Label();
      this.dgvMaint = new System.Windows.Forms.DataGridView();
      this.tableLayoutPanel4 = new System.Windows.Forms.TableLayoutPanel();
      this.lblWorkorders = new System.Windows.Forms.Label();
      this.dgvWorkorder = new System.Windows.Forms.DataGridView();
      this.menuStrip1 = new System.Windows.Forms.MenuStrip();
      this.fileToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
      this.openDatabaseToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
      this.toolStripSeparator1 = new System.Windows.Forms.ToolStripSeparator();
      this.exitToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
      this.helpToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
      this.aboutToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
      this.toolStrip1 = new System.Windows.Forms.ToolStrip();
      this.tsbOpenDb = new System.Windows.Forms.ToolStripButton();
      this.toolStripSeparator2 = new System.Windows.Forms.ToolStripSeparator();
      this.tstFindLocation = new System.Windows.Forms.ToolStripTextBox();
      this.tsbFindLocation = new System.Windows.Forms.ToolStripButton();
      this.toolStripSeparator3 = new System.Windows.Forms.ToolStripSeparator();
      this.tsbExpandAll = new System.Windows.Forms.ToolStripButton();
      this.tsbCollapseAll = new System.Windows.Forms.ToolStripButton();
      this.cmsHierarchy = new System.Windows.Forms.ContextMenuStrip(this.components);
      this.copyToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
      this.ofdAccessDb = new System.Windows.Forms.OpenFileDialog();
      this.bindingSource1 = new System.Windows.Forms.BindingSource(this.components);
      this.toolStripContainer1.BottomToolStripPanel.SuspendLayout();
      this.toolStripContainer1.ContentPanel.SuspendLayout();
      this.toolStripContainer1.TopToolStripPanel.SuspendLayout();
      this.toolStripContainer1.SuspendLayout();
      this.statusStrip1.SuspendLayout();
      this.splitContainer1.Panel1.SuspendLayout();
      this.splitContainer1.Panel2.SuspendLayout();
      this.splitContainer1.SuspendLayout();
      this.splitContainer2.Panel1.SuspendLayout();
      this.splitContainer2.Panel2.SuspendLayout();
      this.splitContainer2.SuspendLayout();
      this.tableLayoutPanel1.SuspendLayout();
      this.tableLayoutPanel2.SuspendLayout();
      this.tabLocation.SuspendLayout();
      this.tabDetails.SuspendLayout();
      this.tableLayoutPanel5.SuspendLayout();
      this.splitContainer3.Panel1.SuspendLayout();
      this.splitContainer3.Panel2.SuspendLayout();
      this.splitContainer3.SuspendLayout();
      this.tableLayoutPanel3.SuspendLayout();
      ((System.ComponentModel.ISupportInitialize)(this.dgvMaint)).BeginInit();
      this.tableLayoutPanel4.SuspendLayout();
      ((System.ComponentModel.ISupportInitialize)(this.dgvWorkorder)).BeginInit();
      this.menuStrip1.SuspendLayout();
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
      this.toolStripContainer1.ContentPanel.Controls.Add(this.splitContainer1);
      this.toolStripContainer1.ContentPanel.Size = new System.Drawing.Size(1037, 641);
      this.toolStripContainer1.Dock = System.Windows.Forms.DockStyle.Fill;
      this.toolStripContainer1.Location = new System.Drawing.Point(0, 0);
      this.toolStripContainer1.Name = "toolStripContainer1";
      this.toolStripContainer1.Size = new System.Drawing.Size(1037, 718);
      this.toolStripContainer1.TabIndex = 5;
      this.toolStripContainer1.Text = "toolStripContainer1";
      // 
      // toolStripContainer1.TopToolStripPanel
      // 
      this.toolStripContainer1.TopToolStripPanel.Controls.Add(this.menuStrip1);
      this.toolStripContainer1.TopToolStripPanel.Controls.Add(this.toolStrip1);
      // 
      // statusStrip1
      // 
      this.statusStrip1.Dock = System.Windows.Forms.DockStyle.None;
      this.statusStrip1.Items.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.statusLabel});
      this.statusStrip1.Location = new System.Drawing.Point(0, 0);
      this.statusStrip1.Name = "statusStrip1";
      this.statusStrip1.Size = new System.Drawing.Size(1037, 22);
      this.statusStrip1.TabIndex = 0;
      // 
      // statusLabel
      // 
      this.statusLabel.Name = "statusLabel";
      this.statusLabel.Size = new System.Drawing.Size(42, 17);
      this.statusLabel.Text = "Ready.";
      // 
      // splitContainer1
      // 
      this.splitContainer1.Dock = System.Windows.Forms.DockStyle.Fill;
      this.splitContainer1.Location = new System.Drawing.Point(0, 0);
      this.splitContainer1.Name = "splitContainer1";
      this.splitContainer1.Orientation = System.Windows.Forms.Orientation.Horizontal;
      // 
      // splitContainer1.Panel1
      // 
      this.splitContainer1.Panel1.Controls.Add(this.splitContainer2);
      // 
      // splitContainer1.Panel2
      // 
      this.splitContainer1.Panel2.Controls.Add(this.splitContainer3);
      this.splitContainer1.Size = new System.Drawing.Size(1037, 641);
      this.splitContainer1.SplitterDistance = 308;
      this.splitContainer1.SplitterWidth = 6;
      this.splitContainer1.TabIndex = 0;
      this.splitContainer1.Paint += new System.Windows.Forms.PaintEventHandler(this.splitContainer1_Paint);
      this.splitContainer1.SplitterMoved += new System.Windows.Forms.SplitterEventHandler(this.splitContainer1_SplitterMoved);
      // 
      // splitContainer2
      // 
      this.splitContainer2.Dock = System.Windows.Forms.DockStyle.Fill;
      this.splitContainer2.Location = new System.Drawing.Point(0, 0);
      this.splitContainer2.Name = "splitContainer2";
      // 
      // splitContainer2.Panel1
      // 
      this.splitContainer2.Panel1.Controls.Add(this.tableLayoutPanel1);
      // 
      // splitContainer2.Panel2
      // 
      this.splitContainer2.Panel2.Controls.Add(this.tableLayoutPanel2);
      this.splitContainer2.Size = new System.Drawing.Size(1037, 308);
      this.splitContainer2.SplitterDistance = 345;
      this.splitContainer2.SplitterWidth = 6;
      this.splitContainer2.TabIndex = 0;
      this.splitContainer2.Paint += new System.Windows.Forms.PaintEventHandler(this.splitContainer2_Paint);
      this.splitContainer2.SplitterMoved += new System.Windows.Forms.SplitterEventHandler(this.splitContainer2_SplitterMoved);
      // 
      // tableLayoutPanel1
      // 
      this.tableLayoutPanel1.ColumnCount = 1;
      this.tableLayoutPanel1.ColumnStyles.Add(new System.Windows.Forms.ColumnStyle(System.Windows.Forms.SizeType.Percent, 100F));
      this.tableLayoutPanel1.ColumnStyles.Add(new System.Windows.Forms.ColumnStyle(System.Windows.Forms.SizeType.Absolute, 20F));
      this.tableLayoutPanel1.Controls.Add(this.lblHierarchy, 0, 0);
      this.tableLayoutPanel1.Controls.Add(this.trvHierarchy, 0, 1);
      this.tableLayoutPanel1.Dock = System.Windows.Forms.DockStyle.Fill;
      this.tableLayoutPanel1.Location = new System.Drawing.Point(0, 0);
      this.tableLayoutPanel1.Name = "tableLayoutPanel1";
      this.tableLayoutPanel1.RowCount = 2;
      this.tableLayoutPanel1.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Absolute, 30F));
      this.tableLayoutPanel1.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Percent, 100F));
      this.tableLayoutPanel1.Size = new System.Drawing.Size(345, 308);
      this.tableLayoutPanel1.TabIndex = 0;
      // 
      // lblHierarchy
      // 
      this.lblHierarchy.AutoSize = true;
      this.lblHierarchy.Dock = System.Windows.Forms.DockStyle.Fill;
      this.lblHierarchy.Font = new System.Drawing.Font("Segoe UI", 12F);
      this.lblHierarchy.Location = new System.Drawing.Point(3, 0);
      this.lblHierarchy.Name = "lblHierarchy";
      this.lblHierarchy.Size = new System.Drawing.Size(339, 30);
      this.lblHierarchy.TabIndex = 0;
      this.lblHierarchy.Text = "Hierarchy";
      this.lblHierarchy.TextAlign = System.Drawing.ContentAlignment.MiddleCenter;
      // 
      // trvHierarchy
      // 
      this.trvHierarchy.Dock = System.Windows.Forms.DockStyle.Fill;
      this.trvHierarchy.ImageIndex = 0;
      this.trvHierarchy.ImageList = this.hierarchyStatus;
      this.trvHierarchy.Location = new System.Drawing.Point(3, 33);
      this.trvHierarchy.Name = "trvHierarchy";
      this.trvHierarchy.SelectedImageIndex = 0;
      this.trvHierarchy.Size = new System.Drawing.Size(339, 272);
      this.trvHierarchy.TabIndex = 1;
      this.trvHierarchy.MouseUp += new System.Windows.Forms.MouseEventHandler(this.HierarchyMouseClick);
      this.trvHierarchy.AfterSelect += new System.Windows.Forms.TreeViewEventHandler(this.LocationNodeSelected);
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
      // tableLayoutPanel2
      // 
      this.tableLayoutPanel2.ColumnCount = 1;
      this.tableLayoutPanel2.ColumnStyles.Add(new System.Windows.Forms.ColumnStyle(System.Windows.Forms.SizeType.Percent, 100F));
      this.tableLayoutPanel2.ColumnStyles.Add(new System.Windows.Forms.ColumnStyle(System.Windows.Forms.SizeType.Absolute, 20F));
      this.tableLayoutPanel2.Controls.Add(this.lblLocation, 0, 0);
      this.tableLayoutPanel2.Controls.Add(this.tabLocation, 0, 1);
      this.tableLayoutPanel2.Dock = System.Windows.Forms.DockStyle.Fill;
      this.tableLayoutPanel2.Location = new System.Drawing.Point(0, 0);
      this.tableLayoutPanel2.Name = "tableLayoutPanel2";
      this.tableLayoutPanel2.RowCount = 2;
      this.tableLayoutPanel2.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Absolute, 30F));
      this.tableLayoutPanel2.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Percent, 100F));
      this.tableLayoutPanel2.Size = new System.Drawing.Size(686, 308);
      this.tableLayoutPanel2.TabIndex = 0;
      // 
      // lblLocation
      // 
      this.lblLocation.AutoSize = true;
      this.lblLocation.Dock = System.Windows.Forms.DockStyle.Fill;
      this.lblLocation.Font = new System.Drawing.Font("Segoe UI", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
      this.lblLocation.Location = new System.Drawing.Point(3, 0);
      this.lblLocation.Name = "lblLocation";
      this.lblLocation.Size = new System.Drawing.Size(680, 30);
      this.lblLocation.TabIndex = 1;
      this.lblLocation.Text = "Location";
      this.lblLocation.TextAlign = System.Drawing.ContentAlignment.MiddleCenter;
      // 
      // tabLocation
      // 
      this.tabLocation.Controls.Add(this.tabDetails);
      this.tabLocation.Controls.Add(this.tabFavourites);
      this.tabLocation.Dock = System.Windows.Forms.DockStyle.Fill;
      this.tabLocation.Font = new System.Drawing.Font("Segoe UI", 9F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
      this.tabLocation.Location = new System.Drawing.Point(3, 33);
      this.tabLocation.Name = "tabLocation";
      this.tabLocation.SelectedIndex = 0;
      this.tabLocation.Size = new System.Drawing.Size(680, 272);
      this.tabLocation.TabIndex = 2;
      // 
      // tabDetails
      // 
      this.tabDetails.Controls.Add(this.tableLayoutPanel5);
      this.tabDetails.Location = new System.Drawing.Point(4, 24);
      this.tabDetails.Name = "tabDetails";
      this.tabDetails.Padding = new System.Windows.Forms.Padding(3);
      this.tabDetails.Size = new System.Drawing.Size(672, 244);
      this.tabDetails.TabIndex = 0;
      this.tabDetails.Text = "Details";
      this.tabDetails.UseVisualStyleBackColor = true;
      // 
      // tableLayoutPanel5
      // 
      this.tableLayoutPanel5.ColumnCount = 3;
      this.tableLayoutPanel5.ColumnStyles.Add(new System.Windows.Forms.ColumnStyle(System.Windows.Forms.SizeType.Absolute, 120F));
      this.tableLayoutPanel5.ColumnStyles.Add(new System.Windows.Forms.ColumnStyle(System.Windows.Forms.SizeType.Percent, 50F));
      this.tableLayoutPanel5.ColumnStyles.Add(new System.Windows.Forms.ColumnStyle(System.Windows.Forms.SizeType.Percent, 50F));
      this.tableLayoutPanel5.Controls.Add(this.label1, 1, 0);
      this.tableLayoutPanel5.Controls.Add(this.label2, 2, 0);
      this.tableLayoutPanel5.Controls.Add(this.label3, 0, 1);
      this.tableLayoutPanel5.Controls.Add(this.label4, 0, 2);
      this.tableLayoutPanel5.Controls.Add(this.label5, 0, 3);
      this.tableLayoutPanel5.Controls.Add(this.label6, 0, 4);
      this.tableLayoutPanel5.Controls.Add(this.label7, 0, 5);
      this.tableLayoutPanel5.Controls.Add(this.label8, 0, 6);
      this.tableLayoutPanel5.Controls.Add(this.txtLocation, 1, 1);
      this.tableLayoutPanel5.Controls.Add(this.txtStatus, 2, 1);
      this.tableLayoutPanel5.Controls.Add(this.txtParentNew, 1, 3);
      this.tableLayoutPanel5.Controls.Add(this.txtParentCurr, 2, 3);
      this.tableLayoutPanel5.Controls.Add(this.txtSCENew, 1, 4);
      this.tableLayoutPanel5.Controls.Add(this.txtSCECurr, 2, 4);
      this.tableLayoutPanel5.Controls.Add(this.txtECENew, 1, 5);
      this.tableLayoutPanel5.Controls.Add(this.txtECECurr, 2, 5);
      this.tableLayoutPanel5.Controls.Add(this.txtPCENew, 1, 6);
      this.tableLayoutPanel5.Controls.Add(this.txtPCECurr, 2, 6);
      this.tableLayoutPanel5.Controls.Add(this.txtDescriptionNew, 1, 2);
      this.tableLayoutPanel5.Controls.Add(this.txtDescriptionCurr, 2, 2);
      this.tableLayoutPanel5.Dock = System.Windows.Forms.DockStyle.Fill;
      this.tableLayoutPanel5.Location = new System.Drawing.Point(3, 3);
      this.tableLayoutPanel5.Name = "tableLayoutPanel5";
      this.tableLayoutPanel5.RowCount = 8;
      this.tableLayoutPanel5.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Absolute, 25F));
      this.tableLayoutPanel5.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Absolute, 25F));
      this.tableLayoutPanel5.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Absolute, 45F));
      this.tableLayoutPanel5.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Absolute, 25F));
      this.tableLayoutPanel5.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Absolute, 25F));
      this.tableLayoutPanel5.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Absolute, 25F));
      this.tableLayoutPanel5.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Absolute, 25F));
      this.tableLayoutPanel5.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Absolute, 25F));
      this.tableLayoutPanel5.Size = new System.Drawing.Size(666, 238);
      this.tableLayoutPanel5.TabIndex = 0;
      // 
      // label1
      // 
      this.label1.AutoSize = true;
      this.label1.Dock = System.Windows.Forms.DockStyle.Fill;
      this.label1.Font = new System.Drawing.Font("Calibri", 9.75F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
      this.label1.Location = new System.Drawing.Point(123, 0);
      this.label1.Name = "label1";
      this.label1.Size = new System.Drawing.Size(267, 25);
      this.label1.TabIndex = 0;
      this.label1.Text = "New Value";
      this.label1.TextAlign = System.Drawing.ContentAlignment.MiddleCenter;
      // 
      // label2
      // 
      this.label2.AutoSize = true;
      this.label2.Dock = System.Windows.Forms.DockStyle.Fill;
      this.label2.Font = new System.Drawing.Font("Calibri", 9.75F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
      this.label2.Location = new System.Drawing.Point(396, 0);
      this.label2.Name = "label2";
      this.label2.Size = new System.Drawing.Size(267, 25);
      this.label2.TabIndex = 1;
      this.label2.Text = "Current Value (TMAX)";
      this.label2.TextAlign = System.Drawing.ContentAlignment.MiddleCenter;
      // 
      // label3
      // 
      this.label3.AutoSize = true;
      this.label3.Dock = System.Windows.Forms.DockStyle.Fill;
      this.label3.Font = new System.Drawing.Font("Calibri", 9.75F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
      this.label3.Location = new System.Drawing.Point(3, 25);
      this.label3.Name = "label3";
      this.label3.Size = new System.Drawing.Size(114, 25);
      this.label3.TabIndex = 2;
      this.label3.Text = "Location";
      this.label3.TextAlign = System.Drawing.ContentAlignment.MiddleLeft;
      // 
      // label4
      // 
      this.label4.AutoSize = true;
      this.label4.Dock = System.Windows.Forms.DockStyle.Fill;
      this.label4.Font = new System.Drawing.Font("Calibri", 9.75F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
      this.label4.Location = new System.Drawing.Point(3, 50);
      this.label4.Name = "label4";
      this.label4.Size = new System.Drawing.Size(114, 45);
      this.label4.TabIndex = 3;
      this.label4.Text = "Description";
      this.label4.TextAlign = System.Drawing.ContentAlignment.MiddleLeft;
      // 
      // label5
      // 
      this.label5.AutoSize = true;
      this.label5.Dock = System.Windows.Forms.DockStyle.Fill;
      this.label5.Font = new System.Drawing.Font("Calibri", 9.75F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
      this.label5.Location = new System.Drawing.Point(3, 95);
      this.label5.Name = "label5";
      this.label5.Size = new System.Drawing.Size(114, 25);
      this.label5.TabIndex = 4;
      this.label5.Text = "Parent";
      this.label5.TextAlign = System.Drawing.ContentAlignment.MiddleLeft;
      // 
      // label6
      // 
      this.label6.AutoSize = true;
      this.label6.Dock = System.Windows.Forms.DockStyle.Fill;
      this.label6.Font = new System.Drawing.Font("Calibri", 9.75F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
      this.label6.Location = new System.Drawing.Point(3, 120);
      this.label6.Name = "label6";
      this.label6.Size = new System.Drawing.Size(114, 25);
      this.label6.TabIndex = 5;
      this.label6.Text = "SCE";
      this.label6.TextAlign = System.Drawing.ContentAlignment.MiddleLeft;
      // 
      // label7
      // 
      this.label7.AutoSize = true;
      this.label7.Dock = System.Windows.Forms.DockStyle.Fill;
      this.label7.Font = new System.Drawing.Font("Calibri", 9.75F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
      this.label7.Location = new System.Drawing.Point(3, 145);
      this.label7.Name = "label7";
      this.label7.Size = new System.Drawing.Size(114, 25);
      this.label7.TabIndex = 6;
      this.label7.Text = "ECE";
      this.label7.TextAlign = System.Drawing.ContentAlignment.MiddleLeft;
      // 
      // label8
      // 
      this.label8.AutoSize = true;
      this.label8.Dock = System.Windows.Forms.DockStyle.Fill;
      this.label8.Font = new System.Drawing.Font("Calibri", 9.75F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
      this.label8.Location = new System.Drawing.Point(3, 170);
      this.label8.Name = "label8";
      this.label8.Size = new System.Drawing.Size(114, 25);
      this.label8.TabIndex = 7;
      this.label8.Text = "PCE";
      this.label8.TextAlign = System.Drawing.ContentAlignment.MiddleLeft;
      // 
      // txtLocation
      // 
      this.txtLocation.Location = new System.Drawing.Point(123, 28);
      this.txtLocation.Name = "txtLocation";
      this.txtLocation.ReadOnly = true;
      this.txtLocation.Size = new System.Drawing.Size(180, 23);
      this.txtLocation.TabIndex = 8;
      // 
      // txtStatus
      // 
      this.txtStatus.Location = new System.Drawing.Point(396, 28);
      this.txtStatus.Name = "txtStatus";
      this.txtStatus.ReadOnly = true;
      this.txtStatus.Size = new System.Drawing.Size(180, 23);
      this.txtStatus.TabIndex = 9;
      // 
      // txtParentNew
      // 
      this.txtParentNew.Location = new System.Drawing.Point(123, 98);
      this.txtParentNew.Name = "txtParentNew";
      this.txtParentNew.ReadOnly = true;
      this.txtParentNew.Size = new System.Drawing.Size(180, 23);
      this.txtParentNew.TabIndex = 10;
      // 
      // txtParentCurr
      // 
      this.txtParentCurr.Location = new System.Drawing.Point(396, 98);
      this.txtParentCurr.Name = "txtParentCurr";
      this.txtParentCurr.ReadOnly = true;
      this.txtParentCurr.Size = new System.Drawing.Size(180, 23);
      this.txtParentCurr.TabIndex = 11;
      // 
      // txtSCENew
      // 
      this.txtSCENew.Location = new System.Drawing.Point(123, 123);
      this.txtSCENew.Name = "txtSCENew";
      this.txtSCENew.ReadOnly = true;
      this.txtSCENew.Size = new System.Drawing.Size(30, 23);
      this.txtSCENew.TabIndex = 12;
      // 
      // txtSCECurr
      // 
      this.txtSCECurr.Location = new System.Drawing.Point(396, 123);
      this.txtSCECurr.Name = "txtSCECurr";
      this.txtSCECurr.ReadOnly = true;
      this.txtSCECurr.Size = new System.Drawing.Size(30, 23);
      this.txtSCECurr.TabIndex = 13;
      // 
      // txtECENew
      // 
      this.txtECENew.Location = new System.Drawing.Point(123, 148);
      this.txtECENew.Name = "txtECENew";
      this.txtECENew.ReadOnly = true;
      this.txtECENew.Size = new System.Drawing.Size(30, 23);
      this.txtECENew.TabIndex = 14;
      // 
      // txtECECurr
      // 
      this.txtECECurr.Location = new System.Drawing.Point(396, 148);
      this.txtECECurr.Name = "txtECECurr";
      this.txtECECurr.ReadOnly = true;
      this.txtECECurr.Size = new System.Drawing.Size(30, 23);
      this.txtECECurr.TabIndex = 15;
      // 
      // txtPCENew
      // 
      this.txtPCENew.Location = new System.Drawing.Point(123, 173);
      this.txtPCENew.Name = "txtPCENew";
      this.txtPCENew.ReadOnly = true;
      this.txtPCENew.Size = new System.Drawing.Size(30, 23);
      this.txtPCENew.TabIndex = 16;
      // 
      // txtPCECurr
      // 
      this.txtPCECurr.Location = new System.Drawing.Point(396, 173);
      this.txtPCECurr.Name = "txtPCECurr";
      this.txtPCECurr.ReadOnly = true;
      this.txtPCECurr.Size = new System.Drawing.Size(30, 23);
      this.txtPCECurr.TabIndex = 17;
      // 
      // txtDescriptionNew
      // 
      this.txtDescriptionNew.Dock = System.Windows.Forms.DockStyle.Fill;
      this.txtDescriptionNew.Location = new System.Drawing.Point(123, 53);
      this.txtDescriptionNew.Multiline = true;
      this.txtDescriptionNew.Name = "txtDescriptionNew";
      this.txtDescriptionNew.ReadOnly = true;
      this.txtDescriptionNew.Size = new System.Drawing.Size(267, 39);
      this.txtDescriptionNew.TabIndex = 18;
      // 
      // txtDescriptionCurr
      // 
      this.txtDescriptionCurr.Dock = System.Windows.Forms.DockStyle.Fill;
      this.txtDescriptionCurr.Location = new System.Drawing.Point(396, 53);
      this.txtDescriptionCurr.Multiline = true;
      this.txtDescriptionCurr.Name = "txtDescriptionCurr";
      this.txtDescriptionCurr.ReadOnly = true;
      this.txtDescriptionCurr.Size = new System.Drawing.Size(267, 39);
      this.txtDescriptionCurr.TabIndex = 19;
      // 
      // tabFavourites
      // 
      this.tabFavourites.Location = new System.Drawing.Point(4, 24);
      this.tabFavourites.Name = "tabFavourites";
      this.tabFavourites.Padding = new System.Windows.Forms.Padding(3);
      this.tabFavourites.Size = new System.Drawing.Size(672, 244);
      this.tabFavourites.TabIndex = 1;
      this.tabFavourites.Text = "Favourites";
      this.tabFavourites.UseVisualStyleBackColor = true;
      // 
      // splitContainer3
      // 
      this.splitContainer3.Dock = System.Windows.Forms.DockStyle.Fill;
      this.splitContainer3.Location = new System.Drawing.Point(0, 0);
      this.splitContainer3.Name = "splitContainer3";
      // 
      // splitContainer3.Panel1
      // 
      this.splitContainer3.Panel1.Controls.Add(this.tableLayoutPanel3);
      // 
      // splitContainer3.Panel2
      // 
      this.splitContainer3.Panel2.Controls.Add(this.tableLayoutPanel4);
      this.splitContainer3.Size = new System.Drawing.Size(1037, 327);
      this.splitContainer3.SplitterDistance = 468;
      this.splitContainer3.SplitterWidth = 6;
      this.splitContainer3.TabIndex = 0;
      this.splitContainer3.Paint += new System.Windows.Forms.PaintEventHandler(this.splitContainer3_Paint);
      this.splitContainer3.SplitterMoved += new System.Windows.Forms.SplitterEventHandler(this.splitContainer3_SplitterMoved);
      // 
      // tableLayoutPanel3
      // 
      this.tableLayoutPanel3.ColumnCount = 1;
      this.tableLayoutPanel3.ColumnStyles.Add(new System.Windows.Forms.ColumnStyle(System.Windows.Forms.SizeType.Percent, 100F));
      this.tableLayoutPanel3.Controls.Add(this.lblMaintenance, 0, 0);
      this.tableLayoutPanel3.Controls.Add(this.dgvMaint, 0, 1);
      this.tableLayoutPanel3.Dock = System.Windows.Forms.DockStyle.Fill;
      this.tableLayoutPanel3.Location = new System.Drawing.Point(0, 0);
      this.tableLayoutPanel3.Name = "tableLayoutPanel3";
      this.tableLayoutPanel3.RowCount = 2;
      this.tableLayoutPanel3.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Absolute, 30F));
      this.tableLayoutPanel3.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Percent, 100F));
      this.tableLayoutPanel3.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Absolute, 20F));
      this.tableLayoutPanel3.Size = new System.Drawing.Size(468, 327);
      this.tableLayoutPanel3.TabIndex = 0;
      // 
      // lblMaintenance
      // 
      this.lblMaintenance.AutoSize = true;
      this.lblMaintenance.Dock = System.Windows.Forms.DockStyle.Fill;
      this.lblMaintenance.Font = new System.Drawing.Font("Segoe UI", 12F);
      this.lblMaintenance.Location = new System.Drawing.Point(3, 0);
      this.lblMaintenance.Name = "lblMaintenance";
      this.lblMaintenance.Size = new System.Drawing.Size(462, 30);
      this.lblMaintenance.TabIndex = 1;
      this.lblMaintenance.Text = "Maintenance";
      this.lblMaintenance.TextAlign = System.Drawing.ContentAlignment.MiddleCenter;
      // 
      // dgvMaint
      // 
      this.dgvMaint.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
      this.dgvMaint.Dock = System.Windows.Forms.DockStyle.Fill;
      this.dgvMaint.Location = new System.Drawing.Point(3, 33);
      this.dgvMaint.Name = "dgvMaint";
      this.dgvMaint.Size = new System.Drawing.Size(462, 291);
      this.dgvMaint.TabIndex = 2;
      // 
      // tableLayoutPanel4
      // 
      this.tableLayoutPanel4.ColumnCount = 1;
      this.tableLayoutPanel4.ColumnStyles.Add(new System.Windows.Forms.ColumnStyle(System.Windows.Forms.SizeType.Percent, 100F));
      this.tableLayoutPanel4.ColumnStyles.Add(new System.Windows.Forms.ColumnStyle(System.Windows.Forms.SizeType.Absolute, 20F));
      this.tableLayoutPanel4.Controls.Add(this.lblWorkorders, 0, 0);
      this.tableLayoutPanel4.Controls.Add(this.dgvWorkorder, 0, 1);
      this.tableLayoutPanel4.Dock = System.Windows.Forms.DockStyle.Fill;
      this.tableLayoutPanel4.Location = new System.Drawing.Point(0, 0);
      this.tableLayoutPanel4.Name = "tableLayoutPanel4";
      this.tableLayoutPanel4.RowCount = 2;
      this.tableLayoutPanel4.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Absolute, 30F));
      this.tableLayoutPanel4.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Percent, 100F));
      this.tableLayoutPanel4.Size = new System.Drawing.Size(563, 327);
      this.tableLayoutPanel4.TabIndex = 0;
      // 
      // lblWorkorders
      // 
      this.lblWorkorders.AutoSize = true;
      this.lblWorkorders.Dock = System.Windows.Forms.DockStyle.Fill;
      this.lblWorkorders.Font = new System.Drawing.Font("Segoe UI", 12F);
      this.lblWorkorders.Location = new System.Drawing.Point(3, 0);
      this.lblWorkorders.Name = "lblWorkorders";
      this.lblWorkorders.Size = new System.Drawing.Size(557, 30);
      this.lblWorkorders.TabIndex = 1;
      this.lblWorkorders.Text = "Open Workorders";
      this.lblWorkorders.TextAlign = System.Drawing.ContentAlignment.MiddleCenter;
      // 
      // dgvWorkorder
      // 
      this.dgvWorkorder.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
      this.dgvWorkorder.Dock = System.Windows.Forms.DockStyle.Fill;
      this.dgvWorkorder.Location = new System.Drawing.Point(3, 33);
      this.dgvWorkorder.Name = "dgvWorkorder";
      this.dgvWorkorder.Size = new System.Drawing.Size(557, 291);
      this.dgvWorkorder.TabIndex = 2;
      // 
      // menuStrip1
      // 
      this.menuStrip1.Dock = System.Windows.Forms.DockStyle.None;
      this.menuStrip1.Items.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.fileToolStripMenuItem,
            this.helpToolStripMenuItem});
      this.menuStrip1.Location = new System.Drawing.Point(0, 0);
      this.menuStrip1.Name = "menuStrip1";
      this.menuStrip1.Size = new System.Drawing.Size(1037, 24);
      this.menuStrip1.TabIndex = 2;
      this.menuStrip1.Text = "menuStrip1";
      // 
      // fileToolStripMenuItem
      // 
      this.fileToolStripMenuItem.DropDownItems.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.openDatabaseToolStripMenuItem,
            this.toolStripSeparator1,
            this.exitToolStripMenuItem});
      this.fileToolStripMenuItem.Name = "fileToolStripMenuItem";
      this.fileToolStripMenuItem.Size = new System.Drawing.Size(37, 20);
      this.fileToolStripMenuItem.Text = "&File";
      // 
      // openDatabaseToolStripMenuItem
      // 
      this.openDatabaseToolStripMenuItem.Image = ((System.Drawing.Image)(resources.GetObject("openDatabaseToolStripMenuItem.Image")));
      this.openDatabaseToolStripMenuItem.ImageScaling = System.Windows.Forms.ToolStripItemImageScaling.None;
      this.openDatabaseToolStripMenuItem.Name = "openDatabaseToolStripMenuItem";
      this.openDatabaseToolStripMenuItem.Size = new System.Drawing.Size(162, 30);
      this.openDatabaseToolStripMenuItem.Text = "&Open Database";
      this.openDatabaseToolStripMenuItem.Click += new System.EventHandler(this.OpenAccessDatabase);
      // 
      // toolStripSeparator1
      // 
      this.toolStripSeparator1.Name = "toolStripSeparator1";
      this.toolStripSeparator1.Size = new System.Drawing.Size(159, 6);
      // 
      // exitToolStripMenuItem
      // 
      this.exitToolStripMenuItem.Image = global::FrontBurner.Tmax.Apps.MaintenanceBuildReview.Properties.Resources.Exit;
      this.exitToolStripMenuItem.ImageScaling = System.Windows.Forms.ToolStripItemImageScaling.None;
      this.exitToolStripMenuItem.Name = "exitToolStripMenuItem";
      this.exitToolStripMenuItem.Size = new System.Drawing.Size(162, 30);
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
      this.aboutToolStripMenuItem.Image = global::FrontBurner.Tmax.Apps.MaintenanceBuildReview.Properties.Resources.Help;
      this.aboutToolStripMenuItem.ImageScaling = System.Windows.Forms.ToolStripItemImageScaling.None;
      this.aboutToolStripMenuItem.Name = "aboutToolStripMenuItem";
      this.aboutToolStripMenuItem.Size = new System.Drawing.Size(115, 30);
      this.aboutToolStripMenuItem.Text = "&About";
      this.aboutToolStripMenuItem.Click += new System.EventHandler(this.HelpAbout);
      // 
      // toolStrip1
      // 
      this.toolStrip1.Dock = System.Windows.Forms.DockStyle.None;
      this.toolStrip1.Items.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.tsbOpenDb,
            this.toolStripSeparator2,
            this.tstFindLocation,
            this.tsbFindLocation,
            this.toolStripSeparator3,
            this.tsbExpandAll,
            this.tsbCollapseAll});
      this.toolStrip1.Location = new System.Drawing.Point(3, 24);
      this.toolStrip1.Name = "toolStrip1";
      this.toolStrip1.Size = new System.Drawing.Size(456, 31);
      this.toolStrip1.TabIndex = 1;
      // 
      // tsbOpenDb
      // 
      this.tsbOpenDb.Image = ((System.Drawing.Image)(resources.GetObject("tsbOpenDb.Image")));
      this.tsbOpenDb.ImageScaling = System.Windows.Forms.ToolStripItemImageScaling.None;
      this.tsbOpenDb.ImageTransparentColor = System.Drawing.Color.Magenta;
      this.tsbOpenDb.Name = "tsbOpenDb";
      this.tsbOpenDb.Size = new System.Drawing.Size(115, 28);
      this.tsbOpenDb.Text = "Open Database";
      this.tsbOpenDb.Click += new System.EventHandler(this.OpenAccessDatabase);
      // 
      // toolStripSeparator2
      // 
      this.toolStripSeparator2.Name = "toolStripSeparator2";
      this.toolStripSeparator2.Size = new System.Drawing.Size(6, 31);
      // 
      // tstFindLocation
      // 
      this.tstFindLocation.Name = "tstFindLocation";
      this.tstFindLocation.Size = new System.Drawing.Size(100, 31);
      this.tstFindLocation.KeyPress += new System.Windows.Forms.KeyPressEventHandler(this.tstFindLocation_KeyPress);
      // 
      // tsbFindLocation
      // 
      this.tsbFindLocation.DisplayStyle = System.Windows.Forms.ToolStripItemDisplayStyle.Image;
      this.tsbFindLocation.Image = global::FrontBurner.Tmax.Apps.MaintenanceBuildReview.Properties.Resources.FindNext;
      this.tsbFindLocation.ImageScaling = System.Windows.Forms.ToolStripItemImageScaling.None;
      this.tsbFindLocation.ImageTransparentColor = System.Drawing.Color.Magenta;
      this.tsbFindLocation.Name = "tsbFindLocation";
      this.tsbFindLocation.Size = new System.Drawing.Size(28, 28);
      this.tsbFindLocation.Text = "toolStripButton1";
      this.tsbFindLocation.Click += new System.EventHandler(this.FindLocation);
      // 
      // toolStripSeparator3
      // 
      this.toolStripSeparator3.Name = "toolStripSeparator3";
      this.toolStripSeparator3.Size = new System.Drawing.Size(6, 31);
      // 
      // tsbExpandAll
      // 
      this.tsbExpandAll.Image = global::FrontBurner.Tmax.Apps.MaintenanceBuildReview.Properties.Resources.ExpandAll;
      this.tsbExpandAll.ImageScaling = System.Windows.Forms.ToolStripItemImageScaling.None;
      this.tsbExpandAll.ImageTransparentColor = System.Drawing.Color.Magenta;
      this.tsbExpandAll.Name = "tsbExpandAll";
      this.tsbExpandAll.Size = new System.Drawing.Size(90, 28);
      this.tsbExpandAll.Text = "Expand All";
      this.tsbExpandAll.Click += new System.EventHandler(this.HierarchyTreeExpandAll);
      // 
      // tsbCollapseAll
      // 
      this.tsbCollapseAll.Image = global::FrontBurner.Tmax.Apps.MaintenanceBuildReview.Properties.Resources.CollapseAll;
      this.tsbCollapseAll.ImageScaling = System.Windows.Forms.ToolStripItemImageScaling.None;
      this.tsbCollapseAll.ImageTransparentColor = System.Drawing.Color.Magenta;
      this.tsbCollapseAll.Name = "tsbCollapseAll";
      this.tsbCollapseAll.Size = new System.Drawing.Size(97, 28);
      this.tsbCollapseAll.Text = "Collapse All";
      this.tsbCollapseAll.Click += new System.EventHandler(this.HierarchyTreeCollapseAll);
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
      this.copyToolStripMenuItem.Click += new System.EventHandler(this.CopyLocationValue);
      // 
      // ofdAccessDb
      // 
      this.ofdAccessDb.Filter = "Microsoft Access Databases|*.mdb";
      // 
      // bindingSource1
      // 
      this.bindingSource1.AllowNew = false;
      // 
      // App
      // 
      this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
      this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
      this.ClientSize = new System.Drawing.Size(1037, 718);
      this.Controls.Add(this.toolStripContainer1);
      this.Icon = ((System.Drawing.Icon)(resources.GetObject("$this.Icon")));
      this.MainMenuStrip = this.menuStrip1;
      this.Name = "App";
      this.Text = "Maintenance Build Review";
      this.SizeChanged += new System.EventHandler(this.App_SizeChanged);
      this.toolStripContainer1.BottomToolStripPanel.ResumeLayout(false);
      this.toolStripContainer1.BottomToolStripPanel.PerformLayout();
      this.toolStripContainer1.ContentPanel.ResumeLayout(false);
      this.toolStripContainer1.TopToolStripPanel.ResumeLayout(false);
      this.toolStripContainer1.TopToolStripPanel.PerformLayout();
      this.toolStripContainer1.ResumeLayout(false);
      this.toolStripContainer1.PerformLayout();
      this.statusStrip1.ResumeLayout(false);
      this.statusStrip1.PerformLayout();
      this.splitContainer1.Panel1.ResumeLayout(false);
      this.splitContainer1.Panel2.ResumeLayout(false);
      this.splitContainer1.ResumeLayout(false);
      this.splitContainer2.Panel1.ResumeLayout(false);
      this.splitContainer2.Panel2.ResumeLayout(false);
      this.splitContainer2.ResumeLayout(false);
      this.tableLayoutPanel1.ResumeLayout(false);
      this.tableLayoutPanel1.PerformLayout();
      this.tableLayoutPanel2.ResumeLayout(false);
      this.tableLayoutPanel2.PerformLayout();
      this.tabLocation.ResumeLayout(false);
      this.tabDetails.ResumeLayout(false);
      this.tableLayoutPanel5.ResumeLayout(false);
      this.tableLayoutPanel5.PerformLayout();
      this.splitContainer3.Panel1.ResumeLayout(false);
      this.splitContainer3.Panel2.ResumeLayout(false);
      this.splitContainer3.ResumeLayout(false);
      this.tableLayoutPanel3.ResumeLayout(false);
      this.tableLayoutPanel3.PerformLayout();
      ((System.ComponentModel.ISupportInitialize)(this.dgvMaint)).EndInit();
      this.tableLayoutPanel4.ResumeLayout(false);
      this.tableLayoutPanel4.PerformLayout();
      ((System.ComponentModel.ISupportInitialize)(this.dgvWorkorder)).EndInit();
      this.menuStrip1.ResumeLayout(false);
      this.menuStrip1.PerformLayout();
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
    private System.Windows.Forms.SplitContainer splitContainer1;
    private System.Windows.Forms.SplitContainer splitContainer2;
    private System.Windows.Forms.SplitContainer splitContainer3;
    private System.Windows.Forms.TableLayoutPanel tableLayoutPanel1;
    private System.Windows.Forms.TableLayoutPanel tableLayoutPanel2;
    private System.Windows.Forms.TableLayoutPanel tableLayoutPanel3;
    private System.Windows.Forms.TableLayoutPanel tableLayoutPanel4;
    private System.Windows.Forms.Label lblHierarchy;
    private System.Windows.Forms.Label lblLocation;
    private System.Windows.Forms.Label lblMaintenance;
    private System.Windows.Forms.Label lblWorkorders;
    private System.Windows.Forms.TreeView trvHierarchy;
    private System.Windows.Forms.DataGridView dgvMaint;
    private System.Windows.Forms.DataGridView dgvWorkorder;
    private System.Windows.Forms.ToolStripButton tsbOpenDb;
    private System.Windows.Forms.MenuStrip menuStrip1;
    private System.Windows.Forms.ToolStripMenuItem fileToolStripMenuItem;
    private System.Windows.Forms.ToolStripSeparator toolStripSeparator1;
    private System.Windows.Forms.ToolStripMenuItem exitToolStripMenuItem;
    private System.Windows.Forms.ToolStripMenuItem openDatabaseToolStripMenuItem;
    private System.Windows.Forms.ToolStripMenuItem helpToolStripMenuItem;
    private System.Windows.Forms.ToolStripMenuItem aboutToolStripMenuItem;
    private System.Windows.Forms.ImageList hierarchyStatus;
    private System.Windows.Forms.ToolStripSeparator toolStripSeparator2;
    private System.Windows.Forms.ToolStripButton tsbExpandAll;
    private System.Windows.Forms.ToolStripButton tsbCollapseAll;
    private System.Windows.Forms.ToolStripSeparator toolStripSeparator3;
    private System.Windows.Forms.ToolStripTextBox tstFindLocation;
    private System.Windows.Forms.ToolStripButton tsbFindLocation;
    private System.Windows.Forms.TabControl tabLocation;
    private System.Windows.Forms.TabPage tabDetails;
    private System.Windows.Forms.TabPage tabFavourites;
    private System.Windows.Forms.TableLayoutPanel tableLayoutPanel5;
    private System.Windows.Forms.Label label1;
    private System.Windows.Forms.Label label2;
    private System.Windows.Forms.Label label6;
    private System.Windows.Forms.Label label3;
    private System.Windows.Forms.Label label4;
    private System.Windows.Forms.Label label5;
    private System.Windows.Forms.Label label7;
    private System.Windows.Forms.Label label8;
    private System.Windows.Forms.TextBox txtLocation;
    private System.Windows.Forms.TextBox txtStatus;
    private System.Windows.Forms.TextBox txtParentNew;
    private System.Windows.Forms.TextBox txtParentCurr;
    private System.Windows.Forms.TextBox txtSCENew;
    private System.Windows.Forms.TextBox txtSCECurr;
    private System.Windows.Forms.TextBox txtECENew;
    private System.Windows.Forms.TextBox txtECECurr;
    private System.Windows.Forms.TextBox txtPCENew;
    private System.Windows.Forms.TextBox txtPCECurr;
    private System.Windows.Forms.TextBox txtDescriptionNew;
    private System.Windows.Forms.TextBox txtDescriptionCurr;
    private System.Windows.Forms.ContextMenuStrip cmsHierarchy;
    private System.Windows.Forms.ToolStripMenuItem copyToolStripMenuItem;
    private System.Windows.Forms.OpenFileDialog ofdAccessDb;
  }
}

