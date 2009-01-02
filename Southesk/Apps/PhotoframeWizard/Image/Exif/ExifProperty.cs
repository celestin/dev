/* * * * * * * * * * * * * * * * * * * * * * * *
 * Photoframe Wizard
 * Copyright (c) 2009 Front Burner
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * $Id: $
 *
 * Who  When         Why
 * CAM  02-Jan-2009  File created.
 * * * * * * * * * * * * * * * * * * * * * * * */

using System;
using System.Collections.Generic;
using System.Text;

namespace Fb.Apps.PhotoframeWizard.Image.Exif
{
  class ExifProperty
  {
    private object _id;
    private object _value;

    public object Id
    {
      get
      {
        return _id;
      }
    }

    public object Value
    {
      get
      {
        return _value;
      }
    }

    public ExifProperty(object id, object value)
    {
      _id = id;
      _value = value;
    }
  }
}
