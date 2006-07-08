/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 * Krakatau Essential PM (KEPM)
 * Copyright (c) 2004-2006 Power Software
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * New Project Wizard (Dialog)
 *
 * $Id$
 * 
 * Who  When       Why
 * CAM  11-Oct-05   152 : Added to Source Safe.
 * CAM  24-Jan-06   179 : Project Title limited to 30 chars, Project Filename box readonly.
 * CAM  08-Jun-06   243 : Remember selected file types.
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

using System;
using System.IO;
using System.Drawing;
using System.Collections;
using System.ComponentModel;
using System.Windows.Forms;

namespace KrakatauEPM
{
	/// <summary>
  /// New Project Wizard Form.  Takes the user through the steps required to
  /// define a new project.
  /// </summary>
	public class NewProject : System.Windows.Forms.Form
	{
    private System.Windows.Forms.Label label1;
    private System.Windows.Forms.TextBox txtTitle;
    private System.Windows.Forms.Label label2;
    private System.Windows.Forms.DateTimePicker dtpSnapshot;
    private System.Windows.Forms.FolderBrowserDialog fbdBase;
    private System.Windows.Forms.Label label3;
    private System.Windows.Forms.Button cmdBrowse;
    private System.Windows.Forms.TextBox txtBase;
    private System.Windows.Forms.Button cmdOK;
    private System.Windows.Forms.Button cmdCancel;
		private System.ComponentModel.Container components = null;
    private System.Windows.Forms.CheckedListBox clbFileTypes;
    private System.Windows.Forms.Label label4;
    private Project _project = null;
    private System.Windows.Forms.Label label5;
    private System.Windows.Forms.Button cmdSaveAs;
    private System.Windows.Forms.TextBox txtProj;
    private System.Windows.Forms.SaveFileDialog sfdProj;
    private System.Windows.Forms.Label label6;

		public NewProject(): this(new Project())
		{
		}

    public NewProject(Project p) 
    {
      InitializeComponent();
      this.AcceptButton = this.cmdOK;
      this._project = p;

      if (_project.ProjectFile != null )
      {
        this.txtProj.Text = _project.ProjectFile.FullName;
      }     
      this.txtTitle.Text = _project.Title;
      this.dtpSnapshot.Value = _project.Snapshot;
      this.txtBase.Text = _project.Basedir;

      this.clbFileTypes.Items.AddRange(XmlConfig.Config.Extensions());
      for (int i=0; i<this.clbFileTypes.Items.Count; i++)
      {
        this.clbFileTypes.SetItemChecked(i, true);
      }

      _project.ReadExtensions(this.clbFileTypes);
    }

		protected override void Dispose( bool disposing )
		{
			if( disposing )
			{
				if(components != null)
				{
					components.Dispose();
				}
			}
		}

