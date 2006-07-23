/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 * Krakatau Essential PM (KEPM)
 * Copyright (c) 2004-2006 Power Software
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * Analyse Dialog and Action
 *
 * $Id$
 * 
 * Who  When       Why
 * CAM  11-Oct-05   152 : Added to Source Safe.
 * CAM  26-Mar-06   213 : Remove Analysis options from Windows Registry (now parse epm.cmd file).
 * CAM  19-Jul-06   284 : Add Defensive checks for style.css and metrics.js.
 * CAM  22-Jul-06   291 : Add some tooltips and help around the reporting options.
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

using System;
using System.Drawing;
using System.Collections;
using System.ComponentModel;
using System.Windows.Forms;
using System.IO;
using System.Diagnostics;
using Microsoft.Win32;

namespace KrakatauEPM
{
  /// <summary>
  /// Summary description for Analyse.
  /// </summary>
  public class Analyse : System.Windows.Forms.Form
  {
    private System.Windows.Forms.CheckBox chkH2;
    private System.Windows.Forms.TextBox txtH2;
    private System.Windows.Forms.Button cmdH2Browse;
    private System.Windows.Forms.TextBox txtCSV;
    private System.Windows.Forms.CheckBox chkCSV;
    private System.Windows.Forms.Button cmdCSVBrowse;
    private System.Windows.Forms.CheckBox chkXML;
    private System.Windows.Forms.TextBox txtXML;
    private System.Windows.Forms.Button cmdXMLBrowse;
    private System.Windows.Forms.TextBox txtMyServer;
    private System.Windows.Forms.CheckBox chkMyServer;
    private System.Windows.Forms.TextBox txtMyUser;
    private System.Windows.Forms.CheckBox chkMyUser;
    private System.Windows.Forms.TextBox txtMyPwd;
    private System.Windows.Forms.CheckBox chkMyPwd;
    private System.Windows.Forms.TextBox txtNewProj;
    private System.Windows.Forms.TextBox txtOldProj;
    private System.Windows.Forms.FolderBrowserDialog fbdH2;
    private System.Windows.Forms.SaveFileDialog sfdRep;
    private System.Windows.Forms.Button cmdOK;
    private System.Windows.Forms.Button cmdCancel;
    private System.Windows.Forms.Label label1;
    private System.Windows.Forms.Label label2;
    private System.Windows.Forms.Label label3;
    private System.Windows.Forms.Label label4;
    private System.Windows.Forms.Label label5;
    private ProcessCaller processCaller;
    private System.Windows.Forms.RichTextBox rtbResults;
    private System.Windows.Forms.Button cmdParse;
    private System.Windows.Forms.CheckBox chkMetSet;
    private System.Windows.Forms.ComboBox cmbMetSet;
    private System.Windows.Forms.Label lblHelp;

    private Project _newProject = null;
    private Project _oldProject = null;



    /// <summary>
    /// Required designer variable.
    /// </summary>
    private System.ComponentModel.Container components = null;

