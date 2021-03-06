/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 * Power Software License Generator (.net)
 * Copyright (c) 2004,2008,2009 PowerSoftware.com
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  11-Oct-05    301 : File created.
 * CAM  05-Nov-06    301 : Added ASP (omission).
 * CAM  28-Jun-07    314 : Added Ericsson IDL.
 * CAM  17-Juj-07    316 : Added VHDL.
 * CAM  30-Nov-07    324 : Added JSP, XML and 'Select All'.
 * CAM  27-Sep-08    1000 : Upgraded to include Classic licensing options.
 * CAM  26-Mar-09    10404 : Added Assembler (AY), Python (PY), JavaScript (JT) and HTML (HT).
 * CAM  24-Jun-2009  10448 : Added CSS Stylesheet (CS), Fortran (FT), Ruby (RB), Shell Script (SH), Text (TX) and Windows Batch File (WB).
 * CAM  27-Jun-2009  10448 : Renamed CSS Stylesheet CS to SS.
 * CAM  10-Dec-2009  10508 : Added PowerBuilder (PB).
 * CAM  18-Jun-2011  10963 : Added Intel languages UC (UC) and MMP (MP).
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

using System;
using System.Drawing;
using System.Collections;
using System.Windows.Forms;
using System.IO;
using System.Diagnostics;
using System.Threading;

using PowerSoftware.Tools.Licensing.Hephaestus;

namespace PowerSoftware.Tools.Licensing.LicGen
{
  /// <summary>
  /// Power Software License Generator.
  /// </summary>
  public partial class FormLicGen : System.Windows.Forms.Form
  {
    FormOptions _opt;

    private string LICENSE_FILE = "license.dat";
    private string FLEXLM = "lmcrypt.exe";
    private int MAX_LIC_LINE_LEN = 45;
    private int HORZ_INC = 24;

    private ArrayList _chkProds;
    private ArrayList _txtQtys;
    private ArrayList _chkProdsClassic;
    private ArrayList _txtQtysClassic;
    private FileInfo _licenseDat;

    public FormLicGen()
    {
      InitializeComponent();
      CreateProductOptions();
      RefreshControls();
      _opt = new FormOptions();
      SetLicenseStyleOptions();
    }

    private void RefreshControls()
    {
      bool blnDate = true;
      bool blnNumLic = true;

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
      _chkProds = new ArrayList();
      _txtQtys = new ArrayList();
      _chkProds.Add(this.chkProd);
      _txtQtys.Add(this.txtQty);

      _chkProdsClassic = new ArrayList();
      _txtQtysClassic = new ArrayList();
      _chkProdsClassic.Add(chkClassic);
      _txtQtysClassic.Add(txtClassic);

      foreach (Feature prod in FeatureList.GetFullFeatureList())
      {
        AddProduct(prod);
      }
    }

    private void AddProduct(Feature prod)
    {
      ArrayList chk = _chkProds;
      ArrayList txt = _txtQtys;

      if (prod.Legacy)
      {
        chk = _chkProdsClassic;
        txt = _txtQtysClassic;
      }

      CheckBox cb = (CheckBox)chk[0];
      TextBox tb;

      if (cb.Text.Equals("Start"))
      {
        cb.Text = prod.Code;
        ToolTip1.SetToolTip(cb, prod.Name);
        cb.Tag = prod;
      }
      else
      {
        cb = new CheckBox();
        tb = new TextBox();

        this.fmeProds.Controls.Add(cb);
        this.fmeProds.Controls.Add(tb);

        CheckBox cb1 = (CheckBox)chk[chk.Count - 1];
        TextBox tb1 = (TextBox)txt[txt.Count - 1];

        cb.Text = prod.Code;
        ToolTip1.SetToolTip(cb, prod.Name);
        cb.Tag = prod;

        cb.Location = new Point(cb1.Left, cb1.Top + HORZ_INC);
        cb.Size = new Size(cb1.Width, cb1.Height);
        cb.Visible = true;
        cb.Font = new System.Drawing.Font("Tahoma", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((System.Byte)(0)));

        tb.Location = new Point(tb1.Left, tb1.Top + HORZ_INC);
        tb.Size = new Size(tb1.Width, tb1.Height);
        tb.Visible = true;
        tb.Font = new System.Drawing.Font("Tahoma", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((System.Byte)(0)));

        if (!prod.Legacy)
        {
          this.fmeProds.Height += HORZ_INC;
          this.Height += HORZ_INC;
        }

        chk.Add(cb);
        txt.Add(tb);
      }
    }

    protected string FLEXlmDate()
    {
      DateTime dt = dtpDate.Value;
      return dt.ToString("dd-MMM-yyyy").ToLower();
    }

    public string LicenseString()
    {
      string rval = "";

      if (optLicFloat.Checked)
      {
        rval = "SERVER " + txtName.Text + " " + cmbHostid.Text + (char)13 + (char)10 + "VENDOR KRAKATAU" + (char)13 + (char)10;
      }

      rval += Features(_chkProds, _txtQtys);
      rval += Features(_chkProdsClassic, _txtQtysClassic);

      return rval;
    }

