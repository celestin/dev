/* * * * * * * * * * * * * * * * * * * * * * * *
 * Ministry Search Engine Data Builder
 * Copyright (c) 2008 Front Burner
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  17-May-2008  10266 : File created.
 * CAM  18-May-2008  10267 : Added MpowerCompletedJobsTableAdapter.
 * * * * * * * * * * * * * * * * * * * * * * * */

using System;
using System.Data;
using System.Windows.Forms;
using MySql.Data.MySqlClient;

namespace FrontBurner.Ministry.MseBuilder
{


  public partial class MseData
  {
  }
}

namespace FrontBurner.Ministry.MseBuilder.MseDataTableAdapters
{
  public partial class MpowerCompletedJobsTableAdapter
  {
    public void CopyToMySQL()
    {
      MseData.MpowerCompletedJobsDataTable release = new MseData.MpowerCompletedJobsDataTable();
      this.Fill(release);

      string tableName = "mse_release_history";
      DataSet ds = new DataSet();

      MySqlConnection myConn = new MySqlConnection("Server=localhost;Database=goodteaching_org_min;Uid=root;Pwd=Coyote99;");
      MySqlDataAdapter myDataAdapter = new MySqlDataAdapter();
      myDataAdapter.SelectCommand = new MySqlCommand("SELECT release_no, task_id, description, completion_date FROM mse_release_history", myConn);
      MySqlCommandBuilder cb = new MySqlCommandBuilder(myDataAdapter);

      myConn.Open();
      myDataAdapter.Fill(ds, tableName);
      DataTable myReleaseHistory = ds.Tables[tableName];

      foreach (DataRow existingRow in myReleaseHistory.Rows)
      {
        // Remove the exising rows
        existingRow.Delete();
      }

      foreach (DataRow mpowerRow in release)
      {
        // Add the new rows from mpower
        DataRow copyRow = myReleaseHistory.NewRow();
        copyRow["release_no"] = mpowerRow[release.ReleaseNoColumn];
        copyRow["task_id"] = mpowerRow[release.TaskIdColumn];
        copyRow["description"] = mpowerRow[release.DescriptionColumn];
        copyRow["completion_date"] = mpowerRow[release.CompletionDateColumn];
        myReleaseHistory.Rows.Add(copyRow);
      }

      // Update MySQL
      myDataAdapter.Update(ds, tableName);
      myConn.Close();
    }
  }
}
