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
    Wireless
  }

	/// <summary>
	/// Node representing Tags
	/// </summary>
  public class ComponentNode : AcumenNode
  {
    protected ComponentTypes _compType;
    protected int _physicalEnd;

    public ComponentNode(int id, string code, string name, int ctype, int physicalEnd) : base(id, code, name)
    {
      this._physicalEnd = physicalEnd;

      if (ctype == 0) 
      {
        this._compType = ComponentTypes.Wireless;
        this.ImageIndex = 6;
      } 
      else 
      {
        this._compType = ComponentTypes.SealChip;
        this.ImageIndex = 5;
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
  }
}
