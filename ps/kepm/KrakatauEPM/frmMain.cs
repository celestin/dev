/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 * Krakatau Essential PM (KEPM)
 * Copyright 2005-2006 Frontburner.co.uk
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * Main KEPM Application
 *
 * $Log: /kepm/KrakatauEPM.root/KrakatauEPM/KrakatauEPM/frmMain.cs $
 * 
 * 7     8/04/06 17:13 Craig
 * 230
 * 
 * 6     13/02/06 23:59 Craig
 * 185
 * 
 * 5     24/01/06 23:39 Craig
 * 179
 * 
 * 4     20/12/05 21:48 Craig
 * 170
 * 
 * 3     30/11/05 0:33 Craig
 * 160
 * 
 * 2     11/10/05 23:17 Craig
 * 152
 * 
 * Who  When       Why
 * CAM  11-Oct-05   152 : Added to Source Safe.
 * CAM  28-Nov-05   134 : Moved Project Old/New code to ProjectsView.
 * CAM  20-Dec-05   170 : Added Remove Project to the right-click menu.
 * CAM  24-Jan-06   179 : Added Help when the user clicks Analyse without having defined New/Old.
 * CAM  09-Feb-06   185 : Save/Restore open Projects to Windows Registry.
 * CAM  08-Apr-06   230 : Added Status Bar.
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

using System;
using System.IO;
using System.Drawing;
using System.Collections;
using System.ComponentModel;
using System.Windows.Forms;
using System.Data;
using System.Diagnostics;

namespace KrakatauEPM
{
  /// <summary>
  /// Krakatau EPM Application
  /// </summary>
  public class EpmApp : System.Windows.Forms.Form
  {
    private System.Windows.Forms.MainMenu mnuApp;
    private System.Windows.Forms.MenuItem mnuFile;
    private System.Windows.Forms.MenuItem mnuHelp;
    private System.Windows.Forms.MenuItem mnuProject;
    private System.Windows.Forms.MenuItem mnuAbout;
    private System.Windows.Forms.MenuItem mnuExit;
    private System.Windows.Forms.MenuItem mnuAnalyse;
    private System.Windows.Forms.ToolBar tbrMenu;
    private System.Windows.Forms.ToolBarButton tlbNew;
    private System.Windows.Forms.ToolBarButton tlbOpen;
    private System.Windows.Forms.ToolBarButton tlbDel;
    private System.Windows.Forms.ToolBarButton tlbSep1;
    private System.Windows.Forms.ToolBarButton tlbOldProj;
    private System.Windows.Forms.ToolBarButton tlbNewProj;
    private System.Windows.Forms.ToolBarButton tlbAnalyse;
    private System.Windows.Forms.ImageList imlToolbar;
    private System.Windows.Forms.ImageList imlProj;
    private System.ComponentModel.IContainer components;
    private System.Windows.Forms.OpenFileDialog ofdProj;
    private System.Windows.Forms.MenuItem mnuNew;
    private System.Windows.Forms.MenuItem menuItem2;
    private System.Windows.Forms.MenuItem mnuOpen;
    private System.Windows.Forms.MenuItem mnuClose;
    private XMLConfig _xmlConfig;
    private System.Windows.Forms.StatusBar stbMain;
    private System.Windows.Forms.StatusBarPanel sbpMessage;
    private System.Windows.Forms.StatusBarPanel sbpAnalysisType;
    ProjectsView lsvProjects;

    public EpmApp()
    {
      InitializeComponent();
      _xmlConfig = new XMLConfig();
      _xmlConfig.ParseFile();

      Prefs p = Prefs.Preferences;
      p.GetSettings(lsvProjects);
    }

