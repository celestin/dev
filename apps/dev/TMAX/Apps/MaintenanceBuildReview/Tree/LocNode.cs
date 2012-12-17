/* * * * * * * * * * * * * * * * * * * * * * * *
 * TMAX Maintenance Build Review
 * Copyright (c) 2012 Front Burner Ltd
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  17-Dec-2012  11149 : Created.
 * * * * * * * * * * * * * * * * * * * * * * * */

using System;
using System.Windows.Forms;

using FrontBurner.Tmax.Apps.MaintenanceBuildReview.Data;

namespace FrontBurner.Tmax.Apps.MaintenanceBuildReview.Tree
{
  public class LocNode : TreeNode
  {
    private Location _location;

    public Location Location
    {
      get { return _location; }
      set { _location = value; }
    }

    public string Code
    {
      get { return Location.Code; }
    }
    public string ParentLocation
    {
      get { return Location.Parent.NewValue; }
    }

    public LocNode(Location loc)
      : base(loc.Code + "  " + loc.Description.NewValue)
    {
      Location = loc;

      switch (Location.ActionStatus)
      {
        case ActionStatus.Create:
          ImageIndex = 1;
          break;
        case ActionStatus.Modify:
          ImageIndex = 2;
          break;
        case ActionStatus.Parent:
          ImageIndex = 4;
          break;
        case ActionStatus.Cancel:
          ImageIndex = 3;
          break;
        default:
          ImageIndex=0;
          break;
      }

      SelectedImageIndex = ImageIndex;
    }
  }
}
