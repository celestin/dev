/* * * * * * * * * * * * * * * * * * * * * * * *
 * Ministry Search Engine Data Builder
 * Copyright (c) 2007 Front Burner
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  22-Sep-2007  File added to source control.
 * CAM  26-Sep-2007  Early working version.
 * * * * * * * * * * * * * * * * * * * * * * * */

using System;
using System.Collections;
using System.Collections.Generic;
using System.Windows.Forms;
using System.Data;
using MySql.Data;
using MySql.Data.MySqlClient;

using FrontBurner.Ministry.MseBuilder.Abstract;

namespace FrontBurner.Ministry.MseBuilder
{
  /// <summary>
  /// Retrieves MySQL data
  /// </summary>
  public class BusinessLayer
  {
    private static BusinessLayer _busLayer;
    protected static readonly object _semaphore = new object();

    protected BibleBookCollection _books;
    protected ArticleCollection _articles;
    protected VolumeCollection _volumes;

    public ArticleCollection Articles
    {
      get
      {
        return _articles;
      }
    }    
    
    private BusinessLayer()
    {
      _articles = new ArticleCollection();
    }

    public static BusinessLayer Instance
    {
      get
      {
        lock (_semaphore)
        {
          if (_busLayer == null)
          {
            _busLayer = new BusinessLayer();
          }
          return _busLayer;
        }
      }
    }

    public BibleBookCollection GetBooks()
    {
      if (_books == null)
      {
        _books = DatabaseLayer.Instance.GetBooks();
      }

      return _books;
    }

    public VolumeCollection GetVolumes()
    {
      if (_volumes == null)
      {
        _volumes = DatabaseLayer.Instance.GetVolumes();
      }

      return _volumes;
    }
  }
}
