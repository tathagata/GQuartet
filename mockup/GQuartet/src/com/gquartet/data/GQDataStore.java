package com.gquartet.data;

import java.util.Date;
import com.google.appengine.api.datastore.DatastoreService;
import com.google.appengine.api.datastore.DatastoreServiceFactory;
import com.google.appengine.api.datastore.Entity;
import com.google.appengine.api.datastore.*;

import java.util.logging.Logger;
import java.util.*;


class GQDataConstants
{
  /*Entity Names*/
  public static String TALK ="Talk";
  public static String SLIDE = "Slide";
  public static String QUESTION ="Question";
  public static String COMMENTS = "Comments"; 

}


public class GQDataStore {

  static final Logger log = Logger.getLogger(GQDataStore.class.getName()); 
  public static DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();

  public static void main(String args[])
  {
    TestNewEmployee();
  }

  public static String AddNewTalk(String resourceId, Date talkDate, String talkName )
  {
     Entity talk = Talk.GetEntity(resourceId, talkDate, talkName, 1, new Date());
     datastore.put(talk);

     for ( int i=1; i <= 25 ; i++ )
     {
       AddSlide ( KeyFactory.keyToString(talk.getKey()), i);
     }

     return KeyFactory.keyToString(talk.getKey());

  }


  public static Map<String, Talk> GetTalks()
  {
     Map<String, Talk> talks = new HashMap<String, Talk>();
     Query query = new Query("Talk");
     for (Entity entity : datastore.prepare(query).asIterable()) 
     {
       Talk t = Talk.GetTalk(entity);
       talks.put(t.talkName, t);
     }
     return talks;
  }

  public static Talk GetTalkByKey(String key)
  {
    try
    {
      Key k = KeyFactory.stringToKey(key);
      Entity entity =  datastore.get(k);
      return Talk.GetTalk(entity);
    }
    catch ( Exception ex)
    {
      log.warning(ex.getMessage());
    }

    return null;
  }

  public static Entity GetEntityByKey(String key)
  {
    try
    {
      Key k = KeyFactory.stringToKey(key);
      return datastore.get(k);
    }
    catch ( Exception ex)
    {
      log.warning("The entity for the requested key " + key + " does not exist");
      log.warning(ex.getMessage());
    }

    return null;
  }

  public static Entity GetEntityByKey(Key k)
  {
    try
    {
      return datastore.get(k);
    }
    catch ( Exception ex)
    {
      log.warning("The entity for the requested key " + k.toString() + " does not exist");
      log.warning(ex.getMessage());
    }

    return null;
  }




  public static Talk GetTalkByTalkName(String talkName)
  {
     Map<String, Talk> talks = new HashMap<String, Talk>();
     Query query = new Query("Talk");
     query.addFilter("Name", Query.FilterOperator.EQUAL, talkName);
	log.warning(talkName +"will be compared now");
     for (Entity entity : datastore.prepare(query).asIterable()) 
     {
       if ( talkName.equals(entity.getProperty("Name") ))
           {
             log.warning("Print for each entry with same name....");
             return Talk.GetTalk(entity);
           }
     }

	log.warning(talkName +"comparison is over");
     return null;
  }

  public static List<SearchResult> SearchText(String searchText)
  {
     List<SearchResult> results = new ArrayList<SearchResult>();
     
     results.addAll(GQDataStore.SearchText(searchText,"Question", "Text"));
     results.addAll(GQDataStore.SearchText(searchText,"Comment", "Text"));
     results.addAll(GQDataStore.SearchText(searchText,"Feed", "Text"));

    return results;

  }

  public static List<SearchResult> SearchText(String searchText,String entityName, String propertyName)
  {
    
    List<SearchResult> results = new ArrayList<SearchResult>();
    
    Query query = new Query(entityName);
    query.addFilter(propertyName, Query.FilterOperator.GREATER_THAN_OR_EQUAL, searchText);
    query.addFilter(propertyName, Query.FilterOperator.LESS_THAN, searchText + "\ufffd" ) ;

     List<Entity> list = datastore.prepare(query).asList(FetchOptions.Builder.withDefaults());
     log.warning("Overe here , the size was list = " + list.size());
     for (Entity entity : list) 
     {
       if ( entity.getKind().equals("Question") )
           {
             Question question = Question.GetQuestion(entity);
             Slide slide = Slide.GetSlide( GetEntityByKey(entity.getParent()) );
             Talk talk =  Talk.GetTalk(GetEntityByKey(entity.getParent().getParent()));
             results.add(new SearchResult(talk.key, talk.talkName, slide.SlideNo, question.questionText));
           }
        else if ( entity.getKind().equals("Comment") )
        {
             Comment comment = Comment.GetComment(entity);
             Slide slide = Slide.GetSlide( GetEntityByKey(entity.getParent().getParent()) );
             Talk talk =  Talk.GetTalk(GetEntityByKey(entity.getParent().getParent().getParent()));
             results.add(new SearchResult(talk.key, talk.talkName, slide.SlideNo, comment.commentText));
        }
       else if ( entity.getKind().equals("Feed") )
       {
             Feed feed = Feed.GetFeed(entity);
             Slide slide = Slide.GetSlide( GetEntityByKey(entity.getParent()) );
             Talk talk =  Talk.GetTalk(GetEntityByKey(entity.getParent().getParent()));
             results.add(new SearchResult(talk.key, talk.talkName, slide.SlideNo, feed.feedText));
       }
    
     }

     return results;

  }

