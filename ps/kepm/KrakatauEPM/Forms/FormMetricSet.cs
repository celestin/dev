/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 * Krakatau Essential PM (KEPM)
 * Copyright (c) 2004,2009 PowerSoftware.com
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  14-Jun-06    258 : File created.
 * CAM  12-Jul-06    282 : Ensure Cancel button can be pressed even if Metric Set exists.
 * CAM  18-Jul-06    272 : Added CHG,DEL,ADD LLOC metrics.
 * CAM  02-Nov-06    117 : Renumber Metric IDs to suit new SLOC* metrics.
 * CAM  24-Apr-08    357 : Correctly number Metric IDs.
 * CAM  17-Apr-2009  10433 : Added Churn metrics.
 * CAM  14-Sep-2009  10479 : Added PLOC metric.
 * CAM  24-Feb-2010  10558 : Separated Designer code.
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

using System;
using System.Drawing;
using System.Collections;
using System.ComponentModel;
using System.Windows.Forms;

using PowerSoftware.Krakatau.Kepm.Config;
using PowerSoftware.Krakatau.Kepm.Metrics;

namespace PowerSoftware.Krakatau.Kepm.Forms
{
  /// <summary>
  /// Dialog to edit a Metric Set.
  /// </summary>
  public partial class FormMetricSet : Form
  {
    protected SortedList _mets1;
    protected SortedList _mets2;
    protected int _tabIndex;
    protected MetricSetItem _msi;
    protected Button _btnLastPressed;

    public FormMetricSet(MetricSetItem msi)
    {
      this._msi = msi;
      InitializeComponent();
      AddExtraMetrics();
      this.txtName.Text = this._msi.Text;
    }

    private void SetLocation(GroupBox grp, Control refObj, Control newObj, bool bold)
    {
      newObj.Location = new Point(refObj.Location.X, refObj.Location.Y + 24);
      newObj.Size = new Size(refObj.Size.Width, refObj.Size.Height);

      if (newObj is CheckBox)
      {
        newObj.Text = refObj.Text;
      }

      if (bold)
      {
        newObj.Font = new Font("Tahoma", 8.25F, FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((System.Byte)(0)));
      }
      else
      {
        newObj.Font = new Font("Tahoma", 8.25F, FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((System.Byte)(0)));
      }

      grp.Controls.Add(newObj);
    }

    private void AddMetric(SortedList m, GroupBox grp, Metric metric)
    {
      CheckBox chkMet = new CheckBox();
      CheckBox chkLower = new CheckBox();
      TextBox txtLower = new TextBox();
      CheckBox chkUpper = new CheckBox();
      TextBox txtUpper = new TextBox();

      AddMetric(m, grp, metric, chkMet, chkLower, txtLower, chkUpper, txtUpper);
    }

    private void AddMetric(SortedList m, GroupBox grp, Metric metric, CheckBox chkMet, CheckBox chkLower, TextBox txtLower, CheckBox chkUpper, TextBox txtUpper)
    {
      Hashtable f;

      if (m.Count > 0)
      {
        f = (Hashtable)m.GetByIndex(m.Count - 1);
        CheckBox chkRefMet = (CheckBox)f["chkMet"];
        CheckBox chkRefLower = (CheckBox)f["chkLower"];
        TextBox txtRefLower = (TextBox)f["txtLower"];
        CheckBox chkRefUpper = (CheckBox)f["chkUpper"];
        TextBox txtRefUpper = (TextBox)f["txtUpper"];

        SetLocation(grp, chkRefMet, chkMet, true);
        SetLocation(grp, chkRefLower, chkLower, false);
        SetLocation(grp, txtRefLower, txtLower, false);
        SetLocation(grp, chkRefUpper, chkUpper, false);
        SetLocation(grp, txtRefUpper, txtUpper, false);
      }

      chkMet.Text = metric.Code;

      MetricDef md = new MetricDef(metric, chkMet, chkLower, txtLower, chkUpper, txtUpper, this._msi.MetricSet);
      f = new Hashtable();
      f["id"] = metric.Id;
      f["name"] = metric.Code;
      f["chkMet"] = chkMet;
      f["chkLower"] = chkLower;
      f["txtLower"] = txtLower;
      f["chkUpper"] = chkUpper;
      f["txtUpper"] = txtUpper;
      f["MetricDef"] = md;
      m.Add(metric.Id, f);
    }

