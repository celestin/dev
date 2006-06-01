/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 * Krakatau Essential PM (KEPM)
 * Copyright 2005 Craig McKay <craig@southesk.com>
 *
 * Analyse Dialog and Action
 *
 * $Log: /kepm/KrakatauEPM.root/KrakatauEPM/KrakatauEPM/Analyse.cs $
 * 
 * 4     26/03/06 19:48 Craig
 * 213
 * 
 * 3     11/10/05 23:15 Craig
 * 152
 * 
 * Who  When       Why
 * CAM  11-Oct-05   152 : Added to Source Safe.
 * CAM  26-Mar-06   213 : Remove Analysis options from Windows Registry (now parse epm.cmd file).
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

    private Project _newProject = null;
    private Project _oldProject = null;

    private ProcessCaller processCaller;
    private System.Windows.Forms.RichTextBox rtbResults;
    private System.Windows.Forms.Button cmdParse;


    /// <summary>
    /// Required designer variable.
    /// </summary>
    private System.ComponentModel.Container components = null;

    public Analyse(Project newProject): this(newProject, null)
    {
    }

    private void setOption(string option, CheckBox chk, TextBox txt) 
    {
      if (option != null) 
      {
        chk.Checked = true;
        txt.Text = option;
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

      chkH2.Checked = chkCSV.Checked = chkXML.Checked = chkMyServer.Checked = chkMyUser.Checked = chkMyPwd.Checked = false;
      txtH2.Text =  txtCSV.Text = txtXML.Text = txtMyServer.Text = txtMyUser.Text = txtMyPwd.Text = "";

      Arguments a = newProject.getAnalysisOptions();
      if (a != null) 
      {
        setOption(a["h2"], chkH2, txtH2);
        setOption(a["c"], chkCSV, txtCSV);
        setOption(a["x"], chkXML, txtXML);
        setOption(a["s"], chkMyServer, txtMyServer);
        setOption(a["u"], chkMyUser, txtMyUser);
        setOption(a["p"], chkMyPwd, txtMyPwd);
      }

      this.txtH2.Visible = this.cmdH2Browse.Visible = this.chkH2.Checked;
      this.txtCSV.Visible = this.cmdCSVBrowse.Visible = this.chkCSV.Checked;    
      this.txtXML.Visible = this.cmdXMLBrowse.Visible = this.chkXML.Checked;        
      this.txtMyServer.Visible = this.chkMyServer.Checked;            
      this.txtMyUser.Visible = this.chkMyUser.Checked;                
      this.txtMyPwd.Visible = this.chkMyPwd.Checked;
    }

    /// <summary>
    /// Clean up any resources being used.
    /// </summary>
    protected override void Dispose( bool disposing )
    {
      if( disposing )
      {
        if(components != null)
        {
          components.Dispose();
        }
      }
      base.Dispose( disposing );
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
      this.txtMyServer.Location = new System.Drawing.Point(128, 256);
      this.txtMyServer.Name = "txtMyServer";
      this.txtMyServer.Size = new System.Drawing.Size(144, 21);
      this.txtMyServer.TabIndex = 11;
      this.txtMyServer.Text = "";
      this.txtMyServer.Visible = false;
      // 
      // chkMyServer
      // 
      this.chkMyServer.Font = new System.Drawing.Font("Tahoma", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((System.Byte)(0)));
      this.chkMyServer.Location = new System.Drawing.Point(16, 256);
      this.chkMyServer.Name = "chkMyServer";
      this.chkMyServer.TabIndex = 10;
      this.chkMyServer.Text = "Server";
      this.chkMyServer.CheckedChanged += new System.EventHandler(this.chkMyServer_CheckedChanged);
      // 
      // label2
      // 
      this.label2.Font = new System.Drawing.Font("Tahoma", 9.75F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((System.Byte)(0)));
      this.label2.Location = new System.Drawing.Point(8, 232);
      this.label2.Name = "label2";
      this.label2.Size = new System.Drawing.Size(304, 23);
      this.label2.TabIndex = 12;
      this.label2.Text = "MySQL Server";
      // 
      // txtMyUser
      // 
      this.txtMyUser.Font = new System.Drawing.Font("Tahoma", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((System.Byte)(0)));
      this.txtMyUser.Location = new System.Drawing.Point(128, 288);
      this.txtMyUser.Name = "txtMyUser";
      this.txtMyUser.Size = new System.Drawing.Size(96, 21);
      this.txtMyUser.TabIndex = 14;
      this.txtMyUser.Text = "";
      this.txtMyUser.Visible = false;
      // 
      // chkMyUser
      // 
      this.chkMyUser.Font = new System.Drawing.Font("Tahoma", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((System.Byte)(0)));
      this.chkMyUser.Location = new System.Drawing.Point(16, 288);
      this.chkMyUser.Name = "chkMyUser";
      this.chkMyUser.TabIndex = 13;
      this.chkMyUser.Text = "Username";
      this.chkMyUser.CheckedChanged += new System.EventHandler(this.chkMyUser_CheckedChanged);
      // 
      // txtMyPwd
      // 
      this.txtMyPwd.Font = new System.Drawing.Font("Tahoma", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((System.Byte)(0)));
      this.txtMyPwd.Location = new System.Drawing.Point(128, 320);
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
      this.chkMyPwd.Location = new System.Drawing.Point(16, 320);
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
      this.cmdCancel.Location = new System.Drawing.Point(440, 520);
      this.cmdCancel.Name = "cmdCancel";
      this.cmdCancel.TabIndex = 22;
      this.cmdCancel.Text = "&Cancel";
      // 
      // cmdOK
      // 
      this.cmdOK.DialogResult = System.Windows.Forms.DialogResult.OK;
      this.cmdOK.Font = new System.Drawing.Font("Tahoma", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((System.Byte)(0)));
      this.cmdOK.Location = new System.Drawing.Point(352, 520);
      this.cmdOK.Name = "cmdOK";
      this.cmdOK.TabIndex = 23;
      this.cmdOK.Text = "&OK";
      this.cmdOK.Click += new System.EventHandler(this.cmdOK_Click);
      // 
      // cmdParse
      // 
      this.cmdParse.Font = new System.Drawing.Font("Tahoma", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((System.Byte)(0)));
      this.cmdParse.Location = new System.Drawing.Point(440, 320);
      this.cmdParse.Name = "cmdParse";
      this.cmdParse.TabIndex = 24;
      this.cmdParse.Text = "&Parse";
      this.cmdParse.Click += new System.EventHandler(this.cmdParse_Click);
      // 
      // rtbResults
      // 
      this.rtbResults.Location = new System.Drawing.Point(8, 352);
      this.rtbResults.Name = "rtbResults";
      this.rtbResults.Size = new System.Drawing.Size(512, 160);
      this.rtbResults.TabIndex = 25;
      this.rtbResults.Text = "";
      // 
      // Analyse
      // 
      this.AcceptButton = this.cmdParse;
      this.AutoScaleBaseSize = new System.Drawing.Size(5, 13);
      this.ClientSize = new System.Drawing.Size(528, 551);
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
    }

    private void chkCSV_CheckedChanged(object sender, System.EventArgs e)
    {
      this.txtCSV.Visible = this.cmdCSVBrowse.Visible = this.chkCSV.Checked;    
    }

    private void chkXML_CheckedChanged(object sender, System.EventArgs e)
    {
      this.txtXML.Visible = this.cmdXMLBrowse.Visible = this.chkXML.Checked;        
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
      tw.WriteLine("cd \"" + pf.InstallDir.DirectoryName + "\"");
      
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
        FileInfo styleCss = new FileInfo(Prefs.Preferences.InstallDir + "\\style.css");

        if (h2Html.Exists)
        {
          FileInfo repStyleCss = new FileInfo(h2Html.Directory.FullName + "\\style.css");
          if (!repStyleCss.Exists) styleCss.CopyTo(repStyleCss.FullName, false);
          System.Diagnostics.Process.Start(h2Html.FullName);
        }
      }
    }
  }
}