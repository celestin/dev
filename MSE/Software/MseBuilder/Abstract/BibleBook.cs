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
using System.Collections.ObjectModel;
using System.Text;

namespace FrontBurner.Ministry.MseBuilder.Abstract
{
  public class BibleBook
  {
    protected int _bookId;
    protected string _bookName;
    protected bool _singleChap;

    public int BookId 
    {
      get
      {
        return _bookId;
      }
    }
    public string BookName
    {
      get
      {
        return _bookName;
      }
    }
    public bool SingleChap
    {
      get
      {
        return _singleChap;
      }
      set
      {
        _singleChap = value;
      }
    }

    public BibleBook(int bookId, string bookName)
    {
      _bookId = bookId;
      _bookName = bookName;
      _singleChap = false;
    }

    public BibleBook(int bookId, string bookName, int singleChap)
    {
      _bookId = bookId;
      _bookName = bookName;
      _singleChap = (singleChap == 1);
    }

    public bool Matches(string text)
    {
      int len = _bookName.Length;
      if (text.Length < len) len = text.Length;

      return _bookName.ToUpper().Equals(text.Substring(0, len).ToUpper());
    }
  }

  public class BibleBookCollection : KeyedCollection<int, BibleBook>
  {
    public BibleBookCollection()
      : base()
    {
    }

    protected override int GetKeyForItem(BibleBook book)
    {
      return book.BookId;
    }
  }
}
