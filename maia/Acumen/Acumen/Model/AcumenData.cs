/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 * Maia Systems Acumen
 * Copyright (c) 2006 Maia Systems
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * Base class for Acumen data
 *
 * $Id$
 * 
 * Who  When       Why
 * CAM  6-Apr-06   100 : Added to Source Safe.
 * CAM  23-Apr-06  100 : Changed to Random Data.
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

using System;
using System.Windows.Forms;
using Gigasoft.ProEssentials;
using Gigasoft.ProEssentials.Enums;
using Gigasoft.ProEssentials.Structs;

using frontburner.maia.Acumen;
using frontburner.maia.Acumen.Nodes;

namespace frontburner.maia.Acumen.Model
{
	/// <summary>
	/// Summary description for Vibration.
	/// </summary>
	public abstract class AcumenData
	{
    protected ComponentNode _component;
    protected int _lastDataId;
    protected Random _random;
    protected string _yAxis;
    protected int _sets;
    protected string[] _setLabels;
    protected float _min;
    protected float _max;

    public AcumenData(ComponentNode component, string yAxis, int sets) 
    {
      this._component = component;
      this._lastDataId = 0;
      this._random = new Random();
      this._sets = sets;
      this._yAxis = yAxis;
      this._setLabels = null;
    }

		public AcumenData(ComponentNode component, string yaxis): this(component, yaxis, 1)
		{
		}

    public abstract MeasurementTypes MeasurementType
    {
      get;
    }

    public void ResetGraph(Pego peg, TabPage tab) 
    {
      InitialiseGraph(peg, tab);

      // Main Title
      peg.PeString.MainTitle = "";
      peg.PeString.SubTitle = " ";
      peg.Refresh();
    }

    protected abstract void StartMessage(StatusBarPanel sbp);
    protected abstract void CompleteMessage(StatusBarPanel sbp);

    public void UpdateGraphFull(Pego peg, StatusBarPanel sbp)
    {
      StartMessage(sbp);
      DataLayer.getDataLayer().UpdateMeasurementData(this._component, peg, this._sets, this.MeasurementType);
      CompleteMessage(sbp);
    }

    public void UpdateGraphMote(Pego peg, StatusBarPanel sbp) 
    {      
      //StartMessage(sbp);
      DataLayer.getDataLayer().UpdateMoteData(this._component, peg, this.MeasurementType);
      //CompleteMessage(sbp);
    }

    protected float RandomValue(int i)
    {
      int factor = (int)(90.0f*((float)i/(float)this._sets));
      int min = ((int) this._min) * factor;
      int max = ((int) this._max) * factor;
      return (float) this._random.Next(min, max) / (factor*1.05f);
    }

    public void UpdateGraph(Pego peg, StatusBarPanel sbp) 
    {
      if (this._component.ComponentType == ComponentTypes.SealChip) 
      {
        UpdateGraphFull(peg, sbp);
        return;
      }

      if (this._component.ComponentType == ComponentTypes.Dart1) 
      {
        UpdateGraphMote(peg, sbp);
        return;
      }

      if (this._component.ComponentType == ComponentTypes.Dart2) 
      {
        UpdateGraphMote(peg, sbp);
        return;
      }

      float[] fdat = new float[this._sets];

      for (int i=0; i<this._sets; i++)
      {
        switch (i)
        {
          case 0:
            fdat[i] = this.RandomValue(1);
            break;
          case 1:
            fdat[i] = this.RandomValue(2);
            break;
          case 2:
            fdat[i] = this.RandomValue(3);
            break;
        }
      }

      DateTime now = DateTime.Now;
      String timeMark = now.Minute.ToString() + ":" + now.Second.ToString() + ":" + now.Millisecond.ToString();
      UpdateGraph(peg, timeMark, fdat);
      peg.Refresh();      
    }


