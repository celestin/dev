/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 * Krakatau Essential PM (KEPM)
 * Copyright (c) 2008 Power Software
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * $Id$
 *
 * Who  When       Why
 * CAM  24-May-08   362 : File created (replicating frmMain).
 * CAM  29-May-08   364 : Added Preferences.
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

namespace KrakatauEPM
{
  partial class FormKrakatauEPM
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
        Prefs p = Prefs.Preferences;
        p.SaveSettings(_lsvProjects);
        XmlConfig.Config.SaveConfig();

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
      System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(FormKrakatauEPM));
      this.toolStripContainer1 = new System.Windows.Forms.ToolStripContainer();
      this._stsMain = new System.Windows.Forms.StatusStrip();
      this._lsvProjects = new KrakatauEPM.ProjectsView();
      this._imlProjects = new System.Windows.Forms.ImageList(this.components);
      this._mnsMain = new System.Windows.Forms.MenuStrip();
      this.mniFile = new System.Windows.Forms.ToolStripMenuItem();
      this.mniNewProject = new System.Windows.Forms.ToolStripMenuItem();
      this.mniOpenProject = new System.Windows.Forms.ToolStripMenuItem();
      this.mniCloseProject = new System.Windows.Forms.ToolStripMenuItem();
      this.toolStripSeparator3 = new System.Windows.Forms.ToolStripSeparator();
      this._mnuExit = new System.Windows.Forms.ToolStripMenuItem();
      this.mniProject = new System.Windows.Forms.ToolStripMenuItem();
      this.mniProjectPrefs = new System.Windows.Forms.ToolStripMenuItem();
      this.mniProjectAnalyse = new System.Windows.Forms.ToolStripMenuItem();
      this.mniMetrics = new System.Windows.Forms.ToolStripMenuItem();
      this.mniMetricsSets = new System.Windows.Forms.ToolStripMenuItem();
      this.mniHelp = new System.Windows.Forms.ToolStripMenuItem();
      this.mniMetricsDefs = new System.Windows.Forms.ToolStripMenuItem();
      this.mniHelpAbout = new System.Windows.Forms.ToolStripMenuItem();
      this._tspMain = new System.Windows.Forms.ToolStrip();
      this._tsbNewProject = new System.Windows.Forms.ToolStripButton();
      this._tsbOpenProject = new System.Windows.Forms.ToolStripButton();
      this._tsbCloseProject = new System.Windows.Forms.ToolStripButton();
      this.toolStripSeparator1 = new System.Windows.Forms.ToolStripSeparator();
      this._tsbMetricSets = new System.Windows.Forms.ToolStripButton();
      this.toolStripSeparator2 = new System.Windows.Forms.ToolStripSeparator();
      this._tsbSetAsOldProject = new System.Windows.Forms.ToolStripButton();
      this._tsbSetAsNewProject = new System.Windows.Forms.ToolStripButton();
      this._tsbAnalyseProject = new System.Windows.Forms.ToolStripButton();
      this._ofdProj = new System.Windows.Forms.OpenFileDialog();
      this.toolStripContainer1.BottomToolStripPanel.SuspendLayout();
      this.toolStripContainer1.ContentPanel.SuspendLayout();
      this.toolStripContainer1.TopToolStripPanel.SuspendLayout();
      this.toolStripContainer1.SuspendLayout();
      this._mnsMain.SuspendLayout();
      this._tspMain.SuspendLayout();
      this.SuspendLayout();
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
      this.toolStripContainer1.ContentPanel.Controls.Add(this._lsvProjects);
      this.toolStripContainer1.ContentPanel.Size = new System.Drawing.Size(558, 303);
      this.toolStripContainer1.Dock = System.Windows.Forms.DockStyle.Fill;
      this.toolStripContainer1.Location = new System.Drawing.Point(0, 0);
      this.toolStripContainer1.Name = "toolStripContainer1";
      this.toolStripContainer1.Size = new System.Drawing.Size(558, 388);
      this.toolStripContainer1.TabIndex = 0;
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
      this._stsMain.Location = new System.Drawing.Point(0, 0);
      this._stsMain.Name = "_stsMain";
      this._stsMain.Size = new System.Drawing.Size(558, 22);
      this._stsMain.TabIndex = 0;
      //
      // _lsvProjects
      //
      this._lsvProjects.Dock = System.Windows.Forms.DockStyle.Fill;
      this._lsvProjects.LargeImageList = this._imlProjects;
      this._lsvProjects.Location = new System.Drawing.Point(0, 0);
      this._lsvProjects.Name = "_lsvProjects";
      this._lsvProjects.Size = new System.Drawing.Size(558, 303);
      this._lsvProjects.TabIndex = 0;
      this._lsvProjects.UseCompatibleStateImageBehavior = false;
      this._lsvProjects.ItemActivate += new System.EventHandler(this._lsvProjects_ItemActivate);
      //
      // _imlProjects
      //
      this._imlProjects.ImageStream = ((System.Windows.Forms.ImageListStreamer)(resources.GetObject("_imlProjects.ImageStream")));
      this._imlProjects.TransparentColor = System.Drawing.Color.Transparent;
      this._imlProjects.Images.SetKeyName(0, "Project1");
      this._imlProjects.Images.SetKeyName(1, "Project2");
      this._imlProjects.Images.SetKeyName(2, "ProjectOld");
      this._imlProjects.Images.SetKeyName(3, "ProjectNew");
      //
      // _mnsMain
      //
      this._mnsMain.Dock = System.Windows.Forms.DockStyle.None;
      this._mnsMain.Items.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.mniFile,
            this.mniProject,
            this.mniMetrics,
            this.mniHelp});
      this._mnsMain.Location = new System.Drawing.Point(0, 0);
      this._mnsMain.Name = "_mnsMain";
      this._mnsMain.Size = new System.Drawing.Size(558, 24);
      this._mnsMain.TabIndex = 1;
      this._mnsMain.Text = "menuStrip1";
      //
      // mniFile
      //
      this.mniFile.DropDownItems.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.mniNewProject,
            this.mniOpenProject,
            this.mniCloseProject,
            this.toolStripSeparator3,
            this._mnuExit});
      this.mniFile.Name = "mniFile";
      this.mniFile.Size = new System.Drawing.Size(35, 20);
      this.mniFile.Text = "&File";
      //
      // mniNewProject
      //
      this.mniNewProject.Image = global::KrakatauEPM.Properties.Resources.NewProjectMenu;
      this.mniNewProject.Name = "mniNewProject";
      this.mniNewProject.Size = new System.Drawing.Size(148, 22);
      this.mniNewProject.Text = "&New Project";
      this.mniNewProject.Click += new System.EventHandler(this.mniNewProject_Click);
      //
      // mniOpenProject
      //
      this.mniOpenProject.Image = global::KrakatauEPM.Properties.Resources.OpenProjectMenu;
      this.mniOpenProject.Name = "mniOpenProject";
      this.mniOpenProject.Size = new System.Drawing.Size(148, 22);
      this.mniOpenProject.Text = "&Open Project";
      this.mniOpenProject.Click += new System.EventHandler(this.mniOpenProject_Click);
      //
      // mniCloseProject
      //
      this.mniCloseProject.Image = global::KrakatauEPM.Properties.Resources.CloseProjectMenu;
      this.mniCloseProject.Name = "mniCloseProject";
      this.mniCloseProject.Size = new System.Drawing.Size(148, 22);
      this.mniCloseProject.Text = "&Close Project";
      this.mniCloseProject.Click += new System.EventHandler(this.mniCloseProject_Click);
      //
      // toolStripSeparator3
      //
      this.toolStripSeparator3.Name = "toolStripSeparator3";
      this.toolStripSeparator3.Size = new System.Drawing.Size(145, 6);
      //
      // _mnuExit
      //
      this._mnuExit.Image = global::KrakatauEPM.Properties.Resources.exit;
      this._mnuExit.Name = "_mnuExit";
      this._mnuExit.Size = new System.Drawing.Size(148, 22);
      this._mnuExit.Text = "E&xit";
      this._mnuExit.Click += new System.EventHandler(this._mnuExit_Click);
      //
      // mniProject
      //
      this.mniProject.DropDownItems.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.mniProjectPrefs,
            this.mniProjectAnalyse});
      this.mniProject.Name = "mniProject";
      this.mniProject.Size = new System.Drawing.Size(53, 20);
      this.mniProject.Text = "&Project";
      //
      // mniProjectPrefs
      //
      this.mniProjectPrefs.Image = global::KrakatauEPM.Properties.Resources.ProjectPrefs;
      this.mniProjectPrefs.Name = "mniProjectPrefs";
      this.mniProjectPrefs.Size = new System.Drawing.Size(155, 22);
      this.mniProjectPrefs.Text = "&Preferences...";
      this.mniProjectPrefs.Click += new System.EventHandler(this.mniProjectPrefs_Click);
      //
      // mniProjectAnalyse
      //
      this.mniProjectAnalyse.Image = global::KrakatauEPM.Properties.Resources.AnalyseProjectMenu;
      this.mniProjectAnalyse.Name = "mniProjectAnalyse";
      this.mniProjectAnalyse.Size = new System.Drawing.Size(155, 22);
      this.mniProjectAnalyse.Text = "&Analyse";
      this.mniProjectAnalyse.Click += new System.EventHandler(this.mniProjectAnalyse_Click);
      //
      // mniMetrics
      //
      this.mniMetrics.DropDownItems.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.mniMetricsSets});
      this.mniMetrics.Name = "mniMetrics";
      this.mniMetrics.Size = new System.Drawing.Size(53, 20);
      this.mniMetrics.Text = "&Metrics";
      //
      // mniMetricsSets
      //
      this.mniMetricsSets.Image = global::KrakatauEPM.Properties.Resources.MetricSetMenu;
      this.mniMetricsSets.Name = "mniMetricsSets";
      this.mniMetricsSets.Size = new System.Drawing.Size(118, 22);
      this.mniMetricsSets.Text = "&Sets...";
      this.mniMetricsSets.Click += new System.EventHandler(this.mniMetricsSets_Click);
      //
      // mniHelp
      //
      this.mniHelp.DropDownItems.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.mniMetricsDefs,
            this.mniHelpAbout});
      this.mniHelp.Name = "mniHelp";
      this.mniHelp.Size = new System.Drawing.Size(40, 20);
      this.mniHelp.Text = "&Help";
      //
      // mniMetricsDefs
      //
      this.mniMetricsDefs.Name = "mniMetricsDefs";
      this.mniMetricsDefs.Size = new System.Drawing.Size(172, 22);
      this.mniMetricsDefs.Text = "&Metrics Definitions";
      this.mniMetricsDefs.Click += new System.EventHandler(this.mniMetricsDefs_Click);
      //
      // mniHelpAbout
      //
      this.mniHelpAbout.Image = global::KrakatauEPM.Properties.Resources.help;
      this.mniHelpAbout.Name = "mniHelpAbout";
      this.mniHelpAbout.Size = new System.Drawing.Size(172, 22);
      this.mniHelpAbout.Text = "&About";
      this.mniHelpAbout.Click += new System.EventHandler(this.mniHelpAbout_Click);
      //
      // _tspMain
      //
      this._tspMain.Dock = System.Windows.Forms.DockStyle.None;
      this._tspMain.Items.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this._tsbNewProject,
            this._tsbOpenProject,
            this._tsbCloseProject,
            this.toolStripSeparator1,
            this._tsbMetricSets,
            this.toolStripSeparator2,
            this._tsbSetAsOldProject,
            this._tsbSetAsNewProject,
            this._tsbAnalyseProject});
      this._tspMain.Location = new System.Drawing.Point(3, 24);
      this._tspMain.Name = "_tspMain";
      this._tspMain.Size = new System.Drawing.Size(276, 39);
      this._tspMain.TabIndex = 0;
      //
      // _tsbNewProject
      //
      this._tsbNewProject.DisplayStyle = System.Windows.Forms.ToolStripItemDisplayStyle.Image;
      this._tsbNewProject.Image = global::KrakatauEPM.Properties.Resources.NewProjectToolbar;
      this._tsbNewProject.ImageScaling = System.Windows.Forms.ToolStripItemImageScaling.None;
      this._tsbNewProject.ImageTransparentColor = System.Drawing.Color.Magenta;
      this._tsbNewProject.Name = "_tsbNewProject";
      this._tsbNewProject.Size = new System.Drawing.Size(36, 36);
      this._tsbNewProject.Text = "New Project";
      this._tsbNewProject.Click += new System.EventHandler(this._tsbNewProject_Click);
      //
      // _tsbOpenProject
      //
      this._tsbOpenProject.DisplayStyle = System.Windows.Forms.ToolStripItemDisplayStyle.Image;
      this._tsbOpenProject.Image = global::KrakatauEPM.Properties.Resources.OpenProjectToolbar;
      this._tsbOpenProject.ImageScaling = System.Windows.Forms.ToolStripItemImageScaling.None;
      this._tsbOpenProject.ImageTransparentColor = System.Drawing.Color.Magenta;
      this._tsbOpenProject.Name = "_tsbOpenProject";
      this._tsbOpenProject.Size = new System.Drawing.Size(36, 36);
      this._tsbOpenProject.Text = "Open Project";
      this._tsbOpenProject.Click += new System.EventHandler(this._tsbOpenProject_Click);
      //
      // _tsbCloseProject
      //
      this._tsbCloseProject.DisplayStyle = System.Windows.Forms.ToolStripItemDisplayStyle.Image;
      this._tsbCloseProject.Image = global::KrakatauEPM.Properties.Resources.CloseProjectToolbar;
      this._tsbCloseProject.ImageScaling = System.Windows.Forms.ToolStripItemImageScaling.None;
      this._tsbCloseProject.ImageTransparentColor = System.Drawing.Color.Magenta;
      this._tsbCloseProject.Name = "_tsbCloseProject";
      this._tsbCloseProject.Size = new System.Drawing.Size(36, 36);
      this._tsbCloseProject.Text = "Close Project";
      this._tsbCloseProject.Click += new System.EventHandler(this._tsbCloseProject_Click);
      //
      // toolStripSeparator1
      //
      this.toolStripSeparator1.Name = "toolStripSeparator1";
      this.toolStripSeparator1.Size = new System.Drawing.Size(6, 39);
      //
      // _tsbMetricSets
      //
      this._tsbMetricSets.DisplayStyle = System.Windows.Forms.ToolStripItemDisplayStyle.Image;
      this._tsbMetricSets.Image = global::KrakatauEPM.Properties.Resources.MetricSetToolbar;
      this._tsbMetricSets.ImageScaling = System.Windows.Forms.ToolStripItemImageScaling.None;
      this._tsbMetricSets.ImageTransparentColor = System.Drawing.Color.Magenta;
      this._tsbMetricSets.Name = "_tsbMetricSets";
      this._tsbMetricSets.Size = new System.Drawing.Size(36, 36);
      this._tsbMetricSets.Text = "Metrics Sets";
      this._tsbMetricSets.Click += new System.EventHandler(this._tsbMetricSets_Click);
      //
      // toolStripSeparator2
      //
      this.toolStripSeparator2.Name = "toolStripSeparator2";
      this.toolStripSeparator2.Size = new System.Drawing.Size(6, 39);
      //
      // _tsbSetAsOldProject
      //
      this._tsbSetAsOldProject.DisplayStyle = System.Windows.Forms.ToolStripItemDisplayStyle.Image;
      this._tsbSetAsOldProject.Image = global::KrakatauEPM.Properties.Resources.SetOldProjectToolbar;
      this._tsbSetAsOldProject.ImageScaling = System.Windows.Forms.ToolStripItemImageScaling.None;
      this._tsbSetAsOldProject.ImageTransparentColor = System.Drawing.Color.Magenta;
      this._tsbSetAsOldProject.Name = "_tsbSetAsOldProject";
      this._tsbSetAsOldProject.Size = new System.Drawing.Size(36, 36);
      this._tsbSetAsOldProject.Text = "Set as Old Project";
      this._tsbSetAsOldProject.Click += new System.EventHandler(this._tsbSetAsOldProject_Click);
      //
      // _tsbSetAsNewProject
      //
      this._tsbSetAsNewProject.DisplayStyle = System.Windows.Forms.ToolStripItemDisplayStyle.Image;
      this._tsbSetAsNewProject.Image = global::KrakatauEPM.Properties.Resources.SetNewProjectToolbar;
      this._tsbSetAsNewProject.ImageScaling = System.Windows.Forms.ToolStripItemImageScaling.None;
      this._tsbSetAsNewProject.ImageTransparentColor = System.Drawing.Color.Magenta;
      this._tsbSetAsNewProject.Name = "_tsbSetAsNewProject";
      this._tsbSetAsNewProject.Size = new System.Drawing.Size(36, 36);
      this._tsbSetAsNewProject.Text = "Set as New Project";
      this._tsbSetAsNewProject.Click += new System.EventHandler(this._tsbSetAsNewProject_Click);
      //
      // _tsbAnalyseProject
      //
      this._tsbAnalyseProject.DisplayStyle = System.Windows.Forms.ToolStripItemDisplayStyle.Image;
      this._tsbAnalyseProject.Image = global::KrakatauEPM.Properties.Resources.AnalyseProjectToolbar;
      this._tsbAnalyseProject.ImageScaling = System.Windows.Forms.ToolStripItemImageScaling.None;
      this._tsbAnalyseProject.ImageTransparentColor = System.Drawing.Color.Magenta;
      this._tsbAnalyseProject.Name = "_tsbAnalyseProject";
      this._tsbAnalyseProject.Size = new System.Drawing.Size(36, 36);
      this._tsbAnalyseProject.Text = "Analyse Project(s)";
      this._tsbAnalyseProject.Click += new System.EventHandler(this._tsbAnalyseProject_Click);
      //
      // _ofdProj
      //
      this._ofdProj.FileName = "openFileDialog1";
      //
      // FormKrakatauEPM
      //
      this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
      this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
      this.ClientSize = new System.Drawing.Size(558, 388);
      this.Controls.Add(this.toolStripContainer1);
      this.Icon = ((System.Drawing.Icon)(resources.GetObject("$this.Icon")));
      this.MainMenuStrip = this._mnsMain;
      this.Name = "FormKrakatauEPM";
      this.Text = "Krakatau EPM";
      this.toolStripContainer1.BottomToolStripPanel.ResumeLayout(false);
      this.toolStripContainer1.BottomToolStripPanel.PerformLayout();
      this.toolStripContainer1.ContentPanel.ResumeLayout(false);
      this.toolStripContainer1.TopToolStripPanel.ResumeLayout(false);
      this.toolStripContainer1.TopToolStripPanel.PerformLayout();
      this.toolStripContainer1.ResumeLayout(false);
      this.toolStripContainer1.PerformLayout();
      this._mnsMain.ResumeLayout(false);
      this._mnsMain.PerformLayout();
      this._tspMain.ResumeLayout(false);
      this._tspMain.PerformLayout();
      this.ResumeLayout(false);

    }

    #endregion

    private System.Windows.Forms.ToolStripContainer toolStripContainer1;
    private System.Windows.Forms.StatusStrip _stsMain;
    private System.Windows.Forms.MenuStrip _mnsMain;
    private System.Windows.Forms.ToolStripMenuItem mniFile;
    private System.Windows.Forms.ToolStripMenuItem _mnuExit;
    private System.Windows.Forms.ToolStrip _tspMain;
    private System.Windows.Forms.ToolStripButton _tsbNewProject;
    private System.Windows.Forms.ToolStripButton _tsbOpenProject;
    private System.Windows.Forms.ToolStripButton _tsbCloseProject;
    private System.Windows.Forms.ToolStripSeparator toolStripSeparator1;
    private System.Windows.Forms.ToolStripButton _tsbMetricSets;
    private System.Windows.Forms.ToolStripSeparator toolStripSeparator2;
    private System.Windows.Forms.ToolStripButton _tsbSetAsOldProject;
    private System.Windows.Forms.ToolStripButton _tsbSetAsNewProject;
    private System.Windows.Forms.ToolStripButton _tsbAnalyseProject;
    private System.Windows.Forms.ImageList _imlProjects;
    private ProjectsView _lsvProjects;
    private System.Windows.Forms.OpenFileDialog _ofdProj;
    private System.Windows.Forms.ToolStripMenuItem mniNewProject;
    private System.Windows.Forms.ToolStripMenuItem mniOpenProject;
    private System.Windows.Forms.ToolStripMenuItem mniCloseProject;
    private System.Windows.Forms.ToolStripSeparator toolStripSeparator3;
    private System.Windows.Forms.ToolStripMenuItem mniProject;
    private System.Windows.Forms.ToolStripMenuItem mniProjectAnalyse;
    private System.Windows.Forms.ToolStripMenuItem mniMetrics;
    private System.Windows.Forms.ToolStripMenuItem mniMetricsSets;
    private System.Windows.Forms.ToolStripMenuItem mniHelp;
    private System.Windows.Forms.ToolStripMenuItem mniMetricsDefs;
    private System.Windows.Forms.ToolStripMenuItem mniHelpAbout;
    private System.Windows.Forms.ToolStripMenuItem mniProjectPrefs;
  }
}

