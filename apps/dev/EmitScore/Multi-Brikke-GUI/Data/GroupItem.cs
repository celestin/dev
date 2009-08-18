/* * * * * * * * * * * * * * * * * * * * * * * *
 * EmitScore
 * Copyright (c) 2008,2009 Front Burner Ltd
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  18-Aug-2009  10473 : File created.
 * * * * * * * * * * * * * * * * * * * * * * * */

using System;
using System.Collections.ObjectModel;
using System.Text;

namespace FrontBurner.Apps.EmitScore.MultiBrikke.Data
{
  public class GroupItem
  {
    private int _groupId;
    private int _teamId;
    private int _courseId;

    public int GroupId
    {
      get { return _groupId; }
      set { _groupId = value; }
    }
    public int TeamId
    {
      get { return _teamId; }
      set { _teamId = value; }
    }
    public int CourseId
    {
      get { return _courseId; }
      set { _courseId = value; }
    }

    public GroupItem(int groupId)
    {
      _groupId = groupId;
    }
  }

  public class GroupMap : KeyedCollection<long, GroupItem>
  {
    public GroupMap()
      : base()
    {
    }

    protected override long GetKeyForItem(GroupItem item)
    {
      return (long)item.GroupId;
    }
  }
}
