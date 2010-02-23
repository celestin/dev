/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 * Krakatau Essential PM (KEPM)
 * Copyright (c) 2004,2010 PowerSoftware.com
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * $Id$
 *
 * Who  When       Why
 * CAM  19-Feb-2010  10558 : File created.
 * CAM  23-Feb-2010  10558 : Refresh the view correctly, and ensure the database is opened with relevant credentials.
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

using System;
using System.Data;
using System.Text;
using System.Windows.Forms;

using SourceCodeMetrics.Krakatau.Kepm.Config;
using SourceCodeMetrics.Krakatau.Kepm.Database;
using SourceCodeMetrics.Krakatau.Kepm.Projects;
using SourceCodeMetrics.Krakatau.Kepm.Results;
using SourceCodeMetrics.Krakatau.Kepm.Win32;

namespace SourceCodeMetrics.Krakatau.Kepm.Forms
{
  public class RefreshController
  {
    protected static readonly string ResultsTable = "MetricsResults";
    private DataGridView _view;
    private DataSet _set;
    private MetricSet _metricSet;

    public MetricSet MetricSet
    {
      get { return _metricSet; }
      set { _metricSet = value; }
    }

    public RefreshController(DataGridView view)
    {
      _view = view;

      _set = new DataSet();

      view.DataSource = _set;
    }

    public void RefreshView(object sender, RefreshViewArgs e)
    {
      if (OpenDatabase(e.Project))
      {
        DatabaseLayer.Instance.GetResults(_set, ResultsTable, _metricSet);
        _view.DataSource = new BindingSource(_set, ResultsTable);
      }
    }

    protected bool OpenDatabase(Project project)
    {
      string server = "localhost";
      string username = "root";
      string password = String.Empty;

      Prefs p = Prefs.Preferences;
      if (p.MySqlUse)
      {
        server = p.MySqlServer;
        username = p.MySqlUsername;
        password = p.MySqlPassword;
      }

      Arguments a = project.GetAnalysisOptions();
      if (a != null)
      {
        if (a["s"] != null) server = a["s"];
        if (a["u"] != null) username = a["u"];
        if (a["p"] != null) password = a["p"];
      }

      if (server.Length > 0 && username.Length > 0)
      {
        return DatabaseLayer.Instance.Open(server, project.Databasename, username, password);
      }

      return false;
    }
  }
}
