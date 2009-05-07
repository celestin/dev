/* * * * * * * * * * * * * * * * * * * * * * * *
 * EmitScore
 * Copyright (c) 2009 Front Burner Ltd
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  07-May-2009  10444 : Changed to Front Burner.
 * * * * * * * * * * * * * * * * * * * * * * * */

using System.Data;

using FrontBurner.Apps.EmitScore.Emit;

namespace FrontBurner.Apps.EmitScore.Data
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

namespace FrontBurner.Apps.EmitScore.EmitScoreDataSetTableAdapters
{
  partial class TeamTableAdapter
  {
  }
}
