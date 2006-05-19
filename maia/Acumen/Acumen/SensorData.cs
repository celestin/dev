/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 * Maia Systems Acumen
 * Copyright (c) 2006 Maia Systems
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * Representation of an instance of Sensor data
 *
 * $Id$
 * 
 * Who  When       Why
 * CAM  6-Apr-06   100 : Added to Source Safe.
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

using System;
using System.Collections;

namespace frontburner.maia.Acumen
{
	/// <summary>
	/// A snapshot of Sensor Data, including its alarm status
	/// </summary>
	public class SensorData
	{
    protected int _id;
    protected string _timeMark;
    protected double[] _series;
    protected int _alarm;

		public SensorData(int id, string timeMark, double v1, double alarm)
		{
      this._id = id;
      this._timeMark = timeMark;
      this._series = new double[1];
      this._series[0] = v1;
      this._alarm = Convert.ToInt16(alarm);
    }

    public SensorData(int id, string timeMark, double v1, double v2, double v3, double alarm)
    {
      this._id = id;
      this._timeMark = timeMark;
      this._series = new double[3];
      this._series[0] = v1;
      this._series[1] = v2;
      this._series[2] = v3;
      this._alarm = Convert.ToInt16(alarm);
    }

    public override string ToString() 
    {
      return this._id.ToString() + " :: " + this._timeMark + " (" + this._series[0].ToString() + ", " +
        this._series[1].ToString() + ", " + this._series[2].ToString() + ") " + this._alarm.ToString();
    }

    public int Id
    {
      get 
      {
        return this._id;
      }
    }

    public string TimeMark 
    {
      get
      {
        return this._timeMark;
      }
    }

    public int Count
    {
      get 
      {
        return this._series.Length;
      }
    }

    public double V1 
    {
      get 
      {
        return this._series[0];
      }
    }

    public double V2
    {
      get 
      {
        return this._series[1];
      }
    }

    public double V3 
    {
      get 
      {
        return this._series[2];
      }
    }

    public int Alarm
    {
      get 
      {
        return this._alarm;
      }
    }
  }
}
