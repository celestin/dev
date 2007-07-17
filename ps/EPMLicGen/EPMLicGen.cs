/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 * EPM License Generator (.net)
 * Copyright (c) 2004-2007 SourceCodeMetrics.com
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * Lic Gen Form
 *
 * $Id$
 *
 * Who  When       Why
 * CAM  11-Oct-05   301 : File created.
 * CAM  05-Nov-06   301 : Added ASP (omission).
 * CAM  28-Jun-07   314 : Added Ericsson IDL.
 * CAM  17-Juj-07   316 : Added VHDL.
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

using System;
using System.Drawing;
using System.Collections;
using System.ComponentModel;
using System.Windows.Forms;
using System.Data;
using System.IO;
using System.Diagnostics;
using System.Threading;
using Microsoft.Win32;

namespace EPM_License_Generator
{
  /// <summary>
  /// Summary description for Form1.
  /// </summary>
  public class EPMLicGen : System.Windows.Forms.Form
  {
    public System.Windows.Forms.ComboBox cmbHostid;
    public System.Windows.Forms.TextBox txtName;
    public System.Windows.Forms.GroupBox fmeProds;
    public System.Windows.Forms.MenuItem mnuFile;
    public System.Windows.Forms.MenuItem mnuExit;
    public System.Windows.Forms.ToolTip ToolTip1;
    public System.Windows.Forms.Label lblHostid;
    public System.Windows.Forms.Label lblDesc;
    public System.Windows.Forms.MenuItem mnuOptions;
    public System.Windows.Forms.RadioButton optLicFloat;
    public System.Windows.Forms.MainMenu MainMenu1;
    public System.Windows.Forms.MenuItem mnuTools;
    public System.Windows.Forms.MenuItem mnuHelp;
    public System.Windows.Forms.MenuItem mnuAbout;
    public System.Windows.Forms.RadioButton optLicHost;
    public System.Windows.Forms.RadioButton optLicTimed;
    public System.Windows.Forms.Button cmdGenerate;
    public System.Windows.Forms.GroupBox frmLicType;
    public System.Windows.Forms.TextBox txtOutput;
    private System.Windows.Forms.DateTimePicker dtpDate;
    private System.ComponentModel.IContainer components;
    public System.Windows.Forms.TextBox txtQty;
    public System.Windows.Forms.CheckBox chkProd;
    EPMOptions _opt;

    private string LICENSE_FILE = "license.dat";
    private string FLEXLM = "lmcrypt.exe";
    //private string WINZIP32 = "C:\\Program Files\\Winzip\\Winzip32.exe ";
    //private string FRAME_SINGLE = "Select Product";
    //private string FRAME_FLOAT = "Select Products && Quantities";
    private int MAX_LIC_LINE_LEN = 45;
    private int HORZ_INC = 24;

    private ArrayList _chkProds;
    private ArrayList _txtQtys;
    private FileInfo _licenseDat;

    public EPMLicGen()
    {
      //
      // Required for Windows Form Designer support
      //
      InitializeComponent();
      CreateProductOptions();
      RefreshControls();
      _opt = new EPMOptions();
    }

