/* * * * * * * * * * * * * * * * * * * * * * * *
 * EmitScore
 * Copyright (c) 2009 Front Burner Ltd
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  07-May-2009  10444 : Changed to Front Burner.
 * * * * * * * * * * * * * * * * * * * * * * * */

namespace FrontBurner.Apps.EmitScore.Forms
{
  partial class FrmMain
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
      System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(FrmMain));
      System.Windows.Forms.DataGridViewCellStyle dataGridViewCellStyle1 = new System.Windows.Forms.DataGridViewCellStyle();
      System.Windows.Forms.DataGridViewCellStyle dataGridViewCellStyle2 = new System.Windows.Forms.DataGridViewCellStyle();
      this._emitReader = new AxEmitEpt.AxEptReading();
      this.toolStripContainer1 = new System.Windows.Forms.ToolStripContainer();
      this._stsMain = new System.Windows.Forms.StatusStrip();
      this._sslRegister = new System.Windows.Forms.ToolStripStatusLabel();
      this._sslRace = new System.Windows.Forms.ToolStripStatusLabel();
      this.tableLayoutPanel1 = new System.Windows.Forms.TableLayoutPanel();
      this._btnRegister = new System.Windows.Forms.Button();
      this._btnRace = new System.Windows.Forms.Button();
      this._dgvResults = new System.Windows.Forms.DataGridView();
      this.ColGroupName = new System.Windows.Forms.DataGridViewTextBoxColumn();
      this.categoryIdDataGridViewTextBoxColumn = new System.Windows.Forms.DataGridViewComboBoxColumn();
      this._dataSet = new FrontBurner.Apps.EmitScore.Data.EmitScoreDataSet();
      this.totalPointsDataGridViewTextBoxColumn = new System.Windows.Forms.DataGridViewTextBoxColumn();
      this.nettPointsDataGridViewTextBoxColumn = new System.Windows.Forms.DataGridViewTextBoxColumn();
      this.totalTimeSecondsDataGridViewTextBoxColumn = new System.Windows.Forms.DataGridViewTextBoxColumn();
      this._bdsReportTotal = new System.Windows.Forms.BindingSource(this.components);
      this._mnsMain = new System.Windows.Forms.MenuStrip();
      this.fileToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
      this.mniFileNew = new System.Windows.Forms.ToolStripMenuItem();
      this.toolStripSeparator7 = new System.Windows.Forms.ToolStripSeparator();
      this.summaryToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
      this.mniFileSave = new System.Windows.Forms.ToolStripMenuItem();
      this.toolStripSeparator3 = new System.Windows.Forms.ToolStripSeparator();
      this.mniExit = new System.Windows.Forms.ToolStripMenuItem();
      this.configureToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
      this.mniComPort = new System.Windows.Forms.ToolStripMenuItem();
      this.toolStripSeparator2 = new System.Windows.Forms.ToolStripSeparator();
      this.mniLocations = new System.Windows.Forms.ToolStripMenuItem();
      this.toolStripSeparator1 = new System.Windows.Forms.ToolStripSeparator();
      this.mniCategories = new System.Windows.Forms.ToolStripMenuItem();
      this.mniGroups = new System.Windows.Forms.ToolStripMenuItem();
      this.helpToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
      this.mniHelpAbout = new System.Windows.Forms.ToolStripMenuItem();
      this._tspMain = new System.Windows.Forms.ToolStrip();
      this.toolStripButton1 = new System.Windows.Forms.ToolStripButton();
      this._tsbSave = new System.Windows.Forms.ToolStripButton();
      this.toolStripSeparator6 = new System.Windows.Forms.ToolStripSeparator();
      this.tsbExit = new System.Windows.Forms.ToolStripButton();
      this.toolStripSeparator4 = new System.Windows.Forms.ToolStripSeparator();
      this._tsbLocations = new System.Windows.Forms.ToolStripButton();
      this.toolStripSeparator5 = new System.Windows.Forms.ToolStripSeparator();
      this._tsbCategories = new System.Windows.Forms.ToolStripButton();
      this._tsbGroups = new System.Windows.Forms.ToolStripButton();
      this._tmrStatus = new System.Windows.Forms.Timer(this.components);
      this._bdsGroup = new System.Windows.Forms.BindingSource(this.components);
      this.groupTableAdapter = new FrontBurner.Apps.EmitScore.Data.EmitScoreDataSetTableAdapters.GroupTableAdapter();
      this._bdsConfig = new System.Windows.Forms.BindingSource(this.components);
      this.configTableAdapter = new FrontBurner.Apps.EmitScore.Data.EmitScoreDataSetTableAdapters.ConfigTableAdapter();
      this._bdsDefaultCategory = new System.Windows.Forms.BindingSource(this.components);
      this.categoryTableAdapter = new FrontBurner.Apps.EmitScore.Data.EmitScoreDataSetTableAdapters.CategoryTableAdapter();
      this.locationTableAdapter = new FrontBurner.Apps.EmitScore.Data.EmitScoreDataSetTableAdapters.LocationTableAdapter();
      this.groupResultTableAdapter = new FrontBurner.Apps.EmitScore.Data.EmitScoreDataSetTableAdapters.GroupResultTableAdapter();
      this.reportGroupResultTableAdapter = new FrontBurner.Apps.EmitScore.Data.EmitScoreDataSetTableAdapters.ReportGroupResultTableAdapter();
      this.ReportGroupTableAdapter = new FrontBurner.Apps.EmitScore.Data.EmitScoreDataSetTableAdapters.ReportGroupTableAdapter();
      ((System.ComponentModel.ISupportInitialize)(this._emitReader)).BeginInit();
      this.toolStripContainer1.BottomToolStripPanel.SuspendLayout();
      this.toolStripContainer1.ContentPanel.SuspendLayout();
      this.toolStripContainer1.TopToolStripPanel.SuspendLayout();
      this.toolStripContainer1.SuspendLayout();
      this._stsMain.SuspendLayout();
      this.tableLayoutPanel1.SuspendLayout();
      ((System.ComponentModel.ISupportInitialize)(this._dgvResults)).BeginInit();
      ((System.ComponentModel.ISupportInitialize)(this._dataSet)).BeginInit();
      ((System.ComponentModel.ISupportInitialize)(this._bdsReportTotal)).BeginInit();
      this._mnsMain.SuspendLayout();
      this._tspMain.SuspendLayout();
      ((System.ComponentModel.ISupportInitialize)(this._bdsGroup)).BeginInit();
      ((System.ComponentModel.ISupportInitialize)(this._bdsConfig)).BeginInit();
      ((System.ComponentModel.ISupportInitialize)(this._bdsDefaultCategory)).BeginInit();
      this.SuspendLayout();
      // 
      // _emitReader
      // 
      this._emitReader.Enabled = true;
      this._emitReader.Location = new System.Drawing.Point(3, 3);
      this._emitReader.Name = "_emitReader";
      this._emitReader.OcxState = ((System.Windows.Forms.AxHost.State)(resources.GetObject("_emitReader.OcxState")));
      this._emitReader.Size = new System.Drawing.Size(157, 89);
      this._emitReader.TabIndex = 0;
      this._emitReader.GetNextBadge += new AxEmitEpt.@__EptReading_GetNextBadgeEventHandler(this.EmitReader_GetNextBadge);
      // 
      // toolStripContainer1
      // 
      // 
      // toolStripContainer1.BottomToolStripPanel
      // 
      this.toolStripContainer1.BottomToolStripPanel.Controls.Add(this._stsMain);
      // 
      // toolStripContainer1.ContentPanel
      // 
      this.toolStripContainer1.ContentPanel.Controls.Add(this.tableLayoutPanel1);
      this.toolStripContainer1.ContentPanel.Size = new System.Drawing.Size(709, 300);
      this.toolStripContainer1.Dock = System.Windows.Forms.DockStyle.Fill;
      this.toolStripContainer1.Location = new System.Drawing.Point(0, 0);
      this.toolStripContainer1.Name = "toolStripContainer1";
      this.toolStripContainer1.Size = new System.Drawing.Size(709, 404);
      this.toolStripContainer1.TabIndex = 1;
      this.toolStripContainer1.Text = "toolStripContainer1";
      // 
      // toolStripContainer1.TopToolStripPanel
      // 
      this.toolStripContainer1.TopToolStripPanel.Controls.Add(this._mnsMain);
      this.toolStripContainer1.TopToolStripPanel.Controls.Add(this._tspMain);
      // 
      // _stsMain
      // 
      this._stsMain.Dock = System.Windows.Forms.DockStyle.None;
      this._stsMain.Items.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this._sslRegister,
            this._sslRace});
      this._stsMain.Location = new System.Drawing.Point(0, 0);
      this._stsMain.Name = "_stsMain";
      this._stsMain.Size = new System.Drawing.Size(709, 22);
      this._stsMain.TabIndex = 0;
      // 
      // _sslRegister
      // 
      this._sslRegister.Name = "_sslRegister";
      this._sslRegister.Size = new System.Drawing.Size(347, 17);
      this._sslRegister.Spring = true;
      this._sslRegister.TextAlign = System.Drawing.ContentAlignment.MiddleLeft;
      // 
      // _sslRace
      // 
      this._sslRace.Name = "_sslRace";
      this._sslRace.Size = new System.Drawing.Size(347, 17);
      this._sslRace.Spring = true;
      this._sslRace.TextAlign = System.Drawing.ContentAlignment.MiddleRight;
      // 
      // tableLayoutPanel1
      // 
      this.tableLayoutPanel1.ColumnCount = 4;
      this.tableLayoutPanel1.ColumnStyles.Add(new System.Windows.Forms.ColumnStyle(System.Windows.Forms.SizeType.Percent, 25F));
      this.tableLayoutPanel1.ColumnStyles.Add(new System.Windows.Forms.ColumnStyle(System.Windows.Forms.SizeType.Percent, 25F));
      this.tableLayoutPanel1.ColumnStyles.Add(new System.Windows.Forms.ColumnStyle(System.Windows.Forms.SizeType.Percent, 25F));
      this.tableLayoutPanel1.ColumnStyles.Add(new System.Windows.Forms.ColumnStyle(System.Windows.Forms.SizeType.Percent, 25F));
      this.tableLayoutPanel1.Controls.Add(this._emitReader, 0, 0);
      this.tableLayoutPanel1.Controls.Add(this._btnRegister, 1, 0);
      this.tableLayoutPanel1.Controls.Add(this._btnRace, 2, 0);
      this.tableLayoutPanel1.Controls.Add(this._dgvResults, 0, 1);
      this.tableLayoutPanel1.Dock = System.Windows.Forms.DockStyle.Fill;
      this.tableLayoutPanel1.Location = new System.Drawing.Point(0, 0);
      this.tableLayoutPanel1.Name = "tableLayoutPanel1";
      this.tableLayoutPanel1.RowCount = 2;
      this.tableLayoutPanel1.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Absolute, 100F));
      this.tableLayoutPanel1.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Percent, 100F));
      this.tableLayoutPanel1.Size = new System.Drawing.Size(709, 300);
      this.tableLayoutPanel1.TabIndex = 4;
      // 
      // _btnRegister
      // 
      this._btnRegister.Anchor = System.Windows.Forms.AnchorStyles.None;
      this._btnRegister.Font = new System.Drawing.Font("Tahoma", 12F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
      this._btnRegister.Location = new System.Drawing.Point(190, 25);
      this._btnRegister.Name = "_btnRegister";
      this._btnRegister.Size = new System.Drawing.Size(150, 50);
      this._btnRegister.TabIndex = 1;
      this._btnRegister.Text = "Register mode";
      this._btnRegister.UseVisualStyleBackColor = true;
      this._btnRegister.Click += new System.EventHandler(this.ToggleRegister);
      // 
      // _btnRace
      // 
      this._btnRace.Anchor = System.Windows.Forms.AnchorStyles.None;
      this._btnRace.Font = new System.Drawing.Font("Tahoma", 12F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
      this._btnRace.Location = new System.Drawing.Point(367, 25);
      this._btnRace.Name = "_btnRace";
      this._btnRace.Size = new System.Drawing.Size(150, 50);
      this._btnRace.TabIndex = 2;
      this._btnRace.Text = "Race mode";
      this._btnRace.UseVisualStyleBackColor = true;
      this._btnRace.Click += new System.EventHandler(this.ToggleRace);
      // 
      // _dgvResults
      // 
      this._dgvResults.AllowUserToAddRows = false;
      this._dgvResults.AllowUserToDeleteRows = false;
      this._dgvResults.AutoGenerateColumns = false;
      dataGridViewCellStyle1.Alignment = System.Windows.Forms.DataGridViewContentAlignment.MiddleLeft;
      dataGridViewCellStyle1.BackColor = System.Drawing.SystemColors.Control;
      dataGridViewCellStyle1.Font = new System.Drawing.Font("Tahoma", 11.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
      dataGridViewCellStyle1.ForeColor = System.Drawing.SystemColors.WindowText;
      dataGridViewCellStyle1.SelectionBackColor = System.Drawing.SystemColors.Highlight;
      dataGridViewCellStyle1.SelectionForeColor = System.Drawing.SystemColors.HighlightText;
      dataGridViewCellStyle1.WrapMode = System.Windows.Forms.DataGridViewTriState.True;
      this._dgvResults.ColumnHeadersDefaultCellStyle = dataGridViewCellStyle1;
      this._dgvResults.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
      this._dgvResults.Columns.AddRange(new System.Windows.Forms.DataGridViewColumn[] {
            this.ColGroupName,
            this.categoryIdDataGridViewTextBoxColumn,
            this.totalPointsDataGridViewTextBoxColumn,
            this.nettPointsDataGridViewTextBoxColumn,
            this.totalTimeSecondsDataGridViewTextBoxColumn});
      this.tableLayoutPanel1.SetColumnSpan(this._dgvResults, 4);
      this._dgvResults.DataSource = this._bdsReportTotal;
      dataGridViewCellStyle2.Alignment = System.Windows.Forms.DataGridViewContentAlignment.MiddleLeft;
      dataGridViewCellStyle2.BackColor = System.Drawing.SystemColors.Window;
      dataGridViewCellStyle2.Font = new System.Drawing.Font("Tahoma", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
      dataGridViewCellStyle2.ForeColor = System.Drawing.SystemColors.ControlText;
      dataGridViewCellStyle2.SelectionBackColor = System.Drawing.SystemColors.Highlight;
      dataGridViewCellStyle2.SelectionForeColor = System.Drawing.SystemColors.HighlightText;
      dataGridViewCellStyle2.WrapMode = System.Windows.Forms.DataGridViewTriState.False;
      this._dgvResults.DefaultCellStyle = dataGridViewCellStyle2;
      this._dgvResults.Dock = System.Windows.Forms.DockStyle.Fill;
      this._dgvResults.Location = new System.Drawing.Point(3, 103);
      this._dgvResults.Name = "_dgvResults";
      this._dgvResults.ReadOnly = true;
      this._dgvResults.RowTemplate.Height = 26;
      this._dgvResults.Size = new System.Drawing.Size(703, 194);
      this._dgvResults.TabIndex = 4;
      this._dgvResults.DataError += new System.Windows.Forms.DataGridViewDataErrorEventHandler(this._dgvResults_DataError);
      // 
      // ColGroupName
      // 
      this.ColGroupName.DataPropertyName = "GroupName";
      this.ColGroupName.HeaderText = "Group";
      this.ColGroupName.Name = "ColGroupName";
      this.ColGroupName.ReadOnly = true;
      // 
      // categoryIdDataGridViewTextBoxColumn
      // 
      this.categoryIdDataGridViewTextBoxColumn.AutoSizeMode = System.Windows.Forms.DataGridViewAutoSizeColumnMode.AllCells;
      this.categoryIdDataGridViewTextBoxColumn.DataPropertyName = "CategoryId";
      this.categoryIdDataGridViewTextBoxColumn.DataSource = this._dataSet;
      this.categoryIdDataGridViewTextBoxColumn.DisplayMember = "Category.CategoryName";
      this.categoryIdDataGridViewTextBoxColumn.HeaderText = "Category";
      this.categoryIdDataGridViewTextBoxColumn.Name = "categoryIdDataGridViewTextBoxColumn";
      this.categoryIdDataGridViewTextBoxColumn.ReadOnly = true;
      this.categoryIdDataGridViewTextBoxColumn.Resizable = System.Windows.Forms.DataGridViewTriState.True;
      this.categoryIdDataGridViewTextBoxColumn.SortMode = System.Windows.Forms.DataGridViewColumnSortMode.Automatic;
      this.categoryIdDataGridViewTextBoxColumn.ValueMember = "Category.CategoryId";
      this.categoryIdDataGridViewTextBoxColumn.Width = 92;
      // 
      // _dataSet
      // 
      this._dataSet.DataSetName = "EmitScoreDataSet";
      this._dataSet.SchemaSerializationMode = System.Data.SchemaSerializationMode.IncludeSchema;
      // 
      // totalPointsDataGridViewTextBoxColumn
      // 
      this.totalPointsDataGridViewTextBoxColumn.AutoSizeMode = System.Windows.Forms.DataGridViewAutoSizeColumnMode.AllCells;
      this.totalPointsDataGridViewTextBoxColumn.DataPropertyName = "TotalPoints";
      this.totalPointsDataGridViewTextBoxColumn.HeaderText = "Total Points";
      this.totalPointsDataGridViewTextBoxColumn.Name = "totalPointsDataGridViewTextBoxColumn";
      this.totalPointsDataGridViewTextBoxColumn.ReadOnly = true;
      this.totalPointsDataGridViewTextBoxColumn.Width = 109;
      // 
      // nettPointsDataGridViewTextBoxColumn
      // 
      this.nettPointsDataGridViewTextBoxColumn.AutoSizeMode = System.Windows.Forms.DataGridViewAutoSizeColumnMode.AllCells;
      this.nettPointsDataGridViewTextBoxColumn.DataPropertyName = "NettPoints";
      this.nettPointsDataGridViewTextBoxColumn.HeaderText = "Nett Points";
      this.nettPointsDataGridViewTextBoxColumn.Name = "nettPointsDataGridViewTextBoxColumn";
      this.nettPointsDataGridViewTextBoxColumn.ReadOnly = true;
      this.nettPointsDataGridViewTextBoxColumn.Width = 104;
      // 
      // totalTimeSecondsDataGridViewTextBoxColumn
      // 
      this.totalTimeSecondsDataGridViewTextBoxColumn.AutoSizeMode = System.Windows.Forms.DataGridViewAutoSizeColumnMode.AllCells;
      this.totalTimeSecondsDataGridViewTextBoxColumn.DataPropertyName = "TotalTimeSeconds";
      this.totalTimeSecondsDataGridViewTextBoxColumn.HeaderText = "Total Time";
      this.totalTimeSecondsDataGridViewTextBoxColumn.Name = "totalTimeSecondsDataGridViewTextBoxColumn";
      this.totalTimeSecondsDataGridViewTextBoxColumn.ReadOnly = true;
      this.totalTimeSecondsDataGridViewTextBoxColumn.Width = 104;
      // 
      // _bdsReportTotal
      // 
      this._bdsReportTotal.DataMember = "ReportGroup";
      this._bdsReportTotal.DataSource = this._dataSet;
      // 
      // _mnsMain
      // 
      this._mnsMain.Dock = System.Windows.Forms.DockStyle.None;
      this._mnsMain.Items.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.fileToolStripMenuItem,
            this.configureToolStripMenuItem,
            this.helpToolStripMenuItem});
      this._mnsMain.Location = new System.Drawing.Point(0, 0);
      this._mnsMain.Name = "_mnsMain";
      this._mnsMain.Size = new System.Drawing.Size(709, 27);
      this._mnsMain.TabIndex = 0;
      this._mnsMain.Text = "menuStrip1";
      // 
      // fileToolStripMenuItem
      // 
      this.fileToolStripMenuItem.DropDownItems.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.mniFileNew,
            this.toolStripSeparator7,
            this.summaryToolStripMenuItem,
            this.mniFileSave,
            this.toolStripSeparator3,
            this.mniExit});
      this.fileToolStripMenuItem.Font = new System.Drawing.Font("Tahoma", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
      this.fileToolStripMenuItem.Name = "fileToolStripMenuItem";
      this.fileToolStripMenuItem.Size = new System.Drawing.Size(45, 23);
      this.fileToolStripMenuItem.Text = "&File";
      // 
      // mniFileNew
      // 
      this.mniFileNew.Image = global::FrontBurner.Apps.EmitScore.Properties.Resources.NewSmall;
      this.mniFileNew.Name = "mniFileNew";
      this.mniFileNew.Size = new System.Drawing.Size(152, 24);
      this.mniFileNew.Text = "&New";
      this.mniFileNew.Click += new System.EventHandler(this.ClearResultData);
      // 
      // toolStripSeparator7
      // 
      this.toolStripSeparator7.Name = "toolStripSeparator7";
      this.toolStripSeparator7.Size = new System.Drawing.Size(149, 6);
      // 
      // summaryToolStripMenuItem
      // 
      this.summaryToolStripMenuItem.Image = global::FrontBurner.Apps.EmitScore.Properties.Resources.SummarySmall;
      this.summaryToolStripMenuItem.Name = "summaryToolStripMenuItem";
      this.summaryToolStripMenuItem.Size = new System.Drawing.Size(152, 24);
      this.summaryToolStripMenuItem.Text = "S&ummary";
      this.summaryToolStripMenuItem.Click += new System.EventHandler(this.SaveSummaryReport);
      // 
      // mniFileSave
      // 
      this.mniFileSave.Image = global::FrontBurner.Apps.EmitScore.Properties.Resources.SaveSmall;
      this.mniFileSave.Name = "mniFileSave";
      this.mniFileSave.Size = new System.Drawing.Size(152, 24);
      this.mniFileSave.Text = "&Save";
      this.mniFileSave.Click += new System.EventHandler(this.SaveFullReport);
      // 
      // toolStripSeparator3
      // 
      this.toolStripSeparator3.Name = "toolStripSeparator3";
      this.toolStripSeparator3.Size = new System.Drawing.Size(149, 6);
      // 
      // mniExit
      // 
      this.mniExit.Image = global::FrontBurner.Apps.EmitScore.Properties.Resources.ExitSmall;
      this.mniExit.Name = "mniExit";
      this.mniExit.Size = new System.Drawing.Size(152, 24);
      this.mniExit.Text = "E&xit";
      this.mniExit.Click += new System.EventHandler(this.ExitApplication);
      // 
      // configureToolStripMenuItem
      // 
      this.configureToolStripMenuItem.DropDownItems.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.mniComPort,
            this.toolStripSeparator2,
            this.mniLocations,
            this.toolStripSeparator1,
            this.mniCategories,
            this.mniGroups});
      this.configureToolStripMenuItem.Font = new System.Drawing.Font("Tahoma", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
      this.configureToolStripMenuItem.Name = "configureToolStripMenuItem";
      this.configureToolStripMenuItem.Size = new System.Drawing.Size(90, 23);
      this.configureToolStripMenuItem.Text = "&Configure";
      // 
      // mniComPort
      // 
      this.mniComPort.Image = global::FrontBurner.Apps.EmitScore.Properties.Resources.wrench;
      this.mniComPort.Name = "mniComPort";
      this.mniComPort.Size = new System.Drawing.Size(167, 24);
      this.mniComPort.Text = "COM &Port...";
      this.mniComPort.Click += new System.EventHandler(this.ShowConfig);
      // 
      // toolStripSeparator2
      // 
      this.toolStripSeparator2.Name = "toolStripSeparator2";
      this.toolStripSeparator2.Size = new System.Drawing.Size(164, 6);
      // 
      // mniLocations
      // 
      this.mniLocations.Image = global::FrontBurner.Apps.EmitScore.Properties.Resources.LocationSmall;
      this.mniLocations.Name = "mniLocations";
      this.mniLocations.Size = new System.Drawing.Size(167, 24);
      this.mniLocations.Text = "&Locations...";
      this.mniLocations.Click += new System.EventHandler(this.ShowLocations);
      // 
      // toolStripSeparator1
      // 
      this.toolStripSeparator1.Name = "toolStripSeparator1";
      this.toolStripSeparator1.Size = new System.Drawing.Size(164, 6);
      // 
      // mniCategories
      // 
      this.mniCategories.Image = global::FrontBurner.Apps.EmitScore.Properties.Resources.CategorySmall;
      this.mniCategories.Name = "mniCategories";
      this.mniCategories.Size = new System.Drawing.Size(167, 24);
      this.mniCategories.Text = "&Categories...";
      this.mniCategories.Click += new System.EventHandler(this.ShowCategories);
      // 
      // mniGroups
      // 
      this.mniGroups.Image = global::FrontBurner.Apps.EmitScore.Properties.Resources.GroupSmall;
      this.mniGroups.Name = "mniGroups";
      this.mniGroups.Size = new System.Drawing.Size(167, 24);
      this.mniGroups.Text = "&Groups...";
      this.mniGroups.Click += new System.EventHandler(this.ShowGroups);
      // 
      // helpToolStripMenuItem
      // 
      this.helpToolStripMenuItem.DropDownItems.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.mniHelpAbout});
      this.helpToolStripMenuItem.Font = new System.Drawing.Font("Tahoma", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
      this.helpToolStripMenuItem.Name = "helpToolStripMenuItem";
      this.helpToolStripMenuItem.Size = new System.Drawing.Size(53, 23);
      this.helpToolStripMenuItem.Text = "&Help";
      // 
      // mniHelpAbout
      // 
      this.mniHelpAbout.Image = global::FrontBurner.Apps.EmitScore.Properties.Resources.HelpAboutSmall;
      this.mniHelpAbout.Name = "mniHelpAbout";
      this.mniHelpAbout.Size = new System.Drawing.Size(136, 24);
      this.mniHelpAbout.Text = "&About...";
      this.mniHelpAbout.Click += new System.EventHandler(this.HelpAbout);
      // 
      // _tspMain
      // 
      this._tspMain.Dock = System.Windows.Forms.DockStyle.None;
      this._tspMain.ImageScalingSize = new System.Drawing.Size(48, 48);
      this._tspMain.Items.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.toolStripButton1,
            this._tsbSave,
            this.toolStripSeparator6,
            this.tsbExit,
            this.toolStripSeparator4,
            this._tsbLocations,
            this.toolStripSeparator5,
            this._tsbCategories,
            this._tsbGroups});
      this._tspMain.Location = new System.Drawing.Point(3, 27);
      this._tspMain.Name = "_tspMain";
      this._tspMain.Size = new System.Drawing.Size(342, 55);
      this._tspMain.TabIndex = 1;
      // 
      // toolStripButton1
      // 
      this.toolStripButton1.DisplayStyle = System.Windows.Forms.ToolStripItemDisplayStyle.Image;
      this.toolStripButton1.Image = global::FrontBurner.Apps.EmitScore.Properties.Resources.SummaryLarge;
      this.toolStripButton1.ImageTransparentColor = System.Drawing.Color.Magenta;
      this.toolStripButton1.Name = "toolStripButton1";
      this.toolStripButton1.Size = new System.Drawing.Size(52, 52);
      this.toolStripButton1.Text = "toolStripButton1";
      this.toolStripButton1.Click += new System.EventHandler(this.SaveSummaryReport);
      // 
      // _tsbSave
      // 
      this._tsbSave.DisplayStyle = System.Windows.Forms.ToolStripItemDisplayStyle.Image;
      this._tsbSave.Image = global::FrontBurner.Apps.EmitScore.Properties.Resources.SaveLarge;
      this._tsbSave.ImageTransparentColor = System.Drawing.Color.Magenta;
      this._tsbSave.Name = "_tsbSave";
      this._tsbSave.Size = new System.Drawing.Size(52, 52);
      this._tsbSave.Text = "Save Report";
      this._tsbSave.Click += new System.EventHandler(this.SaveFullReport);
      // 
      // toolStripSeparator6
      // 
      this.toolStripSeparator6.Name = "toolStripSeparator6";
      this.toolStripSeparator6.Size = new System.Drawing.Size(6, 55);
      // 
      // tsbExit
      // 
      this.tsbExit.DisplayStyle = System.Windows.Forms.ToolStripItemDisplayStyle.Image;
      this.tsbExit.Image = global::FrontBurner.Apps.EmitScore.Properties.Resources.ExitLarge;
      this.tsbExit.ImageTransparentColor = System.Drawing.Color.Magenta;
      this.tsbExit.Name = "tsbExit";
      this.tsbExit.Size = new System.Drawing.Size(52, 52);
      this.tsbExit.Text = "Exit";
      this.tsbExit.Click += new System.EventHandler(this.ExitApplication);
      // 
      // toolStripSeparator4
      // 
      this.toolStripSeparator4.Name = "toolStripSeparator4";
      this.toolStripSeparator4.Size = new System.Drawing.Size(6, 55);
      // 
      // _tsbLocations
      // 
      this._tsbLocations.DisplayStyle = System.Windows.Forms.ToolStripItemDisplayStyle.Image;
      this._tsbLocations.Image = global::FrontBurner.Apps.EmitScore.Properties.Resources.LocationLarge;
      this._tsbLocations.ImageTransparentColor = System.Drawing.Color.Magenta;
      this._tsbLocations.Name = "_tsbLocations";
      this._tsbLocations.Size = new System.Drawing.Size(52, 52);
      this._tsbLocations.Text = "Edit Locations";
      this._tsbLocations.Click += new System.EventHandler(this.ShowLocations);
      // 
      // toolStripSeparator5
      // 
      this.toolStripSeparator5.Name = "toolStripSeparator5";
      this.toolStripSeparator5.Size = new System.Drawing.Size(6, 55);
      // 
      // _tsbCategories
      // 
      this._tsbCategories.DisplayStyle = System.Windows.Forms.ToolStripItemDisplayStyle.Image;
      this._tsbCategories.Image = global::FrontBurner.Apps.EmitScore.Properties.Resources.CategoryLarge;
      this._tsbCategories.ImageTransparentColor = System.Drawing.Color.Magenta;
      this._tsbCategories.Name = "_tsbCategories";
      this._tsbCategories.Size = new System.Drawing.Size(52, 52);
      this._tsbCategories.Text = "Edit Categories";
      this._tsbCategories.Click += new System.EventHandler(this.ShowCategories);
      // 
      // _tsbGroups
      // 
      this._tsbGroups.DisplayStyle = System.Windows.Forms.ToolStripItemDisplayStyle.Image;
      this._tsbGroups.Image = ((System.Drawing.Image)(resources.GetObject("_tsbGroups.Image")));
      this._tsbGroups.ImageTransparentColor = System.Drawing.Color.Magenta;
      this._tsbGroups.Name = "_tsbGroups";
      this._tsbGroups.Size = new System.Drawing.Size(52, 52);
      this._tsbGroups.Text = "Edit Groups";
      this._tsbGroups.Click += new System.EventHandler(this.ShowGroups);
      // 
      // _tmrStatus
      // 
      this._tmrStatus.Enabled = true;
      this._tmrStatus.Interval = 5000;
      this._tmrStatus.Tick += new System.EventHandler(this.StatusTick);
      // 
      // _bdsGroup
      // 
      this._bdsGroup.DataMember = "Group";
      this._bdsGroup.DataSource = this._dataSet;
      // 
      // groupTableAdapter
      // 
      this.groupTableAdapter.ClearBeforeFill = true;
      // 
      // _bdsConfig
      // 
      this._bdsConfig.DataMember = "Config";
      this._bdsConfig.DataSource = this._dataSet;
      // 
      // configTableAdapter
      // 
      this.configTableAdapter.ClearBeforeFill = true;
      // 
      // _bdsDefaultCategory
      // 
      this._bdsDefaultCategory.DataMember = "Category";
      this._bdsDefaultCategory.DataSource = this._dataSet;
      // 
      // categoryTableAdapter
      // 
      this.categoryTableAdapter.ClearBeforeFill = true;
      // 
      // locationTableAdapter
      // 
      this.locationTableAdapter.ClearBeforeFill = true;
      // 
      // groupResultTableAdapter
      // 
      this.groupResultTableAdapter.ClearBeforeFill = true;
      // 
      // reportGroupResultTableAdapter
      // 
      this.reportGroupResultTableAdapter.ClearBeforeFill = true;
      // 
      // ReportGroupTableAdapter
      // 
      this.ReportGroupTableAdapter.ClearBeforeFill = true;
      // 
      // FrmMain
      // 
      this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
      this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
      this.ClientSize = new System.Drawing.Size(709, 404);
      this.Controls.Add(this.toolStripContainer1);
      this.Icon = ((System.Drawing.Icon)(resources.GetObject("$this.Icon")));
      this.MainMenuStrip = this._mnsMain;
      this.Name = "FrmMain";
      this.Text = "Emit Scoring";
      this.Load += new System.EventHandler(this.FrmMain_Load);
      ((System.ComponentModel.ISupportInitialize)(this._emitReader)).EndInit();
      this.toolStripContainer1.BottomToolStripPanel.ResumeLayout(false);
      this.toolStripContainer1.BottomToolStripPanel.PerformLayout();
      this.toolStripContainer1.ContentPanel.ResumeLayout(false);
      this.toolStripContainer1.TopToolStripPanel.ResumeLayout(false);
      this.toolStripContainer1.TopToolStripPanel.PerformLayout();
      this.toolStripContainer1.ResumeLayout(false);
      this.toolStripContainer1.PerformLayout();
      this._stsMain.ResumeLayout(false);
      this._stsMain.PerformLayout();
      this.tableLayoutPanel1.ResumeLayout(false);
      ((System.ComponentModel.ISupportInitialize)(this._dgvResults)).EndInit();
      ((System.ComponentModel.ISupportInitialize)(this._dataSet)).EndInit();
      ((System.ComponentModel.ISupportInitialize)(this._bdsReportTotal)).EndInit();
      this._mnsMain.ResumeLayout(false);
      this._mnsMain.PerformLayout();
      this._tspMain.ResumeLayout(false);
      this._tspMain.PerformLayout();
      ((System.ComponentModel.ISupportInitialize)(this._bdsGroup)).EndInit();
      ((System.ComponentModel.ISupportInitialize)(this._bdsConfig)).EndInit();
      ((System.ComponentModel.ISupportInitialize)(this._bdsDefaultCategory)).EndInit();
      this.ResumeLayout(false);

    }

    #endregion

    private AxEmitEpt.AxEptReading _emitReader;
    private System.Windows.Forms.ToolStripContainer toolStripContainer1;
    private System.Windows.Forms.MenuStrip _mnsMain;
    private System.Windows.Forms.ToolStripMenuItem fileToolStripMenuItem;
    private System.Windows.Forms.ToolStripMenuItem mniExit;
    private System.Windows.Forms.ToolStripMenuItem configureToolStripMenuItem;
    private System.Windows.Forms.ToolStripMenuItem mniLocations;
    private System.Windows.Forms.ToolStripSeparator toolStripSeparator1;
    private System.Windows.Forms.ToolStripMenuItem mniCategories;
    private System.Windows.Forms.ToolStripMenuItem mniGroups;
    private System.Windows.Forms.ToolStrip _tspMain;
    private System.Windows.Forms.ToolStripMenuItem mniComPort;
    private System.Windows.Forms.ToolStripSeparator toolStripSeparator2;
    private System.Windows.Forms.StatusStrip _stsMain;
    private System.Windows.Forms.ToolStripStatusLabel _sslRegister;
    private System.Windows.Forms.ToolStripMenuItem mniFileNew;
    private System.Windows.Forms.ToolStripMenuItem mniFileSave;
    private System.Windows.Forms.ToolStripSeparator toolStripSeparator3;
    private System.Windows.Forms.ToolStripButton tsbExit;
    private System.Windows.Forms.ToolStripSeparator toolStripSeparator4;
    private System.Windows.Forms.ToolStripButton _tsbGroups;
    private System.Windows.Forms.BindingSource _bdsGroup;
    private FrontBurner.Apps.EmitScore.Data.EmitScoreDataSet _dataSet;
    private FrontBurner.Apps.EmitScore.Data.EmitScoreDataSetTableAdapters.GroupTableAdapter groupTableAdapter;
    private System.Windows.Forms.Button _btnRace;
    private System.Windows.Forms.Button _btnRegister;
    private System.Windows.Forms.ToolStripStatusLabel _sslRace;
    private System.Windows.Forms.Timer _tmrStatus;
    private System.Windows.Forms.ToolStripButton _tsbCategories;
    private System.Windows.Forms.ToolStripButton _tsbLocations;
    private System.Windows.Forms.ToolStripSeparator toolStripSeparator5;
    private System.Windows.Forms.BindingSource _bdsConfig;
    private FrontBurner.Apps.EmitScore.Data.EmitScoreDataSetTableAdapters.ConfigTableAdapter configTableAdapter;
    private System.Windows.Forms.BindingSource _bdsDefaultCategory;
    private FrontBurner.Apps.EmitScore.Data.EmitScoreDataSetTableAdapters.CategoryTableAdapter categoryTableAdapter;
    private FrontBurner.Apps.EmitScore.Data.EmitScoreDataSetTableAdapters.LocationTableAdapter locationTableAdapter;
    private FrontBurner.Apps.EmitScore.Data.EmitScoreDataSetTableAdapters.GroupResultTableAdapter groupResultTableAdapter;
    private System.Windows.Forms.ToolStripButton _tsbSave;
    private System.Windows.Forms.ToolStripMenuItem helpToolStripMenuItem;
    private System.Windows.Forms.ToolStripMenuItem mniHelpAbout;
    private System.Windows.Forms.TableLayoutPanel tableLayoutPanel1;
    private System.Windows.Forms.DataGridView _dgvResults;
    private FrontBurner.Apps.EmitScore.Data.EmitScoreDataSetTableAdapters.ReportGroupResultTableAdapter reportGroupResultTableAdapter;
    private System.Windows.Forms.DataGridViewTextBoxColumn ColGroupName;
    private System.Windows.Forms.DataGridViewComboBoxColumn categoryIdDataGridViewTextBoxColumn;
    private System.Windows.Forms.DataGridViewTextBoxColumn totalPointsDataGridViewTextBoxColumn;
    private System.Windows.Forms.DataGridViewTextBoxColumn nettPointsDataGridViewTextBoxColumn;
    private System.Windows.Forms.DataGridViewTextBoxColumn totalTimeSecondsDataGridViewTextBoxColumn;
    private FrontBurner.Apps.EmitScore.Data.EmitScoreDataSetTableAdapters.ReportGroupTableAdapter ReportGroupTableAdapter;
    private System.Windows.Forms.BindingSource _bdsReportTotal;
    private System.Windows.Forms.ToolStripButton toolStripButton1;
    private System.Windows.Forms.ToolStripSeparator toolStripSeparator6;
    private System.Windows.Forms.ToolStripSeparator toolStripSeparator7;
    private System.Windows.Forms.ToolStripMenuItem summaryToolStripMenuItem;
  }
}

