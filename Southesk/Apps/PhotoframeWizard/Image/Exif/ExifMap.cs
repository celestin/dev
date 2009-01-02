/* * * * * * * * * * * * * * * * * * * * * * * *
 * Photoframe Wizard
 * Copyright (c) 2009 Front Burner
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * $Id: $
 *
 * Who  When         Why
 * CAM  02-Jan-2009  File created.
 * CAM  02-Jan-2009  Improved properties handling.
 * * * * * * * * * * * * * * * * * * * * * * * */

using System;
using System.Collections;
using System.Collections.ObjectModel;

namespace Fb.Apps.PhotoframeWizard.Image.Exif
{
  /// <summary>
  /// Summary description for ExifMap.
  /// </summary>
  public class ExifMap : KeyedCollection<int, ExifProperty>
  {
    private ExifPropertyCollection _values;
    /// <summary>
    ///
    /// </summary>
    public ExifMap()
    {
      _values = new ExifPropertyCollection();

      Add(new ExifProperty(0x8769, "Exif IFD"));
      Add(new ExifProperty(0x8825, "Gps IFD"));
      Add(new ExifProperty(0xFE, "New Subfile Type"));
      Add(new ExifProperty(0xFF, "Subfile Type"));
      Add(new ExifProperty(0x100, "Image Width"));
      Add(new ExifProperty(0x101, "Image Height"));
      Add(new ExifProperty(0x102, "Bits Per Sample"));
      Add(new ExifProperty(0x103, "Compression"));
      Add(new ExifProperty(0x106, "Photometric Interp"));
      Add(new ExifProperty(0x107, "Thresh Holding"));
      Add(new ExifProperty(0x108, "Cell Width"));
      Add(new ExifProperty(0x109, "Cell Height"));
      Add(new ExifProperty(0x10A, "Fill Order"));
      Add(new ExifProperty(0x10D, "Document Name"));
      Add(new ExifProperty(0x10E, "Image Description"));
      Add(new ExifProperty(0x10F, "Equip Make"));
      Add(new ExifProperty(0x110, "Equip Model"));
      Add(new ExifProperty(0x111, "Strip Offsets"));
      Add(new ExifProperty(0x112, "Orientation"));
      Add(new ExifProperty(0x115, "Samples PerPixel"));
      Add(new ExifProperty(0x116, "Rows Per Strip"));
      Add(new ExifProperty(0x117, "Strip Bytes Count"));
      Add(new ExifProperty(0x118, "Min Sample Value"));
      Add(new ExifProperty(0x119, "Max Sample Value"));
      Add(new ExifProperty(0x11A, "X Resolution"));
      Add(new ExifProperty(0x11B, "Y Resolution"));
      Add(new ExifProperty(0x11C, "Planar Config"));
      Add(new ExifProperty(0x11D, "Page Name"));
      Add(new ExifProperty(0x11E, "X Position"));
      Add(new ExifProperty(0x11F, "Y Position"));
      Add(new ExifProperty(0x120, "Free Offset"));
      Add(new ExifProperty(0x121, "Free Byte Counts"));
      Add(new ExifProperty(0x122, "Gray Response Unit"));
      Add(new ExifProperty(0x123, "Gray Response Curve"));
      Add(new ExifProperty(0x124, "T4 Option"));
      Add(new ExifProperty(0x125, "T6 Option"));
      Add(new ExifProperty(0x128, "Resolution Unit"));
      Add(new ExifProperty(0x129, "Page Number"));
      Add(new ExifProperty(0x12D, "Transfer Funcition"));
      Add(new ExifProperty(0x131, "Software Used"));
      Add(new ExifProperty(0x132, "Date Time"));
      Add(new ExifProperty(0x13B, "Artist"));
      Add(new ExifProperty(0x13C, "Host Computer"));
      Add(new ExifProperty(0x13D, "Predictor"));
      Add(new ExifProperty(0x13E, "White Point"));
      Add(new ExifProperty(0x13F, "Primary Chromaticities"));
      Add(new ExifProperty(0x140, "ColorMap"));
      Add(new ExifProperty(0x141, "Halftone Hints"));
      Add(new ExifProperty(0x142, "Tile Width"));
      Add(new ExifProperty(0x143, "Tile Length"));
      Add(new ExifProperty(0x144, "Tile Offset"));
      Add(new ExifProperty(0x145, "Tile ByteCounts"));
      Add(new ExifProperty(0x14C, "InkSet"));
      Add(new ExifProperty(0x14D, "Ink Names"));
      Add(new ExifProperty(0x14E, "Number Of Inks"));
      Add(new ExifProperty(0x150, "Dot Range"));
      Add(new ExifProperty(0x151, "Target Printer"));
      Add(new ExifProperty(0x152, "Extra Samples"));
      Add(new ExifProperty(0x153, "Sample Format"));
      Add(new ExifProperty(0x154, "S Min Sample Value"));
      Add(new ExifProperty(0x155, "S Max Sample Value"));
      Add(new ExifProperty(0x156, "Transfer Range"));
      Add(new ExifProperty(0x200, "JPEG Proc"));
      Add(new ExifProperty(0x201, "JPEG InterFormat"));
      Add(new ExifProperty(0x202, "JPEG InterLength"));
      Add(new ExifProperty(0x203, "JPEG RestartInterval"));
      Add(new ExifProperty(0x205, "JPEG LosslessPredictors"));
      Add(new ExifProperty(0x206, "JPEG PointTransforms"));
      Add(new ExifProperty(0x207, "JPEG QTables"));
      Add(new ExifProperty(0x208, "JPEG DCTables"));
      Add(new ExifProperty(0x209, "JPEG ACTables"));
      Add(new ExifProperty(0x211, "YCbCr Coefficients"));
      Add(new ExifProperty(0x212, "YCbCr Subsampling"));
      Add(new ExifProperty(0x213, "YCbCr Positioning"));
      Add(new ExifProperty(0x214, "REF Black White"));
      Add(new ExifProperty(0x8773, "ICC Profile"));
      Add(new ExifProperty(0x301, "Gamma"));
      Add(new ExifProperty(0x302, "ICC Profile Descriptor"));
      Add(new ExifProperty(0x303, "SRGB RenderingIntent"));
      Add(new ExifProperty(0x320, "Image Title"));
      Add(new ExifProperty(0x8298, "Copyright"));
      Add(new ExifProperty(0x5001, "Resolution X Unit"));
      Add(new ExifProperty(0x5002, "Resolution Y Unit"));
      Add(new ExifProperty(0x5003, "Resolution X LengthUnit"));
      Add(new ExifProperty(0x5004, "Resolution Y LengthUnit"));
      Add(new ExifProperty(0x5005, "Print Flags"));
      Add(new ExifProperty(0x5006, "Print Flags Version"));
      Add(new ExifProperty(0x5007, "Print Flags Crop"));
      Add(new ExifProperty(0x5008, "Print Flags Bleed Width"));
      Add(new ExifProperty(0x5009, "Print Flags Bleed Width Scale"));
      Add(new ExifProperty(0x500A, "Halftone LPI"));
      Add(new ExifProperty(0x500B, "Halftone LPIUnit"));
      Add(new ExifProperty(0x500C, "Halftone Degree"));
      Add(new ExifProperty(0x500D, "Halftone Shape"));
      Add(new ExifProperty(0x500E, "Halftone Misc"));
      Add(new ExifProperty(0x500F, "Halftone Screen"));
      Add(new ExifProperty(0x5010, "JPEG Quality"));
      Add(new ExifProperty(0x5011, "Grid Size"));
      Add(new ExifProperty(0x5012, "Thumbnail Format"));
      Add(new ExifProperty(0x5013, "Thumbnail Width"));
      Add(new ExifProperty(0x5014, "Thumbnail Height"));
      Add(new ExifProperty(0x5015, "Thumbnail ColorDepth"));
      Add(new ExifProperty(0x5016, "Thumbnail Planes"));
      Add(new ExifProperty(0x5017, "Thumbnail RawBytes"));
      Add(new ExifProperty(0x5018, "Thumbnail Size"));
      Add(new ExifProperty(0x5019, "Thumbnail CompressedSize"));
      Add(new ExifProperty(0x501A, "Color Transfer Function"));
      Add(new ExifProperty(0x501B, "Thumbnail Data"));
      Add(new ExifProperty(0x5020, "Thumbnail ImageWidth"));
      Add(new ExifProperty(0x502, "Thumbnail ImageHeight"));
      Add(new ExifProperty(0x5022, "Thumbnail BitsPerSample"));
      Add(new ExifProperty(0x5023, "Thumbnail Compression"));
      Add(new ExifProperty(0x5024, "Thumbnail PhotometricInterp"));
      Add(new ExifProperty(0x5025, "Thumbnail ImageDescription"));
      Add(new ExifProperty(0x5026, "Thumbnail EquipMake"));
      Add(new ExifProperty(0x5027, "Thumbnail EquipModel"));
      Add(new ExifProperty(0x5028, "Thumbnail StripOffsets"));
      Add(new ExifProperty(0x5029, "Thumbnail Orientation"));
      Add(new ExifProperty(0x502A, "Thumbnail SamplesPerPixel"));
      Add(new ExifProperty(0x502B, "Thumbnail RowsPerStrip"));
      Add(new ExifProperty(0x502C, "Thumbnail StripBytesCount"));
      Add(new ExifProperty(0x502D, "Thumbnail ResolutionX"));
      Add(new ExifProperty(0x502E, "Thumbnail ResolutionY"));
      Add(new ExifProperty(0x502F, "Thumbnail PlanarConfig"));
      Add(new ExifProperty(0x5030, "Thumbnail ResolutionUnit"));
      Add(new ExifProperty(0x5031, "Thumbnail TransferFunction"));
      Add(new ExifProperty(0x5032, "Thumbnail SoftwareUsed"));
      Add(new ExifProperty(0x5033, "Thumbnail DateTime"));
      Add(new ExifProperty(0x5034, "Thumbnail Artist"));
      Add(new ExifProperty(0x5035, "Thumbnail WhitePoint"));
      Add(new ExifProperty(0x5036, "Thumbnail PrimaryChromaticities"));
      Add(new ExifProperty(0x5037, "Thumbnail YCbCrCoefficients"));
      Add(new ExifProperty(0x5038, "Thumbnail YCbCrSubsampling"));
      Add(new ExifProperty(0x5039, "Thumbnail YCbCrPositioning"));
      Add(new ExifProperty(0x503A, "Thumbnail RefBlackWhite"));
      Add(new ExifProperty(0x503B, "Thumbnail CopyRight"));
      Add(new ExifProperty(0x5090, "Luminance Table"));
      Add(new ExifProperty(0x5091, "Chrominance Table"));
      Add(new ExifProperty(0x5100, "Frame Delay"));
      Add(new ExifProperty(0x5101, "Loop Count"));
      Add(new ExifProperty(0x5110, "Pixel Unit"));
      Add(new ExifProperty(0x5111, "Pixel PerUnit X"));
      Add(new ExifProperty(0x5112, "Pixel PerUnit Y"));
      Add(new ExifProperty(0x5113, "Palette Histogram"));
      Add(new ExifProperty(0x829A, "Exposure Time"));
      Add(new ExifProperty(0x829D, "F-Number"));
      Add(new ExifProperty(0x8822, "Exposure Prog"));
      Add(new ExifProperty(0x8824, "Spectral Sense"));
      Add(new ExifProperty(0x8827, "ISO Speed"));
      Add(new ExifProperty(0x8828, "OECF"));
      Add(new ExifProperty(0x9000, "Ver"));
      Add(new ExifProperty(0x9003, "DTOrig"));
      Add(new ExifProperty(0x9004, "DTDigitized"));
      Add(new ExifProperty(0x9101, "CompConfig"));
      Add(new ExifProperty(0x9102, "CompBPP"));
      Add(new ExifProperty(0x9201, "Shutter Speed"));
      Add(new ExifProperty(0x9202, "Aperture"));
      Add(new ExifProperty(0x9203, "Brightness"));
      Add(new ExifProperty(0x9204, "Exposure Bias"));
      Add(new ExifProperty(0x9205, "MaxAperture"));
      Add(new ExifProperty(0x9206, "SubjectDist"));
      Add(new ExifProperty(0x9207, "Metering Mode"));
      Add(new ExifProperty(0x9208, "LightSource"));
      Add(new ExifProperty(0x9209, "Flash"));
      Add(new ExifProperty(0x920A, "FocalLength"));
      Add(new ExifProperty(0x927C, "Maker Note"));
      Add(new ExifProperty(0x9286, "User Comment"));
      Add(new ExifProperty(0x9290, "DTSubsec"));
      Add(new ExifProperty(0x9291, "DTOrigSS"));
      Add(new ExifProperty(0x9292, "DTDigSS"));
      Add(new ExifProperty(0xA000, "FPXVer"));
      Add(new ExifProperty(0xA001, "ColorSpace"));
      Add(new ExifProperty(0xA002, "PixXDim"));
      Add(new ExifProperty(0xA003, "PixYDim"));
      Add(new ExifProperty(0xA004, "RelatedWav"));
      Add(new ExifProperty(0xA005, "Interop"));
      Add(new ExifProperty(0xA20B, "FlashEnergy"));
      Add(new ExifProperty(0xA20C, "SpatialFR"));
      Add(new ExifProperty(0xA20E, "FocalXRes"));
      Add(new ExifProperty(0xA20F, "FocalYRes"));
      Add(new ExifProperty(0xA210, "FocalResUnit"));
      Add(new ExifProperty(0xA214, "Subject Loc"));
      Add(new ExifProperty(0xA215, "Exposure Index"));
      Add(new ExifProperty(0xA217, "Sensing Method"));
      Add(new ExifProperty(0xA300, "FileSource"));
      Add(new ExifProperty(0xA301, "SceneType"));
      Add(new ExifProperty(0xA302, "CfaPattern"));
      Add(new ExifProperty(0x0, "Gps Ver"));
      Add(new ExifProperty(0x1, "Gps LatitudeRef"));
      Add(new ExifProperty(0x2, "Gps Latitude"));
      Add(new ExifProperty(0x3, "Gps LongitudeRef"));
      Add(new ExifProperty(0x4, "Gps Longitude"));
      Add(new ExifProperty(0x5, "Gps AltitudeRef"));
      Add(new ExifProperty(0x6, "Gps Altitude"));
      Add(new ExifProperty(0x7, "Gps GpsTime"));
      Add(new ExifProperty(0x8, "Gps GpsSatellites"));
      Add(new ExifProperty(0x9, "Gps GpsStatus"));
      Add(new ExifProperty(0xA, "Gps GpsMeasureMode"));
      Add(new ExifProperty(0xB, "Gps GpsDop"));
      Add(new ExifProperty(0xC, "Gps SpeedRef"));
      Add(new ExifProperty(0xD, "Gps Speed"));
      Add(new ExifProperty(0xE, "Gps TrackRef"));
      Add(new ExifProperty(0xF, "Gps Track"));
      Add(new ExifProperty(0x10, "Gps ImgDirRef"));
      Add(new ExifProperty(0x11, "Gps ImgDir"));
      Add(new ExifProperty(0x12, "Gps MapDatum"));
      Add(new ExifProperty(0x13, "Gps DestLatRef"));
      Add(new ExifProperty(0x14, "Gps DestLat"));
      Add(new ExifProperty(0x15, "Gps DestLongRef"));
      Add(new ExifProperty(0x16, "Gps DestLong"));
      Add(new ExifProperty(0x17, "Gps DestBearRef"));
      Add(new ExifProperty(0x18, "Gps DestBear"));
      Add(new ExifProperty(0x19, "Gps DestDistRef"));
      Add(new ExifProperty(0x1A, "Gps DestDist"));
    }

