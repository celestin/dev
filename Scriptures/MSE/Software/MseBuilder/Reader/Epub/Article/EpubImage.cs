/* * * * * * * * * * * * * * * * * * * * * * * *
 * Good Teaching Search Engine Data Builder
 * Copyright (c) 2007,2010 Front Burner
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  21-Jan-2010  10546 : File created.
 * * * * * * * * * * * * * * * * * * * * * * * */

using System;

namespace FrontBurner.Ministry.MseBuilder.Reader.Epub.Article
{
  public class EpubImage : EpubItem
  {
    public EpubImage(string src)
      : base(src)
    {
    }

    public override string RenderToXhtml()
    {
      return String.Format("    <img src=\"img/{0}\" />", Text);
    }
  }
}
