/* * * * * * * * * * * * * * * * * * * * * * * *
 * Good Teaching Search Engine Data Builder
 * Copyright (c) 2007,2010 Front Burner
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  15-Jan-2010  10528 : File created.
 * * * * * * * * * * * * * * * * * * * * * * * */

using System;
using System.Collections.ObjectModel;
using System.Xml;

namespace FrontBurner.Ministry.MseBuilder.Reader.Bbeb
{
  public enum TextPurpose
  {
    CoverTitleLarge,
    CoverTitleMedium,
    CoverTitleSmall,
    ArticleTitle,
    ArticleText
  }

  public enum TextPosition
  {
    LeftAligned,
    Centred
  }

  public class BbebTextStyle : BbebStyle
  {
    private TextPurpose _textPurpose;
    private int _fontSize;
    private TextPosition _textPosition;

    public TextPurpose TextPurpose
    {
      get { return _textPurpose; }
      set { _textPurpose = value; }
    }
    public int FontSize
    {
      get { return _fontSize; }
      set { _fontSize = value; }
    }
    public TextPosition TextPosition
    {
      get { return _textPosition; }
      set { _textPosition = value; }
    }

    public BbebTextStyle(BbebDocument doc, TextPurpose textPurpose, int fontSize, TextPosition textPosition)
      : base(doc, "TextStyle")
    {
      TextPurpose = textPurpose;
      FontSize = fontSize;
      TextPosition = textPosition;
    }

    public override void GenerateBbeb()
    {
      base.GenerateBbeb();

      AppendAttribute("fontsize", FontSize);
      AppendAttribute("fontwidth", -10);
      AppendAttribute("fontescapement", 0);
      AppendAttribute("fontorientation", 0);
      AppendAttribute("fontweight", 400);
      AppendAttribute("fontfacename", "IWA?-??N-eb");
      AppendAttribute("textcolor", "0x00000000");
      AppendAttribute("textbgcolor", "0xff000000");
      AppendAttribute("wordspace", 25);
      AppendAttribute("letterspace", 0);
      AppendAttribute("baselineskip", 140);
      AppendAttribute("linespace", 10);
      AppendAttribute("parskip", 0);
      AppendAttribute("parindent", 0);
      AppendAttribute("textlinewidth", 2);
      AppendAttribute("linecolor", "0x00000000");
      AppendAttribute("rubyoverhang", "none");
      AppendAttribute("empdotsposition", "before");
      AppendAttribute("emplineposition", "before");
      AppendAttribute("emplinetype", "none");

      if (TextPosition == TextPosition.Centred)
      {
        AppendAttribute("align", "center");
      }
      else
      {
        AppendAttribute("align", "head");
      }

      AppendAttribute("column", 1);
      AppendAttribute("columnsep", 0);
    }
  }

  public class BbebTextStyleCollection : KeyedCollection<TextPurpose, BbebTextStyle>, IBbebGenerator
  {
    public BbebTextStyleCollection(BbebDocument doc)
      : base()
    {
      Add(new BbebTextStyle(doc, TextPurpose.CoverTitleLarge, 140, TextPosition.Centred));
      Add(new BbebTextStyle(doc, TextPurpose.CoverTitleMedium, 80, TextPosition.Centred));
      Add(new BbebTextStyle(doc, TextPurpose.CoverTitleSmall, 60, TextPosition.Centred));
      Add(new BbebTextStyle(doc, TextPurpose.ArticleTitle, 140, TextPosition.LeftAligned));
      Add(new BbebTextStyle(doc, TextPurpose.ArticleText, 100, TextPosition.LeftAligned));
    }

    public void GenerateBbeb()
    {
      foreach (BbebTextStyle textStyle in this)
      {
        textStyle.GenerateBbeb();
      }
    }

    protected override TextPurpose GetKeyForItem(BbebTextStyle item)
    {
      return item.TextPurpose;
    }
  }
}
