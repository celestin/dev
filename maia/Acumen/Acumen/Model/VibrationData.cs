/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 * Maia Systems Acumen
 * Copyright (c) 2006 Maia Systems
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * Vibration-specific graphing data
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
  /// Summary description for Vibration.
  /// </summary>
  public class VibrationData : AcumenData
  {
    public VibrationData(ComponentNode component): base(component, "Vibration mm/s2", 3)
    {
      this._setLabels = new string[3];
      this._setLabels[0] = "Radial (X)";
      this._setLabels[1] = "Radial (Y)";
      this._setLabels[2] = "Axial";

      this._min = 1;
      this._max = 3.2f;
    }

    protected override void StartMessage(StatusBarPanel sbp) 
    {
      sbp.Text = "Loading Vibration data...";
      sbp.Parent.Refresh();
    }
    protected override void CompleteMessage(StatusBarPanel sbp)
    {
      sbp.Text = "Finished loading Vibration data.";
      sbp.Parent.Refresh();
    }

    public override int MeasurementType 
    {
      get 
      {
        return 1;
      }
    }
  }
}
