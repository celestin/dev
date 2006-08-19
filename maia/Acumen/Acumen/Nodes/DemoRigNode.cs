/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 * Maia Systems Acumen
 * Copyright (c) 2006 Maia Systems
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * DemoRig Node in the tree
 *
 * $Id: TagNode.cs 116 2006-05-19 22:10:25Z craig $
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
	public class DemoRigNode : AcumenNode
	{
    public DemoRigNode(int id, string code, string name) : base(id, code, name)
		{
      this.Text = code + " :: " + name;
      this.ImageIndex = 3;
      this.SelectedImageIndex = 1;
		}
	}
}
