/* * * * * * * * * * * * * * * * * * * * * * * *
 * Ministry Search Engine Data Builder
 * Copyright (c) 2007 Front Burner
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  22-Sep-2007  File added to source control.
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

    public static readonly string REMARK = "Rem.";
    public static readonly string QUESTION = "Ques.";

    public MseParser(Volume vol)
    {
      _vol = vol;
    }

    protected bool GetInitials(string text, out int start, out int finish) 
    {
      bool halt=false;
      bool inits=false;
      int dotCount=0;
      int c=0;
      int i=0;
      start = 0;
      finish = 0;

      if (text.Length <= REMARK.Length)
      {
        // Don't look for initials in very short lines        
        return false; 
      }

      if (text.StartsWith("."))
      {
        // Ignore the very first period if there is one
        start++;
      }

      if (text.Substring(start, REMARK.Length).Equals(REMARK))
      {
        // A "Remark"
        finish = REMARK.Length;
        return true;
      }
      if (text.Substring(start, QUESTION.Length).Equals(QUESTION))
      {
        // A "Question"
        finish = QUESTION.Length;
        return true;
      }

      char[] buffa = text.ToCharArray();
      for (i = start; i < buffa.Length && !halt && (i < 11); i++) 
      {
        c = (int)buffa[i];

        if (c == 46) {
          dotCount++;

        } else if (c == 32) {
          halt = true;

          if (dotCount > 1) {
            inits = true;
          }

        } else if ((c >= 65 && c <= 90) || (c == 39)) {
          // continue
        } else {
          halt = true;
          inits = false;
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

      while ((buffer = sr.ReadLine()) != null)
      {
        rows++;

        if ((buffer.Substring(0, 1).Equals("{")) && (!buffer.Substring(0, 2).Equals("{#"))) 
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
            inits = buffer.Substring(initStart, initFinish - initStart).Replace(".", "").Replace(" ", "");
            buffer = buffer.Substring(initFinish, buffer.Length - initFinish).Trim();
          }
          
          DatabaseLayer.Instance.InsertParagraph(_vol, pageNo, para, rows, inits, buffer);
        }
        
        // Parse Scriptures
        if (buffer.IndexOf("@") >= 0) 
        {
          string[] a = buffer.Split(new Char[] { '@' });

          for (int ai = 1; ai < a.Length; ai++) {
            BibleRef bref = new BibleRef(a[ai]);

            if (bref.RefValid) {
              DatabaseLayer.Instance.InsertBibleRef(_vol, pageNo, para, ai, bref);
            } 
            else 
            {
              DatabaseLayer.Instance.InsertBadBibleRef(_vol, pageNo, para, ai, bref.ErrCode, a[ai]);
            }
          }
        }
      }
    }

    public void ParseArticles()
    {
      StreamReader sr = new StreamReader(_vol.GetFile().FullName);
      string buffer;
      int rows = 0;
      string trbuff;
      bool prevTitle = false;
      int pageNo = 0;
      int upper;
      int lower;
      int html;
      int other;
      int c;
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
            DatabaseLayer.Instance.UpdateArticle(art);
          }

          if ((buffer.Substring(0, 1) == "{") && (buffer.Substring(0, 2) != "{#"))
          {
            pageNo = Int32.Parse(buffer.Substring(1, buffer.IndexOf('}')-1));
          }

          upper = lower = html = other = 0;
          char[] buffa = buffer.ToCharArray();
          for (int i = 0; i < buffa.Length; i++)
          {
            c = (int)buffa[i];
            if (c >= 65 && c <= 90)
            {
              upper++;
            }
            else if (c >= 97 && c <= 122)
            {
              lower++;
            }
            else if (c == 60 || c == 62)
            {
              html++;
            }
            else if (c == 34 || c == 39 || c == 32 || c == 13 || c == 10 || c == 58 || c == 45)
            {
              // ignore quotes/ws in the 'other' count
            }
            else if (c == 46)
            {
              other++;
            }
            else
            {
              // other++;
            }
          }

          prevTitle = false;
          if (((upper + lower) > 0) && (html == 0) && (!trbuff.Equals("PREFATORY NOTE")) && (!trbuff.Equals("*NOTE*")))
          {
            if ((upper / (upper + lower + other)) > 0.7)
            {
              art = new Article(_vol, pageNo, rows, buffer);
              BusinessLayer.Instance.Articles.Add(art);
              DatabaseLayer.Instance.UpdateArticle(art);

              prevTitle = true;
            }
          }
        }
      }
    }
  }
}
