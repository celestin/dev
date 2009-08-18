/* * * * * * * * * * * * * * * * * * * * * * * *
 * EmitScore
 * Copyright (c) 2008,2009 Front Burner Ltd
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  18-Aug-2009  10473 : Added GroupMap and search by CourseLocation.
 * * * * * * * * * * * * * * * * * * * * * * * */

using System;

using FrontBurner.Apps.EmitScore.MultiBrikke.Data;

namespace FrontBurner.Apps.EmitScore.MultiBrikke.Emit
{
  public class BadgeData
  {    
    private string _messageType;
    private int _badgeNo;
    private int _courseId;
    private SwipeList _swipeList;
    private GroupMap _groupMap;
    private LocationMap _locationMap;

    public int BadgeNo
    {
      get { return _badgeNo; }
      set 
      { 
        _badgeNo = value; 

        // Look up Course Id
        if (_groupMap.Contains((long)_badgeNo))
        {
          _courseId = _groupMap[(long)_badgeNo].CourseId;
        }

      }
    }    
    public SwipeList SwipeList
    {
      get { return _swipeList; }
      set { _swipeList = value; }
    }
    public bool IsValidBadge
    {
      get
      {
        return _messageType.Equals("M");
      }
    }

    public BadgeData(GroupMap groupMap, LocationMap locationMap, string badgeData)
    {
      _groupMap = groupMap;
      _locationMap = locationMap;
      Parse(badgeData);
      _swipeList.Process();
    }    

    protected void Parse(string badgeData)
    {
      string[] commaDelimited = badgeData.Split(new char[] { ',' });
      int i = 0;

      string item = String.Empty;
      Swipe swipe = null;
      Swipe previousSwipe = null;
      int locationId = 0;
      CourseLocation cl;
      
      _swipeList = new SwipeList();

      foreach (string value in commaDelimited)
      {
        i++;
        item = value;

        if (item.StartsWith("\""))
        {
          item = item.Substring(1, item.Length - 1);
        }

        if (item.EndsWith("\""))
        {
          item = item.Substring(0, item.Length - 1);
        }

        if (i == 1)
        {
          _messageType = item;
        }
        else if (i == 4)
        {
          BadgeNo = int.Parse(item);
        }
        else if (i >= 12)
        {
          // control values are even (10,12,14,etc)
          // time values are odd (11,13,15,etc)
          // we ignore 10&11 because they are for the start location and are zero
          bool isLocation = (((i - 10) % 2) == 0);
          locationId = int.Parse(item);

          if (isLocation && ((locationId == 0) || (locationId >= 250)))
          {
            // reached end of list
            return;
          }
          else if (isLocation)
          {
            // This is ignored because part of the process is to ensure all locations
            // are loaded prior to an event.
            //if (!_map.Contains(locationId))
            //{
            //  throw new Exception(String.Format("Could not find Location {0}!", locationId));
            //}

            cl = new CourseLocation(_courseId, locationId);
            if (_locationMap.Contains(cl.FullId))
            {
              swipe = new Swipe(_locationMap[cl.FullId], previousSwipe);
              previousSwipe = swipe;
              _swipeList.Add(swipe);
            }
          }
          else
          {
            if (swipe != null)
            {
              swipe.Cummulative = long.Parse(item);
            }
          }
        }        
      }
    }
  }
}
