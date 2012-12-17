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
using System.Collections.ObjectModel;
using System.Text;

namespace FrontBurner.Tmax.Apps.MaintenanceBuildReview.Data
{
  public class Location
  {
    private ActionStatus _actionStatus;
    private string _code;
    private Changeable _description;
    private Changeable _parent;

    public ActionStatus ActionStatus
    {
      get {
        if (_actionStatus == ActionStatus.Create || _actionStatus == ActionStatus.Cancel)
        {
          return _actionStatus;
        }
        else if (Parent.HasChanged())
        {
          return ActionStatus.Parent;
        }
        else if (_actionStatus == ActionStatus.Modify || Description.HasChanged())
        {
          return ActionStatus.Modify;
        }

        return ActionStatus.None;
      }
      set { _actionStatus = value; }
    }
    public string Code
    {
      get { return _code; }
      set { _code = value; }
    }
    public Changeable Description
    {
      get { return _description; }
      set { _description = value; }
    }
    public Changeable Parent
    {
      get { return _parent; }
      set { _parent = value; }
    }

    public Location(string code)
    {
      Code = code;
    }

    public bool Match(string text)
    {
      string textUpper = text.ToUpper();
      string comparison = (Code + " " + Description.NewValue).ToUpper();

      if (comparison.Contains(textUpper)) return true;

      return false;
    }

    public override string ToString()
    {
      return String.Format("{0}  {1}", Code, Description.NewValue);
    }
  }

  public class LocationCollection : KeyedCollection<string, Location>
  {
    public LocationCollection()
    {
    }

    protected override string GetKeyForItem(Location item)
    {
      return item.Code;
    }
  }
}
