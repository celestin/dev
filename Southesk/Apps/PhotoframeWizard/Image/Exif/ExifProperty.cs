/* * * * * * * * * * * * * * * * * * * * * * * *
 * Photoframe Wizard
 * Copyright (c) 2009 Front Burner
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  02-Jan-2009  File created.
 * CAM  02-Jan-2009  Improved properties handling.
 * * * * * * * * * * * * * * * * * * * * * * * */

using System;
using System.Collections.Generic;
using System.Text;

namespace Fb.Apps.PhotoframeWizard.Image.Exif
{
  public class ExifProperty
  {
    private int _id;
    private string _value;

    public int Id
    {
      get
      {
        return _id;
      }
    }

    public string Value
    {
      get
      {
        return _value;
      }
    }

    public ExifProperty(int id, string value)
    {
      _id = id;
      _value = value;
    }
  }
}
