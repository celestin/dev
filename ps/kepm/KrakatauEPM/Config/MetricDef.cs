/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 * Krakatau Essential PM (KEPM)
 * Copyright (c) 2004,2010 PowerSoftware.com
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  13-Jun-06    258 : File created.
 * CAM  19-Feb-2010  10558 : Use Metric rather than Long as Id.
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

using System;
using System.Collections;
using System.Windows.Forms;

using SourceCodeMetrics.Krakatau.Kepm.Metrics;

namespace SourceCodeMetrics.Krakatau.Kepm.Config
{
  /// <summary>
  /// Representation of Metric Definition in Metric Set.
  /// </summary>
  public class MetricDef
  {
    private Metric _metric;
    private long _upperValue;
    private long _lowerValue;
    private bool _upperBound;
    private bool _lowerBound;

    private CheckBox _chkMet;
    private CheckBox _chkLower;
    private TextBox _txtLower;
    private CheckBox _chkUpper;
    private TextBox _txtUpper;

    public long Id
    {
      get { return _metric.Id; }
    }
    public Metric Metric
    {
      get { return _metric; }
    }

    public bool UpperBound
    {
      get { return this._upperBound; }
    }

    public long UpperValue
    {
      get { return this._upperValue; }
    }

    public bool LowerBound
    {
      get { return this._lowerBound; }
    }

    public long LowerValue
    {
      get { return this._lowerValue; }
    }

    public bool Active
    {
      get
      {
        if (this._chkMet != null && this._chkMet.Checked)
        {
          this.Evaluate();
          return true;
        }
        return false;
      }
    }

    public MetricDef(Metric metric, bool upperBound, long upperValue, bool lowerBound, long lowerValue)
    {
      this._metric = metric;
      this._upperBound = upperBound;
      this._upperValue = upperValue;
      this._lowerBound = lowerBound;
      this._lowerValue = lowerValue;
    }

    public MetricDef(Metric metric, bool upperBound, long upperValue)
      : this(metric, upperBound, upperValue, false, 0)
    {
    }

    public MetricDef(Metric metric)
      : this(metric, false, 0, false, 0)
    {
    }

    public MetricDef(Metric metric, CheckBox chkMet, CheckBox chkLower, TextBox txtLower, CheckBox chkUpper, TextBox txtUpper, MetricSet ms)
    {
      this._metric = metric;
      this._chkMet = chkMet;
      this._chkLower = chkLower;
      this._txtLower = txtLower;
      this._chkUpper = chkUpper;
      this._txtUpper = txtUpper;

      if (ms != null)
      {
        if (ms.Contains(Metric.Id))
        {
          MetricDef existing = ms[Metric.Id];
          this._lowerBound = existing._lowerBound;
          this._lowerValue = existing._lowerValue;
          this._upperBound = existing._upperBound;
          this._upperValue = existing._upperValue;

          this._chkMet.Checked = true;
          if (this._lowerBound)
          {
            this._chkLower.Checked = true;
            this._txtLower.Text = this._lowerValue.ToString();
          }
          if (this._upperBound)
          {
            this._chkUpper.Checked = true;
            this._txtUpper.Text = this._upperValue.ToString();
          }
        }
      }
    }

    public void Evaluate()
    {
      this._upperBound = false;
      this._lowerBound = false;

      if (this._chkLower != null && this._chkLower.Checked)
      {
        if (this._txtLower != null && this._txtLower.Text.Length > 0) this._lowerValue = long.Parse(this._txtLower.Text);
        this._lowerBound = true;
      }
      if (this._chkUpper != null && this._chkUpper.Checked)
      {
        if (this._txtUpper != null && this._txtUpper.Text.Length > 0) this._upperValue = long.Parse(this._txtUpper.Text);
        this._upperBound = true;
      }
    }

    public void Upper(long upperValue)
    {
      this._upperBound = true;
      this._upperValue = upperValue;
    }

    public void Lower(long lowerValue)
    {
      this._lowerBound = true;
      this._lowerValue = lowerValue;
    }
  }
}
