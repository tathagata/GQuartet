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
public class UpdateUtilServlet extends HttpServlet {

  static final Logger log = Logger.getLogger(UpdateUtilServlet.class.getName()); 

	public void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws IOException {

     log.warning("Action called for was " + req.getParameter("action"));
     String action = req.getParameter("action");



     StringBuilder data = new StringBuilder();

      try
      {
      
    
    if ( "addQuestion".equals(action) )
    {

      log.warning("Adding a new question");


       Slide slide = GQDataStore.GetSlideBySlideNo((String)req.getParameter("parentKey"), Long.parseLong(req.getParameter("slideNo")));

       log.warning("Slide key for adding new question " + slide.key + ", " + slide.SlideNo ); 

       String key  = GQDataStore.AddQuestion(slide.key, (String)req.getParameter("questionText"), Integer.parseInt(req.getParameter("rating")));

       Entity questionEntity = GQDataStore.GetEntityByKey(key);
       Question q = Question.GetQuestion(questionEntity);
       data.append(q.key).append("|").append(q.questionText.replace("|"," ")).append("|").append(q.rating);
    }
  
  if ( "addComment".equals(action) )
       {
         String key  = GQDataStore.AddComment((String)req.getParameter("parentKey"), (String)req.getParameter("commentText"), Integer.parseInt(req.getParameter("rating")));

         Entity commentEntity = GQDataStore.GetEntityByKey(key);
         Comment c = Comment.GetComment(commentEntity);
         data.append(c.key).append("|").append(c.commentText.replace("|"," ")).append("|").append(c.rating);
       }

     if ( "updateQuestionRating".equals(action) )
     {
        long rating = Long.parseLong(req.getParameter("rating"));
        String key = req.getParameter("questionKey");
        GQDataStore.UpdateQuestionRating(key, rating);

        data.append("Question has been updated with new rating");
     }

     if ( "updateFeedRating".equals(action) )
     {
        long rating = Long.parseLong(req.getParameter("rating"));
        String key = req.getParameter("feedKey");
        GQDataStore.UpdateQuestionRating(key, rating);

        data.append("Feed has been updated with new rating");
     }
 
 
      if ( "updateCommentRating".equals(action) )
     {
        long rating = Long.parseLong(req.getParameter("rating"));
        String key = req.getParameter("commentKey");
        GQDataStore.UpdateCommentRating(key, rating);

        data.append("Question has been updated with new rating");
     }

     if ( "updateLikes".equals(action) )
     {
        long count = Long.parseLong(req.getParameter("count"));
        String key = req.getParameter("talkKey");
        long slideNo = Long.parseLong(req.getParameter("SlideNo"));
        GQDataStore.UpdateLikes(key, slideNo, count);

        data.append("Slide has been updated with new like value");
     }


     if ( "updateDislikes".equals(action) )
     {
        long count = Long.parseLong(req.getParameter("count"));
        String key = req.getParameter("talkKey");
        long slideNo = Long.parseLong(req.getParameter("SlideNo"));
        GQDataStore.UpdateDislikes(key, slideNo, count);
        data.append("Slide has been updated with new like value");
     }

   
     }
     catch( Exception e)
     {
      log.warning("Exception during post : " + e.getMessage());
     }

    resp.setContentType("text/plain");
    resp.getWriter().println("Hello there");
    resp.getWriter().println(data.toString());

  }
 


	public void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws IOException {
   
    
    resp.setContentType("text/plain");
		resp.getWriter().println("Hello, world");

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


