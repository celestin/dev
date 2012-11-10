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
 * CAM  23-Feb-2010  10558 : Refresh the view only if changes require it, including defining the width and alignment of columns.
 * CAM  24-Feb-2010  10580 : Ensure the last column is autosized to fit contents to prevent the user resizing.
 * CAM  27-Feb-2010  10583 : Added ResultsCellFormatting.
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

using System;
using System.Data;
using System.Text;
using System.Windows.Forms;

using PowerSoftware.Krakatau.Kepm.Config;
using PowerSoftware.Krakatau.Kepm.Database;
using PowerSoftware.Krakatau.Kepm.Projects;
using PowerSoftware.Krakatau.Kepm.Results;
using PowerSoftware.Krakatau.Kepm.Win32;

namespace PowerSoftware.Krakatau.Kepm.Forms
{
  public class RefreshController
  {
    protected static readonly string ResultsTable = "MetricsResults";
    private DataGridView _view;
    private DataSet _set;
    private MetricSet _metricSet;
    private MetricSet _lastRefreshedMetricSet;

    public MetricSet MetricSet
    {
      get { return _metricSet; }
      set { _metricSet = value; }
    }

    public RefreshController(DataGridView view)
    {
      _view = view;

      _set = new DataSet();
    }

    public void RefreshView(object sender, RefreshViewArgs e)
    {
      if (OpenDatabase(e.Project))
      {
        bool fullRefresh = false;
        if ((_view.Columns.Count == 0) ||
          (_lastRefreshedMetricSet == null && _metricSet != null) ||
          (_lastRefreshedMetricSet != null && _metricSet == null) ||
          (_lastRefreshedMetricSet != _metricSet))
        {
          fullRefresh = true;
          _view.DataSource = null;
          _view.Columns.Clear();
        }

        DatabaseLayer.Instance.GetResults(_set, ResultsTable, _metricSet);
        _view.DataSource = new BindingSource(_set, ResultsTable);

        if (fullRefresh)
        {
          foreach (DataGridViewColumn col in _view.Columns)
          {
            if (col.Index == 0)
            {
              col.Width = 50;
            }
            if (col.Index == 1)
            {
              col.Width = 200;
            }
            else if (col.Index == 2 || col.Index ==3)
            {
              col.DefaultCellStyle.Alignment = DataGridViewContentAlignment.MiddleCenter;
              col.Width = 40;
            }
            else if (col.Index == (_view.Columns.Count - 1))
            {
              col.DefaultCellStyle.Alignment = DataGridViewContentAlignment.MiddleRight;
              col.AutoSizeMode = DataGridViewAutoSizeColumnMode.AllCells;
            }
            else if (col.Index > 3)
            {
              col.DefaultCellStyle.Alignment = DataGridViewContentAlignment.MiddleRight;
              col.Width = 42;
            }
          }
        }

        _lastRefreshedMetricSet = _metricSet;
      }
    }

    public void ResultsCellFormatting(object sender, DataGridViewCellFormattingEventArgs e)
    {
      // Set the background to red for negative values in the Balance column.
      ChurnStatus status = ChurnStatuses.GetStatus(_view.Rows[e.RowIndex].Cells["Status"].Value);

      switch (status)
      {
        case ChurnStatus.Added:
          e.CellStyle.BackColor = ChurnStatuses.Added;
          break;
        case ChurnStatus.Deleted:
          e.CellStyle.BackColor = ChurnStatuses.Deleted;
          break;
        case ChurnStatus.Changed:
          e.CellStyle.BackColor = ChurnStatuses.Changed;
          break;
      }

      //if ((e.ColumnIndex == 3) && e.Value != null)
      //{
      //  DataGridViewCell cell = _view.Rows[e.RowIndex].Cells[e.ColumnIndex];
      //  cell.ToolTipText = ChurnStatuses.GetToolTipText(status);
      //}
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
