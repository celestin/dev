/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 * Krakatau Essential PM (KEPM)
 * Copyright (c) 2004,2009 PowerSoftware.com
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  11-Oct-05    152 : Added to Source Safe.
 * CAM  26-Mar-06    213 : Remove Analysis options from Windows Registry (now parse epm.cmd file).
 * CAM  19-Jul-06    284 : Add Defensive checks for style.css and metrics.js.
 * CAM  22-Jul-06    291 : Add some tooltips and help around the reporting options.
 * CAM  29-May-08    364 : Added defaulting of MySQL options.
 * CAM  30-May-08    366 : Set UseSystemPasswordChar to true.
 * CAM  14-Sep-2009  10484 : Ensure logging is based on chkLog.
 * CAM  15-Feb-2010  10565 : Use KrakatauSettings for InstallDir.
 * CAM  19-Feb-2010  10558 : Use MetricSets property (rather than method).
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

using System;
using System.Collections;
using System.ComponentModel;
using System.Windows.Forms;
using System.IO;
using System.Diagnostics;
using Microsoft.Win32;

using SourceCodeMetrics.Krakatau.Kepm.Config;
using SourceCodeMetrics.Krakatau.Kepm.Projects;
using SourceCodeMetrics.Krakatau.Kepm.Threading;
using SourceCodeMetrics.Krakatau.Kepm.Win32;

namespace SourceCodeMetrics.Krakatau.Kepm.Forms
{
  /// <summary>
  /// Analyze Dialog and Action.
  /// </summary>
  public partial class FormAnalyze : Form
  {
    public FormAnalyze(Project newProject, Project oldProject)
    {
      this._newProject = newProject;
      this._oldProject = oldProject;

      InitializeComponent();

      this.txtNewProj.Text = this._newProject.Title + " (" + this._newProject.ProjectFile.FullName + ")";
      if (this._oldProject != null)
      {
        this.txtOldProj.Text = this._oldProject.Title + " (" + this._oldProject.ProjectFile.FullName + ")";
      }

      IEnumerator sets = XmlConfig.Config.MetricSets;
      while (sets.MoveNext())
      {
        this.cmbMetSet.Items.Add(sets.Current);
      }

      chkH2.Checked = chkCSV.Checked = chkXML.Checked = chkMyServer.Checked = chkMyUser.Checked = chkMyPwd.Checked = false;
      txtH2.Text = txtCSV.Text = txtXML.Text = txtMyServer.Text = txtMyUser.Text = txtMyPwd.Text = "";

      Arguments a = newProject.GetAnalysisOptions();
      if (a != null)
      {
        setOption(a["h2"], chkH2, txtH2);
        setOption(a["c"], chkCSV, txtCSV);
        setOption(a["x"], chkXML, txtXML);
        setOption(a["l"], chkLog, txtLog);
        setOption(a["s"], chkMyServer, txtMyServer);
        setOption(a["u"], chkMyUser, txtMyUser);
        setOption(a["p"], chkMyPwd, txtMyPwd);
        setOption(a["m"], chkMetSet, cmbMetSet);
      }
      else
      {
        // New Project, set MySQL settings from Preferences
        Prefs p = Prefs.Preferences;
        if (p.MySqlUse)
        {
          setOption(p.MySqlServer, chkMyServer, txtMyServer);
          setOption(p.MySqlUsername, chkMyUser, txtMyUser);
          setOption(p.MySqlPassword, chkMyPwd, txtMyPwd);
        }
      }

      this.txtH2.Visible = this.cmdH2Browse.Visible = this.chkH2.Checked;
      this.txtCSV.Visible = this.cmdCSVBrowse.Visible = this.chkCSV.Checked;
      this.txtXML.Visible = this.cmdXMLBrowse.Visible = this.chkXML.Checked;
      ReportHelp();

      this.cmbMetSet.Visible = this.chkMetSet.Checked;
      this.txtMyServer.Visible = this.chkMyServer.Checked;
      this.txtMyUser.Visible = this.chkMyUser.Checked;
      this.txtMyPwd.Visible = this.chkMyPwd.Checked;

      ToolTip tt = new ToolTip();
      tt.SetToolTip(txtH2, "Use the Browse button to specify the PATH (a folder)\nto which the HTML files will be written.");
      tt.SetToolTip(cmdH2Browse, "Use this button to specify the PATH (a folder)\nto which the HTML files will be written.");
      tt.SetToolTip(txtCSV, "Use the Browse button to specify the filename for the CSV report.");
      tt.SetToolTip(cmdCSVBrowse, "Use this button to specify the filename for the CSV report.");
      tt.SetToolTip(txtXML, "Use the Browse button to specify the filename for the XML report.");
      tt.SetToolTip(cmdXMLBrowse, "Use this button to specify the filename for the XML report.");
    }

