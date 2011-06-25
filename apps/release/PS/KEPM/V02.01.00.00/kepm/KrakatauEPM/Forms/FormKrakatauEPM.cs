/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 * Krakatau Essential PM (KEPM)
 * Copyright (c) 2008,2010 PowerSoftware.com
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  24-May-08    362 : File created (replicating frmMain).
 * CAM  29-May-08    363 : Completed toolbar buttons.
 * CAM  29-May-08    364 : Added Preferences event.
 * CAM  15-Feb-2010  10565 : Initialise KrakatauSettings with "InstallDir".
 * CAM  18-Feb-2010  10574 : Added MySQL Diagnostics methods.
 * CAM  19-Feb-2010  10558 : Added MetricSet chooser (filter) for Results Browser.
 * CAM  19-Feb-2010  10558 : Added RefreshController.
 * CAM  23-Feb-2010  10558 : Enable MetricSet chooser to be cleared.
 * CAM  27-Feb-2010  10583 : Add event to handle formatting.
 * CAM  27-Feb-2010  10582 : Set default directory for opening projects.
 * CAM  22-Jun-2011  10970 : Included UserGuide in Help menu.
 * CAM  25-Jun-2011  10968 : Ensure that when KEPM exits, any EPM processes are killed.
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

using System;
using System.Collections;
using System.Diagnostics;
using System.Windows.Forms;
using System.IO;

using SourceCodeMetrics.Krakatau.Kepm.Config;
using SourceCodeMetrics.Krakatau.Kepm.Controls;
using SourceCodeMetrics.Krakatau.Kepm.Projects;
using SourceCodeMetrics.Krakatau.Kepm.Win32;
using SourceCodeMetrics.Krakatau.Kepm.Results;

namespace SourceCodeMetrics.Krakatau.Kepm.Forms
{
  public partial class FormKrakatauEPM : Form
  {
    private RefreshController _refreshController;

    public FormKrakatauEPM()
    {
      InitializeComponent();

      KrakatauSettings.Create(Application.StartupPath);
      XmlConfig.Config.ParseFile();
      Prefs.Preferences.GetSettings(_lsvProjects);

      PopulateMetricSetsList(true);

      _refreshController = new RefreshController(_dgvResults);

      _lsvProjects.RefreshView += new RefreshViewRequested(_refreshController.RefreshView);
      _dgvResults.CellFormatting += new DataGridViewCellFormattingEventHandler(_refreshController.ResultsCellFormatting);
    }

    private void NewProject(object sender, EventArgs e)
    {
      NewProject wizard = new NewProject();

      if (wizard.ShowDialog(this) == DialogResult.OK)
      {
        ProjectItem pi = new ProjectItem(wizard.Project);
        pi.ImageIndex = 1;
        _lsvProjects.Items.Add(pi);
      }
    }

    private void OpenProject(object sender, EventArgs e)
    {
      _ofdProj.InitialDirectory = KrakatauSettings.Settings.DefaultDirectory;

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

    private void CloseProject(object sender, EventArgs e)
    {
      _lsvProjects.CloseProject();
    }

    private void AnalyzeProject(object sender, EventArgs e)
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

      FormAnalyze an = null;

      if (newProject != null && oldProject != null)
      {
        an = new FormAnalyze(newProject.Project, oldProject.Project);
      }
      else if (newProject != null)
      {
        an = new FormAnalyze(newProject.Project);
      }
      else
      {
        MessageBox.Show("Please set at least a New Project (by right-clicking on your " +
          "project and choosing 'Set as New')" + System.Environment.NewLine +
          "before attempting to Analyze." + System.Environment.NewLine + System.Environment.NewLine +
          "If you wish to compare two projects, also set an Old Project.",
          KrakatauEPM.AssemblyProduct + " Help", MessageBoxButtons.OK, MessageBoxIcon.Information);
      }

      if (an != null)
      {
        an.ShowDialog(this);
      }
    }

    private void ShowMetricSets(object sender, EventArgs e)
    {
      FormMetricSets metricSets = new FormMetricSets(XmlConfig.Config.MetricSets);
      metricSets.ShowDialog(this);

      PopulateMetricSetsList(metricSets.ItemsDeleted);
    }

