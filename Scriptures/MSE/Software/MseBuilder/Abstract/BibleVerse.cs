/* * * * * * * * * * * * * * * * * * * * * * * *
 * Ministry Search Engine Data Builder
 * Copyright (c) 2008 Front Burner
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * $Id: $
 *
 * Who  When         Why
 * CAM  15-Jun-2008  10409 : File created.
 * * * * * * * * * * * * * * * * * * * * * * * */

using System;
using System.Collections.ObjectModel;
using System.Text;

namespace FrontBurner.Ministry.MseBuilder.Abstract
{
  /// <summary>
  /// Representation of a Bible Verse.
  /// </summary>
  public class BibleVerse : Collection<BibleXref>
  {
    private BibleBook _book;
    private string _shortCode;
    private int _chapter;
    private int _verse;
    private string _text;

    public BibleBook Book
    {
      get
      {
        return _book;
      }
    }
    public string ShortCode
    {
      get
      {
        return _shortCode;
      }
      set
      {
        _shortCode = value;
      }
    }
    public virtual string FullId
    {
      get
      {
        return String.Format("{0}?n={1}", _book.ShortCode, this._shortCode);
      }
    }
    public int Chapter
    {
      get
      {
        return _chapter;
      }
    }
    public int Verse
    {
      get
      {
        return _verse;
      }
    }
    public string Text
    {
      get
      {
        return _text; 
      }
      set
      {
        _text = value.Replace("&amp;", "&");
      }
    }

    public BibleVerse(BibleBook book, string shortCode, string text)
    {
      _book = book;
      _shortCode = shortCode;

      int colon = shortCode.IndexOf(":");
      if (colon > 0)
      {
        _chapter = int.Parse(shortCode.Substring(0, colon).Trim());
        
        shortCode = shortCode.Substring(colon + 1, shortCode.Length - colon - 1).Trim();
        string verse = "";
        for (int i = 0; i < shortCode.Length; i++)
        {
          if (shortCode[i] >= 48 && shortCode[i] <= 57)
          {
            verse += shortCode[i];
          }
        }
        _verse = int.Parse(verse);
      }

      Text = text;
    }

    protected override void InsertItem(int index, BibleXref item)
    {
      base.InsertItem(index, item);
      item.InstanceId = this.Count;
    }
  }

  public class BibleVerseCollection : KeyedCollection<string, BibleVerse>
  {
    private BibleBook _book;

    public BibleVerseCollection(BibleBook book)
      : base()
    {
      _book = book;
    }

    protected override string GetKeyForItem(BibleVerse item)
    {
      return item.ShortCode;
    }

    protected override void InsertItem(int index, BibleVerse item)
    {
      base.InsertItem(index, item);
      _book.Elements.Add(item);
    }
  }

  public class BibleElementsCollection : KeyedCollection<string, BibleVerse>
  {
    public BibleElementsCollection()
      : base()
    {
    }

    protected override string GetKeyForItem(BibleVerse item)
    {
      return item.FullId;
    }
  }
}
