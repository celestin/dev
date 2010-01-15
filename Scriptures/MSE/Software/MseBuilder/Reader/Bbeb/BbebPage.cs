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
using System.Collections.Generic;
using System.Text;

namespace FrontBurner.Ministry.MseBuilder.Reader.Bbeb
{
  public class BbebPage : BbebObjElement
  {
    private BbebPageStyle _pageStyle;

    public BbebPageStyle PageStyle
    {
      get { return _pageStyle; }
      set { _pageStyle = value; }
    }

    public BbebPage(BbebDocument doc, BbebPageStyle pageStyle)
      : base(doc, "Page")
    {
      _pageStyle = pageStyle;
    }

    public override void GenerateBbeb()
    {
      base.GenerateBbeb();

      AppendAttribute("pagestyle", PageStyle);
    }
  }
}
