/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 * Maia Systems Acumen
 * Copyright (c) 2006 Maia Systems
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * Event History events
 *
 * $Id: DbService.cs 116 2006-05-19 22:10:25Z craig $
 * 
 * Who  When       Why
 * CAM  6-Apr-06   100 : Added to Source Safe.
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

using System;

namespace frontburner.maia.Acumen
{
	/// <summary>
	/// Summary description for Event.
	/// </summary>
  public class Event
  {
    protected int dart;
    protected string type;
    protected string resultTime;
    protected float speed;
    protected float temp;
    protected float vb1;
    protected float vb2;
    protected float vb3;

    public Event(int dart, string type, string resultTime, float speed, float temp, float vb1, float vb2, float vb3)
    {
      this.dart = dart;
      this.type = type;
      this.resultTime = resultTime;
      this.speed = speed;
      this.temp = temp;
      this.vb1 = vb1;
      this.vb2 = vb2;
      this.vb3 = vb3;
    }

    public int Dart 
    {
      get 
      {
        return this.dart;
      }
    }

    public string EventType 
    {
      get 
      {
        return this.type;
      }
    }

    public string ResultTime 
    {
      get 
      {
        return this.resultTime;
      }
    }

    public float Speed 
    {
      get 
      {
        return this.speed;
      }
    }

    public float Temp 
    {
      get 
      {
        return this.temp;
      }
    }

    public float Vb1 
    {
      get 
      {
        return this.vb1;
      }
    }

    public float Vb2
    {
      get 
      {
        return this.vb2;
      }
    }
  
    public float Vb3
    {
      get 
      {
        return this.vb3;
      }
    }
  }
}
