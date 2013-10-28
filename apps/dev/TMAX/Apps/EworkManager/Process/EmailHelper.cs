/* * * * * * * * * * * * * * * * * * * * * * * *
 * TMAX Ework Manager
 * Copyright (c) 2013 Front Burner Ltd
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  28-Oct-2013  11181 : Created.
 * * * * * * * * * * * * * * * * * * * * * * * */

using System;
//using System.Collections.Generic;
//using System.Text;
using System.Net.Mail;

namespace FrontBurner.Tmax.Apps.EworkManager.Process
{
  public class EmailHelper
  {
    private SmtpClient _smtp;
    private MailMessage _mail;

    public EmailHelper()
    {
      Properties.Settings s = Properties.Settings.Default;

      _smtp = new SmtpClient();
      _smtp.Host = s.EmailServer;
      _smtp.Port = 25;
      _smtp.EnableSsl = false;

      _smtp.UseDefaultCredentials = false;
      _smtp.Credentials = new System.Net.NetworkCredential(s.EmailUsername, s.EmailPassword);
    }

    protected string EworkUrl(long efolderId)
    {
      return "http://ework.euro.tlm.com/MetastormSSO/eexternalform.asp?service=Metastorm%20BPM%20Server&redirect=" +
        "http://ework.euro.tlm.com/metastorm/efolder.aspx?folderid=" +
        efolderId.ToString("D31") +
        "%2526Service=Metastorm%20BPM%20Server%2526Client=External%2526ResizeForm=FALSE";
    }

    public void PrepareAssignments(string emailTo, string firstName)
    {
      _mail = new MailMessage();
      _mail.From = new MailAddress("maxadmin@talisman-sinopec.com", "Maximo Admin");
      _mail.To.Add(new MailAddress(emailTo));
      _mail.Subject = "Ework Change Request Assignments";

      _mail.IsBodyHtml = true;
      _mail.Body = "<html><font family=\"Arial\"><p>Hello <b>" + firstName + "</b>,</p><p>The following ework Change Requests have been assigned to you:</p><table border=\"1\"><tr>" +
        "<th>Request</th>" +
        "<th>Priority</th>" +
        "<th>Category</th>" +
        "<th>Site</th>" +
        "<th>Description</th>" +
        "<th>Comments</th>" +
        "<th>Effort</th>" +
        "</tr>";
    }

    public void AddAssignment(long efolderId, string folderName, string wmsPriority, string wmsCategory,
      string siteId, string description, string wmsComments, double wmsEffort)
    {
      _mail.Body += "<tr><td><a href=\"" + EworkUrl(efolderId) + "\">" + folderName + "</a></td>" +
        "<td>" + wmsPriority + "</td>" +
        "<td>" + wmsCategory + "</td>" +
        "<td>" + siteId + "</td>" +
        "<td>" + description + "</td>" +
        "<td>" + wmsComments + "</td>" +
        "<td>" + wmsEffort + "</td>" +
        "</tr>";
    }

    public void SendAssignments()
    {
      try
      {
        _mail.Body += "</table></font></html>";
        _smtp.Send(_mail);
      }
      catch (Exception ex)
      {
      }
    }
  }
}
