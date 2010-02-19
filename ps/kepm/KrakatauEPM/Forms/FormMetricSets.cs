/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 * Krakatau Essential PM (KEPM)
 * Copyright (c) 2004,2010 PowerSoftware.com
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  13-Jun-06    258 : File created.
 * CAM  22-Jul-06    291 : Add tooltips for each button.
 * CAM  18-Feb-2010  10574 : Resource names tidied.
 * CAM  19-Feb-2010  10558 : Separated Designer code.
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
  /// Dialog to maintain Metric Sets.
  /// </summary>
  public partial class FormMetricSets : System.Windows.Forms.Form
  {
    private bool _itemsDeleted;

    public bool ItemsDeleted
    {
      get { return _itemsDeleted; }
      set { _itemsDeleted = value; }
    }

    public FormMetricSets(IEnumerator metricSets)
    {
      InitializeComponent();

      ItemsDeleted = false;

      while (metricSets.MoveNext())
      {
        MetricSet ms = (MetricSet)metricSets.Current;
        ListViewItem lvi = new MetricSetItem(ms);
        this.lsvMetricSets.Items.Add(lvi);
      }
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

          ItemsDeleted = true;
        }
      }
    }
  }
}
