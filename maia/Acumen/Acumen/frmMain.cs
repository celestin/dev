/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 * Maia Systems Acumen
 * Copyright (c) 2006 Maia Systems
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * Main Form
 *
 * $Id: $
 * 
 * Who  When       Why
 * CAM  6-Apr-06   100 : Added to Source Safe.
 * CAM  23-Apr-06  100 : Changed to Random Data.
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

using System;
using System.Drawing;
using System.Collections;
using System.ComponentModel;
using System.Windows.Forms;
using System.Data;
using System.IO;

using frontburner.maia.Acumen.Model;
using frontburner.maia.Acumen.Nodes;

namespace frontburner.maia.Acumen
{
	/// <summary>
	/// Summary description for Form1.
	/// </summary>
	public class frmMain : Form
	{
    private StatusBar stbMain;
    private MainMenu mmuMain;
    private MenuItem mniFile;
    private MenuItem mniEdit;
    private MenuItem mniHelp;

    private MenuItem mniHelpAbout;
    private MenuItem mniExit;
    private TreeView trvNav;
    private System.Windows.Forms.TabControl tbcResults;
    private System.ComponentModel.IContainer components=null;
    private System.Windows.Forms.TabPage tabSchem;
    private System.Windows.Forms.PictureBox pbxMaia;
    private System.Windows.Forms.PictureBox pbxJC;
    private System.Windows.Forms.PictureBox pbxBP;
    private System.Windows.Forms.PictureBox pictureBox1;
    private System.Windows.Forms.PictureBox pictureBox2;
    private System.Windows.Forms.Label lblAssetTitle;
    private System.Windows.Forms.Label lblAssetSub;
    private System.Windows.Forms.Label lblSchemSub;
    private System.Windows.Forms.TabPage tabCompany;
    private System.Windows.Forms.TabPage tabAsset;
    private System.Windows.Forms.Label lblAssetName;
    private System.Windows.Forms.Label label2;
    private System.Windows.Forms.PictureBox pictureBox7;
    private System.Windows.Forms.PictureBox pictureBox8;
    private Gigasoft.ProEssentials.Pego pegVibr;
    private System.Windows.Forms.Label lblSchemTitle;
    private System.Windows.Forms.Timer tmrVibr;

    private DataModel _dm;
    private System.Windows.Forms.StatusBarPanel sbpMessage;
    private System.Windows.Forms.StatusBarPanel sbpWarning;
    private System.Windows.Forms.StatusBarPanel sbpError;
    private System.Windows.Forms.ImageList imlTree;
    private System.Windows.Forms.Label lblGraphTitles;
    private System.Windows.Forms.MenuItem mnuEditCopy;
    private System.Windows.Forms.MenuItem mniView;
    private System.Windows.Forms.ImageList imlMenu;
    private System.Windows.Forms.MenuItem mniEditCut;
    private System.Windows.Forms.MenuItem mniEditPaste;
    private Chris.Beckett.MenuImageLib.MenuImage muiMain;
    private System.Windows.Forms.ToolBar tlbMain;
    private System.Windows.Forms.ToolBarButton toolBarButton1;
    private System.Windows.Forms.ToolBarButton toolBarButton2;
    private System.Windows.Forms.ToolBarButton toolBarButton4;
    private System.Windows.Forms.ToolBarButton toolBarButton5;
    private System.Windows.Forms.ToolBarButton toolBarButton6;
    private System.Windows.Forms.ToolBarButton toolBarButton8;
    private Gigasoft.ProEssentials.Pego pegTemp;
    private Gigasoft.ProEssentials.Pego pegSped;
    private System.Windows.Forms.TabPage tabComp;
    private System.Windows.Forms.TabPage tabTag;
    private TagNode _currentTag;
    private System.Windows.Forms.Label lblTagSub;
    private System.Windows.Forms.Label lblTagTitle;
    private System.Windows.Forms.PictureBox pictureBox9;
    private System.Windows.Forms.PictureBox pictureBox10;
    private System.Windows.Forms.PictureBox pbxPump;
    private System.Windows.Forms.Button btnSeal1;
    private System.Windows.Forms.Button btnSeal2;
    private System.Windows.Forms.MenuItem mniFileNew;
    private System.Windows.Forms.ToolBarButton tbbNew;
    private System.Windows.Forms.MenuItem mniFileOpen;
    private System.Windows.Forms.MenuItem mniFileSave;
    private System.Windows.Forms.MenuItem menuItem1;
    private System.Windows.Forms.MenuItem mniPrint;
    private System.Windows.Forms.MenuItem mniPrintPreview;
    private System.Windows.Forms.MenuItem menuItem4;
    private System.Windows.Forms.MenuItem mniDataAdd;
    private System.Windows.Forms.MenuItem mniDataDelete;
    private System.Windows.Forms.MenuItem mniDataRefresh;
    private System.Windows.Forms.MenuItem menuItem2;
    private System.Windows.Forms.MenuItem mniDataPrefs;
    private System.Windows.Forms.ToolBarButton tbbOpen;
    private System.Windows.Forms.ToolBarButton tbbSave;
    private System.Windows.Forms.ToolBarButton tbbSep1;
    private System.Windows.Forms.ToolBarButton tbbPrint;
    private System.Windows.Forms.ToolBarButton tbbPrintPreview;
    private System.Windows.Forms.ToolBarButton tbbSep2;
    private System.Windows.Forms.ToolBarButton tbbDataAdd;
    private System.Windows.Forms.ToolBarButton tbbDataDel;
    private System.Windows.Forms.ToolBarButton tbbDataRefresh;
    private System.Windows.Forms.ToolBarButton tbbDataPrefs;
    private System.Windows.Forms.ToolBar tlbActions;
    private System.Windows.Forms.ToolBarButton tbbSep3;
    private System.Windows.Forms.ToolBarButton tbbSep4;
    private System.Windows.Forms.ImageList imlActions;
    private System.Windows.Forms.ToolBarButton toolBarButton3;
    private System.Windows.Forms.ToolBarButton toolBarButton7;
    private System.Windows.Forms.ToolBarButton tbbSep5;
    private System.Windows.Forms.ToolBarButton toolBarButton10;
    private System.Windows.Forms.ToolBarButton toolBarButton9;
    private System.Windows.Forms.ToolBarButton toolBarButton11;
    private System.Windows.Forms.ToolBarButton toolBarButton12;
    private System.Windows.Forms.ToolBarButton toolBarButton13;
    private System.Windows.Forms.PictureBox pbxSchematic;
    private System.Windows.Forms.Button btnPump1;
    private System.Windows.Forms.Button btnPump2;
    private System.Windows.Forms.Button btnPump3;
    private System.Windows.Forms.Button btnPump4;
    private ComponentNode _currentComponent;
    private System.Windows.Forms.PictureBox pbxTraffic;
    private System.Windows.Forms.ImageList imlTraffic;
    private System.Windows.Forms.LinkLabel lklAssetBruce;
    private System.Windows.Forms.Button btnAssetBruce;
    private System.Windows.Forms.Button btnAssetHarding;
    private System.Windows.Forms.LinkLabel lklAssetHarding;
    private System.Windows.Forms.Button btnAssetMiller;
    private System.Windows.Forms.LinkLabel lklAssetMiller;
    private System.Windows.Forms.Button btnAssetMagnus;
    private System.Windows.Forms.LinkLabel lklAssetMag;
    private System.Windows.Forms.Button btnAsset1;
    private System.Windows.Forms.Button button2;
    private System.Windows.Forms.Button button3;
    private System.Windows.Forms.Button button4;
    private System.Windows.Forms.PictureBox pictureBox3;
    private System.Windows.Forms.Timer tmrFlash;
    private System.Windows.Forms.Button btnOrange;
    private System.Windows.Forms.Button btnYellow;
    private System.Windows.Forms.Button btnMillerMOL;
    private System.Windows.Forms.Timer tmrAlert;
    private SchematicNode _currentSchematic;
    private System.Windows.Forms.Button btnProcess;
    private System.Windows.Forms.TabPage tabContract;
    private System.Windows.Forms.Label label1;
    private System.Windows.Forms.Label label3;
    private System.Windows.Forms.PictureBox pictureBox4;
    private System.Windows.Forms.PictureBox pictureBox5;
    private System.Windows.Forms.Button button1;
    private System.Windows.Forms.Button btnC01;
    private System.Windows.Forms.Button btnC02;
    private System.Windows.Forms.Button btnC03;
    private System.Windows.Forms.Button btnC06;
    private System.Windows.Forms.Button btnC05;
    private System.Windows.Forms.Button btnC04;
    private System.Windows.Forms.Button btnC09;
    private System.Windows.Forms.Button btnC08;
    private System.Windows.Forms.Button btnC07;
    private System.Windows.Forms.Button btnC12;
    private System.Windows.Forms.Button btnC11;
    private System.Windows.Forms.Button btnC10;
    private bool warning=true;

		public frmMain()
		{
			InitializeComponent();

      DataLayer.getDataLayer().populateTree(trvNav);

      this.tbcResults.Region =
        new Region(
        new RectangleF(this.tabAsset.Left,
                       this.tabAsset.Top,
                       this.tabAsset.Width,
                       this.tabAsset.Height));

      //TreeNode n = (TreeNode) trvNav.Nodes[0];
      //n.Expand();

      //GraphControl gc = new GraphControl();
      //this.tabGraph.Controls.Add(gc);

      //_vibrGraph = new VibrationGraph(this.pegVibr);
      //_vibrGraph.InitialiseGraph();

      // Tree Background Image
      //FileInfo fi = new FileInfo(Application.StartupPath + "\\img\\logo_bg1.jpg");
      //MessageBox.Show(fi.Exists.ToString());
      //this.trvNav.BackgroundImage = new Bitmap(fi.FullName);

      _dm = new DataModel();
		}
    
		/// <summary>
		/// Clean up any resources being used.
		/// </summary>
		protected override void Dispose( bool disposing )
		{
      //DbService.getDbService().Stop();
      
      if( disposing )
			{
				if (components != null) 
				{
					components.Dispose();
				}
			}
			base.Dispose(disposing);
		}

