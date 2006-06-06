/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 * Krakatau Essential PM (KEPM)
 * Copyright (c) 2004-2006 Power Software
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * Help - About Dialog
 *
 * $Id$
 * 
 * Who  When       Why
 * CAM  11-Oct-05   152 : Added to Source Safe.
 * CAM  28-Nov-05   134 : Added Version variable.
 * CAM  20-Dec-05   170 : Version 1.00.005.
 * CAM  24-Jan-06   179 : Version 1.00.006.
 * CAM  28-Jan-06   168 : Version 1.01.000.
 * CAM  13-Feb-06   185 : Version 1.01.001.
 * CAM  12-Mar-06   199 : Version 1.01.002.
 * CAM  14-Mar-06   202 : Version 1.01.003.
 * CAM  18-Mar-06   210 : Version 1.01.004.
 * CAM  23-Mar-06   220 : Version 1.01.005; EPM Version 1.09.004.
 * CAM  23-Mar-06   221 : Version 1.02.000; EPM Version 1.10.000.
 * CAM  08-Apr-06   230 : Version 1.02.001; EPM Version 1.10.001.
 * CAM  02-Jun-06   252 : Version 1.02.003; EPM Version 1.10.003.
 * CAM  06-Jun-06   255 : Version 1.02.004; EPM Version 1.10.004.
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

using System;
using System.Drawing;
using System.Collections;
using System.ComponentModel;
using System.Windows.Forms;

namespace KrakatauEPM
{
	/// <summary>
	/// Summary description for HelpAbout.
	/// </summary>
	public class HelpAbout : System.Windows.Forms.Form
	{
		private System.Windows.Forms.PictureBox pictureBox1;
		private System.Windows.Forms.Label label1;
		private System.Windows.Forms.Label label3;
		private System.Windows.Forms.Button btnClose;
		private System.Windows.Forms.LinkLabel lklProduct;
		/// <summary>
		/// Help - About Dialog giving details on the Krakatau EPM application
		/// </summary>
		private System.ComponentModel.Container components = null;
    private System.Windows.Forms.Label lblVersion;

    private String sVersion = "1.02.004";
    private System.Windows.Forms.Label lblEpmVersion;
    private String sEpmVersion = "1.10.004";