    private void PopulateMetricSetsList(bool itemsDeleted)
    {
      if (itemsDeleted)
      {
        _cmbMetricSets.SelectedItem = -1;
        _cmbMetricSets.SelectedText = "";
      }
      _cmbMetricSets.Items.Clear();

      IEnumerator metricSets = XmlConfig.Config.MetricSets;
      while (metricSets.MoveNext()) _cmbMetricSets.Items.Add(metricSets.Current);
    }

    private void SetAsOldProject(object sender, EventArgs e)
    {
      _lsvProjects.SetAsOld();
    }

    private void SetAsNewProject(object sender, EventArgs e)
    {
      _lsvProjects.SetAsNew();
    }

    private void EditProject(object sender, EventArgs e)
    {
      ProjectItem pi = (ProjectItem)this._lsvProjects.FocusedItem;
      NewProject wizard = new NewProject(pi.Project);
      wizard.ShowDialog(this);
      pi.RefreshProject();
    }

    private void ExitKepm(object sender, EventArgs e)
    {
      Close();
    }

    private void ViewPdf(string fname)
    {
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

    private void ViewMetricsDefinitions(object sender, EventArgs e)
    {
      ViewPdf("MetricsDefinitions.pdf");
    }

    private void ViewUserGuide(object sender, EventArgs e)
    {
      ViewPdf("UserGuideKEPM.pdf");
    }

    private void HelpAbout(object sender, EventArgs e)
    {
      (new HelpAbout()).ShowDialog(this);
    }

    private void ShowProjectPreferences(object sender, EventArgs e)
    {
      (new FormPreferences()).ShowDialog(this);
      Prefs.Preferences.SaveSettings(_lsvProjects);
    }

    private void InstallMySqlService(object sender, EventArgs e)
    {
      MysqlWindowsService service = new MysqlWindowsService();

      string error = String.Empty;
      try
      {
        if (!service.InstallService()) error = "Could not install the service.  Please contact support@powersoftware.com.";
      }
      catch (Exception ex)
      {
        error = ex.Message;
      }

      if (error.Length > 0) ShowDiagnosticsDialog(error, "Installing MySQL Service");
    }

    private void RemoveMySqlService(object sender, EventArgs e)
    {
      MysqlWindowsService service = new MysqlWindowsService();

      string error = String.Empty;
      try
      {
        if (!service.RemoveService()) error = "Could not remove the service.  Check to see that it is still installed using Windows Services.";
      }
      catch (Exception ex)
      {
        error = ex.Message;
      }

      if (error.Length > 0) ShowDiagnosticsDialog(error, "Removing MySQL Service");
    }

    private void StartMySqlService(object sender, EventArgs e)
    {
      MysqlWindowsService service = new MysqlWindowsService();

      string error = String.Empty;
      try
      {
        if (!service.StartService()) error = "The service cannot be started.  Is it installed?\n\n" +
          "Try installing using Diagnotics > MySQL > Install Service.";
      }
      catch (Exception ex)
      {
        error = ex.Message;
      }

      if (error.Length > 0) ShowDiagnosticsDialog(error, "Starting MySQL Service");

    }

    private void StopMySqlService(object sender, EventArgs e)
    {
      MysqlWindowsService service = new MysqlWindowsService();

      string error = String.Empty;
      try
      {
        if (!service.StopService()) error = "Could not stop the service.  Try restarting your computer and then running Krakatau EPM again.";
      }
      catch (Exception ex)
      {
        error = ex.Message;
      }

      if (error.Length > 0) ShowDiagnosticsDialog(error, "Stopping MySQL Service");
    }

    private void ShowDiagnosticsDialog(string message, string title)
    {
      MessageBox.Show(message, String.Format("Error {0}", title), MessageBoxButtons.OK, MessageBoxIcon.Error);
    }

    private void MetricSetChanged(object sender, EventArgs e)
    {
      ToolStripComboBox combo = (ToolStripComboBox)sender;
      _refreshController.MetricSet = (MetricSet)combo.SelectedItem;
    }

    private void MetricSetTextChanged(object sender, EventArgs e)
    {
      if (_cmbMetricSets.Text.Length == 0)
      {
        _refreshController.MetricSet = null;
      }
    }

    private void CloseApplication(object sender, FormClosingEventArgs e)
    {
      foreach (Process p in Process.GetProcesses())
      {
        if (p.ProcessName.ToLower().Equals("epm"))
        {
          p.Kill();
          p.WaitForExit();
        }
      }
    }
  }
}
