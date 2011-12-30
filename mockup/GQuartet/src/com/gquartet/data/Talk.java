package com.gquartet.data;

import java.util.Date;
import java.util.*;
import com.google.appengine.api.datastore.*;


public class Talk
{
  public String key;
  public String resourceId;
  public String talkName;
  public Date dateTime;

  //attributes that are populated in some scenarios
  List<Slide> slides = new ArrayList<Slide>();

  public static Entity GetEntity( String resourceId, Date sessionDate, String talkName)
  {
    
    Entity talk = new Entity("Talk");
    talk.setProperty("Date", new Date());
    talk.setProperty("DocumentId", resourceId);
    talk.setProperty("Name", talkName);

    return talk;
  }

  public static Talk GetTalk(Entity entity)
  {
       Talk t = new Talk();
       t.key = KeyFactory.keyToString(entity.getKey());
       t.resourceId = (String)entity.getProperty("DocumentId");
       t.talkName = (String)entity.getProperty("Name");
       t.dateTime = (Date)entity.getProperty("Date");

       return t;
  }










  
  
}