    public Analyse(Project newProject): this(newProject, null)
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
          ComboBox cmb = (ComboBox) txt;
          if (cmb.Items.Contains(option)) 
          {
            cmb.Text = option;
          } 
        }
        else 
        {
          txt.Text = option;
        }
      }
    }

    public Analyse(Project newProject, Project oldProject)
    {
      this._newProject = newProject;
      this._oldProject = oldProject;

      InitializeComponent();    
  
      this.txtNewProj.Text = this._newProject.Title + " (" + this._newProject.ProjectFile.FullName + ")";
      if (this._oldProject != null) 
      {
        this.txtOldProj.Text = this._oldProject.Title + " (" + this._oldProject.ProjectFile.FullName + ")";
      }

      IEnumerator sets = XmlConfig.Config.GetMetricSets();
      while (sets.MoveNext()) 
      {
        this.cmbMetSet.Items.Add(sets.Current);
      }

      chkH2.Checked = chkCSV.Checked = chkXML.Checked = chkMyServer.Checked = chkMyUser.Checked = chkMyPwd.Checked = false;
      txtH2.Text =  txtCSV.Text = txtXML.Text = txtMyServer.Text = txtMyUser.Text = txtMyPwd.Text = "";

      Arguments a = newProject.GetAnalysisOptions();
      if (a != null) 
      {
        setOption(a["h2"], chkH2, txtH2);
        setOption(a["c"], chkCSV, txtCSV);
        setOption(a["x"], chkXML, txtXML);
        setOption(a["s"], chkMyServer, txtMyServer);
        setOption(a["u"], chkMyUser, txtMyUser);
        setOption(a["p"], chkMyPwd, txtMyPwd);        
        setOption(a["m"], chkMetSet, cmbMetSet);        
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

    protected void ReportHelp() 
    {
      this.lblHelp.Visible = false;
      if (!this.chkH2.Checked && !this.chkCSV.Checked && !this.chkXML.Checked) 
      {
        this.lblHelp.Visible = true;
        this.lblHelp.Text = "Select a reporting option by clicking one of the checkboxes.\n\nOnce you have clicked a checkbox, you can specify the output path or filename (as required).";
      }
    }

    /// <summary>
    /// Clean up any resources being used.
    /// </summary>
    protected override void Dispose(bool disposing)
    {
      if(disposing)
      {
        if(components != null)
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
      System.Resources.ResourceManager resources = new System.Resources.ResourceManager(typeof(Analyse));
      this.chkH2 = new System.Windows.Forms.CheckBox();
      this.txtH2 = new System.Windows.Forms.TextBox();
      this.label1 = new System.Windows.Forms.Label();
      this.cmdH2Browse = new System.Windows.Forms.Button();
      this.cmdCSVBrowse = new System.Windows.Forms.Button();
      this.txtCSV = new System.Windows.Forms.TextBox();
      this.chkCSV = new System.Windows.Forms.CheckBox();
      this.cmdXMLBrowse = new System.Windows.Forms.Button();
      this.txtXML = new System.Windows.Forms.TextBox();
      this.chkXML = new System.Windows.Forms.CheckBox();
      this.txtMyServer = new System.Windows.Forms.TextBox();
      this.chkMyServer = new System.Windows.Forms.CheckBox();
      this.label2 = new System.Windows.Forms.Label();
      this.txtMyUser = new System.Windows.Forms.TextBox();
      this.chkMyUser = new System.Windows.Forms.CheckBox();
      this.txtMyPwd = new System.Windows.Forms.TextBox();
      this.chkMyPwd = new System.Windows.Forms.CheckBox();
      this.label3 = new System.Windows.Forms.Label();
      this.label4 = new System.Windows.Forms.Label();
      this.label5 = new System.Windows.Forms.Label();
      this.txtNewProj = new System.Windows.Forms.TextBox();
      this.txtOldProj = new System.Windows.Forms.TextBox();
      this.fbdH2 = new System.Windows.Forms.FolderBrowserDialog();
      this.sfdRep = new System.Windows.Forms.SaveFileDialog();
      this.cmdCancel = new System.Windows.Forms.Button();
      this.cmdOK = new System.Windows.Forms.Button();
      this.rtbResults = new System.Windows.Forms.RichTextBox();
      this.cmdParse = new System.Windows.Forms.Button();
      this.chkMetSet = new System.Windows.Forms.CheckBox();
      this.cmbMetSet = new System.Windows.Forms.ComboBox();
      this.lblHelp = new System.Windows.Forms.Label();
      this.SuspendLayout();
      // 
      // chkH2
      // 
      this.chkH2.Font = new System.Drawing.Font("Tahoma", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((System.Byte)(0)));
      this.chkH2.Location = new System.Drawing.Point(16, 128);
      this.chkH2.Name = "chkH2";
      this.chkH2.TabIndex = 0;
      this.chkH2.Text = "HTML Report";
      this.chkH2.CheckedChanged += new System.EventHandler(this.chkH2_CheckedChanged);
      // 
      // txtH2
      // 
      this.txtH2.Font = new System.Drawing.Font("Tahoma", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((System.Byte)(0)));
      this.txtH2.Location = new System.Drawing.Point(128, 128);
      this.txtH2.Name = "txtH2";
      this.txtH2.Size = new System.Drawing.Size(288, 21);
      this.txtH2.TabIndex = 1;
      this.txtH2.Text = "";
      this.txtH2.Visible = false;
      // 
      // label1
      // 
      this.label1.Font = new System.Drawing.Font("Tahoma", 9.75F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((System.Byte)(0)));
      this.label1.Location = new System.Drawing.Point(8, 96);
      this.label1.Name = "label1";
      this.label1.TabIndex = 2;
      this.label1.Text = "Options";
      // 
      // cmdH2Browse
      // 
      this.cmdH2Browse.Font = new System.Drawing.Font("Tahoma", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((System.Byte)(0)));
      this.cmdH2Browse.Location = new System.Drawing.Point(424, 128);
      this.cmdH2Browse.Name = "cmdH2Browse";
      this.cmdH2Browse.Size = new System.Drawing.Size(64, 21);
      this.cmdH2Browse.TabIndex = 3;
      this.cmdH2Browse.Text = "&Browse";
      this.cmdH2Browse.Visible = false;
      this.cmdH2Browse.Click += new System.EventHandler(this.cmdH2Browse_Click);
      // 
      // cmdCSVBrowse
      // 
      this.cmdCSVBrowse.Font = new System.Drawing.Font("Tahoma", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((System.Byte)(0)));
      this.cmdCSVBrowse.Location = new System.Drawing.Point(424, 160);
      this.cmdCSVBrowse.Name = "cmdCSVBrowse";
      this.cmdCSVBrowse.Size = new System.Drawing.Size(64, 21);
      this.cmdCSVBrowse.TabIndex = 6;
      this.cmdCSVBrowse.Text = "&Browse";
      this.cmdCSVBrowse.Visible = false;
      this.cmdCSVBrowse.Click += new System.EventHandler(this.cmdCSVBrowse_Click);
      // 
      // txtCSV
      // 
      this.txtCSV.Font = new System.Drawing.Font("Tahoma", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((System.Byte)(0)));
      this.txtCSV.Location = new System.Drawing.Point(128, 160);
      this.txtCSV.Name = "txtCSV";
      this.txtCSV.Size = new System.Drawing.Size(288, 21);
      this.txtCSV.TabIndex = 5;
      this.txtCSV.Text = "";
      this.txtCSV.Visible = false;
      // 
      // chkCSV
      // 
      this.chkCSV.Font = new System.Drawing.Font("Tahoma", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((System.Byte)(0)));
      this.chkCSV.Location = new System.Drawing.Point(16, 160);
      this.chkCSV.Name = "chkCSV";
      this.chkCSV.TabIndex = 4;
      this.chkCSV.Text = "CSV Report";
      this.chkCSV.CheckedChanged += new System.EventHandler(this.chkCSV_CheckedChanged);
      // 
      // cmdXMLBrowse
      // 
      this.cmdXMLBrowse.Font = new System.Drawing.Font("Tahoma", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((System.Byte)(0)));
      this.cmdXMLBrowse.Location = new System.Drawing.Point(424, 192);
      this.cmdXMLBrowse.Name = "cmdXMLBrowse";
      this.cmdXMLBrowse.Size = new System.Drawing.Size(64, 21);
      this.cmdXMLBrowse.TabIndex = 9;
      this.cmdXMLBrowse.Text = "&Browse";
      this.cmdXMLBrowse.Visible = false;
      this.cmdXMLBrowse.Click += new System.EventHandler(this.cmdXMLBrowse_Click);
      // 
      // txtXML
      // 
      this.txtXML.Font = new System.Drawing.Font("Tahoma", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((System.Byte)(0)));
      this.txtXML.Location = new System.Drawing.Point(128, 192);
      this.txtXML.Name = "txtXML";
      this.txtXML.Size = new System.Drawing.Size(288, 21);
      this.txtXML.TabIndex = 8;
      this.txtXML.Text = "";
      this.txtXML.Visible = false;
      // 
      // chkXML
      // 
      this.chkXML.Font = new System.Drawing.Font("Tahoma", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((System.Byte)(0)));
      this.chkXML.Location = new System.Drawing.Point(16, 192);
      this.chkXML.Name = "chkXML";
      this.chkXML.TabIndex = 7;
      this.chkXML.Text = "XML Report";
      this.chkXML.CheckedChanged += new System.EventHandler(this.chkXML_CheckedChanged);
      // 
      // txtMyServer
      // 
      this.txtMyServer.Font = new System.Drawing.Font("Tahoma", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((System.Byte)(0)));
      this.txtMyServer.Location = new System.Drawing.Point(128, 280);
      this.txtMyServer.Name = "txtMyServer";
      this.txtMyServer.Size = new System.Drawing.Size(144, 21);
      this.txtMyServer.TabIndex = 11;
      this.txtMyServer.Text = "";
      this.txtMyServer.Visible = false;
      // 
      // chkMyServer
      // 
      this.chkMyServer.Font = new System.Drawing.Font("Tahoma", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((System.Byte)(0)));
      this.chkMyServer.Location = new System.Drawing.Point(16, 280);
      this.chkMyServer.Name = "chkMyServer";
      this.chkMyServer.TabIndex = 10;
      this.chkMyServer.Text = "Server";
      this.chkMyServer.CheckedChanged += new System.EventHandler(this.chkMyServer_CheckedChanged);
      // 
      // label2
      // 
      this.label2.Font = new System.Drawing.Font("Tahoma", 9.75F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((System.Byte)(0)));
      this.label2.Location = new System.Drawing.Point(8, 256);
      this.label2.Name = "label2";
      this.label2.Size = new System.Drawing.Size(304, 23);
      this.label2.TabIndex = 12;
      this.label2.Text = "MySQL Server";
      // 
      // txtMyUser
      // 
      this.txtMyUser.Font = new System.Drawing.Font("Tahoma", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((System.Byte)(0)));
      this.txtMyUser.Location = new System.Drawing.Point(128, 312);
      this.txtMyUser.Name = "txtMyUser";
      this.txtMyUser.Size = new System.Drawing.Size(96, 21);
      this.txtMyUser.TabIndex = 14;
      this.txtMyUser.Text = "";
      this.txtMyUser.Visible = false;
      // 
      // chkMyUser
      // 
      this.chkMyUser.Font = new System.Drawing.Font("Tahoma", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((System.Byte)(0)));
      this.chkMyUser.Location = new System.Drawing.Point(16, 312);
      this.chkMyUser.Name = "chkMyUser";
      this.chkMyUser.TabIndex = 13;
      this.chkMyUser.Text = "Username";
      this.chkMyUser.CheckedChanged += new System.EventHandler(this.chkMyUser_CheckedChanged);
      // 
      // txtMyPwd
      // 
      this.txtMyPwd.Font = new System.Drawing.Font("Tahoma", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((System.Byte)(0)));
      this.txtMyPwd.Location = new System.Drawing.Point(128, 344);
      this.txtMyPwd.Name = "txtMyPwd";
      this.txtMyPwd.PasswordChar = '*';
      this.txtMyPwd.Size = new System.Drawing.Size(96, 21);
      this.txtMyPwd.TabIndex = 16;
      this.txtMyPwd.Text = "";
      this.txtMyPwd.Visible = false;
      // 
      // chkMyPwd
      // 
      this.chkMyPwd.Font = new System.Drawing.Font("Tahoma", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((System.Byte)(0)));
      this.chkMyPwd.Location = new System.Drawing.Point(16, 344);
      this.chkMyPwd.Name = "chkMyPwd";
      this.chkMyPwd.TabIndex = 15;
      this.chkMyPwd.Text = "Password";
      this.chkMyPwd.CheckedChanged += new System.EventHandler(this.chkMyPwd_CheckedChanged);
      // 
      // label3
      // 
      this.label3.Font = new System.Drawing.Font("Tahoma", 9.75F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((System.Byte)(0)));
      this.label3.Location = new System.Drawing.Point(8, 8);
      this.label3.Name = "label3";
      this.label3.TabIndex = 17;
      this.label3.Text = "Projects";
      // 
      // label4
      // 
      this.label4.Font = new System.Drawing.Font("Tahoma", 8.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((System.Byte)(0)));
      this.label4.Location = new System.Drawing.Point(16, 34);
      this.label4.Name = "label4";
      this.label4.Size = new System.Drawing.Size(80, 16);
      this.label4.TabIndex = 18;
      this.label4.Text = "New Project";
      // 
      // label5
      // 
      this.label5.Font = new System.Drawing.Font("Tahoma", 8.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((System.Byte)(0)));
      this.label5.Location = new System.Drawing.Point(16, 66);
      this.label5.Name = "label5";
      this.label5.Size = new System.Drawing.Size(80, 16);
      this.label5.TabIndex = 19;
      this.label5.Text = "Old Project";
      // 
      // txtNewProj
      // 
      this.txtNewProj.BackColor = System.Drawing.SystemColors.InactiveCaptionText;
      this.txtNewProj.Enabled = false;
      this.txtNewProj.Location = new System.Drawing.Point(128, 32);
      this.txtNewProj.Name = "txtNewProj";
      this.txtNewProj.Size = new System.Drawing.Size(264, 20);
      this.txtNewProj.TabIndex = 20;
      this.txtNewProj.Text = "";
      // 
      // txtOldProj
      // 
      this.txtOldProj.BackColor = System.Drawing.SystemColors.InactiveCaptionText;
      this.txtOldProj.Enabled = false;
      this.txtOldProj.Location = new System.Drawing.Point(128, 64);
      this.txtOldProj.Name = "txtOldProj";
      this.txtOldProj.Size = new System.Drawing.Size(264, 20);
      this.txtOldProj.TabIndex = 21;
      this.txtOldProj.Text = "";
      // 
      // cmdCancel
      // 
      this.cmdCancel.DialogResult = System.Windows.Forms.DialogResult.Cancel;
      this.cmdCancel.Font = new System.Drawing.Font("Tahoma", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((System.Byte)(0)));
      this.cmdCancel.Location = new System.Drawing.Point(440, 544);
      this.cmdCancel.Name = "cmdCancel";
      this.cmdCancel.TabIndex = 22;
      this.cmdCancel.Text = "&Cancel";
      // 
      // cmdOK
      // 
      this.cmdOK.DialogResult = System.Windows.Forms.DialogResult.OK;
      this.cmdOK.Font = new System.Drawing.Font("Tahoma", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((System.Byte)(0)));
      this.cmdOK.Location = new System.Drawing.Point(352, 544);
      this.cmdOK.Name = "cmdOK";
      this.cmdOK.TabIndex = 23;
      this.cmdOK.Text = "&OK";
      this.cmdOK.Click += new System.EventHandler(this.cmdOK_Click);
      // 
      // rtbResults
      // 
      this.rtbResults.Location = new System.Drawing.Point(8, 376);
      this.rtbResults.Name = "rtbResults";
      this.rtbResults.Size = new System.Drawing.Size(512, 160);
      this.rtbResults.TabIndex = 25;
      this.rtbResults.Text = "";
      // 
      // cmdParse
      // 
      this.cmdParse.Font = new System.Drawing.Font("Tahoma", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((System.Byte)(0)));
      this.cmdParse.Location = new System.Drawing.Point(440, 344);
      this.cmdParse.Name = "cmdParse";
      this.cmdParse.TabIndex = 24;
      this.cmdParse.Text = "&Parse";
      this.cmdParse.Click += new System.EventHandler(this.cmdParse_Click);
      // 
      // chkMetSet
      // 
      this.chkMetSet.Font = new System.Drawing.Font("Tahoma", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((System.Byte)(0)));
      this.chkMetSet.Location = new System.Drawing.Point(16, 224);
      this.chkMetSet.Name = "chkMetSet";
      this.chkMetSet.TabIndex = 26;
      this.chkMetSet.Text = "Metric Set";
      this.chkMetSet.CheckedChanged += new System.EventHandler(this.chkMetSet_CheckedChanged);
      // 
      // cmbMetSet
      // 
      this.cmbMetSet.Font = new System.Drawing.Font("Tahoma", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((System.Byte)(0)));
      this.cmbMetSet.Location = new System.Drawing.Point(128, 224);
      this.cmbMetSet.Name = "cmbMetSet";
      this.cmbMetSet.Size = new System.Drawing.Size(224, 21);
      this.cmbMetSet.TabIndex = 28;
      // 
      // lblHelp
      // 
      this.lblHelp.BackColor = System.Drawing.Color.FromArgb(((System.Byte)(255)), ((System.Byte)(255)), ((System.Byte)(204)));
      this.lblHelp.Font = new System.Drawing.Font("Tahoma", 9F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((System.Byte)(0)));
      this.lblHelp.Location = new System.Drawing.Point(128, 120);
      this.lblHelp.Name = "lblHelp";
      this.lblHelp.Size = new System.Drawing.Size(360, 96);
      this.lblHelp.TabIndex = 29;
      this.lblHelp.TextAlign = System.Drawing.ContentAlignment.MiddleCenter;
      this.lblHelp.Visible = false;
      // 
      // Analyse
      // 
      this.AcceptButton = this.cmdParse;
      this.AutoScaleBaseSize = new System.Drawing.Size(5, 13);
      this.ClientSize = new System.Drawing.Size(528, 591);
      this.Controls.Add(this.cmbMetSet);
      this.Controls.Add(this.chkMetSet);
      this.Controls.Add(this.cmdParse);
      this.Controls.Add(this.rtbResults);
      this.Controls.Add(this.cmdOK);
      this.Controls.Add(this.cmdCancel);
      this.Controls.Add(this.txtOldProj);
      this.Controls.Add(this.txtNewProj);
      this.Controls.Add(this.txtMyPwd);
      this.Controls.Add(this.txtMyUser);
      this.Controls.Add(this.txtMyServer);
      this.Controls.Add(this.txtXML);
      this.Controls.Add(this.txtCSV);
      this.Controls.Add(this.txtH2);
      this.Controls.Add(this.label5);
      this.Controls.Add(this.label4);
      this.Controls.Add(this.label3);
      this.Controls.Add(this.chkMyPwd);
      this.Controls.Add(this.chkMyUser);
      this.Controls.Add(this.label2);
      this.Controls.Add(this.chkMyServer);
      this.Controls.Add(this.cmdXMLBrowse);
      this.Controls.Add(this.chkXML);
      this.Controls.Add(this.cmdCSVBrowse);
      this.Controls.Add(this.chkCSV);
      this.Controls.Add(this.cmdH2Browse);
      this.Controls.Add(this.label1);
      this.Controls.Add(this.chkH2);
      this.Controls.Add(this.lblHelp);
      this.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedDialog;
      this.Icon = ((System.Drawing.Icon)(resources.GetObject("$this.Icon")));
      this.MaximizeBox = false;
      this.MinimizeBox = false;
      this.Name = "Analyse";
      this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
      this.Text = "Analyse";
      this.ResumeLayout(false);

    }
    #endregion

    private void chkH2_CheckedChanged(object sender, System.EventArgs e)
    {
      this.txtH2.Visible = this.cmdH2Browse.Visible = this.chkH2.Checked;
      ReportHelp();
    }

    private void chkCSV_CheckedChanged(object sender, System.EventArgs e)
    {
      this.txtCSV.Visible = this.cmdCSVBrowse.Visible = this.chkCSV.Checked;    
      ReportHelp();
    }

    private void chkXML_CheckedChanged(object sender, System.EventArgs e)
    {
      this.txtXML.Visible = this.cmdXMLBrowse.Visible = this.chkXML.Checked;        
      ReportHelp();
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

    private void cmdParse_Click(object sender, System.EventArgs e)
    {
      BuildAnalysisFile();    
      EpmAnalyse();
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
      Prefs pf = Prefs.Preferences;
      TextWriter tw = new StreamWriter(_newProject.ProjectAnalysisFile.FullName, false);
      tw.WriteLine("@echo off");
      tw.WriteLine(pf.InstallDrive);
      tw.WriteLine("cd \"" + pf.InstallDir.FullName + "\"");
      
      tw.Write("epm");

      tw.Write(" -f1 \"" + _newProject.ProjectFile.FullName + "\"");

      if (_oldProject != null) 
      {
        tw.Write(" -f2 \"" + _oldProject.ProjectFile.FullName + "\"");
      } 

      if (this.chkH2.Checked) 
      {
        tw.Write(" -h2 \"" + this.txtH2.Text + "\"");
      }
      
      if (this.chkCSV.Checked) 
      {
        tw.Write(" -c \"" + this.txtCSV.Text + "\"");
      }

      if (this.chkXML.Checked) 
      {
        tw.Write(" -x \"" + this.txtXML.Text + "\"");
      }

      if (this.chkMetSet.Checked) 
      {
        tw.Write(" -m \"" + this.cmbMetSet.Text + "\"");
      }

      if (this.chkMyServer.Checked) 
      {
        tw.Write(" -s " + this.txtMyServer.Text);
      }

      if (this.chkMyUser.Checked) 
      {
        tw.Write(" -u " + this.txtMyUser.Text);
      }

      if (this.chkMyPwd.Checked)
      {
        tw.Write(" -p " + this.txtMyPwd.Text);
      }

      tw.WriteLine(" " + this._newProject.Databasename);
      tw.Close();
    }

    private void EpmAnalyse() 
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

      // the following function starts a process and returns immediately,
      // thus allowing the form to stay responsive.
      processCaller.Start();
    }
  
    /// <summary>
    /// Return the StdErrReceived and StdOutReceived event data.
    /// </summary>
    private void writeStreamInfo(object sender, DataReceivedEventArgs e)
    {
      this.rtbResults.AppendText(e.Text + Environment.NewLine);
    }

    /// <summary>
    /// Handles the events of processCompleted & processCanceled
    /// </summary>
    private void processCompletedOrCanceled(object sender, EventArgs e)
    {
      this.Cursor = Cursors.Default;
      this.cmdOK.Enabled = this.cmdParse.Enabled = true;  

      if (this.chkH2.Checked) 
      {
        FileInfo h2Html = new FileInfo(this.txtH2.Text + "\\index.html");
        DirectoryInfo installedHtml = new DirectoryInfo(Prefs.Preferences.InstallDir + "\\html");
        FileInfo styleCss = new FileInfo(installedHtml.FullName + "\\style.css");
        FileInfo metricsJs = new FileInfo(installedHtml.FullName + "\\metrics.js");

        string sError = "";

        if (h2Html.Exists)
        {
          if (styleCss.Exists) 
          {
            FileInfo repStyleCss = new FileInfo(h2Html.Directory.FullName + "\\" + styleCss.Name);
            try 
            {
              styleCss.CopyTo(repStyleCss.FullName, true);
            } 
            catch 
            {
              sError += "Could not overwrite " + repStyleCss.FullName + "\nPlease check you have the right permissions.\n\n";
            }
          } 
          else 
          {
            sError += "Could not find " + styleCss.FullName + "\nPlease check that Krakatau EPM is correctly installed.\n\n";
          }

          if (metricsJs.Exists) 
          {
            
            FileInfo repMetricsJs = new FileInfo(h2Html.Directory.FullName + "\\" + metricsJs.Name);
            try 
            {
              metricsJs.CopyTo(repMetricsJs.FullName, true);
            } 
            catch 
            {
              sError += "Could not overwrite " + repMetricsJs.FullName + "\nPlease check you have the right permissions.\n\n";
            }
          } 
          else 
          {
            sError += "Could not find " + metricsJs.FullName + "\nPlease check that Krakatau EPM is correctly installed.\n\n";
          }

          if (sError.Length>0) 
          {
            MessageBox.Show(this, sError, "Warning!", MessageBoxButtons.OK, MessageBoxIcon.Warning);
          }

          System.Diagnostics.Process.Start(h2Html.FullName);
        }
      }
    }
  }
}