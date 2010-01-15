/* * * * * * * * * * * * * * * * * * * * * * * *
 * Good Teaching Search Engine Data Builder
 * Copyright (c) 2007,2010 Front Burner
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  15-Jan-2010  10528 : File created.
 * CAM  15-Jan-2010  10529 : Converted Volume.Author from string to Author class.
 * * * * * * * * * * * * * * * * * * * * * * * */

using System;
using System.Text;

using FrontBurner.Ministry.MseBuilder.Abstract;

namespace FrontBurner.Ministry.MseBuilder.Reader.Bbeb
{
  public class BbebTitlePage : BbebPage
  {
    public BbebTitlePage(BbebDocument doc, BbebPageStyle pageStyle)
      : base(doc, pageStyle)
    {
    }

    public override void GenerateBbeb()
    {
      base.GenerateBbeb();

      BbebDocument doc = (BbebDocument)OwnerDocument;

      BbebTextBlock text = new BbebTextBlock(doc, doc.BlockStyle, doc.TextStyleCollection[TextPurpose.CoverTitleLarge]);
      text.AddNewline();
      text.AddNewline();
      text.AddNewline();
      text.AddTitle(doc.Volume.Author.Name);
      AppendChild(text);
      text.GenerateBbeb();

      text = new BbebTextBlock(doc, doc.BlockStyle, doc.TextStyleCollection[TextPurpose.CoverTitleLarge]);
      AppendChild(text);

      if (doc.Volume.Title.Length > 0)
      {
        text.AddTitle(doc.Volume.Title);
      }
      else
      {
        text.AddTitle(String.Format("Volume {0}", doc.Volume.Vol));
      }
      text.GenerateBbeb();

      if (doc.Volume.Series.Length > 0)
      {
        text = new BbebTextBlock(doc, doc.BlockStyle, doc.TextStyleCollection[TextPurpose.CoverTitleMedium]);
        text.AddTitle(doc.Volume.Series);
        AppendChild(text);
        text.GenerateBbeb();
      }

      text = new BbebTextBlock(doc, doc.BlockStyle, doc.TextStyleCollection[TextPurpose.CoverTitleSmall]);
      text.AddNewline();
      text.AddNewline();
      text.AddNewline();
      text.AddNewline();
      text.AddNewline();
      text.AddNewline();
      text.AddParagraph("Produced from GoodTeaching.org", false);
      text.AddNewline();
      text.AddParagraph(String.Format("by Craig McKay {0:d-MMM-yyyy}", DateTime.Now), false);
      AppendChild(text);
      text.GenerateBbeb();
    }
  }
}
