/* * * * * * * * * * * * * * * * * * * * * * * *
 * Good Teaching Search Engine Data Builder
 * Copyright (c) 2007,2010 Front Burner
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  19-Jan-2010  10540 : File created.
 * * * * * * * * * * * * * * * * * * * * * * * */

using System;

namespace FrontBurner.Ministry.MseBuilder.Reader.Epub.Article
{
  public class EpubParagraph : EpubItem
  {
    private string _inits;

public string Inits
{
  get { return _inits; }
  set { _inits = value; }
}

    public EpubParagraph(string inits, string text)
      : base(text)
    {
      Inits = inits;
    }

    public EpubParagraph(string text)
      : this("", text)
    {
    }

    public override string RenderToXhtml()
    {
      string initials = "";

      if (Inits.Length > 0)
      {
        initials= String.Format("<span class=\"init\">{0}</span>&nbsp;", Inits);
      }

      return String.Format("    <p>{0}{1} </p>{2}", initials, Text, Newline());
    }
  }
}
