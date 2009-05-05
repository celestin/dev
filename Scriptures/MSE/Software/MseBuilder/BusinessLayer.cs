/* * * * * * * * * * * * * * * * * * * * * * * *
 * Ministry Search Engine Data Builder
 * Copyright (c) 2007,2009 Front Burner
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  22-Sep-2007  File added to source control.
 * CAM  26-Sep-2007  Early working version.
 * CAM  28-Mar-2009  10409 : Added Footnote support.
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
  /// All Business data and processes
  /// </summary>
  public class BusinessLayer
  {
    private static BusinessLayer _busLayer;
    protected static readonly object _semaphore = new object();

    protected BibleBookCollection _books;
    protected BibleVersionCollection _versions;
    protected ArticleCollection _articles;
    protected VolumeCollection _volumes;
    protected int _nextFootnoteId;

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
      _nextFootnoteId = 1;
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

    public BibleVersionCollection GetVersions()
    {
      if (_versions == null)
      {
        _versions = DatabaseLayer.Instance.GetBibleVersions();
      }
      return _versions;
    }

    public VolumeCollection GetVolumes()
    {
      if (_volumes == null)
      {
        _volumes = DatabaseLayer.Instance.GetVolumes();
      }

      return _volumes;
    }

    public int GetNextFootnoteId()
    {
      return _nextFootnoteId++;
    }
  }
}