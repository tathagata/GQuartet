package com.gquartet.data;

import java.util.Date;
import java.util.*;


public class Talk
{
  public String key;
  public String resourceId;
  public String talkName;
  public Date dateTime;

  //attributes that are populated in some scenarios
  List<Slide> slides = new ArrayList<Slide>();
  
  
}
