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

using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;

using FrontBurner.Apps.EmitScore.Data;

namespace FrontBurner.Apps.EmitScore.Emit
{
  public class Swipe
  {
    private LocationItem _location;
    private long _seconds;
    private long _cummulative;
    private int _points;

    private Swipe _previous;

    public LocationItem Location
    {
      get { return _location; }
    }
    public string Id
    {
      get
      {
        return String.Format("-{0}-", _location.Id);
      }
    }
    public long Seconds
    {
      get { return _seconds; }
    }
    public DateTime LocationTime
    {
      get
      {
        return ConvertSecondsToTime(_seconds);
      }
    }
    public long Cummulative
    {
      get { return _cummulative; }
      set
      {
        _cummulative = value;
        _seconds = _cummulative;

        if (_previous != null)
        {
          _seconds -= _previous._seconds;
        }
      }
    }
    public DateTime CummulativeTime
    {
      get
      {
        return ConvertSecondsToTime(_cummulative);
      }
    }
    public int Points
    {
      get { return _points; }
      set { _points = value; }
    }

    public Swipe(LocationItem location, Swipe previous)
    {
      _location = location;
      _seconds = _cummulative = 0;
      _previous = previous;
      _points = 0;
    }

    public static DateTime CreateBaseDate()
    {
      DateTime now = DateTime.Now;
      return new DateTime(now.Year, now.Month, now.Day, 0, 0, 0, 0);
    }

    public static DateTime ConvertSecondsToTime(long seconds)
    {
      return CreateBaseDate().AddSeconds(seconds);
    }
  }

  public class SwipeList : List<Swipe>
  {
    private int _totalPoints;
    private int _nettPoints;
    private DateTime _totalTime;
    private bool _timeDisqualified;

    public int TotalPoints
    {
      get { return _totalPoints; }
      set { _totalPoints = value; }
    }
    public int NettPoints
    {
      get { return _nettPoints; }
      set { _nettPoints = value; }
    }
    public DateTime TotalTime
    {
      get { return _totalTime; }
      set { _totalTime = value; } // to be removed
    }
    public int TimeDisqualified
    {
      get { return _timeDisqualified ? 1 : 0; }
    }

    public SwipeList()
    {
    }

    public void Process()
    {
      SwipeMap map = new SwipeMap();
      _totalPoints = 0;

      foreach (Swipe swipe in this)
      {
        swipe.Points = swipe.Location.Points;

        if (map.Contains(swipe.Id))
        {
          // Someone is visiting a location twice - remove points
          swipe.Points = 0;
        }
        else
        {
          map.Add(swipe);
        }

        _totalPoints += swipe.Points;
        _totalTime = swipe.CummulativeTime;
      }
    }

    public void AdjustPoints()
    {
      DateTime timeLimit = Swipe.CreateBaseDate().AddHours(5);
      int diff = (int)_totalTime.Subtract(timeLimit).TotalMinutes;

      _nettPoints = _totalPoints;
      _timeDisqualified = false;

      if (diff <= 0)
      {
        // on time
      }
      else if (diff > 30)
      {
        // more than 30 minutes late
        _nettPoints = 0; // harsh!
        _timeDisqualified = true;
      }
      else
      {
        // Reduce points by band
        for (int band = 1; band <= diff; band++)
        {
          if (band <= 10)
          {
            _nettPoints -= 5;
          }
          else if (band <= 20)
          {
            _nettPoints -= 10;
          }
          else if (band <= 30)
          {
            _nettPoints -= 20;
          }          
        }
      }
    }
  }

  public class SwipeMap : KeyedCollection<string, Swipe>
  {
    public SwipeMap()
      : base()
    {
    }

    protected override string GetKeyForItem(Swipe item)
    {
      return item.Id;
    }
  }
}
