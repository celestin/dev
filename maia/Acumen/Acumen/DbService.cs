/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 * Maia Systems Acumen
 * Copyright (c) 2006 Maia Systems
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * Database Service Manager
 *
 * $Id: $
 * 
 * Who  When       Why
 * CAM  6-Apr-06   100 : Added to Source Safe.
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

using System;
using System.ServiceProcess;
using System.Windows.Forms;

namespace frontburner.maia.Acumen
{
	/// <summary>
	/// DbService controls the starting and stopping of the AcumenDb service.
	/// </summary>
	public class DbService
	{
    private static DbService _db;

    private ServiceController _dbService;

		private DbService()
		{
      _dbService = new ServiceController("AcumenDb");
    }

    public static DbService getDbService() 
    {
      if (_db == null) 
      {
        _db = new DbService();
      } 
      return _db;
    }

    public void Refresh() 
    {
      this._dbService.Refresh();
    }
    
    public bool Check() 
    {
      try 
      {        
        ServiceControllerStatus status = this._dbService.Status;
      } 
      catch (Exception) 
      {
        return false;
      }

      return true;
    }

    public bool Start() 
    {
      ServiceControllerStatus status = this._dbService.Status;
      if (status.Equals(ServiceControllerStatus.Stopped) || status.Equals(ServiceControllerStatus.Paused)) 
      {
        _dbService.Start();
      }

      this._dbService.Refresh();
      status = this._dbService.Status;
      return (status.Equals(ServiceControllerStatus.Running));
    }

    public void Stop() 
    {
      ServiceControllerStatus status = this._dbService.Status;
      if (status.Equals(ServiceControllerStatus.Running)) 
      {
        _dbService.Stop();
      }
    }
	}
}
