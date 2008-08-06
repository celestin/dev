using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using System.Windows.Forms;

using Southesk.Apps.EmitScore.Data;

namespace Southesk.Apps.EmitScore.Forms
{
  public partial class FrmMain : Form
  {
    public FrmMain()
    {
      InitializeComponent();
    }

    private void EmitReader_GetNextBadge(object sender, AxEmitEpt.__EptReading_GetNextBadgeEvent e)
    {
      //MessageBox.Show("Hello! " + e.badgeData);

      _sslRegister.Text = String.Format("Data received at {0}", DateTime.Now);

      ProcessBadgeData(e.badgeData);
    }

    protected void ProcessBadgeData(string data)
    {
      string[] commaDelimited = data.Split(new char[] { ',' });
      int i = 0;

      string messageType=String.Empty;
      string badgeNumber=String.Empty;
      string item = String.Empty;

      foreach (string value in commaDelimited)
      {
        i++;
        item = value;

        if (item.StartsWith("\""))
        {
          item = item.Substring(1, item.Length - 1);
        }

        if (item.EndsWith("\""))
        {
          item = item.Substring(0, item.Length - 1);
        }

        if (i == 1)
        {
          messageType = item;
        }
        else if (i == 4)
        {
          badgeNumber = item;
        }
      }

      if (messageType.Equals("M"))
      {
        MessageBox.Show("Badge number " + badgeNumber);
        EmitScoreDataSet.GroupDataTable groupTable = new EmitScoreDataSet.GroupDataTable();
        EmitScoreDataSet.GroupRow groupRow = groupTable.NewGroupRow();
        groupRow.CategoryId = 1;
        groupRow.GroupName = "Holders of " + badgeNumber;
        groupRow.GroupId = int.Parse(badgeNumber);

        groupTable.AddGroupRow(groupRow);
        groupTableAdapter.Update(groupTable);        
      }
    }

    private void FrmMain_Load(object sender, EventArgs e)
    {
      this.configTableAdapter.Fill(this.emitScoreDataSet.Config);
      this.groupTableAdapter.Fill(this.emitScoreDataSet.Group);
      ToggleButtons(false);

      EmitScoreDataSet.ConfigDataTable config = emitScoreDataSet.Config;

      _emitReader.ComPrt = short.Parse(config.Rows[0][config.ComPortColumn].ToString());
      _emitReader.Unit = short.Parse(config.Rows[0][config.EmitUnitColumn].ToString());
      _emitReader.StartComm();
    }

    protected void ToggleButtons(bool showRegister)
    {
      _btnRace.Enabled = !(_btnRegister.Enabled = showRegister);
    }

    protected void ShowConfig()
    {
      FrmConfig config = new FrmConfig();
      config.ShowDialog();
    }

    protected void ShowLocations()
    {
      FrmLocations locations = new FrmLocations();
      locations.ShowDialog();
    }

    protected void ShowCategories()
    {
      FrmCategories cats = new FrmCategories();
      cats.ShowDialog();
    }

    protected void ShowGroups()
    {
      FrmGroups groups = new FrmGroups();
      groups.ShowDialog();
    }

    private void mniExit_Click(object sender, EventArgs e)
    {
      this.Dispose();
    }

    private void tsbExit_Click(object sender, EventArgs e)
    {
      this.Dispose();
    }

    private void tsbGroups_Click(object sender, EventArgs e)
    {
      ShowGroups();
    }

    private void mniGroups_Click(object sender, EventArgs e)
    {
      ShowGroups();
    }

    private void _btnRegister_Click(object sender, EventArgs e)
    {
      ToggleButtons(false);
    }

    private void _btnRace_Click(object sender, EventArgs e)
    {
      ToggleButtons(true);
    }

    private void _tmrStatus_Tick(object sender, EventArgs e)
    {
      _sslRegister.Text = String.Format("{0} groups registered.",
        emitScoreDataSet.Group.Rows.Count);
    }

    private void mniCategories_Click(object sender, EventArgs e)
    {
      ShowCategories();
    }

    private void tsbCategories_Click(object sender, EventArgs e)
    {
      ShowCategories();
    }

    private void _tsbLocations_Click(object sender, EventArgs e)
    {
      ShowLocations();
    }

    private void mniLocations_Click(object sender, EventArgs e)
    {
      ShowLocations();
    }

    private void mniComPort_Click(object sender, EventArgs e)
    {
      ShowConfig();
    }

    private void mniFileNew_Click(object sender, EventArgs e)
    {
      MessageBox.Show("This will remove all Groups and Race results.\n"+
        "COM Port, Locations and Categories will be left alone.\n\n" +
        "Are you sure you want to delete Groups and Race results?", "New Race", 
        MessageBoxButtons.YesNoCancel, MessageBoxIcon.Question);
    }
  }
}
