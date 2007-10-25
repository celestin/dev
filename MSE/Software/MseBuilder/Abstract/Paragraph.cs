/* * * * * * * * * * * * * * * * * * * * * * * *
 * Ministry Search Engine Data Builder
 * Copyright (c) 2007 Front Burner
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * $Id $
 *
 * Who  When         Why
 * CAM  01-Oct-2007  File created.
 * * * * * * * * * * * * * * * * * * * * * * * */

using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Text;
using System.Windows.Forms;

namespace FrontBurner.Ministry.MseBuilder.Abstract
{
  public class Paragraph :  Collection<BibleRef>
  {
    protected Volume _vol;
    protected int _pageNo;
    protected int _para;
    protected int _localRow;
    protected string _inits;
    protected string _text;

    public string Id
    {
      get
      {
        return GetId(_vol, _para);
      }
    }
    public Volume Volume
    {
      get
      {
        return _vol;
      }
    }
    public int PageNo
    {
      get
      {
        return _pageNo;
      }
      set
      {
        _pageNo = value;
      }
    }
    public int Para
    {
      get
      {
        return _para;
      }
      set
      {
        _para = value;
      }
    }
    public int LocalRow
    {
      get
      {
        return _localRow;
      }
      set
      {
        _localRow = value;
      }
    }
    public string Inits
    {
      get
      {
        return _inits;
      }
      set
      {
        _inits = value;
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
        _text = value.Trim();
      }
    }

    public Article Article
    {
      get
      {
        return new Article(_vol, _pageNo, _para, _localRow, _text);
      }
    }

    public Paragraph(Volume vol, int pageNo, int para, int localRow, string inits, string text)
      : base()
    {
      _vol = vol;
      _pageNo = pageNo;
      _para = para;
      _localRow = localRow;
      _inits = inits;
      _text = text.Trim();

      ParseBibleRefs();
    }

    protected void ParseBibleRefs()
    {
      // Parse Scriptures
      if (_text.IndexOf("@") >= 0)
      {
        string[] refs = _text.Split(new Char[] { '@' });

        for (int i = 1; i < refs.Length; i++)
        {
          BibleRef bref = new BibleRef(refs[i]);

          if (bref.RefValid)
          {
            this.Add(bref);
          }
          else
          {
            DatabaseLayer.Instance.InsertBadBibleRef(_vol, _pageNo, _para, i, bref.ErrCode, refs[i]);
          }
        }
      }
    }

    public void Augment(Paragraph previous)
    {
      _pageNo = previous._pageNo;
      _para = previous._para;
      _localRow = previous._localRow;
      _inits = previous._inits;
      _text = string.Format("{0} {1}", previous.Text, this.Text);

      foreach (BibleRef bref in previous)
      {
        this.InsertItem(0, bref);
      }
    }

    public bool EndsAbruptly(bool specialLine)
    {
      if (specialLine || (_text.Length == 0)) return false;

      char[] lastChar = _text.Substring(_text.Length - 1).ToCharArray();
      switch (lastChar[0])
      {
        case '.':
        case '!':
        case '?':
          return false;
      }
      return true;
    }

    public bool IsTitle()
    {
      int upper;
      int lower;
      int html;
      int other;
      int c;

      upper = lower = html = other = 0;
      char[] buffa = _text.ToCharArray();
      for (int i = 0; i < buffa.Length; i++)
      {
        c = (int)buffa[i];
        if (c >= 65 && c <= 90)
        {
          upper++;
        }
        else if (c >= 97 && c <= 122)
        {
          lower++;
        }
        else if (c == 60 || c == 62)
        {
          html++;
        }
        else if (c == 34 || c == 39 || c == 32 || c == 13 || c == 10 || c == 58 || c == 45)
        {
          // ignore quotes/ws in the 'other' count
        }
        else if (c == 46)
        {
          other++;
        }
        else
        {
          // other++;
        }
      }

      if (((upper + lower) > 0) && (html == 0) && (!_text.Equals("PREFATORY NOTE")) && (!_text.Equals("*NOTE*")))
      {
        if ((upper / (upper + lower + other)) > 0.7)
        {
          return true;
        }
      }
      return false;
    }

    public void SaveToDatabase()
    {
      DatabaseLayer.Instance.InsertParagraph(this);

      int i = 1;
      foreach (BibleRef bref in this)
      {
        DatabaseLayer.Instance.InsertBibleRef(this, i++, bref);
      }
    }

    public static string GetId(Volume vol, int para)
    {
      return String.Format("{0}-{1}", vol.Id, para);
    }
  }
}