		#region Windows Form Designer generated code
		/// <summary>
		/// Required method for Designer support - do not modify
		/// the contents of this method with the code editor.
		/// </summary>
		private void InitializeComponent()
		{
      this.components = new System.ComponentModel.Container();
      System.Resources.ResourceManager resources = new System.Resources.ResourceManager(typeof(frmMain));
      this.stbMain = new System.Windows.Forms.StatusBar();
      this.sbpMessage = new System.Windows.Forms.StatusBarPanel();
      this.sbpWarning = new System.Windows.Forms.StatusBarPanel();
      this.sbpError = new System.Windows.Forms.StatusBarPanel();
      this.mmuMain = new System.Windows.Forms.MainMenu();
      this.mniFile = new System.Windows.Forms.MenuItem();
      this.mniFileNew = new System.Windows.Forms.MenuItem();
      this.mniFileOpen = new System.Windows.Forms.MenuItem();
      this.mniFileSave = new System.Windows.Forms.MenuItem();
      this.menuItem1 = new System.Windows.Forms.MenuItem();
      this.mniPrint = new System.Windows.Forms.MenuItem();
      this.mniPrintPreview = new System.Windows.Forms.MenuItem();
      this.menuItem4 = new System.Windows.Forms.MenuItem();
      this.mniExit = new System.Windows.Forms.MenuItem();
      this.mniEdit = new System.Windows.Forms.MenuItem();
      this.mniEditCut = new System.Windows.Forms.MenuItem();
      this.mnuEditCopy = new System.Windows.Forms.MenuItem();
      this.mniEditPaste = new System.Windows.Forms.MenuItem();
      this.mniView = new System.Windows.Forms.MenuItem();
      this.mniDataAdd = new System.Windows.Forms.MenuItem();
      this.mniDataDelete = new System.Windows.Forms.MenuItem();
      this.mniDataRefresh = new System.Windows.Forms.MenuItem();
      this.menuItem2 = new System.Windows.Forms.MenuItem();
      this.mniDataPrefs = new System.Windows.Forms.MenuItem();
      this.mniHelp = new System.Windows.Forms.MenuItem();
      this.mniHelpAbout = new System.Windows.Forms.MenuItem();
      this.trvNav = new System.Windows.Forms.TreeView();
      this.imlTree = new System.Windows.Forms.ImageList(this.components);
      this.tbcResults = new System.Windows.Forms.TabControl();
      this.tabCompany = new System.Windows.Forms.TabPage();
      this.btnYellow = new System.Windows.Forms.Button();
      this.btnOrange = new System.Windows.Forms.Button();
      this.lklAssetMag = new System.Windows.Forms.LinkLabel();
      this.btnAssetMagnus = new System.Windows.Forms.Button();
      this.lklAssetMiller = new System.Windows.Forms.LinkLabel();
      this.btnAssetMiller = new System.Windows.Forms.Button();
      this.lklAssetHarding = new System.Windows.Forms.LinkLabel();
      this.btnAssetHarding = new System.Windows.Forms.Button();
      this.btnAssetBruce = new System.Windows.Forms.Button();
      this.lklAssetBruce = new System.Windows.Forms.LinkLabel();
      this.lblAssetSub = new System.Windows.Forms.Label();
      this.lblAssetTitle = new System.Windows.Forms.Label();
      this.pbxJC = new System.Windows.Forms.PictureBox();
      this.pbxBP = new System.Windows.Forms.PictureBox();
      this.tabAsset = new System.Windows.Forms.TabPage();
      this.button4 = new System.Windows.Forms.Button();
      this.button3 = new System.Windows.Forms.Button();
      this.button2 = new System.Windows.Forms.Button();
      this.btnMillerMOL = new System.Windows.Forms.Button();
      this.btnAsset1 = new System.Windows.Forms.Button();
      this.lblAssetName = new System.Windows.Forms.Label();
      this.label2 = new System.Windows.Forms.Label();
      this.pictureBox7 = new System.Windows.Forms.PictureBox();
      this.pictureBox8 = new System.Windows.Forms.PictureBox();
      this.tabSchem = new System.Windows.Forms.TabPage();
      this.btnPump4 = new System.Windows.Forms.Button();
      this.btnPump3 = new System.Windows.Forms.Button();
      this.btnPump2 = new System.Windows.Forms.Button();
      this.btnPump1 = new System.Windows.Forms.Button();
      this.pbxSchematic = new System.Windows.Forms.PictureBox();
      this.lblSchemSub = new System.Windows.Forms.Label();
      this.lblSchemTitle = new System.Windows.Forms.Label();
      this.pictureBox1 = new System.Windows.Forms.PictureBox();
      this.pictureBox2 = new System.Windows.Forms.PictureBox();
      this.tabTag = new System.Windows.Forms.TabPage();
      this.button1 = new System.Windows.Forms.Button();
      this.pbxTraffic = new System.Windows.Forms.PictureBox();
      this.btnSeal2 = new System.Windows.Forms.Button();
      this.btnSeal1 = new System.Windows.Forms.Button();
      this.pbxPump = new System.Windows.Forms.PictureBox();
      this.lblTagSub = new System.Windows.Forms.Label();
      this.lblTagTitle = new System.Windows.Forms.Label();
      this.pictureBox9 = new System.Windows.Forms.PictureBox();
      this.pictureBox10 = new System.Windows.Forms.PictureBox();
      this.tabComp = new System.Windows.Forms.TabPage();
      this.pegTemp = new Gigasoft.ProEssentials.Pego();
      this.pegVibr = new Gigasoft.ProEssentials.Pego();
      this.pegSped = new Gigasoft.ProEssentials.Pego();
      this.lblGraphTitles = new System.Windows.Forms.Label();
      this.tabContract = new System.Windows.Forms.TabPage();
      this.btnC12 = new System.Windows.Forms.Button();
      this.btnC11 = new System.Windows.Forms.Button();
      this.btnC10 = new System.Windows.Forms.Button();
      this.btnC09 = new System.Windows.Forms.Button();
      this.btnC08 = new System.Windows.Forms.Button();
      this.btnC07 = new System.Windows.Forms.Button();
      this.btnC06 = new System.Windows.Forms.Button();
      this.btnC05 = new System.Windows.Forms.Button();
      this.btnC04 = new System.Windows.Forms.Button();
      this.btnC03 = new System.Windows.Forms.Button();
      this.btnC02 = new System.Windows.Forms.Button();
      this.btnC01 = new System.Windows.Forms.Button();
      this.label1 = new System.Windows.Forms.Label();
      this.label3 = new System.Windows.Forms.Label();
      this.pictureBox4 = new System.Windows.Forms.PictureBox();
      this.pictureBox5 = new System.Windows.Forms.PictureBox();
      this.btnProcess = new System.Windows.Forms.Button();
      this.pbxMaia = new System.Windows.Forms.PictureBox();
      this.tmrVibr = new System.Windows.Forms.Timer(this.components);
      this.imlMenu = new System.Windows.Forms.ImageList(this.components);
      this.muiMain = new Chris.Beckett.MenuImageLib.MenuImage(this.components);
      this.tlbMain = new System.Windows.Forms.ToolBar();
      this.tbbNew = new System.Windows.Forms.ToolBarButton();
      this.tbbOpen = new System.Windows.Forms.ToolBarButton();
      this.tbbSave = new System.Windows.Forms.ToolBarButton();
      this.tbbSep1 = new System.Windows.Forms.ToolBarButton();
      this.tbbPrint = new System.Windows.Forms.ToolBarButton();
      this.tbbPrintPreview = new System.Windows.Forms.ToolBarButton();
      this.tbbSep2 = new System.Windows.Forms.ToolBarButton();
      this.tbbDataAdd = new System.Windows.Forms.ToolBarButton();
      this.tbbDataDel = new System.Windows.Forms.ToolBarButton();
      this.tbbDataRefresh = new System.Windows.Forms.ToolBarButton();
      this.tbbDataPrefs = new System.Windows.Forms.ToolBarButton();
      this.tlbActions = new System.Windows.Forms.ToolBar();
      this.toolBarButton1 = new System.Windows.Forms.ToolBarButton();
      this.toolBarButton2 = new System.Windows.Forms.ToolBarButton();
      this.tbbSep3 = new System.Windows.Forms.ToolBarButton();
      this.toolBarButton4 = new System.Windows.Forms.ToolBarButton();
      this.toolBarButton5 = new System.Windows.Forms.ToolBarButton();
      this.toolBarButton6 = new System.Windows.Forms.ToolBarButton();
      this.tbbSep4 = new System.Windows.Forms.ToolBarButton();
      this.toolBarButton8 = new System.Windows.Forms.ToolBarButton();
      this.toolBarButton3 = new System.Windows.Forms.ToolBarButton();
      this.toolBarButton7 = new System.Windows.Forms.ToolBarButton();
      this.tbbSep5 = new System.Windows.Forms.ToolBarButton();
      this.toolBarButton10 = new System.Windows.Forms.ToolBarButton();
      this.toolBarButton9 = new System.Windows.Forms.ToolBarButton();
      this.toolBarButton11 = new System.Windows.Forms.ToolBarButton();
      this.toolBarButton12 = new System.Windows.Forms.ToolBarButton();
      this.toolBarButton13 = new System.Windows.Forms.ToolBarButton();
      this.imlActions = new System.Windows.Forms.ImageList(this.components);
      this.imlTraffic = new System.Windows.Forms.ImageList(this.components);
      this.pictureBox3 = new System.Windows.Forms.PictureBox();
      this.tmrFlash = new System.Windows.Forms.Timer(this.components);
      this.tmrAlert = new System.Windows.Forms.Timer(this.components);
      ((System.ComponentModel.ISupportInitialize)(this.sbpMessage)).BeginInit();
      ((System.ComponentModel.ISupportInitialize)(this.sbpWarning)).BeginInit();
      ((System.ComponentModel.ISupportInitialize)(this.sbpError)).BeginInit();
      this.tbcResults.SuspendLayout();
      this.tabCompany.SuspendLayout();
      this.tabAsset.SuspendLayout();
      this.tabSchem.SuspendLayout();
      this.tabTag.SuspendLayout();
      this.tabComp.SuspendLayout();
      this.tabContract.SuspendLayout();
      this.SuspendLayout();
      // 
      // stbMain
      // 
      this.stbMain.Location = new System.Drawing.Point(0, 653);
      this.stbMain.Name = "stbMain";
      this.stbMain.Panels.AddRange(new System.Windows.Forms.StatusBarPanel[] {
                                                                               this.sbpMessage,
                                                                               this.sbpWarning,
                                                                               this.sbpError});
      this.stbMain.ShowPanels = true;
      this.stbMain.Size = new System.Drawing.Size(1042, 22);
      this.stbMain.TabIndex = 0;
      this.stbMain.Text = "Ready";
      // 
      // sbpMessage
      // 
      this.sbpMessage.AutoSize = System.Windows.Forms.StatusBarPanelAutoSize.Spring;
      this.sbpMessage.Icon = ((System.Drawing.Icon)(resources.GetObject("sbpMessage.Icon")));
      this.sbpMessage.Text = "Ready";
      this.sbpMessage.Width = 846;
      // 
      // sbpWarning
      // 
      this.sbpWarning.Icon = ((System.Drawing.Icon)(resources.GetObject("sbpWarning.Icon")));
      this.sbpWarning.Text = "2 Warnings";
      this.sbpWarning.Width = 90;
      // 
      // sbpError
      // 
      this.sbpError.Icon = ((System.Drawing.Icon)(resources.GetObject("sbpError.Icon")));
      this.sbpError.Text = "3 Errors";
      this.sbpError.Width = 90;
      // 
      // mmuMain
      // 
      this.mmuMain.MenuItems.AddRange(new System.Windows.Forms.MenuItem[] {
                                                                            this.mniFile,
                                                                            this.mniEdit,
                                                                            this.mniView,
                                                                            this.mniHelp});
      // 
      // mniFile
      // 
      this.mniFile.Index = 0;
      this.mniFile.MenuItems.AddRange(new System.Windows.Forms.MenuItem[] {
                                                                            this.mniFileNew,
                                                                            this.mniFileOpen,
                                                                            this.mniFileSave,
                                                                            this.menuItem1,
                                                                            this.mniPrint,
                                                                            this.mniPrintPreview,
                                                                            this.menuItem4,
                                                                            this.mniExit});
      this.mniFile.Text = "&File";
      // 
      // mniFileNew
      // 
      this.mniFileNew.Index = 0;
      this.muiMain.SetMenuImage(this.mniFileNew, "5");
      this.mniFileNew.OwnerDraw = true;
      this.mniFileNew.Text = "&New";
      // 
      // mniFileOpen
      // 
      this.mniFileOpen.Index = 1;
      this.muiMain.SetMenuImage(this.mniFileOpen, "6");
      this.mniFileOpen.OwnerDraw = true;
      this.mniFileOpen.Text = "&Open";
      // 
      // mniFileSave
      // 
      this.mniFileSave.Index = 2;
      this.muiMain.SetMenuImage(this.mniFileSave, "7");
      this.mniFileSave.OwnerDraw = true;
      this.mniFileSave.Text = "&Save";
      // 
      // menuItem1
      // 
      this.menuItem1.Index = 3;
      this.muiMain.SetMenuImage(this.menuItem1, null);
      this.menuItem1.OwnerDraw = true;
      this.menuItem1.Text = "-";
      // 
      // mniPrint
      // 
      this.mniPrint.Index = 4;
      this.muiMain.SetMenuImage(this.mniPrint, "8");
      this.mniPrint.OwnerDraw = true;
      this.mniPrint.Text = "&Print";
      // 
      // mniPrintPreview
      // 
      this.mniPrintPreview.Index = 5;
      this.muiMain.SetMenuImage(this.mniPrintPreview, "9");
      this.mniPrintPreview.OwnerDraw = true;
      this.mniPrintPreview.Text = "Print Pre&view";
      // 
      // menuItem4
      // 
      this.menuItem4.Index = 6;
      this.muiMain.SetMenuImage(this.menuItem4, null);
      this.menuItem4.OwnerDraw = true;
      this.menuItem4.Text = "-";
      // 
      // mniExit
      // 
      this.mniExit.Index = 7;
      this.muiMain.SetMenuImage(this.mniExit, "0");
      this.mniExit.OwnerDraw = true;
      this.mniExit.Text = "E&xit";
      this.mniExit.Click += new System.EventHandler(this.mniExit_Click);
      // 
      // mniEdit
      // 
      this.mniEdit.Index = 1;
      this.mniEdit.MenuItems.AddRange(new System.Windows.Forms.MenuItem[] {
                                                                            this.mniEditCut,
                                                                            this.mnuEditCopy,
                                                                            this.mniEditPaste});
      this.mniEdit.Text = "&Edit";
      // 
      // mniEditCut
      // 
      this.mniEditCut.Index = 0;
      this.muiMain.SetMenuImage(this.mniEditCut, "1");
      this.mniEditCut.OwnerDraw = true;
      this.mniEditCut.Text = "Cu&t";
      // 
      // mnuEditCopy
      // 
      this.mnuEditCopy.Index = 1;
      this.muiMain.SetMenuImage(this.mnuEditCopy, "2");
      this.mnuEditCopy.OwnerDraw = true;
      this.mnuEditCopy.Text = "&Copy";
      // 
      // mniEditPaste
      // 
      this.mniEditPaste.Index = 2;
      this.muiMain.SetMenuImage(this.mniEditPaste, "3");
      this.mniEditPaste.OwnerDraw = true;
      this.mniEditPaste.Text = "&Paste";
      // 
      // mniView
      // 
      this.mniView.Index = 2;
      this.mniView.MenuItems.AddRange(new System.Windows.Forms.MenuItem[] {
                                                                            this.mniDataAdd,
                                                                            this.mniDataDelete,
                                                                            this.mniDataRefresh,
                                                                            this.menuItem2,
                                                                            this.mniDataPrefs});
      this.mniView.Text = "&Data";
      // 
      // mniDataAdd
      // 
      this.mniDataAdd.Index = 0;
      this.muiMain.SetMenuImage(this.mniDataAdd, "10");
      this.mniDataAdd.OwnerDraw = true;
      this.mniDataAdd.Text = "&Add";
      // 
      // mniDataDelete
      // 
      this.mniDataDelete.Index = 1;
      this.muiMain.SetMenuImage(this.mniDataDelete, "11");
      this.mniDataDelete.OwnerDraw = true;
      this.mniDataDelete.Text = "&Delete";
      // 
      // mniDataRefresh
      // 
      this.mniDataRefresh.Index = 2;
      this.muiMain.SetMenuImage(this.mniDataRefresh, "12");
      this.mniDataRefresh.OwnerDraw = true;
      this.mniDataRefresh.Text = "&Refresh";
      // 
      // menuItem2
      // 
      this.menuItem2.Index = 3;
      this.muiMain.SetMenuImage(this.menuItem2, null);
      this.menuItem2.OwnerDraw = true;
      this.menuItem2.Text = "-";
      // 
      // mniDataPrefs
      // 
      this.mniDataPrefs.Index = 4;
      this.muiMain.SetMenuImage(this.mniDataPrefs, "13");
      this.mniDataPrefs.OwnerDraw = true;
      this.mniDataPrefs.Text = "&Preferences...";
      // 
      // mniHelp
      // 
      this.mniHelp.Index = 3;
      this.mniHelp.MenuItems.AddRange(new System.Windows.Forms.MenuItem[] {
                                                                            this.mniHelpAbout});
      this.mniHelp.Text = "&Help";
      // 
      // mniHelpAbout
      // 
      this.mniHelpAbout.Index = 0;
      this.muiMain.SetMenuImage(this.mniHelpAbout, "4");
      this.mniHelpAbout.OwnerDraw = true;
      this.mniHelpAbout.Text = "&About";
      // 
      // trvNav
      // 
      this.trvNav.ImageList = this.imlTree;
      this.trvNav.Location = new System.Drawing.Point(8, 32);
      this.trvNav.Name = "trvNav";
      this.trvNav.Size = new System.Drawing.Size(376, 520);
      this.trvNav.TabIndex = 1;
      this.trvNav.AfterSelect += new System.Windows.Forms.TreeViewEventHandler(this.trvNav_AfterSelect);
      // 
      // imlTree
      // 
      this.imlTree.ColorDepth = System.Windows.Forms.ColorDepth.Depth32Bit;
      this.imlTree.ImageSize = new System.Drawing.Size(16, 16);
      this.imlTree.ImageStream = ((System.Windows.Forms.ImageListStreamer)(resources.GetObject("imlTree.ImageStream")));
      this.imlTree.TransparentColor = System.Drawing.Color.Transparent;
      // 
      // tbcResults
      // 
      this.tbcResults.Controls.Add(this.tabCompany);
      this.tbcResults.Controls.Add(this.tabAsset);
      this.tbcResults.Controls.Add(this.tabSchem);
      this.tbcResults.Controls.Add(this.tabTag);
      this.tbcResults.Controls.Add(this.tabComp);
      this.tbcResults.Controls.Add(this.tabContract);
      this.tbcResults.Location = new System.Drawing.Point(392, 48);
      this.tbcResults.Name = "tbcResults";
      this.tbcResults.SelectedIndex = 0;
      this.tbcResults.Size = new System.Drawing.Size(640, 592);
      this.tbcResults.TabIndex = 2;
      // 
      // tabCompany
      // 
      this.tabCompany.BackColor = System.Drawing.Color.White;
      this.tabCompany.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D;
      this.tabCompany.Controls.Add(this.btnYellow);
      this.tabCompany.Controls.Add(this.btnOrange);
      this.tabCompany.Controls.Add(this.lklAssetMag);
      this.tabCompany.Controls.Add(this.btnAssetMagnus);
      this.tabCompany.Controls.Add(this.lklAssetMiller);
      this.tabCompany.Controls.Add(this.btnAssetMiller);
      this.tabCompany.Controls.Add(this.lklAssetHarding);
      this.tabCompany.Controls.Add(this.btnAssetHarding);
      this.tabCompany.Controls.Add(this.btnAssetBruce);
      this.tabCompany.Controls.Add(this.lklAssetBruce);
      this.tabCompany.Controls.Add(this.lblAssetSub);
      this.tabCompany.Controls.Add(this.lblAssetTitle);
      this.tabCompany.Controls.Add(this.pbxJC);
      this.tabCompany.Controls.Add(this.pbxBP);
      this.tabCompany.Location = new System.Drawing.Point(4, 22);
      this.tabCompany.Name = "tabCompany";
      this.tabCompany.Size = new System.Drawing.Size(632, 566);
      this.tabCompany.TabIndex = 2;
      this.tabCompany.Text = "Company";
      // 
      // btnYellow
      // 
      this.btnYellow.BackColor = System.Drawing.Color.Yellow;
      this.btnYellow.Location = new System.Drawing.Point(136, 496);
      this.btnYellow.Name = "btnYellow";
      this.btnYellow.Size = new System.Drawing.Size(80, 40);
      this.btnYellow.TabIndex = 17;
      this.btnYellow.Text = "button1";
      this.btnYellow.Visible = false;
      // 
      // btnOrange
      // 
      this.btnOrange.BackColor = System.Drawing.Color.FromArgb(((System.Byte)(255)), ((System.Byte)(128)), ((System.Byte)(0)));
      this.btnOrange.Location = new System.Drawing.Point(48, 496);
      this.btnOrange.Name = "btnOrange";
      this.btnOrange.Size = new System.Drawing.Size(80, 40);
      this.btnOrange.TabIndex = 16;
      this.btnOrange.Text = "button1";
      this.btnOrange.Visible = false;
      // 
      // lklAssetMag
      // 
      this.lklAssetMag.Font = new System.Drawing.Font("Tahoma", 12F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((System.Byte)(0)));
      this.lklAssetMag.Location = new System.Drawing.Point(456, 152);
      this.lklAssetMag.Name = "lklAssetMag";
      this.lklAssetMag.Size = new System.Drawing.Size(104, 32);
      this.lklAssetMag.TabIndex = 15;
      this.lklAssetMag.TabStop = true;
      this.lklAssetMag.Text = "BP Magnus";
      this.lklAssetMag.LinkClicked += new System.Windows.Forms.LinkLabelLinkClickedEventHandler(this.lklAssetMag_LinkClicked);
      // 
      // btnAssetMagnus
      // 
      this.btnAssetMagnus.BackColor = System.Drawing.Color.ForestGreen;
      this.btnAssetMagnus.Image = ((System.Drawing.Image)(resources.GetObject("btnAssetMagnus.Image")));
      this.btnAssetMagnus.Location = new System.Drawing.Point(328, 96);
      this.btnAssetMagnus.Name = "btnAssetMagnus";
      this.btnAssetMagnus.Size = new System.Drawing.Size(104, 128);
      this.btnAssetMagnus.TabIndex = 14;
      // 
      // lklAssetMiller
      // 
      this.lklAssetMiller.Font = new System.Drawing.Font("Tahoma", 12F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((System.Byte)(0)));
      this.lklAssetMiller.Location = new System.Drawing.Point(456, 352);
      this.lklAssetMiller.Name = "lklAssetMiller";
      this.lklAssetMiller.Size = new System.Drawing.Size(88, 32);
      this.lklAssetMiller.TabIndex = 13;
      this.lklAssetMiller.TabStop = true;
      this.lklAssetMiller.Text = "BP Miller";
      this.lklAssetMiller.LinkClicked += new System.Windows.Forms.LinkLabelLinkClickedEventHandler(this.lklAssetMiller_LinkClicked);
      // 
      // btnAssetMiller
      // 
      this.btnAssetMiller.BackColor = System.Drawing.Color.FromArgb(((System.Byte)(255)), ((System.Byte)(128)), ((System.Byte)(0)));
      this.btnAssetMiller.Image = ((System.Drawing.Image)(resources.GetObject("btnAssetMiller.Image")));
      this.btnAssetMiller.Location = new System.Drawing.Point(328, 296);
      this.btnAssetMiller.Name = "btnAssetMiller";
      this.btnAssetMiller.Size = new System.Drawing.Size(104, 128);
      this.btnAssetMiller.TabIndex = 12;
      this.btnAssetMiller.Click += new System.EventHandler(this.btnAssetMiller_Click);
      // 
      // lklAssetHarding
      // 
      this.lklAssetHarding.Font = new System.Drawing.Font("Tahoma", 12F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((System.Byte)(0)));
      this.lklAssetHarding.Location = new System.Drawing.Point(168, 352);
      this.lklAssetHarding.Name = "lklAssetHarding";
      this.lklAssetHarding.Size = new System.Drawing.Size(104, 32);
      this.lklAssetHarding.TabIndex = 11;
      this.lklAssetHarding.TabStop = true;
      this.lklAssetHarding.Text = "BP Harding";
      this.lklAssetHarding.LinkClicked += new System.Windows.Forms.LinkLabelLinkClickedEventHandler(this.lklAssetHarding_LinkClicked);
      // 
      // btnAssetHarding
      // 
      this.btnAssetHarding.BackColor = System.Drawing.Color.ForestGreen;
      this.btnAssetHarding.Image = ((System.Drawing.Image)(resources.GetObject("btnAssetHarding.Image")));
      this.btnAssetHarding.Location = new System.Drawing.Point(40, 296);
      this.btnAssetHarding.Name = "btnAssetHarding";
      this.btnAssetHarding.Size = new System.Drawing.Size(104, 128);
      this.btnAssetHarding.TabIndex = 10;
      // 
      // btnAssetBruce
      // 
      this.btnAssetBruce.BackColor = System.Drawing.Color.ForestGreen;
      this.btnAssetBruce.Image = ((System.Drawing.Image)(resources.GetObject("btnAssetBruce.Image")));
      this.btnAssetBruce.Location = new System.Drawing.Point(40, 96);
      this.btnAssetBruce.Name = "btnAssetBruce";
      this.btnAssetBruce.Size = new System.Drawing.Size(104, 128);
      this.btnAssetBruce.TabIndex = 9;
      // 
      // lklAssetBruce
      // 
      this.lklAssetBruce.Font = new System.Drawing.Font("Tahoma", 12F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((System.Byte)(0)));
      this.lklAssetBruce.Location = new System.Drawing.Point(168, 152);
      this.lklAssetBruce.Name = "lklAssetBruce";
      this.lklAssetBruce.Size = new System.Drawing.Size(88, 32);
      this.lklAssetBruce.TabIndex = 8;
      this.lklAssetBruce.TabStop = true;
      this.lklAssetBruce.Text = "BP Bruce";
      this.lklAssetBruce.LinkClicked += new System.Windows.Forms.LinkLabelLinkClickedEventHandler(this.lklAssetBruce_LinkClicked);
      // 
      // lblAssetSub
      // 
      this.lblAssetSub.Font = new System.Drawing.Font("Tahoma", 12F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((System.Byte)(0)));
      this.lblAssetSub.Location = new System.Drawing.Point(136, 40);
      this.lblAssetSub.Name = "lblAssetSub";
      this.lblAssetSub.Size = new System.Drawing.Size(400, 24);
      this.lblAssetSub.TabIndex = 3;
      this.lblAssetSub.Text = "Key UKCS North Sea Assets";
      this.lblAssetSub.TextAlign = System.Drawing.ContentAlignment.TopCenter;
      // 
      // lblAssetTitle
      // 
      this.lblAssetTitle.Font = new System.Drawing.Font("Tahoma", 14.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((System.Byte)(0)));
      this.lblAssetTitle.Location = new System.Drawing.Point(136, 8);
      this.lblAssetTitle.Name = "lblAssetTitle";
      this.lblAssetTitle.Size = new System.Drawing.Size(400, 23);
      this.lblAssetTitle.TabIndex = 2;
      this.lblAssetTitle.Text = "BP Asset Management";
      this.lblAssetTitle.TextAlign = System.Drawing.ContentAlignment.TopCenter;
      // 
      // pbxJC
      // 
      this.pbxJC.Image = ((System.Drawing.Image)(resources.GetObject("pbxJC.Image")));
      this.pbxJC.Location = new System.Drawing.Point(8, 8);
      this.pbxJC.Name = "pbxJC";
      this.pbxJC.Size = new System.Drawing.Size(120, 56);
      this.pbxJC.TabIndex = 0;
      this.pbxJC.TabStop = false;
      // 
      // pbxBP
      // 
      this.pbxBP.Image = ((System.Drawing.Image)(resources.GetObject("pbxBP.Image")));
      this.pbxBP.Location = new System.Drawing.Point(568, 8);
      this.pbxBP.Name = "pbxBP";
      this.pbxBP.Size = new System.Drawing.Size(56, 64);
      this.pbxBP.TabIndex = 1;
      this.pbxBP.TabStop = false;
      // 
      // tabAsset
      // 
      this.tabAsset.BackColor = System.Drawing.Color.White;
      this.tabAsset.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D;
      this.tabAsset.Controls.Add(this.button4);
      this.tabAsset.Controls.Add(this.button3);
      this.tabAsset.Controls.Add(this.button2);
      this.tabAsset.Controls.Add(this.btnMillerMOL);
      this.tabAsset.Controls.Add(this.btnAsset1);
      this.tabAsset.Controls.Add(this.lblAssetName);
      this.tabAsset.Controls.Add(this.label2);
      this.tabAsset.Controls.Add(this.pictureBox7);
      this.tabAsset.Controls.Add(this.pictureBox8);
      this.tabAsset.Location = new System.Drawing.Point(4, 22);
      this.tabAsset.Name = "tabAsset";
      this.tabAsset.Size = new System.Drawing.Size(632, 566);
      this.tabAsset.TabIndex = 5;
      this.tabAsset.Text = "Asset";
      // 
      // button4
      // 
      this.button4.BackColor = System.Drawing.Color.ForestGreen;
      this.button4.Font = new System.Drawing.Font("Tahoma", 12F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((System.Byte)(0)));
      this.button4.ForeColor = System.Drawing.Color.Black;
      this.button4.Location = new System.Drawing.Point(408, 328);
      this.button4.Name = "button4";
      this.button4.Size = new System.Drawing.Size(120, 128);
      this.button4.TabIndex = 17;
      this.button4.Text = "Produced Water Injection";
      // 
      // button3
      // 
      this.button3.BackColor = System.Drawing.Color.ForestGreen;
      this.button3.Font = new System.Drawing.Font("Tahoma", 12F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((System.Byte)(0)));
      this.button3.ForeColor = System.Drawing.Color.Black;
      this.button3.Location = new System.Drawing.Point(200, 328);
      this.button3.Name = "button3";
      this.button3.Size = new System.Drawing.Size(120, 128);
      this.button3.TabIndex = 16;
      this.button3.Text = "Sea Water Injection";
      // 
      // button2
      // 
      this.button2.BackColor = System.Drawing.Color.ForestGreen;
      this.button2.Font = new System.Drawing.Font("Tahoma", 12F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((System.Byte)(0)));
      this.button2.ForeColor = System.Drawing.Color.Black;
      this.button2.Location = new System.Drawing.Point(408, 96);
      this.button2.Name = "button2";
      this.button2.Size = new System.Drawing.Size(120, 128);
      this.button2.TabIndex = 15;
      this.button2.Text = "Main Oil Line Boosters";
      // 
      // btnMillerMOL
      // 
      this.btnMillerMOL.BackColor = System.Drawing.Color.FromArgb(((System.Byte)(255)), ((System.Byte)(128)), ((System.Byte)(0)));
      this.btnMillerMOL.Font = new System.Drawing.Font("Tahoma", 12F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((System.Byte)(0)));
      this.btnMillerMOL.ForeColor = System.Drawing.Color.Black;
      this.btnMillerMOL.Location = new System.Drawing.Point(200, 96);
      this.btnMillerMOL.Name = "btnMillerMOL";
      this.btnMillerMOL.Size = new System.Drawing.Size(120, 128);
      this.btnMillerMOL.TabIndex = 14;
      this.btnMillerMOL.Text = "Main Oil Line Pumps";
      this.btnMillerMOL.Click += new System.EventHandler(this.btnMillerMOL_Click);
      // 
      // btnAsset1
      // 
      this.btnAsset1.BackColor = System.Drawing.Color.FromArgb(((System.Byte)(255)), ((System.Byte)(128)), ((System.Byte)(0)));
      this.btnAsset1.Image = ((System.Drawing.Image)(resources.GetObject("btnAsset1.Image")));
      this.btnAsset1.Location = new System.Drawing.Point(24, 96);
      this.btnAsset1.Name = "btnAsset1";
      this.btnAsset1.Size = new System.Drawing.Size(104, 128);
      this.btnAsset1.TabIndex = 13;
      // 
      // lblAssetName
      // 
      this.lblAssetName.Font = new System.Drawing.Font("Tahoma", 12F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((System.Byte)(0)));
      this.lblAssetName.Location = new System.Drawing.Point(136, 40);
      this.lblAssetName.Name = "lblAssetName";
      this.lblAssetName.Size = new System.Drawing.Size(400, 24);
      this.lblAssetName.TabIndex = 11;
      this.lblAssetName.Text = "Miller Mission Critical Pumps";
      this.lblAssetName.TextAlign = System.Drawing.ContentAlignment.TopCenter;
      // 
      // label2
      // 
      this.label2.Font = new System.Drawing.Font("Tahoma", 14.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((System.Byte)(0)));
      this.label2.Location = new System.Drawing.Point(136, 8);
      this.label2.Name = "label2";
      this.label2.Size = new System.Drawing.Size(400, 23);
      this.label2.TabIndex = 10;
      this.label2.Text = "BP Asset Management";
      this.label2.TextAlign = System.Drawing.ContentAlignment.TopCenter;
      // 
      // pictureBox7
      // 
      this.pictureBox7.Image = ((System.Drawing.Image)(resources.GetObject("pictureBox7.Image")));
      this.pictureBox7.Location = new System.Drawing.Point(8, 8);
      this.pictureBox7.Name = "pictureBox7";
      this.pictureBox7.Size = new System.Drawing.Size(120, 56);
      this.pictureBox7.TabIndex = 8;
      this.pictureBox7.TabStop = false;
      // 
      // pictureBox8
      // 
      this.pictureBox8.Image = ((System.Drawing.Image)(resources.GetObject("pictureBox8.Image")));
      this.pictureBox8.Location = new System.Drawing.Point(568, 8);
      this.pictureBox8.Name = "pictureBox8";
      this.pictureBox8.Size = new System.Drawing.Size(56, 64);
      this.pictureBox8.TabIndex = 9;
      this.pictureBox8.TabStop = false;
      // 
      // tabSchem
      // 
      this.tabSchem.BackColor = System.Drawing.Color.White;
      this.tabSchem.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D;
      this.tabSchem.Controls.Add(this.btnPump4);
      this.tabSchem.Controls.Add(this.btnPump3);
      this.tabSchem.Controls.Add(this.btnPump2);
      this.tabSchem.Controls.Add(this.btnPump1);
      this.tabSchem.Controls.Add(this.pbxSchematic);
      this.tabSchem.Controls.Add(this.lblSchemSub);
      this.tabSchem.Controls.Add(this.lblSchemTitle);
      this.tabSchem.Controls.Add(this.pictureBox1);
      this.tabSchem.Controls.Add(this.pictureBox2);
      this.tabSchem.Location = new System.Drawing.Point(4, 22);
      this.tabSchem.Name = "tabSchem";
      this.tabSchem.Size = new System.Drawing.Size(632, 566);
      this.tabSchem.TabIndex = 3;
      this.tabSchem.Text = "Schematic";
      // 
      // btnPump4
      // 
      this.btnPump4.BackColor = System.Drawing.Color.MidnightBlue;
      this.btnPump4.Font = new System.Drawing.Font("Tahoma", 6.75F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((System.Byte)(0)));
      this.btnPump4.ForeColor = System.Drawing.Color.White;
      this.btnPump4.Location = new System.Drawing.Point(384, 488);
      this.btnPump4.Name = "btnPump4";
      this.btnPump4.Size = new System.Drawing.Size(88, 16);
      this.btnPump4.TabIndex = 12;
      this.btnPump4.Text = "Pump 4";
      this.btnPump4.Click += new System.EventHandler(this.btnPump4_Click);
      // 
      // btnPump3
      // 
      this.btnPump3.BackColor = System.Drawing.Color.MidnightBlue;
      this.btnPump3.Font = new System.Drawing.Font("Tahoma", 6.75F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((System.Byte)(0)));
      this.btnPump3.ForeColor = System.Drawing.Color.White;
      this.btnPump3.Location = new System.Drawing.Point(232, 448);
      this.btnPump3.Name = "btnPump3";
      this.btnPump3.Size = new System.Drawing.Size(88, 16);
      this.btnPump3.TabIndex = 11;
      this.btnPump3.Text = "Pump 3";
      this.btnPump3.Click += new System.EventHandler(this.btnPump3_Click);
      // 
      // btnPump2
      // 
      this.btnPump2.BackColor = System.Drawing.Color.MidnightBlue;
      this.btnPump2.Font = new System.Drawing.Font("Tahoma", 6.75F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((System.Byte)(0)));
      this.btnPump2.ForeColor = System.Drawing.Color.White;
      this.btnPump2.Location = new System.Drawing.Point(168, 352);
      this.btnPump2.Name = "btnPump2";
      this.btnPump2.Size = new System.Drawing.Size(88, 16);
      this.btnPump2.TabIndex = 10;
      this.btnPump2.Text = "Pump 2";
      this.btnPump2.Click += new System.EventHandler(this.btnPump2_Click);
      // 
      // btnPump1
      // 
      this.btnPump1.BackColor = System.Drawing.Color.DarkGreen;
      this.btnPump1.Font = new System.Drawing.Font("Tahoma", 6.75F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((System.Byte)(0)));
      this.btnPump1.ForeColor = System.Drawing.Color.White;
      this.btnPump1.Location = new System.Drawing.Point(488, 304);
      this.btnPump1.Name = "btnPump1";
      this.btnPump1.Size = new System.Drawing.Size(88, 16);
      this.btnPump1.TabIndex = 9;
      this.btnPump1.Text = "Pump 1";
      this.btnPump1.Click += new System.EventHandler(this.btnPump1_Click);
      // 
      // pbxSchematic
      // 
      this.pbxSchematic.BackgroundImage = ((System.Drawing.Image)(resources.GetObject("pbxSchematic.BackgroundImage")));
      this.pbxSchematic.Location = new System.Drawing.Point(15, 80);
      this.pbxSchematic.Name = "pbxSchematic";
      this.pbxSchematic.Size = new System.Drawing.Size(600, 472);
      this.pbxSchematic.TabIndex = 8;
      this.pbxSchematic.TabStop = false;
      // 
      // lblSchemSub
      // 
      this.lblSchemSub.Font = new System.Drawing.Font("Tahoma", 12F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((System.Byte)(0)));
      this.lblSchemSub.Location = new System.Drawing.Point(136, 40);
      this.lblSchemSub.Name = "lblSchemSub";
      this.lblSchemSub.Size = new System.Drawing.Size(400, 24);
      this.lblSchemSub.TabIndex = 7;
      this.lblSchemSub.Text = "Miller Mission Critical Pumps";
      this.lblSchemSub.TextAlign = System.Drawing.ContentAlignment.TopCenter;
      // 
      // lblSchemTitle
      // 
      this.lblSchemTitle.Font = new System.Drawing.Font("Tahoma", 14.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((System.Byte)(0)));
      this.lblSchemTitle.Location = new System.Drawing.Point(136, 8);
      this.lblSchemTitle.Name = "lblSchemTitle";
      this.lblSchemTitle.Size = new System.Drawing.Size(400, 23);
      this.lblSchemTitle.TabIndex = 6;
      this.lblSchemTitle.Text = "BP Asset Management";
      this.lblSchemTitle.TextAlign = System.Drawing.ContentAlignment.TopCenter;
      // 
      // pictureBox1
      // 
      this.pictureBox1.Image = ((System.Drawing.Image)(resources.GetObject("pictureBox1.Image")));
      this.pictureBox1.Location = new System.Drawing.Point(8, 8);
      this.pictureBox1.Name = "pictureBox1";
      this.pictureBox1.Size = new System.Drawing.Size(120, 56);
      this.pictureBox1.TabIndex = 4;
      this.pictureBox1.TabStop = false;
      // 
      // pictureBox2
      // 
      this.pictureBox2.Image = ((System.Drawing.Image)(resources.GetObject("pictureBox2.Image")));
      this.pictureBox2.Location = new System.Drawing.Point(568, 8);
      this.pictureBox2.Name = "pictureBox2";
      this.pictureBox2.Size = new System.Drawing.Size(56, 64);
      this.pictureBox2.TabIndex = 5;
      this.pictureBox2.TabStop = false;
      // 
      // tabTag
      // 
      this.tabTag.BackColor = System.Drawing.Color.White;
      this.tabTag.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D;
      this.tabTag.Controls.Add(this.button1);
      this.tabTag.Controls.Add(this.pbxTraffic);
      this.tabTag.Controls.Add(this.btnSeal2);
      this.tabTag.Controls.Add(this.btnSeal1);
      this.tabTag.Controls.Add(this.pbxPump);
      this.tabTag.Controls.Add(this.lblTagSub);
      this.tabTag.Controls.Add(this.lblTagTitle);
      this.tabTag.Controls.Add(this.pictureBox9);
      this.tabTag.Controls.Add(this.pictureBox10);
      this.tabTag.Location = new System.Drawing.Point(4, 22);
      this.tabTag.Name = "tabTag";
      this.tabTag.Size = new System.Drawing.Size(632, 566);
      this.tabTag.TabIndex = 6;
      this.tabTag.Text = "Tag";
      // 
      // button1
      // 
      this.button1.BackColor = System.Drawing.Color.Brown;
      this.button1.Font = new System.Drawing.Font("Tahoma", 8.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((System.Byte)(0)));
      this.button1.ForeColor = System.Drawing.Color.White;
      this.button1.Location = new System.Drawing.Point(256, 104);
      this.button1.Name = "button1";
      this.button1.Size = new System.Drawing.Size(80, 40);
      this.button1.TabIndex = 16;
      this.button1.Text = "Process";
      // 
      // pbxTraffic
      // 
      this.pbxTraffic.Image = ((System.Drawing.Image)(resources.GetObject("pbxTraffic.Image")));
      this.pbxTraffic.Location = new System.Drawing.Point(512, 120);
      this.pbxTraffic.Name = "pbxTraffic";
      this.pbxTraffic.Size = new System.Drawing.Size(48, 48);
      this.pbxTraffic.TabIndex = 15;
      this.pbxTraffic.TabStop = false;
      // 
      // btnSeal2
      // 
      this.btnSeal2.BackColor = System.Drawing.Color.Brown;
      this.btnSeal2.Font = new System.Drawing.Font("Tahoma", 8.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((System.Byte)(0)));
      this.btnSeal2.ForeColor = System.Drawing.Color.White;
      this.btnSeal2.Location = new System.Drawing.Point(528, 328);
      this.btnSeal2.Name = "btnSeal2";
      this.btnSeal2.Size = new System.Drawing.Size(80, 40);
      this.btnSeal2.TabIndex = 14;
      this.btnSeal2.Text = "Non Drive End";
      this.btnSeal2.Click += new System.EventHandler(this.btnSeal2_Click);
      // 
      // btnSeal1
      // 
      this.btnSeal1.BackColor = System.Drawing.Color.Brown;
      this.btnSeal1.Font = new System.Drawing.Font("Tahoma", 8.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((System.Byte)(0)));
      this.btnSeal1.ForeColor = System.Drawing.Color.White;
      this.btnSeal1.Location = new System.Drawing.Point(8, 288);
      this.btnSeal1.Name = "btnSeal1";
      this.btnSeal1.Size = new System.Drawing.Size(80, 40);
      this.btnSeal1.TabIndex = 13;
      this.btnSeal1.Text = "Drive End";
      this.btnSeal1.Click += new System.EventHandler(this.btnSeal1_Click);
      // 
      // pbxPump
      // 
      this.pbxPump.Image = ((System.Drawing.Image)(resources.GetObject("pbxPump.Image")));
      this.pbxPump.Location = new System.Drawing.Point(16, 80);
      this.pbxPump.Name = "pbxPump";
      this.pbxPump.Size = new System.Drawing.Size(600, 480);
      this.pbxPump.TabIndex = 12;
      this.pbxPump.TabStop = false;
      // 
      // lblTagSub
      // 
      this.lblTagSub.Font = new System.Drawing.Font("Tahoma", 12F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((System.Byte)(0)));
      this.lblTagSub.Location = new System.Drawing.Point(136, 40);
      this.lblTagSub.Name = "lblTagSub";
      this.lblTagSub.Size = new System.Drawing.Size(400, 24);
      this.lblTagSub.TabIndex = 11;
      this.lblTagSub.Text = "Miller Mission Critical Pumps";
      this.lblTagSub.TextAlign = System.Drawing.ContentAlignment.TopCenter;
      // 
      // lblTagTitle
      // 
      this.lblTagTitle.Font = new System.Drawing.Font("Tahoma", 14.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((System.Byte)(0)));
      this.lblTagTitle.Location = new System.Drawing.Point(136, 8);
      this.lblTagTitle.Name = "lblTagTitle";
      this.lblTagTitle.Size = new System.Drawing.Size(400, 23);
      this.lblTagTitle.TabIndex = 10;
      this.lblTagTitle.Text = "BP Asset Management";
      this.lblTagTitle.TextAlign = System.Drawing.ContentAlignment.TopCenter;
      // 
      // pictureBox9
      // 
      this.pictureBox9.Image = ((System.Drawing.Image)(resources.GetObject("pictureBox9.Image")));
      this.pictureBox9.Location = new System.Drawing.Point(8, 8);
      this.pictureBox9.Name = "pictureBox9";
      this.pictureBox9.Size = new System.Drawing.Size(120, 56);
      this.pictureBox9.TabIndex = 8;
      this.pictureBox9.TabStop = false;
      // 
      // pictureBox10
      // 
      this.pictureBox10.Image = ((System.Drawing.Image)(resources.GetObject("pictureBox10.Image")));
      this.pictureBox10.Location = new System.Drawing.Point(568, 8);
      this.pictureBox10.Name = "pictureBox10";
      this.pictureBox10.Size = new System.Drawing.Size(56, 64);
      this.pictureBox10.TabIndex = 9;
      this.pictureBox10.TabStop = false;
      // 
      // tabComp
      // 
      this.tabComp.Controls.Add(this.pegTemp);
      this.tabComp.Controls.Add(this.pegVibr);
      this.tabComp.Controls.Add(this.pegSped);
      this.tabComp.Controls.Add(this.lblGraphTitles);
      this.tabComp.Location = new System.Drawing.Point(4, 22);
      this.tabComp.Name = "tabComp";
      this.tabComp.Size = new System.Drawing.Size(632, 566);
      this.tabComp.TabIndex = 0;
      this.tabComp.Text = "Vibration";
      // 
      // pegTemp
      // 
      this.pegTemp.Font = new System.Drawing.Font("Tahoma", 6.75F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((System.Byte)(0)));
      this.pegTemp.Location = new System.Drawing.Point(8, 16);
      this.pegTemp.Name = "pegTemp";
      this.pegTemp.Size = new System.Drawing.Size(616, 176);
      this.pegTemp.TabIndex = 2;
      this.pegTemp.Text = "X";
      // 
      // pegVibr
      // 
      this.pegVibr.Font = new System.Drawing.Font("Tahoma", 6.75F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((System.Byte)(0)));
      this.pegVibr.Location = new System.Drawing.Point(8, 200);
      this.pegVibr.Name = "pegVibr";
      this.pegVibr.Size = new System.Drawing.Size(616, 176);
      this.pegVibr.TabIndex = 0;
      this.pegVibr.Text = "X";
      // 
      // pegSped
      // 
      this.pegSped.Font = new System.Drawing.Font("Tahoma", 6.75F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((System.Byte)(0)));
      this.pegSped.Location = new System.Drawing.Point(8, 384);
      this.pegSped.Name = "pegSped";
      this.pegSped.Size = new System.Drawing.Size(616, 176);
      this.pegSped.TabIndex = 3;
      this.pegSped.Text = "X";
      // 
      // lblGraphTitles
      // 
      this.lblGraphTitles.Font = new System.Drawing.Font("Tahoma", 9F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((System.Byte)(0)));
      this.lblGraphTitles.Location = new System.Drawing.Point(8, 0);
      this.lblGraphTitles.Name = "lblGraphTitles";
      this.lblGraphTitles.Size = new System.Drawing.Size(368, 16);
      this.lblGraphTitles.TabIndex = 1;
      this.lblGraphTitles.Text = "TAG :: COMPONENT";
      // 
      // tabContract
      // 
      this.tabContract.BackColor = System.Drawing.Color.White;
      this.tabContract.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D;
      this.tabContract.Controls.Add(this.btnC12);
      this.tabContract.Controls.Add(this.btnC11);
      this.tabContract.Controls.Add(this.btnC10);
      this.tabContract.Controls.Add(this.btnC09);
      this.tabContract.Controls.Add(this.btnC08);
      this.tabContract.Controls.Add(this.btnC07);
      this.tabContract.Controls.Add(this.btnC06);
      this.tabContract.Controls.Add(this.btnC05);
      this.tabContract.Controls.Add(this.btnC04);
      this.tabContract.Controls.Add(this.btnC03);
      this.tabContract.Controls.Add(this.btnC02);
      this.tabContract.Controls.Add(this.btnC01);
      this.tabContract.Controls.Add(this.label1);
      this.tabContract.Controls.Add(this.label3);
      this.tabContract.Controls.Add(this.pictureBox4);
      this.tabContract.Controls.Add(this.pictureBox5);
      this.tabContract.Location = new System.Drawing.Point(4, 22);
      this.tabContract.Name = "tabContract";
      this.tabContract.Size = new System.Drawing.Size(632, 566);
      this.tabContract.TabIndex = 7;
      this.tabContract.Text = "Contract";
      // 
      // btnC12
      // 
      this.btnC12.BackColor = System.Drawing.Color.ForestGreen;
      this.btnC12.Font = new System.Drawing.Font("Tahoma", 11.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((System.Byte)(0)));
      this.btnC12.ForeColor = System.Drawing.Color.White;
      this.btnC12.Location = new System.Drawing.Point(424, 448);
      this.btnC12.Name = "btnC12";
      this.btnC12.Size = new System.Drawing.Size(184, 80);
      this.btnC12.TabIndex = 19;
      this.btnC12.Text = "Solvay, Livorno, Italy";
      // 
      // btnC11
      // 
      this.btnC11.BackColor = System.Drawing.Color.ForestGreen;
      this.btnC11.Font = new System.Drawing.Font("Tahoma", 11.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((System.Byte)(0)));
      this.btnC11.ForeColor = System.Drawing.Color.White;
      this.btnC11.Location = new System.Drawing.Point(224, 448);
      this.btnC11.Name = "btnC11";
      this.btnC11.Size = new System.Drawing.Size(184, 80);
      this.btnC11.TabIndex = 18;
      this.btnC11.Text = "Shell Pernis, NL";
      // 
      // btnC10
      // 
      this.btnC10.BackColor = System.Drawing.Color.ForestGreen;
      this.btnC10.Font = new System.Drawing.Font("Tahoma", 11.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((System.Byte)(0)));
      this.btnC10.ForeColor = System.Drawing.Color.White;
      this.btnC10.Location = new System.Drawing.Point(24, 448);
      this.btnC10.Name = "btnC10";
      this.btnC10.Size = new System.Drawing.Size(184, 80);
      this.btnC10.TabIndex = 17;
      this.btnC10.Text = "SASOL, South Africa";
      // 
      // btnC09
      // 
      this.btnC09.BackColor = System.Drawing.Color.ForestGreen;
      this.btnC09.Font = new System.Drawing.Font("Tahoma", 11.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((System.Byte)(0)));
      this.btnC09.ForeColor = System.Drawing.Color.White;
      this.btnC09.Location = new System.Drawing.Point(424, 336);
      this.btnC09.Name = "btnC09";
      this.btnC09.Size = new System.Drawing.Size(184, 80);
      this.btnC09.TabIndex = 16;
      this.btnC09.Text = "Innovene (Ex BP) Grangemouth, UK";
      // 
      // btnC08
      // 
      this.btnC08.BackColor = System.Drawing.Color.ForestGreen;
      this.btnC08.Font = new System.Drawing.Font("Tahoma", 11.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((System.Byte)(0)));
      this.btnC08.ForeColor = System.Drawing.Color.White;
      this.btnC08.Location = new System.Drawing.Point(224, 336);
      this.btnC08.Name = "btnC08";
      this.btnC08.Size = new System.Drawing.Size(184, 80);
      this.btnC08.TabIndex = 15;
      this.btnC08.Text = "ExxonMobil, Dunkirk, France";
      // 
      // btnC07
      // 
      this.btnC07.BackColor = System.Drawing.Color.ForestGreen;
      this.btnC07.Font = new System.Drawing.Font("Tahoma", 11.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((System.Byte)(0)));
      this.btnC07.ForeColor = System.Drawing.Color.White;
      this.btnC07.Location = new System.Drawing.Point(24, 336);
      this.btnC07.Name = "btnC07";
      this.btnC07.Size = new System.Drawing.Size(184, 80);
      this.btnC07.TabIndex = 14;
      this.btnC07.Text = "Conoco, Immingham";
      // 
      // btnC06
      // 
      this.btnC06.BackColor = System.Drawing.Color.ForestGreen;
      this.btnC06.Font = new System.Drawing.Font("Tahoma", 11.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((System.Byte)(0)));
      this.btnC06.ForeColor = System.Drawing.Color.White;
      this.btnC06.Location = new System.Drawing.Point(424, 224);
      this.btnC06.Name = "btnC06";
      this.btnC06.Size = new System.Drawing.Size(184, 80);
      this.btnC06.TabIndex = 13;
      this.btnC06.Text = "Chevron, Pembroke, Wales";
      // 
      // btnC05
      // 
      this.btnC05.BackColor = System.Drawing.Color.ForestGreen;
      this.btnC05.Font = new System.Drawing.Font("Tahoma", 11.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((System.Byte)(0)));
      this.btnC05.ForeColor = System.Drawing.Color.White;
      this.btnC05.Location = new System.Drawing.Point(222, 224);
      this.btnC05.Name = "btnC05";
      this.btnC05.Size = new System.Drawing.Size(184, 80);
      this.btnC05.TabIndex = 12;
      this.btnC05.Text = "Cepsa, Petresa, Spain";
      // 
      // btnC04
      // 
      this.btnC04.BackColor = System.Drawing.Color.ForestGreen;
      this.btnC04.Font = new System.Drawing.Font("Tahoma", 11.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((System.Byte)(0)));
      this.btnC04.ForeColor = System.Drawing.Color.White;
      this.btnC04.Location = new System.Drawing.Point(24, 224);
      this.btnC04.Name = "btnC04";
      this.btnC04.Size = new System.Drawing.Size(184, 80);
      this.btnC04.TabIndex = 11;
      this.btnC04.Text = "Conoco, Immingham";
      // 
      // btnC03
      // 
      this.btnC03.BackColor = System.Drawing.Color.ForestGreen;
      this.btnC03.Font = new System.Drawing.Font("Tahoma", 11.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((System.Byte)(0)));
      this.btnC03.ForeColor = System.Drawing.Color.White;
      this.btnC03.Location = new System.Drawing.Point(424, 112);
      this.btnC03.Name = "btnC03";
      this.btnC03.Size = new System.Drawing.Size(184, 80);
      this.btnC03.TabIndex = 10;
      this.btnC03.Text = "BP Nerefco, NL";
      // 
      // btnC02
      // 
      this.btnC02.BackColor = System.Drawing.Color.ForestGreen;
      this.btnC02.Font = new System.Drawing.Font("Tahoma", 11.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((System.Byte)(0)));
      this.btnC02.ForeColor = System.Drawing.Color.White;
      this.btnC02.Location = new System.Drawing.Point(224, 112);
      this.btnC02.Name = "btnC02";
      this.btnC02.Size = new System.Drawing.Size(184, 80);
      this.btnC02.TabIndex = 9;
      this.btnC02.Text = "BP UKCS";
      this.btnC02.Click += new System.EventHandler(this.btnC02_Click);
      // 
      // btnC01
      // 
      this.btnC01.BackColor = System.Drawing.Color.ForestGreen;
      this.btnC01.Font = new System.Drawing.Font("Tahoma", 11.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((System.Byte)(0)));
      this.btnC01.ForeColor = System.Drawing.Color.White;
      this.btnC01.Location = new System.Drawing.Point(24, 112);
      this.btnC01.Name = "btnC01";
      this.btnC01.Size = new System.Drawing.Size(184, 80);
      this.btnC01.TabIndex = 8;
      this.btnC01.Text = "BP Forties Pipeline, UK";
      // 
      // label1
      // 
      this.label1.Font = new System.Drawing.Font("Tahoma", 12F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((System.Byte)(0)));
      this.label1.Location = new System.Drawing.Point(136, 40);
      this.label1.Name = "label1";
      this.label1.Size = new System.Drawing.Size(400, 24);
      this.label1.TabIndex = 7;
      this.label1.Text = "Contract Management";
      this.label1.TextAlign = System.Drawing.ContentAlignment.TopCenter;
      // 
      // label3
      // 
      this.label3.Font = new System.Drawing.Font("Tahoma", 14.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((System.Byte)(0)));
      this.label3.Location = new System.Drawing.Point(136, 8);
      this.label3.Name = "label3";
      this.label3.Size = new System.Drawing.Size(400, 23);
      this.label3.TabIndex = 6;
      this.label3.Text = "Performance Plus";
      this.label3.TextAlign = System.Drawing.ContentAlignment.TopCenter;
      // 
      // pictureBox4
      // 
      this.pictureBox4.Image = ((System.Drawing.Image)(resources.GetObject("pictureBox4.Image")));
      this.pictureBox4.Location = new System.Drawing.Point(8, 8);
      this.pictureBox4.Name = "pictureBox4";
      this.pictureBox4.Size = new System.Drawing.Size(120, 56);
      this.pictureBox4.TabIndex = 4;
      this.pictureBox4.TabStop = false;
      // 
      // pictureBox5
      // 
      this.pictureBox5.Image = ((System.Drawing.Image)(resources.GetObject("pictureBox5.Image")));
      this.pictureBox5.Location = new System.Drawing.Point(568, 8);
      this.pictureBox5.Name = "pictureBox5";
      this.pictureBox5.Size = new System.Drawing.Size(56, 64);
      this.pictureBox5.TabIndex = 5;
      this.pictureBox5.TabStop = false;
      // 
      // btnProcess
      // 
      this.btnProcess.Location = new System.Drawing.Point(0, 0);
      this.btnProcess.Name = "btnProcess";
      this.btnProcess.TabIndex = 0;
      // 
      // pbxMaia
      // 
      this.pbxMaia.Image = ((System.Drawing.Image)(resources.GetObject("pbxMaia.Image")));
      this.pbxMaia.Location = new System.Drawing.Point(392, 8);
      this.pbxMaia.Name = "pbxMaia";
      this.pbxMaia.Size = new System.Drawing.Size(656, 72);
      this.pbxMaia.TabIndex = 3;
      this.pbxMaia.TabStop = false;
      // 
      // tmrVibr
      // 
      this.tmrVibr.Tick += new System.EventHandler(this.tmrVibr_Tick);
      // 
      // imlMenu
      // 
      this.imlMenu.ColorDepth = System.Windows.Forms.ColorDepth.Depth32Bit;
      this.imlMenu.ImageSize = new System.Drawing.Size(16, 16);
      this.imlMenu.ImageStream = ((System.Windows.Forms.ImageListStreamer)(resources.GetObject("imlMenu.ImageStream")));
      this.imlMenu.TransparentColor = System.Drawing.Color.Transparent;
      // 
      // muiMain
      // 
      this.muiMain.ImageList = this.imlMenu;
      // 
      // tlbMain
      // 
      this.tlbMain.Appearance = System.Windows.Forms.ToolBarAppearance.Flat;
      this.tlbMain.Buttons.AddRange(new System.Windows.Forms.ToolBarButton[] {
                                                                               this.tbbNew,
                                                                               this.tbbOpen,
                                                                               this.tbbSave,
                                                                               this.tbbSep1,
                                                                               this.tbbPrint,
                                                                               this.tbbPrintPreview,
                                                                               this.tbbSep2,
                                                                               this.tbbDataAdd,
                                                                               this.tbbDataDel,
                                                                               this.tbbDataRefresh,
                                                                               this.tbbDataPrefs});
      this.tlbMain.ButtonSize = new System.Drawing.Size(16, 16);
      this.tlbMain.Divider = false;
      this.tlbMain.DropDownArrows = true;
      this.tlbMain.ImageList = this.imlMenu;
      this.tlbMain.Location = new System.Drawing.Point(0, 0);
      this.tlbMain.Name = "tlbMain";
      this.tlbMain.ShowToolTips = true;
      this.tlbMain.Size = new System.Drawing.Size(1042, 26);
      this.tlbMain.TabIndex = 4;
      this.tlbMain.ButtonClick += new System.Windows.Forms.ToolBarButtonClickEventHandler(this.tlbMain_ButtonClick);
      // 
      // tbbNew
      // 
      this.tbbNew.ImageIndex = 5;
      // 
      // tbbOpen
      // 
      this.tbbOpen.ImageIndex = 6;
      // 
      // tbbSave
      // 
      this.tbbSave.ImageIndex = 7;
      // 
      // tbbSep1
      // 
      this.tbbSep1.Style = System.Windows.Forms.ToolBarButtonStyle.Separator;
      // 
      // tbbPrint
      // 
      this.tbbPrint.ImageIndex = 8;
      // 
      // tbbPrintPreview
      // 
      this.tbbPrintPreview.ImageIndex = 9;
      // 
      // tbbSep2
      // 
      this.tbbSep2.Style = System.Windows.Forms.ToolBarButtonStyle.Separator;
      // 
      // tbbDataAdd
      // 
      this.tbbDataAdd.ImageIndex = 10;
      // 
      // tbbDataDel
      // 
      this.tbbDataDel.ImageIndex = 11;
      // 
      // tbbDataRefresh
      // 
      this.tbbDataRefresh.ImageIndex = 12;
      // 
      // tbbDataPrefs
      // 
      this.tbbDataPrefs.ImageIndex = 13;
      // 
      // tlbActions
      // 
      this.tlbActions.Appearance = System.Windows.Forms.ToolBarAppearance.Flat;
      this.tlbActions.Buttons.AddRange(new System.Windows.Forms.ToolBarButton[] {
                                                                                  this.toolBarButton1,
                                                                                  this.toolBarButton2,
                                                                                  this.tbbSep3,
                                                                                  this.toolBarButton4,
                                                                                  this.toolBarButton5,
                                                                                  this.toolBarButton6,
                                                                                  this.tbbSep4,
                                                                                  this.toolBarButton8,
                                                                                  this.toolBarButton3,
                                                                                  this.toolBarButton7,
                                                                                  this.tbbSep5,
                                                                                  this.toolBarButton10,
                                                                                  this.toolBarButton9,
                                                                                  this.toolBarButton11,
                                                                                  this.toolBarButton12,
                                                                                  this.toolBarButton13});
      this.tlbActions.ButtonSize = new System.Drawing.Size(16, 16);
      this.tlbActions.Divider = false;
      this.tlbActions.Dock = System.Windows.Forms.DockStyle.None;
      this.tlbActions.DropDownArrows = true;
      this.tlbActions.ImageList = this.imlActions;
      this.tlbActions.Location = new System.Drawing.Point(400, 16);
      this.tlbActions.Name = "tlbActions";
      this.tlbActions.ShowToolTips = true;
      this.tlbActions.Size = new System.Drawing.Size(360, 26);
      this.tlbActions.TabIndex = 5;
      // 
      // toolBarButton1
      // 
      this.toolBarButton1.ImageIndex = 0;
      // 
      // toolBarButton2
      // 
      this.toolBarButton2.ImageIndex = 1;
      // 
      // tbbSep3
      // 
      this.tbbSep3.Style = System.Windows.Forms.ToolBarButtonStyle.Separator;
      // 
      // toolBarButton4
      // 
      this.toolBarButton4.ImageIndex = 2;
      // 
      // toolBarButton5
      // 
      this.toolBarButton5.ImageIndex = 3;
      // 
      // toolBarButton6
      // 
      this.toolBarButton6.ImageIndex = 4;
      // 
      // tbbSep4
      // 
      this.tbbSep4.ImageIndex = 0;
      this.tbbSep4.Style = System.Windows.Forms.ToolBarButtonStyle.Separator;
      // 
      // toolBarButton8
      // 
      this.toolBarButton8.ImageIndex = 5;
      // 
      // toolBarButton3
      // 
      this.toolBarButton3.ImageIndex = 6;
      // 
      // toolBarButton7
      // 
      this.toolBarButton7.ImageIndex = 7;
      // 
      // tbbSep5
      // 
      this.tbbSep5.Style = System.Windows.Forms.ToolBarButtonStyle.Separator;
      // 
      // toolBarButton10
      // 
      this.toolBarButton10.ImageIndex = 8;
      // 
      // toolBarButton9
      // 
      this.toolBarButton9.ImageIndex = 9;
      // 
      // toolBarButton11
      // 
      this.toolBarButton11.ImageIndex = 10;
      // 
      // toolBarButton12
      // 
      this.toolBarButton12.ImageIndex = 11;
      // 
      // toolBarButton13
      // 
      this.toolBarButton13.ImageIndex = 12;
      // 
      // imlActions
      // 
      this.imlActions.ImageSize = new System.Drawing.Size(16, 16);
      this.imlActions.ImageStream = ((System.Windows.Forms.ImageListStreamer)(resources.GetObject("imlActions.ImageStream")));
      this.imlActions.TransparentColor = System.Drawing.Color.Transparent;
      // 
      // imlTraffic
      // 
      this.imlTraffic.ColorDepth = System.Windows.Forms.ColorDepth.Depth32Bit;
      this.imlTraffic.ImageSize = new System.Drawing.Size(48, 48);
      this.imlTraffic.ImageStream = ((System.Windows.Forms.ImageListStreamer)(resources.GetObject("imlTraffic.ImageStream")));
      this.imlTraffic.TransparentColor = System.Drawing.Color.Transparent;
      // 
      // pictureBox3
      // 
      this.pictureBox3.BackgroundImage = ((System.Drawing.Image)(resources.GetObject("pictureBox3.BackgroundImage")));
      this.pictureBox3.Location = new System.Drawing.Point(8, 560);
      this.pictureBox3.Name = "pictureBox3";
      this.pictureBox3.Size = new System.Drawing.Size(376, 80);
      this.pictureBox3.TabIndex = 6;
      this.pictureBox3.TabStop = false;
      // 
      // tmrFlash
      // 
      this.tmrFlash.Enabled = true;
      this.tmrFlash.Interval = 15000;
      this.tmrFlash.Tick += new System.EventHandler(this.tmrFlash_Tick);
      // 
      // tmrAlert
      // 
      this.tmrAlert.Interval = 15000;
      this.tmrAlert.Tick += new System.EventHandler(this.tmrAlert_Tick);
      // 
      // frmMain
      // 
      this.AutoScaleBaseSize = new System.Drawing.Size(5, 14);
      this.ClientSize = new System.Drawing.Size(1042, 675);
      this.Controls.Add(this.pictureBox3);
      this.Controls.Add(this.tlbActions);
      this.Controls.Add(this.tbcResults);
      this.Controls.Add(this.pbxMaia);
      this.Controls.Add(this.tlbMain);
      this.Controls.Add(this.trvNav);
      this.Controls.Add(this.stbMain);
      this.Font = new System.Drawing.Font("Tahoma", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((System.Byte)(0)));
      this.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedSingle;
      this.Icon = ((System.Drawing.Icon)(resources.GetObject("$this.Icon")));
      this.MaximizeBox = false;
      this.Menu = this.mmuMain;
      this.Name = "frmMain";
      this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
      this.Text = "Maia Systems Acumen";
      ((System.ComponentModel.ISupportInitialize)(this.sbpMessage)).EndInit();
      ((System.ComponentModel.ISupportInitialize)(this.sbpWarning)).EndInit();
      ((System.ComponentModel.ISupportInitialize)(this.sbpError)).EndInit();
      this.tbcResults.ResumeLayout(false);
      this.tabCompany.ResumeLayout(false);
      this.tabAsset.ResumeLayout(false);
      this.tabSchem.ResumeLayout(false);
      this.tabTag.ResumeLayout(false);
      this.tabComp.ResumeLayout(false);
      this.tabContract.ResumeLayout(false);
      this.ResumeLayout(false);

    }
		#endregion

