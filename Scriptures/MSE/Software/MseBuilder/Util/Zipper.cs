/* * * * * * * * * * * * * * * * * * * * * * * *
 * Good Teaching Search Engine Data Builder
 * Copyright (c) 2007,2010 Front Burner
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  21-Jan-2010  10544 : File created.
 * * * * * * * * * * * * * * * * * * * * * * * */

using System;
using System.Collections.Generic;
using System.IO;
using ICSharpCode.SharpZipLib.Zip;


namespace FrontBurner.Ministry.MseBuilder.Util
{
  public class Ziplist : List<FileInfo>
  {
    public Ziplist()
      : base()
    {
    }
  }

  public class Zipper
  {
    private static Zipper _zipper;

    private Ziplist _ziplist;

    public Ziplist Ziplist
    {
      get { return _ziplist; }
      set { _ziplist = value; }
    }

    private Zipper()
    {
      Ziplist = new Ziplist();
    }

    public static Zipper Instance
    {
      get
      {
        if (_zipper == null)
        {
          _zipper = new Zipper();
        }
        return _zipper;
      }
    }

    public void ZipDirectory(DirectoryInfo sourceFolder, FileInfo zipfile)
    {
      Ziplist.Clear();

      GenerateFileList(sourceFolder);

      FileStream fileStream;
      byte[] buffer;
      ZipEntry zipEntry;
      ZipOutputStream zipStream = new ZipOutputStream(zipfile.Create());
      zipStream.SetLevel(9); // maximum compression
      int baseDirectory = sourceFolder.FullName.Length + 1; // remove up to and including the '\'

      foreach (FileInfo file in _ziplist)
      {
        // Generate an entry in the zipfile
        zipEntry = new ZipEntry(file.FullName.Remove(0, baseDirectory));
        zipStream.PutNextEntry(zipEntry);

        // Add the contents of the file itself
        fileStream = File.OpenRead(file.FullName);
        buffer = new byte[fileStream.Length];
        fileStream.Read(buffer, 0, buffer.Length);
        zipStream.Write(buffer, 0, buffer.Length);
      }

      zipStream.Finish();
      zipStream.Close();
    }

    private void GenerateFileList(DirectoryInfo dir)
    {
      foreach (FileInfo file in dir.GetFiles())
      {
        // Add each file in directory
        _ziplist.Add(file);
      }

      foreach (DirectoryInfo subdir in dir.GetDirectories())
      {
        // Recursively add subdirectories
        GenerateFileList(subdir);
      }
    }
  }
}
