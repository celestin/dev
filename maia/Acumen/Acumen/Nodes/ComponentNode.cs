/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 * Maia Systems Acumen
 * Copyright (c) 2006 Maia Systems
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * Tag Node in the tree
 *
 * $Id$
 * 
 * Who  When       Why
 * CAM  6-Apr-06   100 : Added to Source Safe.
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

using System;
using System.Windows.Forms;

namespace frontburner.maia.Acumen.Nodes
{
  public enum ComponentTypes 
  {
    SealChip,
    Wireless,
    Dart1,
    Dart2
  }

  public enum MeasurementTypes 
  {
    Speed=1,
    Temperature=2,
    Vibration=3
  }

	/// <summary>
	/// Node representing Tags
	/// </summary>
  public class ComponentNode : AcumenNode
  {
    protected ComponentTypes _compType;
    protected int _physicalEnd;
    protected long _lastData;

    public ComponentNode(int id, string code, string name, int ctype, int physicalEnd) : base(id, code, name)
    {
      this._physicalEnd = physicalEnd;
      this._lastData = 0;

      if (ctype == 0) 
      {
        this._compType = ComponentTypes.Wireless;
        this.ImageIndex = 6;
      } 
      else if (ctype == 1)
      {
        this._compType = ComponentTypes.SealChip;
        this.ImageIndex = 5;
      }
      else if (ctype == 2) 
      {
        this._compType = ComponentTypes.Dart1;
        this.ImageIndex = 5;
      }
      else if (ctype == 3) 
      {
        this._compType = ComponentTypes.Dart2;
        this.ImageIndex = 6;
      }

      this.SelectedImageIndex = this.ImageIndex;
    }

    public int PhysicalEnd 
    {
      get 
      {
        return this._physicalEnd;
      }
    }

    public ComponentTypes ComponentType 
    {
      get 
      {
        return this._compType;
      }
    }

    public long LastData 
    {
      get 
      {
        return this._lastData;
      }
      set 
      {
        this._lastData = value;
      }
    }
  }
}