		#region Windows Form Designer generated code
		/// <summary>
		/// Required method for Designer support - do not modify
		/// the contents of this method with the code editor.
		/// </summary>
		private void InitializeComponent()
		{
      System.Resources.ResourceManager resources = new System.Resources.ResourceManager(typeof(NewProject));
      this.label1 = new System.Windows.Forms.Label();
      this.txtTitle = new System.Windows.Forms.TextBox();
      this.label2 = new System.Windows.Forms.Label();
      this.dtpSnapshot = new System.Windows.Forms.DateTimePicker();
      this.fbdBase = new System.Windows.Forms.FolderBrowserDialog();
      this.txtBase = new System.Windows.Forms.TextBox();
      this.label3 = new System.Windows.Forms.Label();
      this.cmdBrowse = new System.Windows.Forms.Button();
      this.cmdOK = new System.Windows.Forms.Button();
      this.cmdCancel = new System.Windows.Forms.Button();
      this.clbFileTypes = new System.Windows.Forms.CheckedListBox();
      this.label4 = new System.Windows.Forms.Label();
      this.cmdSaveAs = new System.Windows.Forms.Button();
      this.txtProj = new System.Windows.Forms.TextBox();
      this.label5 = new System.Windows.Forms.Label();
      this.sfdProj = new System.Windows.Forms.SaveFileDialog();
      this.label6 = new System.Windows.Forms.Label();
      this.SuspendLayout();
      // 
      // label1
      // 
      this.label1.Font = new System.Drawing.Font("Tahoma", 8.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((System.Byte)(0)));
      this.label1.Location = new System.Drawing.Point(10, 11);
      this.label1.Name = "label1";
      this.label1.Size = new System.Drawing.Size(100, 24);
      this.label1.TabIndex = 0;
      this.label1.Text = "Project Title";
      // 
      // txtTitle
      // 
      this.txtTitle.Location = new System.Drawing.Point(112, 8);
      this.txtTitle.MaxLength = 30;
      this.txtTitle.Name = "txtTitle";
      this.txtTitle.Size = new System.Drawing.Size(136, 20);
      this.txtTitle.TabIndex = 1;
      this.txtTitle.Text = "";
      this.txtTitle.TextChanged += new System.EventHandler(this.txtTitle_TextChanged);
      // 
      // label2
      // 
      this.label2.Font = new System.Drawing.Font("Tahoma", 8.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((System.Byte)(0)));
      this.label2.Location = new System.Drawing.Point(8, 43);
      this.label2.Name = "label2";
      this.label2.Size = new System.Drawing.Size(100, 24);
      this.label2.TabIndex = 2;
      this.label2.Text = "Snapshot Date";
      // 
      // dtpSnapshot
      // 
      this.dtpSnapshot.CustomFormat = "dd-MMM-yyyy";
      this.dtpSnapshot.Font = new System.Drawing.Font("Tahoma", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((System.Byte)(0)));
      this.dtpSnapshot.Format = System.Windows.Forms.DateTimePickerFormat.Custom;
      this.dtpSnapshot.Location = new System.Drawing.Point(112, 40);
      this.dtpSnapshot.Name = "dtpSnapshot";
      this.dtpSnapshot.Size = new System.Drawing.Size(112, 21);
      this.dtpSnapshot.TabIndex = 4;
      // 
      // fbdBase
      // 
      this.fbdBase.Description = "Locate the base directory, the starting point in the folder tree, for your projec" +
        "t source files";
      this.fbdBase.ShowNewFolderButton = false;
      // 
      // txtBase
      // 
      this.txtBase.Location = new System.Drawing.Point(112, 72);
      this.txtBase.Name = "txtBase";
      this.txtBase.Size = new System.Drawing.Size(256, 20);
      this.txtBase.TabIndex = 6;
      this.txtBase.Text = "";
      this.txtBase.TextChanged += new System.EventHandler(this.txtBase_TextChanged);
      // 
      // label3
      // 
      this.label3.Font = new System.Drawing.Font("Tahoma", 8.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((System.Byte)(0)));
      this.label3.Location = new System.Drawing.Point(8, 75);
      this.label3.Name = "label3";
      this.label3.Size = new System.Drawing.Size(100, 24);
      this.label3.TabIndex = 5;
      this.label3.Text = "Base Directory";
      // 
      // cmdBrowse
      // 
      this.cmdBrowse.Font = new System.Drawing.Font("Tahoma", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((System.Byte)(0)));
      this.cmdBrowse.Location = new System.Drawing.Point(376, 72);
      this.cmdBrowse.Name = "cmdBrowse";
      this.cmdBrowse.Size = new System.Drawing.Size(56, 20);
      this.cmdBrowse.TabIndex = 7;
      this.cmdBrowse.Text = "&Browse";
      this.cmdBrowse.Click += new System.EventHandler(this.cmdBrowse_Click);
      // 
      // cmdOK
      // 
      this.cmdOK.DialogResult = System.Windows.Forms.DialogResult.OK;
      this.cmdOK.Enabled = false;
      this.cmdOK.Font = new System.Drawing.Font("Tahoma", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((System.Byte)(0)));
      this.cmdOK.Location = new System.Drawing.Point(272, 536);
      this.cmdOK.Name = "cmdOK";
      this.cmdOK.TabIndex = 8;
      this.cmdOK.Text = "&OK";
      this.cmdOK.Click += new System.EventHandler(this.cmdOK_Click);
      // 
      // cmdCancel
      // 
      this.cmdCancel.DialogResult = System.Windows.Forms.DialogResult.Cancel;
      this.cmdCancel.Font = new System.Drawing.Font("Tahoma", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((System.Byte)(0)));
      this.cmdCancel.Location = new System.Drawing.Point(360, 536);
      this.cmdCancel.Name = "cmdCancel";
      this.cmdCancel.TabIndex = 9;
      this.cmdCancel.Text = "&Cancel";
      // 
      // clbFileTypes
      // 
      this.clbFileTypes.Location = new System.Drawing.Point(112, 104);
      this.clbFileTypes.Name = "clbFileTypes";
      this.clbFileTypes.Size = new System.Drawing.Size(320, 379);
      this.clbFileTypes.TabIndex = 10;
      // 
      // label4
      // 
      this.label4.Font = new System.Drawing.Font("Tahoma", 8.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((System.Byte)(0)));
      this.label4.Location = new System.Drawing.Point(8, 104);
      this.label4.Name = "label4";
      this.label4.Size = new System.Drawing.Size(100, 24);
      this.label4.TabIndex = 11;
      this.label4.Text = "File Types";
      // 
      // cmdSaveAs
      // 
      this.cmdSaveAs.Font = new System.Drawing.Font("Tahoma", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((System.Byte)(0)));
      this.cmdSaveAs.Location = new System.Drawing.Point(376, 496);
      this.cmdSaveAs.Name = "cmdSaveAs";
      this.cmdSaveAs.Size = new System.Drawing.Size(56, 20);
      this.cmdSaveAs.TabIndex = 14;
      this.cmdSaveAs.Text = "&Save As";
      this.cmdSaveAs.Click += new System.EventHandler(this.cmdSaveAs_Click);
      // 
      // txtProj
      // 
      this.txtProj.Location = new System.Drawing.Point(112, 496);
      this.txtProj.Name = "txtProj";
      this.txtProj.ReadOnly = true;
      this.txtProj.Size = new System.Drawing.Size(256, 20);
      this.txtProj.TabIndex = 13;
      this.txtProj.Text = "";
      this.txtProj.TextChanged += new System.EventHandler(this.txtProj_TextChanged);
      // 
      // label5
      // 
      this.label5.Font = new System.Drawing.Font("Tahoma", 8.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((System.Byte)(0)));
      this.label5.Location = new System.Drawing.Point(8, 499);
      this.label5.Name = "label5";
      this.label5.Size = new System.Drawing.Size(100, 24);
      this.label5.TabIndex = 12;
      this.label5.Text = "Project File";
      // 
      // sfdProj
      // 
      this.sfdProj.DefaultExt = "txt";
      this.sfdProj.Filter = "KEPM Project files|*.txt";
      this.sfdProj.Title = "Save Project File As...";
      // 
      // label6
      // 
      this.label6.Font = new System.Drawing.Font("Tahoma", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((System.Byte)(0)));
      this.label6.Location = new System.Drawing.Point(256, 10);
      this.label6.Name = "label6";
      this.label6.Size = new System.Drawing.Size(100, 24);
      this.label6.TabIndex = 15;
      this.label6.Text = "(30 characters)";
      // 
      // NewProject
      // 
      this.AcceptButton = this.cmdOK;
      this.AutoScaleBaseSize = new System.Drawing.Size(5, 13);
      this.ClientSize = new System.Drawing.Size(448, 573);
      this.Controls.Add(this.label6);
      this.Controls.Add(this.cmdSaveAs);
      this.Controls.Add(this.txtProj);
      this.Controls.Add(this.label5);
      this.Controls.Add(this.label4);
      this.Controls.Add(this.clbFileTypes);
      this.Controls.Add(this.cmdCancel);
      this.Controls.Add(this.cmdOK);
      this.Controls.Add(this.cmdBrowse);
      this.Controls.Add(this.txtBase);
      this.Controls.Add(this.label3);
      this.Controls.Add(this.dtpSnapshot);
      this.Controls.Add(this.label2);
      this.Controls.Add(this.txtTitle);
      this.Controls.Add(this.label1);
      this.Icon = ((System.Drawing.Icon)(resources.GetObject("$this.Icon")));
      this.MaximumSize = new System.Drawing.Size(456, 600);
      this.MinimumSize = new System.Drawing.Size(456, 600);
      this.Name = "NewProject";
      this.Text = "New Project Wizard";
      this.ResumeLayout(false);

    }
		#endregion

