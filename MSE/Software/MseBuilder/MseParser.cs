/* * * * * * * * * * * * * * * * * * * * * * * *
 * Ministry Search Engine Data Builder
 * Copyright (c) 2007 Front Burner
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  22-Sep-2007  File added to source control.
 * CAM  22-Oct-2007  10189 : Catch all initials, and tidy them up appropriately.
 * * * * * * * * * * * * * * * * * * * * * * * */

using System;
using System.Collections.Generic;
using System.Text;
using System.IO;
using System.Windows.Forms;
using FrontBurner.Ministry.MseBuilder.Abstract;

namespace FrontBurner.Ministry.MseBuilder
{
  class MseParser
  {
    protected Volume _vol;
    protected List<string> _constantIntials;

    public MseParser(Volume vol)
    {
      _vol = vol;
    }

    protected bool GetInitials(string text, out int start, out int finish)
    {
      bool halt = false;
      bool inits = false;
      int dotCount = 0;
      int c = 0;
      int i = 0;
      int window = 11;
      start = 0;
      finish = 0;

      if (_constantIntials == null)
      {
        _constantIntials = new List<string>();
        _constantIntials.Add("Rem.");
        _constantIntials.Add("Ques.");
        _constantIntials.Add("*Rem*.");
        _constantIntials.Add("*Ques*.");
      }

      if (text.Length <= 3)
      {
        // Don't look for initials in very short lines
        return false;
      }

      if (text.StartsWith("."))
      {
        // Ignore the very first period if there is one
        start++;
      }

      // Look for any of the Constant Initials first
      foreach (string s in _constantIntials)
      {
        if ((text.Length >= s.Length) && (text.Substring(start, s.Length).Equals(s)))
        {
          finish = s.Length;
          return true;
        }
      }

      char[] buffa = text.ToCharArray();
      for (i = start; i < buffa.Length && !halt && (i < window); i++)
      {
        c = (int)buffa[i];

        if (c == 46) {
          dotCount++;

        } else if (c == 32) {
          halt = true;

          if (dotCount > 1) {
            inits = true;
          }
        }
      }

      if (inits && (i>0))
      {
        text = text.Substring(0, i).Trim();

        if (!text.StartsWith(".."))
        {
          finish = i;
          return true;
        }
      }

      return false;
    }

    public string TidyInitials(string inits)
    {
      string rval = inits.Replace(".", "").Replace(" ", "").Replace("*", "").Replace(",", "");

      while (rval.StartsWith("-"))
      {
        rval = rval.Substring(1);
      }

      return rval;
    }

    public void ParseText()
    {
      StreamReader sr = new StreamReader(_vol.GetFile().FullName);
      string buffer;
      int rows = 0;
      int cb = 0;
      int pageNo = 0;
      int para = 0;
      int initStart = 0;
      int initFinish = 0;
      string inits;
      bool prevTitle = false;
      bool scriptures = false;
      Paragraph paraPrevious = null;
      Paragraph paraCurrent = null;
      Article art;

      while ((buffer = sr.ReadLine()) != null)
      {
        rows++;
        //MessageBox.Show(string.Format("{0}\n{1}", rows, buffer));
        buffer = buffer.Trim();

        scriptures = false;
        if ((buffer.StartsWith("@")) && prevTitle)
        {
          art = BusinessLayer.Instance.Articles[Article.GetId(_vol, (rows-1))];
          art.Scriptures = buffer;
          DatabaseLayer.Instance.UpdateArticle(art);
          scriptures = true;
        }

        if ((buffer.Length > 0) && (buffer.StartsWith("{")) && (!buffer.Substring(0, 2).Equals("{#")))
        {
          if ((cb = buffer.IndexOf("}")) >= 0)
          {
            pageNo = int.Parse(buffer.Substring(1, cb-1));
          }

          para = 0;
        }
        else if ((buffer.Length > 1) && buffer.Substring(0, 2).Equals("{#"))
        {
          // Volume title - do nothing
        }
        else
        {
          para++;

          inits = null;

          if (GetInitials(buffer, out initStart, out initFinish))
          {
            inits = TidyInitials(buffer.Substring(initStart, initFinish - initStart));
            buffer = buffer.Substring(initFinish, buffer.Length - initFinish).Trim();
          }

          paraCurrent = new Paragraph(_vol, pageNo, para, rows, inits, buffer);

          prevTitle = false;
          if (paraCurrent.IsTitle())
          {
            art = paraCurrent.Article;
            BusinessLayer.Instance.Articles.Add(art);
            DatabaseLayer.Instance.UpdateArticle(art);
            DatabaseLayer.Instance.InsertParagraph(paraCurrent);

            prevTitle = true;
            paraPrevious = null;
          }
          else
          {
            if (paraPrevious != null)
            {
              // If the previous paragraph was not written out, add to it
              paraCurrent.Augment(paraPrevious);
            }

            if (paraCurrent.EndsAbruptly(scriptures))
            {
              // The paragraph is not complete, so remember it for next iteration
              paraPrevious = paraCurrent;
            }
            else
            {
              // The paragraph ends normally - save it
              paraCurrent.SaveToDatabase();
              paraPrevious = null;
            }
          }
        }
      }
      sr.Close();
    }

    /* ParseArticles -- surplus to requirement
    public void ParseArticles()
    {
      StreamReader sr = new StreamReader(_vol.GetFile().FullName);
      string buffer;
      int rows = 0;
      string trbuff;
      bool prevTitle = false;
      int pageNo = 0;
      Paragraph paragraph;
      Article art;

      while ((buffer = sr.ReadLine()) != null)
      {
        rows++;

        // Parse Article Names
        trbuff = buffer.Trim();

        if (trbuff.Length > 0)
        {
          if ((trbuff.Substring(0, 1) == "@") && prevTitle)
          {
            art = BusinessLayer.Instance.Articles[Article.GetId(_vol, (rows - 1))];
            art.Scriptures = trbuff;
            DatabaseLayer.Instance.UpdateArticle(art);
          }

          if ((trbuff.Substring(0, 1) == "{") && (trbuff.Substring(0, 2) != "{#"))
          {
            pageNo = Int32.Parse(trbuff.Substring(1, trbuff.IndexOf('}') - 1));
          }

          paragraph = new Paragraph(_vol, pageNo, 0, rows, null, trbuff);

          prevTitle = false;
          if (paragraph.IsTitle())
          {
            art = paragraph.Article;
            BusinessLayer.Instance.Articles.Add(art);
            DatabaseLayer.Instance.UpdateArticle(art);

            prevTitle = true;
          }
        }
      }
    }
    */
  }
}
