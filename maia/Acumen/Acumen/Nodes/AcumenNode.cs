/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 * Maia Systems Acumen
 * Copyright (c) 2006 Maia Systems
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * Abstract base class for Acumen Nodes
 *
 * $Id: $
 * 
 * Who  When       Why
 * CAM  6-Apr-06   100 : Added to Source Safe.
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

using System;
using System.Windows.Forms;

namespace frontburner.maia.Acumen.Nodes
{
	/// <summary>
  /// Node representing Assets within the Company.
  /// </summary>
	public abstract class AcumenNode : TreeNode
	{
    protected int _id;
    protected string _code;
    protected string _name;

		protected AcumenNode(int id, string code, string name) : base(name)
		{
      this._id = id;
      this._code = code;
      this._name = name;
      this.SelectedImageIndex = 1;
    }

    public int Id 
    {
      get 
      {
        return this._id;
      }
    }

    public string Code
    {
      get 
      {
        return this._code;
      }
    }

    public string Name
    {
      get 
      {
        return this._name;
      }
    }
  }
}
