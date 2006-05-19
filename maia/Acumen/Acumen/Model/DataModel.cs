/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 * Maia Systems Acumen
 * Copyright (c) 2006 Maia Systems
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * Data Model Manager
 *
 * $Id$
 * 
 * Who  When       Why
 * CAM  6-Apr-06   100 : Added to Source Safe.
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

using System;
using System.Collections;

using frontburner.maia.Acumen.Nodes;

namespace frontburner.maia.Acumen.Model
{
	/// <summary>
	/// Summary description for DataModel.
	/// </summary>
	public class DataModel
	{
    private Hashtable _dataVibr, _dataSped, _dataTemp;
    private bool _drawing;

		public DataModel()
		{
      this._dataVibr = new Hashtable();
      this._dataSped = new Hashtable();
      this._dataTemp = new Hashtable();
    }

    public bool Drawing 
    {
      get 
      {
        return this._drawing;
      }
      set 
      {
        this._drawing = value;
      }
    }

    public VibrationData getVibration(ComponentNode component)
    {
      VibrationData rval = (VibrationData) _dataVibr[component.Id];

      if (rval == null) 
      {
        rval = new VibrationData(component);
        _dataVibr[component.Id] = rval;
      }

      return rval;
    }

    public SpeedData getSpeed(ComponentNode component)
    {
      SpeedData rval = (SpeedData) _dataSped[component.Id];

      if (rval == null) 
      {
        rval = new SpeedData(component);
        _dataSped[component.Id] = rval;
      }

      return rval;
    }
  
    public TemperatureData getTemperature(ComponentNode component)
    {
      TemperatureData rval = (TemperatureData) _dataTemp[component.Id];

      if (rval == null) 
      {
        rval = new TemperatureData(component);
        _dataTemp[component.Id] = rval;
      }

      return rval;
    }
  }
}
