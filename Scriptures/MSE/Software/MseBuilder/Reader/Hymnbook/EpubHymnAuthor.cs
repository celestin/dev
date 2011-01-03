/* * * * * * * * * * * * * * * * * * * * * * * *
 * Good Teaching Search Engine Data Builder
 * Copyright (c) 2007,2011 Front Burner
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * $Id: $
 *
 * Who  When         Why
 * CAM  03-Jan-2011  10917 : File created.
 * * * * * * * * * * * * * * * * * * * * * * * */

using System;

using FrontBurner.Ministry.MseBuilder.Reader.Epub.Article;

namespace FrontBurner.Ministry.MseBuilder.Reader.Hymnbook
{
  public class EpubHymnAuthor : EpubItem
  {
    private string _life;

    public EpubHymnAuthor(string author, string life)
      : base(author)
    {
      _life = life;
    }

    public override string RenderToXhtml()
    {
      string author = Text;
      if (_life != String.Empty) author = String.Format("{0}&nbsp;<span class=\"authorlife\">{1}</span>", author, _life);
      return String.Format("    <p class=\"author\">{0}</h3>{1}", author, Newline());
    }
  }
}
