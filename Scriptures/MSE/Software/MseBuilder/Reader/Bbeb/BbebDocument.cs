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
using System.IO;
using System.Xml;

using FrontBurner.Ministry.MseBuilder.Abstract;

namespace FrontBurner.Ministry.MseBuilder.Reader.Bbeb
{
  public class BbebDocument : XmlDocument, IBbebGenerator
  {
    private Volume _vol;
    private FileInfo _lrsFile;
    private XmlElement _root;
    private BbebGeneratorList _generators;
    private BbebBookInformation _bookInformation;
    private BbebBookStyle _bookStyle;
    private BbebPageStyle _pageStyle;
    private BbebBlockStyle _blockStyle;
    private BbebTextStyleCollection _textStyleCollection;

    public Volume Volume
    {
      get { return _vol; }
      set { _vol = value; }
    }
    public BbebBookInformation BookInformation
    {
      get { return _bookInformation; }
    }
    public BbebBookStyle BookStyle
    {
      get { return _bookStyle; }
    }
    public BbebPageStyle PageStyle
    {
      get { return _pageStyle; }
    }
    public BbebBlockStyle BlockStyle
    {
      get { return _blockStyle; }
    }
    public BbebTextStyleCollection TextStyleCollection
    {
      get { return _textStyleCollection; }
    }

    public BbebDocument(FileInfo lrsFile, Volume vol)
      : base()
    {
      BbebUtil.Instance.Reset();

      _vol = vol;
      _lrsFile = lrsFile;

      _generators = new BbebGeneratorList();

      _bookInformation = new BbebBookInformation(this);
      _bookStyle = new BbebBookStyle(this);
      _pageStyle = new BbebPageStyle(this);
      _blockStyle = new BbebBlockStyle(this);
      _textStyleCollection = new BbebTextStyleCollection(this);

      _generators.Add(_bookInformation);
      _generators.Add(_bookStyle);
      _generators.Add(_pageStyle);
      _generators.Add(_blockStyle);
      _generators.Add(_textStyleCollection);
    }

    public void GenerateBbeb()
    {
      XmlNode declaration;
      XmlElement main;
      XmlElement style;
      XmlElement objects;
      XmlAttribute attribute;

      // Create all subsections
      _generators.GenerateBbeb();

      //let's add the XML declaration section
      declaration = CreateNode(XmlNodeType.XmlDeclaration, "", "");
      AppendChild(declaration);
      //let's add the root element

      _root = CreateElement("", "BBeBXylog", "");
      AppendChild(_root);
      attribute = this.CreateAttribute("version");
      attribute.Value = "1.0";
      _root.Attributes.Append(attribute);

      _root.AppendChild(BookInformation);

      main = CreateElement("", "Main", "");
      _root.AppendChild(main);

      BbebTitlePage titlePage = new BbebTitlePage(this, PageStyle);
      main.AppendChild(titlePage);
      titlePage.GenerateBbeb();

      BbebPage page = new BbebPage(this, PageStyle);
      main.AppendChild(page);

      BbebTextBlock text = new BbebTextBlock(this, BlockStyle, TextStyleCollection[TextPurpose.ArticleTitle]);
      text.AddTitle("WASHING BY WATER");
      text.GenerateBbeb();
      page.AppendChild(text);

      text = new BbebTextBlock(this, BlockStyle, TextStyleCollection[TextPurpose.ArticleText]);
      text.AddScriptures("@John 2:6 - 11; @John 3:1 - 12");
      text.AddParagraph("JT I wish to speak of the water of purification as presented in the writings of John. In his gospel and his first epistle he presents the two elements of purification. In the gospel he relates that, the Lord being already dead, 'one of the soldiers pierced his side with a spear, and immediately there came out blood and water'. In the gospel the blood is mentioned first, whilst in the epistle the water is first. We read there, referring to Jesus, 'This is he that came by water and blood' (@1 John 5:6 - 8), 'And it is the Spirit that bears witness, for the Spirit is the truth. For they that bear witness are three: the Spirit, and the water, and the blood'. John was surely thinking that in the last days there would be a need of washing with water, the witness of the blood being more generally received than the witness of the water. Many are enjoying the forgiveness of sins by virtue of the blood without ever having understood the significance of the water, which relates to our state, so that we may be purified in a practical way from the activity of sin in us. The subject in mind, the water of purification in John's gospel, begins with these stone waterpots filled with water; then in chapter 3 water is referred to in connection with new birth, 'born of water'. In chapter 9 the blind man on whose eyes the Lord had put mud, was sent to wash in the pool of Siloam. Then in chapter 13 the Lord Himself poured water into a wash hand basin in order to wash the feet of the disciples. I thought that the first two passages mentioned, chapters 2 and 3, would be sufficient for this morning.");
      text.AddParagraph("Ques. Is purification by blood necessary first, before being washed with water?");
      text.GenerateBbeb();
      page.AppendChild(text);
      page.GenerateBbeb();

      style = CreateElement("", "Style", "");
      _root.AppendChild(style);
      style.AppendChild(BookStyle);
      style.AppendChild(PageStyle);
      style.AppendChild(BlockStyle);

      foreach (BbebTextStyle textStyle in TextStyleCollection)
      {
        style.AppendChild(textStyle);
      }

      objects = CreateElement("", "Objects", "");
      _root.AppendChild(objects);

      try
      {
        this.Save(_lrsFile.FullName);
      }
      catch (Exception e)
      {

      }
    }
  }
}
