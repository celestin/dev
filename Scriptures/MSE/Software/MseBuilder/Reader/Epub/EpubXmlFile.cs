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
using System.IO;
using System.Xml;

using FrontBurner.Ministry.MseBuilder.Abstract;

namespace FrontBurner.Ministry.MseBuilder.Reader.Epub
{
  public abstract class EpubXmlFile : XmlDocument, IEpubGenerator
  {
    private DirectoryInfo _dir;
    private FileInfo _file;
    private XmlElement _root;
    private Volume _volume;

    public abstract string XmlFilename
    {
      get;
    }
    public abstract string RootName
    {
      get;
    }
    public DirectoryInfo Dir
    {
      get { return _dir; }
      set
      {
        _dir = value;
        _file = new FileInfo(String.Format(@"{0}\{1}", _dir.FullName, XmlFilename));
      }
    }
    public FileInfo File
    {
      get { return _file; }
    }
    public Volume Volume
    {
      get { return _volume; }
      set { _volume = value; }
    }
    protected XmlElement Root
    {
      get { return _root; }
      set { _root = value; }
    }

    public EpubXmlFile(DirectoryInfo dir, Volume volume)
      : base()
    {
      Dir = dir;
      Volume = volume;
    }

    public virtual void GenerateEpub()
    {
      AppendChild(CreateNode(XmlNodeType.XmlDeclaration, "", ""));

      AddDocumentType();

      Root = CreateElement("", RootName, "");
      AppendChild(Root);
    }

    public void SaveFile()
    {
      try
      {
        this.Save(File.FullName);
      }
      catch (Exception)
      {
      }
    }

    protected virtual void AddDocumentType()
    {
    }

    protected XmlElement AppendElement(XmlElement parent, string elementName)
    {
      return AppendElement(parent, elementName, "", "");
    }

    protected XmlElement AppendElement(XmlElement parent, string elementName, string elementText)
    {
      return AppendElement(parent, elementName, "", elementText);
    }

    protected XmlElement AppendElement(XmlElement parent, string elementName, string ns, string elementText)
    {
      XmlElement rval = CreateElement(elementName, ns);
      if (elementText.Length > 0) rval.AppendChild(CreateTextNode(elementText));
      parent.AppendChild(rval);
      return rval;
    }

    protected void AppendAttribute(XmlElement element, string attributeName, string attributeValue)
    {
      XmlAttribute attribute = CreateAttribute(attributeName);
      attribute.Value = attributeValue;
      element.Attributes.Append(attribute);
    }

    protected void AppendAttribute(XmlElement element, string attributeName, string ns, string attributeValue)
    {
      XmlAttribute attribute = CreateAttribute(attributeName, ns);
      attribute.Value = attributeValue;
      element.Attributes.Append(attribute);
    }
  }
}