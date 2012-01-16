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
import java.util.logging.Logger;
import java.util.*;
import com.google.gdata.data.docs.DocumentEntry;
import com.google.gdata.data.docs.DocumentListEntry;
import com.google.gdata.data.docs.DocumentListFeed;






@SuppressWarnings("serial")
public class GetTalkInfo extends HttpServlet {




	public void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws IOException {


      String action = req.getParameter("action");

      resp.setContentType("application/text");

      if ( "getCurrentSlide".equals(action) )
      {
        String talkKey = req.getParameter("talkKey");

        Talk talk = GQDataStore.GetTalkByKey(talkKey); 
        long slideNo = 1;
        if ( talk != null ) 
          slideNo = talk.activeSlideNo;

        resp.getWriter().println(slideNo);
      }


  }


}

