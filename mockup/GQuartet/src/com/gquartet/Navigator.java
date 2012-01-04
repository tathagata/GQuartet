package com.gquartet;

import java.util.Date;
import java.util.Map;

import com.google.appengine.api.datastore.DatastoreService;
import com.google.appengine.api.datastore.DatastoreServiceFactory;
import com.google.appengine.api.datastore.*;
import com.gquartet.data.*;


import java.io.IOException;
import javax.servlet.http.*;
import java.util.logging.Logger;
import java.util.*;


@SuppressWarnings("serial")
public class Navigator extends HttpServlet {

  static final Logger log = Logger.getLogger(TestGQDataStore.class.getName()); 

	public void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws IOException {

      
      log.warning(req.getParameter("action"));
      String action = req.getParameter("action");

      StringBuilder data = new StringBuilder();
    
      if ( "moveSlideForward".equals(action) || "moveSlideBackward".equals(action) )
      {

        String talkKey = req.getParameter("talkKey");

        log.warning("Moving Slide forward");
        Talk talk = GQDataStore.GetTalkByKey(talkKey);
        long slideNo = talk.activeSlideNo; 
        
        if ( "moveSlideForward".equals(action) )
          slideNo = slideNo +1;  //TODO: What happens to invalid slideNo
        else
        {
          slideNo = slideNo -1;
          if ( slideNo <= 0 ) slideNo = 1;
        }

        GQDataStore.UpdateActiveSlideNo(talkKey, slideNo);
        log.warning("Update complete :  Talk Name=" + talk.talkName + " active slide no = " + slideNo );

        data.append("SlideNo:"+slideNo);
      
      }

    resp.setContentType("text/plain");
    resp.getWriter().println(data.toString());

  }


	public void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws IOException {
   
    
    resp.setContentType("text/plain");
		resp.getWriter().println("Hello, world");

	}
}



/*  Reference 
if ( "getTalks".equals(action) )
      {

        Map<String, Talk>  list = GQDataStore.GetTalks();
        for ( Map.Entry<String,Talk> entry : list.entrySet() )
        {
          Talk t = entry.getValue();
          log.warning("Talk Name :"  + t.talkName );
          data.append(t.talkName).append(" ").append(t.resourceId).append(" ").append(t.dateTime).append("\n");
        }
      }

     if ( "getTalkByTalkName".equals(action) )
     {
          Talk t  = GQDataStore.GetTalkByTalkName((String)req.getParameter("talkname"));
          if ( t != null )
            data.append(t.talkName).append(" ").append(t.resourceId).append(" ").append(t.dateTime).append("\n"); 
          else
            data.append("no talk entity with the name " + (String)req.getParameter("talkname"));
     }


      if ( "getTalkByKey".equals(action) )
     {
          Talk t  = GQDataStore.GetTalkByKey((String)req.getParameter("key"));
          if ( t != null )
            data.append(t.talkName).append(" ").append(t.resourceId).append(" ").append(t.dateTime).append("\n"); 
          else
            data.append("no talk entity with the name " + (String)req.getParameter("talkname"));
     }

 if ( "getTalkContent".equals(action) )
     {
       List<Entity> results = GQDataStore.GetTalkContent(req.getParameter("parentKey"));

       for ( Entity e : results )
       {
         data.append(e.getKey().toString()).append(" ").append(e.getKey().getId()).append("\n");

         if ( e.getKind().equals("Slide") )
           data.append( Slide.GetSlide(e).toString());
       }
     }


*/



