/* * * * * * * * * * * * * * * * * * * * * * * *
 * Good Teaching Search Engine Data Builder
 * Copyright (c) 2007,2010 Front Burner
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  19-Jan-2010  10540 : File created.
 * CAM  23-Jan-2010  10553 : Ensure valid XHTML.
 * * * * * * * * * * * * * * * * * * * * * * * */

using System;
using System.Collections.Generic;

using FrontBurner.Ministry.MseBuilder.Engine;

namespace FrontBurner.Ministry.MseBuilder.Reader.Epub.Article
{
  public abstract class EpubItem
  {
    private string _text;

    public string Text
    {
      get { return _text; }
      set
      {
        _text = value;

        _text = _text.Replace("&", "&amp;");
        _text = _text.Replace("@", "");
        _text = _text.Replace("*", ""); // TODO: make italics work
        _text = _text.Replace("~", "&rsquo;"); // Apostrophes
        _text = _text.Replace("--", "&mdash;");
        _text = _text.Replace("\"", "&quot;");
        _text = _text.Replace("<br>", "<br />"); // XHTML
      }
    }

    protected EpubItem(string text)
    {
      Text = text;
    }

    public abstract string RenderToXhtml();

    public string Newline()
    {
      if (EngineSettings.Instance.Mode == BuildMode.SonyEpub)
      {
        return "<p>&nbsp;</p>";
      }

      return String.Empty;
    }
  }


  public class EpubItemCollection : List<EpubItem>
  {
  }
}
