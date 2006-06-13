/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 * Krakatau Essential PM (KEPM)
 * Copyright (c) 2004-2006 Power Software
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * Representation of Metric Definition in Metric Set
 *
 * $Id: Prefs.cs 147 2006-06-06 23:06:48Z craig $
 * 
 * Who  When       Why
 * CAM  13-Jun-06   258 : File created.
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

using System;
using System.Collections;

namespace KrakatauEPM
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
  }
}
