/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 * Krakatau Essential PM (KEPM)
 * Copyright (c) 2004,2009 PowerSoftware.com
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  11-Oct-05    152 : Added to Source Safe.
 * CAM  24-Jan-06    179 : Project Title limited to 30 chars, Project Filename box readonly.
 * CAM  08-Jun-06    243 : Remember selected file types.
 * CAM  11-Dec-07    327 : Reference Project.MaxProjectDbName.
 * CAM  22-Aug-2009  10461 : Added Check/Uncheck All box.
 * CAM  17-Nov-2009  10502 : Modified to support new Project Options (.kepm) file.
 * CAM  27-Feb-2010  10582 : Set default directory for saving projects.
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

using System;
using System.IO;
using System.Drawing;
using System.Collections;
using System.ComponentModel;
using System.Windows.Forms;
using System.Threading;

using PowerSoftware.Krakatau.Kepm.Config;
using PowerSoftware.Krakatau.Kepm.Projects;

namespace PowerSoftware.Krakatau.Kepm.Forms
{
  /// <summary>
  /// New Project Wizard Form.  Takes the user through the steps required to
  /// define a new project.
  /// </summary>
  public partial class NewProject : System.Windows.Forms.Form
  {
    private Thread _buildProjectFileThread;

    public Project Project
    {
      get
      {
        return _project;
      }
    }

    public NewProject(): this(new Project())
    {
    }

    public NewProject(Project p)
    {
      InitializeComponent();

      this.txtTitle.MaxLength = Project.MaxProjectDbName;
      this.label6.Text = String.Format("({0} characters)", Project.MaxProjectDbName);

      this.AcceptButton = this.cmdOK;
      this._project = p;

      if (_project.ProjectFile != null)
      {
        this.txtProj.Text = _project.ProjectFile.FullName;
      }
      this.txtTitle.Text = _project.Title;
      this.dtpSnapshot.Value = _project.Snapshot;

      if (_project.Basedir != null)
      {
        txtBase.Text = _project.Basedir.FullName;
      }

      this.clbFileTypes.Items.AddRange(XmlConfig.Config.Extensions());
      for (int i=0; i<this.clbFileTypes.Items.Count; i++)
      {
        this.clbFileTypes.SetItemChecked(i, true);
      }

      chkFileTypes.CheckState = _project.ReadExtensions(this.clbFileTypes);

      ShowExcludedDirectories();
    }

    private void BrowseForBaseDirectory(object sender, System.EventArgs e)
    {
      if (fbdBase.ShowDialog() == DialogResult.OK)
      {
        txtBase.Text = fbdBase.SelectedPath;
      }
    }

    private void SelectExcludedDirectories(object sender, EventArgs e)
    {
      if ("".Equals(_project.Basedir)) return;

      FormDirectoryTreeSelector fdtSelector = new FormDirectoryTreeSelector(_project);

      if (fdtSelector.ShowDialog() == DialogResult.OK)
      {
        ShowExcludedDirectories();
      }
    }

    private void ShowExcludedDirectories()
    {
      lbxExcludedDirectories.Items.Clear();
      foreach (DirectoryInfo dir in _project.ProjectOptions.ExcludedDirectories)
      {
        lbxExcludedDirectories.Items.Add(dir.FullName);
      }
    }

    private void ProjectFileSaveAs(object sender, System.EventArgs e)
    {
      sfdProj.InitialDirectory = KrakatauSettings.Settings.DefaultDirectory;

      if (sfdProj.ShowDialog() == DialogResult.OK)
      {
        txtProj.Text = sfdProj.FileName;
      }
    }

    private void SaveProjectFileAndClose(object sender, System.EventArgs e)
    {
      _buildProjectFileThread = new Thread(new ThreadStart(this.BuildProjectFile));
      _buildProjectFileThread.Name = "Build Project File";
      _buildProjectFileThread.Start();

      Enabled = false;

      while (_buildProjectFileThread.IsAlive)
      {
        Thread.Sleep(400);
      }

      MessageBox.Show(this, "Project File successfully created.", "Project Created", MessageBoxButtons.OK, MessageBoxIcon.Information);
      Dispose();
    }

    private void BuildProjectFile()
    {
      _project.BuildFile(this.clbFileTypes.CheckedItems);
    }

    private void TitleChanged(object sender, System.EventArgs e)
    {
      _project.Title = txtTitle.Text;

      DialogValidation();
    }

    private void SnapshotDateChanged(object sender, EventArgs e)
    {
      _project.Snapshot = dtpSnapshot.Value;
    }

    private void BaseDirectoryChanged(object sender, System.EventArgs e)
    {
      if (!"".Equals(txtBase.Text))
      {
        DirectoryInfo check = new DirectoryInfo(txtBase.Text);
        if (check.Exists)
        {
          _project.Basedir = check;
        }
      }
      else
      {
        _project.Basedir = null;
      }

      DialogValidation();
    }

    private void LeaveBaseDirectory(object sender, EventArgs e)
    {
      if (!"".Equals(txtBase.Text))
      {
        DirectoryInfo check = new DirectoryInfo(txtBase.Text);
        if (check.Exists)
        {
          _project.Basedir = check;
        }
        else
        {
          if (_project.Basedir != null)
          {
            txtBase.Text = _project.Basedir.FullName;
          }
          else
          {
            txtBase.Text = "";
          }
        }
      }

      DialogValidation();
    }

    private void ProjectFileChanged(object sender, System.EventArgs e)
    {
      if (!"".Equals(txtProj.Text))
      {
        _project.ProjectFile = new FileInfo(txtProj.Text);
      }

      DialogValidation();
    }

    private void DialogValidation()
    {
      cmdOK.Enabled = ((!"".Equals(txtTitle.Text)) &&
        (!"".Equals(txtBase.Text)) &&
        (_project.ProjectFile != null));

      cmdSelect.Enabled = (_project.Basedir != null);
    }

    private void FileTypesChanged(object sender, EventArgs e)
    {
      for (int i = 0; i < clbFileTypes.Items.Count; i++)
      {
        clbFileTypes.SetItemChecked(i, chkFileTypes.Checked);
      }
    }
  }
}