		/// <summary>
		/// The main entry point for the application.
		/// </summary>
    [STAThread]
    static void Main() 
    {
      if (!DbService.getDbService().Check()) 
      {
        MessageBox.Show("Could not find the database service 'AcumenDb' - have you correctly installed this application?",
          "Missing Database Service", MessageBoxButtons.OK, MessageBoxIcon.Stop);
        return;
      } 
      else if (!DbService.getDbService().Start())
      {
        MessageBox.Show("Could not start the database service 'AcumenDb' - have you correctly installed this application?",
          "Could not start Database Service", MessageBoxButtons.OK, MessageBoxIcon.Stop);
      }

      Application.Run(new frmMain());      
		}

    private void mniExit_Click(object sender, System.EventArgs e)
    {
      this.Dispose();
    }

    private void trvNav_AfterSelect(object sender, System.Windows.Forms.TreeViewEventArgs e)
    {
      if (e.Node is CompanyNode) 
      {
        tbcResults.SelectedIndex = 5;
        //MessageBox.Show("CompanyNode " + e.ToString());
      } 
      else if (e.Node is ContractNode) 
      {
        //MessageBox.Show("AssetNode " + e.ToString());
        tbcResults.SelectedIndex = 0;
      }
      else if (e.Node is AssetNode) 
      {
        //MessageBox.Show("AssetNode " + e.ToString());

        tbcResults.SelectedIndex = 1;
        this.lblAssetName.Text = ((AssetNode)e.Node).Name;
        FileInfo fi = new FileInfo(Application.StartupPath + "\\img\\asset_thumb\\bp" + ((AssetNode)e.Node).Code.ToLower() + ".gif");
        if (fi.Exists) 
        {          
          this.btnAsset1.Image = new Bitmap(fi.FullName);
        }
      }
      else if (e.Node is SchematicNode) 
      {
        //MessageBox.Show("SchematicNode " + e.ToString());

        tbcResults.SelectedIndex = 2;
        this._currentSchematic = (SchematicNode) e.Node;
        this.lblSchemSub.Text = this._currentSchematic.Name;
    
        int i=0;
        for (; i<this._currentSchematic.Nodes.Count; i++) 
        {
          switch (i) 
          {
            case 0:
              btnPump1.Text = ((TagNode)this._currentSchematic.Nodes[i]).Code;
              btnPump1.Visible = true;
              break;
            case 1:
              btnPump2.Text = ((TagNode)this._currentSchematic.Nodes[i]).Code;
              btnPump2.Visible = true;
              break;
            case 2:
              btnPump3.Text = ((TagNode)this._currentSchematic.Nodes[i]).Code;
              btnPump3.Visible = true;
              break;
            case 3:
              btnPump4.Text = ((TagNode)this._currentSchematic.Nodes[i]).Code;
              btnPump4.Visible = true;
              break;
          }
        }
        for (; i<4; i++) 
        {
          switch (i) 
          {
            case 0:
              btnPump1.Visible = false;
              break;
            case 1:
              btnPump2.Visible = false;
              break;
            case 2:
              btnPump3.Visible = false;
              break;
            case 3:
              btnPump4.Visible = false;
              break;
          }
        }
      }
      else if (e.Node is TagNode) 
      {
        tbcResults.SelectedIndex = 3;
        this._currentTag = (TagNode) e.Node;
        this.lblTagSub.Text = ((TagNode)e.Node).Text;

        this.pbxTraffic.Image = imlTraffic.Images[this._currentTag.Traffic];

        //this._currentComponent = null;
      }
      else if ((e.Node is ComponentNode))
      {
        //MessageBox.Show("ComponentNode " + e.Node.ToString());

        //if ((this._currentComponent != null) && (e.Node.Equals(_currentComponent)))
        //{
        //  return;
        //}

        tbcResults.SelectedIndex = 4;
        this._currentComponent = (ComponentNode) e.Node;        
        lblGraphTitles.Text = this._currentComponent.Name + " (" + this._currentComponent.Code + ")";

        if (_dm.Drawing) 
        {
          this.tmrVibr.Stop();
        }
        while (_dm.Drawing);

        _dm.getVibration(this._currentComponent).ResetGraph(this.pegVibr, this.tabComp);
        _dm.getSpeed(this._currentComponent).ResetGraph(this.pegSped, this.tabComp);
        _dm.getTemperature(this._currentComponent).ResetGraph(this.pegTemp, this.tabComp);

        this.tmrVibr.Start();
        this.tmrAlert.Start();
      }
    }

