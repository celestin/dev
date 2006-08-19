/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 * Maia Systems Acumen
 * Copyright (c) 2006 Maia Systems
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * Temperature-specific graphing data
 *
 * $Id$
 * 
 * Who  When       Why
 * CAM  6-Apr-06   100 : Added to Source Safe.
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

using System;
using System.Windows.Forms;
using Gigasoft.ProEssentials;
using Gigasoft.ProEssentials.Enums;

using frontburner.maia.Acumen;
using frontburner.maia.Acumen.Nodes;

namespace frontburner.maia.Acumen.Model
{
  /// <summary>
  /// Summary description for Speed.
  /// </summary>
  public class TemperatureData : AcumenData
  {    
    public TemperatureData(ComponentNode component): base(component, "Temperature oC", 1)
    {
      double[] minmax = DataLayer.getDataLayer().GetMinMax(3);
      this._min = (float)minmax[0]*0.95f;
      this._max = (float)minmax[1]*1.05f;
    }

    protected override void StartMessage(StatusBarPanel sbp) 
    {
      sbp.Text = "Loading Temperature data...";
      sbp.Parent.Refresh();
    }
    protected override void CompleteMessage(StatusBarPanel sbp)
    {
      sbp.Text = "Finished loading Temperature data.";
      sbp.Parent.Refresh();
    }

    public override MeasurementTypes MeasurementType 
    {
      get 
      {
        return MeasurementTypes.Temperature;
      }
    }
  }
}
