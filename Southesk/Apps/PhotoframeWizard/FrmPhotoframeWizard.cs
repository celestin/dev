/* * * * * * * * * * * * * * * * * * * * * * * *
 * Photoframe Wizard
 * Copyright (c) 2009 Front Burner
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  02-Jan-2009  File created.
 * * * * * * * * * * * * * * * * * * * * * * * */

using System;
using System.Collections.Generic;
using System.Drawing;
using System.Drawing.Drawing2D;
using System.Drawing.Imaging;
using System.Windows.Forms;
using System.IO;
using System.Threading;
using Microsoft.Win32;

using Fb.Apps.PhotoframeWizard.Image.Exif;

namespace Fb.Apps.PhotoframeWizard
{
  public partial class FrmPhotoframeWizard : Form
  {
    private int _maxFiles;
    private int _currentFile;
    private string _status;
    private RegistryKey _regKey;
    private int _imgWidth;
    private int _imgHeight;

    public FrmPhotoframeWizard()
    {
      InitializeComponent();

      OpenRegistry();
      ReadRegistry();
    }

    private void CopyFiles()
    {
      _imgWidth = int.Parse(txtWidth.Text);
      _imgHeight = int.Parse(txtHeight.Text);

      Thread m_WorkerThread = new Thread(new ThreadStart(CopyFilesProcess));
      m_WorkerThread.Name = "Copying Files";
      m_WorkerThread.IsBackground = true;
      m_WorkerThread.Start();

      tspbProgress.Maximum = tspbProgress.Value = 0;
      timer1.Enabled = true;
    }

    private void CopyFilesProcess()
    {
      DirectoryInfo dir = new DirectoryInfo(txtInput.Text);
      ExifMap em = new ExifMap();
      Bitmap bmp;
      ExifUtil eu;
      FileInfo imgFile;
      Dictionary<string, FileInfo> correctOrder = new Dictionary<string, FileInfo>();

      ImageCodecInfo jpegCodec = getEncoderInfo("image/jpeg");
      EncoderParameter qualityParam = new EncoderParameter(Encoder.Quality, (long)90);
      EncoderParameters jpegQuality = new EncoderParameters(1);
      jpegQuality.Param[0] = qualityParam;

      if (dir.Exists)
      {
        FileInfo[] processFiles = dir.GetFiles("*.jpg");
        _maxFiles = processFiles.Length;
        _currentFile = 0;
        _status = "Sorting images by creation date...";

        foreach (FileInfo file in processFiles)
        {
          bmp = new Bitmap(file.FullName);
          eu = new ExifUtil(ref bmp, "\n");
          correctOrder.Add(String.Format("{0:yyyy-MM-dd_HH-mm-ss}_{1}",
            eu.DateTimeTaken, file.Name), file);

          _currentFile++;
        }

        _currentFile = 0;
        _status = "Resizing images to output folder...";

        foreach (string fileName in correctOrder.Keys)
        {
          imgFile = correctOrder[fileName];
          bmp = new Bitmap(imgFile.FullName);
          bmp = ResizeWidthCropHeight(bmp, _imgWidth, _imgHeight);
          bmp.Save(String.Format(@"{0}\{1}",txtOutput.Text, fileName),
            jpegCodec, jpegQuality);

          _currentFile++;
        }
      }
    }

    private ImageCodecInfo getEncoderInfo(string mimeType)
    {
      // Get image codecs for all image formats
      ImageCodecInfo[] codecs = ImageCodecInfo.GetImageEncoders();

      // Find the correct image codec
      foreach (ImageCodecInfo codec in codecs)
      {
        if (codec.MimeType == mimeType) return codec;
      }
      return null;
    }

    public Bitmap ResizeWidthCropHeight(Bitmap b, int nWidth, int nHeight)
    {
      int iRatioHeight = (int)(((double)b.Height / (double)b.Width) * (double)nWidth);
      Bitmap result = new Bitmap(nWidth, nHeight);
      using (Graphics g = Graphics.FromImage((System.Drawing.Image)result))
      {
        g.InterpolationMode = InterpolationMode.High;
        g.CompositingQuality = CompositingQuality.HighQuality;
        g.SmoothingMode = SmoothingMode.AntiAlias;
        g.DrawImage(b, 0, (int)(((float)nHeight - (float)iRatioHeight) / 2.0f), nWidth, iRatioHeight);
      }
      return result;
    }

    protected void SelectDirectory(TextBox txt)
    {
      fbdSave.SelectedPath = txt.Text;
      if (fbdSave.ShowDialog() == DialogResult.OK)
      {
        txt.Text = fbdSave.SelectedPath;
      }
    }

    protected void OpenRegistry()
    {
      _regKey = Registry.CurrentUser;
      _regKey = _regKey.CreateSubKey("Software\\FrontBurner\\PhotoframeWizard");
    }

    protected void ReadRegistry()
    {
      txtInput.Text = GetRegistryValue("Source Folder");
      txtOutput.Text = GetRegistryValue("Destination Folder");
      txtWidth.Text = GetRegistryValue("Image Width");
      txtHeight.Text = GetRegistryValue("Image Height");
    }

    protected string GetRegistryValue(string property)
    {
      object value = _regKey.GetValue(property);
      if (value == null) return String.Empty;
      return value.ToString();
    }

    protected void WriteRegistry()
    {
      _regKey.SetValue("Source Folder", txtInput.Text);
      _regKey.SetValue("Destination Folder", txtOutput.Text);
      _regKey.SetValue("Image Width", txtWidth.Text);
      _regKey.SetValue("Image Height", txtHeight.Text);
    }

    private void ExitApplication()
    {
      WriteRegistry();
      Application.Exit();
    }

    private void tsbCopy_Click(object sender, EventArgs e)
    {
      CopyFiles();
    }

    private void tsbExit_Click(object sender, EventArgs e)
    {
      ExitApplication();
    }

    private void tsmCopy_Click(object sender, EventArgs e)
    {
      CopyFiles();
    }

    private void tsmExit_Click(object sender, EventArgs e)
    {
      ExitApplication();
    }

    private void tsmHelpAbout_Click(object sender, EventArgs e)
    {
      FrmAboutPhotoframeWizard helpAbout = new FrmAboutPhotoframeWizard();
      helpAbout.ShowDialog();
    }

    private void btnSetInputDir_Click(object sender, EventArgs e)
    {
      SelectDirectory(txtInput);
    }

    private void btnSetOutputDir_Click(object sender, EventArgs e)
    {
      SelectDirectory(txtOutput);
    }

    private void timer1_Tick(object sender, EventArgs e)
    {
      tslStatus.Text = _status;

      if (_maxFiles != tspbProgress.Maximum)
      {
        tspbProgress.Maximum = _maxFiles;
      }

      tspbProgress.Value = _currentFile;
      if (tspbProgress.Value == tspbProgress.Maximum)
      {
        timer1.Enabled = false;
        tslStatus.Text = "Complete.";
      }
    }
  }
}
