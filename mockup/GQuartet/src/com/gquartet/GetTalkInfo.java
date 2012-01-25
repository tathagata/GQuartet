package com.gquartet;

import java.util.Date;
import java.util.Map;

import com.google.appengine.api.datastore.DatastoreService;
import com.google.appengine.api.datastore.DatastoreServiceFactory;
import com.google.appengine.api.datastore.*;
import com.gquartet.data.*;
import com.google.gdata.data.Link;

import java.io.IOException;
import javax.servlet.http.*;
import javax.servlet.*;
import java.util.logging.Logger;
import java.util.*;
import com.google.gdata.data.docs.DocumentEntry;
import com.google.gdata.data.docs.DocumentListEntry;
import com.google.gdata.data.docs.DocumentListFeed;






@SuppressWarnings("serial")
public class GetTalkInfo extends HttpServlet {

  static final Logger log = Logger.getLogger("GetTalkInfo") ;


	public void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws IOException {


      String action = req.getParameter("action");

      resp.setContentType("application/text");

      Long slideNo = new Long(1);

      try
      {

      if ( "getCurrentSlide".equals(action) )
      {
        //String talkKey = req.getParameter("talkKey");

        //Talk talk = GQDataStore.GetTalkByKey(talkKey); 
        //long slideNo = 1;
        //if ( talk != null ) 
        //  slideNo = talk.activeSlideNo;
        //

        ServletContext application = getServletConfig().getServletContext();
        //application.setAttribute("ACTIVE_SLIDE_NO", 1);

        slideNo = (Long)application.getAttribute("ACTIVE_SLIDE_NO");
        if ( slideNo == null )
		slideNo=new Long(1);
        //slideNo++;

        log.warning("latest slide no " + slideNo);

      }
      }
      catch ( Exception ex)
      {
          log.warning("Exception during getTalkInfo");
      }


      resp.getWriter().println(slideNo.toString());

      
      //resp.getWriter().println("Hello there");


  }


}