    /// <summary>
    /// Clean up any resources being used.
    /// </summary>
    protected override void Dispose( bool disposing )
    {
      if( disposing )
      {
        if (components != null)
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
      this.components = new System.ComponentModel.Container();
      System.Resources.ResourceManager resources = new System.Resources.ResourceManager(typeof(EPMLicGen));
      this.cmbHostid = new System.Windows.Forms.ComboBox();
      this.txtName = new System.Windows.Forms.TextBox();
      this.fmeProds = new System.Windows.Forms.GroupBox();
      this.txtQty = new System.Windows.Forms.TextBox();
      this.chkProd = new System.Windows.Forms.CheckBox();
      this.mnuFile = new System.Windows.Forms.MenuItem();
      this.mnuExit = new System.Windows.Forms.MenuItem();
      this.ToolTip1 = new System.Windows.Forms.ToolTip(this.components);
      this.lblHostid = new System.Windows.Forms.Label();
      this.lblDesc = new System.Windows.Forms.Label();
      this.mnuOptions = new System.Windows.Forms.MenuItem();
      this.optLicFloat = new System.Windows.Forms.RadioButton();
      this.MainMenu1 = new System.Windows.Forms.MainMenu();
      this.mnuTools = new System.Windows.Forms.MenuItem();
      this.mnuHelp = new System.Windows.Forms.MenuItem();
      this.mnuAbout = new System.Windows.Forms.MenuItem();
      this.optLicHost = new System.Windows.Forms.RadioButton();
      this.optLicTimed = new System.Windows.Forms.RadioButton();
      this.cmdGenerate = new System.Windows.Forms.Button();
      this.frmLicType = new System.Windows.Forms.GroupBox();
      this.txtOutput = new System.Windows.Forms.TextBox();
      this.dtpDate = new System.Windows.Forms.DateTimePicker();
      this.fmeProds.SuspendLayout();
      this.SuspendLayout();
      //
      // cmbHostid
      //
      this.cmbHostid.BackColor = System.Drawing.SystemColors.Window;
      this.cmbHostid.Cursor = System.Windows.Forms.Cursors.Default;
      this.cmbHostid.Font = new System.Drawing.Font("Tahoma", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((System.Byte)(0)));
      this.cmbHostid.ForeColor = System.Drawing.SystemColors.WindowText;
      this.cmbHostid.Items.AddRange(new object[] {
                                                   "Any"});
      this.cmbHostid.Location = new System.Drawing.Point(304, 80);
      this.cmbHostid.Name = "cmbHostid";
      this.cmbHostid.RightToLeft = System.Windows.Forms.RightToLeft.No;
      this.cmbHostid.Size = new System.Drawing.Size(105, 21);
      this.cmbHostid.TabIndex = 25;
      this.cmbHostid.Text = "Any";
      //
      // txtName
      //
      this.txtName.AcceptsReturn = true;
      this.txtName.AutoSize = false;
      this.txtName.BackColor = System.Drawing.SystemColors.Window;
      this.txtName.Cursor = System.Windows.Forms.Cursors.IBeam;
      this.txtName.Font = new System.Drawing.Font("Tahoma", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((System.Byte)(0)));
      this.txtName.ForeColor = System.Drawing.SystemColors.WindowText;
      this.txtName.Location = new System.Drawing.Point(64, 80);
      this.txtName.MaxLength = 0;
      this.txtName.Name = "txtName";
      this.txtName.RightToLeft = System.Windows.Forms.RightToLeft.No;
      this.txtName.Size = new System.Drawing.Size(161, 21);
      this.txtName.TabIndex = 18;
      this.txtName.Text = "";
      //
      // fmeProds
      //
      this.fmeProds.BackColor = System.Drawing.SystemColors.Control;
      this.fmeProds.Controls.Add(this.txtQty);
      this.fmeProds.Controls.Add(this.chkProd);
      this.fmeProds.Font = new System.Drawing.Font("Tahoma", 8.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((System.Byte)(0)));
      this.fmeProds.ForeColor = System.Drawing.SystemColors.ControlText;
      this.fmeProds.Location = new System.Drawing.Point(8, 112);
      this.fmeProds.Name = "fmeProds";
      this.fmeProds.RightToLeft = System.Windows.Forms.RightToLeft.No;
      this.fmeProds.Size = new System.Drawing.Size(193, 57);
      this.fmeProds.TabIndex = 23;
      this.fmeProds.TabStop = false;
      this.fmeProds.Text = "&Select Products";
      //
      // txtQty
      //
      this.txtQty.AcceptsReturn = true;
      this.txtQty.AutoSize = false;
      this.txtQty.BackColor = System.Drawing.SystemColors.Window;
      this.txtQty.Cursor = System.Windows.Forms.Cursors.IBeam;
      this.txtQty.Font = new System.Drawing.Font("Tahoma", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((System.Byte)(0)));
      this.txtQty.ForeColor = System.Drawing.SystemColors.WindowText;
      this.txtQty.Location = new System.Drawing.Point(104, 24);
      this.txtQty.MaxLength = 0;
      this.txtQty.Name = "txtQty";
      this.txtQty.RightToLeft = System.Windows.Forms.RightToLeft.No;
      this.txtQty.Size = new System.Drawing.Size(57, 19);
      this.txtQty.TabIndex = 12;
      this.txtQty.Text = "";
      //
      // chkProd
      //
      this.chkProd.BackColor = System.Drawing.SystemColors.Control;
      this.chkProd.Cursor = System.Windows.Forms.Cursors.Default;
      this.chkProd.Font = new System.Drawing.Font("Tahoma", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((System.Byte)(0)));
      this.chkProd.ForeColor = System.Drawing.SystemColors.ControlText;
      this.chkProd.Location = new System.Drawing.Point(16, 24);
      this.chkProd.Name = "chkProd";
      this.chkProd.RightToLeft = System.Windows.Forms.RightToLeft.No;
      this.chkProd.Size = new System.Drawing.Size(73, 17);
      this.chkProd.TabIndex = 11;
      this.chkProd.Text = "krakatau";
      //
      // mnuFile
      //
      this.mnuFile.Index = 0;
      this.mnuFile.MenuItems.AddRange(new System.Windows.Forms.MenuItem[] {
                                                                            this.mnuExit});
      this.mnuFile.Text = "&File";
      //
      // mnuExit
      //
      this.mnuExit.Index = 0;
      this.mnuExit.Text = "E&xit";
      this.mnuExit.Click += new System.EventHandler(this.mnuExit_Click);
      //
      // lblHostid
      //
      this.lblHostid.BackColor = System.Drawing.SystemColors.Control;
      this.lblHostid.Cursor = System.Windows.Forms.Cursors.Default;
      this.lblHostid.Font = new System.Drawing.Font("Tahoma", 8.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((System.Byte)(0)));
      this.lblHostid.ForeColor = System.Drawing.SystemColors.ControlText;
      this.lblHostid.Location = new System.Drawing.Point(248, 82);
      this.lblHostid.Name = "lblHostid";
      this.lblHostid.RightToLeft = System.Windows.Forms.RightToLeft.No;
      this.lblHostid.Size = new System.Drawing.Size(49, 17);
      this.lblHostid.TabIndex = 24;
      this.lblHostid.Text = "Host &ID";
      //
      // lblDesc
      //
      this.lblDesc.BackColor = System.Drawing.SystemColors.Control;
      this.lblDesc.Cursor = System.Windows.Forms.Cursors.Default;
      this.lblDesc.Font = new System.Drawing.Font("Tahoma", 8.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((System.Byte)(0)));
      this.lblDesc.ForeColor = System.Drawing.SystemColors.ControlText;
      this.lblDesc.Location = new System.Drawing.Point(8, 82);
      this.lblDesc.Name = "lblDesc";
      this.lblDesc.RightToLeft = System.Windows.Forms.RightToLeft.No;
      this.lblDesc.Size = new System.Drawing.Size(48, 17);
      this.lblDesc.TabIndex = 21;
      this.lblDesc.Text = "&Expiry";
      //
      // mnuOptions
      //
      this.mnuOptions.Index = 0;
      this.mnuOptions.Text = "&Options";
      this.mnuOptions.Click += new System.EventHandler(this.mnuOptions_Click);
      //
      // optLicFloat
      //
      this.optLicFloat.BackColor = System.Drawing.SystemColors.Control;
      this.optLicFloat.Cursor = System.Windows.Forms.Cursors.Default;
      this.optLicFloat.Font = new System.Drawing.Font("Tahoma", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((System.Byte)(0)));
      this.optLicFloat.ForeColor = System.Drawing.SystemColors.ControlText;
      this.optLicFloat.Location = new System.Drawing.Point(328, 32);
      this.optLicFloat.Name = "optLicFloat";
      this.optLicFloat.RightToLeft = System.Windows.Forms.RightToLeft.No;
      this.optLicFloat.Size = new System.Drawing.Size(65, 17);
      this.optLicFloat.TabIndex = 17;
      this.optLicFloat.TabStop = true;
      this.optLicFloat.Text = "&Floating";
      this.optLicFloat.CheckedChanged += new System.EventHandler(this.optLicFloat_CheckedChanged);
      //
      // MainMenu1
      //
      this.MainMenu1.MenuItems.AddRange(new System.Windows.Forms.MenuItem[] {
                                                                              this.mnuFile,
                                                                              this.mnuTools,
                                                                              this.mnuHelp});
      //
      // mnuTools
      //
      this.mnuTools.Index = 1;
      this.mnuTools.MenuItems.AddRange(new System.Windows.Forms.MenuItem[] {
                                                                             this.mnuOptions});
      this.mnuTools.Text = "&Tools";
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
      // optLicHost
      //
      this.optLicHost.BackColor = System.Drawing.SystemColors.Control;
      this.optLicHost.Cursor = System.Windows.Forms.Cursors.Default;
      this.optLicHost.Font = new System.Drawing.Font("Tahoma", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((System.Byte)(0)));
      this.optLicHost.ForeColor = System.Drawing.SystemColors.ControlText;
      this.optLicHost.Location = new System.Drawing.Point(176, 32);
      this.optLicHost.Name = "optLicHost";
      this.optLicHost.RightToLeft = System.Windows.Forms.RightToLeft.No;
      this.optLicHost.Size = new System.Drawing.Size(96, 17);
      this.optLicHost.TabIndex = 16;
      this.optLicHost.TabStop = true;
      this.optLicHost.Text = "&Host-locked";
      this.optLicHost.CheckedChanged += new System.EventHandler(this.optLicHost_CheckedChanged);
      //
      // optLicTimed
      //
      this.optLicTimed.BackColor = System.Drawing.SystemColors.Control;
      this.optLicTimed.Checked = true;
      this.optLicTimed.Cursor = System.Windows.Forms.Cursors.Default;
      this.optLicTimed.Font = new System.Drawing.Font("Tahoma", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((System.Byte)(0)));
      this.optLicTimed.ForeColor = System.Drawing.SystemColors.ControlText;
      this.optLicTimed.Location = new System.Drawing.Point(24, 32);
      this.optLicTimed.Name = "optLicTimed";
      this.optLicTimed.RightToLeft = System.Windows.Forms.RightToLeft.No;
      this.optLicTimed.Size = new System.Drawing.Size(96, 17);
      this.optLicTimed.TabIndex = 15;
      this.optLicTimed.TabStop = true;
      this.optLicTimed.Text = "&Timed Expiry";
      this.optLicTimed.CheckedChanged += new System.EventHandler(this.optLicTimed_CheckedChanged);
      //
      // cmdGenerate
      //
      this.cmdGenerate.BackColor = System.Drawing.SystemColors.Control;
      this.cmdGenerate.Cursor = System.Windows.Forms.Cursors.Default;
      this.cmdGenerate.Font = new System.Drawing.Font("Tahoma", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((System.Byte)(0)));
      this.cmdGenerate.ForeColor = System.Drawing.SystemColors.ControlText;
      this.cmdGenerate.Location = new System.Drawing.Point(8, 184);
      this.cmdGenerate.Name = "cmdGenerate";
      this.cmdGenerate.RightToLeft = System.Windows.Forms.RightToLeft.No;
      this.cmdGenerate.Size = new System.Drawing.Size(409, 37);
      this.cmdGenerate.TabIndex = 19;
      this.cmdGenerate.Text = "&Generate";
      this.cmdGenerate.Click += new System.EventHandler(this.cmdGenerate_Click);
      //
      // frmLicType
      //
      this.frmLicType.BackColor = System.Drawing.SystemColors.Control;
      this.frmLicType.Font = new System.Drawing.Font("Tahoma", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((System.Byte)(0)));
      this.frmLicType.ForeColor = System.Drawing.SystemColors.ControlText;
      this.frmLicType.Location = new System.Drawing.Point(8, 8);
      this.frmLicType.Name = "frmLicType";
      this.frmLicType.RightToLeft = System.Windows.Forms.RightToLeft.No;
      this.frmLicType.Size = new System.Drawing.Size(401, 57);
      this.frmLicType.TabIndex = 22;
      this.frmLicType.TabStop = false;
      this.frmLicType.Text = "License Type";
      //
      // txtOutput
      //
      this.txtOutput.AcceptsReturn = true;
      this.txtOutput.AutoSize = false;
      this.txtOutput.BackColor = System.Drawing.Color.FromArgb(((System.Byte)(240)), ((System.Byte)(169)), ((System.Byte)(72)));
      this.txtOutput.Cursor = System.Windows.Forms.Cursors.IBeam;
      this.txtOutput.Font = new System.Drawing.Font("Tahoma", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((System.Byte)(0)));
      this.txtOutput.ForeColor = System.Drawing.SystemColors.WindowText;
      this.txtOutput.Location = new System.Drawing.Point(208, 120);
      this.txtOutput.MaxLength = 0;
      this.txtOutput.Multiline = true;
      this.txtOutput.Name = "txtOutput";
      this.txtOutput.ReadOnly = true;
      this.txtOutput.RightToLeft = System.Windows.Forms.RightToLeft.No;
      this.txtOutput.Size = new System.Drawing.Size(209, 48);
      this.txtOutput.TabIndex = 20;
      this.txtOutput.Text = "";
      //
      // dtpDate
      //
      this.dtpDate.Font = new System.Drawing.Font("Tahoma", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((System.Byte)(0)));
      this.dtpDate.Location = new System.Drawing.Point(64, 80);
      this.dtpDate.Name = "dtpDate";
      this.dtpDate.Size = new System.Drawing.Size(128, 21);
      this.dtpDate.TabIndex = 26;
      //
      // EPMLicGen
      //
      this.AutoScaleBaseSize = new System.Drawing.Size(5, 13);
      this.ClientSize = new System.Drawing.Size(424, 233);
      this.Controls.Add(this.dtpDate);
      this.Controls.Add(this.fmeProds);
      this.Controls.Add(this.lblHostid);
      this.Controls.Add(this.lblDesc);
      this.Controls.Add(this.optLicFloat);
      this.Controls.Add(this.optLicHost);
      this.Controls.Add(this.optLicTimed);
      this.Controls.Add(this.cmdGenerate);
      this.Controls.Add(this.frmLicType);
      this.Controls.Add(this.txtOutput);
      this.Controls.Add(this.cmbHostid);
      this.Controls.Add(this.txtName);
      this.Icon = ((System.Drawing.Icon)(resources.GetObject("$this.Icon")));
      this.Menu = this.MainMenu1;
      this.Name = "EPMLicGen";
      this.Text = "EPM License Generator";
      this.fmeProds.ResumeLayout(false);
      this.ResumeLayout(false);

    }
    #endregion

    /// <summary>
    /// The main entry point for the application.
    /// </summary>
    [STAThread]
    static void Main()
    {
      Application.Run(new EPMLicGen());
    }

    private void RefreshControls()
    {

      bool blnDate=true;
      bool blnNumLic=true;

      if (optLicTimed.Checked)
      {
        lblDesc.Text = "&Expiry";
        blnDate = true;
        blnNumLic = false;

      }
      else if (optLicHost.Checked)
      {
        lblDesc.Text = "H&ost";
        blnDate = false;
        blnNumLic = false;

      }
      else if (optLicFloat.Checked)
      {
        lblDesc.Text = "&Server";
        blnDate = false;
        blnNumLic = true;
      }

      dtpDate.Visible = blnDate;
      txtName.Visible = (!blnDate);
      cmbHostid.Visible = blnNumLic;
      lblHostid.Visible = blnNumLic;
      this.Refresh();
    }

    private void CreateProductOptions()
    {
      this._chkProds = new ArrayList();
      this._txtQtys = new ArrayList();

      _chkProds.Add(this.chkProd);
      _txtQtys.Add(this.txtQty);

      AddProduct("epmkr", "Krakatau EPM");
      AddProduct("epmad", "ADA");
      AddProduct("epmas", "ASP");
      AddProduct("epmcp", "C/C++");
      AddProduct("epmcs", "C# (C Sharp)");
      AddProduct("epmjv", "Java");
      AddProduct("epms1", "Oracle PL/SQL");
      AddProduct("epmpl", "Perl");
      AddProduct("epmph", "PHP");
      AddProduct("epmvb", "Visual Basic");
      AddProduct("epmid", "IDL");
      AddProduct("epmvh", "VHDL");
    }

    private void AddProduct(string strName, string strDesc)
    {
      CheckBox cb = (CheckBox) _chkProds[0];
      TextBox tb;

      if (cb.Text.Equals("krakatau"))
      {
        cb.Text = strName;
        ToolTip1.SetToolTip(cb, strDesc);
      }
      else
      {
        cb = new CheckBox();
        tb = new TextBox();

        this.fmeProds.Controls.Add(cb);
        this.fmeProds.Controls.Add(tb);

        CheckBox cb1 = (CheckBox) _chkProds[_chkProds.Count-1];
        TextBox tb1 = (TextBox) _txtQtys[_txtQtys.Count-1];

        cb.Text = strName;
        ToolTip1.SetToolTip(cb, strDesc);

        cb.Location = new Point(cb1.Left, cb1.Top + HORZ_INC);
        cb.Size = new Size(cb1.Width, cb1.Height);
        cb.Visible = true;
        cb.Font = new System.Drawing.Font("Tahoma", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((System.Byte)(0)));

        tb.Location = new Point(tb1.Left, tb1.Top + HORZ_INC);
        tb.Size = new Size(tb1.Width, tb1.Height);
        tb.Visible = true;
        tb.Font = new System.Drawing.Font("Tahoma", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((System.Byte)(0)));

        this.fmeProds.Height += HORZ_INC;
        this.cmdGenerate.Top += HORZ_INC;
        this.txtOutput.Height += HORZ_INC;
        this.Height += (HORZ_INC-2);

        _chkProds.Add(cb);
        _txtQtys.Add(tb);
      }
    }

    protected string FLEXlmDate()
    {
      DateTime dt = dtpDate.Value;
      return dt.ToString("dd-MMM-yyyy").ToLower();
    }

    public string LicenseString()
    {
      string rval="";

      if (optLicFloat.Checked)
      {
        rval = "SERVER " + txtName.Text + " " + cmbHostid.Text + (char)13 + (char)10 + "VENDOR KRAKATAU" + (char)13 + (char)10;
      }

      for (int i=0; i<_chkProds.Count; i++)
      {
        CheckBox cb = ((CheckBox)_chkProds[i]);
        TextBox tb = ((TextBox)_txtQtys[i]);

        if (cb.Checked)
        {
          if (optLicTimed.Checked)
          {
            rval += "FEATURE " + cb.Text + " KRAKATAU 1.0 " + FLEXlmDate() + " uncounted HOSTID=ANY ck=0 SIGN=0" + (char)13 + (char)10;
          }
          else if (optLicHost.Checked)
          {
            rval += "FEATURE " + cb.Text + " KRAKATAU 1.0 " + "permanent uncounted HOSTID=HOSTNAME=" + txtName.Text + " SIGN=0" + (char)13 + (char)10;
          }
          else if (optLicFloat.Checked)
          {
            rval += "FEATURE " + cb.Text + " KRAKATAU 1.0 " + "permanent " + tb.Text + " SIGN=0" + (char)13 + (char)10;
          }
        }
      }

      return rval;
    }

    private void optLicTimed_CheckedChanged(object sender, System.EventArgs e)
    {
      RefreshControls();
    }

    private void optLicHost_CheckedChanged(object sender, System.EventArgs e)
    {
      RefreshControls();
    }

    private void optLicFloat_CheckedChanged(object sender, System.EventArgs e)
    {
      RefreshControls();
    }

    private void cmdGenerate_Click(object sender, System.EventArgs e)
    {
      cmdGenerate.Enabled = txtOutput.Visible = false;
      txtOutput.Text = "";
      Refresh();

      _licenseDat = new FileInfo(_opt.LicenseFilePath + "\\" + LICENSE_FILE);

      TextWriter tw = new StreamWriter(_licenseDat.FullName, false);
      tw.WriteLine(LicenseString());
      tw.Close();

      Process process = new Process();
      process.StartInfo.UseShellExecute = false;
      process.StartInfo.RedirectStandardOutput = true;
      process.StartInfo.RedirectStandardError = true;
      process.StartInfo.CreateNoWindow = true;
      process.StartInfo.FileName = Application.StartupPath + "\\" + FLEXLM;
      process.StartInfo.Arguments = "\"" + _licenseDat.FullName + "\"";
      process.StartInfo.WorkingDirectory = Application.StartupPath;
      process.Start();

      while (!process.HasExited)
      {
        Thread.Sleep(500);
      }

      // Finished LMCRYPT
      TextReader tr = null;
      tr = new StreamReader(_licenseDat.FullName);

      string line,line2 = null;
      string tab = "" + (char)9;

      while ((line = tr.ReadLine()) != null)
      {
        line = line.Trim();
        if (line.EndsWith("\\"))
        {
          if ((line2 = tr.ReadLine()) != null)
          {
            if (line2.StartsWith(tab))
            {
              line2 = line2.Substring(1, line2.Length-1);
              line = line.Substring(0, line.Length-1) + " " + line2.Trim();
            }
          }
        }

        txtOutput.Text += ChopUp(line);
      }
      tr.Close();
      cmdGenerate.Enabled = txtOutput.Visible = true;
      Refresh();
    }

    private void mnuExit_Click(object sender, System.EventArgs e)
    {
      Application.Exit();
    }

    private void mnuOptions_Click(object sender, System.EventArgs e)
    {
      _opt.ShowDialog(this);
    }

    private void mnuAbout_Click(object sender, System.EventArgs e)
    {
      MessageBox.Show(this, "EPM License Generator (.net)\n" +
                            "Version 2.00.004\n\n" +
                            "by Craig A McKay 17-Jul-2007\n\n"+
                            "Copyright (c) 2006-2007 SourceCodeMetrics.com", "About EPM License Generator",
                            MessageBoxButtons.OK, MessageBoxIcon.Information);
    }

    protected string ChopUp(string strLine)
    {
      string rval="";

      if (strLine.Length > MAX_LIC_LINE_LEN)
      {
        int p = MAX_LIC_LINE_LEN;
        string ch = strLine.Substring(p, 1);
        while (p>1 && !ch.Equals(" "))
        {
          ch = strLine.Substring(--p, 1);
        }

        rval = strLine.Substring(0, p) + " \\ " + (char)13 + (char)10 + ChopUp(strLine.Substring(p, strLine.Length-p).Trim());
      }
      else
      {
        rval = strLine.Trim() + (char)13 + (char)10;
      }

      return rval;
    }
  }
}
