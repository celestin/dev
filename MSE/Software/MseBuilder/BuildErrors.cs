/* * * * * * * * * * * * * * * * * * * * * * * *
 * Ministry Search Engine Data Builder
 * Copyright (c) 2008 Front Burner
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  17-May-2008  10266 : File created.
 * * * * * * * * * * * * * * * * * * * * * * * */

using System;
using System.Windows.Forms;

namespace FrontBurner.Ministry.MseBuilder
{
  public partial class BuildErrors : Form
  {
    public BuildErrors()
    {
      InitializeComponent();
    }

    private void BuildErrors_Load(object sender, EventArgs e)
    {
      this.badBibleRefTableAdapter.Fill(this.mseData.BadBibleRef);
    }
  }
}