    protected string Features(ArrayList prods, ArrayList qtys)
    {
      string rval = String.Empty;

      for (int i = 0; i < prods.Count; i++)
      {
        CheckBox cb = ((CheckBox)prods[i]);
        TextBox tb = ((TextBox)qtys[i]);

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

    protected void SetLicenseStyleOptions()
    {
      optLicFloat.Visible = (!_tsbHeph.Checked);
      if (_tsbHeph.Checked && optLicFloat.Checked) optLicTimed.Checked = true;
    }

    protected void Generate()
    {
      txtOutput.Text = "";
      _licenseDat = new FileInfo(_opt.LicenseFilePath + "\\" + LICENSE_FILE);

      if (_tsbHeph.Checked)
      {
        HephaestusGenerate();
      }
      else
      {
        FlexGenerate();
      }
    }

    protected void HephaestusGenerate()
    {
      LicenseFile lf = new LicenseFile(_licenseDat);
      if (optLicTimed.Checked)
      {
        lf.ExpiryDate = dtpDate.Value;
      }
      else if (optLicHost.Checked)
      {
        lf.HostName = txtName.Text;
      }

      foreach (CheckBox chk in _chkProds)
      {
        if (chk.Checked && chk.Tag != null && chk.Tag is Feature)
        {
          lf.Features.Add((Feature)chk.Tag);
        }
      }

      lf.Save();
      DisplayLicenseFileContents(false);
    }

    protected void FlexGenerate()
    {      
      Refresh();

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

      DisplayLicenseFileContents(true);
      
      Refresh();
    }

    protected void DisplayLicenseFileContents(bool chop)
    {      
      TextReader tr = null;
      tr = new StreamReader(_licenseDat.FullName);

      string line, line2 = null;
      string tab = "" + (char)9;

      while ((line = tr.ReadLine()) != null)
      {
        line = line.Trim();

        if (chop)
        {
          if (line.EndsWith("\\"))
          {
            if ((line2 = tr.ReadLine()) != null)
            {
              if (line2.StartsWith(tab))
              {
                line2 = line2.Substring(1, line2.Length - 1);
                line = line.Substring(0, line.Length - 1) + " " + line2.Trim();
              }
            }
          }
          txtOutput.Text += ChopUp(line);
        }
        else
        {
          txtOutput.Text += line + (char)13 + (char)10;
        }        
      }

      tr.Close();
    }

    protected string ChopUp(string strLine)
    {
      string rval = "";

      if (strLine.Length > MAX_LIC_LINE_LEN)
      {
        int p = MAX_LIC_LINE_LEN;
        string ch = strLine.Substring(p, 1);
        while (p > 1 && !ch.Equals(" "))
        {
          ch = strLine.Substring(--p, 1);
        }

        rval = strLine.Substring(0, p) + " \\ " + (char)13 + (char)10 + ChopUp(strLine.Substring(p, strLine.Length - p).Trim());
      }
      else
      {
        rval = strLine.Trim() + (char)13 + (char)10;
      }

      return rval;
    }

    private void chkAll_CheckedChanged(object sender, System.EventArgs e)
    {
      CheckAll(_chkProds, chkAll);
    }

    private void chkAllClassic_CheckedChanged(object sender, EventArgs e)
    {
      CheckAll(_chkProdsClassic, chkAllClassic);
    }

    protected void CheckAll(ArrayList chkList, CheckBox chk)
    {
      for (int i = 0; i < chkList.Count; i++)
      {
        CheckBox cb = ((CheckBox)chkList[i]);
        cb.Checked = chk.Checked;
      }
    }

    private void exitToolStripMenuItem_Click(object sender, EventArgs e)
    {
      Application.Exit();
    }

    private void _tsbExit_Click(object sender, EventArgs e)
    {
      Application.Exit();
    }

    private void generateToolStripMenuItem_Click(object sender, EventArgs e)
    {
      Generate();
    }

    private void _tsbGenerate_Click(object sender, EventArgs e)
    {
      Generate();
    }

    private void optionsToolStripMenuItem_Click(object sender, EventArgs e)
    {
      _opt.ShowDialog(this);
    }

    private void _tsbOptions_Click(object sender, EventArgs e)
    {
      _opt.ShowDialog(this);
    }

    private void AboutLicenseGenerator(object sender, EventArgs e)
    {
      MessageBox.Show(this,
        String.Format("PowerSoftware.com License Generator\n" +
        "Version {0}\n\n" +
        "by Craig McKay <craig.mckay@powersoftware.com> 01-Oct-2011\n\n" +
        "Copyright (c) 2011 PowerSoftware.com", Application.ProductVersion), "About PowerSoftware.com License Generator",
        MessageBoxButtons.OK, MessageBoxIcon.Information);
    }

    private void HephaestusStateChanged(object sender, EventArgs e)
    {
      SetLicenseStyleOptions();
    }
  }
}