    private void tmrVibr_Tick(object sender, System.EventArgs e)
    {
      _dm.Drawing = true;

      this.tmrVibr.Stop();

      if (this._currentComponent != null) 
      {
        _dm.getTemperature(this._currentComponent).UpdateGraph(this.pegTemp, this.sbpMessage);
        _dm.getVibration(this._currentComponent).UpdateGraph(this.pegVibr, this.sbpMessage);
        _dm.getSpeed(this._currentComponent).UpdateGraph(this.pegSped, this.sbpMessage);
        
        if (this._currentComponent.ComponentType == ComponentTypes.Wireless) 
        {
          // Keep looking for more data
          this.tmrVibr.Start();
        }
      } 

      _dm.Drawing = false;
    }

    private void tlbMain_ButtonClick(object sender, System.Windows.Forms.ToolBarButtonClickEventArgs e)
    {
    }

    private void btnSeal1_Click(object sender, System.EventArgs e)
    {
      IEnumerator seals = this._currentTag.Nodes.GetEnumerator();
      while (seals.MoveNext()) 
      {
        if (seals.Current is ComponentNode) 
        {
          ComponentNode c = (ComponentNode) seals.Current;
          if (c.PhysicalEnd == 1) 
          {
            trvNav.SelectedNode = c;
            trvNav.Select();
          }
        }
      }    
    }

