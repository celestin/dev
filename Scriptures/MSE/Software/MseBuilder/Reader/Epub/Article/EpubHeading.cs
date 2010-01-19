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
  public class EpubHeading : EpubItem
  {
    public EpubHeading(string text)
      : base(text)
    {
    }

    public override string RenderToXhtml()
    {
      return String.Format("    <p class=\"title\">{0}<cr /></p>", Text);
    }
  }
}