		public HelpAbout()
		{
			//
			// Required for Windows Form Designer support
			//
			InitializeComponent();
      this.lblVersion.Text = sVersion;
      this.lblEpmVersion.Text = "Powered by EPM " + sEpmVersion;

			//
			// TODO: Add any constructor code after InitializeComponent call
			//
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
      System.Resources.ResourceManager resources = new System.Resources.ResourceManager(typeof(HelpAbout));
      this.pictureBox1 = new System.Windows.Forms.PictureBox();
      this.label1 = new System.Windows.Forms.Label();
      this.lblVersion = new System.Windows.Forms.Label();
      this.btnClose = new System.Windows.Forms.Button();
      this.label3 = new System.Windows.Forms.Label();
      this.lklProduct = new System.Windows.Forms.LinkLabel();
      this.lblEpmVersion = new System.Windows.Forms.Label();
      this.SuspendLayout();
      // 
      // pictureBox1
      // 
      this.pictureBox1.Image = ((System.Drawing.Image)(resources.GetObject("pictureBox1.Image")));
      this.pictureBox1.Location = new System.Drawing.Point(96, 16);
      this.pictureBox1.Name = "pictureBox1";
      this.pictureBox1.Size = new System.Drawing.Size(200, 200);
      this.pictureBox1.TabIndex = 0;
      this.pictureBox1.TabStop = false;
      // 
      // label1
      // 
      this.label1.Font = new System.Drawing.Font("Tahoma", 14.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((System.Byte)(0)));
      this.label1.Location = new System.Drawing.Point(0, 232);
      this.label1.Name = "label1";
      this.label1.Size = new System.Drawing.Size(400, 32);
      this.label1.TabIndex = 1;
      this.label1.Text = "Krakatau Essential Project Manager";
      this.label1.TextAlign = System.Drawing.ContentAlignment.MiddleCenter;
      // 
      // lblVersion
      // 
      this.lblVersion.Font = new System.Drawing.Font("Tahoma", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((System.Byte)(0)));
      this.lblVersion.Location = new System.Drawing.Point(0, 264);
      this.lblVersion.Name = "lblVersion";
      this.lblVersion.Size = new System.Drawing.Size(400, 32);
      this.lblVersion.TabIndex = 2;
      this.lblVersion.TextAlign = System.Drawing.ContentAlignment.MiddleCenter;
      // 
      // btnClose
      // 
      this.btnClose.Font = new System.Drawing.Font("Tahoma", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((System.Byte)(0)));
      this.btnClose.Location = new System.Drawing.Point(144, 400);
      this.btnClose.Name = "btnClose";
      this.btnClose.Size = new System.Drawing.Size(112, 40);
      this.btnClose.TabIndex = 3;
      this.btnClose.Text = "&OK";
      this.btnClose.Click += new System.EventHandler(this.btnClose_Click);
      // 
      // label3
      // 
      this.label3.Font = new System.Drawing.Font("Tahoma", 10F);
      this.label3.Location = new System.Drawing.Point(0, 296);
      this.label3.Name = "label3";
      this.label3.Size = new System.Drawing.Size(400, 32);
      this.label3.TabIndex = 4;
      this.label3.Text = "Copyright (c) 2005-2006 Powersoftware.com";
      this.label3.TextAlign = System.Drawing.ContentAlignment.MiddleCenter;
      // 
      // lklProduct
      // 
      this.lklProduct.Font = new System.Drawing.Font("Tahoma", 10F);
      this.lklProduct.Location = new System.Drawing.Point(0, 328);
      this.lklProduct.Name = "lklProduct";
      this.lklProduct.Size = new System.Drawing.Size(400, 16);
      this.lklProduct.TabIndex = 5;
      this.lklProduct.TabStop = true;
      this.lklProduct.Text = "http://www.powersoftware.com/kepm/";
      this.lklProduct.TextAlign = System.Drawing.ContentAlignment.MiddleCenter;
      this.lklProduct.LinkClicked += new System.Windows.Forms.LinkLabelLinkClickedEventHandler(this.lklProduct_LinkClicked);
      // 
      // lblEpmVersion
      // 
      this.lblEpmVersion.Font = new System.Drawing.Font("Tahoma", 10F);
      this.lblEpmVersion.ForeColor = System.Drawing.SystemColors.GrayText;
      this.lblEpmVersion.Location = new System.Drawing.Point(0, 352);
      this.lblEpmVersion.Name = "lblEpmVersion";
      this.lblEpmVersion.Size = new System.Drawing.Size(400, 32);
      this.lblEpmVersion.TabIndex = 6;
      this.lblEpmVersion.Text = "Powered by EPM";
      this.lblEpmVersion.TextAlign = System.Drawing.ContentAlignment.MiddleCenter;
      // 
      // HelpAbout
      // 
      this.AutoScaleBaseSize = new System.Drawing.Size(5, 13);
      this.ClientSize = new System.Drawing.Size(400, 447);
      this.ControlBox = false;
      this.Controls.Add(this.lblEpmVersion);
      this.Controls.Add(this.lklProduct);
      this.Controls.Add(this.label3);
      this.Controls.Add(this.btnClose);
      this.Controls.Add(this.lblVersion);
      this.Controls.Add(this.label1);
      this.Controls.Add(this.pictureBox1);
      this.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedDialog;
      this.Icon = ((System.Drawing.Icon)(resources.GetObject("$this.Icon")));
      this.MaximizeBox = false;
      this.MinimizeBox = false;
      this.Name = "HelpAbout";
      this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
      this.Text = "About Krakatau EPM";
      this.ResumeLayout(false);

    }
		#endregion

		private void btnClose_Click(object sender, System.EventArgs e)
		{
			//this.Close();
      this.Dispose();
		}

		private void lklProduct_LinkClicked(object sender, System.Windows.Forms.LinkLabelLinkClickedEventArgs e)
		{
			e.Link.Visited = true;
			System.Diagnostics.Process.Start(lklProduct.Text);
		}
	}
}