    private void cmdBrowse_Click(object sender, System.EventArgs e)
    {
      if (fbdBase.ShowDialog() == DialogResult.OK)
      {
        txtBase.Text = fbdBase.SelectedPath;
      }
    }

    private void cmdSaveAs_Click(object sender, System.EventArgs e)
    {      
      if (sfdProj.ShowDialog() == DialogResult.OK)
      {
        txtProj.Text = sfdProj.FileName;
      }    
    }

    private void txtTitle_TextChanged(object sender, System.EventArgs e)
    {
      DialogValidation();
    }

    private void txtBase_TextChanged(object sender, System.EventArgs e)
    {
      DialogValidation();
    }

    private void txtProj_TextChanged(object sender, System.EventArgs e)
    {
      DialogValidation();    
    }

    private void DialogValidation() 
    {
      if ((!"".Equals(this.txtTitle.Text)) && (!"".Equals(this.txtBase.Text)) &&
        (!"".Equals(this.txtProj.Text))) 
      {
        cmdOK.Enabled = true;
      } 
      else
      {
        cmdOK.Enabled = false;
      }     
    }

    private void cmdOK_Click(object sender, System.EventArgs e)
    {
      _project.ProjectFile = new FileInfo(this.txtProj.Text);
      _project.Title = this.txtTitle.Text;
      _project.Snapshot = this.dtpSnapshot.Value;
      _project.Basedir = this.txtBase.Text;      
            
      if (_project.BuildFile(this.clbFileTypes.CheckedItems)) 
      {
        MessageBox.Show(this, "Project File successfully created.", "Project Created", 
                        MessageBoxButtons.OK, MessageBoxIcon.Asterisk);
      }
    }

    public Project Project
    {
      get
      {
        return _project;
      }
      set
      {
      }
    }
	}
}
