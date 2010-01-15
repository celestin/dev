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
using System.Xml;

namespace FrontBurner.Ministry.MseBuilder.Reader.Bbeb
{
  public abstract class BbebObjElement : BbebElement
  {
    private int _objId;

    public int ObjId
    {
      get { return _objId; }
      set { _objId = value; }
    }

    protected BbebObjElement(BbebDocument doc, string name)
      : base(doc, name)
    {
      ObjId = BbebUtil.Instance.NextObjId();
    }

    protected void AppendAttribute(string name, BbebObjElement objElement)
    {
      AppendAttribute(this, name, objElement.ObjId);
    }

    protected void AppendAttribute(XmlElement element, string name, BbebObjElement objElement)
    {
      AppendAttribute(element, name, objElement.ObjId);
    }

    public override void GenerateBbeb()
    {
      XmlAttribute attribute = OwnerDocument.CreateAttribute("objid");
      attribute.Value = ObjId.ToString().Trim();
      Attributes.Append(attribute);
    }
  }
}
