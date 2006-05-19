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
	/// <summary>
	/// Node representing Tags
	/// </summary>
	public class TagNode : AcumenNode
	{
		protected int _traffic;

    public TagNode(int id, string code, string name, int traffic) : base(id, code, name)
		{
      this.Text = code + " :: " + name;
      this.ImageIndex = 3;
      this.SelectedImageIndex = 1;

      this._traffic = traffic;
		}

    public int Traffic 
    {
      get 
      {
        return this._traffic;
      }
    }
	}
}
