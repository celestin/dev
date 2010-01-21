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
using System.Text;
using System.IO;

namespace FrontBurner.Ministry.MseBuilder.Reader.Epub.Article
{
  public class EpubTitlePage : EpubArticle
  {
    public EpubTitlePage(long id, EpubDocument doc)
      : base(id, doc)
    {
      Title = doc.Volume.VolumeTitle;
    }

    public override void SaveFile()
    {
      using (StreamWriter writer = new StreamWriter(XmlFile.FullName))
      {
        EpubHeading author = new EpubHeading(Document.Volume.Author.Name, "frontauthor");
        EpubHeading title = new EpubHeading(Title, "fronttitle");
        EpubHeading source = new EpubHeading(
          String.Format("Produced from GoodTeaching.org<br />by Craig McKay {0:d-MMM-yyyy}", DateTime.Now), "frontpublisher");
        EpubImage image = new EpubImage(Document.Volume.Author.ImageFilename);

        WriteHeader(writer, Title);

        writer.WriteLine(author.RenderToXhtml());
        writer.WriteLine(title.RenderToXhtml());

        if (Document.Volume.Author.Inits.Equals("JT"))
        {
          EpubHeading series = new EpubHeading("New Series", "frontseries");
          writer.WriteLine(series.RenderToXhtml());
        }

        writer.WriteLine(image.RenderToXhtml());
        writer.WriteLine(source.RenderToXhtml());

        WriteFooter(writer);
      }
    }
  }
}
