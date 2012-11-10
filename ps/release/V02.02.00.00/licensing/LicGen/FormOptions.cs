/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 * EPM License Generator (.net)
 * Copyright (c) 2004-2006 PowerSoftware.com
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * Options dialog
 *
 * $Id$
 *
 * Who  When       Why
 * CAM  05-Nov-06   301 : File created.
 * CAM  27-Sep-08  1000 : Upgraded to include Classic licensing options.
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

using System;
using System.Drawing;
using System.Collections;
using System.ComponentModel;
using System.Windows.Forms;

namespace PowerSoftware.Tools.Licensing.LicGen
{
  /// <summary>
  /// Summary description for Options.
  /// </summary>
  public class FormOptions : Form
  {
    private System.Windows.Forms.Button btnBrowseDat;
    private System.Windows.Forms.TextBox txtPathDat;
    private System.Windows.Forms.Button btnOK;
    private System.Windows.Forms.Button btnCancel;
    private System.Windows.Forms.Label label1;
    private System.Windows.Forms.FolderBrowserDialog fbdDat;

    private Microsoft.Win32.RegistryKey _regKey;
    /// <summary>
    /// Required designer variable.
    /// </summary>
    private System.ComponentModel.Container components = null;

    public FormOptions()
    {
      //
      // Required for Windows Form Designer support
      //
      InitializeComponent();
      _regKey = Application.UserAppDataRegistry;

      object path = _regKey.GetValue("License Path");
      if (path != null)
      {
        this.LicenseFilePath = path.ToString();
      }
      else
      {
        this.LicenseFilePath = Application.UserAppDataPath.ToString();
      }
    }

    public string LicenseFilePath
    {
      get
      {
        return this.txtPathDat.Text;
      }

      set
      {
        this.txtPathDat.Text = value;
        _regKey.SetValue("License Path", this.txtPathDat.Text);
      }
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
      System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(FormOptions));
      this.fbdDat = new System.Windows.Forms.FolderBrowserDialog();
      this.btnBrowseDat = new System.Windows.Forms.Button();
      this.txtPathDat = new System.Windows.Forms.TextBox();
      this.btnOK = new System.Windows.Forms.Button();
      this.btnCancel = new System.Windows.Forms.Button();
      this.label1 = new System.Windows.Forms.Label();
      this.SuspendLayout();
      // 
      // fbdDat
      // 
      this.fbdDat.Description = "Select location for license.dat to be saved";
      // 
      // btnBrowseDat
      // 
      this.btnBrowseDat.Font = new System.Drawing.Font("Tahoma", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
      this.btnBrowseDat.Location = new System.Drawing.Point(392, 24);
      this.btnBrowseDat.Name = "btnBrowseDat";
      this.btnBrowseDat.Size = new System.Drawing.Size(64, 21);
      this.btnBrowseDat.TabIndex = 0;
      this.btnBrowseDat.Text = "&Browse";
      this.btnBrowseDat.Click += new System.EventHandler(this.btnBrowseDat_Click);
      // 
      // txtPathDat
      // 
      this.txtPathDat.Enabled = false;
      this.txtPathDat.Font = new System.Drawing.Font("Tahoma", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
      this.txtPathDat.Location = new System.Drawing.Point(8, 24);
      this.txtPathDat.Name = "txtPathDat";
      this.txtPathDat.Size = new System.Drawing.Size(376, 21);
      this.txtPathDat.TabIndex = 0;
      // 
      // btnOK
      // 
      this.btnOK.Font = new System.Drawing.Font("Tahoma", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
      this.btnOK.Location = new System.Drawing.Point(296, 120);
      this.btnOK.Name = "btnOK";
      this.btnOK.Size = new System.Drawing.Size(75, 23);
      this.btnOK.TabIndex = 2;
      this.btnOK.Text = "&OK";
      this.btnOK.Click += new System.EventHandler(this.btnOK_Click);
      // 
      // btnCancel
      // 
      this.btnCancel.DialogResult = System.Windows.Forms.DialogResult.Cancel;
      this.btnCancel.Font = new System.Drawing.Font("Tahoma", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
      this.btnCancel.Location = new System.Drawing.Point(376, 120);
      this.btnCancel.Name = "btnCancel";
      this.btnCancel.Size = new System.Drawing.Size(75, 23);
      this.btnCancel.TabIndex = 3;
      this.btnCancel.Text = "&Cancel";
      // 
      // label1
      // 
      this.label1.Font = new System.Drawing.Font("Tahoma", 8.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
      this.label1.Location = new System.Drawing.Point(8, 8);
      this.label1.Name = "label1";
      this.label1.Size = new System.Drawing.Size(264, 23);
      this.label1.TabIndex = 4;
      this.label1.Text = "Folder to save license.dat";
      // 
      // EPMOptions
      // 
      this.AcceptButton = this.btnOK;
      this.AutoScaleBaseSize = new System.Drawing.Size(5, 13);
      this.CancelButton = this.btnCancel;
      this.ClientSize = new System.Drawing.Size(464, 157);
      this.Controls.Add(this.btnCancel);
      this.Controls.Add(this.btnOK);
      this.Controls.Add(this.txtPathDat);
      this.Controls.Add(this.btnBrowseDat);
      this.Controls.Add(this.label1);
      this.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedDialog;
      this.Icon = ((System.Drawing.Icon)(resources.GetObject("$this.Icon")));
      this.MaximizeBox = false;
      this.MinimizeBox = false;
      this.Name = "EPMOptions";
      this.Text = "Options";
      this.ResumeLayout(false);
      this.PerformLayout();

    }
    #endregion

    private void btnOK_Click(object sender, System.EventArgs e)
    {
      this.Close();
    }

    private void btnBrowseDat_Click(object sender, System.EventArgs e)
    {
      if (fbdDat.ShowDialog(this) != DialogResult.Cancel)
      {
        this.LicenseFilePath = fbdDat.SelectedPath.ToString();
      }
    }
  }
}
