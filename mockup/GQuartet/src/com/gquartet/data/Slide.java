package com.gquartet.data;
import com.google.appengine.api.datastore.DatastoreService;
import com.google.appengine.api.datastore.DatastoreServiceFactory;
import com.google.appengine.api.datastore.Entity;
import com.google.appengine.api.datastore.*;

import java.util.*;
import java.lang.StringBuilder;



public class Slide
{
  public String key;
  public long SlideNo;

  public long likes=0;
  public long dislikes=0; 

  //attributes that are populated in some instances
  public List<Question> questions = new ArrayList<Question>();
  public List<Feed> feeds = new ArrayList<Feed>();

  public static Slide GetSlide(Entity entity)
  {
      Slide q = new Slide();
      q.key = KeyFactory.keyToString(entity.getKey());
      q.SlideNo = (Long)entity.getProperty("SlideNo");

      if ( entity.getProperty("Likes") != null )
        q.likes = (Long)entity.getProperty("Likes");

      if ( entity.getProperty("Dislikes") != null )
        q.dislikes = (Long)entity.getProperty("Dislikes");

      return q;
  }

  public static Entity GetEntity(String parentKey, long  slideNo)
  {
    Entity slideEntity = new Entity("Slide", KeyFactory.stringToKey(parentKey) );
    slideEntity.setProperty("SlideNo", slideNo);

    return slideEntity;
  }

  public String toString()
  {
    StringBuilder b = new StringBuilder();
    Key k = KeyFactory.stringToKey(key);
    b.append( "Slide (").append(k.getId()).append(") : ").append( "SlideNo=" ).append(SlideNo);
    b.append( "Likes = " ).append(likes).append( " , Dislikes = " ).append(dislikes);
    b.append(" ParentInfo = ").append(k.getParent().toString());
    
    b.append("\n");
    for ( Question q : questions )
    {
      b.append("\t").append(q.toString()).append("\n");
    }

    b.append("\n");
    for ( Feed f : feeds )
    {
      b.append("\t").append(f.toString()).append("\n");
    }


    return b.toString();
  }

}



