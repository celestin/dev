/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 * Krakatau Essential PM (KEPM)
 * Copyright (c) 2009 PowerSoftware.com
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  11-Nov-2009  10502 : Added ExtList.
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

using System;
using System.Collections.ObjectModel;
using System.IO;
using System.Text;

namespace PowerSoftware.Krakatau.Kepm.Config
{
  public class DirectoryMap : KeyedCollection<string, DirectoryInfo>
  {
    public DirectoryMap()
      : base()
    {
    }

    protected override string GetKeyForItem(DirectoryInfo item)
    {
      return item.FullName;
    }

    public bool Exists(DirectoryInfo check)
    {
      foreach (DirectoryInfo dir in this)
      {
        if (check.FullName.Equals(dir.FullName)) return true;
      }

      return false;
    }
  }
}
