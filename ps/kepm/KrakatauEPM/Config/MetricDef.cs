/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 * Krakatau Essential PM (KEPM)
 * Copyright (c) 2004-2006 PowerSoftware.com
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * Representation of Metric Definition in Metric Set
 *
 * $Id$
 * 
 * Who  When       Why
 * CAM  13-Jun-06   258 : File created.
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

using System;
using System.Collections;
using System.Windows.Forms;

namespace SourceCodeMetrics.Krakatau.Kepm.Config
{
	/// <summary>
	/// Metric Definition
	/// </summary>
	public class MetricDef
	{
    private int _id;
    private long _upperValue;
    private long _lowerValue;
    private bool _upperBound;
    private bool _lowerBound;

    private CheckBox _chkMet;
    private CheckBox _chkLower;
    private TextBox _txtLower;
    private CheckBox _chkUpper;
    private TextBox _txtUpper;

    public MetricDef(int id, bool upperBound, long upperValue, bool lowerBound, long lowerValue)
    {
      this._id = id;
      this._upperBound = upperBound;
      this._upperValue = upperValue;
      this._lowerBound = lowerBound;
      this._lowerValue = lowerValue;
    }
    
    public MetricDef(int id, bool upperBound, long upperValue): this(id, upperBound, upperValue, false, 0)
    {
    }
    
    public MetricDef(int id): this(id, false, 0, false, 0)
		{
		}

    public MetricDef(int id, CheckBox chkMet, CheckBox chkLower, TextBox txtLower, CheckBox chkUpper, TextBox txtUpper, MetricSet ms) 
    {
      this._id = id;
      this._chkMet = chkMet;
      this._chkLower = chkLower;
      this._txtLower = txtLower;
      this._chkUpper = chkUpper;
      this._txtUpper = txtUpper;

      if (ms != null) 
      {
        MetricDef existing = ms.Get(this._id);        
        if (existing != null) 
        {
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
        if (this._txtLower != null && this._txtLower.Text.Length>0) this._lowerValue = long.Parse(this._txtLower.Text);
        this._lowerBound = true;
      }
      if (this._chkUpper != null && this._chkUpper.Checked) 
      {
        if (this._txtUpper != null && this._txtUpper.Text.Length>0) this._upperValue = long.Parse(this._txtUpper.Text);
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

    public int Id 
    {
      get 
      {
        return this._id;
      }
    }

    public bool UpperBound 
    {
      get 
      {
        return this._upperBound;
      }
    }

    public long UpperValue 
    {
      get 
      {
        return this._upperValue;
      }
    }

    public bool LowerBound 
    {
      get 
      {
        return this._lowerBound;
      }
    }

    public long LowerValue
    {
      get 
      {
        return this._lowerValue;
      }
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
  }
}
