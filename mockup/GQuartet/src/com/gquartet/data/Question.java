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
  public int rating;

  public static Question GetQuestion(Entity entity)
  {
      Question q = new Question();
      q.key = KeyFactory.keyToString(entity.getKey());
      q.questionText = (String)entity.getProperty("Text");
      q.rating = (Integer)entity.getProperty("Rating");

      return q;
  }

  public static Entity GetEntity(String slideKey, String questionText, int  rating)
  {

    Entity questionEntity = new Entity("Question", KeyFactory.stringToKey(slideKey));
    questionEntity.setProperty("Text", questionText);
    questionEntity.setProperty("Rating", rating);

    return questionEntity;
  }
      
}
