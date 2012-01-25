package com.gquartet.data;
import com.google.appengine.api.datastore.DatastoreService;
import com.google.appengine.api.datastore.DatastoreServiceFactory;
import com.google.appengine.api.datastore.Entity;
import com.google.appengine.api.datastore.*;


import java.util.*;


public class Question
{
  public String key;
  public String questionText;;
  public long rating;
  public Date datePosted;


  //attributes that are populated in some instances
  public List<Comment> comments = new ArrayList<Comment>();

  public static Question GetQuestion(Entity entity)
  {
      Question q = new Question();
      q.key = KeyFactory.keyToString(entity.getKey());
      q.questionText = (String)entity.getProperty("Text");
      q.rating = (Long)entity.getProperty("Rating");
      q.datePosted = (Date)entity.getProperty("DatePosted");

      return q;
  }

  public static Entity GetEntity(String slideKey, String questionText, int  rating)
  {

    Entity questionEntity = new Entity("Question", KeyFactory.stringToKey(slideKey));
    questionEntity.setProperty("Text", questionText);
    questionEntity.setProperty("Rating", rating);
    questionEntity.setProperty("DatePosted", new Date());

    return questionEntity;
  }

  public static void UpdateRating(Entity e, long rating)
  {
    e.setProperty("Rating", rating);
  }

  public String toJSON()
  {
    StringBuilder b = new StringBuilder();
    b.append("{");
    b.append(toKeyValue("key",key));
    b.append(toKeyValue("questionText", questionText));
    b.append(toKeyValue("rating", String.valueOf(rating)));
    b.append("}");

    return b.toString();

  }

  public String toKeyValue(String key, String value)
  {
    return String.format("\"%s\":\"%s\"",key,value);
  }

  public String toString()
  {
    StringBuilder b = new StringBuilder();
    Key k = KeyFactory.stringToKey(key);
    b.append( "Question (").append(k.getId()).append(") : ").append( " Text=" ).append(questionText);
    b.append(" Date Posted=").append(datePosted);
    b.append(" ParentInfo = ").append(k.getParent().toString());
    b.append("\n");

    for ( Comment c : comments )
    {
      b.append("\t\t").append(c.toString()).append("\n");
    }

    return b.toString();
  }

      
}
