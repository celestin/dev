/* * * * * * * * * * * * * * * * * * * * * * * *
 * EmitScore
 * Copyright (c) 2008,2009 Front Burner Ltd
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  18-Aug-2009  10473 : Added GroupMap and modified LocationMap to include Course.
 * * * * * * * * * * * * * * * * * * * * * * * */

using System.Data;

using FrontBurner.Apps.EmitScore.MultiBrikke.Emit;

namespace FrontBurner.Apps.EmitScore.MultiBrikke.Data
{
  public partial class EmitScoreDataSet
  {
    partial class GroupTeamDataTable
    {
      public GroupMap BuildGroupMap()
      {
        GroupMap rval = new GroupMap();
        foreach (DataRow row in this.Rows)
        {
          GroupItem group = new GroupItem(
            int.Parse(row[GroupIdColumn].ToString()));
          group.CourseId = int.Parse(row[CourseIdColumn].ToString());
          rval.Add(group);
        }
        return rval;
      }
    }

    partial class LocationDataTable
    {
      public LocationMap BuildLocationMap()
      {
        LocationMap rval = new LocationMap();
        foreach (DataRow row in this.Rows)
        {
          LocationItem location = new LocationItem(
            new CourseLocation(
              int.Parse(row[CourseIdColumn].ToString()),
              int.Parse(row[LocationIdColumn].ToString())));
          location.LocationName = row[LocationNameColumn].ToString();
          location.Points=int.Parse(row[PointsColumn].ToString());
          rval.Add(location);
        }
        return rval;
      }
    }
  }
}

namespace FrontBurner.Apps.EmitScore.MultiBrikke.EmitScoreDataSetTableAdapters
{
  partial class TeamTableAdapter
  {
  }
}
