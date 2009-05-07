/* * * * * * * * * * * * * * * * * * * * * * * *
 * EmitScore
 * Copyright (c) 2008 Southesk.com
 * Author Craig McKay <craig@southesk.com>
 *
 * $Id$
 *
 * Who  When         Why
 * * * * * * * * * * * * * * * * * * * * * * * */

using System.Data;

using Southesk.Apps.EmitScore.Emit;

namespace Southesk.Apps.EmitScore.Data
{
  public partial class EmitScoreDataSet
  {
    partial class GroupResultDataTable
    {
    }
  
    partial class LocationDataTable
    {
      public LocationMap BuildLocationMap()
      {
        LocationMap rval = new LocationMap();
        foreach (DataRow row in this.Rows)
        {
          LocationItem location = new LocationItem(int.Parse(row[LocationIdColumn].ToString()));
          location.LocationName = row[LocationNameColumn].ToString();
          location.Points=int.Parse(row[PointsColumn].ToString());
          rval.Add(location);
        }
        return rval;
      }
    }
  }
}

namespace Southesk.Apps.EmitScore.EmitScoreDataSetTableAdapters
{
  partial class TeamTableAdapter
  {
  }
}