    private void btnSeal2_Click(object sender, System.EventArgs e)
    {
      IEnumerator seals = this._currentTag.Nodes.GetEnumerator();
      while (seals.MoveNext()) 
      {
        if (seals.Current is ComponentNode)
        {
          ComponentNode c = (ComponentNode) seals.Current;
          if (c.PhysicalEnd == 2) 
          {
            trvNav.SelectedNode = c;
            trvNav.Select();
          }
        }
      }    
    }

    private void SelectTagFromSchematic(int i) 
    {
      if (this._currentSchematic == null) return;
      if (this._currentSchematic.Nodes.Count < i) return;      

      trvNav.SelectedNode = this._currentSchematic.Nodes[i-1];
      trvNav.Select();
    }

    private void btnPump1_Click(object sender, System.EventArgs e)
    {
      SelectTagFromSchematic(1);
    }

    private void btnPump2_Click(object sender, System.EventArgs e)
    {
      SelectTagFromSchematic(2);
    }

    private void btnPump3_Click(object sender, System.EventArgs e)
    {
      SelectTagFromSchematic(3);
    }

    private void btnPump4_Click(object sender, System.EventArgs e)
    {
      SelectTagFromSchematic(4);
    }

    private void btnC02_Click(object sender, System.EventArgs e)
    {
      trvNav.SelectedNode = trvNav.Nodes[0].Nodes[0];
      trvNav.Select();
    }