  public static String AddSlide(String talkKey, Integer slideNo)
  {
      Entity entity = Slide.GetEntity(talkKey, slideNo);
      datastore.put(entity);
      return KeyFactory.keyToString(entity.getKey());
  }

  public static String AddQuestion(String slideKey, String text, int rating)
  {
      Entity entity = Question.GetEntity(slideKey, text, rating);
      datastore.put(entity);

      return KeyFactory.keyToString(entity.getKey());
  }

  public static String AddComment(String questionKey, String text, int rating)
  {
      Entity entity = Comment.GetEntity(questionKey, text, rating);
      datastore.put(entity);

      return KeyFactory.keyToString(entity.getKey());
  }

  public static String AddFeed(String slideKey, String text, int rating)
  {
      Entity entity = Feed.GetEntity(slideKey, text, rating);
      datastore.put(entity);

      return KeyFactory.keyToString(entity.getKey());
  }


  public static Slide GetSlideQuestionsAndComments(String talkKey, long slideNo)
  {
    List<Entity> slides = GetChildrenByKind(talkKey, "Slide");
    Slide requiredSlide = null;
    for ( Entity e: slides )
    {
      if ( (Long)e.getProperty("SlideNo") == slideNo )
      {
         String slideKey = KeyFactory.keyToString(e.getKey());
         requiredSlide = Slide.GetSlide(e);

         //Get questions
         List<Entity> questions =  GQDataStore.GetChildrenByKind(slideKey,"Question");

         for ( Entity qe: questions )
         {
             Question q = Question.GetQuestion(qe);
             String qKey = KeyFactory.keyToString(qe.getKey());

             List<Entity> comments =  GQDataStore.GetChildrenByKind(qKey,"Comment");

             for ( Entity ce : comments )
             {
               Comment c = Comment.GetComment(ce);
               q.comments.add(c);
             }

             requiredSlide.questions.add(q);
         }
      }
    }

    return requiredSlide;
  }


  public static List<Entity> GetAllContent(String talkKey)
  {
    Query q = new Query();
    q.setAncestor(KeyFactory.stringToKey(talkKey));
    List<Entity> results = datastore.prepare(q).asList(FetchOptions.Builder.withDefaults());
    return results;
  }

  
  public static List<Entity> GetChildrenByKind(String key, String childName)
  {
    Query q = new Query(childName);
    Key entKey = KeyFactory.stringToKey(key);
    q.setAncestor(entKey);

    q.addFilter(Entity.KEY_RESERVED_PROPERTY, Query.FilterOperator.GREATER_THAN,
    entKey); 

    List<Entity> results = datastore.prepare(q).asList(FetchOptions.Builder.withDefaults());
    return results;

  }

  public static void UpdateActiveSlideNo(String talkKey, long slideNo)
  {
      Entity e =  GetEntityByKey(talkKey);
      Talk.UpdateActiveSlide(e, slideNo);
      datastore.put(e);
  }

  public static Slide GetSlideBySlideNo(String talkKey, long slideNo )
  {
    Slide requiredSlide = null;
    List<Entity> slides = GetChildrenByKind(talkKey, "Slide");
    for ( Entity e: slides )
    {
      if ( (Long)e.getProperty("SlideNo") == slideNo )
      {
         String slideKey = KeyFactory.keyToString(e.getKey());
         requiredSlide = Slide.GetSlide(e);
         break;
      }
    }

    return requiredSlide;


  }

 
  
  public static void UpdateLikes(String talkKey, long slideNo, long value)
  {
    List<Entity> slides = GetChildrenByKind(talkKey, "Slide");
    for ( Entity e: slides )
    {
      if ( (Long)e.getProperty("SlideNo") == slideNo )
      {
         String slideKey = KeyFactory.keyToString(e.getKey());
         Slide requiredSlide = Slide.GetSlide(e);
         if ( requiredSlide.likes + value > 0 )
           e.setProperty("Likes", requiredSlide.likes + value );
         else 
           e.setProperty("Likes",0);
         
         datastore.put(e);
         break;
      }
    }
  }

