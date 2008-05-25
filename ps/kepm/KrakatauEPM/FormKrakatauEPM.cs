/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 * Krakatau Essential PM (KEPM)
 * Copyright (c) 2008 Power Software
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * $Id$
 *
 * Who  When       Why
 * CAM  24-May-08   362 : File created (replicating frmMain).
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;
using System.IO;

namespace KrakatauEPM
{
  public partial class FormKrakatauEPM : Form
  {
    public FormKrakatauEPM()
    {
      InitializeComponent();
      XmlConfig.Config.ParseFile();

      Prefs p = Prefs.Preferences;
      p.GetSettings(_lsvProjects);
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

    }

    private void _tsbMetricSets_Click(object sender, EventArgs e)
    {
      (new FormMetricSets(XmlConfig.Config.GetMetricSets())).ShowDialog(this);
    }

    private void _tsbSetAsOldProject_Click(object sender, EventArgs e)
    {

    }

    private void _tsbSetAsNewProject_Click(object sender, EventArgs e)
    {

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
      _lsvProjects.closeProject();
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
          "Krakatau EPM - please reinstall the application.", fname),
          String.Format("{0} missing!", fname), MessageBoxButtons.OK, MessageBoxIcon.Error);
        return;
      }

      System.Diagnostics.Process.Start(fname);
    }

    private void mniHelpAbout_Click(object sender, EventArgs e)
    {
      (new HelpAbout()).ShowDialog(this);
    }

  }
}
