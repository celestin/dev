/* * * * * * * * * * * * * * * * * * * * * * * *
 * Ministry Search Engine Data Builder
 * Copyright (c) 2008 Front Burner
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * $Id: $
 *
 * Who  When         Why
 * CAM  15-Jun-2008  10409 : File added.
 * * * * * * * * * * * * * * * * * * * * * * * */

using System;
using System.Collections.Generic;
using System.Text;
using System.Windows.Forms;

namespace FrontBurner.Ministry.MseBuilder.Abstract
{
  public enum XrefType
  {
    VerseToFootnote = 1,
    FootnoteToVerse = 2,
    FootnoteToFootnote = 3
  }

  public class BibleXref
  {
    private string _xref;
    private string _word;
    private BibleBook _book;
    private string _fullId;
    private XrefType _type;
    private BibleVerse _refTo;
    private BibleVerse _refFrom;
    private int _instanceId;

    public BibleBook Book
    {
      get
      {
        return _book;
      }
    }
    public string FullId
    {
      get
      {
        return _fullId;
      }       
    }
    public XrefType Type
    {
      get
      {
        return _type;
      }
    }
    public string Word
    {
      get
      {
        return _word;
      }
    }
    public BibleVerse RefFrom
    {
      get
      {
        return _refFrom;
      }
    }
    public BibleVerse RefTo
    {
      get
      {
        return _refTo;
      }
    }
    public int InstanceId
    {
      get
      {
        return _instanceId;
      }
      set
      {
        _instanceId = value;
      }
    }

    public BibleXref(BibleVerse refFrom, XrefType type, string xref, string word)
    {
      _refFrom = refFrom;
      _type = type;
      _xref = xref;
      _word = word;
    }

    public bool AddXref(BibleVersion version)
    {
      const string Slash = "/";
      const string FootnotePrefix = "n_";
      const string Separator = "?n=";
      int p;
      string bookCode = _xref;

      if ((p = bookCode.LastIndexOf(Slash)) >= 0)
      {
        bookCode = bookCode.Substring(p + 1, bookCode.Length - p - 1);
      }

      _fullId = bookCode; // Full Id is the Xref without the leading path and script name

      if (bookCode.StartsWith(FootnotePrefix))
      {
        bookCode = bookCode.Substring(FootnotePrefix.Length, bookCode.Length - FootnotePrefix.Length);
      }

      if ((p = bookCode.IndexOf(Separator)) >= 0)
      {
        _book = version.FindBookByShortCode(bookCode.Substring(0, p));
      }

      if (_book == null || _fullId.Length == 0) return false;

      if (_book.BookId == 62)
      {
        int x = 1;
      }

      if (!_book.Elements.Contains(_fullId) || _refFrom == null) return false;

      _refTo = _book.Elements[_fullId];
      _refTo.Add(this);

      return true;
    }
  }
}
