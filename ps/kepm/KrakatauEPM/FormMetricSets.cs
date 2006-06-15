/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 * Krakatau Essential PM (KEPM)
 * Copyright (c) 2004-2006 Power Software
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * Dialog to maintain Metric Sets.
 *
 * $Id: frmHelpAbout.cs 151 2006-06-08 22:17:10Z craig $
 * 
 * Who  When       Why
 * CAM  13-Jun-06   258 : File created.
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

using System;
using System.Drawing;
using System.Collections;
using System.ComponentModel;
using System.Windows.Forms;

namespace KrakatauEPM
{
	/// <summary>
	/// Summary description for FormMetricSets.
	/// </summary>
	public class FormMetricSets : System.Windows.Forms.Form
	{
    private System.Windows.Forms.ToolBar tlbMetricSets;
    private System.Windows.Forms.ImageList imlMetricSets;
    private System.Windows.Forms.ToolBarButton tbbNew;
    private System.Windows.Forms.ToolBarButton tbbEdit;
    private System.Windows.Forms.ToolBarButton tbbDel;
    private System.Windows.Forms.Button btnOK;
    private System.Windows.Forms.ListView livMetricSets;
    private System.Windows.Forms.ImageList imlListView;
    private System.ComponentModel.IContainer components;

		public FormMetricSets(IEnumerator metricSets)
		{
			InitializeComponent();

      while (metricSets.MoveNext()) 
      {
        MetricSet ms = (MetricSet) metricSets.Current;
        ListViewItem lvi = new MetricSetItem(ms);        
        this.livMetricSets.Items.Add(lvi);
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

    private void btnOK_Click(object sender, System.EventArgs e)
    {
      this.Dispose();
    }

    private void tlbMetricSets_ButtonClick(object sender, System.Windows.Forms.ToolBarButtonClickEventArgs e)
    {
      if (e.Button == tbbNew) 
      {
        MetricSetItem msi = new MetricSetItem();
        this.livMetricSets.Items.Add(msi);

        FormMetricSet mset = new FormMetricSet(msi);
        mset.ShowDialog(this);
      }
    }

    private void livMetricSets_ItemActivate(object sender, System.EventArgs e)
    {
      MetricSetItem msi = (MetricSetItem)this.livMetricSets.FocusedItem;
      FormMetricSet mset = new FormMetricSet(msi);
      mset.ShowDialog(this);
      msi.RefreshSet();
    }

		#region Windows Form Designer generated code
		/// <summary>
		/// Required method for Designer support - do not modify
		/// the contents of this method with the code editor.
		/// </summary>
		private void InitializeComponent()
		{
      this.components = new System.ComponentModel.Container();
      System.Resources.ResourceManager resources = new System.Resources.ResourceManager(typeof(FormMetricSets));
      this.livMetricSets = new System.Windows.Forms.ListView();
      this.imlListView = new System.Windows.Forms.ImageList(this.components);
      this.tlbMetricSets = new System.Windows.Forms.ToolBar();
      this.tbbNew = new System.Windows.Forms.ToolBarButton();
      this.tbbEdit = new System.Windows.Forms.ToolBarButton();
      this.tbbDel = new System.Windows.Forms.ToolBarButton();
      this.imlMetricSets = new System.Windows.Forms.ImageList(this.components);
      this.btnOK = new System.Windows.Forms.Button();
      this.SuspendLayout();
      // 
      // livMetricSets
      // 
      this.livMetricSets.LargeImageList = this.imlListView;
      this.livMetricSets.Location = new System.Drawing.Point(8, 56);
      this.livMetricSets.Name = "livMetricSets";
      this.livMetricSets.Size = new System.Drawing.Size(456, 320);
      this.livMetricSets.TabIndex = 0;
      this.livMetricSets.ItemActivate += new System.EventHandler(this.livMetricSets_ItemActivate);
      // 
      // imlListView
      // 
      this.imlListView.ColorDepth = System.Windows.Forms.ColorDepth.Depth24Bit;
      this.imlListView.ImageSize = new System.Drawing.Size(48, 48);
      this.imlListView.ImageStream = ((System.Windows.Forms.ImageListStreamer)(resources.GetObject("imlListView.ImageStream")));
      this.imlListView.TransparentColor = System.Drawing.Color.Transparent;
      // 
      // tlbMetricSets
      // 
      this.tlbMetricSets.Appearance = System.Windows.Forms.ToolBarAppearance.Flat;
      this.tlbMetricSets.Buttons.AddRange(new System.Windows.Forms.ToolBarButton[] {
                                                                                     this.tbbNew,
                                                                                     this.tbbEdit,
                                                                                     this.tbbDel});
      this.tlbMetricSets.ButtonSize = new System.Drawing.Size(32, 32);
      this.tlbMetricSets.DropDownArrows = true;
      this.tlbMetricSets.Enabled = false;
      this.tlbMetricSets.ImageList = this.imlMetricSets;
      this.tlbMetricSets.Location = new System.Drawing.Point(0, 0);
      this.tlbMetricSets.Name = "tlbMetricSets";
      this.tlbMetricSets.ShowToolTips = true;
      this.tlbMetricSets.Size = new System.Drawing.Size(474, 44);
      this.tlbMetricSets.TabIndex = 1;
      this.tlbMetricSets.ButtonClick += new System.Windows.Forms.ToolBarButtonClickEventHandler(this.tlbMetricSets_ButtonClick);
      // 
      // tbbNew
      // 
      this.tbbNew.ImageIndex = 0;
      // 
      // tbbEdit
      // 
      this.tbbEdit.ImageIndex = 1;
      // 
      // tbbDel
      // 
      this.tbbDel.ImageIndex = 2;
      // 
      // imlMetricSets
      // 
      this.imlMetricSets.ColorDepth = System.Windows.Forms.ColorDepth.Depth24Bit;
      this.imlMetricSets.ImageSize = new System.Drawing.Size(32, 32);
      this.imlMetricSets.ImageStream = ((System.Windows.Forms.ImageListStreamer)(resources.GetObject("imlMetricSets.ImageStream")));
      this.imlMetricSets.TransparentColor = System.Drawing.SystemColors.Control;
      // 
      // btnOK
      // 
      this.btnOK.DialogResult = System.Windows.Forms.DialogResult.OK;
      this.btnOK.Font = new System.Drawing.Font("Tahoma", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((System.Byte)(0)));
      this.btnOK.Location = new System.Drawing.Point(368, 384);
      this.btnOK.Name = "btnOK";
      this.btnOK.Size = new System.Drawing.Size(96, 32);
      this.btnOK.TabIndex = 2;
      this.btnOK.Text = "&OK";
      this.btnOK.Click += new System.EventHandler(this.btnOK_Click);
      // 
      // FormMetricSets
      // 
      this.AcceptButton = this.btnOK;
      this.AutoScaleBaseSize = new System.Drawing.Size(5, 13);
      this.ClientSize = new System.Drawing.Size(474, 423);
      this.ControlBox = false;
      this.Controls.Add(this.btnOK);
      this.Controls.Add(this.tlbMetricSets);
      this.Controls.Add(this.livMetricSets);
      this.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedDialog;
      this.Icon = ((System.Drawing.Icon)(resources.GetObject("$this.Icon")));
      this.MaximizeBox = false;
      this.MinimizeBox = false;
      this.Name = "FormMetricSets";
      this.ShowInTaskbar = false;
      this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
      this.Text = "Metric Sets";
      this.ResumeLayout(false);

    }
		#endregion
	}
}
