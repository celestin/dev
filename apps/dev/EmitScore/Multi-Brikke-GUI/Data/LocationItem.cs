/* * * * * * * * * * * * * * * * * * * * * * * *
 * EmitScore
 * Copyright (c) 2008,2009 Front Burner Ltd
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  18-Aug-2009  10473 : Added CourseLocation.
 * * * * * * * * * * * * * * * * * * * * * * * */

using System;
using System.Collections.ObjectModel;
using System.Text;

namespace FrontBurner.Apps.EmitScore.MultiBrikke.Data
{
  public class CourseLocation
  {
    private int _courseId;
    private int _locationId;

    public string FullId
    {
      get
      {
        return String.Format("{0}-{1}", CourseId, LocationId);
      }
    }

    public int CourseId
    {
      get { return _courseId; }
      set { _courseId = value; }
    }

    public int LocationId
    {
      get { return _locationId; }
      set { _locationId = value; }
    }

    public CourseLocation(int course, int location)
    {
      CourseId = course;
      LocationId = location;
    }

    public override string ToString()
    {
      return String.Format("{0},{1}", CourseId, LocationId);
    }
  }

  public class LocationItem
  {
    private CourseLocation _courseLocation;
    private string _locationName;
    private int _points;

    public CourseLocation CourseLocation
    {
      get { return _courseLocation; }
      set { _courseLocation = value; }
    }
    public int LocationId
    {
      get
      {
        return _courseLocation.LocationId;
      }
    }
    public int CourseId
    {
      get
      {
        return _courseLocation.CourseId;
      }
    }
    public string LocationName
    {
      get { return _locationName; }
      set { _locationName = value; }
    }
    public int Points
    {
      get { return _points; }
      set { _points = value; }
    }

    public LocationItem(CourseLocation courseLocation)
    {
      _courseLocation = courseLocation;
    }

    public LocationItem(CourseLocation courseLocation, string locationName, int points)
    {
      _courseLocation = courseLocation;
      _locationName = locationName;
      _points = points;
    }
  }

  public class LocationMap : KeyedCollection<string, LocationItem>
  {
    public LocationMap()
      : base()
    {
    }
    protected override string GetKeyForItem(LocationItem item)
    {
      return item.CourseLocation.FullId;
    }
  }
}
