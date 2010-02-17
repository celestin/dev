/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 * Krakatau Essential PM (KEPM)
 * Copyright (c) 2004,2009 PowerSoftware.com
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  27-Aug-2009  10484 : File created.
 * CAM  17-Feb-2010  10569 : Changed Project textboxes to lighter grey (and from Disabled to Readonly).
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using System.Windows.Forms;
using System.Collections;
using System.IO;
using System.Diagnostics;
using Microsoft.Win32;

using SourceCodeMetrics.Krakatau.Kepm.Config;
using SourceCodeMetrics.Krakatau.Kepm.Projects;
using SourceCodeMetrics.Krakatau.Kepm.Threading;
using SourceCodeMetrics.Krakatau.Kepm.Win32;

namespace SourceCodeMetrics.Krakatau.Kepm.Forms
{
  partial class FormAnalyse
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
      System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(FormAnalyse));
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
      this.txtLog = new System.Windows.Forms.TextBox();
      this.cmdLogBrowse = new System.Windows.Forms.Button();
      this.chkLog = new System.Windows.Forms.CheckBox();
      this.SuspendLayout();
      //
      // chkH2
      //
      this.chkH2.Font = new System.Drawing.Font("Tahoma", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
      this.chkH2.Location = new System.Drawing.Point(16, 128);
      this.chkH2.Name = "chkH2";
      this.chkH2.Size = new System.Drawing.Size(104, 24);
      this.chkH2.TabIndex = 0;
      this.chkH2.Text = "HTML Report";
      this.chkH2.CheckedChanged += new System.EventHandler(this.chkH2_CheckedChanged);
      //
      // txtH2
      //
      this.txtH2.Font = new System.Drawing.Font("Tahoma", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
      this.txtH2.Location = new System.Drawing.Point(128, 128);
      this.txtH2.Name = "txtH2";
      this.txtH2.Size = new System.Drawing.Size(288, 21);
      this.txtH2.TabIndex = 1;
      this.txtH2.Visible = false;
      //
      // label1
      //
      this.label1.Font = new System.Drawing.Font("Tahoma", 9.75F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
      this.label1.Location = new System.Drawing.Point(8, 96);
      this.label1.Name = "label1";
      this.label1.Size = new System.Drawing.Size(100, 23);
      this.label1.TabIndex = 2;
      this.label1.Text = "Options";
      //
      // cmdH2Browse
      //
      this.cmdH2Browse.Font = new System.Drawing.Font("Tahoma", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
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
      this.cmdCSVBrowse.Font = new System.Drawing.Font("Tahoma", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
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
      this.txtCSV.Font = new System.Drawing.Font("Tahoma", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
      this.txtCSV.Location = new System.Drawing.Point(128, 160);
      this.txtCSV.Name = "txtCSV";
      this.txtCSV.Size = new System.Drawing.Size(288, 21);
      this.txtCSV.TabIndex = 5;
      this.txtCSV.Visible = false;
      //
      // chkCSV
      //
      this.chkCSV.Font = new System.Drawing.Font("Tahoma", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
      this.chkCSV.Location = new System.Drawing.Point(16, 160);
      this.chkCSV.Name = "chkCSV";
      this.chkCSV.Size = new System.Drawing.Size(104, 24);
      this.chkCSV.TabIndex = 4;
      this.chkCSV.Text = "CSV Report";
      this.chkCSV.CheckedChanged += new System.EventHandler(this.chkCSV_CheckedChanged);
      //
      // cmdXMLBrowse
      //
      this.cmdXMLBrowse.Font = new System.Drawing.Font("Tahoma", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
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
      this.txtXML.Font = new System.Drawing.Font("Tahoma", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
      this.txtXML.Location = new System.Drawing.Point(128, 192);
      this.txtXML.Name = "txtXML";
      this.txtXML.Size = new System.Drawing.Size(288, 21);
      this.txtXML.TabIndex = 8;
      this.txtXML.Visible = false;
      //
      // chkXML
      //
      this.chkXML.Font = new System.Drawing.Font("Tahoma", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
      this.chkXML.Location = new System.Drawing.Point(16, 192);
      this.chkXML.Name = "chkXML";
      this.chkXML.Size = new System.Drawing.Size(104, 24);
      this.chkXML.TabIndex = 7;
      this.chkXML.Text = "XML Report";
      this.chkXML.CheckedChanged += new System.EventHandler(this.chkXML_CheckedChanged);
      //
      // txtMyServer
      //
      this.txtMyServer.Font = new System.Drawing.Font("Tahoma", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
      this.txtMyServer.Location = new System.Drawing.Point(128, 308);
      this.txtMyServer.Name = "txtMyServer";
      this.txtMyServer.Size = new System.Drawing.Size(144, 21);
      this.txtMyServer.TabIndex = 11;
      this.txtMyServer.Visible = false;
      //
      // chkMyServer
      //
      this.chkMyServer.Font = new System.Drawing.Font("Tahoma", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
      this.chkMyServer.Location = new System.Drawing.Point(16, 308);
      this.chkMyServer.Name = "chkMyServer";
      this.chkMyServer.Size = new System.Drawing.Size(104, 24);
      this.chkMyServer.TabIndex = 10;
      this.chkMyServer.Text = "Server";
      this.chkMyServer.CheckedChanged += new System.EventHandler(this.chkMyServer_CheckedChanged);
      //
      // label2
      //
      this.label2.Font = new System.Drawing.Font("Tahoma", 9.75F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
      this.label2.Location = new System.Drawing.Point(8, 284);
      this.label2.Name = "label2";
      this.label2.Size = new System.Drawing.Size(304, 23);
      this.label2.TabIndex = 12;
      this.label2.Text = "MySQL Server";
      //
      // txtMyUser
      //
      this.txtMyUser.Font = new System.Drawing.Font("Tahoma", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
      this.txtMyUser.Location = new System.Drawing.Point(128, 340);
      this.txtMyUser.Name = "txtMyUser";
      this.txtMyUser.Size = new System.Drawing.Size(96, 21);
      this.txtMyUser.TabIndex = 14;
      this.txtMyUser.Visible = false;
      //
      // chkMyUser
      //
      this.chkMyUser.Font = new System.Drawing.Font("Tahoma", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
      this.chkMyUser.Location = new System.Drawing.Point(16, 340);
      this.chkMyUser.Name = "chkMyUser";
      this.chkMyUser.Size = new System.Drawing.Size(104, 24);
      this.chkMyUser.TabIndex = 13;
      this.chkMyUser.Text = "Username";
      this.chkMyUser.CheckedChanged += new System.EventHandler(this.chkMyUser_CheckedChanged);
      //
      // txtMyPwd
      //
      this.txtMyPwd.Font = new System.Drawing.Font("Tahoma", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
      this.txtMyPwd.Location = new System.Drawing.Point(128, 372);
      this.txtMyPwd.Name = "txtMyPwd";
      this.txtMyPwd.PasswordChar = '*';
      this.txtMyPwd.Size = new System.Drawing.Size(96, 21);
      this.txtMyPwd.TabIndex = 16;
      this.txtMyPwd.UseSystemPasswordChar = true;
      this.txtMyPwd.Visible = false;
      //
      // chkMyPwd
      //
      this.chkMyPwd.Font = new System.Drawing.Font("Tahoma", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
      this.chkMyPwd.Location = new System.Drawing.Point(16, 372);
      this.chkMyPwd.Name = "chkMyPwd";
      this.chkMyPwd.Size = new System.Drawing.Size(104, 24);
      this.chkMyPwd.TabIndex = 15;
      this.chkMyPwd.Text = "Password";
      this.chkMyPwd.CheckedChanged += new System.EventHandler(this.chkMyPwd_CheckedChanged);
      //
      // label3
      //
      this.label3.Font = new System.Drawing.Font("Tahoma", 9.75F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
      this.label3.Location = new System.Drawing.Point(8, 8);
      this.label3.Name = "label3";
      this.label3.Size = new System.Drawing.Size(100, 23);
      this.label3.TabIndex = 17;
      this.label3.Text = "Projects";
      //
      // label4
      //
      this.label4.Font = new System.Drawing.Font("Tahoma", 8.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
      this.label4.Location = new System.Drawing.Point(16, 34);
      this.label4.Name = "label4";
      this.label4.Size = new System.Drawing.Size(80, 16);
      this.label4.TabIndex = 18;
      this.label4.Text = "New Project";
      //
      // label5
      //
      this.label5.Font = new System.Drawing.Font("Tahoma", 8.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
      this.label5.Location = new System.Drawing.Point(16, 66);
      this.label5.Name = "label5";
      this.label5.Size = new System.Drawing.Size(80, 16);
      this.label5.TabIndex = 19;
      this.label5.Text = "Old Project";
      //
      // txtNewProj
      //
      this.txtNewProj.BackColor = System.Drawing.SystemColors.InactiveCaption;
      this.txtNewProj.Location = new System.Drawing.Point(128, 32);
      this.txtNewProj.Name = "txtNewProj";
      this.txtNewProj.ReadOnly = true;
      this.txtNewProj.Size = new System.Drawing.Size(264, 20);
      this.txtNewProj.TabIndex = 20;
      //
      // txtOldProj
      //
      this.txtOldProj.BackColor = System.Drawing.SystemColors.InactiveCaption;
      this.txtOldProj.Location = new System.Drawing.Point(128, 64);
      this.txtOldProj.Name = "txtOldProj";
      this.txtOldProj.ReadOnly = true;
      this.txtOldProj.Size = new System.Drawing.Size(264, 20);
      this.txtOldProj.TabIndex = 21;
      //
      // cmdCancel
      //
      this.cmdCancel.DialogResult = System.Windows.Forms.DialogResult.Cancel;
      this.cmdCancel.Font = new System.Drawing.Font("Tahoma", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
      this.cmdCancel.Location = new System.Drawing.Point(440, 572);
      this.cmdCancel.Name = "cmdCancel";
      this.cmdCancel.Size = new System.Drawing.Size(75, 23);
      this.cmdCancel.TabIndex = 22;
      this.cmdCancel.Text = "&Cancel";
      //
      // cmdOK
      //
      this.cmdOK.DialogResult = System.Windows.Forms.DialogResult.OK;
      this.cmdOK.Font = new System.Drawing.Font("Tahoma", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
      this.cmdOK.Location = new System.Drawing.Point(352, 572);
      this.cmdOK.Name = "cmdOK";
      this.cmdOK.Size = new System.Drawing.Size(75, 23);
      this.cmdOK.TabIndex = 23;
      this.cmdOK.Text = "&OK";
      this.cmdOK.Click += new System.EventHandler(this.cmdOK_Click);
      //
      // rtbResults
      //
      this.rtbResults.Location = new System.Drawing.Point(8, 404);
      this.rtbResults.Name = "rtbResults";
      this.rtbResults.Size = new System.Drawing.Size(512, 160);
      this.rtbResults.TabIndex = 25;
      this.rtbResults.Text = "";
      //
      // cmdParse
      //
      this.cmdParse.Font = new System.Drawing.Font("Tahoma", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
      this.cmdParse.Location = new System.Drawing.Point(440, 372);
      this.cmdParse.Name = "cmdParse";
      this.cmdParse.Size = new System.Drawing.Size(75, 23);
      this.cmdParse.TabIndex = 24;
      this.cmdParse.Text = "&Parse";
      this.cmdParse.Click += new System.EventHandler(this.cmdParse_Click);
      //
      // chkMetSet
      //
      this.chkMetSet.Font = new System.Drawing.Font("Tahoma", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
      this.chkMetSet.Location = new System.Drawing.Point(16, 252);
      this.chkMetSet.Name = "chkMetSet";
      this.chkMetSet.Size = new System.Drawing.Size(104, 24);
      this.chkMetSet.TabIndex = 26;
      this.chkMetSet.Text = "Metric Set";
      this.chkMetSet.CheckedChanged += new System.EventHandler(this.chkMetSet_CheckedChanged);
      //
      // cmbMetSet
      //
      this.cmbMetSet.Font = new System.Drawing.Font("Tahoma", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
      this.cmbMetSet.Location = new System.Drawing.Point(128, 252);
      this.cmbMetSet.Name = "cmbMetSet";
      this.cmbMetSet.Size = new System.Drawing.Size(224, 21);
      this.cmbMetSet.TabIndex = 28;
      //
      // lblHelp
      //
      this.lblHelp.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(255)))), ((int)(((byte)(255)))), ((int)(((byte)(204)))));
      this.lblHelp.Font = new System.Drawing.Font("Tahoma", 9F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
      this.lblHelp.Location = new System.Drawing.Point(128, 120);
      this.lblHelp.Name = "lblHelp";
      this.lblHelp.Size = new System.Drawing.Size(360, 99);
      this.lblHelp.TabIndex = 29;
      this.lblHelp.TextAlign = System.Drawing.ContentAlignment.MiddleCenter;
      this.lblHelp.Visible = false;
      //
      // txtLog
      //
      this.txtLog.Font = new System.Drawing.Font("Tahoma", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
      this.txtLog.Location = new System.Drawing.Point(128, 222);
      this.txtLog.Name = "txtLog";
      this.txtLog.Size = new System.Drawing.Size(288, 21);
      this.txtLog.TabIndex = 31;
      this.txtLog.Visible = false;
      //
      // cmdLogBrowse
      //
      this.cmdLogBrowse.Font = new System.Drawing.Font("Tahoma", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
      this.cmdLogBrowse.Location = new System.Drawing.Point(424, 222);
      this.cmdLogBrowse.Name = "cmdLogBrowse";
      this.cmdLogBrowse.Size = new System.Drawing.Size(64, 21);
      this.cmdLogBrowse.TabIndex = 32;
      this.cmdLogBrowse.Text = "&Browse";
      this.cmdLogBrowse.Visible = false;
      this.cmdLogBrowse.Click += new System.EventHandler(this.cmdLogBrowse_Click);
      //
      // chkLog
      //
      this.chkLog.Font = new System.Drawing.Font("Tahoma", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
      this.chkLog.Location = new System.Drawing.Point(16, 222);
      this.chkLog.Name = "chkLog";
      this.chkLog.Size = new System.Drawing.Size(104, 24);
      this.chkLog.TabIndex = 30;
      this.chkLog.Text = "Logfile";
      this.chkLog.CheckedChanged += new System.EventHandler(this.chkLog_CheckedChanged);
      //
      // FormAnalyse
      //
      this.AcceptButton = this.cmdParse;
      this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
      this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
      this.CancelButton = this.cmdCancel;
      this.ClientSize = new System.Drawing.Size(528, 605);
      this.Controls.Add(this.txtLog);
      this.Controls.Add(this.cmdLogBrowse);
      this.Controls.Add(this.chkLog);
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
      this.Name = "FormAnalyse";
      this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
      this.Text = "Analyse";
      this.ResumeLayout(false);
      this.PerformLayout();

    }

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
    private TextBox txtLog;
    private Button cmdLogBrowse;
    private CheckBox chkLog;

    #endregion
  }
}