    private void lklAssetBruce_LinkClicked(object sender, System.Windows.Forms.LinkLabelLinkClickedEventArgs e)
    {
      trvNav.SelectedNode = trvNav.Nodes[0].Nodes[0].Nodes[0];
      trvNav.Select();
    }

    private void lklAssetHarding_LinkClicked(object sender, System.Windows.Forms.LinkLabelLinkClickedEventArgs e)
    {
      trvNav.SelectedNode = trvNav.Nodes[0].Nodes[0].Nodes[1];
      trvNav.Select();    
    }

    private void lklAssetMag_LinkClicked(object sender, System.Windows.Forms.LinkLabelLinkClickedEventArgs e)
    {
      trvNav.SelectedNode = trvNav.Nodes[0].Nodes[0].Nodes[2];
      trvNav.Select();    
    }

    private void lklAssetMiller_LinkClicked(object sender, System.Windows.Forms.LinkLabelLinkClickedEventArgs e)
    {
      trvNav.SelectedNode = trvNav.Nodes[0].Nodes[0].Nodes[3];
      trvNav.Select();    
    }

    private void btnAssetMiller_Click(object sender, System.EventArgs e)
    {
      trvNav.SelectedNode = trvNav.Nodes[0].Nodes[0].Nodes[3];
      trvNav.Select();
    }

