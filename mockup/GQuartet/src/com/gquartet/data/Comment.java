package com.gquartet.data;
import com.google.appengine.api.datastore.DatastoreService;
import com.google.appengine.api.datastore.DatastoreServiceFactory;
import com.google.appengine.api.datastore.Entity;
import com.google.appengine.api.datastore.*;


import java.util.*;


public class Comment
{
  public String key;
  public String commentText;;
  public long rating;
  public Date datePosted;

  public static Comment GetComment(Entity entity)
  {
      Comment q = new Comment();
      q.key = KeyFactory.keyToString(entity.getKey());
      q.commentText = (String)entity.getProperty("Text");
      q.rating = (Long)entity.getProperty("Rating");
      q.datePosted = (Date)entity.getProperty("DatePosted");

      return q;
  }

  public static Entity GetEntity(String questionKey, String commentText, int  rating)
  {

    Entity commentEntity = new Entity("Comment", KeyFactory.stringToKey(questionKey));
    commentEntity.setProperty("Text", commentText);
    commentEntity.setProperty("Rating", rating);
    commentEntity.setProperty("DatePosted", new Date());

    return commentEntity;
  }

  public static void UpdateRating(Entity e, long rating)
  {
    e.setProperty("Rating", rating);
  }

   public String toString()
    {
      StringBuilder b = new StringBuilder();
      Key k = KeyFactory.stringToKey(key);
      b.append( "Comment (").append(k.getId()).append(") : ").append( " Text=" ).append(commentText);
      b.append(" Date Posted=").append(datePosted);
      b.append(" ParentInfo = ").append(k.getParent().toString());

      return b.toString();
    }


      
}
