/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 * Krakatau Essential PM (KEPM)
 * Copyright (c) 2009 PowerSoftware.com
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  17-Nov-2009  10502 : File created.
 * CAM  24-Nov-2009  10506 : Scroll to top of treeview after populating.
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

using System;
using System.IO;
using System.Windows.Forms;

using PowerSoftware.Krakatau.Kepm.Projects;

namespace PowerSoftware.Krakatau.Kepm.Forms
{
  public partial class FormDirectoryTreeSelector : Form
  {
    private Project _project;

    public FormDirectoryTreeSelector(Project project)
    {
      _project = project;

      InitializeComponent();
    }

    private void FormDirectoryTreeSelector_Load(object sender, EventArgs e)
    {
      TreeNode basedir = new TreeNode(_project.Basedir.FullName);
      _trvDirs.Nodes.Add(basedir);

      AddChildDirs(basedir, _project.Basedir);

      basedir.ExpandAll();
      basedir.EnsureVisible();
    }

    private void AddChildDirs(TreeNode node, DirectoryInfo dir)
    {
      node.Checked = (!_project.ProjectOptions.ExcludedDirectories.Exists(dir));
      node.Tag = dir;

      foreach (DirectoryInfo childDir in dir.GetDirectories())
      {
        TreeNode childNode = new TreeNode(childDir.Name);
        node.Nodes.Add(childNode);
        AddChildDirs(childNode, childDir);
      }
    }

    private void BuildExcludedDirectories()
    {
      _project.ProjectOptions.ExcludedDirectories.Clear();
      CheckChildDirs(_trvDirs.Nodes[0]);
    }

    private void CheckChildDirs(TreeNode node)
    {
      if (!node.Checked)
      {
        _project.ProjectOptions.ExcludedDirectories.Add((DirectoryInfo)node.Tag);
      }

      foreach (TreeNode child in node.Nodes)
      {
        CheckChildDirs(child);
      }
    }

    private void SaveExcludedDirectories(object sender, EventArgs e)
    {
      BuildExcludedDirectories();
      this.Dispose();
    }
  }
}