    public FormAnalyze(Project newProject)
      : this(newProject, null)
    {
    }

    private void setOption(string option, CheckBox chk, Control txt)
    {
      txt.Text = "";

      if (option != null)
      {
        chk.Checked = true;

        if (txt is ComboBox)
        {
          ComboBox cmb = (ComboBox)txt;
          IEnumerator sets = cmb.Items.GetEnumerator();
          while (sets.MoveNext())
          {
            if (sets.Current.ToString().Equals(option))
            {
              cmb.Text = option;
              return;
            }
          }

        }
        else
        {
          txt.Text = option;
        }
      }
    }

    protected void ReportHelp()
    {
      this.lblHelp.Visible = false;
      if (!this.chkH2.Checked && !this.chkCSV.Checked && !this.chkXML.Checked)
      {
        this.lblHelp.Visible = true;
        this.lblHelp.Text = "Select a reporting option by clicking one of the checkboxes.\n\nOnce you have clicked a checkbox, you can specify the output path or filename (as required).";
      }
    }



    private void chkH2_CheckedChanged(object sender, System.EventArgs e)
    {
      txtH2.Visible = cmdH2Browse.Visible = chkH2.Checked;
      ReportHelp();
    }

    private void chkCSV_CheckedChanged(object sender, System.EventArgs e)
    {
      txtCSV.Visible = cmdCSVBrowse.Visible = chkCSV.Checked;
      ReportHelp();
    }

    private void chkXML_CheckedChanged(object sender, System.EventArgs e)
    {
      txtXML.Visible = cmdXMLBrowse.Visible = chkXML.Checked;
      ReportHelp();
    }

    private void chkLog_CheckedChanged(object sender, EventArgs e)
    {
      txtLog.Visible = cmdLogBrowse.Visible = chkLog.Checked;
    }

    private void chkMetSet_CheckedChanged(object sender, System.EventArgs e)
    {
      this.cmbMetSet.Visible = this.chkMetSet.Checked;
    }

    private void chkMyServer_CheckedChanged(object sender, System.EventArgs e)
    {
      this.txtMyServer.Visible = this.chkMyServer.Checked;
    }

    private void chkMyUser_CheckedChanged(object sender, System.EventArgs e)
    {
      this.txtMyUser.Visible = this.chkMyUser.Checked;
    }

    private void chkMyPwd_CheckedChanged(object sender, System.EventArgs e)
    {
      this.txtMyPwd.Visible = this.chkMyPwd.Checked;
    }

    private void cmdH2Browse_Click(object sender, System.EventArgs e)
    {
      if (fbdH2.ShowDialog() == DialogResult.OK)
      {
        txtH2.Text = fbdH2.SelectedPath;
      }
    }

    private void cmdCSVBrowse_Click(object sender, System.EventArgs e)
    {
      sfdRep.Title = "Save CSV Report";
      sfdRep.DefaultExt = "csv";
      if (sfdRep.ShowDialog() == DialogResult.OK)
      {
        txtCSV.Text = sfdRep.FileName;
      }
    }

    private void cmdXMLBrowse_Click(object sender, System.EventArgs e)
    {
      sfdRep.Title = "Save XML Report";
      sfdRep.DefaultExt = "xml";
      if (sfdRep.ShowDialog() == DialogResult.OK)
      {
        txtXML.Text = sfdRep.FileName;
      }
    }

    private void cmdLogBrowse_Click(object sender, EventArgs e)
    {
      sfdRep.Title = "Save Logfile";
      sfdRep.DefaultExt = "txt";
      if (sfdRep.ShowDialog() == DialogResult.OK)
      {
        txtLog.Text = sfdRep.FileName;
      }
    }

    private void cmdParse_Click(object sender, System.EventArgs e)
    {
      BuildAnalysisFile();
      EpmAnalyze();
    }

    private void cmdOK_Click(object sender, System.EventArgs e)
    {
      BuildAnalysisFile();
      cmdCancel_Click(sender, e);
    }

    private void cmdCancel_Click(object sender, System.EventArgs e)
    {
      if (processCaller != null)
      {
        processCaller.Cancel();
      }
    }

