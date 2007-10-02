/* * * * * * * * * * * * * * * * * * * * * * * *
 * Ministry Search Engine Data Builder
 * Copyright (c) 2007 Front Burner
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  22-Sep-2007  File added to source control.
 * * * * * * * * * * * * * * * * * * * * * * * */

using System;
using System.Collections.Generic;
using System.Text;
using System.Windows.Forms;
using System.Threading;

using FrontBurner.Ministry.MseBuilder.Abstract;

namespace FrontBurner.Ministry.MseBuilder
{
  public class MseEngine
  {
    protected int _current;

    public int Current
    {
      get
      {
        return _current;
      }
    }

    public MseEngine()
    {
      DatabaseLayer.Instance.Open();
    }

    public void Build(string author, int vol)
    {
      VolumeCollection vols = BusinessLayer.Instance.GetVolumes();
      Volume vol1 = null;

      try
      {
        vol1 = vols[Volume.GetId(author, vol)];
      }
      catch (Exception)
      {
        throw;
      }

      if (vol1 != null)
      {
        Build(vol1);
      }
    }

    public void Build(Volume vol)
    {
      //MessageBox.Show(String.Format("Author {0} Vol {1}", vol.Author, vol.Vol));

      DatabaseLayer.Instance.DeleteVolume(vol);
      MseParser parser = new MseParser(vol);

      //parser.ParseArticles();
      parser.ParseText();
    }

    public void Build()
    {
      VolumeCollection vols = DatabaseLayer.Instance.GetVolumes();
      _current = 0;

      DatabaseLayer.Instance.TruncateTables();

      foreach (Volume vol in vols)
      {
        Build(vol);
        _current++;
        Thread.Sleep(2000);
      }
    }
  }
}