    /// <summary>
    /// Clean up any resources being used.
    /// </summary>
    protected override void Dispose( bool disposing )
    {
      if( disposing )
      {
        Prefs p = Prefs.Preferences;
        p.SaveSettings(lsvProjects);

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
      this.components = new System.ComponentModel.Container();
      System.Resources.ResourceManager resources = new System.Resources.ResourceManager(typeof(EpmApp));
      this.mnuApp = new System.Windows.Forms.MainMenu();
      this.mnuFile = new System.Windows.Forms.MenuItem();
      this.mnuNew = new System.Windows.Forms.MenuItem();
      this.mnuOpen = new System.Windows.Forms.MenuItem();
      this.mnuClose = new System.Windows.Forms.MenuItem();
      this.menuItem2 = new System.Windows.Forms.MenuItem();
      this.mnuExit = new System.Windows.Forms.MenuItem();
      this.mnuProject = new System.Windows.Forms.MenuItem();
      this.mnuAnalyse = new System.Windows.Forms.MenuItem();
      this.mnuHelp = new System.Windows.Forms.MenuItem();
      this.mnuAbout = new System.Windows.Forms.MenuItem();
      this.lsvProjects = new KrakatauEPM.ProjectsView();
      this.imlProj = new System.Windows.Forms.ImageList(this.components);
      this.tbrMenu = new System.Windows.Forms.ToolBar();
      this.tlbNew = new System.Windows.Forms.ToolBarButton();
      this.tlbOpen = new System.Windows.Forms.ToolBarButton();
      this.tlbDel = new System.Windows.Forms.ToolBarButton();
      this.tlbSep1 = new System.Windows.Forms.ToolBarButton();
      this.tlbOldProj = new System.Windows.Forms.ToolBarButton();
      this.tlbNewProj = new System.Windows.Forms.ToolBarButton();
      this.tlbAnalyse = new System.Windows.Forms.ToolBarButton();
      this.imlToolbar = new System.Windows.Forms.ImageList(this.components);
      this.ofdProj = new System.Windows.Forms.OpenFileDialog();
      this.stbMain = new System.Windows.Forms.StatusBar();
      this.sbpMessage = new System.Windows.Forms.StatusBarPanel();
      this.sbpAnalysisType = new System.Windows.Forms.StatusBarPanel();
      ((System.ComponentModel.ISupportInitialize)(this.sbpMessage)).BeginInit();
      ((System.ComponentModel.ISupportInitialize)(this.sbpAnalysisType)).BeginInit();
      this.SuspendLayout();
      // 
      // mnuApp
      // 
      this.mnuApp.MenuItems.AddRange(new System.Windows.Forms.MenuItem[] {
                                                                           this.mnuFile,
                                                                           this.mnuProject,
                                                                           this.mnuHelp});
      // 
      // mnuFile
      // 
      this.mnuFile.Index = 0;
      this.mnuFile.MenuItems.AddRange(new System.Windows.Forms.MenuItem[] {
                                                                            this.mnuNew,
                                                                            this.mnuOpen,
                                                                            this.mnuClose,
                                                                            this.menuItem2,
                                                                            this.mnuExit});
      this.mnuFile.Text = "&File";
      // 
      // mnuNew
      // 
      this.mnuNew.Index = 0;
      this.mnuNew.Text = "&New Project";
      this.mnuNew.Click += new System.EventHandler(this.mnuNew_Click);
      // 
      // mnuOpen
      // 
      this.mnuOpen.Index = 1;
      this.mnuOpen.Text = "&Open Project";
      this.mnuOpen.Click += new System.EventHandler(this.mnuOpen_Click);
      // 
      // mnuClose
      // 
      this.mnuClose.Index = 2;
      this.mnuClose.Text = "&Close Project";
      this.mnuClose.Click += new System.EventHandler(this.mnuClose_Click);
      // 
      // menuItem2
      // 
      this.menuItem2.Index = 3;
      this.menuItem2.Text = "-";
      // 
      // mnuExit
      // 
      this.mnuExit.Index = 4;
      this.mnuExit.Text = "E&xit";
      this.mnuExit.Click += new System.EventHandler(this.mnuExit_Click);
      // 
      // mnuProject
      // 
      this.mnuProject.Index = 1;
      this.mnuProject.MenuItems.AddRange(new System.Windows.Forms.MenuItem[] {
                                                                               this.mnuAnalyse});
      this.mnuProject.Text = "&Project";
      // 
      // mnuAnalyse
      // 
      this.mnuAnalyse.Index = 0;
      this.mnuAnalyse.Text = "&Analyse";
      this.mnuAnalyse.Click += new System.EventHandler(this.mnuAnalyse_Click);
      // 
      // mnuHelp
      // 
      this.mnuHelp.Index = 2;
      this.mnuHelp.MenuItems.AddRange(new System.Windows.Forms.MenuItem[] {
                                                                            this.mnuAbout});
      this.mnuHelp.Text = "&Help";
      // 
      // mnuAbout
      // 
      this.mnuAbout.Index = 0;
      this.mnuAbout.Text = "&About";
      this.mnuAbout.Click += new System.EventHandler(this.mnuAbout_Click);
      // 
      // lsvProjects
      // 
      this.lsvProjects.Font = new System.Drawing.Font("Tahoma", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((System.Byte)(0)));
      this.lsvProjects.LargeImageList = this.imlProj;
      this.lsvProjects.Location = new System.Drawing.Point(8, 56);
      this.lsvProjects.Name = "lsvProjects";
      this.lsvProjects.Size = new System.Drawing.Size(576, 235);
      this.lsvProjects.TabIndex = 1;
      this.lsvProjects.ItemActivate += new System.EventHandler(this.lsvProjects_ItemActivate);
      // 
      // imlProj
      // 
      this.imlProj.ImageSize = new System.Drawing.Size(48, 48);
      this.imlProj.ImageStream = ((System.Windows.Forms.ImageListStreamer)(resources.GetObject("imlProj.ImageStream")));
      this.imlProj.TransparentColor = System.Drawing.Color.Transparent;
      // 
      // tbrMenu
      // 
      this.tbrMenu.Buttons.AddRange(new System.Windows.Forms.ToolBarButton[] {
                                                                               this.tlbNew,
                                                                               this.tlbOpen,
                                                                               this.tlbDel,
                                                                               this.tlbSep1,
                                                                               this.tlbOldProj,
                                                                               this.tlbNewProj,
                                                                               this.tlbAnalyse});
      this.tbrMenu.ButtonSize = new System.Drawing.Size(32, 32);
      this.tbrMenu.DropDownArrows = true;
      this.tbrMenu.ImageList = this.imlToolbar;
      this.tbrMenu.Location = new System.Drawing.Point(0, 0);
      this.tbrMenu.Name = "tbrMenu";
      this.tbrMenu.ShowToolTips = true;
      this.tbrMenu.Size = new System.Drawing.Size(592, 44);
      this.tbrMenu.TabIndex = 2;
      this.tbrMenu.ButtonClick += new System.Windows.Forms.ToolBarButtonClickEventHandler(this.tbrMenu_ButtonClick);
      // 
      // tlbNew
      // 
      this.tlbNew.ImageIndex = 0;
      this.tlbNew.ToolTipText = "New Project Wizard";
      // 
      // tlbOpen
      // 
      this.tlbOpen.ImageIndex = 1;
      this.tlbOpen.ToolTipText = "Open Project";
      // 
      // tlbDel
      // 
      this.tlbDel.ImageIndex = 2;
      this.tlbDel.ToolTipText = "Remove Project";
      // 
      // tlbSep1
      // 
      this.tlbSep1.Style = System.Windows.Forms.ToolBarButtonStyle.Separator;
      // 
      // tlbOldProj
      // 
      this.tlbOldProj.ImageIndex = 3;
      this.tlbOldProj.ToolTipText = "Set Old Project";
      // 
      // tlbNewProj
      // 
      this.tlbNewProj.ImageIndex = 4;
      this.tlbNewProj.ToolTipText = "Set New Project";
      // 
      // tlbAnalyse
      // 
      this.tlbAnalyse.ImageIndex = 5;
      this.tlbAnalyse.ToolTipText = "Analyse";
      // 
      // imlToolbar
      // 
      this.imlToolbar.ImageSize = new System.Drawing.Size(32, 32);
      this.imlToolbar.ImageStream = ((System.Windows.Forms.ImageListStreamer)(resources.GetObject("imlToolbar.ImageStream")));
      this.imlToolbar.TransparentColor = System.Drawing.Color.Transparent;
      // 
      // ofdProj
      // 
      this.ofdProj.DefaultExt = "txt";
      this.ofdProj.Filter = "KEPM Projects|*.txt";
      this.ofdProj.InitialDirectory = "\\";
      this.ofdProj.Title = "Open an existing KEPM Project file";
      // 
      // stbMain
      // 
      this.stbMain.Location = new System.Drawing.Point(0, 301);
      this.stbMain.Name = "stbMain";
      this.stbMain.Panels.AddRange(new System.Windows.Forms.StatusBarPanel[] {
                                                                               this.sbpMessage,
                                                                               this.sbpAnalysisType});
      this.stbMain.ShowPanels = true;
      this.stbMain.Size = new System.Drawing.Size(592, 22);
      this.stbMain.TabIndex = 3;
      this.stbMain.Text = "Ready";
      // 
      // sbpMessage
      // 
      this.sbpMessage.AutoSize = System.Windows.Forms.StatusBarPanelAutoSize.Spring;
      this.sbpMessage.Text = "Ready";
      this.sbpMessage.Width = 426;
      // 
      // sbpAnalysisType
      // 
      this.sbpAnalysisType.Width = 150;
      // 
      // EpmApp
      // 
      this.AutoScaleBaseSize = new System.Drawing.Size(5, 13);
      this.ClientSize = new System.Drawing.Size(592, 323);
      this.Controls.Add(this.stbMain);
      this.Controls.Add(this.tbrMenu);
      this.Controls.Add(this.lsvProjects);
      this.Icon = ((System.Drawing.Icon)(resources.GetObject("$this.Icon")));
      this.MaximumSize = new System.Drawing.Size(600, 350);
      this.Menu = this.mnuApp;
      this.MinimumSize = new System.Drawing.Size(600, 350);
      this.Name = "EpmApp";
      this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
      this.Text = "Krakatau EPM";
      this.Load += new System.EventHandler(this.EpmApp_Load);
      ((System.ComponentModel.ISupportInitialize)(this.sbpMessage)).EndInit();
      ((System.ComponentModel.ISupportInitialize)(this.sbpAnalysisType)).EndInit();
      this.ResumeLayout(false);

    }
    #endregion

    /// <summary>
    /// The main entry point for the application.
    /// </summary>
    [STAThread]
    static void Main() 
    {
      Process p = new Process();
      p.StartInfo.RedirectStandardOutput = false;
      p.StartInfo.WindowStyle = ProcessWindowStyle.Hidden;
      p.StartInfo.UseShellExecute = true;
      p.StartInfo.FileName = Prefs.Preferences.InstallDir +  "lic.exe";
      p.Start();
      p.WaitForExit();
      
      EpmApp app = new EpmApp();

      if ((p.ExitCode & 128)==128)
      {
        Application.Run(app);
      }
      else 
      {
        MessageBox.Show(app, "You are not licensed to use Krakatau EPM.\n\n" +
                        "Please contact laurence.arthur@powersoftware.com for a new license.",
          "Unlicensed Krakatau EPM", 
          MessageBoxButtons.OK, MessageBoxIcon.Stop);
      }
    }

    private void EpmApp_Load(object sender, System.EventArgs e)
    {
    }

    private void FileNew() 
    {
      NewProject wizard = new NewProject(this._xmlConfig);
        
      if (wizard.ShowDialog(this) == DialogResult.OK) 
      {
        ProjectItem pi = new ProjectItem(wizard.Project);
        pi.ImageIndex = 1;
        lsvProjects.Items.Add(pi);        
      }
    }

    private void FileOpen()
    {
      if (ofdProj.ShowDialog(this) == DialogResult.OK)
      {
        Project proj = new Project(ofdProj.FileName);
        if (proj.ReadFile()) 
        {
          ProjectItem pi = new ProjectItem(proj);
          lsvProjects.Items.Add(pi);
        } 
        else 
        {
          MessageBox.Show(this, "The Project File you have selected is invalid;\n\n" + 
            "The contents do not conform to the format described in the User Guide.", 
            "Invalid Project File", MessageBoxButtons.OK, MessageBoxIcon.Asterisk);
        }
      }    
    }

    private void AnalyseSelected() 
    {
      ProjectItem newProject = null;
      ProjectItem oldProject = null;

      for(int i=0; i<lsvProjects.Items.Count; i++) 
      {
        if (lsvProjects.Items[i].ImageIndex==3) 
        {
          newProject = (ProjectItem) lsvProjects.Items[i];
        }
        if (lsvProjects.Items[i].ImageIndex==2) 
        {
          oldProject = (ProjectItem) lsvProjects.Items[i];
        }
      }

      Analyse an = null;

      if (newProject != null && oldProject != null) 
      {
        an = new Analyse(newProject.Project, oldProject.Project);
      } 
      else if (newProject != null) 
      {
        an = new Analyse(newProject.Project);
      }
      else 
      {
        MessageBox.Show("Please set at least a New Project (by right-clicking on your " +
          "project and choosing 'Set as New')" + System.Environment.NewLine +
          "before attempting to Analyse." + System.Environment.NewLine + System.Environment.NewLine +
          "If you wish to compare two projects, also set an Old Project.", 
          "Krakatau EPM Help", MessageBoxButtons.OK, MessageBoxIcon.Information);
      }

      if (an != null) 
      {
        an.ShowDialog(this);
      }
    }

    private void mnuNew_Click(object sender, System.EventArgs e)
    {
      FileNew();
    }

    private void mnuOpen_Click(object sender, System.EventArgs e)
    {
      FileOpen();
    }

    private void mnuClose_Click(object sender, System.EventArgs e)
    {
      lsvProjects.closeProject(); 
    }

    private void mnuAbout_Click(object sender, System.EventArgs e)
    {
      HelpAbout about = new HelpAbout();
      about.ShowDialog(this);
    }

    private void mnuExit_Click(object sender, System.EventArgs e)
    {
      this.Dispose();
    }

    private void mnuAnalyse_Click(object sender, System.EventArgs e)
    {
      this.AnalyseSelected();
    }

    private void tbrMenu_ButtonClick(object sender, System.Windows.Forms.ToolBarButtonClickEventArgs e)
    {      
      if (e.Button == tlbNew) 
      {
        FileNew();
      } 
      else if (e.Button == this.tlbOpen) 
      {
        FileOpen();
      } 
      else if (e.Button == tlbDel) 
      {
        lsvProjects.closeProject();
      } 
      else if (e.Button == tlbOldProj)
      {
        lsvProjects.setAsOld();
      } 
      else if (e.Button == tlbNewProj)
      {
        lsvProjects.setAsNew();
      } 
      else if (e.Button == this.tlbAnalyse) 
      {
        AnalyseSelected();
      }
    }

    private void lsvProjects_ItemActivate(object sender, System.EventArgs e)
    {      
      ProjectItem pi = (ProjectItem) this.lsvProjects.FocusedItem;
      NewProject wizard = new NewProject(this._xmlConfig, pi.Project);
      wizard.ShowDialog(this);
      pi.RefreshProject();
    }
  }
}
