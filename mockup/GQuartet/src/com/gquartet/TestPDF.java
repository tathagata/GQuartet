package com.gquartet;

import java.io.IOException;
import javax.servlet.http.*;
import javax.servlet.*;

import java.util.logging.Logger;


import com.google.gdata.client.GoogleAuthTokenFactory.UserToken;
import com.google.gdata.data.Link;
import com.google.gdata.client.GoogleService;
import com.google.gdata.client.Query;
import com.google.gdata.client.docs.DocsService;
import com.google.gdata.data.MediaContent;
import com.google.gdata.data.PlainTextConstruct;
import com.google.gdata.data.acl.AclEntry;
import com.google.gdata.data.acl.AclFeed;
import com.google.gdata.data.acl.AclRole;
import com.google.gdata.data.acl.AclScope;
import com.google.gdata.data.docs.DocumentEntry;
import com.google.gdata.data.docs.DocumentListEntry;
import com.google.gdata.data.docs.DocumentListFeed;
import com.google.gdata.data.docs.FolderEntry;
import com.google.gdata.data.docs.PresentationEntry;
import com.google.gdata.data.docs.RevisionFeed;
import com.google.gdata.data.docs.SpreadsheetEntry;
import com.google.gdata.data.media.MediaSource;
import com.google.gdata.util.AuthenticationException;
import com.google.gdata.util.ServiceException;


import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.net.MalformedURLException;
import java.net.URL;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import java.util.Set;





@SuppressWarnings("serial")
public class TestPDF extends HttpServlet {

  public static DocumentList documentList = null;

  static final Logger log = Logger.getLogger(TestPDF.class.getName()); 

  public TestPDF() 
  {

  log.warning("In TestPDF");
  try
  {
    documentList = new DocumentList(
                  "JavaGDataClientSampleAppV3.0" , "docs.google.com");
    documentList.login("gquartetbeta@gmail.com", "Google!234");
  }
  catch(Exception ex)
  {

    log.warning("An exception occured in TestPDF constructor");
    log.warning( ex.getMessage());
    //TODO: handle this;
  }
  }


	public void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws IOException {

      //listDocuments(req, resp);;
    //
    try
    {

     log.warning("test logging");

     resp.setContentType("application/pdf");
     //resp.getWriter().println("Over here");

     //InputStream inStream = null;

      //ResourceId=presentation:0AYyutri7KO7bZDlycjRyY18wZGo5cWd6OHA
      //
      if ( documentList == null ) log.warning ( "Document object not initialized");

     InputStream inStream =documentList.getPresentation("presentation:0AYyutri7KO7bZDlycjRyY18wZGo5cWd6OHA", "pdf");

     log.warning("test logging 111");

     //resp.getWriter().println("Over here");

     //ServletOutputStream outStream = resp.getOutputStream();  
     try
     {
      int c;

      while ((c = inStream.read()) != -1) {
        //outStream.write(c);
        
        resp.getWriter().write(c);
        //log.warning("ere");;

        //System.out.println(c);
      }
     }
     finally {
     //if (inStream != null) {
      //  inStream.close();
      //}
      //if (outStream != null) {
        //outStream.flush();
        //outStream.close();
      //}
    }
    }
    catch ( Exception ex )
     {
    		resp.setContentType("text/plain");

	    	resp.getWriter().println("Exception occurred  "  + ex.getMessage()) ; 
     }

      //String resourceId = documentEntry.getResourceId();  // resourceId is of the form "presentation:dfrkj84g_9128gtvh8nt"
      //downloadPresentation(resourceId, "/path/to/export/to/preso.pdf", "pdf");


	}



  public void listDocuments(HttpServletRequest req, HttpServletResponse resp) throws IOException
  {
      try
      {


      DocumentListFeed feed =  documentList.getDocsListFeed("all");

      StringBuffer s = new StringBuffer();
      if ( feed !=  null )
      {
          s.append("List of Documents");

          for ( DocumentListEntry entry: feed.getEntries())
          {
              s.append(printDocumentEntry(entry));
          }

  		resp.setContentType("text/plain");
	  	resp.getWriter().println( s.toString() );

      }
      else
      {
    		resp.setContentType("text/plain");
	    	resp.getWriter().println("Feed is NULL");
      }
      }
      catch ( Exception ex)
      {

    		resp.setContentType("text/plain");
	    	resp.getWriter().println( ex.getMessage()) ; 

      }


  }


 public String printDocumentEntry(DocumentListEntry doc) {
       StringBuffer output = new StringBuffer();

           output.append(" -- " + doc.getTitle().getPlainText() + " ");
               if (!doc.getParentLinks().isEmpty()) {
                       for (Link link : doc.getParentLinks()) {
                                 output.append("[" + link.getTitle() + "] ");
                                       }
                           }
                   output.append(", ResourceId=");
                       output.append(doc.getResourceId());

                       return output.toString();
 }


    public void downloadPresentation(String resourceId, String format)
        throws IOException, MalformedURLException, ServiceException {
          //getFile(resourceId, format);
        }

   /* 
    public void getFile(String resourceId, String format)
        throws IOException, MalformedURLException, ServiceException {

      String docType = resourceId.substring(0, resourceId.lastIndexOf(':'));
      String docId = resourceId.substring(resourceId.lastIndexOf(':') + 1);

      URL exportUrl = new URL("https://docs.google.com/feeds/download/" + docType +
          "s/Export?docID=" + docId + "&exportFormat=" + format);

      System.out.println("Exporting document from: " + exportUrl);

      MediaContent mc = new MediaContent();
      mc.setUri(exportUrl.toString());
      MediaSource ms = client.getMedia(mc);

      InputStream inStream = null;
      FileOutputStream outStream = null;

      try {
        inStream = ms.getInputStream();
        outStream = new FileOutputStream(filepath);

        int c;
        while ((c = inStream.read()) != -1) {
          outStream.write(c);
        }
      } finally {
        if (inStream != null) {
          inStream.close();
        }
        if (outStream != null) {
          outStream.flush();
          outStream.close();
        }
      }
    }

    */


/*
    public void downloadFile(String resourceId, String filepath, String format)
        throws IOException, MalformedURLException, ServiceException {

      String docType = resourceId.substring(0, resourceId.lastIndexOf(':'));
      String docId = resourceId.substring(resourceId.lastIndexOf(':') + 1);

      URL exportUrl = new URL("https://docs.google.com/feeds/download/" + docType +
          "s/Export?docID=" + docId + "&exportFormat=" + format);

      System.out.println("Exporting document from: " + exportUrl);

      MediaContent mc = new MediaContent();
      mc.setUri(exportUrl.toString());
      MediaSource ms = client.getMedia(mc);

      InputStream inStream = null;
      FileOutputStream outStream = null;

      try {
        inStream = ms.getInputStream();
        outStream = new FileOutputStream(filepath);

        int c;
        while ((c = inStream.read()) != -1) {
          outStream.write(c);
        }
      } finally {
        if (inStream != null) {
          inStream.close();
        }
        if (outStream != null) {
          outStream.flush();
          outStream.close();
        }
      }

    }

    */

}
