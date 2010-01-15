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
using System.Text;
using System.Xml;

namespace FrontBurner.Ministry.MseBuilder.Reader.Bbeb
{
  public class BbebTextBlock: BbebObjElement
  {
    private BbebBlockStyle _blockStyle;
    private BbebTextStyle _textStyle;

    public BbebBlockStyle BlockStyle
    {
      get { return _blockStyle; }
      set { _blockStyle = value; }
    }
    public BbebTextStyle TextStyle
    {
      get { return _textStyle; }
      set { _textStyle = value; }
    }

    public BbebTextBlock(BbebDocument doc, BbebBlockStyle blockStyle, BbebTextStyle textStyle)
      : base(doc, "TextBlock")
    {
      _blockStyle = blockStyle;
      _textStyle = textStyle;
    }

    public void AddTitle(string text)
    {
      AddParagraph(text, false);
    }

    public void AddScriptures(string text)
    {
      XmlElement para = CreateParagraph();
      XmlElement italics = CreateItalics();
      para.AppendChild(italics);
      italics.AppendChild(CreateText(text));
      para.AppendChild(CreateNewline());
      para.AppendChild(CreateNewline());

      AppendChild(para);
    }

    public void AddParagraph(string text)
    {
      AddParagraph(text, true);
    }

    public void AddParagraph(string text, bool newline)
    {
      // TODO: Replace ** with Italics, etc
      XmlElement para = CreateParagraph();
      para.AppendChild(CreateText(text));

      if (newline)
      {
        para.AppendChild(CreateNewline());
        para.AppendChild(CreateNewline());
      }

      AppendChild(para);
    }

    public void AddNewline()
    {
      AppendChild(CreateNewline());
    }

    protected XmlText CreateText(string text)
    {
      text = text.Replace("@", "");
      text = text.Replace("*", ""); // TODO: make italics work
      return OwnerDocument.CreateTextNode(text);
    }

    protected XmlElement CreateParagraph()
    {
      return OwnerDocument.CreateElement("", "P", "");
    }
    protected XmlElement CreateItalics()
    {
      return OwnerDocument.CreateElement("", "Italic", "");
    }
    protected XmlElement CreateNewline()
    {
      return OwnerDocument.CreateElement("", "CR", "");
    }

    public override void GenerateBbeb()
    {
      base.GenerateBbeb();

      AppendAttribute("blockstyle", BlockStyle);
      AppendAttribute("textstyle", TextStyle);
    }
  }
}