    private void AddExtraMetrics()
    {
      _tabIndex = 1;

      _mets1 = new SortedList();
      _mets2 = new SortedList();

      // Add the existing "reference" components to the start of the list
      MetricCollection metrics = KrakatauSettings.Settings.Metrics;

      Metric firstFile = null;
      Metric firstChanged = null;
      foreach (Metric m in metrics)
      {
        if (m.Type == MetricType.General && firstFile == null)
        {
          firstFile = m;
        }
        else if (m.Type == MetricType.Changed && firstChanged == null)
        {
          firstChanged = m;
        }
      }

      AddMetric(_mets1, grpFileMet, firstFile, chkMet1, chkLower1, txtLower1, chkUpper1, txtUpper1);
      AddMetric(_mets2, grpChgMet, firstChanged, chkMet2, chkLower2, txtLower2, chkUpper2, txtUpper2);

      foreach (Metric m in metrics)
      {
        if (m.Type == MetricType.General)
        {
          // Add the General metrics
          if (!_mets1.Contains(m.Id)) AddMetric(_mets1, grpFileMet, m);
        }
        else
        {
          // Add the Changed metrics
          if (!_mets2.Contains(m.Id)) AddMetric(_mets2, grpChgMet, m);
        }
      }

      SetLayout(_mets1, this.grpFileMet);
      SetLayout(_mets2, this.grpChgMet);

      this.btnOK.TabIndex = _tabIndex++;
      this.btnCancel.TabIndex = _tabIndex++;
    }

    protected void SetLayout(SortedList m, GroupBox grp)
    {
      CheckBox chkRefMet = null;
      CheckBox chkRefLower = null;
      TextBox txtRefLower = null;
      CheckBox chkRefUpper = null;
      TextBox txtRefUpper = null;
      Hashtable f;

      grp.TabIndex = _tabIndex++;

      IEnumerator e = m.GetEnumerator();
      while (e.MoveNext())
      {
        f = (Hashtable)((DictionaryEntry)e.Current).Value;
        chkRefMet = (CheckBox)f["chkMet"];
        chkRefLower = (CheckBox)f["chkLower"];
        txtRefLower = (TextBox)f["txtLower"];
        chkRefUpper = (CheckBox)f["chkUpper"];
        txtRefUpper = (TextBox)f["txtUpper"];

        chkRefMet.TabIndex = _tabIndex++;
        chkRefLower.TabIndex = _tabIndex++;
        txtRefLower.TabIndex = _tabIndex++;
        chkRefUpper.TabIndex = _tabIndex++;
        txtRefUpper.TabIndex = _tabIndex++;
      }

      int winsize = this.Size.Height - (grp.Location.Y + grp.Size.Height);

      int shift = (chkRefMet.Location.Y - this.chkMet1.Location.Y);
      grp.Size = new Size(grp.Size.Width, grp.Size.Height + shift);

      if (grp == this.grpFileMet)
      {
        this.Size = new Size(this.Size.Width, this.Size.Height + shift);
        shift = (grp.Size.Height + winsize - 20) - (this.btnOK.Size.Height);
        this.btnOK.Location = new Point(this.btnOK.Location.X, shift);
        this.btnCancel.Location = new Point(this.btnCancel.Location.X, shift);
      }
    }

    private void AppendMetricDefs(SortedList mets)
    {
      MetricSet ms = this._msi.MetricSet;
      IEnumerator defs = mets.Values.GetEnumerator();
      Hashtable f;
      while (defs.MoveNext())
      {
        f = (Hashtable)defs.Current;
        MetricDef md = (MetricDef)f["MetricDef"];
        if (md != null && md.Active)
        {
          ms.Add(md);
        }
      }
    }

    private void OkClicked(object sender, System.EventArgs e)
    {
      _btnLastPressed = btnOK;

      this._msi.Text = this.txtName.Text;
      this._msi.MetricSet.Clear();
      AppendMetricDefs(this._mets1);
      AppendMetricDefs(this._mets2);
    }

    private void CancelClicked(object sender, System.EventArgs e)
    {
      _btnLastPressed = btnCancel;
    }

    private void FormMetricSet_Closing(object sender, System.ComponentModel.CancelEventArgs e)
    {
      if (_btnLastPressed != null && _btnLastPressed == btnOK)
      {
        MetricSet ms = XmlConfig.Config.GetMetricSet(txtName.Text);
        if (ms != null && ms != this._msi.MetricSet)
        {
          btnOK.Enabled = false;
          stbMsg.Text = "The name you have entered already exists - please specify another.";
          e.Cancel = true;
        }
      }
    }

    private void MetricSetNameChanged(object sender, System.EventArgs e)
    {
      if (txtName.Text.IndexOf(" ") > 0)
      {
        stbMsg.Text = "No spaces in Metric Set names, please... they will be removed.";
      }
      else
      {
        stbMsg.Text = "";
      }

      btnOK.Enabled = false;
      if (txtName.Text.Length > 0)
      {
        btnOK.Enabled = true;
      }
    }

    private void MetricSetNameLeft(object sender, System.EventArgs e)
    {
      txtName.Text = txtName.Text.Replace(" ", "");
      stbMsg.Text = "";
    }
  }
}