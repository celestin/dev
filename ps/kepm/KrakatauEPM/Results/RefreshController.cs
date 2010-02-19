/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 * Krakatau Essential PM (KEPM)
 * Copyright (c) 2004,2010 PowerSoftware.com
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * $Id$
 *
 * Who  When       Why
 * CAM  19-Feb-2010  10558 : File created.
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

using System;
using System.Data;
using System.Text;
using System.Windows.Forms;

using SourceCodeMetrics.Krakatau.Kepm.Projects;
using SourceCodeMetrics.Krakatau.Kepm.Results;

namespace SourceCodeMetrics.Krakatau.Kepm.Forms
{
  public class RefreshController
  {
    private DataTable _table;

    public RefreshController(DataGridView view)
    {
      DataSet set = new DataSet();
      _table = new DataTable("MetricsResults");
      set.Tables.Add(_table);

      view.DataSource = set;
      view.DataMember = _table.TableName;

      DataColumn filename = new DataColumn("File");
      _table.Columns.Clear();
      _table.Columns.Add(filename);
    }

    public void RefreshView(object sender, RefreshViewArgs e)
    {
      _table.Rows.Clear();

      DataRow row = _table.NewRow();
      row[_table.Columns[0]] = "bing bong";

      _table.Rows.Add(row);
    }
  }
}