    public int GetKeyFromValue(string value)
    {
      if (_values.Contains(value))
      {
        return _values[value].Id;
      }
      return 0;
    }

    protected override void InsertItem(int index, ExifProperty item)
    {
      base.InsertItem(index, item);
      _values.Add(item);
    }

    protected override int GetKeyForItem(ExifProperty item)
    {
      return item.Id;
    }
  }

  internal class ExifPropertyCollection : KeyedCollection<string, ExifProperty>
  {
    public ExifPropertyCollection()
    {
    }

    protected override string GetKeyForItem(ExifProperty item)
    {
      return item.Value;
    }
  }

  /// <summary>
  /// private class
  /// </summary>
  internal class Rational
  {
    private int n;
    private int d;
    public Rational(int n, int d)
    {
      this.n = n;
      this.d = d;
      simplify(ref this.n, ref this.d);
    }
    public Rational(uint n, uint d)
    {
      this.n = Convert.ToInt32(n);
      this.d = Convert.ToInt32(d);

      simplify(ref this.n, ref this.d);
    }
    public Rational()
    {
      this.n = this.d = 0;
    }
    public string ToString(string sp)
    {
      if (sp == null) sp = "/";
      return n.ToString() + sp + d.ToString();
    }
    public double ToDouble()
    {
      if (d == 0)
        return 0.0;

      return Math.Round(Convert.ToDouble(n) / Convert.ToDouble(d), 2);
    }
    private void simplify(ref int a, ref int b)
    {
      if (a == 0 || b == 0)
        return;

      int gcd = euclid(a, b);
      a /= gcd;
      b /= gcd;
    }
    private int euclid(int a, int b)
    {
      if (b == 0)
        return a;
      else
        return euclid(b, a % b);
    }
  }
}
