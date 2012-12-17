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
using System.Collections.Generic;
using System.Text;

namespace FrontBurner.Tmax.Apps.MaintenanceBuildReview.Data
{
  public enum ActionStatus
  {
    Create,
    Modify,
    Cancel,
    Parent,
    None
  }

  public class ActionStatuses
  {
    public static ActionStatus GetActionStatus(string value)
    {
      switch (value)
      {
        case "Create":
          return ActionStatus.Create;
        case "Modify":
          return ActionStatus.Modify;
        case "Cancel":
          return ActionStatus.Cancel;
        default:
          return ActionStatus.None;
      }
    }

    public static String ToString(ActionStatus value)
    {
      switch (value)
      {
        case ActionStatus.Create:
          return "Created";
        case ActionStatus.Modify:
          return "Modified";
        case ActionStatus.Cancel:
          return "Cancelled";
        case ActionStatus.Parent:
          return "Re-parented";
        default:
          return "No change";
      }
    }
  }
}
