namespace Southesk.Apps.EmitScore.Forms
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
      this._emitReader = new AxEmitEpt.AxEptReading();
      this.toolStripContainer1 = new System.Windows.Forms.ToolStripContainer();
      this._stsMain = new System.Windows.Forms.StatusStrip();
      this._sslRegister = new System.Windows.Forms.ToolStripStatusLabel();
      this._sslRace = new System.Windows.Forms.ToolStripStatusLabel();
      this._btnRace = new System.Windows.Forms.Button();
      this._btnRegister = new System.Windows.Forms.Button();
      this._mnsMain = new System.Windows.Forms.MenuStrip();
      this.fileToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
      this.mniFileNew = new System.Windows.Forms.ToolStripMenuItem();
      this.mniFileSave = new System.Windows.Forms.ToolStripMenuItem();
      this.toolStripSeparator3 = new System.Windows.Forms.ToolStripSeparator();
      this.mniExit = new System.Windows.Forms.ToolStripMenuItem();
      this.configureToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
      this.mniComPort = new System.Windows.Forms.ToolStripMenuItem();
      this.toolStripSeparator2 = new System.Windows.Forms.ToolStripSeparator();
      this.mniLocations = new System.Windows.Forms.ToolStripMenuItem();
      this.toolStripSeparator1 = new System.Windows.Forms.ToolStripSeparator();
      this.mniCategories = new System.Windows.Forms.ToolStripMenuItem();
      this.mniTeams = new System.Windows.Forms.ToolStripMenuItem();
      this.mniGroups = new System.Windows.Forms.ToolStripMenuItem();
      this._tspMain = new System.Windows.Forms.ToolStrip();
      this._tsbSave = new System.Windows.Forms.ToolStripButton();
      this.tsbExit = new System.Windows.Forms.ToolStripButton();
      this.toolStripSeparator4 = new System.Windows.Forms.ToolStripSeparator();
      this._tsbLocations = new System.Windows.Forms.ToolStripButton();
      this.toolStripSeparator5 = new System.Windows.Forms.ToolStripSeparator();
      this._tsbCategories = new System.Windows.Forms.ToolStripButton();
      this._tsbTeams = new System.Windows.Forms.ToolStripButton();
      this._tsbGroups = new System.Windows.Forms.ToolStripButton();
      this._tmrStatus = new System.Windows.Forms.Timer(this.components);
      this._bdsGroup = new System.Windows.Forms.BindingSource(this.components);
      this._dataSet = new Southesk.Apps.EmitScore.Data.EmitScoreDataSet();
      this.groupTableAdapter = new Southesk.Apps.EmitScore.Data.EmitScoreDataSetTableAdapters.GroupTableAdapter();
      this._bdsConfig = new System.Windows.Forms.BindingSource(this.components);
      this.configTableAdapter = new Southesk.Apps.EmitScore.Data.EmitScoreDataSetTableAdapters.ConfigTableAdapter();
      this._bdsDefaultCategory = new System.Windows.Forms.BindingSource(this.components);
      this.categoryTableAdapter = new Southesk.Apps.EmitScore.Data.EmitScoreDataSetTableAdapters.CategoryTableAdapter();
      this.locationTableAdapter = new Southesk.Apps.EmitScore.Data.EmitScoreDataSetTableAdapters.LocationTableAdapter();
      this.groupResultTableAdapter = new Southesk.Apps.EmitScore.Data.EmitScoreDataSetTableAdapters.GroupResultTableAdapter();
      this.teamResultsTableAdapter = new Southesk.Apps.EmitScore.Data.EmitScoreDataSetTableAdapters.TeamResultsTableAdapter();
      ((System.ComponentModel.ISupportInitialize)(this._emitReader)).BeginInit();
      this.toolStripContainer1.BottomToolStripPanel.SuspendLayout();
      this.toolStripContainer1.ContentPanel.SuspendLayout();
      this.toolStripContainer1.TopToolStripPanel.SuspendLayout();
      this.toolStripContainer1.SuspendLayout();
      this._stsMain.SuspendLayout();
      this._mnsMain.SuspendLayout();
      this._tspMain.SuspendLayout();
      ((System.ComponentModel.ISupportInitialize)(this._bdsGroup)).BeginInit();
      ((System.ComponentModel.ISupportInitialize)(this._dataSet)).BeginInit();
      ((System.ComponentModel.ISupportInitialize)(this._bdsConfig)).BeginInit();
      ((System.ComponentModel.ISupportInitialize)(this._bdsDefaultCategory)).BeginInit();
      this.SuspendLayout();
      // 
      // _emitReader
      // 
      this._emitReader.Enabled = true;
      this._emitReader.Location = new System.Drawing.Point(12, 3);
      this._emitReader.Name = "_emitReader";
      this._emitReader.OcxState = ((System.Windows.Forms.AxHost.State)(resources.GetObject("_emitReader.OcxState")));
      this._emitReader.Size = new System.Drawing.Size(155, 81);
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
      this.toolStripContainer1.ContentPanel.Controls.Add(this._btnRace);
      this.toolStripContainer1.ContentPanel.Controls.Add(this._btnRegister);
      this.toolStripContainer1.ContentPanel.Controls.Add(this._emitReader);
      this.toolStripContainer1.ContentPanel.Size = new System.Drawing.Size(393, 142);
      this.toolStripContainer1.Dock = System.Windows.Forms.DockStyle.Fill;
      this.toolStripContainer1.Location = new System.Drawing.Point(0, 0);
      this.toolStripContainer1.Name = "toolStripContainer1";
      this.toolStripContainer1.Size = new System.Drawing.Size(393, 243);
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
      this._stsMain.Size = new System.Drawing.Size(393, 22);
      this._stsMain.TabIndex = 0;
      // 
      // _sslRegister
      // 
      this._sslRegister.Name = "_sslRegister";
      this._sslRegister.Size = new System.Drawing.Size(189, 17);
      this._sslRegister.Spring = true;
      this._sslRegister.TextAlign = System.Drawing.ContentAlignment.MiddleLeft;
      // 
      // _sslRace
      // 
      this._sslRace.Name = "_sslRace";
      this._sslRace.Size = new System.Drawing.Size(189, 17);
      this._sslRace.Spring = true;
      this._sslRace.TextAlign = System.Drawing.ContentAlignment.MiddleRight;
      // 
      // _btnRace
      // 
      this._btnRace.Font = new System.Drawing.Font("Tahoma", 12F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
      this._btnRace.Location = new System.Drawing.Point(208, 74);
      this._btnRace.Name = "_btnRace";
      this._btnRace.Size = new System.Drawing.Size(171, 50);
      this._btnRace.TabIndex = 2;
      this._btnRace.Text = "Race mode";
      this._btnRace.UseVisualStyleBackColor = true;
      this._btnRace.Click += new System.EventHandler(this._btnRace_Click);
      // 
      // _btnRegister
      // 
      this._btnRegister.Font = new System.Drawing.Font("Tahoma", 12F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
      this._btnRegister.Location = new System.Drawing.Point(208, 18);
      this._btnRegister.Name = "_btnRegister";
      this._btnRegister.Size = new System.Drawing.Size(171, 50);
      this._btnRegister.TabIndex = 1;
      this._btnRegister.Text = "Register mode";
      this._btnRegister.UseVisualStyleBackColor = true;
      this._btnRegister.Click += new System.EventHandler(this._btnRegister_Click);
      // 
      // _mnsMain
      // 
      this._mnsMain.Dock = System.Windows.Forms.DockStyle.None;
      this._mnsMain.Items.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.fileToolStripMenuItem,
            this.configureToolStripMenuItem});
      this._mnsMain.Location = new System.Drawing.Point(0, 0);
      this._mnsMain.Name = "_mnsMain";
      this._mnsMain.Size = new System.Drawing.Size(393, 24);
      this._mnsMain.TabIndex = 0;
      this._mnsMain.Text = "menuStrip1";
      // 
      // fileToolStripMenuItem
      // 
      this.fileToolStripMenuItem.DropDownItems.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.mniFileNew,
            this.mniFileSave,
            this.toolStripSeparator3,
            this.mniExit});
      this.fileToolStripMenuItem.Name = "fileToolStripMenuItem";
      this.fileToolStripMenuItem.Size = new System.Drawing.Size(35, 20);
      this.fileToolStripMenuItem.Text = "&File";
      // 
      // mniFileNew
      // 
      this.mniFileNew.Image = global::Southesk.Apps.EmitScore.Properties.Resources.NewSmall;
      this.mniFileNew.Name = "mniFileNew";
      this.mniFileNew.Size = new System.Drawing.Size(152, 22);
      this.mniFileNew.Text = "&New";
      this.mniFileNew.Click += new System.EventHandler(this.mniFileNew_Click);
      // 
      // mniFileSave
      // 
      this.mniFileSave.Image = global::Southesk.Apps.EmitScore.Properties.Resources.SaveSmall;
      this.mniFileSave.Name = "mniFileSave";
      this.mniFileSave.Size = new System.Drawing.Size(152, 22);
      this.mniFileSave.Text = "&Save";
      this.mniFileSave.Click += new System.EventHandler(this.mniFileSave_Click);
      // 
      // toolStripSeparator3
      // 
      this.toolStripSeparator3.Name = "toolStripSeparator3";
      this.toolStripSeparator3.Size = new System.Drawing.Size(149, 6);
      // 
      // mniExit
      // 
      this.mniExit.Image = global::Southesk.Apps.EmitScore.Properties.Resources.ExitSmall;
      this.mniExit.Name = "mniExit";
      this.mniExit.Size = new System.Drawing.Size(152, 22);
      this.mniExit.Text = "E&xit";
      this.mniExit.Click += new System.EventHandler(this.mniExit_Click);
      // 
      // configureToolStripMenuItem
      // 
      this.configureToolStripMenuItem.DropDownItems.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.mniComPort,
            this.toolStripSeparator2,
            this.mniLocations,
            this.toolStripSeparator1,
            this.mniCategories,
            this.mniTeams,
            this.mniGroups});
      this.configureToolStripMenuItem.Name = "configureToolStripMenuItem";
      this.configureToolStripMenuItem.Size = new System.Drawing.Size(66, 20);
      this.configureToolStripMenuItem.Text = "&Configure";
      // 
      // mniComPort
      // 
      this.mniComPort.Image = global::Southesk.Apps.EmitScore.Properties.Resources.wrench;
      this.mniComPort.Name = "mniComPort";
      this.mniComPort.Size = new System.Drawing.Size(149, 22);
      this.mniComPort.Text = "COM &Port...";
      this.mniComPort.Click += new System.EventHandler(this.mniComPort_Click);
      // 
      // toolStripSeparator2
      // 
      this.toolStripSeparator2.Name = "toolStripSeparator2";
      this.toolStripSeparator2.Size = new System.Drawing.Size(146, 6);
      // 
      // mniLocations
      // 
      this.mniLocations.Image = global::Southesk.Apps.EmitScore.Properties.Resources.LocationSmall;
      this.mniLocations.Name = "mniLocations";
      this.mniLocations.Size = new System.Drawing.Size(149, 22);
      this.mniLocations.Text = "&Locations...";
      this.mniLocations.Click += new System.EventHandler(this.mniLocations_Click);
      // 
      // toolStripSeparator1
      // 
      this.toolStripSeparator1.Name = "toolStripSeparator1";
      this.toolStripSeparator1.Size = new System.Drawing.Size(146, 6);
      // 
      // mniCategories
      // 
      this.mniCategories.Image = global::Southesk.Apps.EmitScore.Properties.Resources.CategorySmall;
      this.mniCategories.Name = "mniCategories";
      this.mniCategories.Size = new System.Drawing.Size(149, 22);
      this.mniCategories.Text = "&Categories...";
      this.mniCategories.Click += new System.EventHandler(this.mniCategories_Click);
      // 
      // mniTeams
      // 
      this.mniTeams.Image = ((System.Drawing.Image)(resources.GetObject("mniTeams.Image")));
      this.mniTeams.Name = "mniTeams";
      this.mniTeams.Size = new System.Drawing.Size(149, 22);
      this.mniTeams.Text = "&Teams...";
      this.mniTeams.Click += new System.EventHandler(this.mniTeams_Click);
      // 
      // mniGroups
      // 
      this.mniGroups.Image = global::Southesk.Apps.EmitScore.Properties.Resources.GroupSmall;
      this.mniGroups.Name = "mniGroups";
      this.mniGroups.Size = new System.Drawing.Size(149, 22);
      this.mniGroups.Text = "&Groups...";
      this.mniGroups.Click += new System.EventHandler(this.mniGroups_Click);
      // 
      // _tspMain
      // 
      this._tspMain.Dock = System.Windows.Forms.DockStyle.None;
      this._tspMain.ImageScalingSize = new System.Drawing.Size(48, 48);
      this._tspMain.Items.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this._tsbSave,
            this.tsbExit,
            this.toolStripSeparator4,
            this._tsbLocations,
            this.toolStripSeparator5,
            this._tsbCategories,
            this._tsbTeams,
            this._tsbGroups});
      this._tspMain.Location = new System.Drawing.Point(3, 24);
      this._tspMain.Name = "_tspMain";
      this._tspMain.Size = new System.Drawing.Size(336, 55);
      this._tspMain.TabIndex = 1;
      // 
      // _tsbSave
      // 
      this._tsbSave.DisplayStyle = System.Windows.Forms.ToolStripItemDisplayStyle.Image;
      this._tsbSave.Image = global::Southesk.Apps.EmitScore.Properties.Resources.SaveLarge;
      this._tsbSave.ImageTransparentColor = System.Drawing.Color.Magenta;
      this._tsbSave.Name = "_tsbSave";
      this._tsbSave.Size = new System.Drawing.Size(52, 52);
      this._tsbSave.Text = "Save Report";
      this._tsbSave.Click += new System.EventHandler(this._tsbSave_Click);
      // 
      // tsbExit
      // 
      this.tsbExit.DisplayStyle = System.Windows.Forms.ToolStripItemDisplayStyle.Image;
      this.tsbExit.Image = global::Southesk.Apps.EmitScore.Properties.Resources.ExitLarge;
      this.tsbExit.ImageTransparentColor = System.Drawing.Color.Magenta;
      this.tsbExit.Name = "tsbExit";
      this.tsbExit.Size = new System.Drawing.Size(52, 52);
      this.tsbExit.Text = "Exit";
      this.tsbExit.Click += new System.EventHandler(this.tsbExit_Click);
      // 
      // toolStripSeparator4
      // 
      this.toolStripSeparator4.Name = "toolStripSeparator4";
      this.toolStripSeparator4.Size = new System.Drawing.Size(6, 55);
      // 
      // _tsbLocations
      // 
      this._tsbLocations.DisplayStyle = System.Windows.Forms.ToolStripItemDisplayStyle.Image;
      this._tsbLocations.Image = global::Southesk.Apps.EmitScore.Properties.Resources.LocationLarge;
      this._tsbLocations.ImageTransparentColor = System.Drawing.Color.Magenta;
      this._tsbLocations.Name = "_tsbLocations";
      this._tsbLocations.Size = new System.Drawing.Size(52, 52);
      this._tsbLocations.Text = "Edit Locations";
      this._tsbLocations.Click += new System.EventHandler(this._tsbLocations_Click);
      // 
      // toolStripSeparator5
      // 
      this.toolStripSeparator5.Name = "toolStripSeparator5";
      this.toolStripSeparator5.Size = new System.Drawing.Size(6, 55);
      // 
      // _tsbCategories
      // 
      this._tsbCategories.DisplayStyle = System.Windows.Forms.ToolStripItemDisplayStyle.Image;
      this._tsbCategories.Image = global::Southesk.Apps.EmitScore.Properties.Resources.CategoryLarge;
      this._tsbCategories.ImageTransparentColor = System.Drawing.Color.Magenta;
      this._tsbCategories.Name = "_tsbCategories";
      this._tsbCategories.Size = new System.Drawing.Size(52, 52);
      this._tsbCategories.Text = "Edit Categories";
      this._tsbCategories.Click += new System.EventHandler(this.tsbCategories_Click);
      // 
      // _tsbTeams
      // 
      this._tsbTeams.DisplayStyle = System.Windows.Forms.ToolStripItemDisplayStyle.Image;
      this._tsbTeams.Image = global::Southesk.Apps.EmitScore.Properties.Resources.TeamLarge;
      this._tsbTeams.ImageTransparentColor = System.Drawing.Color.Magenta;
      this._tsbTeams.Name = "_tsbTeams";
      this._tsbTeams.Size = new System.Drawing.Size(52, 52);
      this._tsbTeams.Text = "Edit Teams";
      this._tsbTeams.Click += new System.EventHandler(this._tsbTeams_Click);
      // 
      // _tsbGroups
      // 
      this._tsbGroups.DisplayStyle = System.Windows.Forms.ToolStripItemDisplayStyle.Image;
      this._tsbGroups.Image = ((System.Drawing.Image)(resources.GetObject("_tsbGroups.Image")));
      this._tsbGroups.ImageTransparentColor = System.Drawing.Color.Magenta;
      this._tsbGroups.Name = "_tsbGroups";
      this._tsbGroups.Size = new System.Drawing.Size(52, 52);
      this._tsbGroups.Text = "Edit Groups";
      this._tsbGroups.Click += new System.EventHandler(this.tsbGroups_Click);
      // 
      // _tmrStatus
      // 
      this._tmrStatus.Enabled = true;
      this._tmrStatus.Interval = 5000;
      this._tmrStatus.Tick += new System.EventHandler(this._tmrStatus_Tick);
      // 
      // _bdsGroup
      // 
      this._bdsGroup.DataMember = "Group";
      this._bdsGroup.DataSource = this._dataSet;
      // 
      // _dataSet
      // 
      this._dataSet.DataSetName = "EmitScoreDataSet";
      this._dataSet.SchemaSerializationMode = System.Data.SchemaSerializationMode.IncludeSchema;
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
      // teamResultsTableAdapter
      // 
      this.teamResultsTableAdapter.ClearBeforeFill = true;
      // 
      // FrmMain
      // 
      this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
      this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
      this.ClientSize = new System.Drawing.Size(393, 243);
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
      this._mnsMain.ResumeLayout(false);
      this._mnsMain.PerformLayout();
      this._tspMain.ResumeLayout(false);
      this._tspMain.PerformLayout();
      ((System.ComponentModel.ISupportInitialize)(this._bdsGroup)).EndInit();
      ((System.ComponentModel.ISupportInitialize)(this._dataSet)).EndInit();
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
    private Southesk.Apps.EmitScore.Data.EmitScoreDataSet _dataSet;
    private Southesk.Apps.EmitScore.Data.EmitScoreDataSetTableAdapters.GroupTableAdapter groupTableAdapter;
    private System.Windows.Forms.Button _btnRace;
    private System.Windows.Forms.Button _btnRegister;
    private System.Windows.Forms.ToolStripStatusLabel _sslRace;
    private System.Windows.Forms.Timer _tmrStatus;
    private System.Windows.Forms.ToolStripButton _tsbCategories;
    private System.Windows.Forms.ToolStripButton _tsbLocations;
    private System.Windows.Forms.ToolStripSeparator toolStripSeparator5;
    private System.Windows.Forms.BindingSource _bdsConfig;
    private Southesk.Apps.EmitScore.Data.EmitScoreDataSetTableAdapters.ConfigTableAdapter configTableAdapter;
    private System.Windows.Forms.BindingSource _bdsDefaultCategory;
    private Southesk.Apps.EmitScore.Data.EmitScoreDataSetTableAdapters.CategoryTableAdapter categoryTableAdapter;
    private Southesk.Apps.EmitScore.Data.EmitScoreDataSetTableAdapters.LocationTableAdapter locationTableAdapter;
    private Southesk.Apps.EmitScore.Data.EmitScoreDataSetTableAdapters.GroupResultTableAdapter groupResultTableAdapter;
    private Southesk.Apps.EmitScore.Data.EmitScoreDataSetTableAdapters.TeamResultsTableAdapter teamResultsTableAdapter;
    private System.Windows.Forms.ToolStripMenuItem mniTeams;
    private System.Windows.Forms.ToolStripButton _tsbTeams;
    private System.Windows.Forms.ToolStripButton _tsbSave;
  }
}

