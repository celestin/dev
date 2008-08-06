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
      this.statusStrip1 = new System.Windows.Forms.StatusStrip();
      this._sslRegister = new System.Windows.Forms.ToolStripStatusLabel();
      this._sslRace = new System.Windows.Forms.ToolStripStatusLabel();
      this._btnRace = new System.Windows.Forms.Button();
      this._btnRegister = new System.Windows.Forms.Button();
      this.menuStrip1 = new System.Windows.Forms.MenuStrip();
      this.fileToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
      this.mniFileNew = new System.Windows.Forms.ToolStripMenuItem();
      this.mniFileSave = new System.Windows.Forms.ToolStripMenuItem();
      this.toolStripSeparator3 = new System.Windows.Forms.ToolStripSeparator();
      this.configureToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
      this.toolStripSeparator2 = new System.Windows.Forms.ToolStripSeparator();
      this.toolStripSeparator1 = new System.Windows.Forms.ToolStripSeparator();
      this.toolStrip1 = new System.Windows.Forms.ToolStrip();
      this.toolStripSeparator4 = new System.Windows.Forms.ToolStripSeparator();
      this.toolStripSeparator5 = new System.Windows.Forms.ToolStripSeparator();
      this._tmrStatus = new System.Windows.Forms.Timer(this.components);
      this.bdsGroup = new System.Windows.Forms.BindingSource(this.components);
      this.emitScoreDataSet = new Southesk.Apps.EmitScore.Data.EmitScoreDataSet();
      this.groupTableAdapter = new Southesk.Apps.EmitScore.Data.EmitScoreDataSetTableAdapters.GroupTableAdapter();
      this._bdsConfig = new System.Windows.Forms.BindingSource(this.components);
      this.configTableAdapter = new Southesk.Apps.EmitScore.Data.EmitScoreDataSetTableAdapters.ConfigTableAdapter();
      this.mniExit = new System.Windows.Forms.ToolStripMenuItem();
      this.mniComPort = new System.Windows.Forms.ToolStripMenuItem();
      this.mniLocations = new System.Windows.Forms.ToolStripMenuItem();
      this.mniCategories = new System.Windows.Forms.ToolStripMenuItem();
      this.mniGroups = new System.Windows.Forms.ToolStripMenuItem();
      this.tsbExit = new System.Windows.Forms.ToolStripButton();
      this._tsbLocations = new System.Windows.Forms.ToolStripButton();
      this._tsbCategories = new System.Windows.Forms.ToolStripButton();
      this._tsbGroups = new System.Windows.Forms.ToolStripButton();
      ((System.ComponentModel.ISupportInitialize)(this._emitReader)).BeginInit();
      this.toolStripContainer1.BottomToolStripPanel.SuspendLayout();
      this.toolStripContainer1.ContentPanel.SuspendLayout();
      this.toolStripContainer1.TopToolStripPanel.SuspendLayout();
      this.toolStripContainer1.SuspendLayout();
      this.statusStrip1.SuspendLayout();
      this.menuStrip1.SuspendLayout();
      this.toolStrip1.SuspendLayout();
      ((System.ComponentModel.ISupportInitialize)(this.bdsGroup)).BeginInit();
      ((System.ComponentModel.ISupportInitialize)(this.emitScoreDataSet)).BeginInit();
      ((System.ComponentModel.ISupportInitialize)(this._bdsConfig)).BeginInit();
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
      this.toolStripContainer1.BottomToolStripPanel.Controls.Add(this.statusStrip1);
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
      this.toolStripContainer1.TopToolStripPanel.Controls.Add(this.menuStrip1);
      this.toolStripContainer1.TopToolStripPanel.Controls.Add(this.toolStrip1);
      // 
      // statusStrip1
      // 
      this.statusStrip1.Dock = System.Windows.Forms.DockStyle.None;
      this.statusStrip1.Items.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this._sslRegister,
            this._sslRace});
      this.statusStrip1.Location = new System.Drawing.Point(0, 0);
      this.statusStrip1.Name = "statusStrip1";
      this.statusStrip1.Size = new System.Drawing.Size(393, 22);
      this.statusStrip1.TabIndex = 0;
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
      // menuStrip1
      // 
      this.menuStrip1.Dock = System.Windows.Forms.DockStyle.None;
      this.menuStrip1.Items.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.fileToolStripMenuItem,
            this.configureToolStripMenuItem});
      this.menuStrip1.Location = new System.Drawing.Point(0, 0);
      this.menuStrip1.Name = "menuStrip1";
      this.menuStrip1.Size = new System.Drawing.Size(393, 24);
      this.menuStrip1.TabIndex = 0;
      this.menuStrip1.Text = "menuStrip1";
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
      this.mniFileNew.Name = "mniFileNew";
      this.mniFileNew.Size = new System.Drawing.Size(109, 22);
      this.mniFileNew.Text = "&New";
      this.mniFileNew.Click += new System.EventHandler(this.mniFileNew_Click);
      // 
      // mniFileSave
      // 
      this.mniFileSave.Name = "mniFileSave";
      this.mniFileSave.Size = new System.Drawing.Size(109, 22);
      this.mniFileSave.Text = "&Save";
      // 
      // toolStripSeparator3
      // 
      this.toolStripSeparator3.Name = "toolStripSeparator3";
      this.toolStripSeparator3.Size = new System.Drawing.Size(106, 6);
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
      this.configureToolStripMenuItem.Name = "configureToolStripMenuItem";
      this.configureToolStripMenuItem.Size = new System.Drawing.Size(66, 20);
      this.configureToolStripMenuItem.Text = "&Configure";
      // 
      // toolStripSeparator2
      // 
      this.toolStripSeparator2.Name = "toolStripSeparator2";
      this.toolStripSeparator2.Size = new System.Drawing.Size(149, 6);
      // 
      // toolStripSeparator1
      // 
      this.toolStripSeparator1.Name = "toolStripSeparator1";
      this.toolStripSeparator1.Size = new System.Drawing.Size(149, 6);
      // 
      // toolStrip1
      // 
      this.toolStrip1.Dock = System.Windows.Forms.DockStyle.None;
      this.toolStrip1.ImageScalingSize = new System.Drawing.Size(48, 48);
      this.toolStrip1.Items.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.tsbExit,
            this.toolStripSeparator4,
            this._tsbLocations,
            this.toolStripSeparator5,
            this._tsbCategories,
            this._tsbGroups});
      this.toolStrip1.Location = new System.Drawing.Point(3, 24);
      this.toolStrip1.Name = "toolStrip1";
      this.toolStrip1.Size = new System.Drawing.Size(263, 55);
      this.toolStrip1.TabIndex = 1;
      // 
      // toolStripSeparator4
      // 
      this.toolStripSeparator4.Name = "toolStripSeparator4";
      this.toolStripSeparator4.Size = new System.Drawing.Size(6, 55);
      // 
      // toolStripSeparator5
      // 
      this.toolStripSeparator5.Name = "toolStripSeparator5";
      this.toolStripSeparator5.Size = new System.Drawing.Size(6, 55);
      // 
      // _tmrStatus
      // 
      this._tmrStatus.Enabled = true;
      this._tmrStatus.Interval = 5000;
      this._tmrStatus.Tick += new System.EventHandler(this._tmrStatus_Tick);
      // 
      // bdsGroup
      // 
      this.bdsGroup.DataMember = "Group";
      this.bdsGroup.DataSource = this.emitScoreDataSet;
      // 
      // emitScoreDataSet
      // 
      this.emitScoreDataSet.DataSetName = "EmitScoreDataSet";
      this.emitScoreDataSet.SchemaSerializationMode = System.Data.SchemaSerializationMode.IncludeSchema;
      // 
      // groupTableAdapter
      // 
      this.groupTableAdapter.ClearBeforeFill = true;
      // 
      // _bdsConfig
      // 
      this._bdsConfig.DataMember = "Config";
      this._bdsConfig.DataSource = this.emitScoreDataSet;
      // 
      // configTableAdapter
      // 
      this.configTableAdapter.ClearBeforeFill = true;
      // 
      // mniExit
      // 
      this.mniExit.Image = global::Southesk.Apps.EmitScore.Properties.Resources.ExitSmall;
      this.mniExit.Name = "mniExit";
      this.mniExit.Size = new System.Drawing.Size(109, 22);
      this.mniExit.Text = "E&xit";
      this.mniExit.Click += new System.EventHandler(this.mniExit_Click);
      // 
      // mniComPort
      // 
      this.mniComPort.Image = global::Southesk.Apps.EmitScore.Properties.Resources.wrench;
      this.mniComPort.Name = "mniComPort";
      this.mniComPort.Size = new System.Drawing.Size(152, 22);
      this.mniComPort.Text = "COM &Port...";
      this.mniComPort.Click += new System.EventHandler(this.mniComPort_Click);
      // 
      // mniLocations
      // 
      this.mniLocations.Image = global::Southesk.Apps.EmitScore.Properties.Resources.LocationSmall;
      this.mniLocations.Name = "mniLocations";
      this.mniLocations.Size = new System.Drawing.Size(152, 22);
      this.mniLocations.Text = "&Locations...";
      this.mniLocations.Click += new System.EventHandler(this.mniLocations_Click);
      // 
      // mniCategories
      // 
      this.mniCategories.Image = global::Southesk.Apps.EmitScore.Properties.Resources.CategorySmall;
      this.mniCategories.Name = "mniCategories";
      this.mniCategories.Size = new System.Drawing.Size(152, 22);
      this.mniCategories.Text = "&Categories...";
      this.mniCategories.Click += new System.EventHandler(this.mniCategories_Click);
      // 
      // mniGroups
      // 
      this.mniGroups.Image = global::Southesk.Apps.EmitScore.Properties.Resources.GroupSmall;
      this.mniGroups.Name = "mniGroups";
      this.mniGroups.Size = new System.Drawing.Size(152, 22);
      this.mniGroups.Text = "&Groups...";
      this.mniGroups.Click += new System.EventHandler(this.mniGroups_Click);
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
      // FrmMain
      // 
      this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
      this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
      this.ClientSize = new System.Drawing.Size(393, 243);
      this.Controls.Add(this.toolStripContainer1);
      this.Icon = ((System.Drawing.Icon)(resources.GetObject("$this.Icon")));
      this.MainMenuStrip = this.menuStrip1;
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
      this.statusStrip1.ResumeLayout(false);
      this.statusStrip1.PerformLayout();
      this.menuStrip1.ResumeLayout(false);
      this.menuStrip1.PerformLayout();
      this.toolStrip1.ResumeLayout(false);
      this.toolStrip1.PerformLayout();
      ((System.ComponentModel.ISupportInitialize)(this.bdsGroup)).EndInit();
      ((System.ComponentModel.ISupportInitialize)(this.emitScoreDataSet)).EndInit();
      ((System.ComponentModel.ISupportInitialize)(this._bdsConfig)).EndInit();
      this.ResumeLayout(false);

    }

    #endregion

    private AxEmitEpt.AxEptReading _emitReader;
    private System.Windows.Forms.ToolStripContainer toolStripContainer1;
    private System.Windows.Forms.MenuStrip menuStrip1;
    private System.Windows.Forms.ToolStripMenuItem fileToolStripMenuItem;
    private System.Windows.Forms.ToolStripMenuItem mniExit;
    private System.Windows.Forms.ToolStripMenuItem configureToolStripMenuItem;
    private System.Windows.Forms.ToolStripMenuItem mniLocations;
    private System.Windows.Forms.ToolStripSeparator toolStripSeparator1;
    private System.Windows.Forms.ToolStripMenuItem mniCategories;
    private System.Windows.Forms.ToolStripMenuItem mniGroups;
    private System.Windows.Forms.ToolStrip toolStrip1;
    private System.Windows.Forms.ToolStripMenuItem mniComPort;
    private System.Windows.Forms.ToolStripSeparator toolStripSeparator2;
    private System.Windows.Forms.StatusStrip statusStrip1;
    private System.Windows.Forms.ToolStripStatusLabel _sslRegister;
    private System.Windows.Forms.ToolStripMenuItem mniFileNew;
    private System.Windows.Forms.ToolStripMenuItem mniFileSave;
    private System.Windows.Forms.ToolStripSeparator toolStripSeparator3;
    private System.Windows.Forms.ToolStripButton tsbExit;
    private System.Windows.Forms.ToolStripSeparator toolStripSeparator4;
    private System.Windows.Forms.ToolStripButton _tsbGroups;
    private System.Windows.Forms.BindingSource bdsGroup;
    private Southesk.Apps.EmitScore.Data.EmitScoreDataSet emitScoreDataSet;
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
  }
}