    private void BuildAnalysisFile()
    {
      // Create a Project Command file
      TextWriter tw = new StreamWriter(_newProject.ProjectAnalysisFile.FullName, false);
      tw.WriteLine("@echo off");
      tw.WriteLine(KrakatauSettings.Settings.InstallDrive);
      tw.WriteLine("cd \"" + KrakatauSettings.Settings.InstallDir.FullName + "\"");

      tw.Write("epm");

      tw.Write(" -f1 \"" + _newProject.ProjectFile.FullName + "\"");

      if (_oldProject != null)
      {
        tw.Write(" -f2 \"" + _oldProject.ProjectFile.FullName + "\"");
      }

      if (chkH2.Checked)
      {
        tw.Write(" -h2 \"" + txtH2.Text + "\"");
      }

      if (chkCSV.Checked)
      {
        tw.Write(" -c \"" + txtCSV.Text + "\"");
      }

      if (chkXML.Checked)
      {
        tw.Write(" -x \"" + txtXML.Text + "\"");
      }

      if (chkLog.Checked)
      {
        tw.Write(" -l \"" + txtLog.Text + "\"");
      }

      if (chkMetSet.Checked)
      {
        tw.Write(" -m \"" + cmbMetSet.Text + "\"");
      }

      if (chkMyServer.Checked)
      {
        tw.Write(" -s " + txtMyServer.Text);
      }

      if (chkMyUser.Checked)
      {
        tw.Write(" -u " + txtMyUser.Text);
      }

      if (chkMyPwd.Checked)
      {
        tw.Write(" -p " + txtMyPwd.Text);
      }

      tw.WriteLine(" " + _newProject.Databasename);
      tw.Close();
    }

    private void EpmAnalyze()
    {
      this.Cursor = Cursors.AppStarting;
      this.cmdOK.Enabled = this.cmdParse.Enabled = false;

      processCaller = new ProcessCaller(this);
      processCaller.FileName = _newProject.ProjectAnalysisFile.FullName;
      processCaller.Arguments = "";
      processCaller.StdErrReceived += new DataReceivedHandler(writeStreamInfo);
      processCaller.StdOutReceived += new DataReceivedHandler(writeStreamInfo);
      processCaller.Completed += new EventHandler(processCompletedOrCanceled);
      processCaller.Cancelled += new EventHandler(processCompletedOrCanceled);

      this.rtbResults.Text = "EPM Started, please wait..." + Environment.NewLine;

      // The following function starts a process and returns immediately,
      // allowing the form to stay responsive
      processCaller.Start();
    }

    /// <summary>
    /// Return the StdErrReceived and StdOutReceived event data
    /// </summary>
    private void writeStreamInfo(object sender, SourceCodeMetrics.Krakatau.Kepm.Threading.DataReceivedEventArgs e)
    {
      this.rtbResults.AppendText(e.Text + Environment.NewLine);
    }

    private string CopyFile(FileInfo from, DirectoryInfo directory, string message)
    {
      string rval = message;

      if (from.Exists)
      {
        FileInfo to = new FileInfo(directory.FullName + "\\" + from.Name);
        try
        {
          from.CopyTo(to.FullName, true);
        }
        catch
        {
          rval += "Could not overwrite " + to.FullName + "\nPlease check you have the right permissions.\n\n";
        }
      }
      else
      {
        rval += "Could not find " + from.FullName + "\nPlease check that " + KrakatauEPM.AssemblyProduct + " is correctly installed.\n\n";
      }

      return rval;
    }

    /// <summary>
    /// Handles the events of processCompleted & processCanceled
    /// </summary>
    private void processCompletedOrCanceled(object sender, EventArgs e)
    {
      Cursor = Cursors.Default;
      cmdOK.Enabled = cmdParse.Enabled = true;

      if (chkH2.Checked)
      {
        FileInfo h2Html = new FileInfo(txtH2.Text + @"\index.html");
        DirectoryInfo installedHtml = new DirectoryInfo(String.Format(@"{0}\html", KrakatauSettings.Settings.InstallDir));
        FileInfo styleCss = new FileInfo(installedHtml.FullName + @"\style.css");
        FileInfo metricsJs = new FileInfo(installedHtml.FullName + @"\metrics.js");

        string sError = "";

        if (h2Html.Exists)
        {
          sError += CopyFile(styleCss, h2Html.Directory, sError);
          sError += CopyFile(metricsJs, h2Html.Directory, sError);

          if (sError.Length > 0)
          {
            MessageBox.Show(this, sError, "Warning!", MessageBoxButtons.OK, MessageBoxIcon.Warning);
          }

          System.Diagnostics.Process.Start(h2Html.FullName);
        }
      }
    }
  }
}
