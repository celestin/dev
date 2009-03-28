/* * * * * * * * * * * * * * * * * * * * * * * *
 * Good Teaching Search Engine Data Builder
 * Copyright (c) 2008 Front Burner
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * $Id: $
 *
 * Who  When         Why
 * CAM  22-Jun-2008  10409 : File created.
 * * * * * * * * * * * * * * * * * * * * * * * */

using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Text;
using System.IO;
using System.Windows.Forms;

using FrontBurner.Ministry.MseBuilder.Abstract;

namespace FrontBurner.Ministry.MseBuilder.Bible
{
  public class Sourcefiles : Collection<FileInfo>
  {
    private DirectoryInfo _dir;

    public Sourcefiles(string dirName)
      : base()
    {
      _dir = new DirectoryInfo(dirName);
      foreach (FileInfo file in _dir.GetFiles())
      {
        this.Add(file);
      }
    }
  }

  public class MseBibleEngine
  {
    Sourcefiles _jndText;
    Sourcefiles _jndFootnotes;
    Sourcefiles _kjvText;

    public MseBibleEngine()
    {
      _jndText = new Sourcefiles(@"C:\Dev\Scriptures\Bible\Darby\tx");
      _jndFootnotes = new Sourcefiles(@"C:\Dev\Scriptures\Bible\Darby\fn");
      _kjvText = new Sourcefiles(@"C:\Dev\Scriptures\Bible\AV\tx");
    }

    public void Build()
    {
      BibleVersionCollection versions = BusinessLayer.Instance.GetVersions();

      foreach (BibleVersion version in versions)
      {
        version.Clear();
      }

      BuildText(_jndText, versions[1]);
      //BuildText(_kjvText, versions[2]);

      BuildFootnotes(_jndFootnotes, versions[1]);

      foreach (BibleBook book in versions[1])
      {
        CrossReference(book);
      }

      DatabaseLayer.Instance.ExecuteSql("TRUNCATE TABLE mse_bible_text");
      DatabaseLayer.Instance.ExecuteSql("TRUNCATE TABLE mse_bible_footnote");
      DatabaseLayer.Instance.ExecuteSql("TRUNCATE TABLE mse_bible_footnote_instance");

      foreach (BibleVersion version in versions)
      {
        foreach (BibleBook book in version)
        {
          DatabaseLayer.Instance.SaveBibleBook(book);
        }
      }
    }

    protected void BuildText(Sourcefiles files, BibleVersion version)
    {
      string buffer;
      int p;
      string bookName;
      string shortCode;
      string text;
      BibleBookCollection books = BusinessLayer.Instance.GetBooks();
      BibleBook book = null;

      foreach (FileInfo file in files)
      {
        using (StreamReader sr = new StreamReader(file.FullName))
        {
          while ((buffer = sr.ReadLine()) != null)
          {
            if ((p = buffer.IndexOf("<BR>")) >= 0)
            {
              bookName = buffer.Substring(p + 4, buffer.Length - p - 4);
              if ((p = bookName.IndexOf("<")) >= 0)
              {
                bookName = bookName.Substring(0, p);
              }
              if ((book = books.FindByFullname(bookName)) != null)
              {
                book = book.AddCopy(version);
                book.ShortCode = ParseShortCode(book, file);
              }
              else
              {
                // Error
                MessageBox.Show("Couldn't find bookname " + bookName, "Error!");
              }
            }
            else if ((p = buffer.IndexOf("<DT>")) >= 0)
            {
              buffer = buffer.Substring(p + 4, buffer.Length - p - 4); // remove dt
              p = buffer.IndexOf(">");
              buffer = buffer.Substring(p + 1, buffer.Length - p - 1); // remove anchor
              p = buffer.IndexOf("<");
              shortCode = buffer.Substring(0, p);
              p = buffer.IndexOf("<DD>");
              text = buffer.Substring(p + 4, buffer.Length - p - 4); // remove remaining prefix
              book.Verses.Add(new BibleVerse(book, shortCode, text));
            }
          }
        }
      }
    }

    protected void BuildFootnotes(Sourcefiles files, BibleVersion version)
    {
      string buffer;
      int p;
      string shortCode;
      char symbol = 'z';
      string text;
      BibleBookCollection books = BusinessLayer.Instance.GetBooks();
      BibleBook book = null;

      foreach (FileInfo file in files)
      {
        using (StreamReader sr = new StreamReader(file.FullName))
        {
          book = version.FindBookByShortCode(ParseShortCode(book, file));

          while ((buffer = sr.ReadLine()) != null)
          {
            if ((p = buffer.IndexOf("<DT>")) >= 0)
            {
              buffer = buffer.Substring(p + 4, buffer.Length - p - 4); // remove dt
              p = buffer.IndexOf("=\"");
              buffer = buffer.Substring(p + 2, buffer.Length - p - 2); // remove anchor tag
              p = buffer.IndexOf("\">");
              shortCode = buffer.Substring(0, p);
              buffer = buffer.Substring(p + 2, buffer.Length - p - 2); // remove anchor completely

              // Now look for the first alpha - this is the symbol
              for (int i = 0; i < buffer.Length; i++)
              {
                if (buffer[i] >= 97 && buffer[i] <= 122)
                {
                  symbol = buffer[i];
                  break;
                }
              }

              p = buffer.IndexOf("<DD>");
              text = buffer.Substring(p + 4, buffer.Length - p - 4); // remove remaining prefix
              book.Footnotes.Add(new BibleFootnote(book, shortCode, symbol, text));
            }
          }
        }
      }
    }

    protected void CrossReference(BibleBook book)
    {
      CrossReferenceVerses(book);
    }

    protected void CrossReferenceVerses(BibleBook book)
    {
      const string AnchorStartOpen = "<A HREF=\"";
      const string AnchorStartClose = "\">";
      const string AnchorEnd = "</A>";
      int p;
      int p2;
      string text;
      string rf;
      string word;
      string newLine;
      BibleXref xref;

      foreach (BibleVerse verse in book.Verses)
      {
        text = verse.Text;
        rf = word = newLine = "";

        while ((p = text.IndexOf(AnchorStartOpen)) >= 0)
        {
          newLine += text.Substring(0, p) + AnchorStartOpen + "showFootnote.php?";

          text = text.Substring(p + AnchorStartOpen.Length, text.Length - p - AnchorStartOpen.Length);

          if ((p = text.IndexOf(AnchorStartClose)) >= 0)
          {
            rf = text.Substring(0, p);
            newLine += rf + AnchorStartClose;

            if ((p2 = text.IndexOf(AnchorEnd)) >= 0)
            {
              word = text.Substring(p + AnchorStartClose.Length, p2 - p - AnchorStartClose.Length).Trim();
            }

            text = text.Substring(p + AnchorStartClose.Length, text.Length - p - AnchorStartClose.Length);
          }

          if (newLine.Length > 0)
          {
            newLine += text;
            xref = new BibleXref(verse, XrefType.VerseToFootnote, rf, word);
            if (!xref.AddXref(book.Version))
            {
              MessageBox.Show("Failed!");
            }
            verse.Text = newLine;
          }
        }
      }
    }

    protected string ParseShortCode(BibleBook book, FileInfo file)
    {
      string code = file.Name;
      code = code.Substring(0, code.Length - file.Extension.Length);
      return code;
    }
  }
}
