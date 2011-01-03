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
  public class EpubHymnHeader : EpubItem
  {
    private long _hymnNo;
    private string _meter;

    public EpubHymnHeader(long hymnNo, string meter)
      : base(meter)
    {
      _hymnNo = hymnNo;
      _meter = meter;
    }

    public override string RenderToXhtml()
    {
      return String.Format("    <p class=\"hymnno\">{0}</p><p class=\"meter\">{1}</p>{2}",
        _hymnNo, _meter, Newline());
    }
  }
}