  public static void UpdateDislikes(String talkKey, long slideNo, long value)
  {
    List<Entity> slides = GetChildrenByKind(talkKey, "Slide");
    for ( Entity e: slides )
    {
      if ( (Long)e.getProperty("SlideNo") == slideNo )
      {
         String slideKey = KeyFactory.keyToString(e.getKey());
         Slide requiredSlide = Slide.GetSlide(e);
         if ( requiredSlide.dislikes + value > 0 )
           e.setProperty("Dislikes", requiredSlide.dislikes + value );
         else 
           e.setProperty("Dislikes",0);
         
         datastore.put(e);
         break;

      }
    }
  }







  public static void UpdateQuestionRating(String questionKey, long rating)
  {
      Entity e =  GetEntityByKey(questionKey);
      Question.UpdateRating(e, rating);
      datastore.put(e);
  }

  public static void UpdateFeedRating(String feedKey, long rating)
  {
      Entity e =  GetEntityByKey(feedKey);
      Feed.UpdateRating(e, rating);
      datastore.put(e);
  }


  public static void UpdateCommentRating(String commentKey, long rating)
  {
      Entity e =  GetEntityByKey(commentKey);
      Comment.UpdateRating(e, rating);
      datastore.put(e);
  }


  /*
  public static Slide GetSlideQuestions(String talkKey, int slideNo)
  {
      List<Entity> results = GetTalkContent(talkKey);
      for ( Entity e : results )
      {
        if ( e.getKind().equals("Slide") )
        {
          if ( (Long)e.getProperty("SlideNo") == slideNo )
          {
            String slideKey = KeyFactory.keyToString(e.getKey());
            List<Entity> slideAndChildren =  GQDataStore.GetSlideContent(slideKey);

            Slide slide = Slide.GetSlide(e);
            for ( Entity e1: slideAndChildren )
            {
              if ( e1.getKind().equals("Question") )
              {
                Question q = Question.GetQuestion(e1);
                slide.questions.add(q);
              }
            }
          }
        }
      }
      return null;
  }

 
  public static Slide GetSlideContent(String talkKey, int slideNo)
  {
     
    List<Entity> results = GetTalkContent(talkKey);
    for ( Entity e : results )
    {
      if ( e.getKind().equals("Slide") )
      {
        if ( (Long)e.getProperty("SlideNo") == slideNo )
        {
          String slideKey = KeyFactory.keyToString(e.getKey());
          List<Entity> slides = GQDataStore.GetSlideContent(slideKey);
        }

      }
    }

    return null;
  }


  public static List<Entity> GetSlideContent(String slideKey)
  {
    Query q = new Query();
    q.setAncestor(KeyFactory.stringToKey(slideKey));
    List<Entity> results = datastore.prepare(q).asList(FetchOptions.Builder.withDefaults());
    return results;
  }*/


  public static void TestNewEmployee()
  {

    Entity employee = new Entity("Employee", "Emp2");;
    employee.setProperty("firstName", "Antonio");
    employee.setProperty("lastName", "Salieri");
    Date hireDate = new Date();
    employee.setProperty("hireDate", hireDate);
    employee.setProperty("attendedHrTraining", true);

    datastore.put(employee);

    Entity address = new Entity("EmpAddr", "addr1", employee.getKey());
    address.setProperty("zip", 60612);
    datastore.put(address);
  }

  public static Entity getEmployeeByKey(int id)
  {
    try
    {
      Key k = KeyFactory.createKey("Employee", id);
      return datastore.get(k);
    }
    catch ( Exception ex)
    {
      log.warning(ex.getMessage());
    }

    return null;
  } 




}





/// SAMPLE:
//
//
//
//http://code.google.com/appengine/docs/java/javadoc/com/google/appengine/api/datastore/package-summary.html
//
//
//// Get a handle on the datastore itself
// DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();
//
//  // Lookup data by known key name
//   Entity userEntity = datastore.get(KeyFactory.createKey("UserInfo", email));
//
//    // Or perform a query
//     Query query = new Query("Task");
//      query.addFilter("dueDate", Query.FilterOperator.LESS_THAN, today);
//       for (Entity taskEntity : datastore.prepare(query).asIterable()) {
//          if ("done".equals(taskEntity.getProperty("status"))) {
//               datastore.delete(taskEntity);
//                  } else {
//                       taskEntity.setProperty("status", "overdue");
//                            datastore.put(taskEntity);
//                               }
//                                }
//
