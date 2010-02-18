/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 * Krakatau Essential PM (KEPM)
 * Copyright (c) 2004,2010 PowerSoftware.com
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * Dialog to maintain Metric Sets.
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  13-Jun-06    258 : File created.
 * CAM  22-Jul-06    291 : Add tooltips for each button.
 * CAM  18-Feb-2010  10574 : Resource names tidied.
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

using System;
using System.Drawing;
using System.Collections;
using System.ComponentModel;
using System.Windows.Forms;

using SourceCodeMetrics.Krakatau.Kepm.Config;

namespace SourceCodeMetrics.Krakatau.Kepm.Forms
{
  /// <summary>
  /// Summary description for FormMetricSets.
  /// </summary>
  public class FormMetricSets : System.Windows.Forms.Form
  {
    private System.Windows.Forms.ImageList imlMetricSets;
    private System.Windows.Forms.Button btnOK;
    private System.Windows.Forms.ImageList imlListView;
    private System.Windows.Forms.ListView lsvMetricSets;
    private ToolStripContainer toolStripContainer1;
    private ToolStrip toolStrip1;
    private ToolStripButton tsbNew;
    private ToolStripButton tsbEdit;
    private ToolStripButton tsbDelete;
    private TableLayoutPanel tableLayoutPanel1;
    private System.ComponentModel.IContainer components;

    public FormMetricSets(IEnumerator metricSets)
    {
      InitializeComponent();

      while (metricSets.MoveNext())
      {
        MetricSet ms = (MetricSet)metricSets.Current;
        ListViewItem lvi = new MetricSetItem(ms);
        this.lsvMetricSets.Items.Add(lvi);
      }
    }

    /// <summary>
    /// Clean up any resources being used.
    /// </summary>
    protected override void Dispose(bool disposing)
    {
      if (disposing)
      {
        if (components != null)
        {
          components.Dispose();
        }
      }
      base.Dispose(disposing);
    }

    private void btnOK_Click(object sender, System.EventArgs e)
    {
      this.Dispose();
    }

    private void livMetricSets_ItemActivate(object sender, System.EventArgs e)
    {
      MetricSetItem msi = (MetricSetItem)lsvMetricSets.FocusedItem;
      FormMetricSet mset = new FormMetricSet(msi);
      mset.ShowDialog(this);
      XmlConfig.Config.SaveConfig();
    }

