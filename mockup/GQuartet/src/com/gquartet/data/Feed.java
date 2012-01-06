package com.gquartet.data;
import com.google.appengine.api.datastore.DatastoreService;
import com.google.appengine.api.datastore.DatastoreServiceFactory;
import com.google.appengine.api.datastore.Entity;
import com.google.appengine.api.datastore.*;


import java.util.*;


public class Feed
{
  public String key;
  public String feedText;;
  public long rating;
  public Date datePosted;
  
  //TODO: userID


  public static Feed GetFeed(Entity entity)
  {
      Feed q = new Feed();
      q.key = KeyFactory.keyToString(entity.getKey());
      q.feedText = (String)entity.getProperty("Text");
      q.rating = (Long)entity.getProperty("Rating");
      q.datePosted = (Date)entity.getProperty("DatePosted");

      return q;
  }

  public static Entity GetEntity(String questionKey, String feedText, int  rating)
  {

    Entity FeedEntity = new Entity("Feed", KeyFactory.stringToKey(questionKey));
    FeedEntity.setProperty("Text", feedText);
    FeedEntity.setProperty("Rating", rating);
    FeedEntity.setProperty("DatePosted", new Date());

    return FeedEntity;
  }

  public static void UpdateRating(Entity e, long rating)
  {
    e.setProperty("Rating", rating);
  }

   public String toString()
    {
      StringBuilder b = new StringBuilder();
      Key k = KeyFactory.stringToKey(key);
      b.append( "Feed (").append(k.getId()).append(") : ").append( " Text=" ).append(feedText);
      b.append(" Date Posted=").append(datePosted);
      b.append(" ParentInfo = ").append(k.getParent().toString());

      return b.toString();
    }
      
}
