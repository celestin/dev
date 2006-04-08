/**
 * Copyright (c) 1999, 2004 Power Software Ltd.
 *
 * $Log: /viz/com/psoft/apps/vizualizeit/VApplication.java $
 * 
 * 1     18/02/04 0:40 Craig
 *
 * Who  When       Why
 * CAM  17-Feb-04  File added.
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */
package com.psoft.apps.vizualizeit;

import java.awt.*;
import java.awt.event.*;
import java.io.*;
import java.net.*;
import java.util.*;
import javax.help.*;
import javax.swing.*;

import com.psoft.framework.app.*;
import com.psoft.framework.app.Info;
import com.psoft.framework.app.progress.*;
import com.psoft.framework.project.*;
import com.psoft.framework.project.handler.ProjectHandler;
import com.psoft.framework.swing.*;
import com.psoft.framework.util.*;

import com.psoft.apps.vizualizeit.db.OurSQL;
import com.psoft.apps.vizualizeit.project.*;
import com.psoft.apps.vizualizeit.project.handler.VProjectHandler;
import com.psoft.apps.vizualizeit.swing.VApplicationMenuBar;
import com.psoft.apps.vizualizeit.swing.VApplicationToolBar;
import com.psoft.apps.vizualizeit.swing.VApplicationWindow;

/**
 * Main VizualizeIt Application.
 * @author  Stephen Webster
 * @version $Revision: 1 $
 */
public class VApplication extends Application {

  static VInfo theVInfo;

  RootVProject theRootVProject;
  VApplicationWindow theVApplicationWindow;

  public VApplication(RootVProject newRootVProject) {
    super(null);

    theRootVProject = newRootVProject;
  }

  public void setApplicationWindow(ApplicationWindow appWindow) {
    super.setApplicationWindow(appWindow);
    if (appWindow instanceof VApplicationWindow) {
      theVApplicationWindow = (VApplicationWindow) appWindow;
    }
  }


  public void cancelOperation() {
    /*if (theCurrentOperation.getCurrentOperation()==APPLYMETRICS_OPERATION) {
      Project proj = getCurrentProject();
        if (proj instanceof KrakatauProject) {
          ((KrakatauProject)proj).cancelApply();
        }
    }*/
  }

  public void exitApplication() {

  /*    Vector projects = rootProject.getSubProjects();

    for (int i=0; i<projects.size(); i++) {

      Project curr = (Project) projects.elementAt(i);

      if (curr.hasChanged()) {
        int retval = JOptionPane.showConfirmDialog(getApplicationWindow(),"Save changes to " + curr.toString() + ".","Project has changed", JOptionPane.YES_NO_CANCEL_OPTION);

        switch (retval) {
          case JOptionPane.YES_OPTION: {
            saveProject(curr);
            break;
          }
          case JOptionPane.CANCEL_OPTION: {
            return;
          }
        }

      }

    }

    try {
      FileChooserFactory.writeToFile(DIALOG_DAT_FILE);
    } catch (Exception e) {
      e.printStackTrace();
    }
  */
    System.err.println("Controlled exit");
    System.exit(0);
  }

  public void closeApplication() {

  /*    // Close connection to database
    OurSQL.close();*/

    exitApplication();
  }

  public void showAbout() {
    AboutBox aboutBox = new AboutBox(theVApplicationWindow,
      "images/general/VizAbout.gif",
      "Copyright (c) Power Software 2001.");
    aboutBox.setVisible(true);
  }

  public void showHelp() {
    HelpSet hs;

    try {
      URL hsURL = HelpSet.findHelpSet(null, "Vizualize_It_Help.hs");
      hs = new HelpSet(null, hsURL);
    } catch (Exception ee) {
      ee.printStackTrace();
      return;
    }

    Help help = new Help(hs);
    help.setVisible(true);
  }

  public static void main( String args[] ) {

    String img = "/images/splash/viz.gif";
    SplashWindow splash = new SplashWindow(img);
    splash.setVisible(true);

    splash.setMessageAt(new Dimension(55,8));
    splash.setMessage("Initialising...");

    // Open connection to database
    OurSQL.open();

    splash.setMessage("Configuring database...");

    theVInfo = new VInfo();

    if (VInfo.getInfo().getPlatform() == VInfo.WINDOWS) {
      try {
        UIManager.setLookAndFeel("com.sun.java.swing.plaf.windows.WindowsLookAndFeel");
      } catch (Exception e) {
      e.printStackTrace();
      }
    }

    RootVProject rootProject = new RootVProject();
    VProjectHandler projHandler = new VProjectHandler(rootProject);

    VApplication vizualizeit = new VApplication(rootProject);

    splash.setMessage("Localizing GUI...");

    VApplicationWindow vWindow = new VApplicationWindow(projHandler,vizualizeit,rootProject);

    vWindow.addDefaultTreeListener();
    vWindow.setSize(new Dimension(600,480));

    projHandler.addProjectListener(vWindow);
    theVInfo.theDefaultProgressHandler = vWindow;
    theVInfo.theDefaultStatusHandler = vWindow;

    vizualizeit.setApplicationWindow(vWindow);
    vizualizeit.setProjectHandler(projHandler);

    // Hide splash screen
    splash.setVisible(false);
    splash = null;

    vizualizeit.startApplication();

    // Load demo project
  //    projHandler.openProject("c:\\bin\\v.prj");
  //    projHandler.parseCurrentProject();
  }
}