    private void btnMillerMOL_Click(object sender, System.EventArgs e)
    {
      trvNav.SelectedNode = trvNav.Nodes[0].Nodes[0].Nodes[3].Nodes[0];
      trvNav.Select();            
    }
 
    private void tmrFlash_Tick(object sender, System.EventArgs e)
    {
      tmrFlash.Interval = 400;
      if (this.btnMillerMOL.BackColor.Equals(this.btnOrange.BackColor))
      {
        this.btnC02.BackColor = this.btnAssetMiller.BackColor = this.btnMillerMOL.BackColor = this.btnPump1.BackColor = this.btnSeal1.BackColor = this.btnYellow.BackColor;
      }
      else 
      {
        this.btnC02.BackColor = this.btnAssetMiller.BackColor = this.btnMillerMOL.BackColor = this.btnPump1.BackColor = this.btnSeal1.BackColor = this.btnOrange.BackColor;
      }
    }

    private void tmrAlert_Tick(object sender, System.EventArgs e)
    {  
      tmrAlert.Stop();
      if (warning) 
      {        
        MessageBox.Show("Warning, cavitation detected.\n\n" + 
          "Please review process conditions to\nprevent severe impeller damage.", "Warning!", 
          MessageBoxButtons.OK, MessageBoxIcon.Exclamation);
        warning = false;
      } 
      else 
      {
        MessageBox.Show("Danger, operating below acceptable speed for the \nseal face geometry. \n\n" +
          "Face contact inevitable - shutdown immediately.", "Danger!", 
          MessageBoxButtons.OK, MessageBoxIcon.Error);
        warning = true;
      }
      tmrAlert.Start();
    }
  }
}