    public void UpdateGraph2(Pego peg, StatusBarPanel sbp) 
    {
      if (this._component.ComponentType == ComponentTypes.SealChip) 
      {
        UpdateGraphFull(peg, sbp);
        return;
      }

      float[] fdat = new float[this._sets];

      SensorData[] dat = DataLayer.getDataLayer().GetMeasurementData(this._component, this._lastDataId, this.MeasurementType);
      for (int j=0; j<dat.Length; j++)
      {
        this._lastDataId = dat[j].Id;        
        for (int i=0; i<this._sets; i++)
        {
          switch (i)
          {
            case 0:
              fdat[i] = (float)dat[j].V1;
              break;
            case 1:
              fdat[i] = (float)dat[j].V2;
              break;
            case 2:
              fdat[i] = (float)dat[j].V3;
              break;
          }
        }
        //MessageBox.Show(fdat[0].ToString() + "," + fdat[1].ToString() + "," + fdat[2].ToString());
        UpdateGraph(peg, dat[j].TimeMark, fdat);
      }
      peg.Refresh();      
    }

    protected void UpdateGraph(Pego peg, string time, float[] fdat) 
    {      
      try 
      {
        Gigasoft.ProEssentials.Api.PEvset(peg.PeSpecial.HObject, Gigasoft.ProEssentials.DllProperties.AppendPointLabelData, time, 1);
        Gigasoft.ProEssentials.Api.PEvset(peg.PeSpecial.HObject, Gigasoft.ProEssentials.DllProperties.AppendYData, fdat, 1);
      } 
      catch (Exception)
      {
      }
    }

    public void InitialiseGraph(Pego peg, TabPage tab)
    {
      Gigasoft.ProEssentials.Api.PEreset(peg.PeSpecial.HObject);

      // No Flicker //
      peg.PeConfigure.PrepareImages = true;
      peg.PeConfigure.CacheBmp = true;   
      
      // Set Subsets and Points //
      peg.PeData.Subsets = this._sets;      // set number of subsets

      //if (this._component.ComponentType == ComponentTypes.Wireless || this._component.ComponentType == ComponentTypes.Dart2) 
      //{
        peg.PeData.Points = 300;
        peg.PeUserInterface.Scrollbar.PointsToGraph = 260;
        peg.PeUserInterface.Scrollbar.PointsToGraphInit = PointsToGraphInit.Last;
      //} 
      //else 
      //{
      //  peg.PeData.Points = 5000;
      //  peg.PeUserInterface.Scrollbar.PointsToGraph = peg.PeData.Points;
      //  peg.PeUserInterface.Scrollbar.PointsToGraphInit = PointsToGraphInit.First;
      //}

      // Needed to allocate point labels so append logic works //
      // Set last point label, Points - 1 //
      peg.PeString.PointLabels[peg.PeData.Points-1] = "";

      peg.PeString.XAxisLabel = "";
      peg.PeString.YAxisLabel = this._yAxis;
      peg.PeLegend.SimpleLine = true;
      peg.PeLegend.SimplePoint = true;

      for (int i=0; i<peg.PeData.Subsets; i++) 
      {
        peg.PePlot.SubsetLineTypes[i] = LineType.ThinSolid;
        //peg.PePlot.SubsetPointTypes[i] = PointType.Dot;
        if (this._setLabels != null) 
        {
          peg.PeString.SubsetLabels[i] = this._setLabels[i];
        }
      }

      // Reset first four default data points
      peg.PeData.Y[0, 0] = 0;
      peg.PeData.Y[0, 1] = 0;
      peg.PeData.Y[0, 2] = 0;
      peg.PeData.Y[0, 3] = 0;

      // Manually configure scales //
      peg.PeGrid.Configure.ManualScaleControlY = ManualScaleControl.MinMax;

      peg.PeGrid.Configure.ManualMinY = this._min;
      peg.PeGrid.Configure.ManualMaxY = this._max;
      peg.PeGrid.Configure.ManualMaxDataString = "000.000";
      peg.PeGrid.Configure.ManualMaxPointLabel = "00:00:00xx";

      peg.BackColor = tab.BackColor;  //System.Drawing.Color.WhiteSmoke;
      peg.PePlot.Method = GraphPlottingMethod.Line;
      peg.GraphForeground = System.Drawing.Color.LightSteelBlue;
      peg.PeConfigure.BorderTypes = TABorder.Inset;

      if (this._sets > 1)
      {
        peg.PeLegend.Show = true;
        peg.PeLegend.Location = LegendLocation.Top;
      } 
      else 
      {
        peg.PeLegend.Show = false;
      }
    }
  }
}
