/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 * Maia Systems Acumen
 * Copyright (c) 2006 Maia Systems
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * Schematic Node in the tree
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
  /// Node representing Schematic diagrams containing Tags.
  /// </summary>
	public class SchematicNode : AcumenNode
	{
		public SchematicNode(int id, string code, string name) : base(id, code, name)
		{      
      this.ImageIndex = 4;
      this.SelectedImageIndex = 1;
		}
	}
}