    #region Windows Form Designer generated code
    /// <summary>
    /// Required method for Designer support - do not modify
    /// the contents of this method with the code editor.
    /// </summary>
    private void InitializeComponent()
    {
      this.components = new System.ComponentModel.Container();
      System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(FormMetricSets));
      this.lsvMetricSets = new System.Windows.Forms.ListView();
      this.imlListView = new System.Windows.Forms.ImageList(this.components);
      this.imlMetricSets = new System.Windows.Forms.ImageList(this.components);
      this.btnOK = new System.Windows.Forms.Button();
      this.toolStripContainer1 = new System.Windows.Forms.ToolStripContainer();
      this.toolStrip1 = new System.Windows.Forms.ToolStrip();
      this.tsbNew = new System.Windows.Forms.ToolStripButton();
      this.tsbEdit = new System.Windows.Forms.ToolStripButton();
      this.tsbDelete = new System.Windows.Forms.ToolStripButton();
      this.tableLayoutPanel1 = new System.Windows.Forms.TableLayoutPanel();
      this.toolStripContainer1.ContentPanel.SuspendLayout();
      this.toolStripContainer1.TopToolStripPanel.SuspendLayout();
      this.toolStripContainer1.SuspendLayout();
      this.toolStrip1.SuspendLayout();
      this.tableLayoutPanel1.SuspendLayout();
      this.SuspendLayout();
      //
      // lsvMetricSets
      //
      this.lsvMetricSets.Dock = System.Windows.Forms.DockStyle.Fill;
      this.lsvMetricSets.LargeImageList = this.imlListView;
      this.lsvMetricSets.Location = new System.Drawing.Point(3, 3);
      this.lsvMetricSets.Name = "lsvMetricSets";
      this.lsvMetricSets.Size = new System.Drawing.Size(545, 363);
      this.lsvMetricSets.TabIndex = 0;
      this.lsvMetricSets.UseCompatibleStateImageBehavior = false;
      this.lsvMetricSets.ItemActivate += new System.EventHandler(this.livMetricSets_ItemActivate);
      //
      // imlListView
      //
      this.imlListView.ImageStream = ((System.Windows.Forms.ImageListStreamer)(resources.GetObject("imlListView.ImageStream")));
      this.imlListView.TransparentColor = System.Drawing.Color.Transparent;
      this.imlListView.Images.SetKeyName(0, "");
      //
      // imlMetricSets
      //
      this.imlMetricSets.ImageStream = ((System.Windows.Forms.ImageListStreamer)(resources.GetObject("imlMetricSets.ImageStream")));
      this.imlMetricSets.TransparentColor = System.Drawing.SystemColors.Control;
      this.imlMetricSets.Images.SetKeyName(0, "");
      this.imlMetricSets.Images.SetKeyName(1, "");
      this.imlMetricSets.Images.SetKeyName(2, "");
      //
      // btnOK
      //
      this.btnOK.Anchor = System.Windows.Forms.AnchorStyles.Right;
      this.btnOK.DialogResult = System.Windows.Forms.DialogResult.OK;
      this.btnOK.Font = new System.Drawing.Font("Tahoma", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
      this.btnOK.Location = new System.Drawing.Point(452, 372);
      this.btnOK.Name = "btnOK";
      this.btnOK.Size = new System.Drawing.Size(96, 32);
      this.btnOK.TabIndex = 2;
      this.btnOK.Text = "&OK";
      this.btnOK.Click += new System.EventHandler(this.btnOK_Click);
      //
      // toolStripContainer1
      //
      //
      // toolStripContainer1.ContentPanel
      //
      this.toolStripContainer1.ContentPanel.AutoScroll = true;
      this.toolStripContainer1.ContentPanel.Controls.Add(this.tableLayoutPanel1);
      this.toolStripContainer1.ContentPanel.Size = new System.Drawing.Size(551, 408);
      this.toolStripContainer1.Dock = System.Windows.Forms.DockStyle.Fill;
      this.toolStripContainer1.Location = new System.Drawing.Point(0, 0);
      this.toolStripContainer1.Name = "toolStripContainer1";
      this.toolStripContainer1.Size = new System.Drawing.Size(551, 447);
      this.toolStripContainer1.TabIndex = 3;
      this.toolStripContainer1.Text = "toolStripContainer1";
      //
      // toolStripContainer1.TopToolStripPanel
      //
      this.toolStripContainer1.TopToolStripPanel.Controls.Add(this.toolStrip1);
      //
      // toolStrip1
      //
      this.toolStrip1.Dock = System.Windows.Forms.DockStyle.None;
      this.toolStrip1.Items.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.tsbNew,
            this.tsbEdit,
            this.tsbDelete});
      this.toolStrip1.Location = new System.Drawing.Point(3, 0);
      this.toolStrip1.Name = "toolStrip1";
      this.toolStrip1.Size = new System.Drawing.Size(151, 39);
      this.toolStrip1.TabIndex = 0;
      //
      // tsbNew
      //
      this.tsbNew.DisplayStyle = System.Windows.Forms.ToolStripItemDisplayStyle.Image;
      this.tsbNew.Image = global::SourceCodeMetrics.Krakatau.Kepm.Properties.Resources.NewMetricSet;
      this.tsbNew.ImageScaling = System.Windows.Forms.ToolStripItemImageScaling.None;
      this.tsbNew.ImageTransparentColor = System.Drawing.Color.Magenta;
      this.tsbNew.Name = "tsbNew";
      this.tsbNew.Size = new System.Drawing.Size(36, 36);
      this.tsbNew.Text = "Add new Metric Set";
      this.tsbNew.Click += new System.EventHandler(this.tsbNew_Click);
      //
      // tsbEdit
      //
      this.tsbEdit.DisplayStyle = System.Windows.Forms.ToolStripItemDisplayStyle.Image;
      this.tsbEdit.Image = global::SourceCodeMetrics.Krakatau.Kepm.Properties.Resources.EditMetricSet;
      this.tsbEdit.ImageScaling = System.Windows.Forms.ToolStripItemImageScaling.None;
      this.tsbEdit.ImageTransparentColor = System.Drawing.Color.Magenta;
      this.tsbEdit.Name = "tsbEdit";
      this.tsbEdit.Size = new System.Drawing.Size(36, 36);
      this.tsbEdit.Text = "Edit selected Metric Set";
      this.tsbEdit.Click += new System.EventHandler(this.tsbEdit_Click);
      //
      // tsbDelete
      //
      this.tsbDelete.DisplayStyle = System.Windows.Forms.ToolStripItemDisplayStyle.Image;
      this.tsbDelete.Image = global::SourceCodeMetrics.Krakatau.Kepm.Properties.Resources.DeleteMetricSet;
      this.tsbDelete.ImageScaling = System.Windows.Forms.ToolStripItemImageScaling.None;
      this.tsbDelete.ImageTransparentColor = System.Drawing.Color.Magenta;
      this.tsbDelete.Name = "tsbDelete";
      this.tsbDelete.Size = new System.Drawing.Size(36, 36);
      this.tsbDelete.Text = "Delete selected Metric Set";
      this.tsbDelete.Click += new System.EventHandler(this.tsbDelete_Click);
      //
      // tableLayoutPanel1
      //
      this.tableLayoutPanel1.ColumnCount = 1;
      this.tableLayoutPanel1.ColumnStyles.Add(new System.Windows.Forms.ColumnStyle(System.Windows.Forms.SizeType.Percent, 50F));
      this.tableLayoutPanel1.Controls.Add(this.lsvMetricSets, 0, 0);
      this.tableLayoutPanel1.Controls.Add(this.btnOK, 0, 1);
      this.tableLayoutPanel1.Dock = System.Windows.Forms.DockStyle.Fill;
      this.tableLayoutPanel1.Location = new System.Drawing.Point(0, 0);
      this.tableLayoutPanel1.Name = "tableLayoutPanel1";
      this.tableLayoutPanel1.RowCount = 2;
      this.tableLayoutPanel1.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Percent, 90.68627F));
      this.tableLayoutPanel1.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Percent, 9.313725F));
      this.tableLayoutPanel1.Size = new System.Drawing.Size(551, 408);
      this.tableLayoutPanel1.TabIndex = 3;
      //
      // FormMetricSets
      //
      this.AcceptButton = this.btnOK;
      this.AutoScaleBaseSize = new System.Drawing.Size(5, 13);
      this.ClientSize = new System.Drawing.Size(551, 447);
      this.ControlBox = false;
      this.Controls.Add(this.toolStripContainer1);
      this.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedDialog;
      this.Icon = ((System.Drawing.Icon)(resources.GetObject("$this.Icon")));
      this.MaximizeBox = false;
      this.MinimizeBox = false;
      this.Name = "FormMetricSets";
      this.ShowInTaskbar = false;
      this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
      this.Text = "Metric Sets";
      this.toolStripContainer1.ContentPanel.ResumeLayout(false);
      this.toolStripContainer1.TopToolStripPanel.ResumeLayout(false);
      this.toolStripContainer1.TopToolStripPanel.PerformLayout();
      this.toolStripContainer1.ResumeLayout(false);
      this.toolStripContainer1.PerformLayout();
      this.toolStrip1.ResumeLayout(false);
      this.toolStrip1.PerformLayout();
      this.tableLayoutPanel1.ResumeLayout(false);
      this.ResumeLayout(false);

    }
    #endregion

    private void tsbNew_Click(object sender, EventArgs e)
    {
      MetricSetItem msi = (MetricSetItem)lsvMetricSets.FocusedItem;
      msi = new MetricSetItem();
      FormMetricSet mset = new FormMetricSet(msi);
      if (mset.ShowDialog(this) == DialogResult.OK)
      {
        this.lsvMetricSets.Items.Add(msi);
        XmlConfig.Config.AddMetricSet(msi.MetricSet);
        XmlConfig.Config.SaveConfig();
      }
    }

    private void tsbEdit_Click(object sender, EventArgs e)
    {
      MetricSetItem msi = (MetricSetItem)lsvMetricSets.FocusedItem;

      if (msi != null)
      {
        FormMetricSet mset = new FormMetricSet(msi);
        mset.ShowDialog(this);
        XmlConfig.Config.SaveConfig();
      }
    }

    private void tsbDelete_Click(object sender, EventArgs e)
    {
      MetricSetItem msi = (MetricSetItem)lsvMetricSets.FocusedItem;
      if (msi != null)
      {
        if (MessageBox.Show(this, "Are you sure you wish to delete this Metric Set?", "Really Delete " + msi.Text + "?",
            MessageBoxButtons.YesNo, MessageBoxIcon.Question) == DialogResult.Yes)
        {
          XmlConfig.Config.RemoveMetricSet(msi.MetricSet);
          lsvMetricSets.Items.Remove(msi);
          XmlConfig.Config.SaveConfig();
        }
      }
    }
  }
}
