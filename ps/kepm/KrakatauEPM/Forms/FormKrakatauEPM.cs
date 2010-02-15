/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 * Krakatau Essential PM (KEPM)
 * Copyright (c) 2008,2010 PowerSoftware.com
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * $Id$
 *
 * Who  When       Why
 * CAM  24-May-08   362 : File created (replicating frmMain).
 * CAM  29-May-08   363 : Completed toolbar buttons.
 * CAM  29-May-08   364 : Added Preferences event.
 * CAM  15-Feb-2010  10565 : Initialise KrakatauSettings with "InstallDir".
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

using System;
using System.Windows.Forms;
using System.IO;

using SourceCodeMetrics.Krakatau.Kepm.Config;
using SourceCodeMetrics.Krakatau.Kepm.Controls;
using SourceCodeMetrics.Krakatau.Kepm.Projects;
using SourceCodeMetrics.Krakatau.Kepm.Win32;

namespace SourceCodeMetrics.Krakatau.Kepm.Forms
{
  public partial class FormKrakatauEPM : Form
  {
    public FormKrakatauEPM()
    {
      InitializeComponent();

      KrakatauSettings.Create(Application.StartupPath);
      XmlConfig.Config.ParseFile();
      Prefs.Preferences.GetSettings(_lsvProjects);
    }

    private void FileNew()
    {
      NewProject wizard = new NewProject();

      if (wizard.ShowDialog(this) == DialogResult.OK)
      {
        ProjectItem pi = new ProjectItem(wizard.Project);
        pi.ImageIndex = 1;
        _lsvProjects.Items.Add(pi);
      }
    }

    private void FileOpen()
    {
      if (_ofdProj.ShowDialog(this) == DialogResult.OK)
      {
        Project proj = new Project(_ofdProj.FileName);
        if (proj.ReadFile())
        {
          ProjectItem pi = new ProjectItem(proj);
          _lsvProjects.Items.Add(pi);
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

      for (int i = 0; i < _lsvProjects.Items.Count; i++)
      {
        if (_lsvProjects.Items[i].ImageIndex == 3)
        {
          newProject = (ProjectItem)_lsvProjects.Items[i];
        }
        if (_lsvProjects.Items[i].ImageIndex == 2)
        {
          oldProject = (ProjectItem)_lsvProjects.Items[i];
        }
      }

      FormAnalyse an = null;

      if (newProject != null && oldProject != null)
      {
        an = new FormAnalyse(newProject.Project, oldProject.Project);
      }
      else if (newProject != null)
      {
        an = new FormAnalyse(newProject.Project);
      }
      else
      {
        MessageBox.Show("Please set at least a New Project (by right-clicking on your " +
          "project and choosing 'Set as New')" + System.Environment.NewLine +
          "before attempting to Analyse." + System.Environment.NewLine + System.Environment.NewLine +
          "If you wish to compare two projects, also set an Old Project.",
          KrakatauEPM.AssemblyProduct + " Help", MessageBoxButtons.OK, MessageBoxIcon.Information);
      }

      if (an != null)
      {
        an.ShowDialog(this);
      }
    }

    private void _tsbNewProject_Click(object sender, EventArgs e)
    {
      FileNew();
    }

    private void _tsbOpenProject_Click(object sender, EventArgs e)
    {
      FileOpen();
    }

    private void _tsbCloseProject_Click(object sender, EventArgs e)
    {
      _lsvProjects.CloseProject();
    }

    private void _tsbMetricSets_Click(object sender, EventArgs e)
    {
      (new FormMetricSets(XmlConfig.Config.GetMetricSets())).ShowDialog(this);
    }

    private void _tsbSetAsOldProject_Click(object sender, EventArgs e)
    {
      _lsvProjects.SetAsOld();
    }

    private void _tsbSetAsNewProject_Click(object sender, EventArgs e)
    {
      _lsvProjects.SetAsNew();
    }

    private void _tsbAnalyseProject_Click(object sender, EventArgs e)
    {
      this.AnalyseSelected();
    }

    private void _lsvProjects_ItemActivate(object sender, EventArgs e)
    {
      ProjectItem pi = (ProjectItem)this._lsvProjects.FocusedItem;
      NewProject wizard = new NewProject(pi.Project);
      wizard.ShowDialog(this);
      pi.RefreshProject();
    }

    private void mniNewProject_Click(object sender, EventArgs e)
    {
      FileNew();
    }

    private void mniOpenProject_Click(object sender, EventArgs e)
    {
      FileOpen();
    }

    private void mniCloseProject_Click(object sender, EventArgs e)
    {
      _lsvProjects.CloseProject();
    }

    private void _mnuExit_Click(object sender, EventArgs e)
    {
      this.Dispose();
    }

    private void mniProjectAnalyse_Click(object sender, EventArgs e)
    {
      AnalyseSelected();
    }

    private void mniMetricsSets_Click(object sender, EventArgs e)
    {
      FormMetricSets sets = new FormMetricSets(XmlConfig.Config.GetMetricSets());
      sets.ShowDialog(this);
    }

    private void mniMetricsDefs_Click(object sender, EventArgs e)
    {
      string fname = "MetricsDefinitions.pdf";
      FileInfo pdf = new FileInfo(fname);
      if (!pdf.Exists)
      {
        MessageBox.Show(String.Format("Could not find the file {0} that is supplied with " +
          KrakatauEPM.AssemblyProduct + " - please reinstall the application.", fname),
          String.Format("{0} missing!", fname), MessageBoxButtons.OK, MessageBoxIcon.Error);
        return;
      }

      System.Diagnostics.Process.Start(fname);
    }

    private void mniHelpAbout_Click(object sender, EventArgs e)
    {
      (new HelpAbout()).ShowDialog(this);
    }

    private void mniProjectPrefs_Click(object sender, EventArgs e)
    {
      (new FormPreferences()).ShowDialog(this);
      Prefs.Preferences.SaveSettings(_lsvProjects);
    }
  }
}
